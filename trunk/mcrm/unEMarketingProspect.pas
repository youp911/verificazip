Unit unEMarketingProspect;

Interface

Uses Classes, DB, SysUtils, UnDados,IdMessage, IdSMTP, UnSistema, stdctrls, comctrls,
  forms, unProspect, idtext,IdAttachmentfile,SQLexpr, Tabela;

//classe localiza
Type TRBLocalizaEMarketingProspect = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesEMarketingProspect = class(TRBLocalizaEMarketingProspect)
  private
    Aux,
    Tabela,
    Prospects : TSQLQuery;
    Cadastro : TSQL;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    function GravaEnvioTarefaProspect(VpaSeqTarefa,VpaCODPROSPECT,VpaSeqContato : Integer;VpaDesErro : String):string;
    function GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpaQtdLigacoes : Integer) : Integer;
    procedure AdicionaTarefaItem(VpaSeqTarefa,VpaCODPROSPECT : Integer;VpaErro : String);
    procedure AtualizaQtdEmailEnviados(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT);
    procedure PosProspectsEMarketing(VpaTabela : TDataSet;VpaSeqTarefa : Integer);
    procedure PosProspectsparaTeleMarketing(VpaTabela : TDataSet; VpaSeqTarefa : Integer);
    function RAssuntoEmail(VpaAssunto,VpaNomCliente : String) : String;
    function EnviaEmailProspect(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT; VpaDFilial : TRBDFilial;VpaDEmailMarketing : TRBDEmailMarketing;VpaCodProspect: Integer;VpaNomContato, VpaDesEmail,VpaContatoPrincipal : String;VpaStatus : TLabel):string;
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDEmailMarketing : TRBDEmailMarketing) : string;
    procedure MontaEmailHTML(VpaTexto : TStrings; VpaDTarefa: TRBDTAREFAEMARKETINGPROSPECT);
    function ConectaEmail(VpaSMTP : TIdSMTP;VpaDEmailMarketing : TRBDEmailMarketing) : string;
    function RQtdEMail(VpaSeqTarefa : Integer) : Integer;
    function RQTDEmailsNaoEnviados(VpaSeqTarefa : Integer) : Integer;
    function RQtdEmailEnviado(VpaSeqTarefa : Integer) : Integer;
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    procedure AtualizaQtdEmail(VpaSeqTarefa : Integer);
    procedure CarDTarefaEMarkegting(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT;VpaSeqTarefa : Integer);
    function EnviaEMarketingProspect(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT;VpaLabel,VpaNomContaEmail,VpaQtdEmail : TLabel;VpaProgresso : TProgressBar):String;
    function GeraTarefaTeleMarketing(VpaSeqTarefa, VpaCodUsuario : Integer):string;
end;



implementation

Uses FunSql, Constantes, FunArquivos, FunString, ConstMsg, FunObjeto, FunData;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaEMarketing
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaEMarketingProspect.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesEMarketingProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesEMarketingProspect.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Prospects := TSQLQuery.Create(nil);
  Prospects.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesEMarketingProspect.destroy;
begin
  Aux.Free;
  Prospects.free;
  Cadastro.free;
  VprMensagem.free;
  VprSMTP.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.GravaEnvioTarefaProspect(VpaSeqTarefa,VpaCODPROSPECT,VpaSeqContato : Integer;VpaDesErro : String):string;
