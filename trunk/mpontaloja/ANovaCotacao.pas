unit ANovaCotacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Db, DBTables, ExtCtrls, Componentes1, Buttons, Localizacao,
  Mask, DBCtrls, Tabela, Grids, DBGrids, DBKeyViolation, UnCotacao, UnDadosProduto,UnImpressao,
  ConvUnidade, Parcela,UnProdutos, UnClientes, UnDados, CGrades, numericos, UnContasAReceber,
  PainelGradiente, Menus, ComCtrls, UnDadosCR, FMTBcd, DBClient, SqlExpr;

type
  TFNovaCotacao = class(TFormularioPermissao)
    PanelColor2: TPanelColor;
    Aux: TSQLQuery;
    Localiza: TConsultaPadrao;
    BFechar: TBitBtn;
    ValidaUnidade: TValidaUnidade;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BImprimir: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    CriaParcelas: TCriaParcelasReceber;
    BCadastrar: TBitBtn;
    MClientes: TPopupMenu;
    Trocas1: TMenuItem;
    MImpressao: TPopupMenu;
    MImprimirOp: TMenuItem;
    Paginas: TPageControl;
    PCotacao: TTabSheet;
    ScrollBox1: TScrollBox;
    PRodaPe: TPanel;
    PTransportadora: TPanel;
    Shape7: TShape;
    Label15: TLabel;
    SpeedButton4: TSpeedButton;
    LTransportadora: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label33: TLabel;
    Label57: TLabel;
    Label55: TLabel;
    ETransportadora: TEditLocaliza;
    EPlaVeiculo: TEditColor;
    EUFPlaVeiculo: TEditColor;
    ECNPJTransportadora: TEditColor;
    EEndTransportadora: TEditColor;
    ECidTransportadora: TEditColor;
    EIETransportadora: TEditColor;
    EUFTransportadora: TEditColor;
    EQtdTransportadora: Tnumerico;
    EEspTransportadora: TEditColor;
    EMarTransportadora: TEditColor;
    ENumTransportadora: Tnumerico;
    EPesoBruto: Tnumerico;
    EPesoLiquido: Tnumerico;
    ETipFrete: Tnumerico;
    PObservacao: TPanel;
    Shape5: TShape;
    Caption15: TLabel;
    Label13: TLabel;
    Label34: TLabel;
    Shape19: TShape;
    Label32: TLabel;
    Shape18: TShape;
    EObservacoes: TMemoColor;
    EDatPrevista: TMaskEditColor;
    EDatValidade: TMaskEditColor;
    EHorPrevista: TMaskEditColor;
    CAcrescimoDesconto: TRadioGroup;
    CValorPercentual: TRadioGroup;
    EDesconto: Tnumerico;
    PDadosGrafica: TPanel;
    Shape9: TShape;
    Label35: TLabel;
    Label36: TLabel;
    CDigital: TRadioButton;
    COffSEt: TRadioButton;
    EValTaxa: Tnumerico;
    PEstagios: TTabSheet;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    Estagios: TSQL;
    EstagiosCODEST: TFMTBCDField;
    EstagiosNOMEST: TWideStringField;
    EstagiosDATESTAGIO: TSQLTimeStampField;
    EstagiosC_NOM_USU: TWideStringField;
    DataEstagios: TDataSource;
    EDesServico: TEditColor;
    Label37: TLabel;
    N1: TMenuItem;
    FormurioGarantia1: TMenuItem;
    PTecnico: TPanel;
    Shape10: TShape;
    Label38: TLabel;
    ECodTecnico: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    Label40: TLabel;
    PChamado: TPanel;
    Shape11: TShape;
    EDesProblema: TMemoColor;
    EValChamado: Tnumerico;
    Label39: TLabel;
    Label41: TLabel;
    EValDeslocamento: Tnumerico;
    N2: TMenuItem;
    ChamadoTcnico1: TMenuItem;
    N3: TMenuItem;
    Envelope1: TMenuItem;
    N4: TMenuItem;
    Boleto1: TMenuItem;
    BGeraCupom: TBitBtn;
    PObservacaoFiscal: TPanel;
    Shape12: TShape;
    Label46: TLabel;
    EObservacaoFiscal: TMemoColor;
    N5: TMenuItem;
    Brindes1: TMenuItem;
    EValFrete: Tnumerico;
    Label47: TLabel;
    EEnderecoAtendimento: TEditColor;
    Label48: TLabel;
    ESolicitante: TEditColor;
    Label49: TLabel;
    EServicoExecutado: TMemoColor;
    DBMemoColor1: TDBMemoColor;
    EstagiosDESMOTIVO: TWideStringField;
    Splitter1: TSplitter;
    BEntregador: TBitBtn;
    PCliente: TPanel;
    LNomeFantasia: TLabel;
    Shape8: TShape;
    Label16: TLabel;
    SpeedButton6: TSpeedButton;
    Label31: TLabel;
    ECor: TEditLocaliza;
    ETipoCotacao: TEditLocaliza;
    EEmbalagem: TEditLocaliza;
    PainelTempo1: TPainelTempo;
    PVendedor: TPanel;
    Shape4: TShape;
    Shape3: TShape;
    Shape2: TShape;
    Label3: TLabel;
    BVendedor: TSpeedButton;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpeedButton3: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    SpeedButton5: TSpeedButton;
    Label6: TLabel;
    Label14: TLabel;
    SpeedButton7: TSpeedButton;
    LPreposto: TLabel;
    BPreposto: TSpeedButton;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    LFormaPagamento2: TLabel;
    SFormaPagamento: TSpeedButton;
    LFormaPagamento: TLabel;
    EVendedor: TEditLocaliza;
    ENumCotacao: TEditColor;
    EDataCotacao: TEditColor;
    EHoraCotacao: TEditColor;
    ECondPagamento: TEditLocaliza;
    EValorTotal: TEditColor;
    EPerComissao: Tnumerico;
    GProdutos: TRBStringGridColor;
    ETotalComDesconto: TEditColor;
    ECodPreposto: TEditLocaliza;
    EComissaoPreposto: Tnumerico;
    EFormaPagamento: TEditLocaliza;
    PTabelaPreco: TPanel;
    PServico: TPanel;
    Shape6: TShape;
    GServicos: TRBStringGridColor;
    Shape13: TShape;
    Label50: TLabel;
    ETabelaPreco: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label51: TLabel;
    PMedico: TPanel;
    Shape14: TShape;
    Label52: TLabel;
    SpeedButton9: TSpeedButton;
    Label53: TLabel;
    EMedico: TEditLocaliza;
    ENumReceita: TEditColor;
    Label54: TLabel;
    ETipoReceita: TComboBoxColor;
    Label56: TLabel;
    Label58: TLabel;
    EDatReceita: TMaskEditColor;
    LNomComputador: TLabel;
    MCadastrar: TPopupMenu;
    Alterar1: TMenuItem;
    PEmails: TTabSheet;
    ORCAMENTOEMAIL: TSQL;
    DataORCAMENTOEMAIL: TDataSource;
    ORCAMENTOEMAILDATEMAIL: TSQLTimeStampField;
    ORCAMENTOEMAILDESEMAIL: TWideStringField;
    ORCAMENTOEMAILC_NOM_USU: TWideStringField;
    GEmails: TGridIndice;
    PCompose: TPanel;
    Shape15: TShape;
    GCompose: TRBStringGridColor;
    ECorCompose: TEditLocaliza;
    DBMemoColor2: TDBMemoColor;
    EstagiosLOGALTERACAO: TWideStringField;
    ETamanho: TEditLocaliza;
    MCupom: TPopupMenu;
    NotaFiscaldeServico1: TMenuItem;
    N6: TMenuItem;
    SomenteServicos1: TMenuItem;
    Shape16: TShape;
    EValTroca: Tnumerico;
    Label60: TLabel;
    PImagem: TPanel;
    Foto: TImage;
    Shape17: TShape;
    Panel1: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    LEnderecoCliente: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    LCNPJ: TLabel;
    Label42: TLabel;
    Label59: TLabel;
    ECliente: TEditLocaliza;
    EContato: TEditColor;
    EOrdemCompra: TEditColor;
    EConsultaSerasa: TEditColor;
    CPendenciaSerasa: TCheckBox;
    EEmailContato: TEditColor;
    PRepresentada: TPanel;
    Shape20: TShape;
    Label61: TLabel;
    SpeedButton10: TSpeedButton;
    Label62: TLabel;
    ERepresentada: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure BFecharClick(Sender: TObject);
    procedure EClienteCadastrar(Sender: TObject);
    procedure EVendedorCadastrar(Sender: TObject);
    procedure ECondPagamentoCadastrar(Sender: TObject);
    procedure MovOrcamentosAfterPost(DataSet: TDataSet);
    procedure ESituacaoChange(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ECondPagamentoSelect(Sender: TObject);
    procedure MovServicoOrcamentoAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECondPagamentoRetorno(Retorno1, Retorno2: String);
    procedure BBAjudaClick(Sender: TObject);
    procedure EVendedorRetorno(Retorno1, Retorno2: String);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ECorCadastrar(Sender: TObject);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure ECorEnter(Sender: TObject);
    procedure GProdutosDepoisExclusao(Sender: TObject);
    procedure GServicosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GServicosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GServicosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GServicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GServicosKeyPress(Sender: TObject; var Key: Char);
    procedure GServicosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GServicosNovaLinha(Sender: TObject);
    procedure GServicosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ETransportadoraRetorno(Retorno1, Retorno2: String);
    procedure ETransportadoraCadastrar(Sender: TObject);
    procedure ETipoCotacaoCadastrar(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure GProdutosEnter(Sender: TObject);
    procedure EEmbalagemCadastrar(Sender: TObject);
    procedure EEmbalagemEnter(Sender: TObject);
    procedure EEmbalagemRetorno(Retorno1, Retorno2: String);
    procedure SpeedButton7Click(Sender: TObject);
    procedure EDescontoChange(Sender: TObject);
    procedure ETipoCotacaoRetorno(Retorno1, Retorno2: String);
    procedure Trocas1Click(Sender: TObject);
    procedure EClienteAlterar(Sender: TObject);
    procedure MImprimirOpClick(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure FormurioGarantia1Click(Sender: TObject);
    procedure ECodTecnicoCadastrar(Sender: TObject);
    procedure ChamadoTcnico1Click(Sender: TObject);
    procedure Envelope1Click(Sender: TObject);
    procedure GProdutosGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure ECodPrepostoRetorno(Retorno1, Retorno2: String);
    procedure Boleto1Click(Sender: TObject);
    procedure BGeraCupomClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Brindes1Click(Sender: TObject);
    procedure ConsumoMateriaPrima1Click(Sender: TObject);
    procedure BEntregadorClick(Sender: TObject);
    procedure ETabelaPrecoSelect(Sender: TObject);
    procedure EMedicoCadastrar(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure GComposeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GComposeDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GComposeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GComposeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorComposeRetorno(Retorno1, Retorno2: String);
    procedure GComposeKeyPress(Sender: TObject; var Key: Char);
    procedure GComposeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GComposeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ETamanhoCadastrar(Sender: TObject);
    procedure ETamanhoEnter(Sender: TObject);
    procedure ETamanhoRetorno(Retorno1, Retorno2: String);
    procedure EContatoExit(Sender: TObject);
    procedure MImpressaoPopup(Sender: TObject);
    procedure SomenteServicos1Click(Sender: TObject);
    procedure EClienteSelect(Sender: TObject);
    procedure Label11DblClick(Sender: TObject);
    procedure EFormaPagamentoCadastrar(Sender: TObject);
  private
    { Private declarations }
    VprOperacao,
    VprLanOrcamento,
    VprCorAnterior : Integer;
    VprAcao : Boolean;
    VprAgrupandoCotacao : Boolean;
    VprServicoAnterior,
    VprProdutoAnterior,
    VprTamanhoAnterior,
    VprProdutoComposeAnterior,
    VprReferenciaAnterior : String;
    VprCotacoes : TList;
    VprDCliente : TRBDCliente;
    VprDCotacao,
    VprDCotacaoInicial : TRBDOrcamento;
    VprDContasaReceber : TRBDContasCR;
    VprDProCotacao,
    VprDProCopia : TRBDOrcProduto;
    VprDSerCotacao : TRBDOrcServico;
    VprDCompCotacao : TRBDOrcCompose;
    VprDTipoCotacao : TRBDTipoCotacao;
    FunCotacao : TFuncoesCotacao;
    FunClientes : TRBFuncoesClientes;
    FunProdutos : TFuncoesProduto;
    FunImpressao :  TFuncoesImpressao;
    VprTransacao : TTransactionDesc;
    function LimiteCreditoOK(VpaDCliente : TRBDCliente) : string;
    function SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : string;
    procedure CarregaDadosCliente;
    function LocalizaProduto : Boolean;
    function LocalizaProdutoCompose : Boolean;
    function ExisteProduto : Boolean;
    function ExisteProdutoCompose : Boolean;
    function Existecor : Boolean;
    function ExisteTamanho : Boolean;
    function ExisteCorCompose : Boolean;
    function ExisteEmbalagem : Boolean;
    function ExisteUM : Boolean;
    function ExisteReferenciaCliente : Boolean;
    procedure CalculaValorTotal;
    function GravaCotacao : String;
    function  LocalizaServico : Boolean;
    function ExisteServico : Boolean;
    procedure DirecionaFoco;
    //rotinas novas
    procedure CarTituloGrade;
    function CarDClasse : String;
    procedure CarDValorTotal;
    procedure CarDDesconto;
    procedure CarDProdutoOrcamento;
    procedure CarDServicoOrcamento;
    procedure CarDComposeOrcamento;
    procedure CarDTela;
    procedure CarDClienteDuplicacao;
    Procedure CarLogAlteracoes;
    procedure CarDChamado;
    procedure CarPaginaLogAlteracao;
    procedure CopiaDChamadoCotacao(VpaDChamado : TRBDChamado);
    procedure CarDTelaNovaCotacaoProsposta;
    procedure InicializaTela;
    procedure CalculaValorUnitarioPeloAlturaProduto;
    procedure CalculaValorTotalProduto;
    procedure CalculaValorTotalServico;
    procedure ConfiguraTelaChamado;
    procedure ReferenciaProduto;
    procedure AtualizaPesoBrutoLiquido;
    function GeraFinanceiro :String;
    function GravaFinanceiro : string;
    procedure ArrumaDuplicatasFinanceiro;
    function BaixarEstoque : String;
    function BaixaBrindesClientes : string;
    function AtualizaContatoCliente: String;
    function ChamaRotinasGravacao : Boolean;
    procedure AtualizaConsultaEstagios;
    procedure AlteraEnabledBotoes(VpaEstado : Boolean);
    procedure ProximoProduto;
    procedure ConfiguraPermissaoUsuario;
    procedure BaixaProdutos;
    procedure PosEmails;
    procedure AdicionaProdutosChamado(VpaDChamado : TRBDChamado);
    procedure CarFoto;
    procedure ValVendaTamanho;
  public
    { Public declarations }
    function NovaCotacao : Integer;
    function AlteraCotacao(VpaCodFilial,VpaLanOrcamento : Integer):Boolean;
    procedure ConsultaCotacao(VpaCodFilial, VpaLanOrcamento : String);
    function DuplicarPedido(VpaCodFilial,VpaLanOrcamento : Integer):Boolean;
    function NovaCotacaoCliente(VpaCodCliente : Integer):Integer;
    function NovaCotacaoChamado(VpaDChamado : TRBDChamado): Integer;
    function NovaCotacaoProposta(VpaDProposta: TRBDPropostaCorpo): Boolean;
    function AgrupaCotacao(VpaCotacoes : TList) : Boolean;
  end;

var
  FNovaCotacao: TFNovaCotacao;

implementation

uses APrincipal, Funsql, Constantes, FunObjeto, ALocalizaProdutos,  Fundata, UnCrystal,
  ANovoCliente, ConstMsg,ANovoVendedor, FunNumeros,
  AConsultaCondicaoPgto, ANovoServico, ALocalizaServico, AImpCotacao,
  ACores,FunString, UnClassesImprimir, ANovaTransportadora,
  ATipoCotacao, AEmbalagem, AProdutoReferencia, AProdutosDevolvidos,
  AMostraObservacaoCliente, ANovaNotaFiscaisFor, ANovoTecnico, UnSistema,
  ANovoECF, ABrindesCliente, AMedico, ATamanhos, ANovaNotaFiscalNota, dmRave,
  ACondicaoPagamento, ACreditoCliente, AFormasPagamento;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaCotacao.FormCreate(Sender: TObject);
begin
  VprAgrupandoCotacao := false;
  Paginas.ActivePageIndex := 0;
  FunClientes := TRBFuncoesClientes.cria(FPrincipal.BaseDados);
  FunImpressao :=  TFuncoesImpressao.Criar(Self,FPrincipal.BaseDados);
  VprDCliente := TRBDCliente.cria;
  VprDCotacao := TRBDOrcamento.cria;
  VprDCotacaoInicial := TRBDOrcamento.Cria;
  VprDTipoCotacao := TRBDTipoCotacao.cria;
  VprDContasaReceber := TRBDContasCR.cria;
  GProdutos.ADados := VprDCotacao.Produtos;
  GServicos.ADados := VprDCotacao.Servicos;
  ScrollBox1.VertScrollBar.Position := 0;
  Top := 0;
  left := 0;
  FunCotacao := TFuncoesCotacao.Cria(FPrincipal.BaseDados);
  FunProdutos := TFuncoesProduto.criar(Self,FPrincipal.BaseDados);
  ValidaUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ValidaUnidade.Ainfo.UnidadeUN := varia.unidadeUN;
  ValidaUnidade.AInfo.UnidadeKiT := varia.UnidadeKit;
  ValidaUnidade.AInfo.UnidadeBarra := varia.UnidadeBarra;
  LNomeFantasia.Caption := Varia.NomeFilial;
  CarTituloGrade;
  VprAcao := false;
  PTabelaPreco.Visible := config.UtilizarTabelaPreconaCotacao;
  ETabelaPreco.ACampoObrigatorio := Config.UtilizarTabelaPreconaCotacao;
//  PMedico.Visible := config.Farmacia;
  PMedico.Visible := false;
  PCompose.Visible := config.UtilizarCompose;
  if not ConfigModulos.Servico then
  begin
    PServico.Visible := false;
    PRodaPe.Top := PServico.Top;
    GServicos.visible := false;
  end
  else
    PRodaPe.Top := PServico.Top + PServico.Height;
  PTransportadora.Visible := config.UtilizarTransPedido;
  PDadosGrafica.Visible  := config.Grafica;
  PTecnico.Visible := Config.TecniconaCotacao;
  PObservacaoFiscal.Visible := config.ObservacaoFiscalNaCotacao;
  PImagem.Visible := config.MostrarImagemProdutoNaTeladaCotacao;
  EDatPrevista.EditMask := FPrincipal.CorFoco.AMascaraData;
  if (varia.CNPJFilial = CNPJ_Reloponto) or
     (varia.CNPJFilial = CNPJ_RLP) then
  begin
    MImprimirOp.Caption := 'Protocolo Crachá';
  end;
  Trocas1.Visible := CONFIG.ControlarTrocasnaCotacao;
  N5.Visible:= CONFIG.ControlarTrocasnaCotacao;
  ConfiguraPermissaoUsuario;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaCotacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunCotacao.free;
  FunProdutos.free;
  FunClientes.free;
  VprDCotacao.free;
  VprDCotacaoInicial.free;
  VprDCliente.free;
  FunImpressao.free;
  VprDTipoCotacao.free;
  VprDContasaReceber.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da tabela movorcamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{****************** verifica a duplicidade dos produtos ***********************}
procedure TFNovaCotacao.MovOrcamentosAfterPost(DataSet: TDataSet);
begin
//  if not  vprKit then
//    Cotacao.VerificaDuplicidadeProdutos(MovOrcamentos);  // rotina que verifica se o produto e duplicado
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos do movorcamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************** localiza o produto digitado *****************************}
Function TFNovaCotacao.LocalizaProduto : Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDCotacao, VprDProCotacao,ECliente.Ainteiro,eTabelaPreco.Ainteiro); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    if config.Farmacia then
      result := FunCotacao.VerificacoesMedicamentoControlado(VprDCotacao,VprDProCotacao);
    if result then
    begin
      with VprDProCotacao do
      begin
        if Config.CodigoBarras then
        begin
          VprDProCotacao.QtdProduto := 1;
          if (UpperCase(VprDProCotacao.UM) = 'CX') then
          begin
            VprDProCotacao.UM := 'pc';
            VprDProCotacao.ValUnitario := FunProdutos.CalculaValorPadrao('cx','pc',VprDProCotacao.ValUnitario,IntToStr(VprDProCotacao.SeqProduto));
          end;
        end;
        VprDProCotacao.UnidadeParentes.free;
        VprDProCotacao.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDProCotacao.UMOriginal);
        VprProdutoAnterior := VprDProCotacao.CodProduto;
        GProdutos.Cells[1,GProdutos.ALinha] := CodProduto;
        GProdutos.Cells[2,GProdutos.ALinha] := NomProduto;
        GProdutos.Cells[8,GProdutos.ALinha] := UM;

        VprDProCotacao.ValTotal := VprDProCotacao.ValUnitario * VprDProCotacao.QtdProduto;
        CalculaValorTotalProduto;
        CarFoto;
        if config.EstoquePorTamanho then
        begin
          ETamanho.AInteiro := VprDProCotacao.CodTamanho;
          ETamanho.Atualiza;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.LocalizaProdutoCompose : Boolean;
var
  VpfAux : Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VpfAux,VprDCompCotacao.SeqProduto,VprDCompCotacao.CodProduto,VprDCompCotacao.NomProduto); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    if result then
    begin
        VprProdutoComposeAnterior := VprDCompCotacao.CodProduto;
        GCompose.Cells[2,GCompose.ALinha] := VprDCompCotacao.CodProduto;
        GCompose.Cells[3,GCompose.ALinha] := VprDCompCotacao.NomProduto;
    end;
  end;
