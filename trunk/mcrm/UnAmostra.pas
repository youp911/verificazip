Unit UnAmostra;
{Verificado
-.edit;
-*= e =*
-.post;

}
Interface

Uses Classes, DBTables, SysUtils, UnDadosProduto, SQLExpr, tabela;

//classe localiza
Type TRBLocalizaAmostra = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesAmostra = class(TRBLocalizaAmostra)
  private
    Aux,
    Amostra : TSQLQuery;
    Cadastro : TSql;
    function RSeqRequisicaoMaquinaDisponivel : Integer;
    procedure CarServicosFixoAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer);
    procedure CarPrecosClienteAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer);
    function GravaDServicoFixoAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer):string;
    function GravaDPrecoClienteAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer):string;
    procedure CarCoeficientesTabelaPreco(VpaDAmostra : TRBDAmostra);
    function RValCustoMateriaPrima(VpaDAmostra : TRBDAmostra):Double;
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    procedure CarDAmostra(VpaDAmostra: TRBDAmostra; VpaCodAmostra: Integer);
    function ConcluiAmostra(VpaCodAmostra : Integer;VpaDatConclusao : TDateTime) : string;
    function ConcluirPrecoAmostra(VpaCodAmostra : Integer;VpaDatConclusao : TDateTime) : string;
    function ConcluiDesenhoAmostra(VpaSeqRequisicao : Integer) : string;
    function AprovaAmostra(VpaCodAmostra : Integer) : string;
    function ConcluirFichaTecnica(VpaCodAmostra : Integer) : string;
    function EstornarAprovacao(VpaCodAmostra : Integer) : string;
    procedure CarConsumosAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer);
    function GravaConsumoAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer):string;
    function GravaRequisicaoMAquina(VpaCodAmostra, VpaCodMaquina : Integer;VpaDesRequisicao : string):string;
    function AtualizarAmostra(VpaCodAmostra: Integer; VpaDAmostra: TRBDAmostra): String;
    function CopiaConsumoAmostraProduto(VpaCodAmostra,VpaSeqProduto : Integer):String;
    procedure CalculaValorVendaUnitario(VpaDAmostra : TRBDAmostra);overload;
    procedure CalculaValorVendaUnitario(VpaDAmostra : TRBDAmostra;VpaDValorVenda : TRBDValorVendaAmostra);overload;
    procedure CalculaValorVendaPeloValorSugerido(VpaDAmostra : TRBDAmostra;VpaValSugerido : Double);
    function ExisteAmostraDefinidaDesenvolvida(VpaCodAmostra : integer):Boolean;
    function RQtdAmostraSolicitada(VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer):Integer;
    function RQtdAmostraEntregue(VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer):Integer;
    function RQtdAmostraAprovada(VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer):Integer;
    function RQtdClientesAmostra(VpaDatInicio,VpaDatFim : TDateTime;VpaCodVendedor : Integer):Integer;
    function RLegendaDisponivel(VpaDAmostra : TRBDAmostra):String;
    function RCodAmostraDisponivel(VpaCodClassificacao : String) : Integer;
    procedure CarPerLucroComissaoCoeficienteCusto(VpaCodCoeficiente : Integer;var VpaPerLucro, VpaPerComissao : Double);
    procedure ExcluiAmostra(VpaCodAmostra : Integer);
    procedure ExportaFichaTecnicaAmostra(VpaDAmostra : TRBDAmostra);
    procedure CarQtdPontos(VpaDAmostra : TRBDAmostra);
    function AtualizaTrocaLinhasQtdTotalPontosAmostra(VpaDAmostra : TRBDAmostra) : string;
end;



implementation

Uses FunSql, FunObjeto, UnProdutos, Constantes, FunData, dmRave, UnCotacao,
     UnClientes, UnSistema, FunString;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaAmostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaAmostra.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesAmostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesAmostra.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Cadastro := TSQL.create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  Aux := TSQLQuery.create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Amostra := TSQLQuery.create(nil);
  Amostra.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesAmostra.destroy;
begin
  Cadastro.free;
  Aux.free;
  Amostra.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RQtdAmostraAprovada(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select count(CODAMOSTRA) QTD '+
                            ' from AMOSTRA '+
                            ' Where CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                            ' and TIPAMOSTRA = ''D'''+
                            SQLTextoDataEntreAAAAMMDD('DATAPROVACAO',VpaDatInicio,VpaDatFim,true));
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RQtdAmostraEntregue(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select count(CODAMOSTRA) QTD '+
                            ' from AMOSTRA '+
                            ' Where CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                            ' and TIPAMOSTRA = ''D'''+
                            SQLTextoDataEntreAAAAMMDD('DATENTREGA',VpaDatInicio,VpaDatFim,true));
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RQtdAmostraSolicitada(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select count(CODAMOSTRA) QTD '+
                            ' from AMOSTRA '+
                            ' Where CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                            ' and TIPAMOSTRA = ''D'''+
                            SQLTextoDataEntreAAAAMMDD('DATAMOSTRA',VpaDatInicio,INCDIA(VpaDatFim,1),true));
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RQtdClientesAmostra(VpaDatInicio, VpaDatFim: TDateTime; VpaCodVendedor: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select count(DISTINCT(CODCLIENTE)) QTD '+
                            ' from AMOSTRA '+
                            ' Where CODVENDEDOR = '+IntToStr(VpaCodVendedor)+
                            ' and TIPAMOSTRA = ''D'''+
                            SQLTextoDataEntreAAAAMMDD('DATAMOSTRA',VpaDatInicio,INCDIA(VpaDatFim,1),true));
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarQtdPontos(VpaDAmostra: TRBDAmostra);
var
  VpfLaco : Integer;
