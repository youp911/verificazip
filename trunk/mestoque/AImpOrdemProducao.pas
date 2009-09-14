unit AImpOrdemProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Qrctrls, QuickRpt, ExtCtrls, Geradores, UnDados, UnClientes,UnOrdemProducao, UnProdutos,
  qrBarcode, Db, DBTables, UnDadosProduto, UnSistema;

type
  TFImpOrdemProducao = class(TForm)
    R001OrdemProducao: TQuickRepNovo;
    QRStringsBand1: TQRStringsBand;
    Q001Borda: TQRShape;
    QRlabel1: TQRLabel;
    L001Op: TQRLabel;
    QRLabel2: TQRLabel;
    L001Pedido: TQRLabel;
    QRLabel3: TQRLabel;
    L001Data: TQRLabel;
    L001DatEntrega: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    L001Maquina: TQRLabel;
    L001Fitas: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape2: TQRShape;
    L001Produto: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel7: TQRLabel;
    L001MetrosTotal: TQRLabel;
    L001PerAcrescimo: TQRLabel;
    QRLabel11: TQRLabel;
    L001MetrosFita: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel10: TQRLabel;
    L001Largura: TQRLabel;
    L001Comprimento: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel13: TQRLabel;
    L001CompFigura: TQRLabel;
    QRLabel14: TQRLabel;
    L001TipoFundo: TQRLabel;
    QRLabel16: TQRLabel;
    L001TipoEmenda: TQRLabel;
    L001Engomagem: TQRLabel;
    QRLabel19: TQRLabel;
    L001Calandragem: TQRLabel;
    QRLabel21: TQRLabel;
    QRShape3: TQRShape;
    QRLabel17: TQRLabel;
    L001Numfios: TQRLabel;
    QRShape4: TQRShape;
    QRShape7: TQRShape;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    L001HorasProducao: TQRLabel;
    L001PrecoUnitario: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel28: TQRLabel;
    QRShape8: TQRShape;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRLabel40: TQRLabel;
    QRShape16: TQRShape;
    QRLabel41: TQRLabel;
    QRShape17: TQRShape;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    QRShape21: TQRShape;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel51: TQRLabel;
    QRShape22: TQRShape;
    L001MetrosFita2: TQRLabel;
    Q001Combinacoes: TQRMemo;
    QRLabel25: TQRLabel;
    L001OpCliente: TQRLabel;
    L001Observacao: TQRMemo;
    L001UMPedido: TQRLabel;
    QRLabel23: TQRLabel;
    Q001CodBarra: TQRAsBarcode;
    QuickRepNovo1: TQuickRepNovo;
    DetailBand1: TQRBand;
    QRAsBarcode1: TQRAsBarcode;
    QRAsBarcode2: TQRAsBarcode;
    QRAsBarcode3: TQRAsBarcode;
    QRAsBarcode4: TQRAsBarcode;
    QRAsBarcode5: TQRAsBarcode;
    R002ColetaOP: TQuickRepNovo;
    PageHeaderBand1: TQRBand;
    DetailBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRLabel22: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel24: TQRLabel;
    QRLabel27: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel52: TQRLabel;
    QRDBText4: TQRDBText;
    QRShape1: TQRShape;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    QRDBText6: TQRDBText;
    ColetaOP: TQuery;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRLabel55: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
    PageFooterBand1: TQRBand;
    QRLabel59: TQRLabel;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRLabel60: TQRLabel;
    QRDBText13: TQRDBText;
    QRLabel61: TQRLabel;
    QRDBText14: TQRDBText;
    QRLabel62: TQRLabel;
    QRShape6: TQRShape;
    QRShape5: TQRShape;
    QRShape23: TQRShape;
    QRLabel63: TQRLabel;
    QRDBText15: TQRDBText;
    QRLabel64: TQRLabel;
    L001Pente: TQRLabel;
    QRAsBarcode6: TQRAsBarcode;
    QRLabel66: TQRLabel;
    QRDBText23: TQRDBText;
    Rel004RomaneioFaturamento: TQuickRepNovo;
    QRBand1: TQRBand;
    QRShape47: TQRShape;
    QRLabel77: TQRLabel;
    L004DatColeta: TQRLabel;
    QRShape48: TQRShape;
    QRLabel79: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel82: TQRLabel;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    QRLabel85: TQRLabel;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    QRLabel88: TQRLabel;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRShape57: TQRShape;
    QRBand2: TQRBand;
    QRShape58: TQRShape;
    QRDBText29: TQRDBText;
    QRDBText30: TQRDBText;
    QRShape59: TQRShape;
    QRShape60: TQRShape;
    QRShape61: TQRShape;
    QRShape62: TQRShape;
    QRShape63: TQRShape;
    QRShape64: TQRShape;
    QRShape65: TQRShape;
    QRShape66: TQRShape;
    QRShape67: TQRShape;
    QRShape68: TQRShape;
    QRBand3: TQRBand;
    QRShape69: TQRShape;
    QRSysData3: TQRSysData;
    QRSysData4: TQRSysData;
    QRDBText31: TQRDBText;
    RomaneioFaturamento: TQuery;
    QRDBText32: TQRDBText;
    L004Combinacoes: TQRLabel;
    L004Manequins: TQRLabel;
    SummaryBand1: TQRBand;
    L004NumFitas: TQRLabel;
    L004MetFita: TQRLabel;
    L004TotKm: TQRLabel;
    L004ValTotal: TQRLabel;
    QRShape70: TQRShape;
    QRShape71: TQRShape;
    L004TotalGeralKM: TQRLabel;
    L004ValTotalGeral: TQRLabel;
    QRShape72: TQRShape;
    QRShape73: TQRShape;
    QRLabel78: TQRLabel;
    L004Icms: TQRLabel;
    L002Emenda: TQRLabel;
    Aux: TQuery;
    Rel003OpCadarco: TQuickRepNovo;
    OPCadarco: TQuery;
    TitleBand1: TQRBand;
    L003Detalhes: TQRBand;
    SummaryBand2: TQRBand;
    QRLabel65: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText16: TQRDBText;
    QRLabel67: TQRLabel;
    L003TipEspula: TQRLabel;
    QRDBText17: TQRDBText;
    L003NomProduto: TQRDBText;
    L003TipFio: TQRLabel;
    QRDBText20: TQRDBText;
    L003Cor: TQRLabel;
    QRDBText21: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    L003Enchimento: TQRDBText;
    QRDBText27: TQRDBText;
    L003NumTabuas: TQRLabel;
    QRShape24: TQRShape;
    QRLabel68: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel70: TQRLabel;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRLabel71: TQRLabel;
    QRShape28: TQRShape;
    QRLabel72: TQRLabel;
    QRLabel73: TQRLabel;
    QRShape29: TQRShape;
    QRLabel74: TQRLabel;
    QRShape30: TQRShape;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRLabel89: TQRLabel;
    QRLabel90: TQRLabel;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRLabel91: TQRLabel;
    QRShape35: TQRShape;
    QRShape36: TQRShape;
    QRShape37: TQRShape;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRShape46: TQRShape;
    QRShape74: TQRShape;
    QRShape75: TQRShape;
    QRShape76: TQRShape;
    QRLabel92: TQRLabel;
    QRDBText19: TQRDBText;
    QRLabel93: TQRLabel;
    QRDBText28: TQRDBText;
    QRDBText33: TQRDBText;
    QRLabel94: TQRLabel;
    QRDBText34: TQRDBText;
    QRLabel95: TQRLabel;
    QRLabel96: TQRLabel;
    QRLabel97: TQRLabel;
    L003DesObservacao: TQRDBText;
    QRLabel98: TQRLabel;
    QRDBText36: TQRDBText;
    QRLabel99: TQRLabel;
    L001Faturar: TQRLabel;
    L001Reprogramacao: TQRLabel;
    L001BatidasTear: TQRLabel;
    QRLabel101: TQRLabel;
    L004SeqRomaneio: TQRLabel;
    QRLabel100: TQRLabel;
    L001ProdutoNovo: TQRLabel;
    QRLabel102: TQRLabel;
    L001TipoCorte: TQRLabel;
    L001Engrenagem: TQRLabel;
    QRLabel103: TQRLabel;
    QRDBText18: TQRDBText;
    SummaryBand3: TQRBand;
    Q001MetrosCombinacaoTearH: TQRMemo;
    QRShape77: TQRShape;
    QRLabel104: TQRLabel;
    L002TipoPedido: TQRLabel;
    QRLabel105: TQRLabel;
    L001Prateleira: TQRLabel;
    QRLabel106: TQRLabel;
    QRLabel107: TQRLabel;
    QRDBText26: TQRDBText;
    QRDBText35: TQRDBText;
    QRLabel108: TQRLabel;
    L001BatProduto: TQRLabel;
    QRLabel110: TQRLabel;
    L001Sumula: TQRLabel;
    QRLabel4: TQRLabel;
    L001Programador: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRStringsBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure L003DetalhesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    FunOrdem : TRBFuncoesOrdemProducao;
    FunProduto : TFuncoesProduto;
    VprDProduto : TRBDProduto;
    VprDOrdemProducao : TRBDOrdemProducaoEtiqueta;
    VprCodCombinacao,
    VprNumFitas : Integer;
    VprCombinacoes, VprManequins : String;
    VprTotalKm,
    VprMetFita,
    VprValTotal,
    VprTotalGeralKM : Double;
    VprSegundaCombinacao : Boolean;
    function REspula(VpaNumEspulas : Integer) : String;
    function RMetrosFitaManequim(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaLacoInicio,VpaLacoFim : Integer):String;
    function RNomEmenda(VpaCodEmenda : String) : String;
    procedure CarManequinsOPConvencional(VpaDordemProducao : TRBDOrdemProducaoEtiqueta);
    procedure CarCombinacoesOPH(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
    procedure CarCombinacoesOPConvencional(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
    procedure CarMetrosCombinacaoOPH(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
    procedure CarDRelatorio(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
    procedure PosicionaColetaOP(VpaEmpfil, VpaSeqOrdem, VpaSeqColeta : String);
    procedure PosRomaneiFaturamento(VpaEmpFil, VpaSeqRomaneio : String);
    procedure PosOPCadarco(VpaEmpFil,VpaSeqOrdem : String);
  public
    { Public declarations }
    procedure ImprimeOP(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaVisualizar : Boolean);
    procedure ImprimeColeaOP(VpaEmpfil, VpaSeqOrdem, VpaSeqColeta : String;VpaVisualizar : Boolean);
    procedure ImprimeRomaneioFaturamento(VpaDatRomaneio : TDateTime; VpaEmpFil, VpaSeqRomaneio : String);
    procedure ImprimeOPEspulaCadarco(VpaEmpFil,VpaSeqOrdem : String);
  end;

var
  FImpOrdemProducao: TFImpOrdemProducao;


implementation

Uses FunData, APrincipal, Constantes, funString, FunSql, FunNumeros, Constmsg;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFImpOrdemProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdem := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
  FunProduto := TFuncoesProduto.criar(nil,FPrincipal.BaseDados);
  VprDProduto := TRBDProduto.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImpOrdemProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdem.free;
  FunProduto.free;
  VprDProduto.free;
  Action := CaFree;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.CarDRelatorio(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
begin
  VprDProduto.CodEmpresa := varia.CodigoEmpresa;
  VprDProduto.CodEmpFil := VpaDOrdemProducao.CodEmpresafilial;
  VprDProduto.SeqProduto := VpaDOrdemProducao.SeqProduto;
  FunProduto.CarDProduto(VprDProduto);
  FunProduto.CarDCombinacao(VprDProduto);
  with VpaDOrdemProducao do
  begin
    L001Op.Caption := IntToStr(SeqOrdem);
    Q001CodBarra.Text := IntToStr(SeqOrdem);
    L001OpCliente.Caption := IntToStr(NroOPCliente);
    L001Pedido.Caption := IntToStr(NumPedido);
    L001Data.Caption := FormatDateTime('DD/MM/YYYY',DatEmissao);
    L001Programador.Caption := Sistema.RNomUsuario(VpaDOrdemProducao.CodProgramador);
    L001DatEntrega.Caption := FormatDateTime('DD/MM/YYYY',DatEntregaPrevista);
{   foi tirado o campo cliente para colocar 2 campos de data de entrega.
    if CodCliente <> 0 then
      L001Cliente.Caption := IntToStr(CodCliente) +' - '+ FunCliente.RNomCliente(IntToStr(CodCliente))
    else
      L001Cliente.Caption := '';}
    L001Maquina.Caption := IntToStr(CodMaquina) +' - ' +FunOrdem.RNomeMaquina(IntToStr(CodMaquina));
    L001Fitas.Caption := IntToStr(QtdFita);
    L001MetrosTotal.Caption := FloattoStr(TotMetros);
    L001PerAcrescimo.Caption := IntToStr(PerAcrescimo);
    L001MetrosFita.Caption := FloattoStr(MetFita);
    L001Produto.Caption := CodProduto+' - '+VprDProduto.NomProduto;
    L001Largura.Caption := IntToStr(VprDProduto.LarProduto);
    L001Comprimento.Caption := IntToStr(VprDProduto.CmpProduto);
    L001CompFigura.Caption := IntToStr(VprDProduto.CmpFigura);
    L001TipoCorte.Caption := IntToStr(CodTipoCorte)+ ' - '+FunProduto.RNomeTipoCorte(CodTipoCorte);
    if VprDProduto.CodTipoFundo <> 0 then
      L001TipoFundo.Caption := IntToStr(VprDProduto.CodTipoFundo) +' - ' + FunProduto.RNomeFundo(IntToStr(VprDProduto.CodTipoFundo))
    else
      L001TipoFundo.Caption := '';
    L001Calandragem.Caption := VprDProduto.IndCalandragem;
    if VprDProduto.CodTipoEmenda <> 0 then
      L001TipoEmenda.Caption := IntToStr(VprDProduto.CodTipoEmenda) + ' - '+ FunProduto.RNomeTipoEmenda(IntToStr(VprDProduto.CodTipoEmenda))
    else
      L001TipoEmenda.Caption := '';
    L001Pente.Caption := VprDProduto.Pente;
    L001BatProduto.Caption := VprDProduto.BatProduto;
    L001Engrenagem.Caption := VprDProduto.Engrenagem;
    L001Engomagem.Caption := VprDProduto.IndEngomagem;
    L001BatidasTear.Caption := VprDProduto.NumBatidasTear;
    L001Numfios.Caption := VprDProduto.NumFios;
    L001HorasProducao.Caption := VpaDOrdemProducao.HorProducao;
    L001PrecoUnitario.Caption := FormatFloat('R$ ###,###,##0.00',VpaDOrdemProducao.ValUnitario);
    L001MetrosFita2.Caption := FloattoStr(MetFita) + ' MTS';
    L001Observacao.Lines.Text := 'OBS :   '+VpaDOrdemProducao.DesObservacoes;
    L001UMPedido.Caption := VpaDOrdemProducao.UMPedido;
    L001ProdutoNovo.Caption := VpaDOrdemProducao.IndProdutoNovo;
    L001Prateleira.Caption := VprDProduto.PraProduto;
    if VpaDOrdemProducao.TipPedido = 4 then
      L001Reprogramacao.Caption := 'PEDIDO DE ESTOQUE - NÃO PRODUZIR'
    else
      if VpaDOrdemProducao.TipPedido > 1 then
        L001Reprogramacao.Caption := 'Reprogramação'
      else
        L001Reprogramacao.Caption := '';
    if VpaDOrdemProducao.TipPedido in [0,3] then
      L001Faturar.Caption := 'N'
    else
      L001Faturar.Caption := 'S';
    if TipPedido = 0 then
      L001Sumula.Caption := 'A '+IntToStr(VprDProduto.CodSumula)
    else
      if TipPedido = 1 then
        L001Sumula.Caption := 'V '+IntToStr(VprDProduto.CodSumula)
      else
        L001Sumula.Caption := IntToStr(VprDProduto.CodSumula);

  end;
  if VpaDOrdemProducao.TipTear = 0 then
  begin
    CarCombinacoesOPConvencional(VpaDOrdemProducao);
    CarManequinsOPConvencional(VpaDOrdemProducao);
  end
  else
  begin
    L001MetrosFita2.caption := '';
    CarCombinacoesOPH(VpaDOrdemProducao);
    CarManequinsOPConvencional(VpaDOrdemProducao);
  end;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.PosicionaColetaOP(VpaEmpfil, VpaSeqOrdem, VpaSeqColeta : String);
begin
  AdicionaSQLAbreTabela(ColetaOP,'select OP.SEQORD, OP.CODPRO, OP.ORDCLI, OP.NUMPED,  OP.CODMAQ, OP.UNMPED,'+
                                 ' OP.DATENP, OP.TIPPED, '+ 
                                 ' PRO.CODEME, PRO.INDCAL, PRO.INDENG, PRO.I_LRG_PRO, PRO.I_CMP_PRO, '+
                                 ' COP.INDFIN, COP.INDREP, COP.QTDTOT,'+
                                 ' CIT.METCOL, CIT.NROFIT, CIT.CODCOM, CIT.CODMAN '+
                                 ' from  COLETAOPCORPO COP, ORDEMPRODUCAOCORPO OP, CADPRODUTOS PRO,  COLETAOPITEM CIT '+
                                 ' WHERE COP.EMPFIL = OP.EMPFIL '+
                                 ' AND COP.SEQORD = OP.SEQORD '+
                                 ' AND COP.EMPFIL = CIT.EMPFIL '+
                                 ' AND COP.SEQORD = CIT.SEQORD '+
                                 ' AND COP.SEQCOL = CIT.SEQCOL '+
                                 ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                                 ' AND COP.EMPFIL = ' + VpaEmpfil +
                                 ' AND COP.SEQORD = '+ VpaSeqOrdem +
                                 ' AND COP.SEQCOL = '+ VpaSeqColeta);
end;

{******************************************************************************}
procedure TFImpOrdemProducao.PosRomaneiFaturamento(VpaEmpFil, VpaSeqRomaneio : String);
begin
  AdicionaSQLAbreTabela(RomaneioFaturamento,'select PRO.C_NOM_PRO, ' +
                                       ' OP.NUMPED, OP.CODPRO, OP.VALUNI, OP.TIPTEA, OP.SEQORD, '+
                                       ' OPI.CODCOM, OPI.CODMAN, OPI.NROFIT, OPI.METCOL, (OPI.METCOL * OPI.NROFIT) / 1000 TOTALKM '+
                                       ' from ORDEMPRODUCAOCORPO OP, COLETAOPITEM opi, CADPRODUTOS PRO, ROMANEIOITEM RIT '+
                                       ' WHERE OPI.EMPFIL = OP.EMPFIL '+
                                       ' AND OPI.SEQORD = OP.SEQORD '+
                                       ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                                       ' AND RIT.EMPFIL = OPI.EMPFIL '+
                                       ' AND RIT.SEQORD = OPI.SEQORD '+
                                       ' AND RIT.SEQCOL = OPI.SEQCOL '+
                                       ' AND RIT.EMPFIL = '+VpaEmpFil+
                                       ' and rit.SEQROM = '+VpaSeqRomaneio+
                                       ' order by OP.NUMPED, OPI.CODCOM, OPI.CODMAN');
end;

{******************************************************************************}
procedure TFImpOrdemProducao.PosOPCadarco(VpaEmpFil,VpaSeqOrdem : String);
begin
  AdicionaSQLAbreTabela(OPCadarco,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, ' +
                                  ' OP.TIPPED, OP.DATEMI, OP.DATENP, OP.SEQORD, OP.DESOBS,' +
                                  ' ITE.QTDMET, ITE.INDALG, ITE.INDPOL, ITE.GROPRO, ITE.CODCOR, ITE.DESENG, '+
                                  ' ITE.QTDFUS, ITE.NROFIO, ITE.TITFIO, ITE.DESENC, ITE.NUMTAB, ITE.NROMAQ, '+
                                  ' PRO.C_NOM_PRO, '+
                                  ' USU.I_COD_USU, USU.C_NOM_USU '+
                                  ' from ORDEMPRODUCAOCORPO OP, OPITEMCADARCO ITE, CADCLIENTES CLI, CADPRODUTOS PRO, CADUSUARIOS USU '+
                                  ' WHERE OP.EMPFIL = ITE.EMPFIL '+
                                  ' AND OP.SEQORD = ITE.SEQORD '+
                                  ' AND OP.CODCLI = CLI.I_COD_CLI '+
                                  ' AND ITE.SEQPRO = PRO.I_SEQ_PRO '+
                                  ' AND OP.CODUSU = USU.I_COD_USU '+
                                  ' and OP.EMPFIL = '+ VpaEmpFil+
                                  ' AND OP.SEQORD = '+ VpaSeqOrdem+
                                  ' ORDER BY SEQITE');
end;

{******************************************************************************}
function TFImpOrdemProducao.REspula(VpaNumEspulas : Integer) : String;
begin
  if VpaNumEspulas > 1 then
    result := ' X '+IntToStr(VpaNumEspulas)
  else
    result := '';
end;

{******************************************************************************}
function TFImpOrdemProducao.RMetrosFitaManequim(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaLacoInicio,VpaLacoFim : Integer):String;
var
  VpfLaco : Integer;
begin
  result := '';
  for VpfLaco := VpaLacoInicio to VpaLacoFim do
    result  := result + AdicionaCharD(' ',AdicionaCharDE(' ',FloatToStr(TRBDOrdemProducaoItem(VpaDOrdemProducao.Items.Items[VpfLaco]).MetrosFita),8),3);
end;

{******************************************************************************}
function TFImpOrdemProducao.RNomEmenda(VpaCodEmenda : String) : String;
begin
  result := '';
  if (VpaCodEmenda <> '') and  (VpaCodEmenda <> '0') then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from TIPOEMENDA '+
                              'Where CODEME = '+VpaCodEmenda);
    result := Aux.FieldByName('NOMEME').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.CarManequinsOPConvencional(VpaDordemProducao : TRBDOrdemProducaoEtiqueta);
var
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco, VpfLacoInicio, VpfCodCombAnt, VpfQtdManequins : Integer;
  VpfLinha : String;
begin
  VpfQtdManequins := 0;
  VpfLacoInicio := 0;
  VpfCodCombAnt := TRBDOrdemProducaoItem(VpaDordemProducao.Items.Items[0]).CodCombinacao ;
//  VpfLinha := AdicionaCharD(' ',InttoStr(VpfCodCombAnt),2);
  for VpfLaco := 0 to VpaDordemProducao.Items.Count - 1 do
  begin
    VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDordemProducao.Items.Items[VpfLaco]) ;
    if (VpfDOrdemItem.CodManequim = '') then
      exit;

    if (VpfQtdManequins > 4) or (VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt) then
    begin
      Q001Combinacoes.Lines.Add('');
      Q001Combinacoes.Lines.Add('');
      Q001Combinacoes.Lines.Add(VpfLinha);
      VpfQtdManequins := 0;
      Q001Combinacoes.Lines.Add(RMetrosFitaManequim(VpaDordemProducao,VpfLacoInicio,VpfLaco-1));
      VpfLacoInicio := VpfLaco;
      VpfLinha := '';
      if (VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt) then
        break;
    end;

    VpfLinha := VpfLinha + AdicionaCharD(' ',AdicionaCharDE(' ',VpfDOrdemItem.CodManequim,8),3);
    inc(VpfQtdManequins);
  end;
  if (Vpflaco >= VpaDordemProducao.Items.Count) then
    dec(VpfLaco);
  if VpfLinha <> '' then
  begin
      Q001Combinacoes.Lines.Add('');
      Q001Combinacoes.Lines.Add('');
      Q001Combinacoes.Lines.Add(VpfLinha);
      VpfLinha := '';
      Q001Combinacoes.Lines.Add(RMetrosFitaManequim(VpaDordemProducao,VpfLacoInicio,vpflaco));
  end;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.CarCombinacoesOPH(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
var
  VpfDCombinacao : TRBDCombinacao;
  vpfDCombinacaoFigura : TRBDCombinacaoFigura;
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco, VpfLacoFigura, VpfCodCombAnt : Integer;
  VpfQtdPecas : String;
begin
  VpfCodCombAnt := 0;
  Q001Combinacoes.Lines.clear;
  Q001Combinacoes.Lines.Add('CB Fts Cor       Título  Fundo  Qtdade(PC)');
  for VpfLaco := 0 to VpaDOrdemProducao.Items.Count - 1 do
  begin
    VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOrdemProducao.Items.Items[VpfLaco]);
    if VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt then
    begin
      if VpfLaco <> 0 then
        Q001Combinacoes.Lines.Add('');
      VpfDCombinacao := FunProduto.RCombinacao(VprDProduto,VpfDOrdemItem.CodCombinacao);
      if VpfDOrdemItem.CodManequim = '' then
        VpfQtdPecas := FormatFloat('0',VpfDOrdemItem.MetrosFita)
      else
        VpfQtdPecas := '';
      //urdume
      Q001Combinacoes.Lines.Add(AdicionaBrancoD( AdicionaBrancoD(AdicionaBrancoE(IntToStr(VpfDCombinacao.CodCombinacao),2),4)+AdicionaBrancoD(IntToStr(VpfDOrdemItem.QtdFitas),3)+
                              AdicionaBrancoD(VpfDCombinacao.CorFundo1,4)+ ' URD ',19) +
                              AdicionaBrancoD(VpfDCombinacao.TituloFundo1+REspula(VpfDCombinacao.Espula1),6)+ AdicionaCharD(' ',''{IntToStr(VpfDCombinacao.CorCartela)},5)+AdicionaCharE(' ',VpfQtdPecas,9));
      if VpfDCombinacao.CorUrdumeFigura <> '' then         //urdume Figura
        Q001Combinacoes.Lines.Add( AdicionaBrancoD('',7)+ AdicionaBrancoD(VpfDCombinacao.CorUrdumeFigura,6)+ 'URD2'+
                              AdicionaBrancoD(VpfDCombinacao.TituloFundoFigura+REspula(VpfDCombinacao.EspulaUrdumeFigura),9));

      //trama
      Q001Combinacoes.Lines.Add( AdicionaBrancoD('',7)+ AdicionaBrancoD(VpfDCombinacao.CorFundo2,10)+
                              AdicionaBrancoD(VpfDCombinacao.TituloFundo2+REspula(VpfDCombinacao.Espula2),9));
      for VpfLacoFigura := 0 to VpfDCombinacao.Figuras.Count - 1 do
      begin
        vpfDCombinacaoFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);
        Q001Combinacoes.Lines.Add( AdicionaBrancoD('',7)+ AdicionaBrancoD(vpfDCombinacaoFigura.CodCor,10)+
                                AdicionaBrancoD(vpfDCombinacaoFigura.TitFio+REspula(vpfDCombinacaoFigura.NumEspula),9));

      end;
      VpfCodCombAnt := VpfDOrdemItem.CodCombinacao;
    end;
  end;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.CarCombinacoesOPConvencional(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
var
  VpfDCombinacao : TRBDCombinacao;
  vpfDCombinacaoFigura : TRBDCombinacaoFigura;
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco, VpfLacoFigura, VpfCodCombAnt,VpfQtdEtiquetas : Integer;
begin
  VpfCodCombAnt := 0;
  VpfQtdEtiquetas := 0;
  Q001Combinacoes.Lines.clear;
  Q001Combinacoes.Lines.Add('CB  Fitas  Cor              Título   Fundo');
  for VpfLaco := 0 to VpaDOrdemProducao.Items.Count - 1 do
  begin
    VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOrdemProducao.Items.Items[VpfLaco]);
    if VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt then
    begin
      if VpfLaco <> 0 then
      begin
        Q001Combinacoes.Lines.Add('');
        Q001Combinacoes.Lines.Add('   QTD = '+IntToStr(VpfQtdEtiquetas));
        VpfQtdEtiquetas := 0;
      end;
      VpfDCombinacao := FunProduto.RCombinacao(VprDProduto,VpfDOrdemItem.CodCombinacao);
      //urdume
      Q001Combinacoes.Lines.Add( AdicionaBrancoD(AdicionaBrancoE(IntToStr(VpfDCombinacao.CodCombinacao),2),7)+AdicionaBrancoD(IntToStr(VpfDOrdemItem.QtdFitas),4)+
                              AdicionaBrancoD(VpfDCombinacao.CorFundo1,9)+ ' URDUME ' +
                              AdicionaBrancoD(VpfDCombinacao.TituloFundo1+REspula(VpfDCombinacao.Espula1),10)+IntToStr(VpfDCombinacao.CorCartela));
      IF VpfDCombinacao.CorUrdumeFigura <> '' then
        //trama
        Q001Combinacoes.Lines.Add( AdicionaBrancoD('',11)+ AdicionaBrancoD(VpfDCombinacao.CorUrdumeFigura,8)+'URDUMEFI '+
                                AdicionaBrancoD(VpfDCombinacao.TituloFundoFigura+REspula(VpfDCombinacao.EspulaUrdumeFigura),12));

      //trama
      Q001Combinacoes.Lines.Add( AdicionaBrancoD('',11)+ AdicionaBrancoD(VpfDCombinacao.CorFundo2,17)+
                              AdicionaBrancoD(VpfDCombinacao.TituloFundo2+REspula(VpfDCombinacao.Espula2),12));
      for VpfLacoFigura := 0 to VpfDCombinacao.Figuras.Count - 1 do
      begin
        vpfDCombinacaoFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);
        Q001Combinacoes.Lines.Add( AdicionaBrancoD('',11)+ AdicionaBrancoD(vpfDCombinacaoFigura.CodCor,17)+
                                AdicionaBrancoD(vpfDCombinacaoFigura.TitFio+REspula(vpfDCombinacaoFigura.NumEspula),12));

      end;
      VpfCodCombAnt := VpfDOrdemItem.CodCombinacao;
    end;
    VpfQtdEtiquetas := VpfQtdEtiquetas + VpfDOrdemItem.QtdEtiquetas;
  end;
  Q001Combinacoes.Lines.Add('   QTD = '+IntToStr(VpfQtdEtiquetas));
end;

{******************************************************************************}
procedure TFImpOrdemProducao.CarMetrosCombinacaoOPH(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta);
var
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco : Integer;
begin
  Q001MetrosCombinacaoTearH.Lines.clear;
  Q001MetrosCombinacaoTearH.Lines.Add('CB    Manequim     Metros por Fita    Qtd Fitas');
  for VpfLaco := 0 to VpaDOrdemProducao.Items.Count - 1 do
  begin
    VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOrdemProducao.Items.Items[VpfLaco]);
    Q001MetrosCombinacaoTearH.Lines.Add(AdicionaCharE(' ',IntTosTr(VpfDOrdemItem.CodCombinacao),2)+'     '+AdicionaCharD(' ',VpfDOrdemItem.CodManequim, 12)+
                                        AdicionaCharE(' ',FormatFloat('##,##0.00',((VpfDOrdemItem.MetrosFita * VprDProduto.CmpProduto)/1000)),15)+'    '+AdicionaCharE(' ',IntTostr(VpfDOrdemItem.QtdFitas),9));
  end;


