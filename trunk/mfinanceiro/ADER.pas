unit ADER;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, AxCtrls, OleCtrls, vcf1, UnDER,
  StdCtrls, Spin, Buttons, EditorImagem, UnDadosCR;

type
  TFDER = class(TFormularioPermissao)
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
    SCorFonteTitulo: TShape;
    Label15: TLabel;
    SCorFundoTitulo: TShape;
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
    SCorFundoReceitas: TShape;
    Label20: TLabel;
    SCorFonteTituloReceitas: TShape;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    SCorFundoTituloDespesas: TShape;
    Label5: TLabel;
    SCorFonteDespesas: TShape;
    Cor: TCor16;
    Label1: TLabel;
    SCorFundoTituloReceitas: TShape;
    Label2: TLabel;
    SCorFonteReceitas: TShape;
    SCorFonteTituloDespesas: TShape;
    Label6: TLabel;
    PanelColor3: TPanelColor;
    BImprime: TBitBtn;
    BDetalhes: TBitBtn;
    BNivel: TBitBtn;
    BSalvar: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn5: TBitBtn;
    Grade: TF1Book;
    PanelColor4: TPanelColor;
    Label7: TLabel;
    Label13: TLabel;
    BGerarFluxo: TBitBtn;
    FiltroFilial: TComboBoxColor;
    GPeriodo: TGroupBox;
    Label14: TLabel;
    Label17: TLabel;
    EMes: TSpinEditColor;
    EAno: TSpinEditColor;
    CMensal: TRadioButton;
    zoom: TSpinEditColor;
    SCorFundoDespesas: TShape;
    Label18: TLabel;
    CAnual: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure SCorFonteTituloMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
  private
    { Private declarations }
    VprDDER : TRBDDERCorpo;
    FunDER : TRBFuncoesDER;
    procedure InicializaTela;
    procedure InicializaGrade;
    procedure CarDClasse;
  public
    { Public declarations }
    function DERMensal(VpaMes, VpaAno : Integer):Boolean;
  end;

var
  FDER: TFDER;

implementation

uses APrincipal,FunData;

{$R *.DFM}


{ ****************** Na cria��o do Formul�rio ******************************** }
procedure TFDER.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualiza��o de menus }
  VprDDER := TRBDDERCorpo.cria;
  FunDER := TRBFuncoesDER.cria;
  InicializaTela;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDER.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualiza��o de menus }
  VprDDER.free;
  FunDER.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            A��es Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFDER.InicializaGrade;
begin
  CarDClasse;
  FunDER.LimpaFluxo(grade);
  FunDer.CarregaCores(SCorFonteTitulo.Brush.Color,SCorFundoTitulo.Brush.Color,SCorNegativo.Brush.Color,SCorFonteTituloReceitas.Brush.Color,
                             SCorFonteReceitas.Brush.Color,SCorFundoTituloReceitas.Brush.Color,SCorFundoReceitas.Brush.Color,SCorFonteDespesas.Brush.Color,SCorFundoDespesas.Brush.Color,
                             SCorFonteTituloDespesas.Brush.Color,SCorFundoTituloDespesas.Brush.Color,
                             ENomFonte.Text,ETamFonte.Value,EAltLinha.Value);
  FunDER.InicializaDER(grade,VprDDER);
end;

{******************************************************************************}
procedure TFDER.InicializaTela;
begin
  ENomFonte.Items := screen.Fonts;
  ENomFonte.Text := 'Arial';
end;

{******************************************************************************}
procedure TFDER.CarDClasse;
begin
  VprDDER.IndMensal := CMensal.Checked;
  VprDDER.Mes := EMes.Value;
  VprDDER.Ano := EAno.Value;
end;

{******************************************************************************}
function TFDER.DERMensal(VpaMes, VpaAno : Integer):boolean;
begin
  CMensal.Checked := true;
  EMes.Value := VpaMes;
  EAno.Value := VpaAno;
  InicializaGrade;
  FunDER.CarTitulosGrade(grade,VprDDER);
  FunDER.CarDER(Grade,VprDDER);
  ShowModal;
end;

{******************************************************************************}
procedure TFDER.BitBtn1Click(Sender: TObject);
begin
//  grade.FormatAlignmentDlg;
  Grade.SelStartCol := 5;
  Grade.SelEndCol := 5;
  Grade.SelStartRow := 5;
  Grade.SelEndRow := 5;
  Grade.SetPattern(2,SCorFundoTitulo.Brush.Color,SCorFundoTitulo.Brush.Color);
  Grade.SetFont( 'Arial',10,true , false, false, false,
                SCorFonteTitulo.Brush.Color, true,false);
  grade.FormatFontDlg;
  grade.SetAlignment(F1HAlignCenter,false,F1HAlignCenter,0);
  grade.SetBorder(1,-1,1,1,1,1,clRed,clRed,clRed,clRed,clRed);

end;

{******************************************************************************}
procedure TFDER.SCorFonteTituloMouseDown(Sender: TObject;
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
procedure TFDER.BitBtn5Click(Sender: TObject);
begin
  PFormatos.Visible :=True;
end;

{******************************************************************************}
procedure TFDER.BitBtn4Click(Sender: TObject);
begin
  InicializaGrade;
//  FunFluxoCaixa.CarTitulosDiarioGrade(grade,VprDFluxo);
  PFormatos.Visible := False;
end;

{******************************************************************************}
procedure TFDER.BitBtn9Click(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFDER]);
end.
