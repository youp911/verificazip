Unit unEMarketing;
{Verificado
-.edit;
}
Interface

Uses Classes, DBTables, SysUtils, UnDados,IdMessage, IdSMTP, UnSistema, stdctrls, comctrls,
  forms, unClientes,idPop3, UnProspect, idtext,IdAttachmentFile,sqlExpr,
  tabela, db;

//classe localiza
Type TRBLocalizaEMarketing = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesEMarketing = class(TRBLocalizaEMarketing)
  private
    Aux,
    Tabela,
    Clientes :TSQLQUERY;
    Cadastro : TSQL;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    VprPop : TidPOP3;
    VprLabelStatus : TLabel;
    function GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpaQtdLigacoes : Integer) : Integer;
    procedure AdicionaTarefaItem(VpaSeqTarefa,VpaCodCliente : Integer;VpaErro : String);
    procedure AtualizaQtdEmailEnviados(VpaDTarefa : TRBDTarefaEMarketing);
    procedure AtualizaQtdEmailNovaTarefa(VpaSeqTarefa : Integer);
    procedure AtualizaStatusLeituraEmail(VpaStatus : String);
    procedure PosClientesEMarketing(VpaTabela : TDataSet;VpaSeqTarefa : Integer);
    procedure PosClientesparaTeleMarketing(VpaTabela : TDataSet; VpaSeqTarefa : Integer);
    function RAssuntoEmail(VpaAssunto,VpaNomCliente : String) : String;
    function EnviaEmailCliente(VpaDTarefa : TRBDTarefaEMarketing; VpaDFilial : TRBDFilial;VpaCodCliente: Integer; VpaNomContato, VpaDesEmail,VpaContatoPrincipal : String;VpaStatus : TLabel):string;
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial) : string;
    procedure MontaEmailHTML(VpaTexto : TStrings; VpaDTarefa: TRBDTarefaEMarketing);
    function ConectaEmail(VpaSMTP : TIdSMTP) : string;
    function ConectaPop(VpaPop : TidPOP3;VpaDEmailMarketing : TRBDEmailMarketing) : string;
    function MensagemEmailInvalido(VpaPop : TidPOP3) : Boolean;
    function MensagemRespostaAutomatica(VpaPop : TidPOP3) : Boolean;
    function REmailMensagemInvalida(VpaPop : TidPOP3) : string;
    function REmailLinha(VpaLinha : String) : String;
    function GravaEnvioTarefaCliente(VpaSeqTarefa,VpaCODCliente,VpaSeqContato : Integer;VpaDesErro : String):string;
    procedure CadastraEmailsAdicionaisCliente(VpaCodCliente : Integer; VpaDominio : String);
    function DesativaEmail(VpaPop : TidPOP3) : boolean;
    function DesativaEmailCliente(VpaDesEmail : String) : Integer;
    function DesativaEmailContatoCliente(VpaDesEmail : String) : Integer;
    function DesativaEmailProspect(VpaDesEmail : String) : Integer;
    function DesativaEmailContatoProspect(VpaDesEmail : String) : Integer;
    function RQtdEMail(VpaSeqTarefa : Integer) : Integer;
    function RQTDEmailsNaoEnviados(VpaSeqTarefa : Integer) : Integer;
    function RQtdEmailEnviado(VpaSeqTarefa : Integer) : Integer;
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    procedure AtualizaQtdEmail(VpaSeqTarefa : Integer);
    procedure CarDTarefaEMarkegting(VpaDTarefa : TRBDTarefaEMarketing;VpaSeqTarefa : Integer);
    procedure CadastraEmailsAdicionaisProspect(VpaCodProspect : Integer; VpaDominio : String);
    function EnviaEMarketingCliente(VpaDTarefa : TRBDTarefaEMarketing;VpaLabel : TLabel;VpaProgresso : TProgressBar):String;
    function EmailDominioProvedores(VpaEmail : String) : Boolean;
    function GeraTarefaTeleMarketing(VpaSeqTarefa, VpaCodUsuario : Integer):string;
    function VerificaEmailInvalido(VpaProgresso : TProgressBar;VpaStatus,VpaContaEmail : TLabel) : string;
    function ExisteEmail(VpaEmail : string) : boolean;
    procedure ExcluiTarefa(VpaSeqTarefa : Integer);
end;



implementation

Uses FunSql, Constantes, FunArquivos, FunString, ConstMsg, funObjeto;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaEMarketing
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaEMarketing.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesEMarketing
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesEMarketing.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Clientes := TSQLQuery.Create(nil);
  Clientes.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
  VprPop := TidPOP3.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesEMarketing.destroy;
