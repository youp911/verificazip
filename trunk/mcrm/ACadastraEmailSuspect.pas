unit ACadastraEmailSuspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao, UnDadosLocaliza, UnDados,
  UnProspect;

type
  TFCadastraEmailSuspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    EVendedor: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    ESuspect: TRBEditLocaliza;
    ENomSuspect: TEditColor;
    Label4: TLabel;
    ESiteEmail: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ESuspectRetorno(VpaColunas: TRBColunasLocaliza);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure ESiteEmailKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDProspect : TRBDProspect;
    procedure InicializaTela;
  public
    { Public declarations }
  end;

var
  FCadastraEmailSuspect: TFCadastraEmailSuspect;

implementation

uses APrincipal, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCadastraEmailSuspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDProspect := TRBDProspect.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCadastraEmailSuspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDProspect.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCadastraEmailSuspect.InicializaTela;
begin
  ESiteEmail.Clear;
  if ESuspect.AInteiro <> 0 then
    ESiteEmail.SetFocus;
end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.ESuspectRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  ENomSuspect.Text := VpaColunas[1].AValorRetorno;
end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

procedure TFCadastraEmailSuspect.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VprDProspect.CodProspect := ESuspect.AInteiro;
  VpfResultado := FunProspect.CadastraEmailEmailSuspect(VprDProspect,ESiteEmail.Text);
  if VpfResultado = '' then
  begin
    InicializaTela;
  end
  else
    aviso(VpfResultado);

end;

{******************************************************************************}
procedure TFCadastraEmailSuspect.ESiteEmailKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    BGravar.Click;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCadastraEmailSuspect]);
end.
