unit ACompactador;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Gauges, StdCtrls, IdBaseComponent, IdZLibCompressorBase,
  IdCompressorZLib;

type
  TFCompactador = class(TForm)
    Gauge1: TGauge;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    function CompactaArquivo(VpaNomArquivo : String): String;
  end;

var
  FCompactador: TFCompactador;

implementation
uses
  Constantes, FunArquivos;

{$R *.DFM}

{******************************************************************************}
function TFCompactador.CompactaArquivo(VpaNomArquivo : String): String;
var
  VpfArquivoBackup: String;
  a : TStream;
begin
  Result:= '';
  Show;
  VpfArquivoBackup := VpaNomArquivo+FormatDateTime('YYMMDD HHMMSS',now)+'.DMP';
  Label1.Caption:= 'Copiando o arquivo para o destino.';
  CopyFile(PChar(VpaNomArquivo+'.DMP'),PChar(VpfArquivoBackup),False);
  if Varia.PathSecundarioBackup <> '' then
  begin
    VpfArquivoBackup := RetornaNomArquivoSemDiretorio(VpfArquivoBackup);
    VpfArquivoBackup :=Varia.PathSecundarioBackup+'\'+VpfArquivoBackup;
    Label1.Caption:= 'Copiando o arquivo para o destino.';
    CopyFile(PChar(VpaNomArquivo+'.DMP'),PChar(VpfArquivoBackup),False);
  end;
  Close;
end;

{******************************************************************************}
procedure TFCompactador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

{******************************************************************************}

end.
 