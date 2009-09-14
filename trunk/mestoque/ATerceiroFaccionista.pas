unit ATerceiroFaccionista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, CGrades, Componentes1, ExtCtrls, UnDadosProduto,
  PainelGradiente;

type
  TFTerceiroFaccionista = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarTituloGrade;
  public
    { Public declarations }
    function CadastraTerceiros(VpaDRevisao : TRBDRevisaoFracaoFaccionista) : Boolean;
  end;

var
  FTerceiroFaccionista: TFTerceiroFaccionista;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTerceiroFaccionista.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTituloGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTerceiroFaccionista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTerceiroFaccionista.CarTituloGrade;
begin
  Grade.cells[1,0] := 'Nome';
  Grade.cells[2,0] := 'Qtd Revisada';
  Grade.cells[3,0] := 'Qtd Defeito';
end;

{******************************************************************************}
function TFTerceiroFaccionista.CadastraTerceiros(VpaDRevisao : TRBDRevisaoFracaoFaccionista) : Boolean;
begin
  Grade.ADados := VpaDRevisao.Terceiros;
  Grade.CarregaGrade;
  ShowModal;
end;

{******************************************************************************}
procedure TFTerceiroFaccionista.BCancelarClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTerceiroFaccionista]);
end.