begin
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGPROSPECTITEM '+
                                 ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa)+
                                 ' and CODPROSPECT = '+IntToStr(VpaCODPROSPECT)+
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
      on e : exception do result := 'ERRO NA GRAVAÇÃO DA TAREFAEMARKETINGPROSPECTITEM!!!'#13+e.message;
    end;
  end;

  if VpaDesErro = '' then
  begin
    if VpaSeqContato = 0 then
      FunProspect.AlteraDatUltimoEmail(VpaCODPROSPECT,now)
    else
      FunProspect.AlteraDatUltimoEmailContato(VpaCODPROSPECT,VpaSeqContato,now);
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpaQtdLigacoes : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETINGPROSPECT');
  Cadastro.insert;
  Cadastro.FieldByname('DATTAREFA').AsDateTime := now;
  Cadastro.FieldByname('QTDLIGACOES').AsInteger := VpaQtdLigacoes;
  Cadastro.FieldByname('DATAGENDAMENTO').AsDateTime := Date;
  Cadastro.FieldByname('SEQCAMPANHA').AsInteger := Varia.SeqCampanhaCadastrarEmail;
  Cadastro.FieldByname('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
  Cadastro.FieldByname('CODUSUARIOTELE').AsInteger := VpaCodUsuario;
  result := FunProspect.RSeqTarefaDisponivel;
  Cadastro.FieldByname('SEQTAREFA').AsInteger := result;
  Cadastro.post;
  Cadastro.close;
end;


{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.AdicionaTarefaItem(VpaSeqTarefa,VpaCODPROSPECT : Integer;VpaErro : String);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGPROSPECTITEM ');
  Cadastro.insert;
  CadaStro.FieldByname('SEQTAREFA').AsInteger :=  VpaSeqTarefa;
  Cadastro.FieldByname('CODPROSPECT').AsInteger :=  VpaCODPROSPECT;
  Cadastro.FieldByname('DESERRO').AsString :=  VpaErro;
  CadaStro.FieldByname('INDENVIADO').AsString := 'N';
  try
    Cadastro.post;
  except
    on e : Exception do aviso('ERRO NA GRAVAÇÃO DA TAREFAEMARKETINGPROSPECTITEM!!!!'#13+e.message);
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.AtualizaQtdEmailEnviados(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT);
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFAEMARKETINGPROSPECT '+
                                 ' Where SEQTAREFA = ' +IntToStr(VpaDTarefa.SeqTarefa));
  Cadastro.edit;
  Cadastro.FieldByname('QTDEMAILENVIADO').AsInteger :=RQtdEmailEnviado(VpaDTarefa.SeqTarefa) ;
  Cadastro.FieldByname('QTDNAOENVIADO').AsInteger :=RQTDEmailsNaoEnviados(VpaDTarefa.SeqTarefa);
  Cadastro.post;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.PosProspectsEMarketing(VpaTabela : TDataSet;VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select TIM.CODPROSPECT, TIM.SEQCONTATO, TIM.NOMCONTATO, TIM.DESEMAIL, '+
                                  ' TIM.INDCONTATOPRINCIPAL ' +
                                  ' from TAREFAEMARKETINGPROSPECTITEM TIM '+
                                  ' WHERE TIM.SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                                  ' AND TIM.INDENVIADO = ''N'''+
                                  ' order by TIM.DESEMAIL');
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.PosProspectsparaTeleMarketing(VpaTabela : TDataSet; VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'select CODPROSPECT, NOMPROSPECT,TIM.DESERRO  '+
                                  ' from PROSPECT PRO, TAREFAEMARKETINGPROSPECTITEM TIM '+
                                  ' WHERE PRO.CODPROSPECT = TIM.CODPROSPECT '+
                                  ' AND TIM.SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                                  ' AND TIM.INDENVIADO = ''N''');
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.RAssuntoEmail(VpaAssunto,VpaNomCliente : String) : String;
begin
  if ExisteLetraString('@',VpaAssunto) then
    result := SubstituiStr(VpaAssunto,'@',VpaNomCliente)
  else
    result := VpaAssunto;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.EnviaEmailProspect(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT; VpaDFilial : TRBDFilial;VpaDEmailMarketing : TRBDEmailMarketing; VpaCodProspect: Integer; VpaNomContato, VpaDesEmail,VpaContatoPrincipal : String;VpaStatus : TLabel):string;
var
  VpfEmailHTML : TIdText;
  Vpfbmppart : TIdAttachmentfile;
begin
  result := '';
  VpaDesEmail := RetiraAcentuacao(VpaDesEmail);
  VpaDesEmail := SubstituiStr(VpaDesEmail,',','.');
  if (VpaDesEmail = '') then
  begin
    if VpaContatoPrincipal = 'S' then
      result := 'Falta o email principal do prospect '+IntToStr(VpaCodProspect)
    else
      result := 'Falta e-mail do contato "'+VpaNomContato+'" do prospect '+IntToStr(VpaCodProspect);
  end;
  if result = '' then
  begin
    VpaStatus.Caption := AdicionaCharD(' ','Enviado e-mail para o contato "'+VpaNomContato +'"',70);
    VpaStatus.Refresh;

    VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    MontaEmailHTML(VpfEmailHTML.Body,VpaDTarefa);

    VprMensagem.Recipients.EMailAddresses := LowerCase(VpaDesEmail);

    if copy(LowerCase(VpaDTarefa.NomArquivoAnexo),1,7) <> 'http://' then
    begin
      Vpfbmppart := TIdAttachmentfile.Create(VprMensagem.MessageParts,VpaDTarefa.NomArquivoAnexo );
      Vpfbmppart.ContentType := 'image/gif';
      Vpfbmppart.ContentDisposition := 'inline';
      Vpfbmppart.ExtraHeaders.Values['content-id'] := RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo) ;
      Vpfbmppart.DisplayName := RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo);
    end;

    VprMensagem.Subject := RAssuntoEmail(VpaDTarefa.DesAssuntoEmail,VpaNomContato);
    result := EnviaEmail(VprMensagem,VprSMTP,VpaDFilial,VpaDEmailMarketing);
    VpfEmailHTML.free;
    Vpfbmppart.free;
  end;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDEmailMarketing : TRBDEmailMarketing) : string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  VpaMensagem.From.Address := VpaDEmailMarketing.DesEmail;
  VpaMensagem.From.Name := PrimeirasMaiusculas(VpaDFilial.NomFantasia);

  if config.ServidorInternetRequerAutenticacao then
  begin
    if VpaSMTP.UserName = '' then
      result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
    if VpaSMTP.Password = '' then
      result := 'SENHA SMTP DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações a senha do e-mail de origem';
  end;
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
procedure TRBFuncoesEMarketingProspect.MontaEmailHTML(VpaTexto : TStrings; VpaDTarefa: TRBDTAREFAEMARKETINGPROSPECT);
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> e-Marketing Eficácia Sistemas e Consultoria');
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('  <center>');
  if UpperCase(copy(VpaDTarefa.DesLinkInternet,1,3)) = 'WWW' then
    VpaTexto.add('    <a title="Clique, para maiores informações" href="http://'+VpaDTarefa.DesLinkInternet + '">')
  else
    VpaTexto.add('    <a title="Clique, para maiores informações" href="'+VpaDTarefa.DesLinkInternet + '">');
  if copy(LowerCase(VpaDTarefa.NomArquivoAnexo),1,7) <> 'http://' then
    VpaTexto.add('      <IMG src="cid:'+RetornaNomArquivoSemDiretorio(VpaDTarefa.NomArquivoAnexo) +' " border="0" >')
  else
    VpaTexto.add('      <IMG src="'+VpaDTarefa.NomArquivoAnexo +' " border="0" >');
  VpaTexto.add('    </a>');
  VpaTexto.add('  </center>');
  VpaTexto.add('  <br>');
  VpaTexto.add('  <center>');
  VpaTexto.add('  <font face="Verdana" size =-3>');
  VpaTexto.add('Esta mensagem nao pode ser considerada SPAM por possuir as seguintes caracteristicas:<br>');
  VpaTexto.add('identificacao do remetente, descricao clara do conteudo e opcao para remocao da lista de distribuicao');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>Para excluir seu cadastro responda esse e-mail com o assunto REMOVER');
  VpaTexto.add('  </font>');
  VpaTexto.add('  </center>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gestao desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficacia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
end;


{******************************************************************************}
function TRBFuncoesEMarketingProspect.ConectaEmail(VpaSMTP : TIdSMTP;VpaDEmailMarketing : TRBDEmailMarketing) : string;
var
  VpfConectou : Boolean;
  VpfQtdVezes : Integer;
begin
  VpfConectou := false;
  VpfQtdVezes := 0;
  while not VpfConectou and (VpfQtdVezes < 3) do
  begin
    inc(VpfQtdVezes);
    if VpaSMTP.Connected then
       VpaSMTP.Disconnect;
    VpaSMTP.UserName := VpaDEmailMarketing.DesEmail;
    VpaSMTP.Host := Varia.ServidorSMTP;
    VpaSMTP.Port := 25;
    if config.ServidorInternetRequerAutenticacao then
    begin
      VpaSMTP.Password := VpaDEmailMarketing.DesSenha;
      VpaSMTP.AuthType := satDefault;
    end
    else
      VpaSMTP.AuthType := satNone;
    try
      VpaSMTP.Connect;
      VpfConectou := true;
    except
    end;
  end;
end;

function TRBFuncoesEMarketingProspect.RQtdEMail(VpaSeqTarefa : Integer) : Integer;
begin
  Aux.Close;
  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT COUNT(SEQTAREFA) QTD '+
              ' FROM TAREFAEMARKETINGPROSPECTITEM  ' +
              ' WHERE SEQTAREFA = '+IntTosTr(VpaSeqTarefa));
  Aux.Open;
  result := Aux.FieldByname('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.RQtdEmailsNaoEnviados(VpaSeqTarefa : Integer) : Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select COUNT(SEQTAREFA) QTD  FROM TAREFAEMARKETINGPROSPECTITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                            ' and INDENVIADO = ''N''');
  Result := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.RQtdEmailEnviado(VpaSeqTarefa : Integer) : Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select COUNT(SEQTAREFA) QTD  FROM TAREFAEMARKETINGPROSPECTITEM '+
                            ' Where SEQTAREFA = ' +IntToStr(VpaSeqTarefa)+
                            ' and INDENVIADO = ''S''');
  Result := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.AtualizaQtdEmail(VpaSeqTarefa : Integer);