begin
  Aux.Free;
  Clientes.free;
  Cadastro.free;
  VprMensagem.free;
  VprSMTP.free;
  VprPop.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpaQtdLigacoes : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETING');
  Cadastro.insert;
  Cadastro.FieldByname('DATTAREFA').AsDateTime := now;
  Cadastro.FieldByname('QTDLIGACOES').AsInteger := VpaQtdLigacoes;
  Cadastro.FieldByname('DATAGENDAMENTO').AsDateTime := Date;
  Cadastro.FieldByname('SEQCAMPANHA').AsInteger := Varia.SeqCampanhaCadastrarEmail;
  Cadastro.FieldByname('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByname('CODUSUARIOTELE').AsInteger := VpaCodUsuario;
  result := FunClientes.RSeqTarefaDisponivel;
  Cadastro.FieldByname('SEQTAREFA').AsInteger := result;
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AdicionaTarefaItem(VpaSeqTarefa,VpaCodCliente : Integer;VpaErro : String);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGITEM ');
  Cadastro.insert;
  CadaStro.FieldByname('SEQTAREFA').AsInteger :=  VpaSeqTarefa;
  Cadastro.FieldByname('CODCLIENTE').AsInteger :=  VpaCodCliente;
  Cadastro.FieldByname('DESERRO').AsString :=  VpaErro;
  CadaStro.FieldByname('INDENVIADO').AsString := 'N';
  try
    Cadastro.post;
  except
    on e : Exception do aviso('ERRO NA GRAVAÇÃO DA TAREFAEMARKETINGITEM!!!!'#13+e.message);
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AtualizaQtdEmailEnviados(VpaDTarefa : TRBDTarefaEMarketing);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETING '+
                                 ' Where SEQTAREFA = ' +IntToStr(VpaDTarefa.SeqTarefa));
  Cadastro.edit;
  Cadastro.FieldByname('QTDEMAILENVIADO').AsInteger :=RQtdEmailEnviado(VpaDTarefa.SeqTarefa) ;
  Cadastro.FieldByname('QTDNAOENVIADO').AsInteger :=RQTDEmailsNaoEnviados(VpaDTarefa.SeqTarefa);
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AtualizaQtdEmailNovaTarefa(VpaSeqTarefa : Integer);
var
  VpfQtd : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select COUNT(SEQTAREFA) QTD from TAREFAEMARKETINGITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa));
  Vpfqtd := Aux.FieldByname('QTD').AsInteger;
  ExecutaComandoSql(Aux,'Update TAREFAEMARKETING '+
                        ' set QTDEMAIL = ' + IntToStr(VpfQtd)+
                        ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa));
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AtualizaStatusLeituraEmail(VpaStatus : String);
begin
  VprLabelStatus.Caption := AdicionaCharD(' ',VpaStatus,100);
  VprLabelStatus.Refresh;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.PosClientesEMarketing(VpaTabela : TDataSet;VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select TIM.CODCLIENTE, TIM.SEQCONTATO, TIM.NOMCONTATO, TIM.DESEMAIL, '+
                                  ' TIM.INDCONTATOPRINCIPAL ' +
                                  ' from TAREFAEMARKETINGITEM TIM '+
                                  ' WHERE TIM.SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                                  ' AND TIM.INDENVIADO = ''N''');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.PosClientesparaTeleMarketing(VpaTabela : TDataSet; VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select I_COD_CLI, C_NOM_CLI,TIM.DESERRO  '+
                                  ' from CADCLIENTES CLI, TAREFAEMARKETINGITEM TIM '+
                                  ' WHERE CLI.I_COD_CLI = TIM.CODCLIENTE '+
                                  ' AND TIM.SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                                  ' AND TIM.INDENVIADO = ''N''');
end;

{******************************************************************************}
function TRBFuncoesEMarketing.RAssuntoEmail(VpaAssunto,VpaNomCliente : String) : String;
begin
  if ExisteLetraString('@',VpaAssunto) then
    result := SubstituiStr(VpaAssunto,'@',VpaNomCliente)
  else
    result := VpaAssunto;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.EnviaEmailCliente(VpaDTarefa : TRBDTarefaEMarketing; VpaDFilial : TRBDFilial;VpaCodCliente: Integer; VpaNomContato, VpaDesEmail,VpaContatoPrincipal : String;VpaStatus : TLabel):string;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
  Vpfbmppart : TIdAttachmentFile;
