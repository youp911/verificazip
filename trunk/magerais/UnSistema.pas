Unit UnSistema;
{Verificado
-.edit;
}
Interface

Uses Classes, SysUtils,Windows, UnDados, forms, Registry, Tabela, SQLExpr,
     IdMessage, IdSMTP,  idtext, idAttachmentfile ;

Const
  CT_OPERACAOINVETARIO = 'FALTA CONFIGURAÇÃO INVENTÁRIO!!!'#13'Falta nas configurações dos produtos indicar quais serão as operações de estoque de saida e entrada de inventário...';

//classe localiza
Type TRBLocalizaSistema = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesSistema = class(TRBLocalizaSistema)
  private
    SisCadastro : TSQL;
    SisAux,
    SisLog : TSQLQuery;
    function RTabelasQuePodemFicarAbertas : Integer;
    function RSeqLogDisponivel:Integer;
    function RDatValidadeSistema : TDatetime;
    function RQtdCustosPendentes : Integer;
    function RQtdCustosRealizado(VpaData : TDateTime):integer;
    procedure SalvarDataValidadeSistema(VpaData : TDateTime);
    function RegistraSistema : Boolean;
    function InicializaDiaCusto(VpaData : TDateTime;VpaQtdCustoPendente : Integer):string;
    function AtualizaCustoUltimoDia(VpaData : TDateTime;VpaQtdCustoPendente : Integer):string;
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    function CarEmailMarketing(VpaEmails : TList) : String;
    function EnviaEmail(VpaDestinatario, VpaAssunto, VpaCorpo,VpaAnexo : String):String;overload;
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP) : string;overload;
    function CFGInventarioValido : String;
    procedure GravaLogExclusao(VpaNomTabela :String; VpaComandoSQL : String);
    function RNomUsuario(VpaCodUsuario : Integer):String;
    function REmpresaFilial(VpaCodFilial : Integer) : Integer;
    function RNomFilial(VpaCodFilial : Integer) : String;
    function RNomComputador : String;
    function RTabelaPrecoFilial(VpaCodFilial : Integer) :Integer;
    procedure GravaDataUltimaBaixa(VpaData : TDateTime);
    function RDataUltimaBaixa : TDateTime;
    procedure CarDFilial(VpaDFilial : TRBDFilial;VpaCodFilial : Integer);
    procedure SalvaTabelasAbertas;
    function ValidaSerieSistema : Boolean;
    function AtualizaInformacoesGerencialCustos(VpaDiaAnterior,VpaData : TDateTime) : String;
    function AtualizaDataInformacaoGerencial(VpaData : TDateTime) : string;
    function RQtdParcelasCondicaoPagamento(VpaCodCondicaoPagamento : Integer) : Integer;
    function RRodapeCRM(VpaCodFilial : integer) : string;
end;

Var
  Sistema  : TRBFuncoesSistema;

implementation

Uses FunSql, Constantes, APrincipal, Constmsg, FunValida, fundata,AValidaSerieSistema,
  FunObjeto, FunArquivos;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaSistema
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaSistema.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesSistema
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesSistema.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;

  SisCadastro := TSQL.Create(nil);
  SisCadastro.ASQLConnection := VpaBaseDados;
  SisAux := TSQLQUERY.Create(nil);
  SisAux.SQLConnection := VpaBaseDados;
  SisLog := TSQLQUERY.Create(nil);
  SisLog.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesSistema.destroy;
begin
  SisCadastro.free;
  SisAux.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesSistema.EnviaEmail(VpaMensagem: TIdMessage;VpaSMTP: TIdSMTP): string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  VpaMensagem.From.Address := varia.UsuarioSMTP;
  VpaMensagem.From.Name := varia.NomeFilial;

  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := 25;
  VpaSMTP.AuthType := satDefault;

  VpaMensagem.ReceiptRecipient.Text  :=VpaMensagem.From.Text;

  if VpaMensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DA FILIAL !!!'#13'É necessário preencher o e-mail da transportadora.';
  if VpaSMTP.UserName = '' then
    result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
  if VpaSMTP.Password = '' then
    result := 'SENHA SMTP DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações a senha do e-mail de origem';
  if VpaSMTP.Host = '' then
    result := 'SERVIDOR DE SMTP NÃO CONFIGURADO!!!'#13'É necessário configurar qual o servidor de SMTP...';
  if result = '' then
  begin
    VpaSMTP.Connect;
    try
      VpaSMTP.Send(VpaMensagem);

    except
      on e : exception do
      begin
        result := 'ERRO AO ENVIAR O E-MAIL!!!'#13+e.message;
        VpaSMTP.Disconnect;
      end;
    end;
    VpaSMTP.Disconnect;
    VpaMensagem.Clear;
  end;
