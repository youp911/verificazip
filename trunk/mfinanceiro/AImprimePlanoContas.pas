unit AImprimePlanoContas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, quickrpt, Db, DBTables, Qrctrls, printers,
  StdCtrls, Buttons, Geradores;

type
  TFImprimePlanoContas = class(TForm)
    Aux: TQuery;
    Report: TQuickRepNovo;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    LNome: TQRLabel;
    Sit: TQRBand;
    QRShape3: TQRShape;
    QRSysData2: TQRSysData;
    QRDBText2: TQRDBText;
    AuxC_CLA_PLA: TStringField;
    AuxC_NOM_PLA: TStringField;
    AuxI_COD_EMP: TIntegerField;
    QRDBText1: TQRDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    procedure ExecutaRelatorio;
  end;

var
  FImprimePlanoContas: TFImprimePlanoContas;

implementation


{$R *.DFM}

uses FunString, Constantes;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimePlanoContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TFImprimePlanoContas.ReportBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Aux.sql.clear;
  Aux.sql.Add(' SELECT * FROM CAD_PLANO_CONTA ' +
    ' WHERE I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa) +
    ' ORDER BY C_CLA_PLA ');
  AUX.Open;
end;

procedure TFImprimePlanoContas.ExecutaRelatorio;
begin
  LNome.Caption := 'Plano de Contas - ' + Varia.NomeEmpresa;
  Report.Preview;
  Close;
end;

Initialization
 RegisterClasses([TFImprimePlanoContas]);
end.
