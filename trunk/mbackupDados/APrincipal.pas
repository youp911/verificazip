unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Componentes1, WideStrings, DBXOracle, SqlExpr;

Const
  NomeModulo = 'Backup dados';

type
  TFPrincipal = class(TForm)
    BaseDados: TSQLConnection;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function AbreBaseDados( Alias : string ) : Boolean;
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

Uses FunSql, FunObjeto, Constantes, FunArquivos, ACompactador, ConstMsg;

{$R *.DFM}

{******************************************************************************}
procedure TFPrincipal.FormCreate(Sender: TObject);
var
  VpfResultado: String;
  VpfUsuarioBD : String;
  VpfNomArquivo : String;
begin
  if ParamStr(1) <> '' then
    VpfUsuarioBD := ParamStr(1)
  else
    VpfUsuarioBD := 'system';

  if AbreBaseDados(VpfUsuarioBD) then
  begin
    varia := TVariaveis.cria(BaseDados);
    config := TConfig.Create;
    ConfigModulos := TConfigModulo.Create;
    carregaCFG(BaseDados);

    NaoExisteCriaDiretorio(Varia.PathBackup,false);

    VpfNomArquivo  := Varia.PathBackup+'\'+varia.NomBackup;
    ExecutaArquivoEXE('"'+Varia.PathSybase+'\exp.exe " '+VpfUsuarioBD+'/1298@siscorp file='+VpfNomArquivo,1);
    FCompactador:= TFCompactador.Create(Self);
    VpfResultado:= FCompactador.CompactaArquivo(VpfNomArquivo);
    FCompactador.Free;
    if VpfResultado <> '' then
      aviso(VpfResultado);
    varia.free;
    Config.free;
    ConfigModulos.free;
  end;
  close;
end;

{******************************************************************************}
function TFPrincipal.AbreBaseDados( Alias : string ) : Boolean;
begin
  Result := true;
  BaseDados.close;
  BaseDados.Params.clear;
  BaseDados.Params.add('drivername=Oracle');
  BaseDados.Params.add('Database=SisCorp');
  BaseDados.Params.add('decimal separator=,');
  BaseDados.Params.add('Password=1298');
  if UpperCase(Alias) <> 'SISCORP' then
  begin
    BaseDados.Params.add('User_Name='+Alias);
  end
  else
    BaseDados.Params.add('User_Name=system');
  BaseDados.Open;

end;

procedure TFPrincipal.FormShow(Sender: TObject);
begin
  close;
end;

end.