begin
  ExecutaComandoSql(Tabela,'Update TAREFAEMARKETINGPROSPECT SET QTDEMAIL = '+IntToStr(RQtdEMail(VpaSeqTarefa))+
                           ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa));
end;

{******************************************************************************}
procedure TRBFuncoesEMarketingProspect.CarDTarefaEMarkegting(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT;VpaSeqTarefa : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from TAREFAEMARKETINGPROSPECT '+
                               ' Where SEQTAREFA = '+IntToStr(VpaSeqTarefa));
  VpaDTarefa.SeqTarefa := VpaSeqTarefa;
  VpaDTarefa.QtdEmail := Tabela.FieldByname('QTDEMAIL').AsInteger;
  VpaDTarefa.DesAssuntoEmail := Tabela.FieldByname('DESASSUNTOEMAIL').AsString;
  VpaDTarefa.DesLinkInternet :=Tabela.FieldByname('DESLINKINTERNET').AsString;
  VpaDTarefa.NomArquivoAnexo :=Tabela.FieldByname('NOMARQUIVO').AsString;
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.EnviaEMarketingProspect(VpaDTarefa : TRBDTAREFAEMARKETINGPROSPECT;VpaLabel,VpaNomContaEmail,VpaQtdEmail : TLabel;VpaProgresso : TProgressBar ):String;
var
  VpfDFilial : TRBDFilial;
  VpfQtdEmail, VpfCodProspect,VpfIndiceEmailRemetente : Integer;
  VpfEmailsRemetente : TList;
  VpfDEmailMarketing : TRBDEmailMarketing;
