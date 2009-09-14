unit AMostraCheque;
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
  DBTables, QuickRpt, Qrctrls, UnClassesImprimir, UnComandosImpCheque, DBClient;

type
  TFMostraCheque = class(TFormularioPermissao)
    PanelFechar: TPanelColor;
    BFechar: TBitBtn;
    BImprimir: TBitBtn;
    PainelTitulo: TPainelGradiente;
    PanelPai: TPanelColor;
    Label76: TLabel;
    Shape4: TShape;
    Label14: TLabel;
    Label5: TLabel;
    LabelCorMove2: TLabelCorMove;
    LabelCorMove3: TLabelCorMove;
    LabelCorMove5: TLabelCorMove;
    LabelCorMove6: TLabelCorMove;
    EValorCheque: Tnumerico;
    PanelModelo: TPanelColor;
    Label1: TLabel;
    CModelo: TDBLookupComboBoxColor;
    CAD_DOC: TSQL;
    CAD_DOCI_NRO_DOC: TFMTBCDField;
    CAD_DOCI_SEQ_IMP: TFMTBCDField;
    CAD_DOCC_NOM_DOC: TWideStringField;
    CAD_DOCC_TIP_DOC: TWideStringField;
    DATACAD_DOC: TDataSource;
    EDescValor2: TEditColor;
    EDescNominal: TEditColor;
    LabelCorMove8: TLabelCorMove;
    LabelCorMove11: TLabelCorMove;
    LabelCorMove12: TLabelCorMove;
    EDescValor1: TEditColor;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape2: TQRShape;
    EDiaDeposito: Tnumerico;
    EMesDeposito: Tnumerico;
    EAnodeDeposito: Tnumerico;
    QRShape7: TQRShape;
    ECidadeEmitido: TEditColor;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    LabelCorMove4: TLabelCorMove;
    LabelCorMove7: TLabelCorMove;
    LabelCorMove9: TLabelCorMove;
    LabelCorMove10: TLabelCorMove;
    LabelCorMove13: TLabelCorMove;
    LabelCorMove14: TLabelCorMove;
    LabelCorMove15: TLabelCorMove;
    Shape9: TShape;
    LabelCorMove16: TLabelCorMove;
    LabelCorMove17: TLabelCorMove;
    LabelCorMove18: TLabelCorMove;
    LabelCorMove20: TLabelCorMove;
    LabelCorMove21: TLabelCorMove;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    LabelCorMove19: TLabelCorMove;
    QRShape24: TQRShape;
    LabelCorMove26: TLabelCorMove;
    LabelCorMove1: TLabelCorMove;
    LabelCorMove27: TLabelCorMove;
    LabelCorMove28: TLabelCorMove;
    ENumeroCheque: TEditColor;
    CAD_DOCC_NOM_IMP: TWideStringField;
    DBText2: TDBText;
    ENroConta: TEditColor;
    ENroAgencia: TEditColor;
    ECodigoBanco: TEditColor;
    BOK: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure CModeloCloseUp(Sender: TObject);
    procedure EValorChequeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    DadosImprimir: TDadosCheque;
    IMP : TFuncoesImpressao;
    FechaAbrePortaEcf : Boolean;
    ImpChe : TECFBematechDP20Plus;
    procedure DesativaEdits;
    procedure ImprimeECF;
    procedure ImprimeImpressoraCheque;
  public
    { Public declarations }
    procedure ImprimeDocumento;
    procedure MostraImprime(Dados: TDadosCheque);
    procedure MostraDocumento(Dados: TDadosCheque);
    procedure CarregaDados(Dados: TDadosCheque);
    procedure CarregaEdits(Dados: TDadosCheque);
    procedure MontaChequeImprimir(Dados: TDadosCheque);
  end;

var
  FMostraCheque: TFMostraCheque;

implementation

uses APrincipal, FunSql, FunString, ConstMsg, Constantes,
     FunNumeros, FunObjeto, fundata;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraCheque.FormCreate(Sender: TObject);