end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImpOrdemProducao.ImprimeOP(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaVisualizar : Boolean);
begin
  VprDOrdemProducao := VpaDOrdemProducao;
  CarDRelatorio(VpaDOrdemProducao);
  if VpaVisualizar then
    R001OrdemProducao.Preview
  else
    R001OrdemProducao.Print;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.ImprimeColeaOP(VpaEmpfil, VpaSeqOrdem, VpaSeqColeta : String;VpaVisualizar : Boolean);
begin
  R002ColetaOP.ReportTitle := 'Impressão da coleta "'+VpaSeqColeta+ '" da OP "'+VpaSeqOrdem+'".';
  PosicionaColetaOP(VpaEmpfil,VpaSeqOrdem,VpaSeqColeta);
  if VpaVisualizar then
    R002ColetaOP.Preview
  else
    R002ColetaOP.Print;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.ImprimeRomaneioFaturamento(VpaDatRomaneio : TDateTime;VpaEmpFil, VpaSeqRomaneio : String);
begin
  VprCombinacoes := '';
  VprManequins :='';
  VprCodCombinacao := 0;
  VprTotalKm := 0;
  VprMetFita := 0;
  VprNumFitas := 0;
  VprValTotal := 0;
  VprTotalGeralKM := 0;
  VprSegundaCombinacao := false;
  L004DatColeta.Caption := 'Data : '+FormatDateTime('DD/MM/YYYY',VpaDatRomaneio);
  L004SeqRomaneio.Caption := 'Romaneio : '+ VpaSeqRomaneio;
  PosRomaneiFaturamento(VpaEmpFil, VpaSeqRomaneio);
  Rel004RomaneioFaturamento.Preview
