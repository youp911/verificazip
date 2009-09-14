unit AMostraCarne;

{          Autor: Douglas Thomas Jacobsen
    Data Criação: 28/02/2000;
          Função: TELA BÁSICA
  Data Alteração:
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, SysUtils, Classes,Controls, Forms, Componentes1, ExtCtrls,
  PainelGradiente, Formularios, StdCtrls, Buttons, Tabela, Grids, DBCtrls,
  Localizacao, Mask, DBGrids, LabelCorMove, numericos, UnImpressao, Db,
  DBTables, ComCtrls, UnClassesImprimir, DBClient;

type
  TFMostraCarne = class(TFormularioPermissao)
    PanelFechar: TPanelColor;
    BFechar: TBitBtn;
    BImprimir: TBitBtn;
    PainelTitulo: TPainelGradiente;
    Panel: TPanelColor;
    Label76: TLabel;
    Shape4: TShape;
    Label14: TLabel;
    Label5: TLabel;
    Shape24: TShape;
    LabelCorMove1: TLabelCorMove;
    LabelCorMove2: TLabelCorMove;
    Shape1: TShape;
    LabelCorMove3: TLabelCorMove;
    Shape2: TShape;
    LabelCorMove4: TLabelCorMove;
    Shape3: TShape;
    LabelCorMove5: TLabelCorMove;
    Shape5: TShape;
    LabelCorMove6: TLabelCorMove;
    Shape6: TShape;
    LabelCorMove7: TLabelCorMove;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    LabelCorMove9: TLabelCorMove;
    Shape10: TShape;
    LabelCorMove10: TLabelCorMove;
    EValorTotal: Tnumerico;
    EAcrDesc: Tnumerico;
    EValorParcela: Tnumerico;
    ECodigoCliente: TEditColor;
    ENomeCliente: TEditColor;
    EParcela: TEditColor;
    ENumeroDocumento: TEditColor;
    EObservacoes: TEditColor;
    EAutentificacao: TEditColor;
    LabelCorMove8: TLabelCorMove;
    PanelModelo: TPanelColor;
    Label1: TLabel;
    CModelo: TDBLookupComboBoxColor;
    CAD_DOC: TSQL;
    CAD_DOCI_NRO_DOC: TFMTBCDField;
    CAD_DOCI_SEQ_IMP: TFMTBCDField;
    CAD_DOCC_NOM_DOC: TWideStringField;
    CAD_DOCC_TIP_DOC: TWideStringField;
    DATACAD_DOC: TDataSource;
    LabelCorMove12: TLabelCorMove;
    CAD_DOCC_NOM_IMP: TWideStringField;
    DBText2: TDBText;
    EVencimento: TMaskEditColor;
    BOK: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure CModeloCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    IMP : TFuncoesImpressao;
    procedure DesativaEdits;
  public
    { Public declarations }
    procedure ImprimeDocumento;
    procedure MostraDocumento(Dados: TDadosCarne);
    procedure CarregaDados(Dados: TDadosCarne);
    procedure CarregaEdits(Dados: TDadosCarne);
  end;

var
  FMostraCarne: TFMostraCarne;

implementation

uses APrincipal, FunSql, FunString, ConstMsg, FunObjeto, Constantes;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraCarne.FormCreate(Sender: TObject);
begin
  EVencimento.Text := DateToStr(Date);
  IMP := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
  AbreTabela(CAD_DOC);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraCarne.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  IMP.Destroy;
  Action := CaFree;
end;

procedure TFMostraCarne.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFMostraCarne.BImprimirClick(Sender: TObject);
begin
  ImprimeDocumento;
end;

procedure TFMostraCarne.ImprimeDocumento;
var
  Dados : TDadosCarne;
begin
  if ((not CAD_DOC.EOF) and (CModelo.Text <> '')) then
  begin
    Dados := TDadosCarne.Create;
    IMP.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
    CarregaDados(Dados);
    IMP.ImprimeCarnePagamento(Dados); // Imprime 1 documento.
    IMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
  end
  else
    Aviso('Não existe modelo de documento para imprimir.');
end;

procedure TFMostraCarne.MostraDocumento(Dados: TDadosCarne);
begin
  BOK.Visible := True;
  ActiveControl :=  BOK;
  CarregaEdits(Dados);
  DesativaEdits;
  if BImprimir.Visible then
    Height := Height - PanelModelo.Height - PanelFechar.Height - PainelTitulo.Height;
  BImprimir.Visible := False;
  PanelModelo.Visible := False;
  PanelFechar.Visible := False;
  PainelTitulo.Visible := False;
  if BImprimir.Visible then
    Height := Height - PanelModelo.Height - PanelFechar.Height - PainelTitulo.Height;  DesativaEdits;
  FormStyle := fsStayOnTop;
  BorderStyle := bsDialog;
  Show;
end;

procedure TFMostraCarne.DesativaEdits;
var
 I: Integer;
begin
  for I := 0 to (ComponentCount -1) do
  begin
    if (Components[I] is TEditColor) then
      (Components[I] as TEditColor).ReadOnly := True;
    if (Components[I] is TNumerico) then
      (Components[I] as TNumerico).ReadOnly := True;
  end;
end;

procedure TFMostraCarne.CarregaEdits(Dados: TDadosCarne);
begin
  with Dados do
  begin
    ECodigoCliente.Text := CodigoClienteC;
    ENomeCliente.Text := NomeClienteC;
    EParcela.Text := ParcelaC;
    EVencimento.Text := DateToStr(VencimentoC);
    ENumeroDocumento.Text := NumeroDocumentoC;
    EObservacoes.Text := ObservacoesC;
    EAutentificacao.Text := AutentificacaoC;
    EValorParcela.AValor := Dados.ValorParcelaC;
    EAcrDesc.AValor := Dados.AcrDescC;
    EValorTotal.AValor := Dados.ValorTotalC;
  end;
end;

procedure TFMostraCarne.CarregaDados(Dados: TDadosCarne);
begin
  with Dados do
  begin
    CodigoClienteC := ECodigoCliente.Text;
    NomeClienteC := ENomeCliente.Text;
    ParcelaC := EParcela.Text;
    VencimentoC := StrToDate(EVencimento.Text);
    NumeroDocumentoC := ENumeroDocumento.Text;
    ObservacoesC := EObservacoes.Text;
    AcrDescC := EAcrDesc.AValor;
    AutentificacaoC := EAutentificacao.Text;
    ValorParcelaC := EValorParcela.AValor;
    ValorTotalC := EValorTotal.AValor;
    CodigoClienteL := CodigoClienteC;
    NomeClienteL := NomeClienteC;
    ParcelaL := ParcelaC;
    VencimentoL := VencimentoC;
    NumeroDocumentoL := NumeroDocumentoC;
    ValorParcelaL := ValorParcelaC;
    ObservacoesL := ObservacoesC;
    AcrDescL := AcrDescC;
    AutentificacaoL := AutentificacaoC;
    ValorTotalL := ValorTotalC;
  end;
end;

procedure TFMostraCarne.CModeloCloseUp(Sender: TObject);
begin
  LimpaEdits(FMostraCarne);
  LimpaEditsNumericos(FMostraCarne);
  // Configura e limita os edits.
  if (not CAD_DOC.EOF) then
    IMP.LimitaTamanhoCampos(FMostraCarne, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFMostraCarne.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  // Configura e limita os edits.
  if (not CAD_DOC.EOF) then
    IMP.LimitaTamanhoCampos(FMostraCarne, CAD_DOCI_NRO_DOC.AsInteger);
end;

Initialization
 RegisterClasses([TFMostraCarne]);
end.
