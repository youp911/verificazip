unit AEntradaMetro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, ComCtrls, StdCtrls, AxCtrls,
  OleCtrls, vcf1, UnEntradaMetros, Buttons, Spin, UnCotacao, TeeEdiGrad,
  TeePenDlg, TeCanvas, Grids, CGrades;

type
  TFEntradaMetro = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label3: TLabel;
    Label4: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    BAtualizar: TBitBtn;
    BFechar: TBitBtn;
    PFormatos: TCorPainelGra;
    BitBtn3: TBitBtn;
    PanelColor5: TPanelColor;
    BitBtn4: TBitBtn;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    SCorFonte: TShape;
    ETamFonte: TSpinEditColor;
    ENomFonteTitulo: TComboBoxColor;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    ELarLinha: TSpinEditColor;
    EAltLinha: TSpinEditColor;
    CImpPretoBranco: TCheckBox;
    BCofiguraImpressora: TBitBtn;
    GroupBox3: TGroupBox;
    Label19: TLabel;
    SCorFundoGrade: TShape;
    Label20: TLabel;
    SCorFonteTituloGrade: TShape;
    Label2: TLabel;
    SCorFundoTituloGrade: TShape;
    Label5: TLabel;
    SCorFonteGrade: TShape;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    SCorFundoTituloCP: TShape;
    Label7: TLabel;
    SCorFonteCP: TShape;
    SCorFonteTituloCP: TShape;
    Label9: TLabel;
    SCorFonteTitulo: TShape;
    Label13: TLabel;
    BitBtn5: TBitBtn;
    BImprime: TBitBtn;
    RBStringGridColor1: TRBStringGridColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BAtualizarClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BImprimeClick(Sender: TObject);
    procedure BCofiguraImpressoraClick(Sender: TObject);
    procedure RBStringGridColor1GetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    { Private declarations }
    VprDatGeradaIni,
    VprDatGeradaFim : TDatetime;
    FunEntradaMEtros : TRBFuncoesEntradaMetros;
    procedure InicializaGrade;
  public
    { Public declarations }
    procedure EntradaMetros;
  end;

var
  FEntradaMetro: TFEntradaMetro;

implementation

uses APrincipal, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEntradaMetro.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunEntradaMEtros := TRBFuncoesEntradaMetros.cria(FPrincipal.BaseDados);
  EDatInicio.DateTime := date;
  EDatFim.DateTime := date;
  InicializaGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEntradaMetro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunEntradaMEtros.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEntradaMetro.EntradaMetros;
begin
//d5  FunEntradaMEtros.CarTituloGrade(Grade,EDatInicio.DateTime,EDatFim.DateTime);
  ShowModal;
end;

{******************************************************************************}
procedure TFEntradaMetro.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFEntradaMetro.InicializaGrade;
begin
  FunEntradaMEtros.CarregaCores(SCorFonte.Brush.Color,SCorFonteTituloGrade.Brush.Color,SCorFonteGrade.Brush.Color,SCorFonteTitulo.Brush.Color,SCorFundoTituloGrade.Brush.Color,
                             SCorFundoGrade.Brush.Color, ENomFonteTitulo.Text,ETamFonte.Value,EAltLinha.Value);
end;

procedure TFEntradaMetro.RBStringGridColor1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
end;

{******************************************************************************}
procedure TFEntradaMetro.BAtualizarClick(Sender: TObject);
begin
  if (EDatInicio.DateTime <> VprDatGeradaIni) or
     (EDatFim.DateTime <> VprDatGeradaFim) then
  begin
    VprDatGeradaIni := EDatInicio.DateTime;
    VprDatGeradaFim := EDatFim.DateTime;
    FunCotacao.AtualizaEntradaMetrosDiario(EDatInicio.DateTime,EDatFim.DateTime);
  end;
//d5  FunEntradaMEtros.CarEntradaMetros(Grade,EDatInicio.DateTime,EDatFim.DateTime);
end;

procedure TFEntradaMetro.BitBtn4Click(Sender: TObject);
begin
  InicializaGrade;
//d  FunEntradaMEtros.CarEntradaMetros(Grade,EDatInicio.DateTime,EDatFim.DateTime);
  PFormatos.Visible := False;
end;

{******************************************************************************}
procedure TFEntradaMetro.BitBtn5Click(Sender: TObject);
begin
  PFormatos.Visible :=True;
end;

{******************************************************************************}
procedure TFEntradaMetro.BImprimeClick(Sender: TObject);
begin
//d5  ImprimeGrade(Grade);
end;

procedure TFEntradaMetro.BCofiguraImpressoraClick(Sender: TObject);
begin
//d5  ConfigImpressoraGrade(Grade);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEntradaMetro]);
end.