end;

{******************************************************************************}
function TRBFuncoesSistema.CarEmailMarketing(VpaEmails : TList) : String;
var
  VpfDEmail : TRBDEmailMarketing;
begin
  FreeTObjectsList(VpaEmails);
  result := '';
  AdicionaSQLAbreTabela(SisLog,'Select * from EMAILMARKETING' +
                               ' order by SEQEMAIL ' );
  While not SisLog.eof do
  begin
    VpfDEmail := TRBDEmailMarketing.cria;
    VpaEmails.Add(VpfDEmail);
    VpfDEmail.SeqEmail := SisLog.FieldByName('SEQEMAIL').AsInteger;
    VpfDEmail.DesEmail := SisLog.FieldByName('DESEMAIL').AsString;
    VpfDEmail.DesSenha := SisLog.FieldByName('DESSENHA').AsString;
    SisLog.next;
  end;
  SisLog.close;
  if VpaEmails.count = 0 then
    result := 'EMAIL''S REMETENTE NÃO CADASTRADOS!!!'#13'É necessário cadastrar os e-mail''s remetentes nas configurações gerais do sistema na pagina Email Marketing';
end;

{******************************************************************************}
function TRBFuncoesSistema.EnviaEmail(VpaDestinatario, VpaAssunto, VpaCorpo,VpaAnexo : String):String;
var
   VpfSMTP : TIdSMTP;
   VpfMensagem : TidMessage;
   VpfEmailTexto, VpfEmailHTML : TIdText;
   VpfAnexo : TIdAttachmentfile;
