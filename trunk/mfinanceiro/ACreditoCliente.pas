unit ACreditoCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, StdCtrls,
  Buttons, UnDados, UnClientes;

type
  TFCreditoCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    VprCreditos : TList;
    VprCodCliente : Integer;
    VprDCreditoCliente : TRBDCreditoCliente;
    VprAcao : Boolean;
    procedure CarTituloGrade;
    procedure CarDClasse;
  public
    { Public declarations }
    function CreditoCliente(VpaCodCliente : Integer):boolean;
  end;

var
  FCreditoCliente: TFCreditoCliente;

implementation

uses APrincipal, FunObjeto, Constantes, FunData, FunString, Constmsg;

{$R *.DFM}


{ ****************** Na cria��o do Formul�rio ******************************** }
procedure TFCreditoCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualiza��o de menus }
  CarTituloGrade;
  VprCreditos := TList.Create;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCreditoCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualiza��o de menus }
  FreeTObjectsList(VprCreditos);
  VprCreditos.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            A��es Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCreditoCliente.CarTituloGrade;
begin
  Grade.Cells[1,0] := 'C/D';
  Grade.Cells[2,0] := 'Valor Inicial';
  Grade.Cells[3,0] := 'Valor';
  Grade.Cells[4,0] := 'Data';
  Grade.Cells[5,0] := 'Observa��es';
end;

{******************************************************************************}
procedure TFCreditoCliente.CarDClasse;
begin
  VprDCreditoCliente.TipCredito := UpperCase(Grade.Cells[1,Grade.ALinha]);
  VprDCreditoCliente.ValCredito := StrToFloat(DeletaChars(Grade.Cells[3,Grade.ALinha],'.'));
  if Grade.AEstadoGrade in [egInsercao] then
    VprDCreditoCliente.ValInicial := VprDCreditoCliente.ValCredito;
  try
    VprDCreditoCliente.DatCredito := StrToDate(Grade.Cells[4,Grade.ALinha])
  except
    VprDCreditoCliente.DatCredito := MontaData(1,1,1900);
  end;
  VprDCreditoCliente.DesObservacao := Grade.Cells[5,Grade.ALinha];
end;

{******************************************************************************}
function TFCreditoCliente.CreditoCliente(VpaCodCliente : Integer):boolean;
begin
  VprCodCliente := vpaCodCliente;
  FunClientes.CarCreditoCliente(VpaCodCliente,VprCreditos,false);
  Grade.ADados := VprCreditos;
  Grade.CarregaGrade;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFCreditoCliente.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCreditoCliente:= TRBDCreditoCliente(VprCreditos.Items[VpaLinha-1]);
  Grade.Cells[1,VpaLinha]:= VprDCreditoCliente.TipCredito;
  Grade.Cells[2,VpaLinha]:= FormatFloat(varia.MascaraValor,VprDCreditoCliente.ValInicial);
  Grade.Cells[3,VpaLinha]:= FormatFloat(varia.MascaraValor,VprDCreditoCliente.ValCredito);
  if VprDCreditoCliente.DatCredito > MontaData(1,1,1900) then
    Grade.Cells[4,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDCreditoCliente.DatCredito)
  else
    Grade.Cells[4,VpaLinha]:= '';
  Grade.Cells[5,VpaLinha]:= VprDCreditoCliente.DesObservacao;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if Grade.Cells[3,Grade.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso('VALOR DO CR�DITO N�O PREENCHIDO!!!'#13'� necess�rio preenhcer o valor do cr�dito.');
    Grade.COL := 3;
  end;
  if VpaValidos then
  begin
    CarDClasse;
    if (VprDCreditoCliente.TipCredito <> 'C') and
       (VprDCreditoCliente.TipCredito <> 'D') then
    begin
      VpaValidos := false;
      aviso('TIPO DEBITO/CREDITO INV�LIDO!!!'#13'� permitido digitar somente :'#13'C- Cr�dito'#13'D - D�bito');
      Grade.COL := 1;
    end;
    if VprDCreditoCliente.ValCredito = 0 then
    begin
      VpaValidos := false;
      aviso('VALOR DO CR�DITO N�O PREENCHIDO!!!'#13'� necess�rio preenhcer o valor do cr�dito.');
      Grade.COL := 3;
    end
    else
      if (VprDCreditoCliente.ValCredito > VprDCreditoCliente.ValInicial) then
      begin
        VpaValidos := false;
        aviso('VALOR DO CR�DITO N�O PODE SER MAIOR QUE O VALOR INICIAL!!!'#13'O valor do cr�dito n�o pode ser maior que o valor inicial');
        Grade.COL := 3;
      end;
    if VprDCreditoCliente.DatCredito <= montadata(1,1,1900) then
    begin
      VpaValidos := false;
      aviso('DATA DO CR�DITO INV�LIDA!!!'#13'� necess�rio digitar uma data v�lida.');
      Grade.col := 4;
    end;
  end;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    4 : Value := DeletaChars(Fprincipal.CorFoco.AMascaraData,'\');
  end;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprCreditos.Count >0 then
  begin
    VprDCreditoCliente := TRBDCreditoCliente(VprCreditos.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeNovaLinha(Sender: TObject);
begin
  VprDCreditoCliente := TRBDCreditoCliente.cria;
  VprCreditos.add(VprDCreditoCliente);
  VprDCreditoCliente.DatCredito := date;
end;

{******************************************************************************}
procedure TFCreditoCliente.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunClientes.GravaCreditoCliente(VprCodCliente,VprCreditos);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    close;
end;

{******************************************************************************}
procedure TFCreditoCliente.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  if Grade.col = 2 then
    key := #0;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCreditoCliente]);
end.
