unit AImpOrdemProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Qrctrls, QuickRpt, ExtCtrls, Geradores, UnDados, UnClientes,UnOrdemProducao, UnProdutos,
  qrBarcode, Db, DBTables, UnDadosProduto, UnSistema, DBClient, Tabela;

type
  TFImpOrdemProducao = class(TForm)
    Aux: TSQL;
    Rel003OpCadarco: TQuickRepNovo;
    OPCadarco: TSQL;
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
    QRShape77: TQRShape;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    procedure PosOPCadarco(VpaEmpFil,VpaSeqOrdem : String);
  public
    { Public declarations }
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


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

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