begin
  if Varia.ServidorSMTP = '' then
    result := 'O servidor SMTP não foi informado';
  if VpaAssunto = '' then
    result :='O assunto da mensagem não foi informado';
  if varia.UsuarioSMTP  = '' then
    result := 'Não foi preenchido o usuario de e-mail nas configurações do sistema';
  if result = ''  then
  begin
    VpfSMTP := TIdSMTP.Create(nil);

    VpfMensagem := TIdMessage.Create(nil);
    VpfMensagem.Clear;
    VpfMensagem.IsEncoded := True;
    VpfMensagem.AttachmentEncoding := 'MIME';
    VpfMensagem.Encoding := meMIME; // meDefault;
    VpfMensagem.ConvertPreamble := True;
    VpfMensagem.Priority := mpNormal;
    VpfMensagem.ContentType := 'multipart/mixed';
    VpfMensagem.CharSet := 'ISO-8859-1';
    VpfMensagem.Date := Now;

    VpfEmailHTML := TIdText.Create(VpfMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    VpfEmailHTML.CharSet := 'ISO-8859-1'; // NOSSA LINGUAGEM PT-BR (Latin-1)!!!!
    VpfEmailHTML.ContentTransfer := '16bit'; // para SAIR ACENTUADO !!!! Pois, 8bit SAI SEM
    VpfEmailHTML.Body.Text := VpaCorpo;

    TRY
      VpfAnexo := TIdAttachmentfile.Create(VpfMensagem.MessageParts,VpaAnexo);
      VpfAnexo.ContentType := 'application/pdf;'+RetornaNomArquivoSemDiretorio(VpaAnexo);

      VpfMensagem.ReceiptRecipient.Text  := varia.UsuarioSMTP;
      VpfMensagem.Recipients.Add.Address := varia.UsuarioSMTP;
      VpfMensagem.ReplyTo.EMailAddresses := varia.UsuarioSMTP;
      VpfMensagem.From.Address := varia.UsuarioSMTP;
      VpfMensagem.From.Name := varia.Nomefilial;

      VpfMensagem.Recipients.EMailAddresses := VpaDestinatario;

      VpfMensagem.Subject := VpaAssunto;

      VpfMensagem.Priority := TIdMessagePriority(0);
      VpfSMTP.UserName := Varia.usuarioSMTP;
      VpfSMTP.Password :=Varia.SenhaEmail;
      VpfSMTP.Host := Varia.ServidorSMTP;
      VpfSMTP.Port := 25;
      VpfSMTP.AuthType := satDefault;
      VpfSMTP.Connect;
      VpfSMTP.Send(VpfMensagem);
      VpfSMTP.Disconnect;
  EXCEPT
    if VpfSMTP.Connected then
      VpfSMTP.Disconnect;
    Raise;
  END;
  end;
  VpfSMTP.free;
  VpfMensagem.free;
end;

{******************************************************************************}
function TRBFuncoesSistema.RTabelasQuePodemFicarAbertas : Integer;
var
  VpfLaco : Integer;
begin
  result := 0;
{ tem que verificar no DBX COMO FAZ PARA BUSCAR ESSAS INFORMACOES
  for VpfLaco := 0 to FPrincipal.BaseBDE.DataSetCount - 1 do
  begin
    if TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner <> nil then
    begin
      if (FPrincipal.BaseDados.DataSets[VpfLaco] is TSQLQUERY) then
      begin
        if ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCartuchos') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'PESOCARTUCHO'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FChamadoTecnico') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ChamadoTecnico'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FChamadoTecnico') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ChamadoProduto')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FClientes') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadClientes')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCobrancas') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Cobranca'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCobrancas') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CobrancaItem'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FContasaPagar') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovParcelas')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FContasaReceber') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovParcelas')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCotacao') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadOrcamento')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FCotacao') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovOrcamentos')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FLeiturasLocacao') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Locacao'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FlocalizaProduto') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadProdutos'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovaCobranca') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadClientes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovaCobranca') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Parcelas'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovaCobranca') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Ligacoes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovaNotaFiscalNota') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovNatureza'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoCliente') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadClientes')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoCliente') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Eventos')) or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Ligacoes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ChamadoTecnico'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'HistoricoLigacoes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadClientes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'CadOrcamentos'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'MovOrcamentos'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ChamadoProduto'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ProdutosComContrato'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'ProdutosSemContrato'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FNovoTeleMarketing') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Inadimplentes'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FPropostas') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Proposta'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FPropostasCliente') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Proposta'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FRomaneioGenerico') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'RomaneioCorpo'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FRomaneioGenerico') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'RomaneioProdutoItem'))or
           ((TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Owner.Name = 'FTeleMarketings') and (TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]).Name = 'Inadimplentes'))then
          inc(result);
      end;
    end;
  end;}
end;

{******************************************************************************}
function TRBFuncoesSistema.RSeqLogDisponivel:Integer;
begin
  AdicionaSQLAbreTabela(SisAux,'Select max(SEQ_LOG) Ultimo FROM LOG ');
  result := SisAux.FieldByName('Ultimo').AsInteger + 1;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RDatValidadeSistema : TDatetime;
begin
  AdicionaSQLAbreTabela(SisAux,'Select C_NOM_CLI from CFG_GERAL');
  if SisAux.FieldByname('C_NOM_CLI').AsString = '' then
    result := decdia(date,1)
  else
    result := StrToDate(Descriptografa(SisAux.FieldByname('C_NOM_CLI').AsString));
  SisAux.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdCustosPendentes : Integer;
begin
  AdicionaSQLAbreTabela(SisAux,'select COUNT(AMO.CODAMOSTRA) QTD '+
                   ' from AMOSTRA AMO '+
                   ' Where AMO.DATENTREGA IS NOT NULL '+
                   ' AND AMO.DATPRECO IS NULL '+
                   ' AND AMO.TIPAMOSTRA = ''D''');
  result := SisAux.FieldByName('QTD').AsInteger;
  SisAux.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdCustosRealizado(VpaData : TDateTime):integer;
