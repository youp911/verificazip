unit ANovoProdutoPro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons, UnDadosProduto,
  ComCtrls, DBCtrls, Tabela, Mask, numericos, Localizacao, DBKeyViolation, Constantes,
  UnProdutos, UnClassificacao, EditorImagem, Grids, CGrades, UnClientes,
  Spin, UnDadosLocaliza, UnContasaReceber;

type
  TFNovoProdutoPro = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BCancelar: TBitBtn;
    BGravar: TBitBtn;
    BFechar: TBitBtn;
    Paginas: TPageControl;
    PGerais: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    Label31: TLabel;
    LblClassificacaoFiscal: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    LblDescontoKit: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label21: TLabel;
    Label7: TLabel;
    LQtdCaixa: TLabel;
    LblQtdMin: TLabel;
    LblQtdPed: TLabel;
    Label14: TLabel;
    Label23: TLabel;
    LValVenda: TLabel;
    LValCusto: TLabel;
    Label73: TLabel;
    Label6: TLabel;
    LDescricaoTecnica: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    BFoto: TBitBtn;
    Label2: TLabel;
    LPatFoto: TLabel;
    EValVenda: Tnumerico;
    EPerMaxDesconto: Tnumerico;
    EQuantidade: Tnumerico;
    EPerIPI: Tnumerico;
    EReducaoICMS: Tnumerico;
    EPerDesconto: Tnumerico;
    EPerComissao: Tnumerico;
    EQtdEntregaFornecedor: Tnumerico;
    EQtdMinima: Tnumerico;
    EQtdPedido: Tnumerico;
    EValCusto: Tnumerico;
    ECodProduto: TEditColor;
    EDescricao: TEditColor;
    ECodMoeda: TEditLocaliza;
    Localiza: TConsultaPadrao;
    Label5: TLabel;
    ECifraoMoeda: TEditColor;
    EClassificacaoFiscal: TMaskEditColor;
    ECodBarraFornecedor: TEditColor;
    LNomClassificacao: TLabel;
    EUnidadesPorCaixa: Tnumerico;
    EUnidadesVenda: TComboBoxColor;
    EDescricaoTecnica: TMemoColor;
    ValidaGravacao: TValidaGravacao;
    CProdutoAtivo: TCheckBox;
    EditorImagem: TEditorImagem;
    PCadarco: TTabSheet;
    Label40: TLabel;
    Label41: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label25: TLabel;
    Label58: TLabel;
    Label63: TLabel;
    Label24: TLabel;
    ENumFios: TEditColor;
    ETipMaquina: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    EMetrosMinuto: TEditColor;
    EEngEspPequena: TEditColor;
    EEngEspGrande: TEditColor;
    EQtdFuso: TEditColor;
    ETituloFio: TEditColor;
    EMetTabuaPequeno: TEditColor;
    EMetTabuaGrande: TEditColor;
    EMetTabuaTrans: TEditColor;
    EEnchimento: TEditColor;
    ELargProduto: TEditColor;
    PETiqueta: TTabSheet;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    Label26: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label59: TLabel;
    Label61: TLabel;
    Label22: TLabel;
    Label38: TLabel;
    Label88: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    ESumula: TEditColor;
    ELarguraProduto: TEditColor;
    EComprFigura: TEditColor;
    ENumeroFios: TEditColor;
    EPente: TEditColor;
    EBatidasTotais: TEditColor;
    EBatidasProduto: TEditColor;
    EBatidasTear: TEditColor;
    EIndiceProdutividade: TEditColor;
    ETipFundo: TEditLocaliza;
    Label12: TLabel;
    ETipEmenda: TEditLocaliza;
    Label15: TLabel;
    ETipCorte: TEditLocaliza;
    Label20: TLabel;
    CEngomagem: TCheckBox;
    EEngrenagem: TEditColor;
    EPrateleiraProduto: TEditColor;
    Panel1: TPanel;
    RTearConvencional: TRadioButton;
    RTearH: TRadioButton;
    Label28: TLabel;
    Label89: TLabel;
    CCalandragem: TCheckBox;
    EComprProduto: TEditColor;
    PCombinacao: TTabSheet;
    Label35: TLabel;
    Label37: TLabel;
    Label39: TLabel;
    GCombinacao: TRBStringGridColor;
    GFigura: TRBStringGridColor;
    PDadosAdicionais: TTabSheet;
    Label49: TLabel;
    Label50: TLabel;
    Label64: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label42: TLabel;
    Label86: TLabel;
    Label165: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Label87: TLabel;
    SpeedButton28: TSpeedButton;
    Label167: TLabel;
    Label77: TLabel;
    Label74: TLabel;
    EPesoLiquido: Tnumerico;
    EPesoBruto: Tnumerico;
    EPrateleiraPro: TEditColor;
    EEmbalagem: TEditLocaliza;
    EAcondicionamento: TEditLocaliza;
    ECodDesenvolvedor: TEditLocaliza;
    EAlturaProduto: TEditColor;
    CImprimeTabelaPreco: TCheckBox;
    CCracha: TCheckBox;
    CProdutoRetornavel: TCheckBox;
    ERendimento: TMemoColor;
    PCopiadoras: TTabSheet;
    Label46: TLabel;
    Label60: TLabel;
    Label62: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Panel2: TPanel;
    RColorida: TRadioButton;
    RMonoCromatica: TRadioButton;
    Panel3: TPanel;
    RMatricial: TRadioButton;
    RJatoTinta: TRadioButton;
    RLaser: TRadioButton;
    Panel4: TPanel;
    RMonoComponente: TRadioButton;
    RBiComponente: TRadioButton;
    Panel5: TPanel;
    RTonerComCilindro: TRadioButton;
    RTonerSemCilindro: TRadioButton;
    Panel6: TPanel;
    CCopiadora: TCheckBox;
    CMultiFuncional: TCheckBox;
    CImpressora: TCheckBox;
    EQtdCopiasToner: TEditColor;
    EQtdCopiasCilindro: TEditColor;
    EQtdCopiasTonerAltaCapacidade: TEditColor;
    EQtdPaginasPorMinuto: TEditColor;
    ECodCartucho: TEditColor;
    ECodCartuchoAltaCapacidade: TEditColor;
    EVolumeMensalCopias: TEditColor;
    Panel7: TPanel;
    CPlacaRede: TCheckBox;
    CPcl: TCheckBox;
    CFax: TCheckBox;
    CUSB: TCheckBox;
    CScanner: TCheckBox;
    CWireless: TCheckBox;
    CDuplex: TCheckBox;
    EDatAmostra: TMaskEditColor;
    EDatSaidaAmostra: TMaskEditColor;
    EDatFabricacao: TMaskEditColor;
    EDatEncerramentoProducao: TMaskEditColor;
    PCartuchos: TTabSheet;
    PEstagios: TTabSheet;
    GEstagios: TRBStringGridColor;
    PFornecedores: TTabSheet;
    GFornecedores: TRBStringGridColor;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label90: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    SpeedButton11: TSpeedButton;
    Label92: TLabel;
    ECodigoReduzido: TEditColor;
    EPesoCartuchoVazio: TEditColor;
    EPesoCartuchoCheio: TEditColor;
    EQtdPaginas: TEditColor;
    ECodCor: TEditLocaliza;
    Panel8: TPanel;
    RCartuchoTinta: TRadioButton;
    RCartuchoTonner: TRadioButton;
    Label91: TLabel;
    CChipNovo: TCheckBox;
    CCilindroNovo: TCheckBox;
    CProdutoOriginal: TCheckBox;
    CCartuchoTexto: TCheckBox;
    CProdutoCompativel: TCheckBox;
    Label85: TLabel;
    GImpressoras: TRBStringGridColor;
    EQtdML: TEditColor;
    EFornecedor: TEditLocaliza;
    ECor: TEditLocaliza;
    EEstagio: TEditLocaliza;
    BKit: TBitBtn;
    ECodClassificacao: TMaskEditColor;
    SpeedButton8: TSpeedButton;
    Label4: TLabel;
    EValRevenda: Tnumerico;
    EPerLucro: Tnumerico;
    Label10: TLabel;
    Label32: TLabel;
    EMesesGarantia: TSpinEditColor;
    Label65: TLabel;
    SpeedButton12: TSpeedButton;
    Label66: TLabel;
    EUsuario: TRBEditLocaliza;
    Label17: TLabel;
    EMetCadarco: TEditColor;
    EDatCadastro: TEditColor;
    Label93: TLabel;
    PAcessorios: TTabSheet;
    GAcessorios: TRBStringGridColor;
    EAcessorio: TRBEditLocaliza;
    Label94: TLabel;
    EComposicao: TRBEditLocaliza;
    Label95: TLabel;
    SpeedButton13: TSpeedButton;
    Label96: TLabel;
    CMonitorarEstoque: TCheckBox;
    EOrigemProduto: TComboBoxColor;
    PTabelaPreco: TTabSheet;
    GPreco: TRBStringGridColor;
    ETabelaPreco: TRBEditLocaliza;
    ETamanho: TRBEditLocaliza;
    ECliPreco: TRBEditLocaliza;
    EMoeda: TRBEditLocaliza;
    PInstalacaoTear: TTabSheet;
    PanelColor3: TPanelColor;
    GInstalacao: TRBStringGridColor;
    EQtdQuadros: TSpinEditColor;
    Label97: TLabel;
    Label98: TLabel;
    EQtdColInstalacao: TSpinEditColor;
    ECapacidadeLiquida: Tnumerico;
    Label99: TLabel;
    Label100: TLabel;
    PanelColor4: TPanelColor;
    BRepeticaoDesenho: TSpeedButton;
    BZoomMenos: TSpeedButton;
    BCursor: TSpeedButton;
    BZoomMais: TSpeedButton;
    BNovo: TSpeedButton;
    PanelColor5: TPanelColor;
    EProdutoInstalacao: TRBEditLocaliza;
    SpeedButton14: TSpeedButton;
    Label101: TLabel;
    LNomProdutoInstalacao: TLabel;
    LNomCorInstalacao: TLabel;
    Label104: TLabel;
    ECorInstalacao: TRBEditLocaliza;
    SpeedButton15: TSpeedButton;
    Label105: TLabel;
    EQtdFiosLico: Tnumerico;
    Label106: TLabel;
    EFuncaoFio: TComboBoxColor;
    ECorPreco: TRBEditLocaliza;
    CProduto: TRadioButton;
    CKit: TRadioButton;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    PanelColor8: TPanelColor;
    PanelColor9: TPanelColor;
    PanelColor10: TPanelColor;
    PanelColor11: TPanelColor;
    EDestinoProduto: TComboBoxColor;
    Label102: TLabel;
    GDPC: TRBStringGridColor;
    EQtdLinInstalacao: TSpinEditColor;
    Label8: TLabel;
    Splitter1: TSplitter;
    PanelColor12: TPanelColor;
    PCadarcoFita: TTabSheet;
    PanelColor13: TPanelColor;
    Label16: TLabel;
    SpeedButton2: TSpeedButton;
    Label103: TLabel;
    EditLocaliza1: TEditLocaliza;
    Label107: TLabel;
    EditColor1: TEditColor;
    EditColor2: TEditColor;
    Label108: TLabel;
    Label109: TLabel;
    EditColor3: TEditColor;
    Label110: TLabel;
    EditColor4: TEditColor;
    Label111: TLabel;
    EditColor5: TEditColor;
    Label112: TLabel;
    EditColor6: TEditColor;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;

    procedure PaginasChange(Sender: TObject);
    procedure PaginasChanging(Sender: TObject; var AllowChange: Boolean);

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BFecharClick(Sender: TObject);
    procedure ECodEmpresaChange(Sender: TObject);
    procedure ECodClassificacaoExit(Sender: TObject);
    procedure ECodClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ECodMoedaRetorno(Retorno1, Retorno2: String);
    procedure ECodProdutoExit(Sender: TObject);
    procedure BFotoClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BKitClick(Sender: TObject);
    procedure EUnidadesVendaChange(Sender: TObject);
    procedure EBatidasTotaisExit(Sender: TObject);
    procedure ETipMaquinaCadastrar(Sender: TObject);
    procedure ETipFundoCadastrar(Sender: TObject);
    procedure ETipEmendaCadastrar(Sender: TObject);
    procedure ETipCorteCadastrar(Sender: TObject);
    procedure EEmbalagemCadastrar(Sender: TObject);
    procedure EAcondicionamentoCadastrar(Sender: TObject);
    procedure ECodCorCadastrar(Sender: TObject);
    procedure EEstagioCadastrar(Sender: TObject);
    procedure GFornecedoresCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GFornecedoresDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GFornecedoresGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure GFornecedoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GFornecedoresKeyPress(Sender: TObject; var Key: Char);
    procedure GFornecedoresMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GFornecedoresNovaLinha(Sender: TObject);
    procedure GFornecedoresSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GEstagiosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GEstagiosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GEstagiosDepoisExclusao(Sender: TObject);
    procedure GEstagiosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GEstagiosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GEstagiosKeyPress(Sender: TObject; var Key: Char);
    procedure GEstagiosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GEstagiosNovaLinha(Sender: TObject);
    procedure GEstagiosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EEstagioRetorno(Retorno1, Retorno2: String);
    procedure GCombinacaoCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GCombinacaoDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GCombinacaoGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GCombinacaoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GCombinacaoNovaLinha(Sender: TObject);
    procedure GFiguraCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GFiguraDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GFiguraGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GFiguraMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GFiguraNovaLinha(Sender: TObject);
    procedure GImpressorasCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GImpressorasDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GImpressorasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GImpressorasMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GImpressorasNovaLinha(Sender: TObject);
    procedure GImpressorasSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SpeedButton8Click(Sender: TObject);
    procedure EPerLucroChange(Sender: TObject);
    procedure GAcessoriosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GAcessoriosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure EAcessorioRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GAcessoriosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GAcessoriosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GAcessoriosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GAcessoriosNovaLinha(Sender: TObject);
    procedure GAcessoriosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ECodClassificacaoEnter(Sender: TObject);
    procedure EDescricaoExit(Sender: TObject);
    procedure EComposicaoCadastrar(Sender: TObject);
    procedure GPrecoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GPrecoDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GPrecoGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GPrecoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GPrecoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GPrecoNovaLinha(Sender: TObject);
    procedure GPrecoSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ETabelaPrecoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ECliPrecoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EMoedaRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ETabelaPrecoSelect(Sender: TObject);
    procedure EValVendaExit(Sender: TObject);
    procedure GInstalacaoClick(Sender: TObject);
    procedure GInstalacaoGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure EQtdQuadrosExit(Sender: TObject);
    procedure EQtdColInstalacaoExit(Sender: TObject);
    procedure GInstalacaoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GInstalacaoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BZoomMaisClick(Sender: TObject);
    procedure BZoomMenosClick(Sender: TObject);
    procedure BNovoClick(Sender: TObject);
    procedure EProdutoInstalacaoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure BRepeticaoDesenhoClick(Sender: TObject);
    procedure ECorPrecoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GPrecoAntesExclusao(Sender: TObject; var VpaPermiteExcluir: Boolean);
    procedure EQtdMinimaExit(Sender: TObject);
    procedure EQtdPedidoExit(Sender: TObject);
    procedure EQuantidadeExit(Sender: TObject);
    procedure EValRevendaExit(Sender: TObject);
    procedure EValCustoExit(Sender: TObject);
    procedure PanelColor11Click(Sender: TObject);
    procedure GDPCGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GDPCClick(Sender: TObject);
    procedure EQtdLinInstalacaoExit(Sender: TObject);
  private
    VprCodClassificacao,
    VprCodClassificacaoAnterior : String;
    FunClassificacao: TFuncoesClassificacao;
    VprOperacao: TRBDOperacaoCadastro;
    VprAcao,
    VprImpressorasCarregadas,
    VprAcessoriosCarregados : Boolean;
    VprImpressoraAnterior: String;
    VprLinhaInicial,VprLinhaFinal, VprColunaInicial, VprColunaFinal : Integer;
    VprSeqProdutoInstalacao,
    VprQtdRepeticao : Integer;

    VprDProduto: TRBDProduto;
    VprDFornecedor: TRBDProdutoFornecedor;
    VprDEstagio: TRBDEstagioProduto;
    VprDCombinacao: TRBDCombinacao;
    VprDProAcessorio : TRBDProdutoAcessorio;
    VprDProTabelaPreco : TRBDProdutoTabelaPreco;
    VprDFigura: TRBDCombinacaoFigura;
    VprRepeticoesInstalacao,
    VprListaImpressoras: TList;
    VprDProImpressora: TRBDProdutoImpressora;

    // Verificar permissões e configurações ao criar uma nova página
    procedure ConfiguraPermissaoUsuario;
    procedure CarregaConfiguracoes;
    procedure ConfiguracoesCodigoBarra;
    procedure ConfiguracoesCadarco;
    procedure ConfiguracoesEtiqueta;
    procedure ConfiguracoesAdicionais;
    procedure ConfiguracoesCopiadora;
    procedure ConfiguracoesCartuchos;
    procedure ConfiguracoesEstagios;
    procedure ConfiguracoesFornecedores;

    function ExisteCor: Boolean;
    function ExisteCliente: Boolean;
    function ExisteEstagio(VpaCodEstagio: String): Boolean;
    function ExisteImpressora: Boolean;
    function ImpressoraDuplicada: Boolean;
    function LocalizaImpressora: Boolean;

    procedure CriaClasses;
    procedure InicializaClasseProduto;
    procedure InicializaGrades;
    procedure InicializaTela;
    procedure CarTitulosGrade;
    function LocalizaClassificacao: Boolean;
    procedure BloquearTela(VpaEstado: Boolean);
    procedure AlteraFoco;
    function ChamaRotinasGravacao: String;
    function GeraCodigoBarras : String;

    function DadosValidos : String;
    procedure CarDTela;
    procedure PosDadosGerais;
    procedure PosDadosCadarco;
    procedure PosDadosEtiqueta;
    procedure PosDadosCombinacao;
    procedure PosDadosAdicionais;
    procedure PosDadosCopiadora;
    procedure PosDadosCartucho;
    procedure PosImpressoras;
    procedure PosDadosEstagios;
    procedure PosDadosFornecedores;
    procedure PosDadosAcessorios;
    procedure PosDadosTabelaPreco;

    procedure CarDClasseGerais;
    procedure CarDClasseCadarco;
    procedure CarDClasseEtiqueta;
    procedure CadDClasseAdicionais;
    procedure CarDClasseCopiadora;
    procedure CarDClasseCartucho;

    procedure CarDFornecedoresClasse;
    procedure CarDEstagio;
    procedure CarDCombinacao;
    procedure CarDFigura;
    procedure CarDTabelaPreco;
    procedure CarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);

    procedure ConfiguraQtdQuadros(VpaQtdQuadros : Integer);
    procedure ConfiguraQtdColunaInstalcao(VpaQtdColunas : Integer);
    procedure ConfiguraQtdLinhaInstalacao(VpaQtdLinhas : Integer);
    procedure ZoomGradeInstalacao(VpaIndice : Double);
    procedure CarDProdutoInstalacao;
    procedure CarDProdutoInstalacaoTela;
    function DadosProdutoInstalacaoValido : String;
  public
    function NovoProduto(VpaCodClassificacao: String): TRBDProduto;
    function AlterarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): TRBDProduto;
    function AlteraEstagioProdutos(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): Boolean;
    procedure ConsultarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);
    function DesativarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): Boolean;
  end;

