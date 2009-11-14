Unit UnSpedFiscal;

Interface

Uses Classes, DBTables, UnDados,SysUtils, Unsistema;

//classe localiza
Type TRBLocalizaSpedFiscal = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesSpedFiscal = class(TRBLocalizaSpedFiscal)
  private
    function DadosValidos(VpaDSped : TRBDSpedFiscal) : string;
    function GeraBloco0Registro0000(VpaDSped : TRBDSpedFiscal) : string;
  public
    constructor cria;
    destructor destroy;override;
    function GeraSpedfiscal(VpaDSped : TRBDSpedFiscal):string;
end;



implementation

Uses FunSql, Constantes, funString;

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
constructor TRBFuncoesSpedFiscal.cria;
begin
  inherited create;
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.DadosValidos(VpaDSped: TRBDSpedFiscal): string;
begin
  result := '';
  if varia.CodIBGEMunicipio = 0 then
    result := 'CODIGO IBGE EMITENTE NÃO PREENCHIDO!!!'#13'É necessário corrigir o cadastro da FILIAL para associar o codigo IBGE.'
  else
    if varia.PerfilSped = '' then
      result := 'PERFIL DE APRESENTAÇÃO DO ARQUIVO FISCAL NÃO PREENCHIDO!!!'#13'É necessário ir nas Configurações das Filiais nas página Sped Fiscal e preencher o perfil da filial.';
end;

{********************************************************************************}
destructor TRBFuncoesSpedFiscal.destroy;
begin

  inherited;
end;

{********************************************************************************}
function TRBFuncoesSpedFiscal.GeraBloco0Registro0000(VpaDSped: TRBDSpedFiscal): string;
var
  VpfLinha : string;
begin

  result := '';
  VpfLinha :=
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
  FormatDateTime('DDMMYYYY',VpaDSped.DatInicio)+'|'+
  //06 NOME
  VpaDSped.DFilial.NomFilial+'|'+
  //07 CNPJ
  DeletaChars(DeletaChars(DeletaChars(VpaDSped.DFilial.DesCNPJ,'/'),'.'),'-')+'|'+
  //08 CPF

end;

function TRBFuncoesSpedFiscal.GeraSpedfiscal(VpaDSped: TRBDSpedFiscal): string;
begin
  Sistema.CarDFilial(VpaDSped.DFilial,VpaDSped.CodFilial);
  VpaDSped.Arquivo.clear;
  result := DadosValidos(VpaDSped);
  if result = '' then
  begin
    result := GeraBloco0Registro0000(VpaDSped);
  end;
end;

end.