begin
  AdicionaSQLAbreTabela(SisAux,'select COUNT(AMO.CODAMOSTRA) QTD '+
                   ' from AMOSTRA AMO '+
                   ' Where AMO.DATENTREGA IS NOT NULL '+
                   ' AND AMO.DATPRECO >='+SQLTextoDataAAAAMMMDD(VpaData)+
                   ' AND AMO.TIPAMOSTRA = ''D''');
  result := SisAux.FieldByName('QTD').AsInteger;
  SisAux.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RQtdParcelasCondicaoPagamento(VpaCodCondicaoPagamento: Integer): Integer;
begin
  AdicionaSQLAbreTabela(SisAux,'select I_QTD_PAR from CADCONDICOESPAGTO '+
                               ' Where I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
  result := SisAux.FieldByName('I_QTD_PAR').AsInteger;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RRodapeCRM(VpaCodFilial: integer): string;
begin
  AdicionaSQLAbreTabela(SisAux,'Select L_ROD_EMA from CADFILIAIS '+
                            ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial));
  result := sisAux.FieldByname('L_ROD_EMA').AsString;
  SisAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSistema.SalvarDataValidadeSistema(VpaData : TDateTime);
begin
  AdicionaSQLAbreTabela(SisCadastro,'Select * from CFG_GERAL ');
  SisCadastro.edit;
  SisCadastro.FieldByname('C_NOM_CLI').AsString := Criptografa(DateToStr(VpaData));
  SisCadastro.post;
  SisCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RegistraSistema : Boolean;
var
  VpfData : TDateTime;
  VpfDSerie : TRBDSerie;
  VpfBase : string;
  VpfQtdMeses : integer;
begin
  VpfDSerie := TRBDSerie.Create;
  FValidaSerieSistema := TFValidaSerieSistema.Create(nil);
  VpfDSerie.Serie := FValidaSerieSistema.RSerie;
  result :=  FValidaSerieSistema.SolicitaSerieSenha('1',VpfDSerie);
  if result then
  begin
    VpfBase := FValidaSerieSistema.rsenhaSistema(Copy(VpfDSerie.Serie,4,length(VpfDSerie.Serie)));
    VpfQtdMeses := StrToInt(Copy(VpfDSerie.Senha,(length(VpfBase) +3),3));
    VpfData := IncMes(VpfDSerie.Dat_Instalacao,VpfQtdMeses);
    SalvarDataValidadeSistema(VpfData);
  end;
  FValidaSerieSistema.free;
end;

