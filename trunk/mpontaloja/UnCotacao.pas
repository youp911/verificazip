unit UnCotacao;
{Verificado
-.edit;
-post
}
{ autor: rafael budag
  data : 05/04/2000
 funcao: unidade que faz as acoes da cotacao}

interface
uses classes, DBTables, Db, SysUtils, ConvUnidade, UnDados, UnContasAReceber, UnProdutos, UnDadosCR, UnDadosProduto,
     Parcela, UnContasAPagar, UnSistema, UnImpressaoBoleto, Registry, IdMessage, IdSMTP, UnVendedor, windows,comctrls, variants,
     IdAttachmentfile, idText, SQLExpr, tabela, UnArgox;

type TCalculosCotacao = class
  private
  public
end;

// classe com as localizacoes das funcoes
Type TLocalizaCotacao = class(TCalculosCotacao)
  private
  public
    procedure LocalizaMovOrcamento(VpaTabela : TDataSet;VpaCodFilial, VpaLanOrcamento : String);
    function ExisteProdutoOrcamento(VpaMovOrcamento : TDataSet;VpaCodFilial,VpaLanOrcamento,VpaSeqProduto : Integer):Boolean;
    procedure LocalizaCadOrcamento(VpaTabela : TDataSet;VpaLanOrcamento : String);
    procedure LocalizaMovServicoOrcamento(VpaTabela : TDataSet;VpaLanOrcamento : String);
    procedure LocalizaCliente(VpaTabela : TDataSet;VpaCodCliente : String);
    procedure LocalizaEntradaMetrosDiario(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime);
end;

// classe com as funcoes da cotacao
type TFuncoesCotacao = class(TLocalizaCotacao)
  private
    Aux,
    Orcamento,
    Kit,
    ProdutosNota : TSQLQuery;
    CotCadastro,
    CotCadastro2  : TSQL;
    VprBaseDados : TSQLConnection;
    IndiceUnidade : TConvUnidade;
    ValidaUnidade : TValidaUnidade;
    CriaParcelas : TCriaParcelasReceber;
    VprMensagem : TidMessage;
    VprSMTP : TIdSMTP;
    FunVendedor : TRBFuncoesVendedor;
    function RProximoLanOrcamento : Integer;
    function RProximoSeqParcialOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) : Integer;
    function RProximoSeqEstagioOrcamento(VpaCodfilial,VpaLanOrcamento : integer) : Integer;
    function REstagioAtualCotacao(VpaCodFilial,VpaLanOrcamento : Integer):Integer;
    function RQtdBrindeProdutoCliente(VpaCodCliente,VpaSeqProduto : Integer;VpaUM : String) : Double;
    function REmailTransportadora(VpaCodTransportadora : Integer):string;
    function RTextoAcrescimoDesconto(VpaDCotacao : TRBDORcamento):String;
    function RValorAcrescimodesconto(VpaDCotacao : TRBDORcamento):String;
    procedure CarDComposeProduto(VpaDCotacao : trbdorcamento;VpaDProdutoOrc : TRBDOrcProduto);
    procedure CarDOrcamentoProduto(VpaDCotacao : TRBDOrcamento);
    procedure CarDOrcamentoServico(VpaDCotacao : TRBDOrcamento);
    procedure CarDTipoOrcamento(VpaDCotacao : TRBDOrcamento);
    procedure CarFlaSituacao(VpaDCotacao : TRBDOrcamento);
    procedure CarFlaPendente(VpaDCotacao : TrBDOrcamento);
    procedure CarParcelasContasAReceber(VpaDOrcamento : TRBDOrcamento);
    procedure ExcluiMovOrcamento(VpaCodFilial, VpaLanOrcamento : Integer);
    procedure VerificaPrecoCliente(VpaCodCliente : Integer;VpaDProCotacao : TRBDOrcProduto);
    function ExtornaNotaOrcamento(VpaCodFilial,VpaLanOrcamento : Integer):String;
    function EstornaEstoqueOrcamento(VpaDCotacao : TRBDOrcamento) : String;
    function ExtornaBrindeCliente(VpaDCotacao : TRBDOrcamento) : String;
    function EstagioFinal(VpaCodEstagio : Integer) : Boolean;
    function BaixaProdutosDevolvidos(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento;Var VpaValoraDevolver : Double): String;
    function BaixaProdutosOrcamentoQueVirouVenda(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento) : string;
    function GravaDBaixaParcialOrcamentoCorpo(VpaDCotacao : TRBDorcamento) : TRBDOrcamentoParcial;
    function GravaDBaixaParcialOrcamentoItem(VpaDBaixaCorpo : TRBDOrcamentoParcial;VpaDBaixaItem : TRBDProdutoOrcParcial):String;
    function GravaDEmail(VpaDCotacao: TRBDOrcamento; VpaDesEmail : String): String;
    procedure CopiaDCotacao(VpaDCotacaoDe, VpaDCotacaoPara : TRBDOrcamento;VpaCopiarItems : Boolean);
    procedure CopiaDProdutoCotacao(VpaDCotacaoDe, VpaDCotacaoPara : TRBDOrcamento);overload;
    function GeraFinanceiroEstagio(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio : Integer):String;
    procedure DuplicaDadosItemOrcamento(VpaDItemOrigem,VpaDItemDestino : TRBDOrcProduto);
    procedure MontaEmailCotacaoTexto(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente);
    procedure MontaCabecalhoEmail(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaEnviarImagem : Boolean);
    procedure MontaEmailCotacao(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaEnviarImagem : Boolean);
    function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP) : string;
    function VerificaSeparacaoTotal(VpaDCotacao : TRBDOrcamento;Var VpaIndTotal : Boolean):string;
    function BaixaEstoqueCartuchoAssociado(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):string;
    function BaixaProdutosASeparar(VpaDCotacao, VpaDCotacaoNova : TRBDOrcamento):String;
    function BaixaEstoqueSaldoAlteracao(VpaDSaldo : TRBDOrcamento) :string;
    function RSeqEmailDisponivel(VpaCodFilial, VpaLanOrcamento : Integer ): Integer;
    function RValComissao(VpaDCotacao : TRBDOrcamento;VpaTipComissao : Integer;VpaPerComissao, VpaPerComissaoPreposto : Double):Double;
    function RProdutoPendente(VpaProdutos : TList;VpaSeqProduto : Integer) : TRBDProdutoPendenteMetalVidros;
    procedure CarDProdutoPendenteMetalVidros(VpaProdutos : TList;VpaDatInicio, VpaDatFim : TDateTime);
    procedure OrdenaProdutosPendentes(VpaProdutos : TList);
    procedure SalvaArquivoProdutoPendente(VpaProduto : TList);
    procedure SubtraiQtdAlteradaCotacaoInicial(VpaDSaldoCotacao, VpaDCotacaoAlterada : TRBDOrcamento);
  public
    constructor Cria(VpaBaseDados : TSQLConnection);
    destructor Destroy;override;
    procedure RetornaDadosTransportadora(CodTrans: integer; var Nome, CNPJ_CPF,
      Endereco, Cidade, UF, IE: string);
    function RCodCliente(VpaCodFilial, VpaLanOrcamento : Integer):Integer;
    procedure InseriNovoOrcamento(VpaMovOrcamento : TDataSet;VpaLanOrcamento,VpaSeqProduto : Integer;
                                               VpaValorVenda : Double; VpaCodUnidade : String);
    function AdicionaFinanceiroArqRemessa(VpaDCotacao : TRBDOrcamento):String;
    procedure AdicionaDescontoCotacaoDePara(VpaDCotacaoDE,VpaDCotacaoPara : TRBDOrcamento);
    procedure AdicionaPaginasLogAlteracao(VpaDCotacao : TRBDOrcamento;VpaPaginas : TpageControl);
    procedure CarDOrcamento(VpaDOrcamento : TRBDOrcamento;VpaCodFilial : Integer = 0;VpaLanOrcamento : Integer = 0);
    procedure CarDParcelaOrcamento(VpaDOrcamento : TRBDOrcamento);
    procedure CarDtipoCotacao(VpaDTipoCotacao : TRBDTipoCotacao;VpaCodTipoCotacao : Integer);
    procedure CarComposeCombinacao(VpaDProCotacao : TRBDOrcProduto);
    procedure CarPrecosProdutosRevenda(VpaDCotacao : TRBDOrcamento);
    function RProdutoCotacao(VpaDCotacao : TRBDOrcamento;VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer;VpaValUnitario : Double):TRBDOrcProduto;
    function RServicoCotacao(VpaDCotacao : TRBDOrcamento; VpaCodServico : Integer): TRBDOrcServico;
    function RSeqNotaFiscalCotacao(VpaCodFilial,VpaLanOrcamento : Integer):Integer;
    function RTipoOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) : Integer;
    function RNomeTipoOrcamento(VpaTipCotacao : Integer) : string;
    function RVendedorUltimaCotacao : Integer;
    function RNomTransportadora(VpaCodTransportadora : Integer) : string;
    function RNomVendedor(VpaCodVendedor : Integer):string;
    function REmailVencedor(VpaCodVendedor : Integer) : string;
    function ROrdemProducao(VpaCodFilial,VpaLanOrcamento, VpaItemOrcamento : Integer) : Integer;
    function RValTotalCotacaoParcial(VpaDCotacao : TRBDOrcamento) : Double;
    procedure VerificaBrindeCliente(VpadCotacao : TRBDOrcamento;VpaDItemCotacao :TRBDOrcProduto);
    function VerificaProdutoDuplicado(VpaDCotacao : TRBDOrcamento;VpaDItemCotacao : TRBDOrcProduto):Boolean;
    function ExisteProduto(VpaCodProduto : String;VpaCodTabelaPreco : Integer;VpaDProCotacao : TRBDOrcProduto;VpaDCotacao : TRBDOrcamento):Boolean;
    function ExisteServico(VpaCodServico : String;VpaDSerCotacao : TRBDOrcServico):Boolean;
    function Existecor(VpaCodCor :String;VpaDProCotacao : TRBDOrcProduto):Boolean;
    function ExisteTamanho(VpaCodTamanho : String;var VpaNomTamanho : string):Boolean;
    function ExisteEmbalagem(VpaCodEmbalagem :String;VpaDProCotacao : TRBDOrcProduto):Boolean;
    function ExisteBaixaParcial(VpaDCotacao : TRBDOrcamento) : Boolean;
    function ExtornaOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) :String;
    procedure CancelaOrcamento(VpacodFilial,VpaLanOrcamento : Integer);
    function CancelaSaldoItemOrcamento(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento : Integer):string;
    procedure cancelaFinanceiroNota(VpaCodigoFilial, VpaLanOrcamento : integer);
    procedure ReservaProduto(VpaSeqProduto, VpaUnidade : String; VpaQtd : Double);
    procedure BaixaReservaProdutoOrcamento(VpaCodFilial, VpaLanOrcamento : Integer);
    procedure BaixaReserva(VpaCodFilial, VpaSeqProduto : Integer; VpaUnidade : String; VpaQtd : Double);
    function BaixaProdutosEtiquetadosSeparados(VpaDCotacao : TRBDOrcamento):String;
    function BaixaProdutosParcialCotacao(VpaDCotacao : TRBDOrcamento):String;
    function RetornaValorTotalOrcamento(VpaMovOrcamento : TDataSet): Double;
    procedure BaixaOrcamento(VpaDOrcamento : TRBDOrcamento);overload;
    procedure ExcluiOrcamento(VpaCodFilial,VpaLanOrcamento : Integer;VpaEstornarEstoque : Boolean = true);
    function ExcluiBaixaParcialCotacao(VpaCodFilial, VpaLanOrcamento, VpaSeqParcial : Integer) : string;
    function ExcluiFinanceiroOrcamento(VpaCodFilial,VpaLanOrcamento : Integer;VpaFazerVerificacoes : boolean=true) : String;
    function ExcluiFinanceiroCotacoes(VpaCotacoes : TList):String;
    function GeraFinanceiro(VpaDOrcamento : TRBDOrcamento; VpaDCliente : TRBDCliente; VpaDContaReceber : TRBDContasCR; VpaFunContaAReceber : TFuncoesContasAReceber;var VpaResultado : String;VpaGravarRegistro : Boolean;VpaMostrarParcela :Boolean=true):Boolean;
    function GeraFinanceiroParcial(VpaDOrcamento : TRBDOrcamento;VpaFunContaAReceber : TFuncoesContasAReceber;VpaSeqParcial : Integer;var VpaResultado : String):Boolean;
    function GeraEstoqueProdutos(VpaDOrcamento : TRBDOrcamento; FunProduto : TFuncoesProduto):String;
    function GeraContasaPagarDevolucaoCotacao(VpaDCotacao : TRBDOrcamento; VpaValor : Double):String;
    function GeraContasAReceberDevolucaoCotacao(VpaDOrcamento : TRBDOrcamento; VpaValor : Double):String;
    procedure SetaFinanceiroGerado(VpaDOrcamento : TRBDOrcamento);
    procedure SetaOPImpressa(VpaCotacoes : TList);
    procedure SetaOrcamentoImpresso(VpaCodFilial,VpaLanOrcamento : Integer);
    procedure SetaOrcamentoProcessado(VpaCodFilial,VpaLanOrcamento : Integer);
    procedure SetaOrcamentoNaoProcessado(VpaCodFilial,VpaLanOrcamento : Integer);
    procedure SetaDataOpGeradaProduto(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento, VpaSeqOrdemProducao : Integer);
    procedure AtualizaDCliente(VpaDCotacao :TRBDOrcamento;VpaDCliente : TRBDCliente);
    function GravaDCotacao(VpaDCotacao : TRBDOrcamento;VpaDCliente:TRBDCliente) : String;
    function GravaDProdutoCotacao(VpaDCotacao : TRBDOrcamento):String;
    function GravaDServicoCotacao(VpaDCotacao : TRBDOrcamento):String;
    function GravaBaixaParcialCotacao(VpaDCotacao : TRBDOrcamento;Var VpaSeqParcial : Integer) : String;
    function GravaDCompose(VpaDCotacao : TRBDOrcamento) : string;
    function GeraComplementoCotacao(VpaDCotacao : TRBDOrcamento;Var VpaLanOrcamentoRetorno : Integer) : string;
    function GravaLogEstagio(VpaCodFilial,VpaLanOrcamento,VpaCodEstagio,VpaCodUsuario : Integer;VpaDesMotivo : String) :string;
    function GravaCartuchoCotacao(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):string;
    procedure GravaVendedorUltimaCotacao(VpaCodVendedor : Integer);
    procedure CalculaValorTotal(VpaDCotacao : TRBDOrcamento);
    procedure CalculaPesoLiquidoeBruto(VpaDCotacao : TRBDOrcamento);
    procedure AlteraPrecoProdutosPorCliente(VpaDCotacao : TRBDOrcamento);
    function AlteraEstagioCotacao(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio : Integer;VpaDesMotivo : String):String;
    function AlteraEstagioCotacoes(VpaCodFilial, VpaCodUsuario, VpaCodEstagio : Integer;VpaCotacoes, VpaDesMotivo : String):String;
    procedure AlteraVendedor(VpaDCotacao : trbdorcamento);
    procedure AlteraPreposto(VpaDCotacao : trbdorcamento);
    procedure AlteraTipoCotacao(VpaDCotacao : TRBDOrcamento;VpaCodTipoCotacao : Integer);
    procedure AlteraTransportadora(VpaDCotacao : TRBDOrcamento;VpaCodTransportadora : Integer);
    function AlteraCotacaoParaPedido(VpaDCotacao : TRBDOrcamento):String;
    function BaixaAlteracaoCotacao(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : String;
    function BaixaNumero(VpaCodFilial,VpaLanOrcamento : Integer):boolean;
    function RValTotalOrcamentoNoMovEstoque(VpaCodFilial,VpaLanOrcamento : Integer) : Double;
    procedure ZeraQtdBaixada(VpaDOrcamento : trbdorcamento);
    function FaturarTodosProdutos(VpaDCotacao : TRBDOrcamento):Boolean;
    procedure ImprimirBoletos(VpaCodFilial, VpaLanOrcamento : Integer;VpaDCliente : TRBDCliente;VpaImpressora : String);
    function ExisteOpGerada(VpaCodFilial, VpaLanOrcamento : Integer;VpaAvisar : Boolean):Boolean;
    function EnviaEmailCotacaoTransportadora(VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : string;
    function EnviaEmailCliente(VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : string;
    function VerificacoesMedicamentoControlado(VpaDCotacao : TRBDOrcamento;VpaDProCotacao : TRBDOrcProduto):boolean;
    function ExisteProdutoSemBaixar(VpaCotacoes : TList): Boolean;
    function AgrupaCotacoes(VpaCotacoes : TList;VpaIndCopia : Boolean) : TRBDOrcamento;
    procedure ExcluiCotacoesAgrupadas(VpaCotacoes : TList);
    function TodosCartuchosAssociados(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):Boolean;
    procedure CopiaDCotacaoProposta(VpaDProsposta: TRBDPropostaCorpo;  VpaDCotacao: TRBDOrcamento);
    procedure CopiaDProdutoCotacao(VpaDProCotacaoDe, VpaDProCotacaoPara : TRBDOrcProduto);overload;
    function DuplicaProduto(VpaDCotacao : TRBDOrcamento; VpaDProCotacao : TRBDOrcProduto): TRBDOrcProduto;
    procedure ExportaProdutosPendentes(VpaDatInicio, VpaDatFim : TDateTime);
    procedure AtualizaEntradaMetrosDiario(VpaDatInicio, VpaDatFim : TDatetime);
    procedure ImprimeEtiquetaSeparacaoPedido(VpaDCotacao : TRBDOrcamento);
end;

var
  FunCotacao : TFuncoesCotacao;

implementation

uses FunSql, Constantes, FunString,FunObjeto, UnNotaFiscal, ConstMsg, unClientes, FunData,
     FunNumeros;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          eventos da classe localiza
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************* localiza o orcamento *******************************}
procedure TLocalizaCotacao.LocalizaMovOrcamento(VpaTabela : TDataSet;VpaCodFilial, VpaLanOrcamento : String);
begin
  AdicionaSQLAbreTabela( VpaTabela,'Select * from MovOrcamentos '+
                         ' Where I_emp_fil = ' + VpaCodFilial +
                         ' and I_Lan_Orc = ' + VpaLanOrcamento +
                         ' order by C_Cod_Pro');
end;

{*************** verifica se o produto ja existe no orcamento *****************}
function TLocalizaCotacao.ExisteProdutoOrcamento(VpaMovOrcamento : TDataSet;VpaCodFilial,VpaLanOrcamento,VpaSeqProduto : Integer):Boolean;
begin
  result := VpaMovOrcamento.Locate('I_Emp_fil;I_Lan_Orc;I_Seq_Pro',VarArrayOf([VpaCodFilial,VpaLanOrcamento,VpaSeqProduto]),[locaseinsensitive]);
end;

{************************* localiza o cadorcamento ****************************}
procedure TLocalizaCotacao.LocalizaCadOrcamento(VpaTabela : TDataSet;VpaLanOrcamento : String);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from CadOrcamentos'+
                                  ' Where I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil) +
                                  ' and I_Lan_Orc = ' + VpaLanOrcamento);
end;

{******************* localiza o movservico orcamento **************************}
procedure TLocalizaCotacao.LocalizaMovServicoOrcamento(VpaTabela : TDataSet;VpaLanOrcamento : String);
begin
  AdicionaSQLAbreTabela( VpaTabela,'Select * from MovServicoOrcamento '+
                         ' Where I_emp_fil = ' + IntToStr(Varia.CodigoEmpFil) +
                         ' and I_Lan_Orc = ' + VpaLanOrcamento +
                         ' order by I_Cod_Ser');
end;

{******************************************************************************}
procedure TLocalizaCotacao.LocalizaCliente(VpaTabela : TDataSet;VpaCodCliente : String);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from CADCLIENTES '+
                                  'Where I_COD_CLI = '+VpaCodCliente);
end;

{******************************************************************************}
procedure TLocalizaCotacao.LocalizaEntradaMetrosDiario(VpaTabela : TDataSet;VpaDatInicio,VpaDatFim : TDateTime);
begin
  AdicionaSQLAbreTabela(VpaTabela,'SELECT  CAD.D_DAT_ORC, CAD.I_TIP_ORC, CAD.I_COD_CLI, '+
                    ' CAD.I_COD_VEN, CAD.I_VEN_PRE,  '+
                    ' MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.C_COD_PRO, MOV.N_VLR_TOT, '+
                    ' PRO.C_COD_CLA, PRO.C_NOM_PRO, PRO.I_CMP_PRO, PRO.I_COD_EMP '+
                    ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                    ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                    ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                    ' AND CAD.C_IND_CAN = ''N'''+
                    ' AND CAD.D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                    ' AND CAD.D_DAT_ORC <= '+SQLTextoDataAAAAMMMDD(VpaDatFim)+
                    'ORDER BY PRO.C_COD_CLA, CAD.I_COD_CLI, CAD.I_COD_VEN, CAD.I_VEN_PRE ');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          eventos da classe funcoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************************** cria a classe **********************************}
constructor TFuncoesCotacao.Cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  VprBaseDados := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Kit := TSQLQuery.Create(nil);
  Kit.SQLConnection := VpaBaseDados;
  ProdutosNota := TSQLQuery.Create(nil);
  ProdutosNota.SQLConnection := VpaBaseDados;
  IndiceUnidade :=  TConvUnidade.create(nil);
  IndiceUnidade.ADataBase := VpaBaseDados;
  Orcamento := TSQLQuery.Create(nil);
  Orcamento.SQLConnection := VpaBaseDados;
  CotCadastro := TSQL.Create(nil);
  CotCadastro.ASQLConnection := VpaBaseDados;
  CotCadastro2 := TSQL.Create(nil);
  CotCadastro2.ASQLConnection := VpaBaseDados;
  IndiceUnidade.AInfo.UniNomeTabela := 'MovIndiceConversao';
  IndiceUnidade.AInfo.UniCampoDE := 'C_Uni_Atu';
  IndiceUnidade.AInfo.UniCampoPARA := 'C_Uni_Cov';
  IndiceUnidade.AInfo.UniCampoIndice := 'N_Ind_Cov';
  IndiceUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  IndiceUnidade.AInfo.UnidadeUN := Varia.UnidadeUN;
  IndiceUnidade.AInfo.UnidadeKit := Varia.UnidadeKit;
  IndiceUnidade.AInfo.Unidadebarra := Varia.Unidadebarra;
  IndiceUnidade.AInfo.ProCampoIndice := 'I_Ind_Cov';
  IndiceUnidade.AInfo.ProCampoCodigo := 'I_Seq_Pro';
  IndiceUnidade.AInfo.ProCampoFilial := 'I_Cod_Emp';
  IndiceUnidade.AInfo.ProNomeTabela := 'CadProdutos';
  //cria a valida unidade;
  ValidaUnidade := TValidaUnidade.create(nil);
  ValidaUnidade.ADataBase := VpaBaseDados;
  ValidaUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ValidaUnidade.Ainfo.UnidadeUN := varia.unidadeUN;
  ValidaUnidade.Ainfo.UnidadeKit := varia.unidadeKit;
  ValidaUnidade.Ainfo.UnidadeBarra := varia.unidadeBarra;
  ValidaUnidade.AInfo.CampoIndice := 'N_IND_COV';
  ValidaUnidade.AInfo.CampoUnidadeDE := 'C_UNI_ATU';
  ValidaUnidade.AInfo.CampoUnidadePARA := 'C_UNI_COV';
  ValidaUnidade.AInfo.NomeTabelaIndice  := 'MOVINDICECONVERSAO';
  //criar parcelas
  CriaParcelas := TCriaParcelasReceber.create(nil);
  CriaParcelas.info.ConCampoCodigoCondicao := 'I_COD_PAG';
  CriaParcelas.info.ConCampoQdadeParcelas := 'I_QTD_PAR';
  CriaParcelas.info.ConIndiceReajuste := 'N_IND_REA';
  CriaParcelas.info.ConNomeTabelaCondicao := 'CADCONDICOESPAGTO';
  CriaParcelas.info.ConPercAteVencimento := 'N_PER_DES';
  CriaParcelas.info.MovConCampoCreDeb := 'C_CRE_DEB';
  CriaParcelas.info.MovConCampoDataFixa := 'D_DAT_FIX';
  CriaParcelas.info.MOvConCampoDiaFixo := 'I_DIA_FIX';
  CriaParcelas.info.MovConCampoNumeroDias := 'I_NUM_DIA';
  CriaParcelas.info.MovConCampoNumeroParcela := 'I_NRO_PAR';
  CriaParcelas.info.MovConCampoPercentualCon := 'N_PER_CON';
  CriaParcelas.info.MovConCampoPercPagamento := 'N_PER_PAG';
  CriaParcelas.info.MovConCaracterCrePer := 'C';
  CriaParcelas.info.MovConCaracterDebPer := 'D';
  CriaParcelas.info.MovConNomeTabela := 'MOVCONDICAOPAGTO';
  CriaParcelas.ADataBase := VpaBaseDados;
  //componentes indy
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);

  FunVendedor := TRBFuncoesVendedor.cria(VpaBaseDados);
end;

{******************************************************************************}
destructor TFuncoesCotacao.Destroy;
begin
  Aux.free;
  Kit.free;
  Orcamento.free;
  ProdutosNota.free;
  IndiceUnidade.free;
  CotCadastro.free;
  CotCadastro2.free;
  ValidaUnidade.Free;
  CriaParcelas.free;
  VprMensagem.free;
  VprSMTP.free;
  FunVendedor.free;
  inherited destroy;
end;

procedure TFuncoesCotacao.RetornaDadosTransportadora(CodTrans: integer; var Nome,
CNPJ_CPF, Endereco, Cidade, UF, IE: string);
begin
  AdicionaSQLAbreTabela(Aux, ' select * from CADTRANSPORTADORAS ' +
                             ' where I_COD_TRA = ' + IntToStr(CodTrans));

  Nome     := Aux.fieldbyname('C_NOM_TRA').AsString;
  CNPJ_CPF := Aux.fieldbyname('C_CGC_TRA').AsString;
  Endereco := Aux.fieldbyname('C_END_TRA').AsString + ' ' + Aux.fieldbyname('I_NUM_TRA').AsString;
  Cidade   := Aux.fieldbyname('C_CID_TRA').AsString;
  UF       := Aux.fieldbyname('C_EST_TRA').AsString;
  IE       := Aux.fieldbyname('C_INS_TRA').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RProximoLanOrcamento : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(I_LAN_ORC) ULTIMO from CADORCAMENTOS '+
                            ' where I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RProximoSeqParcialOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(SEQPARCIAL) ULTIMO from ORCAMENTOPARCIALCORPO '+
                            ' Where CODFILIAL = '+ IntTostr(VpaCodFilial)+
                            ' and LANORCAMENTO = '+ IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
end;

