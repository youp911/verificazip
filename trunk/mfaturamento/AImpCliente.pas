unit AImpCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  QuickRpt, ExtCtrls, Geradores, Qrctrls, Db, DBTables;

type
  TFImpCliente = class(TForm)
    Rel001PorCidade: TQuickRepNovo;
    PageHeaderBand1: TQRBand;
    SummaryBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    L001Estado: TQRLabel;
    QRBand1: TQRBand;
    DetailBand1: TQRBand;
    PorCidade: TQuery;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape2: TQRShape;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRGroup2: TQRGroup;
    L001Cidade: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel4: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBText10: TQRDBText;
    QRLabel14: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    Rel002MalaDireta: TQuickRepNovo;
    DetailBand2: TQRBand;
    MalaDireta: TQuery;
    QRDBText11: TQRDBText;
    QRShape3: TQRShape;
    L002Rua: TQRLabel;
    L002Cidade: TQRLabel;
    L002Bairro: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    procedure CarSelectPorCidade(VpaCidade, VpaEstado : String);
  public
    { Public declarations }
    procedure ImpClientePorCidade( VpaCidade, VpaEstado : String;VpaVisualizar : Boolean);
    procedure ImpMalaDireta(VpaClienteInicial,VpaClienteFinal :String);
  end;

var
  FImpCliente: TFImpCliente;

implementation

{$R *.DFM}

Uses FunSql;

{ ****************** Na criação do Formulário ******************************** }
procedure TFImpCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImpCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImpCliente.CarSelectPorCidade(VpaCidade,VpaEstado : String);
begin
  PorCidade.Sql.Clear;
  PorCidade.Sql.Add('Select * from CADCLIENTES '+
                    ' WHERE C_TIP_CAD IN (''C'',''A'')');
  if VpaEstado <> '' then
    PorCidade.Sql.Add(' AND C_EST_CLI = '''+VpaEstado+'''');
  if VpaCidade <> ''then
    PorCidade.Sql.Add(' AND C_CID_CLI = '''+VpaCidade+'''');
  PorCidade.Sql.Add(' ORDER BY C_EST_CLI, C_CID_CLI, C_NOM_CLI');
  PorCidade.Sql.SaveToFile('c:\Consulta.Sql');
  PorCidade.open;
end;

{******************************************************************************}
procedure TFImpCliente.ImpClientePorCidade( VpaCidade, VpaEstado : String;VpaVisualizar : Boolean);
begin
  CarSelectPorCidade(VpaCidade,VpaEstado);
  if VpaEstado <> '' then
    L001Estado.Caption := 'Estado : '+VpaEstado
  else
    L001Estado.Caption := '';

  if VpaVisualizar then
    Rel001PorCidade.Preview
  else
    Rel001PorCidade.Print;
  close;
end;

{******************************************************************************}
procedure TFImpCliente.ImpMalaDireta(VpaClienteInicial,VpaClienteFinal :String);
begin
  AdicionaSQLAbreTabela(MalaDireta,'Select * from CADCLIENTES '+
                                   ' Where I_COD_CLI >= '+VpaClienteInicial+
                                   ' and I_COD_CLI <= '+VpaClienteFinal);
  Rel002MalaDireta.Preview;
end;

{******************************************************************************}
procedure TFImpCliente.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  L001Cidade.Caption := PorCidade.FieldByName('C_CID_CLI').AsString + ' / '+ PorCidade.FieldByName('C_EST_CLI').AsString;
end;

procedure TFImpCliente.DetailBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  L002Rua.Caption := 'Rua '+MalaDireta.FieldByName('C_END_CLI').AsString;
  if MalaDireta.FieldByName('I_NUM_END').AsString <> '' then
    L002Rua.Caption := L002Rua.Caption +', ' + MalaDireta.FieldByName('I_NUM_END').AsString;
  L002Bairro.Caption := MalaDireta.FieldByName('C_BAI_CLI').AsString +' -  CEP : '+copy(MalaDireta.FieldByName('C_CEP_CLI').AsString,1,5)+'-'+copy(MalaDireta.FieldByName('C_CEP_CLI').AsString,6,3) ;
  L002Cidade.Caption := MalaDireta.FieldByName('C_CID_CLI').AsString + ' - '+MalaDireta.FieldByName('C_EST_CLI').AsString;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImpCliente]);
end.