var
  FNovoProdutoPro: TFNovoProdutoPro;

implementation
uses
  APrincipal, FunString, FunData, FunObjeto, FunNumeros, ALocalizaClassificacao, ConstMsg,
  AMaquinas, ATipoEmenda, ATipoFundo, ATipoCorte, AEmbalagem, AAcondicionamento,
  ACores, AEstagioProducao, ALocalizaProdutos, AMontaKit, ANovaComposicao;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoProdutoPro.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EditorImagem.DirServidor := varia.DriveFoto;
  VprAcao:= False;
  VprCodClassificacao := '';
  EDatAmostra.EditMask := FPrincipal.CorFoco.AMascaraData;
  EDatSaidaAmostra.EditMask := FPrincipal.CorFoco.AMascaraData;
  VprImpressorasCarregadas:= False;
  VprAcessoriosCarregados := false;
  CriaClasses;
  InicializaTela;
  ConfiguraPermissaoUsuario;
  CarregaConfiguracoes;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoProdutoPro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprListaImpressoras);
  VprListaImpressoras.Free;
  FreeTObjectsList(VprRepeticoesInstalacao);
  VprRepeticoesInstalacao.Free;
  FunClassificacao.Free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoProdutoPro.BZoomMenosClick(Sender: TObject);
begin
  ZoomGradeInstalacao(0.80);
end;