begin
  VpfEmailsRemetente := TList.create;
  VpfIndiceEmailRemetente := 0;
  result := Sistema.CarEmailMarketing(VpfEmailsRemetente);
  if result = '' then
  begin
    VpfDEmailMarketing := TRBDEmailMarketing(VpfEmailsRemetente.Items[VpfIndiceEmailRemetente]);
    VpaNomContaEmail.Caption := VpfDEmailMarketing.DesEmail;
    VpaNomContaEmail.Refresh;
    VpaProgresso.Max := VpaDTarefa.QtdEmail;
    VpaProgresso.Position := 0;
    VpfQtdEmail := 999;
    VpfDFilial := TRBDFilial.cria;
    Sistema.CarDFilial(VpfDFilial,Varia.CodigoEmpFil);
    PosProspectsEMarketing(Prospects,VpaDTarefa.SeqTarefa);
    While not Prospects.eof do
    begin
      if VpfQtdEmail > 40 then
      begin
        VpaLabel.Caption := 'Conectando com o servidor de e-mail';
        VpaLabel.Refresh;
        ConectaEmail(VprSMTP,VpfDEmailMarketing);
        VpfQtdEmail := 0;
        AtualizaQtdEmailEnviados(VpaDTarefa);
      end;
      inc(VpfQtdEmail);

      result := EmailValido(Prospects.FieldByname('DESEMAIL').AsString);
      if result = '' then
      begin
        result := EnviaEmailProspect(VpaDTarefa,VpfDFilial,VpfDEmailMarketing, Prospects.FieldByname('CODPROSPECT').AsInteger,Prospects.FieldByname('NOMCONTATO').AsString,
                          Prospects.FieldByname('DESEMAIL').AsString,Prospects.FieldByname('INDCONTATOPRINCIPAL').AsString,VpaLabel);
        if result <> '' then
        begin
          if (copy(DeleteAteChar(result,#13),1,3) = '552') or
             (lowerCase(DeletaEspaco(DeleteAteChar(result,#13))) = 'connectionclosedgracefully.') then
          begin
            VpfDEmailMarketing.HorUltimoenvio := now;
            if IncHora(TRBDEmailMarketing(VpfEmailsRemetente.Items[VpfIndiceEmailRemetente]).HorUltimoenvio,1) < now then
              VpfIndiceEmailRemetente := -1;
            inc(VpfIndiceEmailRemetente);
            if VpfIndiceEmailRemetente >= VpfEmailsRemetente.Count then
               VpfIndiceEmailRemetente := 0;
            VpfDEmailMarketing := TRBDEmailMarketing(VpfEmailsRemetente.Items[VpfIndiceEmailRemetente]);
            VpaNomContaEmail.Caption := VpfDEmailMarketing.DesEmail;
            VpaNomContaEmail.Refresh;
            VpaLabel.Caption := 'Conectando com o servidor de e-mail';
            VpaLabel.Refresh;
            ConectaEmail(VprSMTP,VpfDEmailMarketing);
            result := EnviaEmailProspect(VpaDTarefa,VpfDFilial,VpfDEmailMarketing, Prospects.FieldByname('CODPROSPECT').AsInteger,Prospects.FieldByname('NOMCONTATO').AsString,
                          Prospects.FieldByname('DESEMAIL').AsString,Prospects.FieldByname('INDCONTATOPRINCIPAL').AsString,VpaLabel);
          end;
        end;
      end;

      GravaEnvioTarefaProspect(VpaDTarefa.SeqTarefa,Prospects.FieldByname('CODPROSPECT').AsInteger,Prospects.FieldByname('SEQCONTATO').AsInteger,result);


      VpaProgresso.Position := VpaProgresso.Position + 1;
      VpaQtdEmail.Caption := IntToStr(VpaProgresso.Position);
      VpaQtdEmail.refresh;
      Application.ProcessMessages;

      Prospects.Next;
    end;
    AtualizaQtdEmailEnviados(VpaDTarefa);

    if VprSMTP.Connected then
      VprSMTP.Disconnect;
    VpfDFilial.free;
  end;
  FreeTObjectsList(VpfEmailsRemetente);
  VpfEmailsRemetente.free;
end;

{******************************************************************************}
function TRBFuncoesEMarketingProspect.GeraTarefaTeleMarketing(VpaSeqTarefa, VpaCodUsuario: Integer): string;
var
  VpfQtdEmailNaoEnviados, VpfSeqTarefaTele : Integer;
begin
  VpfQtdEmailNaoEnviados := RQTDEmailsNaoEnviados(VpaSeqTarefa);
  if  VpfQtdEmailNaoEnviados > 0  then
  begin
    VpfSeqTarefaTele := GeraNovaTarefaTeleMarketing(VpaCodUsuario,VpfQtdEmailNaoEnviados);
    AdicionaSQLAbreTabela(Cadastro,'Select * from TAREFATELEMARKETINGPROSPECTITEM');
    PosProspectsparaTeleMarketing(Prospects,VpaSeqTarefa);
    While not Prospects.Eof do
    begin
      Cadastro.insert;
      Cadastro.FieldByname('SEQTAREFA').AsInteger := VpfSeqTarefaTele;
      Cadastro.FieldByname('CODUSUARIO').AsInteger := VpaCodUsuario;
      Cadastro.FieldByname('CODPROSPECT').AsInteger := Prospects.FieldByname('CODPROSPECT').AsInteger;
      Cadastro.FieldByname('DATLIGACAO').AsDateTime := Date;
      Cadastro.FieldByname('SEQCAMPANHA').AsInteger := Varia.SeqCampanhaCadastrarEmail;
      Cadastro.FieldByname('INDREAGENDADO').AsString := 'N';
      Cadastro.post;

      FunProspect.AlterarObsLigacao(Prospects.FieldByname('CODPROSPECT').AsInteger,Prospects.FieldByname('DESERRO').AsString);
      Prospects.Next;
    end;
    Prospects.close;
  end;
  Prospects.Close;
  Cadastro.close;
end;

end.