{******************************************************************************}
function TFuncoesCotacao.RProximoSeqEstagioOrcamento(VpaCodfilial,VpaLanOrcamento : integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(SEQESTAGIO) ULTIMO from ESTAGIOORCAMENTO '+
                            ' Where CODFILIAL = '+InttoStr(VpaCodfilial)+
                            ' and SEQORCAMENTO = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RValTotalCotacaoParcial(VpaDCotacao : TRBDOrcamento) : Double;
var
  VpfLaco : Integer;
  VpfDItemCotacao : TRBDOrcProduto;
begin
  result := 0;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItemCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDItemCotacao.QtdABaixar <> 0 then
    begin
      result := result + (VpfdItemCotacao.qtdABaixar * VpfDItemCotacao.ValUnitario);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.REstagioAtualCotacao(VpaCodFilial,VpaLanOrcamento : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_EST from CADORCAMENTOS '+
                            ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('I_COD_EST').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RQtdBrindeProdutoCliente(VpaCodCliente,VpaSeqProduto : Integer;VpaUM : String) : Double;
begin
  result := 0;
  AdicionaSQLAbreTabela(Aux,'Select QTDPRODUTO, DESUM from BRINDECLIENTE '+
                            ' Where CODCLIENTE = '+IntToStr(VpaCodCliente)+
                            ' and SEQPRODUTO = '+IntToStr(VpaSeqProduto));
  if not Aux.Eof then
    result := FunProdutos.CalculaQdadePadrao(Aux.FieldByName('DESUM').AsString,VpaUM,Aux.FieldByName('QTDPRODUTO').AsFloat,IntToStr(VpaSeqproduto));
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.REmailTransportadora(VpaCodTransportadora : Integer):string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_END_ELE from CADTRANSPORTADORAS'+
                            ' Where I_COD_TRA = '+IntToStr(VpaCodTransportadora));
  result := Aux.FieldByname('C_END_ELE').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RTextoAcrescimoDesconto(VpaDCotacao : TRBDOrcamento):String;
begin
  result := '';
  if (VpaDCotacao.PerDesconto > 0) or (VpaDCotacao.ValDesconto > 0) then
    result := 'Desconto'
  else
    if (VpaDCotacao.PerDesconto < 0) or (VpaDCotacao.PerDesconto < 0) then
      result := 'Acréscimo';
end;

{******************************************************************************}
function TFuncoesCotacao.RValorAcrescimodesconto(VpaDCotacao : TRBDORcamento):String;
begin
  result := '';
  if VpaDCotacao.PerDesconto > 0 then
    result := FormatFloat('0%',VpaDCotacao.PerDesconto)
  else
    if VpaDCotacao.PerDesconto < 0 then
      result := FormatFloat('0%',VpaDCotacao.PerDesconto*-1);
  if VpaDCotacao.ValDesconto > 0 then
    Result := FormatFloat(varia.MascaraValor,VpaDCotacao.ValDesconto)
  else
    if VpaDCotacao.ValDesconto > 0 then
      Result := FormatFloat(varia.MascaraValor,VpaDCotacao.ValDesconto*-1);

end;

{******************************************************************************}
function TFuncoesCotacao.VerificacoesMedicamentoControlado(VpaDCotacao : TRBDOrcamento;VpaDProCotacao : TRBDOrcProduto):boolean;
begin
  result := true;
  if VpaDProCotacao.IndMedicamentoControlado then
  begin
    if VpaDCotacao.CodCliente = 0 then
    begin
      aviso('CLIENTE NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher o cliente.');
      result := false;
    end;
    if result then
    begin
      if VpaDProCotacao.DesRegistroMSM = '' then
      begin
        aviso('REGISTRO DO MSM NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher no cadastro do produto o registro do MSM.');
        result := false;
      end;
      if result then
      begin
        if VpaDProCotacao.CodPrincipioAtivo = 0 Then
        begin
          result := false;
          aviso('PRINCIPIO ATIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o principio ativo do medicamento.');
        end;
        if result then
        begin
          if VpaDCotacao.CodMedico = 0 then
          begin
            aviso('MÉDICO NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher o médico.');
            result := false;
          end;
          if result then
          begin
            if VpaDCotacao.TipReceita <= 0 then
            begin
              aviso('TIPO RECEITA NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher o tipo da receita.');
              result := false;
            end;
            if result then
            begin
              if VpaDCotacao.NumReceita = '' then
              begin
                aviso('NUMERO DA RECEITA NÃO PREENCHIDO!!!'#13'Antes de vender um produto controlado é necessário preencher o número da receita.');
                result := false;
              end;
              if result then
              begin
                if VpaDCotacao.DatReceita < montadata(1,1,1900) then
                begin
                  aviso('DATA DA RECEITA NÃO PREENCHIDA!!!'#13'Antes de vender um produto controlado é necessário preencher a data da receita.');
                  result := false;
                end;
                if result then
                begin
                  if VpaDCotacao.RGCliente = '' then
                  begin
                    aviso('RG DO CLIENTE NÃO PREENCHIDO!!!'#13'É necessario informar o RG do cliente.');
                    result := false;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteProdutoSemBaixar(VpaCotacoes : TList): Boolean;
var
  VpfLacoCotacao, VpfLacoProduto : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacao : TRBDOrcProduto;
begin
  result := false;
  for VpfLacoCotacao := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoCotacao]);
    for VpfLacoProduto := 0 to VpfDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProduto]);
      if VpfDProCotacao.QtdBaixado < VpfDProCotacao.QtdProduto then
      begin
        aviso('EXISTEM PRODUTOS NÃO BAIXADOS!!!'#13'Não é possivel agrupar esse pedidos pois existe produtos não baixados');
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDComposeProduto(VpaDCotacao : trbdorcamento;VpaDProdutoOrc : TRBDOrcProduto);
var
  VpfDCompose : TRBDOrcCompose;
begin
  AdicionaSQLAbreTabela(Kit,'Select COM.SEQCOMPOSE, COM.CORREFERENCIA, COM.SEQPRODUTO, COM.CODCOR, '+
                            ' PRO.C_NOM_PRO, PRO.C_COD_PRO, '+
                            ' COR.NOM_COR '+
                            ' from ORCAMENTOITEMCOMPOSE COM, CADPRODUTOS PRO, COR '+
                            ' Where COM.CODFILIAL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                            ' and COM.LANORCAMENTO = '+IntToStr(VpaDCotacao.LanOrcamento)+
                            ' and COM.SEQMOVIMENTO = '+IntToStr(VpaDProdutoOrc.SeqMovimento)+
                            ' and COM.SEQPRODUTO = PRO.I_SEQ_PRO '+
                            ' AND COM.CODCOR = COR.COD_COR '+
                            ' ORDER BY COM.CORREFERENCIA');
  While not kit.eof do
  begin
    VpfDCompose := VpaDProdutoOrc.AddCompose;
    VpfDCompose.SeqCompose := Kit.FieldByname('SEQCOMPOSE').AsInteger;
    VpfDCompose.CorRefencia := Kit.FieldByname('CORREFERENCIA').AsInteger;
    VpfDCompose.SeqProduto := Kit.FieldByname('SEQPRODUTO').AsInteger;
    VpfDCompose.CodCor := Kit.FieldByname('CODCOR').AsInteger;
    VpfDCompose.CodProduto := Kit.FieldByname('C_COD_PRO').AsString;
    VpfDCompose.NomProduto := Kit.FieldByname('C_NOM_PRO').AsString;
    VpfDCompose.NomCor := Kit.FieldByname('NOM_COR').AsString;
    kit.next;
  end;
  kit.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDOrcamentoProduto(VpaDCotacao : TRBDOrcamento);
Var
  VpfDProCotacao :TRBDOrcProduto;
begin
  AdicionaSQLAbreTabela(Orcamento,'Select COT.I_SEQ_MOV, COT.I_SEQ_PRO, COT.C_COD_PRO, COT.N_VLR_PRO, '+
                                  ' COT.N_QTD_PRO, COT.N_VLR_TOT, COT.C_COD_UNI, '+
                                  ' COT.C_IMP_FOT, COT.C_OBS_ORC, COT.C_FLA_RES, '+
                                  ' COT.C_IMP_DES, COT.N_PER_DES, N_QTD_BAI, COT.N_QTD_CON, C_DES_COR, '+
                                  ' COT.I_SEQ_MOV, COT.I_COD_COR, COT.D_ULT_ALT, COT.C_PRO_REF,'+
                                  ' COT.I_COD_EMB, COT.C_DES_EMB,COT.N_QTD_DEV, COT.C_IND_FAT, '+
                                  ' COT.C_IND_BRI, COT.N_SAL_BRI, COT.C_NOM_PRO PRODUTOCOTACAO, '+
                                  ' COT.D_DAT_ORC, '+
                                  ' COT.C_ORD_COM, COT.I_COD_TAM, COT.D_DAT_GOP, '+
                                  'PRO.C_NOM_PRO, PRO.N_PES_LIQ, PRO.N_PES_BRU, PRO.C_IND_RET, PRO.C_IND_CRA,  '+
                                  ' PRO.C_COD_UNI UNIORIGINAL, PRO.C_COD_CLA, PRO.N_PER_COM, I_IND_COV, PRO.I_MES_GAR, '+
                                  ' CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, CLA.C_ALT_QTD , CLA.C_IMP_ETI, '+
                                  ' TAM.NOMTAMANHO '+
                                  ' FROM MOVORCAMENTOS COT, CADPRODUTOS PRO, TAMANHO TAM, CADCLASSIFICACAO CLA '+
                                  ' Where COT.I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                                  ' AND  COT.I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento)+
                                  ' AND PRO.I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa)+
                                  ' AND PRO.I_SEQ_PRO = COT.I_SEQ_PRO' +
                                  ' AND '+SQLTextoRightJoin('COT.I_COD_TAM','TAM.CODTAMANHO')+
                                  ' AND PRO.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' order by COT.I_SEQ_MOV');
  while not Orcamento.eof do
  begin
    VpfDProCotacao := VpaDCotacao.AddProduto;
    with VpfDProCotacao do
    begin
      SeqMovimento := Orcamento.FieldByName('I_SEQ_MOV').AsInteger;
      SeqProduto := Orcamento.FieldByName('I_SEQ_PRO').AsInteger;
      CodCor := Orcamento.FieldByName('I_COD_COR').AsInteger;
      CodTamanho := Orcamento.FieldByname('I_COD_TAM').AsInteger;
      NomTamanho := Orcamento.FieldByname('NOMTAMANHO').AsString;
      CodProduto := Orcamento.FieldByName('C_COD_PRO').AsString;
      CodClassificacao := Orcamento.FieldByName('C_COD_CLA').AsString;
      if (config.PermiteAlteraNomeProdutonaCotacao) and (Orcamento.FieldByName('PRODUTOCOTACAO').AsString <> '' )then
        NomProduto := Orcamento.FieldByName('PRODUTOCOTACAO').AsString
      else
        NomProduto := Orcamento.FieldByName('C_NOM_PRO').AsString;
      DesCor := Orcamento.FieldByName('C_DES_COR').AsString;
      CodEmbalagem := Orcamento.FieldByName('I_COD_EMB').AsInteger;
      DesEmbalagem := Orcamento.FieldByName('C_DES_EMB').AsString;
      DesOrdemCompra := Orcamento.FieldByName('C_ORD_COM').AsString;
      DesObservacao := Orcamento.FieldByName('C_OBS_ORC').AsString;
      UM := Orcamento.FieldByName('C_COD_UNI').AsString;
      UMAnterior := UM;
      UMOriginal := Orcamento.FieldByName('UNIORIGINAL').AsString;
      IndImpFoto := Orcamento.FieldByName('C_IMP_FOT').AsString;
      IndImpDescricao := Orcamento.FieldByName('C_IMP_DES').AsString;
      IndFaturar := Orcamento.FieldByName('C_IND_FAT').AsString = 'S';
      IndCracha := Orcamento.FieldByName('C_IND_CRA').AsString = 'S';
      IndPermiteAlterarQtdnaSeparacao := Orcamento.FieldByName('C_ALT_QTD').AsString = 'S';
      IndImprimirEtiquetaSeparacao := Orcamento.FieldByName('C_IMP_ETI').AsString = 'S';
      QtdEstoque := 0;
      QtdMinima := 0;
      QtdPedido := 0;
      QtdBaixado := Orcamento.FieldByName('N_QTD_BAI').AsFloat;
      QtdConferidoSalvo := Orcamento.FieldByName('N_QTD_CON').AsFloat;
      QtdProduto := Orcamento.FieldByName('N_QTD_PRO').AsFloat;
      QtdKit := Orcamento.FieldByName('I_IND_COV').AsInteger;
      PerDesconto := Orcamento.FieldByName('N_PER_DES').AsFloat;
      PerComissao := Orcamento.FieldByName('N_PER_COM').AsFloat;
      PerComissaoClassificacao := Orcamento.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
      QtdDevolvido := Orcamento.FieldByName('N_QTD_DEV').AsFloat;
 {     QtdEstoque := Orcamento.FieldByName('QTDREAL').AsFloat;
      QtdMinima := Orcamento.FieldByName('N_QTD_MIN').AsFloat;
      QtdPedido := Orcamento.FieldByName('N_QTD_PED').AsFloat;}
      ValUnitario := Orcamento.FieldByName('N_VLR_PRO').AsFloat;
      ValTotal := Orcamento.FieldByName('N_VLR_TOT').AsFloat;
      DesRefClienteOriginal := Orcamento.FieldByName('C_PRO_REF').AsString;
      DesRefCliente := Orcamento.FieldByName('C_PRO_REF').AsString;
      PesLiquido := Orcamento.FieldByName('N_PES_LIQ').AsFloat;
      PesBruto := Orcamento.FieldByName('N_PES_BRU').AsFloat;
      UnidadeParentes.free;
      UnidadeParentes := ValidaUnidade.UnidadesParentes(UMOriginal) ;
      IndRetornavel := (Orcamento.FieldByName('C_IND_RET').AsString = 'S');
      IndBrinde := (Orcamento.FieldByName('C_IND_BRI').AsString = 'S');
      QtdSaldoBrinde := Orcamento.FieldByName('N_SAL_BRI').AsFloat;
      DatOpGerada := Orcamento.FieldByName('D_DAT_GOP').AsDateTime;
      DatOrcamento := Orcamento.FieldByName('D_DAT_ORC').AsDateTime;
      QtdMesesGarantia := Orcamento.FieldByName('I_MES_GAR').AsInteger;
      FunProdutos.CarValVendaeRevendaProduto(VpaDCotacao.CodTabelaPreco,VpfDProCotacao.SeqProduto,VpfDProCotacao.CodCor,VpfDProCotacao.CodTamanho,
                                             VpaDCotacao.CodCliente,VpfDProCotacao.ValUnitarioOriginal,VpfDProCotacao.ValRevenda);
    end;
    CarDComposeProduto(VpaDCotacao,VpfDProCotacao);
    Orcamento.next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDOrcamentoServico(VpaDCotacao : TRBDOrcamento);
var
  VpfDSErCotacao : TRBDOrcServico;
begin
  AdicionaSQLAbreTabela(Orcamento,'Select MOV.I_COD_SER, MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.C_DES_ADI, '+
                                  ' MOV.N_VLR_TOT, CAD.C_NOM_SER, CAD.N_PER_ISS '+
                                  ' from MOVSERVICOORCAMENTO MOV, CADSERVICO CAD ' +
                                   ' WHERE CAD.I_COD_EMP = '+ IntToStr(varia.CodigoEmpresa)+
                                   ' AND CAD.I_COD_SER = MOV.I_COD_SER '+
                                   ' AND MOV.I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil)+
                                   ' AND MOV.I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento)+
                                   ' and MOV.I_COD_SER = CAD.I_COD_SER ');
  while not Orcamento.Eof do
  begin
    VpfDSErCotacao := VpaDCotacao.AddServico;
    with VpfDSErCotacao do
    begin
      CodServico := Orcamento.FieldByName('I_COD_SER').AsInteger;
      NomServico := Orcamento.FieldByName('C_NOM_SER').AsString;
      DesAdicional := Orcamento.FieldByName('C_DES_ADI').AsString;
      QtdServico := Orcamento.FieldByName('N_QTD_SER').AsFloat;
      ValUnitario := Orcamento.FieldByName('N_VLR_SER').AsFloat;
      ValTotal := Orcamento.FieldByName('N_VLR_TOT').AsFloat;
      PerISSQN := Orcamento.FieldByName('N_PER_ISS').AsFloat;
    end;
    orcamento.Next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDTipoOrcamento(VpaDCotacao : TRBDOrcamento);
begin
  if VpaDCotacao.CodTipoOrcamento <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from CADTIPOORCAMENTO '+
                              ' Where I_COD_TIP = '+IntToStr(VpaDCotacao.CodTipoOrcamento));
    VpaDCotacao.CodPlanoContas := Aux.FieldByName('C_CLA_PLA').AsString;
    VpaDCotacao.CodOperacaoEstoque := Aux.FieldByName('I_COD_OPE').AsInteger;;
    Aux.close;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarFlaSituacao(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
begin
//10/11/2008 - colocado em comentario porque os pedidos da filial 13 edson estava deixando em aberto.
//  if not config.GerarFinanceiroCotacao then
//  begin
    VpaDCotacao.FlaSituacao := 'E';
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      if TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto <> TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdBaixado then
      begin
        VpaDCotacao.FlaSituacao := 'A';
        break;
      end;
    end;
    if VpaDCotacao.Produtos.Count = 0 then
    begin
      if VpaDCotacao.FinanceiroGerado or VpaDCotacao.IndNotaGerada then
        VpaDCotacao.FlaSituacao := 'E'
      else
        VpaDCotacao.FlaSituacao := 'A';
    end;

//  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarFlaPendente(VpaDCotacao : TrBDOrcamento);
var
  VpfLaco : Integer;
begin
  VpaDCotacao.IndPendente := false;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    if (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).IndRetornavel) and (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto > TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdDevolvido) then
    begin
      VpaDCotacao.IndPendente := true;
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarParcelasContasAReceber(VpaDOrcamento : TRBDOrcamento);
begin
  AdicionaSQLAbreTabela(Aux,'select MOV.I_NRO_PAR, MOV.D_DAT_VEN, MOV.N_VLR_PAR '+
                                  ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                                  ' where CAD.I_EMP_FIL = '+IntToStr(VpaDOrcamento.CodEmpFil)+
                                  ' and CAD.I_LAN_ORC = '+IntToStr(VpaDOrcamento.LanOrcamento) +
                                  ' and CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' and CAD.I_LAN_REC = MOV.I_LAN_REC'+
                                  ' order by I_NRO_PAR');
  while not  Aux.eof do
  begin
    VpaDOrcamento.Parcelas.add('*  '+CentraStr(Aux.FieldByName('I_NRO_PAR').AsString,6) + ' - '+
                           CentraStr(FormatDateTime('DD/MM/YYYY',Aux.FieldByName('D_DAT_VEN').AsDateTime) ,10) + ' - ' +
                           AdicionaBrancoE(Formatfloat(Varia.MascaraMoeda,Aux.FieldByName('N_VLR_PAR').AsFloat),17));

    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ExcluiMovOrcamento(VpaCodFilial, VpaLanOrcamento : Integer);
begin
  if (VpaLanOrcamento <> 0) then
  begin
    BaixaReservaProdutoOrcamento(VpaCodFilial,VpaLanOrcamento);
    sistema.GravaLogExclusao('MOVSERVICOORCAMENTO','Select * from MOVSERVICOORCAMENTO '+
                          ' Where I_Emp_Fil = ' + IntTostr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from MovServicoOrcamento '+
                          ' Where I_Emp_Fil = ' + IntTostr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
    sistema.GravaLogExclusao('MOVORCAMENTOS','Select * from MOVORCAMENTOS '+
                          ' Where I_Emp_Fil = ' + IntTostr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from MovOrcamentos '+
                          ' Where I_Emp_Fil = ' + IntTostr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));

  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.VerificaPrecoCliente(VpaCodCliente : Integer;VpaDProCotacao : TRBDOrcProduto);
begin
  if VpaDProCotacao.ValUnitarioOriginal <> FunProdutos.CalculaValorPadrao(VpaDProCotacao.UM,VpaDProCotacao.UMOriginal,VpaDProCotacao.ValUnitario,InttoStr(VpaDProCotacao.SeqProduto)) then
  begin
    AdicionaSQLAbreTabela(CotCadastro2,'Select * from MOVTABELAPRECO PRE '+
                              ' Where PRE.I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa) +
                              ' and PRE.I_COD_TAB = '+IntToStr(Varia.TabelaPreco)+
                              ' and PRE.I_SEQ_PRO = ' + IntToStr(VpaDProCotacao.SeqProduto) +
                              ' and PRE.I_COD_CLI = '+ Inttostr(VpaCodCliente));
    if CotCadastro2.Eof then
    begin
      CotCadastro2.Insert;
      CotCadastro2.FieldByName('I_COD_EMP').AsInteger := Varia.CodigoEmpresa;
      CotCadastro2.FieldByName('I_COD_TAB').AsInteger := varia.TabelaPreco;
      CotCadastro2.FieldByName('I_SEQ_PRO').AsInteger := VpaDProCotacao.SeqProduto;
      CotCadastro2.FieldByName('I_COD_TAM').AsInteger := VpaDProCotacao.CodTamanho;
      CotCadastro2.FieldByName('I_COD_COR').AsInteger := VpaDProCotacao.CodCor;
      CotCadastro2.FieldByName('I_COD_CLI').AsInteger := VpaCodCliente;
      CotCadastro2.FieldByName('I_COD_MOE').AsInteger := VARIA.MoedaBase;
      CotCadastro2.FieldByName('C_CIF_MOE').AsString := CurrencyString;
    end
    else
      CotCadastro2.Edit;

    CotCadastro2.FieldByName('N_VLR_VEN').AsFloat := FunProdutos.CalculaValorPadrao(VpaDProCotacao.UMOriginal,VpaDProCotacao.UM,VpaDProCotacao.ValUnitario,InttoStr(VpaDProCotacao.SeqProduto));
    CotCadastro2.FieldByName('D_ULT_ALT').AsDateTime := date;
    CotCadastro2.post;
  end;
  CotCadastro2.close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExtornaNotaOrcamento(VpaCodFilial,VpaLanOrcamento : Integer):String;
begin
  result := '';
  AdicionaSQLAbreTabela(Aux,'Select I_SEQ_NOT from MOVNOTAORCAMENTO '+
                            ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial) +
                            ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
  While not Aux.eof do
  begin
    result := FunNotaFiscal.CancelaNotaFiscal(VpaCodFilial,Aux.FieldByName('I_SEQ_NOT').AsInteger,false);
    if result <> '' then
      exit;
    Aux.Next;
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExcluiFinanceiroOrcamento(VpaCodFilial,VpaLanOrcamento : Integer;VpaFazerVerificacoes : boolean=true) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(Orcamento,'select CAD.I_LAN_REC '+
                                  ' from CADCONTASARECEBER CAD'+
                                  ' where CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and CAD.I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  if VpaFazerVerificacoes then
    result :=  FunContasAReceber.ContaAdicionadaRemessa(VpaCodFilial,Orcamento.FieldByName('I_LAN_REC').AsiNTEGER);
  if result = '' then
  begin
    While not Orcamento.Eof do
    begin
      result := FunContasAReceber.ExcluiConta(VpaCodFilial,Orcamento.FieldByName('I_LAN_REC').AsiNTEGER,false,true);
      if result <> '' then
      begin
        Orcamento.Close;
        exit;
      end;
      Orcamento.next;
    end;
  end;
  Orcamento.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExcluiFinanceiroCotacoes(VpaCotacoes : TList):String;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
    result := FunCotacao.ExcluiFinanceiroOrcamento(VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento);
    if result <> ''then
      exit;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EstornaEstoqueOrcamento(VpaDCotacao : TRBDOrcamento):String;
var
  VpfDProdutoOrc : TRBDOrcProduto;
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  result := funprodutos.OperacoesEstornoValidas;
  if result = '' then
  begin
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProdutoOrc := TRBDOrcProduto(VpaDCotacao.Produtos.Items[vpflaco]);
      if VpfDProdutoOrc.QtdBaixado > 0 then
      begin
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,0,VpaDCotacao.CodEmpFil,VpfDProdutoOrc.SeqProduto);
        FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaDCotacao.CodEmpFil, varia.OperacaoEstoqueEstornoEntrada,0,
                                      VpaDCotacao.LanOrcamento,VpaDCotacao.LanOrcamento,varia.MoedaBase,VpfDProdutoOrc.CodCor,
                                      VpfDProdutoOrc.CodTamanho, date,VpfDProdutoOrc.QtdBaixado,VpfDProdutoOrc.ValTotal,
                                      VpfDProdutoOrc.UM,
                                      VpfDProdutoOrc.DesRefCliente, false,VpfSeqEstoqueBarra);
        VpfDProduto.free;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExtornaBrindeCliente(VpaDCotacao : TRBDOrcamento) : String;
var
  VpfLaco : Integer;
  VpfDItem : TRBDOrcProduto;
begin
  result := '';
  for Vpflaco := 0 to VpaDCotacao.Produtos.Count -1 do
  begin
    VpfDItem := TRBDOrcProduto(vpadCotacao.Produtos.Items[Vpflaco]);
    if VpfDItem.IndBrinde then
    begin
      result := FunClientes.BaixaEstoqueBrinde(VpaDCotacao.CodCliente,VpfDItem.SeqProduto,VpfDItem.QtdProduto,VpfDItem.UM,false);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EstagioFinal(VpaCodEstagio : Integer) : Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from ESTAGIOPRODUCAO '+
                            ' Where CODEST = '+IntToStr(VpaCodEstagio));
  result := (Aux.FieldByName('INDFIN').AsString = 'S');
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosDevolvidos(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento;Var VpaValoraDevolver : Double): String;
var
  VpfDCotacaoSaldo : TRBDOrcamento;
  VpfBaixouProduto : Boolean;
  VpfDProdutoOrcInicial, VpfDProdutoOrc : TRBDOrcProduto;
  VpfQtdInicial, VpfQtdAtual, VpfPerDesconto : Double;
begin
  result := FunProdutos.OperacoesEstornoValidas;
  VpaValoraDevolver := 0;
  if result = '' then
  begin
    VpfDCotacaoSaldo := TRBDOrcamento.cria;
    CopiaDCotacao(VpaDCotacaoInicial,VpfDCotacaoSaldo,true);
    VpfDCotacaoSaldo.LanOrcamento := VpaDCotacaoInicial.LanOrcamento;
    SubtraiQtdAlteradaCotacaoInicial(VpfDCotacaoSaldo,VpaDCotacao);
    result := BaixaEstoqueSaldoAlteracao(VpfDCotacaoSaldo);
    VpfDCotacaoSaldo.free;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosOrcamentoQueVirouVenda(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento) : string;
var
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfDProdutoOrc : TRBDOrcProduto;
  VpfDProduto : TRBDProduto;
begin
  result := FunProdutos.OperacoesEstornoValidas;
  if result = '' then
  begin
    if (VpaDCotacaoInicial.CodOperacaoEstoque <> 0)  and (VpaDCotacao.CodOperacaoEstoque = 0) then
    begin
      for VpfLaco := 0 to VpaDCotacaoInicial.Produtos.Count - 1 do
      begin
        VpfDProdutoOrc := TRBDOrcProduto(VpaDCotacaoInicial.Produtos.Items[VpfLaco]);
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,0,VpaDCotacao.CodEmpFil,VpfDProdutoOrc.SeqProduto);
        if VpaDCotacaoInicial.DatOrcamento > Varia.DataUltimoFechamento then
        begin
          FunProdutos.ExcluiMovimentoEstoqueCotacao(VpaDCotacaoInicial.CodEmpFil,VpfDProdutoOrc.SeqProduto,VpaDCotacaoInicial.LanOrcamento,VpfDProdutoOrc.CodCor);
          FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaDCotacaoInicial.CodEmpFil,Varia.OperacaoEstoqueEstornoEntrada,0,
                                            VpaDCotacaoInicial.LanOrcamento,VpaDCotacaoInicial.LanOrcamento,varia.MoedaBase,VpfDProdutoOrc.CodCor, VpfDProdutoOrc.CodTamanho,
                                            date,VpfDProdutoOrc.QtdProduto,VpfDProdutoOrc.ValTotal,
                                            VpfDProdutoOrc.UM,VpfDProdutoOrc.DesRefCliente, false,VpfSeqEstoqueBarra,false);
        end
        else
          FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDCotacaoInicial.CodEmpFil, Varia.OperacaoEstoqueEstornoEntrada,0,
                                          VpaDCotacaoInicial.LanOrcamento,VpaDCotacaoInicial.LanOrcamento,varia.MoedaBase,VpfDProdutoOrc.CodCor, VpfDProdutoOrc.CodTamanho,
                                          date,VpfDProdutoOrc.QtdProduto,VpfDProdutoOrc.ValTotal,
                                          VpfDProdutoOrc.UM,VpfDProdutoOrc.DesRefCliente, false,VpfSeqEstoqueBarra,true);
        VpfDProduto.free;
      end;
    end
    else
      if (VpaDCotacaoInicial.CodOperacaoEstoque = 0)  and (VpaDCotacao.CodOperacaoEstoque <> 0) then
      begin
        for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
        begin
          VpfDProdutoOrc := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
          VpfDProduto := TRBDProduto.Cria;
          FunProdutos.CarDProduto(VpfDProduto,0,VpaDCotacao.CodEmpFil,VpfDProdutoOrc.SeqProduto);
          FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaDCotacao.CodEmpFil,Varia.OperacaoEstoqueEstornoSaida,0,
                                            VpaDCotacaoInicial.LanOrcamento,VpaDCotacaoInicial.LanOrcamento,varia.MoedaBase,VpfDProdutoOrc.CodCor,VpfDProdutoOrc.CodTamanho,
                                            date,VpfDProdutoOrc.QtdProduto,VpfDProdutoOrc.ValTotal,
                                            VpfDProdutoOrc.UM,VpfDProdutoOrc.DesRefCliente, false,VpfSeqEstoqueBarra,true);
          VpfDProduto.free;
        end;
      end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDBaixaParcialOrcamentoCorpo(VpaDCotacao : TRBDorcamento) : TRBDOrcamentoParcial;
begin
  result := TRBDOrcamentoParcial.cria;
  result.CodFilial := VpaDCotacao.CodEmpFil;
  result.LanOrcamento := VpaDCotacao.LanOrcamento;
  result.DatParcial := now;
  result.ValTotal := RValTotalCotacaoParcial(VpaDCotacao);
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ORCAMENTOPARCIALCORPO '+
                                    ' Where CODFILIAL = 0 AND LANORCAMENTO = 0 AND SEQPARCIAL = 0');
  CotCadastro.Insert;
  CotCadastro.FieldByName('CODFILIAL').AsInteger := Result.CodFilial;
  CotCadastro.FieldByName('LANORCAMENTO').AsInteger := Result.LanOrcamento;
  CotCadastro.FieldByName('DATPARCIAL').AsDateTime := Result.DatParcial;
  CotCadastro.FieldByName('CODUSUARIO').AsInteger := varia.CodigoUsuario;
  if VpaDCotacao.PerDesconto <> 0 then
    CotCadastro.FieldByname('PERDESCONTO').AsFloat := VpaDCotacao.PerDesconto;
  CotCadastro.FieldByName('VALTOTAL').AsFloat := Result.ValTotal;
  result.SeqParcial := RProximoSeqParcialOrcamento(result.CodFilial,result.Lanorcamento);
  CotCadastro.FieldByName('SEQPARCIAL').AsInteger := Result.SeqParcial;
  CotCadastro.post;
  if CotCadastro.AErronaGravacao then
  begin
    result.free;
    result := nil;
  end;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDBaixaParcialOrcamentoItem(VpaDBaixaCorpo : TRBDOrcamentoParcial;VpaDBaixaItem : TRBDProdutoOrcParcial):String;
begin
  result := '';
  AdicionaSqlAbreTabela(CotCadastro2,'Select * from ORCAMENTOPARCIALITEM'+
                                     ' Where CODFILIAL = 0 AND LANORCAMENTO = 0 '+
                                     ' AND SEQPARCIAL = 0 AND SEQMOVORCAMENTO = 0');
  CotCadastro2.Insert;
  CotCadastro2.FieldByName('CODFILIAL').AsInteger := VpaDBaixaCorpo.Codfilial;
  CotCadastro2.FieldByName('LANORCAMENTO').AsInteger := VpaDBaixaCorpo.LanOrcamento;
  CotCadastro2.FieldByName('SEQPARCIAL').AsInteger := VpaDBaixaCorpo.SeqParcial;
  CotCadastro2.FieldByName('SEQMOVORCAMENTO').AsInteger := VpaDBaixaItem.SeqMovOrcamento;
  CotCadastro2.FieldByName('SEQPRODUTO').AsInteger := VpaDBaixaItem.SeqProduto;
  if VpaDBaixaItem.CodCor <> 0  then
    CotCadastro2.FieldByName('CODCOR').AsInteger := VpaDBaixaItem.CodCor;
  CotCadastro2.FieldByName('DESUM').AsString := VpaDBaixaItem.DesUM;
  CotCadastro2.FieldByName('QTDPARCIAL').AsFloat := VpaDBaixaItem.QtdParcial;
  CotCadastro2.FieldByName('QTDCONFERIDO').AsFloat := VpaDBaixaItem.QtdConferido;
  CotCadastro2.FieldByName('VALPRODUTO').AsFloat := VpaDBaixaItem.ValProduto;
  CotCadastro2.FieldByName('VALTOTAL').AsFloat := VpaDBaixaItem.ValTotal;
  cotcadastro2.post;
  result :=  CotCadastro2.AMensagemErroGravacao;
  CotCadastro2.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraFinanceiroEstagio(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio : Integer):String;