end;

{******************************************************************************}
procedure TFImpOrdemProducao.ImprimeOPEspulaCadarco(VpaEmpFil,VpaSeqOrdem : String);
begin
  PosOPCadarco(VpaEmpFil,VpaSeqOrdem);
  Rel003OpCadarco.Preview;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.QRStringsBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Q001Combinacoes.Height := (Q001Combinacoes.Lines.Count * 17);
  if (Q001Combinacoes.Top + Q001Combinacoes.Height -5) > 487 then
    L001MetrosFita2.Top := Q001Combinacoes.Top + Q001Combinacoes.Height - 5;
  L001Reprogramacao.Top := L001MetrosFita2.Top;
  Q001Borda.Height := L001MetrosFita2.Top + 25;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.L003DetalhesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //
  if OPCadarco.FieldByName('CODCOR').AsInteger <> 0 then
    L003Cor.Caption := FunProduto.RNomeCor(OPCadarco.FieldByName('CODCOR').AsString)
  else
    L003Cor.Caption := '';

  L003NumTabuas.Caption := FunOrdem.RNumTabuasExtenso(OPCadarco.FieldByName('TIPPED').AsInteger,OPCadarco.FieldByName('NUMTAB').AsFloat,OPCadarco.FieldByName('QTDMET').AsFloat);
  if OPCadarco.FieldByName('INDALG').AsString = 'S' then
    L003TipFio.Caption := 'Algodão'
  else
    if OPCadarco.FieldByName('INDPOL').AsString = 'S' then
      L003TipFio.Caption := 'Poliéster'
    else
      L003TipFio.Caption := '';