begin
  result := '';
  if (VpaDesEmail = '')  then
  begin
    if VpaContatoPrincipal = 'S' then
      result := 'Falta o email principal do cliente '+IntToStr(VpaCodCliente)
    else
      result := 'Falta e-mail do contato "'+VpaNomContato+'" do cliente '+IntToStr(VpaCodCliente);
  end;
  if result = '' then
  begin
    VpaStatus.Caption := AdicionaCharD(' ','Enviado e-mail para o contato "'+VpaNomContato +'"',70);
    VpaStatus.Refresh;
    VpfEmailTexto := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailTexto.ContentType := 'text/plain';

    VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    MontaEmailHTML(VpfEmailHTML.Body,VpaDTarefa);

    VprMensagem.Recipients.EMailAddresses := LowerCase(VpaDesEmail);

    if copy(LowerCase(VpaDTarefa.NomArquivoAnexo),1,7) <> 'http://' then
    begin
      Vpfbmppart := TIdAttachmentFile.Create(VprMensagem.MessageParts,VpaDTarefa.NomArquivoAnexo );
      Vpfbmppart.ContentType := 'image/gif';
      Vpfbmppart.ContentDisposition := 'inline';
      Vpfbmppart.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo) ;
      Vpfbmppart.DisplayName := RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo);
    end;

    VprMensagem.Subject := RAssuntoEmail(VpaDTarefa.DesAssuntoEmail,VpaNomContato);
    result := EnviaEmail(VprMensagem,VprSMTP,VpaDFilial);
    VpfEmailTexto.free;
    VpfEmailHTML.free;
    Vpfbmppart.free;
  end;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial) : string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  VpaMensagem.From.Address := VpaDFilial.DesEmailComercial;
  VpaMensagem.From.Name := VpaDFilial.NomFantasia;


  if VpaSMTP.UserName = '' then
    result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
  if VpaSMTP.Password = '' then
    result := 'SENHA SMTP DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações a senha do e-mail de origem';
  if VpaSMTP.Host = '' then
    result := 'SERVIDOR DE SMTP NÃO CONFIGURADO!!!'#13'É necessário configurar qual o servidor de SMTP...';
  if result = '' then
  begin
    try
      VpaSMTP.Send(VpaMensagem);
    except
      on e : exception do
      begin
        result := 'ERRO AO ENVIAR O E-MAIL!!!'#13+e.message;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.MontaEmailHTML(VpaTexto : TStrings; VpaDTarefa: TRBDTarefaEMarketing);