var
  VpfDCotacao : TRBDorcamento;
  VpfDCliente : TRBDCliente;
  VpfDContaReceber : TRBDContasCR;
begin
  result := '';
  VpfDContaReceber := TRBDContasCR.Cria;
  AdicionaSQLAbreTabela(aux,'Select * from ESTAGIOPRODUCAO '+
                            ' Where CODEST = '+IntToStr(VpaCodEstagio));
  if Aux.FieldByName('CODPLA').AsString <> '' then
  begin
    VpfDCotacao := TRBDOrcamento.cria;
    VpfDCotacao.CodEmpFil := VpaCodFilial;
    VpfDCotacao.LanOrcamento := VpaLanOrcamento;
    cardorcamento(VpfDCotacao);
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VpfDCotacao.CodCliente;
    FunClientes.CarDCliente(VpfDCliente);
    if not GeraFinanceiro(VpfDCotacao,VpfDCliente, VpfDContaReceber,FunContasAReceber,result,true) then
      if result = '' then
        result := 'FINANCEIRO CANCELADO!!!'#13'Não foi possível alterar o estágio da cotação porque o financeiro foi cancelado.';
    VpfDCotacao.free;
  end;
  VpfDContaReceber.free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CopiaDCotacao(VpaDCotacaoDe, VpaDCotacaoPara : TRBDOrcamento;VpaCopiarItems : Boolean);
begin
    VpaDCotacaoPara.CodEmpFil := VpaDCotacaoDe.CodEmpFil;
    VpaDCotacaoPara.CodTipoOrcamento := VpaDCotacaoDe.CodTipoOrcamento;
    VpaDCotacaoPara.CodOperacaoEstoque := VpaDCotacaoDe.CodOperacaoEstoque;
    VpaDCotacaoPara.CodPlanoContas := VpaDCotacaoDe.CodPlanoContas;
    VpaDCotacaoPara.CodCliente := VpaDCotacaoDe.CodCliente;
    VpaDCotacaoPara.CodVendedor := VpaDCotacaoDe.CodVendedor;
    VpaDCotacaoPara.CodPreposto := VpaDCotacaoDe.CodPreposto;
    VpaDCotacaoPara.CodCondicaoPagamento := VpaDCotacaoDe.CodCondicaoPagamento;
    VpaDCotacaoPara.CodFormaPaqamento := VpaDCotacaoDe.CodFormaPaqamento;
    VpaDCotacaoPara.CodEstagio := varia.EstagioOrdemProducao;
    VpaDCotacaoPara.CodUsuario := varia.CodigoUsuario;
    VpaDCotacaoPara.TipFrete := VpaDCotacaoDe.TipFrete;
    VpaDCotacaoPara.TipGrafica := VpaDCotacaoDe.TipGrafica;
    VpaDCotacaoPara.CodTecnico := VpaDCotacaoDe.CodTecnico;
    VpaDCotacaoPara.CodTabelaPreco := VpaDCotacaoDe.CodTabelaPreco;
    VpaDCotacaoPara.FlaSituacao := 'A';
    VpaDCotacaoPara.NomContato := VpaDCotacaoDe.NomContato;
    VpaDCotacaoPara.NomSolicitante := VpaDCotacaoDe.NomSolicitante;
    VpaDCotacaoPara.PerComissao := VpaDCotacaoDe.PerComissao;
    VpaDCotacaoPara.PerComissaoPreposto := VpaDCotacaoDe.PerComissaoPreposto;
    VpaDCotacaoPara.CodTransportadora := VpaDCotacaoDe.CodTransportadora;
    VpaDCotacaoPara.PlaVeiculo := VpaDCotacaoDe.PlaVeiculo;
    VpaDCotacaoPara.UFVeiculo := VpaDCotacaoDe.UFVeiculo;
    VpaDCotacaoPara.DatOrcamento := date;
    VpaDCotacaoPara.HorOrcamento := now;
    VpaDCotacaoPara.datPrevista := date;
    VpaDCotacaoPara.PerDesconto := VpaDCotacaoDe.PerDesconto;
    if VpaCopiarItems then
      CopiaDProdutoCotacao(VpaDCotacaoDe,VpaDCotacaoPara);
end;

{******************************************************************************}
procedure TFuncoesCotacao.CopiaDProdutoCotacao(VpaDCotacaoDe, VpaDCotacaoPara : TRBDOrcamento);
var
  VpfDProdutoDe, VpfDProdutoPara : TRBDOrcProduto;
  VpfLaco : Integer;
begin
  FreeTObjectsList(VpaDCotacaoPara.Produtos);
  for VpfLaco := 0 to VpaDCotacaoDe.Produtos.count - 1 do
  begin
    VpfDProdutoDe := TRBDOrcProduto(VpaDCotacaoDe.Produtos.Items[VpfLaco]);
    VpfDProdutoPara := VpaDCotacaoPara.AddProduto;
    CopiaDProdutoCotacao(VpfDProdutoDe,VpfDProdutoPara);
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CopiaDProdutoCotacao(VpaDProCotacaoDe, VpaDProCotacaoPara : TRBDOrcProduto);
begin
  VpaDProCotacaoPara.LanOrcamentoOrigem := VpaDProCotacaoDe.LanOrcamentoOrigem;
  VpaDProCotacaoPara.SeqMovimento := VpaDProCotacaoDe.SeqMovimento;
  VpaDProCotacaoPara.SeqProduto := VpaDProCotacaoDe.SeqProduto;
  VpaDProCotacaoPara.CodCor := VpaDProCotacaoDe.CodCor;
  VpaDProCotacaoPara.CodTamanho := VpaDProCotacaoDe.CodTamanho;
  VpaDProCotacaoPara.CodEmbalagem := VpaDProCotacaoDe.CodEmbalagem;
  VpaDProCotacaoPara.CodPrincipioAtivo := VpaDProCotacaoDe.CodPrincipioAtivo;
  VpaDProCotacaoPara.CodProduto := VpaDProCotacaoDe.CodProduto;
  VpaDProCotacaoPara.CodClassificacao := VpaDProCotacaoDe.CodClassificacao;
  VpaDProCotacaoPara.NomProduto := VpaDProCotacaoDe.NomProduto;
  VpaDProCotacaoPara.NomTamanho := VpaDProCotacaoDe.NomTamanho;
  VpaDProCotacaoPara.DesCor := VpaDProCotacaoDe.DesCor;
  VpaDProCotacaoPara.DesEmbalagem := VpaDProCotacaoDe.DesEmbalagem;
  VpaDProCotacaoPara.DesObservacao := VpaDProCotacaoDe.DesObservacao;
  VpaDProCotacaoPara.DesRefCliente := VpaDProCotacaoDe.DesRefCliente;
  VpaDProCotacaoPara.DesOrdemCompra := VpaDProCotacaoDe.DesOrdemCompra;
  VpaDProCotacaoPara.UM := VpaDProCotacaoDe.UM;
  VpaDProCotacaoPara.UMAnterior := VpaDProCotacaoDe.UMAnterior;
  VpaDProCotacaoPara.UMOriginal := VpaDProCotacaoDe.UMOriginal;
  VpaDProCotacaoPara.IndImpFoto := VpaDProCotacaoDe.IndImpFoto;
  VpaDProCotacaoPara.IndImpDescricao := VpaDProCotacaoDe.IndImpDescricao;
  VpaDProCotacaoPara.DesRegistroMSM := VpaDProCotacaoDe.DesRegistroMSM;
  VpaDProCotacaoPara.IndFaturar := VpaDProCotacaoDe.IndFaturar;
  VpaDProCotacaoPara.IndRetornavel := VpaDProCotacaoDe.IndRetornavel;
  VpaDProCotacaoPara.IndBrinde := VpaDProCotacaoDe.IndBrinde;
  VpaDProCotacaoPara.IndCracha := VpaDProCotacaoDe.IndCracha;
  VpaDProCotacaoPara.IndMedicamentoControlado := VpaDProCotacaoDe.IndMedicamentoControlado;
  VpaDProCotacaoPara.IndPermiteAlterarQtdnaSeparacao := VpaDProCotacaoDe.IndPermiteAlterarQtdnaSeparacao;
  VpaDProCotacaoPara.PerDesconto := VpaDProCotacaoDe.PerDesconto;
  VpaDProCotacaoPara.PesLiquido := VpaDProCotacaoDe.PesLiquido;
  VpaDProCotacaoPara.PesBruto := VpaDProCotacaoDe.PesBruto;
  VpaDProCotacaoPara.QtdBaixado := VpaDProCotacaoDe.QtdBaixado;
  VpaDProCotacaoPara.QtdABaixar := VpaDProCotacaoDe.QtdABaixar;
  VpaDProCotacaoPara.QtdEstoque := VpaDProCotacaoDe.QtdEstoque;
  VpaDProCotacaoPara.QtdMinima := VpaDProCotacaoDe.QtdMinima;
  VpaDProCotacaoPara.QtdPedido := VpaDProCotacaoDe.QtdPedido;
  VpaDProCotacaoPara.QtdProduto := VpaDProCotacaoDe.QtdProduto;
  VpaDProCotacaoPara.QtdFiscal := VpaDProCotacaoDe.QtdFiscal;
  VpaDProCotacaoPara.QtdDevolvido := VpaDProCotacaoDe.QtdDevolvido;
  VpaDProCotacaoPara.QtdSaldoBrinde := VpaDProCotacaoDe.QtdSaldoBrinde;
  VpaDProCotacaoPara.ValUnitario := VpaDProCotacaoDe.ValUnitario;
  VpaDProCotacaoPara.ValUnitarioOriginal := VpaDProCotacaoDe.ValUnitarioOriginal;
  VpaDProCotacaoPara.ValTotal := VpaDProCotacaoDe.ValTotal;
  VpaDProCotacaoPara.RedICMS := VpaDProCotacaoDe.RedICMS;
  VpaDProCotacaoPara.PerComissao := VpaDProCotacaoDe.PerComissao;
  VpaDProCotacaoPara.PerComissaoClassificacao := VpaDProCotacaoDe.PerComissaoClassificacao;
  VpaDProCotacaoPara.UnidadeParentes.Assign(VpaDProCotacaoDe.UnidadeParentes);
end;

{******************************************************************************}
procedure TFuncoesCotacao.DuplicaDadosItemOrcamento(VpaDItemOrigem,VpaDItemDestino : TRBDOrcProduto);
begin
  VpaDItemDestino.SeqProduto := VpaDItemOrigem.SeqProduto;
  VpaDItemDestino.CodCor := VpaDItemOrigem.CodCor;
  VpaDItemDestino.CodEmbalagem := VpaDItemOrigem.CodEmbalagem;
  VpaDItemDestino.CodProduto := VpaDItemOrigem.CodProduto;
  VpaDItemDestino.NomProduto := VpaDItemOrigem.NomProduto;
  VpaDItemDestino.DesCor := VpaDItemOrigem.DesCor;
  VpaDItemDestino.DesEmbalagem := VpaDItemOrigem.DesEmbalagem;
  VpaDItemDestino.DesObservacao := VpaDItemOrigem.DesObservacao;
  VpaDItemDestino.DesRefCliente := VpaDItemOrigem.DesRefCliente;
  VpaDItemDestino.UM := VpaDItemOrigem.UM;
  VpaDItemDestino.UMAnterior := VpaDItemOrigem.UMAnterior;
  VpaDItemDestino.UMOriginal := VpaDItemOrigem.UMOriginal;
  VpaDItemDestino.IndImpFoto := VpaDItemOrigem.IndImpFoto;
  VpaDItemDestino.DesOrdemCompra := VpaDItemOrigem.DesOrdemCompra;
  VpaDItemDestino.IndImpDescricao := VpaDItemOrigem.IndImpDescricao;
  VpaDItemDestino.IndFaturar := VpaDItemOrigem.IndFaturar;
  VpaDItemDestino.IndRetornavel := VpaDItemOrigem.IndRetornavel;
  VpaDItemDestino.IndBrinde := VpaDItemOrigem.IndBrinde;
  VpaDItemDestino.PerDesconto := VpaDItemOrigem.PerDesconto;
  VpaDItemDestino.PesLiquido := VpaDItemOrigem.PesLiquido;
  VpaDItemDestino.PesBruto := VpaDItemOrigem.PesBruto;
  VpaDItemDestino.QtdBaixado := 0;
  VpaDItemDestino.QtdABaixar := 0;
  VpaDItemDestino.QtdEstoque := VpaDItemOrigem.QtdEstoque;
  VpaDItemDestino.QtdMinima := VpaDItemOrigem.QtdMinima;
  VpaDItemDestino.QtdPedido := VpaDItemOrigem.QtdPedido;
  VpaDItemDestino.QtdProduto := VpaDItemOrigem.QtdProduto;
  VpaDItemDestino.QtdFiscal := VpaDItemOrigem.QtdFiscal;
  VpaDItemDestino.QtdDevolvido := 0;
  VpaDItemDestino.ValUnitario := VpaDItemOrigem.ValUnitario;
  VpaDItemDestino.ValUnitarioOriginal := VpaDItemOrigem.ValUnitarioOriginal;
  VpaDItemDestino.ValTotal := VpaDItemOrigem.ValTotal;
  VpaDItemDestino.UnidadeParentes.Assign(VpaDItemOrigem.UnidadeParentes);
end;

{******************************************************************************}
procedure TFuncoesCotacao.MontaEmailCotacaoTexto(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente);
var
  VpfDProduto : TRBDOrcProduto;
  VpfLaco : Integer;
begin
  VpaTexto.add('Cotação '+IntToStr(VpaDCotacao.LanOrcamento));
  VpaTexto.add('Tipo');
  VpaTexto.add(UpperCase(IntToStr(VpaDCotacao.CodTipoOrcamento))+'-'+ RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento));
  VpaTexto.add('Cliente');
  VpaTexto.add(UpperCase(IntToStr(VpaDCliente.CodCliente)+'-'+VpaDCliente.NomCliente));
  VpaTexto.add('Nome Fantasia');
  VpaTexto.add(UpperCase(VpaDCliente.NomFantasia));
  VpaTexto.add('Endereço');
  VpaTexto.add(UpperCase(VpaDCliente.DesEndereco+','+VpaDCliente.NumEndereco+'-'+VpaDCliente.DesComplementoEndereco));
  VpaTexto.add('Bairro');
  VpaTexto.add(UPPERCASE(VpaDCliente.DesBairro));
  VpaTexto.add('Cidade');
  VpaTexto.add(UpperCase(VpaDCliente.DesCidade+' / '+VpaDCliente.DesUF));
  VpaTexto.add('Fone');
  VpaTexto.add(VpaDCliente.DesFone1);
  VpaTexto.add('Contato');
  VpaTexto.add(UpperCase(VpaDCotacao.NomContato));
  VpaTexto.add('');
  VpaTexto.add('Data');
  VpaTexto.add(FormatDateTime('DD/MM/YY',VpaDCotacao.DatOrcamento)+FormatDateTime('HH:MM:SS',VpaDCotacao.HorOrcamento));
  VpaTexto.add('');
  VpaTexto.add('Transportadora');
  VpaTexto.add(RNomTransportadora(VpaDCotacao.CodTransportadora));
  VpaTexto.add('');
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    VpaTexto.add('Produto '+IntToStr(VpfLaco+1)+' de '+IntToStr(VpaDCotacao.Produtos.Count));
    VpaTexto.add(VpfDProduto.CodProduto+'-'+VpfDProduto.NomProduto);
    VpaTexto.add('Qtd');
    VpaTexto.add(FormatFloat('###,###,##0.00',VpfDProduto.QtdProduto));
    VpaTexto.add('Valor Unitario');
    VpaTexto.add(FormatFloat('###,###,##0.00',VpfDProduto.ValUnitario));
    VpaTexto.add('Valor Total');
    VpaTexto.add(FormatFloat('###,###,##0.00',VpfDProduto.ValTotal));
    VpaTexto.add('');
  end;
  VpaTexto.add('Observações');
  VpaTexto.add(VpaDCotacao.desobservacao.Text);
  VpaTexto.add('');
  VpaTexto.add('Valor Total Pedido');
  VpaTexto.add(FormatFloat('###,###,##0.00',VpaDCotacao.ValTotal));
  VpaTexto.add('Forma de Pagamento');
  VpaTexto.add(FunContasAReceber.RNomFormaPagamento(VpaDCotacao.CodFormaPaqamento));
  VpaTexto.add('Condição de Pagamento');
  VpaTexto.add(FunContasAReceber.RNomCondicaoPagamento(VpaDCotacao.CodCondicaoPagamento));

  VpaDCotacao.Parcelas.Clear;
  CarParcelasContasAReceber(VpaDCotacao);
  VpaTexto.add('Parcelas');
  for VpfLaco := 0 to VpaDCotacao.Parcelas.Count - 1 do
  begin
    VpaTexto.add(VpaDCotacao.Parcelas.Strings[vpflaco]);
  end;
  VpaTexto.add('');
  VpaTexto.add('Usuário');
  VpaTexto.add(Sistema.RNomUsuario(VpaDCotacao.CodUsuario));
end;

{******************************************************************************}
procedure TFuncoesCotacao.MontaCabecalhoEmail(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaEnviarImagem : Boolean);
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDCotacao.CodEmpFil)+' - '+RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento)+' : '+IntToStr(VpaDCotacao.LanOrcamento));
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <a href="http://'+varia.SiteFilial+'">');
  VpaTexto.add('      <IMG src="cid:'+intToStr(VpaDCotacao.CodEmpFil)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+'>');
  VpaTexto.add('    </a></td> <td bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <b>'+varia.NomeFilial+ '.</b>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+Varia.EnderecoFilial+'              Bairro : '+Varia.BairroFilial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+Varia.CidadeFilial +' / '+Varia.UFFilial+ '                CEP : '+Varia.CepFilial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    Fone : '+varia.FoneFilial +'         -             e-mail :'+Varia.EMailFilial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    site : <a href="http://'+varia.SiteFilial+'">'+varia.SiteFilial);
  VpaTexto.add('    </td><td bgcolor="#'+varia.CRMCorClaraEmail+'"> ');
  VpaTexto.add('    <center>');
  VpaTexto.add('    <h3> Número </h3>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <h2> '+formatFloat('###,###,##0',VpadCotacao.LanOrcamento)+'</h2>');
  VpaTexto.add('    </center>');
  VpaTexto.add('    </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('</left>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <br>');
end;

{******************************************************************************}
procedure TFuncoesCotacao.MontaEmailCotacao(VpaTexto : TStrings; VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente;VpaEnviarImagem : Boolean);
var
  VpfDProduto : TRBDOrcProduto;
  VpfDServico : TRBDOrcServico;
  VpfLaco : Integer;
  Vpfbmppart : TIdAttachmentFile;
  VpfValUnitario,VpfValTotal : Double;
begin
  Vpfbmppart := TIdAttachmentFile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+intToStr(VpaDCotacao.CodEmpFil)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := intToStr(VpaDCotacao.CodEmpFil)+'.jpg';
  Vpfbmppart.DisplayName := intToStr(VpaDCotacao.CodEmpFil)+'.jpg';

  MontaCabecalhoEmail(VpaTexto,VpaDCotacao,VpaDCliente,VpaEnviarImagem);
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Tipo</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDCotacao.CodTipoOrcamento)+'-'+RNomeTipoOrcamento(VpaDCotacao.CodTipoOrcamento)+'</td>');
  VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Data</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY',VpaDCotacao.DatOrcamento)+' - '+FormatDateTime('HH:MM:SS',VpaDCotacao.HorOrcamento) +'</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('    <br>');
//  VpaTexto.add('    <P>Número e cadastro: <input TYPE="text" name="cadastro" size="8" maxlength="8"><br> ');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cliente</td>');
  if VpaDCliente.NomFantasia <> ''  then
    VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.NomFantasia+' </td>')
  else
    VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.NomCliente+' </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Endere&ccedil;o</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+vpadcliente.DesEndereco+','+VpaDCliente.NumEndereco+' - '+VpaDCliente.DesComplementoEndereco +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Bairro</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+vpadCliente.DesBairro +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cep</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CepCliente+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cidade</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesCidade+'/'+VpaDCliente.DesUF +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;CNPJ</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CGC_CPF+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Inscrição Estadual</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.InscricaoEstadual+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fone</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFone1+'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fax</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFax+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;e-mail</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesEmail+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Contato</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+vpadcliente.NomContato+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Atendente</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+Sistema.RNomUsuario(VpaDCotacao.CodUsuario) +'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td colspan=5 align="center" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="3"><b>Produtos</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('        <td width="45%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Produto</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');

  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpaDCotacao.PerDesconto <> 0 then
    begin
      VpfValUnitario := VpfDProduto.ValUnitario - ((VpfDProduto.ValUnitario * VpaDCotacao.PerDesconto)/100);
      VpfValTotal := VpfDProduto.ValTotal - ((VpfDProduto.ValTotal * VpaDCotacao.PerDesconto)/100);
    end
    else
    begin
      VpfValUnitario := VpfDProduto.ValUnitario;
      VpfValTotal := VpfDProduto.ValTotal;
    end;

    VpaTexto.add('</tr><tr>');
    VpaTexto.add('      <td width="45%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="left"><font face="Verdana" size="-1">&nbsp;'+VpfDProduto.CodProduto+'-'+VpfDProduto.NomProduto+'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDProduto.QtdProduto) +'</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValorUnitario,VpfValUnitario)+'</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValor,VpfValTotal) +'</td>');
  end;
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  if VpaDCotacao.Servicos.Count > 0 then
  begin
    VpaTexto.add('<table width="100%">');
    VpaTexto.add('<tr>');
    VpaTexto.add('	<td colspan=4 align="center" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="3"><b>Servi&ccedil;os</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('        <td width="40%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Servi&ccedil;o</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
    for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
    begin
      VpfDServico:= TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]);
      VpaTexto.add('</tr><tr>');
      VpaTexto.add('      <td width="40%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="left"><font face="Verdana" size="-1">&nbsp;'+IntToStr(VpfDServico.CodServico)+'-'+VpfDServico.NomServico+'-'+VpfDServico.DesAdicional+'</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraQtd,VpfDServico.QtdServico) +'</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValorUnitario,VpfDServico.ValUnitario)+'</td>');
      VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="-1">&nbsp;'+FormatFloat(varia.MascaraValor,VpfDServico.ValTotal) +'</td>');
    end;
    VpaTexto.add('</tr>');
    VpaTexto.add('</table><br>');
  end;

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Transportadora</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RNomTransportadora(VpaDCotacao.CodTransportadora) +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Vendedor</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RNomVendedor(VpaDCotacao.CodVendedor) +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Ordem de Compra</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCotacao.OrdemCompra +'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>Observa&ccedil;oes</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCotacao.DesObservacao.Text+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;'+RTextoAcrescimoDesconto(VpaDCotacao) +'</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RValorAcrescimodesconto(VpaDCotacao)+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'" align="right"><font face="Verdana" size="4">&nbsp;<b>'+FormatFloat(varia.MascaraValor,VpaDCotacao.ValTotal) +'</b></td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<table width="40%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="center" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="3"><b>Parcelas</td>');
  VpaTexto.add('</tr><tr>');
  for VpfLaco := 0 to VpaDCotacao.Parcelas.Count - 1 do
  begin
    VpaTexto.add('	<td align="center" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1"><b>&nbsp;'+VpaDCotacao.Parcelas.Strings[vpflaco]+'</td>');
    VpaTexto.add('</tr><tr>');
  end;
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  if Varia.CNPJFilial <>  CNPJ_REELTEX then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
//  VpaTExto.saveToFile('c:\marcelo.html');
end;

{******************************************************************************}
function TFuncoesCotacao.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP) : string;
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
function TFuncoesCotacao.VerificaSeparacaoTotal(VpaDCotacao : TRBDOrcamento;Var VpaIndTotal : Boolean):string;
var
  VpfLaco : Integer;
  VpfSeparacaoSuperior : Boolean;
  VpfDProCotacao : TRBDOrcProduto;
begin
  result := '';
  VpaIndTotal := true;
  VpfSeparacaoSuperior := false;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDProCotacao.QtdBaixado < VpfDProCotacao.QtdProduto then
      VpaIndTotal := false
    else
      if VpfDProCotacao.QtdBaixado > VpfDProCotacao.QtdProduto then
      begin
        VpfSeparacaoSuperior := true;
        result := #13'"'+VpfDProCotacao.CodProduto+'-'+VpfDProCotacao.NomProduto+ '" COR '+VpfDProCotacao.DesCor;
      end;
  end;
  if VpfSeparacaoSuperior and VpaIndTotal then
    result := 'OS PRODUTOS ABAIXO FORAM SEPARADOS COM A SUAS QUANTIDADE A MAIOR DO QUE A DO PEDIDO:'+result
  else
    result := '';
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaEstoqueCartuchoAssociado(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):string;
var
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfDCartucho : TRBDCartuchoCotacao;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  if Varia.OperacaoAcertoEstoqueEntrada = 0 then
    result := 'OPERAÇÃO ACERTO ESTOQUE ENTRADA NÃO PREENCHIDA!!!'#13'É necessário preencher nas configurações do sistema a operação de acerto de estoque';
  if Varia.OperacaoAcertoEstoqueSaida = 0 then
    result := 'OPERAÇÃO ACERTO ESTOQUE SAÍDA NÃO PREENCHIDA!!!'#13'É necessário preencher nas configurações do sistema a operação de acerto de estoque';
  if result = '' then
  begin
    for VpfLaco := 0 to VpaCartuchos.Count - 1 do
    begin
      VpfDCartucho := TRBDCartuchoCotacao(VpaCartuchos.Items[VpfLaco]);
      if VpfDCartucho.SeqProdutoTrocado <> 0 then
      begin
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,VpaDCotacao.CodEmpFil,VpfDCartucho.SeqProdutoTrocado);
        FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDCotacao.CodEmpFil,varia.OperacaoAcertoEstoqueEntrada,
                                         0,VpaDCotacao.LanOrcamento,VpaDCotacao.LanOrcamento,
                                         varia.MoedaBase,0,0,now,1,0,VpfDProduto.CodUnidade,
                                         '',false,VpfSeqEstoqueBarra,true);
        FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,VpaDCotacao.CodEmpFil,VpfDCartucho.SeqProduto);
        FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDCotacao.CodEmpFil,varia.OperacaoAcertoEstoqueSaida,
                                         0,VpaDCotacao.LanOrcamento,VpaDCotacao.LanOrcamento,
                                         varia.MoedaBase,0,0,now,1,0,VpfDProduto.CodUnidade,
                                         '',false,VpfSeqEstoqueBarra,true);
        VpfDProduto.free;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosASeparar(VpaDCotacao, VpaDCotacaoNova : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfdProdutoDE, VpfDProdutoPara : TRBDOrcProduto;
begin
  result := '';
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProdutoDE :=TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDProdutoDE.QtdBaixado <> 0 then
    begin
      VpfDProdutoPara := VpaDCotacaoNova.AddProduto;
      VpfDProdutoPara.QtdProduto := VpfDProdutoDE.QtdBaixado;
      VpfDProdutoPara.QtdBaixado := VpfDProdutoDE.QtdBaixado;
      VpfDProdutoPara.QtdConferidoSalvo := VpfDProdutoDE.QtdConferidoSalvo;
      VpfDProdutoPara.ValUnitario := VpfDProdutoDE.ValUnitario;
      VpfDProdutoPara.ValTotal := VpfDProdutoPara.ValUnitario * VpfDProdutoPara.QtdProduto;
      VpfDProdutoPara.PerDesconto := VpfDProdutoDE.PerDesconto;
      if Config.DescontoNosProdutodaCotacao then
        VpfDProdutoPara.ValTotal := VpfDProdutoPara.ValTotal - ((VpfDProdutoPara.ValTotal *VpfDProdutoPara.PerDesconto)/100);
      VpfDProdutoPara.SeqProduto := VpfDProdutoDE.SeqProduto;
      VpfDProdutoPara.CodCor := VpfDProdutoDE.CodCor;
      VpfDProdutoPara.CodEmbalagem := VpfDProdutoDE.CodEmbalagem;
      VpfDProdutoPara.CodPrincipioAtivo := VpfDProdutoDE.CodPrincipioAtivo;
      VpfDProdutoPara.CodProduto := VpfDProdutoDE.CodProduto;
      VpfDProdutoPara.NomProduto := VpfDProdutoDE.NomProduto;
      VpfDProdutoPara.DesCor := VpfDProdutoDE.DesCor;
      VpfDProdutoPara.DesEmbalagem := VpfDProdutoDE.DesEmbalagem;
      VpfDProdutoPara.DesObservacao := VpfDProdutoDE.DesObservacao;
      VpfDProdutoPara.DesRefCliente := IntToStr(VpaDCotacao.LanOrcamento);
      VpfDProdutoPara.DesOrdemCompra := VpfDProdutoDE.DesOrdemCompra;
      VpfDProdutoPara.UM := VpfDProdutoDE.UM;
      VpfDProdutoPara.UMAnterior := VpfDProdutoDE.UMAnterior;
      VpfDProdutoPara.UMOriginal := VpfDProdutoDE.UMOriginal;
      VpfDProdutoPara.IndImpFoto := VpfDProdutoDE.IndImpFoto;
      VpfDProdutoPara.IndImpDescricao := VpfDProdutoDE.IndImpDescricao;

      VpfDProdutoDE.QtdProduto := VpfDProdutoDE.QtdProduto - VpfDProdutoDE.QtdBaixado;
      VpfDProdutoDE.ValTotal := VpfDProdutoDE.ValUnitario * VpfDProdutoDE.QtdProduto;
      if Config.DescontoNosProdutodaCotacao then
        VpfDProdutoDE.ValTotal := VpfDProdutoDE.ValTotal - ((VpfDProdutoDE.ValTotal *VpfDProdutoDE.PerDesconto)/100);
      VpfdProdutoDE.QtdBaixado := 0;
      VpfdProdutoDE.QtdConferidoSalvo := 0;
    end;
  end;

  //deletas os produtos que ficaram com a quantidade zero.
  for VpfLaco := VpaDCotacao.Produtos.Count - 1 downto 0 do
  begin
    VpfDProdutoDE := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDProdutoDE.QtdProduto <= 0 then
    begin
      VpfDProdutoDE.free;
      VpaDCotacao.Produtos.Delete(VpfLaco);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaEstoqueSaldoAlteracao(VpaDSaldo : TRBDOrcamento) :string;
var
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfDProCotacao : TRBDOrcProduto;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  for VpfLaco := 0 to VpaDSaldo.Produtos.Count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDSaldo.Produtos.Items[VpfLaco]);
    VpfDProduto := TRBDProduto.Cria;
    if VpfDProCotacao.QtdProduto > 0 then
    begin
      FunProdutos.CarDProduto(VpfDProduto,0,VpaDSaldo.CodEmpFil, VpfDProCotacao.SeqProduto);
      FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDSaldo.CodEmpFil, varia.OperacaoEstoqueEstornoEntrada,0,
                                    VpaDSaldo.LanOrcamento,VpaDSaldo.LanOrcamento,varia.MoedaBase,VpfDProCotacao.CodCor,VpfDProCotacao.CodTamanho,
                                    date,VpfDProCotacao.QtdProduto ,VpfDProCotacao.QtdProduto *VpfDProCotacao.ValUnitario,
                                    VpfDProCotacao.UM,VpfDProCotacao.DesRefCliente, false,VpfSeqEstoqueBarra)
    end
    else
      if VpfDProCotacao.QtdProduto < 0 then
      begin
        FunProdutos.CarDProduto(VpfDProduto,0,VpaDSaldo.CodEmpFil, VpfDProCotacao.SeqProduto);
        FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaDSaldo.CodEmpFil,varia.OperacaoEstoqueEstornoSaida,0,
                                    VpaDSaldo.LanOrcamento,VpaDSaldo.LanOrcamento,varia.MoedaBase,VpfDProCotacao.CodCor,VpfDProCotacao.CodTamanho,
                                    date,VpfDProCotacao.QtdProduto*-1 ,(VpfDProCotacao.QtdProduto *-1) *VpfDProCotacao.ValUnitario,
                                    VpfDProCotacao.UM,VpfDProCotacao.DesRefCliente, false,VpfSeqEstoqueBarra)
      end;
    VpfDProduto.free;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AdicionaFinanceiroArqRemessa(VpaDCotacao : TRBDOrcamento):String;