end;

{******************** verifica se o produto existe ****************************}
function TFNovaCotacao.ExisteProduto : Boolean;
begin
  if (GProdutos.Cells[1,GProdutos.ALinha] <> '') then
  begin
    if GProdutos.Cells[1,GProdutos.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunCotacao.ExisteProduto(GProdutos.Cells[1,GProdutos.ALinha],ETabelaPreco.AInteiro, VprDProCotacao,VprDCotacao);
      if result then
      begin
        if config.Farmacia then
          result := FunCotacao.VerificacoesMedicamentoControlado(VprDCotacao,VprDProCotacao);
        if result then
        begin
          VprDProCotacao.UnidadeParentes.free;
          VprDProCotacao.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDProCotacao.UMOriginal);
          VprProdutoAnterior := VprDProCotacao.CodProduto;
          GProdutos.Cells[1,GProdutos.ALinha] := VprDProCotacao.CodProduto;
          GProdutos.Cells[2,GProdutos.ALinha] := VprDProCotacao.NomProduto;
          GProdutos.Cells[8,GProdutos.ALinha] := VprDProCotacao.UM;
          VprDProCotacao.ValTotal := VprDProCotacao.ValUnitario * VprDProCotacao.QtdProduto;
          ReferenciaProduto;
          CalculaValorTotalProduto;
          CarFoto;
        end;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaCotacao.ExisteProdutoCompose : Boolean;
var
  VpfAux : String;
begin
  if (GCompose.Cells[2,GCompose.ALinha] <> '') then
  begin
    if GCompose.Cells[2,GCompose.ALinha] = VprProdutoComposeAnterior then
      result := true
    else
    begin
      result := FunProdutos.ExisteProduto(GCompose.Cells[2,GCompose.ALinha],VprDCompCotacao.SeqProduto,VprDCompCotacao.NomProduto,VpfAux);
      if result then
      begin
        if result then
        begin
          VprDCompCotacao.CodProduto := GCompose.Cells[2,GCompose.ALinha];
          VprProdutoComposeAnterior :=VprDCompCotacao.CodProduto;
          GCompose.Cells[3,GCompose.ALinha] := VprDCompCotacao.NomProduto;
        end;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaCotacao.Existecor : Boolean;
begin
  result := false;
  if (GProdutos.Cells[3,GProdutos.Alinha]<> '') then
  begin
    if StrToInt(GProdutos.Cells[3,GProdutos.Alinha]) = VprCorAnterior then
      result := true
    else
    begin
      result := FunCotacao.Existecor(GProdutos.Cells[3,GProdutos.ALinha],VprDProCotacao);
      if result then
      begin
        GProdutos.Cells[4,GProdutos.ALinha] := VprDProCotacao.DesCor;
        ReferenciaProduto;
        VprCorAnterior := VprDProCotacao.CodCor;
        ValVendaTamanho;
      end;
    end;
  end;
  if not result then
  begin
    FreeTObjectsList(VprDProCotacao.Compose);
    GCompose.CarregaGrade;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.ExisteTamanho : Boolean;
begin
  result := true;
  if (GProdutos.Cells[5,GProdutos.Alinha]<> VprTamanhoAnterior) then
  begin
    if (GProdutos.Cells[5,GProdutos.Alinha]<> '') then
    begin
        result := FunCotacao.ExisteTamanho(GProdutos.Cells[5,GProdutos.ALinha],VprDProCotacao.nomTamanho);
        if result then
        begin
          VprDProCotacao.CodTamanho := StrToInt(GProdutos.Cells[5,GProdutos.Alinha]);
          VprTamanhoAnterior := GProdutos.Cells[5,GProdutos.Alinha];
          GProdutos.Cells[6,GProdutos.ALinha] := VprDProCotacao.NomTamanho;
          ValVendaTamanho;
        end
        else
          GProdutos.Cells[6,GProdutos.ALinha] := '';
    end;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.ExisteCorCompose : Boolean;
begin
  result := false;
  if (GCompose.Cells[4,GCompose.Alinha]<> '') then
  begin
    result := FunProdutos.ExisteCor(GCompose.Cells[4,GCompose.ALinha],VprDCompCotacao.NomCor);
    if result then
    begin
      GCompose.Cells[5,GCompose.ALinha] := VprDCompCotacao.NomCor;
      VprDCompCotacao.CodCor := StrToInt(GCompose.Cells[4,GCompose.ALinha]);
    end;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.ExisteEmbalagem : Boolean;
begin
  result := false;
  if (GProdutos.Cells[15,GProdutos.Alinha]<> '') then
  begin
    result := FunCotacao.ExisteEmbalagem(GProdutos.Cells[15,GProdutos.ALinha],VprDProCotacao);
    if result then
    begin
      GProdutos.Cells[16,GProdutos.ALinha] := VprDProCotacao.DesEmbalagem;
    end;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.ExisteUM : Boolean;
begin
  if (VprDProCotacao.UMAnterior = GProdutos.cells[8,GProdutos.ALinha]) then
    result := true
  else
  begin
    result := (VprDProCotacao.UnidadeParentes.IndexOf(GProdutos.Cells[8,GProdutos.Alinha]) >= 0);
    if result then
    begin
      VprDProCotacao.UM := GProdutos.Cells[8,GProdutos.Alinha];
      VprDProCotacao.UMAnterior := VprDProCotacao.UM;
      VprDProCotacao.ValUnitario := FunProdutos.ValorPelaUnidade(VprDProCotacao.UMOriginal,VprDProCotacao.UM,VprDProCotacao.SeqProduto,
                                               VprDProCotacao.ValUnitarioOriginal);
      CalculaValorTotalProduto;
    end;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.ExisteReferenciaCliente : Boolean;
begin
  result := FunProdutos.CarProdutodaReferencia(GProdutos.Cells[13,GProdutos.ALinha],ECliente.Ainteiro,VprDProCotacao.CodProduto,VprDProCotacao.CodCor);
  if result then
  begin
    GProdutos.Cells[1,GProdutos.Alinha] := VprDProCotacao.CodProduto;
    VprProdutoAnterior := '';
    ExisteProduto;
    GProdutos.Cells[3,GProdutos.ALinha] := IntToStr(VprDProCotacao.CodCor);
    Existecor;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       eventos da tabela servico orcamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{************************ faz as operações apos gravar ************************}
procedure TFNovaCotacao.MovServicoOrcamentoAfterPost(DataSet: TDataSet);
begin
//  FunCotacao.VerificaDuplicidadeServico(MovServicoOrcamento);  // rotina que verifica se o produto e duplicado
  CalculaValorTotal;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          eventos do servico orcamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************** localiza o servico ********************************}
function  TFNovaCotacao.LocalizaServico : Boolean;
begin

  FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
  result := FlocalizaServico.LocalizaServico(VprDSerCotacao);
  FlocalizaServico.free; // destroi a classe;

  if result then  // se o usuario nao cancelou a consulta
  begin
    VprDSerCotacao.QtdServico := 1;
    GServicos.Cells[1,GServicos.ALinha] := IntToStr(VprDSerCotacao.CodServico);
    GServicos.Cells[2,GServicos.ALinha] := VprDSerCotacao.NomServico;
    GServicos.Cells[4,GServicos.ALinha] :=  FormatFloat('###,###,###,##0.000',VprDSerCotacao.QtdServico);
    GServicos.Cells[5,GServicos.ALinha] :=  FormatFloat('###,###,###,##0.0000',VprDSerCotacao.ValUnitario);
    VprServicoAnterior := GServicos.Cells[1,GServicos.ALinha];
    CalculaValorTotalServico;
  end;
end;

{************** Verifica se existe o servico digitado *************************}
function TFNovaCotacao.ExisteServico : Boolean;
begin
  if (GServicos.Cells[1,GServicos.ALinha] <> '') then
  begin
    if (GServicos.Cells[1,GServicos.ALinha] = VprServicoAnterior)  then
      result := true
    else
    begin
      result := FunCotacao.ExisteServico(GServicos.Cells[1,GServicos.ALinha],VprDSerCotacao);
      if result then
      begin
        VprServicoAnterior := GServicos.Cells[1,GServicos.ALinha];
        GServicos.Cells[2,GServicos.Alinha] := VprDSerCotacao.NomServico;
        GServicos.Cells[4,GServicos.ALinha] :=  FormatFloat('###,###,###,##0.000',VprDSerCotacao.QtdServico);
        GServicos.Cells[5,GServicos.ALinha] :=  FormatFloat('###,###,###,##0.0000',VprDSerCotacao.ValUnitario);
        CalculaValorTotalServico;
      end;
    end;
  end
  else
    result := false;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaCotacao.Label11DblClick(Sender: TObject);
begin
  if Confirmacao('Tem certeza que deseja excluir todos os produtos?')then
  begin
    FreeTObjectsList(VprDCotacao.Produtos);
    GProdutos.CarregaGrade;
  end;
end;

function TFNovaCotacao.LimiteCreditoOK(VpaDCliente : TRBDCliente) : string;
var
  VpfValAlteracao : Double;
begin
  result := '';
  VpfValAlteracao := 0;
  if VprOperacao = 2 then // alteracao
    VpfValAlteracao := VprDCotacaoInicial.ValTotal;
  if (config.LimiteCreditoCliente) and(ECondPagamento.AInteiro <> varia.CondPagtoVista)  then
  begin
    if (VprDCliente.LimiteCredito < (VprDCliente.DuplicatasEmAberto + VprDCotacao.ValTotal - VpfValAlteracao)) then
    begin
     result := 'CLIENTE COM LIMITE DE CRÉDITO ESTOURADO!!!'#13'Esse cliente possui um limite de crédito de "'+FormatFloat('#,###,###,##0.00',VprDCliente.LimiteCredito)+
            '", e o valor das duplicatas em aberto somam "'+FormatFloat('#,###,###,##0.00',VprDCliente.DuplicatasEmAberto + VprDCotacao.ValTotal-VpfValAlteracao)+ '".';
    end;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : string;
