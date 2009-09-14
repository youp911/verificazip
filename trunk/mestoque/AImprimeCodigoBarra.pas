unit AImprimeCodigoBarra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Db, DBTables,
  Mask, numericos, Grids, UnImpressao, Tabela, DBGrids, DBKeyViolation, DBClient;

type
  TFImprimeCodigoBarra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EcodPro: TEditColor;
    BFechar: TBitBtn;
    Aux: TQuery;
    Label1: TLabel;
    SpeedButton5: TSpeedButton;
    numerico1: Tnumerico;
    CAD_DOC: TSQL;
    CAD_DOCN_ALT_ETI: TFloatField;
    CAD_DOCN_LIN_ETI: TFloatField;
    CAD_DOCI_NRO_DOC: TIntegerField;
    CAD_DOCC_NOM_DOC: TStringField;
    CAD_DOCN_COM_ETI: TFloatField;
    CAD_DOCN_COL_ETI: TFloatField;
    DATA_CAD_DOC: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    LPosicao: TLabel;
    PainelFundo: TPanelColor;
    Fundo: TShape;
    Shape1: TShape;
    Label5: TLabel;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    Shape3: TShape;
    GDoc: TGridIndice;
    Label4: TLabel;
    Label8: TLabel;
    BitBtn1: TBitBtn;
    CAD_DOCC_COD_BAR: TStringField;
    ComboBoxColor1: TComboBoxColor;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EcodProExit(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CAD_DOCAfterScroll(DataSet: TDataSet);
    procedure numerico1Exit(Sender: TObject);
  private
    SeqProAImprimir : Integer;
    PosicaoImpressao : Integer;
    Etiquetas : array[1..400] of TShape;
    IMP : TFuncoesImpressao;
    function AtualizaProduto(CodProduto : string) : boolean;
    procedure ValidaProduto;
    procedure AbreLocalizacao;
    procedure MontaPosicao( QtdaLinha, QtdColuna : Integer );
    procedure MarcaSelecaoAImprimir(Sender: TObject;
                                    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MarcaEtiqueta( Posicao : Integer );                                    
  public
    { Public declarations }
  end;

var
  FImprimeCodigoBarra: TFImprimeCodigoBarra;

implementation

uses APrincipal, funsql, constantes, ALocalizaProdutos,
  AImprimeEtiquetaBarra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeCodigoBarra.FormCreate(Sender: TObject);
begin
  IMP := TFuncoesImpressao.Criar(self,FPrincipal.BaseDados);
    AdicionaSQLAbreTabela(CAD_DOC,
    ' SELECT * FROM CAD_DOC as doc, cad_codigo_barra as bar WHERE C_TIP_DOC  = ' +
    ' ''CDB'' ' +
    ' and doc.i_cod_bar = bar.i_cod_bar' );
  MontaPosicao(CAD_DOCN_LIN_ETI.AsInteger, CAD_DOCN_COL_ETI.AsInteger);
  MarcaEtiqueta(1);
end;


{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeCodigoBarra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Imp.Free;
 Action := CaFree;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Localiza o produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************************* atualiza o codigo e nome do produto ************** }
function TFImprimeCodigoBarra.AtualizaProduto(CodProduto : string) : boolean;
begin
  AdicionaSQLAbreTabela( Aux, ' Select pro.i_seq_pro, pro.c_nom_pro, ' + varia.CodigoProduto +
                              ' from CadProdutos as pro, MovQdadeProduto as mov, ' +
                              ' where ' + varia.CodigoProduto + ' = ''' + CodProduto + '''' +
                              ' and pro.i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                              ' and mov.I_EMP_FIL = ' + intToStr(varia.CodigoEmpFil) +
                              ' and pro.i_seq_pro = mov.i_seq_pro ' );
  if not aux.Eof then
  begin
    SeqProAImprimir := Aux.fieldByName('i_seq_pro').AsInteger;
    EcodPro.Text := Aux.fieldByName(varia.CodigoProduto).AsString;
    Label1.Caption := Aux.fieldByName('C_nom_pro').AsString;
  end;
  result := not Aux.eof;
end;

{*******************  Valida o produto ************************************** }
procedure TFImprimeCodigoBarra.ValidaProduto;
begin
  if EcodPro.Text <> '' then
    if not AtualizaProduto(EcodPro.Text) then // valida o campo codigo caso esteja vazio
      AbreLocalizacao;
end;

{*********************** Abre a localizacao do produto ********************** }
procedure TFImprimeCodigoBarra.AbreLocalizacao;
var
  SeqPro :integer;
  codPro : string;
  Ok : boolean;
  EstoqueAtual : Double;
begin
  FLocalizaProduto := TFLocalizaProduto.CriarSDI(application,'',true);
  ok := FLocalizaProduto.LocalizaProduto( OK, seqProAImprimir, CodPro, EstoqueAtual,0 );
  if ok then
    AtualizaProduto(codPro)
  else
    EcodPro.SetFocus;
end;

{*************** no exit do Codigo do produto valida  o produto ************* }
procedure TFImprimeCodigoBarra.EcodProExit(Sender: TObject);
begin
  ValidaProduto;
end;

{*************** chama a abertura da localizacao pelo botao **************** }
procedure TFImprimeCodigoBarra.SpeedButton5Click(Sender: TObject);
begin
  AbreLocalizacao;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   configura a tela de etiquetas
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************** Monta as etiquetas ****************************************** }
procedure TFImprimeCodigoBarra.MontaPosicao( QtdaLinha, QtdColuna : Integer );
var
  laco, lacoCol, SomaLinha, SomaColuna, conta : integer;
  larguraEti, AlturaEti : Integer;
begin

  for laco := 1 to 400 do
   if Etiquetas[laco] <> nil then
     Etiquetas[laco].free
   else
     break;

  for laco := 1 to 400 do
    Etiquetas[laco] := nil;


  AlturaEti  := trunc((205 /  QtdaLinha) -1);
  larguraEti := trunc((172 /  QtdColuna) - 2);

  SomaColuna := 10;
  conta := 0;
  for lacoCol := 1 to QtdColuna do
  begin
    SomaLinha := 10;
    for laco := 1 to QtdaLinha do
    begin
     inc(conta);
     Etiquetas[conta] := TShape.Create(fundo);
     Etiquetas[conta].parent := Fundo.Parent;
     Etiquetas[conta].Height := AlturaEti;
     Etiquetas[conta].Width := LarguraEti;
     Etiquetas[conta].Top := SomaLinha;
     SomaLinha := SomaLinha + AlturaEti + 1;
     Etiquetas[conta].Left := somacoluna;
     Etiquetas[conta].Shape := stRoundRect;
     Etiquetas[conta].Tag := conta;
     Etiquetas[conta].OnMouseUp := MarcaSelecaoAImprimir;
    end;
    SomaColuna := SomaColuna + larguraEti + 1
  end;
  PainelFundo.Height := SomaLinha + 10 ;
  PainelFundo.Width := SomaColuna + 8 ;
  LPosicao.Top := PainelFundo.Height + PainelFundo.top + 4;
end;

{************************* Marca o inicio de impressao ********************* }
procedure TFImprimeCodigoBarra.MarcaSelecaoAImprimir(Sender: TObject;
          Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  laco : Integer;
begin
  if (Sender is TShape) then
    MarcaEtiqueta((Sender as TShape).Tag)
end;

{****************configura as etiquetas a imprimir e as impressas *********** }
procedure TFImprimeCodigoBarra.MarcaEtiqueta( Posicao : Integer );
var
  laco, conta : integer;
begin
  conta := 1;

  for laco := 1 to 400 do
    if Etiquetas[laco] <> nil then
      Etiquetas[laco].Brush.Color := clsilver;

  if posicao = 0 then
    posicao := 1;

  for laco := posicao to 400  do
    if Etiquetas[laco] <> nil then
    begin
      if conta > numerico1.AValor then
        Etiquetas[laco].Brush.Color := clwhite
      else
        Etiquetas[laco].Brush.Color := clBlue;
      inc(conta);
    end
    else
       break;
  LPosicao.Caption := 'Posiçao : ' + IntToStr(Posicao);
  PosicaoImpressao := Posicao;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Diveros
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************** fecha o formulario **************************************** }
procedure TFImprimeCodigoBarra.BFecharClick(Sender: TObject);
begin
  self.close;
end;

{****************** imprime o codigo de barra do produto ********************* }
procedure TFImprimeCodigoBarra.BitBtn1Click(Sender: TObject);
var
  QdadeRestante : double;
begin
  FImprimeEtiquetaBarra := TFImprimeEtiquetaBarra.CriarSDI(application, '', true);
  FImprimeEtiquetaBarra.ImprimeBarra( CAD_DOCI_NRO_DOC.AsInteger,trunc(numerico1.avalor),PosicaoImpressao, ComboBoxColor1.ItemIndex, SeqProAImprimir);
  FImprimeEtiquetaBarra.Pagina.Preview;
  FImprimeEtiquetaBarra.close;

  QdadeRestante := (CAD_DOCN_LIN_ETI.AsInteger * CAD_DOCN_COL_ETI.AsInteger) -  PosicaoImpressao;

  if ( QdadeRestante - numerico1.avalor ) >= 0 then
    PosicaoImpressao := PosicaoImpressao + trunc(numerico1.avalor)
  else
  begin
    QdadeRestante := numerico1.avalor - QdadeRestante;
    while QdadeRestante >= (CAD_DOCN_LIN_ETI.AsInteger * CAD_DOCN_COL_ETI.AsInteger) do
      QdadeRestante := QdadeRestante - (CAD_DOCN_LIN_ETI.AsInteger * CAD_DOCN_COL_ETI.AsInteger);
    PosicaoImpressao := Trunc(QdadeRestante);
  end;

  numerico1.AValor := 0;

  MarcaEtiqueta(PosicaoImpressao);
  EcodPro.SetFocus;
end;




procedure TFImprimeCodigoBarra.CAD_DOCAfterScroll(DataSet: TDataSet);
begin
  numerico1.AValor := 0;
  MontaPosicao(CAD_DOCN_LIN_ETI.AsInteger, CAD_DOCN_COL_ETI.AsInteger);
  MarcaEtiqueta(1);
  if CAD_DOCC_COD_BAR.AsString  <> '' then
    ComboBoxColor1.ItemIndex := StrToInt(CAD_DOCC_COD_BAR.AsString[1]);
end;

procedure TFImprimeCodigoBarra.numerico1Exit(Sender: TObject);
begin
  MarcaEtiqueta(PosicaoImpressao);
end;

Initialization
 RegisterClasses([TFImprimeCodigoBarra]);
end.