begin
  Result := '';
  if ConfigModulos.Bancario then
  begin
    AdicionaSQLAbreTabela(Orcamento,'Select MOV.I_COD_FRM, MOV.C_NRO_CON, MOV.I_EMP_FIL,MOV.I_LAN_REC, '+
                                    ' MOV.I_NRO_PAR '+
                                    ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                                    ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                    ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                    ' AND CAD.I_EMP_FIL = '+IntTostr(VpaDCotacao.CodEmpFil)+
                                    ' AND CAD.I_LAN_ORC = '+Inttostr(VpaDCotacao.LanOrcamento),true);
    While not Orcamento.Eof do
    begin
      if (Orcamento.FieldByName('I_COD_FRM').AsInteger = varia.FormaPagamentoBoleto) then
        result :=   FunContasAReceber.AdicionaRemessa(Orcamento.FieldByName('I_EMP_FIL').AsInteger,Orcamento.FieldByName('I_LAN_REC').AsInteger,Orcamento.FieldByName('I_NRO_PAR').AsInteger,1);
      if result <> '' then
        break;
      Orcamento.next;
    end;
    Orcamento.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RCodCliente(VpaCodFilial, VpaLanOrcamento : Integer):Integer;
begin
  AdicionaSqlabreTabela(Aux,'Select I_COD_CLI from CADORCAMENTOS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('I_COD_CLI').AsInteger;
  Aux.close;
end;

{******** carrega os dados default na insercao do movimento do orcamento ******}
procedure TFuncoesCotacao.InseriNovoOrcamento(VpaMovOrcamento : TDataSet;VpaLanOrcamento,VpaSeqProduto : Integer;
                                               VpaValorVenda : Double; VpaCodUnidade : String);
begin
  VpaMovOrcamento.insert;
  VpaMovOrcamento.FieldByName('I_EMP_FIL').AsInteger := Varia.codigoEmpFil;
  VpaMovOrcamento.FieldByName('I_LAN_ORC').AsInteger := VpaLanOrcamento;
  VpaMovOrcamento.FieldByName('I_Seq_Pro').AsInteger := VpaSeqProduto;
  VpaMovOrcamento.FieldByName('N_Vlr_Pro').AsFloat := VpaValorVenda;
  VpaMovOrcamento.FieldByName('N_QTD_PRO').AsFloat := 1;
  VpaMovOrcamento.FieldByName('C_COD_UNI').AsString := VpaCodUnidade;
  VpaMovOrcamento.FieldByname('D_ULT_ALT').AsDateTime := Date;
  VpaMovOrcamento.Post;
end;


{******************************************************************************}
procedure TFuncoesCotacao.AdicionaDescontoCotacaoDePara(VpaDCotacaoDE,VpaDCotacaoPara : TRBDOrcamento);
begin
  if VpaDCotacaoDE.ValDesconto <> 0 then
    VpaDCotacaoPara.ValDesconto := VpaDCotacaoPara.ValDesconto + VpaDCotacaoDE.ValDesconto;
  if VpaDCotacaoDE.PerDesconto <> 0 then
    VpaDCotacaoPara.ValDesconto := VpaDCotacaoPara.ValDesconto +((VpaDCotacaoDE.ValTotalProdutos * VpaDCotacaoDE.PerDesconto)/100);
end;

{******************************************************************************}
procedure TFuncoesCotacao.AdicionaPaginasLogAlteracao(VpaDCotacao : TRBDOrcamento;VpaPaginas : TpageControl);
var
  VpfPagina : TTabSheet;
begin
  AdicionaSQLAbreTabela(Orcamento,'Select SEQESTAGIO FROM ESTAGIOORCAMENTO '+
                                  ' Where CODFILIAL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                                  ' AND SEQORCAMENTO = '+IntToStr(VpaDCotacao.LanOrcamento)+
                                  ' AND CODESTAGIO = '+IntToStr(VARIA.EstagioCotacaoAlterada)+
                                  ' order by SEQESTAGIO');
  While not Orcamento.eof do
  begin
    VpfPagina := TTabSheet.Create(VpaPaginas);
    VpaPaginas.InsertControl(VpfPagina);
    VpfPagina.PageControl := VpaPaginas;
    VpfPagina.Tag := 9;
    VpfPagina.Caption := Orcamento.FieldByName('SEQESTAGIO').AsString;
    Orcamento.next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDOrcamento(VpaDOrcamento : TRBDOrcamento;VpaCodFilial : Integer = 0;VpaLanOrcamento : Integer = 0);
begin
  if VpaCodFilial <> 0 then
    VpaDOrcamento.CodEmpFil := VpaCodFilial;
  if VpaLanOrcamento <> 0 then
    VpaDOrcamento.LanOrcamento := VpaLanOrcamento;
  FreeTObjectsList(VpaDOrcamento.Produtos);
  FreeTObjectsList(VpaDOrcamento.Servicos);
  VpaDOrcamento.Produtos.Clear;
  VpaDOrcamento.Servicos.Clear;
  if VpaDOrcamento.CodEmpFil = 0 then
    VpaDOrcamento.CodEmpFil := varia.CodigoEmpFil;
  AdicionaSQLAbreTabela(Orcamento,'Select * from CADORCAMENTOS ORC, CADCLIENTES CLI '+
                                  ' Where ORC.I_EMP_FIL = '+IntToStr(VpaDOrcamento.CodEmpFil) +
                                  ' and ORC.I_LAN_ORC = '+ IntToStr(VpaDOrcamento.LanOrcamento)+
                                  ' AND ORC.I_COD_CLI = CLI.I_COD_CLI');
  with VpaDOrcamento do
  begin
    CodEmpFil := Orcamento.FieldByName('I_EMP_FIL').AsInteger;
    CodTipoOrcamento := Orcamento.FieldByName('I_TIP_ORC').AsInteger;
    CodUsuario := Orcamento.FieldByName('I_COD_USU').AsInteger;
    CodCliente := Orcamento.FieldByName('I_COD_CLI').AsInteger;
    CodFormaPaqamento := Orcamento.FieldByName('I_COD_FRM').AsInteger;
    if CodFormaPaqamento = 0 then
      CodFormaPaqamento := Orcamento.FieldByName('I_FRM_PAG').AsInteger;
    IF CodFormaPaqamento = 0 then
      CodFormaPaqamento := Varia.FormaPagamentoPadrao;
    CodTecnico := Orcamento.FieldByName('I_COD_TEC').AsInteger;
    CodTabelaPreco := Orcamento.FieldByName('I_COD_TAB').AsInteger;
    CodVendedor := Orcamento.FieldByName('I_COD_VEN').AsInteger;
    CodPreposto := Orcamento.FieldByName('I_VEN_PRE').AsInteger;
    CodCondicaoPagamento := Orcamento.FieldByName('I_COD_PAG').AsInteger;
    CodEstagio := Orcamento.FieldByName('I_COD_EST').AsInteger;
    SeqNotaEntrada := Orcamento.FieldByName('I_NOT_ENT').AsInteger;
    PerComissao := Orcamento.FieldByName('N_PER_COM').AsFloat;
    PerComissaoPreposto := Orcamento.FieldByName('N_COM_PRE').AsFloat;
    ValTotal := Orcamento.FieldByName('N_VLR_TOT').AsFloat;
    ValTotalProdutos := Orcamento.FieldByName('N_VLR_PRO').AsFloat;
    ValTotalLiquido := Orcamento.FieldByName('N_VLR_LIQ').AsFloat;
    IndProcessada := NOT(Orcamento.FieldByName('C_IND_PRO').AsString = 'N');
    FinanceiroGerado := (Orcamento.FieldByName('C_GER_FIN').AsString = 'S');
    IndNotaGerada := (Orcamento.FieldByName('C_NOT_GER').AsString = 'S');
    NomContato := Orcamento.FieldByName('C_CON_ORC').AsString;
    NomSolicitante := Orcamento.FieldByName('C_NOM_SOL').AsString;
    DesEmail := Orcamento.FieldByName('C_DES_EMA').AsString;
    NomComputador := Orcamento.FieldByName('C_NOM_MIC').AsString;
    OrdemCompra := Orcamento.FieldByName('C_ORD_COM').AsString;
    NumCupomfiscal := Orcamento.FieldByName('C_NUM_CUF').AsString;
    DatOrcamento := Orcamento.FieldByName('D_DAT_ORC').AsDateTime;
    HorOrcamento := Orcamento.FieldByName('T_HOR_ORC').AsDateTime;
    DatPrevista := Orcamento.FieldByName('D_DAT_PRE').AsDateTime;
    HorPrevista :=  Orcamento.FieldByName('T_HOR_ENT').AsDateTime;
    DatValidade := Orcamento.FieldByName('D_DAT_VAL').AsDateTime;
    DesObservacao.Text := Orcamento.FieldByName('L_OBS_ORC').AsString;
    DesObservacaoFiscal := Orcamento.FieldByName('C_OBS_FIS').AsString;
    FlaSituacao := Orcamento.FieldByName('C_FLA_SIT').Asstring;
    NumNotas    := Orcamento.FieldByName('C_NRO_NOT').Asstring;
    CodTransportadora  := Orcamento.FieldByName('I_COD_TRA').AsInteger;
    PlaVeiculo := Orcamento.FieldByName('C_PLA_VEI').AsString;
    UFVeiculo    := Orcamento.FieldByName('C_EST_VEI').AsString;
    QtdVolumesTransportadora := Orcamento.FieldByName('N_QTD_TRA').AsInteger;
    EspTransportadora := Orcamento.FieldByName('C_ESP_TRA').AsString;
    MarTransportadora := Orcamento.FieldByName('C_MAR_TRA').AsString;
    NumTransportadora := Orcamento.FieldByName('I_NRO_TRA').AsInteger;
    PesBruto := Orcamento.FieldByName('N_PES_BRU').AsFloat;
    PesLiquido := Orcamento.FieldByName('N_PES_LIQ').AsFloat;
    OPImpressa := Orcamento.FieldByName('C_ORP_IMP').AsString = 'S';
    IndPendente := Orcamento.FieldByName('C_IND_PEN').AsString = 'S';
    IndRevenda := Orcamento.FieldByName('C_IND_REV').AsString = 'S';
    PerDesconto := Orcamento.FieldByName('N_PER_DES').AsFloat;
    ValDesconto := Orcamento.FieldByName('N_VLR_DES').AsFloat;
    TipFrete := Orcamento.FieldByName('I_TIP_FRE').AsInteger;
    ValTotalComDesconto := Orcamento.FieldByName('N_VLR_TTD').AsFloat;
    CodOperacaoEstoque := Orcamento.FieldByName('I_COD_OPE').AsInteger;
    TipGrafica := Orcamento.FieldByName('I_TIP_GRA').AsInteger;
    ValTaxaEntrega := Orcamento.FieldByName('N_VAL_TAX').AsFloat;
    DesServico := Orcamento.FieldByName('C_DES_SER').AsString;
    IndNumeroBaixado := Orcamento.FieldByName('C_NUM_BAI').AsString = 'S';
    DesProblemaChamado := Orcamento.FieldByName('C_DES_CHA').AsString;
    DesServicoExecutado := Orcamento.FieldByName('C_SER_EXE').AsString;
    DesEnderecoAtendimento := Orcamento.FieldByName('C_END_ATE').AsString;
    ValDeslocamento := Orcamento.FieldByName('N_VLR_DSL').AsFloat;
    ValChamado := Orcamento.FieldByName('N_VLR_CHA').AsFloat;
    ValTroca := Orcamento.FieldByName('N_VLR_TRO').AsFloat;
    CodMedico := Orcamento.FieldByName('I_COD_MED').AsInteger;
    NumReceita := Orcamento.FieldByName('C_NUM_REC').AsString;
    DatReceita := Orcamento.FieldByName('D_DAT_REC').AsDateTime;
    TipReceita := Orcamento.FieldByName('I_TIP_REC').AsInteger;

    if Orcamento.FieldByName('D_DAT_ENT').IsNull then
      DatEntrega := 0
    else
    begin
      DatEntrega := Orcamento.FieldByName('D_DAT_ENT').AsDateTime;
      HorPrevista := Orcamento.FieldByName('T_HOR_ENT').AsDateTime;
    end;
  end;
  CarDTipoOrcamento(VpaDOrcamento);
  CarDOrcamentoProduto(VpaDOrcamento);
  CarDOrcamentoServico(VpaDOrcamento);

  Orcamento.Close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDParcelaOrcamento(VpaDOrcamento : TRBDOrcamento);
var
  VpfLaco : Integer;
begin
  VpaDOrcamento.Parcelas.Clear;
  if (VpaDOrcamento.FinanceiroGerado) and ((VpaDOrcamento.NumNotas = '') or (config.GerarFinanceiroCotacao)) then
  begin
     CarParcelasContasaReceber(VpaDOrcamento);
   end
   else
   begin
     CriaParcelas.Parcelas(VpaDOrcamento.ValTotalLiquido,VpaDOrcamento.CodCondicaoPagamento,true,Date);
     for VpfLaco := 0 to CriaParcelas.TextoParcelas.Count - 1 do
     begin
        VpaDOrcamento.Parcelas.Add(CentraStr(InttoStr(Vpflaco + 1),6) + ' - '+
                           CentraStr(CriaParcelas.TextoVencimentos.Strings[Vpflaco],10) + ' - ' +
                           AdicionaBrancoE(Formatfloat(Varia.MascaraMoeda,StrToFloat(DeletaChars(CriaParcelas.TextoParcelas.Strings[Vpflaco],'.'))),17));
     end;
   end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDtipoCotacao(VpaDTipoCotacao : TRBDTipoCotacao;VpaCodTipoCotacao : Integer);
begin
  AdicionaSQLAbreTabela(Orcamento,'Select * from CADTIPOORCAMENTO '+
                                  ' Where I_COD_TIP = '+IntToStr(VpaCodTipoCotacao));
  with VpaDTipoCotacao do
  begin
    CodTipo := VpaCodTipoCotacao;
    CodOperacaoEstoque := Orcamento.FieldByName('I_COD_OPE').AsInteger;
    CodVendedor := Orcamento.FieldByName('I_COD_VEN').AsInteger;
    NomTipo := Orcamento.FieldByName('C_NOM_TIP').AsString;
    CodPlanoContas := Orcamento.FieldByName('C_CLA_PLA').AsString;
    IndExigirDataEntregaPrevista := (Orcamento.FieldByName('C_IND_DAP').AsString = 'S');
    IndChamado := (Orcamento.FieldByName('C_IND_CHA').AsString = 'S');
    IndRevenda := (Orcamento.FieldByName('C_IND_REV').AsString = 'S');
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarComposeCombinacao(VpaDProCotacao : TRBDOrcProduto);
var
  VpfDCompose : TRBDOrcCompose;
begin
  FreeTObjectsList(VpaDProCotacao.Compose);
  AdicionaSQLAbreTabela(Orcamento,'select KIT.I_COR_REF, KIT.N_QTD_PRO, KIT.I_COD_COR, ' +
                                 ' PRO.I_SEQ_PRO, PRO.C_NOM_PRO, PRO.C_COD_PRO, '+
                                 ' COR.COD_COR, NOM_COR ' +
                                 ' from MOVKIT KIT, CADPRODUTOS PRO, COR '+
                                 ' Where KIT.I_PRO_KIT = '+IntToStr(VpaDProCotacao.SeqProduto)+
                                 ' and KIT.I_COR_KIT = '+IntToStr(VpaDProCotacao.CodCor)+
                                 ' and KIT.I_COR_REF IS NOT NULL '+
                                 ' AND KIT.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                 ' AND KIT.I_COD_COR = COR.COD_COR '+
                                 ' ORDER BY KIT.I_COR_REF ');
  While not Orcamento.eof do
  begin
    if Orcamento.FieldByname('I_COR_REF').AsInteger <> 0 then
    begin
      VpfDCompose := VpaDProCotacao.AddCompose;
      VpfDCompose.SeqProduto := Orcamento.FieldByname('I_SEQ_PRO').AsInteger;
      VpfDCompose.CorRefencia := Orcamento.FieldByname('I_COR_REF').AsInteger;
      VpfDCompose.CodCor := Orcamento.FieldByname('COD_COR').AsInteger;
      VpfDCompose.CodProduto := Orcamento.FieldByname('C_COD_PRO').AsString;
      VpfDCompose.NomProduto := Orcamento.FieldByname('C_NOM_PRO').AsString;
      VpfDCompose.NomCor := Orcamento.FieldByname('NOM_COR').AsString;
    end;
    Orcamento.next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarPrecosProdutosRevenda(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfDProduto : TRBDOrcProduto;
begin
  for vpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpaDCotacao.IndRevenda then
      VpfDProduto.ValUnitario := VpfDProduto.ValRevenda
    else
      VpfDProduto.ValUnitario := VpfDProduto.ValUnitarioOriginal;
    VpfDProduto.ValTotal := VpfDProduto.ValUnitario * VpfDProduto.ValUnitario;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RProdutoCotacao(VpaDCotacao : TRBDOrcamento;VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer;VpaValUnitario : Double):TRBDOrcProduto;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDCotacao.Produtos.count - 1 do
  begin
    if (TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]).SeqProduto = VpaSeqProduto) and
       (TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]).CodCor = VpaCodCor) and
       (TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]).CodTamanho = VpaCodTamanho) and
       (TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]).ValUnitario = VpaValUnitario)  then
      result := TRBDOrcProduto(VpaDCotacao.Produtos.Items[Vpflaco]);
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RServicoCotacao(VpaDCotacao : TRBDOrcamento; VpaCodServico : Integer): TRBDOrcServico;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
  begin
    if  TRBDOrcServico(VpaDCotacao.Servicos.Items[Vpflaco]).CodServico = VpaCodServico then
      result := TRBDOrcServico(VpaDCotacao.Servicos.Items[Vpflaco]);
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RSeqNotaFiscalCotacao(VpaCodFilial,VpaLanOrcamento : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_SEQ_NOT from MOVNOTAORCAMENTO '+
                            ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('I_SEQ_NOT').AsInteger;
  aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.RTipoOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select I_TIP_ORC from CADORCAMENTOS '+
                            ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                            ' and I_LAN_ORC = ' +IntToStr(VpaLanOrcamento));
  result := Aux.FieldByName('I_TIP_ORC').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RNomeTipoOrcamento(VpaTipCotacao : Integer) : string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_TIP from CADTIPOORCAMENTO '+
                            ' Where I_COD_TIP = ' +IntToStr(VpaTipCotacao));
  Result := aux.FieldByName('C_NOM_TIP').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RVendedorUltimaCotacao : Integer;
var
  VpfIni : TRegIniFile;
begin
  VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  result := VpfIni.ReadInteger('COTACAO','ULTIMOVENDEDOR',0);
  VpfIni.free;
end;

{******************************************************************************}
function TFuncoesCotacao.RNomTransportadora(VpaCodTransportadora : Integer) : string;
begin
  Result := '';
  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select C_NOM_TRA from CADTRANSPORTADORAS ' +
                            ' Where I_COD_TRA = ' +IntToStr(VpaCodTransportadora));
    result := Aux.FieldByname('C_NOM_TRA').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RNomVendedor(VpaCodVendedor : Integer):string;
begin
  result := '';
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select C_NOM_VEN from CADVENDEDORES '+
                              ' Where I_COD_VEN = ' +IntToStr(VpaCodVendedor));
    result := Aux.FieldByname('C_NOM_VEN').AsString;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.REmailVencedor(VpaCodVendedor : Integer) : string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_DES_EMA from CADVENDEDORES '+
                            ' Where I_COD_VEN = '+IntToStr(VpaCodVendedor));
  result := Aux.FieldByname('C_DES_EMA').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesCotacao.ROrdemProducao(VpaCodFilial,VpaLanOrcamento, VpaItemOrcamento : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select SEQORD from ORDEMPRODUCAOCORPO '+
                            ' Where EMPFIL = '+IntToStr(VpaCodFilial)+
                            ' and NUMPED = '+IntToStr(VpaLanOrcamento)+
                            ' and ITEORC = '+IntToStr(VpaItemOrcamento));
  result := Aux.FieldByname('SEQORD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.VerificaBrindeCliente(VpadCotacao : TRBDOrcamento;VpaDItemCotacao :TRBDOrcProduto);
var
  VpfQtdBrinde : Double;
  VpfDItem : TRBDOrcProduto;
begin
  if (VpadCotacao.CodTipoOrcamento <> varia.TipoCotacaoContrato) and
     (VpadCotacao.CodTipoOrcamento <> varia.TipoCotacaoGarantia) and
     (VpadCotacao.CodTipoOrcamento <> varia.TipoCotacaoGarantia) THEN
  begin
    VpfQtdBrinde := RQtdBrindeProdutoCliente(VpadCotacao.CodCliente,VpaDItemCotacao.SeqProduto,VpaDItemCotacao.UM);
    if VpfQtdBrinde > 0 then
    begin
      VpaDItemCotacao.IndBrinde := true;
      if VpfQtdBrinde < VpaDItemCotacao.QtdProduto then
      begin
        VpfDItem := VpadCotacao.AddProduto;
        DuplicaDadosItemOrcamento(VpaDItemCotacao,VpfDItem);
        VpfDItem.IndBrinde := false;
        VpfDItem.QtdProduto := VpaDItemCotacao.QtdProduto - VpfQtdBrinde;
        if VpfDItem.ValUnitario = 0 then
          VpfDItem.ValUnitario := VpaDItemCotacao.ValUnitarioOriginal;
        VpaDItemCotacao.QtdProduto := VpfQtdBrinde;
      end;
      VpaDItemCotacao.QtdSaldoBrinde := VpfQtdBrinde - VpaDItemCotacao.QtdProduto;
      VpaDItemCotacao.ValUnitario := 0;
      VpaDItemCotacao.ValTotal := 0;
    end;
  end;

end;

{******************************************************************************}
function TFuncoesCotacao.VerificaProdutoDuplicado(VpaDCotacao : TRBDOrcamento;VpaDItemCotacao : TRBDOrcProduto):Boolean;
var
  VpfLaco : Integer;
begin
  result := false;
  if config.CodigoBarras then   //essa rotina funciona somente para leitor de codigo de barras, pois só testa a ultima inserção, se for alterado um item ele nào controla. Não tirar esse if, analisar beeeem a rotina antes.
  begin
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count -2 do
    begin
      if (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).SeqProduto = VpaDItemCotacao.SeqProduto) and
         (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).UM = VpaDItemCotacao.UM) and
         (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).DesRefCliente = VpaDItemCotacao.DesRefCliente)  then
      begin
        result := true;
        TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto +VpaDItemCotacao.QtdProduto;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteProduto(VpaCodProduto : String;VpaCodTabelaPreco : Integer; VpaDProCotacao : TRBDOrcProduto;VpaDCotacao : TRBDOrcamento):Boolean;
begin
  result := false;
  if VpaCodTabelaPreco = 0 then
    VpaCodTabelaPreco := Varia.TabelaPreco;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(Orcamento,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, PRO.N_RED_ICM,'+
                                  ' PRO.N_PES_BRU, PRO.N_PES_LIQ, PRO.N_PER_KIT, PRO.C_IND_RET, PRO.C_IND_CRA, '+
                                  ' PRO.C_REG_MSM , PRO.I_PRI_ATI, PRO.N_PER_COM, PRO.I_IND_COV, PRO.I_MES_GAR, '+
                                  ' PRO.C_PAT_FOT, '+
                                  ' (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                                  ' (Pre.N_Vlr_REV * Moe.N_Vlr_Dia) VlrReVENDA, ' +
                                  ' (QTD.N_QTD_PRO - QTD.N_QTD_RES) QdadeReal, '+
                                  ' Qtd.N_QTD_MIN, QTD.N_QTD_PED, QTD.N_QTD_FIS, ' +
                                  ' CLA.C_COD_CLA, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, CLA.C_ALT_QTD '+
                                  ' from CADPRODUTOS PRO, MOVTABELAPRECO PRE, CadMOEDAS Moe,  '+
                                  ' MOVQDADEPRODUTO Qtd, CADCLASSIFICACAO CLA ' +
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and Pre.I_Cod_Emp = ' + IntTosTr(Varia.CodigoEmpresa) +
                                  ' and PRE.I_COD_TAB = '+IntToStr(VpaCodTabelaPreco)+
                                  ' and Pro.I_Seq_Pro = Pre.I_Seq_Pro ' +
                                  ' and Pre.I_Cod_Moe = Moe.I_Cod_Moe '+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and PRO.C_ATI_PRO = ''S'' '+
                                  ' and Pro.c_ven_avu = ''S'''+
                                  ' AND PRO.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' and PRE.I_COD_CLI IN (0,'+IntToStr(VpaDCotacao.CodCliente)+')'+
                                  ' order by PRE.I_COD_CLI DESC',true);

    result := not Orcamento.Eof;
    if result then
    begin
      with VpaDProCotacao do
      begin
        UMOriginal := Orcamento.FieldByName('C_Cod_Uni').Asstring;
        UM := Orcamento.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := UM;
        ValUnitarioOriginal := Orcamento.FieldByName('VlrReal').AsFloat;
        QtdEstoque := Orcamento.FieldByName('QdadeReal').AsFloat;
        QtdMinima := Orcamento.FieldByName('N_QTD_Min').AsFloat;
        QtdPedido := Orcamento.FieldByName('N_QTD_Ped').AsFloat;
        QtdFiscal := Orcamento.FieldByName('N_QTD_FIS').AsFloat;
        CodProduto := Orcamento.FieldByName(Varia.CodigoProduto).Asstring;
        CodClassificacao := Orcamento.FieldByName('C_COD_CLA').Asstring;
        if (VpaDCotacao.IndRevenda or  VpaDCotacao.IndClienteRevenda) and (Orcamento.FieldByName('VlrRevenda').AsFloat <> 0) then
          ValUnitario := Orcamento.FieldByName('VlrRevenda').AsFloat
        else
          ValUnitario := Orcamento.FieldByName('VlrReal').AsFloat;
        ValRevenda := Orcamento.FieldByName('VlrRevenda').AsFloat;
        QtdProduto := 1;
        QtdBaixado := 0;
        QtdKit := Orcamento.FieldByName('I_IND_COV').AsInteger;
        SeqProduto := Orcamento.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := Orcamento.FieldByName('C_NOM_PRO').AsString;
        PesLiquido := Orcamento.FieldByName('N_PES_LIQ').AsFloat;
        PesBruto := Orcamento.FieldByName('N_PES_BRU').AsFloat;
        PerDesconto := Orcamento.FieldByName('N_PER_KIT').AsFloat;
        PerComissao := Orcamento.FieldByName('N_PER_COM').AsFloat;
        PerComissaoClassificacao := Orcamento.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
        RedICMS := Orcamento.FieldByName('N_RED_ICM').AsFloat;
        IndFaturar := (QtdFiscal > (QtdPedido * 2));
        IndRetornavel  := (Orcamento.FieldByName('C_IND_RET').AsString = 'S');
        IndCracha  := (Orcamento.FieldByName('C_IND_CRA').AsString = 'S');
        IndPermiteAlterarQtdnaSeparacao  := (Orcamento.FieldByName('C_ALT_QTD').AsString = 'S');
        IndBrinde := false;
        DesRegistroMSM := Orcamento.FieldByName('C_REG_MSM').AsString;
        QtdMesesGarantia := Orcamento.FieldByName('I_MES_GAR').AsInteger;
        CodPrincipioAtivo := Orcamento.FieldByName('I_PRI_ATI').AsInteger;
        PathFoto := Orcamento.FieldByName('C_PAT_FOT').AsString;
        if config.Farmacia then
        begin
          IndMedicamentoControlado := FunProdutos.PrincipioAtivoControlado(CodPrincipioAtivo);
        end;
      end;
    end;
    Orcamento.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteServico(VpaCodServico : String;VpaDSerCotacao : TRBDOrcServico):Boolean;
