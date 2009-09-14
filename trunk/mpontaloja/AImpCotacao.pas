unit AImpCotacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, QuickRpt, Db, DBTables, Qrctrls, jpeg, Parcela, Geradores, printers,
  QRExport, StdCtrls, Mask, Componentes1, UnVendedor, UnClientes, UnCotacao, unDados,
  qrBarcode, UnDadosProduto;

type
  TFImpOrcamento = class(TForm)
    MovOrcamento: TQuery;
    Aux: TQuery;
    CriaParcelas: TCriaParcelasReceber;
    MovOrcamentoCodPro: TStringField;
    MovOrcamentoNomPro: TStringField;
    MovOrcamentoQtdPro: TFloatField;
    MovOrcamentoVlrPro: TFloatField;
    MovOrcamentoTotPro: TFloatField;
    MovOrcamentoC_Cod_Uni: TStringField;
    CadOrcamento: TQuery;
    CadOrcamentoI_EMP_FIL: TIntegerField;
    CadOrcamentoI_LAN_ORC: TIntegerField;
    CadOrcamentoI_COD_CLI: TIntegerField;
    CadOrcamentoI_COD_PAG: TIntegerField;
    CadOrcamentoD_DAT_ORC: TDateField;
    CadOrcamentoT_HOR_ORC: TTimeField;
    CadOrcamentoD_DAT_ENT: TDateField;
    CadOrcamentoT_HOR_ENT: TTimeField;
    CadOrcamentoN_DIA_VAL: TIntegerField;
    CadOrcamentoN_PER_DES: TFloatField;
    CadOrcamentoC_FLA_RES: TStringField;
    CadOrcamentoC_FLA_SIT: TStringField;
    MovOrcamentoC_Imp_fot: TStringField;
    MovOrcamentoL_Des_Tec: TMemoField;
    CadOrcamentoC_CON_ORC: TStringField;
    CadOrcamentoD_DAT_VAL: TDateTimeField;
    MovOrcamentoC_Imp_Des: TStringField;
    MovOrcamentoI_Seq_Pro: TIntegerField;
    CadOrcamentoL_OBS_ORC: TMemoField;
    CadOrcamentoI_COD_VEN: TIntegerField;
    CadOrcamentoD_DAT_PRE: TDateField;
    PedPendentes: TQuery;
    CadOrcamentoC_NOM_VEN: TStringField;
    MovOrcamentoC_DES_COR: TStringField;
    Rel002OrdemProducao: TQuickRepNovo;
    QRBand5: TQRBand;
    QRLabel41: TQRLabel;
    L002Cliente: TQRLabel;
    L002Orcamento: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel61: TQRLabel;
    QRBand8: TQRBand;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRSubDetail2: TQRSubDetail;
    QRDBText28: TQRDBText;
    QRDBText29: TQRDBText;
    QRDBText30: TQRDBText;
    QRDBText31: TQRDBText;
    QRDBText32: TQRDBText;
    QRChildBand1: TQRChildBand;
    QRLabel72: TQRLabel;
    QRLabel73: TQRLabel;
    QRLabel74: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel66: TQRLabel;
    QRDBText21: TQRDBText;
    QRDBText20: TQRDBText;
    QRDBText33: TQRDBText;
    QRShape4: TQRShape;
    QRLabel37: TQRLabel;
    QRDBText25: TQRDBText;
    CadOrcamentoC_ORD_COM: TStringField;
    QRShape5: TQRShape;
    PedidosPorDia: TQuery;
    PedidosPorDiaD_DAT_ORC: TDateField;
    PedidosPorDiaI_EMP_FIL: TIntegerField;
    PedidosPorDiaI_LAN_ORC: TIntegerField;
    PedidosPorDiaD_DAT_PRE: TDateField;
    PedidosPorDiaD_DAT_ENT: TDateField;
    PedidosPorDiaI_COD_CLI: TIntegerField;
    PedidosPorDiaC_NOM_CLI: TStringField;
    PedidosPorDiaN_VLR_TOT: TFloatField;
    PedidosPorDiaI_COD_PAG: TIntegerField;
    PedidosPorDiaC_NOM_PAG: TStringField;
    Rel004AtrasadosPorDia: TQuickRepNovo;
    QRBand6: TQRBand;
    QRLabel55: TQRLabel;
    L004Filial: TQRLabel;
    QRShape8: TQRShape;
    L004Periodo: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel68: TQRLabel;
    QRLabel69: TQRLabel;
    L004Cliente: TQRLabel;
    L004Situacao: TQRLabel;
    L004Vendedor: TQRLabel;
    QRBand7: TQRBand;
    QRDBText40: TQRDBText;
    QRDBText41: TQRDBText;
    QRDBText42: TQRDBText;
    QRDBText43: TQRDBText;
    QRDBText44: TQRDBText;
    QRDBText45: TQRDBText;
    QRBand9: TQRBand;
    QRBand10: TQRBand;
    QRShape9: TQRShape;
    QRSysData7: TQRSysData;
    QRSysData8: TQRSysData;
    QRGroup3: TQRGroup;
    PedidosAtrasadosPorDia: TQuery;
    PedidosAtrasadosPorDiaD_DAT_ORC: TDateField;
    PedidosAtrasadosPorDiaI_COD_CLI: TIntegerField;
    PedidosAtrasadosPorDiaD_DAT_PRE: TDateField;
    PedidosAtrasadosPorDiaD_DAT_ENT: TDateField;
    PedidosAtrasadosPorDiaATRASO: TIntegerField;
    PedidosAtrasadosPorDiaPRAZOESTIMADO: TIntegerField;
    PedidosAtrasadosPorDiaPRAZOREAL: TIntegerField;
    PedidosAtrasadosPorDiaN_VLR_TOT: TFloatField;
    PedidosAtrasadosPorDiaC_NOM_CLI: TStringField;
    PedidosAtrasadosPorDiaI_EMP_FIL: TIntegerField;
    QRDBText47: TQRDBText;
    PedidosAtrasadosPorDiaI_LAN_ORC: TIntegerField;
    QRLabel70: TQRLabel;
    QRDBText46: TQRDBText;
    QRDBText48: TQRDBText;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRDBText49: TQRDBText;
    ResumoAtraso: TQuery;
    ResumoAtrasoATRASO: TIntegerField;
    ResumoAtrasoQTD: TIntegerField;
    ResumoAtrasoVALOR: TFloatField;
    QRSubDetail3: TQRSubDetail;
    QRDBText50: TQRDBText;
    QRDBText51: TQRDBText;
    L004PerQtdAtraso: TQRLabel;
    QRDBText52: TQRDBText;
    L004PerValorAtraso: TQRLabel;
    GroupHeaderBand1: TQRBand;
    QRLabel71: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel78: TQRLabel;
    QRLabel79: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    L004QtdPedAntecipado: TQRLabel;
    L004QtdPedData: TQRLabel;
    L004QtdPedAtrasado: TQRLabel;
    L004ValAntecipado: TQRLabel;
    L004ValData: TQRLabel;
    L004ValAtrasado: TQRLabel;
    ClientesSemPedido: TQuery;
    ClientesSemPedidoI_COD_CLI: TIntegerField;
    ClientesSemPedidoC_NOM_CLI: TStringField;
    ClientesSemPedidoC_CID_CLI: TStringField;
    ClientesSemPedidoC_EST_CLI: TStringField;
    ClientesSemPedidoC_FO1_CLI: TStringField;
    ClientesSemPedidoI_COD_VEN: TIntegerField;
    L004TipoCotacao: TQRLabel;
    CadOrcamentoC_GER_FIN: TStringField;
    CadOrcamentoC_NRO_NOT: TStringField;
    CadOrcamentoN_QTD_TRA: TFloatField;
    CadOrcamentoC_ESP_TRA: TStringField;
    QRLabel6: TQRLabel;
    QRDBText55: TQRDBText;
    MovOrcamentoC_DES_EMB: TStringField;
    R006EtiModelo1: TQuickRepNovo;
    Q006Itens: TQRStringsBand;
    L006Filial: TQRLabel;
    L006Cliente: TQRLabel;
    L006OrdemCompra: TQRLabel;
    L006Produto: TQRLabel;
    L006TitCor: TQRLabel;
    L006Cor1: TQRLabel;
    L006Cor2: TQRLabel;
    L006Cor3: TQRLabel;
    L006Cor4: TQRLabel;
    L006Cor5: TQRLabel;
    L006Qtd1: TQRLabel;
    L006Qtd2: TQRLabel;
    L006Qtd3: TQRLabel;
    L006Qtd4: TQRLabel;
    L006Qtd5: TQRLabel;
    L006Data: TQRLabel;
    SummaryBand4: TQRBand;
    L006Um1: TQRLabel;
    L006Um2: TQRLabel;
    L006Um3: TQRLabel;
    L006Um4: TQRLabel;
    L006Um5: TQRLabel;
    R007EtiPequena: TQuickRepNovo;
    Q007Items: TQRStringsBand;
    L007Qtd: TQRLabel;
    L007Produto: TQRLabel;
    L007Barra: TQRLabel;
    QRBand13: TQRBand;
    L007MM: TQRLabel;
    Rel008EtiComposicao: TQuickRepNovo;
    Q008Items: TQRStringsBand;
    L008Qtd: TQRLabel;
    L008Barra: TQRLabel;
    L008MM: TQRLabel;
    QRBand14: TQRBand;
    L008Produto: TQRLabel;
    L008Composicao: TQRLabel;
    Rel009Referencia: TQuickRepNovo;
    Q009Items: TQRStringsBand;
    L009Empresa: TQRLabel;
    L009Produto: TQRLabel;
    QRBand15: TQRBand;
    L009Referencia: TQRLabel;
    L009Cor: TQRLabel;
    Rel010EtiCaixa: TQuickRepNovo;
    Q010Items: TQRStringsBand;
    L010Filial: TQRLabel;
    L010Cliente: TQRLabel;
    L010OrdemCompra: TQRLabel;
    L010Produto: TQRLabel;
    L010Cor: TQRLabel;
    L010Qtd: TQRLabel;
    L010Data: TQRLabel;
    QRBand16: TQRBand;
    L002NomProduto: TQRLabel;
    MovOrcamentoC_PRO_REF: TStringField;
    CadOrcamentoN_VLR_TOT: TFloatField;
    CadOrcamentoN_VLR_DES: TFloatField;
    SummaryBand5: TQRBand;
    QRDBText56: TQRDBText;
    QRLabel32: TQRLabel;
    CadOrcamentoI_COD_TRA: TIntegerField;
    CadOrcamentoI_TIP_FRE: TIntegerField;
    MovServicoOrcamento: TQuery;
    MovServicoOrcamentoI_Cod_Ser: TIntegerField;
    MovServicoOrcamentoN_Vlr_Ser: TFloatField;
    MovServicoOrcamentoN_Qtd_Ser: TFloatField;
    MovServicoOrcamentoN_Vlr_Tot: TFloatField;
    MovServicoOrcamentoC_Nom_Ser: TStringField;
    L002DesCor: TQRLabel;
    Rel013EtiAmostra: TQuickRepNovo;
    Q013Items: TQRStringsBand;
    L013Filial: TQRLabel;
    L013DATA: TQRLabel;
    QRBand1: TQRBand;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    L013Aprovado: TQRLabel;
    L013Artigo: TQRLabel;
    QRShape20: TQRShape;
    L013CORMARISOL: TQRLabel;
    L013CorCompletaMarisol: TQRLabel;
    L013CorCadartex: TQRLabel;
    QRShape21: TQRShape;
    L013QUANTIDADE: TQRLabel;
    QRShape22: TQRShape;
    L013PEDIDO: TQRLabel;
    QRShape23: TQRShape;
    L013CAPTIONDESTINO: TQRLabel;
    QRShape24: TQRShape;
    L013DESTINO: TQRLabel;
    L013MM: TQRLabel;
    QRShape25: TQRShape;
    L013MODELO: TQRLabel;
    QRShape26: TQRShape;
    L013XModelo: TQRLabel;
    L013MODELOA: TQRLabel;
    QRShape27: TQRShape;
    L013MODELOB: TQRLabel;
    L013ALGODAO: TQRLabel;
    L013XALGODAO: TQRLabel;
    QRShape28: TQRShape;
    L013POLIESTER: TQRLabel;
    L013XPOLIESTER: TQRLabel;
    QRShape29: TQRShape;
    PedidosPorDiaC_IND_CAN: TStringField;
    QRLabel18: TQRLabel;
    L002Cidade: TQRLabel;
    ClientesSemPedidoC_CON_CLI: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Childband1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRSubDetail3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand9AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand9BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure GroupHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand3AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure Q006ItensBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand4AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure Q007ItemsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Q008ItemsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Q009ItemsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Q010ItemsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand8BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Q013ItemsBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure AcompanhamentoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    VprUltimoProduto,
    VprQtdDias, VprQtdPed,VprMes,
    VprQtdPedAntecipado,
    VprQtdPedData,
    VprQtdPedAtrasado,
    VprPrimeiroMes,
    VprUltimoSeqPedido,
    VprQtdClientesVendedor,
    VprQtdClienteSemPedido,
    VprQtdClienteComPedido,
    VprQtdClienteSemPedidoVendedor,
    VprQtdClientes,
    VprLacoProdutos,
    VprLacoCores  : Integer;
    VprValPedAntecipado,
    VprValPedData,
    VprValPedAtrasado,
    VprValPedDia,
    VprQtdProDia,
    VprValTotPed, VprPedMes, VprProMes, VprQtdTotPro : Double;
    VprImprimirAcompanhamentoVisita : Boolean;
    VprDEtiModelo1 : TRBDEtiModelo1;
    FunVendedor : TRBFuncoesVendedor;
    FunCotacao : TFuncoesCotacao;
    procedure MostrarLinhasEtiquetaAmostra(VpaMostrar : Boolean);
    procedure ConfiguraPermissaoUsuario;
    procedure CarregaRelatorio(VpaOrcamento : String);
    procedure CarregaCabecalho(VpaOrcamento : String);
    procedure CarregaCadOrcamento(VpaOrcamento : String);
    procedure CarregaProdutos(VpaOrcamento : String);
    procedure CarregaServicos(VpaOrcamento : String);
    procedure cArPedidosAtrasadosPorDia(VpaCodFilial, VpaNomFilial, VpaCodTipCotacao, VpaNomTipCotacao, VpaCodCliente, VpaNomCliente, VpaCodVendedor, VpaNomVendedor, VpaSituacao : String;VpaDatInicio,VpaDatFim : TDateTime);
    procedure CarPosEtiquetaModelo1(VpaDModelo1 : TRBDEtiModelo1);
    procedure CarPosEtiquetaPequena(VpaDModelo1 : TRBDEtiModelo1);
    procedure CarPosEtiquetaComposicao(VpaDModelo1 : TRBDEtiModelo1);
    procedure CarPosEtiquetaReferencia(VpaDModelo1 : TRBDEtiModelo1);
    procedure PosicionaProdutos(VpaOrcamento : String);
    procedure CarregaCliente(Codigo :Integer);
    procedure CarParcelasContasaReceber(VpaParcelas : TStrings);
    procedure AdicionaCabecalhoParcelas(Parcelas : TQRMemo);
    function ValorOrcamento : double;
    Function NomeCondicao(Codigo : Integer):String;
    Function ProdutoFoto : string;
    procedure PosicionaImpressora;
  public
    { Public declarations }
    procedure ImprimeOP(VpaDOrcamento : TRBDOrcamento);
    procedure ImpPedidosAtrasadosPorDia(VpaCodFilial, VpaNomFilial,VpaCodTipCotacao, VpaNomTipCotacao,  VpaCodCliente, VpaNomCliente, VpaCodVendedor, VpaNomVendedor, VpaSituacao : String;VpaDatInicio,VpaDatFim : TDateTime;VpaVisualizar : Boolean);
    procedure ImpEtiquetaModelo1(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
    procedure ImpEtiquetaPequena(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
    procedure ImpEtiquetaComposicao(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
    procedure ImpEtiquetaPeqRefCliente(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
    procedure ImpEtiquetaCaixa(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
    procedure ImpEtiquetaAmostra(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
  end;
var
  FImpOrcamento: TFImpOrcamento;

implementation

Uses Constantes,FunString,Fundata, FunSQl,FunObjeto, APrincipal, ConstMsg, FunNumeros;

{$R *.DFM}


{ ******************* Quando o formulario e fechado ************************** }
procedure TFImpOrcamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadOrcamento.close;
   MovOrcamento.close;
   aux.close;
   FunVendedor.free;
   FunCotacao.free;
   Action := CaFree;
end;

{**************************Quando o formulario é criado************************}
procedure TFImpOrcamento.FormCreate(Sender: TObject);
begin
  FunVendedor := TRBFuncoesVendedor.cria(FPrincipal.BaseDados);
  FunCotacao := TFuncoesCotacao.Cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Ações que carregam o relatorio
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImpOrcamento.ImprimeOP(VpaDOrcamento : TRBDOrcamento);
var
  VpfCotacoes : TList;
begin
  CarregaRelatorio(IntToStr(VpaDOrcamento.LanOrcamento));
  VpfCotacoes := TList.create;
  VpfCotacoes.add(VpaDOrcamento);
  FunCotacao.SetaOPImpressa(VpfCotacoes);
  VpfCotacoes.free;
  Rel002OrdemProducao.Print;
  close;
end;


{******************************************************************************}
procedure TFImpOrcamento.ImpPedidosAtrasadosPorDia(VpaCodFilial, VpaNomFilial, VpaCodTipCotacao, VpaNomTipCotacao, VpaCodCliente, VpaNomCliente, VpaCodVendedor, VpaNomVendedor, VpaSituacao : String;VpaDatInicio,VpaDatFim : TDateTime;VpaVisualizar : Boolean);
begin
  CarPedidosAtrasadosPorDia(VpaCodFilial, VpaNomFilial, VpaCodTipCotacao, VpaNomTipCotacao, VpaCodCliente, VpaNomCliente, VpaCodVendedor, VpaNomVendedor, VpaSituacao,VpaDatInicio,VpaDatFim);
  if VpaVisualizar then
    Rel004AtrasadosPorDia.Preview
  else
    Rel004AtrasadosPorDia.print;
end;

{******************************************************************************}
procedure TFImpOrcamento.ImpEtiquetaModelo1(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
begin
  VprLacoProdutos := 0;
  VprLacoCores := 0;
  VprDEtiModelo1 := VpaDModelo1;
  CarPosEtiquetaModelo1(VpaDModelo1);
  if VpaVisualizar then
    R006EtiModelo1.Preview
  else
    R006EtiModelo1.Print;
end;

{******************************************************************************}
procedure TFImpOrcamento.ImpEtiquetaPequena(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
begin
  VprLacoProdutos := 0;
  VprDEtiModelo1 := VpaDModelo1;
  CarPosEtiquetaPequena(VpaDModelo1);
  if VpaVisualizar then
    R007EtiPequena.Preview
  else
    R007EtiPequena.Print;
end;

{******************************************************************************}
procedure TFImpOrcamento.ImpEtiquetaComposicao(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
begin
  VprLacoProdutos := 0;
  VprDEtiModelo1 := VpaDModelo1;
  CarPosEtiquetaComposicao(VpaDModelo1);
  if VpaVisualizar then
    Rel008EtiComposicao.Preview
  else
    Rel008EtiComposicao.Print;
end;

{******************************************************************************}
procedure TFImpOrcamento.ImpEtiquetaPeqRefCliente(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
begin
  VprLacoProdutos := 0;
  VprDEtiModelo1 := VpaDModelo1;
  CarPosEtiquetaReferencia(VpaDModelo1);
  if VpaVisualizar then
    Rel009Referencia.Preview
  else
    Rel009Referencia.Print;
end;

{******************************************************************************}
procedure TFImpOrcamento.ImpEtiquetaCaixa(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
begin
  VprLacoProdutos := 0;
  VprDEtiModelo1 := VpaDModelo1;
  CarPosEtiquetaPequena(VpaDModelo1);
  if VpaVisualizar then
    Rel010EtiCaixa.Preview
  else
    Rel010EtiCaixa.Print;
end;

{******************************************************************************}
procedure TFImpOrcamento.ImpEtiquetaAmostra(VpaDModelo1 : TRBDEtiModelo1; VpaVisualizar : Boolean);
begin
  VprLacoProdutos := 0;
  VprDEtiModelo1 := VpaDModelo1;
  CarPosEtiquetaPequena(VpaDModelo1);
  if VpaVisualizar then
    Rel013EtiAmostra.preview
  else
    Rel013EtiAmostra.Print;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         eventos do Cabeçalho do relatório
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************Carrega o  cabeçalho do relatório************************}
procedure TFImpOrcamento.CarregaCabecalho(VpaOrcamento : String);
begin
   CarregaCadOrcamento(VpaOrcamento);
   CarregaCliente(CadOrcamentoI_COD_CLI.Asinteger);
end;

{***********************Retorna o nome do cliente******************************}
procedure TFImpOrcamento.CarregaCliente(Codigo :Integer);
Var
  VpfCGCCPF : String;
begin
  AdicionaSQLAbreTabela(aux,'Select C_NOM_CLI, C_CID_CLI from dba.CadClientes '+
                            ' Where I_Cod_Cli = '+ IntToStr(Codigo));
  L002Cliente.Caption := aux.fieldbyname('C_Nom_Cli').AsString;
  L002Cidade.Caption := Aux.fieldbyname('C_CID_CLI').AsString;
end;

{*******************Carrega os dados do cadOrcamento***************************}
procedure TFImpOrcamento.CarregaCadOrcamento(VpaOrcamento : String);
begin
  AdicionaSQLAbreTabela(CadOrcamento,'Select * from dba.CadOrcamentos cad, CadVendedores ven'+
                        ' Where I_emp_Fil = '+ InTToStr(Varia.CodigoEmpFil) +
                        ' and I_Lan_Orc = ' + VpaOrcamento+
                        ' and cad.i_cod_ven = ven.i_cod_Ven');
  CadOrcamento.open;
  L002Orcamento.Caption := 'Pedido : ' + VpaOrcamento;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       eventos dos produtos do Orcamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************Carrega os produtos do orcamento*************************}
procedure TFImpOrcamento.CarregaProdutos(VpaOrcamento : String);
begin
   PosicionaProdutos(VpaOrcamento);
   MovOrcamento.last;
   VprUltimoProduto := MovOrcamentoI_Seq_Pro.AsInteger;
end;

{********************Posiciona os produtos do MovOrcamento*********************}
procedure TFImpOrcamento.PosicionaProdutos(VpaOrcamento : String);
begin
  AdicionaSQLAbreTabela(MovOrcamento,'Select Pro.'+ Varia.CodigoProduto+ ' CodPro, pro.C_Nom_Pro NomPro, '+
                  ' Orc.N_Qtd_Pro QtdPro, Orc.N_Vlr_Pro VlrPro, Orc.N_Vlr_TOT TotPro, ORC.C_PRO_REF, '+
                  ' Orc.C_Cod_Uni, Orc.C_Imp_fot, ORC.C_DES_COR,ORC.C_DES_EMB, Pro.L_Des_Tec, Orc.C_Imp_Des, Pro.I_seq_Pro '+
                  ' from dba.MovOrcamentos Orc, CadProdutos Pro' +
                  ' Where Orc.I_Seq_Pro = Pro.I_Seq_pro '+
                  '  and Orc.I_emp_fil = ' + IntToStr(Varia.CodigoEmpFil) +
                  ' and Orc.I_Lan_Orc = ' + VpaOrcamento +
                  ' order by ORC.I_SEQ_MOV' );
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos dos servicos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************* carrega o servico do orcamento *************************}
procedure TFImpOrcamento.CarregaServicos(VpaOrcamento : String);
begin
  AdicionaSQLAbreTabela(MovServicoOrcamento,'Select Mov.I_Cod_Ser, Mov.N_Vlr_Ser,'+
                ' Mov.N_Qtd_Ser, Mov.N_Vlr_Tot, Ser.Ser.C_Nom_Ser ' +
                ' from CadServico Ser, MovSErvicoOrcamento Mov ' +
                ' Where Mov.I_Emp_Fil  = ' + IntToStr(Varia.CodigoEmpFil) +
                ' and Mov.I_Lan_Orc = ' + VpaOrcamento +
                ' and Mov.I_Cod_Ser = Ser.I_cod_Ser ');
end;


{******************************************************************************}
procedure TFImpOrcamento.cArPedidosAtrasadosPorDia(VpaCodFilial, VpaNomFilial, VpaCodTipCotacao, VpaNomTipCotacao, VpaCodCliente, VpaNomCliente, VpaCodVendedor, VpaNomVendedor, VpaSituacao : String;VpaDatInicio,VpaDatFim : TDateTime);
begin
  VprQtdPedAntecipado := 0;
  VprQtdPedData := 0;
  VprQtdPedAtrasado := 0;
  VprValPedAntecipado := 0;
  VprValPedData := 0;
  VprValPedAtrasado := 0;

  if VpaCodFilial <> '' then
    L004Filial.Caption := 'Filial : '+ VpaCodFilial+'-'+VpaNomFilial
  else
    L004Filial.Caption := 'Filial : Todas';
  L004Periodo.Caption := 'Período de : ' + DataToStrFormato(DDMMAAAA,VpaDatInicio,'/')+ ' a '+ DataToStrFormato(DDMMAAAA,VpaDatFim,'/');
  if VpaCodCliente <> '' then
    L004Cliente.Caption := 'Cliente : '+VpaCodCliente+'-'+VpaNomCliente
  else
    L004Cliente.Caption := 'Cliente : Todos';
  if VpaCodVendedor <> '' then
    L004Vendedor.Caption := 'Vendedor : '+VpaCodVendedor+'-'+VpaNomVendedor
  else
    L004Vendedor.Caption := 'Vendedor : Todos';
  if VpaSituacao <> '' then
    L004Situacao.Caption := 'Situação : '+VpaSituacao
  else
    L004Situacao.Caption := 'Situação : Todas';
  if VpaCodTipCotacao <> '' then
    L004TipoCotacao.Caption := 'Tipo Cotação : '+VpaCodTipCotacao +'-' +VpaNomTipCotacao
  else
    L004TipoCotacao.Caption := 'Tipo Cotação : Todos';
  PedidosAtrasadosPorDia.Sql.Clear;
  PedidosAtrasadosPorDia.Sql.Add('select CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.D_DAT_ORC, '+
                                 ' CAD.I_COD_CLI, D_DAT_PRE, D_DAT_ENT, ' +
                                 ' isnull(d_dat_ent,getdate()) - d_dat_pre ATRASO, '+
                                 ' CAD.D_DAT_PRE -  CAD.D_DAT_ORC PRAZOESTIMADO, '+
                                 ' isnull(d_dat_ent,getdate()) - d_dat_ORC PRAZOREAL, '+
                                 ' CAD.N_VLR_TOT,  CLI.C_NOM_CLI ');
  PedidosAtrasadosPorDia.Sql.Add('from CADORCAMENTOS CAD, CADCLIENTES CLI ');
  Aux.Sql.Clear;
  Aux.Sql.Add('Select count(*) QTD, sum(CAD.N_VLR_TOT) VALOR ');
  Aux.Sql.Add('from CADORCAMENTOS CAD');
  PedidosAtrasadosPorDia.Sql.Add('where '+SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_PRE',VpaDatInicio,VpaDatFim,false) +
                                 ' AND CLI.I_COD_CLI = CAD.I_COD_CLI ');
  Aux.Sql.Add('where '+SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_PRE',VpaDatInicio,VpaDatFim,false));
  if VpaCodFilial <> '' then
  begin
    PedidosAtrasadosPorDia.Sql.Add('AND CAD.I_EMP_FIL = ' +VpaCodFilial);
    Aux.Sql.Add('AND CAD.I_EMP_FIL = ' +VpaCodFilial);
  end;
  if VpaCodCliente <> '' then
  begin
    PedidosAtrasadosPorDia.Sql.Add('AND CAD.I_COD_CLI = ' +VpaCodCliente);
    Aux.Sql.Add('AND CAD.I_COD_CLI = ' +VpaCodCliente);
  end;
  if VpaCodVendedor <> '' then
  begin
    PedidosAtrasadosPorDia.Sql.Add('AND CAD.I_COD_VEN = ' +VpaCodVendedor);
    Aux.Sql.Add('AND CAD.I_COD_VEN = ' +VpaCodVendedor);
  end;
  if VpaSituacao <> '' then
  begin
    PedidosAtrasadosPorDia.Sql.Add(' and CAD.C_Fla_Sit = '''+VpaSituacao+'''');
    Aux.Sql.Add(' and CAD.C_Fla_Sit = '''+VpaSituacao+'''');
  end;
  if VpaCodTipCotacao <> '' then
  begin
    PedidosAtrasadosPorDia.Sql.Add(' and CAD.I_TIP_ORC = '+VpaCodTipCotacao);
    Aux.Sql.Add('and CAD.I_TIP_ORC = '+ VpaCodTipCotacao);
  end;
  if (varia.CNPJFilial = CNPJ_Kairos) or (varia.CNPJFilial = CNPJ_AviamentosJaragua) then
  begin
    PedidosAtrasadosPorDia.Sql.Add(' and CAD.I_EMP_FIL <> 13 ');
    aux.Sql.Add(' and CAD.I_EMP_FIL <> 13 ');
  end;

  PedidosAtrasadosPorDia.sql.Add('order by CAD.D_DAT_PRE');
  PedidosAtrasadosPorDia.open;
  PedidosAtrasadosPorDia.Last;
  VprUltimoSeqPedido := PedidosAtrasadosPorDia.FieldByName('I_LAN_ORC').AsInteger;
  PedidosAtrasadosPorDia.First;
  Aux.Open;
  VprQtdPed := Aux.FieldByName('QTD').AsInteger;
  VprValTotPed := Aux.FieldByName('VALOR').AsFloat;


  Aux.Close;
  ResumoAtraso.Sql.Text := Aux.Sql.text;
  ResumoAtraso.Sql.Delete(0);
  resumoAtraso.Sql.Insert(0,'select  isnull(d_dat_ent,getdate()) - d_dat_pre ATRASO, count(*)QTD, sum(CAD.N_VLR_TOT) VALOR ');
  ResumoAtraso.Sql.Add('group by atraso  '+
                       ' order by 1 ');
  ResumoAtraso.open;
end;

{******************************************************************************}
procedure TFImpOrcamento.CarPosEtiquetaModelo1(VpaDModelo1 : TRBDEtiModelo1);
var
  VpfLaco : Integer;
begin
  Q006Itens.Items.Clear;
  for VpfLaco := 1 to VpaDModelo1.EtiInicial - 1 do
  begin
    Q006Itens.Items.Add('0');
  end;
  for VpfLaco := 1 to VpaDModelo1.QtdEtiquetas do
  begin
    Q006Itens.Items.Add('1');
    Q010Items.Items.Add('1');
  end;
end;

{******************************************************************************}
procedure TFImpOrcamento.CarPosEtiquetaPequena(VpaDModelo1 : TRBDEtiModelo1);
var
  VpfLaco : Integer;
begin
  Q010Items.Items.Clear;
  Q007Items.Items.Clear;
  Q013Items.Items.clear;
  for VpfLaco := 1 to VpaDModelo1.EtiInicial - 1 do
  begin
    Q007Items.Items.Add('0');
    Q010Items.Items.Add('0');
    Q013Items.Items.Add('0');
  end;
  for VpfLaco := 1 to VpaDModelo1.EtiPequenas.Count do
  begin
    Q007Items.Items.Add('1');
    Q010Items.Items.Add('1');
    Q013Items.Items.Add('1');
  end;
end;

{******************************************************************************}
procedure TFImpOrcamento.CarPosEtiquetaComposicao(VpaDModelo1 : TRBDEtiModelo1);
var
  VpfLaco : Integer;
begin
  Q008Items.Items.Clear;
  for VpfLaco := 1 to VpaDModelo1.EtiInicial - 1 do
    Q008Items.Items.Add('0');
  for VpfLaco := 1 to VpaDModelo1.EtiPequenas.Count do
    Q008Items.Items.Add('1');
end;

{******************************************************************************}
procedure TFImpOrcamento.CarPosEtiquetaReferencia(VpaDModelo1 : TRBDEtiModelo1);
var
  VpfLaco : Integer;
begin
  Q009Items.Items.Clear;
  for VpfLaco := 1 to VpaDModelo1.EtiInicial - 1 do
    Q009Items.Items.Add('0');
  for VpfLaco := 1 to VpaDModelo1.EtiPequenas.Count do
    Q009Items.Items.Add('1');
end;



{****************** imprime o titulo dos servicos *****************************}
procedure TFImpOrcamento.Childband1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := ((VprUltimoProduto = MovOrcamentoI_Seq_pro.AsInteger) and not(MovServicoOrcamento.IsEmpty)) ;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   Carrega as parcelas do Orcamento e o sumario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImpOrcamento.CarParcelasContasaReceber(VpaParcelas : TStrings);
begin
  AdicionaSQLAbreTabela(Aux,'select MOV.I_NRO_PAR, MOV.D_DAT_VEN, MOV.N_VLR_PAR '+
                                  ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                                  ' where CAD.I_EMP_FIL = '+IntToStr(varia.CodigoEmpFil)+
                                  ' and CAD.C_IND_CAD  = ''S''' +
                                  ' and CAD.I_SEQ_NOT is null '+
                                  ' and CAD.I_NRO_NOT = '+CadOrcamentoI_LAN_ORC.AsString+
                                  ' and CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' and CAD.I_LAN_REC = MOV.I_LAN_REC');
  while not  Aux.eof do
  begin
    VpaParcelas.add(CentraStr(Aux.FieldByName('I_NRO_PAR').AsString,6) + ' - '+
                           CentraStr(FormatDateTime('DD/MM/YYYY',Aux.FieldByName('D_DAT_VEN').AsDateTime) ,10) + ' - ' +
                           AdicionaBrancoE(Formatfloat(Varia.MascaraMoeda,Aux.FieldByName('N_VLR_PAR').AsFloat),17));

    Aux.Next;
  end;
  Aux.Close;
end;

{****************** retorna o valor do orcamento ******************************}
function TFImpOrcamento.ValorOrcamento : double;
begin
  result := 0;
  MovOrcamento.First;
  While not MovOrcamento.Eof do
  begin
    Result := result + MovOrcamentoTotPro.AsFloat;
    MovOrcamento.next;
  end;

  MovServicoOrcamento.first;
  While not MovServicoOrcamento.Eof do
  begin
    result := Result + MovServicoOrcamentoN_Vlr_Tot.AsFloat;
    MovServicoOrcamento.next;
  end;
end;

{********************Adiciona um cabeçalho nas parcelas************************}
procedure TFImpOrcamento.AdicionaCabecalhoParcelas(Parcelas : TQRMemo);
begin
   Parcelas.Lines.Clear;
   parcelas.lines.add(CentraStr('PARC.',5) + '     '+
                         CentraStr('VENCIMENTO',10) + '    ' +
                         AdicionaBrancoE('VALOR',15));
   parcelas.lines.add('');
end;

{*************************retorna o nome da Condição***************************}
Function TFImpOrcamento.NomeCondicao(Codigo : Integer) : String;
begin
   aux.close;
   aux.sql.clear;
   aux.sql.add('Select * from dba.CadCondicoesPagto ' +
               ' Where I_Cod_Pag = '+ IntToStr(codigo));
   aux.open;

   result := aux.FieldByName('C_Nom_Pag').asstring;
end;


{************retorna o codigo do produto que será impressa a foto**************}
Function TFImpOrcamento.ProdutoFoto : string;
begin
   MovOrcamento.First;
   While not MovOrcamento.eof do
   begin
      if MovOrcamentoC_Imp_fot.AsString = 'S' Then
         begin
         result :=MovOrcamentoI_Seq_Pro.AsString;
         exit;
         end;
      MovOrcamento.Next;
   end;
   result := ''
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************** posiciona a impressora do quicreport ************************}
procedure TFImpOrcamento.PosicionaImpressora;
  var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to printer.Printers.Count -1 do
    if printer.Printers[VpfLaco] = Varia.ImpressoraRelatorio then
    begin
       Rel002OrdemProducao.PrinterSettings.PrinterIndex := VpfLaco;
       Rel004AtrasadosPorDia.PrinterSettings.PrinterIndex := VpfLaco;
    end;
end;

{******************************************************************************}
procedure TFImpOrcamento.MostrarLinhasEtiquetaAmostra(VpaMostrar : Boolean);
var
  VpfTipoLinha : TPenStyle;
begin
  if VpaMostrar then
    VpfTipoLinha := psSolid
  else
    VpfTipoLinha := psClear;

    QRShape18.Pen.Style := VpfTipoLinha;
    QRShape19.Pen.Style := VpfTipoLinha;
    QRShape20.Pen.Style := VpfTipoLinha;
    QRShape21.Pen.Style := VpfTipoLinha;
    QRShape22.Pen.Style := VpfTipoLinha;
    QRShape23.Pen.Style := VpfTipoLinha;
    QRShape24.Pen.Style := VpfTipoLinha;
    QRShape25.Pen.Style := VpfTipoLinha;
    QRShape26.Pen.Style := VpfTipoLinha;
    QRShape27.Pen.Style := VpfTipoLinha;
    QRShape28.Pen.Style := VpfTipoLinha;
    QRShape29.Pen.Style := VpfTipoLinha;
end;

{******************************************************************************}
procedure TFImpOrcamento.ConfiguraPermissaoUsuario;
begin
end;

{********************Carrega o relatorio do orcamento**************************}
procedure TFImpOrcamento.CarregaRelatorio(VpaOrcamento : String);
begin
   PosicionaImpressora;
   CarregaCabecalho(VpaOrcamento);
   CarregaProdutos(VpaOrcamento);
   CarregaServicos(VpaOrcamento);
   Rel002OrdemProducao.ReportTitle := 'Ordem de produção Nr. '+VpaOrcamento;
end;


{******************************************************************************}
procedure TFImpOrcamento.SummaryBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  vprmes := VprPrimeiroMes;
end;

{******************************************************************************}
procedure TFImpOrcamento.QRSubDetail3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := VprUltimoSeqPedido = PedidosAtrasadosPorDia.FieldByName('I_LAN_ORC').AsInteger;
  if PrintBand then
  begin
    L004PerQtdAtraso.Caption := FormatFloat('##0.00%',(ResumoAtrasoQTD.AsInteger *100)/VprQtdPed);
    L004PerValorAtraso.Caption := FormatFloat('##0.00%',(ResumoAtrasoVALOR.AsFloat * 100)/VprValTotPed);
    if ResumoAtrasoATRASO.AsInteger < 0 then
    begin
      VprQtdPedAntecipado := VprQtdPedAntecipado + ResumoAtrasoQTD.AsInteger;
      VprValPedAntecipado := VprValPedAntecipado + ResumoAtrasoVALOR.AsFloat;
    end
    else
      if ResumoAtrasoATRASO.AsInteger = 0 then
      begin
        VprQtdPedData := VprQtdPedData + ResumoAtrasoQTD.AsInteger;
        VprValPedData := VprValPedData + ResumoAtrasoVALOR.AsFloat;
      end
      else
        if ResumoAtrasoATRASO.AsInteger > 0 then
        begin
          VprValPedAtrasado := VprValPedAtrasado + ResumoAtrasoVALOR.AsFloat;
          VprQtdPedAtrasado := VprQtdPedAtrasado + ResumoAtrasoQTD.AsInteger;
        end;
  end;
end;

{******************************************************************************}
procedure TFImpOrcamento.QRBand9AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  VprQtdPedAntecipado := 0;
  VprQtdPedData := 0;
  VprQtdPedAtrasado := 0;
  VprValPedAntecipado := 0;
  VprValPedData := 0;
  VprValPedAtrasado := 0;
end;

{******************************************************************************}
procedure TFImpOrcamento.QRBand9BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  L004QtdPedAntecipado.Caption := 'Qtd Entregue Antecipado : '+ IntToStr(VprQtdPedAntecipado) + '  -  '+  FormatFloat('##0.00%',(VprQtdPedAntecipado * 100)/VprQtdPed);
  L004QtdPedData.Caption := 'Qtd Entregue na Data : '+ IntToStr(VprQtdPedData) + '  -  '+ FormatFloat('0.00%',(VprQtdPedData * 100)/VprQtdPed);
  L004QtdPedAtrasado.Caption := 'Qtd Entregue Atrasado : '+IntToStr(VprQtdPedAtrasado) + '  -  '+ FormatFloat('0.00%',(VprQtdPedAtrasado * 100)/VprQtdPed);
  L004ValAntecipado.Caption := 'Valor Entregue Antecipado : '+ FormatFloat('###,###,###,###,##0.00',VprValPedAntecipado) + '  -  ' + FormatFloat('0.00%',(VprValPedAntecipado * 100)/VprValTotPed);
  L004ValData.Caption := 'Valor Entregue na Data : '+ FormatFloat('###,###,###,###,##0.00',VprValPedData) + '  -  '+ FormatFloat('0.00%',(VprValPedData * 100)/ VprValTotPed);
  L004ValAtrasado.Caption := 'Valor Entregue Atrasado : '+ FormatFloat('###,###,###,##0.00',VprValPedAtrasado) + '  -  ' + FormatFloat('0.00%',(VprValPedAtrasado * 100)/VprValTotPed);
end;

{******************************************************************************}
procedure TFImpOrcamento.GroupHeaderBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := VprUltimoSeqPedido = PedidosAtrasadosPorDia.FieldByName('I_LAN_ORC').AsInteger;
end;

{******************************************************************************}
procedure TFImpOrcamento.SummaryBand3AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  VprQtdClienteSemPedido := 0;
  VprQtdClienteSemPedidoVendedor := 0;
end;

procedure TFImpOrcamento.Q006ItensBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  VpfDEtiProduto : TRBDEtiProduto;
  VpfDEtiCor : TRBDEtiCor;
  Vpflaco : Integer;
begin
  LimpaComponentes(Q006Itens,0);
  if Q006Itens.Item = '1' then
  begin
    L006Filial.Caption := Varia.NomeFilial;
    L006Cliente.Caption := 'Cliente : ' + VprDEtiModelo1.NomCliente;
    L006OrdemCompra.Caption := 'OC : ' + VprDEtiModelo1.OrdemCompra;
    L006Data.Caption := 'Data : '+FormatDateTime('DD/MM/YYYY',Date);
    VpfDEtiProduto := TRBDEtiProduto(VprDEtiModelo1.Produtos.Items[VprLacoProdutos]);
    L006TitCor.Caption := 'Cor : ';
    L006Produto.Caption := 'Produto : '+ VpfDEtiProduto.NomProduto;
    for VpfLaco := 0 to VpfDEtiProduto.Cores.Count - 1 do
    begin
      VpfDEtiCor := TRBDEtiCor(VpfDEtiProduto.Cores.Items[VprLacoCores]);
      case Vpflaco of
        0 :begin
             if VpfDEtiCor.DesReferenciaCliente <> '' then
               L006Cor1.Caption := VpfDEtiCor.DesReferenciaCliente +' - '+ VpfDEtiCor.NomCor
             else
               L006Cor1.Caption := VpfDEtiCor.NomCor;
             L006Qtd1.Caption := FloatToStr(VpfDEtiCor.QtdEtiqueta); L006Um1.Caption := VpfDEtiCor.UM;
           end;
        1 :begin
             if VpfDEtiCor.DesReferenciaCliente <> '' then
               L006Cor2.Caption := VpfDEtiCor.DesReferenciaCliente +' - '+ VpfDEtiCor.NomCor
             else
               L006Cor2.Caption := VpfDEtiCor.NomCor;
             L006Qtd2.Caption := FloatToStr(VpfDEtiCor.QtdEtiqueta); L006Um2.Caption := VpfDEtiCor.UM;
           end;
        2 :begin
             if VpfDEtiCor.DesReferenciaCliente <> '' then
               L006Cor3.Caption := VpfDEtiCor.DesReferenciaCliente +' - '+ VpfDEtiCor.NomCor
             else
               L006Cor3.Caption := VpfDEtiCor.NomCor;
             L006Qtd3.Caption := FloatToStr(VpfDEtiCor.QtdEtiqueta); L006Um3.Caption := VpfDEtiCor.UM;
           end;
        3 :begin
             if VpfDEtiCor.DesReferenciaCliente <> '' then
               L006Cor4.Caption := VpfDEtiCor.DesReferenciaCliente +' - '+ VpfDEtiCor.NomCor
             else
               L006Cor4.Caption := VpfDEtiCor.NomCor;
             L006Qtd4.Caption := FloatToStr(VpfDEtiCor.QtdEtiqueta); L006Um4.Caption := VpfDEtiCor.UM;
           end;
//        4 :begin
//             if VpfDEtiCor.DesReferenciaCliente <> '' then
//               L006Cor5.Caption := VpfDEtiCor.DesReferenciaCliente
//             else
//               L006Cor5.Caption := VpfDEtiCor.NomCor;
//             L006Qtd5.Caption := FloatToStr(VpfDEtiCor.QtdEtiqueta); L006Um5.Caption := VpfDEtiCor.UM;
//           end;
      end;
      inc(VprLacoCores);
      if VprLacoCores >= VpfDEtiProduto.Cores.Count then
      begin
        inc(VprLacoProdutos);
        VprLacoCores := 0;
        exit;
      end;

      if Vpflaco >= 3 then
        exit;
    end;
    inc(VprLacoProdutos);
    VprLacoCores := 0;
  end;
end;

{******************************************************************************}
procedure TFImpOrcamento.SummaryBand4AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  VprLacoProdutos :=0;
  VprLacoCores := 0;
end;

{******************************************************************************}
procedure TFImpOrcamento.Q007ItemsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  VpfDEtiPequena : TRBDEtiPequena;
begin
  LimpaComponentes(Q007Items,0);
  if Q007Items.Item = '1' then
  begin
    VpfDEtiPequena := TRBDEtiPequena(VprDEtiModelo1.EtiPequenas.Items[VprLacoProdutos]);
    L007Qtd.Caption := VpfDEtiPequena.Qtd;
    L007MM.Caption := VpfDEtiPequena.DesMM;
    L007Produto.Caption := VpfDEtiPequena.DesProduto;
    L007Barra.Caption := '/';
    inc(VprLacoProdutos);
  end;
end;

{******************************************************************************}
procedure TFImpOrcamento.Q008ItemsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  VpfDEtiPequena : TRBDEtiPequena;
begin
  LimpaComponentes(Q008Items,0);
  if Q008Items.Item = '1' then
  begin
    VpfDEtiPequena := TRBDEtiPequena(VprDEtiModelo1.EtiPequenas.Items[VprLacoProdutos]);
    L008Qtd.Caption := VpfDEtiPequena.Qtd;
    L008MM.Caption := VpfDEtiPequena.DesMM;
    L008Produto.Caption := VpfDEtiPequena.DesProduto ;
    L008Composicao.Caption := VpfDEtiPequena.DesComposicao ;
    L008Barra.Caption := '/';
    inc(VprLacoProdutos);
  end;
end;

{******************************************************************************}
procedure TFImpOrcamento.Q009ItemsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  VpfDEtiPequena : TRBDEtiPequena;
begin
  LimpaComponentes(Q009Items,0);
  if Q009Items.Item = '1' then
  begin
    VpfDEtiPequena := TRBDEtiPequena(VprDEtiModelo1.EtiPequenas.Items[VprLacoProdutos]);
    L009Empresa.Caption := 'CADARTEX LTDA';
    L009Produto.Caption:= VpfDEtiPequena.DesProduto + '/'+VpfDEtiPequena.Qtd + '/'+VpfDEtiPequena.DesMM;
    L009Referencia.Caption:= 'Ref: '+VpfDEtiPequena.DesReferencia;
    L009Cor.Caption :=  VpfDEtiPequena.DesCor;
    inc(VprLacoProdutos);
  end;

end;

{******************************************************************************}
procedure TFImpOrcamento.Q010ItemsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  VpfDEtiPequena : TRBDEtiPequena;
begin
  LimpaComponentes(Q010Items,0);
  if Q010Items.Item = '1' then
  begin
    VpfDEtiPequena := TRBDEtiPequena(VprDEtiModelo1.EtiPequenas.Items[VprLacoProdutos]);
    L010Filial.Caption := Varia.NomeFilial;
    L010Cliente.Caption := 'Cliente : ' + VprDEtiModelo1.NomCliente;
    L010OrdemCompra.Caption := 'OC : ' + VprDEtiModelo1.OrdemCompra;
    L010Data.Caption := 'Data : '+FormatDateTime('DD/MM/YYYY',Date);
    if VpfDEtiPequena.DesReferencia <> '' then
      L010Cor.Caption := 'Cor : '+VpfDEtiPequena.DesReferencia
    else
      L010Cor.Caption := 'Cor : '+VpfDEtiPequena.DesCor;
    L010Produto.Caption := 'Produto : '+ VpfDEtiPequena.DesProduto;
    L010Qtd.Caption := VpfDEtiPequena.Qtd;
    inc(VprLacoProdutos);
  end;
end;

{******************************************************************************}
procedure TFImpOrcamento.QRBand8BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  Vpfdescor :String;
begin
  L002NomProduto.Caption := MovOrcamentoNomPro.AsString;
  if MovOrcamentoC_PRO_REF.AsString <> '' then
  begin
    L002NomProduto.Caption := L002NomProduto.Caption + ' - '+MovOrcamentoC_PRO_REF.AsString;
  end;
  VpfDesCor := MovOrcamentoC_DES_COR.AsString;
  if Length(VpfDescor) > 21 then
  begin
    if not ExisteLetraString(' ',copy(VpfDesCor,1,22)) then
      insert(' ',Vpfdescor,15);
  end;
  L002DesCor.Caption := VpfDesCor;

end;

procedure TFImpOrcamento.Q013ItemsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  VpfDEtiPequena : TRBDEtiPequena;
begin
  LimpaComponentes(Q013Items,0);
  if Q013Items.Item = '1' then
  begin
    VpfDEtiPequena := TRBDEtiPequena(VprDEtiModelo1.EtiPequenas.Items[VprLacoProdutos]);
    L013Aprovado.caption := 'APROVADO';
    L013Filial.Caption := Varia.NomeFilial;
    L013Artigo.Caption := 'ARTIGO : '+ VpfDEtiPequena.DesProduto+ ' '+VpfDEtiPequena.DesMM;
    L013CORMARISOL.Caption :='COR MARISOL : '+DeleteAteChar(DeleteAteChar((CopiaAteChar(VpfDEtiPequena.DesCor,'(')),' '),' ');
    L013CorCompletaMarisol.Caption := CopiaAteChar(VpfDEtiPequena.DesCor,'(');
    L013CorCadartex.Caption := 'COR CADARTEX : '+DeletaChars(DeleteAteChar(VpfDEtiPequena.DesCor,'('),')');
    L013QUANTIDADE.Caption := 'QUANTIDADE : '+ VpfDEtiPequena.Qtd;
    L013PEDIDO.Caption := 'PEDIDO No : '+VpfDEtiPequena.DesOrdemCompra;
    L013CAPTIONDESTINO.Caption := 'DESTINO : ';
    L013DESTINO.Caption := VpfDEtiPequena.DesDestino;
    L013DATA.Caption := 'DATA : '+FormatDateTime('DD/MM/YYYY',Date);
    L013MM.Caption := 'No '+VpfDEtiPequena.DesMM;
    L013MODELO.Caption := 'MODELO';
    L013MODELOA.Caption := 'A';
    L013MODELOb.Caption := 'B';
    L013XModelo.Caption := 'X';
    L013ALGODAO.Caption := 'ALGODÃO';
    L013POLIESTER.Caption := 'POLIÉSTER';
    VpfDEtiPequena.DesProduto := uppercase(RetiraAcentuacao(VpfDEtiPequena.DesProduto));
    if ExistePalavra(VpfDEtiPequena.DesProduto,'ALGODAO') or ExistePalavra(VpfDEtiPequena.DesProduto,'ALG') or
       ExistePalavra(VpfDEtiPequena.DesProduto,'ALGODÃO') then
       L013XALGODAO.Caption := 'X'
    else
      if ExistePalavra(VpfDEtiPequena.DesProduto,'POLIESTER') or ExistePalavra(VpfDEtiPequena.DesProduto,'POL') or
         ExistePalavra(VpfDEtiPequena.DesProduto,'POLIÉSTER') or ExistePalavra(VpfDEtiPequena.DesProduto,'ELASTICO') OR
         ExistePalavra(VpfDEtiPequena.DesProduto,'ELASTICO') then
        L013XPOLIESTER.Caption := 'X';

    inc(VprLacoProdutos);
    MostrarLinhasEtiquetaAmostra(true);
  end
  else //não é para imprimir
  begin
    MostrarLinhasEtiquetaAmostra(false);
  end;


end;

{******************************************************************************}
procedure TFImpOrcamento.AcompanhamentoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := VprImprimirAcompanhamentoVisita;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImpOrcamento]);
end.
