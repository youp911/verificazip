Unit UnSpedFiscal;

Interface

Uses Classes, DBTables, UnDados,SysUtils, Unsistema, comCtrls, Unclientes, Tabela,SqlExpr;

//classe localiza
Type TRBLocalizaSpedFiscal = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesSpedFiscal = class(TRBLocalizaSpedFiscal)
  private
    Tabela : TSQL;
    VprBarraStatus : TStatusBar;
    procedure AtualizaStatus(VpaTexto : String);
    procedure LocalizaParticipantesREG0150(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaUnidadesMedidasREG0190(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaProdutosREG0200(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaNaturezaOperacaoREG0400(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaNotasFiscaisSaidaRegC100(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    function DadosValidos(VpaDSped : TRBDSpedFiscal) : string;
    procedure DadosValidosParticipantesREG0150(VpaDSped : TRBDSpedFiscal);
    procedure DadosValidosProdutosREG0200(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0000(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0005(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0100(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0150(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0190(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0200(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0400(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC100(VpaDSped : TRBDSpedFiscal);
    procedure CarDSped(VpadSped : TRBDSpedFiscal);
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    procedure GeraSpedfiscal(VpaDSped : TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
end;



implementation

Uses FunSql, Constantes, funString, funvalida, UnNotafiscal;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaSpedFiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaSpedFiscal.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesSpedFiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
procedure TRBFuncoesSpedFiscal.AtualizaStatus(VpaTexto: String);
begin
  VprBarraStatus.Panels[0].Text := VpaTexto;
  VprBarraStatus.Refresh;
end;

{********************************* cria a classe ********************************}
procedure TRBFuncoesSpedFiscal.CarDSped(VpadSped: TRBDSpedFiscal);
begin
  VpadSped.PerICMSInterno := FunNotaFiscal.RValICMSPadrao(VpadSped.DFilial.DesUF,'ISENTO',true,false);
  VpadSped.QtdLinhasBloco0 := 0;
end;

{********************************************************************************}
constructor TRBFuncoesSpedFiscal.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Tabela :=  TSQL.create(nil);
  Tabela.ASQlConnection := VpaBaseDados;
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.DadosValidos(VpaDSped: TRBDSpedFiscal): string;
begin
  result := '';
  if VpaDSped.DFilial.CodIBGEMunicipio = 0 then
    VpaDSped.Incosistencias.add('CODIGO IBGE EMITENTE NÃO PREENCHIDO!!!'#13'É necessário corrigir o cadastro da FILIAL para associar o codigo IBGE.');
  if VpaDSped.DFilial.DesPerfilSpedFiscal = '' then
    VpaDSped.Incosistencias.add('PERFIL DE APRESENTAÇÃO DO ARQUIVO FISCAL NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais nas página Sped Fiscal e preencher o perfil da filial.');
  if VpaDSped.DFilial.CodContabilidade = 0 then
    VpaDSped.Incosistencias.add('CONTABILISTA NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais na pagina Sped Fiscal e preencher o contabilista da filial');
  if VpaDSped.DFilial.DesCPFContador = '' then
    VpaDSped.Incosistencias.add('CPF CONTABILISTA NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais na pagina Sped Fiscal e preencher o CPF do contabilista');
  if VpaDSped.DFilial.DesCRCContador = '' then
    VpaDSped.Incosistencias.add('CRC CONTABILISTA NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais na pagina Sped Fiscal e preencher o CRC do contabilista');
  if VpaDSped.DFilial.NomContador = '' then
    VpaDSped.Incosistencias.add('NOME DO CONTABILISTA NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais na pagina Sped Fiscal e preencher o CRC do contabilista');

  DadosValidosParticipantesREG0150(VpaDSped);
  DadosValidosProdutosREG0200(VpaDSped);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.DadosValidosParticipantesREG0150(VpaDSped: TRBDSpedFiscal);
begin
  LocalizaParticipantesREG0150(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    if Tabela.FieldByName('I_COD_PAI').AsInteger = 0 then
      VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - Falta o codigo IBGE do pais');
    if (Tabela.FieldByName('I_COD_IBG').AsInteger = 0) and
       (Tabela.FieldByName('C_TIP_PES').AsString <> 'E') then
      VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - Falta o codigo IBGE do municipio');
    if Tabela.FieldByName('C_TIP_PES').AsString = 'F' then
    begin
      if not VerificaCPF(Tabela.FieldByName('C_CPF_CLI').AsString) then
        VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - CPF INVALIDO');
    end
    else
      if Tabela.FieldByName('C_TIP_PES').AsString = 'J' then
      begin
        if not VerificaCGC(Tabela.FieldByName('C_CGC_CLI').AsString) then
          VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - CGC INVALIDO');
      end;
    if Tabela.FieldByName('C_END_CLI').AsString = '' then
      VpaDSped.Incosistencias.add('CLIENTE INVÁLIDO "'+Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString+'" - Endereco não preenchido');
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.DadosValidosProdutosREG0200(VpaDSped: TRBDSpedFiscal);
begin
  LocalizaProdutosREG0200(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    if Tabela.FieldByName('C_CLA_FIS').AsString = '' then
      VpaDSped.Incosistencias.add('PRODUTO INVÁLIDO "'+Tabela.FieldByName('C_COD_PRO').AsString+'-'+Tabela.FieldByName('C_NOM_PRO').AsString+'" - Falta o codigo NCM/Classificação fiscal');
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
destructor TRBFuncoesSpedFiscal.destroy;
begin
  Tabela.close;
  Tabela.free;
  inherited;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0000(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : string;
begin
  VpfLinha :='|'+
  //01 REG
    '0000|'+
  //02 COD_VER
  '002|';

  //03 COD_FIN
  case VpaDSped.CodFinalidade of
    cfRemessaOriginal: VpfLinha := VpfLinha + '0|';
    cfRemessaSubtituto: VpfLinha := VpfLinha + '1|';
  end;
  VpfLinha :=  VpfLinha +
  //04 DT_INI
  FormatDateTime('DDMMYYYY',VpaDSped.DatInicio)+'|'+
  //05 DT_FIM
  FormatDateTime('DDMMYYYY',VpaDSped.DatFinal)+'|'+
  //06 NOME
  VpaDSped.DFilial.NomFilial+'|'+
  //07 CNPJ
  DeletaChars(DeletaChars(DeletaChars(VpaDSped.DFilial.DesCNPJ,'/'),'.'),'-')+'|'+
  //08 CPF
  '|'+
  //09 UF
  VpaDSped.DFilial.DesUF+'|'+
  //10 IE
  DeletaChars(DeletaChars(VpaDSped.DFilial.DesInscricaoEstadual,'.'),'-')+'|'+
  //11 COD_MUN
  IntToStr(VpaDSped.DFilial.CodIBGEMunicipio)+'|'+
  //12 IM
  VpaDSped.DFilial.DesInscricaoMunicipal+'|'+
  //13 SUFRAMA
  '|'+
  //14 IND_PERFIL
  VpaDSped.DFilial.DesPerfilSpedFiscal+'|'+
  //15 IND_ATIV
  IntToStr(VpaDSped.DFilial.CodAtividadeSpedFiscal)+'|';
  VpaDSped.Arquivo.Add(VpfLinha);
  inc(VpaDSped.QtdLinhasBloco0);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|0001|0|');
  inc(VpaDSped.QtdLinhasBloco0);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0005(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : string;
begin
  VpfLinha := '|'+
  //01 REG
  '0005|'+
  //02 FANTASIA
  VpaDSped.DFilial.NomFantasia+'|'+
  //03 CEP
  AdicionaCharE('0',DeletaChars(VpaDSped.DFilial.DesCep,'-'),8)+ '|'+
  //04 END
  VpaDSped.DFilial.DesEnderecoSemNumero+'|'+
  //05 NUM
  IntToStr(VpaDSped.DFilial.NumEndereco)+'|'+
  //06 COMPL
  '|'+
  //07 BAIRRO
  VpaDSped.DFilial.DesBairro+'|'+
  //08 FONE
  DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDSped.DFilial.DesFone,'('),')'),'*'),'-'),'0')+'|'+
  //09 FAX
  DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDSped.DFilial.DesFax,'('),')'),'*'),'-'),'0')+'|'+
  //10 email
  VpaDSped.DFilial.DesEmail+'|';
  VpaDSped.Arquivo.Add(VpfLinha);
  inc(VpaDSped.QtdLinhasBloco0);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0100(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : string;
begin
  VpfLinha := '|'+
  //01 REG
  '0100|'+
  //02 NOME
  VpaDSped.DFilial.NomContador+'|'+
  //03 CPF
  DeletaChars(DeletaChars(VpaDSped.DFilial.DesCPFContador,'.'),'-')+'|'+
  //04 CRC
  VpaDSped.DFilial.DesCRCContador+'|'+
  //05 CNPJ
  DeletaChars(DeletaChars(DeletaChars(VpaDSped.DContabilidade.CGC_CPF,'.'),'/'),'-')+'|'+
  //06 CEP
  AdicionaCharE('0',DeletaChars(VpaDSped.DContabilidade.CepCliente,'-'),8)+ '|'+
  //07 END
  VpaDSped.DContabilidade.DesEndereco+'|'+
  //08 NUM
  VpaDSped.DContabilidade.NumEndereco+'|'+
  //09 COMPL
  VpaDSped.DContabilidade.DesComplementoEndereco+ '|'+
  //10 BAIRRO
  VpaDSped.DContabilidade.DesBairro+'|'+
  //11 FONE
  DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDSped.DContabilidade.DesFone1,'('),')'),'*'),'-')+'|'+
  //12 FAX
  DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDSped.DContabilidade.DesFax,'('),')'),'*'),'-')+'|'+
  //13 email
  VpaDSped.DContabilidade.DesEmail+'|'+
  //14 COD_MUN
  IntToStr(VpaDSped.DContabilidade.CodIBGECidade) +'|';
  VpaDSped.Arquivo.Add(VpfLinha);
  inc(VpaDSped.QtdLinhasBloco0);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0150(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : String;
begin
  LocalizaParticipantesREG0150(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01 REG
    '0150|'+
    //02 COD_PART
    Tabela.FieldByName('I_COD_CLI').AsString+'|'+
    //03 nome
    Tabela.FieldByName('C_NOM_CLI').AsString+'|'+
    //04 COD_PAIS
    AdicionaCharE('0',Tabela.FieldByName('I_COD_PAI').AsString,5)+'|'+
    //05 CNPJ
    DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_CGC_CLI').AsString,'.'),'-'),'/') +'|'+
    //06 CPF
    DeletaChars(DeletaChars(Tabela.FieldByName('C_CPF_CLI').AsString,'.'),'-') +'|'+
    //07 IE
    DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_INS_CLI').AsString,'.'),'-'),'/') +'|';

    //08 COD_MUN
    if (Tabela.FieldByName('C_TIP_PES').AsString = 'E') then
      VpfLinha :=  VpfLinha +'|'
    else
      VpfLinha := VpfLinha + Tabela.FieldByName('I_COD_IBG').AsString+'|';

    VpfLinha := VpfLinha +
    //09 SUFRAMA
    '|'+
    //10 END
    Tabela.FieldByName('C_END_CLI').AsString+'|'+
    //11 END
    Tabela.FieldByName('I_NUM_END').AsString+'|'+
    //12 COMPL
    Tabela.FieldByName('C_COM_END').AsString+'|'+
    //13 BAIRRO
    Tabela.FieldByName('C_BAI_CLI').AsString+'|';

    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0190(VpaDSped: TRBDSpedFiscal);
Var
  vpfLinha : String;
begin
  LocalizaUnidadesMedidasREG0190(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01REG
    '0190|'+
    //02 UNID
    Tabela.FieldByName('C_COD_UNI').AsString+'|'+
    //03 DESCRI
    Tabela.FieldByName('C_NOM_UNI').AsString+'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0200(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : String;
begin
  LocalizaProdutosREG0200(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01 REG
    '0200|' +
    //02 COD_ITEM
    Tabela.FieldByName('I_SEQ_PRO').AsString+'|'+
    //03 DESCR_ITEM
    Tabela.FieldByName('C_NOM_PRO').AsString+'|'+
    //04 COD_BARRAS
    '|'+
    //05 COD_ANT_ITEM
    '|'+
    //06 UNID_INV
    Tabela.FieldByName('C_COD_UNI').AsString+'|'+
    //07 TIPO_ITEM
    AdicionaCharE('0',Tabela.FieldByName('I_DES_PRO').AsString,2)+'|'+
    //08 UNID_INV
    Tabela.FieldByName('C_CLA_FIS').AsString+'|'+
    //09 EX_IPI
    '|'+
    //10 COD_GEN - SAO OS 2 PRIMEIROS CARACTERES DO CODIGO NCM
    copy(Tabela.FieldByName('C_CLA_FIS').AsString,1,2)+ '|'+
    //11 COD_LST
    '|';
    if Tabela.FieldByName('N_RED_ICM').AsFloat <> 0 then
      VpfLinha := VpfLinha + Tabela.FieldByName('N_RED_ICM').Asstring+'|'
    else
      VpfLinha := VpfLinha +FormatFloat('0.00',VpaDSped.PerICMSInterno)  +'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0400(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : string;
begin
  LocalizaNaturezaOperacaoREG0400(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01 REG
    '0400|' +
    //02 COD_NAT
    Tabela.FieldByName('C_COD_NAT').AsString+Tabela.FieldByName('I_SEQ_MOV').AsString+ '|'+
    //03 DESCR_NAT
    Tabela.FieldByName('C_NOM_MOV').AsString+'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBloco0);
  VpaDSped.Arquivo.Add('|0990|'+IntToStr(VpaDSped.QtdLinhasBloco0)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|C001|0|');
  inc(VpaDSped.QtdLinhasBlocoC);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC100(VpaDSped: TRBDSpedFiscal);
begin
  LocalizaNotasFiscaisSaidaRegC100(Tabela,VpaDSped);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraSpedfiscal(VpaDSped: TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
begin
  VpaDSped.Incosistencias.clear;
  VprBarraStatus :=  VpaBarraStatus;
  AtualizaStatus('Carregando os dados da filial');
  Sistema.CarDFilial(VpaDSped.DFilial,VpaDSped.CodFilial);

  AtualizaStatus('Carregando os dados gerais do sped');
  CarDSped(VpaDSped);
  AtualizaStatus('Carregando os dados do contabilista');
  VpaDSped.DContabilidade.CodCliente := VpaDSped.DFilial.CodContabilidade;
  FunClientes.CarDCliente(VpaDSped.DContabilidade);

  VpaDSped.Arquivo.clear;
  AtualizaStatus('Validando as configurações');
  DadosValidos(VpaDSped);
  if VpaDSped.Incosistencias.Count = 0 then
  begin
    AtualizaStatus('Gerando Bloco 0 registro 0000');
    GeraBloco0Registro0000(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0001');
    GeraBloco0Registro0001(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0005');
    GeraBloco0Registro0005(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0100');
    GeraBloco0Registro0100(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0150');
    GeraBloco0Registro0150(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0190');
    GeraBloco0Registro0190(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0200');
    GeraBloco0Registro0200(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0400');
    GeraBloco0Registro0400(VpaDSped);
    AtualizaStatus('Gerando Bloco 0 registro 0990');
    GeraBloco0Registro0990(VpaDSped);
    AtualizaStatus('Gerando Bloco C registro C001');
    GeraBlocoCRegistroC001(VpaDSped);
    AtualizaStatus('Gerando Bloco C registro C001');
    GeraBlocoCRegistroC100(VpaDSped);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaNaturezaOperacaoREG0400(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select MOV.C_COD_NAT, MOV.I_SEQ_MOV, MOV.C_NOM_MOV '+
                               ' FROM MOVNATUREZA MOV '+
                               ' WHERE EXISTS (SELECT * FROM CADNOTAFISCAIS CAD ' +
                               ' WHERE CAD.C_COD_NAT = MOV.C_COD_NAT '+
                               ' AND CAD.I_ITE_NAT = MOV.I_SEQ_MOV '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ')'+
                               ' ORDER BY C_COD_NAT, I_SEQ_MOV ');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaNotasFiscaisSaidaRegC100(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select NAT.C_ENT_SAI, NAT.C_GER_FIN, '+
                               ' CAD.I_COD_CLI, CAD.C_NOT_CAN, CAD.I_SEQ_NOT, CAD.I_NRO_NOT, CAD.C_SER_NOT, CAD.C_CHA_NFE, CAD.D_DAT_EMI, '+
                               ' CAD.D_DAT_SAI, CAD.N_TOT_NOT, CAD.N_VLR_DES, CAD.N_PER_DES, CAD.N_TOT_PRO, CAD.N_TOT_SER, CAD.I_TIP_FRE, '+
                               ' CAD.N_VLR_FRE,  CAD.N_VLR_SEG, CAD.N_OUT_DES, CAD.N_BAS_CAL, CAD.N_VLR_ICM, CAD.N_BAS_SUB, CAD.N_VLR_SUB, '+
                               ' CAD.N_TOT_IPI, '+
                               ' PAG.I_COD_PAG '+
                               ' from MOVNATUREZA NAT, CADNOTAFISCAIS CAD, CADCONDICOESPAGTO PAG '+
                               ' Where CAD.C_COD_NAT = NAT.C_COD_NAT '+
                               ' AND CAD.I_ITE_NAT = NAT.I_SEQ_MOV '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND '+SQLTextoRightJoin('CAD.I_COD_PAG','PAG.I_COD_PAG'));
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaParticipantesREG0150(VpaTabela: TSQL;VpaDSped : TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select CLI.I_COD_CLI,CLI.C_NOM_CLI, CLI.C_TIP_PES, CLI.C_CGC_CLI, ' +
                               ' CLI.C_CPF_CLI, CLI.I_COD_IBG, CLI.I_COD_PAI, CLI.C_INS_CLI, CLI.C_END_CLI, '+
                               ' CLI.I_NUM_END, CLI.C_COM_END, CLI.C_BAI_CLI '+
                               ' FROM CADCLIENTES CLI '+
                               ' WHERE EXISTS (SELECT * FROM CADNOTAFISCAIS CAD '+
                               ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               '  ) ');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaProdutosREG0200(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, PRO.I_DES_PRO, PRO.C_CLA_FIS, ' +
                               ' PRO.N_RED_ICM '+
                               ' FROM CADPRODUTOS PRO '+
                               ' WHERE EXISTS (SELECT * FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV '+
                               ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                               '  )');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaUnidadesMedidasREG0190(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select UNI.C_COD_UNI, UNI.C_NOM_UNI ' +
                               ' FROM CADUNIDADE UNI '+
                               ' WHERE EXISTS (SELECT * FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV '+
                               ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOV.C_COD_UNI = UNI.C_COD_UNI'+
                               '  )'+
                               ' or exists(SELECT * FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV, CADPRODUTOS PRO '+
                               ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               ' AND PRO.C_COD_UNI = UNI.C_COD_UNI'+
                               '  )' );
end;

end.