end;

{******************************************************************************}
procedure TFImpOrdemProducao.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  VpfNumPedido, VpfSeqOrdemProducao : Integer;
  VpfValUnitario : Double;
  VpfNumFitasPedido : Integer;
begin
  VpfValUnitario := RomaneioFaturamento.FieldByName('VALUNI').AsFloat;
  VprTotalKm := VprTotalKm + (RomaneioFaturamento.FieldByName('METCOL').AsFloat * RomaneioFaturamento.FieldByName('NROFIT').AsInteger) /1000;
  if (RomaneioFaturamento.FieldByName('TIPTEA').AsInteger in [0,1]) then
  begin
    if ((VprCodCombinacao = RomaneioFaturamento.FieldByName('CODCOM').AsInteger) or
       (VprCodCombinacao = 0)) and not(VprSegundaCombinacao) then
      VprMetFita := VprMetFita + RomaneioFaturamento.FieldByName('METCOL').AsFloat;
  end
  else
    VprMetFita := VprMetFita + RomaneioFaturamento.FieldByName('METCOL').AsFloat; //tear H sempre soma os metros porque as combinações não rodam paralelamente

  if VprCodCombinacao <> RomaneioFaturamento.FieldByName('CODCOM').AsInteger then
  begin
    if VprCodCombinacao <> 0 then
      VprSegundaCombinacao := true;
    VprCodCombinacao := RomaneioFaturamento.FieldByName('CODCOM').AsInteger;
    if RomaneioFaturamento.FieldByName('TIPTEA').AsInteger in [0,1] then //tear convencional
      VprNumFitas := VprNumFitas + RomaneioFaturamento.FieldByName('NROFIT').AsInteger
    else
      VprNumFitas := RomaneioFaturamento.FieldByName('NROFIT').AsInteger; //tear H não soma o número de fitas porque as combinações não correm paralelamente.
    VprCombinacoes := VprCombinacoes + RomaneioFaturamento.FieldByName('CODCOM').AsString + ', ';
  end;

  if RomaneioFaturamento.FieldByName('CODMAN').AsString <> '' then
    VprManequins := VprManequins + RomaneioFaturamento.FieldByName('CODMAN').AsString+ ', ';

  VpfNumPedido := RomaneioFaturamento.FieldByName('NUMPED').AsInteger;
  VpfNumFitasPedido := RomaneioFaturamento.FieldByName('NROFIT').AsInteger;
  VpfSeqOrdemProducao := RomaneioFaturamento.FieldByName('SEQORD').AsInteger;
  RomaneioFaturamento.Next;

  if (VpfNumPedido  <> RomaneioFaturamento.FieldByName('NUMPED').AsInteger) or
     ( VprCodCombinacao <> RomaneioFaturamento.FieldByName('CODCOM').AsInteger) or
     (VpfNumFitasPedido <> RomaneioFaturamento.FieldByName('NROFIT').AsInteger ) or
     (VpfSeqOrdemProducao <> RomaneioFaturamento.FieldByName('SEQORD').AsInteger) or (RomaneioFaturamento.Eof) then
  begin
   PrintBand := true;
   L004Combinacoes.Caption := copy(VprCombinacoes,1,length(VprCombinacoes)-2);
   if length(VprManequins) >= 30 then
     L004Manequins.Caption := 'Vários'
   else
     L004Manequins.Caption := copy(VprManequins,1,length(VprManequins)-2);
   L004NumFitas.Caption := IntToStr(VprNumFitas);
   L004MetFita.Caption := FormatFloat('###,###,##0.00',VprMetFita);
   L004TotKm.Caption := FormatFloat(varia.mascaraqtd,VprTotalKm);
   L004ValTotal.Caption := FormatFloat('###,###,##0.00',ArredondaDecimais(VprTotalKm,3) * VpfValUnitario);
   VprValTotal := VprValTotal +(ArredondaDecimais(VprTotalKm,4) * VpfValUnitario);
   VprTotalGeralKM := VprTotalGeralKM + VprTotalKm;
   VprCombinacoes := '';
   VprManequins :='';
   VprCodCombinacao := 0;
   VprNumFitas := 0;
   VprMetFita := 0;
   VprTotalKm := 0;
   VprSegundaCombinacao := false;
  end
  else
    PrintBand := false;
  if not RomaneioFaturamento.eof then
    RomaneioFaturamento.prior;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.SummaryBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  VprCombinacoes := '';
  VprManequins := '';
  VprTotalKM := 0;
  VprMetFita := 0;
  VprCodCombinacao := 0;
  VprValTotal := 0;
  VprTotalGeralKM := 0;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  L004TotalGeralKM.Caption := FormatFloat('###,##0.00',VprTotalGeralKM);
  L004ValTotalGeral.Caption := FormatFloat('###,###,##0.00',VprValTotal);
  L004Icms.Caption := FormatFloat('###,###,##0.00',(VprValTotal *17)/100);