begin
  result := false;
  if VpaCodServico <> '' then
  begin
    AdicionaSQLAbreTabela(Orcamento,'Select (Moe.N_Vlr_dia * Pre.N_Vlr_Ven) Valor, SER.C_NOM_SER, SER.I_COD_SER, '+
                           ' SER.N_PER_ISS, CLA.C_COD_CLA, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO '+
                           ' from cadservico Ser, MovTabelaPrecoServico Pre, CadMoedas Moe, CADCLASSIFICACAO CLA ' +
                           ' where Ser.I_Cod_ser = ' + VpaCodServico +
                           ' and Pre.I_Cod_ser = Ser.I_Cod_Ser ' +
                           ' and Pre.i_cod_emp = ' + IntToStr(varia.codigoEmpresa) +
                           ' and Pre.I_Cod_tab = '+ IntToStr(Varia.TabelaPrecoServico)+
                           ' and SER.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' and SER.C_COD_CLA = CLA.C_COD_CLA '+
                           ' and SER.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' and Moe.I_cod_Moe = Pre.I_Cod_Moe');

    result := not Orcamento.Eof;
    if result then
    begin
      with VpaDSerCotacao do
      begin
        NomServico := Orcamento.FieldByName('C_NOM_SER').AsString;
        CodClassificacao := Orcamento.FieldByName('C_COD_CLA').AsString;
        CodServico := Orcamento.FieldByName('I_COD_SER').AsInteger;
        QtdServico := 1;
        ValUnitario := Orcamento.FieldByName('Valor').AsFloat;
        PerISSQN := Orcamento.FieldByName('N_PER_ISS').AsFloat;
        PerComissaoClassificacao := Orcamento.FieldByName('PERCOMISSAOCLASSIFICACAO').AsFloat;
      end;
    end;
    Orcamento.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.Existecor(VpaCodCor :String;VpaDProCotacao : TRBDOrcProduto) :Boolean;
begin
  result := false;
  if VpaCodCor <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from COR '+
                              ' Where COD_COR = '+VpaCodCor );
    result := not Aux.eof;
    if result then
    begin
      VpaDProCotacao.CodCor := Aux.FieldByName('COD_COR').AsInteger;
      VpaDProCotacao.DesCor := Aux.FieldByName('NOM_COR').AsString;
    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteTamanho(VpaCodTamanho : String;var VpaNomTamanho : string):Boolean;
begin
  result := false;
  if VpaCodTamanho <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select CODTAMANHO, NOMTAMANHO FROM TAMANHO '+
                              ' Where CODTAMANHO = ' +VpaCodTamanho);
    Result := not Aux.Eof;
    if result then
      VpaNomTamanho := Aux.FieldByname('NOMTAMANHO').AsString;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteEmbalagem(VpaCodEmbalagem :String;VpaDProCotacao : TRBDOrcProduto):Boolean;
begin
  result := false;
  if VpaCodEmbalagem <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from EMBALAGEM '+
                              ' Where COD_EMBALAGEM = '+VpaCodEmbalagem );
    result := not Aux.eof;
    if result then
    begin
      VpaDProCotacao.CodEmbalagem := Aux.FieldByName('COD_EMBALAGEM').AsInteger;
      VpaDProCotacao.DesEmbalagem := Aux.FieldByName('NOM_EMBALAGEM').AsString;
    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteBaixaParcial(VpaDCotacao : TRBDOrcamento) : Boolean;
var
  VpfLaco : Integer;
begin
  result := false;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    if (TRBDOrcProduto(VpaDCotacao.produtos.Items[VpfLaco]).QtdABaixar <> 0) or
       (TRBDOrcProduto(VpaDCotacao.produtos.Items[VpfLaco]).QtdConferido <> 0) then
    begin
      result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.ExtornaOrcamento(VpaCodFilial, VpaLanOrcamento : Integer) :string;
var
  VpfAbriuTransacao : boolean;
  VpfDCotacao : TRBDOrcamento;
  VpfT : TTransactionDesc;
begin
  VpfDCotacao := TRBDOrcamento.cria;
  cardorcamento(VpfDCotacao,VpaCodFilial,VpaLanOrcamento);
  result := '';
  VpfAbriuTransacao := false;
  if not VprBaseDados.InTransaction then
  begin
    VpfT.IsolationLevel := xilREADCOMMITTED;
    VprBaseDados.StartTransaction(vpfT);
    VpfAbriuTransacao := true;
  end;
//Foi colocado em comentario pois na work quando é para extornar o orcamento não é para cancelar a nota.
//  result := ExtornaNotaOrcamento(VpaLanOrcamento);
  if result = '' then
  begin
    result := ExcluiFinanceiroOrcamento(VpaCodFilial,VpaLanOrcamento);
    if result = '' then
    begin
      IF VpfDCotacao.CodOperacaoEstoque <> 0 then
        result := EstornaEstoqueOrcamento(VpfDCotacao);
      if Result = '' then
      begin
        result := ExtornaBrindeCliente(VpfDCotacao);
        if result = '' then
        begin
          if Varia.EstagioCotacaoExtornada <> 0 then
            result := AlteraEstagioCotacao(VpfDCotacao.CodEmpFil,varia.CodigoUsuario,VpfDCotacao.LanOrcamento,varia.EstagioCotacaoExtornada,'Cotacao Extornada');
        end;
      end;
    end;
  end;

  if result = '' then
  begin
    BaixaReservaProdutoOrcamento(VpaCodFilial,VpaLanOrcamento);
    ExecutaComandoSql(Aux,'Update MovOrcamentos '+
                             ' Set C_Fla_Res = ''N''' +
                             ' , N_QTD_BAI = NULL '+
                             ' , D_DAT_GOP = NULL '+
                             ' , N_QTD_CON = NULL '+
                             ' Where I_Emp_Fil = '+ IntToStr(VpaCodFilial) +
                             ' and I_Lan_Orc = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                             ' Set C_GER_FIN = NULL ' +
                             ' , C_FLA_SIT = ''A'''+
                             ' , C_IND_CAN = ''N'''+
                             ' , D_DAT_ENT = NULL '+
                             ' , T_HOR_ENT = NULL '+
                             ' , C_NOT_GER = NULL '+
                             ' Where I_Emp_Fil = '+ IntToStr(VpaCodFilial) +
                             ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
  end;
  if result = '' then
  begin
    if VpfAbriuTransacao then
      VprBaseDados.Commit(vpfT);
  end
  else
  begin
    if  VpfAbriuTransacao then
      VprBaseDados.Rollback(VpfT);
    aviso(result);
  end;
  VpfDCotacao.free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CancelaOrcamento(VpacodFilial,VpaLanOrcamento : Integer);
var
  VpfResultado : String;
begin
  VpfResultado := ExtornaOrcamento(VpacodFilial,VpaLanOrcamento);
  if VpfResultado = '' then
  begin
    if Varia.EstagioCotacaoExtornada <> 0 then
      AlteraEstagioCotacao(VpaCodFilial,varia.CodigoUsuario,VpaLanOrcamento,varia.EstagioCotacaoExtornada,'Cotacao Cancelada');
    ExecutaComandoSql(Aux,'Update CadOrcamentos '+
                          ' Set C_IND_CAN = ''S''' +
                          ' Where I_Emp_Fil = ' + IntToStr(VpacodFilial)+
                          ' and I_Lan_Orc = ' + IntTostr(VpaLanOrcamento));
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFuncoesCotacao.CancelaSaldoItemOrcamento(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' and I_SEQ_MOV = '+IntToStr(VpaSeqMovimento));
  CotCadastro.Edit;
  CotCadastro.FieldByname('N_QTD_BAI').AsFloat := CotCadastro.FieldByname('N_QTD_PRO').AsFloat;
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.cancelaFinanceiroNota(VpaCodigoFilial, VpaLanOrcamento : integer);
begin
  ExecutaComandoSql(Aux,'Update CADCONTASARECEBER '+
                        ' Set I_SEQ_NOT = NULL '+
                        ' , C_IND_CAD = ''S'''+
                        ' Where I_EMP_FIL = '+IntToStr(VpaCodigoFilial)+
                        ' AND I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
end;

{************************ reserva o produto ***********************************}
procedure TFuncoesCotacao.ReservaProduto(VpaSeqProduto, VpaUnidade : String; VpaQtd : Double);
begin
   AdicionaSQLAbreTabela(aux,'Select N_Qtd_Res, Pro.C_Cod_Uni '+
                             ' from MovQdadeProduto Qtd, CadProdutos Pro' +
                             ' Where Qtd.I_Emp_Fil = ' + intToStr(Varia.CodigoEmpFil) +
                             ' and Qtd.I_Seq_Pro = ' + VpaSeqProduto+
                             ' and Qtd.I_Seq_Pro =  Pro.I_Seq_Pro');
   ExecutaComandoSql(Aux,'Update MovQdadeProduto ' +
                         ' set N_Qtd_Res = ' + SubstituiStr(FormatFloat('##0.00',Aux.FieldByName('N_Qtd_Res').AsFloat +
                                              (VpaQtd * IndiceUnidade.Indice(VpaUnidade,Aux.FieldByName('C_Cod_Uni').Asstring,StrToInt(VpaSeqProduto),Varia.CodigoEmpresa))),',','.')+
                         ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(date) +
                         ' where I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil) +
                         ' and I_Seq_Pro = '+ VpaSeqProduto);
end;

{*************** baixa as reservas dos produtos orcamento *********************}
procedure TFuncoesCotacao.BaixaReservaProdutoOrcamento(VpaCodFilial, VpaLanOrcamento : Integer);
begin
  AdicionaSQLAbreTabela(Orcamento,'Select * from MOVORCAMENTOS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_LAN_ORC = '+ Inttostr(VpaLanOrcamento));

  while not Orcamento.eof do
  begin
    if Uppercase(Orcamento.FieldByName('C_Fla_Res').Asstring) = 'S' Then
      Baixareserva(VpaCodFilial, Orcamento.FieldByName('I_Seq_Pro').AsInteger,Orcamento.FieldByName('C_Cod_Uni').Asstring,Orcamento.FieldByName('N_Qtd_Pro').AsFloat);
    Orcamento.next;
  end;
  Orcamento.close;
end;

{************************ baixa reserva dos produto ***************************}
procedure TFuncoesCotacao.BaixaReserva(VpaCodFilial, VpaSeqProduto : Integer; VpaUnidade : String; VpaQtd : Double);
begin
   AdicionaSQLAbreTabela(aux,'Select N_Qtd_Res, Pro.C_Cod_Uni '+
                             ' from MovQdadeProduto Qtd, CadProdutos Pro' +
                             ' Where Qtd.I_Emp_Fil = ' + intToStr(VpaCodFilial) +
                             ' and Qtd.I_Seq_Pro = ' + IntToStr(VpaSeqProduto)+
                             ' and Qtd.I_Seq_Pro =  Pro.I_Seq_Pro');
   ExecutaComandoSql(Aux,'Update MovQdadeProduto ' +
                         ' set N_Qtd_Res = ' + SubstituiStr(FormatFloat('##0.00',Aux.FieldByName('N_Qtd_Res').AsFloat -
                                              (VpaQtd * IndiceUnidade.Indice(VpaUnidade,Aux.FieldByName('C_Cod_Uni').Asstring,VpaSeqProduto,Varia.CodigoEmpresa))),',','.')+
                         ' , D_ULT_ALT = '+ SQLTextoDataAAAAMMMDD(DATE) +
                         ' where I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil) +
                         ' and I_Seq_Pro = '+ IntTostr(VpaSeqProduto));
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosEtiquetadosSeparados(VpaDCotacao : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfDItemCotacao : TRBDOrcProduto;
begin
  result := '';
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItemCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfDItemCotacao.QtdABaixar <> 0 then
    begin
      if ((VpfDItemCotacao.QtdBaixado + VpfDItemCotacao.QtdABaixar) >= VpfDItemCotacao.QtdProduto) then
      begin
        try
          ExecutaComandoSql(Aux,'Delete from PRODUTOETIQUETADOCOMPEDIDO ' +
                                ' Where CODFILIAL = '+ IntToStr(VpaDCotacao.CodEmpFil)+
                                 ' and LANORCAMENTO = '+IntToStr(VpaDCotacao.LanOrcamento)+
                                ' and SEQMOVIMENTO = '+IntToStr(VpfDItemCotacao.SeqMovimento));
        except
          on e : exception do result :='ERRO NA BAIXA DOS PRODUTOS ETIQUETADOS!!!'#13+e.message;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaProdutosParcialCotacao(VpaDCotacao : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfDItemCotacao : TRBDOrcProduto;
  VpfQtdBaixar : Double;
begin
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItemCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if (VpfDItemCotacao.QtdABaixar <> 0) or (VpfDItemCotacao.QtdConferido <> 0) then
    begin
      Aux.sql.clear;
      Aux.sql.add( 'UPDATE MOVORCAMENTOS ');
      if VpfDItemCotacao.QtdABaixar <> 0 then
        Aux.sql.add(' Set N_QTD_BAI = '+SqlTextoIsNull('N_QTD_BAI','0')+' + '+SubstituiStr(FormatFloat('0.00',VpfDItemCotacao.QtdABaixar),',','.'))
      else
        Aux.sql.add(' Set N_QTD_CON = '+SqlTextoIsNull('N_QTD_CON','0')+' + ' + SubstituiStr(FormatFloat('0.00',VpfDItemCotacao.QtdConferido),',','.'));
      Aux.sql.add(' WHERE I_EMP_FIL = '+ IntToStr(VpadCotacao.CodEmpFil)+
                  ' and I_LAN_ORC = '+ IntToStr(VpaDCotacao.LanOrcamento)+
                  ' AND I_SEQ_MOV = '+ IntToStr(VpfDItemCotacao.SeqMovimento));
      try
        Aux.ExecSQL;
      except
        on e : exception do
        begin
          result := 'ERRO NA BAIXA DA COTACAO!!!'#13+e.message;
        end;
      end;
    end;
  end;
end;

{***************** retorna o valor total do orcamento *************************}
function TFuncoesCotacao.RetornaValorTotalOrcamento(VpaMovOrcamento : TDataSet): Double;
begin
  result := 0;
  VpaMovOrcamento.first;
  while not VpaMovOrcamento.eof do
  begin
    Result := result + VpaMovOrcamento.FieldByName('N_Vlr_Tot').AsFloat;
    VpaMovOrcamento.next;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.BaixaOrcamento(VpaDOrcamento : TRBDOrcamento);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDOrcamento.Produtos.count - 1 do
  begin
    TRBDOrcProduto(VpaDOrcamento.Produtos.Items[VpfLaco]).QtdBaixado := TRBDOrcProduto(VpaDOrcamento.Produtos.Items[VpfLaco]).QtdProduto;
  end;
  if VpaDOrcamento.DatEntrega = 0 then
  begin
    VpaDOrcamento.DatEntrega := date;
  end;
  GravaDCotacao(VpaDOrcamento,nil);
end;

{************************* exclui o orcamento *********************************}
procedure TFuncoesCotacao.ExcluiOrcamento(VpaCodFilial, VpaLanOrcamento : Integer;VpaEstornarEstoque : Boolean = true);
var
  VpfResultado : String;
begin
  VpfResultado := '';
  if VpaEstornarEstoque then
  begin
    vpfResultado := ExtornaOrcamento(VpaCodFilial,VpaLanOrcamento);
  end;


  if VpfResultado = '' then
  begin
    ExcluiMovOrcamento(VpaCodFilial,VpaLanOrcamento);
    ExecutaComandoSql(Aux,'Delete from MOVNOTAORCAMENTO '+
                          ' Where I_EMP_FIL = '+ InttoStr(VpaCodFilial)+
                          ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from ESTAGIOORCAMENTO '+
                          ' Where CODFILIAL = '+ InttoStr(VpaCodFilial)+
                          ' and SEQORCAMENTO = '+ IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from ORCAMENTOPARCIALITEM '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from CONTRATOPROCESSADOITEM '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete FROM LEITURALOCACAOCORPO '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from ORCAMENTOEMAIL '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,' Update  PESOCARTUCHO '+
                          ' SET CODFILIAL = NULL '+
                          ' , LANORCAMENTO = NULL '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from ORCAMENTOPARCIALCORPO '+
                          ' Where CODFILIAL = ' + InttoStr(VpaCodFilial) +
                          ' and LANORCAMENTO = ' + IntToStr(VpaLanOrcamento));
    sistema.GravaLogExclusao('CADORCAMENTOS','Select * from CadOrcamentos '+
                          ' Where I_Emp_Fil = ' + InttoStr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntToStr(VpaLanOrcamento));
    ExecutaComandoSql(Aux,'Delete from CadOrcamentos '+
                          ' Where I_Emp_Fil = ' + InttoStr(VpaCodFilial) +
                          ' and I_Lan_Orc = ' + IntToStr(VpaLanOrcamento));
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFuncoesCotacao.ExcluiBaixaParcialCotacao(VpaCodFilial, VpaLanOrcamento, VpaSeqParcial : Integer) : string;
var
  VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  result := FunProdutos.OperacoesEstornoValidas;
  if result = '' then
  begin
    AdicionaSQLAbreTabela(Orcamento,'Select ITE.QTDPARCIAL, '+
                                    ' MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.N_VLR_PRO, MOV.C_COD_UNI, '+
                                    ' MOV.C_PRO_REF, PRO.C_COD_UNI UNIORIGINAL '+
                                    ' from ORCAMENTOPARCIALITEM ITE, MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                                    ' Where ITE.CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                    ' and ITE.LANORCAMENTO = '+ IntToStr(VpaLanOrcamento)+
                                    ' and ITE.SEQPARCIAL = '+IntToStr(VpaSeqParcial)+
                                    ' AND ITE.CODFILIAL = MOV.I_EMP_FIL '+
                                    ' AND ITE.LANORCAMENTO = MOV.I_LAN_ORC '+
                                    ' AND ITE.SEQMOVORCAMENTO = MOV.I_SEQ_MOV'+
                                    ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ');
    While not Orcamento.eof do
    begin
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,0,VpaCodFilial,Orcamento.FieldByName('I_SEQ_PRO').AsInteger);
      FunProdutos.BaixaProdutoEstoque(VpfDProduto, VpaCodFilial, varia.OperacaoEstoqueEstornoEntrada,0,
                                      VpaLanOrcamento ,VpaLanOrcamento ,varia.MoedaBase,Orcamento.FieldByName('I_COD_COR').AsInteger,
                                      Orcamento.FieldByName('I_COD_TAM').AsInteger,
                                      date,Orcamento.FieldByName('QTDPARCIAL').AsFloat,Orcamento.FieldByName('QTDPARCIAL').AsFloat * Orcamento.FieldByName('N_VLR_PRO').AsFloat,
                                      Orcamento.FieldByName('C_COD_UNI').AsString ,Orcamento.FieldByName('C_PRO_REF').AsString, false,VpfSeqEstoqueBarra);
      VpfDProduto.free;
      Orcamento.next;
    end;
    Orcamento.Close;
    ExecutaComandoSql(Aux,'Delete from ORCAMENTOPARCIALITEM '+
                          ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                          ' and LANORCAMENTO = '+ IntToStr(VpaLanOrcamento)+
                          ' and SEQPARCIAL = '+IntToStr(VpaSeqParcial));
    ExecutaComandoSql(Aux,'Delete from ORCAMENTOPARCIALCORPO '+
                          ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                          ' and LANORCAMENTO = '+ IntToStr(VpaLanOrcamento)+
                          ' and SEQPARCIAL = '+IntToStr(VpaSeqParcial));
  end;

end;

{******************************************************************************}
function TFuncoesCotacao.GeraFinanceiro(VpaDOrcamento : TRBDOrcamento; VpaDCliente : TRBDCliente; VpaDContaReceber : TRBDContasCR;VpaFunContaAReceber : TFuncoesContasAReceber;var VpaResultado : String;VpaGravarRegistro : Boolean;VpaMostrarParcela :Boolean=true):Boolean;
Var
  VpfClienteCriado : Boolean;
begin
  VpfClienteCriado := false;
  VpaResultado := '';
  if (VpaDOrcamento.CodPlanoContas <> '') and (VpaDOrcamento.ValTotal > 0) then
  begin
    if VpaDCliente = nil then
    begin
      VpaDCliente := TRBDCliente.cria;
      VpaDCliente.CodCliente := VpaDOrcamento.CodCliente;
      FunClientes.CarDCliente(VpaDCliente);
      VpfClienteCriado := true;
    end;

    VpaDContaReceber.CodEmpFil := VpaDOrcamento.CodEmpFil;
    VpaDContaReceber.NroNota := VpaDOrcamento.LanOrcamento;
    VpaDContaReceber.LanOrcamento := VpaDOrcamento.LanOrcamento;
    VpaDContaReceber.SeqNota := 0;
    VpaDContaReceber.SeqParcialCotacao := 0;
    VpaDContaReceber.CodCondicaoPgto := VpaDOrcamento.CodCondicaoPagamento;
    VpaDContaReceber.CodCliente := VpaDOrcamento.CodCliente;
    VpaDContaReceber.CodFrmPagto := VpaDOrcamento.CodFormaPaqamento;
    VpaDContaReceber.NomCliente := VpaDCliente.NomCliente;
    VpaDContaReceber.NumContaCorrente := VpaDOrcamento.NumContaCorrente;
    if (VpaDOrcamento.CodFormaPaqamento = Varia.FormaPagamentoDeposito)and (VpaDCliente.ContaBancariaDeposito <> '') and
       (VpaDOrcamento.NumContaCorrente = '')then
      VpaDContaReceber.NumContaCorrente := VpaDCliente.ContaBancariaDeposito;
    VpaDContaReceber.CodMoeda :=  varia.MoedaBase;
    VpaDContaReceber.CodUsuario := varia.CodigoUsuario;
    VpaDContaReceber.DatMov := date; //VpaDOrcamento.DatOrcamento;
    if config.DataFinanceiroIgualDataCotacao then
      VpaDContaReceber.DatEmissao := VpaDOrcamento.DatOrcamento
    else
      VpaDContaReceber.DatEmissao := date;
    VpaDContaReceber.PlanoConta := VpaDOrcamento.CodPlanoContas;
    if config.QuandoForQuartodeNotanoRomaneioFazeroValorFaltante then
    begin
      if VpaDCliente.IndQuarto then
        VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido * 0.75
      else
        if VpaDCliente.IndMeia then
          VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido * 0.5
        else
          if VpaDCliente.IndVintePorcento then
            VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido * 0.8
          else
            VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido;
    end
    else
      VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido;
    VpaDContaReceber.PercentualDesAcr := 0;
    VpaDContaReceber.MostrarParcelas := VpaMostrarParcela;
    VpaDContaReceber.IndGerarComissao := true;
    VpaDContaReceber.CodVendedor := VpaDOrcamento.CodVendedor;

    // comissao
    if VpaDOrcamento.CodPreposto <> 0 then
    begin
      VpaDContaReceber.TipComissaoPreposto := 0;
      VpaDContaReceber.CodPreposto := VpaDOrcamento.CodPreposto;
      VpaDContaReceber.PerComissaoPreposto := VpaDOrcamento.PerComissaoPreposto;
      VpaDContaReceber.ValComissaoPreposto := RValComissao(VpaDOrcamento,VpaDContaReceber.TipComissaoPreposto,VpaDOrcamento.PerComissaoPreposto,0);
    end;

    // comissao
    if VpaDOrcamento.CodVendedor <> 0 then
    begin
      VpaDContaReceber.TipComissao := FunVendedor.RTipComissao(VpaDOrcamento.CodVendedor);
      VpaDContaReceber.PerComissao := VpaDOrcamento.PerComissao;
      VpaDContaReceber.ValComissao := RValComissao(VpaDOrcamento,VpaDContaReceber.TipComissao,VpaDOrcamento.PerComissao,VpaDOrcamento.PerComissaoPreposto);
    end;
    VpaDContaReceber.EsconderConta := true;
    result := VpaFunContaAReceber.CriaContasaReceber(VpaDContaReceber,VpaResultado,VpaGravarRegistro);
    VpaDOrcamento.CodFormaPaqamento := VpaDContaReceber.CodFrmPagto;
    //quando for para gerar o financeiro do valor faltante do 1/4 de nota inicializa novamente o valor total da cotaçao porque em seguida é chamada a rotina para salvar o valor total;
    if config.QuandoForQuartodeNotanoRomaneioFazeroValorFaltante then
      VpaDContaReceber.ValTotal := VpaDOrcamento.ValTotalLiquido
    else
      VpaDOrcamento.ValTotal := VpaDContaReceber.ValTotal;
    if result then
    begin
      VpaDOrcamento.FinanceiroGerado := true;
      VpaDOrcamento.IndCancelado := false;
    end;
  end
  else
    result := true;
  if VpfClienteCriado then
    VpaDCliente.free;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraFinanceiroParcial(VpaDOrcamento : TRBDOrcamento;VpaFunContaAReceber : TFuncoesContasAReceber;VpaSeqParcial : Integer;var VpaResultado : String):Boolean;
Var
  VpfDContaReceber : TRBDContasCR;
  VpfDCliente : TRBDCliente;
begin
  VpaResultado := '';
  if VpaDOrcamento.CodPlanoContas <> '' then
  begin
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VpaDOrcamento.CodCliente;
    FunClientes.CarDCliente(VpfDCliente,false,false);
    VpfDContaReceber := TRBDContasCR.Cria;
    VpfDContaReceber.CodEmpFil := Varia.CodigoEmpFil;
    VpfDContaReceber.NroNota := VpaDOrcamento.LanOrcamento;
    VpfDContaReceber.LanOrcamento := VpaDOrcamento.LanOrcamento;
    VpfDContaReceber.SeqNota := 0;
    VpfDContaReceber.SeqParcialCotacao := VpaSeqParcial;
    VpfDContaReceber.CodCondicaoPgto := VpaDOrcamento.CodCondicaoPagamento;
    VpfDContaReceber.CodCliente := VpaDOrcamento.CodCliente;
    VpfDContaReceber.CodFrmPagto := VpaDOrcamento.CodFormaPaqamento;
    VpfDContaReceber.CodMoeda :=  varia.MoedaBase;
    VpfDContaReceber.CodUsuario := varia.CodigoUsuario;
    VpfDContaReceber.DatMov := date; //VpaDOrcamento.DatOrcamento;
    VpfDContaReceber.DatEmissao := date;
    VpfDContaReceber.PlanoConta := VpaDOrcamento.CodPlanoContas;
    VpfDContaReceber.DesObservacao := 'Parcial "'+ IntToStr(VpaSeqParcial) +'" do Romaneio "'+IntToStr(VpaDOrcamento.LanOrcamento)+'"';
    if config.QuandoForQuartodeNotanoRomaneioFazeroValorFaltante then
    begin
      if VpfdCliente.IndQuarto then
        VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal * 0.75
      else
        if VpfDCliente.IndMeia then
          VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal * 0.5
        else
          if VpfDCliente.IndVintePorcento then
            VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal * 0.8
          else
            VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal;
    end
    else
      VpfDContaReceber.ValTotal := VpaDOrcamento.ValTotal;

    VpfDContaReceber.PercentualDesAcr := 0;
    VpfDContaReceber.MostrarParcelas := true;
    VpfDContaReceber.IndGerarComissao := true;
    VpfDContaReceber.EsconderConta := true;
    VpfDContaReceber.CodVendedor := VpaDOrcamento.CodVendedor;

    if VpaDOrcamento.CodPreposto <> 0 then
    begin
      VpfDContaReceber.TipComissaoPreposto := 0;
      VpfDContaReceber.CodPreposto := VpaDOrcamento.CodPreposto;
      VpfDContaReceber.PerComissaoPreposto := VpaDOrcamento.PerComissaoPreposto;
      VpfDContaReceber.ValComissaoPreposto := RValComissao(VpaDOrcamento,VpfDContaReceber.TipComissaoPreposto,VpaDOrcamento.PerComissaoPreposto,0);
    end;

    // comissao
    if VpaDOrcamento.CodVendedor <> 0 then
    begin
      VpfDContaReceber.TipComissao := FunVendedor.RTipComissao(VpaDOrcamento.CodVendedor) ;
      VpfDContaReceber.PerComissao := VpaDOrcamento.PerComissao;
      VpfDContaReceber.ValComissao := RValComissao(VpaDOrcamento,VpfDContaReceber.TipComissao,VpaDOrcamento.PerComissao,VpaDOrcamento.PerComissaoPreposto);
    end
    else
    VpfDContaReceber.EsconderConta := true;
    if VpfDContaReceber.ValTotal <> 0 then
      result := VpaFunContaAReceber.CriaContasaReceber(VpfDContaReceber,VpaResultado,true);
    VpfDCliente.free;
  end
  else
    result := true;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraEstoqueProdutos(VpaDOrcamento : TRBDOrcamento; FunProduto : TFuncoesProduto):String;
var
  VpfDProdutoOrc : TRBDOrcProduto;
  VpfLaco, VpfSeqEstoqueBarra : Integer;
  VpfIndice,VpfValTotalItem : Double;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  if VpaDOrcamento.CodOperacaoEstoque <> 0 then
  begin
    if VpaDOrcamento.ValTotalProdutos > 0 then
      VpfIndice := ((VpaDOrcamento.ValTotal *100)/VpaDOrcamento.ValTotalProdutos)-100
    else
      VpfIndice := 0;
    for VpfLaco := 0 to VpaDOrcamento.Produtos.Count - 1 do
    begin
      VpfDProdutoOrc := TRBDOrcProduto(VpaDOrcamento.Produtos.Items[Vpflaco]);
      if VpfDProdutoOrc.QtdProduto > 0 then
      begin
        VpfValTotalItem := (VpfDProdutoOrc.ValTotal);
        //adicina indide de acrescimo ou desconto conforme a cotacao
        VpfValTotalItem := VpfValTotalItem + ((VpfValTotalItem*VpfIndice)/100);
        VpfDProduto := TRBDProduto.Cria;
        FunProduto.CarDProduto(VpfDProduto,0,VpaDOrcamento.CodEmpFil,VpfDProdutoOrc.SeqProduto);
        FunProduto.BaixaProdutoEstoque(VpfDProduto, VpaDOrcamento.CodEmpFil,
                                        VpaDOrcamento.CodOperacaoEstoque,
                                        0,
                                        VpaDOrcamento.LanOrcamento,VpaDOrcamento.LanOrcamento,
                                        varia.MoedaBase, VpfDProdutoOrc.CodCor,VpfDProdutoOrc.CodTamanho, Date,
                                        VpfDProdutoOrc.QtdProduto,
                                        VpfValTotalItem,
                                        VpfDProdutoOrc.UM,
                                        VpfDProdutoOrc.DesRefCliente,false,VpfSeqEstoqueBarra);
        VpfDProduto.free;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraContasAReceberDevolucaoCotacao(VpaDOrcamento : TRBDOrcamento; VpaValor : Double):String;
Var
  VpfDContaReceber : TRBDContasCR;
begin
  result := '';
  if VpaDOrcamento.CodPlanoContas <> '' then
  begin
    VpfDContaReceber := TRBDContasCR.Cria;
    VpfDContaReceber.CodEmpFil := Varia.CodigoEmpFil;
    VpfDContaReceber.NroNota := VpaDOrcamento.LanOrcamento;
    VpfDContaReceber.SeqNota := 0;
    VpfDContaReceber.CodCondicaoPgto := VpaDOrcamento.CodCondicaoPagamento;
    VpfDContaReceber.CodCliente := VpaDOrcamento.CodCliente;
    VpfDContaReceber.CodFrmPagto := VpaDOrcamento.CodFormaPaqamento;
    VpfDContaReceber.CodMoeda :=  varia.MoedaBase;
    VpfDContaReceber.CodUsuario := varia.CodigoUsuario;
    VpfDContaReceber.DatMov := VpaDOrcamento.DatOrcamento;
    VpfDContaReceber.DatEmissao := date;
    VpfDContaReceber.PlanoConta := VpaDOrcamento.CodPlanoContas;
    VpfDContaReceber.ValTotal := VpaValor;
    VpfDContaReceber.PercentualDesAcr := 0;
    VpfDContaReceber.MostrarParcelas := true;
    VpfDContaReceber.IndGerarComissao := true;
    VpfDContaReceber.DesObservacao := 'Conta gerada pelas trocas';
    VpfDContaReceber.CodVendedor := VpaDOrcamento.CodVendedor;

    // comissao
    if VpaDOrcamento.CodVendedor <> 0 then
    begin
      VpfDContaReceber.TipComissao := FunVendedor.RTipComissao(VpaDOrcamento.CodVendedor);
      VpfDContaReceber.PerComissao := VpaDOrcamento.PerComissao;
      VpfDContaReceber.ValComissao := RValComissao(VpaDOrcamento,VpfDContaReceber.TipComissao,VpaDOrcamento.PerComissao,0);
    end;
    VpfDContaReceber.EsconderConta := true;
    FunContasAReceber.CriaContasaReceber(VpfDContaReceber,result,true);
  end;
end;


{******************************************************************************}
function TFuncoesCotacao.GeraContasaPagarDevolucaoCotacao(VpaDCotacao : TRBDOrcamento; VpaValor : Double):String;
var
  VpfDContasAPagar : TRBDContasaPagar;
begin
  result := '';
  VpfDContasAPagar := TRBDContasaPagar.create;
  VpfDContasAPagar.CodFilial := VpaDCotacao.CodEmpFil;
  VpfDContasAPagar.NumNota := VpaDCotacao.LanOrcamento;
  VpfDContasAPagar.SeqNota := 0;
  VpfDContasAPagar.CodFornecedor := VpaDCotacao.CodCliente;
  VpfDContasAPagar.CodFormaPagamento := varia.FormaPagamentoPadrao;
  VpfDContasAPagar.CodMoeda := varia.MoedaBase;
  VpfDContasAPagar.CodUsuario := varia.CodigoUsuario;
  VpfDContasAPagar.DatEmissao := date;
  VpfDContasAPagar.CodPlanoConta := varia.PlanoContasDevolucaoCotacao;
  VpfDContasAPagar.QtdParcela := 1;
  VpfDContasAPagar.ValParcela := VpaValor;
  VpfDContasAPagar.QtdDiasPriVen := 0;
  VpfDContasAPagar.QtdDiasDemaisVen :=0;
  VpfDContasAPagar.PerDescontoAcrescimo := 0;
  VpfDContasAPagar.IndBaixarConta := true;
  VpfDContasAPagar.IndMostrarParcelas := false;
  VpfDContasAPagar.IndEsconderConta := false;
  VpfDContasAPagar.DesTipFormaPAgamento := 'D';
  result :=  FunContasAPagar.CriaContaPagar(VpfDContasAPagar,nil);
  VpfDContasAPagar.Free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaFinanceiroGerado(VpaDOrcamento : TRBDOrcamento);
begin
  ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' Set C_GER_FIN = ''S'','+
                        ' I_COD_FRM = '+IntToStr(VpaDOrcamento.CodFormaPaqamento)+
                        ' , N_VLR_TOT = '+SubstituiStr(FormatFloat('0.00',VpaDOrcamento.ValTotal),',','.')+
                        ' , C_ORP_IMP = ''S'''+
                        ' Where I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil)+
                        ' and I_LAN_ORC = '+IntToStr(VpaDOrcamento.LanOrcamento));
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaOPImpressa(VpaCotacoes : TList);
var
  VpfLaco : Integer;
  VpfCotacoes : String;
begin
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' Set C_ORP_IMP = ''S'''+
                        ' Where I_EMP_FIL = '+InttoStr(TRBDOrcamento(VpaCotacoes.Items[VpfLaco]).CodEmpFil)+
                        ' and I_LAN_ORC = ' +InttoStr(TRBDOrcamento(VpaCotacoes.Items[VpfLaco]).LanOrcamento));
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaOrcamentoImpresso(VpaCodFilial,VpaLanOrcamento : Integer);
begin
  ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' Set C_IND_IMP = ''S'''+
                        ' Where I_EMP_FIL =  '+IntToStr(VpaCodfilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));

