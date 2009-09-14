unit AMostraNotaPromissoria;

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
  DBTables, QuickRpt, Qrctrls, UnClassesImprimir, DBClient;

type
  TFMostraNotaPromissoria = class(TFormularioPermissao)
    PanelFechar: TPanelColor;
    BFechar: TBitBtn;
    BImprimir: TBitBtn;
    PainelTitulo: TPainelGradiente;
    PanelModelo: TPanelColor;
    Label1: TLabel;
    CModelo: TDBLookupComboBoxColor;
    CAD_DOC: TSQL;
    CAD_DOCI_NRO_DOC: TFMTBCDField;
    CAD_DOCI_SEQ_IMP: TFMTBCDField;
    CAD_DOCC_NOM_DOC: TWideStringField;
    CAD_DOCC_TIP_DOC: TWideStringField;
    DATACAD_DOC: TDataSource;
    Panel: TPanel;
    PanelPaiEdits: TPanelColor;
    Label76: TLabel;
    Shape4: TShape;
    Label14: TLabel;
    Label5: TLabel;
    Shape24: TShape;
    LabelCorMove1: TLabelCorMove;
    LabelCorMove6: TLabelCorMove;
    LabelCorMove4: TLabelCorMove;
    LabelCorMove2: TLabelCorMove;
    LabelCorMove3: TLabelCorMove;
    LabelCorMove5: TLabelCorMove;
    LabelCorMove7: TLabelCorMove;
    LabelCorMove8: TLabelCorMove;
    LabelCorMove9: TLabelCorMove;
    LabelCorMove10: TLabelCorMove;
    Shape1: TShape;
    LabelCorMove11: TLabelCorMove;
    LabelCorMove12: TLabelCorMove;
    LabelCorMove13: TLabelCorMove;
    LabelCorMove14: TLabelCorMove;
    LabelCorMove15: TLabelCorMove;
    Shape2: TShape;
    Shape3: TShape;
    LabelCorMove16: TLabelCorMove;
    LabelCorMove17: TLabelCorMove;
    EEnderecoEmitente: TEditColor;
    ECPFCGCEmitente: TEditColor;
    EEmitente: TEditColor;
    EDescricaoPagamento: TEditColor;
    EDescricaoValor2: TEditColor;
    EDescricaoValor1: TEditColor;
    ENumeroCGCCPF: TEditColor;
    EPessoaDuplicata: TEditColor;
    EDescricaoDuplicata2: TEditColor;
    EDescricaoDuplicata1: TEditColor;
    EValorDocumento: Tnumerico;
    ENumeroDocumento: TEditColor;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape2: TQRShape;
    EDiaVencimento: Tnumerico;
    EMesVencimento: Tnumerico;
    EAnoVencimento: Tnumerico;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    CAD_DOCC_NOM_IMP: TWideStringField;
    DBText2: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure CModeloCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EValorDocumentoChange(Sender: TObject);
  private
    IMP : TFuncoesImpressao;
    procedure DesativaEdits;
  public
    { Public declarations }
    procedure ImprimeDocumento;
    procedure MostraDocumento(Dados: TDadosPromissoria);
    procedure CarregaDados(Dados: TDadosPromissoria);
    procedure CarregaEdits(Dados: TDadosPromissoria);
  end;

var
  FMostraNotaPromissoria: TFMostraNotaPromissoria;

implementation

uses APrincipal, FunSql, FunString, ConstMsg, funnumeros, FunObjeto, Constantes;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraNotaPromissoria.FormCreate(Sender: TObject);
begin
  IMP := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
  AbreTabela(CAD_DOC);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraNotaPromissoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  IMP.Destroy;
  Action := CaFree;
end;

procedure TFMostraNotaPromissoria.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFMostraNotaPromissoria.BImprimirClick(Sender: TObject);
begin
  ImprimeDocumento;
end;

procedure TFMostraNotaPromissoria.ImprimeDocumento;
var
  Dados: TDadosPromissoria;
begin
  if ((not CAD_DOC.EOF) and (CModelo.Text <> '')) then
  begin
    Dados := TDadosPromissoria.Create;
    IMP.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
    CarregaDados(Dados);
    IMP.ImprimePromissoria(Dados); // Imprime 1 documento.
    IMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
  end
  else
    Aviso('Não existe modelo de documento para imprimir.');