begin
  VpaTexto.clear;
  VpaTexto.add('<html>');
  VpaTexto.add('<title> e-Marketing Listeners Sistemas');
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('  <center>');
  VpaTexto.add('    <a title="Clique, para maiores informações" href="http://'+VpaDTarefa.DesLinkInternet + '">');
  if copy(LowerCase(VpaDTarefa.NomArquivoAnexo),1,7) <> 'http://' then
    VpaTexto.add('      <IMG src="cid:'+RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo) +' " border="0" >')
  else
    VpaTexto.add('      <IMG src="'+VpaDTarefa.NomArquivoAnexo +' " border="0" >');
  VpaTexto.add('    </a>');
  VpaTexto.add('  </center>');
  VpaTexto.add('  <br>');
  VpaTexto.add('  <center>');
  VpaTexto.add('  <font face="Verdana" size =-3>');
  VpaTexto.add('Esta mensagem não pode ser considerada SPAM por possuir as seguintes características:<br>');
  VpaTexto.add('identificação do remetente, descrição clara do conteúdo e opção para remoção da lista de distribuição');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>Para excluir seu cadastro responda esse e-mail com o assunto REMOVER');
  VpaTexto.add('  </font>');
  VpaTexto.add('  </center>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
end;


{******************************************************************************}
function TRBFuncoesEMarketing.ConectaEmail(VpaSMTP : TIdSMTP) : string;
begin
  if VpaSMTP.Connected then
     VpaSMTP.Disconnect;
  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := 25;
  VpaSMTP.AuthType := satDefault;
  VpaSMTP.Connect;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.ConectaPop(VpaPop : TidPOP3;VpaDEmailMarketing : TRBDEmailMarketing) : string;
begin
  result := '';
//d5  VpaPop.DeleteOnRead := false;
//d5  VpaPop.TimeOut := 200000;
  if VpaPop.Connected then
    VpaPop.Disconnect;
  AtualizaStatusLeituraEmail('Conectando com o servidor POP');
  VpaPop.Host := Varia.ServidorPop;
  VpaPop.UserName := VpaDEmailMarketing.DesEmail;
  VpaPop.Password := VpaDEmailMarketing.DesSenha;
  NaoExisteCriaDiretorio(RetornaDiretorioCorrente+'\AnexosEmail',false);
  DeletaArquivo(RetornaDiretorioCorrente+'\AnexosEmail\*.*');
//d5  VpaPop.AttachFilePath := RetornaDiretorioCorrente+'\AnexosEmail';
  try
    VpaPop.Connect;
    AtualizaStatusLeituraEmail('E-mail conectado com sucesso');
  except
    on e : exception do result := 'ERRO AO CONECTAR O E-MAIL!!!'#13+e.message;
  end;
end;


{******************************************************************************}
function TRBFuncoesEMarketing.MensagemEmailInvalido(VpaPop : TidPOP3) : Boolean;
begin
//  aviso('postmaster@'+DeleteAteChar(Varia.SiteFilial,'.'));
  result := false;
{d5  if (LowerCase(DeletaEspacoE(VpaPop.MailMessage.Subject)) = 'failure notice') or
     (LowerCase(VpaPop.MailMessage.From) = 'postmaster@hotmail.com') or
     (CopiaAteChar(DeleteAtechar(LowerCase(VpaPop.MailMessage.From),'<'),'>') = 'postmaster@'+DeleteAteChar(Varia.SiteFilial,'.')) or
     (LowerCase(CopiaAteChar(VpaPop.MailMessage.From,'@')) = 'mailer-daemon') or
     (LowerCase(DeletaEspaco(VpaPop.MailMessage.Subject)) = 'deliverystatusnotification(failure)') or
     (LowerCase(DeletaEspaco(VpaPop.MailMessage.Subject)) = '') or
     (LowerCase(DeletaEspaco(VpaPop.MailMessage.Subject)) = 'deliverystatus') or
     (LowerCase(DeletaEspaco(VpaPop.MailMessage.Subject)) = 'deliveryreport') or
     (LowerCase(DeletaEspacoE(VpaPop.MailMessage.Subject)) = 'undelivered mail returned to sender') or
     (LowerCase(DeletaEspacoE(VpaPop.MailMessage.Subject)) = 'n/a') or
//     ExistePalavra(LowerCase(VpaPop.MailMessage.Subject),'bulk') or
     (LowerCase(CopiaAteChar(DeleteAteChar(VpaPop.MailMessage.From,'<'),'@')) = 'mailer-daemon') then
    result := true;}
end;

{******************************************************************************}
function TRBFuncoesEMarketing.MensagemRespostaAutomatica(VpaPop : TidPOP3) : Boolean;
begin
  result := false;
{d5  if (LowerCase(DeletaEspaco(VpaPop.MailMessage.Subject)) = '[mensagemautomatica]respostaautomática') or
     (LowerCase(DeletaEspaco(VpaPop.MailMessage.Subject)) = '[mensagemautomatica]=?iso-8859-1?q?resposta_autom=e1tica?=') or
     (LowerCase(DeletaEspaco(VpaPop.MailMessage.Subject)) = '[mensagemautomatica]re:') or
     (LowerCase(DeletaEspaco(VpaPop.MailMessage.Subject)) = 'e-mailrecebido') or
     (LowerCase(DeletaEspaco(VpaPop.MailMessage.Subject)) = '[mensagemautomatica]')then
//     ExistePalavra(LowerCase(VpaPop.MailMessage.Subject),'bulk')then
    result := true;}
end;

{******************************************************************************}
function TRBFuncoesEMarketing.REmailLinha(VpaLinha : String) : String;
var
  VpfPosInicial,VpfIndiceLinha, VpfQtdCaracteres : Integer;
begin
  VpfQtdCaracteres := 0;
  if ExisteLetraString('@',VpaLinha) then
  begin
    if ExisteLetraString('#',VpaLinha) then
      VpaLinha := DeleteAteChar(VpaLinha,'@');
    if ExisteLetraString('@',VpaLinha) then
    begin
      VpfIndiceLinha := pos('@',VpaLinha);
      while (VpaLinha[VpfIndiceLinha] <> ' ') and
            (VpaLinha[VpfIndiceLinha] <> '<') and
            (VpfIndiceLinha > 1) do
        dec(VpfIndiceLinha);

      inc(VpfIndiceLinha);
      VpfPosInicial := VpfIndiceLinha;
      while (VpaLinha[VpfIndiceLinha] <> ' ') and
            (VpaLinha[VpfIndiceLinha] <> '>') and
            (VpfIndiceLinha <= Length(VpaLinha) ) do
      begin
        inc(VpfIndiceLinha);
        inc(VpfQtdCaracteres);
      end;
      result := copy(VpaLinha,VpfPosInicial,VpfQtdCaracteres);
      exit;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.REmailMensagemInvalida(VpaPop : TidPOP3) :string;
var
  VpfLaco : Integer;
  VpfCorpo : TIdText;
  VpfLinha : String;
begin
  result := '';
{d5  for VpfLaco := 0 to VpaPop.MailMessage.RawBody.Count - 1 do
  begin
    VpfLinha := VpaPop.MailMessage.RawBody.Strings[VpfLaco];
    if Uppercase(copy(VpfLinha,1,3)) = 'TO:' then
    begin
      result :=  REmailLinha(VpfLinha);
      break;
    end;
  end;}
end;

function TRBFuncoesEMarketing.EmailDominioProvedores(VpaEmail : String) : Boolean;
begin
  result := false;
  if ExisteLetraString('@',VpaEmail) then
    VpaEmail := DeleteAteChar(VpaEmail,'@');
  if (VpaEmail = 'terra.com.br') or
     (VpaEmail = 'hotmail.com') or
     (VpaEmail = 'hotmail.com.br') or
     (VpaEmail = 'iscc.com.br') or
     (VpaEmail = 'netvale.net') or
     (VpaEmail = 'bol.com.br') or
     (VpaEmail = 'uol.com.br') or
     (VpaEmail = 'unetvale.com.br') or
     (VpaEmail = 'matrix.com.br') or
     (VpaEmail = 'yahoo.com.br') or
     (VpaEmail = 'brturbo.com.br') or
     (VpaEmail = 'gmail.com.br') or
     (VpaEmail = 'zaz.com.br') or
     (VpaEmail = 'nutecnet.com.br') or
     (VpaEmail = 'ig.com.br') or
     (VpaEmail = 'tpa.com.br') or
     (VpaEmail = 'superig.com.br') or
     (VpaEmail = 'globo.com') or
     (VpaEmail = 'sol.com') or
     (VpaEmail = 'correioweb.com.br') or
     (VpaEmail = 'aol.com.br') or
     (VpaEmail = 'braznet.com.br') or
     (VpaEmail = 'creativenet.com.br') or
     (VpaEmail = 'zipmail.com.br') or
     (VpaEmail = 'flynet.com.br') or
     (VpaEmail = 'netron.com.br') or
     (VpaEmail = 'pop.com.br') or
     (VpaEmail = 'onda.com.br') or
     (VpaEmail = 'netron.com.br') or
     (VpaEmail = 'ibest.com.br') then
    result := true;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.ExcluiTarefa(VpaSeqTarefa: Integer);
begin
  ExecutaComandoSql(Aux,'Delete from TAREFAEMARKETINGITEM ' +
                        ' Where SEQTAREFA = '+  IntToStr(VpaSeqTarefa));
  ExecutaComandoSql(Aux,'Delete from TAREFAEMARKETING ' +
                        ' Where SEQTAREFA = '+  IntToStr(VpaSeqTarefa));
end;

function TRBFuncoesEMarketing.ExisteEmail(VpaEmail : string) : boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_CLI  from CADCLIENTES ' +
                                 ' Where C_END_ELE = '''+VpaEmail+'''');
  result := not Aux.Eof;

  if not result then
  begin
    AdicionaSQLAbreTabela(Aux,'Select CODCLIENTE '+
                                 ' from CONTATOCLIENTE ' +
                                 ' Where DESEMAIL = '''+VpaEmail+'''');
    result := not Aux.Eof;

    if not result then
    begin
      AdicionaSQLAbreTabela(Aux,'Select CODPROSPECT '+
                                 ' from PROSPECT ' +
                                 ' Where DESEMAILCONTATO = '''+VpaEmail+'''');

      result := not Aux.Eof;

      if not result then
      begin
        AdicionaSQLAbreTabela(Aux,'Select CODPROSPECT '+
                                 ' from CONTATOPROSPECT ' +
                                 ' Where DESEMAIL = '''+VpaEmail+'''');
        result := not Aux.Eof;
      end;
    end;
  end;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.GravaEnvioTarefaCliente(VpaSeqTarefa,VpaCODCliente,VpaSeqContato : Integer;VpaDesErro : String):string;
begin
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGITEM '+
                                 ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa)+
                                 ' and CODCLIENTE = '+IntToStr(VpaCODCliente)+
                                 ' and SEQCONTATO = '+IntToStr(VpaSeqContato));
    Cadastro.Edit;
    if VpaDesErro = '' then
    begin
      Cadastro.FieldByname('INDENVIADO').AsString := 'S';
      Cadastro.FieldByname('DATENVIO').AsDateTime := now;
      Cadastro.FieldByname('DESERRO').Clear;
    end
    else
    begin
      Cadastro.FieldByname('INDENVIADO').AsString := 'N';
      Cadastro.FieldByname('DESERRO').AsString := VpaDesErro;
    end;
    try
      Cadastro.post;
    except
      on e : exception do result := 'ERRO NA GRAVAÇÃO DA TAREFAEMARKETINGITEM!!!'#13+e.message;
    end;
  end;

  if VpaDesErro = '' then
  begin
    if VpaSeqContato = 0 then
      FunClientes.AlteraDatUltimoEmail(VpaCodCliente,now);
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.CadastraEmailsAdicionaisCliente(VpaCodCliente : Integer; VpaDominio : String);
begin
  if not ExisteEmail('diretoria@'+VpaDominio) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'diretoria@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('financeiro@'+VpaDominio) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'financeiro@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(CopiaAteChar(VpaDominio,'.')+'@'+VpaDominio) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,CopiaAteChar(VpaDominio,'.')+'@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('contato@'+VpaDominio) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'contato@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('vendas@'+VpaDominio) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'vendas@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('sac@'+VpaDominio) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'sac@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('comercial@'+VpaDominio) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'comercial@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('compras@'+VpaDominio) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'compras@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('rh@'+VpaDominio) then
    FunClientes.AdicionaEmailContatoCliente(VpaCodCliente,'rh@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.CadastraEmailsAdicionaisProspect(VpaCodProspect : Integer; VpaDominio : String);
begin
  if not ExisteEmail('diretoria@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'diretoria@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('financeiro@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'financeiro@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail(CopiaAteChar(VpaDominio,'.')+ '@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,CopiaAteChar(VpaDominio,'.')+ '@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('contato@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'contato@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('vendas@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'vendas@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('sac@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'sac@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('comercial@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'comercial@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('compras@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'compras@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('rh@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'rh@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('faturamento@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'faturamento@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('estoque@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'estoque@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('almoxarifado@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'almoxarifado@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('ti@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'ti@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('informatica@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'informatica@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('supervisao@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'supervisao@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('gerencia@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'gerencia@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('cobranca@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'cobranca@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
  if not ExisteEmail('recrutamento@'+VpaDominio) then
    FunProspect.AdicionaEmailContatoProspect(VpaCodProspect,'recrutamento@'+VpaDominio,'Cadastrado atraves de um e-mail invalido desse dominio');
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmail(VpaPop : TidPOP3) : Boolean;
var
  VpfEmail : String;
  VpfCodCliente, VpfCodProspect : Integer;
begin
  VpfCodProspect := 0;
  VpfEmail := REmailMensagemInvalida(VpaPop);
  VpfCodCliente := DesativaEmailCliente(VpfEmail);
  if VpfCodCliente = 0 then
    VpfCodProspect := DesativaEmailProspect(VpfEmail);
  if not EmailDominioProvedores(VpfEmail) then
  begin
    if not ExisteEmail('diretoria@'+DeleteAteChar(VpfEmail,'@')) then
    begin
      if VpfCodCliente <> 0 then
        CadastraEmailsAdicionaisCliente(VpfCodCliente,DeleteAteChar(VpfEmail,'@'))
      else
        if VpfCodProspect <> 0 then
          CadastraEmailsAdicionaisProspect(VpfCodProspect,DeleteAteChar(VpfEmail,'@'));
    end;
  end;
  result := (VpfCodCliente <> 0) or (VpfCodProspect <> 0);
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmailCliente(VpaDesEmail : String) : Integer;
begin
  result := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCLIENTES ' +
                                 ' Where C_END_ELE = '''+VpaDesEmail+''''+
                                 ' AND C_ACE_SPA = ''S''');
  if not Cadastro.eof then
  begin
    result := Cadastro.FieldByname('I_COD_CLI').AsInteger;
    Cadastro.Edit;
    Cadastro.FieldByname('I_QTD_EMI').AsInteger := Cadastro.FieldByname('I_QTD_EMI').AsInteger + 1;
    if Cadastro.FieldByname('I_QTD_EMI').AsInteger > 3 then
      Cadastro.FieldByname('C_EMA_INV').AsString := 'S';
    Cadastro.Post;
  end;
  Cadastro.close;

  if result = 0 then
    result := DesativaEmailContatoCliente(VpaDesEmail);
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmailContatoCliente(VpaDesEmail : String) : Integer;
begin
  result := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select *  '+
                                 ' from CONTATOCLIENTE ' +
                                 ' Where DESEMAIL = '''+VpaDesEmail+''''+
                                 ' AND INDACEITAEMARKETING = ''S''');
  if not Cadastro.eof then
  begin
    result := Cadastro.FieldByname('CODCLIENTE').AsInteger;
    Cadastro.Edit;
    Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger := Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger + 1;
    if Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger > 3 then
      Cadastro.FieldByname('INDEMAILINVALIDO').AsString := 'S';
    Cadastro.Post;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmailProspect(VpaDesEmail : String) : Integer;