begin
  result := LimiteCreditoOK(VpaDCliente);
  if result = '' then
  begin
    if config.BloquearClienteEmAtraso then
    begin
      if VprDCliente.DuplicatasEmAtraso > 0 then
      begin
        if not Confirmacao('CLIENTE COM DUPLICATAS VENCIDAS!!!'#13'Este cliente possui duplicatas vencidas no valor de "'+FormatFloat('#,###,###,###,##0.00',VprDCliente.DuplicatasEmAtraso)+'". Deseja faturar para esse cliente ?') then
        begin
          ECliente.Clear;
          result := 'NÃO FOI POSSÍVEL GRAVAR O CLIENTE!!!'#13'Cliente com duplicatas vencidas.';
        end;
      end;
    end;
  end;
  if VprDCliente.IndBloqueado then
  begin
    result := 'CLIENTE BLOQUEADO!!!'#13'Este cliente encontra-se bloqueado, não é permitido fazer cotações para clientes bloqueados. Solicite o desbloqueio desse cliente.';
    ECliente.clear;
    VprDCotacao.CodCliente := 0;
  end;
  if result = '' then
  begin
    if varia.QtdMesesSemConsultaSerasa > 0  then
    begin
      if IncMes(VprDCliente.DatUltimaConsultaSerasa,Varia.QtdMesesSemConsultaSerasa) < date then
      begin
        result := 'CLIENTE JÁ ESTÁ A MAIS DE '+IntToStr(Varia.QtdMesesSemConsultaSerasa)+ ' MESES SEM CONSULTAR O SERASA!!!'#13'A última consulta realizada no Serasa foi em "'+FormatDateTime('DD/MM/YYYY',VpaDCliente.DatUltimaConsultaSerasa)+'", é necessário fazer uma nova consulta.';
        ECliente.Clear;
      end;

    end;

  end;
end;

{******************* carrega os dados do cliente ******************************}
procedure TFNovaCotacao.CarregaDadosCliente;
var
  VpfResultado : String;
begin
  if ECliente.Ainteiro <> VprDCotacao.CodCliente then
  begin
    VprDCotacao.CodCliente := ECliente.AInteiro;
    VprDCliente.CodCliente :=  VprDCotacao.CodCliente;
    if VprDCliente.CodCliente <> 0 then
    begin
      FunClientes.CarDCliente(VprDCliente);
      //carrega o nome do contato
      if (VprOperacao in [1,2]) then
      begin
        VprDCotacao.RGCliente := VprDCliente.RG;
        VprDCotacao.IndClienteRevenda := VprDCliente.IndRevenda;
        VpfResultado := SituacaoFinanceiraOK(VprDCliente);
        if VpfResultado <> '' then
          aviso(VpfResultado);
        if config.NaCotacaoBuscaroContato then
        begin
          EContato.Text := VprDCliente.NomContato;
          EEmailContato.Text:= VprDCliente.DesEmail;
        end;
        if (VprDCliente.CodTipoCotacao <> 0) and CONFIG.PermitirAlterarTipoCotacao then
        begin
          ETipoCotacao.AInteiro := VprDCliente.CodTipoCotacao;
          ETipoCotacao.Atualiza;
        end;
        //carrega a condicao de pagamento
        if (VprDCliente.CodCondicaoPagamento <> 0)  then
        begin
          ECondPagamento.AInteiro := VprDCliente.CodCondicaoPagamento;
          ECondPagamento.Atualiza;
        end;
        //carrega o vendedor
        if (VprDCliente.CodVendedor <> 0)  then
        begin
          EVendedor.AInteiro := VprDCliente.CodVendedor;
          EVendedor.Atualiza;
        end;
        if not config.PermitirAlterarVendedornaCotacao then
        begin
          if VprDCliente.CodVendedor <> 0 then
            EVendedor.AInteiro := VprDCliente.CodVendedor
          else
            EVendedor.AInteiro := varia.CodVendedorCotacao;
          EVendedor.Atualiza;
        end;
        if (VprDCliente.CodVendedorPreposto <> 0) then
        begin
          ECodPreposto.AInteiro := VprDCliente.CodVendedorPreposto;
          ECodPreposto.Atualiza;
        end;

        if (VprDCliente.CodTecnico <> 0) and (ECodTecnico.AInteiro = 0) then
        begin
          ECodTecnico.AInteiro := VprDCliente.CodTecnico;
          ECodTecnico.Atualiza;
        end;
        //carrega o vendedor
        if (VprDCliente.PerComissao <> 0) then
          EPerComissao.AValor:= VprDCliente.PerComissao;
        if (VprDCliente.CodTransportadora <> 0) and (PTransportadora.Visible) then
        begin
          ETransportadora.AInteiro := VprDCliente.CodTransportadora;
          ETransportadora.Atualiza;
        end;
        if (VprDCliente.CodFormaPagamento <> 0) and (EFormaPagamento.AInteiro = varia.FormaPagamentoPadrao) then
        begin
          EFormaPagamento.AInteiro := VprDCliente.CodFormaPagamento;
          EFormaPagamento.Atualiza;
        end;
        if VprDCliente.PerDescontoCotacao <> 0 then
        begin
          EDesconto.AValor := VprDCliente.PerDescontoCotacao;
          CAcrescimoDesconto.ItemIndex := 1;
          CValorPercentual.ItemIndex := 1;
        end;
        CPendenciaSerasa.Checked := VprDCliente.IndPendenciaSerasa;
        EConsultaSerasa.Clear;
        if VprDCliente.DatUltimaConsultaSerasa > montadata(1,1,1900) then
        begin
          EConsultaSerasa.Text := FormatDateTime('DD/MM/YYYY',VprDCliente.DatUltimaConsultaSerasa);
          if VprDCliente.DatUltimaConsultaSerasa < DecMes(date,6) then
            EConsultaSerasa.Font.Color := clred
          else
            EConsultaSerasa.Font.Color := clblack;
        end;
        if config.UtilizarTabelaPreconaCotacao then
        begin
          if VprDCliente.CodTabelaPreco <> 0 then
            ETabelaPreco.AInteiro := VprDCliente.CodTabelaPreco
          else
            ETabelaPreco.AInteiro := Varia.TabelaPreco;
          ETabelaPreco.atualiza;
        end;
        CarDChamado;
        //atualiza o valor unitario conforme o cliente.
        // foi colocado em comentário por causa da Zumm.
        //FunCotacao.AlteraPrecoProdutosPorCliente(VprDCotacao);
        GProdutos.CarregaGrade;
        CalculaValorTotal;
      end;
      LEnderecoCliente.caption :=  VprDCliente.DesEndereco + ', '+ VprDCliente.NumEndereco +
                                  '   ' + VprDCliente.DesBairro + '    Fone: '+VprDCliente.DesFone1 + '   CEP ' +VprDCliente.CepCliente + '      ' +
                                  VprDCliente.DesCidade+ '/' + VprDCliente.DesUF;
      if VprDCliente.TipoPessoa = 'F' then
        LCNPJ.Caption := 'CPF : '+ VprDCliente.CGC_CPF
      else
        LCNPJ.Caption := 'CNPJ : '+ VprDCliente.CGC_CPF;
      if VprDCliente.DesObservacao <> '' then
      begin
        FMostraObservacaoCliente := TFMostraObservacaoCliente.CriarSDI(application , '', FPrincipal.VerificaPermisao('FMostraObservacaoCliente'));
        FMostraObservacaoCliente.MostraObservacaoCliente(VprDCliente);
        FMostraObservacaoCliente.free;
      end;
      if VprOperacao in [1,2] then
      begin
        if config.MostrarNotasDevolvidasnaVenda then
        begin
          if FunProdutos.existeprodutosDevolvidos(ECliente.Text) then
          begin
            FProdutosDevolvidos := TFProdutosDevolvidos.CriarSDI(application , '', FPrincipal.VerificaPermisao('FProdutosDevolvidos'));;
            FProdutosDevolvidos.MostraNotasCliente(ECliente.Text);
            FProdutosDevolvidos.free;
          end;
        end;
        FCreditoCliente := TFCreditoCliente.CriarSDI(application , '', FPrincipal.VerificaPermisao('FCreditoCliente'));
        FCreditoCliente.ConsultaCreditoCliente(VprDCliente.CodCliente);
        FCreditoCliente.free;
      end;
    end
    else
      LimpaLabel([LEnderecoCliente]);
  end;
end;

{********************** faz uma nova cotacao **********************************}
function TFNovaCotacao.NovaCotacao :Integer;
begin
  result := 0;
  VprOperacao := 1;
  InicializaTela;
  showmodal;
  if VprAcao then
    result := VprLanOrcamento;
end;

{************************ altera uma cotacao **********************************}
function TFNovaCotacao.AlteraCotacao(VpaCodFilial,VpaLanOrcamento : Integer) :Boolean;
begin
  VprOperacao := 3;
  FunCotacao.CarDOrcamento(VprDCotacao,VpaCodFilial,VpaLanOrcamento);
  FunCotacao.CarDOrcamento(VprDCotacaoInicial,VpaCodFilial,VpaLanOrcamento);
  VprDCliente.CodCliente :=  VprDCotacao.CodCliente;
  FunClientes.CarDCliente(VprDCliente);
  ENumCotacao.ReadOnly := true;

  CarDTela;
  FunCotacao.AdicionaPaginasLogAlteracao(VprDCotacao,Paginas);
  GProdutos.CarregaGrade;
  if GServicos.Visible then
    GServicos.CarregaGrade;
  VprOperacao := 2;
  AlteraEnabledBotoes(true);
  AlteraReadOnlyDet(ScrollBox1,0,false);
  ActiveControl := ECliente;
  if not Visible then
    ShowModal; // mostra o formulario
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaCotacao.DuplicarPedido(VpaCodFilial,VpaLanOrcamento : Integer):Boolean;
begin
  VprOperacao := 1;
  VprDCotacao.CodEmpFil := VpaCodFilial;
  VprDCotacao.LanOrcamento := VpaLanOrcamento;
  FunCotacao.CarDOrcamento(VprDCotacao);
  VprDCotacao.CodEmpFil := varia.CodigoEmpFil;
  VprDCliente.CodCliente :=  VprDCotacao.CodCliente;
  FunClientes.CarDCliente(VprDCliente);
  CarDClienteDuplicacao;
  FunCotacao.ZeraQtdBaixada(VprDCotacao);
  VprDCotacao.LanOrcamento := 0;
  VprDCotacao.DatOrcamento := date;
  VprDCotacao.HorOrcamento := now;
  if config.GerarFinanceiroCotacao then
    VprDCotacao.DatEntrega := date
  else
    VprDCotacao.DatEntrega := 0;
  VprDCotacao.DatValidade := incDia(Date,Varia.DiasValidade);
  VprDCotacao.NumNotas := '';
  VprDCotacao.NumCupomfiscal := '';
  VprDCotacao.IndNotaGerada := false;
  VprDCotacao.FinanceiroGerado := false;
  VprDCotacao.OPImpressa := false;
  VprDCotacao.CodUsuario := Varia.CodigoUsuario;
  VprDCotacao.CodEstagio := varia.EstagioOrdemProducao;
  VprDCotacao.NomComputador := Varia.NomeComputador;
  VprDCotacao.IndPendente := true;
  VprDCotacao.IndNumeroBaixado := false;
  VprDCotacao.FlaSituacao := 'A';
  VprDCotacao.IndProcessada := false;
  CarDTela;
  EDatPrevista.Clear;
  EHorPrevista.Clear;
  GProdutos.CarregaGrade;
  if GServicos.Visible then
    GServicos.CarregaGrade;
  VprOperacao := 1;
  ShowModal; // mostra o formulario
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaCotacao.NovaCotacaoCliente(VpaCodCliente : Integer):integer;
begin
  VprOperacao := 1;
  result := 0;
  InicializaTela;
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  ActiveControl := GProdutos;
  showmodal;
  if Vpracao then
    result := VprLanOrcamento;
end;

{******************************************************************************}
function TFNovaCotacao.NovaCotacaoChamado(VpaDChamado : TRBDChamado): Integer;
begin
  VprOperacao := 1;
  Result := 0;
  InicializaTela;
  CopiaDChamadoCotacao(VpaDChamado);
  showmodal;
  if vpracao then
    result := VprLanOrcamento;
end;

{******************************************************************************}
function TFNovaCotacao.AgrupaCotacao(VpaCotacoes : TList) : Boolean;
begin
  VprCotacoes := VpaCotacoes;
  VprAgrupandoCotacao := true;
  VprOperacao := 3;
  InicializaTela;
  VprDCotacao.free;
  VprDCotacao := FunCotacao.AgrupaCotacoes(VpaCotacoes,false);
  VprDCotacaoInicial := FunCotacao.AgrupaCotacoes(VpaCotacoes,true);
  GProdutos.ADados := VprDCotacao.Produtos;
  ECliente.AInteiro := VprDCotacao.CodCliente;
  ECliente.Atualiza;
  CarDTela;
  ValidaGravacao1.execute;
  GProdutos.CarregaGrade;
  VprOperacao := 2;
  ActiveControl := GProdutos;
  showmodal;
  result := VprAcao;
end;

{************************* consulta a cotacao *********************************}
procedure TFNovaCotacao.ConsultaCotacao(VpaCodFilial, VpaLanOrcamento : String);
begin
  VprOperacao := 3;
  VprDCotacao.CodEmpFil := StrToInt(VpaCodFilial);
  VprDCotacao.LanOrcamento := StrToInt(VpaLanOrcamento);
  FunCotacao.CarDOrcamento(VprDCotacao);
  CarDTela;
  FunCotacao.AdicionaPaginasLogAlteracao(VprDCotacao,Paginas);
  GProdutos.CarregaGrade;
  if GServicos.Visible then
    GServicos.CarregaGrade;
  BGravar.Enabled := false;
  BImprimir.Enabled := true;
  BCancelar.Enabled := false;
  AlteraReadOnlyDet(ScrollBox1,0,true);
  AlteraEnabledBotoes(false);
  ShowModal; // mostra o formulario
end;

{******************************************************************************}
procedure TFNovaCotacao.CalculaValorTotalProduto;
begin
  if Config.DescontoNosProdutodaCotacao then
  begin
    VprDProCotacao.ValTotal := VprDProCotacao.ValTotal - ((VprDProCotacao.ValTotal *VprDProCotacao.PerDesconto)/100);
  end;
  GProdutos.Cells[9,GProdutos.ALinha] := FormatFloat(Varia.MascaraQtd,VprDProCotacao.QtdProduto);
  GProdutos.Cells[10,GProdutos.ALinha] := FormatFloat(Varia.MascaraValorUnitario,VprDProCotacao.ValUnitario);
  GProdutos.Cells[11,GProdutos.ALinha] := FormatFloat(varia.MascaraValor,VprDProCotacao.ValTotal);
  GProdutos.Cells[12,GProdutos.ALinha] := FormatFloat('##0.00',VprDProCotacao.PerDesconto);
end;

{******************************************************************************}
procedure TFNovaCotacao.CalculaValorTotalServico;
begin
  VprDSerCotacao.ValTotal := VprDSerCotacao.ValUnitario * VprDSerCotacao.QtdServico;
  GServicos.Cells[6,GServicos.ALinha] := FormatFloat('R$ #,###,###,###,##0.000',VprDSerCotacao.ValTotal);
end;

{******************************************************************************}
procedure TFNovaCotacao.CalculaValorUnitarioPeloAlturaProduto;
var
  VpfValorGrade : Double;
begin
  if config.AlturadoProdutonaGradedaCotacao then
  begin
    if GProdutos.Cells[7,GProdutos.ALinha] <> '' then
    begin
     VpfValorGrade := StrToFloat(DeletaChars(GProdutos.Cells[7,GProdutos.ALinha],'.'));
     if VprDProCotacao.AltProdutonaGrade <> VpfValorGrade  then
     begin
       VprDProCotacao.AltProdutonaGrade := StrToFloat(DeletaChars(GProdutos.Cells[7,GProdutos.ALinha],'.'));
       VprDProCotacao.ValUnitario := (VprDProCotacao.ValUnitarioOriginal * VprDProCotacao.AltProdutonaGrade);
       CalculaValorTotalProduto;
     end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.ConfiguraTelaChamado;
begin
  PChamado.Visible := VprDTipoCotacao.IndChamado;
//  ECondPagamento.ACampoObrigatorio := not VprDTipoCotacao.IndChamado;
end;

{***************** atualiza o cliente apos a consulta *************************}
procedure TFNovaCotacao.EClienteRetorno(Retorno1, Retorno2: String);
begin
  CarregaDadosCliente;
end;

procedure TFNovaCotacao.EClienteSelect(Sender: TObject);
begin
  ECliente.ASelectValida.Text := 'Select I_COD_CLI, C_NOM_CLI, C_CID_CLI from CADCLIENTES '+
                                 ' where I_Cod_Cli = @ ' +
                                 ' and C_IND_CLI = ''S''';
  ECliente.ASelectLocaliza.Text := 'Select I_COD_CLI, C_NOM_CLI, C_CID_CLI from CADCLIENTES '+
                                 ' where C_NOM_CLI LIKE ''@%'' ' +
                                 ' and C_IND_CLI = ''S''';


  if (puSomenteClientesdoVendedor in varia.PermissoesUsuario) then
  begin
    ECliente.ASelectValida.Text := ECliente.ASelectValida.Text + 'and I_COD_VEN in '+varia.CodigosVendedores;
    ECliente.ASelectLocaliza.Text := ECliente.ASelectLocaliza.Text + 'and I_COD_VEN in '+varia.CodigosVendedores;
  end;
end;

{************************* fecha o formulario *********************************}
procedure TFNovaCotacao.BFecharClick(Sender: TObject);
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);
  close;
end;

{*********************** cadastra um novo cliente *****************************}
procedure TFNovaCotacao.EClienteCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.ShowModal;
  Localiza.AtualizaConsulta;
  FNovoCliente.free;
end;

{******************** cadastra um novo vendedor *******************************}
procedure TFNovaCotacao.EVendedorCadastrar(Sender: TObject);
begin
  FNovoVendedor := TFNovoVendedor.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoVendedor'));
  FNovoVendedor.CadVendedores.Insert;
  FNovoVendedor.ShowModal;
  FNovoVendedor.free;
  Localiza.AtualizaConsulta;
end;

{***************** cadastra uma nova condição de pagamento ********************}
procedure TFNovaCotacao.ECondPagamentoCadastrar(Sender: TObject);
begin
  FCondicaoPagamento := TFCondicaoPagamento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FCondicaoPagamento'));
  FCondicaoPagamento.ShowModal;
  FCondicaoPagamento.free;
  Localiza.AtualizaConsulta;
end;

{******************** calcula o valor total ***********************************}
procedure TFNovaCotacao.CalculaValorTotal;
begin
  CarDValorTotal;
  FunCotacao.CalculaValorTotal(VprDCotacao);
  if config.SugerirPrecoAtacado then
  begin
    if (VprDCotacao.QtdProduto >= Varia.QtdPecasAtacado) and not(VprDCotacao.IndRevenda) then
    begin
      ETipoCotacao.AInteiro := varia.TipoCotacaoRevenda;
      ETipoCotacao.Atualiza;
      FunCotacao.CalculaValorTotal(VprDCotacao);
      GProdutos.CarregaGrade;
    end
    else
      if (VprDCotacao.QtdProduto < Varia.QtdPecasAtacado) and (VprDCotacao.IndRevenda) then
      begin
        ETipoCotacao.AInteiro := Varia.TipoCotacaoPedido;
        ETipoCotacao.atualiza;
        FunCotacao.CalculaValorTotal(VprDCotacao);
        GProdutos.CarregaGrade;
      end;
  end;
  EValorTotal.text := FormatFloat(varia.MascaraValor,VprDCotacao.ValTotal);
  ETotalComDesconto.Text := FormatFloat(varia.MascaraValor,VprDCotacao.ValTotalComDesconto);