end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaOrcamentoProcessado(VpaCodFilial,VpaLanOrcamento : Integer);
begin
  ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' Set C_IND_PRO = ''S'''+
                        ' Where I_EMP_FIL =  '+IntToStr(VpaCodfilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));

end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaOrcamentoNaoProcessado(VpaCodFilial,VpaLanOrcamento : Integer);
begin
  ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' Set C_IND_PRO = ''N'''+
                        ' Where I_EMP_FIL =  '+IntToStr(VpaCodfilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
end;

{******************************************************************************}
procedure TFuncoesCotacao.SetaDataOpGeradaProduto(VpaCodFilial,VpaLanOrcamento, VpaSeqMovimento, VpaSeqOrdemProducao : Integer);
begin
  AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' AND I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' AND I_SEQ_MOV = '+IntToStr(VpaSeqMovimento));
  CotCadastro.edit;
  CotCadastro.FieldByName('D_DAT_GOP').AsDateTime := now;
  CotCadastro.FieldByName('I_SEQ_ORD').AsInteger := VpaSeqOrdemProducao;
  CotCadastro.post;
  CotCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AtualizaDCliente(VpaDCotacao :TRBDOrcamento;VpaDCliente : TRBDCliente);
begin
  if ((VpaDCliente.NomContato = '') and (VpaDCotacao.NomContato <>  '')) or
     ((VpaDCliente.CodVendedor = 0) and (VpaDCotacao.CodVendedor <> 0)) or
     ((VpaDCliente.PerComissao = 0) and (VpaDCotacao.PerComissao <> 0)) or
     ((VpaDCliente.CodTecnico = 0 ) and (VpaDCotacao.CodTecnico <> 0)) then
  begin
    LocalizaCliente(CotCadastro,IntToStr(VpaDCotacao.CodCliente));
    CotCadastro.Edit;
    if (VpaDCliente.NomContato = '') and (VpaDCotacao.NomContato <>  '') then
      CotCadastro.FieldByName('C_CON_CLI').AsString := VpaDCotacao.NomContato;
    if (VpaDCliente.CodVendedor = 0) and (VpaDCotacao.CodVendedor <> 0) then
      CotCadastro.FieldByName('I_COD_VEN').AsInteger := VpaDCotacao.CodVendedor;
    if (VpaDCliente.PerComissao = 0) and (VpaDCotacao.PerComissao <> 0) then
      CotCadastro.FieldByName('I_PER_COM').AsFloat := VpaDCotacao.PerComissao;
    if (VpaDCliente.CodTecnico = 0 ) and (VpaDCotacao.CodTecnico <> 0) then
      CotCadaStro.FieldByName('I_COD_TEC').AsInteger := VpaDCotacao.CodTecnico;
    CotCadastro.post;
  end;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDCotacao(VpaDCotacao : TRBDOrcamento;VpaDCliente:TRBDCliente):String;
var
  VpfQtdGravacao : Integer;
begin
  result := '';
  ExcluiMovOrcamento(VpaDCotacao.CodEmpFil, VpaDCotacao.LanOrcamento);
  LocalizaCadOrcamento(CotCadastro,IntToStr(VpaDCotacao.LanOrcamento));
  with VpaDCotacao do
  begin
    if LanOrcamento = 0 then
      CotCadastro.Insert
    else
    begin
      if CotCadastro.Eof then
        CotCadastro.Insert
      else
        CotCadastro.edit;
    end;
    if result = '' then
    begin
      with CotCadastro do
      begin
        FieldByName('I_EMP_FIL').AsInteger := CodEmpFil;
        FieldByName('I_TIP_ORC').AsInteger := CodTipoOrcamento;
        FieldByName('I_COD_USU').AsInteger := CodUsuario;
        FieldByName('I_COD_CLI').AsInteger := CodCliente;
        FieldByName('I_COD_TAB').AsInteger := CodTabelaPreco;
        FieldByName('I_COD_PAG').AsInteger := CodCondicaoPagamento;
        if CodEstagio <> 0 then
          FieldByName('I_COD_EST').AsInteger := CodEstagio
        else
          FieldByName('I_COD_EST').Clear;
        FieldByName('D_DAT_ORC').AsDateTime := DatOrcamento;
        FieldByName('T_HOR_ORC').AsDateTime := HorOrcamento;
        if FlaSituacao <> 'C' Then
          CarFlaSituacao(VpaDCotacao);
        if CodFormaPaqamento <> 0 then
          FieldByName('I_COD_FRM').AsInteger := CodFormaPaqamento
        else
          FieldByName('I_COD_FRM').Clear;
        if CodTecnico <> 0 then
          FieldByName('I_COD_TEC').AsInteger := CodTecnico
        else
          FieldByName('I_COD_TEC').Clear;
        if SeqNotaEntrada <> 0 then
          FieldByName('I_NOT_ENT').AsInteger := SeqNotaEntrada
        else
          FieldByName('I_NOT_ENT').Clear;
        FieldByName('C_FLA_SIT').Asstring := FlaSituacao;
        FieldByName('D_DAT_PRE').AsDateTime := DatPrevista;
        FieldByName('T_HOR_ENT').AsDateTime := HorPrevista;
        FieldByName('D_DAT_VAL').AsDateTime := DatValidade;
        if DatEntrega <> 0 then
        begin
          FieldByName('D_DAT_ENT').AsDateTime := DatEntrega;
        end;
        FieldByName('C_CON_ORC').Asstring := NomContato;
        FieldByName('C_NOM_SOL').Asstring := NomSolicitante;
        FieldByName('C_DES_EMA').Asstring := DesEmail;
        FieldByName('C_DES_SER').Asstring := DesServico;
        FieldByName('L_OBS_ORC').Asstring := DesObservacao.Text;
        FieldByName('C_OBS_FIS').Asstring := DesObservacaoFiscal;
        FieldByName('I_COD_VEN').AsInteger := CodVendedor;
        if CodPreposto <> 0 then
          FieldByName('I_VEN_PRE').AsInteger := CodPreposto
        else
          FieldByName('I_VEN_PRE').Clear;
        FieldByName('N_VLR_TOT').AsFloat := ValTotal;
        FieldByName('N_VLR_PRO').AsFloat := ValTotalProdutos;
        FieldByName('N_VLR_LIQ').AsFloat := ValTotalLiquido;
        FieldByName('N_PER_COM').AsFloat := PerComissao;
        FieldByName('N_COM_PRE').AsFloat := PerComissaoPreposto;

        FieldByName('C_ORD_COM').Asstring := OrdemCompra;
        FieldByName('C_NUM_CUF').Asstring := NumCupomfiscal;
        FieldByName('I_COD_OPE').AsInteger := CodOperacaoEstoque;
        FieldByName('I_TIP_GRA').AsInteger := TipGrafica;
        FieldByName('N_VAL_TAX').AsFloat := ValTaxaEntrega;
        FieldByName('C_DES_CHA').AsString := DesProblemaChamado;
        FieldByName('C_SER_EXE').AsString := DesServicoExecutado;
        FieldByName('C_END_ATE').AsString := DesEnderecoAtendimento;
        FieldByName('C_NOM_MIC').AsString := NomComputador;
        FieldByName('N_VLR_CHA').AsFloat := ValChamado;
        FieldByName('N_VLR_DSL').AsFloat := ValDeslocamento;

        if NumNotas <> '' then
          FieldByName('C_NRO_NOT').Asstring := NumNotas
        else
          FieldByName('C_NRO_NOT').Clear;

        if IndCancelado then
          FieldByName('C_IND_CAN').AsString := 'S'
        else
          FieldByName('C_IND_CAN').AsString := 'N';

        if IndProcessada then
          FieldByName('C_IND_PRO').AsString := 'S'
        else
          FieldByName('C_IND_PRO').AsString := 'N';

        if FinanceiroGerado then
          FieldByName('C_GER_FIN').AsString := 'S'
        else
          FieldByName('C_GER_FIN').clear;

        if IndNotaGerada then
          FieldByName('C_NOT_GER').AsString := 'S'
        else
          FieldByName('C_NOT_GER').Clear;

        if OPImpressa then
          FieldByName('C_ORP_IMP').AsString := 'S'
        else
          FieldByName('C_ORP_IMP').AsString := 'N';
        CarFlaPendente(VpaDCotacao);
        if IndPendente then
          FieldByName('C_IND_PEN').AsString := 'S'
        else
          FieldByName('C_IND_PEN').AsString := 'N';
        if IndNumeroBaixado then
          FieldByName('C_NUM_BAI').AsString := 'S'
        else
          FieldByName('C_NUM_BAI').AsString := 'N';
        if IndRevenda then
          FieldByName('C_IND_REV').AsString := 'S'
        else
          FieldByName('C_IND_REV').AsString := 'N';

        FieldByName('D_ULT_ALT').AsDateTime := now;

        if CodTransportadora <> 0 then
          FieldByName('I_COD_TRA').AsInteger := CodTransportadora
        else
          FieldByName('I_COD_TRA').Clear;
        FieldByName('C_PLA_VEI').AsString := PlaVeiculo;
        FieldByName('C_EST_VEI').AsString := UFVeiculo;
        FieldByName('N_QTD_TRA').AsFloat := QtdVolumesTransportadora;
        FieldByName('C_ESP_TRA').AsString := EspTransportadora;
        FieldByName('C_MAR_TRA').AsString := MarTransportadora;
        FieldByName('I_NRO_TRA').AsInteger := NumTransportadora;
        FieldByName('N_PES_BRU').AsFloat := PesBruto;
        FieldByName('N_PES_LIQ').AsFloat := PesLiquido;
        FieldByName('N_PER_DES').AsFloat := PerDesconto;
        FieldByName('N_VLR_DES').AsFloat := ValDesconto;
        FieldByName('I_TIP_FRE').AsInteger := TipFrete;
        FieldByName('N_VLR_TTD').AsFloat := ValTotalComDesconto;
        FieldByName('N_VLR_TRO').AsFloat := ValTroca;
        if CodMedico <> 0 then
          FieldByName('I_COD_MED').AsInteger := CodMedico
        else
          FieldByName('I_COD_MED').Clear;
        FieldByName('C_NUM_REC').AsString := NumReceita;
        FieldByName('I_TIP_REC').AsInteger := TipReceita;
        if DatReceita > montadata(1,1,1900) then
          FieldByName('D_DAT_REC').AsDateTime := DatReceita
        else
          FieldByName('D_DAT_REC').Clear;
        if LanOrcamento = 0 then
          LanOrcamento := RProximoLanOrcamento;
        FieldByName('I_LAN_ORC').AsInteger := LanOrcamento;
        post;
        result := AMensagemErroGravacao;
        if not AErronaGravacao then
          LanOrcamento := FieldByName('I_LAN_ORC').AsInteger;
      end;
    end;
  end;
  CotCadastro.Close;
  if result = '' then
  begin
    result := GravaDProdutoCotacao(VpaDCotacao);
    if result = '' then
    begin
      result := GravaDServicoCotacao(VpaDCotacao);
      if result = '' then
      begin
        result := GravaDCompose(VpaDCotacao);
        if result = '' then
        begin
          result := FunClientes.CadastraProdutosCliente(VpaDCotacao);
          if result = '' then
          begin
            result := FunClientes.CadastraReferenciaCliente(VpaDCotacao);
          end;
        end;
      end;
    end;
  end;

  if result = '' then
    if VpaDCliente <> nil then
      AtualizaDCliente(VpaDCotacao,VpaDCliente);
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDProdutoCotacao(VpaDCotacao : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfDProCotacao : TRBDOrcProduto;
begin
  result := '';
  AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = 11 AND I_LAN_ORC = 0');

  for VpfLaco := 0 to VpaDCotacao.Produtos.count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    CotCadastro.insert;
    if VpfDProCotacao.DatOrcamento < MontaData(1,1,1900) then
      VpfDProCotacao.DatOrcamento := VpaDCotacao.DatOrcamento+VpaDCotacao.HorOrcamento;
    CotCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDCotacao.CodEmpFil;
    CotCadastro.FieldByName('I_LAN_ORC').AsInteger := VpaDCotacao.LanOrcamento;
    VpfDProCotacao.SeqMovimento := VpfLaco +1;
    CotCadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfDProCotacao.SeqMovimento;
    CotCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpfDProCotacao.SeqProduto;
    CotCadastro.FieldByName('N_VLR_PRO').AsFloat := VpfDProCotacao.ValUnitario;
    CotCadastro.FieldByName('N_QTD_PRO').AsFloat := VpfDProCotacao.QtdProduto;
    CotCadastro.FieldByName('N_PER_DES').AsFloat := VpfDProCotacao.PerDesconto;
    If VpfDProCotacao.QtdBaixado <> 0 then
      CotCadastro.FieldByName('N_QTD_BAI').AsFloat := VpfDProCotacao.QtdBaixado
    else
      CotCadastro.FieldByName('N_QTD_BAI').Clear;
    if VpfDProCotacao.QtdConferidoSalvo <> 0 then
      CotCadastro.FieldByName('N_QTD_CON').AsFloat := VpfDProCotacao.QtdConferidoSalvo
    else
      CotCadastro.FieldByName('N_QTD_CON').Clear;

    CotCadastro.FieldByName('N_VLR_TOT').AsFloat := VpfDProCotacao.ValTotal;
    CotCadastro.FieldByName('C_COD_UNI').AsString := upperCase(VpfDProCotacao.UM);
    CotCadastro.FieldByName('C_IMP_FOT').AsString := VpfDProCotacao.IndImpFoto;
    CotCadastro.FieldByName('C_OBS_ORC').AsString := VpfDProCotacao.DesObservacao;
    CotCadastro.FieldByName('C_COD_PRO').AsString := VpfDProCotacao.CodProduto;
    CotCadastro.FieldByName('C_ORD_COM').AsString := VpfDProCotacao.DesOrdemCompra;
    CotCadastro.FieldByName('C_IMP_DES').AsString := VpfDProCotacao.IndImpDescricao;
    CotCadastro.FieldByName('D_ULT_ALT').AsDateTime := Date;
    CotCadastro.FieldByName('C_DES_COR').AsString := VpfDProCotacao.DesCor;
    CotCadastro.FieldByName('I_COD_COR').AsInteger := VpfDProCotacao.CodCor;
    CotCadastro.FieldByName('I_COD_EMB').AsInteger := VpfDProCotacao.CodEmbalagem;
    CotCadastro.FieldByName('C_DES_EMB').AsString := VpfDProCotacao.DesEmbalagem;
    CotCadastro.FieldByName('C_PRO_REF').AsString := VpfDProCotacao.DesRefCliente;
    CotCadastro.FieldByName('N_QTD_DEV').AsFloat := VpfDProCotacao.QtdDevolvido;
    CotCadastro.FieldByName('N_SAL_BRI').AsFloat := VpfDProCotacao.QtdSaldoBrinde;
    CotCadastro.FieldByName('D_DAT_ORC').AsDateTime := VpfDProCotacao.DatOrcamento;
    if VpfDProCotacao.CodTamanho <> 0 then
      CotCadastro.FieldByname('I_COD_TAM').AsInteger := VpfDProCotacao.CodTamanho
    else
      CotCadastro.FieldByname('I_COD_TAM').Clear;
    if VpfDProCotacao.IndFaturar then
      CotCadastro.FieldByName('C_IND_FAT').AsString := 'S'
    else
      CotCadastro.FieldByName('C_IND_FAT').AsString := 'N';
    if VpfDProCotacao.IndBrinde then
      CotCadastro.FieldByName('C_IND_BRI').AsString := 'S'
    else
      CotCadastro.FieldByName('C_IND_BRI').AsString := 'N';
    if VpfDProCotacao.DatOpGerada > MontaData(1,1,1900) then
      CotCadastro.FieldByName('D_DAT_GOP').AsDateTime := VpfDProCotacao.DatOpGerada
    else
      CotCadastro.FieldByName('D_DAT_GOP').clear;
    if config.PermiteAlteraNomeProdutonaCotacao then
      CotCadastro.FieldByName('C_NOM_PRO').AsString := VpfDProCotacao.NomProduto;

    CotCadastro.post;
    result := CotCadastro.AMensagemErroGravacao;
//Rotina colocada em comentário dia 23/05/2007 por não estar mais usando o indicador de reserva.
//    if (VpfDProCotacao.IndReservar = 'S') then
//      reservaProduto(IntToStr(VpfDProCotacao.SeqProduto),VpfDProCotacao.UM,VpfDProCotacao.QtdProduto);
    if (config.PrecoPorClienteAutomatico) and not(VpfDProCotacao.IndBrinde) then
      VerificaPrecoCliente(VpaDCotacao.CodCliente,VpfDProCotacao);
    if result <> '' then
    begin
      cotCadastro.Close;
      break;
    end;
  end;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDServicoCotacao(VpaDCotacao : TRBDOrcamento):String;
var
  VpfLaco : Integer;
  VpfDSerCotacao : TRBDOrcServico;
begin
  result := '';
  if VpaDCotacao.Servicos.count > 0  then
  begin

    AdicionaSQLAbreTabela(CotCadastro,'Select * from MOVSERVICOORCAMENTO '+
                                    ' Where I_EMP_FIL = 11 AND I_LAN_ORC = 0 and I_SEQ_MOV = 0');

    for VpfLaco := 0 to VpaDCotacao.Servicos.count - 1 do
    begin
      VpfDSerCotacao := TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]);
      CotCadastro.insert;
      CotCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDCotacao.CodEmpFil;
      CotCadastro.FieldByName('I_LAN_ORC').AsInteger := VpaDCotacao.LanOrcamento;
      CotCadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfLaco+1;
      CotCadastro.FieldByName('I_COD_SER').AsInteger := VpfDSerCotacao.CodServico;
      CotCadastro.FieldByName('C_DES_ADI').AsString := VpfDSerCotacao.DesAdicional;
      CotCadastro.FieldByName('N_VLR_SER').AsFloat := VpfDSerCotacao.ValUnitario;
      CotCadastro.FieldByName('N_QTD_SER').AsFloat := VpfDSerCotacao.QtdServico;
      CotCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
      CotCadastro.FieldByName('N_VLR_TOT').AsFloat := VpfDSerCotacao.ValTotal;
      CotCadastro.FieldByName('D_ULT_ALT').AsDateTime := Date;
      CotCadastro.post;
    end;
    CotCadastro.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaBaixaParcialCotacao(VpaDCotacao : TRBDOrcamento;Var VpaSeqParcial : Integer) : String;
var
  VpfLaco :Integer;
  VpfDItemProduto : TRBDOrcProduto;
  VpfDBaixaCorpo : TRBDOrcamentoParcial;
  VpfDBaixaItem : TRBDProdutoOrcParcial;
  VpfQtdBaixar : Double;
begin
  result := '';
  VpaSeqParcial := 0;
  if ExisteBaixaParcial(VpaDCotacao) then
  begin
    VpfDBaixaCorpo := GravaDBaixaParcialOrcamentoCorpo(VpaDCotacao);
    if VpfDBaixaCorpo = nil then
    begin
      result := 'ERRO NA GRAVAÇÃO DA TABELA ORCAMENTOPARCIALCORPO!!!'#13'Não foi possivel gravar a baixa parcial do produto.';
      exit;
    end;
    VpaSeqParcial := VpfDBaixaCorpo.SeqParcial;
    VpaDCotacao.ValTotalLiquido := VpfDBaixaCorpo.ValTotal;
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      vpfDItemProduto := TRBDOrcProduto(VpaDCotacao.Produtos.items[Vpflaco]);
      if (vpfDItemProduto.QtdABaixar <> 0) or (vpfDItemProduto.QtdConferido <> 0) then
      begin
        VpfDBaixaItem := VpaDCotacao.addProdutoBaixaParcial;
        VpfDBaixaItem.SeqMovOrcamento := VpfDItemProduto.SeqMovimento;
        VpfDBaixaItem.SeqProduto := VpfDItemProduto.SeqProduto;
        VpfDBaixaItem.CodCor := VpfDItemProduto.CodCor;
        VpfDBaixaItem.DesUM := VpfDItemProduto.UM;
        VpfDBaixaItem.QtdParcial := VpfDItemProduto.QtdABaixar;
        VpfDBaixaItem.QtdConferido := VpfDItemProduto.QtdConferido;
        VpfDBaixaItem.ValProduto := VpfDItemProduto.ValUnitario;
        VpfDBaixaItem.ValTotal := VpfDItemProduto.QtdABaixar * VpfDItemProduto.ValUnitario;
        result := GravaDBaixaParcialOrcamentoItem(VpfDBaixaCorpo,VpfDBaixaItem);
        if result <> '' then
          exit;
      end;
    end;
    VpfDBaixaCorpo.free;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDCompose(VpaDCotacao : TRBDOrcamento) : string;
var
  VpfLacoProduto, VpfLacoCompose : Integer;
  VpfDProduto : TRBDOrcProduto;
  VpfDCompose : TRBDOrcCompose;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from ORCAMENTOITEMCOMPOSE '+
                        ' Where CODFILIAL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                        ' and LANORCAMENTO = ' +IntToStr(VpaDCotacao.LanOrcamento));
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ORCAMENTOITEMCOMPOSE'+
                                    ' Where CODFILIAL = 11 AND LANORCAMENTO = 0');
  for VpfLacoProduto := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProduto := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLacoProduto]);
    for VpfLacoCompose := 0 to VpfDProduto.Compose.Count - 1 do
    begin
      VpfDCompose := TRBDOrcCompose(VpfDProduto.Compose.Items[VpfLacoCompose]);
      VpfDCompose.SeqCompose := VpfLacoCompose +1;
      CotCadastro.insert;
      CotCadastro.FieldByname('CODFILIAL').AsInteger := VpaDCotacao.CodEmpFil;
      CotCadastro.FieldByname('LANORCAMENTO').AsInteger := VpaDCotacao.LanOrcamento;
      CotCadastro.FieldByname('SEQMOVIMENTO').AsInteger := VpfDProduto.SeqMovimento;
      CotCadastro.FieldByname('SEQCOMPOSE').AsInteger := VpfDCompose.SeqCompose;
      CotCadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDCompose.SeqProduto;
      CotCadastro.FieldByname('CODCOR').AsInteger := VpfDCompose.CodCor;
      CotCadastro.FieldByname('CORREFERENCIA').AsInteger := VpfDCompose.CorRefencia;
      CotCadastro.post;
      result := CotCadastro.AMensagemErroGravacao;
      if CotCadastro.AErronaGravacao then
        break;
    end;
    if result <> '' then
      break;
  end;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GeraComplementoCotacao(VpaDCotacao : TRBDOrcamento;Var VpaLanOrcamentoRetorno : Integer) : string;
var
  VpfDCotacaoNova : TRBDOrcamento;
  VpfSeparacaoTotal : Boolean;