begin
  result := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select * '+
                                 ' from PROSPECT ' +
                                 ' Where DESEMAILCONTATO = '''+VpaDesEmail+''''+
                                 ' AND INDACEITASPAM = ''S''');
  if not Cadastro.eof then
  begin
    result := Cadastro.FieldByname('CODPROSPECT').AsInteger;
    Cadastro.Edit;
    Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger := Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger + 1;
    IF Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger > 3 then
      Cadastro.FieldByname('INDEMAILINVALIDO').AsString := 'S';
    Cadastro.Post;
  end;
  Cadastro.close;
  if result = 0 then
    result := DesativaEmailContatoProspect(VpaDesEmail);
end;

{******************************************************************************}
function TRBFuncoesEMarketing.DesativaEmailContatoProspect(VpaDesEmail : String) : Integer;
begin
  result := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select * '+
                                 ' from CONTATOPROSPECT ' +
                                 ' Where DESEMAIL = '''+VpaDesEmail+''''+
                                 ' AND INDACEITAEMARKETING = ''S''');
  if not Cadastro.eof then
  begin
    result := Cadastro.FieldByname('CODPROSPECT').AsInteger;
    Cadastro.Edit;
    Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger := Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger +1;
    IF Cadastro.FieldByname('QTDVEZESEMAILINVALIDO').AsInteger > 3 then
      Cadastro.FieldByname('INDEMAILINVALIDO').AsString := 'S';
    Cadastro.Post;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.RQtdEMail(VpaSeqTarefa : Integer) : Integer;