end;

{******************************************************************************}
procedure TFImpOrdemProducao.PageHeaderBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  L002Emenda.Caption := RNomEmenda(ColetaOP.FieldByName('CODEME').AsString );
  case ColetaOP.FieldByName('TIPPED').AsInteger of
    0 : L002TipoPedido.Caption := 'Amostra';
    1 : L002TipoPedido.Caption := 'Venda';
    2 : L002TipoPedido.Caption := 'Reprogramação Faturar';
    3 : L002TipoPedido.Caption := 'Reprogramação NÃO Faturar';
    4 : L002TipoPedido.Caption := 'Pedido de Estoque';
  else
    L002TipoPedido.Caption := '';
  end;
end;

procedure TFImpOrdemProducao.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  case OPCadarco.FieldByName('TIPPED').AsInteger of
    0 : L003TipEspula.Caption := 'ESPULA GRANDE';
    1 : L003TipEspula.Caption := 'ESPULA PEQUENA';
    2 : L003TipEspula.Caption := 'ESPULA TRANSILIN';
  end;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.SummaryBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  printBand := VprDOrdemProducao.TipTear = 1; //tear H;
  if printBand then
  begin
    CarMetrosCombinacaoOPH(VprDOrdemProducao);
    Q001MetrosCombinacaoTearH.Height := Q001MetrosCombinacaoTearH.Lines.Count * 16; 
  end;
end;

{******************************************************************************}
procedure TFImpOrdemProducao.SummaryBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  VpfTexto : TStringList;
begin
  VpfTexto := TStringList.create;
  VpfTexto.text := OPCadarco.FieldByName('DESOBS').AsString;
  L003DesObservacao.Height := VpfTexto.count *17;
  SummaryBand2.Height := 60 + L003DesObservacao.Height;
  VpfTexto.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImpOrdemProducao]);
end.

