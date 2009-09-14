unit AImpInventario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, QuickRpt, ExtCtrls, Qrctrls;

type
  TFImpInventario = class(TForm)
    QuickRep1: TQuickRep;
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    Inventario: TQuery;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    LQtdFalta: TQRLabel;
    QRLabel7: TQRLabel;
    LValorFalta: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    LQtdSobra: TQRLabel;
    LValorSobra: TQRLabel;
    SummaryBand1: TQRBand;
    LTotFalta: TQRLabel;
    LValTotFalta: TQRLabel;
    LTotSobra: TQRLabel;
    LValTotSobra: TQRLabel;
    QRLabel12: TQRLabel;
    LFilial: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    VprQtdFalta,
    VprQtdSobra,
    VprValorFalta,
    VprValorSobra : Double;
    procedure PosicionaInventario(VpaCodFilial : String;VpaDatInicio,VpaDatFim : TDateTime);
  public
    { Public declarations }
    procedure ImprimeInventario(VpaCodFilial, VpaNomFilial : String;VpaDatInicio, VpaDatFim : TDatetime);
  end;

var
  FImpInventario: TFImpInventario;

implementation

Uses FunSql; 

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImpInventario.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprQtdFalta := 0;
  VprQtdSobra := 0;
  VprValorFalta := 0;
  VprValorSobra := 0;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImpInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImpInventario.PosicionaInventario(VpaCodFilial : String;VpaDatInicio,VpaDatFim : TDateTime);
begin
  AdicionaSQLAbreTabela(Inventario,'Select INV.C_COD_PRO, INV.I_QTD_ANT, INV.I_QTD_INV, '+
                                   ' INV.N_CUS_PRO, '+
                                   ' PRO.C_NOM_PRO '+
                                   ' From INVENTARIO INV, CADPRODUTOS PRO '+
                                   ' WHERE INV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                   SQLTextoDataEntreAAAAMMDD('INV.D_DAT_INV',VpaDatInicio,VpaDatFim,TRUE)+
                                   ' AND INV.I_EMP_FIL = '+VpaCodFilial+
                                   ' ORDER BY INV.C_COD_PRO');
end;

{******************************************************************************}
procedure TFImpInventario.ImprimeInventario(VpaCodFilial, VpaNomFilial : String;VpaDatInicio, VpaDatFim : TDatetime);
begin
  PosicionaInventario(VpaCodFilial,VpaDatInicio,VpaDatFim);
  LFilial.caption := 'Filial : '+VpaCodFilial + ' - '+ VpaNomfilial;
  QuickRep1.preview;
end;

{******************************************************************************}
procedure TFImpInventario.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  LQtdFalta.caption := '';
  LValorFalta.caption := '';
  LQtdSobra.Caption := '';
  LValorSobra.caption := '';
  if Inventario.FieldByName('I_QTD_ANT').AsFloat  > Inventario.FieldByName('I_QTD_INV').AsFloat then
  begin
    LQtdSobra.Caption := FormatFloat('0.00', Inventario.FieldByName('I_QTD_ANT').AsFloat - Inventario.FieldByName('I_QTD_INV').AsFloat);
    LValorSobra.Caption := FormatFloat('0.00',(Inventario.FieldByName('I_QTD_ANT').AsFloat - Inventario.FieldByName('I_QTD_INV').AsFloat)* Inventario.FieldByName('N_CUS_PRO').AsFloat);
    VprQtdSobra := VprQtdSobra + (Inventario.FieldByName('I_QTD_ANT').AsFloat - Inventario.FieldByName('I_QTD_INV').AsFloat);
    VprValorSobra := VprValorSobra + ((Inventario.FieldByName('I_QTD_ANT').AsFloat - Inventario.FieldByName('I_QTD_INV').AsFloat)*Inventario.FieldByName('N_CUS_PRO').AsFloat);
  end
  else
    if Inventario.FieldByName('I_QTD_ANT').AsFloat  < Inventario.FieldByName('I_QTD_INV').AsFloat then
    begin
      LQtdFalta.Caption := FormatFloat('0.00', Inventario.FieldByName('I_QTD_INV').AsFloat - Inventario.FieldByName('I_QTD_ANT').AsFloat);
      LValorFalta.Caption := FormatFloat('0.00',(Inventario.FieldByName('I_QTD_INV').AsFloat - Inventario.FieldByName('I_QTD_ANT').AsFloat)* Inventario.FieldByName('N_CUS_PRO').AsFloat);
      VprQtdFalta := VprQtdFalta + (Inventario.FieldByName('I_QTD_INV').AsFloat - Inventario.FieldByName('I_QTD_ANT').AsFloat);
      VprValorFalta := VprValorFalta + ((Inventario.FieldByName('I_QTD_INV').AsFloat - Inventario.FieldByName('I_QTD_ANT').AsFloat)*Inventario.FieldByName('N_CUS_PRO').AsFloat);
    end
end;

{******************************************************************************}
procedure TFImpInventario.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  LTotFalta.Caption := Formatfloat('0.00',VprQtdFalta);
  LValTotFalta.Caption := Formatfloat('0.00',VprvalorFalta);
  LTotSobra.caption  := Formatfloat('0.00',VprQtdSobra);
  LValTotSobra.caption := Formatfloat('0.00',VprValorSobra);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImpInventario]);
end.