begin
  ImpChe := TECFBematechDP20Plus.criar;
  FechaAbrePortaEcf := true;
  DadosImprimir := TDadosCheque.Create;
  IMP := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
  AbreTabela(CAD_DOC);
  // Configurações Iniciais.
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraCheque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  IMP.Destroy;
  ImpChe.free;
  Action := CaFree;
end;

{***************** fecha formulario ******************************************}
procedure TFMostraCheque.BFecharClick(Sender: TObject);
begin
  Close;
end;

{************* quando manda imprimir seleciona impressora ********************}
procedure TFMostraCheque.BImprimirClick(Sender: TObject);
var
  erro : boolean;
begin
  erro := false;
  if (EValorCheque.AValor = 0) or (ECidadeEmitido.text = '') or (ECodigoBanco.Text = '') then
  begin
    aviso(' ERRO - Código do Banco, Valor do cheque ou cidade possui valor inválido');
    erro := true;
  end
  else
    if not ValidaData(Trunc(EDiaDeposito.avalor), Trunc(EMesDeposito.avalor), Trunc(EAnodeDeposito.avalor)) then
      erro := true;

  if not erro then
    case varia.ImpressoraCheque of
      1 : ImprimeDocumento;
      2 : ImprimeECF;
      3 : ImprimeImpressoraCheque;
    end;
end;

{*************** imprime um documento na matricial ****************************}
procedure TFMostraCheque.ImprimeDocumento;
begin
  if ((not CAD_DOC.EOF) and (CModelo.Text <> '')) then
  begin
      IMP.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
      CarregaDados(DadosImprimir);
      IMP.ImprimeCheque(DadosImprimir); // Imprime 1 documento.
      IMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
  end
  else
    Aviso('Não existe modelo de documento para imprimir.');
end;

{************* imprime um documento na impressora ECF ************************}
procedure TFMostraCheque.ImprimeECF;
begin
{  if FechaAbrePortaEcf then
   ecf.AbrePorta;
  ecf.ImprimeCheque( EValorCheque.avalor, EDescNominal.Text, ECidadeEmitido.text,
                     MontaData(StrToInt(EDiaDeposito.text),StrToInt(EMesDeposito.text), StrToInt(EAnodeDeposito.text)) );
  if FechaAbrePortaEcf then
    ecf.FecharPorta;}
end;

{***************** imprime atraves da impressora de cheque ****************** }
procedure  TFMostraCheque.ImprimeImpressoraCheque;
begin
  ImpChe.AbrePorta('com2');
  ImpChe.ImprimeCheques('001','125.5','sergio','Curitiba','10102000',Pchar('oiiiiii'));
  ImpChe.FecharPorta('com2');
end;

{************* mostra e imprime conforme impressora *************************}
procedure TFMostraCheque.MostraImprime(Dados: TDadosCheque);
begin
  FechaAbrePortaEcf := False;
  BOK.Visible := false;
  CarregaEdits(dados);
  Self.ShowModal;
end;

{****** mostra apenas o cheque para visualizacao nao permite imprimir *********}
procedure TFMostraCheque.MostraDocumento(Dados: TDadosCheque);
begin
  // Inicializa as variaveis
  BOK.Visible := True;

  CarregaEdits(Dados);
  DesativaEdits;

  if BImprimir.Visible then
    Height := Height - PanelModelo.Height - PanelFechar.Height - PainelTitulo.Height;
  BImprimir.Visible := False;
  PanelModelo.Visible := False;
  PanelFechar.Visible := False;
  PainelTitulo.Visible := False;
  ActiveControl :=  BOK;
  if BImprimir.Visible then
    Height := Height - PanelModelo.Height - PanelFechar.Height - PainelTitulo.Height;
  DesativaEdits;
  //coloca o formulario no topo
  FormStyle := fsStayOnTop;
  BorderStyle := bsDialog;
  //somente mostra se nao esta visivel
  if not Visible then
    Show;