{******************************************************************************}
function TRBFuncoesSistema.InicializaDiaCusto(VpaData : TDateTime;VpaQtdCustoPendente : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(SisCadastro,'Select * from RESUMOCUSTO '+
                                    ' Where DATRESUMO = ' +SQLTextoDataAAAAMMMDD(VpaData));
  if SisCadastro.Eof then
    SisCadastro.insert
  else
    SisCadastro.edit;
  SisCadastro.FieldByName('DATRESUMO').AsDateTime := VpaData;
  SisCadastro.FieldByName('QTDINICIAL').AsInteger := VpaQtdCustoPendente;
  SisCadastro.post;
  result := SisCadastro.AMensagemErroGravacao;
  SisCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.AtualizaCustoUltimoDia(VpaData : TDateTime;VpaQtdCustoPendente : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(SisCadastro,'Select * from RESUMOCUSTO '+
                                    ' Where DATRESUMO = ' +SQLTextoDataAAAAMMMDD(VpaData));
  if not SisCadastro.Eof then
  begin
    SisCadastro.edit;
    SisCadastro.FieldByName('QTDPENDENTE').AsInteger := VpaQtdCustoPendente;
    SisCadastro.FieldByName('QTDREALIZADO').AsInteger := RQtdCustosRealizado(VpaData);
    SisCadastro.post;
    result := SisCadastro.AMensagemErroGravacao;
  end;
  SisCadastro.close;
end;

{******************************************************************************}
function TRBFuncoesSistema.CFGInventarioValido : String;
begin
  result := '';
  if not((Varia.InventarioEntrada <> 0) and (varia.InventarioSaida <> 0)) then
    result := CT_OPERACAOINVETARIO;
end;

{******************************************************************************}
procedure TRBFuncoesSistema.GravaLogExclusao(VpaNomTabela :String;VpaComandoSQL : String);
var
  VpfLaco,VpfQtdGravacao : Integer;
  VpfResultado : String;
begin
  AdicionaSQLAbreTabela(SisCadastro,'Select * from LOG '+
                                    ' Where SEQ_LOG = 0 ');
  AdicionaSQLAbreTabela(SisLog,VpaComandoSQL);
  SisLog.First;
  While not SisLog.Eof do
  begin
    SisCadastro.Insert;
    SisCadastro.FieldByName('DAT_LOG').AsDateTime := now;
    SisCadastro.FieldByName('COD_USUARIO').AsInteger := Varia.CodigoUsuario;
    SisCadastro.FieldByName('DES_LOG').AsString := 'Exclusão';
    SisCadastro.FieldByName('NOM_TABELA').AsString := VpaNomTabela;
    SisCadastro.FieldByName('NOM_MODULO_SISTEMA').AsString := NomeModulo;
    SisCadastro.FieldByName('NOM_COMPUTADOR').AsString := varia.NomeComputador;
    for VpfLaco := 0 to SisLog.FieldCount - 1 do
    begin
      SisCadastro.FieldByName('DES_INFORMACOES').AsString := SisCadastro.FieldByName('DES_INFORMACOES').AsString + #13+
                            SisLog.Fields[VpfLaco].DisplayName +' = "'+
                            SisLog.FieldByName(SisLog.Fields[VpfLaco].DisplayName).AsString+'"';
    end;
    VpfQtdGravacao := 0;
    repeat
      SisCadastro.FieldByName('SEQ_LOG').AsInteger := RSeqLogDisponivel;
      VpfResultado := '';
      SisCadastro.Post;
      VpfResultado := SisCadastro.AMensagemErroGravacao;
      inc(VpfQtdGravacao);
    until ((VpfResultado = '') or (VpfQtdGravacao > 3));
    if VpfResultado <> '' then
      aviso(VpfREsultado);

    SisLog.next;
  end;
  SisLog.close;
  SisCadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RNomUsuario(VpaCodUsuario : Integer):String;
begin
  AdicionaSQLAbreTabela(SisAux,'Select * from CADUSUARIOS '+
                               ' Where I_COD_USU = '+ IntTostr(VpaCodUsuario));
  result := SisAux.FieldByName('C_NOM_USU').AsString;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.REmpresaFilial(VpaCodFilial : Integer) : Integer;
begin
  if VpaCodFilial = 0 then
    VpaCodFilial := varia.CodigoEmpFil;
  AdicionaSQLAbreTabela(Sisaux,'Select I_COD_EMP from CADFILIAIS '+
                               ' Where I_EMP_FIL = '+IntTostr(VpaCodFilial));
  result := Sisaux.FieldByName('I_COD_EMP').AsInteger;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RNomFilial(VpaCodFilial : Integer) : String;
begin
  AdicionaSQLAbreTabela(SisAux,'Select * from CADFILIAIS '+
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodfilial));
  result := SisAux.FieldByName('C_NOM_FAN').AsString;
  SisAux.Close;
end;

{******************************************************************************}
function TRBFuncoesSistema.RNomComputador : String;
var
  lpBuffer : Array[0..20] of Char;
  nSize : dWord;
  mRet : boolean;
begin
  nSize :=120;
  mRet:= GetComputerName(lpBuffer,nSize);
  if mRet then
    Result:= lpBuffer
  else
    result := 'INDEFINIDO';
end;

{******************************************************************************}
function TRBFuncoesSistema.RTabelaPrecoFilial(VpaCodFilial : Integer) :Integer;
begin
  AdicionaSqlabreTabela(SisAux,'Select I_COD_TAB from CADFILIAIS '+
                               ' Where I_EMP_FIL = '+ InttoStr(VpacodFilial));
  result := SisAux.FieldByName('I_COD_TAB').AsInteger;
  SisAux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesSistema.GravaDataUltimaBaixa(VpaData : TDateTime);
var
 VpfIni : TRegIniFile;
begin
 // informacoes do ini
  VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  VpfIni.OpenKey('GERAIS',true);
  VpfIni.WriteDate('DATABAIXACR', VpaData);
  VpfIni.free;
end;

{******************************************************************************}
function TRBFuncoesSistema.RDataUltimaBaixa : TDateTime;
var
 VpfIni : TRegIniFile;
begin
 // informacoes do ini
  VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  VpfIni.OpenKey('GERAIS',true);
  try
    result := VpfIni.ReadDate('DATABAIXACR');
  except
    result := date;
  end;
  VpfIni.free;
end;

{******************************************************************************}
procedure  TRBFuncoesSistema.CarDFilial(VpaDFilial : TRBDFilial;VpaCodFilial : Integer);
begin
  AdicionaSQLAbreTabela(SisAux,'Select I_EMP_FIL, C_NOM_FIL, C_NOM_FAN, C_WWW_FIL, C_END_ELE, '+
                               ' C_BAI_FIL, C_CID_FIL, C_EST_FIL, I_CEP_FIL, C_FON_FIL, C_END_FIL,I_NUM_FIL, '+
                               ' C_CRM_CES, C_CRM_CCL, C_EMA_COM, C_CGC_FIL, C_INS_FIL, C_CAB_EMA, C_MEI_EMA,  '+
                               ' L_ROD_EMA, I_COD_FIS, C_INS_MUN, C_PER_SPE, I_ATI_SPE, C_CPC_SPE, '+
                               ' C_CRC_SPE, C_NCO_SPE, I_CON_SPE, C_IND_NFE '+
                               ' from CADFILIAIS '+
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial));
  with VpaDFilial do
  begin
    CodFilial := VpaCodFilial;
    NomFilial := SisAux.FieldByname('C_NOM_FIL').AsString;
    NomFantasia := SisAux.FieldByname('C_NOM_FAN').AsString;
    DesSite := SisAux.FieldByname('C_WWW_FIL').AsString;
    DesEmail := SisAux.FieldByname('C_END_ELE').AsString;
    DesEndereco := SisAux.FieldByname('C_END_FIL').AsString+', '+SisAux.FieldByname('I_NUM_FIL').AsString;
    DesEnderecoSemNumero := SisAux.FieldByname('C_END_FIL').AsString;
    NumEndereco :=SisAux.FieldByname('I_NUM_FIL').AsInteger;
    DesBairro := SisAux.FieldByname('C_BAI_FIL').AsString;
    DesCidade := SisAux.FieldByname('C_CID_FIL').AsString;
    DesUF := SisAux.FieldByname('C_EST_FIL').AsString;
    DesCep := SisAux.FieldByname('I_CEP_FIL').AsString;
    DesFone := SisAux.FieldByname('C_FON_FIL').AsString;
    DesEmailComercial := SisAux.FieldByname('C_EMA_COM').AsString;
    DesCNPJ := SisAux.FieldByname('C_CGC_FIL').AsString;
    DesInscricaoEstadual := SisAux.FieldByname('C_INS_FIL').AsString;
    DesInscricaoMunicipal := SisAux.FieldByname('C_INS_MUN').AsString;
    DesCabecalhoEmailProposta := SisAux.FieldByname('C_CAB_EMA').AsString;
    DesMeioEmailProposta := SisAux.FieldByname('C_MEI_EMA').AsString;
    DesRodapeEmailProposta := SisAux.FieldByname('L_ROD_EMA').AsString;
    Varia.CRMCorEscuraEmail := SisAux.FieldByName('C_CRM_CES').AsString;
    varia.CRMCorClaraEmail := SisAux.FieldByName('C_CRM_CCL').AsString;
    CodIBGEMunicipio := SisAux.FieldByname('I_COD_FIS').AsInteger;
    DesPerfilSpedFiscal := SisAux.FieldByName('C_PER_SPE').AsString;
    CodAtividadeSpedFiscal := SisAux.FieldByName('I_ATI_SPE').AsInteger;
    DesCPFContador := SisAux.FieldByName('C_CPC_SPE').AsString;
    DesCRCContador := SisAux.FieldByName('C_CRC_SPE').AsString;
    NomContador := SisAux.FieldByName('C_NCO_SPE').AsString;
    CodContabilidade := SisAux.FieldByName('I_CON_SPE').AsInteger;
    IndEmiteNFE := SisAux.FieldByName('C_IND_NFE').AsString = 'T';
  end;
  sisAux.Close;