end;

procedure TFMostraNotaPromissoria.MostraDocumento(Dados: TDadosPromissoria);
begin
  CarregaEdits(Dados);
  BImprimir.Visible := False;
  PanelModelo.Visible := False;
  PanelFechar.Visible := False;
  PainelTitulo.Visible := False;
  Height := Height - PanelModelo.Height - PanelFechar.Height - PainelTitulo.Height;
  DesativaEdits;
  FormStyle := fsStayOnTop;
  BorderStyle := bsDialog;
  Show;
end;

procedure TFMostraNotaPromissoria.DesativaEdits;
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

procedure TFMostraNotaPromissoria.CarregaEdits(Dados: TDadosPromissoria);
begin
  EDiaVencimento.Text := Dados.DiaVencimento;
  EMesVencimento.Text := Dados.MesVencimento;
  EAnoVencimento.Text := Dados.AnoVencimento;
  ENumeroDocumento.Text := Dados.NumeroDocumento;
  EValorDocumento.AValor := Dados.ValorDocumento;
  EDescricaoDuplicata1.Text := Dados.DescricaoDuplicata1;
  EDescricaoDuplicata2.Text := Dados.DescricaoDuplicata2;
  EPessoaDuplicata.Text := Dados.PessoaDuplicata;
  ENumeroCGCCPF.Text := Dados.NumeroCGCCPF;
  EDescricaoValor1.Text := Dados.DescricaoValor1;
  EDescricaoValor2.Text := Dados.DescricaoValor2;
  EDescricaoPagamento.Text := Dados.DescricaoPagamento;
  EEmitente.Text := Dados.Emitente;
  ECPFCGCEmitente.Text := Dados.CPFCGCEmitente;
  EEnderecoEmitente.Text := Dados.EnderecoEmitente;
end;

procedure TFMostraNotaPromissoria.CarregaDados(Dados: TDadosPromissoria);
begin
  Dados.DiaVencimento := EDiaVencimento.Text;
  Dados.MesVencimento := EMesVencimento.Text;
  Dados.AnoVencimento := EAnoVencimento.Text;
  Dados.NumeroDocumento := ENumeroDocumento.Text;
  Dados.ValorDocumento := EValorDocumento.AValor;
  Dados.DescricaoDuplicata1 := EDescricaoDuplicata1.Text;
  Dados.DescricaoDuplicata2 := EDescricaoDuplicata2.Text;
  Dados.PessoaDuplicata := EPessoaDuplicata.Text;
  Dados.NumeroCGCCPF := ENumeroCGCCPF.Text;
  Dados.DescricaoValor1 := EDescricaoValor1.Text;
  Dados.DescricaoValor2 := EDescricaoValor2.Text;
  Dados.DescricaoPagamento := EDescricaoPagamento.Text;
  Dados.Emitente := EEmitente.Text;
  Dados.CPFCGCEmitente := ECPFCGCEmitente.Text;
  Dados.EnderecoEmitente := EEnderecoEmitente.Text;
end;

procedure TFMostraNotaPromissoria.CModeloCloseUp(Sender: TObject);
begin
  // Limpa os Edits.
  LimpaEdits(FMostraNotaPromissoria);
  LimpaEditsNumericos(FMostraNotaPromissoria);
  // Configura e limita os edits.
  if (not CAD_DOC.EOF) then
    IMP.LimitaTamanhoCampos(FMostraNotaPromissoria, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFMostraNotaPromissoria.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  // Configura e limita os edits.
  if (not CAD_DOC.EOF) then
    IMP.LimitaTamanhoCampos(FMostraNotaPromissoria, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFMostraNotaPromissoria.EValorDocumentoChange(Sender: TObject);
var
  AUX: string;
begin
  if (EValorDocumento.AValor > 0) then
  begin
    AUX  := Maiusculas(RetiraAcentuacao(Extenso(EValorDocumento.AValor, 'reais', 'real')));
    DivideTextoDoisComponentes(EDescricaoValor1, EDescricaoValor2, AUX);
  end
  else
  begin
    // Limpa descrição de valores.
    EDescricaoValor1.Clear;
    EDescricaoValor2.Clear;
  end;
end;

Initialization
 RegisterClasses([TFMostraNotaPromissoria]);
end.