begin
  VpaDAmostra.QtdTotalPontos := 0;
  VpaDAmostra.QtdTrocasLinhaBordado := 0;
  for Vpflaco := 0 to VpaDAmostra.Consumos.Count - 1 do
  begin
    if TRBDConsumoAmostra(VpaDAmostra.Consumos.Items[Vpflaco]).QtdPontos > 0 then
    begin
      VpaDAmostra.QtdTotalPontos := VpaDAmostra.QtdTotalPontos + TRBDConsumoAmostra(VpaDAmostra.Consumos.Items[Vpflaco]).QtdPontos;
      VpaDAmostra.QtdTrocasLinhaBordado := VpaDAmostra.QtdTrocasLinhaBordado +1;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RCodAmostraDisponivel(VpaCodClassificacao: String): Integer;
var
  VpfBaseCodigo : String;
  VpfProximoCodigoSemBase : Integer;
begin
  VpfBaseCodigo :=Copy(VpaCodClassificacao,2,length(VpaCodClassificacao));
  AdicionaSQLAbreTabela(Aux,'Select MAX(CODAMOSTRA) ULTIMO FROM AMOSTRA '+
                            ' Where CODCLASSIFICACAO = '''+VpaCodClassificacao+'''');
  if Aux.FieldByName('ULTIMO').AsInteger = 0 then
    result := StrToInt(VpfBaseCodigo+'1')
  else
  begin
    VpfProximoCodigoSemBase := StrtoInt(COPY(Aux.FieldByName('ULTIMO').AsString,length(VpfBaseCodigo),20))+1;
    Result := StrToInt(VpfBaseCodigo + IntToStr(VpfProximoCodigoSemBase));
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RLegendaDisponivel(VpaDAmostra : TRBDAmostra):String;
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoAmostra;
  VpfLegenda : String;
begin
  result := '';
  if VpaDAmostra.Consumos.Count = 1 then
    result := 'A'
  else
  begin
    for VpfLaco := 0 to VpaDAmostra.Consumos.Count - 1 do
    begin
      VpfDConsumo := TRBDConsumoAmostra(VpaDAmostra.Consumos.Items[VpfLaco]);
      if DeletaEspaco(VpfDConsumo.DesLegenda) <> '' then
      begin
        VpfLegenda := DeletaEspaco(VpfDConsumo.DesLegenda);
        result := '';
        if Length(VpfLegenda) > 1 then
          result := copy(VpfLegenda,1,Length(VpfLegenda)-1);
        result := result + char(ord(VpfLegenda[Length(VpfLegenda)])+1);
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RSeqRequisicaoMaquinaDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select Max(SEQREQUISICAO) ULTIMO from REQUISICAOMAQUINA ');
  result := Aux.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.RValCustoMateriaPrima(VpaDAmostra: TRBDAmostra): Double;
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoAmostra;
begin
  result := 0;
  for Vpflaco := 0 to VpaDAmostra.Consumos.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoAmostra(VpaDAmostra.Consumos.Items[VpfLaco]);
    result :=  result + VpfDConsumo.ValTotal;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarServicosFixoAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer);
Var
  VpfDSerAmostra :TRBDServicoFixoAmostra;
begin
  FreeTObjectsList(VpaDAmostra.ServicoFixo);

  AdicionaSQLAbreTabela(Amostra,'Select AMS.CODAMOSTRA, AMS.CODCORAMOSTRA, AMS.SEQCONSUMO, ' +
                               ' AMS.QTDSERVICO, AMS.VALUNITARIO, AMS.VALTOTAL, AMS.DESADICIONAL,'+
                               ' AMS.CODSERVICO, AMS.CODEMPRESASERVICO, '+
                               ' SER.C_NOM_SER '+
                               ' FROM AMOSTRASERVICOFIXO AMS, CADSERVICO SER '+
                               '  Where AMS.CODEMPRESASERVICO = SER.I_COD_EMP '+
                               '  and AMS.CODSERVICO = SER.I_COD_SER '+
                               ' and AMS.CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                               ' and AMS.CODCORAMOSTRA = '+IntToStr(VpaCorAmostra)+
                               ' order by AMS.SEQCONSUMO ');
  While not Amostra.eof do
  begin
    VpfDSerAmostra := VpaDAmostra.addServicoFixo;
    VpfDSerAmostra.SeqConsumo := Amostra.FieldByName('SEQCONSUMO').AsInteger;
    VpfDSerAmostra.CodCorAmostra := VpaCorAmostra;
    VpfDSerAmostra.CodEmpresaServico := Amostra.FieldByName('CODEMPRESASERVICO').AsInteger;
    VpfDSerAmostra.CodServico := Amostra.FieldByName('CODSERVICO').AsInteger;
    VpfDSerAmostra.NomServico := Amostra.FieldByName('C_NOM_SER').AsString;
    VpfDSerAmostra.DesAdicional := Amostra.FieldByName('DESADICIONAL').AsString;
    VpfDSerAmostra.QtdServico := Amostra.FieldByName('QTDSERVICO').AsFloat;
    VpfDSerAmostra.ValUnitario := Amostra.FieldByName('VALUNITARIO').AsFloat;
    VpfDSerAmostra.ValTotal := Amostra.FieldByName('VALTOTAL').AsFloat;
    Amostra.next;
  end;
  Amostra.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaDPrecoClienteAmostra(VpaDAmostra: TRBDAmostra; VpaCorAmostra: Integer): string;
var
  VpfLaco : Integer;
  VpfDPrecoCliente : TRBDPrecoClienteAmostra;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from AMOSTRAPRECOCLIENTE '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                        '  and CODCORAMOSTRA = '+IntToStr(VpaCorAmostra));
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRAPRECOCLIENTE '+
                                 ' Where CODAMOSTRA = 0 AND CODCORAMOSTRA = 0 AND CODCLIENTE = 0 AND CODCOEFICIENTE = 0 AND SEQPRECO = 0 ');
  for VpfLaco := 0 to VpaDAmostra.PrecosClientes.Count -1 do
  begin
    VpfDPrecoCliente := TRBDPrecoClienteAmostra(VpaDAmostra.PrecosClientes.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaDAmostra.CodAmostra;
    Cadastro.FieldByName('CODCORAMOSTRA').AsInteger := VpaCorAmostra;
    VpfDPrecoCliente.SeqPreco := VpfLaco +1;
    Cadastro.FieldByName('SEQPRECO').AsInteger := VpfDPrecoCliente.SeqPreco;
    Cadastro.FieldByName('CODCLIENTE').AsInteger := VpfDPrecoCliente.CodCliente;
    Cadastro.FieldByName('CODCOEFICIENTE').AsInteger := VpfDPrecoCliente.CodTabela;
    Cadastro.FieldByName('QTDAMOSTRA').AsFloat :=  VpfDPrecoCliente.QtdVenda;
    Cadastro.FieldByName('VALVENDA').AsFloat := VpfDPrecoCliente.ValVenda;
    Cadastro.FieldByName('PERLUCRO').AsFloat := VpfDPrecoCliente.PerLucro;
    Cadastro.FieldByName('PERCOMISSAO').AsFloat := VpfDPrecoCliente.PerComissao;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaDServicoFixoAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer):string;
var
  VpfLaco : Integer;
  VpfDSerAmostra : TRBDServicoFixoAmostra;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from AMOSTRASERVICOFIXO '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                        '  and CODCORAMOSTRA = '+IntToStr(VpaCorAmostra));
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRASERVICOFIXO '+
                                 ' Where CODAMOSTRA = 0 AND CODCORAMOSTRA = 0 AND SEQCONSUMO = 0 ');
  for VpfLaco := 0 to VpaDAmostra.ServicoFixo.Count -1 do
  begin
    VpfDSerAmostra := TRBDServicoFixoAmostra(VpaDAmostra.ServicoFixo.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaDAmostra.CodAmostra;
    Cadastro.FieldByName('CODCORAMOSTRA').AsInteger := VpaCorAmostra;
    VpfDSerAmostra.SeqConsumo := VpfLaco +1;
    Cadastro.FieldByName('SEQCONSUMO').AsInteger := VpfDSerAmostra.SeqConsumo;
    Cadastro.FieldByName('CODEMPRESASERVICO').AsInteger := VpfDSerAmostra.CodEmpresaServico;
    Cadastro.FieldByName('CODSERVICO').AsInteger := VpfDSerAmostra.CodServico;
    Cadastro.FieldByName('VALUNITARIO').AsFloat := VpfDSerAmostra.ValUnitario;
    Cadastro.FieldByName('VALTOTAL').AsFloat := VpfDSerAmostra.ValTotal;
    Cadastro.FieldByName('QTDSERVICO').AsFloat := VpfDSerAmostra.QtdServico;
    Cadastro.FieldByName('DESADICIONAL').AsString := VpfDSerAmostra.DesAdicional;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluiAmostra(VpaCodAmostra : Integer;VpaDatConclusao : TDateTime) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  if Cadastro.FieldByname('DATENTREGA').IsNull then
  begin
    Cadastro.edit;
    Cadastro.FieldByname('DATENTREGA').AsDateTime := VpaDatConclusao;
    Cadastro.FieldByname('DATALTERADOENTREGA').AsDateTime := now;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluirPrecoAmostra(VpaCodAmostra : Integer;VpaDatConclusao : TDateTime) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Cadastro.edit;
  Cadastro.FieldByname('DATPRECO').AsDateTime := VpaDatConclusao;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluiDesenhoAmostra(VpaSeqRequisicao : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from REQUISICAOMAQUINA '+
                                 ' Where SEQREQUISICAO = '+IntToStr(VpaSeqRequisicao));
  cadastro.edit;
  Cadastro.FieldByName('DATCONCLUSAO').AsDateTime := now;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.AprovaAmostra(VpaCodAmostra : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  if Cadastro.FieldByName('DATAPROVACAO').IsNull then
  begin
    Cadastro.edit;
    Cadastro.FieldByname('DATAPROVACAO').AsDateTime := DATE;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.ConcluirFichaTecnica(VpaCodAmostra : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Cadastro.edit;
  Cadastro.FieldByname('DATFICHA').AsDateTime := now;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.EstornarAprovacao(VpaCodAmostra : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  Cadastro.edit;
  Cadastro.FieldByname('DATAPROVACAO').Clear;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CalculaValorVendaPeloValorSugerido(VpaDAmostra: TRBDAmostra; VpaValSugerido: Double);
var
  VpfLaco : Integer;
  VpfDValorVenda : TRBDValorVendaAmostra;
begin
  CalculaValorVendaUnitario(VpaDAmostra);
  for VpfLaco := 0 to VpaDAmostra.ValoresVenda.Count - 1 do
  begin
    VpfDValorVenda := TRBDValorVendaAmostra(VpaDAmostra.ValoresVenda.Items[VpfLaco]);
    if VpfDValorVenda.ValVenda <> 0 then
    begin
      VpfDValorVenda.PerLucro := (VpaValSugerido * 30)/VpfDValorVenda.ValVenda;
      CalculaValorVendaUnitario(VpaDAmostra,VpfDValorVenda);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CalculaValorVendaUnitario(VpaDAmostra: TRBDAmostra; VpaDValorVenda: TRBDValorVendaAmostra);
var
  VpfCoeficiente  : Double;
begin
  VpfCoeficiente := VpaDValorVenda.PerCoeficientes + VpaDValorVenda.PerComissao + VpaDValorVenda.PerLucro+VpaDValorVenda.PerVendaPrazo;
  VpaDValorVenda.CustoComImposto := VpaDAmostra.CustoProduto /(1-((VpaDValorVenda.PerCoeficientes+VpaDValorVenda.PerComissao)/100));
  VpaDValorVenda.ValVenda := VpaDAmostra.CustoProduto /(1-(vpfCoeficiente/100));
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarCoeficientesTabelaPreco(VpaDAmostra: TRBDAmostra);
Var
  VpfLaco : Integer;
  VpfDValorVenda : TRBDValorVendaAmostra;
  VpfDQuantidade : TRBDQuantidadeAmostra;
begin
  FreeTObjectsList(VpaDAmostra.ValoresVenda);
  AdicionaSQLAbreTabela(Amostra,'Select * from COEFICIENTECUSTO'+
                                ' order by CODCOEFICIENTE ');
  while not Amostra.Eof do
  begin
    for VpfLaco := 0 to VpaDAmostra.Quantidades.Count - 1 do
    begin
      VpfDQuantidade := TRBDQuantidadeAmostra(VpaDAmostra.Quantidades.Items[VpfLaco]);
      VpfDValorVenda := VpaDAmostra.addValorVenda;
      VpfDValorVenda.CodTabela := Amostra.FieldByName('CODCOEFICIENTE').AsInteger;
      VpfDValorVenda.NomTabela := Amostra.FieldByName('NOMCOEFICIENTE').AsString;
      VpfDValorVenda.PerCoeficientes := Amostra.FieldByName('PERICMS').AsFloat+ Amostra.FieldByName('PERPISCOFINS').AsFloat +Amostra.FieldByName('PERFRETE').AsFloat+
                                        Amostra.FieldByName('PERADMINISTRATIVO').AsFloat + Amostra.FieldByName('PERPROPAGANDA').AsFloat;
      VpfDValorVenda.PerComissao := Amostra.FieldByName('PERCOMISSAO').AsFloat;
      VpfDValorVenda.PerVendaPrazo := Amostra.FieldByName('PERVENDAPRAZO').AsFloat;
      VpfDValorVenda.PerLucro := Amostra.FieldByName('PERLUCRO').AsFloat;
      VpfDValorVenda.Quantidade :=VpfDQuantidade.Quantidade;
    end;
    Amostra.Next;
  end;
  Amostra.close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarConsumosAmostra(VpaDAmostra : TRBDAmostra;VpaCorAmostra : Integer);
Var
  VpfDConsumo : TRBDConsumoAmostra;
begin
  FreeTObjectsList(VpaDAmostra.Consumos);
  Amostra.Close;
  Amostra.SQL.Clear;
  Amostra.SQL.Add('Select CON.SEQCONSUMO, CON.SEQPRODUTO, CON.DESUM, CON.NOMPRODUTO, CON.CODCOR,' +
                  ' CON.DESOBSERVACAO, CON.DESLEGENDA, CON.VALUNITARIO, CON.QTDPRODUTO, CON.VALTOTAL,'+
                  ' CON.CODFACA, CON.ALTMOLDE, CON.LARMOLDE, CON.CODMAQUINA,  '+
                  ' CON.DESOBSERVACAO, CON.NUMSEQUENCIA, CON.QTDPONTOSBORDADO, '+
                  ' PRO.C_COD_PRO, PRO.I_ALT_PRO, '+
                  ' COR.NOM_COR, '  +
                  ' CLA.N_PER_PER, ' +
                  ' TIP.CODTIPOMATERIAPRIMA, TIP.NOMTIPOMATERIAPRIMA '+
                  ' FROM AMOSTRACONSUMO CON, CADPRODUTOS PRO, COR, TIPOMATERIAPRIMA TIP, CADCLASSIFICACAO CLA  '+
                  ' Where CON.CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra));
  Amostra.SQL.Add(' AND CON.CODCORAMOSTRA = '+IntToStr(VpaCorAmostra));
  Amostra.SQL.Add(' AND CON.SEQPRODUTO = PRO.I_SEQ_PRO '+
                  ' AND '+SQLTextoRightJoin('CON.CODCOR','COR.COD_COR')+
                  ' AND '+SQLTextoRightJoin('CON.CODTIPOMATERIAPRIMA','TIP.CODTIPOMATERIAPRIMA')+
                  ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                  ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                  ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                  ' ORDER BY NUMSEQUENCIA, SEQCONSUMO');
  Amostra.Open;
  while not Amostra.Eof do
  begin
    VpfDConsumo := VpaDAmostra.addConsumo;
    VpfDConsumo.SeqConsumo := Amostra.FieldByname('SEQCONSUMO').AsInteger;
    VpfDConsumo.CodCorAmostra := VpaCorAmostra;
    VpfDConsumo.SeqProduto := Amostra.FieldByname('SEQPRODUTO').AsInteger;
    VpfDConsumo.CodCor := Amostra.FieldByname('CODCOR').AsInteger;
    VpfDConsumo.CodProduto := Amostra.FieldByname('C_COD_PRO').AsString;
    VpfDConsumo.NomProduto := Amostra.FieldByname('NOMPRODUTO').AsString;
    VpfDConsumo.NomCor := Amostra.FieldByname('NOM_COR').AsString;
    VpfDConsumo.DesUM :=  Amostra.FieldByname('DESUM').AsString;
    VpfDConsumo.UMAnterior :=  VpfDConsumo.DesUM;
    VpfDConsumo.UnidadeParentes := FunProdutos.ValidaUnidade.UnidadesParentes(VpfDConsumo.DesUM);
    VpfDConsumo.DesObservacao := Amostra.FieldByname('DESOBSERVACAO').AsString;
    VpfDConsumo.Qtdproduto := Amostra.FieldByname('QTDPRODUTO').AsFloat;
    VpfDConsumo.ValUnitario := Amostra.FieldByname('VALUNITARIO').AsFloat;
    VpfDConsumo.ValTotal := Amostra.FieldByname('VALTOTAL').AsFloat;
    VpfDConsumo.CodFaca := Amostra.FieldByname('CODFACA').AsInteger;
    VpfDConsumo.AltProduto := Amostra.FieldByname('I_ALT_PRO').AsInteger;
    VpfDConsumo.LarMolde := Amostra.FieldByname('LARMOLDE').AsFloat;
    VpfDConsumo.AltMolde := Amostra.FieldByname('ALTMOLDE').AsFloat;
    VpfDConsumo.CodMaquina := Amostra.FieldByname('CODMAQUINA').AsInteger;
    VpfDConsumo.DesObservacao := Amostra.FieldByname('DESOBSERVACAO').AsString;
    VpfDConsumo.DesLegenda := Amostra.FieldByname('DESLEGENDA').AsString;
    VpfDConsumo.CodTipoMateriaPrima := Amostra.FieldByName('CODTIPOMATERIAPRIMA').AsInteger;
    VpfDConsumo.NomTipoMateriaPrima := Amostra.FieldByName('NOMTIPOMATERIAPRIMA').AsString;
    VpfDConsumo.NumSequencia := Amostra.FieldByName('NUMSEQUENCIA').AsInteger;
    VpfDConsumo.QtdPontos := Amostra.FieldByName('QTDPONTOSBORDADO').AsInteger;
    VpfDConsumo.PerAcrescimoPerda := Amostra.FieldByName('N_PER_PER').AsFloat;
    if VpfDConsumo.CodFaca <> 0 then
      FunProdutos.ExisteFaca(VpfDConsumo.CodFaca,VpfDConsumo.Faca);
    if VpfDConsumo.CodMaquina <> 0 then
      FunProdutos.ExisteMaquina(VpfDConsumo.CodMaquina,VpfDConsumo.Maquina);
    Amostra.next;
  end;
  Amostra.close;
  CarServicosFixoAmostra(VpaDAmostra,VpaCorAmostra);
  CarPrecosClienteAmostra(VpaDAmostra,VpaCorAmostra);
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaConsumoAmostra(VpaDAmostra: TRBDAmostra;VpaCorAmostra: Integer): string;
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoAmostra;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from AMOSTRACONSUMO '+
                        ' Where CODAMOSTRA = '+ IntToStr(VpaDAmostra.CodAmostra)+
                        ' and CODCORAMOSTRA = '+IntToStr(VpaCorAmostra));
  AdicionaSqlAbreTabela(Cadastro,'Select * from AMOSTRACONSUMO '+
                                 ' Where CODAMOSTRA = 0 AND CODCORAMOSTRA = 0 AND SEQCONSUMO = 0 ');
  for VpfLaco := 0 to VpaDAmostra.Consumos.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoAmostra(VpaDAmostra.Consumos.Items[VpfLaco]);
    Cadastro.Insert;
    Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaDAmostra.CodAmostra;
    Cadastro.FieldByName('CODCORAMOSTRA').AsInteger := VpaCorAmostra;
    Cadastro.FieldByName('SEQCONSUMO').AsInteger := VpfLaco + 1;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDConsumo.SeqProduto;
    cadastro.FieldByName('NOMPRODUTO').AsString := VpfDConsumo.NomProduto;
    cadastro.FieldByName('DESUM').AsString := VpfDConsumo.DesUM;
    IF VpfDConsumo.CodCor <> 0 then
      Cadastro.FieldByName('CODCOR').AsInteger := VpfDConsumo.CodCor;
    Cadastro.FieldByName('QTDPRODUTO').AsFloat := VpfdConsumo.Qtdproduto;
    Cadastro.FieldByName('VALUNITARIO').AsFloat := VpfdConsumo.ValUnitario;
    Cadastro.FieldByName('VALTOTAL').AsFloat := VpfdConsumo.ValTotal;
    Cadastro.FieldByName('DESOBSERVACAO').AsString := VpfdConsumo.DesObservacao;
    Cadastro.FieldByName('DESLEGENDA').AsString := VpfdConsumo.DesLegenda;
    if VpfDConsumo.CodFaca <> 0 then
      Cadastro.FieldByName('CODFACA').AsInteger := VpfDConsumo.CodFaca;
    if VpfDConsumo.LarMolde <> 0 then
      Cadastro.FieldByName('LARMOLDE').AsFloat := VpfDConsumo.LarMolde;
    if VpfDConsumo.AltMolde <> 0 then
      Cadastro.FieldByName('ALTMOLDE').AsFloat := VpfDConsumo.AltMolde;
    if VpfDConsumo.CodMaquina <> 0 then
      Cadastro.FieldByName('CODMAQUINA').AsInteger := VpfDConsumo.CodMaquina;
    if VpfDConsumo.QtdPecasemMetro <> 0 then
      Cadastro.FieldByName('QTDPECAEMMETRO').AsFloat := VpfDConsumo.QtdPecasemMetro;
    if VpfDConsumo.ValIndiceConsumo <> 0 then
      Cadastro.FieldByName('VALINDICEMETRO').AsFloat := VpfDConsumo.ValIndiceConsumo;
    if VpfDConsumo.CodTipoMateriaPrima <> 0 then
      Cadastro.FieldByName('CODTIPOMATERIAPRIMA').AsInteger := VpfDConsumo.CodTipoMateriaPrima;
    if VpfDConsumo.NumSequencia <> 0 then
      Cadastro.FieldByName('NUMSEQUENCIA').AsInteger := VpfDConsumo.NumSequencia;
    if VpfDConsumo.QtdPontos <> 0 then
      Cadastro.FieldByName('QTDPONTOSBORDADO').AsInteger := VpfDConsumo.QtdPontos;
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      exit;
  end;
  Cadastro.close;
  if result = '' then
  begin
    if result = '' then
    begin
      Result := GravaDServicoFixoAmostra(VpaDAmostra,VpaCorAmostra);
      if result = '' then
      begin
        result := GravaDPrecoClienteAmostra(VpaDAmostra,VpaCorAmostra);
        if result = '' then
          result := AtualizaTrocaLinhasQtdTotalPontosAmostra(VpaDAmostra);
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesAmostra.GravaRequisicaoMAquina(VpaCodAmostra, VpaCodMaquina : Integer;VpaDesRequisicao : string):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from REQUISICAOMAQUINA ');
  Cadastro.insert;
  Cadastro.FieldByName('CODAMOSTRA').AsInteger := VpaCodAmostra;
  Cadastro.FieldByName('CODMAQUINA').AsInteger := VpaCodMaquina;
  Cadastro.FieldByName('DESREQUISICAO').AsString := VpaDesRequisicao;
  Cadastro.FieldByName('DATREQUISICAO').AsDateTime := now;
  Cadastro.FieldByName('SEQREQUISICAO').AsInteger := RSeqRequisicaoMaquinaDisponivel;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarDAmostra(VpaDAmostra: TRBDAmostra; VpaCodAmostra : Integer);
begin
  AdicionaSQLAbreTabela(Amostra,'SELECT * FROM AMOSTRA'+
                                ' WHERE CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  VpaDAmostra.CodAmostra:= VpaCodAmostra;
  VpaDAmostra.CodColecao:= Amostra.FieldByName('CODCOLECAO').AsInteger;
  VpaDAmostra.CodDesenvolvedor:= Amostra.FieldByName('CODDESENVOLVEDOR').AsInteger;
  VpaDAmostra.CodDepartamento := Amostra.FieldByName('CODDEPARTAMENTOAMOSTRA').AsInteger;
  VpaDAmostra.CodProspect:= Amostra.FieldByName('CODCLIENTE').AsInteger;
  VpaDAmostra.CodVendedor:= Amostra.FieldByName('CODVENDEDOR').AsInteger;
  VpaDAmostra.CodAmostraIndefinida:= Amostra.FieldByName('CODAMOSTRAINDEFINIDA').AsInteger;
  VpaDAmostra.QtdAmostra:= Amostra.FieldByName('QTDAMOSTRA').AsInteger;
  VpaDAmostra.NomAmostra:= Amostra.FieldByName('NOMAMOSTRA').AsString;
  VpaDAmostra.DesImagem:= Amostra.FieldByName('DESIMAGEM').AsString;
  VpaDAmostra.DesImagemCliente:= Amostra.FieldByName('DESIMAGEMCLIENTE').AsString;
  VpaDAmostra.IndCopia:= Amostra.FieldByName('INDCOPIA').AsString;
  VpaDAmostra.TipAmostra:= Amostra.FieldByName('TIPAMOSTRA').AsString;
  VpaDAmostra.DesObservacao:= Amostra.FieldByName('DESOBSERVACAO').AsString;
  VpaDAmostra.CodProduto:= Amostra.FieldByName('CODPRODUTO').AsString;
  VpaDAmostra.IndAlteracao:= Amostra.FieldByName('INDALTERACAO').AsString;
  VpaDAmostra.DatAmostra:= Amostra.FieldByName('DATAMOSTRA').AsDateTime;
  VpaDAmostra.DatEntrega:= Amostra.FieldByName('DATENTREGA').AsDateTime;
  VpaDAmostra.DatEntregaCliente:= Amostra.FieldByName('DATENTREGACLIENTE').AsDateTime;
  VpaDAmostra.DatAprovacao:= Amostra.FieldByName('DATAPROVACAO').AsDateTime;
  VpaDAmostra.DatAlteradoEntrega:= Amostra.FieldByName('DATALTERADOENTREGA').AsDateTime;
  VpaDAmostra.DatFicha:= Amostra.FieldByName('DATFICHA').AsDateTime;
  VpaDAmostra.QtdPrevisaoCompra:= Amostra.FieldByName('QTDPREVISAOCOMPRA').AsFloat;
  VpaDAmostra.QtdTotalPontos := Amostra.FieldByName('QTDTOTALPONTOSBORDADO').AsInteger;
  VpaDAmostra.QtdCortesBordado := Amostra.FieldByName('QTDCORTES').AsInteger;
  VpaDAmostra.QtdTrocasLinhaBordado := Amostra.FieldByName('QTDTROCALINHA').AsInteger;

  Amostra.Close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarPerLucroComissaoCoeficienteCusto(VpaCodCoeficiente: Integer;var VpaPerLucro, VpaPerComissao : Double);
begin
  AdicionaSQLAbreTabela(Aux,'Select PERCOMISSAO, PERLUCRO FROM COEFICIENTECUSTO '+
                            ' Where CODCOEFICIENTE = '+IntToStr(VpaCodCoeficiente));
  VpaPerLucro := Aux.FieldByName('PERLUCRO').AsFloat;
  VpaPerComissao := Aux.FieldByName('PERCOMISSAO').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CarPrecosClienteAmostra(VpaDAmostra: TRBDAmostra;VpaCorAmostra: Integer);
Var
  VpfDPreAmostra :TRBDPrecoClienteAmostra;
begin
  FreeTObjectsList(VpaDAmostra.ServicoFixo);

  AdicionaSQLAbreTabela(Amostra,'Select AMP.CODAMOSTRA, AMP.CODCORAMOSTRA, AMP.SEQPRECO, AMP.CODCLIENTE, AMP.CODCOEFICIENTE, AMP.QTDAMOSTRA, ' +
                                ' AMP.VALVENDA, AMP.PERLUCRO, AMP.PERCOMISSAO, ' +
                                ' CLI.C_NOM_CLI, ' +
                                ' COE.NOMCOEFICIENTE ' +
                                ' FROM AMOSTRAPRECOCLIENTE AMP, CADCLIENTES CLI, COEFICIENTECUSTO COE ' +
                                ' Where AMP.CODCLIENTE = CLI.I_COD_CLI ' +
                                ' AND AMP.CODCOEFICIENTE = COE.CODCOEFICIENTE '+
                               ' and AMP.CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra)+
                               ' and AMP.CODCORAMOSTRA = '+IntToStr(VpaCorAmostra)+
                               ' order by AMP.SEQPRECO ');
  While not Amostra.eof do
  begin
    VpfDPreAmostra := VpaDAmostra.addPrecoCliente;
    VpfDPreAmostra.SeqPreco := Amostra.FieldByName('SEQPRECO').AsInteger;
    VpfDPreAmostra.CodTabela := Amostra.FieldByName('CODCOEFICIENTE').AsInteger;
    VpfDPreAmostra.CodCliente := Amostra.FieldByName('CODCLIENTE').AsInteger;
    VpfDPreAmostra.NomTabela := Amostra.FieldByName('NOMCOEFICIENTE').AsString;
    VpfDPreAmostra.NomCliente := Amostra.FieldByName('C_NOM_CLI').AsString;
    VpfDPreAmostra.ValVenda := Amostra.FieldByName('VALVENDA').AsFloat;
    VpfDPreAmostra.QtdVenda := Amostra.FieldByName('QTDAMOSTRA').AsFloat;
    VpfDPreAmostra.PerLucro := Amostra.FieldByName('PERLUCRO').AsFloat;
    VpfDPreAmostra.PerComissao := Amostra.FieldByName('PERCOMISSAO').AsFloat;
    Amostra.next;
  end;
  Amostra.close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.AtualizarAmostra(VpaCodAmostra: Integer; VpaDAmostra: TRBDAmostra): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM AMOSTRA'+
                                 ' WHERE CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  if not Cadastro.Eof then
  begin
    Cadastro.Edit;
    Cadastro.FieldByName('CODPRODUTO').AsString:= VpaDAmostra.CodProduto;
    Cadastro.Post;
    result := Cadastro.AMensagemErroGravacao;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.AtualizaTrocaLinhasQtdTotalPontosAmostra(VpaDAmostra: TRBDAmostra): string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from AMOSTRA '+
                                 ' Where CODAMOSTRA = '+IntToStr(VpaDAmostra.CodAmostra));
  Cadastro.Edit;
  Cadastro.FieldByName('QTDTOTALPONTOSBORDADO').AsInteger := VpaDAmostra.QtdTotalPontos;
  Cadastro.FieldByName('QTDCORTES').AsInteger := VpaDAmostra.QtdCortesBordado;
  Cadastro.FieldByName('QTDTROCALINHA').AsInteger := VpaDAmostra.QtdTrocasLinhaBordado;
  Cadastro.Post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesAmostra.CopiaConsumoAmostraProduto(VpaCodAmostra,VpaSeqProduto : Integer):String;
begin
  result := '';
  AdicionaSQLAbreTabela(Amostra,'Select * from AMOSTRACONSUMO '+
                                ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from MOVKITBASTIDOR '+
                        ' Where SEQPRODUTOKIT = '+IntToStr(VpaSeqProduto));
  ExecutaComandoSql(Aux,'Delete from MOVKIT '+
                        ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto));
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVKIT '+
                                 ' Where I_PRO_KIT = 0 AND I_SEQ_MOV = 0 AND I_COR_KIT = 0 ');
  While not Amostra.Eof do
  begin
    Cadastro.Insert;
    Cadastro.FieldByname('I_PRO_KIT').AsInteger := VpaSeqProduto;
    Cadastro.FieldByname('I_SEQ_PRO').AsInteger := Amostra.FieldByname('SEQPRODUTO').AsInteger;
    Cadastro.FieldByname('N_QTD_PRO').AsFloat := Amostra.FieldByname('QTDPRODUTO').AsFloat;
    Cadastro.FieldByname('I_COD_EMP').AsInteger := VARIA.CodigoEmpresa;
    Cadastro.FieldByname('D_ULT_ALT').AsDateTime := date;
    if Amostra.FieldByname('CODCOR').AsInteger <> 0 then
      Cadastro.FieldByname('I_COD_COR').AsInteger := Amostra.FieldByname('CODCOR').AsInteger;
    Cadastro.FieldByname('C_COD_UNI').AsString := Amostra.FieldByname('DESUM').AsString;
    Cadastro.FieldByname('I_SEQ_MOV').AsInteger := Amostra.FieldByname('SEQCONSUMO').AsInteger;
    Cadastro.FieldByname('I_COR_KIT').AsInteger := Amostra.FieldByname('CODCORAMOSTRA').AsInteger;
    if Amostra.FieldByname('CODFACA').AsInteger <> 0 then
      Cadastro.FieldByname('I_COD_FAC').AsInteger := Amostra.FieldByname('CODFACA').AsInteger;
    if Amostra.FieldByname('ALTMOLDE').AsFloat <> 0 then
      Cadastro.FieldByname('I_ALT_MOL').Asfloat := Amostra.FieldByname('ALTMOLDE').AsFloat;
    if Amostra.FieldByname('LARMOLDE').Asfloat <> 0 then
      Cadastro.FieldByname('I_LAR_MOL').AsFloat := Amostra.FieldByname('LARMOLDE').AsFloat;
    if Amostra.FieldByname('CODMAQUINA').AsInteger <> 0 then
      Cadastro.FieldByname('I_COD_MAQ').AsInteger := Amostra.FieldByname('CODMAQUINA').AsInteger;
    Cadastro.FieldByname('N_VLR_UNI').AsFloat := Amostra.FieldByname('VALUNITARIO').AsFloat;
    Cadastro.FieldByname('N_VLR_TOT').AsFloat := Amostra.FieldByname('VALTOTAL').AsFloat;
    Cadastro.FieldByname('N_PEC_MET').AsFloat := Amostra.FieldByname('QTDPECAEMMETRO').AsFloat;
    Cadastro.FieldByname('N_IND_MET').AsFloat := Amostra.FieldByname('VALINDICEMETRO').AsFloat;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
    Amostra.next;
  end;
  Amostra.close;
  Cadastro.close;
  AprovaAmostra(VpaCodAmostra);
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.CalculaValorVendaUnitario(VpaDAmostra : TRBDAmostra);
var
  VpfLaco : Integer;
  VpfDValorVenda : TRBDValorVendaAmostra;
begin
{Explicativo do custo
  COEFICIENTE = %ICMS + %PIS + %COMISSAO + %FRETE + %ADM_VENDAS + %PROPAGANDA

  CUSTO_IMPOSTOS = CUSTO_PRODUTO /(1-(COEFICIENTE/100))

  PVENDA = (CUSTO_PRODUTO /1 -((COEFICIENTE + % LUCRO)/100)))

  PVENDA_PRAZO = (CUSTO_PRODUTO / (1 - ((COEFICIENTE +%LUCRO + %VENDAPRAZO)/100)))}

//  if VpaDAmostra.ValoresVenda.Count = 0 then
    CarCoeficientesTabelaPreco(VpaDAmostra);
  VpaDAmostra.CustoMateriaPrima := RValCustoMateriaPrima(VpaDAmostra);
  VpaDAmostra.CustoProcessos := 0;
  VpaDAmostra.CustoProduto := VpaDAmostra.CustoProcessos + VpaDAmostra.CustoMateriaPrima;

  for VpfLaco := 0 to VpaDAmostra.ValoresVenda.Count - 1 do
  begin
    VpfDValorVenda := TRBDValorVendaAmostra(VpaDAmostra.ValoresVenda.Items[VpfLaco]);
    CalculaValorVendaUnitario(VpaDAmostra,VpfDValorVenda);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.ExcluiAmostra(VpaCodAmostra: Integer);
begin
  ExecutaComandoSql(Aux,'Delete from AMOSTRAPRECOCLIENTE '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from AMOSTRASERVICO '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from AMOSTRACONSUMO '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
  ExecutaComandoSql(Aux,'Delete from AMOSTRA '+
                        ' Where CODAMOSTRA = '+IntToStr(VpaCodAmostra));
end;

{******************************************************************************}
function TRBFuncoesAmostra.ExisteAmostraDefinidaDesenvolvida(VpaCodAmostra : integer):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select CODAMOSTRA FROM AMOSTRA '+
                            ' Where CODAMOSTRAINDEFINIDA = '+IntToStr(VpaCodAmostra));
  result := not Aux.eof;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesAmostra.ExportaFichaTecnicaAmostra(VpaDAmostra: TRBDAmostra);
var
  VpfNomArquivo, VpfTextoEmail, VpfNomVendedor, VpfEmailVendedor : String;
begin
  VpfNomVendedor := FunCotacao.RNomVendedor(VpaDAmostra.CodVendedor);
  VpfNomArquivo := Varia.PathFichaAmostra+'\Arquivos '+VpfNomVendedor+'\Ficha Técnica\'+FunClientes.RNomeFantasia(VpaDAmostra.CodProspect)+'\'+IntToStr(VpaDAmostra.CodAmostra)+'A.PDF';
  dtRave := TdtRave.Create(nil);
  dtRave.ImprimeFichaTecnicaAmostra(VpaDAmostra.CodAmostra,false,VpfNomArquivo);
  dtRave.free;
  VpfEmailVendedor := FunCotacao.REmailVencedor(VpaDAmostra.CodVendedor);
  if VpfEmailVendedor <> '' then
  begin
    VpfTextoEmail := 'Prezado <b>'+VpfNomVendedor+'</b> <br><br>Segue anexo a <b>F</b>icha <b>T</b>ecnica de <b>A</b>mostra. <br><br><br>Atenciosamente<br><br>Departamento de Criação <br>'+varia.NomeFilial;

    Sistema.EnviaEmail(VpfEmailVendedor,Varia.NomeFilial+' - FTA - ' +IntToStr(VpaDAmostra.CodAmostra),
                       VpfTextoEmail,VpfNomArquivo);
  end;
end;

end.