begin
  result := VerificaSeparacaoTotal(VpaDCotacao,VpfSeparacaoTotal);
  if result = '' then
  begin
    if VpfSeparacaoTotal then
    begin
      result := GravaDCotacao(VpaDCotacao,nil);
      VpaLanOrcamentoRetorno := VpaDCotacao.LanOrcamento;
      if result = ''then
        result := AlteraEstagioCotacao(VpaDCotacao.CodEmpFil,varia.CodigoUsuario,VpaDCotacao.LanOrcamento,varia.EstagioAguardandoEntrega,'');
    end
    else
    begin
      VpfDCotacaoNova := TRBDOrcamento.cria;
      CopiaDCotacao(VpaDCotacao,VpfDCotacaoNova,false);
      VpfDCotacaoNova.CodEstagio := varia.EstagioAguardandoEntrega;
      VpfDCotacaoNova.DesObservacao.Text := VpfDCotacaoNova.DesObservacao.Text+' Entrega Parcial do pedido '+IntToStr(VpaDCotacao.LanOrcamento);

      result := BaixaProdutosASeparar(VpaDCotacao,VpfDCotacaoNova);
      if result = '' then
      begin
        if VpfDCotacaoNova.Produtos.Count > 0 then
        begin
          CalculaValorTotal(VpaDCotacao);
          CalculaValorTotal(VpfDCotacaoNova);
          if VpaDCotacao.Produtos.Count = 0 then
            ExcluiOrcamento(VpaDCotacao.CodEmpFil,VpaDCotacao.LanOrcamento)
          else
            result := GravaDCotacao(VpaDCotacao,nil);

          if result = '' then
            Result := GravaDCotacao(VpfDCotacaoNova,nil);
          VpaLanOrcamentoRetorno := VpfDCotacaoNova.LanOrcamento;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaLogEstagio(VpaCodFilial,VpaLanOrcamento,VpaCodEstagio,VpaCodUsuario : Integer;VpaDesMotivo : String) :string;
Var
  VpfLaco, VpfLacoItem : Integer;
begin
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ESTAGIOORCAMENTO '+
                                    ' Where CODFILIAL = 0 AND SEQORCAMENTO = 0 AND CODESTAGIO = 0 ' );
  CotCadastro.insert;
  CotCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  CotCadastro.FieldByName('SEQORCAMENTO').AsInteger := VpaLanOrcamento;
  CotCadastro.FieldByName('CODESTAGIO').AsInteger := VpaCodEstagio;
  CotCadastro.FieldByName('DATESTAGIO').AsDateTime := now;
  CotCadastro.FieldByName('CODUSUARIO').AsInteger := VpaCodUsuario;
  if VpaDesMotivo <> '' then
    CotCadastro.FieldByName('DESMOTIVO').AsString := VpaDesMotivo;

  AdicionaSQLAbreTabela(Orcamento,'Select * from CADORCAMENTOS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
  for VpfLaco := 0 to Orcamento.FieldCount - 1 do
  begin
    CotCadastro.FieldByname('LOGALTERACAO').AsString := CotCadastro.FieldByname('LOGALTERACAO').AsString+
                                   Orcamento.Fields[VpfLaco].DisplayName+' = "'+ Orcamento.Fields[VpfLaco].AsString+'"'+#13;
  end;
  AdicionaSQLAbreTabela(Orcamento,'Select * from MOVORCAMENTOS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
  while not Orcamento.eof do
  begin
    CotCadastro.FieldByname('LOGALTERACAO').AsString := CotCadastro.FieldByname('LOGALTERACAO').AsString +
                                                        #13'MOVORCAMENTOS '#13;
    for VpfLacoItem := 0 to Orcamento.FieldCount - 1 do
      CotCadastro.FieldByname('LOGALTERACAO').AsString := CotCadastro.FieldByname('LOGALTERACAO').AsString+
                                 Orcamento.Fields[VpfLacoItem].DisplayName+' = "'+ Orcamento.Fields[VpfLacoItem].AsString+'"'+#13;
    Orcamento.next;
  end;

  Orcamento.close;

  CotCadastro.FieldByname('LOGALTERACAO').AsString := copy(CotCadastro.FieldByname('LOGALTERACAO').AsString,1,3500);
  CotCadastro.FieldByName('SEQESTAGIO').AsInteger := RProximoSeqEstagioOrcamento(VpaCodFilial,VpaLanOrcamento);
  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
  CotCadastro.close;
end;

{******************************************************************************}
function TFuncoesCotacao.GravaCartuchoCotacao(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):string;
var
  VpfLaco : Integer;
  VpfDCartucho : TRBDCartuchoCotacao;
begin
  result := '';
  if varia.EstagioNaEntrega = 0 then
    result := 'ESTAGIO COTAÇÃO NA ENTREGA NÃO PREENCHIDO!!!'#13'É necessário preencher nas configurações do sistema o estágio da cotação que está na entrega.';
  if result = '' then
  begin
    for VpfLaco := 0 to  VpaCartuchos.Count - 1 do
    begin
      VpfDCartucho := TRBDCartuchoCotacao(VpaCartuchos.Items[Vpflaco]);
      AdicionaSQLAbreTabela(CotCadastro,'Select * from PESOCARTUCHO '+
                                        ' Where SEQCARTUCHO = '+IntToStr(VpfDCartucho.SeqCartucho));
      CotCadastro.edit;
      CotCadastro.FieldByname('CODFILIAL').AsInteger := VpfDCartucho.CodFilial;
      CotCadastro.FieldByname('LANORCAMENTO').AsInteger := VpfDCartucho.LanOrcamento;
      CotCadastro.post;
      result := CotCadastro.AMensagemErroGravacao;
      if CotCadastro.AErronaGravacao then
        break;
    end;
    CotCadastro.close;
    if result = '' then
    begin
      AlteraEstagioCotacao(VpaDCotacao.CodEmpFil,varia.CodigoUsuario,VpaDCotacao.LanOrcamento,Varia.EstagioNaEntrega,'');
      if Result = '' then
      begin
        Result := BaixaEstoqueCartuchoAssociado(VpaDCotacao,VpaCartuchos);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.GravaVendedorUltimaCotacao(VpaCodVendedor : Integer);
var
  VpfIni : TRegIniFile;
begin
  VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  VpfIni.WriteInteger('COTACAO','ULTIMOVENDEDOR',VpaCodVendedor);
  VpfIni.free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CalculaValorTotal(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfDProdutoOrc : TRBDOrcProduto;
  VpfQtdBaixado : Double;
begin
  VpaDCotacao.ValTotal := 0;
  VpaDCotacao.ValTotalProdutos := 0;
  VpaDCotacao.ValTotalComDesconto := 0;
  VpaDCotacao.QtdProduto := 0;
  VpfQtdBaixado := 0;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProdutoOrc := TRBDOrcProduto(VpaDCotacao.Produtos.items[VpfLaco]);
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal + VpfDProdutoOrc.ValTotal;
    VpaDCotacao.ValTotalProdutos := VpaDCotacao.ValTotalProdutos + VpfDProdutoOrc.ValTotal;
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto + (VpfDProdutoOrc.ValTotal - ((VpfDProdutoOrc.ValTotal * VpfDProdutoOrc.PerDesconto)/100));
    VpaDCotacao.QtdProduto := VpaDCotacao.QtdProduto + VpfDProdutoOrc.QtdProduto;
    VpfQtdBaixado := VpfQtdBaixado + VpfDProdutoOrc.QtdBaixado;
  end;
  if VpfQtdBaixado = 0 then
    VpaDCotacao.IndNotaGerada := false;

  for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
  begin
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal + TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]).ValTotal;
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto + TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]).ValTotal;
  end;
  VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotal;

  if VpaDCotacao.ValTaxaEntrega <> 0 then
  begin
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal + VpaDCotacao.ValTaxaEntrega;
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto + VpaDCotacao.ValTaxaEntrega;
    VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotalLiquido + VpaDCotacao.ValTaxaEntrega;
  end;
  if VpaDCotacao.ValTroca <> 0 then
  begin
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal - VpaDCotacao.ValTroca;
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto - VpaDCotacao.ValTroca;
    VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotalLiquido - VpaDCotacao.ValTroca;
  end;

  if VpaDCotacao.PerDesconto <> 0 then
  begin
    VpaDCotacao.ValTotal := VpaDCotacao.ValTotal - ((VpaDCotacao.ValTotal * VpaDCotacao.PerDesconto)/100);
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto - ((VpaDCotacao.ValTotalComDesconto * VpaDCotacao.PerDesconto)/100);
    VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotalLiquido - ((VpaDCotacao.ValTotalLiquido * VpaDCotacao.PerDesconto)/100);
  end
  else
    if VpaDCotacao.ValDesconto <> 0 then
    begin
      VpaDCotacao.ValTotal := VpaDCotacao.ValTotal - VpaDCotacao.ValDesconto;
      VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotalComDesconto - VpaDCotacao.ValDesconto;
      VpaDCotacao.ValTotalLiquido := VpaDCotacao.ValTotalLiquido - VpaDCotacao.ValDesconto;
    end;

  if VpaDCotacao.CodCondicaoPagamento <> 0 then
  begin
    CriaParcelas.Parcelas(VpaDCotacao.ValTotal,VpaDCotacao.CodCondicaoPagamento,false,date);
    VpaDCotacao.ValTotal := CriaParcelas.valorTotal;
  end;
  if Config.DescontoNosProdutodaCotacao then
    VpaDCotacao.ValTotalComDesconto := VpaDCotacao.ValTotal;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CalculaPesoLiquidoeBruto(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
begin
  VpaDCotacao.PesBruto := 0;
  VpaDCotacao.PesLiquido := 0;
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpaDCotacao.PesBruto := VpaDCotacao.PesBruto + (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).PesBruto * TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto);
    VpaDCotacao.PesLiquido := VpaDCotacao.PesLiquido + (TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).PesLiquido * TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]).QtdProduto);
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraPrecoProdutosPorCliente(VpaDCotacao : TRBDOrcamento);
var
  VpfLaco : Integer;
  VpfDItemCotacao : TRBDOrcProduto;
begin
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItemCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    FunProdutos.CarValVendaeRevendaProduto(VpaDCotacao.CodTabelaPreco,VpfDItemCotacao.SeqProduto,VpfDItemCotacao.CodCor,VpfDItemCotacao.CodTamanho,
                                                      VpaDCotacao.CodCliente,VpfDItemCotacao.ValUnitario,VpfDItemCotacao.ValRevenda);
    VpfDItemCotacao.ValTotal :=  VpfDItemCotacao.ValUnitario * VpfDItemCotacao.QtdProduto;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AlteraEstagioCotacao(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio : Integer;VpaDesMotivo : String):String;
Var
  VpfDCotacao : trbdorcamento;
  VpfCodEstagioAtual : Integer;
begin
  result := '';
  VpfCodEstagioAtual := REstagioAtualCotacao(VpaCodFilial,VpaLanOrcamento);
  if VpaCodEstagio <> VpfCodEstagioAtual then
    result := GeraFinanceiroEstagio(VpaCodFilial,VpaCodUsuario,VpaLanOrcamento,VpaCodEstagio);

  if result = '' then
    result := GravaLogEstagio(VpaCodFilial,VpaLanOrcamento,VpaCodEstagio,VpaCodUsuario,VpaDesMotivo);

  if (result = '') and (VpaCodEstagio <> VpfCodEstagioAtual) then
  begin
    if (VpaCodEstagio = varia.EstagioFinalOrdemProducao) or EstagioFinal(VpaCodEstagio) then
    begin
      VpfDCotacao := TRBDOrcamento.cria;
      VpfDCotacao.CodEmpFil := VpaCodFilial;
      VpfDCotacao.LanOrcamento := VpaLanOrcamento;
      cardorcamento(VpfDCotacao);
      AdicionaFinanceiroArqRemessa(VpfDCotacao);
      BaixaOrcamento(VpfDCotacao);
      VpfDCotacao.free;
    end;
    if (VpaCodEstagio = varia.EstagioOrdemProducao) then
      SetaOrcamentoNaoProcessado(VpaCodFilial,VpaLanOrcamento);
    ExecutaComandoSql(Aux,'UPDATE CADORCAMENTOS  set I_COD_EST = '+ IntToStr(VpaCodEstagio)+
                          ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                          ' AND I_LAN_ORC = '+ IntToStr(VpaLanOrcamento));
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AlteraEstagioCotacoes(VpaCodFilial, VpaCodUsuario, VpaCodEstagio : Integer;VpaCotacoes, VpaDesMotivo : String):String;
Var
  VpfCotacao : Integer;
begin
  While length(VpaCotacoes) > 0 do
  begin
    VpfCotacao := strtoInt(CopiaAteChar(VpaCotacoes,','));
    VpaCotacoes := DeleteAteChar(VpaCotacoes,',');
    result := AlteraEstagioCotacao(VpaCodFilial,VpaCodUsuario,VpfCotacao,VpaCodEstagio,VpaDesMotivo);
    if result <> '' then
      exit;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraVendedor(VpaDCotacao : trbdorcamento);
begin
  ExecutaComandoSql(Aux,'update CADORCAMENTOS '+
                        ' set I_COD_VEN = '+IntToStr(VpaDCotacao.CodVendedor)+
                        ' Where I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                        ' and I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento));
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraPreposto(VpaDCotacao : trbdorcamento);
var
  VpfComando : string;
begin
  if VpaDCotacao.CodPreposto <> 0 then
    VpfComando := ' set I_VEN_PRE = '+IntToStr(VpaDCotacao.CodPreposto)
  else
    VpfComando := ' SET I_VEN_PRE = NULL ';
  ExecutaComandoSql(Aux,'update CADORCAMENTOS '+
                         VpfComando +
                        ' Where I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                        ' and I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento));
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraTipoCotacao(VpaDCotacao : TRBDOrcamento;VpaCodTipoCotacao : Integer);
begin
  ExecutaComandoSql(Aux,'update CADORCAMENTOS '+
                        ' set I_TIP_ORC = '+IntToStr(VpaCodTipoCotacao)+
                        ' Where I_EMP_FIL = '+IntToStr(VpaDCotacao.CodEmpFil)+
                        ' and I_LAN_ORC = '+IntToStr(VpaDCotacao.LanOrcamento));
end;

{******************************************************************************}
procedure TFuncoesCotacao.AlteraTransportadora(VpaDCotacao : TRBDOrcamento;VpaCodTransportadora : Integer);
begin
  if (VpaCodTransportadora <> VpaDCotacao.CodTransportadora) and
     (VpaCodTransportadora <> 0) then
  begin
    ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                          ' SET I_COD_TRA = ' +IntToStr(VpaCodTransportadora)+
                          ' Where I_EMP_FIL = ' +IntToStr(VpaDCotacao.CodEmpFil)+
                          ' and I_LAN_ORC = ' +IntToStr(VpaDCotacao.LanOrcamento));
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AlteraCotacaoParaPedido(VpaDCotacao : TRBDOrcamento):string;
var
  VpfDTipoCotacao : TRBDTipoCotacao;
begin
  result := '';
  if Varia.TipoCotacaoPedido = 0 then
    result := 'TIPO COTAÇÃO PEDIDO NÃO PREENCHIDO!!!'#13'É necessário configurar o tipo da cotação pedido nas configurações dos produtos.';
  if result = '' then
  begin
    VpfDTipoCotacao := TRBDTipoCotacao.cria;

    VpaDCotacao.CodTipoOrcamento := varia.TipoCotacaoPedido;
    CarDtipoCotacao(VpfDTipoCotacao,varia.TipoCotacaoPedido);
    VpaDCotacao.CodOperacaoEstoque := VpfDTipoCotacao.CodOperacaoEstoque;
    VpaDCotacao.CodPlanoContas := VpfDTipoCotacao.CodPlanoContas;
    VpaDCotacao.DatOrcamento := date;
    VpaDCotacao.DatPrevista := date;
    result := GravaDCotacao(VpaDCotacao,nil);

    VpfDTipoCotacao.free;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaAlteracaoCotacao(VpaDCotacaoInicial, VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : String;
var
  VpfValoraDevolver : Double;
  VpfDContasAReceber : TRBDContasCR;
begin

  VpfValoraDevolver := 0;
  if (VpaDCotacaoInicial.CodOperacaoEstoque <> 0) and (VpaDCotacao.CodOperacaoEstoque <> 0) then
    result := BaixaProdutosDevolvidos(VpaDCotacaoInicial, VpaDCotacao,VpfValoraDevolver) //baixas as devoluções e trocas
  else
    result := BaixaProdutosOrcamentoQueVirouVenda(VpaDCotacaoInicial, VpaDCotacao);    //baixa os produtos da cotacao que foi alterada de orcamento para venda ou vice versa
  if result = '' then
  begin
    if config.GerarFinanceiroCotacao then
    begin
      if (VpaDCotacao.ValTotal <> VpaDCotacaoInicial.ValTotal) or
         (VpaDCotacao.CodTipoOrcamento <> VpaDCotacaoInicial.CodTipoOrcamento) or
         (VpaDCotacao.CodCondicaoPagamento <> VpaDCotacaoInicial.CodCondicaoPagamento) or
         (VpaDCotacao.CodVendedor <> VpaDCotacaoInicial.CodVendedor) or
         (VpaDCotacao.CodCliente <> VpaDCotacaoInicial.CodCliente) or
         (config.RegerarFinanceiroQuandoCotacaoAlterada) or
         (VpaDCotacao.CodOperacaoEstoque <> VpaDCotacaoInicial.CodOperacaoEstoque) then
      begin
        result := ExcluiFinanceiroOrcamento(VpaDCotacaoInicial.CodEmpFil,VpaDCotacaoInicial.LanOrcamento);
        if (result = '') then
        begin
          if VpaDCotacao.CodPlanoContas <> '' then  //só gera financeiro se a cotação gerou estoque, senão é apenas um orcamento
          begin
            VpfDContasAReceber := TRBDContasCR.cria;
            if GeraFinanceiro(VpaDCotacao,VpaDCliente, VpfDContasAReceber,FunContasAReceber,result,true) then
            begin
              if Result = '' then
                SetaFinanceiroGerado(VpaDCotacao);
            end
            else
              result := 'FINANCEIRO NÃO GERADO!!!'#13'O contas a receber não foi gerado por cancelamento do usuário.';
            VpfDContasAReceber.free;
          end;
        end
        else
        begin
          if VpfValoraDevolver > 0 then
          begin
            if confirmacao('COTAÇÃO JÁ FOI PAGA!!!'#13'Esta cotação já foi paga, deseja devolver o dinheiro"'+FormatFloat('R$ #,###,###,##0.00',VpfValoraDevolver)+'"?') then
            begin
              result := '';
              GeraContasaPagarDevolucaoCotacao(VpaDCotacaoInicial,VpfValoraDevolver);
            end;
          end;
{ 15/11/2006
  Foi colocado em comentario pois o Anisio solicitou que se a parcela esteja paga nao permitir alterar a cotacao, antes
  é necessario extornar o contas a receber
        else
          if VpfValoraDevolver < 0 then
          begin
            if (VpaDCotacao.CodOperacaoEstoque <>  0)then //só gera financeiro se a cotação gerou estoque, senão é apenas um orcamento
              result := GeraContasAReceberDevolucaoCotacao(VpaDCotacaoInicial,VpfValoraDevolver * -1);
          end;}
        end;
      end; 
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.BaixaNumero(VpaCodFilial,VpaLanOrcamento : Integer):Boolean;
begin
  result := false;
  AdicionaSQLAbreTabela(Aux,'Select C_NUM_BAI from CADORCAMENTOS '+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  if aux.FieldByName('C_NUM_BAI').AsString = 'S' then
    aviso('NUMERO JÁ SE ENCONTRA BAIXADO!!!'#13'Não foi possivel baixar o número pois o mesmo já foi baixado.')
  else
  begin
    result := true;
    ExecutaComandoSql(Aux,'Update CADORCAMENTOS '+
                        ' set C_NUM_BAI = ''S'''+
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                        ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento));
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesCotacao.RValTotalOrcamentoNoMovEstoque(VpaCodFilial,VpaLanOrcamento : Integer) : Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select SUM(N_VLR_MOV) TOTAL from MOVESTOQUEPRODUTOS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' AND I_LAN_ORC = '+ IntToStr(VpaLanOrcamento),true);
  result := Aux.FieldByName('TOTAL').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ZeraQtdBaixada(VpaDOrcamento : trbdorcamento);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDOrcamento.Produtos.count - 1 do
  begin
    TRBDOrcProduto(vpadOrcamento.Produtos.Items[VpfLaco]).QtdBaixado := 0;
    TRBDOrcProduto(vpadOrcamento.Produtos.Items[VpfLaco]).QtdDevolvido := 0;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.FaturarTodosProdutos(VpaDCotacao : TRBDOrcamento):Boolean;
var
  VpfLaco : Integer;
begin
  result := true;
  if config.EstoqueFiscal then
  begin
    for VpfLaco := 0 to VpaDCotacao.Produtos.count - 1 do
    begin
      if TRBDOrcProduto(vpadCotacao.Produtos.Items[VpfLaco]).IndFaturar then
      begin
        result := false;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ImprimirBoletos(VpaCodFilial, VpaLanOrcamento : Integer;VpaDCliente : TRBDCliente;VpaImpressora : String);
var
  VpfFunImpressao : TImpressaoBoleto;
begin
  VpfFunImpressao := TImpressaoBoleto.cria(CotCadastro.ASQlConnection);
  AdicionaSQLAbreTabela(Orcamento,'Select MOV.I_EMP_FIL, MOV.I_COD_FRM, MOV.I_LAN_REC, MOV.I_NRO_PAR, CON.C_EMI_BOL '+
                                  ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV, CADCONTAS CON '+
                                  ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                  ' AND MOV.C_NRO_CON = CON.C_NRO_CON '+
                                  ' AND CAD.I_EMP_FIL = '+IntToStr(VpaCodfilial)+
                                  ' and CAD.I_LAN_ORC = '+IntToStr(VpaLanOrcamento));

  while not(Orcamento.Eof) and (Orcamento.FieldByName('C_EMI_BOL').AsString = 'T') and
        (Orcamento.FieldByName('I_COD_FRM').AsInteger = varia.FormaPagamentoBoleto) do
  begin
    VpfFunImpressao.ImprimeBoleto(VpaCodFilial,Orcamento.FieldByName('I_LAN_REC').AsInteger,Orcamento.FieldByName('I_NRO_PAR').AsInteger,
                                  VpaDCliente,false,VpaImpressora,False);
    Orcamento.Next;
  end;
  VpfFunImpressao.free;
  orcamento.close;
end;

{******************************************************************************}
function TFuncoesCotacao.ExisteOpGerada(VpaCodFilial, VpaLanOrcamento : Integer;VpaAvisar : Boolean):Boolean;
begin
  result := false;
  if not config.AlterarCotacaoComOPGerada then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from ORDEMPRODUCAOCORPO '+
                              ' Where EMPFIL = '+IntToStr(VpaCodFilial)+
                              ' and LANORC = '+IntToStr(VpaLanOrcamento));
    result := not Aux.Eof;
    if result and VpaAvisar then
      aviso('ORDEM DE PRODUÇÃO GERADA!!!'#13'Não é possível completar a operação porque esta cotação possui ordens de produção geradas.');
    aux.close;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EnviaEmailCotacaoTransportadora(VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : string;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
begin
  result := '';
  VpfEmailTexto := TIdText.Create(VprMensagem.MessageParts);
  VpfEmailTexto.ContentType := 'text/plain';
  MontaEmailCotacaoTexto(VpfEmailTexto.Body,VpaDCotacao,VpaDCliente);

  VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
  VpfEmailHTML.ContentType := 'text/html';
  MontaEmailCotacaoTexto(VpfEmailHTML.Body,VpaDCotacao,VpaDCliente);
  VpfEmailHTML.Body.Insert(0,'<html> <pre>');
  VpfEmailHTML.Body.Insert(VpfEmailHTML.Body.Count -1,'</pre></html>');

  VprMensagem.Recipients.EMailAddresses := REmailTransportadora(VpaDCotacao.CodTransportadora) ;
  VprMensagem.Subject := 'Cotação ' +IntToStr(VpaDCotacao.LanOrcamento);
  result := EnviaEmail(VprMensagem,VprSMTP);
  if result = '' then
    Result:= GravaDEmail(VpaDCotacao,REmailTransportadora(VpaDCotacao.CodTransportadora));
end;

{******************************************************************************}
function TFuncoesCotacao.GravaDEmail(VpaDCotacao: TRBDOrcamento;VpaDesEmail : String): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(CotCadastro,'SELECT * FROM ORCAMENTOEMAIL');
  CotCadastro.Insert;

  CotCadastro.FieldByName('CODFILIAL').AsInteger:= VpaDCotacao.CodEmpFil;
  CotCadastro.FieldByName('LANORCAMENTO').AsInteger:= VpaDCotacao.LanOrcamento;
  CotCadastro.FieldByName('SEQEMAIL').AsInteger:= RSeqEmailDisponivel(VpaDCotacao.CodEmpFil,VpaDCotacao.LanOrcamento);
  CotCadastro.FieldByName('DATEMAIL').AsDateTime:= Now;
  CotCadastro.FieldByName('DESEMAIL').AsString:= VpaDesEmail;
  CotCadastro.FieldByName('CODUSUARIO').AsInteger:= Varia.CodigoUsuario;

  CotCadastro.post;
  result := CotCadastro.AMensagemErroGravacao;
end;

{******************************************************************************}
function TFuncoesCotacao.RSeqEmailDisponivel(VpaCodFilial, VpaLanOrcamento : Integer ): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQEMAIL) PROXIMO '+
                            ' FROM ORCAMENTOEMAIL'+
                            ' Where CODFILIAL = ' + IntToStr(VpaCodFilial)+
                            ' and LANORCAMENTO = ' +IntToStr(VpaLanOrcamento));
  Result:= Aux.FieldByName('PROXIMO').AsInteger + 1;
end;

{******************************************************************************}
function TFuncoesCotacao.RValComissao(VpaDCotacao : TRBDOrcamento;VpaTipComissao : Integer;VpaPerComissao, VpaPerComissaoPreposto : Double):Double;
var
  VpfLaco : Integer;
  VpfDProdutoCotacao : TRBDOrcProduto;
  VpfDServicoCotacao : TRBDOrcServico;
  VpfCodClassificacao : String;
  VpfPerComissaoVendedor : Double;
begin
  if VpaTipComissao = 0 then //comissao direta;
    result := (VpaDCotacao.ValTotalLiquido * (VpaPerComissao - VpaPerComissaoPreposto))/100
  else
  begin
    VpfCodClassificacao := '';
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProdutoCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
      if VpfDProdutoCotacao.PerComissao <> 0 then
        Result := result + ((VpfDProdutoCotacao.ValTotal * (VpfDProdutoCotacao.PerComissao - VpaPerComissaoPreposto))/100)
      else
      begin
        if VpfCodClassificacao <> VpfDProdutoCotacao.CodClassificacao then
        begin
          VpfCodClassificacao := VpfDProdutoCotacao.CodClassificacao;
          VpfPerComissaoVendedor := FunVendedor.RPerComissaoVendedorClassificacao(varia.CodigoEmpresa,VpaDCotacao.CodVendedor,VpfDProdutoCotacao.CodClassificacao,'P');
        end;
        if VpfPerComissaoVendedor <> 0 then
          Result := result + ((VpfDProdutoCotacao.ValTotal * (VpfPerComissaoVendedor - VpaPerComissaoPreposto))/100)
        else
          Result := result + ((VpfDProdutoCotacao.ValTotal * (VpfDProdutoCotacao.PerComissaoClassificacao - VpaPerComissaoPreposto))/100);
      end;
    end;
    VpfCodClassificacao := '';
    for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
    begin
      VpfDServicoCotacao := TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]);
      if VpfCodClassificacao <> VpfDServicoCotacao.CodClassificacao then
      begin
        VpfCodClassificacao := VpfDServicoCotacao.CodClassificacao;
        VpfPerComissaoVendedor := FunVendedor.RPerComissaoVendedorClassificacao(varia.CodigoEmpresa,VpaDCotacao.CodVendedor,VpfDServicoCotacao.CodClassificacao,'S');
      end;
      if VpfPerComissaoVendedor <> 0 then
        Result := result + ((VpfDServicoCotacao.ValTotal * (VpfPerComissaoVendedor - VpaPerComissaoPreposto))/100)
      else
        Result := result + ((VpfDServicoCotacao.ValTotal * (VpfDServicoCotacao.PerComissaoClassificacao - VpaPerComissaoPreposto))/100);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.RProdutoPendente(VpaProdutos : TList;VpaSeqProduto : Integer) : TRBDProdutoPendenteMetalVidros;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaProdutos.Count - 1 do
  begin
    if TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLaco]).SeqProduto = VpaSeqProduto then
    begin
      result := TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLaco]);
      break;
    end;
  end;
  if result = nil then
  begin
    Result := TRBDProdutoPendenteMetalVidros.cria;
    result.SeqProduto := VpaSeqProduto;
    result.QtdProduto := 0;
    Result.DatPrimeiraEntrega := MontaData(1,1,2500);
    VpaProdutos.add(result);
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CarDProdutoPendenteMetalVidros(VpaProdutos : TList;VpaDatInicio, VpaDatFim : TDateTime);
Var
  VpfDProdutoPendente : TRBDProdutoPendenteMetalVidros;
  VpfDPedidoPendente : TRBDOrcamentoProdutoPendenteMetalVidros;
