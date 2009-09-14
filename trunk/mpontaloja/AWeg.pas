unit AWeg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ComCtrls, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnClientes,
  Db, DBTables, FMTBcd, SqlExpr;

type
  TFWeg = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Progresso: TProgressBar;
    BImportar: TBitBtn;
    BExportar: TBitBtn;
    BFechar: TBitBtn;
    BarraStatus: TStatusBar;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label2: TLabel;
    Weg: TSQLQuery;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImportarClick(Sender: TObject);
    procedure BExportarClick(Sender: TObject);
  private
    { Private declarations }
    function exportaArquivoWEG(VpaNomArquivo : String) : string;
    procedure AtualizaBarraStatus(VpaBarraStatus : TStatusBar;VpaTexto : String);
  public
    { Public declarations }
  end;

var
  FWeg: TFWeg;

implementation

uses APrincipal, ConstMsg, FunData, FunSql,FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFWeg.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := decmes(MontaData(21,mes(date),ano(date)),1);
  EDatFim.DateTime := MontaData(20,mes(date),ano(date));
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFWeg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFWeg.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFWeg.BImportarClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    aviso(FunClientes.ImportaClientesWeg(OpenDialog1.FileName,BarraStatus,Progresso));
  end;
end;

{******************************************************************************}
function TFWeg.exportaArquivoWEG(VpaNomArquivo : String) : string;
var
  VpfArquivo : TStringLIst;
begin
  result := '';
  VpfArquivo := TStringList.create;
  AdicionaSQLAbreTabela(Weg,'select sum(ORC.N_VLR_TOT) TOTAL, CLI.I_COD_CLI, CLI.C_SIG_WEG, CLI.I_COD_WEG ' +
                           ' FROM CADCLIENTES CLI, CADORCAMENTOS ORC '+
                           ' Where CLI.I_COD_CLI = ORC.I_COD_CLI ' +
                           ' and CLI.C_FUN_WEG = ''S'''+
                           SQLTextoDataEntreAAAAMMDD('D_DAT_ORC',EDatInicio.DateTime,EDatFim.DateTime,true)+
                           ' GROUP BY CLI.I_COD_CLI, C_SIG_WEG, I_COD_WEG ' );
  Progresso.Max := Weg.recordcount;
  Progresso.position := 0;
  While not Weg.eof do
  begin
    AtualizaBarraStatus(BarraStatus,'Exportando cliente '+Weg.FieldByName('I_COD_CLI').AsString);
    if (Weg.FieldByName('C_SIG_WEG').AsString = '') then
      result := 'SIGLA DA EMPRESA WEG NÃO PREENCHIDA!!!'#13'O cliente "'+Weg.FieldByName('I_COD_CLI').AsString+'" esta com a sigla da empresa WEG em branco.';
    if (Weg.FieldByName('I_COD_WEG').AsString = '') then
      result := 'CODIGO DO FUNCIONÁRIO DA WEG NÃO PREENCHIDA!!!'#13'O cliente "'+Weg.FieldByName('I_COD_CLI').AsString+'" esta com o codigo do funcionário da WEG em branco.';
    if result = '' then
    begin
      VpfArquivo.Add(Weg.FieldByName('C_SIG_WEG').AsString+AdicionaCharE('0',Weg.FieldByName('I_COD_WEG').AsString,6)+AdicionaCharE('0',DeletaChars(FormatFloat('0.00',Weg.FieldByName('TOTAL').AsFloat),','),12));
    end;
    if result <> '' then
      Weg.last;
    Progresso.position := Progresso.position +1;
    Weg.next;
  end;
  VpfArquivo.SaveToFile(VpaNomArquivo);
  VpfArquivo.free;
  if result = '' then
  begin
    result := 'Exportação do arquivo realizada com sucesso.';
    AtualizaBarraStatus(BarraStatus,'Exportação realizada com sucesso.');
  end;
end;

{******************************************************************************}
procedure TFWeg.AtualizaBarraStatus(VpaBarraStatus : TStatusBar;VpaTexto : String);
begin
  VpaBarraStatus.Panels[0].Text := VpaTexto;
  VpaBarraStatus.Refresh;
end;

procedure TFWeg.BExportarClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    aviso(exportaArquivoWEG(SaveDialog1.FileName));
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFWeg]);
end.