begin
  Aux.Close;
  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT COUNT(SEQTAREFA) QTD '+
              ' FROM TAREFAEMARKETINGITEM  ' +
              ' WHERE SEQTAREFA = '+IntTosTr(VpaSeqTarefa));
  Aux.Open;
  result := Aux.FieldByname('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.RQtdEmailsNaoEnviados(VpaSeqTarefa : Integer) : Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select COUNT(SEQTAREFA) QTD  FROM TAREFAEMARKETINGITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                            ' and INDENVIADO = ''N''');
  Result := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.RQtdEmailEnviado(VpaSeqTarefa : Integer) : Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select COUNT(SEQTAREFA) QTD  FROM TAREFAEMARKETINGITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                            ' and INDENVIADO = ''S''');
  Result := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.AtualizaQtdEmail(VpaSeqTarefa : Integer);
begin
  ExecutaComandoSql(Tabela,'Update TAREFAEMARKETING SET QTDEMAIL = '+IntToStr(RQtdEMail(VpaSeqTarefa))+
                           ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa));
end;

{******************************************************************************}
procedure TRBFuncoesEMarketing.CarDTarefaEMarkegting(VpaDTarefa : TRBDTarefaEMarketing;VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from TAREFAEMARKETING '+
                               ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa));
  VpaDTarefa.SeqTarefa := VpaSeqTarefa;
  VpaDTarefa.QtdEmail := Tabela.FieldByname('QTDEMAIL').AsInteger;
  VpaDTarefa.DesAssuntoEmail := Tabela.FieldByname('DESASSUNTOEMAIL').AsString;
  VpaDTarefa.DesLinkInternet :=Tabela.FieldByname('DESLINKINTERNET').AsString;
  VpaDTarefa.NomArquivoAnexo :=Tabela.FieldByname('NOMARQUIVO').AsString;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.EnviaEMarketingCliente(VpaDTarefa : TRBDTarefaEMarketing;VpaLabel : TLabel;VpaProgresso : TProgressBar ):String;