procedure TFNovoProdutoPro.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguraPermissaoUsuario;
begin
  if not ((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario) or
          (puESCompleto in varia.PermissoesUsuario) or (puFACompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([EValCusto,EValVenda,LValVenda,LValCusto],False);
    AlteraCampoObrigatorioDet([EValCusto,EValVenda],False);
    if (puVerPrecoCustoProduto in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([EValCusto,LValCusto],True);
    end;
    if (puVerPrecoVendaProduto in varia.PermissoesUsuario) then
    begin
      AlterarVisibleDet([EValVenda,LValVenda],True);
    end
  end;
  EValRevenda.ACampoObrigatorio := config.SugerirPrecoAtacado;
  EValCusto.ACampoObrigatorio:= Config.ExigirPrecoCustoProdutonoCadastro;
  EValVenda.ACampoObrigatorio:= Config.ExigirPrecoVendaProdutonoCadastro;
  PAcessorios.TabVisible := config.MostrarAcessoriosnoProduto;
  EClassificacaoFiscal.ACampoObrigatorio := (config.EmiteNFe or config.EmiteSped);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguraQtdColunaInstalcao(VpaQtdColunas: Integer);
var
  VpfLacoLinha, VpfLacoColuna, VpfDiferenca : Integer;
  VpfDRepeticao : TRBDRepeticaoInstalacaoTear;
begin
  if VpaQtdColunas <=0 then
  begin
    aviso('QUANTIDADE DE COLUNAS INVÁLIDA!!!'#13'Quantidade de colunas não pode ser menor que zero.');
    EQtdColInstalacao.Value := GInstalacao.ColCount;
  end
  else
  begin
    VpfDiferenca := VpaQtdColunas - GInstalacao.ColCount;
    if VpfDiferenca > 0 then
    begin
      GInstalacao.ColCount := VpaQtdColunas;
      for VpfLacoColuna := VpaQtdColunas -1 downto 0 do
      begin
        for VpfLacoLinha := 0 to GInstalacao.RowCount - 1 do
        begin
          if VpfLacoColuna < VpfDiferenca then
            GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha] := ''
          else
            GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha] := GInstalacao.Cells[VpfLacoColuna-VpfDiferenca,VpfLacoLinha];
          GInstalacao.ColWidths[VpfLacoColuna] :=GInstalacao.ColWidths[0] ;
        end;
      end;
    end
    else
    begin
      for VpfLacoColuna := (VpfDiferenca *-1) to GInstalacao.ColCount - 1  do
      begin
        for VpfLacoLinha := 0 to GInstalacao.RowCount - 1 do
        begin
          GInstalacao.Cells[VpfLacoColuna+VpfDiferenca,VpfLacoLinha] := GInstalacao.Cells[VpfLacoColuna,VpfLacoLinha];
        end;
      end;
      GInstalacao.ColCount := VpaQtdColunas;
    end;


    for VpfLacoLinha := 0 to VprDProduto.DInstalacaoCorTear.Repeticoes.Count - 1 do
    begin
      VpfDRepeticao := TRBDRepeticaoInstalacaoTear(VprDProduto.DInstalacaoCorTear.Repeticoes.Items[VpfLacoLinha]);
      VpfDRepeticao.NumColunaInicial := VpfDRepeticao.NumColunaInicial + VpfDiferenca;
      VpfDRepeticao.NumColunaFinal := VpfDRepeticao.NumColunaFinal + VpfDiferenca;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguraQtdLinhaInstalacao(VpaQtdLinhas: Integer);
Var
  VpfDiferenca : Integer;
  VpfLacoLinha, VpfLacoColuna : Integer;
begin
  if VpaQtdLinhas <=0  then
  begin
    aviso('QUANTIDADE DE LINHAS INVÁLIDAS!!!'#13'A quantidade de linhas não pode ser menor que zero.');
    EQtdLinInstalacao.Value := GDPC.rowcount;
  end
  else
  begin
    VpfDiferenca := VpaQtdLinhas - GDPC.RowCount;
    if VpfDiferenca > 0 then
    begin
      GDPC.Rowcount := VpaQtdLinhas;
      for VpflacoLInha := VpaQtdLinhas  downto 0 do
      begin
        for VpfLacoColuna := 0 to GDPC.ColCount -1 do
        begin
          if VpfLacoLinha < VpfDiferenca then
            GDPC.Cells[VpfLacoColuna,VpfLacoLinha] := ''
          else
            GDPC.Cells[VpfLacoColuna,VpfLacoLinha] := GDPC.Cells[VpfLacoColuna,VpfLacoLinha-VpfDiferenca];
        end;
      end;
    end
    else
    begin
      for VpfLacoLinha := (VpfDiferenca *-1) to GDPC.RowCount - 1  do
      begin
        for VpfLacoColuna := 0 to GDPC.ColCount - 1 do
        begin
          GDPC.Cells[VpfLacoColuna,VpfLacoLinha+VpfDiferenca] := GDPC.Cells[VpfLacoColuna,VpfLacoLinha];
        end;
      end;
      GDPC.RowCount := VpaQtdLinhas;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguraQtdQuadros(VpaQtdQuadros: Integer);
var
  VpfLaco : Integer;
begin
  GInstalacao.RowCount := VpaQtdQuadros + 3;
  GDPC.ColCount := VpaQtdQuadros;
  for VpfLaco := 0 to VpaQtdQuadros - 1 do
  begin
    GInstalacao.Cells[GInstalacao.ColCount-1,VpfLaco] := IntToStr(VpaQtdQuadros - Vpflaco);
    GDPC.Cells[VpfLaco,GDPC.RowCount-1] := IntToStr(Vpflaco+1);
    gdpc.ColWidths[VpfLaco]:=GDPC.ColWidths[0];
  end;

end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarregaConfiguracoes;
begin
  ConfiguracoesCodigoBarra;
  ConfiguracoesCadarco;
  ConfiguracoesEtiqueta;
  ConfiguracoesAdicionais;
  ConfiguracoesCopiadora;
  ConfiguracoesCartuchos;
  ConfiguracoesEstagios;
  ConfiguracoesFornecedores;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesCodigoBarra;
begin
  ECodBarraFornecedor.Visible:= Config.CodigoBarras;
  Label13.Visible:= Config.CodigoBarras;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesCadarco;
begin
  PCadarco.TabVisible:= Config.CadastroCadarco;
//  EMetrosMinuto.ACampoObrigatorio:= Config.CadastroCadarco;
//  ETipMaquina.ACampoObrigatorio:= Config.CadastroCadarco;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesEtiqueta;
begin
  PEtiqueta.TabVisible:= Config.CadastroEtiqueta;
  PCombinacao.TabVisible:= Config.CadastroEtiqueta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesAdicionais;
begin
  // Sem configurações encontradas
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesCopiadora;
begin
  PCopiadoras.TabVisible:= Config.ManutencaoImpressoras;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesCartuchos;
begin
  PCartuchos.TabVisible:= Config.ManutencaoImpressoras;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesEstagios;
begin
  // Sem configurações encontradas
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConfiguracoesFornecedores;
begin
  // Sem configurações encontradas
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CriaClasses;
begin
  VprDProduto:= TRBDProduto.Cria;
  VprDFornecedor:= TRBDProdutoFornecedor.Cria;
  VprDEstagio:= TRBDEstagioProduto.Cria;
  VprDCombinacao:= TRBDCombinacao.Cria;
  VprListaImpressoras:= TList.Create;
  VprRepeticoesInstalacao := TList.Create;
  FunClassificacao:= TFuncoesClassificacao.criar(Self,FPrincipal.BaseDados);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.InicializaTela;
begin
  CarTitulosGrade;
  FunProdutos.CarUnidadesVenda(EUnidadesVenda.Items);
  EUnidadesVenda.ItemIndex:= EUnidadesVenda.Items.IndexOf(Varia.UnidadeUN);
  EUnidadesVendaChange(Self);
  InicializaGrades;
  Paginas.ActivePage:= PGerais;
  ActiveControl:= ECodClassificacao;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarTitulosGrade;
begin
  GCombinacao.Cells[1,0]:= 'Comb.';
  GCombinacao.Cells[2,0]:= 'Urdume';
  GCombinacao.Cells[3,0]:= 'Título ';
  GCombinacao.Cells[4,0]:= 'Espula ';
  GCombinacao.Cells[5,0]:= 'Trama';
  GCombinacao.Cells[6,0]:= 'Título';
  GCombinacao.Cells[7,0]:= 'Espula';
  GCombinacao.Cells[8,0]:= 'Cartela';
  GCombinacao.Cells[9,0]:= 'Urd Figura';
  GCombinacao.Cells[10,0]:= 'Título';
  GCombinacao.Cells[11,0]:= 'Nro Fios';
  GCombinacao.ColWidths[8]:= 0;

  GFigura.Cells[1,0]:= 'Figura';
  GFigura.Cells[2,0]:= 'Cor';
  GFigura.Cells[3,0]:= 'Título';
  GFigura.Cells[4,0]:= 'Espula';

  GImpressoras.Cells[1,0] := 'Código';
  GImpressoras.Cells[2,0] := 'Impressora';

  GEstagios.Cells[0,0] := 'ID';
  GEstagios.Cells[1,0] := 'Ordem';
  GEstagios.Cells[2,0] := 'Código';
  GEstagios.Cells[3,0] := 'Estágio';
  GEstagios.Cells[4,0] := 'Descrição';
  GEstagios.Cells[5,0] := 'Qtd Pro. Hora';
  GEstagios.Cells[6,0] := 'Est. Anterior(ID)';
  GEstagios.Cells[7,0] := 'Qtd Estágio Ant';
  GEstagios.Cells[8,0] := 'Config.';
  GEstagios.Cells[9,0] := 'Tempo Config';

  GFornecedores.Cells[1,0]:= 'Código';
  GFornecedores.Cells[2,0]:= 'Cor';
  GFornecedores.Cells[3,0]:= 'Código';
  GFornecedores.Cells[4,0]:= 'Fornecedor';
  GFornecedores.Cells[5,0]:= 'Valor Unitário';
  GFornecedores.Cells[6,0]:= 'Ref Fornecedor';
  GFornecedores.Cells[7,0]:= 'Última Compra';
  GFornecedores.Cells[8,0]:= 'Dias Entrega';
  GFornecedores.Cells[9,0]:= 'Qtd. Mín. Compra';
  GFornecedores.Cells[10,0]:= '% IPI';

  GAcessorios.Cells[1,0]:= 'Código';
  GAcessorios.Cells[2,0]:= 'Descrição';

  GPreco.Cells[1,0] := 'Código';
  GPreco.Cells[2,0] := 'Tabela Preço';
  GPreco.Cells[3,0] := 'Valor Venda';
  GPreco.Cells[4,0] := 'Valor Revenda';
  GPreco.Cells[5,0] := '%Max Deconto';
  GPreco.Cells[6,0] := 'Valor Compra';
  GPreco.Cells[7,0] := 'Valor Custo';
  GPreco.Cells[8,0] := 'Código';
  GPreco.Cells[9,0] := 'Cor';
  GPreco.Cells[10,0] := 'Código';
  GPreco.Cells[11,0] := 'Tamanho';
  GPreco.Cells[12,0] := 'Código';
  GPreco.Cells[13,0] := 'Cliente';
  GPreco.Cells[14,0] := 'Código';
  GPreco.Cells[15,0] := 'Moeda';
  GPreco.Cells[16,0] := 'Qtd Minima';
  GPreco.Cells[17,0] := 'Qtd Pedido';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.InicializaClasseProduto;
begin
  try
    VprDProduto.Free;
  finally
    VprDProduto:= TRBDProduto.Cria;
  end;
  VprDProduto.CodEmpresa:= Varia.CodigoEmpresa;
  VprDProduto.CodEmpFil:= Varia.CodigoEmpFil;
  VprDProduto.CodClassificacao:= VprCodClassificacao;
  VprDProduto.CodProduto:= FunProdutos.ProximoCodigoProduto(VprDProduto.CodClassificacao,Length(varia.MascaraPro));
  VprDProduto.CodMoeda := varia.MoedaBase;
  VprDProduto.CodUsuario := Varia.CodigoUsuario;

  VprDProduto.SeqProduto:= 0;
  VprDProduto.CodUnidade:= varia.UnidadePadrao;
  VprDProduto.IndProdutoAtivo:= True;
  VprDProduto.DesClassificacaoFiscal := varia.ClassificacaoFiscal;
  VprDProduto.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDProduto.CodUnidade);
  VprDProduto.IndCalandragem:= 'N';
  VprDProduto.IndEngomagem:= 'N';
  VprDProduto.IndCilindro:= 'S';
  VprDProduto.IndComponente:= 'N';
  VprDProduto.IndColorida:= 'S';
  VprDProduto.DesTipTear:= 'M';
  VprDProduto.QtdMesesGarantia := 12;
  VprDProduto.IndMonitorarEstoque := false;
  VprDProduto.IndKit := false;
  InicializaGrades;
  // Iniciar os campos de marcação multipla para a tela não ficar suja
end;

{******************************************************************************}
procedure TFNovoProdutoPro.InicializaGrades;
begin
  GCombinacao.ADados:= VprDProduto.Combinacoes;
  GFigura.ADados:= VprDCombinacao.Figuras;
  GEstagios.ADados:= VprDProduto.Estagios;
  GImpressoras.ADados:= VprListaImpressoras;
  GFornecedores.ADados:= VprDProduto.Fornecedores;
  GAcessorios.ADados := VprDProduto.Acessorios;
  GPreco.ADados := VprDProduto.TabelaPreco;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodEmpresaChange(Sender: TObject);
begin
  if VprOperacao in [ocEdicao,ocInsercao] then
    ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EUnidadesVendaChange(Sender: TObject);
var
  VpfUnidadesParentes : TStringList;
begin
  if VprOperacao in [ocEdicao,ocInsercao] then
  begin
    LQtdCaixa.Visible:= (EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeCX) or(EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeKit)
                        or(EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeBarra) ;
    if (EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeKit) then
      LQtdCaixa.Caption := 'Unidades por Kit : '
    else
      if (EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeCX) then
        LQtdCaixa.Caption := 'Unidades por Caixa : '
      else
        if (EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex] = Varia.UnidadeBarra) then
          LQtdCaixa.Caption := 'Qtd Metros Barra : ';
    EUnidadesPorCaixa.Visible:= LQtdCaixa.Visible;
    EUnidadesPorCaixa.ACampoObrigatorio:= LQtdCaixa.Visible;

    if config.ExigirQdMetrosQuandoDiferenteMT then
    begin
      VpfUnidadesParentes := FunProdutos.RUnidadesParentes('mt');
      EMetCadarco.ACampoObrigatorio := (VpfUnidadesParentes.IndexOf(EUnidadesVenda.TExt) = -1);
    end;

    ValidaGravacao.execute;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EValCustoExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EValCusto.AValor <> VprDProduto.VlrCusto then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.ValCusto := EValCusto.AValor;
      VprDProduto.VlrCusto := EValCusto.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EValRevendaExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EValRevenda.AValor <> VprDProduto.VlrRevenda then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.ValReVenda := EValReVenda.AValor;
      VprDProduto.VlrReVenda := EValReVenda.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EValVendaExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EValVenda.AValor <> VprDProduto.VlrVenda then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.ValVenda := EValVenda.AValor;
      VprDProduto.VlrVenda := EValVenda.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECliPrecoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodCliente := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomCliente := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[8,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[9,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodCliente := 0;
      VprDProTabelaPreco.NomCliente := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodClassificacaoEnter(Sender: TObject);
begin
  VprCodClassificacaoAnterior := EcodClassificacao.text;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodClassificacaoExit(Sender: TObject);
var
  VpfNomeClassificacao: string;
begin
  if ECodClassificacao.Text <> '' then
  begin
    if not FunClassificacao.ValidaClassificacao(ECodClassificacao.Text, VpfNomeClassificacao, 'P') then
    begin
      if not LocalizaClassificacao then
        ECodClassificacao.SetFocus;
    end
    else
      LNomClassificacao.Caption:= VpfNomeClassificacao;

    if VprOperacao in [ocinsercao,ocedicao] then
    begin
      if VprCodClassificacaoAnterior <> ECodClassificacao.Text then
      begin
        VprCodClassificacao := ECodClassificacao.Text;
        ECodProduto.Text := FunProdutos.ProximoCodigoProduto(ECodClassificacao.Text,Length(varia.MascaraPro));
      end;
    end;
  end
  else
    LNomClassificacao.Caption:= '';
end;

{******************************************************************************}
function TFNovoProdutoPro.LocalizaClassificacao : Boolean;
var
  VpfCodClassificacao, VpfNomeClassificacao: string;
begin
  Result:= True;
  FLocalizaClassificacao:= TFLocalizaClassificacao.CriarSDI(Application,'',True);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomeClassificacao,'P') then
  begin
    ECodClassificacao.Text:= VpfCodClassificacao;
    LNomClassificacao.Caption:= VpfNomeClassificacao;
    ECodProduto.Text := FunProdutos.ProximoCodigoProduto(ECodClassificacao.Text,Length(varia.MascaraPro));
  end
  else
    Result:= False;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodClassificacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BZoomMaisClick(Sender: TObject);
begin
  ZoomGradeInstalacao(1.2);
end;

procedure TFNovoProdutoPro.SpeedButton1Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodMoedaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    ECifraoMoeda.Text:= Retorno1;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodProdutoExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao] then
    if FunProdutos.ExisteProduto(ECodProduto.Text) then
    begin
      ECodProduto.SetFocus;
      aviso('PRODUTO JÁ CADASTRADO!!!'#13'Informe um código que ainda não esteja cadastrado.');
    end;
end;

procedure TFNovoProdutoPro.EComposicaoCadastrar(Sender: TObject);
begin
  FNovaComposicao := TFNovaComposicao.CriarSDI(application,'',true);
  FNovaComposicao.Composicao.Insert;
  FNovaComposicao.showmodal;
  FNovaComposicao.free;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BFotoClick(Sender: TObject);
begin
  if VprOperacao in [ocEdicao, ocInsercao] then
    if EditorImagem.execute(varia.DriveFoto + LPatFoto.Caption) then
      LPatFoto.Caption:= EditorImagem.PathImagem;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BloquearTela(VpaEstado: Boolean);
begin
  AlteraReadOnlyDet(PanelColor1,0,VpaEstado);
  EQuantidade.ReadOnly:= True;
  if VprOperacao in [ocEdicao,ocInsercao] then
  begin
    if VprOperacao in [ocInsercao] then
    begin
      BKit.Enabled:= False;
      EQuantidade.ReadOnly:= False;      
    end;
    ValidaGravacao.Execute;
  end
  else
  begin
    BGravar.Enabled:= False;
    BFoto.Enabled:= False;
  end;
end;

procedure TFNovoProdutoPro.BNovoClick(Sender: TObject);
begin
{  EProdutoInstalacao.Clear;
  EProdutoInstalacao.Atualiza;
  ECorInstalacao.Clear;
  ECor.Atualiza;
  EQtdFiosLico.Clear;
  EFuncaoFio.ItemIndex := -1;}
end;

procedure TFNovoProdutoPro.BRepeticaoDesenhoClick(Sender: TObject);
var
  VpfQtdRepeticao : String;
begin
  if EntradaNumero('Quantidade de repetições Desenho','Qtd Repetições : ',VpfqtdRepeticao,false,EValVenda.Color,PanelColor1.Color,false) then
    VprQtdRepeticao := StrToInt(VpfQtdRepeticao)
  else
    BCursor.Down := true;

end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETipMaquinaCadastrar(Sender: TObject);
begin
  FMaquinas:= TFMaquinas.CriarSDI(Application,'',True);
  FMaquinas.BotaoCadastrar1.Click;
  FMaquinas.ShowModal;
  FMaquinas.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETipFundoCadastrar(Sender: TObject);
begin
  FTipoFundo:= TFTipoFundo.CriarSDI(Application,'',True);
  FTipoFundo.BotaoCadastrar1.Click;
  FTipoFundo.ShowModal;
  FTipoFundo.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETipEmendaCadastrar(Sender: TObject);
begin
  FTipoEmenda:= TFTipoEmenda.CriarSDI(Application,'',True);
  FTipoEmenda.BotaoCadastrar1.Click;
  FTipoEmenda.ShowModal;
  FTipoEmenda.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETabelaPrecoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodTabelaPreco := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomTabelaPreco := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[1,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[2,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodTabelaPreco := 0;
      VprDProTabelaPreco.NomTabelaPreco := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETabelaPrecoSelect(Sender: TObject);
begin
  ETabelaPreco.ASelectValida.Text := 'Select I_COD_TAB, C_NOM_TAB '#13+
                          ' from CADTABELAPRECO '#13 +
                          ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                          ' and I_COD_TAB = @';
  ETabelaPreco.ASelectLocaliza.Text := 'Select I_COD_TAB, C_NOM_TAB '#13+
                          ' from CADTABELAPRECO '#13 +
                          ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodTamanho := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomTamanho := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[10,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[11,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodTamanho := 0;
      VprDProTabelaPreco.NomTamanho := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ETipCorteCadastrar(Sender: TObject);
begin
  FTipoCorte:= TFTipoCorte.CriarSDI(Application,'', True);
  FTipoCorte.BotaoCadastrar1.Click;
  FTipoCorte.ShowModal;
  FTipoCorte.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EEmbalagemCadastrar(Sender: TObject);
begin
  FEmbalagem:= TFEmbalagem.CriarSDI(Application,'',True);
  FEmbalagem.BotaoCadastrar1.Click;
  FEmbalagem.ShowModal;
  FEmbalagem.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EAcondicionamentoCadastrar(Sender: TObject);
begin
  FAcondicionamento:= TFAcondicionamento.CriarSDI(Application,'',True);
  FAcondicionamento.BotaoCadastrar1.Click;
  FAcondicionamento.ShowModal;
  FAcondicionamento.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECodCorCadastrar(Sender: TObject);
begin
  FCores:= TFCores.CriarSDI(Application,'',True);
  FCores.BotaoCadastrar1.Click;
  FCores.ShowModal;
  FCores.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EEstagioCadastrar(Sender: TObject);
begin
  FEstagioProducao := TFEstagioProducao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FEstagioProducao'));
  FEstagioProducao.BotaoCadastrar1.Click;
  FEstagioProducao.Showmodal;
  FEstagioProducao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EBatidasTotaisExit(Sender: TObject);
begin
  try
    EBatidasProduto.AInteiro:= RetornaInteiro(EBatidasTotais.AInteiro / (1000 / EComprProduto.AInteiro));
  except
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 115 then
    AlteraFoco;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.AlteraFoco;
begin
  if GCombinacao.Focused then
    ActiveControl:= GFigura
  else
    if GFigura.Focused then
      ActiveControl:= GCombinacao;
end;

{******************************************************************************}
function TFNovoProdutoPro.NovoProduto(VpaCodClassificacao: String): TRBDProduto;
begin
  VprCodClassificacao := VpaCodClassificacao;
  VprOperacao:= ocConsulta;
  InicializaClasseProduto;
  VprDProduto.CodClassificacao:= VpaCodClassificacao;
  ECodClassificacao.EditMask:= RetornaPicture(Varia.MascaraCla,VprDProduto.CodClassificacao,'_');
  CarDTela;
  VprOperacao:= ocInsercao;
  BloquearTela(False);
  FunProdutos.AdicionaTodasTabelasdePreco(VprDProduto);
  ShowModal;
  if VprAcao then
    Result:= VprDProduto
  else
  begin
    Result:= nil;
    VprDProduto.Free;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.AlterarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): TRBDProduto;
begin
  EUnidadesVenda.Enabled := false;
  CarProduto(VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  ShowModal;
  Result:= VprDProduto;
end;

{******************************************************************************}
function TFNovoProdutoPro.AlteraEstagioProdutos(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): Boolean;
begin
  CarProduto(VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  Paginas.ActivePage := PEstagios;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ConsultarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);
begin
  VprOperacao:= ocConsulta;
  CarProduto(VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  ECodClassificacao.EditMask:= RetornaPicture(Varia.MascaraCla,VprDProduto.CodClassificacao,'_');
  CarDTela;
  BloquearTela(True);
  ShowModal;
end;

{******************************************************************************}
function TFNovoProdutoPro.DesativarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer): Boolean;
var
  VpfResultado: String;
begin
  Result:= False;
  VpfResultado:= '';
  VprOperacao:= ocConsulta;
  FunProdutos.CarDProduto(VprDProduto,VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  ECodClassificacao.EditMask:= RetornaPicture(Varia.MascaraCla,VprDProduto.CodClassificacao,'_');
  CarDTela;
  VprOperacao:= ocEdicao;
  BloquearTela(True);
  Show;
  if Confirmacao('Deseja desativar o produto "'+VprDProduto.NomProduto+'"?') then
  begin
    VprDProduto.IndProdutoAtivo:= False;
    VpfResultado:= FunProdutos.GravaDProduto(VprDProduto);
    if VpfResultado <> '' then
      aviso(VpfResultado);
    Result:= True;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
  VpfPermiteTrocaPagina: Boolean;
begin
  VpfResultado:= '';
  VpfPermiteTrocaPagina:= False;
  // Carregar os dados da página atual já que os outros são carregados sempre
  // quando saimos da página
  PaginasChanging(Self,VpfPermiteTrocaPagina);
  VpfResultado:= ChamaRotinasGravacao;
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao:= True;   
    Close;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.BKitClick(Sender: TObject);
begin
  VprDProduto.CodEmpFil:= Varia.CodigoEmpFil;
  FunProdutos.CarDProduto(VprDProduto);
  FMontaKit:= TFMontaKit.CriarSDI(Application,'',True);
  FMontaKit.ConsumoMP(VprDProduto);
  FMontaKit.Free;
end;

{******************************************************************************}
function TFNovoProdutoPro.ChamaRotinasGravacao: String;
begin
  Result:= DadosValidos;
  if result = '' then
  begin
    result := GeraCodigoBarras;
    if result = '' then
    begin
      Result:= FunProdutos.GravaDProduto(VprDProduto);
      if Result = '' then
      begin
        Result:= FunProdutos.GravaDCombinacao(VprDProduto);
        if Result = '' then
        begin
          Result:= FunProdutos.GravaDEstagio(VprDProduto);
          if Result = '' then
          begin
            Result:= FunProdutos.GravaDFornecedor(VprDProduto);
            if VprImpressorasCarregadas then
            begin
              Result:= FunProdutos.GravaProdutoImpressoras(VprDProduto.SeqProduto,VprListaImpressoras);
              if Result = '' then
              begin
                Result:= FunProdutos.InsereProdutoEmpresa(Varia.CodigoEmpresa, VprDProduto,VprOperacao = ocInsercao);
                if Result = '' then
                begin
                  Result:= FunProdutos.GravaDTabelaPreco(VprDProduto);
                  if result = '' then
                  begin
                    result := FunProdutos.GravaDAcessorio(VprDProduto);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PGerais then
    PosDadosGerais
  else
    if Paginas.ActivePage = PCadarco then
      PosDadosCadarco
    else
      if Paginas.ActivePage = PETiqueta then
        PosDadosEtiqueta
      else
        if Paginas.ActivePage = PCombinacao then
          PosDadosCombinacao
        else
          if Paginas.ActivePage = PDadosAdicionais then
            PosDadosAdicionais
          else
            if Paginas.ActivePage = PCopiadoras then
              PosDadosCopiadora
            else
              if Paginas.ActivePage = PCartuchos then
                PosDadosCartucho
              else
                if Paginas.ActivePage = PEstagios then
                  PosDadosEstagios
                else
                  if Paginas.ActivePage = PFornecedores then
                    PosDadosFornecedores
                  else
                    if Paginas.ActivePage = PAcessorios then
                      PosDadosAcessorios
                    else
                      if Paginas.ActivePage = PTabelaPreco then
                        PosDadosTabelaPreco;
end;

{******************************************************************************}
function TFNovoProdutoPro.DadosValidos : String;
begin
  result := '';
  if VprOperacao in [ocInsercao] then
  begin
    if FunProdutos.ExisteProduto(ECodProduto.Text) then
    begin
      ECodProduto.SetFocus;
      result := 'PRODUTO JÁ CADASTRADO!!!'#13'Informe um código que ainda não esteja cadastrado.';
    end;
  end
  else
  begin
    if FunProdutos.ExisteCodigoProdutoDuplicado(VprDProduto.SeqProduto,VprDProduto.CodProduto) then
    begin
      Result := 'PRODUTO JÁ CADASTRADO!!!'#13'Informe um código que ainda não esteja cadastrado.';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDTela;
begin
  PosDadosGerais;
  PosDadosCadarco;
  PosDadosEtiqueta;
  PosDadosAdicionais;
  PosDadosCopiadora;
  PosDadosCartucho;
  Paginas.ActivePage:= PGerais;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosGerais;
begin
  VprCodClassificacaoAnterior := VprDProduto.CodClassificacao;
  ECodClassificacao.Text:= VprDProduto.CodClassificacao;
  ECodProduto.Text:= VprDProduto.CodProduto;
  EDescricao.Text:= VprDProduto.NomProduto;
  ECodMoeda.AInteiro:= VprDProduto.CodMoeda;
  EUsuario.AInteiro := VprDProduto.CodUsuario;
  EUsuario.Atualiza;
  ECifraoMoeda.Text:= VprDProduto.CifraoMoeda;
  EUnidadesVenda.ItemIndex:= EUnidadesVenda.Items.IndexOf(VprDProduto.CodUnidade);
  EClassificacaoFiscal.Text:= VprDProduto.DesClassificacaoFiscal;
  EUnidadesPorCaixa.AValor:= VprDProduto.QtdUnidadesPorCaixa;
  EPerIPI.AValor:= VprDProduto.PerIPI;
  EQtdEntregaFornecedor.AValor:= VprDProduto.QtdDiasEntregaFornecedor;
  EReducaoICMS.AValor:= VprDProduto.PerReducaoICMS;
  EQtdMinima.AValor:= VprDProduto.QtdMinima;
  EPerDesconto.AValor:= VprDProduto.PerDesconto;
  EQtdPedido.AValor:= VprDProduto.QtdPedido;
  EPerComissao.AValor:= VprDProduto.PerComissao;
  EQuantidade.AValor:= VprDProduto.QtdEstoque;
  EOrigemProduto.ItemIndex := VprDProduto.NumOrigemProduto;
  if VprDProduto.NumDestinoProduto = 99  then
    EDestinoProduto.ItemIndex := 11
  else
    EDestinoProduto.ItemIndex := VprDProduto.NumDestinoProduto;
  EPerMaxDesconto.AValor:= VprDProduto.PerMaxDesconto;
  ECodBarraFornecedor.Text:= VprDProduto.CodBarraFornecedor;
  EValCusto.AValor:= VprDProduto.VlrCusto;
  EValVenda.AValor:= VprDProduto.VlrVenda;
  EPerLucro.AValor := VprDProduto.PerLucro;
  CProdutoAtivo.Checked:= VprDProduto.IndProdutoAtivo;
  LPatFoto.Caption:= VprDProduto.PatFoto;
  EDescricaoTecnica.Text:= VprDProduto.DesDescricaoTecnica;
  if VprDProduto.IndKit then
    CKit.Checked := true
  else
    CProduto.Checked := true;

  ECodClassificacaoExit(Self);
  ECodMoeda.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosCadarco;
begin
  ETipMaquina.AInteiro:= VprDProduto.CodMaquina;
  EMetrosMinuto.AInteiro:= VprDProduto.MetrosPorMinuto;
  EEngEspPequena.Text:= VprDProduto.EngrenagemEspPequena;
  EQtdFuso.AInteiro:= VprDProduto.QuantidadeFusos;
  EMetTabuaPequeno.AInteiro:= VprDProduto.MetrosTabuaPequena;
  EMetTabuaGrande.AInteiro:= VprDProduto.MetrosTabuaGrande;
  EMetTabuaTrans.AInteiro:= VprDProduto.MetrosTabuaTrans;
  EMetCadarco.AInteiro:= VprDProduto.CmpProduto;
  ELargProduto.AInteiro:= VprDProduto.LarProduto;
  EEngEspGrande.Text:= VprDProduto.Engrenagem;
  ENumFios.Text:= VprDProduto.NumFios;
  ETituloFio.Text:= VprDProduto.DesTituloFio;
  EEnchimento.Text:= VprDProduto.DesEnchimento;

  ETipMaquina.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosEtiqueta;
begin
  ESumula.AInteiro:= VprDProduto.CodSumula;
  ELarguraProduto.AInteiro:= VprDProduto.LarProduto;
  EComprProduto.AInteiro:= VprDProduto.CmpProduto;
  if VprDProduto.DatEntradaAmostra > MontaData(1,1,1900) then
    EDatAmostra.Text:= FormatDateTime('DD/MM/YYYY',VprDProduto.DatEntradaAmostra)
  else
    EDatAmostra.Text:= '';
  if VprDProduto.DatSaidaAmostra > MontaData(1,1,1900) then
    EDatSaidaAmostra.Text:= FormatDateTime('DD/MM/YYYY',VprDProduto.DatSaidaAmostra)
  else
    EDatSaidaAmostra.Text:= '';
  EComprFigura.AInteiro:= VprDProduto.CmpFigura;
  ENumeroFios.Text:= VprDProduto.NumFios;
  EPente.Text:= VprDProduto.Pente;
  EBatidasTotais.AInteiro:= VprDProduto.MetrosPorMinuto;
  EBatidasProduto.Text:= VprDProduto.BatProduto;
  EBatidasTear.Text:= VprDProduto.NumBatidasTear;
  ETipFundo.AInteiro:= VprDProduto.CodTipoFundo;
  ETipEmenda.AInteiro:= VprDProduto.CodTipoEmenda;
  ETipCorte.AInteiro:= VprDProduto.CodTipoCorte;
  EIndiceProdutividade.AInteiro:= VprDProduto.PerProdutividade;
  CCalandragem.Checked:= (VprDProduto.IndCalandragem = 'S');
  CEngomagem.Checked:= (VprDProduto.IndEngomagem = 'S');
  EEngrenagem.Text:= VprDProduto.Engrenagem;
  EPrateleiraProduto.Text:= VprDProduto.PraProduto;
  RTearConvencional.Checked:= (VprDProduto.DesTipTear = 'C');
  RTearH.Checked:= not RTearConvencional.Checked;
  ETipFundo.Atualiza;
  ETipEmenda.Atualiza;
  ETipCorte.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosCombinacao;
begin
  GCombinacao.ADados := VprDProduto.Combinacoes;
  GCombinacao.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosAdicionais;
begin
  EPesoLiquido.AValor:= VprDProduto.PesoLiquido;
  EPesoBruto.AValor:= VprDProduto.PesoBruto;
  EMesesGarantia.Value := VprDProduto.QtdMesesGarantia;
  EPrateleiraPro.Text:= VprDProduto.PraProduto;
  EEmbalagem.AInteiro:= VprDProduto.CodEmbalagem;
  EAcondicionamento.AInteiro:= VprDProduto.CodAcondicionamento;
  EAlturaProduto.AInteiro:= VprDProduto.AltProduto;
  ECapacidadeLiquida.AValor := VprDProduto.CapLiquida;
  ECodDesenvolvedor.AInteiro:= VprDProduto.CodDesenvolvedor;
  CImprimeTabelaPreco.Checked:= VprDProduto.IndImprimeNaTabelaPreco = 'S';
  CCracha.Checked:= VprDProduto.IndCracha = 'S';
  CProdutoRetornavel.Checked:= VprDProduto.IndProdutoRetornavel = 'S';
  CMonitorarEstoque.Checked := VprDProduto.IndMonitorarEstoque;
  ERendimento.Text:= VprDProduto.DesRendimento;
  EDatCadastro.Text := FormatDateTime('DD/MM/YYYY',VprDProduto.DatCadastro);
  EComposicao.AInteiro := VprDProduto.CodComposicao;

  EEmbalagem.Atualiza;
  EAcondicionamento.Atualiza;
  ECodDesenvolvedor.Atualiza;
  EComposicao.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosCopiadora;
begin
  RMatricial.Checked:= False;
  RJatoTinta.Checked:= False;
  RLaser.Checked:= False;
  if VprDProduto.DesTipTear = 'M' then
    RMatricial.Checked:= True
  else
    if VprDProduto.DesTipTear =  'J' then
      RJatoTinta.Checked:= True
    else
      if VprDProduto.DesTipTear = 'L' then
        RLaser.Checked:= True;
  CCopiadora.Checked:= VprDProduto.IndCopiadora = 'S';
  CMultiFuncional.Checked:= VprDProduto.IndMultiFuncional = 'S';
  CImpressora.Checked:= VprDProduto.IndImpressora = 'S';

  RColorida.Checked:= VprDProduto.IndColorida = 'S';
  RMonoCromatica.Checked:= not RColorida.Checked;
  RMonoComponente.Checked:= VprDProduto.IndComponente = 'N';
  RBiComponente.Checked:= not RMonoComponente.Checked;
  RTonerComCilindro.Checked:= VprDProduto.IndCilindro = 'S';
  RTonerSemCilindro.Checked:= not RTonerComCilindro.Checked;
  CPlacaRede.Checked:= VprDProduto.IndPlacaRede = 'S';
  CPcl.Checked:= VprDProduto.IndPCL = 'S';
  CFax.Checked:= VprDProduto.IndFax = 'S';
  CUSB.Checked:= VprDProduto.IndUSB = 'S';
  CScanner.Checked:= VprDProduto.IndScanner = 'S';
  CWireless.Checked:= VprDProduto.IndWireless = 'S';
  CDuplex.Checked:= VprDProduto.IndDuplex = 'S';
  ECodCartucho.Text:= VprDProduto.CodReduzidoCartucho;
  ECodCartuchoAltaCapacidade.Text:= VprDProduto.CodCartuchoAltaCapac;
  EQtdCopiasToner.AInteiro:= VprDProduto.QtdCopiasTonner;
  EQtdCopiasTonerAltaCapacidade.AInteiro:= VprDProduto.QtdCopiasTonnerAltaCapac;
  EQtdCopiasCilindro.AInteiro:= VprDProduto.QtdCopiasCilindro;
  EQtdPaginasPorMinuto.AInteiro:= VprDProduto.QtdPagPorMinuto;
  EVolumeMensalCopias.AInteiro:= VprDProduto.VolumeMensal;
  if VprDProduto.DatFabricacao > MontaData(1,1,1900) then
    EDatFabricacao.Text:= FormatDateTime('DD/MM/YYYY',VprDProduto.DatFabricacao)
  else
    EDatFabricacao.Text:= '';
  if VprDProduto.DatEncerProducao > MontaData(1,1,1900) then
    EDatEncerramentoProducao.Text:= FormatDateTime('DD/MM/YYYY',VprDProduto.DatEncerProducao)
  else
    EDatEncerramentoProducao.Text:= '';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosCartucho;
begin
  ECodigoReduzido.Text:= VprDProduto.CodReduzidoCartucho;
  EPesoCartuchoVazio.AInteiro:= VprDProduto.PesCartuchoVazio;
  EPesoCartuchoCheio.AInteiro:= VprDProduto.PesCartucho;
  EQtdMl.AInteiro:= VprDProduto.QtdMlCartucho;
  EQtdPaginas.AInteiro:= VprDProduto.QtdPaginas;
  ECodCor.AInteiro:= VprDProduto.CodCorCartucho;
  RCartuchoTinta.Checked:= VprDProduto.DesTipoCartucho = 'TI';
  RCartuchoTonner.Checked:= VprDProduto.DesTipoCartucho= 'TO';
  CChipNovo.Checked:= VprDProduto.IndChipNovo;
  CCilindroNovo.Checked:= VprDProduto.IndCilindroNovo;
  CProdutoOriginal.Checked:= VprDProduto.IndProdutoOriginal;
  CCartuchoTexto.Checked:= VprDProduto.IndCartuchoTexto;
  CProdutoCompativel.Checked:= VprDProduto.IndProdutoCompativel;
  PosImpressoras;

  ECodCor.Atualiza;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosImpressoras;
begin
  if not VprImpressorasCarregadas then
  begin
    FunProdutos.CarProdutoImpressoras(VprDProduto.SeqProduto,VprListaImpressoras);
    VprImpressorasCarregadas:= True;
  end;
  GImpressoras.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosEstagios;
begin
  GEstagios.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosFornecedores;
begin
  GFornecedores.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosAcessorios;
begin
  GAcessorios.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PosDadosTabelaPreco;
begin
  GPreco.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.PaginasChanging(Sender: TObject; var AllowChange: Boolean);
begin
  // Antes de trocar de página, carrega os dados especificos de determinada página
  // para não haver problema de o usuário perder informação
  // já que quando uma página é selecionada os dados que estão na classe vão para a tela
  if Paginas.ActivePage = PGerais then
    CarDClasseGerais
  else
    if Paginas.ActivePage = PCadarco then
      CarDClasseCadarco
    else
      if Paginas.ActivePage = PETiqueta then
        CarDClasseEtiqueta
      else
        if Paginas.ActivePage = PDadosAdicionais then
          CadDClasseAdicionais
        else
          if Paginas.ActivePage = PCopiadoras then
            CarDClasseCopiadora
          else
            if Paginas.ActivePage = PCartuchos then
              CarDClasseCartucho;

  // Obs.: Não precisa carregar as páginas que trabalham apenas com grades.
end;

procedure TFNovoProdutoPro.PanelColor11Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseGerais;
begin
  VprDProduto.CodClassificacao:= ECodClassificacao.Text;
  VprDProduto.CodProduto:= ECodProduto.Text;
  VprDProduto.NomProduto:= EDescricao.Text;
  VprDProduto.CodMoeda:= ECodMoeda.AInteiro;
  VprDProduto.CifraoMoeda:= ECifraoMoeda.Text;
  VprDProduto.CodUnidade:= EUnidadesVenda.Items.Strings[EUnidadesVenda.ItemIndex];
  VprDProduto.DesClassificacaoFiscal:= EClassificacaoFiscal.Text;
  VprDProduto.QtdUnidadesPorCaixa:= Round(EUnidadesPorCaixa.AValor);
  VprDProduto.PerIPI:= EPerIPI.AValor;
  VprDProduto.QtdDiasEntregaFornecedor:= EQtdEntregaFornecedor.AValor;
  VprDProduto.PerReducaoICMS:= EReducaoICMS.AValor;
  VprDProduto.QtdMinima:= EQtdMinima.AValor;
  VprDProduto.PerDesconto:= EPerDesconto.AValor;
  VprDProduto.QtdPedido:= EQtdPedido.AValor;
  VprDProduto.PerComissao:= EPerComissao.AValor;
  VprDProduto.QtdEstoque:= EQuantidade.AValor;
  VprDProduto.NumOrigemProduto:= EOrigemProduto.ItemIndex;
  if EDestinoProduto.ItemIndex = 11 then
    VprDProduto.NumDestinoProduto := 99
  else
    VprDProduto.NumDestinoProduto := EDestinoProduto.ItemIndex;
  VprDProduto.PerMaxDesconto:= EPerMaxDesconto.AValor;
  VprDProduto.CodBarraFornecedor:= ECodBarraFornecedor.Text;
  VprDProduto.VlrCusto:= EValCusto.AValor;
  VprDProduto.VlrVenda := EValVenda.AValor;
  VprDProduto.VlrReVenda := EValRevenda.AValor;
  VprDProduto.PerLucro := EPerLucro.AValor;

  VprDProduto.IndProdutoAtivo:= CProdutoAtivo.Checked;
  VprDProduto.PatFoto:= LPatFoto.Caption;
  VprDProduto.DesDescricaoTecnica:= EDescricaoTecnica.Text;
  VprDProduto.IndKit := CKit.Checked;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseCadarco;
begin
  VprDProduto.CodMaquina:= ETipMaquina.AInteiro;
  VprDProduto.MetrosPorMinuto:= EMetrosMinuto.AInteiro;
  VprDProduto.EngrenagemEspPequena:= EEngEspPequena.Text;
  VprDProduto.QuantidadeFusos:= EQtdFuso.AInteiro;
  VprDProduto.MetrosTabuaPequena:= EMetTabuaPequeno.AInteiro;
  VprDProduto.MetrosTabuaGrande:= EMetTabuaGrande.AInteiro;
  VprDProduto.MetrosTabuaTrans:= EMetTabuaTrans.AInteiro;
  VprDProduto.LarProduto:= ELargProduto.AInteiro;
  VprDProduto.Engrenagem:= EEngEspGrande.Text;
  VprDProduto.NumFios:= ENumFios.Text;
  VprDProduto.DesTituloFio:= ETituloFio.Text;
  VprDProduto.DesEnchimento:= EEnchimento.Text;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseEtiqueta;
begin
  VprDProduto.CodSumula:= ESumula.AInteiro;
  VprDProduto.LarProduto:= ELarguraProduto.AInteiro;
  if Config.CadastroEtiqueta and not Config.CadastroCadarco then
    VprDProduto.CmpProduto:= EComprProduto.AInteiro
  else
    VprDProduto.CmpProduto:= EMetCadarco.AInteiro;

  if DeletaEspaco(DeletaChars(EDatAmostra.Text,'/')) <> '' then
    VprDProduto.DatEntradaAmostra:= StrToDate(EDatAmostra.Text)
  else
    VprDProduto.DatEntradaAmostra:= MontaData(1,1,1900);
  if DeletaEspaco(DeletaChars(EDatSaidaAmostra.Text,'/')) <> '' then
    VprDProduto.DatSaidaAmostra:= StrToDate(EDatSaidaAmostra.Text)
  else
    VprDProduto.DatSaidaAmostra:= MontaData(1,1,1900);
  VprDProduto.CmpFigura:= EComprFigura.AInteiro;
  VprDProduto.NumFios:= ENumeroFios.Text;
  VprDProduto.Pente:= EPente.Text;
  VprDProduto.MetrosPorMinuto:= EBatidasTotais.AInteiro;
  VprDProduto.BatProduto:= EBatidasProduto.Text;
  VprDProduto.NumBatidasTear:= EBatidasTear.Text;
  VprDProduto.CodTipoFundo:= ETipFundo.AInteiro;
  VprDProduto.CodTipoEmenda:= ETipEmenda.AInteiro;
  VprDProduto.CodTipoCorte:= ETipCorte.AInteiro;
  VprDProduto.PerProdutividade:= EIndiceProdutividade.AInteiro;
  if CCalandragem.Checked then
    VprDProduto.IndCalandragem:= 'S'
  else
    VprDProduto.IndCalandragem:= 'N';
  if CEngomagem.Checked then
    VprDProduto.IndEngomagem:= 'S'
  else
    VprDProduto.IndEngomagem:= 'N';
  VprDProduto.Engrenagem:= EEngrenagem.Text;
  VprDProduto.PraProduto:= EPrateleiraProduto.Text;
  if RTearConvencional.Checked then
    VprDProduto.DesTipTear:= 'C'
  else
    VprDProduto.DesTipTear:= 'H';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CadDClasseAdicionais;
begin
  VprDProduto.PesoLiquido:= EPesoLiquido.AValor;
  VprDProduto.PesoBruto:= EPesoBruto.AValor;
  VprDProduto.QtdMesesGarantia := EMesesGarantia.Value;
  VprDProduto.PraProduto:= EPrateleiraPro.Text;
  VprDProduto.CodEmbalagem:= EEmbalagem.AInteiro;
  VprDProduto.CodAcondicionamento:= EAcondicionamento.AInteiro;
  VprDProduto.CodComposicao := EComposicao.AInteiro;
  VprDProduto.AltProduto:= EAlturaProduto.AInteiro;
  VprDProduto.CapLiquida := ECapacidadeLiquida.AValor;
  VprDProduto.CodDesenvolvedor:= ECodDesenvolvedor.AInteiro;

  if CImprimeTabelaPreco.Checked then
    VprDProduto.IndImprimeNaTabelaPreco:= 'S'
  else
    VprDProduto.IndImprimeNaTabelaPreco:= 'N';
  if CCracha.Checked then
    VprDProduto.IndCracha:= 'S'
  else
    VprDProduto.IndCracha:= 'N';
  if CProdutoRetornavel.Checked then
    VprDProduto.IndProdutoRetornavel:= 'S'
  else
    VprDProduto.IndProdutoRetornavel:= 'N';
  VprDProduto.DesRendimento:= ERendimento.Text;
  if Config.CadastroEtiqueta and not Config.CadastroCadarco then
    VprDProduto.CmpProduto:= EComprProduto.AInteiro
  else
    VprDProduto.CmpProduto:= EMetCadarco.AInteiro;
  VprDProduto.IndMonitorarEstoque := CMonitorarEstoque.Checked;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseCopiadora;
begin
  VprDProduto.DesTipTear:= '';
  if RMatricial.Checked then
    VprDProduto.DesTipTear:= 'M'
  else
    if RJatoTinta.Checked then
      VprDProduto.DesTipTear:= 'J'
    else
      if RLaser.Checked then
        VprDProduto.DesTipTear:= 'L';
  if CCopiadora.Checked then
    VprDProduto.IndCopiadora:= 'S'
  else
    VprDProduto.IndCopiadora:= 'N';
  if CMultiFuncional.Checked then
    VprDProduto.IndMultiFuncional:= 'S'
  else
    VprDProduto.IndMultiFuncional:= 'N';
  if CImpressora.Checked then
    VprDProduto.IndImpressora:= 'S'
  else
    VprDProduto.IndImpressora:= 'N';
  if RColorida.Checked then
    VprDProduto.IndColorida:= 'S'
  else
    VprDProduto.IndColorida:= 'N';
  if RMonoComponente.Checked then
    VprDProduto.IndComponente:= 'N'
  else
    VprDProduto.IndComponente:= 'S';
  if RTonerComCilindro.Checked then
    VprDProduto.IndCilindro:= 'S'
  else
    VprDProduto.IndCilindro:= 'N';
  if CPlacaRede.Checked then
    VprDProduto.IndPlacaRede:= 'S'
  else
    VprDProduto.IndPlacaRede:= 'N';
  if CPcl.Checked then
    VprDProduto.IndPCL:= 'S'
  else
    VprDProduto.IndPCL:= 'N';
  if CFax.Checked then
    VprDProduto.IndFax:= 'S'
  else
    VprDProduto.IndFax:= 'N';
  if CUSB.Checked then
    VprDProduto.IndUSB:= 'S'
  else
    VprDProduto.IndUSB:= 'N';
  if CScanner.Checked then
    VprDProduto.IndScanner:= 'S'
  else
    VprDProduto.IndScanner:= 'N';
  if CWireless.Checked then
    VprDProduto.IndWireless:= 'S'
  else
    VprDProduto.IndWireless:= 'N';
  if CDuplex.Checked then
    VprDProduto.IndDuplex:= 'S'
  else
    VprDProduto.IndDuplex:= 'N';
  VprDProduto.CodReduzidoCartucho:= ECodCartucho.Text;
  VprDProduto.CodCartuchoAltaCapac:= ECodCartuchoAltaCapacidade.Text;
  VprDProduto.QtdCopiasTonner:= EQtdCopiasToner.AInteiro;
  VprDProduto.QtdCopiasTonnerAltaCapac:= EQtdCopiasTonerAltaCapacidade.AInteiro;
  VprDProduto.QtdCopiasCilindro:= EQtdCopiasCilindro.AInteiro;
  VprDProduto.QtdPagPorMinuto:= EQtdPaginasPorMinuto.AInteiro;
  VprDProduto.VolumeMensal:= EVolumeMensalCopias.AInteiro;
  if DeletaEspaco(DeletaChars(EDatFabricacao.Text,'/')) <> '' then
    VprDProduto.DatFabricacao:= StrToDate(EDatFabricacao.Text)
  else
    VprDProduto.DatFabricacao:= MontaData(1,1,1900);
  if DeletaEspaco(DeletaChars(EDatEncerramentoProducao.Text,'/')) <> '' then
    VprDProduto.DatEncerProducao:= StrToDate(EDatEncerramentoProducao.Text)
  else
    VprDProduto.DatEncerProducao:= MontaData(1,1,1900);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDClasseCartucho;
begin
  VprDProduto.CodReduzidoCartucho:= ECodigoReduzido.Text;
  VprDProduto.PesCartuchoVazio:= EPesoCartuchoVazio.AInteiro;
  VprDProduto.PesCartucho:= EPesoCartuchoCheio.AInteiro;
  VprDProduto.QtdMlCartucho:= EQtdMl.AInteiro;
  VprDProduto.QtdPaginas:= EQtdPaginas.AInteiro;
  VprDProduto.CodCorCartucho:= ECodCor.AInteiro;
  if RCartuchoTinta.Checked then
    VprDProduto.DesTipoCartucho := 'TI'
  else
    if RCartuchoTonner.Checked then
      VprDProduto.DesTipoCartucho := 'TO';
  VprDProduto.IndChipNovo:= CChipNovo.Checked;
  VprDProduto.IndCilindroNovo:= CCilindroNovo.Checked;
  VprDProduto.IndProdutoOriginal:= CProdutoOriginal.Checked;
  VprDProduto.IndCartuchoTexto:= CCartuchoTexto.Checked;
  VprDProduto.IndProdutoCompativel:= CProdutoCompativel.Checked;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFornecedor:= TRBDProdutoFornecedor(VprDProduto.Fornecedores.Items[VpaLinha-1]);

  if VprDFornecedor.CodCor = 0 then
    GFornecedores.Cells[1,VpaLinha]:= ''
  else
    GFornecedores.Cells[1,VpaLinha]:= IntToStr(VprDFornecedor.CodCor);
  GFornecedores.Cells[2,VpaLinha]:= VprDFornecedor.NomCor;
  if VprDFornecedor.CodCliente = 0 then
    GFornecedores.Cells[3,VpaLinha]:= ''
  else
    GFornecedores.Cells[3,VpaLinha]:= IntToStr(VprDFornecedor.CodCliente);
  GFornecedores.Cells[4,VpaLinha]:= VprDFornecedor.NomCliente;
  if VprDFornecedor.ValUnitario = 0 then
    GFornecedores.Cells[5,VpaLinha]:= ''
  else
    GFornecedores.Cells[5,VpaLinha]:= FormatFloat(Varia.MascaraValorUnitario,VprDFornecedor.ValUnitario);
  GFornecedores.Cells[6,VpaLinha]:= VprDFornecedor.DesReferencia;

  if VprDFornecedor.DatUltimaCompra > MontaData(1,1,1900) then
    GFornecedores.Cells[7,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDFornecedor.DatUltimaCompra)
  else
    GFornecedores.Cells[7,VpaLinha]:= '';
  if VprDFornecedor.NumDiaEntrega = 0 then
    GFornecedores.Cells[8,VpaLinha]:= ''
  else
    GFornecedores.Cells[8,VpaLinha]:= IntToStr(VprDFornecedor.NumDiaEntrega);
  if VprDFornecedor.QtdMinimaCompra = 0 then
    GFornecedores.Cells[9,VpaLinha]:= ''
  else
    GFornecedores.Cells[9,VpaLinha]:= FloatToStr(VprDFornecedor.QtdMinimaCompra);
  if VprDFornecedor.PerIPI = 0 then
    GFornecedores.Cells[10,VpaLinha]:= ''
  else
    GFornecedores.Cells[10,VpaLinha]:= FormatFloat('##0.00 %',VprDFornecedor.PerIPI);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDFornecedoresClasse;
begin
  if GFornecedores.Cells[1,GFornecedores.ALinha] <> '' then
    VprDFornecedor.CodCor := StrToInt(DeletaChars(GFornecedores.Cells[1,GFornecedores.ALinha],'.'))
  else
    VprDFornecedor.CodCor := 0;
  VprDFornecedor.CodCliente:= StrToInt(GFornecedores.Cells[3,GFornecedores.ALinha]);
  VprDFornecedor.NomCliente:= GFornecedores.Cells[4,GFornecedores.ALinha];
  if GFornecedores.Cells[5,GFornecedores.ALinha] <> '' then
    VprDFornecedor.ValUnitario:= StrToFloat(DeletaChars(GFornecedores.Cells[5,GFornecedores.ALinha],'.'))
  else
    VprDFornecedor.ValUnitario:= 0;
  VprDFornecedor.DesReferencia:= GFornecedores.Cells[6,GFornecedores.ALinha];
  try
    if DeletaChars(DeletaChars(GFornecedores.Cells[7,GFornecedores.ALinha],'/'),' ') <> '' then
      VprDFornecedor.DatUltimaCompra:= StrToDate(GFornecedores.Cells[7,GFornecedores.ALinha]);
  except
    VprDFornecedor.DatUltimaCompra:= MontaData(1,1,1900);
    aviso('DATA INVÁLIDA!!!'#13'Preencha corretamente a data.');
  end;
  if GFornecedores.Cells[8,GFornecedores.ALinha] <> '' then
    VprDFornecedor.NumDiaEntrega:= StrToInt(GFornecedores.Cells[8,GFornecedores.ALinha])
  else
    VprDFornecedor.NumDiaEntrega:= 0;
  if GFornecedores.Cells[9,GFornecedores.ALinha] <> '' then
    VprDFornecedor.QtdMinimaCompra:= StrToFloat(DeletaChars(GFornecedores.Cells[9,GFornecedores.ALinha],'.'))
  else
    VprDFornecedor.QtdMinimaCompra:= 0;
  if GFornecedores.Cells[10,GFornecedores.ALinha] <> '' then
    VprDFornecedor.PerIPI:= StrToFloat(DeletaChars(DeletaChars(DeletaChars(GFornecedores.Cells[10,GFornecedores.ALinha],'%'),'.'),' '))
  else
    VprDFornecedor.PerIPI:= 0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteCor then
  begin
    Aviso('CÓDIGO DA COR NÃO PREENCHIDA!'#13'É necessário preencher o código da cor.');
    VpaValidos:= False;
    GFornecedores.Col:= 1;
  end
  else
    if not ExisteCliente then
    begin
      Aviso('CÓDIGO DO FORNECEDOR NÃO PREENCHIDO!'#13'É necessário preencher o código do fornecedor.');
      VpaValidos:= False;
      GFornecedores.Col:= 3;
    end;

  if VpaValidos then
    CarDFornecedoresClasse;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1, 3, 8, 9: Value:= '0000000;0; ';
    7: Value:= FPrincipal.CorFoco.AMascaraData;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    114: begin
           case GFornecedores.Col of
             1: ECor.AAbreLocalizacao;
             3: EFornecedor.AAbreLocalizacao;
           end;
         end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GFornecedores.Col of
    6: if Key = '.' then
         Key:= ',';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.Fornecedores.Count > 0 then
    VprDFornecedor:= TRBDProdutoFornecedor(VprDProduto.Fornecedores.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresNovaLinha(Sender: TObject);
begin
  VprDFornecedor:= VprDProduto.AddFornecedor;
  VprDFornecedor.CodCliente:= 0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFornecedoresSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GFornecedores.AEstadoGrade in [egInsercao, egEdicao] then
  begin
    if GFornecedores.AColuna <> ACol then
      case GFornecedores.AColuna of
        1: if not ExisteCor then
             if not ECor.AAbreLocalizacao then
             begin
               Aviso('CÓDIGO DA COR INVALIDO !!!'#13'É necessário informar o código da cor.');
               GFornecedores.Col:= 1;
             end;
        3: if not ExisteCliente then
             if not EFornecedor.AAbreLocalizacao then
             begin
               Aviso('CÓDIGO DO FORNECEDOR INVALIDO !!!'#13'É necessário informar o código do fornecedor.');
               GFornecedores.Col:= 3;
             end;
      end;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteCor: Boolean;
begin
  Result:= True;
  if GFornecedores.Cells[1,GFornecedores.ALinha] <> '' then
  begin
    Result:= FunProdutos.ExisteCor(GFornecedores.Cells[1,GFornecedores.ALinha],VprDFornecedor.NomCor);
    if Result then
    begin
      VprDFornecedor.CodCor:= StrToInt(GFornecedores.Cells[1,GFornecedores.ALinha]);
      GFornecedores.Cells[2,GFornecedores.ALinha]:= VprDFornecedor.NomCor;
    end;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteCliente: Boolean;
begin
  Result:= False;
  if GFornecedores.Cells[3,GFornecedores.ALinha] <> '' then
  begin
    Result:= FunClientes.ExisteCliente(StrToInt(GFornecedores.Cells[3,GFornecedores.ALinha]));
    if Result then
    begin
      EFornecedor.Text:= GFornecedores.Cells[3,GFornecedores.ALinha];
      EFornecedor.Atualiza;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EFornecedorRetorno(Retorno1, Retorno2: String);
begin
  if GFornecedores.ALinha > 0 then
  begin
    GFornecedores.Cells[3,GFornecedores.ALinha]:= Retorno1;
    GFornecedores.Cells[4,GFornecedores.ALinha]:= Retorno2;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EMoedaRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodMoeda := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomMoeda := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[14,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[15,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodMoeda := 0;
      VprDProTabelaPreco.NomMoeda := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECorPrecoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProTabelaPreco.CodCor := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProTabelaPreco.NomCor := VpaColunas.items[1].AValorRetorno;
      GPreco.Cells[8,GPreco.ALinha] := VpaColunas.items[0].AValorRetorno;
      GPreco.Cells[9,GPreco.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProTabelaPreco.CodCor := 0;
      VprDProTabelaPreco.NomCor := '';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ECorRetorno(Retorno1, Retorno2: String);
begin
  if GFornecedores.ALinha > 0 then
  begin
    GFornecedores.Cells[1,GFornecedores.ALinha]:= Retorno1;
    GFornecedores.Cells[2,GFornecedores.ALinha]:= Retorno2;
    if GFornecedores.AEstadoGrade = egNavegacao then
      GFornecedores.AEstadoGrade := egEdicao;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EDescricaoExit(Sender: TObject);
begin
  if (varia.CNPJFilial = CNPJ_Reeltex) then
  begin
    if LPatFoto.Caption = '' then
    begin
      LPatFoto.Caption := CopiaAteChar(CopiaAteChar(EDescricao.Text,'/'),'=')+'0001.jpg';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDEstagio := TRBDEstagioProduto(VprDProduto.Estagios.Items[VpaLinha-1]);
  GEstagios.Cells[0,VpaLinha] := IntToStr(VprDEstagio.SeqEstagio);
  if VprDEstagio.NumOrdem <> 0 then
    GEstagios.Cells[1,VpaLinha] := IntToStr(VprDEstagio.NumOrdem)
  else
    GEstagios.Cells[1,VpaLinha] := '';
  if VprDEstagio.CodEstagio <> 0 then
    GEstagios.Cells[2,VpaLinha] := IntTostr(VprDEstagio.CodEstagio)
  else
    GEstagios.Cells[2,VpaLinha] := '';
  GEstagios.Cells[3,VpaLinha] := VprDEstagio.NomEstagio;
  GEstagios.Cells[4,VpaLinha] := VprDEstagio.DesEstagio;

  GEstagios.Cells[5,VpaLinha] := FormatFloat('0.0000',VprDEstagio.QtdProducaoHora);
  if VprDEstagio.CodEstagioAnterior <> 0 then
    GEstagios.Cells[6,VpaLinha] := InttoStr(VprDEstagio.CodEstagioAnterior)
  else
    GEstagios.Cells[6,VpaLinha] := '';
  if VprDEstagio.QtdEstagioAnterior <> 0 then
    GEstagios.Cells[7,VpaLinha] := IntToStr(VprDEstagio.QtdEstagioAnterior)
  else
    GEstagios.cells[7,VpaLinha] := '';
  GEstagios.Cells[8,VpaLinha] := VprDEstagio.IndConfig;
  GEstagios.Cells[9,VpaLinha] := VprDEstagio.DesTempoConfig;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDEstagio;
begin
  if GEstagios.Cells[1,GEstagios.ALinha] <> '' then
    VprDEstagio.NumOrdem := StrtoInt(Gestagios.Cells[1,GEstagios.ALinha])
  else
    VprDEstagio.Numordem := GEstagios.ALinha;
  VprDEstagio.CodEstagio := StrToInt(GEstagios.Cells[2,GEstagios.ALinha]);
  VprDEstagio.NomEstagio := GEstagios.Cells[3,GEstagios.ALinha];
  VprDEstagio.DesEstagio := GEstagios.Cells[4,GEstagios.ALinha];

  if GEstagios.Cells[5,GEstagios.ALinha] <> '' then
    VprDEstagio.QtdProducaoHora := StrToFloat(GEstagios.Cells[5,GEstagios.ALinha])
  else
    VprDEstagio.QtdproducaoHora := 0;
  if GEstagios.Cells[6,GEstagios.ALinha] <> '' then
    VprDEstagio.CodEstagioAnterior := StrToInt(GEstagios.Cells[6,GEstagios.ALinha])
  else
    VprDEstagio.CodEstagioAnterior := 0;
  if GEstagios.Cells[7,GEstagios.ALinha] <> '' then
    VprDEstagio.QtdEstagioAnterior := StrToInt(GEstagios.Cells[7,GEstagios.Alinha])
  else
    VprDEstagio.QtdEstagioAnterior := 0;
  VprDEstagio.IndConfig := UpperCase(GEstagios.cells[8,GEstagios.ALinha]);
  VprDEstagio.DesTempoConfig := GEstagios.Cells[9,Gestagios.ALinha];
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := false;
  if GEstagios.Cells[2,GEstagios.ALinha] = '' then
  begin
    aviso('ESTÁGIO NÃO PREENCHIDO!!!'#13'É necessário digitar o código do estagio.');
    GEstagios.col := 2;
  end
  else
    if (GEstagios.Cells[5,GEstagios.ALinha] = '') and (GEstagios.Cells[10,GEstagios.ALinha] = '') then
    begin
      aviso('QUANTIDADE PRODUÇÃO HORA OU TEMPO CONFIGURAÇÃO NÃO PREENCHIDO!!!'#13'É necessário digitar a quantidade produzida por hora ou o tempo de configuração.');
      GEstagios.col := 5;
    end
    else
      if not ExisteEstagio(GEstagios.Cells[2,GEstagios.ALinha]) then
      begin
        aviso('ESTÁGIO INVÁLIDO!!!'#13'O estágio preenchido não existe cadastrado.');
        GEstagios.col := 2;
      end
      else
        VpaValidos := true;
  if VpaValidos then
  begin
    CarDEstagio;

    if VpaValidos then
    begin
      if VprDEstagio.CodEstagio = 0 then
      begin
        aviso('ESTÁGIO NÃO PREENCHIDO!!!'#13'É necessário digitar o código do estagio.');
        GEstagios.col := 2;
        VpaValidos := false;
      end
      else
        if (VprDEstagio.IndConfig = 'N') and (VprDEstagio.QtdProducaoHora = 0) then
        begin
          aviso('QUANTIDADE PRODUÇÃO HORA NÃO PREENCHIDO!!!'#13'É necessário preencher a quantidade produzida em 1 hora.');
          Vpavalidos := false;
          GEstagios.col := 5;
        end
        else
          if (VprDEstagio.IndConfig = 'S') and (DeletaChars(DeletaChars(VprDEstagio.DesTempoConfig,' '),':') = '') then
          begin
            aviso('TEMPO DE CONFIGURAÇÃO NÃO PREENCHIDO!!!'#13'É necessário preencher o tempo de configuração.');
            Vpavalidos := false;
            GEstagios.col := 10;
          end
          else
            if (VprDEstagio.IndConfig <> 'S') and (VprDEstagio.IndConfig <> 'N') then
            begin
              aviso('INDICADOR SE O ESTÁGIO É UMA CONFIGURAÇÃO ESTÁ INVÁLIDO!!!'#13'É necessário preencher o indicador se o estagio é uma configuração ou não com os valores (S/N).');
              Vpavalidos := false;
              GEstagios.col := 9;
            end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosDepoisExclusao(Sender: TObject);
begin
  FunProdutos.ReorganizaSeqEstagio(VprDProduto);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1,2,6,7:  Value := '00000;0; ';
    9: value := '000:00;1;_';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114:
    begin
      case GEstagios.Col of
        2: EEstagio.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosKeyPress(Sender: TObject;
  var Key: Char);
begin
  case GEstagios.Col of
    3: key := #0;
    5: if key = '.' then
          key := ',';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.Estagios.Count >0 then
    VprDEstagio:= TRBDEstagioProduto(VprDProduto.Estagios.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosNovaLinha(Sender: TObject);
begin
  VprDEstagio := VprDProduto.AddEstagio;
  VprDEstagio.SeqEstagio := VprDProduto.Estagios.count;
  VprDEstagio.NumOrdem := VprDProduto.Estagios.count;
  VprDEstagio.IndConfig := 'N';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GEstagiosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GEstagios.AEstadoGrade in [egInsercao,EgEdicao] then
    if GEstagios.AColuna <> ACol then
    begin
      case GEstagios.AColuna of
        2 : if GEstagios.Cells[2,GEstagios.Alinha] <> '' then
            begin
              if not existeEstagio(GEstagios.Cells[2,GEstagios.Alinha]) then
              begin
                if not EEstagio.AAbreLocalizacao then
                begin
                  Aviso('ESTÁGIO INVÁLIDO!!!'#13'O estágio digitado não existe cadastrado.');
                  GEstagios.Col := 2;
                  abort;
                end;
              end;
            end
            else
              EEstagio.AAbreLocalizacao;
      end;
    end;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteEstagio(VpaCodEstagio: String): Boolean;
var
  VpfNomEstagio: String;
begin
  Result:= False;
  if VpaCodEstagio <> '' then
  begin
    Result:= FunProdutos.ExisteEstagio(VpaCodEstagio,VpfNomEstagio);
    if Result then
      GEstagios.Cells[3,GEstagios.ALinha]:= VpfNomEstagio;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EEstagioRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GEstagios.Cells[2,GEstagios.ALinha] := EEstagio.Text;
    GEstagios.Cells[3,GEstagios.ALinha] := retorno1;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCombinacao := TRBDCombinacao(VprDProduto.Combinacoes.Items[VpaLinha-1]);
  if VprDCombinacao.CodCombinacao <> 0 then
    GCombinacao.Cells[1,VpaLinha] := IntToStr(VprDCombinacao.CodCombinacao)
  else
    GCombinacao.Cells[1,VpaLinha] := '';
  if VprDCombinacao.CorFundo1 <> '' then
    GCombinacao.Cells[2,VpaLinha] := VprDCombinacao.CorFundo1
  else
    GCombinacao.Cells[2,VpaLinha] := '';
  if VprDCombinacao.TituloFundo1 <> '' then
    GCombinacao.Cells[3,VpaLinha] := VprDCombinacao.TituloFundo1
  else
    GCombinacao.Cells[3,VpaLinha] := '';
  if VprDCombinacao.Espula1 <> 0 then
    GCombinacao.Cells[4,VpaLinha] := IntToStr(VprDCombinacao.Espula1)
  else
    GCombinacao.Cells[4,VpaLinha] := '';
  if VprDCombinacao.CorFundo2 <> '' then
    GCombinacao.Cells[5,VpaLinha] := VprDCombinacao.CorFundo2
  else
    GCombinacao.Cells[5,VpaLinha] := '';
  if VprDCombinacao.TituloFundo2 <> '' then
    GCombinacao.Cells[6,VpaLinha] := VprDCombinacao.TituloFundo2
  else
    GCombinacao.Cells[6,VpaLinha] := '';
  if VprDCombinacao.Espula2 <> 0 then
    GCombinacao.Cells[7,VpaLinha] := IntToStr(VprDCombinacao.Espula2)
  else
    GCombinacao.Cells[7,VpaLinha] := '';
  if VprDCombinacao.CorCartela <> 0 then
    GCombinacao.Cells[8,VpaLinha] := IntToStr(VprDCombinacao.CorCartela)
  else
    GCombinacao.Cells[8,VpaLinha] := '';
  if VprDCombinacao.CorUrdumeFigura <> '' then
    GCombinacao.Cells[9,VpaLinha] := VprDCombinacao.CorUrdumeFigura
  else
    GCombinacao.Cells[9,VpaLinha] := '';
  if VprDCombinacao.TituloFundoFigura <> '' then
    GCombinacao.Cells[10,VpaLinha] := VprDCombinacao.TituloFundoFigura
  else
    GCombinacao.Cells[10,VpaLinha] := '';
  if VprDCombinacao.EspulaUrdumeFigura <> 0 then
    GCombinacao.Cells[11,VpaLinha] := IntToStr(VprDCombinacao.EspulaUrdumeFigura)
  else
    GCombinacao.Cells[11,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDCombinacao;
begin
  VprDCombinacao.CodCombinacao := StrToInt(GCombinacao.Cells[1,GCombinacao.ALinha]);
  VprDCombinacao.CorFundo1 := GCombinacao.Cells[2,GCombinacao.ALinha];
  VprDCombinacao.TituloFundo1 := GCombinacao.Cells[3,GCombinacao.ALinha];
  VprDCombinacao.Espula1 :=  StrToInt(GCombinacao.Cells[4,GCombinacao.ALinha]);
  VprDCombinacao.CorFundo2 := GCombinacao.Cells[5,GCombinacao.ALinha];
  VprDCombinacao.TituloFundo2 := GCombinacao.Cells[6,GCombinacao.ALinha];
  VprDCombinacao.Espula2 := StrToInt(GCombinacao.Cells[7,GCombinacao.ALinha]);
  if GCombinacao.Cells[8,GCombinacao.ALinha] <> '' then
    VprDCombinacao.CorCartela := StrToInt(GCombinacao.Cells[8,GCombinacao.ALinha])
  else
    VprDCombinacao.CorCartela := 0;
  if GCombinacao.Cells[9,GCombinacao.ALinha] <> '' then
    VprDCombinacao.CorUrdumeFigura := GCombinacao.Cells[9,GCombinacao.ALinha]
  else
    VprDCombinacao.CorUrdumeFigura := '';
  VprDCombinacao.TituloFundoFigura := GCombinacao.Cells[10,GCombinacao.ALinha];
  if GCombinacao.Cells[11,GCombinacao.ALinha] <> '' then
    VprDCombinacao.EspulaUrdumeFigura := StrToInt(GCombinacao.Cells[11,GCombinacao.ALinha])
  else
    VprDCombinacao.EspulaUrdumeFigura := 0;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if  GCombinacao.Cells[1,GCombinacao.ALinha] = '' then
  begin
    Aviso('COMBINAÇÃO INVÁLIDA!!!'#13'É necessário preencher o código da combinação');
    GCombinacao.Col := 1;
    VpaValidos := false;
  end
  else
    if  GCombinacao.Cells[2,GCombinacao.ALinha] = '' then
    begin
      Aviso('COR FUNDO 1 INVÁLIDA!!!'#13'É necessário preencher a cor de fundo 1');
      GCombinacao.Col := 2;
      VpaValidos := false;
    end
    else
      if  GCombinacao.Cells[3,GCombinacao.ALinha] = '' then
      begin
        Aviso('TÍTULO FUNDO 1 INVÁLIDO!!!'#13'É necessário preencher o título do fundo 1');
        GCombinacao.Col := 3;
        VpaValidos := false;
      end
      else
        if  GCombinacao.Cells[4,GCombinacao.ALinha] = '' then
        begin
          Aviso('ESPULA 1 INVÁLIDO!!!'#13'É necessário preencher a espúla da cor de fundo 1');
          GCombinacao.Col := 4;
          VpaValidos := false;
        end
        else
          if  GCombinacao.Cells[5,GCombinacao.ALinha] = '' then
          begin
            Aviso('COR FUNDO 2 INVÁLIDO!!!'#13'É necessário preencher a cor de fundo 2');
            GCombinacao.Col := 5;
            VpaValidos := false;
          end
          else
            if  GCombinacao.Cells[6,GCombinacao.ALinha] = '' then
            begin
              Aviso('TÍTULO FUNDO 2 INVÁLIDO!!!'#13'É necessário preencher o título do fundo 2');
              GCombinacao.Col := 6;
              VpaValidos := false;
            end
            else
              if  GCombinacao.Cells[7,GCombinacao.ALinha] = '' then
              begin
                Aviso('ESPULA FUNDO 2 INVÁLIDO!!!'#13'É necessário preencher a espúla do  fundo 2');
                GCombinacao.Col := 7;
                VpaValidos := false;
              end;

  if VpaValidos then
  begin
    CarDCombinacao;

    if FunProdutos.CombinacaoDuplicada(VprDProduto) then
    begin
      Aviso('COMBINAÇÃO DUPLICADA!!!'#13'A combinação "'+ InttoStr(VprDCombinacao.CodCombinacao)+'" está duplicada.');
      VpaValidos := false;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1: Value := '0000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.Combinacoes.Count > 0 then
  begin
    VprDCombinacao:= TRBDCombinacao(VprDProduto.Combinacoes.Items[VpaLinhaAtual-1]);
    GFigura.ADados:= VprDCombinacao.Figuras;
    GFigura.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GCombinacaoNovaLinha(Sender: TObject);
begin
  VprDCombinacao := VprDProduto.AddCombinacao;
  VprDCombinacao.Espula1 := 1;
  VprDCombinacao.Espula2 := 1;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GDPCClick(Sender: TObject);
begin
  if BNovo.Down then
  begin
    if (GDPC.row < GDPC.RowCount - 1)then
    begin
      if GDPC.Cells[GDPC.col,GDPC.Row] = '' then
        GDPC.Cells[GDPC.col,GDPC.Row] := '*'
      else
        GDPC.Cells[GDPC.col,GDPC.Row] := '';
    end;
  end
  else
    if BCursor.Down then
    begin
      CarDProdutoInstalacaoTela;
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GDPCGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ARow < GDPC.RowCount -1 then
  begin
    if GDPC.Cells[Acol,ARow] = '' then
      ABrush.Color := clInfoBk
    else
      if GDPC.Cells[Acol,ARow] = '*' then
        ABrush.Color := clBlack;
  end
  else
    ABrush.Color := clGray;
end;

{******************************************************************************}
function TFNovoProdutoPro.GeraCodigoBarras: String;
begin
  result := '';
  if (VprOperacao = ocInsercao) then
  begin
    case Varia.TipCodBarras of
      cbEAN13 : VprDProduto.CodBarraFornecedor :=  FunProdutos.RCodBarrasEAN13Disponivel;
    end;
    if VprDProduto.CodBarraFornecedor = 'FIM FAIXA' then
      result :='FINAL DA FAIXA DO CODIGO DE BARRAS!!!'#13'Não existe mais codigo de barras disponivel.'
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFigura := TRBDCombinacaoFigura(VprDCombinacao.Figuras.Items[VpaLinha-1]);
  if VprDFigura.SeqFigura <> 0 then
    GFigura.Cells[1,VpaLinha] := IntToStr(VprDFigura.SeqFigura)
  else
    GFigura.Cells[1,VpaLinha] := '';
  if VprDFigura.CodCor <> '' then
    GFigura.Cells[2,VpaLinha] := VprDFigura.CodCor
  else
    GFigura.Cells[2,VpaLinha] := '';
  if VprDFigura.TitFio <> '' then
    GFigura.Cells[3,VpaLinha] := VprDFigura.TitFio
  else
    GFigura.Cells[3,VpaLinha] := '';
  if VprDFigura.NumEspula <> 0 then
    GFigura.Cells[4,VpaLinha] := IntToStr(VprDFigura.NumEspula)
  else
    GFigura.Cells[4,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDFigura;
begin
  VprDFigura.SeqFigura := StrToInt(GFigura.Cells[1,GFigura.Alinha]);
  VprDFigura.CodCor := GFigura.Cells[2,GFigura.Alinha];
  VprDFigura.TitFio := GFigura.Cells[3,GFigura.Alinha];
  VprDFigura.NumEspula := StrToInt(GFigura.Cells[4,GFigura.Alinha]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDTabelaPreco;
begin
  VprDProTabelaPreco.ValVenda := StrToFloat(DeletaChars(GPreco.Cells[3,GPreco.ALinha],'.'));
  VprDProTabelaPreco.ValReVenda := StrToFloat(DeletaChars(GPreco.Cells[4,GPreco.ALinha],'.'));
  VprDProTabelaPreco.PerMaximoDesconto := StrToFloat(DeletaChars(DeletaChars(DeletaChars(GPreco.Cells[5,GPreco.ALinha],'.'),'%'),' '));
  VprDProTabelaPreco.ValCompra := StrToFloat(DeletaChars(GPreco.Cells[6,GPreco.ALinha],'.'));
  VprDProTabelaPreco.ValCusto := StrToFloat(DeletaChars(GPreco.Cells[7,GPreco.ALinha],'.'));
  VprDProTabelaPreco.QtdMinima := StrToFloat(DeletaChars(GPreco.Cells[16,GPreco.ALinha],'.'));
  VprDProTabelaPreco.QtdIdeal := StrToFloat(DeletaChars(GPreco.Cells[17,GPreco.ALinha],'.'));
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarProduto(VpaCodEmpresa, VpaCodFilial, VpaSeqProduto: Integer);
begin
  VprOperacao:= ocConsulta;
  FunProdutos.CarDProduto(VprDProduto,VpaCodEmpresa,VpaCodFilial,VpaSeqProduto);
  FunProdutos.CarDCombinacao(VprDProduto);
  FunProdutos.CarDEstagio(VprDProduto);
  FunProdutos.CarDFornecedores(VprDProduto);
  FunProdutos.CarAcessoriosProduto(VprDProduto);
  ECodClassificacao.EditMask:= RetornaPicture(Varia.MascaraCla,VprDProduto.CodClassificacao,'_');
  CarDTela;
  VprOperacao:= ocEdicao;
  EUnidadesVendaChange(EUnidadesVenda);
  ConfiguracoesEstagios;
  BloquearTela(False);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := false;
  if GFigura.Cells[1,GFigura.ALinha] = '' then
  begin
    aviso('SEQUÊNCIA DA FIGURA INVÁLIDA!!!'#13'É necessário preencher o sequencial da figura.');
    GFigura.col := 1;
  end
  else
    if GFigura.Cells[2,GFigura.ALinha] = '' then
    begin
      aviso('COR INVÁLIDA!!!'#13'É necessário preencher a cor da figura.');
      GFigura.col := 2;
    end
    else
      if GFigura.Cells[3,GFigura.ALinha] = '' then
      begin
        aviso('TÍTULO INVÁLIDO!!!'#13'É necessário preencher o título do fio.');
        GFigura.col := 3;
      end
      else
        if GFigura.Cells[4,GFigura.ALinha] = '' then
        begin
          aviso('ESPULA INVÁLIDA!!!'#13'É necessário preencher a espula da figura.');
          GFigura.col := 4;
        end
        else
          VpaValidos := true;
  if VpaValidos then
  begin
    CarDFigura;
    if VprDFigura.SeqFigura = 0 then
    begin
      aviso('SEQUÊNCIA DA FIGURA INVÁLIDA!!!'#13'É necessário preencher o sequencial da figura.');
      GFigura.col := 1;
      VpaValidos := false;
    end
    else
      if VprDFigura.CodCor = '' then
      begin
        aviso('COR INVÁLIDA!!!'#13'É necessário preencher a cor da figura.');
        GFigura.col := 2;
        VpaValidos := false;
      end
      else
        if VprDFigura.TitFio = '' then
        begin
          aviso('TÍTULO INVÁLIDO!!!'#13'É necessário preencher o título do fio.');
          GFigura.col := 3;
          VpaValidos := false;
        end
        else
          if VprDFigura.NumEspula = 0 then
          begin
            aviso('ESPULA INVÁLIDA!!!'#13'É necessário preencher a espula da figura.');
            GFigura.col := 4;
            VpaValidos := false;
          end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1: Value:= '000;0; ';
    4: Value:= '00;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDCombinacao <> nil then
    if VprDCombinacao.Figuras.Count >0 then
    begin
      VprDFigura := TRBDCombinacaoFigura(VprDCombinacao.Figuras.Items[VpaLinhaAtual-1]);
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GFiguraNovaLinha(Sender: TObject);
begin
  VprDFigura := VprDCombinacao.AddFigura;
  VprDFigura.SeqFigura := VprDCombinacao.Figuras.Count + 1;
  VprDFigura.NumEspula := 1;
  GFigura.Col := 2;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProImpressora:= TRBDProdutoImpressora(VprListaImpressoras.Items[VpaLinha-1]);
  GImpressoras.Cells[1,VpaLinha] := VprDProImpressora.CodProduto;
  GImpressoras.Cells[2,VpaLinha] := VprDProImpressora.NomProduto;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GImpressoras.Cells[1,GImpressoras.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteImpressora then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GImpressoras.col := 1;
    end;
    if VpaValidos then
    begin
      VpaValidos := not ImpressoraDuplicada;
    end;
end;

{******************************************************************************}
function TFNovoProdutoPro.ExisteImpressora : boolean;
var
  VpfTemp : string;
begin
  if (GImpressoras.Cells[1,GImpressoras.ALinha] <> '') then
  begin
    if GImpressoras.Cells[1,GImpressoras.ALinha] = VprImpressoraAnterior then
      result := true
    else
    begin
      result := FunProdutos.ExisteProduto(GImpressoras.Cells[1,GImpressoras.ALinha],VprDProImpressora.SeqImpressora , VprDProImpressora.NomProduto,VpfTemp);
      if result then
      begin
        VprDProImpressora.CodProduto := GImpressoras.Cells[1,GImpressoras.ALinha];
        GImpressoras.Cells[2,GImpressoras.ALinha] := VprDProImpressora.NomProduto;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovoProdutoPro.ImpressoraDuplicada: Boolean;
var
  VpfLacoExterno, vpfLacoInterno : Integer;
begin
  result := false;
  for VpfLacoExterno := 0 to VprListaImpressoras.Count -2 do
  begin
    for vpfLacoInterno := VpfLacoExterno +1 to VprListaImpressoras.count -1 do
    begin
      if TRBDProdutoImpressora(VprListaImpressoras.Items[VpfLacoExterno]).SeqImpressora = TRBDProdutoImpressora(VprListaImpressoras.Items[vpfLacoInterno]).SeqImpressora then
      begin
        result := true;
        aviso('IMPRESSORA DUPLICADA!!!'#13'Essa impressora já foi adicionada para esse cartucho');
        exit;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovoProdutoPro.LocalizaImpressora: Boolean;
var
  VpfTemp, VpfTemp1 : string;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDProImpressora.SeqImpressora,VprDProImpressora.CodProduto,VprDProImpressora.NomProduto,VpfTemp,vpfTemp1); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    GImpressoras.Cells[1,GImpressoras.ALinha] := VprDProImpressora.CodProduto;
    GImpressoras.Cells[2,GImpressoras.ALinha] := VprDProImpressora.NomProduto;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114: LocalizaImpressora;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprListaImpressoras.Count > 0 then
  begin
    VprDProImpressora := TRBDProdutoImpressora(VprListaImpressoras.Items[VpaLinhaAtual-1]);
    VprImpressoraAnterior := VprDProImpressora.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasNovaLinha(Sender: TObject);
begin
  VprDProImpressora:= TRBDProdutoImpressora.Create;
  VprListaImpressoras.Add(VprDProImpressora);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GImpressorasSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GImpressoras.AEstadoGrade in [egInsercao,EgEdicao] then
    if GImpressoras.AColuna <> ACol then
    begin
      case GImpressoras.AColuna of
        1 :if not ExisteImpressora then
           begin
             if not LocalizaImpressora then
             begin
               GImpressoras.Cells[1,GImpressoras.ALinha] := '';
               GImpressoras.Col := 1;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GInstalacaoClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if BNovo.Down then
  begin
    if (GInstalacao.Col < GInstalacao.ColCount - 1) and
       (GInstalacao.Row < GInstalacao.RowCount -3) then
    begin
      VpfResultado := DadosProdutoInstalacaoValido;
      if VpfResultado = '' then
      begin
        CarDProdutoInstalacao;
        if GInstalacao.Cells[GInstalacao.col,GInstalacao.Row] = '' then
          GInstalacao.Cells[GInstalacao.col,GInstalacao.Row] := '*'
        else
          GInstalacao.Cells[GInstalacao.col,GInstalacao.Row] := '';
      end
      else
        aviso(VpfResultado);
    end;
  end
  else
    if BCursor.Down then
    begin
      CarDProdutoInstalacaoTela;
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GInstalacaoGetCellColor(Sender: TObject; ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ACol < GInstalacao.ColCount -1 then
  begin
    if GInstalacao.Cells[Acol,ARow] = '' then
      ABrush.Color := clInfoBk
    else
      if GInstalacao.Cells[Acol,ARow] = '*' then
        ABrush.Color := clBlack
      else
        if GInstalacao.Cells[Acol,ARow] = '&' then
          ABrush.Color := clBlue;
  end
  else
    ABrush.Color := clGray;
end;

procedure TFNovoProdutoPro.GInstalacaoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  GInstalacao.MouseToCell(x,y,VprColunaInicial,VprLinhaInicial);
  if (VprLinhaInicial = GInstalacao.RowCount -3) then
  begin

  end;
end;

{***********************************************************************}
procedure TFNovoProdutoPro.GInstalacaoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Vpfqtd : String;
  VpfDRepeticao : TRBDRepeticaoInstalacaoTear;
  VpfResultado : String;
  VpfLinha, VpfLaco : Integer;
begin
  if BRepeticaoDesenho.Down then
  begin
    GInstalacao.MouseToCell(x,y,VprColunaFinal,VprLinhaFinal);
    VpfResultado := FunProdutos.AdicionaRepeticaoInstalacaoTear(VprDProduto,VprColunaInicial,VprColunaFinal,VprQtdRepeticao);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
    begin
      VpfDRepeticao := TRBDRepeticaoInstalacaoTear(VprDProduto.DInstalacaoCorTear.Repeticoes.Items[VprDProduto.DInstalacaoCorTear.Repeticoes.Count -1]);
      if (VprDProduto.DInstalacaoCorTear.Repeticoes.Count mod 2) = 0 then
        VpfLinha := GInstalacao.RowCount-2
      else
        VpfLinha := GInstalacao.RowCount-1;
      GInstalacao.Cells[VpfDRepeticao.NumColunaInicial +((VpfDRepeticao.NumColunaFinal - VpfDRepeticao.NumColunaInicial)div 2),VpfLinha] := IntToStr(VpfDRepeticao.QtdRepeticao);
      for Vpflaco := VpfDRepeticao.NumColunaInicial to VpfDRepeticao.NumColunaFinal do
      begin
        GInstalacao.Cells[Vpflaco,VpfLinha-1] := '&';
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoAntesExclusao(Sender: TObject; var VpaPermiteExcluir: Boolean);
begin
  if VprOperacao = ocEdicao then
  begin
    if VprDProTabelaPreco.QtdEstoque <> 0 then
    begin
      VpaPermiteExcluir := false;
      aviso('NÃO É PERMITIDO EXCLUIR O ITEM DO ESTOQUE!!!'#13'Esse item possui "'+FormatFloat('#,###,##0.00',VprDProTabelaPreco.QtdEstoque)+'" itens em estoque, é necessário antes zerar o estoque para depois excluir.');
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDProTabelaPreco := TRBDProdutoTabelaPreco(VprDProduto.TabelaPreco.Items[VpaLinha-1]);
  if VprDProTabelaPreco.CodTabelaPreco <> 0 then
    GPreco.Cells[1,VpaLinha] := IntToStr(VprDProTabelaPreco.CodTabelaPreco)
  else
    GPreco.Cells[1,VpaLinha] := '';
  GPreco.Cells[2,VpaLinha] := VprDProTabelaPreco.NomTabelaPreco;
  GPreco.Cells[3,VpaLinha] := FormatFloat(varia.MascaraValorUnitario,VprDProTabelaPreco.ValVenda);
  GPreco.Cells[4,VpaLinha] := FormatFloat(varia.MascaraValorUnitario,VprDProTabelaPreco.ValReVenda);
  GPreco.Cells[5,VpaLinha] := FormatFloat('0.00%',VprDProTabelaPreco.PerMaximoDesconto);
  GPreco.Cells[6,VpaLinha] := FormatFloat(varia.MascaraValorUnitario,VprDProTabelaPreco.ValCompra);
  GPreco.Cells[7,VpaLinha] := FormatFloat(varia.MascaraValorUnitario,VprDProTabelaPreco.ValCusto);
  if VprDProTabelaPreco.CodCor <> 0 then
    GPreco.Cells[8,VpaLinha] := IntToStr(VprDProTabelaPreco.CodCor)
  else
    GPreco.Cells[8,VpaLinha] := '';
  GPreco.Cells[9,VpaLinha] := VprDProTabelaPreco.NomCor;
  if VprDProTabelaPreco.CodTamanho <> 0 then
    GPreco.Cells[10,VpaLinha] := IntToStr(VprDProTabelaPreco.CodTamanho)
  else
    GPreco.Cells[10,VpaLinha] := '';
  GPreco.Cells[11,VpaLinha] := VprDProTabelaPreco.NomTamanho;
  if VprDProTabelaPreco.CodCliente <> 0 then
    GPreco.Cells[12,VpaLinha] := IntToStr(VprDProTabelaPreco.CodCliente)
  else
    GPreco.Cells[12,VpaLinha] := '';
  GPreco.Cells[13,VpaLinha] := VprDProTabelaPreco.NomCliente;
  if VprDProTabelaPreco.CodMoeda <> 0 then
    GPreco.Cells[14,VpaLinha] := IntToStr(VprDProTabelaPreco.CodMoeda)
  else
    GPreco.Cells[14,VpaLinha] := '';
  GPreco.Cells[15,VpaLinha] := VprDProTabelaPreco.NomMoeda;
  GPreco.Cells[16,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDProTabelaPreco.QtdMinima);
  GPreco.Cells[17,VpaLinha] := FormatFloat(varia.MascaraQtd,VprDProTabelaPreco.QtdIdeal);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ETabelaPreco.AExisteCodigo(GPreco.Cells[1,GPreco.ALinha]) then
  begin
    aviso('TABELA DE PREÇO NÃO CADASTRADA!!!'#13'É necessário preencher a tabela de preço.');
    VpaValidos:= False;
    GPreco.Col:= 1;
  end
  else
    if not ECorPreco.AExisteCodigo(GPreco.Cells[8,GPreco.ALinha]) then
    begin
      aviso('COR NÃO CADASTRADA!!!'#13'A cor digitada não existe cadastrada');
      VpaValidos:= False;
      GPreco.Col:= 8;
    end
    else
      if not ETamanho.AExisteCodigo(GPreco.Cells[10,GPreco.ALinha]) then
      begin
        aviso('TAMANHO NÃO CADASTRADO!!!'#13'O tamanho digitado não existe cadastrado');
        VpaValidos:= False;
        GPreco.Col:= 10;
      end
      else
        if not ECliPreco.AExisteCodigo(GPreco.Cells[12,GPreco.ALinha]) then
        begin
          aviso('CLIENTE NÃO CADASTRADO!!!'#13'O cliente digitado não existe cadastrado');
          VpaValidos:= False;
          GPreco.Col:= 12;
        end
        else
          if not EMoeda.AExisteCodigo(GPreco.Cells[14,GPreco.ALinha]) then
          begin
            aviso('MOEDA NÃO CADASTRADA!!!'#13'A moeda digitada não existe cadastrada');
            VpaValidos:= False;
            GPreco.Col:= 14;
          end;

  if VpaValidos then
  begin
    CarDTabelaPreco;
    if FunProdutos.ExisteTabelaPrecoDuplicado(VprDProduto) then
    begin
      aviso('TABELA DE PREÇO DUPLICADO!!!'#13'A tabela de preço digitado já existe digitado para essa cor e tamanho');
      VpaValidos:= False;
      GPreco.Col:= 1;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  case ACol of
    1,8,10,12,14: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GPreco.Col of
        1 : ETabelaPreco.AAbreLocalizacao;
        6 : ECorPreco.AAbreLocalizacao;
        10 : ETamanho.AAbreLocalizacao;
        12 : ECliPreco.AAbreLocalizacao;
        14: EMoeda.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.TabelaPreco.Count > 0 then
    VprDProTabelaPreco := TRBDProdutoTabelaPreco(VprDProduto.TabelaPreco.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoNovaLinha(Sender: TObject);
begin
  VprDProTabelaPreco := VprDProduto.AddTabelaPreco;
  VprDProTabelaPreco.CodTabelaPreco := varia.TabelaPreco;
  VprDProTabelaPreco.NomTabelaPreco := FunProdutos.RNomTabelaPreco(Varia.TabelaPreco);
  VprDProTabelaPreco.CodMoeda := VARIA.MoedaBase;
  VprDProTabelaPreco.NomMoeda := FunContasAReceber.RNomMoeda(Varia.MoedaBase);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GPrecoSelectCell(Sender: TObject; ACol,ARow: Integer; var CanSelect: Boolean);
begin
  if GPreco.AEstadoGrade in [egInsercao,EgEdicao] then
    if GPreco.AColuna <> ACol then
    begin
      case GPreco.AColuna of
        1: if not ETabelaPreco.AExisteCodigo(GPreco.Cells[1,GPreco.ALinha]) then
           begin
             if not ETabelaPreco.AAbreLocalizacao then
             begin
               GPreco.Cells[1,GPreco.ALinha]:= '';
               GPreco.Col:= 1;
               Abort;
             end;
           end;
        8: if not ECorPreco.AExisteCodigo(GPreco.Cells[8,GPreco.ALinha]) then
           begin
             if not ECorPreco.AAbreLocalizacao then
             begin
               GPreco.Cells[8,GPreco.ALinha]:= '';
               GPreco.Col:= 8;
               Abort;
             end;
           end;
        10: if not ETamanho.AExisteCodigo(GPreco.Cells[10,GPreco.ALinha]) then
           begin
             if not ETamanho.AAbreLocalizacao then
             begin
               GPreco.Cells[10,GPreco.ALinha]:= '';
               GPreco.Col:= 10;
               Abort;
             end;
           end;
        12: if not ECliPreco.AExisteCodigo(GPreco.Cells[12,GPreco.ALinha]) then
           begin
             if not ECliPreco.AAbreLocalizacao then
             begin
               GPreco.Cells[12,GPreco.ALinha]:= '';
               GPreco.Col:= 12;
               Abort;
             end;
           end;
       14: if not EMoeda.AExisteCodigo(GPreco.Cells[14,GPreco.ALinha]) then
           begin
             if not EMoeda.AAbreLocalizacao then
             begin
               GPreco.Cells[14,GPreco.ALinha]:= '';
               GPreco.Col:= 14;
               Abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.SpeedButton8Click(Sender: TObject);
begin
  EDatAmostra.Clear;
  EDatSaidaAmostra.clear;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.ZoomGradeInstalacao(VpaIndice: Double);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to GInstalacao.RowCount - 1 do
    GInstalacao.RowHeights[Vpflaco] := RetornaInteiro(GInstalacao.RowHeights[Vpflaco] * VpaIndice);
  for VpfLaco := 0 to GInstalacao.ColCount - 1 do
    GInstalacao.ColWidths[Vpflaco] := RetornaInteiro(GInstalacao.ColWidths[Vpflaco] * VpaIndice);
end;


{******************************************************************************}
procedure TFNovoProdutoPro.CarDProdutoInstalacao;
var
  VpfDProdutoInstalacao : TRBDProdutoInstalacaoTear;
begin
  if GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row] <> nil then
    GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row].Free;
  VpfDProdutoInstalacao := TRBDProdutoInstalacaoTear.cria;
  GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row] := VpfDProdutoInstalacao;
  VpfDProdutoInstalacao.CodProduto := EProdutoInstalacao.Text;
  VpfDProdutoInstalacao.NomProduto := LNomProdutoInstalacao.Caption;
  VpfDProdutoInstalacao.CodCor := ECorInstalacao.AInteiro;
  VpfDProdutoInstalacao.NomCor := LNomCorInstalacao.Caption;
  VpfDProdutoInstalacao.QtdFioslIco := EQtdFiosLico.AsInteger;
  VpfDProdutoInstalacao.SeqProduto := VprSeqProdutoInstalacao;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.CarDProdutoInstalacaoTela;
var
  VpfDProdutoInstalacao : TRBDProdutoInstalacaoTear;
begin
  if GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row] <> nil then
  begin
    VpfDProdutoInstalacao :=TRBDProdutoInstalacaoTear(GInstalacao.Objects[GInstalacao.Col,GInstalacao.Row]);
    EProdutoInstalacao.Text := VpfDProdutoInstalacao.CodProduto;
    LNomProdutoInstalacao.Caption := VpfDProdutoInstalacao.NomProduto;
    ECorInstalacao.AInteiro := VpfDProdutoInstalacao.CodCor;
    LNomCorInstalacao.Caption := VpfDProdutoInstalacao.NomCor;
    EQtdFiosLico.AsInteger := VpfDProdutoInstalacao.QtdFioslIco;
    VprSeqProdutoInstalacao := VpfDProdutoInstalacao.SeqProduto;
  end;

end;

{******************************************************************************}
function TFNovoProdutoPro.DadosProdutoInstalacaoValido : String;
begin
  result := '';
  if EProdutoInstalacao.Text = '' then
    result := 'PRODUTO NÃO PREENCHIDO!!!'#13'É necessário selecionar o produto';
  if result = '' then
  begin
    if ECorInstalacao.AInteiro = 0 then
      result := 'COR NÃO PREENCHIDA!!!'#13'A cor do produto de instalação não foi preenchido.';
    if result = '' then
    begin
      if EQtdFiosLico.AsInteger = 0 then
        result := 'QUANTIDADE DE FIOS NO LIÇO NÃO PREENHCIDO!!!'#13'É necessário preenhcer a quantidade de fios no liço.';
      if result = '' then
      begin
        if EFuncaoFio.ItemIndex < 0 then
          result := 'FUNÇÃO FIO NÃO PREENCHIDO!!!'#13'É necessário preenhcer a função do fio.';
      end;
    end;

  end;


end;

{******************************************************************************}
procedure TFNovoProdutoPro.EPerLucroChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if config.ValorVendaProdutoAutomatico then
    begin
      if EPerLucro.AValor <> 0 then
        EValVenda.AValor := ((EPerLucro.AValor/100)*EValCusto.AValor)
    end;
  end;
end;

procedure TFNovoProdutoPro.EProdutoInstalacaoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if VpaColunas.items[2].AValorRetorno <> '' then
      VprSeqProdutoInstalacao := StrToINt(VpaColunas.items[2].AValorRetorno)
    else
      VprSeqProdutoInstalacao := 0;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQtdColInstalacaoExit(Sender: TObject);
begin
  ConfiguraQtdColunaInstalcao(EQtdColInstalacao.Value);
end;

procedure TFNovoProdutoPro.EQtdLinInstalacaoExit(Sender: TObject);
begin
  ConfiguraQtdLinhaInstalacao(EQtdLinInstalacao.Value);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQtdMinimaExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EQtdMinima.AValor <> VprDProduto.QtdMinima then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.QtdMinima := EQtdMinima.AValor;
      VprDProduto.QtdMinima := EQtdMinima.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQtdPedidoExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EQtdPedido.AValor <> VprDProduto.QtdPedido then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.QtdIdeal := EQtdPedido.AValor;
      VprDProduto.QtdPedido := EQtdPedido.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQtdQuadrosExit(Sender: TObject);
begin
  ConfiguraQtdQuadros(EQtdQuadros.Value);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EQuantidadeExit(Sender: TObject);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if EQuantidade.AValor <> VprDProduto.QtdEstoque then
    begin
      VpfDTabelaPreco := FunProdutos.RTabelaPreco(VprDProduto,varia.TabelaPreco,0,0,Varia.MoedaBase);
      if VpfDTabelaPreco <> nil then
        VpfDTabelaPreco.QtdEstoque := EQuantidade.AValor;
      VprDProduto.QtdEstoque := EQuantidade.AValor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProAcessorio := TRBDProdutoAcessorio(VprDProduto.Acessorios.Items[VpaLinha-1]);
  if VprDProAcessorio.CodAcessorio <> 0 then
    GAcessorios.Cells[1,VpaLinha] := IntToStr(VprDProAcessorio.CodAcessorio)
  else
    GAcessorios.Cells[1,VpaLinha] := '';
  GAcessorios.Cells[2,VpaLinha] := VprDProAcessorio.NomAcessorio;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not EAcessorio.AExisteCodigo(GAcessorios.Cells[1,GAcessorios.ALinha]) then
  begin
    aviso('ACESSÓRIO NÃO CADASTRADO!!!'#13'É necessário informar o código de um acessório que esteja cadastrado.');
    VpaValidos:= False;
    GAcessorios.Col:= 1;
  end;
  if VpaValidos then
  begin
    if FunProdutos.ExisteAcessorioDuplicado(VprDProduto) then
    begin
      aviso('ACESSÓRIO DUPLICADO!!!'#13'O acessório digitado já existe digitado para esse produto');
      VpaValidos:= False;
      GAcessorios.Col:= 1;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.EAcessorioRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDProAcessorio.CodAcessorio := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDProAcessorio.NomAcessorio := VpaColunas.items[1].AValorRetorno;
    GAcessorios.Cells[1,GAcessorios.ALinha] := VpaColunas.items[0].AValorRetorno;
    GAcessorios.Cells[2,GAcessorios.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDProAcessorio.CodAcessorio := 0;
    VprDProAcessorio.NomAcessorio := '';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GAcessorios.Col of
        1 : EAcessorio.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDProduto.Acessorios.Count > 0 then
    VprDProAcessorio := TRBDProdutoAcessorio(VprDProduto.Acessorios.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosNovaLinha(Sender: TObject);
begin
  VprDProAcessorio := VprDProduto.AddAcessorio;
end;

{******************************************************************************}
procedure TFNovoProdutoPro.GAcessoriosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GAcessorios.AEstadoGrade in [egInsercao,EgEdicao] then
    if GAcessorios.AColuna <> ACol then
    begin
      case GAcessorios.AColuna of
        1: if not EAcessorio.AExisteCodigo(GAcessorios.Cells[1,GAcessorios.ALinha]) then
           begin
             if not EAcessorio.AAbreLocalizacao then
             begin
               GAcessorios.Cells[1,GAcessorios.ALinha]:= '';
               GAcessorios.Col:= 1;
               Abort;
             end;
           end;
      end;
    end;
end;
end.