end;

{******************************************************************************}
procedure TRBFuncoesSistema.SalvaTabelasAbertas;
var
  VpfArquivo : TStringList;
  VpfLaco : Integer;
  VpfTabela : TSQLQUERY;
begin
{ tem que verificar no dbx como faz essa rotina;
  if FPrincipal.BaseBDE.DataSetCount > RTabelasQuePodemFicarAbertas then
  begin
    VpfArquivo := TStringList.create;
    VpfArquivo.Add('Aplicativo = '+Application.ExeName);
    VpfArquivo.Add('Formulario Ativo = '+Screen.ActiveForm.Name);
    VpfArquivo.Add('');
    VpfArquivo.Add('Formularios Aberto');
    for VpfLaco := Screen.FormCount - 1 downto 0 do
    begin
      VpfArquivo.Add(Screen.Forms[vpflaco].Name);
    end;

    VpfArquivo.Add('');
    VpfArquivo.Add('Tabelas Abertas');
    for VpfLaco := 0 to FPrincipal.BaseBDE.DataSetCount - 1 do
    begin
      if (FPrincipal.BaseBDE.DataSets[VpfLaco] is TSQLQUERY) then
      begin
        VpfTabela := TSQLQUERY(FPrincipal.BaseBDE.DataSets[VpfLaco]);
        VpfArquivo.add('----------------------------------------------------');
        VpfArquivo.add('Nome Componente = '+VpfTabela.Name);
        if VpfTabela.Owner <> nil then
          VpfArquivo.add('Dono = '+VpfTabela.Owner.Name);
        VpfArquivo.add(VpfTabela.SQL.text);
      end;
    end;
    if VpfArquivo.Count > 0 then
    begin
      VpfArquivo.add(Application.Name);
//      VpfArquivo.savetofile(Varia.DiretorioSistema+'\tabelas'+FormatDateTime('YYYYMMDD_HHMMSS',now)+'.txt');
    end;
    VpfArquivo.free;
  end;}