var
  VpfDFilial : TRBDFilial;
  VpfQtdEmail, VpfQTdEmailEnviado, VpfNovoSeqTarefa,VpfCodCliente : Integer;
begin
  result := '';
  VpaProgresso.Max := VpaDTarefa.QtdEmail;
  VpaProgresso.Position := 0;
  VpfQtdEmail := 999;
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,Varia.CodigoEmpFil);
  PosClientesEMarketing(Clientes,VpaDTarefa.SeqTarefa);

  While not Clientes.eof do
  begin
    if VpfQtdEmail > 40 then
    begin
      VpaLabel.Caption := 'Conectando com o servidor de e-mail';
      VpaLabel.Refresh;
      ConectaEmail(VprSMTP);
      VpfQtdEmail := 0;
      AtualizaQtdEmailEnviados(VpaDTarefa);
    end;
    inc(VpfQtdEmail);
    result := EnviaEmailCliente(VpaDTarefa,VpfDFilial,Clientes.FieldByname('CODCLIENTE').AsInteger,Clientes.FieldByname('NOMCONTATO').AsString,
                     Clientes.FieldByname('DESEMAIL').AsString,Clientes.FieldByname('INDCONTATOPRINCIPAL').AsString,VpaLabel);

    GravaEnvioTarefaCliente(VpaDTarefa.SeqTarefa,Clientes.FieldByname('CODCLIENTE').AsInteger,Clientes.FieldByname('SEQCONTATO').AsInteger,result);

    VpaProgresso.Position := VpaProgresso.Position + 1;
    Application.ProcessMessages;
    Clientes.Next;
  end;
  AtualizaQtdEmailEnviados(VpaDTarefa);

  if VprSMTP.Connected then
    VprSMTP.Disconnect;
  VpfDFilial.free;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.GeraTarefaTeleMarketing(VpaSeqTarefa, VpaCodUsuario: Integer): string;