end;

{************************* grava o orcamento **********************************}
function  TFNovaCotacao.GravaCotacao : String;
begin
  result := '';
  if (VprOperacao in [1,2]) then
  begin
    begin
      result := FunCotacao.GravaDCotacao(VprDCotacao,VprDCliente);
      if result = '' then
      begin
        ENumCotacao.AInteiro := VprDCotacao.LanOrcamento;
        if (VprOperacao = 2) and (varia.EstagioCotacaoAlterada <> 0) then
          result:=  FunCotacao.GravaLogEstagio(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,Varia.EstagioCotacaoAlterada,Varia.codigoUsuario,'')
        else
          if (VprOperacao = 1) then
            result := FunCotacao.GravaLogEstagio(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,Varia.EstagioOrdemProducao,Varia.codigoUsuario,'');
      end;
    end;
  end;
end;

{************************** valida a gravacao *********************************}
procedure TFNovaCotacao.ESituacaoChange(Sender: TObject);
begin
  if VprOperacao in [1,2] then
  begin
    ValidaGravacao1.execute;
    BImprimir.Enabled := BGravar.Enabled;
  end;
end;

{**************** chama a rotina para gravar o orcamento **********************}
procedure TFNovaCotacao.BGravarClick(Sender: TObject);
begin
  ChamaRotinasGravacao;
end;

{******************************************************************************}
procedure TFNovaCotacao.ReferenciaProduto;
begin
  FunCotacao.CarComposeCombinacao(VprDProCotacao);
  GCompose.CarregaGrade;
  if not config.NumeroSerieProduto then
  begin
    VprDProCotacao.DesRefClienteOriginal := FunProdutos.RReferenciaProduto(VprDProCotacao.SeqProduto,VprDCotacao.CodCliente,GProdutos.Cells[3,GProdutos.ALinha]);
    VprDProCotacao.DesRefCliente := VprDProCotacao.DesRefClienteOriginal;
    GProdutos.Cells[13,GProdutos.ALinha] := VprDProCotacao.DesRefCliente;
    VprReferenciaAnterior := VprDProCotacao.DesRefCliente;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.AtualizaPesoBrutoLiquido;
begin
  FunCotacao.CalculaPesoLiquidoeBruto(VprDCotacao);
  EPesoBruto.AValor := VprDCotacao.PesBruto;
  EPesoLiquido.AValor := VprDCotacao.PesLiquido;
end;

{******************************************************************************}
function TFNovaCotacao.GeraFinanceiro : String;
begin
  result := '';
  if VprOperacao = 1 then // inclusao, gera um financeiro e baixa o estoque
  begin
    PainelTempo1.execute('Gerando Financeiro...');
    if VprDCotacao.CodPlanoContas <> '' then
    begin
      VprDContasaReceber.free;
      VprDContasaReceber := TRBDContasCR.cria;
      if FunCotacao.GeraFinanceiro(VprDCotacao,VprDCliente, VprDContasaReceber, FunContasAReceber,result,false) then
        VprDCotacao.FinanceiroGerado := true
      else
        result := 'FINANCEIRO DA COTAÇÃO CANCELADO!!!'#13'A cotação não pode ser gravada porque foi cancelada a geração do contas a receber.';
    end;
    PainelTempo1.fecha;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.GravaFinanceiro : string;
begin
  result := '';
  if VprOperacao = 1 then // inclusao, gera um financeiro e baixa o estoque
  begin
    PainelTempo1.execute('Gravando Financeiro...');
    if (VprDCotacao.CodPlanoContas <> '')and (VprDCotacao.ValTotal > 0) then
    begin
      ArrumaDuplicatasFinanceiro;
      VprDContasaReceber.MostrarParcelas := false;
      result := FunContasAReceber.GravaContasaReceber(VprDContasaReceber);
      if VprDCotacao.ValTotal <> VprDContasaReceber.ValTotal then
      begin
        VprDCotacao.ValTotal := VprDContasaReceber.ValTotal;
        VprDCotacao.IndValoresAlterados := true;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.ArrumaDuplicatasFinanceiro;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDMovContasCR;
begin
  VprDContasaReceber.LanOrcamento := VprDCotacao.LanOrcamento;
  VprDContasaReceber.NroNota := VprDCotacao.LanOrcamento;
  for VpfLaco := 0 to VprDContasaReceber.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDMovContasCR(VprDContasaReceber.Parcelas.Items[VpfLaco]);
    if (VpfDParcela.NroDuplicata = '') then
    begin
      VpfDParcela.NroDuplicata := IntToStr(VprDCotacao.LanOrcamento)+'/'+IntToStr(VpfLaco + 1);
      VpfDParcela.NroDocumento := VpfDParcela.NroDuplicata;
    end;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.BaixarEstoque : String;
begin
  result := '';
  if config.BaixarEstoqueCotacao then
  begin
    if VprOperacao = 1 then // inclusao, gera um financeiro e baixa o estoque
    begin
      if result = '' then
      begin
        PainelTempo1.execute('Baixando estoque dos produtos...');
        result := FunCotacao.GeraEstoqueProdutos(VprDCotacao,FunProdutos);
        PainelTempo1.fecha;
      end;
    end
    else
      if VprOperacao = 2 then // alteracao, gera um financeiro e baixa o estoque
      begin
        result := FunCotacao.BaixaAlteracaoCotacao(VprDCotacaoInicial,VprDCotacao,VprDCliente);
      end;
    if result = '' then
      BaixaProdutos;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.BaixaBrindesClientes : string;
var
  VpfLaco : Integer;
  VpfDProdutoOrc : TRBDOrcProduto;
begin
  result := '';
  if VprOperacao = 2 then //alteração - inclui novamente o estoque dos brindes.
  begin
    if (VprDCotacaoInicial.CodTipoOrcamento <> varia.TipoCotacaoGarantia) then
    begin
      for VpfLaco := 0 to VprDCotacaoInicial.Produtos.Count - 1 do
      begin
        VpfDProdutoOrc := TRBDOrcProduto(VprDCotacaoInicial.Produtos.Items[Vpflaco]);
        if VpfDProdutoOrc.IndBrinde then
        begin
          result := FunClientes.BaixaEstoqueBrinde(VprDCotacaoInicial.CodCliente,VpfDProdutoOrc.SeqProduto,VpfDProdutoOrc.QtdProduto,
                                         VpfDProdutoOrc.UM,false);
          if result <> '' then
            exit;
        end;
      end;
    end;
  end;

  if (VprDCotacao.CodTipoOrcamento <> varia.TipoCotacaoGarantia) then
  begin
    for VpfLaco := 0 to VprDCotacao.Produtos.Count - 1 do
    begin
      VpfDProdutoOrc := TRBDOrcProduto(VprDCotacao.Produtos.Items[Vpflaco]);
      if VpfDProdutoOrc.IndBrinde then
      begin
        result := FunClientes.BaixaEstoqueBrinde(VprDCotacao.CodCliente,VpfDProdutoOrc.SeqProduto,VpfDProdutoOrc.QtdProduto,
                                       VpfDProdutoOrc.UM,true);
        if result <> '' then
          exit;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.ChamaRotinasGravacao : Boolean;
var
  VpfResultado : String;
begin
  result := true;
  if VprOperacao in [1,2] then
  begin
    VpfResultado := CarDClasse;
    if Vpfresultado = '' then
    begin
      if config.GerarFinanceiroCotacao then
        VpfResultado := GeraFinanceiro;
      if VpfResultado = '' then
      begin
        sistema.SalvaTabelasAbertas;
        VprTransacao.IsolationLevel :=xilDIRTYREAD;
        FPrincipal.BaseDados.StartTransaction(vprTransacao);
        VpfResultado := GravaCotacao;
        if VpfREsultado = '' then
        begin
          if config.GerarFinanceiroCotacao then
            VpfResultado := GravaFinanceiro;

          if VpfResultado = '' then
          begin
            VpfResultado := BaixarEstoque;

            if VpfResultado = '' then
            begin
              VpfResultado := BaixaBrindesClientes;
              if VpfResultado = '' then
              begin
                VpfResultado:= AtualizaContatoCliente;
                if VpfResultado = '' then
                  if VprDCotacao.IndValoresAlterados then
                    VpfResultado := FunCotacao.GravaDCotacao(VprDCotacao,VprDCliente)
              end;
            end;
          end;
        end;
      end;
    end;
    if VpfResultado <> '' then
    begin
      if FPrincipal.BaseDados.inTransaction then
        FPrincipal.BaseDados.Rollback(VprTransacao);
      if VprOperacao = 1 then
        VprDCotacao.LanOrcamento := 0;
      aviso(VpfResultado);
      result := false;
    end
    else
    begin
      FPrincipal.BaseDados.Commit(VprTransacao);
      AlteraEnabledBotoes(false);
      VprAcao := true;
      VprLanOrcamento := VprDCotacao.LanOrcamento;
      result := true;
      if  VprOperacao = 1 then
      begin
        if config.EnviaCotacaoEmailTransportadora then
          BEntregador.Click;
      end;
      VprOperacao := 3;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.AtualizaConsultaEstagios;
begin
  AdicionaSQLAbreTabela(Estagios,'select EST.CODEST, EST.NOMEST, ORC.DATESTAGIO, ORC.DESMOTIVO ,USU.C_NOM_USU, '+
                                 ' ORC.LOGALTERACAO '+
                                 ' from ESTAGIOORCAMENTO ORC, ESTAGIOPRODUCAO EST, CADUSUARIOS USU '+
                                 ' Where ORC.CODESTAGIO = EST.CODEST '+
                                 ' AND ORC.CODFILIAL = USU.I_EMP_FIL '+
                                 ' AND ORC.CODUSUARIO = USU.I_COD_USU '+
                                 ' AND ORC.CODFILIAL = '+InttoStr(VprDCotacao.CodEmpFil)+
                                 ' and ORC.SEQORCAMENTO = '+ IntToStr(VprdCotacao.LanOrcamento)+
                                 ' order by ORC.DATESTAGIO');
end;

{******************************************************************************}
procedure TFNovaCotacao.AlteraEnabledBotoes(VpaEstado : Boolean);
begin
    BCadastrar.Enabled := not VpaEstado;
    BCancelar.Enabled := VpaEstado;
    BGravar.Enabled := VpaEstado;
    BFechar.Enabled := not VpaEstado;
    BGeraCupom.Enabled := not BGravar.Enabled;
    BEntregador.Enabled := not VpaEstado;
    AlteraReadOnlyDet(ScrollBox1,0,true);
    GProdutos.ReadOnly := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovaCotacao.ProximoProduto;
begin
  if config.CodigoBarras then
  begin
    if GProdutos.Cells[2,GProdutos.ALinha] = '' then
    begin
      GProdutos.col := 8;
      if UpperCase(VprDProCotacao.UM) = 'CX' then
      begin
        GProdutos.Cells[8,GProdutos.ALinha] := 'pc';
        GProdutos.col := 8;
      end;
      GProdutos.SetaParaBaixo;
      GProdutos.col := 1;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.ConfiguraPermissaoUsuario;
begin
  EVendedor.Enabled := config.PermitirAlterarVendedornaCotacao;
  BVendedor.Enabled := config.PermitirAlterarVendedornaCotacao;
  ETipoCotacao.Enabled := CONFIG.PermitirAlterarTipoCotacao;
  if not CONFIG.PermitirAlterarTipoCotacao then
  begin
    if (puPLAlterarTipoCotacao in varia.PermissoesUsuario) then
      ETipoCotacao.Enabled := true;
  end;
  if not config.PermitirAlterarVendedornaCotacao then
    LPreposto.Caption := 'Atendente : ';
  if not config.NaCotacaoBuscaroContato then
    EContato.ACampoObrigatorio := true;
  if not config.RepresentanteComercial then
  begin
    PRepresentada.Visible := false;
    PCliente.Height := PCliente.Height - PRepresentada.Height;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.BaixaProdutos;
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VprDCotacao.Produtos.Count - 1 do
    TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]).QtdBaixado := TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]).QtdProduto;

  VprDCotacao.IndValoresAlterados := true;
end;

{******************* grava a cotacao e depois imprime *************************}
procedure TFNovaCotacao.BImprimirClick(Sender: TObject);
begin
  if ChamaRotinasGravacao then
  begin
    if not Config.ImprimirPedEmPreImp then
    begin
      if ((varia.ImpressoraAlmoxarifado <> '') and (VprDCotacao.CodTransportadora = varia.CodTransportadoraVazio)) or
        not(config.ImprimeCotacaocomEntregadorSomenteAlmoxarifado)  then
        if (varia.CNPJFilial = CNPJ_ZUMM) OR
           (varia.CNPJFilial = CNPJ_ZummH) or
           (varia.CNPJFilial = CNPJ_ZummNeumarkt) then // grafica zumm
          FunCrystal.ImprimeRelatorio(Varia.PathRelatorios + '\Cotações\XX_CotacaoVias.rpt',[IntToStr(VprDCotacao.CodEmpFil),Inttostr(VprDCotacao.LanOrcamento),IntToStr(VprDCotacao.CodEmpFil),Inttostr(VprDCotacao.LanOrcamento)])
        else
        begin
          dtRave := TdtRave.create(self);
          dtRave.ImprimePedido(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,false);
          dtRave.free;
        end;
      if (varia.ImpressoraAlmoxarifado <> '') and (VprDCotacao.CodTransportadora <> varia.CodTransportadoraVazio)  then
      begin
          dtRave := TdtRave.create(self);
          dtRave.ImprimePedido(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,false);
          dtRave.free;
      end;
      if (varia.CNPJFilial = CNPJ_COPYLINE) or
         (varia.CNPJFilial = CNPJ_IMPOX) then
      begin
        if (VprDCotacao.CodTransportadora = varia.CodTransportadoraVazio) then
        begin
          FunCotacao.AdicionaFinanceiroArqRemessa(VprDCotacao);
          FunCotacao.ImprimirBoletos(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,VprDCliente,Varia.ImpressoraRelatorio)
        end
        else
          FunCotacao.ImprimirBoletos(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,VprDCliente,varia.ImpressoraAlmoxarifado);

        if VprDCotacao.CodTipoOrcamento = 2 then
        begin
          dtRave := TdtRave.create(self);
          dtRave.ImprimeGarantia(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,false);
          dtRave.free;
        end;
      end;
    end
    else
    begin
      FunCotacao.CarDParcelaOrcamento(VprDCotacao);
      FunImpressao.ImprimirPedido(VprDCotacao);
    end;
    FunCotacao.SetaOrcamentoImpresso(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento);
  end;

end;

{*************** consulta as parcelas da condicao de pagamento ****************}
procedure TFNovaCotacao.SpeedButton5Click(Sender: TObject);
var
  VpfCondicao : Integer;
begin
  if (ECondPagamento.text <> '') Then
  begin
    FunCotacao.CalculaValorTotal(VprDCotacao);
    VpfCondicao :=StrToInt(EcondPagamento.Text);
    FConsultaCondicaoPgto := TFConsultaCondicaoPgto.create(self);
    FConsultaCondicaoPgto.VisualizaParcelas(VprDCotacao.ValTotalLiquido,VpfCondicao, false);
    FConsultaCondicaoPgto.free;
    if (StrToInt(EcondPagamento.Text) <> VpfCondicao) and
       (VpfCondicao <> 0) then
    begin
      EcondPagamento.text := IntToStr(VpfCondicao);
      CalculaValorTotal;
    end;
  end;
end;

{********** carrega a select da localiza da condicao de pagamento *************}
procedure TFNovaCotacao.ECondPagamentoSelect(Sender: TObject);
begin
  ECondPagamento.ASelectValida.Text := 'select * from cadcondicoespagto '+
                                       ' where I_Cod_pag = @ ' +
                                       ' and D_VAl_Con >= ' + SQLTextoDataAAAAMMMDD(Date);
  ECondPagamento.ASelectLocaliza.Text := 'select * from cadcondicoespagto '+
                                         ' where c_nom_pag like ''@%''' +
                                         ' and D_VAl_Con >= ' + SQLTextoDataAAAAMMMDD(Date);
 if (puSomenteCondicoesPgtoAutorizadas in varia.PermissoesUsuario) then
 begin
    ECondPagamento.ASelectValida.Text := ECondPagamento.ASelectValida.Text + ' and I_COD_PAG IN '+varia.CodigosCondicaoPagamento;
    ECondPagamento.ASelectLocaliza.Text := ECondPagamento.ASelectLocaliza.Text + ' and I_COD_PAG IN '+varia.CodigosCondicaoPagamento;
 end;
end;

{******************** direciona o foco do cursor ******************************}
procedure TFNovaCotacao.DirecionaFoco;
begin
  if GProdutos.Focused then
  begin
    if ConfigModulos.Servico then
      GServicos.SetFocus
    else
      if PTransportadora.Visible then
        ETransportadora.SetFocus
      else
        if PTecnico.Visible then
          ECodTecnico.Setfocus
        else
          if PCompose.Visible then
          begin
            GCompose.SetFocus;
            GCompose.row := 1;
            GCompose.Col := 2;
          end
          else
            EDatPrevista.SetFocus;
  end
  else
    if GServicos.Focused then
    begin
      if PTransportadora.Visible then
        ETransportadora.SetFocus
      else
        if PTecnico.visible then
          ECodTecnico.SetFocus
        else
          EDatPrevista.SetFocus;
    end
    else
      GProdutos.SetFocus;