begin
  Orcamento.close;
  Orcamento.sql.clear;
  AdicionaSQLTabela(Orcamento,'Select PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI UNIORIGINAL, '+
                                  ' CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.D_DAT_PRE, '+
                                  ' mov.n_qtd_pro, mov.n_qtd_bai, mov.c_cod_uni '+
                             ' from cadorcamentos cad, movorcamentos mov, cadclientes cli, cadprodutos pro '+
                             ' where cad.i_emp_fil = mov.i_emp_fil '+
                             ' and cad.i_lan_orc = mov.i_lan_orc '+
                             ' and cad.i_cod_cli = cli.i_cod_cli '+
                             ' and mov.i_seq_pro = pro.i_seq_pro '+
                             ' and cad.c_fla_sit = ''A'''+
                             ' and (MOV.N_QTD_PRO - '+SqlTextoIsNull('MOV.N_QTD_BAI','0')+') > 0 '+
                             ' and CAD.I_TIP_ORC = '+ IntToStr(Varia.TipoCotacaoPedido)+
                             ' and CAD.C_IND_CAN = ''N''');
  if config.ImprimirPedidoPendentesPorPeriodo then
    AdicionaSQLTabela(Orcamento,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_PRE',VpaDatInicio,VpaDatFim,true));
  Orcamento.open;
  while not Orcamento.eof do
  begin
    VpfDProdutoPendente := RProdutoPendente(VpaProdutos,Orcamento.FieldByname('I_SEQ_PRO').AsInteger);
    VpfDProdutoPendente.CodProduto := Orcamento.FieldByname('C_COD_PRO').AsString;
    VpfDProdutoPendente.NomProduto := Orcamento.FieldByname('C_NOM_PRO').AsString;
    VpfDProdutoPendente.DesUM := Orcamento.FieldByname('UNIORIGINAL').AsString;
    VpfDProdutoPendente.QtdProduto := VpfDProdutoPendente.QtdProduto + FunProdutos.CalculaQdadePadrao(Orcamento.FieldByname('C_COD_UNI').AsString,VpfDProdutoPendente.DesUM,
                                       Orcamento.FieldByname('N_QTD_PRO').AsFloat - Orcamento.FieldByname('N_QTD_BAI').AsFloat,Orcamento.FieldByname('I_SEQ_PRO').AsString);
    if Orcamento.FieldByname('D_DAT_PRE').AsDateTime < VpfDProdutoPendente.DatPrimeiraEntrega then
      VpfDProdutoPendente.DatPrimeiraEntrega := Orcamento.FieldByname('D_DAT_PRE').AsDateTime;
    VpfDPedidoPendente := VpfDProdutoPendente.AddOrcamentoProdutoPendente(Orcamento.FieldByname('D_DAT_PRE').AsDateTime);
    VpfDPedidoPendente.CodFilial := Orcamento.FieldByname('I_EMP_FIL').AsInteger;
    VpfDPedidoPendente.LanOrcamento := Orcamento.FieldByname('I_LAN_ORC').AsInteger;
    Orcamento.next;
  end;
  Orcamento.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.OrdenaProdutosPendentes(VpaProdutos : TList);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDProPendenteExterno, VpfDProPendenteInterno, VpfProPendenteAux : TRBDProdutoPendenteMetalVidros;
begin
  for VpfLacoExterno := 0 to VpaProdutos.Count - 2 do
  begin
    VpfDProPendenteExterno := TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaProdutos.Count - 1 do
    begin
      VpfDProPendenteInterno := TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLacoInterno]);
      if VpfDProPendenteInterno.DatPrimeiraEntrega <  VpfDProPendenteExterno.DatPrimeiraEntrega then
      begin
        VpaProdutos.Items[VpfLacoExterno] := VpaProdutos.Items[VpfLacoInterno];
        VpaProdutos.Items[VpfLacoInterno] := VpfDProPendenteExterno;
        VpfDProPendenteExterno := TRBDProdutoPendenteMetalVidros(VpaProdutos.Items[VpfLacoExterno]);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.SalvaArquivoProdutoPendente(VpaProduto : TList);
var
  VpfLacoProduto, VpfLacoPedido : Integer;
  VpfArquivo : TStringLIst;
  VpfDProdutoPendente : TRBDProdutoPendenteMetalVidros;
  VpfDPedidoPendente : TRBDOrcamentoProdutoPendenteMetalVidros;
  VpfLinha : String;
begin
  VpfArquivo := TStringList.Create;
  for VpfLacoProduto := 0 to VpaProduto.Count - 1 do
  begin
    VpfDProdutoPendente := TRBDProdutoPendenteMetalVidros(VpaProduto.Items[VpfLacoProduto]);
    VpfLinha :=  AdicionaCharD(' ',VpfDProdutoPendente.CodProduto,12)+' '+AdicionaCharE(' ',FormatFloat('##,###,##0.00',VpfDProdutoPendente.QtdProduto),20)+
                                    ' '+FormatDateTime('DD/MM/YYYY',VpfDProdutoPendente.DatPrimeiraEntrega)+ ' *** ';
    for VpfLacoPedido := 0 to VpfDProdutoPendente.Orcamentos.Count - 1 do
    begin
      VpfDPedidoPendente := TRBDOrcamentoProdutoPendenteMetalVidros(VpfDProdutoPendente.Orcamentos.Items[VpfLacoPedido]);
      VpfLinha := VpfLinha + IntToStr(VpfDPedidoPendente.LanOrcamento)+'; ';
    end;
    VpfArquivo.Add(VpfLinha);
  end;
  VpfARquivo.SaveToFile('ProdutosPendentes.txt');
  WinExec(PAnsiChar('NOTEPAD.EXE ProdutosPendentes.txt'), SW_ShowNormal);
  VpfArquivo.Free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.SubtraiQtdAlteradaCotacaoInicial(VpaDSaldoCotacao, VpaDCotacaoAlterada : TRBDOrcamento);
var
  VpfLacoCotacaoAlterada, VpfLacoSaldo : Integer;
  VpfDProAlterado, VpfDProSaldo : TRBDOrcProduto;
begin
  for VpfLacoCotacaoAlterada := 0 to VpaDCotacaoAlterada.Produtos.Count - 1 do
  begin
    VpfDProAlterado := TRBDOrcProduto(VpaDCotacaoAlterada.Produtos.Items[VpfLacoCotacaoAlterada]);
    VpfDProSaldo := RProdutoCotacao(VpaDSaldoCotacao,VpfDProAlterado.SeqProduto,VpfDProAlterado.CodCor,VpfDProAlterado.CodTamanho, VpfDProAlterado.ValUnitario);
    if VpfDProSaldo = nil then
    begin
      VpfDProSaldo := VpaDSaldoCotacao.AddProduto;
      CopiaDProdutoCotacao(VpfDProAlterado,VpfDProSaldo);
      VpfDProSaldo.QtdProduto := 0;
    end;
    VpfDProSaldo.QtdProduto := VpfDProSaldo.QtdProduto - FunProdutos.CalculaQdadePadrao(VpfDProAlterado.UM ,VpfDProSaldo.UM,VpfDProAlterado.QtdProduto,InttoStr(VpfDProAlterado.SeqProduto));
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.EnviaEmailCliente(VpaDCotacao : TRBDOrcamento;VpaDCliente : TRBDCliente) : string;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
  VpfEmailVendedor,VpfEmailCliente : String;
  VpfChar : Char;
begin
  result := '';
  if VpaDCotacao.DesEmail = '' then
    if VpaDCliente.DesEmail = '' then
      result := 'E-MAIL DO CLIENTE NÃO PREENCHIDO!!!'#13'Falta preencher o e-mail do cliente.'
    else
      VpaDCotacao.DesEmail := VpaDCliente.DesEmail;
  if result = '' then
  begin
{    VpfEmailTexto := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailTexto.ContentType := 'text/plain';
    MontaEmailCotacaoTexto(VpfEmailTexto.Body,VpaDCotacao,VpaDCliente);}

    VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';
    MontaEmailCotacao(VpfEmailHTML.Body,VpaDCotacao,VpaDCliente,true);

    VpfEmailCliente := VpaDCotacao.DesEmail;
    VpfChar := ',';
    if ExisteLetraString(';',VpfEmailCliente) then
      VpfChar := ';';
    while Length(VpfEmailCliente) > 0 do
    begin
      VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailCliente,VpfChar),VpfChar);
      VpfEmailCliente := DeleteAteChar(VpfEmailCliente,VpfChar);
    end;

    VprMensagem.Subject := Varia.NomeFilial+' - Cotação ' +IntToStr(VpaDCotacao.LanOrcamento);
    VpfEmailVendedor := REmailVencedor(VpaDCotacao.CodVendedor);
    if VpfEmailVendedor <> '' then
      VprMensagem.ReplyTo.EMailAddresses := VpfEmailVendedor;

    result := EnviaEmail(VprMensagem,VprSMTP);
    if result = '' then
      Result:= GravaDEmail(VpaDCotacao,VpaDCliente.DesEmail);
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.AgrupaCotacoes(VpaCotacoes : TList;VpaIndCopia : Boolean) : TRBDOrcamento;
var
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacaoDe, VpfDProCotacaoPara : TRBDOrcProduto;
  vpfdSerCotacaoDe, VpfDSerCotacaoPara : TRBDOrcServico;
  VpfLaco, VpfLacoProduto, VpfLacoUM, VpfLacoServico  : Integer;
  VpfNumCotacoes : String;
begin
  VpfNumCotacoes := '';
  if VpaIndCopia then
  begin
    result := TRBDOrcamento.cria;
    Cardorcamento(result,TRBDOrcamento(VpaCotacoes.Items[0]).CodEmpFil,TRBDOrcamento(VpaCotacoes.Items[0]).LanOrcamento);
  end
  else
  begin
    result := TRBDOrcamento(VpaCotacoes.Items[0]);
  end;
  if VpaCotacoes.Count > 0 then
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[0]);
    if Result.PerDesconto <> 0 then
      AdicionaDescontoCotacaoDePara(result,result); //converto o percentual de desconto em valor de desconto.
    result.PerDesconto := 0;

    for VpfLaco := 1 to VpaCotacoes.Count - 1 do
    begin
      VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
      VpfNumCotacoes := VpfNumCotacoes+IntToStr(VpfDCotacao.LanOrcamento)+',';
      if VpfDCotacao.DesObservacaoFiscal <> '' then
        result.DesObservacaoFiscal := Result.DesObservacaoFiscal + #13+VpfDCotacao.DesObservacaoFiscal;
      if VpfDCotacao.DesObservacao.Text <> '' then
        result.DesObservacao.Text := Result.DesObservacao.Text +#13+ VpfDCotacao.DesObservacao.Text;
      AdicionaDescontoCotacaoDePara(VpfDCotacao,result);
      for VpfLacoProduto := 0 to VpfDCotacao.Produtos.count - 1 do
      begin
        VpfDProCotacaoDe := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProduto]);
        VpfDProCotacaoPara := result.AddProduto;
        VpfDProCotacaoPara.LanOrcamentoOrigem := VpfDCotacao.LanOrcamento;
        VpfDProCotacaoPara.SeqProduto := VpfDProCotacaoDe.SeqProduto;
        VpfDProCotacaoPara.CodCor := VpfDProCotacaoDe.CodCor;
        VpfDProCotacaoPara.CodEmbalagem := VpfDProCotacaoDe.CodEmbalagem;
        VpfDProCotacaoPara.CodPrincipioAtivo := VpfDProCotacaoDe.CodPrincipioAtivo;
        VpfDProCotacaoPara.CodProduto := VpfDProCotacaoDe.CodProduto;
        VpfDProCotacaoPara.NomProduto := VpfDProCotacaoDe.NomProduto;
        VpfDProCotacaoPara.DesCor := VpfDProCotacaoDe.DesCor;
        VpfDProCotacaoPara.DesEmbalagem := VpfDProCotacaoDe.DesEmbalagem;
        VpfDProCotacaoPara.DesObservacao := VpfDProCotacaoDe.DesObservacao;
        VpfDProCotacaoPara.DesRefCliente := IntToStr(VpfDCotacao.LanOrcamento);
        VpfDProCotacaoPara.DesOrdemCompra := IntTostr(VpfDCotacao.LanOrcamento);
        VpfDProCotacaoPara.UM := VpfDProCotacaoDe.UM;
        VpfDProCotacaoPara.UMAnterior := VpfDProCotacaoDe.UMAnterior;
        VpfDProCotacaoPara.UMOriginal := VpfDProCotacaoDe.UMOriginal;
        VpfDProCotacaoPara.IndImpFoto := VpfDProCotacaoDe.IndImpFoto;
        VpfDProCotacaoPara.IndImpDescricao := VpfDProCotacaoDe.IndImpDescricao;
        VpfDProCotacaoPara.IndFaturar := VpfDProCotacaoDe.IndFaturar;
        VpfDProCotacaoPara.IndRetornavel := VpfDProCotacaoDe.IndRetornavel;
        VpfDProCotacaoPara.IndBrinde := VpfDProCotacaoDe.IndBrinde;
        VpfDProCotacaoPara.IndCracha := VpfDProCotacaoDe.IndCracha;
        VpfDProCotacaoPara.PerDesconto := VpfDProCotacaoDe.PerDesconto;
        VpfDProCotacaoPara.PesLiquido := VpfDProCotacaoDe.PesLiquido;
        VpfDProCotacaoPara.PesBruto := VpfDProCotacaoDe.PesBruto;
        VpfDProCotacaoPara.QtdEstoque := VpfDProCotacaoDe.QtdEstoque;
        VpfDProCotacaoPara.QtdBaixado := VpfDProCotacaoDe.QtdBaixado;
        VpfDProCotacaoPara.QtdConferido := VpfDProCotacaoDe.QtdConferido;
        VpfDProCotacaoPara.QtdConferidoSalvo := VpfDProCotacaoDe.QtdConferidoSalvo;
        VpfDProCotacaoPara.QtdMinima := VpfDProCotacaoDe.QtdMinima;
        VpfDProCotacaoPara.QtdPedido := VpfDProCotacaoDe.QtdPedido;
        VpfDProCotacaoPara.QtdProduto := VpfDProCotacaoDe.QtdProduto;
        VpfDProCotacaoPara.QtdFiscal := VpfDProCotacaoDe.QtdFiscal;
        VpfDProCotacaoPara.QtdDevolvido := VpfDProCotacaoDe.QtdDevolvido;
        VpfDProCotacaoPara.QtdSaldoBrinde := VpfDProCotacaoDe.QtdSaldoBrinde;
        VpfDProCotacaoPara.ValUnitario := VpfDProCotacaoDe.ValUnitario;
        VpfDProCotacaoPara.ValUnitarioOriginal := VpfDProCotacaoDe.ValUnitarioOriginal;
        VpfDProCotacaoPara.ValTotal := VpfDProCotacaoDe.ValTotal;
        VpfDProCotacaoPara.RedICMS := VpfDProCotacaoDe.RedICMS;
        for VpfLacoUM := 0 to VpfDProCotacaoDe.UnidadeParentes.Count - 1 do
          VpfDProCotacaoPara.UnidadeParentes.add(VpfDProCotacaoDe.UnidadeParentes.Strings[VpfLacoUM]);
      end;
      for VpfLacoServico := 0 to VpfDCotacao.Servicos.count - 1 do
      begin
        vpfdSerCotacaoDe := TRBDOrcServico(VpfDCotacao.servicos.Items[VpfLacoServico]);
        VpfDSerCotacaoPara := result.AddServico;
        VpfDSerCotacaoPara.CodServico := vpfdSerCotacaoDe.CodServico;
        VpfDSerCotacaoPara.NomServico := vpfdSerCotacaoDe.NomServico;
        VpfDSerCotacaoPara.DesAdicional := vpfdSerCotacaoDe.DesAdicional;
        VpfDSerCotacaoPara.QtdServico := vpfdSerCotacaoDe.QtdServico;
        VpfDSerCotacaoPara.ValUnitario := vpfdSerCotacaoDe.ValUnitario;
        VpfDSerCotacaoPara.ValTotal := vpfdSerCotacaoDe.ValTotal;
        VpfDSerCotacaoPara.PerISSQN := vpfdSerCotacaoDe.PerISSQN;
      end;
    end;
    result.DesObservacao.Text := 'Agrupado cotações : '+ copy(VpfNumCotacoes,1,length(VpfNumCotacoes)-1)+#13+ result.DesObservacao.Text;
  end;
end;


{******************************************************************************}
procedure TFuncoesCotacao.ExcluiCotacoesAgrupadas(VpaCotacoes : TList);
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  if VpaCotacoes.Count > 0 then
  begin
    for VpfLaco := 1 to VpaCotacoes.Count - 1 do
    begin
      VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
      ExcluiOrcamento(VpfDCotacao.CodEmpFil, VpfDCotacao.LanOrcamento,false);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.TodosCartuchosAssociados(VpaDCotacao : TRBDOrcamento;VpaCartuchos : TList):boolean;
var
  VpfLacoCartuchos,VpfLacoCotacao : Integer;
  VpfDCartucho : TRBDCartuchoCotacao;
  VpfDProCotacao : TRBDOrcProduto;
  VpfProdutoAMenos,VpfProdutoAMais, VpfResultado : String;
begin
  for VpfLacoCotacao := 0 to  VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLacoCotacao]);
    VpfDProCotacao.QtdABaixar := 0;
  end;

  for VpfLacoCartuchos := 0 to VpaCartuchos.Count - 1 do
  begin
    VpfDCartucho := TRBDCartuchoCotacao(VpaCartuchos.Items[VpfLacoCartuchos]);
    for VpfLacoCotacao := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLacoCotacao]);
      if VpfDCartucho.SeqProdutoTrocado <> 0 then
      begin
        if (VpfDProCotacao.SeqProduto = VpfDCartucho.SeqProdutoTrocado) then
          VpfDProCotacao.QtdABaixar := VpfDProCotacao.QtdABaixar + 1;
      end
      else
        if (VpfDProCotacao.SeqProduto = VpfDCartucho.SeqProduto) then
          VpfDProCotacao.QtdABaixar := VpfDProCotacao.QtdABaixar + 1;
    end;
  end;
  VpfProdutoAMenos := '';
  VpfProdutoAMais := '';
  for VpfLacoCotacao := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLacoCotacao]);
    if (VpfDProCotacao.QtdABaixar < VpfDProCotacao.QtdProduto) then
      VpfProdutoAMenos := VpfProdutoAMenos + #13'"'+VpfDProCotacao.CodProduto+'-'+VpfDProCotacao.NomProduto+'" ('+FormatFloat('0',VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdABaixar)+') ' +VpfDProCotacao.UM
    else
      if (VpfDProCotacao.QtdABaixar > VpfDProCotacao.QtdProduto) then
      VpfProdutoAMais := VpfProdutoAMais + #13'"'+VpfDProCotacao.CodProduto+'-'+VpfDProCotacao.NomProduto+'" ('+FormatFloat('0',VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdABaixar)+') ' +VpfDProCotacao.UM
  end;
  result := true;
  if (VpfProdutoAMenos <> '') or (VpfProdutoAMais <> '' ) then
  begin
    if VpfProdutoAMenos <> '' then
      VpfResultado := 'Falta associar o produtos abaixo:'+VpfProdutoAMenos+#13;
    if VpfProdutoAMais <> '' then
      VpfResultado := VpfResultado +'Os o produtos abaixo foram associados a mais:'+VpfProdutoAMais+#13;
    result := Confirmacao(VpfResultado+'Deseja gravar a cotação?');
  end;
end;

{******************************************************************************}
procedure TFuncoesCotacao.CopiaDCotacaoProposta(VpaDProsposta: TRBDPropostaCorpo; VpaDCotacao: TRBDOrcamento);
var
  VpfLaco: Integer;
  VpfProdutoProposta: TRBDPropostaProduto;
  VpfProdutoCotacao: TRBDOrcProduto;
  VpfDServicoProposta : TRBDPropostaServico;
  VpfDServicoCotacao : TRBDOrcServico;
begin
  VpaDCotacao.CodCliente:= VpaDProsposta.CodCliente;
  VpaDCotacao.CodVendedor:= VpaDProsposta.CodVendedor;
  VpaDCotacao.NomContato:= VpaDProsposta.NomContato;
  VpaDCotacao.CodCondicaoPagamento := VpaDProsposta.CodCondicaoPagamento;
  VpaDCotacao.CodFormaPaqamento := VpaDProsposta.CodFormaPagamento;
  VpaDCotacao.CodTipoOrcamento := varia.TipoCotacao;
  VpaDCotacao.ValDesconto := VpaDProsposta.ValDesconto;
  VpaDCotacao.PerDesconto := VpaDProsposta.PerDesconto;
  FreeTObjectsList(VpaDCotacao.Produtos);
  for VpfLaco:= 0 to VpaDProsposta.Produtos.Count - 1 do
  begin
     VpfProdutoCotacao:= VpaDCotacao.AddProduto;
     VpfProdutoProposta:= TRBDPropostaProduto(VpaDProsposta.Produtos.Items[VpfLaco]);

     VpfProdutoCotacao.SeqProduto:= VpfProdutoProposta.SeqProduto;
     VpfProdutoCotacao.CodProduto:= VpfProdutoProposta.CodProduto;
     ExisteProduto(VpfProdutoCotacao.CodProduto,0,VpfProdutoCotacao,VpaDCotacao);
     VpfProdutoCotacao.CodCor:= VpfProdutoProposta.CodCor;
     VpfProdutoCotacao.DesCor:= VpfProdutoProposta.DesCor;
     VpfProdutoCotacao.DesObservacao:= VpfProdutoProposta.DesTecnica;
     VpfProdutoCotacao.UM:= VpfProdutoProposta.UM;
     VpfProdutoCotacao.QtdProduto:= VpfProdutoProposta.QtdProduto;
     VpfProdutoCotacao.QtdEstoque:= VpfProdutoProposta.QtdEstoque;
     VpfProdutoCotacao.ValUnitario:= VpfProdutoProposta.ValUnitario;
     VpfProdutoCotacao.ValUnitarioOriginal:= VpfProdutoProposta.ValUnitarioOriginal;
     VpfProdutoCotacao.ValTotal:= VpfProdutoProposta.ValTotal;
  end;
  for VpfLaco := 0 to VpaDProsposta.Servicos.Count - 1 do
  begin
    VpfDServicoProposta := TRBDPropostaServico(VpaDProsposta.Servicos.Items[VpfLaco]);
    VpfDServicoCotacao := VpaDCotacao.AddServico;
    VpfDServicoCotacao.CodServico := VpfDServicoProposta.CodServico;
    ExisteServico(IntToStr(VpfDServicoProposta.CodSErvico),VpfDServicoCotacao);
    VpfDServicoCotacao.NomServico := VpfDServicoProposta.NomServico;
    VpfDServicoCotacao.QtdServico := VpfDServicoProposta.QtdServico;
    VpfDServicoCotacao.ValUnitario := VpfDServicoProposta.ValUnitario;
    VpfDServicoCotacao.ValTotal := VpfDServicoProposta.ValTotal;
  end;
end;

{******************************************************************************}
function TFuncoesCotacao.DuplicaProduto(VpaDCotacao : TRBDOrcamento; VpaDProCotacao : TRBDOrcProduto): TRBDOrcProduto;
begin
  result := VpaDCotacao.AddProduto;
  result.SeqMovimento := 0;
  result.SeqProduto := VpaDProCotacao.SeqProduto;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ExportaProdutosPendentes(VpaDatInicio, VpaDatFim : TDateTime);
var
  VpfProdutos : TList;
begin
  VpfProdutos := TList.Create;
  CarDProdutoPendenteMetalVidros(VpfProdutos,VpaDatINicio,VpaDatFim);
  OrdenaProdutosPendentes(VpfProdutos);
  SalvaArquivoProdutoPendente(VpfProdutos);
  FreeTObjectsList(VpfProdutos);
  VpfProdutos.free;
end;

{******************************************************************************}
procedure TFuncoesCotacao.AtualizaEntradaMetrosDiario(VpaDatInicio, VpaDatFim : TDatetime);
Var
  VpfCodClassificacao, VpfErro : String;
  VpfCodVendedor, VpfCodCliente, VpfCodPreposto, VpfCodEmpresa : Integer;
  VpfSeqEntrada : Integer;
  VpfDatPedido : TDateTime;
begin
  VpfCodClassificacao := '';
  VpfSeqEntrada := 0;

  ExecutaComandoSql(Aux,'Delete from ENTRADAMETRODIARIO');
  AdicionaSQLAbreTabela(CotCadastro,'Select * from ENTRADAMETRODIARIO');
  LocalizaEntradaMetrosDiario(Orcamento,VpaDatInicio,VpaDatFim);
  while not Orcamento.eof do
  begin
    if (VpfCodClassificacao <> copy(Orcamento.FieldByName('C_COD_CLA').AsString,1,Varia.QuantidadeLetrasClassificacaProdutoUnidadeFabricacao))or
       (VpfCodVendedor <> Orcamento.FieldByName('I_COD_VEN').AsInteger) or
       (VpfCodCliente <> Orcamento.FieldByName('I_COD_CLI').AsInteger) or
       (VpfCodPreposto <> Orcamento.FieldByName('I_VEN_PRE').AsInteger) then
    begin
     if VpfCodClassificacao <> '' then
      begin
        VpfSeqEntrada := VpfSeqEntrada + 1;
        CotCadastro.FieldByName('SEQENTRADA').AsInteger := VpfSeqEntrada;
        CotCadastro.post;
      end;
      VpfCodClassificacao := copy(Orcamento.FieldByName('C_COD_CLA').AsString,1,Varia.QuantidadeLetrasClassificacaProdutoUnidadeFabricacao);
      CotCadastro.insert;
      CotCadastro.FieldByName('DATENTRADA').AsDateTime := Orcamento.FieldByName('D_DAT_ORC').AsDateTime;
      CotCadastro.FieldByName('CODCLASSIFICACAO').AsString := VpfCodClassificacao;
      CotCadastro.FieldByName('CODCLIENTE').AsInteger := Orcamento.FieldByName('I_COD_CLI').AsInteger;
      CotCadastro.FieldByName('CODVENDEDOR').AsInteger := Orcamento.FieldByName('I_COD_VEN').AsInteger;
      CotCadastro.FieldByName('CODPREPOSTO').AsInteger := Orcamento.FieldByName('I_VEN_PRE').AsInteger;

      VpfCodVendedor := Orcamento.FieldByName('I_COD_VEN').AsInteger;
      VpfCodCliente := Orcamento.FieldByName('I_COD_CLI').AsInteger;
      VpfCodPreposto :=  Orcamento.FieldByName('I_VEN_PRE').AsInteger;
      VpfCodEmpresa := Orcamento.FieldByName('I_COD_EMP').AsInteger;
    end;
    if Orcamento.FieldByName('I_TIP_ORC').AsInteger = Varia.TipoCotacaoAmostra then
    begin
      CotCadastro.FieldByName('VALAMOSTRA').AsFloat := CotCadastro.FieldByName('VALAMOSTRA').AsFloat + Orcamento.FieldByName('N_VLR_TOT').AsFloat;
      CotCadastro.FieldByName('QTDMETROAMOSTRA').AsFloat := CotCadastro.FieldByName('QTDMETROAMOSTRA').AsFloat +FunProdutos.RQtdMetrosFita(Orcamento.FieldByName('C_COD_PRO').AsString,Orcamento.FieldByName('C_NOM_PRO').AsString,Orcamento.FieldByName('C_COD_UNI').AsString,Orcamento.FieldByName('N_QTD_PRO').AsFloat,Orcamento.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    end
    else
    begin
      CotCadastro.FieldByName('VALPEDIDO').AsFloat := CotCadastro.FieldByName('VALPEDIDO').AsFloat + Orcamento.FieldByName('N_VLR_TOT').AsFloat;
      CotCadastro.FieldByName('QTDMETROPEDIDO').AsFloat := CotCadastro.FieldByName('QTDMETROPEDIDO').AsFloat +FunProdutos.RQtdMetrosFita(Orcamento.FieldByName('C_COD_PRO').AsString,Orcamento.FieldByName('C_NOM_PRO').AsString,Orcamento.FieldByName('C_COD_UNI').AsString,Orcamento.FieldByName('N_QTD_PRO').AsFloat,Orcamento.FieldByName('I_CMP_PRO').AsFloat, VpfErro);
    end;

    CotCadastro.FieldByName('VALTOTAL').AsFloat := CotCadastro.FieldByName('VALTOTAL').AsFloat + Orcamento.FieldByName('N_VLR_TOT').AsFloat;
    CotCadastro.FieldByName('QTDMETROTOTAL').AsFloat := CotCadastro.FieldByName('QTDMETROTOTAL').AsFloat +FunProdutos.RQtdMetrosFita(Orcamento.FieldByName('C_COD_PRO').AsString,Orcamento.FieldByName('C_NOM_PRO').AsString,Orcamento.FieldByName('C_COD_UNI').AsString,Orcamento.FieldByName('N_QTD_PRO').AsFloat,Orcamento.FieldByName('I_CMP_PRO').AsFloat, VpfErro);

    if VpfErro <> '' then
      Aviso(VpfErro);
    Orcamento.Next;
  end;
  if VpfCodClassificacao <> '' then
  begin
    VpfSeqEntrada := VpfSeqEntrada + 1;
    CotCadastro.FieldByName('SEQENTRADA').AsInteger := VpfSeqEntrada;
    CotCadastro.post;
  end;
  Orcamento.close;
  CotCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesCotacao.ImprimeEtiquetaSeparacaoPedido(VpaDCotacao : TRBDOrcamento);
var
  VpfEtiquetas : TList;
  VpfLaco : Integer;
  VpfDProCotacao : TRBDOrcProduto;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfDProduto : TRBDProduto;
  VpfFunArgox : TRBFuncoesArgox;
begin
  if varia.PortaComunicacaoImpTermica <> '' then
  begin
    VpfEtiquetas := TList.create;
    for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
    begin
      VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
      if VpfDProCotacao.IndImprimirEtiquetaSeparacao then
      begin
        if VpfDProCotacao.QtdBaixado < VpfDProCotacao.QtdProduto then
        begin
          VpfDProduto := TRBDProduto.Cria;
          FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,VpaDCotacao.CodEmpFil,VpfDProCotacao.SeqProduto);
          VpfDEtiqueta := TRBDEtiquetaProduto.cria;
          VpfEtiquetas.Add(VpfDEtiqueta);
          VpfDEtiqueta.Produto := VpfDProduto;
          VpfDEtiqueta.CodCor := VpfDProCotacao.CodCor;
          VpfDEtiqueta.QtdOriginalEtiquetas := RetornaInteiro(VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado);
          VpfDEtiqueta.QtdEtiquetas := RetornaInteiro(VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado);
          VpfDEtiqueta.NomCor := VpfDProCotacao.DesCor;
          VpfDEtiqueta.NumPedido := VpaDCotacao.LanOrcamento;
          VpfDEtiqueta.Cliente := IntToStr(VpaDCotacao.CodCliente)+ ' - '+ FunClientes.RNomCliente(IntTosTr(VpaDCotacao.CodCliente));
        end;
      end;
    end;
    if VpfEtiquetas.Count > 0  then
    begin
      VpfFunArgox := TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica);
      VpfFunArgox.ImprimeEtiquetaProduto100X38(VpfEtiquetas);
      VpfFunArgox.free;
    end;

    FreeTObjectsList(VpfEtiquetas);
    VpfEtiquetas.free;
  end;
end;
end.