var
  VpfQtdEmailNaoEnviados, VpfSeqTarefaTele : Integer;
begin
  VpfQtdEmailNaoEnviados := RQTDEmailsNaoEnviados(VpaSeqTarefa);
  if  VpfQtdEmailNaoEnviados > 0  then
  begin
    VpfSeqTarefaTele := GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpfQtdEmailNaoEnviados);
    AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETINGITEM');
    PosClientesparaTeleMarketing(Clientes,VpaSeqTarefa);
    While not Clientes.Eof do
    begin
      Cadastro.insert;
      Cadastro.FieldByname('SEQTAREFA').AsInteger := VpfSeqTarefaTele;
      Cadastro.FieldByname('CODUSUARIO').AsInteger := VpaCodUsuario;
      Cadastro.FieldByname('CODCLIENTE').AsInteger := Clientes.FieldByname('I_COD_CLI').AsInteger;
      Cadastro.FieldByname('DATLIGACAO').AsDateTime := Date;
      Cadastro.FieldByname('SEQCAMPANHA').AsInteger := Varia.SeqCampanhaCadastrarEmail;
      Cadastro.FieldByname('INDREAGENDADO').AsString := 'N';
      Cadastro.post;

      FunClientes.AlterarObsLigacao(Clientes.FieldByname('I_COD_CLI').AsInteger,Clientes.FieldByname('DESERRO').AsString);
      Clientes.Next;
    end;
    Clientes.close;
  end;
  Clientes.Close;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketing.VerificaEmailInvalido(VpaProgresso : TProgressBar;VpaStatus,VpaContaEmail : TLabel) : string;
var
  VpfLacoMensagem, VpfLacoContaEmail,  VpfQtdMensagens, VpfQtdExcluido : Integer;
  VpfEmailsMarketing : TList;
  VpfDEmailMarketing : TRBDEmailMarketing;
begin
  VpfEmailsMarketing := TList.Create;
  result := Sistema.CarEmailMarketing(VpfEmailsMarketing);
  if result = '' then
  begin
    for VpfLacoContaEmail := 0 to VpfEmailsMarketing.Count - 1 do
    begin
      VpfDEmailMarketing := TRBDEmailMarketing(VpfEmailsMarketing.Items[VpfLacoContaEmail]);
      VpaContaEmail.Caption := VpfDEmailMarketing.DesEmail;
      VpaContaEmail.Refresh;

      VprLabelStatus := VpaStatus;
      VpfQtdExcluido := 0;
      result := ConectaPop(VprPop,VpfDEmailMarketing);
      if result = '' then
      begin
        AtualizaStatusLeituraEmail('Verificando a quantidade de e-mail''s');
//d5        VpfQtdMensagens := VprPop.MailCount;
        VpaProgresso.Max := VpfQtdMensagens;
        VpaProgresso.Position := 0;
        for VpfLacoMensagem := VpfQtdMensagens downto 1 do
        begin
          inc(VpfQtdExcluido);
          if VpfQtdExcluido > 40 then
          begin
            ConectaPop(VprPop,VpfDEmailMarketing);
            VpfQtdExcluido := 0;
          end;
          VpaProgresso.Position := VpaProgresso.Position + 1;

//d5          VprPop.GetMailMessage(VpfLacoMensagem);
//d5          AtualizaStatusLeituraEmail('Verificando se a mensagem '+IntToStr(VpaProgresso.Position) +' de '+IntToStr(VpfQtdMensagens)+' é válida "'+VprPop.MailMessage.Subject);
          if MensagemEmailInvalido(VprPop) then
          begin
            DesativaEmail(VprPop);
//d5            VprPop.DeleteMailMessage(VpfLacoMensagem);
          end
          else
//d5            if MensagemRespostaAutomatica(VprPop)then
//d5              VprPop.DeleteMailMessage(VpfLacoMensagem);
        end;
      end;
      VprPop.Disconnect;
    end;
  end;
  FreeTObjectsList(VpfEmailsMarketing);
  VpfEmailsMarketing.free;
end;

end.