end;

{*************** monta impressao do cheque **********************************}
procedure TFMostraCheque.MontaChequeImprimir(Dados: TDadosCheque);
begin
  DadosImprimir := Dados;
  CarregaEdits(DadosImprimir);
  ENumeroCheque.ReadOnly := True;
  EValorCheque.ReadOnly := True;
  ENroAgencia.Text := Dados.Agencia;
  ENroConta.Text := Dados.Conta;
  ECodigoBanco.Text := Dados.Banco;
  ENumeroCheque.Text := DadosImprimir.Numero;
  ShowModal;
end;

{******************* desativa os edits **************************************}
procedure TFMostraCheque.DesativaEdits;
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

{*************** carrega edits **********************************************}
procedure TFMostraCheque.CarregaEdits(Dados: TDadosCheque);
begin
  EValorCheque.AValor := Dados.ValorCheque;
  EDescNominal.Text := Dados.DescNominal;
  ECidadeEmitido.Text := Dados.CidadeEmitido;
  ENumeroCheque.Text := Dados.Numero;
  EDiaDeposito.AValor := StrToInt(Dados.DiaDeposito);
  EMesDeposito.AValor := StrToInt(Dados.MesDeposito);
  EAnodeDeposito.AValor := StrToInt(Dados.AnodeDeposito);
  ENroAgencia.Text := Dados.Agencia;
  ENroConta.Text := Dados.Conta;
  ECodigoBanco.Text := Dados.Banco;
  EValorChequeChange(self);
end;

{****************** carrega os dados no cheque *******************************}
procedure TFMostraCheque.CarregaDados(Dados: TDadosCheque);
begin
  Dados.ValorCheque := EValorCheque.AValor;
  Dados.DescValor1 := EDescValor1.Text;
  Dados.DescValor2 := EDescValor2.Text;
  Dados.DescNominal := EDescNominal.Text;
  Dados.CidadeEmitido := ECidadeEmitido.Text;
  Dados.DiaDeposito := EDiaDeposito.Text;
  Dados.MesDeposito := EMesDeposito.Text;
  Dados.AnodeDeposito := EAnodeDeposito.Text;
  Dados.Numero := ENumeroCheque.Text;
  Dados.Agencia := ENroAgencia.Text;
  Dados.Banco := ECodigoBanco.Text;
  Dados.Conta := ENroConta.Text;
  Dados.Traco := '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
  Dados.Observ := '';
end;

procedure TFMostraCheque.CModeloCloseUp(Sender: TObject);
begin
  // Configura e limita os edits.
  if (not CAD_DOC.EOF) then
    IMP.LimitaTamanhoCampos(FMostraCheque, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFMostraCheque.EValorChequeChange(Sender: TObject);
var
  AUX: string;
begin
  if (EValorCheque.AValor > 0) then
  begin
    AUX  := Maiusculas(RetiraAcentuacao(Extenso(EValorCheque.AValor, 'reais', 'real')));
    DivideTextoDoisComponentes( EDescValor1, EDescValor2, AUX);
  end
  else
  begin
    // Limpa descrição de valores.
    EDescValor1.Clear;
    EDescValor2.Clear;
  end;
end;

{************** configura o formulario conforme tipo de impressora ***********}
procedure TFMostraCheque.FormShow(Sender: TObject);
begin
  // Configura e limita os edits.
  case Varia.ImpressoraCheque of
    1 : begin
          if (not CAD_DOC.EOF) then
            IMP.LimitaTamanhoCampos(FMostraCheque, CAD_DOCI_NRO_DOC.AsInteger);
        end;
    2,3 : PanelModelo.Visible := false;
  end;
  EAnodeDeposito.AValor := ano(date);
  EDiaDeposito.AValor := dia(date);
  EMesDeposito.AValor  := mes(date);
end;

{******************** ajuda **************************************************}
Initialization
 RegisterClasses([TFMostraCheque]);
end.
