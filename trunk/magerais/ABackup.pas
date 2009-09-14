unit ABackup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, ShellApi,
  Db, DBTables, ComCtrls;

type
  TFBackup = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Aux: TQuery;
    PainelGradiente1: TPainelGradiente;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Backupbase: TBitBtn;
    BitBtn3: TBitBtn;
    ABackup: TAnimate;
    LocalBackup: TEditColor;
    GroupBox2: TGroupBox;
    BValida: TBitBtn;
    Label3: TLabel;
    EnomeBaseValida: TEditColor;
    Texto: TLabel;
    Label2: TLabel;
    ENomeBase: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BValidaClick(Sender: TObject);
    procedure BackupbaseClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    procedure AbreAnimacao( Texto : string );
    procedure FechaAnimacao;
  public
    { Public declarations }
  end;

var
  FBackup: TFBackup;

implementation

{$R *.DFM}

uses
   funstring, constantes, funsql, funvalida, APrincipal, funarquivos, constmsg;


{ ****************** Na criação do Formulário ******************************** }
procedure TFBackup.FormCreate(Sender: TObject);
begin
  LocalBackup.Text := varia.PathBackup;
  ENomeBase.Text := 'SISCORP';
  EnomeBaseValida.Text := 'SISCORP';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBackup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

{***************** inicia a  animacao *************************************** }
procedure TFBackup.AbreAnimacao( Texto : string );
begin
  ABackup.Visible := true;
  ABackup.Active := true;
  self.texto.visible := true;
  self.Texto.caption := texto ;
  self.texto.Refresh;
end;

{************** fecha a animacao *********************************************}
procedure TFBackup.FechaAnimacao;
begin
  ABackup.Active := false;
  ABackup.Visible := false;
  Texto.Visible := false;
end;

{********************* Valida Sistema ************************************** }
procedure TFBackup.BValidaClick(Sender: TObject);
var
  senha, frase : string;
begin
  senha := Descriptografa(varia.SenhaBanco);
  frase := '-c "uid=dba;pwd='+ senha + ';dbf=' + EnomeBaseValida.Text + '.db"';
  ShellExecute( handle, nil, StrToPChar(NormalDiretorio(varia.PathSybase) + 'dbvalid.exe'),
                StrToPChar(frase),
                StrToPChar(varia.PathSybase + 'dbvalid.exe'),
                SW_MAXIMIZE);
end;

{******************* copia base de dados *********************************** }
procedure TFBackup.BackupbaseClick(Sender: TObject);
begin
  if LocalBackup.Text <> '' then
  begin
    LocalBackup.text := trim(LocalBackup.text);
    if LocalBackup.text[length(LocalBackup.text)] = '\' then
      LocalBackup.text := copy(LocalBackup.text,1,length(LocalBackup.text)-1);
    if  ExisteDiretorio(LocalBackup.text) then
    begin
      AbreAnimacao('Gerando Backup, Aguarde..');
      LimpaSQLTabela(aux);
      AdicionaSQLTabela( Aux, ' BACKUP DATABASE DIRECTORY ''' + LocalBackup.text + '''' +
                              ' TRANSACTION LOG RENAME ' );
      aux.ExecSQL;
      FechaAnimacao;
    end
    else
      aviso('Local de Backup Inválido.');
  end;
end;

{****************** fecha fromulario *************************************** }
procedure TFBackup.BFecharClick(Sender: TObject);
begin
  self.close;
end;

procedure TFBackup.BitBtn3Click(Sender: TObject);
var
 frase : string;
begin
  frase := ' a -v1440 -j -y a:\sig.arj ' + NormalDiretorio(LocalBackup.text) + ENomeBase.text + '.db' ;
  ShellExecute( handle, nil, StrToPChar(NormalDiretorio(varia.PathInSig) + 'arj.exe'),
                StrToPChar(frase),
                StrToPChar(NormalDiretorio(varia.PathInSig) + 'arj.exe'),
                SW_MAXIMIZE);
end;

Initialization
  RegisterClasses([TFBackup]);
end.