end;

{******************************************************************************}
procedure TFNovaCotacao.CarTituloGrade;
begin
  GProdutos.Cells[1,0] := 'Código';
  GProdutos.Cells[2,0] := 'Nome';
  GProdutos.Cells[3,0] := 'Cor';
  GProdutos.Cells[4,0] := 'Descrição';
  GProdutos.Cells[5,0] := 'Tamanho';
  GProdutos.Cells[6,0] := 'Descrição';
  GProdutos.Cells[7,0] := 'Altura';
  GProdutos.Cells[8,0] := 'UM';
  GProdutos.Cells[9,0] := 'Quantidade';
  GProdutos.Cells[10,0] := 'Valor Unitário';
  GProdutos.Cells[11,0] := 'Valor Total';
  GProdutos.Cells[12,0] := 'Per Desconto';
  if config.NumeroSerieProduto then
    GProdutos.Cells[13,0] := 'Número Série'
  else
    GProdutos.Cells[13,0] := 'Referencia Cliente';
  if config.Farmacia then
    GProdutos.Cells[13,0] := 'Numero Lote';
  GProdutos.Cells[14,0] := 'Ordem de Compra';
  GProdutos.Cells[15,0] := 'Emba.';
  GProdutos.Cells[16,0] := 'Descrição';
  GProdutos.Cells[17,0] := 'Imp Foto';
  GProdutos.Cells[18,0] := 'Imp. Desc';
  GProdutos.Cells[19,0] := 'Observação';
  GProdutos.CarregaGrade;

  GServicos.Cells[1,0] := 'Serviço';
  GServicos.Cells[2,0] := 'Descrição';
  GServicos.Cells[3,0] := 'Descrição Adicional';
  GServicos.Cells[4,0] := 'Qtd';
  GServicos.Cells[5,0] := 'Valor Unitário';
  GServicos.Cells[6,0] := 'Valor Total';
  GServicos.CarregaGrade;

  GCompose.Cells[1,0] := 'Cor Ref';
  GCompose.Cells[2,0] := 'Código';
  GCompose.Cells[3,0] := 'Produto';
  GCompose.Cells[4,0] := 'Código';
  GCompose.Cells[5,0] := 'Cor';
  GCompose.CarregaGrade;

 if not Config.EstoquePorCor then
  begin
    GProdutos.ColWidths[2] := 450;
    GProdutos.ColWidths[3] := -1;
    GProdutos.ColWidths[4] := -1;
    GProdutos.TabStops[3] := false;
    GProdutos.TabStops[4] := false;
  end;
  if not config.EstoquePorTamanho then
  begin
    GProdutos.ColWidths[5] := -1;
    GProdutos.ColWidths[6] := -1;
    GProdutos.TabStops[5] := false;
    GProdutos.TabStops[6] := false;
  end;
  if not config.AlturadoProdutonaGradedaCotacao then
  begin
    GProdutos.ColWidths[7] := -1;
    GProdutos.TabStops[7] := false;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.CarDClasse :String ;
begin
  result := '';
  VprDCotacao.LanOrcamento := ENumCotacao.AInteiro;
  VprDCotacao.CodMedico := EMedico.AInteiro;
  VprDCotacao.NumReceita := ENumReceita.Text;
  VprDCotacao.TipReceita := ETipoReceita.ItemIndex + 1;
  if config.Farmacia then
  begin
    try
      if DeletaChars(EDatReceita.Text,'/') <> '' then
        VprDCotacao.DatReceita := StrToDate(EDatReceita.text);
    except
      result := '';
    end;
  end;
  if (VprDCotacao.Produtos.Count = 0) and (VprDCotacao.Servicos.Count = 0) and not(VprDTipoCotacao.IndChamado) then
    result := 'COTAÇÃO SEM PRODUTOS/SERVIÇOS!!!'#13'Não foi adicionado nenhum produto/serviço na cotação.';
  if result = '' then
  begin
    try
      StrToDate(EDatPrevista.text);
    except
      result := 'DATA PREVISÃO ENTREGA INVÁLIDA!!!'#13'A data de previsão de entrega não é uma data válida ou não foi preenchida...';
    end;
    if result = '' then
    begin
      if StrToDate(EDatPrevista.text) > IncMes(Date,VARIA.QtdMaximaMesesEntregaPedido) then
        result := 'DATA PREVISÃO ENTREGA INVÁLIDA!!!'#13'A data de entrega prevista não pode ser maior que '+IntToStr(Varia.QtdMaximaMesesEntregaPedido)+' meses';
    end;
    if result = '' then
    begin
      if StrToDate(EDatPrevista.text) < DecDia(VprDCotacao.DatOrcamento,7) then
        result := 'DATA PREVISÃO ENTREGA INVÁLIDA!!!'#13'A data de entrega prevista não pode ser menor que 1 semana atrás.';
    end;
    try
      StrToDate(EDatValidade.text);
    except
      result := 'DATA DE VALIDADE INVÁLIDA!!!'#13'A data de validade da cotação não é uma data válida ou não foi preenchida...';
    end;
    if result = '' then
    begin
      if ECondPagamento.AInteiro = 0 then
      begin
        result := CT_CondicaoPagtoNulo;
      end;
      if result = '' then
      begin
        if config.ExigirCNPJeCEPCotacaoPadrao  and (VprDCliente.TipoPessoa <> 'E') then
        begin
          if varia.TipoCotacao = ETipoCotacao.AInteiro then
          begin
            if VprDCliente.CepCliente = '' then
              result := 'CLIENTE CADASTRADO SE O CEP!!!'#13'É necessário preencher o CEP no cadastro do cliente...';
            if (VprDCliente.CGC_CPF = '') then
              result := 'CLIENTE CADASTRADO SEM O CNPJ/CPF!!!'#13'É necessário preencher o CNPJ/CPF no cadatro do cliente...';
          end;
        end;
      end;
    end;
  end;
  if result = '' then //
  begin
    if CONFIG.TransportadoraObrigatorianaCotacao and (config.UtilizarTransPedido) then
      if (ETransportadora.AInteiro = 0) and not (VprDTipoCotacao.IndChamado) then
        result := 'TRANSPORTADORA VAZIA!!!'#13'É necessário preencher a transportadora.';
  end;

  if result = '' then
  begin
    with VprDCotacao do
    begin
      CodTipoOrcamento := ETipoCotacao.AInteiro;
      CodCliente := ECliente.AInteiro;
      if VprOperacao = 1 then // inclusao
      begin
        CodFormaPaqamento := VprDCliente.CodFormaPagamento;
        if CodFormaPaqamento = 0 then
          CodFormaPaqamento := varia.FormaPagamentoPadrao;
      end;
      CodRepresentada := ERepresentada.AInteiro;
      CodFormaPaqamento := EFormaPagamento.AInteiro;
      CodTabelaPreco := ETabelaPreco.AInteiro;
      CodVendedor := EVendedor.AInteiro;
      CodPreposto := ECodPreposto.AInteiro;
      CodTecnico := ECodTecnico.AInteiro;
      CodMedico := EMedico.AInteiro;
      PerComissao := EPerComissao.AValor;
      PerComissaoPreposto := EComissaoPreposto.AValor;
      NomContato := EContato.Text;
      NomSolicitante := ESolicitante.Text;
      DesEmail := EEmailContato.Text;
      OrdemCompra := EOrdemCompra.Text;
      DesServico := EDesServico.Text;
      DatPrevista := StrToDate(EDatPrevista.text);
      DatValidade := StrToDate(EDatValidade.text);
      if DeletaChars(DeletaChars(EHorPrevista.Text,':'),' ') <> '' then
        HorPrevista := StrToDateTime(EHorPrevista.Text)
      else
        HorPrevista := StrToDateTime('00:00');
      DesObservacao.Text := EObservacoes.Lines.text;
      DesObservacaoFiscal := EObservacaoFiscal.Lines.text;

      CodTransportadora  := ETransportadora.AInteiro;

      PlaVeiculo := EPlaVeiculo.Text;
      UFVeiculo := EUFPlaVeiculo.Text;
      QtdVolumesTransportadora := ArredondaPraMaior(EQtdTransportadora.AValor);
      EspTransportadora := EEspTransportadora.Text;
      MarTransportadora := EMarTransportadora.Text;
      NumTransportadora := trunc(ENumTransportadora.AValor);
      DesProblemaChamado := EDesProblema.Lines.Text;
      DesServicoExecutado := EServicoExecutado.Lines.text;
      DesEnderecoAtendimento := EEnderecoAtendimento.text;
      TipFrete := ETipFrete.AsInteger;
      PesBruto := EPesoBruto.AValor;
      PesLiquido := EPesoLiquido.AValor;
      if COffSEt.checked then
        TipGrafica := 1
      else
        TipGrafica := 0;
      if (config.GerarFinanceiroCotacao) and (VprDTipoCotacao.CodPlanoContas <> '') then
        VprDCotacao.OPImpressa := true;
      CarDValorTotal;
      CalculaValorTotal;

      if Produtos.Count = 0 then
        IndPendente := false;

      if (config.EstagioFinalOPparaCotacaoTransportadoraVaiza and (CodTransportadora = varia.CodTransportadoraVazio)) or
         (config.EstagioFinalOpparaCotacaoFaturamentoPosterior and (VprDCotacao.CodTipoOrcamento = varia.TipoCotacaoFaturamentoPosterior)) then
        CodEstagio := varia.EstagioFinalOrdemProducao;
      result :=  SituacaoFinanceiraOK(VprDCliente);
    end;
  end;
  if result = '' then
  begin
    if (varia.CNPJFilial = CNPJ_Kairos) or (Varia.CNPJFilial = CNPJ_AviamentosJaragua) then
    begin
      if (varia.CodigoUsuario = 8) and (Varia.CodigoEmpFil <> 13) then
      begin
        if not confirmacao('FILIAL DIFERENTE DA EDSON!!!'#13'Geisa, você não está na filial 13-Revenda Edson. Tem certeza  deseja continuar?') then
          result := 'FILIIAL INVÁLIDA!!!'#13'Faltou selecionar a filial correta';
      end;
    end;
  end;
  if result = '' then
  begin
    if (varia.CNPJFilial = CNPJ_Feldmann)or
       (varia.CNPJFilial = CNPJ_Atol) then
      if VprOperacao = 2 then
      begin
        if (VprDCotacao.CodTipoOrcamento <> VprDCotacaoInicial.CodTipoOrcamento) and
           (VprDCotacao.CodTipoOrcamento = varia.TipoCotacao) then
        begin
          VprDCotacao.DatOrcamento := date;
          VprDCotacao.HorOrcamento := now;
        end;
      end;
  end;
  if result = '' then
  begin
    if config.PermanecerOVendedorDaUltimaVenda then
    begin
      FunCotacao.GravaVendedorUltimaCotacao(EVendedor.AInteiro);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.CarDValorTotal;
begin
  if VprOperacao in [1,2] then
  begin
    with VprDCotacao do
    begin
      CarDDesconto;
      CodCondicaoPagamento := ECondPagamento.AInteiro;
      ValChamado := EValChamado.AValor;
      ValDeslocamento := EValDeslocamento.AValor;
      ValTaxaEntrega := EValTaxa.AValor;
      if PTransportadora.Visible then
        ValTaxaEntrega := EValFrete.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.CarDDesconto;
begin
  if VprOperacao in [1,2] then
  begin
    with VprDCotacao do
    begin
      ValTaxaEntrega := EValTaxa.aValor;
      PerDesconto := 0;
      ValDesconto := 0;
      if CValorPercentual.ItemIndex = 0 then //valor
      begin
        ValDesconto := EDesconto.AValor;
        if (CAcrescimoDesconto.ItemIndex = 0) then
          ValDesconto := ValDesconto * (-1);
      end
      else
        if CValorPercentual.ItemIndex = 1 then //percentual
        begin
          PerDesconto := EDesconto.AValor;
          if (CAcrescimoDesconto.ItemIndex = 0) then
            PerDesconto := PerDesconto * (-1);
        end;
    end;
  end;

end;

{******************************************************************************}
procedure TFNovaCotacao.CarDProdutoOrcamento;
begin
  VprDProCotacao.CodProduto := GProdutos.Cells[1,GProdutos.Alinha];
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDProCotacao.NomProduto := GProdutos.Cells[2,GProdutos.ALinha];

  if (GProdutos.Cells[3,GProdutos.ALinha] <> '') and config.EstoquePorCor then
    VprDProCotacao.CodCor := StrToInt(GProdutos.Cells[3,GProdutos.Alinha])
  else
    VprDProCotacao.CodCor := 0;
  VprDProCotacao.DesCor := GProdutos.Cells[4,GProdutos.ALinha];
  if GProdutos.Cells[5,GProdutos.ALinha] <> '' then
    VprDProCotacao.CodTamanho := StrToInt(GProdutos.Cells[5,GProdutos.Alinha])
  else
    VprDProCotacao.CodTamanho := 0;

  CalculaValorUnitarioPeloAlturaProduto;
  VprDProCotacao.UM := GProdutos.Cells[8,GProdutos.ALinha];
  VprDProCotacao.QtdProduto := StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'));
  if (DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.'),','),'0') = '') and
     (DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[11,GProdutos.ALinha],'.'),','),'0') <> '') then
  begin
    VprDProCotacao.ValTotal := StrToFloat(DeletaChars(GProdutos.Cells[11,GProdutos.ALinha],'.'));
    VprDProCotacao.ValUnitario := VprDProCotacao.ValTotal / VprDProCotacao.QtdProduto;
  end
  else
  begin
    VprDProCotacao.ValUnitario := StrToFloat(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.'));
    VprDProCotacao.ValTotal := VprDProCotacao.ValUnitario * VprDProCotacao.QtdProduto;
  end;

  VprDProCotacao.PerDesconto := StrToFloat(DeletaChars(GProdutos.Cells[12,GProdutos.ALinha],'.'));
  VprDProCotacao.DesRefCliente := GProdutos.Cells[13,GProdutos.Alinha];
  VprDProCotacao.DesOrdemCompra := GProdutos.Cells[14,GProdutos.ALinha];
  if GProdutos.Cells[15,GProdutos.ALinha] <> '' then
    VprDProCotacao.CodEmbalagem := StrToInt(GProdutos.Cells[15,GProdutos.Alinha])
  else
    VprDProCotacao.CodEmbalagem := 0;
  VprDProCotacao.DesEmbalagem := GProdutos.Cells[16,GProdutos.ALinha];
  VprDProCotacao.IndImpFoto := GProdutos.Cells[17,GProdutos.ALinha];
  VprDProCotacao.IndImpDescricao := GProdutos.Cells[18,GProdutos.ALinha];
  VprDProCotacao.DesObservacao := GProdutos.Cells[19,GProdutos.ALinha];
  CalculaValorTotalProduto;
  if ((VprDProCotacao.QtdEstoque - VprDProCotacao.QtdProduto) < VprDProCotacao.QtdMinima) then
  begin
    if config.AvisaQtdMinima then
      aviso(CT_EstoqueProdutoMinimo);
  end
  else
    if ((VprDProCotacao.QtdEstoque -  VprDProCotacao.QtdProduto) < VprDProCotacao.QtdPedido) Then
    begin
      if Config.AvisaQtdPedido Then
        aviso(CT_EstoquePedido);
    end;
end;

{******************************************************************************}
procedure TFNovaCotacao.CarDServicoOrcamento;
begin
  VprDSerCotacao.CodServico := StrToInt(GServicos.Cells[1,GServicos.Alinha]);
  VprDSerCotacao.NomServico := GServicos.Cells[2,GServicos.ALinha];
  VprDSerCotacao.DesAdicional := GServicos.Cells[3,GServicos.ALinha];
  VprDSerCotacao.QtdServico := StrToFloat(DeletaChars(GServicos.Cells[4,GServicos.ALinha],'.'));
  VprDSerCotacao.ValUnitario := StrToFloat(DeletaChars(GServicos.Cells[5,GServicos.ALinha],'.'));
  CalculaValorTotalServico;
end;

{******************************************************************************}
procedure TFNovaCotacao.CarDComposeOrcamento;
begin
  VprDCompCotacao.CodProduto := GCompose.Cells[2,GCompose.ALinha];
  VprDCompCotacao.CodCor := StrtoInt(GCompose.Cells[4,GCompose.ALinha]);
end;

{******************************************************************************}
procedure TFNovaCotacao.CarDTela;
begin
  with VprDCotacao do
  begin
    ETipoCotacao.AInteiro := CodTipoOrcamento;
    ETipoCotacao.Atualiza;
    ERepresentada.AInteiro := CodRepresentada;
    ERepresentada.Atualiza;
    ECliente.AInteiro := CodCliente;
    VprDCotacao.CodCliente := 0;
    ECliente.Atualiza;
    EContato.Text := NomContato;
    EEmailContato.Text := DesEmail;
    ESolicitante.Text := NomSolicitante;
    EOrdemCompra.Text := OrdemCompra;
    LNomComputador.Caption := NomComputador;
    EDesServico.Text := DesServico;
    ETabelaPreco.AInteiro := CodTabelaPreco;
    ETabelaPreco.atualiza;
    EMedico.AInteiro := CodMedico;
    EMedico.Atualiza;
    EVendedor.AInteiro := CodVendedor;
    EVendedor.Atualiza;
    ECodPreposto.AInteiro := CodPreposto;
    ECodPreposto.Atualiza;
    ECodTecnico.AInteiro := CodTecnico;
    ECodTecnico.Atualiza;
    EPerComissao.AValor := PerComissao;
    EComissaoPreposto.AValor := PerComissaoPreposto;
    EFormaPagamento.AInteiro := CodFormaPaqamento;
    EFormaPagamento.Atualiza;
    EDataCotacao.Text := FormatDateTime('DD/MM/YYYY',DatOrcamento);
    EHoraCotacao.Text := FormatDateTime('HH:MM',HorOrcamento);
    EDatPrevista.Text := FormatDateTime('DD/MM/YYYY',DatPrevista);
    EDatValidade.Text := FormatDateTime('DD/MM/YYYY',DatValidade);
    EHorPrevista.text := FormatDateTime('HH:MM',HorPrevista);
    ECondPagamento.AInteiro := CodCondicaoPagamento;
    ECondPagamento.Atualiza;
    EObservacoes.Lines.text := DesObservacao.Text;
    EObservacoes.Lines.text := DesObservacao.Text;
    EObservacaoFiscal.Lines.text := DesObservacaoFiscal;
    ENumCotacao.AInteiro := LanOrcamento;
    EDesProblema.Lines.text := DesProblemaChamado;
    EServicoExecutado.Lines.text := DesServicoExecutado;
    EEnderecoAtendimento.Text := DesEnderecoAtendimento;
    EValChamado.AValor := ValChamado;
    EValDeslocamento.AValor := ValDeslocamento;
    EValTroca.AValor := ValTroca;

    if CodTransportadora > 0 then
    begin
      ETransportadora.Text := IntToStr(CodTransportadora);
      ETransportadora.Atualiza;
    end;

    EPlaVeiculo.Text   := PlaVeiculo;
    EUFPlaVeiculo.Text := UFVeiculo;
    EQtdTransportadora.AValor  := QtdVolumesTransportadora;
    EEspTransportadora.Text:= EspTransportadora;
    EMarTransportadora.Text  := MarTransportadora;
    ENumTransportadora.AValor:= NumTransportadora;
    ETipFrete.AsInteger := TipFrete;
    EPesoBruto.AValor := PesBruto;
    EPesoLiquido.AValor:= PesLiquido;
    case TipGrafica of
      0 : CDigital.Checked := true;
      1 : COffSEt.Checked := true;
    end;
    EValTaxa.Avalor := ValTaxaEntrega;
    if PTransportadora.Visible then
      EValFrete.Avalor := ValTaxaEntrega;
    CAcrescimoDesconto.ItemIndex :=1;
    CValorPercentual.ItemIndex := 0;
    if ValDesconto <> 0 then
    begin
      CValorPercentual.ItemIndex := 0;
      if ValDesconto > 0 then
      begin
        EDesconto.AValor := ValDesconto;
        CAcrescimoDesconto.ItemIndex := 1;
      end
      else
      begin
        EDesconto.AValor := ValDesconto * -1;
        CAcrescimoDesconto.ItemIndex := 0;
      end;
    end
    else
      if PerDesconto <> 0 then
      begin
        CValorPercentual.ItemIndex := 1;
        if PerDesconto > 0 then
        begin
           EDesconto.AValor := PerDesconto;
           CAcrescimoDesconto.ItemIndex := 1;
        end
        else
        begin
           EDesconto.AValor := PerDesconto * -1;
           CAcrescimoDesconto.ItemIndex := 0;
        end;
      end;
    EValorTotal.Text := FormatFloat(varia.MascaraValor,VprDCotacao.ValTotal);
    ETotalComDesconto.Text := FormatFloat(varia.MascaraValor,VprDCotacao.ValTotalComDesconto);
    ENumReceita.Text := NumReceita;
    ETipoReceita.ItemIndex := TipReceita - 1;
    if DatReceita > MontaData(1,1,1900) then
      EDatReceita.text := FormatDateTime('DD/MM/YYYY',DatReceita)
    else
      EDatReceita.clear;
    if CodEmpFil <> varia.CodigoFilial then
      LNomeFantasia.Caption := Sistema.RNomFilial(CodEmpFil);
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.CarDClienteDuplicacao;
begin
  if VprDCliente.CodCondicaoPagamento <> 0 then
    VprDCotacao.CodCondicaoPagamento := VprDCliente.CodCondicaoPagamento;
  if VprDCliente.CodTransportadora <> 0 then
    VprDCotacao.CodTransportadora := VprDCliente.CodTransportadora;
  if VprDCliente.CodTecnico <> 0 then
    VprDCotacao.CodTecnico := VprDCliente.CodTecnico;
  if VprDCliente.CodVendedor <> 0 then
    VprDCotacao.CodVendedor := VprDCliente.CodVendedor;
  if VprDCliente.PerComissao <> 0 then
    VprDCotacao.PerComissao := VprDCliente.PerComissao;
end;

{******************************************************************************}
Procedure TFNovaCotacao.CarLogAlteracoes;
begin
end;

{******************************************************************************}
procedure TFNovaCotacao.CarDChamado;
begin
  if ECliente.Ainteiro <> 0 then
  begin
    if VprDTipoCotacao.IndChamado then
      if not VprDCliente.IndPossuiContrato then
      begin
        EValChamado.AValor := varia.ValChamado;
        EValDeslocamento.AValor := FunClientes.RValDeslocamentoCliente(VprDCliente.DesCidade);
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.CarPaginaLogAlteracao;
begin
  Paginas.ActivePage.Tag := 10;
end;

{******************************************************************************}
procedure TFNovaCotacao.CopiaDChamadoCotacao(VpaDChamado : TRBDChamado);
begin
  ECliente.AInteiro := VpaDChamado.CodCliente;
  ECliente.Atualiza;
  if (VpaDChamado.ValDeslocamento <> 0) or (VpaDChamado.ValChamado <> 0) then
  begin
    VprDSerCotacao := VprDCotacao.AddServico;
    VprDSerCotacao.CodServico := varia.codServicoChamadoCotacao;
    FunCotacao.ExisteServico(IntToStr(VprDSerCotacao.CodServico),VprDSerCotacao);
    VprDSerCotacao.DesAdicional := ' em '+FormatDateTime('DD/MM/YYY',date);
    VprDSerCotacao.QtdServico := 1;
    VprDSerCotacao.ValUnitario :=VpaDChamado.ValChamado+VpaDChamado.ValDeslocamento;
    VprDSerCotacao.ValTotal := VprDSerCotacao.ValUnitario;
    GServicos.CarregaGrade;
  end;
  AdicionaProdutosChamado(VpaDChamado);
  if config.CopiaoServicoExecutadoParaAObsdaCotacao then
  begin
    FunCotacao.CarServicoExecutadonaObsdaCotacao(VprDCotacao,VpaDChamado);
    EObservacoes.Lines := VprDCotacao.DesObservacao;
  end;

  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovaCotacao.InicializaTela;
begin
  VprDProCopia := nil;
  LimpaLabel([LEnderecoCliente]);
  GProdutos.COL := 1;
  GServicos.Col := 1;
  BEntregador.Enabled := false;
  BCadastrar.Enabled := false;
  ENumCotacao.ReadOnly := false;
  with VprDCotacao do
  begin
    LanOrcamento := 0;
    CodEmpFil := Varia.CodigoEmpFil;
    CodUsuario := varia.CodigoUsuario;
    CodEstagio := varia.EstagioOrdemProducao;
    CodTabelaPreco := varia.TabelaPreco;
    EFormaPagamento.AInteiro := varia.FormaPagamentoPadrao;
    EFormaPagamento.Atualiza;
    IndPendente := true;
    FlaSituacao := 'A';
    IndProcessada := false;
    DatOrcamento := date;
    HorOrcamento := Time;
    NomComputador := varia.NomeComputador;
    TipFrete := Varia.FretePadraoNF;
    DatValidade := incDia(Date,Varia.DiasValidade);
    if config.GerarFinanceiroCotacao then
      DatEntrega := date;
    if not config.ExigirDataEntregaPrevista then
    begin
      DatPrevista := IncDia(date,3);
      EDatPrevista.Text := FormatDateTime(FPrincipal.CorFoco.AMascaraData,DatPrevista);
      EHorPrevista.Text := '08:00';
    end;

    EDatValidade.Text := FormatDateTime('DD/MM/YYYY',DatValidade);
    EDataCotacao.Text := FormatDateTime('DD/MM/YYYY',DatOrcamento);
    EHoraCotacao.Text := FormatDateTime('HH:MM',HorOrcamento);
    ETipFrete.AsInteger := Varia.FretePadraoNF;
    EDesconto.Clear;
    CAcrescimoDesconto.ItemIndex :=1;
    CValorPercentual.ItemIndex := 0;
    EObservacoes.Clear;
    if varia.CodTipoCotacaoMaquinaLocal <> 0 then
    begin
        ETipoCotacao.AInteiro :=  Varia.CodTipoCotacaoMaquinaLocal;
        ETipoCotacao.Atualiza;
    end
    else
      if Varia.TipoCotacao <> 0 then
      begin
        ETipoCotacao.AInteiro :=  Varia.TipoCotacao;
        ETipoCotacao.Atualiza;
        ActiveControl := ECliente;
      end;
    if PTransportadora.Visible then
    begin
      if varia.CodTransportadora <> 0 then
      begin
        ETransportadora.AInteiro := Varia.CodTransportadora;
        ETransportadora.Atualiza;
      end;
      EMarTransportadora.Text := varia.MarcaEmbalagem;
    end;
    if varia.CodClientePadraoCotacao <> 0 then
    begin
      ECliente.AInteiro := Varia.CodClientePadraoCotacao;
      ECliente.Atualiza;
    end;
    if config.PermanecerOVendedorDaUltimaVenda then
    begin
      EVendedor.AInteiro := FunCotacao.RVendedorUltimaCotacao;
      EVendedor.Atualiza;
    end;
    ETabelaPreco.AInteiro := CodTabelaPreco;
    if config.UtilizarTabelaPreconaCotacao then
    begin
      ETabelaPreco.Atualiza;
    end;
    if config.RepresentanteComercial then
      ActiveControl := ERepresentada;
  end;
  ValidaGravacao1.Execute;
  BFechar.Enabled := false;
end;
{**************** trata as teclas pressionadas da grade ***********************}
procedure TFNovaCotacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    Vk_F4 : DirecionaFoco;
    33 : ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position  - ScrollBox1.VertScrollBar.Range;
    34 : ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position  + ScrollBox1.VertScrollBar.Range;
  end;
end;

{************************ quando retorna da consulta **************************}
procedure TFNovaCotacao.ECondPagamentoRetorno(Retorno1, Retorno2: String);
begin
  if VprOperacao in [1,2] then
    CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovaCotacao.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFNovaCotacao.EVendedorRetorno(Retorno1, Retorno2: String);
begin
  if (VprOperacao in [1,2]) then
  begin
    if (Retorno1 <> '') and (VprDCliente.PerComissao = 0) then
      EPerComissao.AValor := StrToFloat(Retorno1);
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProCotacao := TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaLinha-1]);
  GProdutos.Cells[1,VpaLinha] := VprDProCotacao.CodProduto;
  GProdutos.Cells[2,VpaLinha] := VprDProCotacao.NomProduto;
  if VprDProCotacao.CodCor <> 0 then
    GProdutos.Cells[3,VpaLinha] := IntToStr(VprDProCotacao.CodCor)
  else
    GProdutos.Cells[3,VpaLinha] := '';
  GProdutos.Cells[4,VpaLinha] := VprDProCotacao.DesCor;
  if VprDProCotacao.CodTamanho <> 0 then
    GProdutos.Cells[5,VpaLinha] := IntToStr(VprDProCotacao.CodTamanho)
  else
    GProdutos.Cells[5,VpaLinha] := '';
  GProdutos.Cells[6,VpaLinha] := VprDProCotacao.NomTamanho;
  if VprDProCotacao.AltProdutonaGrade <> 0 then
    GProdutos.Cells[7,VpaLinha] := FormatFloat('#,##0.00',VprDProCotacao.AltProdutonaGrade)
  else
    GProdutos.Cells[7,VpaLinha] := '';
  GProdutos.Cells[8,VpaLinha] := VprDProCotacao.UM;
  GProdutos.Cells[13,VpaLinha] := VprDProCotacao.DesRefCliente;
  GProdutos.Cells[14,VpaLinha] := VprDProCotacao.DesOrdemCompra;
  if VprDProCotacao.CodEmbalagem <> 0 then
    GProdutos.Cells[15,VpaLinha] := IntToStr(VprDProCotacao.CodEmbalagem)
  else
    GProdutos.Cells[15,VpaLinha] := '';
  GProdutos.Cells[16,VpaLinha] := VprDProCotacao.DesEmbalagem;
  GProdutos.Cells[17,VpaLinha] := VprDProCotacao.IndImpFoto;
  GProdutos.Cells[18,VpaLinha] := VprDProCotacao.IndImpDescricao;
  GProdutos.Cells[19,VpaLinha] := VprDProCotacao.DesObservacao;
  CalculaValorTotalProduto;
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
Var
  VpfSenha : String;
