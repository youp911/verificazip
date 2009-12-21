Unit UnSpedFiscal;

Interface

Uses Classes, DBTables, UnDados,SysUtils, Unsistema, comCtrls, Unclientes, Tabela,SqlExpr, UnDadosProduto;

//classe localiza
Type TRBLocalizaSpedFiscal = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesSpedFiscal = class(TRBLocalizaSpedFiscal)
  private
    Tabela,
    Tabela2,
    Tabela3 : TSQL;
    VprBarraStatus : TStatusBar;
    procedure ZeraQtdLinhas(VpaDSped : TRBDSpedFiscal);
    procedure AtualizaStatus(VpaTexto : String);
    procedure LocalizaParticipantesREG0150(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaTransportadorasREG0150(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaUnidadesMedidasREG0190(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaProdutosREG0200(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaNaturezaOperacaoREG0400(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaNotasFiscaisSaidaRegC100(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaNotasFiscaisEntradaRegC100(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal);
    procedure LocalizaProdutosNotafiscalSaidaRegC170(VpaTabela : TSQL;VpaCodFilial, VpaSeqNota : Integer);
    function RBaseCalculoICMSRegitroC170Saida(VpaValTotProdutos : Double;VpaDNatureza : TRBDNaturezaOperacao) : double;
    function RAliquotaICMSRegitroC170Saida(VpaPerICMS : Double;VpaDNatureza : TRBDNaturezaOperacao) : double;
    function RValICMSRegitroC170Saida(VpaValTotProdutos,VpaPerICMS : Double;VpaDNatureza : TRBDNaturezaOperacao) : double;
    function DadosValidos(VpaDSped : TRBDSpedFiscal) : string;
    procedure DadosValidosParticipantesREG0150(VpaDSped : TRBDSpedFiscal);
    procedure DadosValidosTransportadorasREG0150(VpaDSped : TRBDSpedFiscal);
    procedure DadosValidosProdutosREG0200(VpaDSped : TRBDSpedFiscal);
    procedure CarDRegistroC190Saida(VpaTabela : TSQL;VpaDSped : TRBDSpedFiscal;VpaDNatureza : TRBDNaturezaOperacao;VpaCodCFOP, VpaCodCST :String);
    procedure GeraBloco0Registro0000(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0005(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0100(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0150(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0150Transportadoras(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0190(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0200(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0400(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco0Registro0990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC100Entrada(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC100Saida(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC140Saida(VpaCodFilial,VpaSeqNota : Integer;VpadSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC141Saida(VpaCodFilial,VpaLanReceber : Integer;VpadSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC160Saida(VpaTabela : TSql;VpadSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC170Saida(VpaCodFilial,VpaSeqNota, VpaCodCliente : Integer;VpaCodCFOP : String;VpaSeqNatureza : Integer;VpadSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC190(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoCRegistroC990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoDRegistroD001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoDRegistroD990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE100(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE110(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoERegistroE990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoHRegistroH001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoHRegistroH990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoHRegistro1001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBlocoHRegistro1990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco9Registro9001(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco9Registro9900(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco9Registro9990(VpaDSped : TRBDSpedFiscal);
    procedure GeraBloco9Registro9999(VpaDSped : TRBDSpedFiscal);
    procedure CarDSped(VpadSped : TRBDSpedFiscal);
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    procedure GeraSpedfiscal(VpaDSped : TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
end;



implementation

Uses FunSql, Constantes, funString, funvalida, UnNotafiscal, FunObjeto, UnProdutos;

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
procedure TRBFuncoesSpedFiscal.CarDRegistroC190Saida(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal;VpaDNatureza : TRBDNaturezaOperacao; VpaCodCFOP, VpaCodCST :String);
Var
  VpfDRegistroC190 :TRBDSpedfiscalRegistroC190;
begin
  VpfDRegistroC190 := VpaDSped.RRegistroC190(VpaCodCST,StrToInt(VpaCodCFOP),VpaTabela.FieldByName('N_PER_ICM').AsFloat);
  VpfDRegistroC190.ValOperacao := VpfDRegistroC190.ValOperacao + VpaTabela.FieldByName('N_TOT_PRO').AsFloat;
  if VpaDNatureza.IndCalcularICMS  then
    VpfDRegistroC190.ValBaseCalculoICMS := VpfDRegistroC190.ValBaseCalculoICMS + VpaTabela.FieldByName('N_TOT_PRO').AsFloat;
  VpfDRegistroC190.ValICMS := VpfDRegistroC190.ValICMS + VpaTabela.FieldByName('N_TOT_PRO').AsFloat *(VpaTabela.FieldByName('N_PER_ICM').AsFloat/100);
  VpfDRegistroC190.ValBaseCalculoICMSSubstituica := 0;
  VpfDRegistroC190.ValICMSSubstituicao := 0;
  VpfDRegistroC190.ValReducaBaseCalculo := 0;
  VpfDRegistroC190.ValIPI := VpfDRegistroC190.ValIPI + VpaTabela.FieldByName('N_VLR_IPI').AsFloat;
end;

{********************************************************************************}
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
  Tabela2 :=  TSQL.create(nil);
  Tabela2.ASQlConnection := VpaBaseDados;
  Tabela3 :=  TSQL.create(nil);
  Tabela3.ASQlConnection := VpaBaseDados;
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

  AtualizaStatus('Validando os dados dos participantes');
  DadosValidosParticipantesREG0150(VpaDSped);
  AtualizaStatus('Validando os dados das transportadoras');
  DadosValidosTransportadorasREG0150(VpaDSped);
  AtualizaStatus('Validando os dados dos produtos');
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
      VpaDSped.Incosistencias.add('PRODUTO INVÁLIDO "'+Tabela.FieldByName('C_COD_PRO').AsString+'-'+Tabela.FieldByName('C_NOM_PRO').AsString+'" - Falta o codigo NCM/Classificação fiscal')
    else
      if length(Deletachars(Tabela.FieldByName('C_CLA_FIS').AsString,'.')) <> 8 then
        VpaDSped.Incosistencias.add('PRODUTO INVÁLIDO "'+Tabela.FieldByName('C_COD_PRO').AsString+'-'+Tabela.FieldByName('C_NOM_PRO').AsString+'" - O tamanho do codigo NCM/Classificação fiscal é diferente de 8 caracteres');
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.DadosValidosTransportadorasREG0150(VpaDSped: TRBDSpedFiscal);
begin
  LocalizaTransportadorasREG0150(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    if Tabela.FieldByName('I_COD_PAI').AsInteger = 0 then
      VpaDSped.Incosistencias.add('TRANSPORTADORA INVÁLIDA "'+Tabela.FieldByName('I_COD_TRA').AsString+'-'+Tabela.FieldByName('C_NOM_TRA').AsString+'" - Falta o codigo IBGE do pais');
    if (Tabela.FieldByName('I_COD_IBG').AsInteger = 0)Then
      VpaDSped.Incosistencias.add('TRANSPORTADORA INVÁLIDO "'+Tabela.FieldByName('I_COD_TRA').AsString+'-'+Tabela.FieldByName('C_NOM_TRA').AsString+'" - Falta o codigo IBGE do municipio');
    if not VerificaCGC(Tabela.FieldByName('C_CGC_TRA').AsString) then
      VpaDSped.Incosistencias.add('TRANSPORTADORA INVÁLIDO "'+Tabela.FieldByName('I_COD_TRA').AsString+'-'+Tabela.FieldByName('C_NOM_TRA').AsString+'" - CGC INVALIDO');
    if Tabela.FieldByName('C_END_TRA').AsString = '' then
      VpaDSped.Incosistencias.add('TRANSPORTADORA INVÁLIDO "'+Tabela.FieldByName('I_COD_TRA').AsString+'-'+Tabela.FieldByName('C_NOM_TRA').AsString+'" - Endereco não preenchido');
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
destructor TRBFuncoesSpedFiscal.destroy;
begin
  Tabela.close;
  Tabela.free;
  Tabela2.close;
  Tabela2.free;
  Tabela3.close;
  Tabela3.free;
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
  DeletaEspacoDE(VpaDSped.DFilial.NomFantasia)+'|'+
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
    DeletaEspacoDE(Tabela.FieldByName('C_NOM_CLI').AsString)+'|'+
    //04 COD_PAIS
    AdicionaCharE('0',Tabela.FieldByName('I_COD_PAI').AsString,5)+'|'+
    //05 CNPJ
    DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_CGC_CLI').AsString,'.'),'-'),'/') +'|'+
    //06 CPF
    DeletaEspaco(DeletaChars(DeletaChars(Tabela.FieldByName('C_CPF_CLI').AsString,'.'),'-')) +'|';
    //07 IE
    if DeletaEspaco(Tabela.FieldByName('C_INS_CLI').AsString) <> 'ISENTO' then
      VpfLinha := VpfLinha + DeletaEspacoDE(DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_INS_CLI').AsString,'.'),'-'),'/')) +'|'
    else
      VpfLinha := VpfLinha + '|';

    //08 COD_MUN
    if (Tabela.FieldByName('C_TIP_PES').AsString = 'E') then
      VpfLinha :=  VpfLinha +'|'
    else
      VpfLinha := VpfLinha + Tabela.FieldByName('I_COD_IBG').AsString+'|';

    VpfLinha := VpfLinha +
    //09 SUFRAMA
    '|'+
    //10 END
    DeletaEspacoDE(Tabela.FieldByName('C_END_CLI').AsString)+'|'+
    //11 END
    Tabela.FieldByName('I_NUM_END').AsString+'|'+
    //12 COMPL
    DeletaEspacoDE(Tabela.FieldByName('C_COM_END').AsString)+'|'+
    //13 BAIRRO
    DeletaEspacoDE(Tabela.FieldByName('C_BAI_CLI').AsString)+'|';

    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0150);
    Tabela.next;
  end;
  Tabela.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco0Registro0150Transportadoras(VpaDSped: TRBDSpedFiscal);
var
  VpfLinha : String;
begin
  LocalizaTransportadorasREG0150(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    VpfLinha := '|'+
    //01 REG
    '0150|'+
    //02 COD_PART
    Tabela.FieldByName('I_COD_TRA').AsString+'T|'+
    //03 nome
    DeletaEspacoDE(Tabela.FieldByName('C_NOM_TRA').AsString)+'|'+
    //04 COD_PAIS
    AdicionaCharE('0',Tabela.FieldByName('I_COD_PAI').AsString,5)+'|'+
    //05 CNPJ
    DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_CGC_TRA').AsString,'.'),'-'),'/') +'|'+
    //06 CPF
    '|'+
    //07 IE
    DeletaEspacoDE(DeletaChars(DeletaChars(DeletaChars(Tabela.FieldByName('C_INS_TRA').AsString,'.'),'-'),'/')) +'|';

    //08 COD_MUN
    VpfLinha := VpfLinha + Tabela.FieldByName('I_COD_IBG').AsString+'|';

    VpfLinha := VpfLinha +
    //09 SUFRAMA
    '|'+
    //10 END
    DeletaEspacoDE(Tabela.FieldByName('C_END_TRA').AsString)+'|'+
    //11 END
    Tabela.FieldByName('I_NUM_TRA').AsString+'|'+
    //12 COMPL
    '|'+
    //13 BAIRRO
    DeletaEspacoDE(Tabela.FieldByName('C_BAI_TRA').AsString)+'|';

    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0150);
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
    inc(VpaDSped.QtdLinhasRegistro0190);
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
    DeletaEspacoDE(Tabela.FieldByName('C_NOM_PRO').AsString)+'|'+
    //04 COD_BARRAS
    '|'+
    //05 COD_ANT_ITEM
    '|'+
    //06 UNID_INV
    Tabela.FieldByName('C_COD_UNI').AsString+'|'+
    //07 TIPO_ITEM
    AdicionaCharE('0',Tabela.FieldByName('I_DES_PRO').AsString,2)+'|'+
    //08 CODIGO NCM
    DeletaChars(Tabela.FieldByName('C_CLA_FIS').AsString,'.')+'|'+
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
    inc(VpaDSped.QtdLinhasRegistro0200);
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
    DeletaEspacoDE(Tabela.FieldByName('C_NOM_MOV').AsString)+'|';
    VpaDSped.Arquivo.Add(VpfLinha);
    inc(VpaDSped.QtdLinhasBloco0);
    inc(VpaDSped.QtdLinhasRegistro0400);
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
procedure TRBFuncoesSpedFiscal.GeraBloco9Registro9001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|9001|0|');
  inc(VpaDSped.QtdLinhasBloco9);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco9Registro9900(VpaDSped: TRBDSpedFiscal);
Var
  VpfLinhaInicial : Integer;
begin
  VpfLinhaInicial := VpaDSped.Arquivo.Count;
  VpaDSped.Arquivo.Add('|9900|0000|1|');
  VpaDSped.Arquivo.Add('|9900|0001|1|');
  VpaDSped.Arquivo.Add('|9900|0005|1|');
  VpaDSped.Arquivo.Add('|9900|0100|1|');
  VpaDSped.Arquivo.Add('|9900|0150|'+IntToStr(VpaDSped.QtdLinhasRegistro0150)+'|');
  VpaDSped.Arquivo.Add('|9900|0190|'+IntToStr(VpaDSped.QtdLinhasRegistro0190)+'|');
  VpaDSped.Arquivo.Add('|9900|0200|'+IntToStr(VpaDSped.QtdLinhasRegistro0200)+'|');
  VpaDSped.Arquivo.Add('|9900|0400|'+IntToStr(VpaDSped.QtdLinhasRegistro0400)+'|');
  VpaDSped.Arquivo.Add('|9900|0990|1|');
  VpaDSped.Arquivo.Add('|9900|C001|1|');
  VpaDSped.Arquivo.Add('|9900|C100|'+IntToStr(VpaDSped.QtdLinhasRegistroC100)+'|');
  VpaDSped.Arquivo.Add('|9900|C140|'+IntToStr(VpaDSped.QtdLinhasRegistroC140)+'|');
  VpaDSped.Arquivo.Add('|9900|C141|'+IntToStr(VpaDSped.QtdLinhasRegistroC141)+'|');
  VpaDSped.Arquivo.Add('|9900|C160|'+IntToStr(VpaDSped.QtdLinhasRegistroC160)+'|');
  VpaDSped.Arquivo.Add('|9900|C170|'+IntToStr(VpaDSped.QtdLinhasRegistroC170)+'|');
  VpaDSped.Arquivo.Add('|9900|C190|'+IntToStr(VpaDSped.QtdLinhasRegistroC190)+'|');
  VpaDSped.Arquivo.Add('|9900|C990|1|');
  VpaDSped.Arquivo.Add('|9900|D001|1|');
  VpaDSped.Arquivo.Add('|9900|D990|1|');
  VpaDSped.Arquivo.Add('|9900|E001|1|');
  VpaDSped.Arquivo.Add('|9900|E100|1|');
  VpaDSped.Arquivo.Add('|9900|E110|1|');
  VpaDSped.Arquivo.Add('|9900|E990|1|');
  VpaDSped.Arquivo.Add('|9900|H001|1|');
  VpaDSped.Arquivo.Add('|9900|H990|1|');
  VpaDSped.Arquivo.Add('|9900|1001|1|');
  VpaDSped.Arquivo.Add('|9900|1990|1|');
  VpaDSped.Arquivo.Add('|9900|9001|1|');
  VpaDSped.QtdLinhasBloco9 := VpaDSped.Arquivo.Count - VpfLinhaInicial+3;
  VpaDSped.Arquivo.Add('|9900|9900|'+Inttostr(VpaDSped.QtdLinhasBloco9)+'|');
  VpaDSped.Arquivo.Add('|9900|9990|1|');
  VpaDSped.Arquivo.Add('|9900|9999|1|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco9Registro9990(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|9990|'+IntToStr(VpaDSped.QtdLinhasBloco9+3)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBloco9Registro9999(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|9999|'+IntToStr(VpaDSped.Arquivo.Count +1)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|C001|0|');
  inc(VpaDSped.QtdLinhasBlocoC);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC100Entrada(VpaDSped: TRBDSpedFiscal);
Var
  VpfLinha : String;
  VpfIndPagamentoAVista : Boolean;
begin
  LocalizaNotasFiscaisSaidaRegC100(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    AtualizaStatus('Gerando Bloco C registro C100 - Nota Fiscal "'+    Tabela.FieldByName('I_NRO_NOT').AsString+'"');
    VpfIndPagamentoAVista := (Tabela.FieldByName('I_COD_PAG').AsInteger = varia.CondPagtoVista);
    if Tabela.FieldByName('C_CHA_NFE').AsString <> '' then
      VpaDSped.CodModeloDocumento := 55
    else
      VpaDSped.CodModeloDocumento := 1;

    VpfLinha := '|'+
    //01 REG
    'C100|';
    //02 IND_OPER
    if Tabela.FieldByName('C_ENT_SAI').AsString = 'E' then
      VpfLinha := VpfLinha +'0|' //entrada
    else
      VpfLinha := VpfLinha +'1|'; //saida;
    //03 IND_EMIT
    VpfLinha := VpfLinha + '0|'+
    //04 COD_PART
    Tabela.FieldByName('I_COD_CLI').AsString+'|'+
    //05 COD_MOD
    AdicionaCharE('0',IntToStr(VpaDSped.CodModeloDocumento),2)+'|';
    //06 COD_SIT
    if Tabela.FieldByName('C_NOT_CAN').AsString = 'S' then
      VpfLinha := VpfLinha + '02|'
    else
      VpfLinha := VpfLinha + '00|';
    // 07 SER
    VpfLinha := VpfLinha + Tabela.FieldByName('C_SER_NOT').AsString+ '|'+
    //08 NUM_DOC
    Tabela.FieldByName('I_NRO_NOT').AsString+'|'+
    //09 CHV_NFE
    Tabela.FieldByName('C_CHA_NFE').AsString+'|'+
    //10 DT_DOC
    FormatDateTime('DDMMYYYY', Tabela.FieldByName('D_DAT_EMI').AsDatetime)+'|'+
    //11 DT_SAI
    FormatDateTime('DDMMYYYY', Tabela.FieldByName('D_DAT_SAI').AsDatetime)+'|'+
    //12 VL_DOC
    FormatFloat('0.00',Tabela.FieldByName('N_TOT_NOT').AsFloat)+'|';
    //13 IND_PGTO
    if Tabela.FieldByName('C_GER_FIN').AsString = 'S' then
    begin
      if VpfIndPagamentoAVista then
        VpfLinha := VpfLinha + '0|'
      else
        VpfLinha := VpfLinha + '1|';
    end
    else
      VpfLinha := VpfLinha + '9|';
    //14 VL_DESC
    if (Tabela.FieldByName('N_PER_DES').AsFloat > 0) then
      VpfLinha := VpfLinha + FormatFloat('0.00',((Tabela.FieldByName('N_TOT_PRO').AsFloat+Tabela.FieldByName('N_TOT_SER').AsFloat)*Tabela.FieldByName('N_PER_DES').AsFloat)/100)+'|'
    else
      if (Tabela.FieldByName('N_VLR_DES').AsFloat > 0) then
        VpfLinha := VpfLinha + FormatFloat('0.00',Tabela.FieldByName('N_VLR_DES').AsFloat)+'|'
      else
        VpfLinha := VpfLinha +'0,00|';
    //15 VL_ABAT_NT
    VpfLinha := VpfLinha+ '0,00|'+
    //16 VL_MERC
    FormatFloat('0.00',Tabela.FieldByName('N_TOT_PRO').AsFloat+Tabela.FieldByName('N_TOT_SER').AsFloat)+'|';
    //17 IND_FRT
    if Tabela.FieldByName('N_VLR_FRE').AsFloat > 0 then
      vpfLinha := VpfLinha +Tabela.FieldByName('I_TIP_FRE').AsString+ '|'
    else
      vpfLinha := VpfLinha +'9|';
    //18 VL_FRT
    VpfLinha := VpfLinha+ FormatFloat('0.00',Tabela.FieldByName('N_VLR_FRE').AsFloat)+'|'+
    //19 VL_SEG
    FormatFloat('0.00',Tabela.FieldByName('N_VLR_SEG').AsFloat)+'|';
    //20 VL_OUT_DA
    if (Tabela.FieldByName('N_PER_DES').AsFloat < 0) then
      VpfLinha := VpfLinha + FormatFloat('0.00',(((Tabela.FieldByName('N_TOT_PRO').AsFloat+Tabela.FieldByName('N_TOT_SER').AsFloat)*(Tabela.FieldByName('N_PER_DES').AsFloat*-1))/100)+Tabela.FieldByName('N_OUT_DES').AsFloat)+'|'
    else
      if (Tabela.FieldByName('N_VLR_DES').AsFloat < 0) then
        VpfLinha := VpfLinha + FormatFloat('0.00',(Tabela.FieldByName('N_VLR_DES').AsFloat*-1)+Tabela.FieldByName('N_OUT_DES').AsFloat)+'|'
      else
        VpfLinha :=VpfLinha + FormatFloat('0.00',Tabela.FieldByName('N_OUT_DES').AsFloat)+'|';
    //21 VL_BC_ICMS
    VpfLinha := VpfLinha + FormatFloat('0.00',Tabela.FieldByName('N_BAS_CAL').AsFloat)+'|'+
    //22 VL_ICMS
    FormatFloat('0.00',Tabela.FieldByName('N_VLR_ICM').AsFloat)+'|'+
    //23 VL_BC_ICMS_ST
    FormatFloat('0.00',Tabela.FieldByName('N_BAS_SUB').AsFloat)+'|'+
    //24 VL_ICMS_ST
    FormatFloat('0.00',Tabela.FieldByName('N_VLR_SUB').AsFloat)+'|'+
    //25 VL_IPI
    FormatFloat('0.00',Tabela.FieldByName('N_TOT_IPI').AsFloat)+'|'+
    //26 VL_PIS
    FormatFloat('0.00',0)+'|'+
    //27 VL_COFINS
    FormatFloat('0.00',0)+'|'+
    //28 VL_PIS_ST
    FormatFloat('0.00',0)+'|'+
    //29 VL_COFINS_ST
    FormatFloat('0.00',0)+'|';

    VpaDSped.Arquivo.add(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC100);
    if VpaDSped.CodModeloDocumento = 1 then
    begin
      GeraBlocoCRegistroC140Saida(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_SEQ_NOT').AsInteger,VpaDSped);
      GeraBlocoCRegistroC160Saida(Tabela,VpaDSped);
    end;
    GeraBlocoCRegistroC170Saida(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_SEQ_NOT').AsInteger,Tabela.FieldByName('I_COD_CLI').AsInteger,Tabela.FieldByName('C_COD_NAT').AsString,Tabela.FieldByName('I_ITE_NAT').AsInteger,VpaDSped);
    GeraBlocoCRegistroC190(VpaDSped);

    Tabela.next;
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC100Saida(VpaDSped: TRBDSpedFiscal);
Var
  VpfLinha : String;
  VpfIndPagamentoAVista : Boolean;
begin
  LocalizaNotasFiscaisSaidaRegC100(Tabela,VpaDSped);
  while not Tabela.eof do
  begin
    AtualizaStatus('Gerando Bloco C registro C100 - Nota Fiscal "'+    Tabela.FieldByName('I_NRO_NOT').AsString+'"');
    VpfIndPagamentoAVista := (Tabela.FieldByName('I_COD_PAG').AsInteger = varia.CondPagtoVista);
    if Tabela.FieldByName('C_CHA_NFE').AsString <> '' then
      VpaDSped.CodModeloDocumento := 55
    else
      VpaDSped.CodModeloDocumento := 1;

    VpfLinha := '|'+
    //01 REG
    'C100|';
    //02 IND_OPER
    if Tabela.FieldByName('C_ENT_SAI').AsString = 'E' then
      VpfLinha := VpfLinha +'0|' //entrada
    else
      VpfLinha := VpfLinha +'1|'; //saida;
    //03 IND_EMIT
    VpfLinha := VpfLinha + '0|';
    //04 COD_PART
    if Tabela.FieldByName('C_NOT_CAN').AsString = 'S' then
      vpfLinha := VpfLinha +'|'
    else
      vpfLinha := VpfLinha + Tabela.FieldByName('I_COD_CLI').AsString+'|';
    VpfLinha := vpflinha +
    //05 COD_MOD
    AdicionaCharE('0',IntToStr(VpaDSped.CodModeloDocumento),2)+'|';
    //06 COD_SIT
    if Tabela.FieldByName('C_NOT_CAN').AsString = 'S' then
      VpfLinha := VpfLinha + '02|'
    else
      VpfLinha := VpfLinha + '00|';
    // 07 SER
    VpfLinha := VpfLinha + Tabela.FieldByName('C_SER_NOT').AsString+ '|'+
    //08 NUM_DOC
    Tabela.FieldByName('I_NRO_NOT').AsString+'|';
    if Tabela.FieldByName('C_NOT_CAN').AsString = 'S' then
      VpfLinha := VpfLinha + AdicionaCharD('|','',21)
    else
    begin
      VpfLinha := VpfLinha +
      //09 CHV_NFE
      Tabela.FieldByName('C_CHA_NFE').AsString+'|'+
      //10 DT_DOC
      FormatDateTime('DDMMYYYY', Tabela.FieldByName('D_DAT_EMI').AsDatetime)+'|'+
      //11 DT_SAI
      FormatDateTime('DDMMYYYY', Tabela.FieldByName('D_DAT_SAI').AsDatetime)+'|'+
      //12 VL_DOC
      FormatFloat('0.00',Tabela.FieldByName('N_TOT_NOT').AsFloat)+'|';
      //13 IND_PGTO
      if Tabela.FieldByName('C_GER_FIN').AsString = 'S' then
      begin
        if VpfIndPagamentoAVista then
          VpfLinha := VpfLinha + '0|'
        else
          VpfLinha := VpfLinha + '1|';
      end
      else
        VpfLinha := VpfLinha + '9|';
      //14 VL_DESC
      if (Tabela.FieldByName('N_PER_DES').AsFloat > 0) then
        VpfLinha := VpfLinha + FormatFloat('0.00',((Tabela.FieldByName('N_TOT_PRO').AsFloat+Tabela.FieldByName('N_TOT_SER').AsFloat)*Tabela.FieldByName('N_PER_DES').AsFloat)/100)+'|'
      else
        if (Tabela.FieldByName('N_VLR_DES').AsFloat > 0) then
          VpfLinha := VpfLinha + FormatFloat('0.00',Tabela.FieldByName('N_VLR_DES').AsFloat)+'|'
        else
          VpfLinha := VpfLinha +'0,00|';
      //15 VL_ABAT_NT
      VpfLinha := VpfLinha+ '0,00|'+
      //16 VL_MERC
      FormatFloat('0.00',Tabela.FieldByName('N_TOT_PRO').AsFloat+Tabela.FieldByName('N_TOT_SER').AsFloat)+'|';
      //17 IND_FRT
      if Tabela.FieldByName('N_VLR_FRE').AsFloat > 0 then
        vpfLinha := VpfLinha +Tabela.FieldByName('I_TIP_FRE').AsString+ '|'
      else
        vpfLinha := VpfLinha +'9|';
      //18 VL_FRT
      VpfLinha := VpfLinha+ FormatFloat('0.00',Tabela.FieldByName('N_VLR_FRE').AsFloat)+'|'+
      //19 VL_SEG
      FormatFloat('0.00',Tabela.FieldByName('N_VLR_SEG').AsFloat)+'|';
      //20 VL_OUT_DA
      if (Tabela.FieldByName('N_PER_DES').AsFloat < 0) then
        VpfLinha := VpfLinha + FormatFloat('0.00',(((Tabela.FieldByName('N_TOT_PRO').AsFloat+Tabela.FieldByName('N_TOT_SER').AsFloat)*(Tabela.FieldByName('N_PER_DES').AsFloat*-1))/100)+Tabela.FieldByName('N_OUT_DES').AsFloat)+'|'
      else
        if (Tabela.FieldByName('N_VLR_DES').AsFloat < 0) then
          VpfLinha := VpfLinha + FormatFloat('0.00',(Tabela.FieldByName('N_VLR_DES').AsFloat*-1)+Tabela.FieldByName('N_OUT_DES').AsFloat)+'|'
        else
          VpfLinha :=VpfLinha + FormatFloat('0.00',Tabela.FieldByName('N_OUT_DES').AsFloat)+'|';
      //21 VL_BC_ICMS
      VpfLinha := VpfLinha + FormatFloat('0.00',Tabela.FieldByName('N_BAS_CAL').AsFloat)+'|'+
      //22 VL_ICMS
      FormatFloat('0.00',Tabela.FieldByName('N_VLR_ICM').AsFloat)+'|'+
      //23 VL_BC_ICMS_ST
      FormatFloat('0.00',Tabela.FieldByName('N_BAS_SUB').AsFloat)+'|'+
      //24 VL_ICMS_ST
      FormatFloat('0.00',Tabela.FieldByName('N_VLR_SUB').AsFloat)+'|'+
      //25 VL_IPI
      FormatFloat('0.00',Tabela.FieldByName('N_TOT_IPI').AsFloat)+'|'+
      //26 VL_PIS
      FormatFloat('0.00',0)+'|'+
      //27 VL_COFINS
      FormatFloat('0.00',0)+'|'+
      //28 VL_PIS_ST
      FormatFloat('0.00',0)+'|'+
      //29 VL_COFINS_ST
      FormatFloat('0.00',0)+'|';
    end;

    VpaDSped.Arquivo.add(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC100);
    if Tabela.FieldByName('C_NOT_CAN').AsString = 'N' then
    begin
      if VpaDSped.CodModeloDocumento = 1 then
      begin
        GeraBlocoCRegistroC140Saida(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_SEQ_NOT').AsInteger,VpaDSped);
        GeraBlocoCRegistroC160Saida(Tabela,VpaDSped);
      end;
      GeraBlocoCRegistroC170Saida(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_SEQ_NOT').AsInteger,Tabela.FieldByName('I_COD_CLI').AsInteger,Tabela.FieldByName('C_COD_NAT').AsString,Tabela.FieldByName('I_ITE_NAT').AsInteger,VpaDSped);
      GeraBlocoCRegistroC190(VpaDSped);
    end;

    Tabela.next;
  end;

end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC140Saida(VpaCodFilial, VpaSeqNota: Integer; VpadSped: TRBDSpedFiscal);
Var
  VpfLinha : String;
begin
  AdicionaSQLAbreTabela(Tabela2,'Select CAD.I_EMP_FIL, CAD.I_LAN_REC, CAD.I_NRO_NOT, CAD.I_QTD_PAR, CAD.N_VLR_TOT '+
                                ' FROM CADCONTASARECEBER CAD '+
                                ' WHERE I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                ' AND I_SEQ_NOT = ' +IntToStr(VpaSeqNota));
  while not Tabela2.Eof do
  begin
    AtualizaStatus('Gerando Bloco C registro C140 - Nota Fiscal "'+    Tabela.FieldByName('I_NRO_NOT').AsString+'"');
    VpfLinha :=
    //01 REG
    '|C140|'+
    //02 IND_EMIT
    '0|'+
    //03 IND_TIT
    '00|'+
    //04 DESC_TIT
    '|'+
    //05 NUM_TIT
    Tabela2.FieldByName('I_NRO_NOT').AsString +'|'+
    //06 QTD PARC
    Tabela2.FieldByName('I_QTD_PAR').AsString +'|'+
    //07 VL TIT
    FormatFloat('0.00',Tabela2.FieldByName('N_VLR_TOT').AsFloat)+'|';

    VpadSped.Arquivo.Add(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC140);

    GeraBlocoCRegistroC141Saida(Tabela2.FieldByName('I_EMP_FIL').AsInteger,Tabela2.FieldByName('I_LAN_REC').AsInteger,VpadSped);
    Tabela2.next;
  end;
  Tabela2.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC141Saida(VpaCodFilial, VpaLanReceber: Integer; VpadSped: TRBDSpedFiscal);
Var
  VpfLinha : String;
begin
  AdicionaSQLAbreTabela(Tabela3,'Select MOV.I_NRO_PAR, MOV.N_VLR_PAR, MOV.D_DAT_VEN '+
                                ' FROM MOVCONTASARECEBER MOV '+
                                ' Where MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                ' AND MOV.I_LAN_REC = '+IntToStr(VpaLanReceber)+
                                ' ORDER BY MOV.I_NRO_PAR');
  while not Tabela3.Eof do
  begin
    AtualizaStatus('Gerando Bloco C registro C100 - Nota Fiscal "'+    Tabela.FieldByName('I_NRO_NOT').AsString+'"');
    VpfLinha :=
    //01 REG
    '|C141|'+
    //02 NUM PARC
    Tabela3.FieldByName('I_NRO_PAR').AsString +'|'+
    //03 DT_VCTO
    FormatDateTime('DDMMYYYY',Tabela3.FieldByName('D_DAT_VEN').AsDateTime)+'|'+
    //04 VL PARCTIT
    FormatFloat('0.00',Tabela3.FieldByName('N_VLR_PAR').AsFloat)+'|';

    VpadSped.Arquivo.Add(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC141);

    Tabela3.next;
  end;
  Tabela3.close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC160Saida(VpaTabela: TSql; VpadSped: TRBDSpedFiscal);
var
  VpfLinha : String;
begin
  VpfLinha :=
  //01 reg
  '|C160|';
  //02 COD PART
  if VpaTabela.FieldByName('C_IND_PRO').AsString = 'N' then
    VpfLinha := VpfLinha +  VpaTabela.FieldByName('I_COD_TRA').AsString+'T|'
  else
    VpfLinha := VpfLinha +  '|';
  //03 VEIC_ID
  VpfLinha := VpfLinha + DeletaEspaco(VpaTabela.FieldByName('C_NRO_PLA').AsString)+'|'+
  //04 QTD_VOL
  FormatFloat('0',VpaTabela.FieldByName('I_QTD_VOL').AsFloat)+'|'+
  //05 PESO_BRT
  FormatFloat('0.00',VpaTabela.FieldByName('N_PES_BRU').AsFloat)+'|'+
  //06 PESO_LIQ
  FormatFloat('0.00',VpaTabela.FieldByName('N_PES_LIQ').AsFloat)+'|'+
  //07 UF_ID
  VpaTabela.FieldByName('C_EST_PLA').AsString+'|';

  VpadSped.Arquivo.add(VpfLinha);
  inc(VpadSped.QtdLinhasBlocoC);
  Inc(VpaDSped.QtdLinhasRegistroC160);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC170Saida(VpaCodFilial, VpaSeqNota, VpaCodCliente: Integer; VpaCodCFOP : String;VpaSeqNatureza : Integer; VpadSped: TRBDSpedFiscal);
Var
  VpfLinha, VpfCodCST : String;
  VpfDProduto : TRBDProduto;
  VpfDNatureza : TRBDNaturezaOperacao;
  VpfDCliente : TRBDCliente;
begin
  FreeTObjectsList(VpadSped.RegistroC190);
  VpfDNatureza :=  TRBDNaturezaOperacao.cria;
  FunNotaFiscal.CarDNaturezaOperacao(VpfDNatureza,VpaCodCFOP,VpaSeqNatureza);
  VpfDCliente := TRBDCliente.cria;
  VpfDCliente.CodCliente := VpaCodCliente;
  FunClientes.CarDCliente(VpfDCliente);
  LocalizaProdutosNotafiscalSaidaRegC170(Tabela2,VpaCodFilial,VpaSeqNota);
  while not Tabela2.eof do
  begin
    VpfDProduto := TRBDProduto.cria;
    FunProdutos.CarDProduto(VpfDProduto,varia.codigoempresa,Tabela2.FieldByName('I_EMP_FIL').AsInteger,Tabela2.FieldByName('I_SEQ_PRO').AsInteger);
    VpfCodCST := FunNotaFiscal.RCSTICMSProduto(VpfDCliente,VpfDProduto,VpfDNatureza);
    VpfLinha :=
    //01 REG
    '|C170|'+
    //02 NUM ITEM
    Tabela2.FieldByName('I_SEQ_MOV').AsString+'|'+
    //03 COD ITEM
    Tabela2.FieldByName('I_SEQ_PRO').AsString+'|'+
    //04 DESCR CMPL
    '|'+
    //05 QTD
    FormatFloat('0.00000',Tabela2.FieldByName('N_QTD_PRO').AsFloat)+ '|'+
    //06 UNID
    Tabela2.FieldByName('C_COD_UNI').AsString + '|'+
    //07 VL ITEM
    FormatFloat('0.00',Tabela2.FieldByName('N_TOT_PRO').AsFloat)+ '|'+
    //08 VL DESC
    FormatFloat('0.00',0)+ '|'+
    //09 IND MOV
     '0|'+
    //10 CST_ICMS
    AdicionaCharD('0',VpfCodCST,3)+'|'+
    //11 CFOP
    VpaCodCFOP+'|'+
    //12 COD NAT
    VpaCodCFOP+ IntToStr(VpaSeqNatureza)+'|'+
    //13 VL BC ICMS
    FormatFloat('0.00',RBaseCalculoICMSRegitroC170Saida(Tabela2.FieldByName('N_TOT_PRO').AsFloat,VpfDNatureza))+ '|'+
    //14 ALIQ ICMS
    FormatFloat('0.00',RAliquotaICMSRegitroC170Saida(Tabela2.FieldByName('N_PER_ICM').AsFloat,VpfDNatureza))+ '|'+
    //15 VL ICMS
    FormatFloat('0.00',RValICMSRegitroC170Saida(Tabela2.FieldByName('N_TOT_PRO').AsFloat,Tabela2.FieldByName('N_PER_ICM').AsFloat,VpfDNatureza))+ '|'+
    //16 VL BC ICMS ST
    FormatFloat('0.00',0)+ '|'+
    //17 ALIQ ICMS ST
    FormatFloat('0.00',0)+ '|'+
    //18 VL ICMS ST
    FormatFloat('0.00',0)+ '|'+
    //19 IND APUR
    '0|'+
    //20 CST IPI
    varia.CSTIPI+ '|'+
    //21 COD ENQ
    '|'+
    //22 VL BC IPI
    FormatFloat('0.00',Tabela2.FieldByName('N_TOT_PRO').AsFloat)+ '|'+
    //23 ALIQ IPI
    FormatFloat('0.00',Tabela2.FieldByName('N_PER_IPI').AsFloat)+ '|'+
    //24 ALIQ IPI
    FormatFloat('0.00',Tabela2.FieldByName('N_VLR_IPI').AsFloat)+ '|'+
    //25 CST PIS
    '01|'+
    //26 VL BC PIS
    FormatFloat('0.00',Tabela2.FieldByName('N_TOT_PRO').AsFloat)+ '|'+
    //27 ALIQ PIS
    '0|'+
    //28 QUANT BC PIS
    '0|'+
    //29 ALIQ PIS
    '0|'+
    //30 VL PIS
    '0|'+
    //31 CST COFINS
    '01|'+
    //32 VL BASE COFINS
    '0|'+
    //33 ALIQ COFINS
    '0|'+
    //34 QUANT BC COFINS
    '0|'+
    //35 ALIQ COFINS
    '0|'+
    //36 VL COFINS
    '0|'+
    //37 COD CTA
    '0|';

    VpadSped.Arquivo.Add(VpfLinha);
    inc(VpadSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC170);
    CarDRegistroC190Saida(Tabela2,VpadSped,VpfDNatureza,VpaCodCFOP,VpfCodCST);
    tabela2.next;
    VpfDProduto.free;
  end;
  VpfDNatureza.Free;
  VpfDCliente.free;
  Tabela2.Close;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC190(VpaDSped: TRBDSpedFiscal);
Var
  Vpflaco : integer;
  VpfDRegistroC190 : TRBDSpedfiscalRegistroC190;
  VpfLinha : String;
begin
  for vpflaco := 0 to VpaDSped.RegistroC190.Count - 1 do
  begin
    VpfDRegistroC190 := TRBDSpedfiscalRegistroC190(VpaDSped.RegistroC190.Items[vpfLaco]);
    vpflinha :=
    //01 REG
    '|C190|'+
    //02 CST ICMS
    AdicionaCharE('0',VpfDRegistroC190.CodCST,3)+'|'+
    //03 CFOP
    IntToStr(VpfDRegistroC190.CodCFOP)+'|'+
    //04 ALIQ ICMS
    FormatFloat('0.00',VpfDRegistroC190.PerICMS)+'|'+
    //05 VL OPR
    FormatFloat('0.00',VpfDRegistroC190.ValOperacao)+'|'+
    //06 VL BC ICMS
    FormatFloat('0.00',VpfDRegistroC190.ValBaseCalculoICMS)+'|'+
    //07 VL ICMS
    FormatFloat('0.00',VpfDRegistroC190.ValICMS)+'|'+
    //08 VL BC ICMS ST
    FormatFloat('0.00',VpfDRegistroC190.ValBaseCalculoICMSSubstituica)+'|'+
    //09 VL ICMS ST
    FormatFloat('0.00',VpfDRegistroC190.ValICMSSubstituicao)+'|'+
    //10 VL RED ICMS
    FormatFloat('0.00',VpfDRegistroC190.ValReducaBaseCalculo)+'|'+
    //11 VL IPI
    FormatFloat('0.00',VpfDRegistroC190.ValIPI)+'|';
    VpaDSped.Arquivo.ADD(VpfLinha);
    Inc(VpaDSped.QtdLinhasBlocoC);
    Inc(VpaDSped.QtdLinhasRegistroC190);
  end;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoCRegistroC990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBlocoC);
  VpaDSped.Arquivo.Add('|C990|'+IntToStr(VpaDSped.QtdLinhasBlocoC)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoDRegistroD001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|D001|1|');
  inc(VpaDSped.QtdLinhasBlocoD);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoDRegistroD990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBlocoD);
  VpaDSped.Arquivo.Add('|D990|'+IntToStr(VpaDSped.QtdLinhasBlocoD)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|E001|0|');
  inc(VpaDSped.QtdLinhasBlocoE);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE100(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|E100|'+FormatDateTime('DDMMYYYY',VpaDSped.DatInicio)+'|'+FormatDateTime('DDMMYYYY',VpaDSped.DatFinal)+'|');
  inc(VpaDSped.QtdLinhasBlocoE);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE110(VpaDSped: TRBDSpedFiscal);
Var
  VpfLinha : String;
begin
  VpfLinha :=
  //01 REG
  '|E110|'+
  //02 VL TOT DEBITOS
  FormatFloat('0.00',0)+'|'+
  //03 VL AJ DEBITOS
  FormatFloat('0.00',0)+'|'+
  //04 VL TOT AJ DEBITOS
  FormatFloat('0.00',0)+'|'+
  //05 VL ESTORNOS CRED
  FormatFloat('0.00',0)+'|'+
  //06 VL TOT CREDITO
  FormatFloat('0.00',0)+'|'+
  //07 VL AJ DEBITOS
  FormatFloat('0.00',0)+'|'+
  //08 VL TOT AJ DEBITOS
  FormatFloat('0.00',0)+'|'+
  //09 VL ESTORNOS DEBITOS
  FormatFloat('0.00',0)+'|'+
  //10 VL SALDO CREDOR ANT
  FormatFloat('0.00',0)+'|'+
  //11 VL SALDO APURADO
  FormatFloat('0.00',0)+'|'+
  //12 VL TOT DED
  FormatFloat('0.00',0)+'|'+
  //13 VL ICMS RECOLHER
  FormatFloat('0.00',0)+'|'+
  //14 VL SLD CREDOR TRANSPORTAR
  FormatFloat('0.00',0)+'|'+
  //15 DEB ESP
  FormatFloat('0.00',0)+'|';
  VpaDSped.Arquivo.Add(VpfLinha);
  inc(VpaDSped.QtdLinhasBlocoE);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoERegistroE990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBlocoE);
  VpaDSped.Arquivo.Add('|E990|'+IntToStr(VpaDSped.QtdLinhasBlocoE)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoHRegistro1001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|1001|1|');
  inc(VpaDSped.QtdLinhasBloco1);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoHRegistro1990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBloco1);
  VpaDSped.Arquivo.Add('|1990|'+IntToStr(VpaDSped.QtdLinhasBloco1)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoHRegistroH001(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.Arquivo.Add('|H001|1|');
  inc(VpaDSped.QtdLinhasBlocoH);
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraBlocoHRegistroH990(VpaDSped: TRBDSpedFiscal);
begin
  inc(VpaDSped.QtdLinhasBlocoH);
  VpaDSped.Arquivo.Add('|H990|'+IntToStr(VpaDSped.QtdLinhasBlocoH)+'|');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.GeraSpedfiscal(VpaDSped: TRBDSpedFiscal;VpaBarraStatus : TStatusBar);
begin
  VpaDSped.Incosistencias.clear;
  ZeraQtdLinhas(VpaDSped);
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
    AtualizaStatus('Gerando Bloco 0 registro 0150 Transportadoras');
    GeraBloco0Registro0150Transportadoras(VpaDSped);
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
    AtualizaStatus('Gerando Bloco C registro C100');
    GeraBlocoCRegistroC100Saida(VpaDSped);
    AtualizaStatus('Gerando Bloco C registro C990');
    GeraBlocoCRegistroC990(VpaDSped);
    AtualizaStatus('Gerando Bloco D registro D001');
    GeraBlocoDRegistroD001(VpaDSped);
    AtualizaStatus('Gerando Bloco D registro D990');
    GeraBlocoDRegistroD990(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E001');
    GeraBlocoERegistroE001(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E100');
    GeraBlocoERegistroE100(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E110');
    GeraBlocoERegistroE110(VpaDSped);
    AtualizaStatus('Gerando Bloco E registro E990');
    GeraBlocoERegistroE990(VpaDSped);
    AtualizaStatus('Gerando Bloco H registro D001');
    GeraBlocoHRegistroH001(VpaDSped);
    AtualizaStatus('Gerando Bloco H registro D990');
    GeraBlocoHRegistroH990(VpaDSped);
    AtualizaStatus('Gerando Bloco 1 registro 1001');
    GeraBlocoHRegistro1001(VpaDSped);
    AtualizaStatus('Gerando Bloco 1 registro 1990');
    GeraBlocoHRegistro1990(VpaDSped);
    AtualizaStatus('Gerando Bloco 9 registro 9001');
    GeraBloco9Registro9001(VpaDSped);
    AtualizaStatus('Gerando Bloco 9 registro 9990');
    GeraBloco9Registro9900(VpaDSped);
    AtualizaStatus('Gerando Bloco 9 registro 9990');
    GeraBloco9Registro9990(VpaDSped);
    AtualizaStatus('Gerando Bloco 9 registro 9999');
    GeraBloco9Registro9999(VpaDSped);
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
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ')'+
                               ' OR EXISTS (SELECT * FROM CADNOTAFISCAISFOR CAF ' +
                               ' WHERE CAF.C_COD_NAT = MOV.C_COD_NAT '+
                               ' AND CAF.I_SEQ_NAT = MOV.I_SEQ_MOV '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL '+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ')'+
                               ' ORDER BY C_COD_NAT, I_SEQ_MOV ');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaNotasFiscaisEntradaRegC100(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select NAT.C_ENT_SAI, NAT.C_GER_FIN, '+
                               ' CAD.I_EMP_FIL, CAD.I_COD_CLI, CAD.C_NOT_CAN, CAD.I_SEQ_NOT, CAD.I_NRO_NOT, CAD.C_SER_NOT, CAD.C_CHA_NFE, CAD.D_DAT_EMI, '+
                               ' CAD.D_DAT_SAI, CAD.N_TOT_NOT, CAD.N_VLR_DES, CAD.N_PER_DES, CAD.N_TOT_PRO, CAD.N_TOT_SER, CAD.I_TIP_FRE, CAD.C_COD_NAT, CAD.I_ITE_NAT, '+
                               ' CAD.N_VLR_FRE,  CAD.N_VLR_SEG, CAD.N_OUT_DES, CAD.N_BAS_CAL, CAD.N_VLR_ICM, CAD.N_BAS_SUB, CAD.N_VLR_SUB, '+
                               ' CAD.N_TOT_IPI, CAD.I_COD_TRA, CAD.C_NRO_PLA, CAD.C_EST_PLA, CAD.I_QTD_VOL, CAD.N_PES_BRU, CAD.N_PES_LIQ, '+
                               ' TRA.C_IND_PRO, '+
                               ' PAG.I_COD_PAG '+
                               ' from MOVNATUREZA NAT, CADNOTAFISCAIS CAD, CADCONDICOESPAGTO PAG, CADTRANSPORTADORAS TRA '+
                               ' Where CAD.C_COD_NAT = NAT.C_COD_NAT '+
                               ' AND CAD.I_ITE_NAT = NAT.I_SEQ_MOV '+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               ' and CAD.C_MOD_DOC IS NOT NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND '+SQLTextoRightJoin('CAD.I_COD_PAG','PAG.I_COD_PAG')+
                               ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_TRA'));
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaNotasFiscaisSaidaRegC100(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select NAT.C_ENT_SAI, NAT.C_GER_FIN, '+
                               ' CAD.I_EMP_FIL, CAD.I_COD_CLI, CAD.C_NOT_CAN, CAD.I_SEQ_NOT, CAD.I_NRO_NOT, CAD.C_SER_NOT, CAD.C_CHA_NFE, CAD.D_DAT_EMI, '+
                               ' CAD.D_DAT_SAI, CAD.N_TOT_NOT, CAD.N_VLR_DES, CAD.N_PER_DES, CAD.N_TOT_PRO, CAD.N_TOT_SER, CAD.I_TIP_FRE, CAD.C_COD_NAT, CAD.I_ITE_NAT, '+
                               ' CAD.N_VLR_FRE,  CAD.N_VLR_SEG, CAD.N_OUT_DES, CAD.N_BAS_CAL, CAD.N_VLR_ICM, CAD.N_BAS_SUB, CAD.N_VLR_SUB, '+
                               ' CAD.N_TOT_IPI, CAD.I_COD_TRA, CAD.C_NRO_PLA, CAD.C_EST_PLA, CAD.I_QTD_VOL, CAD.N_PES_BRU, CAD.N_PES_LIQ, '+
                               ' TRA.C_IND_PRO, '+
                               ' PAG.I_COD_PAG '+
                               ' from MOVNATUREZA NAT, CADNOTAFISCAIS CAD, CADCONDICOESPAGTO PAG, CADTRANSPORTADORAS TRA '+
                               ' Where CAD.C_COD_NAT = NAT.C_COD_NAT '+
                               ' AND CAD.I_ITE_NAT = NAT.I_SEQ_MOV '+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND '+SQLTextoRightJoin('CAD.I_COD_PAG','PAG.I_COD_PAG')+
                               ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_TRA'));
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
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  ) '+
                               ' or EXISTS(SELECT * FROM CADNOTAFISCAISFOR CAF '+
                               ' WHERE CAF.I_COD_CLI = CLI.I_COD_CLI '+
                               ' AND CAF.C_SER_NOT <> ''-1'''+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  ) ');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaProdutosNotafiscalSaidaRegC170(VpaTabela: TSQL; VpaCodFilial, VpaSeqNota: Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select MOV.I_EMP_FIL, MOV.I_SEQ_NOT, MOV.I_SEQ_MOV, MOV.I_SEQ_PRO, '+
                                  ' MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_TOT_PRO, MOV.C_COD_CST, '+
                                  ' MOV.N_PER_ICM, MOV.N_PER_IPI, MOV.N_VLR_IPI, MOV.I_COD_COR ' +
                                  ' FROM MOVNOTASFISCAIS MOV '+
                                  ' Where MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND MOV.I_SEQ_NOT = '+ IntToStr(VpaSeqNota)+
                                  ' ORDER BY MOV.I_SEQ_MOV');
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
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  )'+
                               ' OR EXISTS (SELECT * FROM CADNOTAFISCAISFOR CAF, MOVNOTASFISCAISFOR MOF '+
                               ' WHERE CAF.I_EMP_FIL = MOF.I_EMP_FIL '+
                               ' AND CAF.I_SEQ_NOT = MOF.I_SEQ_NOT '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL'+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOF.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                               ' )');
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.LocalizaTransportadorasREG0150(VpaTabela: TSQL; VpaDSped: TRBDSpedFiscal);
begin
  AdicionaSQLAbreTabela(Tabela,'Select TRA.I_COD_TRA,TRA.C_NOM_TRA, TRA.C_CGC_TRA, ' +
                               ' TRA.I_COD_IBG, TRA.I_COD_PAI, TRA.C_INS_TRA, TRA.C_END_TRA, '+
                               ' TRA.I_NUM_TRA, TRA.C_BAI_TRA '+
                               ' FROM CADTRANSPORTADORAS TRA '+
                               ' WHERE EXISTS (SELECT * FROM CADNOTAFISCAIS CAD '+
                               ' WHERE CAD.I_COD_TRA = TRA.I_COD_TRA '+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               '  ) '+
                               ' or EXISTS (SELECT * FROM CADNOTAFISCAISFOR CAF '+
                               ' WHERE CAF.I_COD_TRA = TRA.I_COD_TRA '+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               ' AND CAF.C_MOD_DOC IS NOT NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ')');
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
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  )'+
                               ' or exists(SELECT * FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV, CADPRODUTOS PRO '+
                               ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               ' AND PRO.C_COD_UNI = UNI.C_COD_UNI'+
                               ' and CAD.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                              '  )'+
                               ' OR EXISTS (SELECT * FROM CADNOTAFISCAISFOR CAF, MOVNOTASFISCAISFOR MOF '+
                               ' WHERE CAF.I_EMP_FIL = MOF.I_EMP_FIL '+
                               ' AND CAF.I_SEQ_NOT = MOF.I_SEQ_NOT '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOF.C_COD_UNI = UNI.C_COD_UNI'+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  )'+
                               ' or exists(SELECT * FROM CADNOTAFISCAISFOR CAF, MOVNOTASFISCAISFOR MOF, CADPRODUTOS PRO '+
                               ' WHERE CAF.I_EMP_FIL = MOF.I_EMP_FIL '+
                               ' AND CAF.I_SEQ_NOT = MOF.I_SEQ_NOT '+
                               ' AND CAF.C_MOD_DOC IS NOT NULL '+
                               SQLTextoDataEntreAAAAMMDD('CAF.D_DAT_REC',VpaDSped.DatInicio,VpaDSped.DatFinal,true)+
                               ' AND MOF.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               ' AND PRO.C_COD_UNI = UNI.C_COD_UNI'+
                               ' and CAF.I_EMP_FIL = '+IntToStr(VpaDSped.CodFilial)+
                               '  )' );
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.RAliquotaICMSRegitroC170Saida(VpaPerICMS: Double; VpaDNatureza: TRBDNaturezaOperacao): double;
begin
  if VpaDNatureza.IndCalcularICMS then
    result := VpaPerICMS
  else
    result := 0;
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.RBaseCalculoICMSRegitroC170Saida(VpaValTotProdutos: Double; VpaDNatureza: TRBDNaturezaOperacao): double;
begin
  if VpaDNatureza.IndCalcularICMS then
    result := VpaValTotProdutos
  else
    result := 0;
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.RValICMSRegitroC170Saida(VpaValTotProdutos, VpaPerICMS: Double; VpaDNatureza: TRBDNaturezaOperacao): double;
begin
  if VpaDNatureza.IndCalcularICMS then
    result := (VpaValTotProdutos * VpaPerICMS)/100
  else
    result := 0;
end;

{********************************************************************************}
procedure TRBFuncoesSpedFiscal.ZeraQtdLinhas(VpaDSped: TRBDSpedFiscal);
begin
  VpaDSped.QtdLinhasBloco0 := 0;
  VpaDSped.QtdLinhasBlocoC := 0;
  VpaDSped.QtdLinhasBlocoD := 0;
  VpaDSped.QtdLinhasBlocoE := 0;
  VpaDSped.QtdLinhasBlocoH := 0;
  VpaDSped.QtdLinhasBloco1 := 0;
  VpaDSped.QtdLinhasBloco9 := 0;
  VpaDSped.QtdLinhasRegistro0150 := 0;
  VpaDSped.QtdLinhasRegistro0190 := 0;
  VpaDSped.QtdLinhasRegistro0200 := 0;
  VpaDSped.QtdLinhasRegistro0400 := 0;
  VpaDSped.QtdLinhasRegistroC100 := 0;
  VpaDSped.QtdLinhasRegistroC140 := 0;
  VpaDSped.QtdLinhasRegistroC141 := 0;
  VpaDSped.QtdLinhasRegistroC160 := 0;
  VpaDSped.QtdLinhasRegistroC170 := 0;
  VpaDSped.QtdLinhasRegistroC190 := 0;
end;

end.