end;

{******************************************************************************}
function TRBFuncoesSistema.ValidaSerieSistema : Boolean;
var
  VpfData : TDateTime;
begin
  result := false;
  VpfData := RDatValidadeSistema;
  result := VpfData > date;
  if not result then
  begin
    result := RegistraSistema;
  end
  else
    if VpfData < IncDia(date,10) then
      if confirmacao('O registro do sistema irá expirar em '+IntToStr(DiasPorPeriodo(date,VpfData)) + ' dias. Entre em contato o mais breve possível com o seu fornecedor de Software para adquirir um novo registro.'#13+
                     'Deseja registrar o sistema agora?') then
        RegistraSistema;
end;

{******************************************************************************}
function TRBFuncoesSistema.AtualizaInformacoesGerencialCustos(VpaDiaAnterior,VpaData : TDateTime) : String;
var
  vpfQtdCustoPendentes : Integer;
begin
  result := '';
  vpfQtdCustoPendentes := RQtdCustosPendentes;
  result := InicializaDiaCusto(VpaData,vpfQtdCustoPendentes);
  if result = '' then
    result := AtualizaCustoUltimoDia(VpaDiaAnterior,vpfQtdCustoPendentes);
end;

{******************************************************************************}
function TRBFuncoesSistema.AtualizaDataInformacaoGerencial(VpaData : TDateTime) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(SisCadastro,'Select * from CFG_GERAL');
  SisCadastro.edit;
  SisCadastro.FieldByName('D_INF_GER').AsDateTime := VpaData;
  SisCadastro.post;
  result := SisCadastro.AMensagemErroGravacao;
  SisCadastro.close;
end;

end.