begin
  VpaValidos := true;
  if not ExisteProduto then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTONAOCADASTRADO);
    GProdutos.col := 1;
  end
  else
    if (GProdutos.Cells[2,GProdutos.ALinha] = '') then
    begin
      VpaValidos := false;
      aviso(CT_NOMEPRODUTOINVALIDO);
      GProdutos.Col := 2;
    end
    else
    if (GProdutos.Cells[3,GProdutos.ALinha] <> '') then
    begin
      if not Existecor then
      begin
        VpaValidos := false;
        Aviso(CT_CORINEXISTENTE);
        GProdutos.Col := 3;
      end;
    end
    else
      if not ExisteTamanho then
      begin
        VpaValidos := false;
//          Aviso(CT_TAMANHOINEXISTENTE);
        GProdutos.Col := 3;
      end
      else
        if (VprDProCotacao.UnidadeParentes.IndexOf(GProdutos.Cells[8,GProdutos.Alinha]) < 0) then
        begin
          VpaValidos := false;
          aviso(CT_UNIDADEVAZIA);
          GProdutos.col := 8;
        end
        else
          if (GProdutos.Cells[9,GProdutos.ALinha] = '') then
          begin
            VpaValidos := false;
            aviso(CT_QTDPRODUTOINVALIDO);
            GProdutos.Col := 9;
          end
          else
            if ((GProdutos.Cells[10,GProdutos.ALinha] = '')and
               (GProdutos.Cells[11,GProdutos.ALinha] = '')) then
            begin
              VpaValidos := false;
              aviso(CT_VALORUNITARIOINVALIDO);
              GProdutos.Col := 10;
            end
            else
              if (GProdutos.Cells[15,GProdutos.ALinha] <> '') then
              begin
                if not ExisteEmbalagem then
                begin
                  VpaValidos := false;
                  Aviso(CT_EMBALAGEMINEXISTENTE);
                  GProdutos.Col := 15;
                end;
              end;

  if VpaValidos then
  begin
    CarDProdutoOrcamento;
    CalculaValorTotal;
    if (VprDProCotacao.QtdProduto = 0) and not(VprDProCotacao.IndBrinde) then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      GProdutos.col := 9
    end
    else
      if (VprDProCotacao.ValUnitario = 0) and not(VprDProCotacao.IndBrinde) then
      begin
        VpaValidos := false;
        aviso(CT_VALORUNITARIOINVALIDO);
        GProdutos.Col := 10;
      end
      else
        if not FunProdutos.VerificaEstoque( VprDProCotacao.UM,VprDProCotacao.UMOriginal,VprDProCotacao.QtdProduto,VprDProCotacao.SeqProduto,VprDProCotacao.CodCor,VprDProCotacao.CodTamanho) then
          VpaValidos := false
        else
          if not(config.AlterarValorUnitarioNota) and (VprDProCotacao.ValUnitario < FunProdutos.CalculaValorPadrao(VprDProCotacao.UM,VprDProCotacao.UMOriginal,VprDProCotacao.ValUnitarioOriginal,IntToStr(VprDProCotacao.SeqProduto))) then
          begin
            Aviso('VALOR UNITÁRIO INVÁLIDO!!!'#13'O valor unitário não pode ser menor que o valor de tabela.');
            VpaValidos := false;
            GProdutos.Col := 10;
          end
          else
            if not(config.DescontoNota) and (VprDProCotacao.PerDesconto > 0 ) then
            begin
              Aviso('PERCENTUAL DE DESCONTO INVÁLIDO!!!'#13'Não é permitido desconto no produto.');
              VpaValidos := false;
              GProdutos.Col := 10;
            end;

    if VpaValidos then
    begin
      if GProdutos.AEstadoGrade = eginsercao then
      begin
        if FunCotacao.VerificaProdutoDuplicado(VprDCotacao,VprDProCotacao) then
        begin
          VpaValidos := false;
          GProdutos.ExcluiItemDados(true);
          GProdutos.NovaLinha;
        end;
      end;
      AtualizaPesoBrutoLiquido;
    end;
    if VpaValidos then
    begin
      if config.Farmacia and (VprDProCotacao.IndMedicamentoControlado) then
      begin
        if VprDProCotacao.DesRefCliente = '' then
        begin
          VpaValidos := false;
          aviso('NUMERO DO LOTE NÃO PREENCHIDO!!!'#13'É necessário preencher o numero do lote quando o medicamento é controlado.');
          GProdutos.Col := 13;
        end;
      end;
    end;
    if  VpaValidos then
    begin
      VprDCotacao.CodTipoOrcamento := ETipoCotacao.AInteiro;
      VprDCotacao.CodCliente := ECliente.Ainteiro;
      FunCotacao.VerificaBrindeCliente(VprDCotacao,VprDProCotacao);
      CalculaValorTotal;
    end;
    if VpaValidos then
    begin
      if config.AlterarDescontoComSenha and (VprDProCotacao.PerDesconto > Varia.DescontoMaximoNota) then
        if Entrada('Senha de Permissão para desconto','Senha : ',VpfSenha,true,FPrincipal.CorFoco.AFundoComponentes,PanelColor2.color) then
        begin
          if VpfSenha <> Varia.SenhaLiberacao then
          begin
            VpaVAlidos := false;
            Aviso('SENHA DE LIBERAÇÃO INVÁLIDA!!!'#13'O percentual não pode ser superior a '+FormatFloat('0.00%',Varia.DescontoMaximoNota)+' sem a senha de liberação.');
           end;
        end
        else
        begin
          VpaVAlidos := false;
          Aviso('PERCENTUAL DE DESCONTO ACIMA DO PERMITIDO!!!'#13'O percentual não pode ser superior a '+FormatFloat('0.00%',Varia.DescontoMaximoNota));
        end
    end;
    if VpaValidos then
    begin
      if config.BloquearProdutosnaCotacaosemCadastrodePreco then
      begin
        if not FunProdutos.ProdutoCadastradonaTabeladePreco(VprDProCotacao.SeqProduto,VprDProCotacao.CodCor,VprDProCotacao.CodTamanho) then
        begin
          VpaValidos := false;
          aviso('PRODUTO NÃO CADASTRADO NA TABELA DE PRECO!!!'#13'Esse produto não existe cadastrado na tabela de preço.');
        end;
      end;
    end;

    if VpaValidos then
    begin
      if VprDProCopia <> nil then
        VprDProCopia.free;
      VprDProCopia := TRBDOrcProduto.cria;
      FunCotacao.CopiaDProdutoCotacao(VprDProCotacao,VprDProCopia);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3,15 :  Value := '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
     13 : ProximoProduto;
     86 : if (Shift = [ssctrl] ) then
           Begin
             if VprDProCopia <> nil then
             begin
               FunCotacao.CopiaDProdutoCotacao(VprDProCopia,VprDProCotacao);
               GProdutos.CarregaGrade;
             end;
           end;
    114 :
    begin                           // F3
      case GProdutos.Col of
        1 :  LocalizaProduto;
        3 :  ECor.AAbreLocalizacao;
        5 : ETamanho.AAbreLocalizacao;
       15 :  EEmbalagem.AAbreLocalizacao;
      end;
    end;
    107 :begin
           if (Shift = [ssalt] ) then
           Begin
             VprDProCotacao.IndFaturar := true;
             GProdutos.Refresh;
           end;
         end;
    109 :begin
           if Shift = [ssAlt] then
           begin
             VprDProCotacao.IndFaturar := false;
             GProdutos.refresh;
           end;
         end;

  end;

end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin

  if GProdutos.col in [17,18] then  //permite digitar somente S/N
    if not (key in ['s','S','n','N',#8]) then
      key := #0
    else
      if key = 's' Then
        key := 'S'
      else
        if key = 'n' Then
          key := 'N';

  if (key = '.') and  not(GProdutos.col in [1,13,14]) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDCotacao.Produtos.Count >0 then
  begin
    VprDProCotacao := TRBDOrcProduto(VprDCotacao.Produtos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDProCotacao.CodProduto;
    VprCorAnterior := VprDProCotacao.CodCor;
    VprTamanhoAnterior := IntToStr(VprDProCotacao.CodTamanho);
    if config.UtilizarCompose then
    begin
      GCompose.ADados := VprDProCotacao.Compose;
      GCompose.CarregaGrade;
    end;
    CarFoto;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosNovaLinha(Sender: TObject);
begin
  VprDProCotacao := VprDCotacao.AddProduto;
  VprCorAnterior := -1;
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProdutos.AColuna <> ACol then
    begin
      case GProdutos.AColuna of
        1 :if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GProdutos.Cells[1,GProdutos.ALinha] := '';
               GProdutos.Col := 1;
             end;
           end;
        3 : if GProdutos.Cells[3,GProdutos.Alinha] <> '' then
            begin
              if not Existecor then
              begin
                Aviso(CT_CORINEXISTENTE);
                GProdutos.Col := 3;
                abort;
              end;
            end
            else
              ReferenciaProduto;
        5 :if not ExisteTamanho then
           begin
             if not ETamanho.AAbreLocalizacao then
             begin
               GProdutos.Cells[5,GProdutos.ALinha] := '';
               GProdutos.Col := 5;
             end;
           end;
        7 : begin
              CalculaValorUnitarioPeloAlturaProduto;
            end;
        8 : if not ExisteUM then
            begin
              aviso(CT_UNIDADEVAZIA);
              GProdutos.col := 8;
              abort;
            end;
        9 :
             begin
               if GProdutos.Cells[9,GProdutos.ALinha] <> '' then
                 VprDProCotacao.QtdProduto := StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'))
               else
                 VprDProCotacao.QtdProduto := 0;
               VprDProCotacao.ValTotal := VprDProCotacao.ValUnitario * VprDProCotacao.QtdProduto;
               CalculaValorTotalProduto;
             end;
       10 :
             begin
               if (DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.'),','),'0') <> '')then
               begin
                 VprDProCotacao.ValUnitario := StrToFloat(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.'));
                 VprDProCotacao.ValTotal := VprDProCotacao.ValUnitario * VprDProCotacao.QtdProduto;
               end
               else
                 VprDProCotacao.ValUnitario := 0;
               CalculaValorTotalProduto;
             end;
       11 : begin
              if DeletaChars(DeletaChars(DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[11,GProdutos.ALinha],'R'),'$'),'0'),'.'),',') <> '' then
              begin
                if VprDProCotacao.ValTotal <> StrToFloat(DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[11,GProdutos.ALinha],'.'),'R'),'$')) then
                begin
                  if not Config.DescontoNosProdutodaCotacao then //nao pode calcular o valor unitario atraves do valor total se possuir desconto senão sempre ira baixando.
                  begin
                    VprDProCotacao.ValTotal := StrToFloat(DeletaChars(DeletaChars(DeletaChars(GProdutos.Cells[11,GProdutos.ALinha],'.'),'R'),'$'));
                    VprDProCotacao.ValUnitario := VprDProCotacao.ValTotal / VprDProCotacao.QtdProduto;
                    CalculaValorTotalProduto;
                  end;
                end;
              end;
            end;
        12 :
             begin
               if GProdutos.Cells[12,GProdutos.ALinha] <> '' then
                 VprDProCotacao.PerDesconto := StrToFloat(DeletaChars(GProdutos.Cells[12,GProdutos.ALinha],'.'))
               else
                 VprDProCotacao.PerDesconto := 0;
               VprDProCotacao.ValTotal := VprDProCotacao.ValUnitario * VprDProCotacao.QtdProduto;
               CalculaValorTotalProduto;
             end;
       13 : if not config.NumeroSerieProduto then
            begin
              if (GProdutos.Cells[13,GProdutos.ALinha] <> '') and (GProdutos.Cells[1,GProdutos.ALinha] ='') then
              begin
                if not ExisteReferenciaCliente then
                begin
                  aviso('REFERÊNCIA CLIENTE NÃO CADASTRADA!!!'#13'A referência digitada não existe cadastrada para o cliente selecionado.');
                  GProdutos.Col := 13;
                  Abort;
                end;
              end
              else
               GProdutos.Cells[13,GProdutos.ALinha] := VprDProCotacao.DesRefCliente;
            end;
       15 : if GProdutos.Cells[15,GProdutos.Alinha] <> '' then
            begin
              if not ExisteEmbalagem then
              begin
                Aviso(CT_EMBALAGEMINEXISTENTE);
                GProdutos.Col := 15;
                abort;
              end;
            end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaCotacao.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application, '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.Showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaCotacao.ECorRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GProdutos.Cells[3,GProdutos.ALinha] := ECor.Text;
    GProdutos.Cells[4,GProdutos.ALinha] := Retorno1;
    VprDProCotacao.CodCor := ECor.AInteiro;
    ReferenciaProduto;
    GProdutos.AEstadoGrade := egEdicao;
  end;
  VprCorAnterior := ECor.AInteiro;
end;

{******************************************************************************}
procedure TFNovaCotacao.ECorEnter(Sender: TObject);
begin
  ECor.clear;
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosDepoisExclusao(Sender: TObject);
begin
  CalculaValorTotal;
  AtualizaPesoBrutoLiquido;
end;

{******************************************************************************}
procedure TFNovaCotacao.GServicosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDSerCotacao := TRBDOrcServico(VprDCotacao.Servicos.Items[VpaLinha-1]);
  if VprDSerCotacao.CodServico <> 0 then
    GServicos.Cells[1,VpaLinha] := IntToStr(VprDSerCotacao.CodServico)
  else
    GServicos.Cells[1,VpaLinha] := '';
  GServicos.Cells[2,VpaLinha] := VprDSerCotacao.NomServico;
  GServicos.Cells[3,VpaLinha] := VprDSerCotacao.DesAdicional;
  GServicos.Cells[4,VpaLinha] := FormatFloat('###,###,###,##0.000',VprDSerCotacao.QtdServico);
  GServicos.Cells[5,VpaLinha] := FormatFloat('###,###,###,##0.0000',VprDSerCotacao.ValUnitario);
  GServicos.Cells[6,VpaLinha] := FormatFloat('R$ #,###,###,###,##0.000',VprDSerCotacao.ValTotal)
end;

{******************************************************************************}
procedure TFNovaCotacao.GServicosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GServicos.Cells[1,GServicos.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_SERVICONAOCADASTRADO);
  end
  else
    if not ExisteServico then
    begin
      VpaValidos := false;
      aviso(CT_SERVICONAOCADASTRADO);
      GServicos.col := 1;
    end
    else
      if (GServicos.Cells[4,GServicos.ALinha] = '') then
      begin
        VpaValidos := false;
        aviso(CT_QTDSERVICOSINVALIDO);
        GProdutos.Col := 4;
      end
      else
        if (GServicos.Cells[5,GServicos.ALinha] = '') then
        begin
          VpaValidos := false;
          aviso(CT_VALORUNITARIOINVALIDO);
          GServicos.Col := 5;
        end;
  if VpaValidos then
  begin
    CarDServicoOrcamento;
    CalculaValorTotal;
    if VprDSerCotacao.QtdServico = 0 then
    begin
      VpaValidos := false;
      aviso(CT_QTDSERVICOINVALIDO);
      GServicos.col := 4;
    end
    else
      if VprDSerCotacao.ValUnitario = 0 then
      begin
        VpaValidos := false;
        aviso(CT_VALORUNITARIOINVALIDO);
        GServicos.Col := 5;
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GServicosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1 :  Value := '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GServicosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GServicos.Col of
        1 :  LocalizaServico;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GServicosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = '.') then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaCotacao.GServicosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDCotacao.Servicos.Count >0 then
  begin
    VprDSerCotacao := TRBDOrcServico(VprDCotacao.Servicos.Items[VpaLinhaAtual-1]);
    VprServicoAnterior := IntTostr(VprDSerCotacao.CodServico);
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GServicosNovaLinha(Sender: TObject);
begin
  VprDSerCotacao := VprDCotacao.AddServico;
end;

{******************************************************************************}
procedure TFNovaCotacao.GServicosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GServicos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GServicos.AColuna <> ACol then
    begin
      case GServicos.AColuna of
        1 :if not ExisteServico then
           begin
             if not LocalizaServico then
             begin
               GServicos.Cells[1,GServicos.ALinha] := '';
               abort;
             end;
           end;
        4,5 :
             begin
               if GServicos.Cells[4,GServicos.ALinha] <> '' then
                 VprDSerCotacao.QtdServico := StrToFloat(DeletaChars(GServicos.Cells[4,GServicos.ALinha],'.'))
               else
                 VprDSerCotacao.QtdServico := 0;
               if GServicos.Cells[5,GServicos.ALinha] <> '' then
                 VprDSerCotacao.ValUnitario := StrToFloat(DeletaChars(GServicos.Cells[5,GServicos.ALinha],'.'))
               else
                 VprDSerCotacao.ValUnitario := 0;
               CalculaValorTotalServico;
             end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaCotacao.ETransportadoraRetorno(Retorno1, Retorno2: String);
var
  VpfNomtransportadora, VpfCNPJTransportadora, VpfEndTransportadora, VpfCidTransportadora, VpfUFTransportadora, VpfIETransportadora: String;
begin
  if ETransportadora.Text <> '' then
  begin
    FunCotacao.RetornaDadosTransportadora(StrToInt(ETransportadora.Text), VpfNomTransportadora, VpfCNPJTransportadora,
      VpfEndTransportadora, VpfCidTransportadora, VpfUFTransportadora, VpfIEtransportadora);
    ECNPJTransportadora.Text := VpfCNPJTransportadora;
    EEndTransportadora.Text := VpfEndTransportadora;
    ECidTransportadora.Text   := VpfCidTransportadora;
    EUFTransportadora.Text       := VpfUFTransportadora;
    EIETransportadora.Text       := VpfIETransportadora;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.ETransportadoraCadastrar(Sender: TObject);
begin
  FNovaTransportadora := TFNovaTransportadora.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaTransportadora'));
  FNovaTransportadora.CadTransportadoras.Insert;
  FNovaTransportadora.ShowModal;
  FNovaTransportadora.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaCotacao.ETipoCotacaoCadastrar(Sender: TObject);
begin
  FTipoCotacao := TFTipoCotacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FTipoCotacao'));
  FTipoCotacao.ShowModal;
  FTipoCotacao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaCotacao.BCadastrarClick(Sender: TObject);
begin
  VprOperacao := 1;
  VprDCotacao.free;
  VprDCotacao := TRBDOrcamento.cria;
  GProdutos.ADados := VprDCotacao.Produtos;
  GServicos.ADados := VprDCotacao.Servicos;
  LimpaComponentes(ScrollBox1,0);
  InicializaTela;
  AlteraEnabledBotoes(true);
  ScrollBox1.VertScrollBar.Position := 0;
  AlteraReadOnlyDet(ScrollBox1,0,false);
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosEnter(Sender: TObject);
begin
  CarDClasse;
end;

{******************************************************************************}
procedure TFNovaCotacao.EEmbalagemCadastrar(Sender: TObject);
begin
  FEmbalagem := TFEmbalagem.CriarSDI(application , '',FPrincipal.VerificaPermisao('FEmbalagem'));
  FEmbalagem.BotaoCadastrar1.Click;
  FEmbalagem.Showmodal;
  FEmbalagem.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaCotacao.EEmbalagemEnter(Sender: TObject);
begin
  EEmbalagem.Clear;
end;

procedure TFNovaCotacao.EEmbalagemRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GProdutos.Cells[15,GProdutos.ALinha] := EEmbalagem.Text;
    GProdutos.Cells[16,GProdutos.ALinha] := Retorno1;
    GProdutos.AEstadoGrade := egEdicao;
  end;

end;

procedure TFNovaCotacao.EFormaPagamentoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(self,'',true);
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.ShowModal;
  FFormasPagamento.Free;
end;

{******************************************************************************}
procedure TFNovaCotacao.SpeedButton7Click(Sender: TObject);
begin
  FReferenciaProduto := TFReferenciaProduto.CriarSDI(application , '', FPrincipal.VerificaPermisao('FReferenciaProduto'));
  FReferenciaProduto.ShowModal;
  FReferenciaProduto.free;
end;

procedure TFNovaCotacao.EDescontoChange(Sender: TObject);
begin
  if (VprOperacao in [1,2]) then
  begin
    CarDDesconto;
    CalculaValorTotal;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.ETipoCotacaoRetorno(Retorno1, Retorno2: String);
begin
  FunCotacao.CarDtipoCotacao(VprDTipoCotacao,ETipoCotacao.AInteiro);
  ConfiguraTelaChamado;
  if VprOperacao in [1,2] then
  begin
    VprDCotacao.CodPlanoContas := VprDTipoCotacao.CodPlanoContas;
    VprDCotacao.CodOperacaoEstoque := VprDTipoCotacao.CodOperacaoEstoque;
    if VprDTipoCotacao.CodVendedor <> 0 then
    begin
      EVendedor.AInteiro := VprDTipoCotacao.CodVendedor;
      EVendedor.Atualiza;
    end;
    if not VprDTipoCotacao.IndChamado then
    begin
      EDesProblema.Clear;
      EValChamado.Clear;
      EValDeslocamento.clear;
      PTransportadora.Visible := config.UtilizarTransPedido;
    end
    else
    Begin
      CarDChamado;
      PTransportadora.Visible := false;
    end;
    if (VprDTipoCotacao.IndExigirDataEntregaPrevista) and
       (config.ExigirDataEntregaPrevista) then
      EDatPrevista.Clear
    else
    begin
      EDatPrevista.Text := FormatDateTime('DD/MM/YY',Date);
      EHorPrevista.Text := formatDatetime('HH:MM',now);
    end;
    if VprDCotacao.IndRevenda <> VprDTipoCotacao.IndRevenda then
    begin
      VprDCotacao.IndRevenda := VprDTipoCotacao.IndRevenda;
      FunCotacao.CarPrecosProdutosRevenda(VprDCotacao);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.Trocas1Click(Sender: TObject);
begin
  if ECliente.AInteiro <> 0 then
  begin
    FNovaNotaFiscaisFor := TFNovaNotaFiscaisFor.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaNotaFiscaisFor'));
    if FNovaNotaFiscaisFor.GeraTroca(VprDCliente,VprDCotacao) then
    begin
      EValTroca.AValor := VprDCotacao.ValTroca;
      CalculaValorTotal;
    end;
    FNovaNotaFiscaisFor.free;
  end
  else
    aviso('CLIENTE NÃO PREENCHIDO!!!'#13+'É necessário preencher o código do cliente antes de digitar a troca.');
end;

{******************************************************************************}
procedure TFNovaCotacao.ValVendaTamanho;
Var
  VpfValVenda : Double;
begin
  VpfValVenda := FunProdutos.RValVendaTamanhoeCor(VprDProCotacao.SeqProduto,VprDProCotacao.CodCor,VprDProCotacao.CodTamanho);
  if VpfValVenda <> 0 then
  begin
    VprDProCotacao.ValUnitario := VpfValVenda;
    VprDProCotacao.ValTotal := VprDProCotacao.ValUnitario * VprDProCotacao.QtdProduto;
    ReferenciaProduto;
    CalculaValorTotalProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.EClienteAlterar(Sender: TObject);
begin
  if ECliente.ALocaliza.Loca.Tabela.FieldByName(ECliente.AInfo.CampoCodigo).AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+ECliente.ALocaliza.Loca.Tabela.FieldByName(ECliente.AInfo.CampoCodigo).asString);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    Localiza.AtualizaConsulta;
    FNovoCliente.free;
    VprDCotacao.CodCliente := -1;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.MImprimirOpClick(Sender: TObject);
begin
  if (Varia.CNPJFilial = CNPJ_RELOPONTO) or
     (varia.CNPJFilial = CNPJ_RLP) then
    FunCrystal.ImprimeRelatorio(Varia.PathRelatorios + '\Cotações\XX_CotacaoVias.rpt',[IntToStr(VprDCotacao.CodEmpFil),Inttostr(VprDCotacao.LanOrcamento),IntToStr(VprDCotacao.CodEmpFil),Inttostr(VprDCotacao.LanOrcamento)])
  else
    FunCrystal.ImprimeRelatorio(Varia.PathRelatorios+ '\Ordem Produção\0100PL_OPCotacao.rpt',[IntToStr(VprDCotacao.CodEmpFil),IntToStr(VprDCotacao.LanOrcamento)]);
end;

{******************************************************************************}
procedure TFNovaCotacao.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PEstagios then
    AtualizaConsultaEstagios
  else
    if Paginas.ActivePage = PEmails then
      PosEmails
    else
       if Paginas.ActivePage.Tag = 9 then

end;

{******************************************************************************}
procedure TFNovaCotacao.PosEmails;
begin
  ORCAMENTOEMAIL.SQL.Clear;
  ORCAMENTOEMAIL.SQL.Add('SELECT OCE.DATEMAIL, OCE.DESEMAIL, USU.C_NOM_USU'+
                         ' FROM ORCAMENTOEMAIL OCE, CADUSUARIOS USU'+
                         ' WHERE USU.I_COD_USU = OCE.CODUSUARIO'+
                         ' AND OCE.LANORCAMENTO = '+IntToStr(VprDCotacao.LanOrcamento));
  ORCAMENTOEMAIL.SQL.Add(' ORDER BY OCE.DATEMAIL');
  GEmails.ALinhaSQLOrderBy:= ORCAMENTOEMAIL.SQL.Count-1;
  ORCAMENTOEMAIL.Open;
end;

{******************************************************************************}
procedure TFNovaCotacao.AdicionaProdutosChamado(VpaDChamado : TRBDChamado);
var
  VpfLacoItems,VpfLacoProdutos : Integer;
  VpfDProChamado : TRBDChamadoProduto;
  VpfDProOrcado : TRBDChamadoProdutoOrcado;
  VpfDSerOrcado : TRBDChamadoServicoOrcado;
begin
  for VpfLacoItems := 0 to VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDProChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpflacoItems]);
    for VpfLacoProdutos := 0 to VpfDProChamado.ProdutosOrcados.Count - 1 do
    begin
      VpfDProOrcado:= TRBDChamadoProdutoOrcado(VpfDProChamado.ProdutosOrcados.Items[VpfLacoProdutos]);
      VprDProCotacao:= VprDCotacao.AddProduto;
      VprDProCotacao.SeqProduto:= VpfDProOrcado.SeqProduto;
      VprDProCotacao.CodProduto:= VpfDProOrcado.CodProduto;
      FunCotacao.ExisteProduto(VprDProCotacao.CodProduto,0,VprDProCotacao,VprDCotacao);
      VprDProCotacao.UM:= VpfDProOrcado.DesUM;
      VprDProCotacao.QtdProduto:= VpfDProOrcado.Quantidade;
      VprDProCotacao.ValUnitario:= VpfDProOrcado.ValUnitario;
      VprDProCotacao.ValTotal:= VpfDProOrcado.ValTotal;
    end;

    for VpfLacoProdutos := 0 to VpfDProChamado.ServicosOrcados.Count - 1 do
    begin
      VpfDSerOrcado:= TRBDChamadoServicoOrcado(VpfDProChamado.ServicosOrcados.Items[VpfLacoProdutos]);
      VprDSerCotacao:= VprDCotacao.AddServico;

      VprDSerCotacao.CodServico := VpfDSerOrcado.CodServico;
      FunCotacao.ExisteServico(IntToStr(VpfDSerOrcado.CodSErvico),VprDSerCotacao);
      VprDSerCotacao.NomServico := VpfDSerOrcado.NomServico;
      VprDSerCotacao.QtdServico := VpfDSerOrcado.QtdServico;
      VprDSerCotacao.ValUnitario := VpfDSerOrcado.ValUnitario;
      VprDSerCotacao.ValTotal := VpfDSerOrcado.ValTotal;
    end;
  end;
  GProdutos.CarregaGrade;
  GServicos.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaCotacao.CarFoto;
begin
    try
      if (VprDProCotacao.pathFoto  <> '') then
        Foto.Picture.LoadFromFile(varia.DriveFoto + VprDProCotacao.pathFoto)
      else
        Foto.Picture := nil;
    except
        Foto.Picture := nil;
    end;
end;

{******************************************************************************}
procedure TFNovaCotacao.FormurioGarantia1Click(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeGarantia(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,false);
  dtRave.free;
end;

{******************************************************************************}
procedure TFNovaCotacao.ECodTecnicoCadastrar(Sender: TObject);
begin
  FNovoTecnico := TFNovoTecnico.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoTecnico'));
  FNovoTecnico.Tecnico.Insert;
  FNovoTecnico.ShowModal;
  FNovoTecnico.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaCotacao.ChamadoTcnico1Click(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeChamadodaCotacao(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,false);
  dtRave.free;
end;

{******************************************************************************}
procedure TFNovaCotacao.Envelope1Click(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeEnvelope(VprDCliente);
  dtRave.free;
end;

{******************************************************************************}
procedure TFNovaCotacao.GProdutosGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDItem : TRBDOrcProduto;
begin
  if (ARow > 0) and (Acol > 0) then
  begin
    if VprDCotacao.Produtos.Count >0 then
    begin
      VpfDItem := TRBDOrcProduto(VprDCotacao.Produtos.Items[arow-1]);
      if VpfDItem.SeqProduto <> 0 then
      begin
        if Config.EstoqueFiscal  then
        begin
          if (VpfDItem.IndFaturar ) then
            ABrush.Color := $0080FF80
          else
            if VpfDItem.QtdFiscal < 0 then
              ABrush.Color := $008080FF
            else
              if VpfDItem.QtdFiscal = 0 then
                ABrush.Color := $0080FFFF
        end;
        if VpfDItem.IndBrinde then
          AFont.Color := clblue;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.ECodPrepostoRetorno(Retorno1, Retorno2: String);
begin
  if (EComissaoPreposto.AValor = 0) and (VprOperacao in [1,2]) then
    if (Retorno1 <> '') then
      EComissaoPreposto.AValor := StrToFloat(Retorno1);
end;

{******************************************************************************}
procedure TFNovaCotacao.Boleto1Click(Sender: TObject);
begin
  FunCotacao.ImprimirBoletos(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento,VprDCliente,'');
end;

{******************************************************************************}
procedure TFNovaCotacao.BGeraCupomClick(Sender: TObject);
begin
  FNovoECF := TFNovoECF.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoECF'));
  if FNovoECF.GeraECFAPartirCotacao(VprDCotacao) then
  begin
    VprDCotacao.IndNotaGerada := true;
    FunCotacao.GravaDCotacao(VprDCotacao,nil);
  end;
  FNovoECF.free;
  BGeraCupom.Enabled := false;
end;

{******************************************************************************}
procedure TFNovaCotacao.FormShow(Sender: TObject);
begin
  PRodaPe.Height := 10;
end;

{******************************************************************************}
procedure TFNovaCotacao.Brindes1Click(Sender: TObject);
begin
  if ECliente.AInteiro <> 0 then
  begin
    FBrindesCliente := TFBrindesCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBrindesCliente'));
    FBrindesCliente.BrindesCliente(ECliente.AInteiro);
    FBrindesCliente.free;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.ConsumoMateriaPrima1Click(Sender: TObject);
begin
  FunCrystal.ImprimeRelatorio(Varia.PathRelatorios+ '\Cotações\XX_consumocotacao.rpt',[IntToStr(VprDCotacao.CodEmpFil),IntToStr(VprDCotacao.LanOrcamento)]);
end;

{******************************************************************************}
procedure TFNovaCotacao.BEntregadorClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunCotacao.EnviaEmailCotacaoTransportadora(VprDCotacao,VprDCliente);
  if VpfREsultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFNovaCotacao.ETabelaPrecoSelect(Sender: TObject);
begin
  ETabelaPreco.ASelectValida.Text := 'Select * from CADTABELAPRECO '+
                                     ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                                     ' and I_COD_TAB = @';
  ETabelaPreco.ASelectLocaliza.Text := 'Select * from CADTABELAPRECO '+
                                     ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                                     ' and C_NOM_TAB LIKE ''@%''';
end;

{******************************************************************************}
procedure TFNovaCotacao.EMedicoCadastrar(Sender: TObject);
begin
  FMedico := TFMedico.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMedico'));
  FMedico.BotaoCadastrar1.Click;
  FMedico.showmodal;
  FMedico.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaCotacao.Alterar1Click(Sender: TObject);
begin
  AlteraCotacao(VprDCotacao.CodEmpFil,VprDCotacao.LanOrcamento);
end;

{******************************************************************************}
procedure TFNovaCotacao.GComposeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  if config.UtilizarCompose then
  begin
    VprDCompCotacao := TRBDOrcCompose(VprDProCotacao.Compose.Items[VpaLinha-1]);
    GCompose.Cells[1,VpaLinha] := IntToStr(VprDCompCotacao.CorRefencia);
    GCompose.Cells[2,VpaLinha] := VprDCompCotacao.CodProduto;
    GCompose.Cells[3,VpaLinha] := VprDCompCotacao.NomProduto;
    if VprDCompCotacao.CodCor <> 0 then
      GCompose.Cells[4,VpaLinha] := InttoStr(VprDCompCotacao.CodCor)
    else
      GCompose.Cells[4,VpaLinha] := '';
    GCompose.Cells[5,VpaLinha] := VprDCompCotacao.NomCor;
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GComposeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ExisteProdutoCompose then
  begin
    VpaValidos := false;
    aviso('PRODUTO INVÁLIDO!!!#13O produto digitado não existe cadastrado...');
    GCompose.Col := 2;
  end
  else
    if not ExisteCorCompose then
    begin
      aviso('COR INVÁLIDA!!!#13A cor digitada não existe cadastrada...');
      GCompose.Col := 4;
    end;
  if VpaValidos then
    CarDComposeOrcamento;
end;

procedure TFNovaCotacao.GComposeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    4 : Value := '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GComposeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GCompose.Col of
        2 :  LocalizaProdutoCompose;
        4 :  ECorCompose.AAbreLocalizacao;
      end;
    end;
  end;

end;

{******************************************************************************}
procedure TFNovaCotacao.ECorComposeRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GCompose.Cells[4,GCompose.ALinha] := ECorCompose.Text;
    GCompose.Cells[5,GCompose.ALinha] := Retorno1;
    ExisteCorCompose;
  end;

end;

{******************************************************************************}
procedure TFNovaCotacao.GComposeKeyPress(Sender: TObject; var Key: Char);
begin
   if GCompose.col = 1 then
     key := #0;
end;

{******************************************************************************}
procedure TFNovaCotacao.GComposeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDProCotacao <> nil then
   if VprDCotacao.Produtos.Count >0 then
    begin
      if VprDProCotacao.Compose.Count > 0 then
      begin
        VprDCompCotacao := TRBDOrcCompose(VprDProCotacao.Compose.Items[VpaLinhaAtual-1]);
        VprProdutoComposeAnterior := VprDCompCotacao.CodProduto;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaCotacao.GComposeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GCompose.AEstadoGrade in [egInsercao,EgEdicao] then
    if GCompose.AColuna <> ACol then
    begin
      case GCompose.AColuna of
        2 :if not ExisteProdutoCompose then
           begin
             if not LocalizaProdutoCompose then
             begin
               GCompose.Cells[2,GCompose.ALinha] := '';
               GCompose.Col := 2;
             end;
           end;
        4 : if GCompose.Cells[4,GCompose.Alinha] <> '' then
            begin
              if not ExisteCorCompose then
              begin
                Aviso(CT_CORINEXISTENTE);
                GCompose.Col := 4;
                abort;
              end;
            end;
      end;
    end;

end;

{******************************************************************************}
procedure TFNovaCotacao.ETamanhoCadastrar(Sender: TObject);
begin
  FTamanhos := TFTamanhos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTamanhos'));
  FTamanhos.BCadastrar.Click;
  FTamanhos.ShowModal;
  FTamanhos.free;
end;

{******************************************************************************}
procedure TFNovaCotacao.ETamanhoEnter(Sender: TObject);
begin
  ETamanho.Clear;
end;

procedure TFNovaCotacao.ETamanhoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GProdutos.Cells[5,GProdutos.ALinha] := ETamanho.Text;
    GProdutos.Cells[6,GProdutos.ALinha] := Retorno1;
    VprDProCotacao.CodTamanho := ETamanho.AInteiro;
    VprDProCotacao.NomTamanho := retorno1;
    VprTamanhoAnterior := ETamanho.Text;
    GProdutos.AEstadoGrade := egEdicao;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.NovaCotacaoProposta(VpaDProposta: TRBDPropostaCorpo): Boolean;
begin
  VprOperacao:= 3;
  InicializaTela;
  FunCotacao.CopiaDCotacaoProposta(VpaDProposta, VprDCotacao);
  VprDCliente.CodCliente:= VprDCotacao.CodCliente;
  CarDTelaNovaCotacaoProsposta;
  VprOperacao:= 1;
  ETipoCotacao.Atualiza;
  EVendedor.Atualiza;
  ValidaGravacao1.execute;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFNovaCotacao.CarDTelaNovaCotacaoProsposta;
begin
  CarDTela;
  GProdutos.CarregaGrade;
  GServicos.CarregaGrade;
  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovaCotacao.EContatoExit(Sender: TObject);
var
  VpfNomContato: String;
begin
  if EContato.Text = VprDCliente.NomContato then
    EEmailContato.Text:= VprDCliente.DesEmail
  else
  begin
    VpfNomContato:= EContato.Text;
    EEmailContato.Text:= FunClientes.REmailContatoCliente(VprDCliente.CodCliente, VpfNomContato);
    if EEmailContato.Text <> '' then
      EContato.Text:= VpfNomContato;
  end;
end;

{******************************************************************************}
function TFNovaCotacao.AtualizaContatoCliente: String;
begin
  Result:= FunClientes.VerificaAtualizaContatoCliente(ECliente.AInteiro, VprDCliente, EContato.Text, EEmailContato.Text);
end;

{******************************************************************************}
procedure TFNovaCotacao.MImpressaoPopup(Sender: TObject);
begin
  if (varia.CNPJFilial = CNPJ_Zumm) or (varia.CNPJFilial = CNPJ_ZummH) then
    MImprimirOp.Visible:= False;
end;

{******************************************************************************}
procedure TFNovaCotacao.SomenteServicos1Click(Sender: TObject);
var
  VpfCotacoes : TList;
begin
  VpfCotacoes := TList.Create;
  VpfCotacoes.add(VprDCotacao);
  FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
  FNovaNotaFiscalNota.GeraNotaCotacoes(VpfCotacoes,true);
  FNovaNotaFiscalNota.free;
  VpfCotacoes.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaCotacao]);
 //1215
end.
