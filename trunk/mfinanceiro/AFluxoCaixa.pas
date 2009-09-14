unit AFluxoCaixa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, AxCtrls, OleCtrls, vcf1, UnFluxoCaixa,
  StdCtrls, Spin, Buttons, EditorImagem, UnDadosCR;

type
  TFFluxoCaixa = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PFormatos: TCorPainelGra;
    BitBtn3: TBitBtn;
    PanelColor5: TPanelColor;
    BitBtn4: TBitBtn;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    SCorFonteCaixa: TShape;
    Label15: TLabel;
    SCorFundoCaixa: TShape;
    Label16: TLabel;
    SCorNegativo: TShape;
    ETamFonte: TSpinEditColor;
    ENomFonte: TComboBoxColor;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label10: TLabel;
    ELarLinha: TSpinEditColor;
    EAltLinha: TSpinEditColor;
    CImpPretoBranco: TCheckBox;
    BCofiguraImpressora: TBitBtn;
    GroupBox3: TGroupBox;
    Label19: TLabel;
    SCorFundoCR: TShape;
    Label20: TLabel;
    SCorFonteTituloCR: TShape;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    SCorFundoTituloCP: TShape;
    Label5: TLabel;
    SCorFonteCP: TShape;
    Cor: TCor16;
    Label1: TLabel;
    SCorFundoTituloCR: TShape;
    Label2: TLabel;
    SCorFonteCR: TShape;
    SCorFonteTituloCP: TShape;
    Label6: TLabel;
    PanelColor3: TPanelColor;
    BImprime: TBitBtn;
    BDetalhes: TBitBtn;
    BGraficosPagar: TBitBtn;
    BGraficosReceber: TBitBtn;
    BNivel: TBitBtn;
    BSalvar: TBitBtn;
    BExpandir: TBitBtn;
    BitBtn9: TBitBtn;
    BSituacao: TBitBtn;
    BSuprimir: TBitBtn;
    BitBtn5: TBitBtn;
    Grade: TF1Book;
    PanelColor4: TPanelColor;
    Label7: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    BGerarFluxo: TBitBtn;
    FiltroFilial: TComboBoxColor;
    ETipoFluxo: TComboBoxColor;
    GPeriodo: TGroupBox;
    Label14: TLabel;
    Label17: TLabel;
    EMes: TSpinEditColor;
    EAno: TSpinEditColor;
    CDiario: TRadioButton;
    CMensal: TRadioButton;
    zoom: TSpinEditColor;
    CClientesConfiaveis: TCheckBox;
    SCorFundoCP: TShape;
    Label18: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure SCorFonteCaixaMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
  private
    { Private declarations }
    VprDFluxo : TRBDFluxoCaixaCorpo;
    FunFluxoCaixa : TRBFuncoesFluxoCaixa;
    procedure InicializaTela;
    procedure InicializaGrade;
    procedure CarDClasse;
  public
    { Public declarations }
    function FluxoCaixaDiario(VpaMes, VpaAno : Integer):Boolean;
  end;

var
  FFluxoCaixa: TFFluxoCaixa;

implementation

uses APrincipal,FunData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFluxoCaixa.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDFluxo := TRBDFluxoCaixaCorpo.cria;
  FunFluxoCaixa := TRBFuncoesFluxoCaixa.cria;
  InicializaTela;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFluxoCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDFluxo.free;
  FunFluxoCaixa.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFFluxoCaixa.InicializaGrade;
begin
  CarDClasse;
  FunFluxoCaixa.LimpaFluxo(grade);
  FunFluxoCaixa.CarregaCores(SCorFonteCaixa.Brush.Color,SCorFundoCaixa.Brush.Color,SCorNegativo.Brush.Color,SCorFonteTituloCR.Brush.Color,
                             SCorFonteCR.Brush.Color,SCorFundoTituloCR.Brush.Color,SCorFundoCR.Brush.Color,SCorFonteCP.Brush.Color,SCorFundoCP.Brush.Color,
                             SCorFonteTituloCP.Brush.Color,SCorFundoTituloCP.Brush.Color,
                             ENomFonte.Text,ETamFonte.Value,EAltLinha.Value);
  FunFluxoCaixa.InicializaFluxoDiario(grade,VprDFluxo);
end;

{******************************************************************************}
procedure TFFluxoCaixa.InicializaTela;
begin
  ENomFonte.Items := screen.Fonts;
  ENomFonte.Text := 'Arial';
end;

{******************************************************************************}
procedure TFFluxoCaixa.CarDClasse;
begin
  VprDFluxo.IndDiario := CDiario.Checked;
  VprDFluxo.Mes := EMes.Value;
  VprDFluxo.Ano := EAno.Value;
  if CDiario.Checked then
  begin
    VprDFluxo.DatInicio := MontaData(1,EMes.Value,EAno.Value);
    VprDFluxo.DatFim :=UltimoDiaMes(VprDFluxo.DatInicio);
  end
  else
  begin
    VprDFluxo.DatInicio := MontaData(1,1,EAno.Value);
    VprDFluxo.DatFim :=MontaData(31,12,EAno.Value);
  end;
end;

{******************************************************************************}
function TFFluxoCaixa.FluxoCaixaDiario(VpaMes, VpaAno : Integer):boolean;
begin
  CDiario.Checked := true;
  EMes.Value := VpaMes;
  EAno.Value := VpaAno;
  InicializaGrade;
  FunFluxoCaixa.CarTitulosDiarioGrade(grade,VprDFluxo);
  FunFluxoCaixa.CarFluxoCaixa(Grade,VprDFluxo);
  ShowModal;
end;

{******************************************************************************}
procedure TFFluxoCaixa.BitBtn1Click(Sender: TObject);
begin
//  grade.FormatAlignmentDlg;
  Grade.SelStartCol := 5;
  Grade.SelEndCol := 5;
  Grade.SelStartRow := 5;
  Grade.SelEndRow := 5;
  Grade.SetPattern(2,SCorFundoCaixa.Brush.Color,SCorFundoCaixa.Brush.Color);
  Grade.SetFont( 'Arial',10,true , false, false, false,
                SCorFonteCaixa.Brush.Color, true,false);
  grade.FormatFontDlg;
  grade.SetAlignment(F1HAlignCenter,false,F1HAlignCenter,0);
  grade.SetBorder(1,-1,1,1,1,1,clRed,clRed,clRed,clRed,clRed);

end;

{******************************************************************************}
procedure TFFluxoCaixa.SCorFonteCaixaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  VpfShape : TShape;
begin
  VpfShape := TShape(Sender);
  if Cor.execute(VpfShape.Brush.color) then
  begin
    VpfShape.Brush.Color := Cor.ACor;
  end;
end;

{******************************************************************************}
procedure TFFluxoCaixa.BitBtn5Click(Sender: TObject);
begin
  PFormatos.Visible :=True;
end;

{******************************************************************************}
procedure TFFluxoCaixa.BitBtn4Click(Sender: TObject);
begin
  InicializaGrade;
  FunFluxoCaixa.CarTitulosDiarioGrade(grade,VprDFluxo);
  PFormatos.Visible := False;
end;

{******************************************************************************}
procedure TFFluxoCaixa.BitBtn9Click(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFluxoCaixa]);
end.
