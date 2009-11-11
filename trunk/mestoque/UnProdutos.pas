unit UnProdutos;
//revisado o as
//           =*
//           *=
//           edit;

interface

uses
    Db, DBTables, classes, sysUtils, painelGradiente, ConvUnidade, UnAmostra,
    UnMoedas, UnCodigoBarra, UnClassificacao, Graphics, UnDados, UnDadosProduto,
    SQLExpr, tabela;

// FUNÇÕES DAS OPERAÇÕES DE ESTOQUE
//-----------------------------------
// VE  Venda
// CO  Compra
// DV  Devolução de Venda
// DC  Devolução de Compra
// TS  Transferência Saída
// TE  Transferência Entrada
// OS  Outros Saída
// OE  Outro Entrada
//-------------------------------------


// calculos
type
  TCalculosProduto = class
  private
    calcula : TSQLQuery;
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection); virtual;
    destructor destroy; override;
    function CalculaQdadeEstoqueProduto( VpaSeqProduto,VpaCodCor,VpaCodTamanho :Integer) : Double;
    Function UnidadePadrao( SequencialProduto : Integer ) : string;
    Function MoedaPadrao( SequencialProduto : Integer ) : Integer;
    function ValorDeVenda( SequencialProduto, CodigoTabela,VpaCodTamanho : Integer ) : double;
    function PercMaxDesconto( SequencialProduto, CodigoTabela : Integer ) : double;
    function CalculaEstoqueProduto( SequencialProduto : Integer; CodigoEmpFil : Integer ) : integer;
    function MascaraBarra( codBarra : Integer ) : string;
end;

// localizacao
Type
  TLocalizaProduto = class(TCalculosProduto)
  public
    procedure LocalizaProduto(Tabela : TDataSet; CodProduto : string);
    procedure LocalizaProdutoClassificacao(Tabela : TDataSet; CodProduto, CodClassificacaoBase : string);
    procedure LocalizaSeqProdutoClassificacao(Tabela : TDataSet; CodClassificacaoBase : string);
    procedure LocalizaSeqProdutoQdadeClassificacao(Tabela : TDataSet; CodClassificacaoBase : string);
    procedure LocalizaProdutoSequencial(Tabela : TDataSet; SequencialProduto : string);
    procedure LocalizaProdutoSequencialQdade(Tabela : TDataSet; VpaSeqProduto, VpaCodCor,VpaCodTamanho : Integer);
    procedure LocalizaMovQdadeSequencial(VpaTabela : TDataSet; VpaCodFilial, VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer);
    procedure LocalizaOperacaoEstoque(VpaTabela : TDataSet; VpaCodOperacao : integer );
    procedure LocalizaEstoque(Tabela : TDataSet; Lancamento : string);
    procedure LocalizaEstoqueProduto(Tabela : TDataSet; SeqPro : Integer);
    procedure LocalizaProdutoEmpresa(Tabela : TDataSet);
    procedure LocalizaProdutoTabelaPreco(Tabela : TDataSet;  VpaCodTabela,VpaSeqProduto,VpaCodCliente : string );
    procedure LocalizaNotaEntradaEstoque(VpaTabela : TDataSet;  VpaCodFilial,VpaSeqNota : integer );
    procedure LocalizaNotaSaidaEstoque(Tabela : TDataSet;  VpaCodFilial, VpaSeqNota : integer );
    procedure LocalizaCadTabelaPreco(Tabela : TDataSet;  CodTabela : Integer);
end;

// funcoes
type
  TFuncoesProduto = class(TLocalizaProduto)
  private
      AUX,
      Tabela,
      Tabela2,
      ProProduto : TSQLQUERY;
      ProCadastro,
      ProCadastro2 : TSQL;
      DataBase : TSQLCONNECTION;
      FunAmostra: TRBFuncoesAmostra;
    function RSeqEtiquetadoDisponivel(VpaCodFilial,VpaLanOrcamento : Integer) : Integer;
    function RSeqLogFracaoOpConsumo(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaSeqConsumo : Integer):Integer;
    function REtiquetaPedido(VpaDEtiquetaOriginal : TRBDEtiquetaProduto;VpaNumPedido, VpaQtdEtiquetado : Integer):TRBDEtiquetaProduto;
    function RSeqConsumoFracaoOpDisponivel(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao : Integer):Integer;
    function RSeqDefeitoDisponivel : Integer;
    function RSeqBarraDisponivel(VpaSeqProduto : Integer):Integer;
    function RSeqReservaExcessoDisponivel : Integer;
    function RSeqReservaProdutoDisponivel : Integer;
    function RDBaixaConsumoOp(VpaBaixas : TList;VpaSeqProduto,VpaCodCor : Integer; VpaIndMaterialExtra : Boolean):TRBDConsumoFracaoOP;
    function RCodProdutoDisponivelpelaClassificacao(VpaCodClassificacao : String):String;
    function RQtdMetrosBarraProduto(VpaSeqProduto : Integer):Double;
    function RPrecoVendaeCustoProduto(VpaDProduto : TRBDProduto;VpaCodCor,VpaCodTamanho : Integer):TList;
    procedure CKitsProdutos(VpaSeqProduto : String; VpaSeqKit : TStringList);
    procedure CarDOperacaoEstoque(VpaDOperacao : TRBDOperacaoEstoque;VpaCodOperacao: Integer);
    procedure CarDBaixaOPConsumoProduto(VpaCodFilial, VpaSeqOrdem : Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList);
    procedure CarConsumoProdutoBastidor(VpaSeqProduto : Integer; VpaDConsumo :TRBDConsumoMP);
    procedure CarQtdMinimaProduto(VpaCodFilial, VpaSeqProduto, VpaCor, VpaCodTamanho : Integer; var VpaQtdMinima, VpaQtdPedido, VpaValCusto : Double); overload;
    procedure CarQtdMinimaProduto(VpaCodFilial, VpaCor: Integer; VpaDProduto: TRBDProduto); overload;
    function GravaDBaixaConsumoFracaoLog(VpaDBaixa : TRBDConsumoFracaoOP; VpaCodUsuario : Integer): String;
    function GravaDBaixaConsumoFracaoProduto1(VpaCodigoFilial, VpaSeqOrdem,VpaSeqFracao, VpaCodUsuario: Integer; VpaBaixas: TList): String;
    function GravaDBaixaConsumoOPProduto(VpaCodigoFilial, VpaSeqOrdem, VpaCodUsuario : Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList): String;
    function GravaDConsumoMPBastidor(VpaDProduto : TRBDProduto;VpaCorKit : Integer) : String;
    procedure ExcluiMovimentoEstoquePorData(VpaDatInicial, VpaDatFinal : TDateTime);
    function ReprocessaEstoqueCotacao(VpaDatInicial, VpaDatFinal : TDateTime) : String;
    function ReprocessaEstoqueCompras(VpaDatInicial, VpaDatFinal : TDateTime) : String;
    function AdicionaConsumoExtraFracaoOP(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):string;
    procedure CopiaDEtiqueta(VpaDEtiquetaOrigem, VpaDEtiquetaDestino : TRBDEtiquetaProduto);
    procedure SincronizarConsumoAmostraProduto(VpaDProduto: TRBDProduto; VpaConsumosAmostra: TList);
    procedure ImportaEstoqueProdutAExcluir(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
    procedure ImportaProdutofornecedor(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
    procedure ImportaEstoqueTecnico(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
    function BaixaSubmontagemFracao(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;Var VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):Boolean;
    function GeraCodigoBarrasEAN13 : string;
    procedure OrdenaTabelaPrecoProduto(VpaDProduto : TRBDProduto);
  public
    ConvUnidade : TConvUnidade;
    ValidaUnidade : TValidaUnidade;
    UnMoeda : TFuncoesMoedas;
    UnCla : TFuncoesClassificacao;
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); override;
    destructor Destroy; override;
    function RSeqProdutoDisponivel: Integer;
    function OperacoesEstornoValidas : String;
    function ProximoCodigoProduto( CodClassificacao : String; tamanhoPicture : Integer ) : string;
    procedure EstornaProximoCodigoProduto;
    function ProdutoExistente(CodigoPro, CodClassificacao : string) : Boolean;
    function VerificaMascaraClaPro : Boolean;
    function CalculaQdadePadrao( unidadeAtual, UnidadePadrao : string; QdadeVendida : double; SequencialProduto : string) : Double;
    function CalculaValorPadrao( unidadeAtual, UnidadePadrao : string; ValorTotal : double; SequencialProduto : string) : Double;
    function CalculaQtdPecasemMetro(Var VpaIndice : Double;VpaAltProduto,VpaCodFaca,VpaCodMaquina,VpaCodBastidor,VpaQtdPcBastidor : Integer;VpaAltMolde,VpaLarMolde : Double) : Integer;
    function ValorPelaUnidade(VpaUnidadeDe,VpaUnidadePara : String;VpaSeqProduto : Integer; VpaValorUnitario : Double):Double;
    function TextoPossuiEstoque( QdadeVendidade, QdadeEstoque : double; UnidadePadrao : string ) : Boolean;
    function VerificaEstoque( unidadeAtual, UnidadePadrao : string; QdadeVendida : double; VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer) : Boolean;
    procedure TextoQdadeMinimaPedido(QdadeMin, QdadePed, QdadeBaixa : double);
    procedure VerificaPontoPedido(VpaCodFilial, VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer; VpaQtdBaixar : Double );
    function BaixaProdutoEstoque(VpaDProduto : TRBDProduto;VpaCodFilial, VpaCodOperacao,VpaSeqNotaF, VpaNroNota,VpaLanOrcamento, VpaCodigoMoeda, VpaCodCor,VpaCodTamanho : Integer;
                                  VpaDataMov : TdateTime; VpaQdadeVendida, VpaValorTotal : Double;
                                  VpaunidadeAtual, VpaNumSerie : string; VpaNotaFornecedor : Boolean;Var VpaSeqBarra : Integer;VpaGerarMovimentoEstoque : Boolean = true;VpaCodTecnico : Integer = 0;VpaSeqOrdemProducao : Integer = 0) : Boolean;overload;
    function BaixaEstoqueFiscal(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaUnidadeAtual,vpaUnidadePadrao,VpaTipoOperacao : String) : String;
    function BaixaEstoqueTecnicoouConsumoFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqProduto,VpaCodCor,VpaCodTecnico,VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaTipOperacao,VpaDesUM : String) : string;
    function BaixaEstoqueTecnico(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTecnico,VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaTipOperacao : String) : string;
    function BaixaEstoqueDefeito(VpaSeqProduto,VpaCodTecnico : Integer;VpaQtdProduto : Double;VpaDesUM, VpaDesOperacaoEstoque, VpaDesDefeito : string):string;
    function BaixaEstoqueBarra(VpaSeqProduto,VpaCodCor,VpaSeqBarra : Integer;VpaQtdProduto : Double;VpaDesUM, VpaDesUMOriginal, VpaDesOperacaoEstoque : string):string;
    function BaixaConsumoFracaoOP(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):string;
    function BaixaQtdAReservarProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho: Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao :String):string;
    function ReservaEstoqueProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao: Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao :String):string;
    function BaixaQtdReservadoOP(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao: Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao,  VpaTipOperacao :String):string;
    function AtualizaQtdKit(VpaSeqProduto : String;VpaKit : Boolean):Boolean;
    function EstornaEstoque(VpaDMovimento : TRBDMovEstoque) : String;
    function AdicionaProdutoNaTabelaPreco(VpaCodTabela: Integer; VpaDProduto: TRBDProduto;VpaCodTamanho, VpaCodCor : Integer): String;
    function VerificaItemKit( codigoPro : string ) : Boolean;
    procedure ConverteMoedaTabela( NovaMoeda, TabelaPreco, SequencialProduto : Integer );
    procedure ConverteMoedaProduto( NovaMoeda, TabelaPreco, SequencialProduto : Integer );
    procedure AlteraAtividadeProduto( SequencialProduto : integer);
    function AlteraClassificacaoProduto(VpaSeqProduto : Integer;VpaNovaClassificacao : String) : String;
    function AlteraValorVendaProduto(VpaSeqProduto, VpaCodTamanho : Integer;VpaNovoValor :Double):String;
    procedure OrganizaTabelaPreco(VpaCodTabela, VpaCodCliente : integer; VpaSomenteAtividade : Boolean );
    procedure AtualizaValorKit( SeqProdutoKit, CodTabelaPreco : integer );
    procedure InseriProdutoClassificacaoFilial(Vpa_SeqPro_CodCla, VpaFilial, VpaEmpresa: string; NQtdMin, NQtdPed, VpaValCusto: Double; Classificacao : Boolean);
    procedure InsereProdutoFilial(VpaSeqProduto, VpaCodFilial, VpaCodCor, VpaCodTamanho: Integer; VpaQtdEstoque, VpaQtdMinima, VpaQtdPedido, VpaValCusto, VpaValCompra: Double); overload;
    function InsereProdutoFilial(VpaCodFilial,VpaCodCor, VpaCodTamanho : Integer; VpaDProduto: TRBDProduto): String; overload;
    procedure AdicionaProdutosFilialAtiva;
    procedure AdicionaProdutoEtiquetado(VpaEtiquetas : TList);
    function InsereProdutoEmpresa(VpaCodEmpresa: Integer; VpaDProduto: TRBDProduto;VpaProdutoNovo : Boolean): String;overload;
    function InsereProdutoEmpresa(VpaCodEmpresa: Integer; VpaSeqProduto : Integer): String;overload;
    procedure InserePrecoProdutoCliente(VpaSeqProduto, VpaCodTabela, VpaCodCliente, VpaCodTamanho : Integer);
    function ExisteProduto(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;overload;
    function ExisteProduto(VpaCodProduto : String;var VpaSeqProduto : Integer;var VpaNomProduto, VpaUM : String):boolean;overload;
    function ExisteProduto(VpaSeqProduto : Integer;Var VpaCodProduto, VpaNomProduto : String):Boolean;overload;
    function ExisteProduto(VpaCodProduto: String; VpaDProAmostra: TRBDConsumoAmostra): Boolean; overload;
    function ExisteProduto(VpaCodProduto: String): Boolean; overload;
    function ExisteProduto(VpaCodProduto : String;VpaDProdutoPedido: TRBDProdutoPedidoCompra): Boolean; overload;
    function ExisteProduto(VpaCodProduto: String; VpaDOrcamentoItem: TRBDSolicitacaoCompraItem): Boolean; overload;
    function ExisteProduto(VpaCodProduto: String; VpaDOrcamentoItem: TRBDOrcamentoCompraProduto): Boolean; overload;
    function ExisteProduto(VpaCodProduto : string; VpaDProdutoOrcado : TRBDChamadoProdutoOrcado):Boolean;overload;
    function ExisteEntretela(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
    function ExisteTermoColante(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
    function ExisteCodigoProduto(Var VpaSeqProduto : Integer; Var VpaCodProduto, VpaNomProduto : String) : Boolean;
    function ExisteCodigoProdutoDuplicado(VpaSeqProduto : Integer;VpaCodProduto : String):Boolean;
    function ExisteNomeProduto(Var VpaSeqProduto : Integer;VpaNomProduto : string):Boolean;
    function ExisteCombinacao(VpaSeqProduto, VpaCodCombinacao : Integer):Boolean;
    function ExisteCor(VpaCodCor : String) : Boolean;overload;
    function ExisteCor(VpaCodCor : String;VpaDConcumoMP : TRBDConsumoMP) : Boolean;overload;
    function Existecor(VpaCodCor : String;var VpaNomCor : String):Boolean;overload;
    function ExisteEstagio(VpaCodEstagio : String;Var VpaNomEstagio :string):Boolean;
    function ExisteEstoqueCor(VpaSeqProduto, VpaCodCor : Integer):String;
    function ExisteProdutosDevolvidos(VpaCodCliente : String):Boolean;
    function ExisteDonoProduto(VpaCodDono : Integer):Boolean;
    function ExisteFaca(VpaCodFaca : Integer; VpaDFaca : TRBDFaca):Boolean;
    function ExisteMaquina(VpaCodMaquina : Integer;VpaDMaquina : TRBDMaquina):Boolean;
    function ExisteConsumo(VpaSeqProduto : Integer) : Boolean;
    function ExisteConsumoProdutoCor(VpaSeqProduto, VpaCodCor : Integer):Boolean;
    function ExisteBastidor(VpaCodBastidor : Integer;VpaDBastidor : TRBDBastidor):boolean;overload;
    function ExisteBastidor(VpaCodBastidor : String;Var VpaNomBastidor : String):boolean;overload;
    function ExisteBastidorDuplicado(VpaDConsumo : TRBDConsumoMP):boolean;
    function ExisteAcessorioDuplicado(VpaDProduto : TRBDProduto) : Boolean;
    function ExisteTabelaPrecoDuplicado(VpaDProduto : TRBDProduto) : Boolean;
    function ValidaAlterarValorUnitario( CorForm, CorCaixa : TColor ) : boolean;
    function ValidaDesconto( ValorProdutos,  Desconto : double; percentual : Boolean; CorForm, CorCaixa : TColor ) : boolean;
    procedure ColocaProdutoEmAtividade(VpaSequencial : String);
    procedure TiraProdutoAtividade(VpaSequencial : String);
    function CQtdValorCusto(VpaCodFilial, VpaSeqProduto, VpaCodCor : Integer; Var VpaQtdProduto, VpaValCusto : Double):Boolean;
    function RFreteRateado(VpaQtdComprado,VpaVlrCompra, VpaTotCompra, VpaTotFrete : Double) : Double;
    function RDescontoRateado(VpaQtdComprado,VpaVlrCompra, VpaTotCompra, VpaValDesconto : Double) : Double;
    function RFuncaoOperacaoEstoque(VpaCodOperacao : String):String;
    function RIcmsEstado(VpaEstado:String):Double;
    function RValorCusto(VpaCodEmpFil, VpaSeqProduto : String):Double;
    function RNomeFundo(VpaCodFundo : String):String;
    function RNomeTipoEmenda(VpaCodEmenda : String):String;
    function RNomeCor(VpaCodCor : String): String;
    function RNomeTamanho(VpaCodTamanho : Integer) : string;
    function RNomeTipoCorte(VpaCodTipoCorte : Integer) : String;
    function RNomeEmbalagem(VpaCodEmbalagem : Integer) : String;
    function RNomAcondicionamento(VpaCodAcondicionamento : Integer) : string;
    function RNomTabelaPreco(VpaCodTabelaPreco : Integer) : String;
    function RQtdPecaemMetro(VpaAltProduto, VpaLarProduto, VpaQtdProvas : Integer;VpaAltMolde, VpaLarMolde : double;VpaIndAltFixa : Boolean; Var VpaIndice : double):Integer;
    function RCodBarrasEAN13Disponivel : String;
    function PrincipioAtivoControlado(VpaCodPrincipio : Integer) : boolean;
    procedure AtualizaValorCusto(VpaSeqProduto,VpaCodFilial, VpaCodMoeda : Integer; VpaUniPadrao, VpaUniProduto,VpaFuncaoOperacao : String;VpaCodCor,VpaCodTamanho : Integer;VpaQtdProduto, VpaVlrCompra,VpaTotCompra,VpaVlrFrete,VpaPerIcms, VpaPerIPI, VpaValDescontoNota: Double;VpaIndFreteEmitente : Boolean);
    function AtualizaCodEan(VpaSeqProduto,VpaCodCor : Integer;VpaCodBarras : String):String;
    function AtualizaValorVendaAutomatico(VpaSeqProduto : Integer;VpaValCusto : Double):string;
    function AtualizaEmbalagem(VpaSeqProduto,VpaCodEmbalagem : Integer):string;
    function AtualizaComposicao(VpaSeqProduto,VpaCodComposicao : Integer):string;
    procedure CarDMovimentoEstoque(VpaTabela : TDataSet;VpaDMovimento : TRBDMovEstoque);
    procedure CarDProduto(VpaDProduto: TRBDProduto; VpaCodEmpresa: Integer = 0; VpaCodFilial: Integer = 0; VpaSeqProduto: Integer = 0);
    procedure CarCodNomProduto(VpaSeqproduto : Integer;var VpaCodProduto,VpaNomProduto : string);
    procedure CarProdutoFaturadosnoMes(VpaDatInicio, VpaDatFim : TDateTime;VpaFilial : Integer);
    procedure CarDCombinacao(VpaDProduto : TRBDProduto);
    procedure CarDEstagio(VpaDProduto : TRBDProduto);
    procedure CarDFornecedores(VpaDProduto : TRBDProduto);
    procedure CarDEstoque1(VpaDProduto: TRBDProduto; VpaCodFilial, VpaSeqProduto: Integer;VpaCodCor : Integer = 0;VpaCodTamanho : Integer = 0);
    procedure CarDPreco(VpaDProduto: TRBDProduto; VpaCodEmpresa, VpaSeqProduto: Integer);
    procedure CarDValCusto(VpaDProduto: TRBDProduto; VpaCodFilial : Integer);
    procedure CarDProdutoFornecedor(VpaCodFornecedor: Integer;VpaDProtudoPedido: TRBDProdutoPedidoCompra);
    procedure CarFigurasGRF(VpaCodComposicao : Integer;VpaFiguras : TList);
    procedure CarConsumoProduto(VpaDProduto : TRBDProduto;VpaCorKit : Integer);
    procedure ApagaSubMontagensdaListaConsumo(VpaDProduto : TRBDProduto);
    procedure CarProdutoImpressoras(VpaSeqProduto : Integer;VpaImpresoras : TList);
    procedure CarAcessoriosProduto(VpaDProduto : TRBDProduto);
    procedure CarDBaixaConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList);
    procedure CarDBaixaFracaoConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList;VpaCarregarSubMontagem, VpaConsumoAExcluir : Boolean);
    procedure CarPerComissoesProduto(VpaSeqProduto,VpaCodVendedor : Integer;Var VpaPerComissaoProduto : Double;Var VpaPerComissaoClassificacao : Double;var VpaPerComissaoVendedor : Double);
    procedure CarValVendaeRevendaProduto(VpaCodTabelaPreco, VpaSeqProduto, VpaCodCor, VpaCodTamanho, VpaCodCliente : Integer;Var VpaValVenda : Double;Var VpaValRevenda : Double);
    function RMoedaProduto(VpaCodEmpresa, VpaSeqProduto : String) : integer;
    function RCombinacao(VpaDProduto : TRBDProduto;VpaCodCombinacao : Integer):TRBDCombinacao;
    function RSeqReferenciaDisponivel(VpaSeqProduto, VpaCodCliente : Integer): Integer;
    function RReferenciaProduto(VpaSeqProduto,VpaCodCliente : Integer; VpaCodCor : String):String;
    function CarProdutodaReferencia(VpaDesReferencia : String;VpaCodCliente : Integer;Var VpaCodProduto : String; Var VpaCodCor : Integer) : Boolean;
    function RDesMMProduto(var VpaNomProduto : String) :String;
    function RComprimentoProduto(VpaSeqProduto : Integer):Integer;
    function REstagioProduto(VpaDProduto : TRBDProduto;VpaSeqEstagio : Integer):TRBDEstagioProduto;
    function RNomePrincipioAtivo(VpaCodPrincipio : Integer) : String;
    function RNomeProduto(VpaSeqProduto : Integer) : String;
    function RNomeClassificacao(VpaCodEmpresa : Integer;VpaCodClasssificacao : String):string;
    function RNomeComposicao(VpaCodComposicao : Integer):string;
    function RAlturaProduto(VpaSeqProduto : Integer) : Integer;
    procedure CarUnidadesVenda(VpaUnidades: TStrings);
    function RUnidadesParentes(VpaUM : String):TStringList;
    function RSeqCartuchoDisponivel : Integer;
    function RQtdIdealEstoque(VpaCodFilial, VpaSeqProduto, VpaCodCor : Integer): Double;
    function RQtdMetrosFita(VpaCodProduto,VpaNomProduto, VpaCodUM : string;VpaQtdProduto,VpaComprimentoProduto : Double; Var VpfErro : string):Double;
    function RTabelaPreco(VpaDProduto : TRBDProduto;VpaCodTabela,VpaCodCliente,VpaCodTamanho,VpaCodMoeda : Integer): TRBDProdutoTabelaPreco;
    function CombinacaoDuplicada(VpaDProduto : TRBDProduto):Boolean;
    function FiguraGRFDuplicada(VpaFiguras : TList) : Boolean;
    procedure ExcluiCombinacoes(VpaSeqProduto : String);
    function ExcluiProdutoTabelaPreco(VpaCodtabela,VpaSeqProduto,VpaCodCliente : Integer):Boolean;
    procedure ExcluiMovimentoEstoque(VpaCodFilial,VpaLanEstoque,VpaSeqProduto : Integer);
    procedure ExcluiMovimentoEstoqueCotacao(VpaCodFilial,VpaSeqProduto,VpaLanOrcamento, VpaCodCor : Integer);
    procedure ExcluiProdutoDuplicado(VpaSeqProdutoExcluir, VpaSeqProdutoDestino : Integer;VpaLog : TStrings);
    procedure ExcluiComposicaoFiguraGRF(VpaCodComposicao : Integer);
    function GravaDProduto(VpaDProduto: TRBDProduto): String;
    function GravaDCombinacao(VpaDProduto: TRBDProduto):String;
    function GravaDMovimentoEstoque(VpaDMovimento : TRBDMovEstoque): String;
    function GravaDConsumoMP(VpaDProduto : TRBDProduto;VpaCorKit : Integer) : String;
    function GravaDEstagio(VpaDProduto : TRBDProduto) : String;
    function GravaDFornecedor(VpaDProduto: TRBDProduto): String;
    function GravaDAcessorio(VpaDProduto : TRBDProduto):string;
    function GravaDTabelaPreco(VpaDProduto : TRBDProduto):string;
    function GravaProdutoImpressoras(VpaSeqProduto : Integer; VpaImpressoras : TList):string;
    function GravaPesoCartucho(VpaDPesoCartucho : TRBDPesoCartucho;VpaDProduto : TRBDProduto):string;
    function GravaBaixaConsumoProduto1(VpaCodigoFilial, VpaSeqOrdem, VpaSeqFracao, VpaCodUsuario : Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList): String;
    function GravaFigurasGRF(VpaCodComposicao : Integer;VpaFiguras : TList) : string;
    function GravaProdutoReservadoEmExcesso(VpaSeqProduto, VpaCodFilial,VpaSeqOrdem : Integer;VpaDesUM : String;VpaQtdEstoque, VpaQtdReservado, VpaQtdExcesso : Double):String;
    function GravaMovimentoProdutoReservado(VpaSeqProduto, VpaCodFilial,VpaSeqOrdem : Integer;VpaDesUM : String; VpaQtdReservado,VpaQtdInicial,VpaQtdAtual: Double;VpaTipMovimento : String):String;
    function ReferenciaProdutoDuplicada(VpaCodCliente,VpaSeqProduto, VpaSeqReferencia,VpaCodCor : Integer):Boolean;
    function ReprocessaEstoque(VpaMes, VpaAno : Integer): String;
    procedure ReAbrirMes(VpaData : TDateTime);
    procedure ReorganizaSeqEstagio(VpaDProduto : TRBDProduto);
    function CorReferenciaDuplicada(VpaDProduto : TRBDProduto):Boolean;
    function ConcluiDesenho(VpaSeqProduto, VpaCodCor, VpaSeqMovimento : Integer) : string;
    function ConcluiFichaTecnica(VpaCodFilial,VpaLanOrcamento, VpaSeqItem : Integer):string;
    procedure PreparaImpressaoEtiqueta(VpaEtiquetas : TList;VpaPosInicial : Integer);
    function CalculaNumeroSerie(VpaNumSerie : Integer) :string;
    function GeraCodigosBArras : String;
    procedure ConverteNomesProdutosSemAcento;
    procedure AdicionaTodasTabelasdePreco(VpaDProduto : TRBDProduto);
 end;
Var
  FunProdutos : TFuncoesProduto;

implementation

uses constMsg, constantes, funSql, funstring, fundata, funnumeros, FunObjeto, UnOrdemProducao,
     FunValida, unContasAreceber ;


{#############################################################################
                        TCalculo Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TCalculosProduto.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  calcula := TSQLQuery.Create(aowner);
  calcula.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosProduto.destroy;
begin
  calcula.Destroy;
  inherited;
end;

{******************************************************************************}
function TCalculosProduto.CalculaQdadeEstoqueProduto(VpaSeqProduto,VpaCodCor,VpaCodTamanho :Integer ) : Double;
begin
  result := 0;
  if VpaSeqProduto <> 0 then
  begin
    AdicionaSQLAbreTabela(calcula, ' select N_QTD_PRO from MOVQDADEPRODUTO ' +
                                   ' where I_SEQ_PRO = ' + IntToStr(VpaSeqProduto) +
                                   ' and I_COD_COR = '+IntToStr(VpaCodCor)+
                                   ' AND I_COD_TAM = '+IntToStr(VpaCodTamanho)+
                                   ' and I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil));
    result := calcula.fieldByName('N_QTD_PRO').AsFloat;
    FechaTabela(calcula);
  end;
end;


{******************************************************************************}
Function TCalculosProduto.UnidadePadrao( SequencialProduto : Integer ) : string;
begin
  AdicionaSQLAbreTabela(calcula, ' Select C_COD_UNI from CadProdutos where ' +
                                ' i_seq_pro = ' + IntToStr(SequencialProduto) );
  result := calcula.fieldByName('C_COD_UNI').AsString;
  FechaTabela(calcula);
end;

{****************** retorna a moeda padrao do produto *************************}
Function TCalculosProduto.MoedaPadrao( SequencialProduto : Integer ) : Integer;
begin
  AdicionaSQLAbreTabela(calcula, ' Select I_COD_MOE from CadProdutos where ' +
                                ' i_seq_pro = ' + IntToStr(SequencialProduto) );
  result := calcula.fieldByName('I_COD_MOE').AsInteger;
  calcula.Close;
end;

{******************************************************************************}
function TCalculosProduto.ValorDeVenda( SequencialProduto, CodigoTabela,VpaCodTamanho : Integer ) : double;
begin
  AdicionaSQLAbreTabela(calcula, ' Select N_VLR_VEN from MovTabelaPreco where ' +
                                ' i_seq_pro = ' + IntToStr(SequencialProduto) +
                                ' and i_cod_tab = ' + IntToStr(CodigoTabela) +
                                ' and I_COD_CLI = 0 '+
                                ' AND I_COD_TAM = '+IntToStr(VpaCodTamanho));
  result := calcula.fieldByName('n_vlr_ven').AsCurrency;
  FechaTabela(calcula);
end;

function TCalculosProduto.PercMaxDesconto( SequencialProduto, CodigoTabela : Integer ) : double;
begin
  AdicionaSQLAbreTabela(calcula, ' Select N_PER_MAX from MovTabelaPreco where ' +
                                ' i_seq_pro = ' + IntToStr(SequencialProduto) +
                                ' and i_cod_tab = ' + IntToStr(CodigoTabela)+
                                ' and I_COD_CLI = 0');
  result := calcula.fieldByName('n_per_max').AsCurrency;
  FechaTabela(calcula);
end;

function TCalculosProduto.CalculaEstoqueProduto( SequencialProduto : Integer; CodigoEmpFil : Integer ) : integer;
var
  MenorValor : double;
begin
  LimpaSQLTabela(calcula);
  AdicionaSQLTabela(calcula, ' select  sum(mov.n_qtd_pro) / max( kit.n_qtd_pro)  valor ' +
                             ' from MovQdadeProduto mov, Movkit Kit ' +
                             ' where  kit.i_pro_kit = ' + IntTostr(SequencialProduto) +
                             ' and '+SQLTextoRightJoin('mov.i_seq_pro', 'kit.i_seq_pro ') );

  if CodigoEmpFil > 10 then
    AdicionaSQLTabela(calcula,' and mov.i_emp_fil = ' + IntToStr(CodigoEmpFil) );

  AdicionaSQLTabela(calcula,' group by kit.i_seq_pro ');
  AbreTabela(calcula);

  MenorValor := calcula.fieldByname('valor').AsCurrency;
  while not Calcula.Eof do
  begin
    if MenorValor > calcula.fieldByname('valor').AsCurrency then
      MenorValor := calcula.fieldByname('valor').AsCurrency;
    calcula.Next;
  end;
  result := Trunc(MenorValor);
  if result < 0 then
    result := 0;
end;

function TCalculosProduto.MascaraBarra( codBarra : Integer ) : string;
begin
  AdicionaSQLAbreTabela(calcula, 'select c_cod_bar from cad_codigo_barra where i_cod_bar = ' +
                                 IntTostr(codBarra) );
  result := calcula.fieldByName('c_cod_bar').AsString;
end;

{#############################################################################
                        TLocaliza Produtos
#############################################################################  }

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProduto(Tabela : TDataSet; CodProduto : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where C_Cod_Pro = ''' + CodProduto + ''''+
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoClassificacao(Tabela : TDataSet; CodProduto, CodClassificacaoBase : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where C_Cod_Pro = ''' + CodProduto + ''''+
                               ' and C_Cod_Cla = ''' + CodClassificacaoBase + '''' +
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaSeqProdutoClassificacao(Tabela : TDataSet; CodClassificacaoBase : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where C_Cod_Cla = ''' + CodClassificacaoBase + '''' +
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa));
end;


{******************************************************************************}
procedure TLocalizaProduto.LocalizaSeqProdutoQdadeClassificacao(Tabela : TDataSet; CodClassificacaoBase : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos pro, ' +
                                ' MovQdadeProduto mov ' +
                                ' Where C_Cod_Cla like ''' + CodClassificacaoBase + '%''' +
                                ' and pro.I_seq_pro = mov.I_seq_pro ' +
                                ' and Mov.I_Emp_Fil = ' + IntToStr(varia.CodigoEmpFil) );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoSequencial(Tabela : TDataSet; SequencialProduto : string);
begin
  AdicionaSQLAbreTabela(tabela, ' Select * from CADPRODUTOS ' +
                                ' Where I_SEQ_PRO = ' + SequencialProduto );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoSequencialQdade(Tabela : TDataSet; VpaSeqProduto, VpaCodCor,VpaCodTamanho : Integer);
begin
  AdicionaSQLAbreTabela(tabela, ' Select * ' +
                                ' From cadprodutos pro, ' +
                                ' MovQdadeProduto mov ' +
                                ' Where pro.i_seq_pro = ' +IntToStr(VpaSeqProduto) +
                                ' and pro.I_seq_pro = mov.I_seq_pro ' +
                                ' and Mov.I_Emp_Fil = ' + IntToStr(varia.CodigoEmpFil) +
                                ' and MOV.I_COD_COR = '+ IntToStr(VpaCodCor)+
                                ' and MOV.I_COD_TAM = '+IntToStr(VpaCodTamanho));
end;


{******************************************************************************}
procedure TLocalizaProduto.LocalizaMovQdadeSequencial(VpaTabela : TDataSet; VpaCodFilial, VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer);
begin
  if config.EstoqueCentralizado then
    VpaCodFilial := Varia.CodFilialControladoraEstoque;
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVQDADEPRODUTO'+
                               ' where I_EMP_FIL = ' + InttoStr(VpaCodFilial) +
                                ' and I_SEQ_PRO = ' + InttoStr(VpaSeqProduto) +
                                ' and I_COD_COR = '+ InttoStr(VpaCodCor)+
                                ' and I_COD_TAM = '+IntToStr(VpaCodTamanho));
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaOperacaoEstoque(VpaTabela : TDataSet; VpaCodOperacao : integer );
begin
  AdicionaSQLAbreTabela(VpaTabela, ' Select * from CADOPERACAOESTOQUE ' +
                                ' Where I_COD_OPE = ' + IntToStr(VpaCodOperacao) );
end;


procedure TLocalizaProduto.LocalizaEstoque(Tabela : TDataSet; Lancamento : string);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MovEstoqueProdutos where I_emp_fil = ' +
                                intToStr(Varia.CodigoEmpFil)  +
                                ' and i_lan_est = ' + lancamento );
end;

procedure TLocalizaProduto.LocalizaEstoqueProduto(Tabela : TDataSet; SeqPro : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MovEstoqueProdutos where I_emp_fil = ' +
                                intToStr(Varia.CodigoEmpFil)  +
                                ' and i_seq_pro = ' + IntToStr(SeqPro) );
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoEmpresa(Tabela : TDataSet );
begin
  AdicionaSQLAbreTabela(Tabela, ' SELECT * FROM CADPRODUTOS ' +
                                ' WHERE I_COD_EMP =  ' + IntTostr(varia.CodigoEmpresa));
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaProdutoTabelaPreco(Tabela : TDataSet;  VpaCodTabela,VpaSeqProduto,VpaCodCliente : string );
begin
  AdicionaSQLAbreTabela(Tabela, ' SELECT * FROM MovTabelaPreco' +
                                ' WHERE i_cod_emp =  ' + IntTostr(varia.CodigoEmpresa) +
                                ' and i_cod_tab = ' + VpaCodTabela +
                                ' and i_seq_pro = ' + VpaSeqProduto +
                                ' and I_COD_CLI = ' + VpaCodCliente);
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaNotaEntradaEstoque(VpaTabela : TDataSet; VpaCodFilial,VpaSeqNota : integer );
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVESTOQUEPRODUTOS ' +
                        ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial) +
                        ' and I_NOT_ENT = ' + IntToStr(VpaSeqNota))
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaNotaSaidaEstoque(Tabela : TDataSet; VpaCodFilial, VpaSeqNota : integer );
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from MOVESTOQUEPRODUTOS Where ' +
                        ' I_EMP_FIL = '+ IntToStr(VpaCodFilial) +
                        ' and I_NOT_SAI = ' + IntToStr(VpaSeqNota))
end;

{******************************************************************************}
procedure TLocalizaProduto.LocalizaCadTabelaPreco(Tabela : TDataSet;  CodTabela : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADTABELAPRECO ' +
                        ' Where I_COD_EMP = '+ IntToStr(varia.CodigoEmpresa) +
                        ' and I_COD_TAB = ' + IntToStr(CodTabela));
end;

{#############################################################################
                        TFuncoes Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesProduto.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  UnMoeda := TFuncoesMoedas.criar(aowner,VpaBaseDados);
  UnCla := TFuncoesClassificacao.criar(aowner,VpaBaseDados);
  DataBase := VpaBaseDados;
  Tabela := TSQLQuery.Create(aowner);
  Tabela.SQLConnection := vpaBaseDados;
  Tabela2 := TSQLQuery.Create(aowner);
  Tabela2.SQLConnection := vpaBaseDados;
  AUX := TSQLQuery.Create(aowner);
  AUX.SQLConnection := vpaBaseDados;
  ProProduto := TSQLQuery.Create(aowner);
  ProProduto.SQLConnection := vpaBaseDados;
  ProCadastro := TSQL.Create(nil);
  ProCadastro.ASQLConnection := vpaBaseDados;
  ProCadastro2 := TSQL.Create(nil);
  ProCadastro2.ASQLConnection := vpaBaseDados;
  ConvUnidade := TConvUnidade.create(nil);
  ConvUnidade.ADataBase := VpaBaseDados;
  ConvUnidade.AInfo.UniNomeTabela := 'MOVINDICECONVERSAO';
  ConvUnidade.AInfo.UniCampoDE := 'C_UNI_ATU';
  ConvUnidade.AInfo.UniCampoPARA := 'C_UNI_COV';
  ConvUnidade.AInfo.UniCampoIndice := 'N_IND_COV';
  ConvUnidade.AInfo.ProCampoIndice := 'I_IND_COV';
  ConvUnidade.AInfo.ProCampoCodigo := 'I_SEQ_PRO';
  ConvUnidade.AInfo.ProCampoFilial := 'I_COD_EMP';
  ConvUnidade.AInfo.ProNomeTabela := 'CADPRODUTOS';
  ConvUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ConvUnidade.AInfo.UnidadeUN := varia.UnidadeUN;
  ConvUnidade.AInfo.UnidadeKit := varia.UnidadeKit;
  ConvUnidade.AInfo.UnidadeBarra := varia.UnidadeBarra;

  ValidaUnidade := TValidaUnidade.create(nil);
  ValidaUnidade.ADataBase := VpaBaseDados;
  ValidaUnidade.AInfo.NomeTabelaIndice := 'MOVINDICECONVERSAO';
  ValidaUnidade.AInfo.CampoUnidadeDE := 'C_UNI_ATU';
  ValidaUnidade.AInfo.CampoUnidadePARA := 'C_UNI_COV';
  ValidaUnidade.AInfo.CampoIndice := 'N_IND_COV';
  ValidaUnidade.AInfo.UnidadeCX :=  Varia.UnidadeCX;
  ValidaUnidade.AInfo.UnidadeUN := Varia.UnidadeUN;
  ValidaUnidade.AInfo.UnidadeKit := Varia.UnidadeKit;
  ValidaUnidade.AInfo.UnidadeBarra := Varia.UnidadeBarra;

  FunAmostra:= TRBFuncoesAmostra.cria(ProCadastro.ASQLConnection);
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesProduto.Destroy;
begin
  UnMoeda.free;
  UnCla.Free;
  ConvUnidade.free;
  ValidaUnidade.free;
  FechaTabela(AUX);
  AUX.Destroy;
  FechaTabela(tabela);
  Tabela.Destroy;
  FechaTabela(tabela2);
  Tabela2.Destroy;
  ProCadastro.free;
  ProProduto.free;
  FunAmostra.Free;
  ProCadastro2.free;
  inherited;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeCor(VpaCodCor: String): String;
begin
  result := '';
  if (VpaCodCor <> '') and (VpaCodCor <> '0') then
  begin
    AdicionaSQLAbreTabela(AUX,'Select * from COR '+
                              ' Where COD_COR = '+ VpaCodCor);
    result := Aux.FieldByName('NOM_COR').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeTamanho(VpaCodTamanho : Integer) : string;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMTAMANHO FROM TAMANHO '+
                            ' Where CODTAMANHO = '+IntToStr(VpaCodTamanho));
  result := Aux.FieldByName('NOMTAMANHO').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeTipoCorte(VpaCodTipoCorte : Integer) : String;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from TIPOCORTE '+
                            ' Where CODCORTE = '+ IntToStr(VpaCodTipoCorte));
  result := Aux.FieldByName('NOMCORTE').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeEmbalagem(VpaCodEmbalagem : Integer) : String;
begin
  AdicionaSQLAbreTabela(AUX,'Select NOM_EMBALAGEM FROM EMBALAGEM '+
                            ' Where COD_EMBALAGEM = '+ IntToStr(VpaCodEmbalagem));
  result := Aux.FieldByName('NOM_EMBALAGEM').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomAcondicionamento(VpaCodAcondicionamento : Integer) : string;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMACONDICIONAMENTO FROM ACONDICIONAMENTO ' +
                            ' Where CODACONDICIONAMENTO = ' + IntToStr(VpaCodAcondicionamento));
  result := Aux.FieldByName('NOMACONDICIONAMENTO').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomTabelaPreco(VpaCodTabelaPreco : Integer) : String;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_TAB FROM CADTABELAPRECO ' +
                            ' Where I_COD_TAB = ' + IntToStr(VpaCodTabelaPreco));
  result := Aux.FieldByName('C_NOM_TAB').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqEtiquetadoDisponivel(VpaCodFilial,VpaLanOrcamento : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQETIQUETA) ULTIMO FROM PRODUTOETIQUETADOCOMPEDIDO '+
                            ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                            ' and LANORCAMENTO = '+IntToStr(VpaLanOrcamento));
  result := Aux.FieldByname('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqLogFracaoOpConsumo(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaSeqConsumo : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQLOG) ULTIMO From FRACAOOPCONSUMOLOG '+
                            ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                            ' AND SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                            ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                            ' and SEQCONSUMO = '+IntToStr(VpaSeqConsumo));
  result := AUX.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.REtiquetaPedido(VpaDEtiquetaOriginal : TRBDEtiquetaProduto;VpaNumPedido, VpaQtdEtiquetado : Integer):TRBDEtiquetaProduto;
begin
  Result := TRBDEtiquetaProduto.cria;
  CopiaDEtiqueta(VpaDEtiquetaOriginal,result);
  result.NumPedido := VpaNumPedido;

  result.IndParaEstoque := false;
  result.QtdOriginalEtiquetas := VpaQtdEtiquetado;
  result.QtdEtiquetas := result.QtdOriginalEtiquetas;
  result.QtdProduto := result.QtdOriginalEtiquetas;

  VpaDEtiquetaOriginal.QtdOriginalEtiquetas := VpaDEtiquetaOriginal.QtdOriginalEtiquetas - VpaQtdEtiquetado;
  VpaDEtiquetaOriginal.QtdEtiquetas := VpaDEtiquetaOriginal.QtdOriginalEtiquetas;
  VpaDEtiquetaOriginal.QtdProduto := VpaDEtiquetaOriginal.QtdOriginalEtiquetas;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqConsumoFracaoOpDisponivel(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao : Integer):Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQCONSUMO) ULTIMO from FRACAOOPCONSUMO '+
                            ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                            ' AND SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                            ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao));
  result := AUX.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqDefeitoDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQDEFEITO) ULTIMO from PRODUTODEFEITO ');
  Result := AUX.FieldByName('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqBarraDisponivel(VpaSeqProduto : Integer):Integer;
begin
  AdicionaSQLAbreTabela(ProCadastro2,'Select * from CADPRODUTOS '+
                                    ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
  ProCadastro2.edit;
  ProCadastro2.FieldByName('I_ULT_BAR').AsInteger := ProCadastro2.FieldByName('I_ULT_BAR').AsInteger +1;
  result := ProCadastro2.FieldByName('I_ULT_BAR').AsInteger;
  ProCadastro2.post;
  ProCadastro2.close;
end;

{******************************************************************************}
function TFuncoesProduto.RDBaixaConsumoOp(VpaBaixas : TList;VpaSeqProduto,VpaCodCor : Integer;VpaIndMaterialExtra : Boolean):TRBDConsumoFracaoOP;
var
  VpfLaco : Integer;
  VpfDBaixa : TRBDConsumoFracaoOP;
begin
  result := nil;
  for VpfLaco := 0 to VpaBaixas.Count - 1 do
  begin
    VpfDBaixa := TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if (VpfDBaixa.SeqProduto = VpaSeqProduto) and (VpfDBaixa.CodCor = VpaCodCor) and
       (VpfDBaixa.IndMaterialExtra = VpaIndMaterialExtra) then
    begin
      result := VpfDBaixa;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RCodProdutoDisponivelpelaClassificacao(VpaCodClassificacao : String):String;
var
  VpfUltimoCodigo : String;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(C_COD_PRO) ULTIMO from CADPRODUTOS '+
                            ' Where C_COD_CLA = '''+VpaCodClassificacao+'''');
  if AUX.FieldByname('ULTIMO').AsString = '' then
    Result := VpaCodClassificacao + AdicionaCharE('0','1',length(Varia.MascaraPro))
  else
  begin
    VpfUltimoCodigo := DeletaEspaco(AUX.FieldByname('ULTIMO').AsString);
    if (varia.CNPJFilial = CNPJ_PERFOR) then
    begin
      if ExisteLetraString('R',VpfUltimoCodigo) then
        VpfUltimoCodigo := CopiaAteChar(VpfUltimoCodigo,'R');
    end;

    result := AdicionaCharE('0',IntToStr(StrtoInt(VpfUltimoCodigo)+1),length(Varia.MascaraPro));
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RQtdMetrosBarraProduto(VpaSeqProduto : Integer):Double;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_IND_COV from CADPRODUTOS '+
                            ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
  result := AUX.FieldByName('I_IND_COV').AsFloat;
end;

{******************************************************************************}
function TFuncoesProduto.RPrecoVendaeCustoProduto(VpaDProduto : TRBDProduto;VpaCodCor,VpaCodTamanho : Integer):TList;
var
  vpfLaco : Integer;
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  result := TList.create;
  for vpfLaco := 0 to VpaDProduto.TabelaPreco.Count - 1 do
  begin
    VpfDTabelaPreco := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[Vpflaco]);
    if  (VpfDTabelaPreco.CodCor = VpaCodCor) and
        (VpfDTabelaPreco.CodTamanho = VpaCodTamanho) then
      Result.add(VpfDTabelaPreco);
  end;
end;

{********************* carrega os kits do produto *****************************}
function TFuncoesProduto.RCodBarrasEAN13Disponivel : String;
begin
  result := FloatToStr(varia.NumPrefixoCodEAN)+AdicionaCharE('0',FloatToSTr(Varia.NumUltimoCodigoEAN+1),2);
  result := result+DigitoVerificadEAN13(result);
  if length(Result) > 13  then
    result := 'FIM FAIXA';

  Varia.NumUltimoCodigoEAN := Varia.NumUltimoCodigoEAN+1;
  ExecutaComandoSql(AUX,'UPDATE CFG_PRODUTO SET I_ULT_EAN = '+IntToStr(Varia.NumUltimoCodigoEAN));
end;

{********************* carrega os kits do produto *****************************}
procedure TFuncoesProduto.CKitsProdutos(VpaSeqProduto : String; VpaSeqKit : TStringList);
begin
  VpaSeqKit.Clear;

  AdicionaSQLAbreTabela(ProProduto,'select I_PRO_KIT  from MOVKIT '+
                                   ' WHERE I_SEQ_PRO = ' + VpaSeqProduto+
                                   ' AND I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa));
  ProProduto.First;
  While not ProProduto.Eof do
  begin
    VpaSeqKit.Add(ProProduto.FieldByName('I_PRO_KIT').AsString);
    ProProduto.next;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDBaixaFracaoConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer; VpaIndConsumoOrdemCorte : Boolean;  VpaBaixas: TList;VpaCarregarSubMontagem,VpaConsumoAExcluir : Boolean);
var
  VpfDBaixaConsumo: TRBDConsumoFracaoOP;
  VpfTabela : TSQLQUERY;
begin
  Tabela.sql.clear;
  Tabela.sql.add('SELECT FOC.SEQCONSUMO, FOC.QTDPRODUTO, FOC.QTDBAIXADO, FOC.QTDUNITARIO, '+
                               ' FOC.SEQPRODUTO, FOC.DESUMUNITARIO,FOC.DESOBSERVACAO, FOC.INDMATERIALEXTRA,  '+
                               ' FOC.INDEXCLUIR, '+
                               ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL,'+
                               ' FOC.CODCOR, COR.NOM_COR,'+
                               ' FOC.DESUM, FOC.INDBAIXADO, FOC.CODFACA, FOC.QTDRESERVADAESTOQUE, '+
                               ' FOC.INDORIGEMCORTE, FOC.QTDARESERVAR,  '+
                               ' FAC.NOMFACA '+
                               ' FROM FRACAOOPCONSUMO FOC, COR, CADPRODUTOS PRO, FACA FAC'+
                               ' WHERE FOC.CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND FOC.SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                               ' AND FOC.SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                               ' AND '+SQLTextoRightJoin('FOC.CODCOR','COR.COD_COR')+
                               ' AND '+SQLTextoRightJoin('FOC.CODFACA','FAC.CODFACA')+
                               ' AND PRO.I_SEQ_PRO = FOC.SEQPRODUTO');
  if VpaIndConsumoOrdemCorte then
    Tabela.sql.add(' AND FOC.INDORDEMCORTE = ''S''')
  else
    Tabela.sql.add(' AND FOC.INDORDEMCORTE = ''N''');
  if VpaConsumoAExcluir then
    Tabela.sql.add(' AND FOC.INDEXCLUIR = ''S''')
  else
    Tabela.sql.add(' AND FOC.INDEXCLUIR = ''N''');


  Tabela.Open;

  while not Tabela.Eof do
  begin
    VpfDBaixaConsumo := RDBaixaConsumoOp(VpaBaixas,Tabela.FieldByName('I_SEQ_PRO').AsInteger,Tabela.FieldByName('CODCOR').AsInteger,Tabela.FieldByName('INDMATERIALEXTRA').AsString = 'S');
    if (VpfDBaixaConsumo = nil)or (Varia.TipoOrdemProducao = toFracionada) then
    begin
      VpfDBaixaConsumo:= TRBDConsumoFracaoOP.Create;
      VpaBaixas.Add(VpfDBaixaConsumo);
      VpfDBaixaConsumo.CodFilial:= VpaCodFilial;
      VpfDBaixaConsumo.SeqOrdem:= VpaSeqOrdem;
      VpfDBaixaConsumo.SeqFracao:= VpaSeqFracao;
      VpfDBaixaConsumo.SeqConsumo:= Tabela.FieldByName('SEQCONSUMO').AsInteger;
      VpfDBaixaConsumo.SeqProduto:= Tabela.FieldByName('I_SEQ_PRO').AsInteger;
      VpfDBaixaConsumo.CodCor:= Tabela.FieldByName('CODCOR').AsInteger;
      VpfDBaixaConsumo.CodProduto:= Tabela.FieldByName('C_COD_PRO').AsString;
      VpfDBaixaConsumo.IndMaterialExtra := Tabela.FieldByName('INDMATERIALEXTRA').AsString = 'S';
      if config.ConverterMTeCMparaMM and
        ((Tabela.FieldByName('DESUM').AsString = 'CM') OR
         (Tabela.FieldByName('DESUM').AsString = 'MT')) then
      begin
        VpfDBaixaConsumo.DesUM:= 'MM';
        VpfDBaixaConsumo.DesUMUnitario:= 'MM';
        VpfDBaixaConsumo.DesUMOriginal := 'MM';
        if (Tabela.FieldByName('DESUM').AsString = 'CM') then
          VpfDBaixaConsumo.QtdUnitario:= Tabela.FieldByName('QTDUNITARIO').AsFloat*10
        else
          if (Tabela.FieldByName('DESUM').AsString = 'MT') then
            VpfDBaixaConsumo.QtdUnitario:= Tabela.FieldByName('QTDUNITARIO').AsFloat*1000;
      end
      else
      begin
        VpfDBaixaConsumo.DesUM:= Tabela.FieldByName('DESUM').AsString;
        VpfDBaixaConsumo.QtdUnitario:= Tabela.FieldByName('QTDUNITARIO').AsFloat;
        VpfDBaixaConsumo.DesUMUnitario:= Tabela.FieldByName('DESUMUNITARIO').AsString;
        VpfDBaixaConsumo.DesUMOriginal := Tabela.FieldByName('UMORIGINAL').AsString;
      end;
      VpfDBaixaConsumo.NomProduto:= Tabela.FieldByName('C_NOM_PRO').AsString;
      VpfDBaixaConsumo.NomCor:= Tabela.FieldByName('NOM_COR').AsString;
      VpfDBaixaConsumo.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpfDBaixaConsumo.DesUM);
      VpfDBaixaConsumo.DesObservacao:= Tabela.FieldByName('DESOBSERVACAO').AsString;
      VpfDBaixaConsumo.IndOrigemCorte:= Tabela.FieldByName('INDORIGEMCORTE').AsString = 'S';
      VpfDBaixaConsumo.IndExcluir:= Tabela.FieldByName('INDEXCLUIR').AsString = 'S';
      VpfDBaixaConsumo.CodFaca:= Tabela.FieldByName('CODFACA').AsInteger;
      VpfDBaixaConsumo.NomFaca:= Tabela.FieldByName('NOMFACA').AsString;
    end
    else
    begin
      VpfDBaixaConsumo.SeqFracao:= 0;
      VpfDBaixaConsumo.SeqConsumo:= 0;
      VpfDBaixaConsumo.QtdUnitario:= 0;
    end;
    VpfDBaixaConsumo.QtdProduto:= VpfDBaixaConsumo.QtdProduto + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDPRODUTO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdBaixado:= VpfDBaixaConsumo.QtdBaixado + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDBAIXADO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdReservado:= VpfDBaixaConsumo.QtdReservado + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDRESERVADAESTOQUE').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdAReservar:= VpfDBaixaConsumo.QtdAReservar + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDARESERVAR').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.DesObservacao := VpfDBaixaConsumo.DesObservacao +' ' + Tabela.FieldByName('DESOBSERVACAO').AsString;

    VpfDBaixaConsumo.IndBaixado:=  VpfDBaixaConsumo.QtdBaixado >= VpfDBaixaConsumo.QtdProduto;
    Tabela.Next;
  end;
  Tabela.Close;

  if (varia.TipoOrdemProducao = toSubMontagem) and (VpaCarregarSubMontagem) then
  begin
    //carrega o consumo das submontagens
    VpfTabela := TSQLQUERY.Create(nil);
    VpfTabela.SQLConnection := DataBase;
    AdicionaSQLAbreTabela(VpfTabela,'Select CODFILIAL, SEQORDEM, SEQFRACAO '+
                                     ' from FRACAOOP '+
                                     ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                     ' AND SEQORDEM = '+ IntToStr(VpaSeqOrdem)+
                                     ' and SEQFRACAOPAI = '+IntToStr(VpaSeqFracao));
    while not VpfTabela.eof do
    begin
      CarDBaixaFracaoConsumoProduto(VpaCodFilial,VpaSeqOrdem,VpfTabela.FieldByName('SEQFRACAO').AsInteger,VpaIndConsumoOrdemCorte,VpaBaixas,true,VpaConsumoAExcluir);
      VpfTabela.next;
    end;
    VpfTabela.close;
    VpfTabela.free;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDBaixaOPConsumoProduto(VpaCodFilial, VpaSeqOrdem : Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList);
var
  VpfDBaixaConsumo: TRBDConsumoFracaoOP;
begin
  FreeTObjectsList(VpaBaixas);
  Tabela.sql.clear;
  Tabela.sql.add('SELECT FOC.SEQCONSUMO, FOC.QTDPRODUTO, FOC.QTDBAIXADO, FOC.SEQFRACAO,  '+
                               ' FOC.SEQPRODUTO, FOC.DESUMUNITARIO, FOC.DESOBSERVACAO, FOC.INDMATERIALEXTRA, '+
                               ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL,'+
                               ' FOC.CODCOR, COR.NOM_COR,'+
                               ' FOC.DESUM, FOC.INDBAIXADO, FOC.CODFACA, FOC.QTDRESERVADAESTOQUE '+
                               ' FROM FRACAOOPCONSUMO FOC, COR, CADPRODUTOS PRO'+
                               ' WHERE FOC.CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND FOC.SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                               ' AND '+SQLTextoRightJoin('FOC.CODCOR','COR.COD_COR')+
                               ' AND PRO.I_SEQ_PRO = FOC.SEQPRODUTO');
  if VpaIndConsumoOrdemCorte then
    Tabela.sql.add(' AND FOC.INDORDEMCORTE = ''S''')
  else
    Tabela.sql.add(' AND FOC.INDORDEMCORTE = ''N''');
  Tabela.Open;

  while not Tabela.Eof do
  begin
    VpfDBaixaConsumo := RDBaixaConsumoOp(VpaBaixas,Tabela.FieldByName('I_SEQ_PRO').AsInteger,Tabela.FieldByName('CODCOR').AsInteger,Tabela.FieldByName('INDMATERIALEXTRA').AsString = 'S');
    if VpfDBaixaConsumo = nil then
    begin
      VpfDBaixaConsumo:= TRBDConsumoFracaoOP.Create;
      VpaBaixas.Add(VpfDBaixaConsumo);
      VpfDBaixaConsumo.CodFilial:= VpaCodFilial;
      VpfDBaixaConsumo.SeqOrdem:= VpaSeqOrdem;
      VpfDBaixaConsumo.SeqFracao:= 0;
      VpfDBaixaConsumo.SeqConsumo:= 0;
      VpfDBaixaConsumo.SeqProduto:= Tabela.FieldByName('I_SEQ_PRO').AsInteger;
      VpfDBaixaConsumo.CodCor:= Tabela.FieldByName('CODCOR').AsInteger;
      VpfDBaixaConsumo.CodProduto:= Tabela.FieldByName('C_COD_PRO').AsString;
      VpfDBaixaConsumo.IndMaterialExtra := Tabela.FieldByName('INDMATERIALEXTRA').AsString = 'S';
      if config.ConverterMTeCMparaMM and
         ((Tabela.FieldByName('DESUM').AsString = 'CM') OR
         (Tabela.FieldByName('DESUM').AsString = 'MT')) then
      begin
        VpfDBaixaConsumo.DesUM:= 'MM';
        VpfDBaixaConsumo.DesUMUnitario:= 'MM';
        VpfDBaixaConsumo.DesUMOriginal := 'MM';
      end
      else
      begin
        VpfDBaixaConsumo.DesUM:= Tabela.FieldByName('DESUM').AsString;
        VpfDBaixaConsumo.DesUMUnitario:= Tabela.FieldByName('DESUMUNITARIO').AsString;
        VpfDBaixaConsumo.DesUMOriginal := Tabela.FieldByName('UMORIGINAL').AsString;
      end;

      VpfDBaixaConsumo.NomProduto:= Tabela.FieldByName('C_NOM_PRO').AsString;
      VpfDBaixaConsumo.NomCor:= Tabela.FieldByName('NOM_COR').AsString;
      VpfDBaixaConsumo.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpfDBaixaConsumo.DesUM);
    end;
    VpfDBaixaConsumo.QtdProduto:= VpfDBaixaConsumo.QtdProduto + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDPRODUTO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdBaixado:= VpfDBaixaConsumo.QtdBaixado + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDBAIXADO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
    VpfDBaixaConsumo.QtdReservado:= VpfDBaixaConsumo.QtdReservado + CalculaQdadePadrao(Tabela.FieldByName('DESUM').AsString,VpfDBaixaConsumo.DesUM,Tabela.FieldByName('QTDRESERVADAESTOQUE').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);;
    VpfDBaixaConsumo.DesObservacao := VpfDBaixaConsumo.DesObservacao +' ' + Tabela.FieldByName('DESOBSERVACAO').AsString;
    VpfDBaixaConsumo.IndBaixado:=  VpfDBaixaConsumo.QtdBaixado >= VpfDBaixaConsumo.QtdProduto;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarConsumoProdutoBastidor(VpaSeqProduto : Integer;VpaDConsumo :TRBDConsumoMP);
var
  VpfDBastidor : TRBDConsumoMPBastidor;
begin
  AdicionaSQLAbreTabela(Tabela2,'Select MOB.CODBASTIDOR, MOB.QTDPECAS, '+
                                ' BAS.NOMBASTIDOR '+
                                ' FROM MOVKITBASTIDOR MOB, BASTIDOR BAS '+
                                ' Where MOB.CODBASTIDOR = BAS.CODBASTIDOR '+
                                ' and MOB.SEQPRODUTOKIT = '+ IntToStr(VpaSeqProduto)+
                                ' and MOB.SEQCORKIT = ' + IntToStr(VpaDConsumo.CorKit)+
                                ' AND MOB.SEQMOVIMENTO = '+IntToStr(VpaDConsumo.SeqMovimento)+
                                ' ORDER BY MOB.CODBASTIDOR ');
  While not Tabela2.eof do
  begin
    VpfDBastidor := VpaDConsumo.addBastidor;
    VpfDBastidor.CodBastidor := Tabela2.FieldByname('CODBASTIDOR').AsInteger;
    VpfDBastidor.QtdPecas := Tabela2.FieldByname('QTDPECAS').AsInteger;
    VpfDBastidor.NomBastidor := Tabela2.FieldByname('NOMBASTIDOR').AsString;
    Tabela2.next;
  end;
  Tabela2.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDOperacaoEstoque(VpaDOperacao : TRBDOperacaoEstoque;VpaCodOperacao: Integer);
begin
  LocalizaOperacaoEstoque(AUX, VpaCodOperacao);
  VpaDOperacao.NomOperacao := Aux.FieldByName('C_NOM_OPE').AsString;
  VpaDOperacao.DesTipo_E_S := Aux.FieldByName('C_TIP_OPE').AsString;
  VpaDOperacao.DesFuncao := Aux.FieldByName('C_FUN_OPE').AsString;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarConsumoProduto(VpaDProduto : TRBDProduto;VpaCorKit : Integer);
Var
  VpfDConsumo : TRBDConsumoMP;
begin
  AdicionaSQLAbreTabela(Tabela,'Select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.I_ALT_PRO, MOV.I_COD_COR, MOV.C_COD_UNI, '+
                               ' MOV.N_QTD_PRO, MOV.I_SEQ_PRO, PRO.C_COD_UNI UNIORI, PRO.C_PRA_PRO, '+
                               ' MOV.I_COD_FAC, MOV.I_ALT_MOL, MOV.I_LAR_MOL, MOV.I_SEQ_MOV, '+
                               ' MOV.I_COD_MAQ, MOV.I_COR_REF, MOV.N_VLR_UNI, MOV.N_VLR_TOT, MOV.N_PEC_MET, MOV.N_IND_MET, '+
                               ' MOV.C_DES_OBS, MOV.I_SEQ_ENT, MOV.I_SEQ_TER, MOV.I_QTD_ENT, MOV.I_QTD_TER, '+
                               ' MOV.D_DAT_DES  '+
                               ' from MOVKIT MOV, CADPRODUTOS PRO' +
                               ' Where MOV.I_PRO_KIT = '+ IntToStr(VpaDProduto.SeqProduto)+
                               ' and MOV.I_COR_KIT = ' + IntToStr(VpaCorKit)+
                               ' and MOV.I_SEQ_PRO = PRO.I_SEQ_PRO' +
                               ' order by MOV.I_SEQ_MOV');

  FreeTObjectsList(VpaDProduto.ConsumosMP);
  While not Tabela.eof do
  begin
    VpfDConsumo := VpaDProduto.AddConsumoMP;
    VpfDConsumo.CorKit := VpaCorKit;
    VpfDConsumo.SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
    VpfDConsumo.CodCor := Tabela.FieldByName('I_COD_COR').AsInteger;
    VpfDConsumo.SeqMovimento := Tabela.FieldByName('I_SEQ_MOV').AsInteger;
    VpfDConsumo.CodProduto := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDConsumo.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDConsumo.AltProduto := Tabela.FieldByName('I_ALT_PRO').AsInteger;
    VpfDConsumo.UMOriginal := Tabela.FieldByName('UNIORI').AsString;
    VpfDConsumo.UM := Tabela.FieldByName('C_COD_UNI').AsString;
    VpfDConsumo.UnidadeParentes := ValidaUnidade.UnidadesParentes(VpfDConsumo.UMOriginal);
    VpfDConsumo.QtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat;
    VpfDConsumo.DesPrateleira := Tabela.FieldByName('C_PRA_PRO').AsString;
    if VpfDConsumo.CodCor <> 0 then
      VpfDConsumo.NomCor := RNomeCor(Tabela.FieldByName('I_COD_COR').AsString);

    VpfDConsumo.ValorUnitario := Tabela.FieldByName('N_VLR_UNI').AsFloat;
    VpfDConsumo.ValorTotal := Tabela.FieldByName('N_VLR_TOT').AsFloat;
    VpfDConsumo.PecasMT := Tabela.FieldByName('N_PEC_MET').AsFloat;
    VpfDConsumo.IndiceMT := Tabela.FieldByName('N_IND_MET').AsFloat;

    VpfDConsumo.CodFaca:= Tabela.FieldByName('I_COD_FAC').AsInteger;
    VpfDConsumo.AlturaMolde:= Tabela.FieldByName('I_ALT_MOL').AsFloat;
    VpfDConsumo.LarguraMolde:= Tabela.FieldByName('I_LAR_MOL').AsFloat;
    VpfDConsumo.CodMaquina:= Tabela.FieldByName('I_COD_MAQ').AsInteger;
    VpfDConsumo.DatDesenho:= Tabela.FieldByName('D_DAT_DES').AsDateTime;
    VpfDConsumo.CorReferencia:= Tabela.FieldByName('I_COR_REF').AsInteger;
    if VpfDConsumo.CodFaca <> 0 then
      ExisteFaca(VpfDConsumo.CodFaca,VpfDConsumo.Faca);
    if VpfDConsumo.CodMaquina <> 0 then
      ExisteMaquina(VpfDConsumo.CodMaquina,VpfDConsumo.Maquina);
    VpfDConsumo.DesObservacoes := Tabela.FieldByName('C_DES_OBS').AsString;
    VpfDConsumo.SeqProdutoEntretela := Tabela.FieldByName('I_SEQ_ENT').AsInteger;
    VpfDConsumo.SeqProdutoTermoColante := Tabela.FieldByName('I_SEQ_TER').AsInteger;
    VpfDConsumo.QtdEntretela := Tabela.FieldByName('I_QTD_ENT').AsInteger;
    VpfDConsumo.QtdTermoColante := Tabela.FieldByName('I_QTD_TER').AsInteger;
    if VpfDConsumo.SeqProdutoEntretela <> 0 then
      FunProdutos.ExisteProduto(VpfDConsumo.SeqProdutoEntretela,VpfDConsumo.CodProdutoEntretela,VpfDConsumo.NomProdutoEntretela);
    if VpfDConsumo.SeqProdutoTermoColante <> 0 then
      FunProdutos.ExisteProduto(VpfDConsumo.SeqProdutoTermoColante,VpfDConsumo.CodProdutoTermoColante,VpfDConsumo.NomProdutoTermoColante);
    CarConsumoProdutoBastidor(VpaDProduto.SeqProduto,VpfDConsumo);
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarProdutoImpressoras(VpaSeqProduto : Integer;VpaImpresoras : TList);
Var
  VpfProImpressora : TRBDProdutoImpressora;
begin
  FreeTObjectsList(VpaImpresoras);
  AdicionaSQLAbreTabela(Tabela,'Select PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                               ' from CADPRODUTOS PRO, PRODUTOIMPRESSORA IMP '+
                               ' Where IMP.SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                               ' and PRO.I_SEQ_PRO = IMP.SEQIMPRESSORA');
  While not Tabela.eof do
  begin
    VpfProImpressora := TRBDProdutoImpressora.Create;
    VpaImpresoras.add(VpfProImpressora);
    VpfProImpressora.SeqImpressora := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
    VpfProImpressora.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
    VpfProImpressora.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarAcessoriosProduto(VpaDProduto : TRBDProduto);
Var
  VpfDAcessorio :  TRBDProdutoAcessorio;
begin
  FreeTObjectsList(VpaDProduto.Acessorios);
  AdicionaSQLAbreTabela(Tabela,'Select ACE.CODACESSORIO, ACE.NOMACESSORIO  '+
                               ' from ACESSORIO ACE, PRODUTOACESSORIO PAC '+
                               ' Where ACE.CODACESSORIO = PAC.CODACESSORIO'+
                               ' and PAC.SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto)+
                               ' ORDER BY ACE.CODACESSORIO');
  while not Tabela.eof do
  begin
    VpfDAcessorio := VpaDProduto.AddAcessorio;
    VpfDAcessorio.CodAcessorio := Tabela.FieldByName('CODACESSORIO').AsInteger;
    VpfDAcessorio.NomAcessorio := Tabela.FieldByName('NOMACESSORIO').AsString;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDBaixaConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer; VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList);
begin
  FreeTObjectsList(VpaBaixas);
  if VpaSeqFracao <> 0 then
    CarDBaixaFracaoConsumoProduto(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaIndConsumoOrdemCorte, VpaBaixas,true,false)
  else
    CarDBaixaOPConsumoProduto(VpaCodFilial,VpaSeqOrdem,VpaIndConsumoOrdemCorte, VpaBaixas);
end;

{******************************************************************************}
procedure TFuncoesProduto.CarPerComissoesProduto(VpaSeqProduto, VpaCodVendedor : Integer;Var VpaPerComissaoProduto : Double;Var VpaPerComissaoClassificacao : Double;var VpaPerComissaoVendedor : Double);
begin
  AdicionaSQLAbreTabela(Aux,'Select PRO.N_PER_COM, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, '+
                            ' COM.PERCOMISSAO '+
                            ' From CADPRODUTOS PRO, CADCLASSIFICACAO CLA, COMISSAOCLASSIFICACAOVENDEDOR COM '+
                            ' Where PRO.I_SEQ_PRO = ' +IntToStr(VpaSeqProduto)+
                            ' and PRO.I_COD_EMP = CLA.I_COD_EMP '+
                            ' and PRO.C_COD_CLA = CLA.C_COD_CLA '+
                            ' and PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                            ' and '+SQLTextoRightJoin('COM.CODEMPRESA','CLA.I_COD_EMP') +
                            ' and '+SQLTextoRightJoin('COM.CODCLASSIFICACAO','CLA.C_COD_CLA')+
                            ' and '+SQLTextoRightJoin('COM.TIPCLASSIFICACAO','CLA.C_TIP_CLA')+
                            ' AND COM.CODVENDEDOR = '+IntToStr(VpaCodVendedor));
  VpaPerComissaoProduto := AUX.FieldByname('N_PER_COM').AsFloat;
  VpaPerComissaoClassificacao := AUX.FieldByname('PERCOMISSAOCLASSIFICACAO').AsFloat;
  VpaPerComissaoVendedor := AUX.FieldByname('PERCOMISSAO').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarQtdMinimaProduto(VpaCodFilial, VpaSeqProduto, VpaCor, VpaCodTamanho : Integer; var VpaQtdMinima, VpaQtdPedido, VpaValCusto : Double);
begin
  AdicionaSQLAbreTabela(AUX,'Select N_QTD_MIN, N_QTD_PED, N_VLR_CUS from MOVQDADEPRODUTO '+
                            ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                            ' AND I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' AND I_COD_COR = '+ IntToStr(VpaCor)+
                            ' AND I_COD_TAM = '+ IntToStr(VpaCodTamanho));
  VpaQtdMinima := AUX.FieldByName('N_QTD_MIN').AsFloat;
  VpaQtdPedido := AUX.FieldByName('N_QTD_PED').AsFloat;
  VpaValCusto := AUX.FieldByName('N_VLR_CUS').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarQtdMinimaProduto(VpaCodFilial, VpaCor: Integer; VpaDProduto: TRBDProduto);
begin
  AdicionaSQLAbreTabela(AUX,'SELECT N_QTD_MIN, N_QTD_PED, N_VLR_CUS FROM MOVQDADEPRODUTO '+
                            ' WHERE I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' AND I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                            ' AND I_COD_COR = '+IntToStr(VpaCor));
  VpaDproduto.QtdMinima:= AUX.FieldByName('N_QTD_MIN').AsFloat;
  VpaDProduto.QtdPedido:= AUX.FieldByName('N_QTD_PED').AsFloat;
  VpaDProduto.VlrCusto:= AUX.FieldByName('N_VLR_CUS').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDBaixaConsumoFracaoLog(VpaDBaixa : TRBDConsumoFracaoOP;VpaCodUsuario : Integer): String;
begin
  AdicionaSQLAbreTabela(ProCadastro,'Select * from FRACAOOPCONSUMOLOG ');
  ProCadastro.Insert;
  ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaDBaixa.CodFilial;
  ProCadastro.FieldByName('SEQORDEM').AsInteger := VpaDBaixa.SeqOrdem;
  ProCadastro.FieldByName('SEQFRACAO').AsInteger := VpaDBaixa.SeqFracao;
  ProCadastro.FieldByName('SEQCONSUMO').AsInteger := VpaDBaixa.SeqConsumo;
  ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDBaixa.SeqProduto;
  ProCadastro.FieldByName('CODCOR').AsInteger := VpaDBaixa.CodCor;
  ProCadastro.FieldByName('CODUSUARIO').AsInteger := VpaCodUsuario;
  ProCadastro.FieldByName('DATLOG').AsDateTime := Now;
  ProCadastro.FieldByName('QTDBAIXADO').AsFloat := VpaDBaixa.QtdABaixar;
  ProCadastro.FieldByName('DESUM').AsString := VpaDBaixa.DesUM;
  ProCadastro.FieldByName('SEQLOG').AsInteger := RSeqLogFracaoOpConsumo(VpaDBaixa.CodFilial,VpaDBaixa.SeqOrdem,VpaDBaixa.SeqFracao,VpaDBaixa.SeqConsumo);
  ProCadastro.post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDBaixaConsumoFracaoProduto1(VpaCodigoFilial, VpaSeqOrdem,VpaSeqFracao, VpaCodUsuario : Integer;  VpaBaixas: TList): String;
var
  VpfLaco: Integer;
  VpfBaixaConsumo: TRBDConsumoFracaoOP;
begin
  Result:= '';
  for VpfLaco:= 0 to VpaBaixas.Count-1 do
  begin
    VpfBaixaConsumo:= TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if VpfBaixaConsumo.QtdABaixar <> 0 then
    begin
      AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM FRACAOOPCONSUMO'+
                          ' WHERE CODFILIAL = '+IntToStr(VpaCodigoFilial)+
                          ' AND SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                          ' AND SEQFRACAO = '+IntToStr(VpaSeqFracao)+
                          ' AND SEQCONSUMO = '+IntToStr(VpfBaixaConsumo.SeqConsumo));
      ProCadastro.Edit;
      ProCadastro.FieldByName('CODFILIAL').AsInteger:= VpfBaixaConsumo.CodFilial;
      ProCadastro.FieldByName('SEQORDEM').AsInteger:= VpfBaixaConsumo.SeqOrdem;
      ProCadastro.FieldByName('SEQFRACAO').AsInteger:= VpfBaixaConsumo.SeqFracao;
      ProCadastro.FieldByName('SEQCONSUMO').AsInteger:= VpfBaixaConsumo.SeqConsumo;
      ProCadastro.FieldByName('QTDPRODUTO').AsFloat:= VpfBaixaConsumo.QtdProduto;
      VpfBaixaConsumo.QtdBaixado := VpfBaixaConsumo.QtdBaixado + VpfBaixaConsumo.QtdaBaixar;
      ProCadastro.FieldByName('QTDBAIXADO').AsFloat:= VpfBaixaConsumo.QtdBaixado;
      VpfBaixaConsumo.QtdReservado := VpfBaixaConsumo.QtdReservado - VpfBaixaConsumo.QtdABaixar;
      if VpfBaixaConsumo.QtdReservado  < 0 then
        VpfBaixaConsumo.QtdReservado := 0;
      ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat:= VpfBaixaConsumo.QtdReservado;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger:= VpfBaixaConsumo.SeqProduto;
      ProCadastro.FieldByName('CODCOR').AsInteger:= VpfBaixaConsumo.CodCor;
      ProCadastro.FieldByName('DESUM').AsString:= VpfBaixaConsumo.DesUM;
      VpfBaixaConsumo.IndBaixado := VpfBaixaConsumo.QtdBaixado >=  VpfBaixaConsumo.QtdProduto;
      if VpfBaixaConsumo.IndBaixado then
        ProCadastro.FieldByName('INDBAIXADO').AsString:= 'S'
      else
        ProCadastro.FieldByName('INDBAIXADO').AsString:= 'N';

      ProCadastro.Post;
      result := ProCadastro.AMensagemErroGravacao;
      if ProCadastro.AErronaGravacao then
        Break;
      if (VpfBaixaConsumo.QtdABaixar > 0) and not(VpfBaixaConsumo.IndOrigemCorte) then
      begin
        Result := GravaDBaixaConsumoFracaoLog(VpfBaixaConsumo,VpaCodUsuario)
      end;
    end;
    if result <> '' then
      break;
  end;

  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDBaixaConsumoOPProduto(VpaCodigoFilial, VpaSeqOrdem, VpaCodUsuario: Integer;VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList): String;
var
  VpfLaco: Integer;
  VpfDBaixaConsumo: TRBDConsumoFracaoOP;
begin
  Result:= '';
  for VpfLaco:= 0 to VpaBaixas.Count-1 do
  begin
    VpfDBaixaConsumo:= TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if VpfDBaixaConsumo.QtdABaixar <> 0 then
    begin
      result :=  GravaDBaixaConsumoFracaoLog(VpfDBaixaConsumo,VpaCodUsuario);
      if result = '' then
      begin
        ProCadastro.sql.clear;
        ProCadastro.sql.add('SELECT * FROM FRACAOOPCONSUMO'+
                            ' WHERE CODFILIAL = '+IntToStr(VpaCodigoFilial)+
                            ' AND SEQORDEM = '+IntToStr(VpaSeqOrdem)+
                            ' AND SEQPRODUTO = '+IntToStr(VpfDBaixaConsumo.SeqProduto)+
                            ' AND CODCOR = ' +IntToStr(VpfDBaixaConsumo.CodCor));
        if VpaIndConsumoOrdemCorte then
          ProCadastro.sql.add(' AND INDORDEMCORTE = ''S''')
        else
          ProCadastro.sql.add(' AND INDORDEMCORTE = ''N''');
        ProCadastro.Open;

        While not (ProCadastro.eof) and (VpfDBaixaConsumo.QtdABaixar > 0) do
        begin
          if ((ProCadastro.FieldByname('QTDPRODUTO').AsFloat - ProCadastro.FieldByname('QTDBAIXADO').AsFloat) > 0) then
          begin
            ProCadastro.Edit;
            ProCadastro.FieldByName('CODFILIAL').AsInteger:= VpfDBaixaConsumo.CodFilial;
            ProCadastro.FieldByName('SEQORDEM').AsInteger:= VpfDBaixaConsumo.SeqOrdem;

            if (VpfDBaixaConsumo.QtdABaixar > (ProCadastro.FieldByname('QTDPRODUTO').AsFloat - ProCadastro.FieldByname('QTDBAIXADO').AsFloat)) then
            begin
              VpfDBaixaConsumo.QtdABaixar := VpfDBaixaConsumo.QtdABaixar - (ProCadastro.FieldByname('QTDPRODUTO').AsFloat - ProCadastro.FieldByname('QTDBAIXADO').AsFloat);
              ProCadastro.FieldByname('QTDBAIXADO').AsFloat := ProCadastro.FieldByname('QTDPRODUTO').AsFloat;
            end
            else
            begin
              ProCadastro.FieldByname('QTDBAIXADO').AsFloat := ProCadastro.FieldByname('QTDBAIXADO').AsFloat+VpfDBaixaConsumo.QtdABaixar;
              VpfDBaixaConsumo.QtdABaixar := 0;
            end;
            VpfDBaixaConsumo.IndBaixado := ProCadastro.FieldByname('QTDBAIXADO').AsFloat >= ProCadastro.FieldByname('QTDPRODUTO').AsFloat;
            if VpfDBaixaConsumo.IndBaixado then
              ProCadastro.FieldByName('INDBAIXADO').AsString:= 'S'
            else
              ProCadastro.FieldByName('INDBAIXADO').AsString:= 'N';

            ProCadastro.Post;
            result := ProCadastro.AMensagemErroGravacao;
            if ProCadastro.AErronaGravacao then
              Break;
          end;
          ProCadastro.next;
        end;
      end;
    end;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDConsumoMPBastidor(VpaDProduto : TRBDProduto;VpaCorKit : Integer) : String;
var
  VpfLacoConsumo, VpfLacoBastidor : Integer;
  VpfDConsumo : TRBDConsumoMP;
  VpfDConsumoBastidor : TRBDConsumoMPBastidor;
begin
  result := '';
  AdicionaSqlAbreTabela(ProCadastro,'Select * from MOVKITBASTIDOR'+
                                    ' Where SEQPRODUTOKIT = 0 AND SEQCORKIT = 0 AND SEQMOVIMENTO = 0 AND CODBASTIDOR = 0 ');
  for VpfLacoConsumo := 0 to VpaDProduto.ConsumosMP.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLacoConsumo]);
    for VpfLacoBastidor := 0 to VpfDConsumo.Bastidores.Count - 1 do
    begin
      VpfDConsumoBastidor := TRBDConsumoMPBastidor(VpfDConsumo.Bastidores.Items[VpfLacoBastidor]);
      ProCadastro.Insert;
      ProCadastro.FieldByName('SEQPRODUTOKIT').AsInteger := VpaDProduto.SeqProduto;
      ProCadastro.FieldByName('SEQCORKIT').AsInteger := VpaCorKit;
      ProCadastro.FieldByName('SEQMOVIMENTO').AsInteger := VpfDConsumo.SeqMovimento;
      ProCadastro.FieldByName('CODBASTIDOR').AsInteger := VpfDConsumoBastidor.CodBastidor;
      ProCadastro.FieldByName('QTDPECAS').AsInteger := VpfDConsumoBastidor.QtdPecas;
      ProCadastro.Post;
      result := ProCadastro.AMensagemErroGravacao;
      if ProCadastro.AErronaGravacao then
        break;
    end;
    if result <> '' then
      break;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiMovimentoEstoquePorData(VpaDatInicial, VpaDatFinal : TDateTime);
begin
  ExecutaComandoSql(AUX,'DELETE FROM MOVESTOQUEPRODUTOS '+
                        ' Where D_DAT_MOV >= '+ SQLTextoDataAAAAMMMDD(VpaDatInicial)+
                        ' and D_DAT_MOV <= '+ SQLTextoDataAAAAMMMDD(VpaDatFinal)+
                        ' and I_EMP_FIL = ' + IntToStr(Varia.CodigoempFil)+
                        ' and I_COD_OPE not in ('+ IntToStr(Varia.OperacaoEstoqueInicial)+
                        ','+IntTostr(Varia.InventarioEntrada)+
                        ','+IntToStr(varia.InventarioSaida)+
                        ','+IntTostr(Varia.OperacaoAcertoEstoqueEntrada)+
                        ','+IntToStr(varia.OperacaoAcertoEstoqueSaida)+')');
  ExecutaComandoSql(AUX,'DELETE FROM MOVSUMARIZAESTOQUE '+
                        ' Where I_MES_FEC = '+ IntToStr(Mes(VpaDatInicial)) +
                        ' and I_ANO_FEC = '+ InttoStr(Ano(VpaDatInicial))+
                        ' and I_EMP_FIL = ' + IntToStr(Varia.CodigoempFil));
end;

{******************************************************************************}
function TFuncoesProduto.ReprocessaEstoqueCotacao(VpaDatInicial, VpaDatFinal : TDateTime) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVESTOQUEPRODUTOS');
  AdicionaSQLAbreTabela(ProProduto,'Select MOV.I_SEQ_PRO, MOV.N_QTD_PRO, MOV.N_VLR_TOT, MOV.I_LAN_ORC, MOV.C_COD_UNI, '+
                                   ' CAD.D_DAT_ORC '+
                                   ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV '+
                                   ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                   ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                                   ' AND CAD.D_DAT_ORC >= '+ SQLTextoDataAAAAMMMDD(VpaDatInicial)+
                                   ' AND CAD.D_DAT_ORC <= '+ SQLTextoDataAAAAMMMDD(VpaDatFinal)+
                                   ' AND CAD.I_EMP_FIL = '+ IntTostr(varia.CodigoEmpFil)+
                                   ' ORDER BY CAD.D_DAT_ORC');
  While not ProProduto.Eof do
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_EMP_FIL').AsInteger := Varia.CodigoEmpFil;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
    ProCadastro.FieldByName('I_COD_OPE').AsInteger := 1101;
    ProCadastro.FieldByName('D_DAT_MOV').AsDateTime := ProProduto.FieldByName('D_DAT_ORC').AsDateTime;
    ProCadastro.FieldByName('N_QTD_MOV').AsFloat := ProProduto.FieldByName('N_QTD_PRO').AsFloat;
    ProCadastro.FieldByName('C_TIP_MOV').AsString := 'S';
    ProCadastro.FieldByName('N_VLR_MOV').AsFloat := ProProduto.FieldByName('N_VLR_TOT').AsFloat;
    ProCadastro.FieldByName('I_NRO_NOT').AsInteger := ProProduto.FieldByName('I_LAN_ORC').AsInteger;
    ProCadastro.FieldByName('C_COD_UNI').AsString := ProProduto.FieldByName('C_COD_UNI').AsString;
    ProCadastro.FieldByName('D_DAT_CAD').AsDateTime := ProProduto.FieldByName('D_DAT_ORC').AsDateTime;
    ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', varia.CodigoEmpFil, false,ProCadastro.ASQlConnection );
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      exit;
    ProProduto.Next;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ReprocessaEstoqueCompras(VpaDatInicial, VpaDatFinal : TDateTime) : String;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVESTOQUEPRODUTOS');
  AdicionaSQLAbreTabela(ProProduto,'Select MOV.I_SEQ_PRO, MOV.N_QTD_PRO, MOV.N_TOT_PRO, MOV.I_SEQ_NOT, MOV.C_COD_UNI, '+
                                   ' CAD.D_DAT_EMI, I_NRO_NOT '+
                                   ' FROM CADNOTAFISCAISFOR CAD, MOVNOTASFISCAISFOR MOV '+
                                   ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                   ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                                   ' AND CAD.D_DAT_EMI >= '+ SQLTextoDataAAAAMMMDD(VpaDatInicial)+
                                   ' AND CAD.D_DAT_EMI <= '+ SQLTextoDataAAAAMMMDD(VpaDatFinal)+
                                   ' AND CAD.I_EMP_FIL = '+ IntTostr(varia.CodigoEmpFil)+
                                   ' ORDER BY CAD.D_DAT_EMI');
  While not ProProduto.Eof do
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_EMP_FIL').AsInteger := Varia.CodigoEmpFil;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
    ProCadastro.FieldByName('I_COD_OPE').AsInteger := 1102;
    ProCadastro.FieldByName('D_DAT_MOV').AsDateTime := ProProduto.FieldByName('D_DAT_EMI').AsDateTime;
    ProCadastro.FieldByName('N_QTD_MOV').AsFloat := ProProduto.FieldByName('N_QTD_PRO').AsFloat;
    ProCadastro.FieldByName('C_TIP_MOV').AsString := 'E';
    ProCadastro.FieldByName('N_VLR_MOV').AsFloat := ProProduto.FieldByName('N_TOT_PRO').AsFloat;
    ProCadastro.FieldByName('I_NRO_NOT').AsInteger := ProProduto.FieldByName('I_NRO_NOT').AsInteger;
    ProCadastro.FieldByName('I_NOT_ENT').AsInteger := ProProduto.FieldByName('I_SEQ_NOT').AsInteger;
    ProCadastro.FieldByName('C_COD_UNI').AsString := ProProduto.FieldByName('C_COD_UNI').AsString;
    ProCadastro.FieldByName('D_DAT_CAD').AsDateTime := ProProduto.FieldByName('D_DAT_EMI').AsDateTime;
    ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', varia.CodigoEmpFil,false,ProCadastro.ASqlconnection );
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      exit;
    ProProduto.Next;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AdicionaConsumoExtraFracaoOP(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;VpaQtdProduto : Double;VpaUM,VpaTipOperacao : String):string;
begin
  if VpaTipOperacao = 'E' then
    VpaQtdProduto := VpaQtdProduto *-1;
  AdicionaSQLAbreTabela(ProCadastro,'Select * from FRACAOOPCONSUMO ');
  ProCadastro.Insert;
  ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  ProCadastro.FieldByName('SEQORDEM').AsInteger := VpaSeqOrdemProducao;
  ProCadastro.FieldByName('SEQFRACAO').AsInteger := 1;
  ProCadastro.FieldByName('QTDBAIXADO').AsFloat := VpaQtdProduto;
  ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
  IF VpaCodCor <> 0 then
    ProCadastro.FieldByName('CODCOR').AsInteger := VpaCodCor;

  ProCadastro.FieldByName('DESUM').AsString := VpaUM;
  ProCadastro.FieldByName('INDBAIXADO').AsString := 'S';
  ProCadastro.FieldByName('QTDPRODUTO').AsFloat := VpaQtdProduto;
  ProCadastro.FieldByName('QTDUNITARIO').AsFloat := VpaQtdProduto;
  ProCadastro.FieldByName('INDORDEMCORTE').AsString := 'N';
  ProCadastro.FieldByName('DESUMUNITARIO').AsString := VpaUM;
  ProCadastro.FieldByName('INDORIGEMCORTE').AsString := 'N';
  ProCadastro.FieldByName('INDMATERIALEXTRA').AsString := 'S';

  ProCadastro.FieldByName('SEQCONSUMO').AsInteger := RSeqConsumoFracaoOpDisponivel(VpaCodFilial,VpaSeqOrdemProducao,ProCadastro.FieldByName('SEQFRACAO').AsInteger);
  try
    ProCadastro.post;
  except
    on e : exception do result :='ERRO NA GRAVAÇÃO DO CONSUMO EXTRA DA FRAÇAO(FRACAOOPCONSUMO)!!!'#13+e.message;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CopiaDEtiqueta(VpaDEtiquetaOrigem, VpaDEtiquetaDestino : TRBDEtiquetaProduto);
begin
//  VpaDEtiquetaDestino.Produto := TRBDProduto.cria;
  VpaDEtiquetaDestino.Produto := VpaDEtiquetaOrigem.Produto;
{  VpaDEtiquetaDestino.Produto.NomProduto := VpaDEtiquetaDestino.Produto.NomProduto;
  VpaDEtiquetaDestino.Produto.CODProduto := VpaDEtiquetaDestino.Produto.CODProduto;
  VpaDEtiquetaDestino.Produto.SeqProduto := VpaDEtiquetaDestino.Produto.SeqProduto;}
  VpaDEtiquetaDestino.CodCor := VpaDEtiquetaOrigem.CodCor;
  VpaDEtiquetaDestino.QtdOriginalEtiquetas := VpaDEtiquetaOrigem.QtdOriginalEtiquetas;
  VpaDEtiquetaDestino.QtdEtiquetas := VpaDEtiquetaOrigem.QtdEtiquetas;
  VpaDEtiquetaDestino.QtdProduto := VpaDEtiquetaOrigem.QtdProduto;
  VpaDEtiquetaDestino.NomCor := VpaDEtiquetaOrigem.NomCor;
  VpaDEtiquetaDestino.IndParaEstoque := VpaDEtiquetaOrigem.IndParaEstoque;
end;

{******************************************************************************}
function TFuncoesProduto.OperacoesEstornoValidas : String;
begin
  result := '';
  if Varia.OperacaoEstoqueEstornoEntrada = 0 then
    result := 'OPERAÇÃO DE ESTORNO DE ESTOQUE DE ENTRADA VAZIO!!!'#13'É necessário preencher a operação de estoque de estorno de entrada nas configurações dos produtos.'
  else
    if Varia.OperacaoEstoqueEstornoSaida = 0 then
      result := 'OPERAÇÃO DE ESTORNO DE ESTOQUE DE SAÍDA VAZIO!!!'#13'É necessário preencher a operação de estoque de estorno de entrada nas configurações dos produtos.'
    else
      if varia.PlanoContasDevolucaoCotacao = '' then
        result := 'PLANO DE CONTAS DEVOLUÇÃO COTAÇÃO VAZIO!!!'#13'É necessário preencher o plano de contas devolução da cotação, nas configurações da empresa.';
end;

{**************** gera o proximo codigo para o produto ********************** }
function TFuncoesProduto.ProximoCodigoProduto( CodClassificacao : String; tamanhoPicture : Integer ) : string;
begin
  if config.CodigoProdutoCompostopelaClasificacao then
    result := RCodProdutoDisponivelpelaClassificacao(CodClassificacao)
  else
  begin
    LimpaSQLTabela(tabela);
    AdicionaSQLAbreTabela(tabela, ' select max(I_ULT_PRO)  ULTIMO ' +
                              ' from CADEMPRESAS '+
                              ' where i_cod_emp = ' +IntToStr(varia.CodigoEmpresa) );

    result := IntTostr(Tabela.FieldByName('ULTIMO').AsInteger+1);
    Tabela.Close;
    ExecutaComandoSql(Tabela,'update CADEMPRESAS '+
                             ' Set I_ULT_PRO = I_ULT_PRO + 1'+
                              ' where i_cod_emp = ' +IntToStr(varia.CodigoEmpresa) );
    if config.MascaraProdutoPadrao then
      result := AdicionaCharE('0', result, tamanhoPicture);
   end;
end;

{******************************************************************************}
procedure TFuncoesProduto.EstornaProximoCodigoProduto;
begin
  ExecutaComandoSql(Tabela,'update CADEMPRESAS '+
                           ' Set I_ULT_PRO = I_ULT_PRO - 1'+
                            ' where i_cod_emp = ' +IntToStr(varia.CodigoEmpresa) );
end;

{************************* Verifica se o produto ja foi cadastrado *********** }
function TFuncoesProduto.ProdutoExistente(CodigoPro, CodClassificacao : string) : Boolean;
begin
  result := true;
  if Config.CodigoUnicoProduto then
    LocalizaProduto(tabela, CodigoPro)
  else
    LocalizaProdutoClassificacao(tabela,CodigoPro,CodClassificacao);

     if not tabela.eof then
     begin
        erro('PRODUTO DUPLICADO - Este código do produto já existe nesta classificação');
        result := false;
     end;
end;

{**************** carrega mascara do produto e classificacao ***************** }
function TFuncoesProduto.VerificaMascaraClaPro : Boolean;
begin
  result := true;
  if Varia.MascaraCla = '0' then
  begin
    Aviso(CT_FilialSemMascara);   // caso a mascara seje 0
    Result := false;
  end;
end;

{************** calcula qdade de poduto para a unidade padrao do mesmo ******* }
function TFuncoesProduto.CalculaQdadePadrao( unidadeAtual, UnidadePadrao : string; QdadeVendida : double; SequencialProduto : string) : Double;
var
  VpfIndice, VpfIndiceMetro : double;
  VpfQtdMetros : Double;
begin
  // indice para calculo de qdade / valor *
  VpfIndice := ConvUnidade.Indice(UnidadeAtual,UnidadePadrao,StrToInt(SequencialProduto),varia.CodigoEmpresa);
  if VpfIndice = 0 then
    result := 0
  else
  begin
    if (UnidadeAtual = varia.UnidadeCX ) or (UnidadeAtual =  varia.UnidadeUN ) then
      result := ArredondaDecimais((QdadeVendida * VpfIndice),4)
    else
    if (UnidadePadrao = varia.UnidadeBarra ) and (unidadeAtual <> Varia.UnidadeBarra) then
    begin
      VpfIndiceMetro := ConvUnidade.Indice(UnidadeAtual,'mt',StrToInt(SequencialProduto),varia.CodigoEmpresa);
      VpfQtdMetros := ArredondaDecimais((QdadeVendida / VpfIndiceMetro),4);
      Result := VpfQtdMetros * VpfIndice;
    end
      else
        result := ArredondaDecimais((QdadeVendida / Vpfindice),4);
  end;
end;

{************** calcula valor do poduto para a unidade padrao do mesmo ******* }
function TFuncoesProduto.CalculaValorPadrao( unidadeAtual, UnidadePadrao : string; ValorTotal : double; SequencialProduto : string) : Double;
var
  indice : double;
begin
  // indice para calculo de qdade / valor *  indice 0.1 * 0.9 = 9 reais  0.9 preco unidade
  indice := ConvUnidade.Indice(UnidadeAtual,UnidadePadrao,StrToInt(SequencialProduto),varia.CodigoEmpresa);
  result := ArredondaDecimais((ValorTotal / indice),2)
end;

{******************************************************************************}
function TFuncoesProduto.CalculaQtdPecasemMetro(Var VpaIndice : Double;VpaAltProduto,VpaCodFaca,VpaCodMaquina,VpaCodBastidor,VpaQtdPcBastidor : Integer;VpaAltMolde,VpaLarMolde : Double) : Integer;
var
  VpfDFaca : TRBDFaca;
  VpfDBastidor : TRBDBastidor;
begin
  Result := 0;
  if VpaAltProduto = 0 then
  begin
    aviso('ALTURA DO PRODUTO NÃO PREENCHIDA!!!'#13'É necessário informar a altura do produto');
  end;
  VpfDFaca := TRBDFaca.cria;
  if VpaCodFaca <> 0 then
  begin
    ExisteFaca(VpaCodFaca,VpfDFaca);
    result:= RQtdPecaemMetro(VpaAltProduto,100,VpfDFaca.QtdProvas,VpfDFaca.AltFaca,VpfDFaca.LarFaca,false,VpaIndice);
  end
  else
    if VpaCodMaquina <> 0 then
    begin
      VpfDBastidor := TRBDBastidor.cria;
      ExisteBastidor(VpaCodBastidor,VpfDBastidor);
      result := RQtdPecaemMetro(VpaAltProduto,100,VpaQtdPcBastidor,VpfDBastidor.AltBastidor,VpfDBastidor.LarBastidor,false,VpaIndice);
      VpfDBastidor.free;
    end
    else
    if (VpaLarMolde <> 0 )and
       (VpaAltMolde <> 0) then
    begin
      result:= RQtdPecaemMetro(VpaAltProduto,100,1,VpaAltMolde,VpaLarMolde,false,VpaIndice);
    end;
  VpfDFaca.free;
end;

{********************* retorna o valor pela unidade ***************************}
Function TFuncoesProduto.ValorPelaUnidade(VpaUnidadeDe,VpaUnidadePara : String;VpaSeqProduto: Integer; VpaValorUnitario : Double): Double;
begin
  if ((UpperCase(VpaUnidadeDe) = 'CX') and (UpperCase(VpaUnidadePara) = 'PC'))or ((UpperCase(VpaUnidadeDe) = 'KT') and (UpperCase(VpaUnidadePara) = 'PC')) Then
     result := VpaValorUnitario * ConvUnidade.Indice(VpaUnidadePara,VpaUnidadede,VpaSeqProduto,Varia.CodigoEmpresa)
  else
     result := VpaValorUnitario * ConvUnidade.Indice(VpaUnidadede,VpaUnidadePara,VpaSeqProduto,Varia.CodigoEmpresa)
end;


{******************************************************************************}
function  TFuncoesProduto.TextoPossuiEstoque( QdadeVendidade, QdadeEstoque : double; UnidadePadrao : string ) : Boolean;
begin
  result := true;
  if ArredondaDecimais(QdadeVendidade,2) >  ArredondaDecimais(QdadeEstoque,2)  then
    case  config.QtdNegativa of
      0 : begin
            aviso(CT_SemEstoqueTranca + FloatToStr(QdadeEstoque) + '  ' + UnidadePadrao);
            result := false;
          end;
      1 : begin
            if not confirmacao(CT_FaltaEstoque + FloatToStr(QdadeEstoque) + '  ' + UnidadePadrao) then
              result := false;
          end;
    end;
end;

{ *************** Verifica se um produto tem ou naum estoque **************** }
function TFuncoesProduto.VerificaEstoque( unidadeAtual, UnidadePadrao : string; QdadeVendida : double; VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer) : Boolean;
var
  qdadeConvertida, EstoqueProduto : Double;
begin
  QdadeConvertida := CalculaQdadePadrao( unidadeAtual, UnidadePadrao, QdadeVendida, IntTostr(VpaSeqProduto));
  EstoqueProduto := CalculaQdadeEstoqueProduto(VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  result := TextoPossuiEstoque(QdadeConvertida,EstoqueProduto, UnidadePadrao);
end;

{********* texto de qdade minima e ponto de pedido ************************** }
procedure TFuncoesProduto.TextoQdadeMinimaPedido(QdadeMin, QdadePed, QdadeBaixa : double);
begin
    // avisa quando chegar ponto de pedido ou qdade minima.
  if ( Config.AvisaQtdMinima ) and ( QdadeBaixa <= QdadeMin ) then
       aviso(CT_EstoqueProdutoMinimo)
  else
    if ( Config.AvisaQtdPedido ) and ( QdadeBaixa <= QdadePed ) then
        aviso(CT_ProdutoPontoPedido);
end;


{*************** verifica qdade de ponto de pedido ************************** }
procedure TFuncoesProduto.VerificaPontoPedido(VpaCodFilial, VpaSeqProduto,VpaCodCor,VpaCodTamanho : Integer; VpaQtdBaixar : Double );
begin
   LocalizaMovQdadeSequencial(tabela,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);

    // avisa quando chegar ponto de pedido ou qdade minima.
   TextoQdadeMinimaPedido(  tabela.FieldByName('N_QTD_MIN').AsFloat,
                            tabela.FieldByName('N_QTD_PED').AsFloat,
                           ( ArredondaDecimais(tabela.FieldByName('N_QTD_PRO').AsFloat - VpaQtdBaixar,2) ));
end;

{ *************** efetua baixa de estoque ************************************ }
function TFuncoesProduto.BaixaProdutoEstoque( VpaDProduto : TRBDProduto;VpaCodFilial, VpaCodOperacao,VpaSeqNotaF, VpaNroNota,VpaLanOrcamento, VpaCodigoMoeda, VpaCodCor,VpaCodTamanho : Integer;
                                              VpaDataMov : TdateTime; VpaQdadeVendida, VpaValorTotal : Double;
                                              VpaunidadeAtual, VpaNumSerie : string; VpaNotaFornecedor : Boolean;Var VpaSeqBarra : Integer;VpaGerarMovimentoEstoque : Boolean = true;VpaCodTecnico : Integer = 0;
                                              VpaSeqOrdemProducao : Integer = 0) : Boolean;
var
  VpfQdadeBaixa,VpfQtdInicialEstoque,VpfQtdFinalEstoque : double;
  VpfCodFilialParametro, VpfLaco : Integer;
  VpfCifrao: string;
  VpfValCusto : double;
  VpfBaixouMovimento : Boolean;
  VpfDOperacaoEstoque : TRBDOperacaoEstoque;
  VpfResultado : String;
  VpfDProdutoKit : TRBDProduto;
  VpfDConsumoMP : TRBDConsumoMP;
begin
  // qdade conforme unidade
  VpfQdadeBaixa := CalculaQdadePadrao( VpaunidadeAtual, VpaDProduto.CodUnidade, VpaQdadeVendida, IntTostr(VpaDProduto.SeqProduto));

  if VpaDProduto.IndKit then
  begin
    CarConsumoProduto(VpaDProduto,VpaCodCor);
    for vpflaco := 0 to VpaDProduto.ConsumosMP.Count - 1 do
    begin
      VpfDConsumoMP := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLaco]);
      VpfDProdutoKit := TRBDProduto.cria;
      CarDProduto(VpfDProdutoKit,0,VpaCodFilial,VpfDConsumoMP.SeqProduto);
      BaixaProdutoEstoque(VpfDProdutoKit,VpaCodFilial,VpaCodOperacao,VpaSeqNotaF,
                          VpaNroNota,VpaLanOrcamento,VpaCodigoMoeda,VpaCodCor,
                          VpaCodTamanho,VpaDataMov,VpfQdadeBaixa * VpfDConsumoMP.QtdProduto,
                          0,VpfDConsumoMP.UM,VpaNumSerie,VpaNotaFornecedor,VpaSeqBarra,VpaGerarMovimentoEstoque,
                          VpaCodTecnico,VpaSeqOrdemProducao);
    end;
    exit;
  end;

  VpfCodFilialParametro := VpaCodFilial;
  if config.EstoqueCentralizado then
    VpaCodFilial := Varia.CodFilialControladoraEstoque;
   // informacoes sobre a operacao estoque
  result := true;
  VpfDOperacaoEstoque := TRBDOperacaoEstoque.cria;
  CarDOperacaoEstoque(VpfDOperacaoEstoque,VpaCodOperacao);

  VpfQdadeBaixa := CalculaQdadePadrao( VpaunidadeAtual, VpaDProduto.CodUnidade, VpaQdadeVendida, IntTostr(VpaDProduto.SeqProduto));


  // coloca o produto em ativade
  if not VpaDProduto.IndProdutoAtivo then
    ColocaProdutoEmAtividade(IntToStr(VpaDProduto.SeqProduto));

  // valor conforme moeda
  VpaValorTotal := UnMoeda.ConverteValor( VpfCifrao, VpaCodigoMoeda, VpaDProduto.CodMoeda, VpaValorTotal );

  //posiciona a tabela de movqdadeproduto
  LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaDProduto.SeqProduto,VpaCodCor,VpaCodTamanho);
  if ProCadastro.eof then
  begin
    InsereProdutoFilial(VpaDProduto.SeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,0,0);
    LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaDProduto.SeqProduto,VpaCodCor,VpaCodTamanho);
  end;

  ProCadastro.Edit;

  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;
  VpfValCusto := ProCadastro.FieldByname('N_VLR_CUS').AsFloat;

  VpfQtdInicialEstoque := ProCadastro.FieldByName('N_QTD_PRO').AsFloat;
  // atualiza a qdade produtos em estoque
  if  VpfDOperacaoEstoque.DesTipo_E_S = 'E' then  // entrada de produto
    ProCadastro.FieldByName('N_QTD_PRO').AsFloat := ProCadastro.FieldByName('N_QTD_PRO').AsFloat + VpfQdadeBaixa
  else  // saida de produto
    ProCadastro.FieldByName('N_QTD_PRO').AsFloat := ProCadastro.FieldByName('N_QTD_PRO').AsFloat - VpfQdadeBaixa;

  VpfQtdFinalEstoque := ProCadastro.FieldByName('N_QTD_PRO').AsFloat;
  ProCadastro.post;
  if ProCadastro.AErronaGravacao then
    aviso(ProCadastro.AMensagemErroGravacao);
  ProCadastro.close;
  // inseri novo registro na movimentacao de estoque.
  if VpaGerarMovimentoEstoque then
  begin
    VpfBaixouMovimento := false;
{     Não é para excluir uma movimentação para não perder o hitorico.
    if VpaCodOperacao = varia.OperacaoEstoqueEstornoEntrada then
    begin
      AdicionaSQLAbreProCadastro(ProCadastro, ' Select * From MovEstoqueProdutos '+
                                    ' Where I_NRO_NOT = '+IntToStr(VpaNroNota)+
                                    ' and I_SEQ_PRO = '+ IntToStr(VpaSequencialProduto)+
                                    ' AND I_NOT_SAI IS NULL '+
                                    ' AND I_NOT_ENT IS NULL'+
                                    ' and N_QTD_MOV = '+SubstituiStr(FloatToStr(VpaQdadeVendida),',','.')+
                                    ' AND C_COD_UNI = '''+VpaunidadeAtual+''''+
                                    ' AND C_TIP_MOV = ''S''');
      if not ProCadastro.Eof then
        if ProCadastro.FieldByName('D_DAT_MOV').AsDateTime > Varia.DataUltimoFechamento then
        begin
          ProCadastro.Delete;
          vpfBaixouMovimento := true;
        end;
    end
    else}
    begin
      AdicionaSQLAbreTabela(ProCadastro, ' Select * From MovEstoqueProdutos '+
                                         ' WHERE I_EMP_FIL = 0 '+
                                         ' AND I_LAN_EST = 0 '+
                                         ' AND I_SEQ_PRO = 0');
    end;
    if not VpfBaixouMovimento then
    begin
      ProCadastro.Insert;
      ProCadastro.FieldByName('I_EMP_FIL').AsInteger := VpfCodFilialParametro;
      ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpaDProduto.SeqProduto;
      ProCadastro.FieldByName('I_COD_OPE').AsInteger := VpaCodOperacao;
      ProCadastro.FieldByName('D_DAT_MOV').AsDateTime := VpaDataMov;
      ProCadastro.FieldByName('N_QTD_MOV').AsFloat := VpaQdadeVendida;
      ProCadastro.FieldByName('N_QTD_INI').AsFloat := VpfQtdInicialEstoque;
      ProCadastro.FieldByName('N_QTD_FIN').AsFloat := VpfQtdFinalEstoque;
      ProCadastro.FieldByName('C_TIP_MOV').AsString := VpfDOperacaoEstoque.DesTipo_E_S;
      ProCadastro.FieldByName('N_VLR_MOV').AsFloat := VpaValorTotal;
      ProCadastro.FieldByName('D_DAT_CAD').AsDateTime := date;
      ProCadastro.FieldByName('C_COD_UNI').AsString := VpaunidadeAtual;
      ProCadastro.FieldByName('I_COD_COR').AsInteger := VpaCodCor;
      if VpaCodTamanho <> 0 then
        ProCadastro.FieldByName('I_COD_TAM').AsInteger := VpaCodTamanho;
      if VpaCodTecnico <> 0 then
        ProCadastro.FieldByName('I_COD_TEC').AsInteger := VpaCodTecnico;
      if VpaSeqOrdemProducao <> 0 then
        ProCadastro.FieldByName('I_SEQ_ORD').AsInteger := VpaSeqOrdemProducao;
      ProCadastro.FieldByName('N_VLR_CUS').AsFloat := CalculaValorPadrao(VpaunidadeAtual,VpaDProduto.CodUnidade,VpfValCusto * VpaQdadeVendida,IntToStr(VpaDProduto.SeqProduto));
      if VpaNumSerie <> '' then
        ProCadastro.FieldByName('C_PRO_REF').AsString := VpaNumSerie;

      if VpaNroNota <> 0 then
        ProCadastro.FieldByName('I_NRO_NOT').AsInteger := VpaNroNota;
      if VpaLanOrcamento <> 0 then
        ProCadastro.FieldByName('I_LAN_ORC').AsInteger := VpaLanOrcamento;

      if VpaSeqNotaF <> 0 then
      begin
        if VpaNotaFornecedor then
          ProCadastro.FieldByName('I_NOT_ENT').AsInteger := VpaSeqNotaF
        else
          ProCadastro.FieldByName('I_NOT_SAI').AsInteger := VpaSeqNotaF;
      end;
      try
        ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', varia.CodigoEmpFil, false,ProCadastro.ASQLConnection );
        ProCadastro.post;
      except
        // caso erro na ProCadastro de codigos sequencial a o proximo do movProCadastro
        ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', varia.CodigoEmpFil, true,ProCadastro.ASQLConnection );
        ProCadastro.post;
      end;
    end;
  end;
  //Atualiza as qtd dos kit's
//    AtualizaQtdKit(IntToStr(SequencialProduto),false);
  VpfResultado := BaixaEstoqueTecnicoouConsumoFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaDProduto.SeqProduto,VpaCodCor,VpaCodTecnico,0,VpfQdadeBaixa,VpfDOperacaoEstoque.DesTipo_E_S,VpaDProduto.CodUnidade);
  if VpfResultado = '' then
  begin
    VpfResultado := BaixaEstoqueBarra(VpaDProduto.SeqProduto,VpaCodCor,VpaSeqBarra,VpaQdadeVendida,VpaunidadeAtual,VpaDProduto.CodUnidade,VpfDOperacaoEstoque.DesTipo_E_S);
  end;

  VpfDOperacaoEstoque.free;
  ProCadastro.close;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;


{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueFiscal(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaUnidadeAtual,vpaUnidadePadrao, VpaTipoOperacao : String) : String;
var
  VpfQtdBaixa : Double;
begin
  result := '';
  if config.EstoqueCentralizado then
  VpaCodFilial := Varia.CodFilialControladoraEstoque;

  VpfQtdBaixa := CalculaQdadePadrao( VpaunidadeAtual, VpaUnidadePadrao, VpaQtdProduto, IntTostr(VpaSeqProduto));

  LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  if ProCadastro.eof then
  begin
    InsereProdutoFilial(VpaSeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,0,0);
    LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  end;
  ProCadastro.Edit;

  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

  // atualiza a qdade produtos em estoque
  if  VpaTipoOperacao = 'E' then  // entrada de produto
   ProCadastro.FieldByName('N_QTD_FIS').AsFloat := ProCadastro.FieldByName('N_QTD_FIS').AsFloat + VpfQtdBaixa
  else  // saida de produto
    ProCadastro.FieldByName('N_QTD_FIS').AsFloat := ProCadastro.FieldByName('N_QTD_FIS').AsFloat - VpfQtdBaixa;
  ProCadastro.post;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueTecnicoouConsumoFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqProduto,VpaCodCor,VpaCodTecnico,VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaTipOperacao,VpaDesUM : String) : string;
begin
  AdicionaSQLAbreTabela(AUX,'Select C_IND_FER from CADCLASSIFICACAO CLA, CADPRODUTOS PRO '+
                              ' Where PRO.I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                              ' and PRO.I_COD_EMP = CLA.I_COD_EMP '+
                              ' and PRO.C_COD_CLA = CLA.C_COD_CLA '+
                              ' and PRO.C_TIP_CLA = CLA.C_TIP_CLA ');
  if AUX.FieldByName('C_IND_FER').AsString = 'S' then //so adiciona para o estoque do tecnico as ferramentas
    result := BaixaEstoqueTecnico(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTecnico,VpaCodTamanho,VpaQtdProduto,VpaTipOperacao)
  else
    result := BaixaConsumoFracaoOP(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqProduto,VpaCodCor,VpaQtdProduto,VpaDesUM,VpaTipOperacao);

end;
{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueTecnico(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTecnico,VpaCodTamanho : Integer;VpaQtdProduto : Double;VpaTipOperacao : String) : string;
begin
  if VpaCodTecnico <> 0 then
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from ESTOQUETECNICO '+
                                      ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                      ' and CODTECNICO = '+IntToStr(VpaCodTecnico)+
                                      ' and SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                                      ' and CODCOR = '+IntToStr(VpaCodCor)+
                                      ' and CODTAMANHO = '+IntToStr(VpaCodTamanho));
    if ProCadastro.Eof then
    begin
      ProCadastro.insert;
      ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
      ProCadastro.FieldByName('CODTECNICO').AsInteger := VpaCodTecnico;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
      ProCadastro.FieldByName('CODCOR').AsInteger := VpaCodCor;
      ProCadastro.FieldByName('CODTAMANHO').AsInteger := VpaCodTamanho;
    end
    else
      ProCadastro.Edit;

    if VpaTipOperacao = 'S' then //esta saindo do estoque e entrando no estoque do tecnico por isso a operação será sempre o contrario .
      ProCadastro.FieldByName('QTDPRODUTO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat + VpaQtdProduto
    else
      ProCadastro.FieldByName('QTDPRODUTO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat - VpaQtdProduto;
    ProCadastro.FieldByName('DATALTERACAO').AsDateTime := now;
    try
      ProCadastro.post;
    except
      on e : exception do result := 'ERRO NA GRAVAÇÃO DO ESTOQUE DO TECNICO!!!'#13+e.message;
    end;
    ProCadastro.close;
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueDefeito(VpaSeqProduto,VpaCodTecnico : Integer;VpaQtdProduto : Double;VpaDesUM, VpaDesOperacaoEstoque, VpaDesDefeito : string):string;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTODEFEITO ');
  ProCadastro.Insert;
  ProCadastro.FieldByName('DATMOVIMENTO').AsDateTime := now;
  ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
  ProCadastro.FieldByName('QTDPRODUTO').AsFloat := VpaQtdProduto;
  ProCadastro.FieldByName('DESUM').AsString := VpaDesUM;
  ProCadastro.FieldByName('CODTECNICO').AsInteger := VpaCodTecnico;
  ProCadastro.FieldByName('DESDEFEITO').AsString := VpaDesDefeito;
  ProCadastro.FieldByName('DESOPERACAOESTOQUE').AsString := VpaDesOperacaoEstoque;
  ProCadastro.FieldByName('SEQDEFEITO').AsInteger := RSeqDefeitoDisponivel;
  try
    ProCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO PRODUTODEFEITO!!!'#13+e.message;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaEstoqueBarra(VpaSeqProduto,VpaCodCor,VpaSeqBarra : Integer;VpaQtdProduto : Double;VpaDesUM, VpaDesUMOriginal, VpaDesOperacaoEstoque : string):string;
var
  VpfQtdBarras, VpfQtdMetrosBarra, VpfQtdBaixar : Double;
  VpfSeqBarra : Integer;
begin
  result := '';
  if UpperCase(VpaDesUMOriginal) = UPPERCASE(VARIA.UnidadeBarra) Then
  begin
    if VpaDesUM <> varia.UnidadeBarra then
      VpfQtdBarras := 1
    else
      VpfQtdBarras := VpaQtdProduto;
    if VpaDesUM = varia.UnidadeBarra then
      VpfQtdMetrosBarra := RQtdMetrosBarraProduto(VpaSeqProduto);
    while (VpfQtdBarras > 0) and (Result = '') do
    begin
      AdicionaSQLAbreTabela(ProCadastro,'Select * from ESTOQUEBARRA '+
                                        ' Where SEQPRODUTO = '+ IntToStr(VpaSeqProduto)+
                                        ' AND CODCOR = '+IntToStr(VpaCodCor)+
                                        ' AND SEQBARRA = '+IntToStr(VpaSeqBarra));
      if ProCadastro.Eof then
        ProCadastro.Insert
      else
        ProCadastro.Edit;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
      ProCadastro.FieldByName('CODCOR').AsInteger := VpaCodCor;

      if VpaDesUM = varia.UnidadeBarra then
      begin
        if VpfQtdBarras >= 1 then
          VpfQtdBaixar := VpfQtdMetrosBarra
        else
          VpfQtdBaixar := (VpfQtdMetrosBarra * VpfQtdBarras);
      end
      else
        VpfQtdBaixar := CalculaQdadePadrao(VpaDesUM,'mt',VpaQtdProduto,IntToStr(VpaSeqProduto));
      if VpaDesOperacaoEstoque = 'E' then
        ProCadastro.FieldByName('QTDMETRO').AsFloat := ProCadastro.FieldByName('QTDMETRO').AsFloat+ VpfQtdBaixar
      else
        ProCadastro.FieldByName('QTDMETRO').AsFloat := ProCadastro.FieldByName('QTDMETRO').AsFloat- VpfQtdBaixar;

      if ProCadastro.State = dsinsert then
        ProCadastro.FieldByName('SEQBARRA').AsInteger := RSeqBarraDisponivel(VpaSeqProduto);

      if ProCadastro.FieldByName('QTDMETRO').AsFloat <= 0 then
      begin
        if (ProCadastro.State = dsedit) then
        begin
          ProCadastro.cancel;
          ProCadastro.delete;
        end
        else
          ProCadastro.cancel;
      end
      else
      begin
        try
          ProCadastro.Post;
        except
          on e : exception do result := 'ERRO NA GRAVAÇÃO DO ESTOQUE DE BARRAS!!!'#13+e.message;
        end;
      end;
      VpfQtdBarras := VpfQtdBarras - 1;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaConsumoFracaoOP(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):string;
begin
  result := '';
  if VpaSeqOrdemProducao <> 0 then
  begin
    if VpaTipOperacao = 'S' then
      BaixaSubmontagemFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqProduto,VpaCodCor,VpaQtdProduto,VpaUM,VpaTipOperacao);
    if VpaQtdProduto > 0 then
    begin
      ProCadastro.close;
      ProCadastro.sql.clear;
      ProCadastro.sql.add('Select * from FRACAOOPCONSUMO '+
                                        ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                        ' and SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                                        ' and SEQPRODUTO = '+IntToStr(VpaSeqProduto));
      if VpaTipOperacao = 'S' then
        ProCadastro.sql.add(' and INDBAIXADO = ''N''')
      else
        ProCadastro.sql.add(' and QTDBAIXADO > 0');
      if VpaCodCor <> 0 then
        ProCadastro.sql.add('and CODCOR = '+IntToStr(VpaCodCor))
      else
        ProCadastro.sql.add('and CODCOR IS NULL');
      ProCadastro.sql.add('order by INDMATERIALEXTRA DESC');
      ProCadastro.Open;
      while not ProCadastro.eof and (VpaQtdProduto > 0) and (result = '') do
      begin
        ProCadastro.Edit;
        VpaQtdProduto := CalculaQdadePadrao(VpaUM,ProCadastro.FieldByName('DESUM').AsString,VpaQtdProduto,IntToStr(VpaSeqProduto));
        VpaUM := ProCadastro.FieldByName('DESUM').AsString;
        if VpaTipOperacao = 'S' then
        begin
          if VpaQtdProduto > (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat) then
          begin
            VpaQtdProduto := VpaQtdProduto - (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat);
            ProCadastro.FieldByName('QTDBAIXADO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat;
            ProCadastro.FieldByName('INDBAIXADO').AsString := 'S';
          end
          else
            if VpaQtdProduto <= (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat) then
            begin
              ProCadastro.FieldByName('QTDBAIXADO').AsFloat := ProCadastro.FieldByName('QTDBAIXADO').AsFloat + VpaQtdProduto;
              VpaQtdProduto := 0;
            end;
        end
        else
          if VpaTipOperacao = 'E' then
          begin
            if VpaQtdProduto >= (ProCadastro.FieldByName('QTDBAIXADO').AsFloat) then
            begin
              VpaQtdProduto := VpaQtdProduto - (ProCadastro.FieldByName('QTDBAIXADO').AsFloat);
              ProCadastro.FieldByName('QTDBAIXADO').AsFloat := 0;
              ProCadastro.FieldByName('INDBAIXADO').AsString := 'N';
            end
            else
              if VpaQtdProduto < (ProCadastro.FieldByName('QTDBAIXAD0').AsFloat) then
              begin
                ProCadastro.FieldByName('QTDBAIXADO').AsFloat := ProCadastro.FieldByName('QTDBAIXADO').AsFloat - VpaQtdProduto;
                VpaQtdProduto := 0;
              end;
          end;
        try
          //estorno de um produto extra enviado para a maquina, tem que excluir o material extra;
          if (ProCadastro.FieldByName('INDMATERIALEXTRA').AsString = 'S') and
             (ProCadastro.FieldByName('QTDBAIXADO').AsFloat = 0) then
          begin
            ProCadastro.cancel;
            ProCadastro.Delete;
          end
          else
          ProCadastro.post;
        except
          on e : exception do result := 'ERRO NA GRAVAÇÃO DA FRACAOOPCONSUMO!!!'#13+e.message;
        end;
        ProCadastro.next;
      end;
      ProCadastro.close;
      if result = '' then
      begin
        if VpaQtdProduto > 0 then
        begin
          if VpaTipOperacao = 'S' Then
            result := AdicionaConsumoExtraFracaoOP(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqProduto,VpaCodCor,VpaQtdProduto,VpaUM,VpaTipOperacao)
          else
            BaixaSubmontagemFracao(VpaCodFilial,VpaSeqOrdemProducao,VpaSeqProduto,VpaCodCor,VpaQtdProduto,VpaUM,VpaTipOperacao);
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaQtdAReservarProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho: Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao :String):string;
var
  VpfQtdAReservar : Double;
begin
  result := '';

  if config.EstoqueCentralizado then
    VpaCodFilial := Varia.CodFilialControladoraEstoque;

  VpfQtdAReservar := CalculaQdadePadrao( VpaunidadeAtual, VpaUnidadePadrao, VpaQtdProduto, IntTostr(VpaSeqProduto));

  LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  if ProCadastro.eof then
  begin
    InsereProdutoFilial(VpaSeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,0,0);
    LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  end;
  ProCadastro.Edit;

  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

  // atualiza a qdade produtos em estoque
  if  VpaTipOperacao = 'E' then  // adiciona o produto reservado e diminui a quantidade de estoque
   ProCadastro.FieldByName('N_QTD_ARE').AsFloat := ProCadastro.FieldByName('N_QTD_ARE').AsFloat + VpfQtdAReservar
  else  // diminui a quantidade reservado e aumenta a quantidade de estoque
   ProCadastro.FieldByName('N_QTD_ARE').AsFloat := ProCadastro.FieldByName('N_QTD_ARE').AsFloat - VpfQtdAReservar;
  ProCadastro.post;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaQtdReservadoOP(VpaCodFilial, VpaSeqProduto, VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao: Integer; VpaQtdProduto: Double; VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao: String): string;
var
  VpfQtdInicial, VpfQtdAReservarBaixada : Double;
  VpfUmInicial,VpfOperacaoQtdAReservar : String;
begin
  result :='';
  VpfQtdInicial := VpaQtdProduto;
  VpfUmInicial := VpaUnidadeAtual;
  VpfQtdAReservarBaixada := 0;
  AdicionaSQLAbreTabela(ProCadastro,'Select * from FRACAOOPCONSUMO '+
                                    ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                    ' AND SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                                    ' AND SEQPRODUTO = '+ IntToStr(VpaSeqProduto)+
                                    ' ORDER BY SEQFRACAO ');
  while not(ProCadastro.Eof) and
        (result = '') and
        (VpaQtdProduto > 0)  do
  begin
    if ((ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat
       - ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat) > 0) then
    begin
      VpaQtdProduto := CalculaQdadePadrao( VpaunidadeAtual,ProCadastro.FieldByName('DESUM').AsString, VpaQtdProduto, IntTostr(VpaSeqProduto));
      VpaunidadeAtual := ProCadastro.FieldByName('DESUM').AsString;
      ProCadastro.Edit;
      if VpaQtdProduto >= (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat
       - ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat) THEN
      begin
        VpfQtdAReservarBaixada := VpfQtdAReservarBaixada + ProCadastro.FieldByName('QTDARESERVAR').AsFloat;
        ProCadastro.FieldByName('QTDARESERVAR').AsFloat := 0;
        VpaQtdProduto := VpaQtdProduto - (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat- ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat);
        ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDBAIXADO').AsFloat;
      end
      else
      begin
        if VpaQtdProduto > ProCadastro.FieldByName('QTDARESERVAR').AsFloat then
          VpfQtdAReservarBaixada := VpfQtdAReservarBaixada + ProCadastro.FieldByName('QTDARESERVAR').AsFloat
        else
          VpfQtdAReservarBaixada := VpfQtdAReservarBaixada + VpaQtdProduto;

        ProCadastro.FieldByName('QTDARESERVAR').AsFloat := ProCadastro.FieldByName('QTDARESERVAR').AsFloat-VpaQtdProduto;
        if ProCadastro.FieldByName('QTDARESERVAR').AsFloat < 0  then
          ProCadastro.FieldByName('QTDARESERVAR').AsFloat := 0;
        ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat := ProCadastro.FieldByName('QTDRESERVADAESTOQUE').AsFloat +VpaQtdProduto;
      end;
      ProCadastro.post;
      result := ProCadastro.AMensagemErroGravacao;
    end;
    ProCadastro.next;
  end;
  if result = '' then
  begin
    if VpaQtdProduto > 0  then
    begin
      Result := GravaProdutoReservadoEmExcesso(VpaSeqProduto,VpaCodFilial,VpaSeqOrdemProducao,VpfUmInicial,0,VpfQtdInicial,VpaQtdProduto);
    end;
    if result = ''  then
    begin
      if VpaTipOperacao = 'E' then
        VpfOperacaoQtdAReservar := 'S'
      ELSE
        VpfOperacaoQtdAReservar := 'E';
      result := BaixaQtdAReservarProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho,VpfQtdAReservarBaixada,VpaUnidadeAtual,
                                        VpaUnidadePadrao,VpfOperacaoQtdAReservar);
    end;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ReservaEstoqueProduto(VpaCodFilial,VpaSeqProduto,VpaCodCor, VpaCodTamanho, VpaSeqOrdemProducao : Integer; VpaQtdProduto : Double;VpaUnidadeAtual,VpaUnidadePadrao, VpaTipOperacao :String):string;
var
  VpfQtdReservar, VpfQtdInicial : Double;
begin
  result := '';

  if config.EstoqueCentralizado then
    VpaCodFilial := Varia.CodFilialControladoraEstoque;

  VpfQtdReservar := CalculaQdadePadrao( VpaunidadeAtual, VpaUnidadePadrao, VpaQtdProduto, IntTostr(VpaSeqProduto));

  LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  if ProCadastro.eof then
  begin
    InsereProdutoFilial(VpaSeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,0,0);
    LocalizaMovQdadeSequencial(ProCadastro,VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho);
  end;
  ProCadastro.Edit;
  VpfQtdInicial := ProCadastro.FieldByName('N_QTD_RES').AsFloat;

  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

  // atualiza a qdade produtos em estoque
  if  VpaTipOperacao = 'E' then  // adiciona o produto reservado
  begin
    ProCadastro.FieldByName('N_QTD_RES').AsFloat := ProCadastro.FieldByName('N_QTD_RES').AsFloat + VpfQtdReservar;
    if ProCadastro.FieldByName('N_QTD_RES').AsFloat > ProCadastro.FieldByName('N_QTD_PRO').AsFloat then
      result := GravaProdutoReservadoEmExcesso(VpaSeqProduto,0,0,VpaUnidadeAtual,ProCadastro.FieldByName('N_QTD_PRO').AsFloat,VpaQtdProduto,0);
  end
  else  // diminui a quantidade reservado
  begin
    ProCadastro.FieldByName('N_QTD_RES').AsFloat := ProCadastro.FieldByName('N_QTD_RES').AsFloat - VpfQtdReservar;
  end;
  ProCadastro.post;
  Result := ProCadastro.AMensagemErroGravacao;

  if Result = ''  then
    result := GravaMovimentoProdutoReservado(VpaSeqProduto,VpaCodFilial,VpaSeqOrdemProducao,VpaUnidadeAtual, VpaQtdProduto,VpfQtdInicial,ProCadastro.FieldByName('N_QTD_RES').AsFloat,VpaTipOperacao);

  if result = ''  then
  begin
    if VpaSeqOrdemProducao <> 0 then
      Result := BaixaQtdReservadoOP(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpaCodTamanho,VpaSeqOrdemProducao,VpaQtdProduto,VpaUnidadeAtual,VpaUnidadePadrao,VpaTipOperacao);
  end;
  ProCadastro.close;
end;

{************************ atualiza a qtd do kit *******************************}
function TFuncoesProduto.AtualizaQtdKit(VpaSeqProduto : String;VpaKit :Boolean):Boolean;
Var
  VpfKits : TStringList;
  VpfLaco : Integer;
begin
  // cria a lista de string que contera os codigos dos kits que serão atualizados
  VpfKits := TStringList.Create;
  VpfKits.CLEAR;

   //carrega os kit's que serao atualizados
  if VpaKit then
    VpfKits.Add(VpaSeqProduto)
  else
  begin
    CKitsProdutos(VpaSeqProduto,VpfKits);
  end;

  //atualiza a quantidade de estoque dos kit's
  for VpfLaco := 0 to VpfKits.Count -1 do
  begin
    ExecutaComandoSql(AUX,'update MOVQDADEPRODUTO MOV '+
                    ' set MOV.N_QTD_PRO = (select min(QTD.N_QTD_PRO / KIT.N_QTD_PRO) QDADE '+
                    ' FROM MOVQDADEPRODUTO QTD, MOVKIT KIT '+
                    ' WHERE KIT.I_SEQ_PRO = QTD.I_SEQ_PRO '+
                    ' AND KIT.I_PRO_KIT = '+ VpfKits.Strings[VpfLaco] +
                    ' AND KIT.I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa) +
                    ' AND  QTD.I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil) +')'+
                    ' WHERE I_SEQ_PRO = '+ VpfKits.Strings[VpfLaco] +
                    ' AND I_EMP_FIL = ' +IntToStr(Varia.CodigoEmpFil));
  end;
  VpfKits.free;
  result := true;
end;

{******************************************************************************}
function TFuncoesProduto.EstornaEstoque(VpaDMovimento : TRBDMovEstoque) : String;
var
  VpfQtdEstorno : double;
begin
  result := OperacoesEstornoValidas;
  if result = '' then
  begin
    if VpaDMovimento.SeqProduto <> 0 then
    begin
      // localiza o produto
      LocalizaProdutoSequencial(calcula, IntToStr(VpaDMovimento.SeqProduto));
      VpfQtdEstorno := CalculaQdadePadrao(VpaDMovimento.CodUnidade,
                                         Calcula.fieldByName('C_COD_UNI').AsString,
                                         VpaDMovimento.QtdProduto,
                                          IntTostr(VpaDMovimento.SeqProduto) );
      Calcula.close;
      LocalizaMovQdadeSequencial(ProCadastro,VpaDMovimento.CodFilial,VpaDMovimento.SeqProduto ,VpaDMovimento.CodCor,VpaDMovimento.CodTamanho);

       // atualiza a qdade produtos
      ProCadastro.Edit;

      if  VpaDMovimento.TipMovimento = 'S' then  // entrada de produto
        Procadastro.FieldByName('N_QTD_PRO').AsFloat := ProCadastro.FieldByName('N_QTD_PRO').AsFloat + VpfQtdEstorno
      else  // saida de produto
        ProCadastro.FieldByName('N_QTD_PRO').AsFloat := ProCadastro.FieldByName('N_QTD_PRO').AsFloat - VpfQtdEstorno;

      //atualiza a data de alteracao para poder exportar
      Procadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

      ProCadastro.post;
      ProCadastro.Close;

      if VpaDMovimento.DatMovimento > varia.DataUltimoFechamento then
        ExcluiMovimentoEstoque(VpaDMovimento.CodFilial,VpaDMovimento.LanEstoque,VpaDMovimento.SeqProduto)
      else
      begin
        VpaDMovimento.LanEstoque := 0;
        VpaDMovimento.DatMovimento := Date;
        if VpaDMovimento.TipMovimento = 'S' then
        begin
          VpaDMovimento.TipMovimento := 'E';
          VpaDMovimento.CodOperacaoEstoque := varia.OperacaoEstoqueEstornoEntrada;
        end
        else
        begin
          VpaDMovimento.TipMovimento := 'S';
          VpaDMovimento.CodOperacaoEstoque := varia.OperacaoEstoqueEstornoSaida;
        end;
        result := GravaDMovimentoEstoque(VpaDMovimento);
      end;
    end;
  end;
end;

{************ insere um novo produto na tabela de preco ***********************}
function TFuncoesProduto.AdicionaProdutoNaTabelaPreco(VpaCodTabela: Integer; VpaDProduto: TRBDProduto;VpaCodTamanho, VpaCodCor : Integer): String;
begin
  LocalizaCadTabelaPreco(Tabela, VpaCodTabela);
  if not Tabela.Eof then
  begin
    AdicionaSQLAbreTabela(ProCadastro,'SELECT *'+
                                      ' FROM MOVTABELAPRECO'+
                                      ' WHERE I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                                      ' AND I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                                      ' AND I_COD_TAB = '+IntToStr(VpaCodTabela)+
                                      ' AND I_COD_CLI = 0 '+
                                      ' AND I_COD_TAM = 0');
    if ProCadastro.Eof then
      ProCadastro.Insert
    else
      ProCadastro.Edit;
    ProCadastro.FieldByName('I_COD_EMP').AsInteger:= Varia.CodigoEmpresa;
    ProCadastro.FieldByName('I_COD_TAB').AsInteger:= VpaCodTabela;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger:= VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger:= VpaCodTamanho;
    ProCadastro.FieldByName('I_COD_COR').AsInteger:= VpaCodCor;
    ProCadastro.FieldByName('I_COD_MOE').AsInteger:= VpaDProduto.CodMoeda;
    ProCadastro.FieldByName('N_VLR_VEN').AsFloat:= VpaDProduto.VlrVenda;
    ProCadastro.FieldByName('N_VLR_REV').AsFloat:= VpaDProduto.VlrRevenda;
    ProCadastro.FieldByName('N_PER_MAX').AsFloat:= VpaDProduto.PerMaxDesconto;
    ProCadastro.FieldByName('C_CIF_MOE').AsString:= VpaDProduto.CifraoMoeda;
    ProCadastro.FieldByName('I_COD_CLI').AsInteger:= 0;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime:= Now;
    try
      ProCadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO AO GRAVAR O PRODUTO NA TABELA DE PREÇO'#13+E.Message;
    end;
  end;
  Tabela.Close;
  ProCadastro.Close;
end;

{****************** Verifica item pertence a um kit ************************** }
function TFuncoesProduto.VerificaItemKit( codigoPro : string ) : Boolean;
begin
  AdicionaSQLAbreTabela(calcula, 'select * from MovKit where i_seq_pro = ' + codigoPro );
  result := calcula.Eof;
  FechaTabela(calcula);
end;


{********** converte a moeda de um produto na tabela de preco *****************}
procedure TFuncoesProduto.ConverteMoedaTabela( NovaMoeda, TabelaPreco, SequencialProduto : Integer );
var
  CifraoNovaTabela : string;
begin
  AdicionaSQLAbreTabela(ProCadastro, ' select * from MovTabelaPreco ' +
                                ' where i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                                ' and i_cod_tab = ' + intToStr(TabelaPreco) +
                                ' and i_seq_pro = ' + intToStr(SequencialProduto)+
                                ' and I_COD_CLI = 0 ' );
  ProCadastro.edit;
  ProCadastro.FieldByName('n_vlr_ven').AsCurrency := UnMoeda.ConverteValor( CifraoNovaTabela,ProCadastro.fieldByname('i_cod_moe').AsInteger,
                                                NovaMoeda, ProCadastro.fieldByname('n_vlr_ven').AsFloat);
  ProCadastro.fieldByName('i_cod_moe').AsInteger := NovaMoeda;
  ProCadastro.FieldByName('c_cif_moe').AsString := CifraoNovaTabela;
  ProCadastro.FieldByName('D_Ult_Alt').AsDateTime := Date;
  ProCadastro.Post;
  ProCadastro.Close;
end;


{********** converte a moeda de um produto, tabela de preco e custo, compra ***}
procedure TFuncoesProduto.ConverteMoedaProduto( NovaMoeda, TabelaPreco, SequencialProduto : Integer );
var
  MoedaAtual : Integer;
  CifraoNovaTabela : string;
begin
  AdicionaSQLAbreTabela(ProCadastro, ' select * from CadProdutos ' +
                                ' where i_cod_emp = ' + intToStr(varia.CodigoEmpresa) +
                                ' and i_seq_pro = ' + intToStr(SequencialProduto) );

  MoedaAtual := ProCadastro.fieldByName('i_cod_moe').AsInteger;

  ProCadastro.edit;
  ProCadastro.fieldbyName('i_cod_moe').AsInteger := NovaMoeda;
  ProCadastro.fieldbyName('c_cif_moe').AsString := UnMoeda.UnidadeMonetaria(NovaMoeda);
  ProCadastro.post;
  ProCadastro.close;


  AdicionaSQLAbreTabela(ProCadastro, ' select * from MovQdadeProduto ' +
                                ' where i_emp_fil = ' + intToStr(varia.CodigoEmpFil) +
                                ' and i_seq_pro = ' + intToStr(SequencialProduto) );

  ProCadastro.edit;
  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_ULT_ALT').AsDateTime := Date;

  ProCadastro.fieldbyName('n_vlr_com').AsFloat := UnMoeda.ConverteValor( CifraoNovaTabela, MoedaAtual,
                                               NovaMoeda, ProCadastro.fieldByname('n_vlr_com').AsFloat);
  ProCadastro.fieldbyName('n_vlr_cus').AsFloat := UnMoeda.ConverteValor( CifraoNovaTabela, MoedaAtual,
                                               NovaMoeda, ProCadastro.fieldByname('n_vlr_cus').AsFloat);
  ProCadastro.post;
  ProCadastro.close;
end;

{******** alterar a atividade de um produto ******************************* }
Procedure TFuncoesProduto.AlteraAtividadeProduto( SequencialProduto : integer);
begin
  LocalizaProdutoSequencial(ProCadastro, IntToStr(SequencialProduto));
  ProCadastro.edit;
  if ProCadastro.fieldByName('C_ATI_PRO').AsString = 'S' then
    ProCadastro.fieldByName('C_ATI_PRO').AsString := 'N'
  else
    ProCadastro.fieldByName('C_ATI_PRO').AsString := 'S';
  //atualiza a data de alteracao para poder exportar
  ProCadastro.FieldByname('D_Ult_Alt').AsDateTime := Date;
  ProCadastro.post;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.AlteraClassificacaoProduto(VpaSeqProduto : Integer;VpaNovaClassificacao : String) : String;
begin
  result := '';
  try
    ExecutaComandoSql(AUX,'UPDATE CADPRODUTOS '+
                        ' Set C_COD_CLA = '''+ VpaNovaClassificacao+'''' +
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
  except
    on e : exception do result := 'ERRO NA ALTERAÇÃO DA CLASSIFICAÇÃO!!!'#13+e.message;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AlteraValorVendaProduto(VpaSeqProduto, VpaCodTamanho : Integer;VpaNovoValor :Double):String;
begin
  result := '';
  try
    ExecutaComandoSql(AUX,'Update MOVTABELAPRECO ' +
                        'SET N_VLR_VEN = '+ SubstituiStr(DeletaChars(FloatToStr(VpaNovoValor),'.'),',','.') +
                        ' Where I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa)+
                        ' and I_COD_TAB = '+ IntTostr(varia.tabelaPreco)+
                        ' and I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                        ' and I_COD_TAM = '+IntToStr(VpaCodTamanho)+
                        ' and I_COD_MOE = '+ IntToStr(Varia.MoedaBase));
  except
    on e: exception do result := 'ERRO NA ATUALIZAÇÃO DO VALOR DE VENDA DO PRODUTO.'#13'Sequencial do Produto = '+IntToStr(VpaSeqProduto)+' Valor Venda = '+FloatToStr(VpaNovoValor)+#13+e.message;
  end;

end;

{******* inseri uma classificacao toda em uma determinada filial ************* }
procedure TFuncoesProduto.InseriProdutoClassificacaoFilial(Vpa_SeqPro_CodCla, VpaFilial, VpaEmpresa: string; NQtdMin, NQtdPed, VpaValCusto : Double; Classificacao : Boolean);
//var
//  VpfCodigoBarra : String;
begin
{ Colocado em comentario dia 11/05/2008  por nao saber se ainda é util
    CodBrra := TCodigoBarra.Create;
    if Classificacao then
      LocalizaSeqProdutoQdadeClassificacao(TABELA, Vpa_SeqPro_CodCla)
    else
      LocalizaProdutoSequencialQdade(tabela,Vpa_SeqPro_CodCla,'0');

    if TABELA.EOF then
      Aviso(CT_Cassificacao_Vazia)
    else
    begin
      TABELA.First;
      while not TABELA.EOF do
      begin
        VpfCodigoBarra := CodBrra.GeraCodigoBarra( MascaraBarra(TABELA.FieldByName('I_COD_BAR').AsInteger),
                                                   VpaEmpresa,
                                                   VpaFilial,
                                                   TABELA.FieldByName('C_COD_CLA').AsString,
                                                   TABELA.FieldByName('C_COD_PRO').AsString,
                                                   TABELA.FieldByName('C_COD_REF').AsString,
                                                   TABELA.FieldByName('I_SEQ_PRO').AsString,
                                                   TABELA.FieldByName('C_BAR_FOR').AsString);

        InsereProdutoFilial( TABELA.FieldByName('I_SEQ_PRO').AsInteger,
                             VpaFilial, Tabela.FieldByName('I_COD_COR').AsString, VpfCodigoBarra,  TABELA.FieldByName('I_COD_BAR').AsString,
                             NQtdMin,  NQtdPed, VpaValCusto);
        TABELA.Next;
      end;
    end;
  CodBrra.Free;}
end;

{************** inseri um produto em uma determinada filial *************** }
procedure TFuncoesProduto.InsereProdutoFilial(VpaSeqProduto, VpaCodFilial,VpaCodCor, VpaCodTamanho  : Integer;VpaQtdEstoque, VpaQtdMinima, VpaQtdPedido,VpaValCusto, VpaValCompra: Double);
begin

  // Verifica se o produto  ja existe.
  AdicionaSQLAbreTabela(AUX,' SELECT * FROM MOVQDADEPRODUTO ' +
                            ' WHERE I_EMP_FIL = ' +IntToStr(VpaCodFilial) +
                            ' AND I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' and I_COD_COR = '+ InttoStr(VpaCodCor)+
                            ' and I_COD_TAM = '+IntToStr(VpaCodTamanho));
  if AUX.EOF then // Se não existe - adiciona.
  begin
    ExecutaComandoSql(AUX,
    ' INSERT INTO MOVQDADEPRODUTO (I_EMP_FIL, I_SEQ_PRO,I_COD_COR,I_COD_TAM, N_QTD_PRO,N_QTD_FIS, N_QTD_MIN,  N_QTD_PED, N_VLR_COM, N_VLR_CUS, D_ULT_ALT ) VALUES (' +
      IntTostr(VpaCodFilial) + ',' +
      IntToStr(VpaSeqProduto) + ',' +
      IntToStr(VpaCodCor)+','+
      IntToStr(VpaCodTamanho)+','+
      SubstituiStr(FloatToStr(VpaQtdEstoque),',','.') + ',' +
      '0,' +
      SubstituiStr(FloatToStr(VpaQtdMinima),',','.') + ',' +
      SubstituiStr(FloatToStr(VpaQtdPedido),',','.') + ',' +
      SubstituiStr(FloatToStr(VpaValCompra),',','.') + ','+
      SubstituiStr(FloatToStr(VpaValCusto),',','.') + ','+
      SQLTextoDataAAAAMMMDD(DATE)+  ')');
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.InsereProdutoFilial(VpaCodFilial, VpaCodCor, VpaCodTamanho: Integer; VpaDProduto: TRBDProduto): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM MOVQDADEPRODUTO'+
                                    ' WHERE I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' AND I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                                    ' AND I_COD_COR = '+InttoStr(VpaCodCor)+
                                    ' AND I_COD_TAM = '+IntToStr(VpaCodTamanho));
  if (ProCadastro.Eof) or (VpaCodFilial = varia.CodigoEmpFil)  then
  begin
    if (ProCadastro.Eof) then
    begin
      ProCadastro.Insert;
      if (VpaCodFilial = Varia.CodigoEmpFil) then //somente coloca o estoque na filial ativa
      begin
        ProCadastro.FieldByName('N_QTD_PRO').AsFloat:= VpaDProduto.QtdEstoque;
        ProCadastro.FieldByName('N_QTD_FIS').AsFloat:= VpaDProduto.QtdEstoque;
      end
      else
      begin
        ProCadastro.FieldByName('N_QTD_PRO').AsFloat:= 0;
        ProCadastro.FieldByName('N_QTD_FIS').AsFloat:= 0;
      end;
    end
    else
      ProCadastro.Edit;

    ProCadastro.FieldByName('I_EMP_FIL').AsInteger:= VpaCodFilial;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger:= VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger:= VpaCodTamanho;
    ProCadastro.FieldByName('I_COD_COR').AsInteger:= VpaCodCor;
    ProCadastro.FieldByName('N_QTD_MIN').AsFloat:= VpaDProduto.QtdMinima;
    ProCadastro.FieldByName('N_QTD_PED').AsFloat:= VpaDProduto.QtdPedido;
    ProCadastro.FieldByName('N_VLR_COM').AsFloat:= VpaDProduto.VlrCusto;
    ProCadastro.FieldByName('N_VLR_CUS').AsFloat:= VpaDProduto.VlrCusto;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime:= Now;

    ProCadastro.Post;
    result :=  ProCadastro.AMensagemErroGravacao;
  end;

  ProCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.AdicionaProdutosFilialAtiva;
begin
  AdicionaSQLAbreTabela(Tabela,'select * from CADPRODUTOS PRO '+
                               ' where PRO.I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa)+
                               ' and not exists (select * from MOVQDADEPRODUTO QTD ' +
                               ' Where QTD.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                               ' and QTD.I_COD_COR = 0 '+
                               ' and QTD.I_COD_TAM = 0 '+
                               ' and QTD.I_EMP_FIL = '+ IntToStr(varia.CodigoEmpFil)+')');
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVQDADEPRODUTO'+
                                    ' WHERE I_EMP_FIL = 0 AND I_SEQ_PRO = 0' );
  While not Tabela.Eof do
  begin
    ProCadastro.insert;
    ProCadastro.FieldByName('I_EMP_FIL').AsInteger := varia.CodigoEmpFil;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
    ProCadastro.FieldByName('N_QTD_PRO').AsInteger := 0;
    ProCadastro.FieldByName('N_QTD_MIN').AsInteger := 0;
    ProCadastro.FieldByName('N_QTD_PED').AsInteger := 0;
    ProCadastro.FieldByName('N_VLR_CUS').AsInteger := 0;
    ProCadastro.FieldByName('I_COD_COR').AsInteger := 0;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger := 0;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := date;
    ProCadastro.Post;
    Tabela.Next;
  end;

  AdicionaSQLAbreTabela(Tabela,'select * from MOVQDADEPRODUTO PRO '+
                               ' where PRO.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil)+
                               ' and not exists (select * from MOVTABELAPRECO MOV ' +
                               ' Where MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                               ' and MOV.I_COD_TAM = PRO.I_COD_TAM '+
                               ' and MOV.I_COD_COR = PRO.I_COD_COR '+
                               ' and MOV.I_COD_TAB = '+IntToStr(VARIA.TabelaPreco)+
                               ' and MOV.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+' )');
  While not Tabela.Eof do
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVTABELAPRECO '+
                                      ' Where I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa)+
                                      ' and I_SEQ_PRO = '+Tabela.FieldByName('I_SEQ_PRO').AsString+
                                      ' and I_COD_TAB = '+IntToStr(VARIA.TabelaPreco)+
                                      ' and I_COD_TAM = '+IntToStr(Tabela.FieldByName('I_COD_TAM').AsInteger));
    if ProCadastro.eof then
    begin
      ProCadastro.Insert;
      ProCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
      ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
      ProCadastro.FieldByName('I_COD_TAM').AsInteger := Tabela.FieldByName('I_COD_TAM').AsInteger;
      ProCadastro.FieldByName('I_COD_COR').AsInteger := Tabela.FieldByName('I_COD_COR').AsInteger;
      ProCadastro.FieldByName('I_COD_TAB').AsInteger := Varia.TabelaPreco;
      ProCadastro.FieldByName('I_COD_MOE').AsInteger := Varia.MoedaBase;
      ProCadastro.FieldByName('N_VLR_VEN').AsInteger := 0;
      ProCadastro.FieldByName('N_PER_MAX').AsInteger := 0;
      ProCadastro.FieldByName('C_CIF_MOE').AsString := varia.MascaraMoeda;
      ProCadastro.FieldByName('I_COD_CLI').AsInteger := 0;
      ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := date;
      ProCadastro.Post;
    end;
    Tabela.Next;
  end;
  ProCadastro.close;
  Aviso('Produtos Adicionados com sucesso');
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.AdicionaTodasTabelasdePreco(VpaDProduto: TRBDProduto);
var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  FreeTObjectsList(VpaDProduto.TabelaPreco);
  AdicionaSQLAbreTabela(Tabela,'Select * from CADTABELAPRECO ');
  while not Tabela.eof do
  begin
    VpfDTabelaPreco := VpaDProduto.AddTabelaPreco;
    VpfDTabelaPreco.CodTabelaPreco := Tabela.FieldByName('I_COD_TAB').AsInteger;
    VpfDTabelaPreco.NomTabelaPreco := Tabela.FieldByName('C_NOM_TAB').AsString;
    VpfDTabelaPreco.CodTamanho := 0;
    VpfDTabelaPreco.CodCliente := 0;
    VpfDTabelaPreco.CodMoeda := Varia.MoedaBase;
    VpfDTabelaPreco.NomMoeda := FunContasAReceber.RNomMoeda(Varia.MoedaBase);
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.AdicionaProdutoEtiquetado(VpaEtiquetas : TList);
var
  VpfLaco : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfQtdEtiqueta : Integer;
  VpfEtiquetasPedido : TList;
begin
  VpfEtiquetasPedido := TList.create;
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOETIQUETADOCOMPEDIDO '+
                                   ' Where CODFILIAL = 0 AND LANORCAMENTO = 0 AND SEQETIQUETA = 0');
  for VpfLaco := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLaco]);
    VpfQtdEtiqueta := VpfDEtiqueta.QtdOriginalEtiquetas;
    AdicionaSQLAbreTabela(ProProduto,'Select CAD.I_EMP_FIL, CAD.I_LAN_ORC, MOV.I_SEQ_MOV, MOV.N_QTD_PRO, MOV.N_QTD_BAI '+
                              ' from CADORCAMENTOS CAD, MOVORCAMENTOS MOV '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' and CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' and CAD.I_TIP_ORC = '+IntToStr(Varia.TipoCotacaoPedido) +
                              ' and CAD.C_FLA_SIT = ''A'''+
                              ' and CAD.C_IND_CAN = ''N'''+
                              ' AND MOV.N_QTD_PRO > '+SQLTextoIsNull('MOV.N_QTD_BAI','0')+
                              ' AND MOV.I_SEQ_PRO = '+IntToStr(VpfDEtiqueta.Produto.SeqProduto)+
                              ' order by CAD.I_LAN_ORC');
    while not ProProduto.eof and (VpfQtdEtiqueta > 0) do
    begin
      VpfQtdEtiqueta := VpfQtdEtiqueta - (RetornaInteiro(ProProduto.FieldByname('N_QTD_PRO').AsFloat)- RetornaInteiro(ProProduto.FieldByname('N_QTD_BAI').AsFloat));
      ProCadastro.insert;
      if VpfQtdEtiqueta <= 0 then
      begin
        ProCadastro.FieldByname('QTDETIQUETADO').AsInteger := VpfDEtiqueta.QtdOriginalEtiquetas;
        VpfDEtiqueta.NumPedido := ProProduto.FieldByname('I_LAN_ORC').AsInteger;
        VpfDEtiqueta.IndParaEstoque :=false;
        VpfQtdEtiqueta := 0;
      end
      else
      begin
        ProCadastro.FieldByname('QTDETIQUETADO').AsInteger := RetornaInteiro(ProProduto.FieldByname('N_QTD_PRO').AsFloat)- RetornaInteiro(ProProduto.FieldByname('N_QTD_BAI').AsFloat);
        VpfEtiquetasPedido.add(REtiquetaPedido(VpfDEtiqueta,ProProduto.FieldByname('I_LAN_ORC').AsInteger,ProCadastro.FieldByname('QTDETIQUETADO').AsInteger));
      end;

      ProCadastro.FieldByname('CODFILIAL').AsInteger := ProProduto.FieldByname('I_EMP_FIL').AsInteger;
      ProCadastro.FieldByname('LANORCAMENTO').AsInteger := ProProduto.FieldByname('I_LAN_ORC').AsInteger;
      ProCadastro.FieldByname('SEQMOVIMENTO').AsInteger := ProProduto.FieldByname('I_SEQ_MOV').AsInteger;
      ProCadastro.FieldByname('DATIMPRESSAO').AsDateTime := now;
      ProCadastro.FieldByname('SEQETIQUETA').AsInteger := RSeqEtiquetadoDisponivel(ProProduto.FieldByname('I_EMP_FIL').AsInteger,ProProduto.FieldByname('I_LAN_ORC').AsInteger);
      try
        ProCadastro.post;
      except
        on e : exception do aviso('ERRO NA GRAVACAO DA PRODUTOETIQUETADOCOMPEDIDO!!!'#13+e.message);
      end;

      ProProduto.next;
    end;
  end;

  for VpfLaco := 0 to VpfEtiquetasPedido.Count - 1 do
  begin
    VpaEtiquetas.Add(VpfEtiquetasPedido.Items[VpfLAco]);
  end;

  ProCadastro.close;
  ProProduto.close;
  VpfEtiquetasPedido.free;
end;

{******************************************************************************}
function TFuncoesProduto.InsereProdutoEmpresa(VpaCodEmpresa: Integer; VpaDProduto: TRBDProduto;VpaProdutoNovo : Boolean): String;
var
  VpfLaco : Integer;
  VpfDPreco : TRBDProdutoTabelaPreco;
  VpfFiltroFilial : String;
begin
  Result:= '';
  if not VpaProdutoNovo  then
    VpfFiltroFilial :=  'and I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil);

  ExecutaComandoSql(AUX,'Delete from MOVQDADEPRODUTO '+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                        VpfFiltroFilial);
  AdicionaSQLAbreTabela(Tabela,'SELECT I_EMP_FIL '+
                               ' FROM CADFILIAIS '+
                               ' WHERE I_COD_EMP = '+IntTostr(VpaCodEmpresa)+
                               VpfFiltroFilial);
  for VpfLaco := 0 to VpaDProduto.TabelaPreco.Count - 1 do
  begin
    VpfDPreco := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLaco]);
    Tabela.close;
    Tabela.Open;
    while not Tabela.eof do
    begin
      InsereProdutoFilial(VpaDProduto.SeqProduto,Tabela.FieldByName('I_EMP_FIL').AsInteger,VpfDPreco.CodCor,VpfDPreco.CodTamanho, VpfDPreco.QtdEstoque,VpfDPreco.QtdMinima,VpfDPreco.QtdIdeal,VpfDPreco.ValCusto,VpfDPreco.ValCompra);
      Tabela.next;
    end;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesProduto.InsereProdutoEmpresa(VpaCodEmpresa: Integer; VpaSeqProduto : Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Tabela,'SELECT I_EMP_FIL '+
                               ' FROM CADFILIAIS '+
                               ' WHERE I_COD_EMP = '+IntTostr(VpaCodEmpresa));

  while not Tabela.eof do
  begin
    InsereProdutoFilial(VpaSeqProduto,Tabela.FieldByName('I_EMP_FIL').AsInteger,0,0, 0,0,0,0,0);
    Tabela.next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.InserePrecoProdutoCliente(VpaSeqProduto, VpaCodTabela, VpaCodCliente, VpaCodTamanho : Integer);
begin
  LocalizaProdutoTabelaPreco(ProCadastro, IntToStr(VpaCodTabela),
                             IntToStr(VpaSeqProduto),IntToStr(VpaCodCliente) );

  if ProCadastro.Eof then
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
    ProCadastro.FieldByName('I_COD_TAB').AsInteger := VpaCodTabela;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpaSeqproduto;
    ProCadastro.FieldByName('I_COD_MOE').Value := Varia.MoedaBase;
    ProCadastro.FieldByName('C_CIF_MOE').Value := CurrencyString;
    ProCadastro.FieldByName('I_COD_CLI').AsInteger := VpaCodCliente;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger := VpaCodTamanho;
    ProCadastro.FieldByname('D_Ult_Alt').AsDateTime :=Date;
    ProCadastro.Post;
  end;

  ProCadastro.Close;
end;
{-******************** verifica se produto existe *****************************}
function TFuncoesProduto.ExisteCodigoProduto(Var VpaSeqProduto : Integer; Var VpaCodProduto, VpaNomProduto : String) : Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select pro.I_Seq_Pro, C_Cod_Pro, '+
                            ' Pro.C_Nom_Pro'  +
                            ' from CadProdutos Pro,  '+
                            ' MovQdadeProduto Qtd ' +
                            ' Where C_COD_PRO = ''' + VpaCodProduto +''''+
                            ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                            ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro ');
  result := not Aux.eof;
  if Result then
  begin
    VpaSeqProduto := AUX.FieldByName('I_Seq_Pro').AsInteger;
    VpaCodProduto := AUX.FieldByName('C_Cod_Pro').Asstring;
    VpaNomProduto := Aux.FieldByName('C_Nom_Pro').Asstring;
  end
  else
  begin
    VpaSeqProduto := 0;
    VpaCodProduto := '';
    VpaNomProduto := '';
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteCodigoProdutoDuplicado(VpaSeqProduto : Integer;VpaCodProduto : String):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_SEQ_PRO from CADPRODUTOS '+
                           ' Where C_COD_PRO = '''+VpaCodProduto+''''+
                           ' and I_SEQ_PRO <> '+IntToStr(VpaSeqProduto));
  Result := not Aux.eof;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteNomeProduto(Var VpaSeqProduto : Integer;VpaNomProduto : string):Boolean;
begin
  if VpaNomProduto <> '' then
  begin
    AdicionaSQLAbreTabela(AUX,'Select I_SEQ_PRO from CADPRODUTOS '+
                              ' Where C_NOM_PRO like '''+VpaNomProduto+'''');
    result := not Aux.eof;
    VpaSeqProduto := AUX.FieldByname('I_SEQ_PRO').AsInteger;
    Aux.close;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, PRO.I_ALT_PRO, '+
                                  ' MOV.N_VLR_CUS '+
                                  ' from CADPRODUTOS PRO, MOVQDADEPRODUTO MOV  '+
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ');

    result := not ProProduto.Eof;
    if result then
    begin
      with VpaDConsumoMP do
      begin
        UMOriginal := ProProduto.FieldByName('C_Cod_Uni').Asstring;
        UM := ProProduto.FieldByName('C_Cod_Uni').Asstring;
        QtdProduto := 1;
        SeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
        AltProduto := ProProduto.FieldByName('I_ALT_PRO').AsInteger;
        ValorUnitario := ProProduto.FieldByName('N_VLR_CUS').AsFloat;
      end;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto : String;var VpaSeqProduto : Integer;var VpaNomProduto, VpaUM : String):boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, PRO.C_NOM_PRO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where C_COD_PRO  = ''' + VpaCodProduto +'''');

    result := not ProProduto.Eof;
    if result then
    begin
      VpaNomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaUM := ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaSeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaSeqProduto : Integer;Var VpaCodProduto, VpaNomProduto : String):Boolean;
begin
  result := false;
  if VpaSeqProduto <> 0 then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, PRO.C_COD_PRO, '+
                                  ' PRO.C_NOM_PRO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));

    result := not ProProduto.Eof;
    if result then
    begin
      VpaCodProduto := ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaNomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String; VpaDProAmostra: TRBDConsumoAmostra): Boolean;
begin
  result:= false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                     ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, I_ALT_PRO, '+
                                     ' QTD.N_VLR_CUS '+
                                     ' from CADPRODUTOS PRO, MOVQDADEPRODUTO QTD '+
                                     ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                     ' AND PRO.I_SEQ_PRO = QTD.I_SEQ_PRO ');

    result := not ProProduto.Eof;
    if result then
    begin
      with VpaDProAmostra do
      begin
        DesUM := ProProduto.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := DesUM;
        QtdProduto := 1;
        SeqProduto := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := ProProduto.FieldByName('C_NOM_PRO').AsString;
        ValUnitario:= ProProduto.FieldByName('N_VLR_CUS').AsFloat;
        AltProduto := ProProduto.FieldByName('I_ALT_PRO').AsInteger;
      end;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String): Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT * FROM CADPRODUTOS'+
                                     ' WHERE C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto : String;VpaDProdutoPedido: TRBDProdutoPedidoCompra): Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO, PRO.N_PER_IPI, '+
                                     ' PRO.L_DES_TEC, '+
                                     ' QTD.N_VLR_COM '+
                                     ' FROM CADPRODUTOS PRO, MOVQDADEPRODUTO QTD'+
                                     ' WHERE QTD.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                                     ' AND PRO.C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    if Result then
    begin
      VpaDProdutoPedido.SeqProduto:= ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDProdutoPedido.CodProduto:= ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaDProdutoPedido.DesUM:= ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaDProdutoPedido.NomProduto:= ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaDProdutoPedido.DesTecnica := ProProduto.FieldByName('L_DES_TEC').AsString;
      VpaDProdutoPedido.ValUnitario:= ProProduto.FieldByName('N_VLR_COM').AsFloat;
      VpaDProdutoPedido.PerIPI := ProProduto.FieldByName('N_PER_IPI').AsFloat;

      VpaDProdutoPedido.UnidadesParentes.Free;
      VpaDProdutoPedido.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDProdutoPedido.DesUM);
      VpaDProdutoPedido.QtdProduto:= 1;
      VpaDProdutoPedido.CodCor:= 0;
    end;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String; VpaDOrcamentoItem: TRBDSolicitacaoCompraItem): Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO, '+
                                     ' PRO.C_COD_CLA '+
                                     ' FROM CADPRODUTOS PRO'+
                                     ' WHERE PRO.C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    if Result then
    begin
      VpaDOrcamentoItem.SeqProduto:= ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDOrcamentoItem.CodProduto:= ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaDOrcamentoItem.CodClassificacao := ProProduto.FieldByName('C_COD_CLA').AsString;
      VpaDOrcamentoItem.DesUM:= ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaDOrcamentoItem.NomProduto:= ProProduto.FieldByName('C_NOM_PRO').AsString;

      VpaDOrcamentoItem.UnidadesParentes.Free;
      VpaDOrcamentoItem.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDOrcamentoItem.DesUM);
      VpaDOrcamentoItem.QtdProduto:= 1;
      VpaDOrcamentoItem.CodCor:= 0;
    end;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto: String; VpaDOrcamentoItem: TRBDOrcamentoCompraProduto): Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO, PRO.L_DES_TEC '+
                                     ' FROM CADPRODUTOS PRO'+
                                     ' WHERE PRO.C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    if Result then
    begin
      VpaDOrcamentoItem.SeqProduto:= ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDOrcamentoItem.CodProduto:= ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaDOrcamentoItem.DesUM:= ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaDOrcamentoItem.NomProduto:= ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaDOrcamentoItem.DesTecnica:= ProProduto.FieldByName('L_DES_TEC').AsString;

      VpaDOrcamentoItem.UnidadesParentes.Free;
      VpaDOrcamentoItem.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDOrcamentoItem.DesUM);
      VpaDOrcamentoItem.QtdSolicitada:= 1;
      VpaDOrcamentoItem.QtdProduto:= 1;
      VpaDOrcamentoItem.CodCor:= 0;
    end;
    ProProduto.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProduto(VpaCodProduto : string; VpaDProdutoOrcado : TRBDChamadoProdutoOrcado):Boolean;
begin
  Result:= False;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'SELECT PRO.C_COD_PRO, PRO.I_SEQ_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO,  '+
                                     ' PRE.N_VLR_VEN '+
                                     ' FROM CADPRODUTOS PRO, MOVTABELAPRECO PRE'+
                                     ' WHERE PRE.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                                     ' AND PRE.I_COD_TAB = '+ IntToStr(Varia.TabelaPreco)+
                                     ' and PRE.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                                     ' AND PRO.C_COD_PRO = '''+VpaCodProduto+'''');
    Result:= not ProProduto.Eof;
    if Result then
    begin
      VpaDProdutoOrcado.SeqProduto:= ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      VpaDProdutoOrcado.CodProduto:= ProProduto.FieldByName('C_COD_PRO').AsString;
      VpaDProdutoOrcado.DesUM:= ProProduto.FieldByName('C_COD_UNI').AsString;
      VpaDProdutoOrcado.NomProduto:= ProProduto.FieldByName('C_NOM_PRO').AsString;
      VpaDProdutoOrcado.ValUnitario := ProProduto.FieldByName('N_VLR_VEN').AsFloat;

      VpaDProdutoOrcado.UnidadesParentes.Free;
      VpaDProdutoOrcado.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDProdutoOrcado.DesUM);
      VpaDProdutoOrcado.Quantidade:= 1;
    end;
    ProProduto.Close;
  end;
end;
{******************************************************************************}
function TFuncoesProduto.ExisteEntretela(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, PRO.I_ALT_PRO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +'''');

    result := not ProProduto.Eof;
    if result then
    begin
      with VpaDConsumoMP do
      begin
        QtdEntretela := 1;
        SeqProdutoEntretela := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
        NomProdutoEntretela := ProProduto.FieldByName('C_NOM_PRO').AsString;
      end;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteTermoColante(VpaCodProduto : String;VpaDConsumoMP : TRBDConsumoMP):Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(ProProduto,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, PRO.C_NOM_PRO, PRO.I_ALT_PRO '+
                                  ' from CADPRODUTOS PRO  '+
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +'''');

    result := not ProProduto.Eof;
    if result then
    begin
      with VpaDConsumoMP do
      begin
        QtdTermoColante := 1;
        SeqProdutoTermoColante := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
        NomProdutoTermoColante := ProProduto.FieldByName('C_NOM_PRO').AsString;
      end;
    end;
    ProProduto.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.FiguraGRFDuplicada(VpaFiguras: TList): Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDFiguraInterna, VpfDFiguraExterna : TRBDFiguraGRF;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaFiguras.Count - 2 do
  begin
    VpfDFiguraExterna := TRBDFiguraGRF(VpaFiguras.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaFiguras.Count - 1 do
    begin
      VpfDFiguraInterna := TRBDFiguraGRF(VpaFiguras.Items[VpfLacoInterno]);
      if VpfDFiguraInterna.CodFiguraGRF = VpfDFiguraExterna.CodFiguraGRF then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteCombinacao(VpaSeqProduto, VpaCodCombinacao : Integer):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select * from COMBINACAO '+
                            ' Where SEQPRO = '+IntToStr(VpaSeqProduto)+
                            ' and CODCOM = ' +IntToStr(VpaCodCombinacao));
  result := not Aux.eof;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteCor(VpaCodCor : String) : Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select * from COR '+
                            ' Where COD_COR = '+VpaCodCor);
  result := not Aux.eof;
  AUX.close;
end;

{************* ************************************************ ************ }
procedure TFuncoesProduto.OrdenaTabelaPrecoProduto(VpaDProduto: TRBDProduto);
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDPrecoInterno, VpfDPrecoExterno : TRBDProdutoTabelaPreco;
begin
  for VpfLacoExterno := 0 to VpaDProduto.TabelaPreco.Count - 2 do
  begin
    VpfDPrecoExterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDProduto.TabelaPreco.Count - 1 do
    begin
      VpfDPrecoInterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoInterno]);
      if (VpfDPrecoInterno.CodCor <  VpfDPrecoExterno.CodCor)or
        ((VpfDPrecoInterno.CodCor =  VpfDPrecoExterno.CodCor)and
         (VpfDPrecoInterno.CodTamanho < VpfDPrecoExterno.CodTamanho)) then
      begin
        VpaDProduto.TabelaPreco.Items[VpfLacoExterno] := VpaDProduto.TabelaPreco.Items[VpfLacoInterno];
        VpaDProduto.TabelaPreco.Items[VpfLacoInterno] := VpfDPrecoExterno;
        VpfDPrecoExterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoExterno]);
      end;
    end;
  end;
end;

{************* adiciona os produtos faltantes na tabela de preco ************ }
procedure TFuncoesProduto.OrganizaTabelaPreco(VpaCodTabela, VpaCodCliente : integer; VpaSomenteAtividade : Boolean );
begin
  LocalizaProdutoEmpresa( calcula );

  while not calcula.Eof do
  begin
    LocalizaProdutoTabelaPreco( ProCadastro, IntToStr(VpaCodTabela),
                                calcula.FieldByName('I_SEQ_PRO').AsString,IntToStr(VpaCodCliente) );

    if ProCadastro.eof then
    begin
      if (calcula.FieldByName('C_ATI_PRO').AsString = 'S') or (VpaSomenteAtividade) then
      begin
        ProCadastro.Insert;
        ProCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
        ProCadastro.FieldByName('I_COD_TAB').AsInteger := VpaCodTabela;
        ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := calcula.fieldByName('I_SEQ_PRO').AsInteger;
        ProCadastro.FieldByName('N_PER_MAX').AsFloat := calcula.fieldByName('N_PER_MAX').AsFloat;
        ProCadastro.FieldByName('I_COD_MOE').Value := Varia.MoedaBase;
        ProCadastro.FieldByName('C_CIF_MOE').Value := CurrencyString;
        ProCadastro.FieldByName('I_COD_CLI').AsInteger := VpaCodCliente;
        ProCadastro.FieldByname('D_Ult_Alt').AsDateTime :=Date;
        ProCadastro.post;
      end;
    end;
    calcula.next;
    ProCadastro.close;
  end;
end;

{************ atualiza o valor do kit conforme o preco dos seus produtos ***** }
procedure TFuncoesProduto.AtualizaValorKit( SeqProdutoKit, CodTabelaPreco : integer );
begin
  LimpaSQLTabela(tabela);
  AdicionaSQLTabela(tabela, ' update MovTabelaPreco ' +
                    ' set n_vlr_ven =  ( select sum((n_vlr_ven * (1 - (isnull(pro.n_per_kit,0) / 100)))* kit.n_qtd_pro) ' +
                                       ' from movkit  kit, MovTabelaPreco tab, cadprodutos  pro  ' +
                                       ' where i_pro_kit =  ' + IntToStr( SeqProdutoKit ) +
                                       ' and tab.i_cod_tab = ' + IntToStr(CodTabelaPreco)  +
                                       ' and tab.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa)  +
                                       ' and tab.i_cod_cli = 0 '+
                                       ' and kit.i_seq_pro = tab.i_seq_pro ' +
                                       ' and kit.i_seq_pro = pro.i_seq_pro ' +
                                       ' and pro.i_cod_emp = ' + IntToStr(varia.codigoEmpresa) + ' ), ' +
                    ' d_ult_alt = ' + SQLTextoDataAAAAMMMDD(Date) +
                    ' where i_seq_pro = ' + IntToStr( SeqProdutoKit ) +
                    ' and i_cod_tab = ' + IntToStr(CodTabelaPreco)  +
                    ' and i_cod_emp = ' + IntToStr(varia.CodigoEmpresa)+
                    ' and I_COD_CLI = 0');
  tabela.ExecSQL;
end;

{****************** valida a alteracao do valor unitario ********************* }
function TFuncoesProduto.ValidaAlterarValorUnitario( CorForm, CorCaixa : TColor ) : boolean;
var
  senha : string;
begin
  result := true;
  if  config.AlterarValorUnitarioComSenha then
     if Entrada( 'Digite senha', 'Digite a senha de permissão', senha,true, CorCaixa, CorForm) then  // senha de permissao para liberar o desconto
      begin
         if varia.SenhaLiberacao <> senha then     // verifica a senha de autorizacao....
         begin
           aviso(CT_SenhaInvalida);
           result := false;
         end;
      end
      else
        result := false;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteCor(VpaCodCor : String;VpaDConcumoMP : TRBDConsumoMP) : Boolean;
begin
  VpaDConcumoMP.NomProduto := '';
  AdicionaSQLAbreTabela(AUX,'Select * from COR '+
                            ' Where COD_COR = '+VpaCodCor);
  result := not Aux.eof;
  if result then
  begin
    VpaDConcumoMP.NomCor := Aux.FieldByName('NOM_COR').AsString;
  end;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.Existecor(VpaCodCor : String;var VpaNomCor : String):Boolean;
begin
  VpaNomCor := '';
  AdicionaSQLAbreTabela(AUX,'Select * from COR '+
                            ' Where COD_COR = '+VpaCodCor);
  result := not Aux.eof;
  if result then
  begin
    VpaNomCor := Aux.FieldByName('NOM_COR').AsString;
  end;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteEstagio(VpaCodEstagio : String;Var VpaNomEstagio :string): Boolean;
begin
  AdicionaSQlAbreTabela(AUX,'Select * from ESTAGIOPRODUCAO '+
                            ' Where CODEST = '+ VpaCodEstagio);
  result := not aux.eof;
  if result then
    VpaNomEstagio := Aux.FieldByName('NOMEST').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteEstoqueCor(VpaSeqProduto, VpaCodCor : Integer):String;
begin
  result := '';
  AdicionaSQLAbreTabela(AUX,'Select MOV.N_QTD_PRO, PRO.C_COD_UNI from MOVQDADEPRODUTO MOV, CADPRODUTOS PRO '+
                            ' Where MOV.I_EMP_FIL = '+ IntToStr(Varia.CodigoEmpFil)+
                            ' and MOV.I_SEQ_PRO = '+ IntToStr(VpaSeqProduto)+
                            ' and MOV.I_COD_COR = '+ IntToStr(VpaCodCor)+
                            ' and PRO.I_SEQ_PRO = MOV.I_SEQ_PRO ');
  if  not Aux.Eof then
  begin
    if Aux.FieldByName('N_QTD_PRO').AsFloat > 0 then
    begin
      result := 'COMBINAÇÃO POSSUI ESTOQUE!!!'#13'A combinação digitada possui "'+FormatFloat(varia.mascaraqtd,AUX.FieldByName('N_QTD_PRO').AsFloat)+ '" '+ AUX.FieldByName('C_COD_UNI').AsString +' em estoque.';
    end;
  end;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteProdutosDevolvidos(VpaCodCliente : String):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select * from CADNOTAFISCAISFOR '+
                            ' Where I_COD_CLI = '+ VpaCodCliente+
                            ' and I_EMP_FIL = '+IntToStr(varia.CodigoFilial));
  result := not aux.eof;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteDonoProduto(VpaCodDono : Integer):Boolean;
begin
  AdicionaSqlAbreTabela(Aux,'Select * from DONOPRODUTO '+
                            ' Where CODDONO = '+inttoStr(VpaCodDono));
  result := not aux.eof;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteFaca(VpaCodFaca : Integer; VpaDFaca : TRBDFaca):Boolean;
begin
  AdicionaSqlAbreTabela(Tabela2,'Select CODFACA, NOMFACA, ALTFACA, LARFACA, QTDPROVA from FACA '+
                                ' Where CODFACA = '+inttoStr(VpaCodFaca));
  result := not Tabela2.eof;
  if result then
  begin
    VpaDFaca.CodFaca := Tabela2.FieldByname('CODFACA').AsInteger;
    VpaDFaca.LarFaca := Tabela2.FieldByname('LARFACA').AsFloat;
    VpaDFaca.AltFaca := Tabela2.FieldByname('ALTFACA').AsFloat;
    VpaDFaca.QtdProvas := Tabela2.FieldByname('QTDPROVA').AsInteger;
    VpaDFaca.NomFaca := Tabela2.FieldByname('NOMFACA').AsString;
  end;
  Tabela2.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteMaquina(VpaCodMaquina : Integer;VpaDMaquina : TRBDMaquina):Boolean;
begin
  AdicionaSQLAbreTabela(Tabela2,'Select CODMAQ, NOMMAQ, ALTBOC, LARBOC '+
                               ' from MAQUINA '+
                               ' Where CODMAQ = '+IntToStr(VpaCodMaquina));
  result := not Tabela2.Eof;
  if result then
  begin
    VpaDMaquina.CodMaquina := VpaCodMaquina;
    VpaDMaquina.NomMaquina := Tabela2.FieldByname('NOMMAQ').AsString;
    VpaDMaquina.AltBoca := Tabela2.FieldByname('ALTBOC').AsInteger;
    VpaDMaquina.LarBoca := Tabela2.FieldByname('LARBOC').AsInteger;
  end;
  Tabela2.Close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteConsumo(VpaSeqProduto : Integer) : Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_SEQ_PRO from MOVKIT  '+
                            ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto));
  result := not Aux.eof;
  Aux.close;
end;

function TFuncoesProduto.ExisteConsumoProdutoCor(VpaSeqProduto, VpaCodCor : Integer):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_SEQ_PRO from MOVKIT  '+
                            ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto)+
                            ' and I_COR_KIT = '+IntToStr(VpaCodCor));
  result := not Aux.eof;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteBastidor(VpaCodBastidor : Integer;VpaDBastidor : TRBDBastidor):boolean;
begin
  result := false;
  AdicionaSQLAbreTabela(AUX,'Select * from BASTIDOR '+
                            ' Where CODBASTIDOR = '+InttoStr(VpaCodBastidor));
  result := not Aux.eof;
  if result then
  begin
    VpaDBastidor.CodBastidor := VpaCodBastidor;
    VpaDBastidor.NomBastidor := AUX.FieldByName('NOMBASTIDOR').AsString;
    VpaDBastidor.LarBastidor := Aux.FieldByName('LARBASTIDOR').AsFloat;
    VpaDBastidor.AltBastidor := AUX.FieldByName('ALTBASTIDOR').AsFloat;
  end;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteBastidor(VpaCodBastidor : String;Var VpaNomBastidor : String):boolean;
begin
  result := false;
  if VpaCodBastidor <> '' then
  begin
    AdicionaSQLAbreTabela(AUX,'Select * from BASTIDOR '+
                              ' Where CODBASTIDOR = '+VpaCodBastidor);
    result := not Aux.eof;
    VpaNomBastidor := AUX.FieldByname('NOMBASTIDOR').AsString;
    AUX.close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteBastidorDuplicado(VpaDConsumo : TRBDConsumoMP):Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDBastidorInterno, vpfDBastidorExterno : TRBDConsumoMPBastidor;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDConsumo.Bastidores.Count - 2 do
  begin
    vpfDBastidorExterno := TRBDConsumoMPBastidor(VpaDConsumo.Bastidores.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDConsumo.Bastidores.Count - 1 do
    begin
      VpfDBastidorInterno := TRBDConsumoMPBastidor(VpaDConsumo.Bastidores.Items[VpfLacoInterno]);
      if VpfDBastidorInterno.CodBastidor = vpfDBastidorExterno.CodBastidor then
      begin
        Result := true;
        break;
      end;
    end;
    if result then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ExisteAcessorioDuplicado(VpaDProduto : TRBDProduto) : Boolean;
var
  VpfDAcessorioExterno, VpfDAcessorioInterno : TRBDProdutoAcessorio;
  VpfLacoExterno, VpfLacoInterno : Integer;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDProduto.Acessorios.Count -2 do
  begin
    VpfDAcessorioExterno := TRBDProdutoAcessorio(VpaDProduto.Acessorios.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno +1 to VpaDProduto.Acessorios.Count - 1 do
    begin
      VpfDAcessorioInterno := TRBDProdutoAcessorio(VpaDProduto.Acessorios.Items[VpfLacoInterno]);
      if VpfDAcessorioExterno.CodAcessorio = VpfDAcessorioInterno.CodAcessorio then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{*************** valida Desconto somente com senha *************************** }
function TFuncoesProduto.ExisteTabelaPrecoDuplicado(VpaDProduto : TRBDProduto) : Boolean;
var
  VpfDTabelaPrecoExterno, VpfDTabelaPrecoInterno : TRBDProdutoTabelaPreco;
  VpfLacoExterno, VpfLacoInterno : Integer;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDProduto.TabelaPreco.Count -2 do
  begin
    VpfDTabelaPrecoExterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno +1 to VpaDProduto.TabelaPreco.Count - 1 do
    begin
      VpfDTabelaPrecoInterno := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLacoInterno]);
      if (VpfDTabelaPrecoExterno.CodTabelaPreco = VpfDTabelaPrecoInterno.CodTabelaPreco) and
         (VpfDTabelaPrecoExterno.CodTamanho = VpfDTabelaPrecoInterno.CodTamanho)and
         (VpfDTabelaPrecoExterno.CodCliente = VpfDTabelaPrecoInterno.CodCliente) and
         (VpfDTabelaPrecoExterno.CodMoeda = VpfDTabelaPrecoInterno.CodMoeda)and
         (VpfDTabelaPrecoExterno.CodCor = VpfDTabelaPrecoInterno.CodCor) then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{*************** valida Desconto somente com senha *************************** }
function TFuncoesProduto.ValidaDesconto( ValorProdutos, Desconto : double; percentual : Boolean; CorForm, CorCaixa : TColor ) : boolean;
var
  senha : string;
begin
  result := true;
  if ValorProdutos = 0 then
    exit;
  if not percentual then
    Desconto :=  (Desconto / ValorProdutos) * 100; // verifica o desconto concedido

   if Desconto > varia.DescontoMaximoNota  then  // se o desconto for maior
   begin
    case varia.MaiorDescontoPermitido of
    2 : begin
           if ConfirmacaoFormato(CT_DescontoInvalido, [FormatFloat(varia.mascaraMoeda, (varia.DescontoMaximoNota / 100) * ValorProdutos)] ) then  // mensagem de desconto maior
               result := false
            else
                if Entrada( 'Digite senha', 'Digite a senha de permissão', senha,true, CorCaixa, CorForm) then  // senha de permissao para liberar o desconto
                begin
                   if varia.SenhaLiberacao <> senha then     // verifica a senha de autorizacao....
                   begin
                     aviso('permissao negada');
                     result := false;
                   end
                end
                else
                  result := false;
        end;
    3 : begin
          avisoFormato(CT_DescontoInvalido, [FormatFloat(varia.mascaraMoeda, (varia.DescontoMaximoNota / 100) * ValorProdutos)] );
          result := false;
        end;
    end;
  end;
end;

{****************** coloca o produto em ativadade ******************************}
procedure TFuncoesProduto.ColocaProdutoEmAtividade(VpaSequencial : String);
begin
  ExecutaComandoSql(aux,'Update CadProdutos ' +
                        ' set C_Ati_Pro = ''S''' +
                        ' Where I_Seq_Pro = ' + VpaSequencial);
end;

{******************** tira o produto de atividade *****************************}
procedure TFuncoesProduto.TiraProdutoAtividade(VpaSequencial : String);
begin
  ExecutaComandoSql(aux,'Update CadProdutos ' +
                        ' set C_Ati_Pro = ''N''' +
                        ' Where I_Seq_Pro = ' + VpaSequencial);
end;

{******************* carrega o valor de custo do produto **********************}
function TFuncoesProduto.CQtdValorCusto(VpaCodFilial, VpaSeqProduto, VpaCodCor :Integer; Var VpaQtdProduto, VpaValCusto : Double):Boolean;
begin
  AdicionaSQLAbreTabela(AUX,'Select N_VLR_CUS,N_QTD_PRO from MOVQDADEPRODUTO '+
                            ' Where I_EMP_FIL = ' + IntToStr(VpaCodFilial) +
                            ' and I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' and I_COD_COR = '+ IntToStr(VpaCodCor));
  result := not Aux.Eof;
  VpaValCusto := AUX.FieldByname('N_VLR_CUS').AsFloat;
  VpaQtdProduto := AUX.FieldByname('N_QTD_PRO').AsFloat;
  Aux.close;
end;

{*********** retorna o valor do frete rateado pela media ponderada ************}
function TFuncoesProduto.RFreteRateado(VpaQtdComprado,VpaVlrCompra, VpaTotCompra, VpaTotFrete : Double) : Double;
var
  VpfPerCompra : Double;
begin
  result := 0;
  if VpaTotFrete >0 then
  begin
    VpfPerCompra := ((VpaVlrCompra * VpaQtdComprado) * 100) / VpaTotCompra;
    Result := (VpaTotFrete * VpfPerCompra) / 100;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RDescontoRateado(VpaQtdComprado,VpaVlrCompra, VpaTotCompra, VpaValDesconto : Double) : Double;
var
  VpfPerCompra : Double;
begin
  result := 0;
  if VpaValDesconto <>0 then
  begin
    VpfPerCompra := ((VpaVlrCompra * VpaQtdComprado) * 100) / (VpaTotCompra + VpaValDesconto);
    Result := (VpaValDesconto * VpfPerCompra) / 100;
    result := result /VpaQtdComprado;
  end;
end;

{***************** retorna a funcao da operacao de estoque ********************}
function TFuncoesProduto.RFuncaoOperacaoEstoque(VpaCodOperacao : String):String;
begin
  AdicionaSQLAbreTabela(AUX,'Select C_FUN_OPE from CADOPERACAOESTOQUE '+
                            ' where I_COD_OPE = '+ VpaCodOperacao);
  if Aux.Eof then
    result := ''
  else
    result := Aux.FieldByName('C_FUN_OPE').AsString;
  Aux.close;
end;

{******************** retorna o icms do estado ********************************}
function TFuncoesProduto.RIcmsEstado(VpaEstado:String):Double;
begin
  AdicionaSQLAbreTabela(Aux,'Select N_ICM_INT FROM CADICMSESTADOS ' +
                            ' Where C_COD_EST = '''+ VpaEstado + '''');
  result := Aux.FieldByname('N_ICM_INT').AsFloat;
end;

{****************** retorna o valor de custo do produto ***********************}
function TFuncoesProduto.RValorCusto(VpaCodEmpFil, VpaSeqProduto : String):Double;
begin
  AdicionaSQLAbreTabela(AUX,'Select N_VLR_CUS from MOVQDADEPRODUTO'+
                            ' WHERE I_EMP_FIL = '+ VpaCodEmpFil +
                            ' AND I_SEQ_PRO =  ' + VpaSeqProduto);
  Result := Aux.FieldByName('N_VLR_CUS').AsFloat;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeFundo(VpaCodFundo : String):String;
begin
  result := '';
  if VpaCodFundo <> '' then;
  begin
    AdicionaSQLAbreTabela(AUX,'Select * from CADTIPOFUNDO '+
                              ' Where I_COD_FUN = '+ VpaCodFundo);
    result := AUX.FieldByName('C_NOM_FUN').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeTipoEmenda(VpaCodEmenda : String):String;
begin
  result := '';
  if VpaCodEmenda <> '' then
  begin
    AdicionaSQLAbreTabela(Aux,'Select NOMEME from TIPOEMENDA '+
                              ' Where CODEME = '+ VpaCodEmenda);
    result := Aux.FieldByName('NOMEME').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RQtdPecaemMetro(VpaAltProduto, VpaLarProduto, VpaQtdProvas : Integer;VpaAltMolde, VpaLarMolde : double;VpaIndAltFixa : Boolean;Var VpaIndice :Double):Integer;
var
  VpfQtdAltura, VpfQtdLargura : Integer;
  VpfQtdMedida1 : Integer;
  VpfIndice1 : Double;
begin
  VpfQtdAltura :=RetornaInteiro(VpaAltProduto/VpaAltMolde);
  if VpfQtdAltura = 0 then
     VpfQtdAltura := 1;
  VpfQtdLargura := RetornaInteiro(VpaLarProduto/VpaLarMolde);
  if VpfQtdLargura = 0 then
  begin
    VpfQtdLargura := 1;
    VpaIndice := VpaLarMolde /100;
  end
  else
    VpaIndice := RetornaInteiro(VpfQtdLargura * VpaLarMolde +(Varia.AcrescimoCMEnfesto *2))/100;
  result := VpfQtdAltura * VpfQtdLargura * VpaQtdProvas;
  if not VpaIndAltFixa then
  begin
    VpfQtdAltura := RetornaInteiro(VpaLarProduto/VpaAltMolde);
    if VpfQtdAltura = 0 then
    begin
      VpfQtdAltura := 1;
      VpfIndice1 := VpaAltMolde / 100;
    end
    else
      VpfIndice1 := RetornaInteiro(VpfQtdAltura * VpaAltMolde +(Varia.AcrescimoCMEnfesto *2))/100;
    VpfQtdLargura := RetornaInteiro(VpaAltProduto/VpaLarMolde);
    VpfQtdMedida1 := VpfQtdAltura * VpfQtdLargura * VpaQtdProvas;
    if ((100 * VpfIndice1)/VpfQtdMedida1) < ((100 * VpaIndice)/result) then
    begin
      Result := VpfQtdMedida1;
      VpaIndice := VpfIndice1;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.PrincipioAtivoControlado(VpaCodPrincipio : Integer) : boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select INDCONTROLADO from PRINCIPIOATIVO '+
                            ' Where CODPRINCIPIO = ' +IntToStr(VpaCodPrincipio));
  result := Aux.FieldByname('INDCONTROLADO').AsString = 'T';
  Aux.Close;
end;

{********************* atualiza o valor de compra do produto ******************}
procedure TFuncoesProduto.AtualizaValorCusto(VpaSeqProduto,VpaCodFilial, VpaCodMoeda : Integer; VpaUniPadrao, VpaUniProduto, VpaFuncaoOperacao: String;VpaCodCor,VpaCodTamanho : Integer;VpaQtdProduto, VpaVlrCompra,VpaTotCompra,VpaVlrFrete,VpaPerIcms, VpaPerIPI,VpaValDescontoNota : Double;VpaIndFreteEmitente : Boolean);
Var
  VpfValCusto, VpfQtdEstoque, VpfValCustoEstoque, VpfQtdCompra, VpfValFrete, VpfValDesconto, VpfValCompraUMPadrao, VpfTotCompra : Double;
  VpfMoedaProduto : Integer;
  VpfCifrao : String;
begin
  if VpaFuncaoOperacao = 'CO' then
  begin
    VpfMoedaProduto := MoedaPadrao(VpaSeqProduto);  // localiza a moeda do produto
    VpaVlrCompra := UnMoeda.ConverteValor( Vpfcifrao, VpaCodMoeda, VpfMoedaProduto, VpaVlrCompra);
    VpaTotCompra := UnMoeda.ConverteValor( Vpfcifrao, VpaCodMoeda, VpfMoedaProduto, VpaTotCompra);
    VpfQtdCompra := CalculaQdadePadrao( VpaUniProduto, VpaUniPadrao, VpaQtdProduto, IntToStr(VpaSeqProduto));
    if Varia.UtilizarIpi then
      VpaVlrCompra := VpaVlrCompra +((VpaVlrCompra * VpaPerIPI)/100)  ;

    if VpaIndFreteEmitente then
      VpfTotCompra := VpaTotCompra - VpaVlrFrete
    else
      VpfTotCompra := VpaTotCompra;

    VpfValFrete :=  RFreteRateado(VpaQtdProduto,VpaVlrCompra,VpfTotCompra,VpaVlrFrete);
    VpfValDesconto := RDescontoRateado(VpaQtdProduto,VpaVlrCompra,VpfTotCompra,VpaValDescontoNota);

    VpfValCompraUMPadrao := (VpaVlrCompra * ConvUnidade.Indice(VpaUniProduto,VpaUniPadrao,VpaSeqProduto,Varia.CodigoEmpresa));

    VpfValfrete := VpfValfrete / VpfQtdCompra;

    VpfValCusto := VpfValCompraUMPadrao + VpfValFrete - VpfValDesconto;
    if config.ValordeCompraComFrete then
      VpfValCompraUMPadrao := VpfValCompraUMPadrao + VpfValFrete;
    VpfValCompraUMPadrao := VpfValCompraUMPadrao - VpfValDesconto;
    if CQtdValorCusto(VpaCodFilial,VpaSeqProduto,VpaCodCor,VpfQtdEstoque,VpfValCustoEstoque) then
    begin
      if VpfQtdEstoque > 0 then
        VpfValCusto := ((VpfQtdEstoque * VpfValCustoEstoque) + (VpfQtdCompra * VpfValCusto))/(VpfQtdCompra + VpfQtdEstoque)
    end
    else
      InsereProdutoFilial(VpaSeqProduto,VpaCodFilial,VpaCodCor,VpaCodTamanho,0,0,0,VpfValCusto,VpfValCompraUMPadrao);

    ExecutaComandoSql(Aux,'Update MOVQDADEPRODUTO '+
                            ' Set N_VLR_CUS = '+ SubstituiStr(FloatToStr(VpfValCusto),',','.')+
                            ' , N_VLR_COM = '+ SubstituiStr(FloatToStr(VpfValCompraUMPadrao),',','.')+
                            ' Where I_EMP_FIL = '+ IntToStr(VpaCodFilial) +
                            ' and I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' AND I_COD_COR = '+ IntToStr(VpaCodCor));
    if config.ValorVendaProdutoAutomatico then
      AtualizaValorVendaAutomatico(VpaSeqProduto,VpfValCusto);
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AtualizaCodEan(VpaSeqProduto,VpaCodCor : Integer;VpaCodBarras : String):String;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVQDADEPRODUTO '+
                                    ' Where C_COD_BAR = ''' + VpaCodBarras+'''');
  if ProCadastro.Eof then
  begin
    LocalizaMovQdadeSequencial(ProCadastro,Varia.CodigoEmpFil,VpaSeqProduto,VpaCodCor,0);
    if ProProduto.eof then
    begin
      InsereProdutoFilial(VpaSeqProduto,varia.CodigoEmpFil,VpaCodCor,0, 0,0,0,0,0);
      LocalizaMovQdadeSequencial(ProCadastro,Varia.CodigoEmpFil,VpaSeqProduto,VpaCodCor,0);
    end;

    ProCadastro.Edit;
    ProCadastro.FieldByName('C_COD_BAR').AsString := VpaCodBarras;
    ProCadastro.Post;
    result := ProCadastro.AMensagemErroGravacao;
  end
  else
  begin
    if (ProCadastro.FieldByName('I_SEQ_PRO').AsInteger <> VpaSeqProduto) AND
       (ProCadastro.FieldByName('I_COD_COR').AsInteger <> VpaCodCor) Then
    Begin
      AdicionaSQLAbreTabela(AUX,'Select C_COD_PRO, C_NOM_PRO FROM CADPRODUTOS '+
                              ' Where I_SEQ_PRO = '+ ProCadastro.FieldByName('I_SEQ_PRO').AsString);
      result := 'CODIGO DE BARRAS DUPLICADO!!!'#13'Esse código de barras já existe cadastrado para o produto "'+AUX.FieldByName('C_COD_PRO').AsString+'-'+AUX.FieldByName('C_NOM_PRO').AsString+'"';
      Aux.close;
    End;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.AtualizaValorVendaAutomatico(VpaSeqProduto : Integer;VpaValCusto : Double):string;
begin
  if config.ValorVendaProdutoAutomatico then
  begin
    AdicionaSQLAbreTabela(AUX,'Select N_PER_LUC from CADPRODUTOS '+
                              ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
    if Aux.FieldByName('N_PER_LUC').AsFloat <> 0 then
    begin
      ExecutaComandoSql(Aux,'Update MOVTABELAPRECO '+
                            ' Set N_VLR_VEN = '+ SubstituiStr(FloatToStr((AUX.FieldByName('N_PER_LUC').AsFloat/100)*VpaValCusto),',','.')+
                            ' Where I_COD_EMP = '+ IntToStr(Varia.CodigoEmpresa) +
                            ' and I_COD_TAB = '+IntToStr(varia.TabelaPreco)+
                            ' and I_SEQ_PRO = ' + IntToStr(VpaSeqProduto));
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.AtualizaEmbalagem(VpaSeqProduto,VpaCodEmbalagem : Integer):string;
begin
  LocalizaProdutoSequencial(ProCadastro,IntToStr(VpaSeqProduto));
  ProCadastro.Edit;
  if VpaCodEmbalagem <> 0 then
    ProCadastro.FieldByName('I_COD_EMB').AsInteger := VpaCodEmbalagem
  else
    ProCadastro.FieldByName('I_COD_EMB').clear;
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.AtualizaComposicao(VpaSeqProduto,VpaCodComposicao : Integer):string;
begin
  LocalizaProdutoSequencial(ProCadastro,IntToStr(VpaSeqProduto));
  ProCadastro.Edit;
  if VpaCodComposicao <> 0 then
    ProCadastro.FieldByName('I_COD_COM').AsInteger := VpaCodComposicao
  else
    ProCadastro.FieldByName('I_COD_COM').clear;
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDMovimentoEstoque(VpaTabela : TDataSet;VpaDMovimento : TRBDMovEstoque);
begin
  with VpaDMovimento do
  begin
    CodFilial := VpaTabela.FieldByName('I_EMP_FIL').AsInteger;
    LanEstoque := VpaTabela.FieldByName('I_LAN_EST').AsInteger;
    LanOrcamento := VpaTabela.FieldByName('I_LAN_ORC').AsInteger;
    SeqProduto := VpaTabela.FieldByName('I_SEQ_PRO').AsInteger;
    CodCor := VpaTabela.FieldByName('I_COD_COR').AsInteger;
    CodTamanho := VpaTabela.FieldByName('I_COD_TAM').AsInteger;
    CodOperacaoEstoque := VpaTabela.FieldByName('I_COD_OPE').AsInteger;
    SeqNotaEntrada := VpaTabela.FieldByName('I_NOT_ENT').AsInteger;
    SeqNotaSaida := VpaTabela.FieldByName('I_NOT_SAI').AsInteger;
    NumNota := VpaTabela.FieldByName('I_NRO_NOT').AsInteger;
    TipMovimento := VpaTabela.FieldByName('C_TIP_MOV').AsString;
    CodUnidade := VpaTabela.FieldByName('C_COD_UNI').AsString;
    QtdProduto := VpaTabela.FieldByName('N_QTD_MOV').AsFloat;
    ValMovimento := VpaTabela.FieldByName('N_VLR_MOV').AsFloat;
    DatMovimento := VpaTabela.FieldByName('D_DAT_MOV').AsDateTime;
    ValCusto :=  VpaTabela.FieldByName('N_VLR_CUS').AsFloat;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDProduto(VpaDProduto: TRBDProduto; VpaCodEmpresa: Integer = 0; VpaCodFilial: Integer = 0; VpaSeqProduto: Integer = 0);
begin
  if VpaCodEmpresa <> 0 then
    VpaDProduto.CodEmpresa:= VpaCodEmpresa;
  if VpaCodFilial <> 0 then
    VpaDProduto.CodEmpFil:= VpaCodFilial;
  if VpaSeqProduto <> 0 then
    VpaDProduto.SeqProduto:= VpaSeqProduto;

  AdicionaSQLAbreTabela(Tabela,'SELECT '+
                            ' CAD.I_PES_CVA, CAD.I_QTD_PAG, CAD.C_IND_ORI,'+
                            ' CAD.C_IND_COP, CAD.C_IND_MUL, CAD.C_IND_IMP,'+
                            ' CAD.C_IND_RED, CAD.C_IND_PCL, CAD.C_IND_FAX,'+
                            ' CAD.C_IND_USB, CAD.C_IND_SCA, CAD.C_IND_WIR,'+
                            ' CAD.C_IND_SCR, CAD.C_IMP_COL ,CAD.C_COM_REV,'+
                            ' CAD.C_COM_CIL, CAD.I_QTD_CTB, CAD.I_QTD_CCI,'+
                            ' CAD.I_QTD_CTA, CAD.C_COD_CTA, CAD.I_QTD_PPM,'+
                            ' CAD.I_VOL_MEN, CAD.D_DAT_FAB, CAD.D_DAT_ENC,'+
                            ' CAD.N_PES_BRU, CAD.I_COD_EMB, CAD.N_PES_LIQ,'+
                            ' CAD.I_COD_ACO, CAD.I_ALT_PRO, CAD.I_COD_DES,'+
                            ' CAD.IMPPRE, CAD.C_IND_CRA, CAD.C_IND_RET,'+
                            ' CAD.C_REN_PRO, CAD.CODMAQ, CAD.I_QTD_FUS,'+
                            ' CAD.I_TAB_GRA, CAD.I_TAB_TRA, CAD.C_TIT_FIO,'+
                            ' CAD.C_DES_ENC, CAD.I_COD_SUM, CAD.D_ENT_AMO,'+
                            ' CAD.D_SAI_AMO, CAD.C_TIP_IMP, CAD.METMIN,'+
                            ' CAD.C_ENG_EPE, CAD.I_COD_MOE, CAD.I_IND_COV,'+
                            ' CAD.C_COD_CLA, CAD.C_CLA_FIS, CAD.L_DES_TEC,'+
                            ' CAD.C_COD_REF, CAD.C_BAR_FOR, CAD.C_CIF_MOE,'+
                            ' CAD.N_PER_IPI, CAD.I_DIA_FOR, CAD.N_RED_ICM,'+
                            ' CAD.N_PER_LUC, CAD.I_MES_GAR, CAD.I_COD_USU,'+
                            ' CAD.N_PER_KIT, CAD.N_PER_COM, CAD.C_COD_PRO,'+
                            ' CAD.C_COD_UNI, CAD.C_NOM_PRO, CAD.C_PAT_FOT,'+
                            ' CAD.I_LRG_PRO, CAD.C_BAT_TEA, CAD.I_CMP_PRO,'+
                            ' CAD.I_CMP_FIG, CAD.C_BAT_PRO, CAD.I_COD_FUN,'+
                            ' CAD.I_IND_PRO, CAD.C_NUM_FIO, CAD.C_PEN_PRO,'+
                            ' CAD.C_PRA_PRO, CAD.INDCAL, CAD.INDENG, CAD.CODEME,'+
                            ' CAD.L_DES_TEC, CAD.ENGPRO, CAD.I_COD_CRT,'+
                            ' CAD.C_TIP_CAR, CAD.I_QTD_MLC, CAD.C_CHI_NOV,'+
                            ' CAD.C_CIL_NOV, CAD.I_PES_CCH, CAD.C_COD_CTB,'+
                            ' CAD.I_COD_COR, CAD.C_IND_COM, CAD.C_ATI_PRO,'+
                            ' CAD.I_TAB_PED, CAD.I_QTD_CTA, CAD.C_CAR_TEX,'+
                            ' CAD.D_DAT_CAD, CAD.I_COD_COM, CAD.C_IND_MON, '+
                            ' CAD.I_ORI_PRO, CAD.N_CAP_LIQ, CAD.C_KIT_PRO '+
                            ' FROM CADPRODUTOS CAD'+
                            ' WHERE CAD.I_SEQ_PRO = '+IntToStr(vpadproduto.Seqproduto));

// Gerais
  VpaDProduto.CodMoeda:= Tabela.FieldByName('I_COD_MOE').AsInteger;
  VpaDProduto.CodUsuario:= Tabela.FieldByName('I_COD_USU').AsInteger;
  VpaDProduto.QtdUnidadesPorCaixa:= Tabela.FieldByName('I_IND_COV').AsInteger;
  VpaDProduto.CodProduto:= Tabela.FieldByName('C_COD_PRO').AsString;
  VpaDProduto.CodUnidade:= Tabela.FieldByName('C_COD_UNI').AsString;
  VpaDProduto.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDProduto.CodUnidade);
  VpaDProduto.NomProduto:= Tabela.FieldByName('C_NOM_PRO').AsString;
  VpaDProduto.PatFoto:= Tabela.FieldByName('C_PAT_FOT').AsString;
  VpaDProduto.DesObservacao:= Tabela.FieldByName('L_DES_TEC').AsString;
  VpaDProduto.CodClassificacao:= Tabela.FieldByName('C_COD_CLA').AsString;
  VpaDProduto.DesClassificacaoFiscal:= Tabela.FieldByName('C_CLA_FIS').AsString;
  VpaDProduto.DesDescricaoTecnica:= Tabela.FieldByName('L_DES_TEC').AsString;
  VpaDProduto.NumOrigemProduto:= Tabela.FieldByName('I_ORI_PRO').AsInteger;
  VpaDProduto.CodBarraFornecedor:= Tabela.FieldByName('C_BAR_FOR').AsString;
  VpaDProduto.CifraoMoeda:= Tabela.FieldByName('C_CIF_MOE').AsString;
  VpaDProduto.PerIPI:= Tabela.FieldByName('N_PER_IPI').AsFloat;
  VpaDProduto.QtdDiasEntregaFornecedor:= Tabela.FieldByName('I_DIA_FOR').AsFloat;
  VpaDProduto.PerReducaoICMS:= Tabela.FieldByName('N_RED_ICM').AsFloat;
  VpaDProduto.PerDesconto:= Tabela.FieldByName('N_PER_KIT').AsFloat;
  VpaDProduto.PerComissao:= Tabela.FieldByName('N_PER_COM').AsFloat;
  VpaDProduto.PerLucro:= Tabela.FieldByName('N_PER_LUC').AsFloat;
  VpaDProduto.IndProdutoAtivo:= (Tabela.FieldByName('C_ATI_PRO').AsString = 'S');
  VpaDProduto.IndKit := (Tabela.FieldByName('C_KIT_PRO').AsString = 'K');

// Cadarço
  VpaDProduto.CodMaquina:= Tabela.FieldByName('CODMAQ').AsInteger;
  VpaDProduto.QuantidadeFusos:= Tabela.FieldByName('I_QTD_FUS').AsInteger;
  VpaDProduto.MetrosTabuaPequena:= Tabela.FieldByName('I_TAB_PED').AsInteger;
  VpaDProduto.MetrosTabuaGrande:= Tabela.FieldByName('I_TAB_GRA').AsInteger;
  VpaDProduto.MetrosTabuaTrans:= Tabela.FieldByName('I_TAB_TRA').AsInteger;
  VpaDProduto.Engrenagem:= Tabela.FieldByName('ENGPRO').AsString;
  VpaDProduto.DesTituloFio:= Tabela.FieldByName('C_TIT_FIO').AsString;
  VpaDProduto.DesEnchimento:= Tabela.FieldByName('C_DES_ENC').AsString;

// Etiqueta
  VpaDProduto.CodSumula:= Tabela.FieldByName('I_COD_SUM').AsInteger;
  VpaDProduto.DatEntradaAmostra:= Tabela.FieldByName('D_ENT_AMO').AsDateTime;
  VpaDProduto.DatSaidaAmostra:= Tabela.FieldByName('D_SAI_AMO').AsDateTime;
  VpaDProduto.CmpFigura:= Tabela.FieldByName('I_CMP_FIG').AsInteger;
  VpaDProduto.Pente:= Tabela.FieldByName('C_PEN_PRO').AsString;
  VpaDProduto.BatProduto:= Tabela.FieldByName('C_BAT_PRO').AsString;
  VpaDProduto.NumBatidasTear:= Tabela.FieldByName('C_BAT_TEA').AsString;
  VpaDProduto.CodTipoFundo:=  Tabela.FieldByName('I_COD_FUN').AsInteger;
  VpaDProduto.CodTipoEmenda:= Tabela.FieldByName('CODEME').AsInteger;
  VpaDProduto.CodTipoCorte:= Tabela.FieldByName('I_COD_CRT').AsInteger;
  VpaDProduto.PerProdutividade:= Tabela.FieldByName('I_IND_PRO').AsInteger;
  VpaDProduto.IndCalandragem:= Tabela.FieldByName('INDCAL').AsString;
  VpaDProduto.IndEngomagem:= Tabela.FieldByName('INDENG').AsString;

// Adicionais
  VpaDProduto.PesoLiquido:= Tabela.FieldByName('N_PES_LIQ').AsFloat;
  VpaDProduto.PesoBruto:= Tabela.FieldByName('N_PES_BRU').AsFloat;
  VpaDProduto.QtdMesesGarantia := Tabela.FieldByName('I_MES_GAR').AsInteger;
  VpaDProduto.CodEmbalagem:= Tabela.FieldByName('I_COD_EMB').AsInteger;
  VpaDProduto.CodAcondicionamento:= Tabela.FieldByName('I_COD_ACO').AsInteger;
  VpaDProduto.AltProduto:= Tabela.FieldByName('I_ALT_PRO').AsInteger;
  VpaDProduto.CapLiquida := Tabela.FieldByName('N_CAP_LIQ').AsFloat;
  VpaDProduto.CodDesenvolvedor:= Tabela.FieldByName('I_COD_DES').AsInteger;
  VpaDProduto.CodComposicao := Tabela.FieldByName('I_COD_COM').AsInteger;
  VpaDProduto.IndImprimeNaTabelaPreco:= Tabela.FieldByName('IMPPRE').AsString;
  VpaDProduto.IndCracha:= Tabela.FieldByName('C_IND_CRA').AsString;
  VpaDProduto.IndProdutoRetornavel:= Tabela.FieldByName('C_IND_RET').AsString;
  VpaDProduto.DesRendimento:= Tabela.FieldByName('C_REN_PRO').AsString;
  VpaDProduto.DatCadastro := Tabela.FieldByName('D_DAT_CAD').AsDateTime;
  VpaDProduto.IndMonitorarEstoque:= Tabela.FieldByName('C_IND_MON').AsString = 'S';

// Copiadora
  VpaDProduto.IndCopiadora:= Tabela.FieldByName('C_IND_COP').AsString;
  VpaDProduto.IndMultiFuncional:= Tabela.FieldByName('C_IND_MUL').AsString;
  VpaDProduto.IndImpressora:= Tabela.FieldByName('C_IND_IMP').AsString;
  VpaDProduto.IndColorida:= Tabela.FieldByName('C_IMP_COL').AsString;
  VpaDProduto.IndComponente:= Tabela.FieldByName('C_COM_REV').AsString;
  VpaDProduto.IndCilindro:= Tabela.FieldByName('C_COM_CIL').AsString;
  VpaDProduto.IndPlacaRede:= Tabela.FieldByName('C_IND_RED').AsString;
  VpaDProduto.IndPCL:= Tabela.FieldByName('C_IND_PCL').AsString;
  VpaDProduto.IndFax:= Tabela.FieldByName('C_IND_FAX').AsString;
  VpaDProduto.IndUSB:= Tabela.FieldByName('C_IND_USB').AsString;
  VpaDProduto.IndScanner:= Tabela.FieldByName('C_IND_SCA').AsString;
  VpaDProduto.IndWireless:= Tabela.FieldByName('C_IND_WIR').AsString;
  VpaDProduto.IndDuplex:= Tabela.FieldByName('C_IND_SCR').AsString;
  VpaDProduto.CodCartuchoAltaCapac:= Tabela.FieldByName('C_COD_CTA').AsString;
  VpaDProduto.QtdCopiasTonner:= Tabela.FieldByName('I_QTD_CTB').AsInteger;
  VpaDProduto.QtdCopiasTonnerAltaCapac:= Tabela.FieldByName('I_QTD_CTA').AsInteger;
  VpaDProduto.QtdCopiasCilindro:= Tabela.FieldByName('I_QTD_CCI').AsInteger;
  VpaDProduto.QtdPagPorMinuto:= Tabela.FieldByName('I_QTD_PPM').AsInteger;
  VpaDProduto.VolumeMensal:= Tabela.FieldByName('I_VOL_MEN').AsInteger;
  VpaDProduto.DatFabricacao:= Tabela.FieldByName('D_DAT_FAB').AsDateTime;
  VpaDProduto.DatEncerProducao:= Tabela.FieldByName('D_DAT_ENC').AsDateTime;

// Cartuchos
  VpaDProduto.QtdPaginas:= Tabela.FieldByName('I_QTD_PAG').AsInteger;
  VpaDProduto.PesCartucho:= Tabela.FieldByName('I_PES_CCH').AsInteger;
  VpaDProduto.PesCartuchoVazio:= Tabela.FieldByName('I_PES_CVA').AsInteger;
  VpaDProduto.QtdMlCartucho:= Tabela.FieldByName('I_QTD_MLC').AsInteger;
  VpaDProduto.CodCorCartucho:= Tabela.FieldByName('I_COD_COR').AsInteger;
  VpaDProduto.DesTipoCartucho:= Tabela.FieldByName('C_TIP_CAR').AsString;
  VpaDProduto.IndChipNovo:= (Tabela.FieldByName('C_CHI_NOV').AsString = 'S');
  VpaDProduto.IndCilindroNovo:= (Tabela.FieldByName('C_CIL_NOV').AsString = 'S');
  VpaDProduto.IndProdutoCompativel:= (Tabela.FieldByName('C_IND_COM').AsString = 'S');
  VpaDProduto.IndProdutoOriginal:= (Tabela.FieldByName('C_IND_ORI').AsString = 'S');
  VpaDProduto.IndCartuchoTexto:= (Tabela.FieldByName('C_CAR_TEX').AsString = 'S');

// Dados que se repetem para várias páginas. Ex.: Largura Produto
  VpaDProduto.LarProduto:= Tabela.FieldByName('I_LRG_PRO').AsInteger;
  VpaDProduto.CmpProduto:= Tabela.FieldByName('I_CMP_PRO').AsInteger;
  VpaDProduto.NumFios:= Tabela.FieldByName('C_NUM_FIO').AsString;
  VpaDProduto.MetrosPorMinuto:= Tabela.FieldByName('METMIN').AsInteger;
  VpaDProduto.EngrenagemEspPequena:= Tabela.FieldByName('C_ENG_EPE').AsString;
  VpaDProduto.PraProduto:= Tabela.FieldByName('C_PRA_PRO').AsString;
  VpaDProduto.DesTipTear:= Tabela.FieldByName('C_TIP_IMP').AsString;
  VpaDProduto.CodReduzidoCartucho:= Tabela.FieldByName('C_COD_CTB').AsString;

  Tabela.close;
//  CarDCombinacao(VpaDProduto);
//  CarDEstagio(VpaDProduto);
//  CarDFornecedores(VpaDProduto);
  CarDEstoque1(VpaDProduto, VpaDProduto.CodEmpFil, VpaDProduto.SeqProduto);
  CarDPreco(VpaDProduto, VpaDProduto.CodEmpresa, VpaDProduto.SeqProduto);
  CarDValCusto(VpaDProduto,VpaDProduto.CodEmpFil);
//  CarAcessoriosProduto(VpaDProduto);
end;


{******************************************************************************}
procedure TFuncoesProduto.CarDEstoque1(VpaDProduto: TRBDProduto; VpaCodFilial, VpaSeqProduto: Integer;VpaCodCor : Integer = 0;VpaCodTamanho : Integer = 0);
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT MOV.I_COD_BAR, MOV.N_QTD_MIN, MOV.N_QTD_PED,'+
                               ' MOV.N_QTD_PRO, MOV.N_VLR_CUS, MOV.N_QTD_RES, MOV.N_QTD_ARE '+
                               ' FROM MOVQDADEPRODUTO MOV'+
                               ' WHERE'+
                               ' MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                               ' AND MOV.I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                               ' AND MOV.I_COD_COR = '+IntToStr(VpaCodCor)+
                               ' and MOV.I_COD_TAM = '+IntToStr(VpaCodTamanho));

  VpaDProduto.CodTipoCodBarra:= Tabela.FieldByName('I_COD_BAR').AsInteger;
  VpaDProduto.QtdMinima:= Tabela.FieldByName('N_QTD_MIN').AsFloat;
  VpaDProduto.QtdPedido:= Tabela.FieldByName('N_QTD_PED').AsFloat;
  VpaDProduto.QtdEstoque:= Tabela.FieldByName('N_QTD_PRO').AsFloat;
  VpaDProduto.QtdReservado := Tabela.FieldByName('N_QTD_RES').AsFloat;
  VpaDProduto.QtdAReservar := Tabela.FieldByName('N_QTD_ARE').AsFloat;
  VpaDProduto.QtdRealEstoque := VpaDProduto.QtdEstoque - VpaDProduto.QtdReservado - VpaDProduto.QtdAReservar;
  VpaDProduto.VlrCusto:= Tabela.FieldByName('N_VLR_CUS').AsFloat;

  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDPreco(VpaDProduto: TRBDProduto; VpaCodEmpresa, VpaSeqProduto: Integer);
Var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  FreeTObjectsList(VpaDProduto.TabelaPreco);
  AdicionaSQLAbreTabela(Tabela,'SELECT MOV.N_PER_MAX, MOV.N_VLR_VEN, MOV.N_VLR_REV, '+
                               ' CAD.I_COD_TAB, CAD.C_NOM_TAB, '+
                               ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                               ' MOE.I_COD_MOE, MOE.C_NOM_MOE, '+
                               ' TAM.CODTAMANHO, TAM.NOMTAMANHO, '+
                               ' COR.COD_COR, COR.NOM_COR ' +
                               ' FROM MOVTABELAPRECO MOV, CADCLIENTES CLI, TAMANHO TAM, CADMOEDAS MOE, CADTABELAPRECO CAD, COR '+
                               ' WHERE MOV.I_COD_EMP = '+IntToStr(VpaCodEmpresa)+
                               ' AND MOV. I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_CLI','CLI.I_COD_CLI')+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                               ' AND MOV.I_COD_MOE = MOE.I_COD_MOE '+
                               ' AND MOV.I_COD_TAB = CAD.I_COD_TAB');
  while not Tabela.Eof do
  begin
    VpfDTabelaPreco := VpaDProduto.AddTabelaPreco;
    VpfDTabelaPreco.CodTabelaPreco := Tabela.FieldByName('I_COD_TAB').AsInteger;
    VpfDTabelaPreco.NomTabelaPreco := Tabela.FieldByName('C_NOM_TAB').AsString;
    VpfDTabelaPreco.CodTamanho := Tabela.FieldByName('CODTAMANHO').AsInteger;
    VpfDTabelaPreco.NomTamanho := Tabela.FieldByName('NOMTAMANHO').AsString;
    VpfDTabelaPreco.CodCor := Tabela.FieldByName('COD_COR').AsInteger;
    VpfDTabelaPreco.NomCor := Tabela.FieldByName('NOM_COR').AsString;
    VpfDTabelaPreco.CodCliente := Tabela.FieldByName('I_COD_CLI').AsInteger;
    VpfDTabelaPreco.NomCliente := Tabela.FieldByName('C_NOM_CLI').AsString;
    VpfDTabelaPreco.CodMoeda := Tabela.FieldByName('I_COD_MOE').AsInteger;
    VpfDTabelaPreco.NomMoeda := Tabela.FieldByName('C_NOM_MOE').AsString;
    VpfDTabelaPreco.ValVenda := Tabela.FieldByName('N_VLR_VEN').AsFloat;
    VpfDTabelaPreco.ValReVenda := Tabela.FieldByName('N_VLR_REV').AsFloat;
    VpfDTabelaPreco.PerMaximoDesconto := Tabela.FieldByName('N_PER_MAX').AsFloat;
    if (Tabela.FieldByName('I_COD_TAB').AsInteger = VARIA.TabelaPreco) and
       (Tabela.FieldByName('I_COD_MOE').AsInteger = VARIA.MoedaBase) and
       (Tabela.FieldByName('CODTAMANHO').AsInteger = 0) and
       (Tabela.FieldByName('COD_COR').AsInteger = 0) and
       (Tabela.FieldByName('I_COD_CLI').AsInteger = 0) then
    begin
      VpaDProduto.PerMaxDesconto:= Tabela.FieldByName('N_PER_MAX').AsFloat;
      VpaDProduto.VlrVenda:= Tabela.FieldByName('N_VLR_VEN').AsFloat;
      VpaDProduto.VlrRevenda := Tabela.FieldByName('N_VLR_REV').AsFloat;
    end;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDProduto(VpaDProduto: TRBDProduto): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM CADPRODUTOS'+
                                    ' WHERE I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto));
  if ProCadastro.Eof then
    ProCadastro.Insert
  else
    ProCadastro.Edit;

// Gerais
  ProCadastro.FieldByName('I_COD_EMP').AsInteger:= VpaDProduto.CodEmpresa;
  ProCadastro.FieldByName('I_COD_MOE').AsInteger:= VpaDProduto.CodMoeda;
  if VpaDProduto.CodUsuario <> 0 then
    ProCadastro.FieldByName('I_COD_USU').AsInteger:= VpaDProduto.CodUsuario;
  ProCadastro.FieldByName('I_IND_COV').AsInteger:= VpaDProduto.QtdUnidadesPorCaixa;
  ProCadastro.FieldByName('N_PER_IPI').AsFloat:= VpaDProduto.PerIPI;
  ProCadastro.FieldByName('I_DIA_FOR').AsFloat:= VpaDProduto.QtdDiasEntregaFornecedor;
  ProCadastro.FieldByName('N_RED_ICM').AsFloat:= VpaDProduto.PerReducaoICMS;
  ProCadastro.FieldByName('N_PER_KIT').AsFloat:= VpaDProduto.PerDesconto;
  ProCadastro.FieldByName('N_PER_MAX').AsFloat:= VpaDProduto.PerMaxDesconto;
  ProCadastro.FieldByName('N_PER_COM').AsFloat:= VpaDProduto.PerComissao;
  ProCadastro.FieldByName('N_PER_LUC').AsFloat:= VpaDProduto.PerLucro;
  ProCadastro.FieldByName('C_COD_PRO').AsString:= VpaDProduto.CodProduto;
  ProCadastro.FieldByName('C_COD_UNI').AsString:= VpaDProduto.CodUnidade;
  ProCadastro.FieldByName('C_NOM_PRO').AsString:= VpaDProduto.NomProduto;
  ProCadastro.FieldByName('C_COD_CLA').AsString:= VpaDProduto.CodClassificacao;
  ProCadastro.FieldByName('C_CLA_FIS').AsString:= VpaDProduto.DesClassificacaoFiscal;
  ProCadastro.FieldByName('L_DES_TEC').AsString:= VpaDProduto.DesDescricaoTecnica;
  ProCadastro.FieldByName('I_ORI_PRO').AsInteger:= VpaDProduto.NumOrigemProduto;
  ProCadastro.FieldByName('C_BAR_FOR').AsString:= VpaDProduto.CodBarraFornecedor;
  ProCadastro.FieldByName('C_PAT_FOT').AsString:= VpaDProduto.PatFoto;
  ProCadastro.FieldByName('C_CIF_MOE').AsString:= VpaDProduto.CifraoMoeda;
  if VpaDProduto.IndProdutoAtivo then
    ProCadastro.FieldByName('C_ATI_PRO').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_ATI_PRO').AsString:= 'N';
  ProCadastro.FieldByName('D_ULT_ALT').AsDateTime:= Now;

// Cadarço
  if VpaDProduto.CodMaquina <> 0 then
    ProCadastro.FieldByName('CODMAQ').AsInteger:= VpaDProduto.CodMaquina
  else
    ProCadastro.FieldByName('CODMAQ').Clear;
  ProCadastro.FieldByName('C_ENG_EPE').AsString:= VpaDProduto.EngrenagemEspPequena;
  ProCadastro.FieldByName('I_QTD_FUS').AsInteger:= VpaDProduto.QuantidadeFusos;
  ProCadastro.FieldByName('C_TIT_FIO').AsString:= VpaDProduto.DesTituloFio;
  ProCadastro.FieldByName('I_TAB_PED').AsInteger:= VpaDProduto.MetrosTabuaPequena;
  ProCadastro.FieldByName('I_TAB_GRA').AsInteger:= VpaDProduto.MetrosTabuaGrande;
  ProCadastro.FieldByName('I_TAB_TRA').AsInteger:= VpaDProduto.MetrosTabuaTrans;
  ProCadastro.FieldByName('C_DES_ENC').AsString:= VpaDProduto.DesEnchimento;

// Etiqueta
  if VpaDProduto.CodSumula <> 0 then
    ProCadastro.FieldByName('I_COD_SUM').AsInteger:= VpaDProduto.CodSumula
  else
    ProCadastro.FieldByName('I_COD_SUM').Clear;
  ProCadastro.FieldByName('D_ENT_AMO').AsDateTime:= VpaDProduto.DatEntradaAmostra;
  ProCadastro.FieldByName('D_SAI_AMO').AsDateTime:= VpaDProduto.DatSaidaAmostra;
  ProCadastro.FieldByName('I_CMP_FIG').AsInteger:= VpaDProduto.CmpFigura;
  ProCadastro.FieldByName('C_PEN_PRO').AsString:= VpaDProduto.Pente;
  ProCadastro.FieldByName('C_BAT_PRO').AsString:= VpaDProduto.BatProduto;
  ProCadastro.FieldByName('C_BAT_TEA').AsString:= VpaDProduto.NumBatidasTear;
  if VpaDProduto.CodTipoFundo <> 0 then
    ProCadastro.FieldByName('I_COD_FUN').AsInteger:= VpaDProduto.CodTipoFundo
  else
    ProCadastro.FieldByName('I_COD_FUN').Clear;
  if VpaDProduto.CodTipoEmenda <> 0 then
    ProCadastro.FieldByName('CODEME').AsInteger:= VpaDProduto.CodTipoEmenda
  else
    ProCadastro.FieldByName('CODEME').Clear;
  if VpaDProduto.CodTipoCorte <> 0 then
    ProCadastro.FieldByName('I_COD_CRT').AsInteger:= VpaDProduto.CodTipoCorte
  else
    ProCadastro.FieldByName('I_COD_CRT').Clear;
  ProCadastro.FieldByName('I_IND_PRO').AsInteger:= VpaDProduto.PerProdutividade;
  ProCadastro.FieldByName('INDCAL').AsString:= VpaDProduto.IndCalandragem;
  ProCadastro.FieldByName('INDENG').AsString:= VpaDProduto.IndEngomagem;

// Adicionais
  ProCadastro.FieldByName('N_PES_LIQ').AsFloat:= VpaDProduto.PesoLiquido;
  ProCadastro.FieldByName('N_PES_BRU').AsFloat:= VpaDProduto.PesoBruto;
  ProCadastro.FieldByName('I_MES_GAR').AsInteger:= VpaDProduto.QtdMesesGarantia;
  if VpaDProduto.CodEmbalagem <> 0 then
    ProCadastro.FieldByName('I_COD_EMB').AsInteger:= VpaDProduto.CodEmbalagem
  else
    ProCadastro.FieldByName('I_COD_EMB').Clear;
  if VpaDProduto.CodAcondicionamento <> 0 then
    ProCadastro.FieldByName('I_COD_ACO').AsInteger:= VpaDProduto.CodAcondicionamento
  else
    ProCadastro.FieldByName('I_COD_ACO').Clear;
  ProCadastro.FieldByName('I_ALT_PRO').AsInteger:= VpaDProduto.AltProduto;
  if VpaDProduto.CodDesenvolvedor <> 0 then
    ProCadastro.FieldByName('I_COD_DES').AsInteger:= VpaDProduto.CodDesenvolvedor
  else
    ProCadastro.FieldByName('I_COD_DES').Clear;
  if VpaDProduto.CodComposicao <> 0 then
    ProCadastro.FieldByName('I_COD_COM').AsInteger:= VpaDProduto.CodComposicao
  else
    ProCadastro.FieldByName('I_COD_COM').Clear;
  ProCadastro.FieldByName('IMPPRE').AsString:= VpaDProduto.IndImprimeNaTabelaPreco;
  ProCadastro.FieldByName('C_IND_CRA').AsString:= VpaDProduto.IndCracha;
  ProCadastro.FieldByName('C_IND_RET').AsString:= VpaDProduto.IndProdutoRetornavel;
  ProCadastro.FieldByName('C_REN_PRO').AsString:= VpaDProduto.DesRendimento;
  if VpaDProduto.IndMonitorarEstoque then
    ProCadastro.FieldByName('C_IND_MON').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_IND_MON').AsString:= 'N';
  ProCadastro.FieldByName('N_CAP_LIQ').AsFloat := VpaDProduto.CapLiquida;


// Copiadoras
  ProCadastro.FieldByName('C_IND_COP').AsString:= VpaDProduto.IndCopiadora;
  ProCadastro.FieldByName('C_IND_MUL').AsString:= VpaDProduto.IndMultiFuncional;
  ProCadastro.FieldByName('C_IND_IMP').AsString:= VpaDProduto.IndImpressora;
  ProCadastro.FieldByName('C_IMP_COL').AsString:= VpaDProduto.IndColorida;
  ProCadastro.FieldByName('C_COM_REV').AsString:= VpaDProduto.IndComponente;
  ProCadastro.FieldByName('C_COM_CIL').AsString:= VpaDProduto.IndCilindro;
  ProCadastro.FieldByName('C_IND_RED').AsString:= VpaDProduto.IndPlacaRede;
  ProCadastro.FieldByName('C_IND_PCL').AsString:= VpaDProduto.IndPCL;
  ProCadastro.FieldByName('C_IND_FAX').AsString:= VpaDProduto.IndFax;
  ProCadastro.FieldByName('C_IND_USB').AsString:= VpaDProduto.IndUSB;
  ProCadastro.FieldByName('C_IND_SCA').AsString:= VpaDProduto.IndScanner;
  ProCadastro.FieldByName('C_IND_WIR').AsString:= VpaDProduto.IndWireless;
  ProCadastro.FieldByName('C_IND_SCR').AsString:= VpaDProduto.IndDuplex;
  ProCadastro.FieldByName('C_COD_CTA').AsString:= VpaDProduto.CodCartuchoAltaCapac;
  ProCadastro.FieldByName('I_QTD_CTB').AsInteger:= VpaDProduto.QtdCopiasTonner;
  ProCadastro.FieldByName('I_QTD_CTA').AsInteger:=VpaDProduto.QtdCopiasTonnerAltaCapac;
  ProCadastro.FieldByName('I_QTD_CCI').AsInteger:= VpaDProduto.QtdCopiasCilindro;
  ProCadastro.FieldByName('I_QTD_PPM').AsInteger:= VpaDProduto.QtdPagPorMinuto;
  ProCadastro.FieldByName('I_VOL_MEN').AsInteger:= VpaDProduto.VolumeMensal;
  ProCadastro.FieldByName('D_DAT_FAB').AsDateTime:= VpaDProduto.DatFabricacao;
  ProCadastro.FieldByName('D_DAT_ENC').AsDateTime:= VpaDProduto.DatEncerProducao;

// Cartuchos
  ProCadastro.FieldByName('I_PES_CVA').AsInteger:= VpaDProduto.PesCartuchoVazio;
  ProCadastro.FieldByName('I_PES_CCH').AsInteger:= VpaDProduto.PesCartucho;
  ProCadastro.FieldByName('I_QTD_MLC').AsInteger:= VpaDProduto.QtdMlCartucho;
  ProCadastro.FieldByName('I_QTD_PAG').AsInteger:= VpaDProduto.QtdPaginas;

  if VpaDProduto.CodCorCartucho <> 0 then
    ProCadastro.FieldByName('I_COD_COR').AsInteger:= VpaDProduto.CodCorCartucho
  else
    ProCadastro.FieldByName('I_COD_COR').Clear;

  ProCadastro.FieldByName('C_TIP_CAR').AsString:= VpaDProduto.DesTipoCartucho;
  if VpaDProduto.IndChipNovo then
    ProCadastro.FieldByName('C_CHI_NOV').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_CHI_NOV').AsString:= 'N';
  if VpaDProduto.IndCilindroNovo then
    ProCadastro.FieldByName('C_CIL_NOV').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_CIL_NOV').AsString:= 'N';
  if VpaDProduto.IndProdutoOriginal then
    ProCadastro.FieldByName('C_IND_ORI').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_IND_ORI').AsString:= 'N';
  if VpaDProduto.IndCartuchoTexto then
    ProCadastro.FieldByName('C_CAR_TEX').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_CAR_TEX').AsString:= 'N';
  if VpaDProduto.IndProdutoCompativel then
    ProCadastro.FieldByName('C_IND_COM').AsString:= 'S'
  else
    ProCadastro.FieldByName('C_IND_COM').AsString:= 'N';

// Dados que se repetem para várias páginas. Ex.: Largura Produto
  ProCadastro.FieldByName('I_LRG_PRO').AsInteger:= VpaDProduto.LarProduto;
  ProCadastro.FieldByName('I_CMP_PRO').AsInteger:= VpaDProduto.CmpProduto;
  ProCadastro.FieldByName('C_NUM_FIO').AsString:= VpaDProduto.NumFios;
  ProCadastro.FieldByName('METMIN').AsInteger:= VpaDProduto.MetrosPorMinuto;
  ProCadastro.FieldByName('ENGPRO').AsString:= VpaDProduto.Engrenagem;
  ProCadastro.FieldByName('C_PRA_PRO').AsString:= VpaDProduto.PraProduto;
  ProCadastro.FieldByName('C_ENG_EPE').AsString:= VpaDProduto.EngrenagemEspPequena;
  ProCadastro.FieldByName('C_TIP_IMP').AsString:= VpaDProduto.DesTipTear;
  ProCadastro.FieldByName('C_COD_CTB').AsString:= VpaDProduto.CodReduzidoCartucho;

// Campos inicializados manualmente
  ProCadastro.FieldByName('C_VEN_AVU').AsString:= 'S';
  if VpaDProduto.IndKit then
    ProCadastro.FieldByName('C_KIT_PRO').AsString:= 'K'
  else
    ProCadastro.FieldByName('C_KIT_PRO').AsString:= 'P';
  ProCadastro.FieldByName('C_FLA_PRO').AsString:= 'N';
  ProCadastro.FieldByName('C_IND_GEN').AsString:= 'N';
  ProCadastro.FieldByName('C_TIP_CLA').AsString:= 'P';

// Novo Cadastro
  if ProCadastro.State = dsInsert then
  begin
    ProCadastro.FieldByName('D_DAT_CAD').AsDateTime:= Now;
    VpaDProduto.SeqProduto:= FunProdutos.RSeqProdutoDisponivel;
  end;

  ProCadastro.FieldByName('I_SEQ_PRO').AsInteger:= VpaDProduto.SeqProduto;
  ProCadastro.Post;
  result:= ProCadastro.AMensagemErroGravacao;
  ProCadastro.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarCodNomProduto(VpaSeqproduto : Integer;var VpaCodProduto,VpaNomProduto : string);
begin
  AdicionaSQLAbreTabela(Aux,'Select C_COD_PRO, C_NOM_PRO from CADPRODUTOS ' +
                            '  Where I_SEQ_PRO = ' +IntToStr(VpaSeqproduto));
  VpaCodProduto := Aux.FieldByname('C_COD_PRO').AsString;
  VpaNomProduto := Aux.FieldByname('C_NOM_PRO').AsString;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarProdutoFaturadosnoMes(VpaDatInicio, VpaDatFim : TDateTime;VpaFilial : Integer);
var
  VpfSeqProdutoAtual : Integer;
begin
  ExecutaComandoSql(Aux,'Delete from REL_PRODUTO_VENDIDO_MES');
  AdicionaSQLAbreTabela(ProCadastro,'Select * from REL_PRODUTO_VENDIDO_MES');
  AdicionaSqlAbreTabela(ProProduto,'select SUM(MOV.N_QTD_PRO) QTD, MOV.I_SEQ_PRO, MOV.C_COD_UNI,  PRO.C_COD_UNI UNIORIGINAL '+
                                   ' from CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV, CADPRODUTOS PRO '+
                                   ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                                   ' and CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                                   ' and MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                   ' AND CAD.I_EMP_FIL = '+IntToStr(VpaFilial)+
                                   ' AND CAD.D_DAT_EMI >= ' + SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                                   ' AND CAD.D_DAT_EMI <= ' + SQLTextoDataAAAAMMMDD(VpaDatFim)+
                                   ' GROUP BY MOV.I_SEQ_PRO, MOV.C_COD_UNI, PRO.C_COD_UNI ');
  VpfSeqProdutoAtual := -1;
  While not ProProduto.Eof do
  begin
    if ProProduto.FieldByName('I_SEQ_PRO').AsInteger <> VpfSeqProdutoAtual then
    begin
      if VpfSeqProdutoAtual <> - 1 then
      begin
        ProCadastro.Post;
      end;
      ProCadastro.Insert;
      ProCadastro.FieldByName('SEQ_PRODUTO').AsInteger := ProProduto.FieldByName('I_SEQ_PRO').AsInteger;
      ProCadastro.FieldByName('QTD_VENDIDA').AsFloat := 0;
      ProCadastro.FieldByName('UM_PRODUTO').AsString := ProProduto.FieldByName('UNIORIGINAL').AsString;
    end;
    ProCadastro.FieldByName('QTD_VENDIDA').AsFloat := ProCadastro.FieldByName('QTD_VENDIDA').AsFloat + CalculaQdadePadrao(ProProduto.FieldByName('C_COD_UNI').AsString,ProProduto.FieldByName('UNIORIGINAL').AsString,ProProduto.FieldByName('QTD').AsFloat,ProProduto.FieldByName('I_SEQ_PRO').AsString);
    ProProduto.Next;
  end;
  if ProCadastro.State = dsinsert then
    ProCadastro.Post;
end;

{******************************************************************************}
function TFuncoesProduto.RMoedaProduto(VpaCodEmpresa, VpaSeqProduto : String) : integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_COD_MOE from CADPRODUTOS '+
                            ' WHERE I_COD_EMP = '+ VpaCodEmpresa +
                            ' and I_SEQ_PRO = ' + VpaSeqProduto);
  RESUlt := aux.FieldByName('I_COD_MOE').AsInteger;
end;

{******************************************************************************}
function TFuncoesProduto.RCombinacao(VpaDProduto : TRBDProduto;VpaCodCombinacao : Integer):TRBDCombinacao;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDProduto.Combinacoes.Count - 1 do
  begin
    if TRBDCombinacao(VpaDProduto.Combinacoes.Items[VpfLaco]).CodCombinacao = VpaCodCombinacao then
    begin
      result := TRBDCombinacao(VpaDProduto.Combinacoes.Items[VpfLaco]);
      exit;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqReferenciaDisponivel(VpaSeqProduto, VpaCodCliente : Integer): Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQ_REFERENCIA) ULTIMO from PRODUTO_REFERENCIA '+
                            ' Where SEQ_PRODUTO = '+IntTostr(VpaSeqProduto)+
                            ' and COD_CLIENTE = '+IntToStr(VpaCodCliente));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqReservaExcessoDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQRESERVA) ULTIMO from PRODUTORESERVADOEMEXCESSO');
  result :=  Aux.FieldByName('ULTIMO').AsInteger+1;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqReservaProdutoDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select MAX(SEQRESERVA) ULTIMO from RESERVAPRODUTO');
  result :=  Aux.FieldByName('ULTIMO').AsInteger+1;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.RReferenciaProduto(VpaSeqProduto,VpaCodCliente : Integer; VpaCodCor : String):String;
begin
  Aux.Sql.Clear;
  Aux.Sql.Add('Select DES_REFERENCIA from PRODUTO_REFERENCIA '+
              ' Where SEQ_PRODUTO = '+ IntToStr(VpaSeqProduto)+
              ' and COD_CLIENTE = '+ IntToStr(VpaCodCliente));
  if (VpaCodCor <> '0') and (VpaCodCor <> '') then
    Aux.Sql.Add('and COD_COR = '+ VpaCodCor)
  else
    Aux.Sql.Add('and '+SQLTextoIsnull('COD_COR','0')+ '= 0');

  Aux.Open;
  result := Aux.FieldByName('DES_REFERENCIA').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.CarProdutodaReferencia(VpaDesReferencia : String;VpaCodCliente : Integer;Var VpaCodProduto : String; Var VpaCodCor : Integer) : Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select PRO.C_COD_PRO, COD_COR ' +
                            ' FROM CADPRODUTOS PRO, PRODUTO_REFERENCIA REF  '+
                            ' Where REF.DES_REFERENCIA = '''+VpaDesReferencia+''''+
                            ' and REF.COD_CLIENTE = '+IntToStr(VpaCodCliente)+
                            ' and PRO.I_SEQ_PRO = REF.SEQ_PRODUTO');
  result := not Aux.Eof;
  if result then
  begin
    VpaCodProduto := AUX.FieldByName('C_COD_PRO').AsString;
    VpaCodCor := Aux.FieldByName('COD_COR').AsInteger;
  end;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RDesMMProduto(var VpaNomProduto : String) :String;
var
  VpfPosicao, VpfPosFinal : Integer;
begin
  result := '';
  VpfPosicao := pos('MM',UpperCase(VpaNomProduto));
  if VpfPosicao <= 0 then
    VpfPosicao := length(vpanomProduto);
  if VpfPosicao > 0 then
  begin
    VpfPosFinal := VpfPosicao + 1;
    dec(VpfPosicao);
    While (VpfPosicao > 1) and (VpaNomProduto[VpfPosicao] = ' ') do //retira os espacos entre o numero e o mm exemplo = 1 mm
      Dec(VpfPosicao);

    While (VpfPosicao > 1) and (VpaNomProduto[VpfPosicao] in ['0'..'9',',']) do //procura o inicio dos numeros
      Dec(VpfPosicao);

    result := copy(VpaNomProduto,VpfPosicao+1,VpfPosFinal - VpfPosicao); //retorna os mm

    if VpaNomProduto[VpfPosicao] = '(' then
    begin
      dec(VpfPosicao);
      inc(VpfPosFinal);
    end;
    delete(VpaNomProduto,VpfPosicao+1,VpfPosfinal-VpfPosicao);
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RComprimentoProduto(VpaSeqProduto : Integer):Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_CMP_PRO  from CADPRODUTOS '+
                            ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
  result := Aux.FieldByName('I_CMP_PRO').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.REstagioProduto(VpaDProduto : TRBDProduto;VpaSeqEstagio : Integer):TRBDEstagioProduto;
var
  VpfLaco : Integer;
begin
  result := nil;
  for VpfLaco := 0 to VpaDProduto.Estagios.Count - 1 do
  begin
    result := TRBDEstagioProduto(VpaDProduto.Estagios.Items[Vpflaco]);
    if Result.SeqEstagio = VpaSeqEstagio then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomePrincipioAtivo(VpaCodPrincipio : Integer) : String;
begin
  if VpaCodPrincipio <> 0 then
  begin
    AdicionaSQLAbreTabela(AUX,'Select * from PRINCIPIOATIVO '+
                              ' Where CODPRINCIPIO = '+IntToStr(VpaCodPrincipio));
    result := Aux.FieldByName('NOMPRINCIPIO').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeProduto(VpaSeqProduto : Integer) : String;
begin
  if VpaSeqProduto <> 0 then
  begin
    AdicionaSQLAbreTabela(AUX,'Select C_NOM_PRO from CADPRODUTOS '+
                              ' where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
    result := Aux.FieldByname('C_NOM_PRO').AsString;
    Aux.Close;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeClassificacao(VpaCodEmpresa : Integer;VpaCodClasssificacao : String):string;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_CLA from CADCLASSIFICACAO '+
                            ' Where I_COD_EMP = '+IntToStr(VpaCodEmpresa)+
                            ' and C_COD_CLA = '''+VpaCodClasssificacao+'''');
  Result := Aux.FieldByName('C_NOM_CLA').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RNomeComposicao(VpaCodComposicao : Integer):string;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMCOMPOSICAO from COMPOSICAO '+
                            ' Where CODCOMPOSICAO = '+IntToStr(VpaCodComposicao));
  Result := Aux.FieldByName('NOMCOMPOSICAO').AsString;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RAlturaProduto(VpaSeqProduto : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_ALT_PRO from CADPRODUTOS '+
                            ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
  result := Aux.FieldByname('I_ALT_PRO').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarUnidadesVenda(VpaUnidades: TStrings);
begin
  AdicionaSQLAbreTabela(AUX,'SELECT * FROM CADUNIDADE');
  while not AUX.Eof do
  begin
    VpaUnidades.Add(AUX.FieldByName('C_COD_UNI').AsString);
    AUX.Next;
  end;
  AUX.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarValVendaeRevendaProduto(VpaCodTabelaPreco, VpaSeqProduto, VpaCodCor, VpaCodTamanho, VpaCodCliente : Integer; var VpaValVenda,VpaValRevenda: Double);
begin
  AdicionaSQLAbreTabela(AUX,'Select (Pre.N_Vlr_Ven * Moe.N_Vlr_Dia) VlrReal, ' +
                            ' (Pre.N_VLR_REV * Moe.N_Vlr_Dia) VlrRevenda ' +
                            ' from MOVTABELAPRECO PRE, CADMOEDAS MOE '+
                            ' Where PRE.I_COD_MOE = MOE.I_COD_MOE '+
                            ' AND PRE.I_COD_MOE = '+IntToStr(Varia.MoedaBase) +
                            ' and PRE.I_COD_EMP = ' + IntToStr(VARIA.CodigoEmpresa)+
                            ' and PRE.I_COD_TAB = ' + IntToStr(VpaCodTabelaPreco)+
                            ' and PRE.I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' and PRE.I_COD_CLI in (0,'+ IntToStr(VpaCodCliente)+')'+
                            ' and PRE.I_COD_COR = ' + IntToStr(VpaCodCor)+
                            ' and PRE.I_COD_TAM = ' + IntToStr(VpaCodTamanho)+
                            ' ORDER BY PRE.I_COD_CLI DESC');
  VpaValVenda := AUX.FieldByName('VLRREAL').AsFloat;
  VpaValRevenda := AUX.FieldByName('VlrRevenda').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFuncoesProduto.RUnidadesParentes(VpaUM : String):TStringList;
begin
  result := ValidaUnidade.UnidadesParentes(VpaUM);
end;

{******************************************************************************}
function TFuncoesProduto.RSeqCartuchoDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(AUX,'Select I_SEQ_CAR from CFG_GERAL');
  Result := Aux.FieldByname('I_SEQ_CAR').AsInteger + 1;
  Aux.close;
  ExecutaComandoSql(AUX,'UPDATE CFG_GERAL SET I_SEQ_CAR = '+IntToStr(Result));
end;

{******************************************************************************}
function TFuncoesProduto.RQtdIdealEstoque(VpaCodFilial, VpaSeqProduto, VpaCodCor : Integer): Double;
begin
  AdicionaSqlAbreTabela(Aux,'Select N_QTD_PED from MOVQDADEPRODUTO '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_SEQ_PRO = '+IntToStr(VpaSeqProduto)+
                            ' and I_COD_COR = '+IntToStr(VpaCodCor));
  result := Aux.FieldByname('N_QTD_PED').AsFloat;
  Aux.close;
end;

{******************************************************************************}
function TFuncoesProduto.RQtdMetrosFita(VpaCodProduto,VpaNomProduto, VpaCodUM : string;VpaQtdProduto,VpaComprimentoProduto : Double; Var VpfErro : string):Double;
begin
  result := 0;
  VpfErro := '';
  if UpperCase(VpaCodUM) = 'MT' then
    result := VpaQtdProduto
  else
    if UpperCase(VpaCodUM) = 'KM' then
      result := (VpaQtdProduto * 1000)
    else
      if UpperCase(VpaCodUM) = 'CM' then
        result := (VpaQtdProduto /100)
      else
      begin
        if VpaComprimentoProduto = 0 then
          VpfErro := 'Produto "'+VpaCodProduto+'-'+ VpaNomProduto+'", está cadastrado em "'+VpaCodUM+'", e não possui a quantidade de metros do cadastrada'
        else
          result := ((VpaQtdProduto * VpaComprimentoProduto)  /100);
      end;
end;

{******************************************************************************}
function TFuncoesProduto.RTabelaPreco(VpaDProduto : TRBDProduto;VpaCodTabela,VpaCodCliente,VpaCodTamanho,VpaCodMoeda : Integer): TRBDProdutoTabelaPreco;
var
  VpfLaco : Integer;
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
begin
  result := nil;
  for Vpflaco := 0 to VpaDProduto.TabelaPreco.Count - 1 do
  begin
    VpfDTabelaPreco := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[VpfLaco]);
    if (VpfDTabelaPreco.CodTabelaPreco = VpaCodTabela) and
       (VpfDTabelaPreco.CodTamanho = VpaCodTamanho) and
       (VpfDTabelaPreco.CodCliente = VpaCodCliente) and
       (VpfDTabelaPreco.CodMoeda = VpaCodMoeda) then
    begin
      result := VpfDTabelaPreco;
      break;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.CombinacaoDuplicada(VpaDProduto : TRBDProduto):Boolean;
var
  VpfLaco, VpfLaco2 : Integer;
  VpfDCombinacao : TRBDCombinacao;
begin
  result := false;
  for VpfLaco := 0 to VpaDProduto.Combinacoes.count - 1 do
  begin
    VpfDCombinacao := TRBDCombinacao(VpaDProduto.Combinacoes.Items[Vpflaco]);
    for VpfLaco2 := VpfLaco + 1 to VpaDProduto.Combinacoes.Count - 1 do
    begin
      if VpfDCombinacao.CodCombinacao = TRBDCombinacao(VpaDProduto.Combinacoes.Items[Vpflaco2]).CodCombinacao then
      begin
        result := true;
        exit;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiCombinacoes(VpaSeqProduto : String);
begin
  ExecutaComandoSql(AUX,'Delete from COMBINACAOFIGURA '+
                        ' Where SEQPRO = '+VpaSeqProduto);
  ExecutaComandoSql(Aux,'Delete from COMBINACAO '+
                        ' Where SEQPRO = '+VpaSeqProduto);
end;

{******************************************************************************}
function TFuncoesProduto.ExcluiProdutoTabelaPreco(VpaCodtabela,VpaSeqProduto,VpaCodCliente : Integer):Boolean;
begin
  result :=  Confirmacao(CT_DeletaRegistro);
  if result then
  begin
    if VpaCodTabela = 0 then
    begin
      aviso('CODIGO DA TABELA DE PREÇO INVÁLIDA!!!'#13'É necessário informar o código da tabela de preço.');
      result := false;
    end;
    if result then
    begin
      ExecutaComandoSql(Aux,'Delete from MOVTABELAPRECO '+
                            ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                            ' and I_COD_TAB = '+ IntToStr(VpaCodTabela)+
                            ' and I_SEQ_PRO = ' + IntToStr(VpaSeqProduto)+
                            ' and I_COD_CLI = ' + IntToStr(VpaCodCliente));
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiMovimentoEstoque(VpaCodFilial,VpaLanEstoque,VpaSeqProduto : Integer);
begin
  ExecutaComandoSql(AUX,'Delete from movestoqueprodutos '+
                        ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                        ' and I_LAN_EST = '+ IntToStr(VpaLanEstoque)+
                        ' and I_SEQ_PRO = ' +IntToStr(VpaSeqProduto));
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiMovimentoEstoqueCotacao(VpaCodFilial,VpaSeqProduto,VpaLanOrcamento,VpaCodCor : Integer);
begin
  ExecutaComandoSql(AUX,'Delete from movestoqueprodutos '+
                        ' Where I_EMP_FIL = ' +IntToStr(VpaCodFilial)+
                        ' and I_SEQ_PRO = '+ IntToStr(VpaSeqProduto)+
                        ' and I_LAN_ORC = '+ IntToStr(VpaLanOrcamento)+
                        ' and I_COD_COR = '+ IntToStr(VpaCodCor));

end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiProdutoDuplicado(VpaSeqProdutoExcluir, VpaSeqProdutoDestino : Integer;VpaLog : TStrings);
begin
  VpaLog.Insert(0,'IMPORTANDO MOVKIT');
  ExecutaComandoSql(AUX,'UPDATE MOVKIT '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO MOVKITBASTIDOR');
  ExecutaComandoSql(AUX,'DELETE MOVKITBASTIDOR '+
                        ' Where SEQPRODUTOKIT = '+IntToStr(VpaSeqProdutoDestino));
  ExecutaComandoSql(AUX,'UPDATE MOVKITBASTIDOR '+
                        ' SET SEQPRODUTOKIT = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTOKIT = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO MOVIMENTAÇÃO DE ESTOQUE');
  ExecutaComandoSql(AUX,'UPDATE MOVESTOQUEPRODUTOS '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DO ORCAMENTO');
  ExecutaComandoSql(AUX,'UPDATE MOVORCAMENTOS '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DA NOTA FISCAL');
  ExecutaComandoSql(AUX,'UPDATE MOVNOTASFISCAIS '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS NOTA FISCAL ENTRADA');
  ExecutaComandoSql(AUX,'UPDATE MOVNOTASFISCAISFOR '+
                        ' SET I_SEQ_PRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORDEM PRODUCAO');
  ExecutaComandoSql(AUX,'UPDATE ORDEMPRODUCAOCORPO '+
                        ' SET SEQPRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO COMBINACAO FIGURA');
  ExecutaComandoSql(AUX,'UPDATE COMBINACAOFIGURA '+
                        ' SET SEQPRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO COMBINACAO');
  ExecutaComandoSql(AUX,'UPDATE COMBINACAO '+
                        ' SET SEQPRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO OPITEMCADARCO');
  ExecutaComandoSql(AUX,'UPDATE OPITEMCADARCO '+
                        ' SET SEQPRO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO AMOSTRACONSUMO');
  ExecutaComandoSql(AUX,'UPDATE AMOSTRACONSUMO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORCAMENTOPARCIALITEM');
  ExecutaComandoSql(AUX,'UPDATE ORCAMENTOPARCIALITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS ROTULADOS');
  ExecutaComandoSql(AUX,'UPDATE PROPOSTAPRODUTOROTULADO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORDEM SERRA');
  ExecutaComandoSql(AUX,'UPDATE ORDEMSERRA '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  ExecutaComandoSql(AUX,'UPDATE ORDEMSERRA '+
                        ' SET SEQMATERIAPRIMA = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQMATERIAPRIMA = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO FRACAO CONSUMO LOG');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOPCONSUMOLOG '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DO PLANO DE CORTE');
  ExecutaComandoSql(AUX,'UPDATE PLANOCORTEITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DO ORCAMENTO COMPRA');
  ExecutaComandoSql(AUX,'UPDATE ORCAMENTOCOMPRAITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS SEM QUANTIDADE DA PROPOSTA');
  ExecutaComandoSql(AUX,'UPDATE PROPOSTAPRODUTOSEMQTD '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS DO CONTRATO');
  ExecutaComandoSql(AUX,'UPDATE CONTRATOITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO BRINDE CLIENTE');
  ExecutaComandoSql(AUX,'UPDATE BRINDECLIENTE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITENS LEITURA LOCAÇÃO');
  ExecutaComandoSql(AUX,'UPDATE LEITURALOCACAOITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS CLIENTE');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOCLIENTE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO TAREFA TELEMARKETING');
  ExecutaComandoSql(AUX,'UPDATE TAREFATELEMARKETING '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ESTAGIO DA FRACAOOP');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOPESTAGIO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO DO ROMANEIO');
  ExecutaComandoSql(AUX,'UPDATE ROMANEIOPRODUTO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS DO CHAMADO');
  ExecutaComandoSql(AUX,'UPDATE CHAMADOPRODUTO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PESO DO CARTUCHO');
  ExecutaComandoSql(AUX,'UPDATE PESOCARTUCHO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS DA PROPOSTA');
  ExecutaComandoSql(AUX,'UPDATE PROPOSTAPRODUTO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOS DA IMPRESSORA');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOIMPRESSORA '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO RESERVA');
  ExecutaComandoSql(AUX,'UPDATE PRODUTORESERVA '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO DO PROSPECT');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOPROSPECT '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CONSUMO DA FRACAO');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOPCONSUMO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORCAMENTOITEMCOMPOSE');
  ExecutaComandoSql(AUX,'UPDATE ORCAMENTOITEMCOMPOSE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITEM PEDIDO COMPRA');
  ExecutaComandoSql(AUX,'UPDATE PEDIDOCOMPRAITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO TAREFA TELEMARKETING');
  ExecutaComandoSql(AUX,'UPDATE TAREFAEMARKETING '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO TAREFA TELEMARKETING PROSPECT');
  ExecutaComandoSql(AUX,'UPDATE TAREFATELEMARKETINGPROSPECT '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO TAREFA EMARKETING PROSPECT');
  ExecutaComandoSql(AUX,'UPDATE TAREFAEMARKETINGPROSPECT '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ITEM DA SOLICITAÇÃO DE COMPRA');
  ExecutaComandoSql(AUX,'UPDATE SOLICITACAOCOMPRAITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PROPOSTA LOCACACAO');
  ExecutaComandoSql(AUX,'UPDATE PROPOSTALOCACAO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO FRACAOOP');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOP '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO FRACAOOPCOMPOSE');
  ExecutaComandoSql(AUX,'UPDATE FRACAOOPCOMPOSE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CHAMADOPRODUTOORCADO');
  ExecutaComandoSql(AUX,'UPDATE CHAMADOPRODUTOORCADO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CONSUMO ORDEM PRODUCAO');
  ExecutaComandoSql(AUX,'UPDATE ORDEMPRODUCAOCONSUMO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO FUSO');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOFUSO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PEDIDOCOMPRANOTAFISCALITEM');
  ExecutaComandoSql(AUX,'UPDATE PEDIDOCOMPRANOTAFISCALITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORDEMCOMPRAITEM');
  ExecutaComandoSql(AUX,'UPDATE ORDEMCORTEITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTOINTERESSE');
  ExecutaComandoSql(AUX,'UPDATE PRODUTOINTERESSECLIENTE '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CHAMADOPRODUTOEXTRA');
  ExecutaComandoSql(AUX,'UPDATE CHAMADOPRODUTOEXTRA '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO CHAMADOPARCIALPRODUTO');
  ExecutaComandoSql(AUX,'UPDATE CHAMADOPARCIALPRODUTO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO ORCAMENTOCOMRAFORNECEDORITEM');
  ExecutaComandoSql(AUX,'UPDATE ORCAMENTOCOMPRAFORNECEDORITEM '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTANDO PRODUTO DEFEITO');
  ExecutaComandoSql(AUX,'UPDATE PRODUTODEFEITO '+
                        ' SET SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                        ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoExcluir));

  //atualiza quantidade em estoque
  VpaLog.Insert(0,'IMPORTANDO AS QUANTIDADES DE ESTOQUE');
  ImportaEstoqueProdutAExcluir(VpaSeqProdutoExcluir,VpaSeqProdutoDestino);
  VpaLog.Insert(0,'IMPORTANDO OS PRODUTOS FORNECEDOR');
  ImportaProdutofornecedor(VpaSeqProdutoExcluir,VpaSeqProdutoDestino);
  VpaLog.Insert(0,'IMPORTANDO AS QUANTIDADES DO ESTOQUE DO TECNICO');
  ImportaEstoqueTecnico(VpaSeqProdutoExcluir,VpaSeqProdutoDestino);

  VpaLog.Insert(0,'EXCLUINDO ESTOQUE DO TECNICO');
  ExecutaComandoSql(Aux,'DELETE FROM ESTOQUETECNICO '+
                        ' Where SEQPRODUTO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO MOVKIT');
  ExecutaComandoSql(Aux,'DELETE FROM MOVKIT '+
                        ' Where I_PRO_KIT = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO QUANTIDADE DE ESTOQUE');
  ExecutaComandoSql(Aux,'DELETE FROM MOVQDADEPRODUTO '+
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO TABELA DE PREÇO');
  ExecutaComandoSql(Aux,'DELETE FROM MOVTABELAPRECO '+
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO ESTOQUE DO MOVSUMARIZAESTOQUE');
  ExecutaComandoSql(Aux,'DELETE FROM MOVSUMARIZAESTOQUE '+
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO ESTOQUE DO PRODUTOESTAGIO');
  ExecutaComandoSql(Aux,'DELETE FROM PRODUTOESTAGIO '+
                        ' Where SEQPRODUTO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'EXCLUINDO O PRODUTO');
  ExecutaComandoSql(Aux,'DELETE FROM CADPRODUTOS '+
                        ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProdutoExcluir));
  VpaLog.Insert(0,'IMPORTAÇÃO REALIZADA COM SUCESSO.');
end;

{******************************************************************************}
procedure TFuncoesProduto.ExcluiComposicaoFiguraGRF(VpaCodComposicao : Integer);
begin
  ExecutaComandoSql(AUX,'DELETE from COMPOSICAOFIGURAGRF ' +
                                     ' Where CODCOMPOSICAO = '+IntToStr(VpaCodComposicao));
end;

{******************************************************************************}
function TFuncoesProduto.GravaDCombinacao(VpaDProduto : TRBDProduto):String;
Var
  VpfLaco, VpfLacoFigura : Integer;
  VpfDCombinacao : TRBDCombinacao;
  VpfDFigura : TRBDCombinacaoFigura;
begin
  result := '';
  ExcluiCombinacoes(IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * FROM COMBINACAO');
  for VpfLaco := 0 to VpaDProduto.Combinacoes.count - 1 do
  begin
    VpfDCombinacao := TRBDCombinacao(VpaDProduto.Combinacoes.Items[VpfLaco]);
    ProCadastro.Insert;
    ProCadastro.FieldByName('SEQPRO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('CODCOM').AsInteger := VpfDCombinacao.CodCombinacao;
    ProCadastro.FieldByName('CORFU1').AsString := VpfDCombinacao.CorFundo1;
    ProCadastro.FieldByName('CORFU2').AsString := VpfDCombinacao.CorFundo2;
    ProCadastro.FieldByName('TITFU1').AsString := VpfDCombinacao.TituloFundo1;
    ProCadastro.FieldByName('TITFU2').AsString := VpfDCombinacao.TituloFundo2;
    ProCadastro.FieldByName('ESPFU1').AsInteger := VpfDCombinacao.Espula1;
    ProCadastro.FieldByName('ESPFU2').AsInteger := VpfDCombinacao.Espula2;
    ProCadastro.FieldByName('CORCAR').AsInteger := VpfDCombinacao.CorCartela;
    ProCadastro.FieldByName('CORFUF').AsString := VpfDCombinacao.CorUrdumeFigura;
    ProCadastro.FieldByName('ESPFUF').AsInteger := VpfDCombinacao.EspulaUrdumeFigura;
    ProCadastro.FieldByName('TITFUF').AsString := VpfDCombinacao.TituloFundoFigura;

    try
      ProCadastro.post;
    except
      on e : Exception do
      begin
        result := 'ERRRO NA GRAVAÇÃO DA COMBINAÇÃO!!!'#13+e.message;
        exit;
      end;
    end;
  end;

  AdicionaSQLAbreTabela(ProCadastro,'Select * FROM COMBINACAOFIGURA');
  for VpfLaco := 0 to VpaDProduto.Combinacoes.count - 1 do
  begin
    VpfDCombinacao := TRBDCombinacao(VpaDProduto.Combinacoes.Items[VpfLaco]);
    for VpfLacoFigura := 0 to VpfDCombinacao.Figuras.Count - 1 do
    begin
      VpfDFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);

      ProCadastro.Insert;
      ProCadastro.FieldByName('SEQPRO').AsInteger := VpaDProduto.SeqProduto;
      ProCadastro.FieldByName('CODCOM').AsInteger := VpfDCombinacao.CodCombinacao;
      ProCadastro.FieldByName('SEQCOR').AsInteger := VpfDFigura.SeqFigura;
      ProCadastro.FieldByName('CODCOR').AsString := VpfDFigura.CodCor;
      ProCadastro.FieldByName('TITFIO').AsString := VpfDFigura.TitFio;
      ProCadastro.FieldByName('NUMESP').AsInteger := VpfDFigura.NumEspula;
      try
        ProCadastro.post;
      except
        on e : Exception do
        begin
          result := 'ERRRO NA GRAVAÇÃO DA COMBINAÇÃO FIGURA!!!'#13+e.message;
          exit;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDMovimentoEstoque(VpaDMovimento : TRBDMovEstoque): String;
begin
  AdicionaSQLAbreTabela(ProCadastro, ' Select * From MovEstoqueProdutos '+
                                ' Where I_EMP_FIL = '+ IntToStr(VpaDMovimento.CodFilial)+
                                ' and I_LAN_EST = '+ IntToStr(VpaDMovimento.LanEstoque));
  if VpaDMovimento.LanEstoque = 0 then
    ProCadastro.Insert
  else
    ProCadastro.edit;
  ProCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDMovimento.CodFilial;
  ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpaDMovimento.SeqProduto;
  ProCadastro.FieldByName('I_COD_OPE').AsInteger := VpaDMovimento.CodOperacaoEstoque;
  ProCadastro.FieldByName('D_DAT_MOV').AsDateTime := VpaDMovimento.DatMovimento;
  ProCadastro.FieldByName('N_QTD_MOV').AsFloat := VpaDMovimento.QtdProduto;
  ProCadastro.FieldByName('C_TIP_MOV').AsString := VpaDMovimento.TipMovimento;
  ProCadastro.FieldByName('N_VLR_MOV').AsFloat := VpaDMovimento.ValMovimento;
  ProCadastro.FieldByName('D_DAT_CAD').AsDateTime := date;
  ProCadastro.FieldByName('C_COD_UNI').AsString := VpaDMovimento.CodUnidade;
  ProCadastro.FieldByName('I_COD_COR').AsInteger := VpaDMovimento.CodCor;
  ProCadastro.FieldByName('N_VLR_CUS').AsFloat := VpaDMovimento.valCusto;

  if VpaDMovimento.NumNota <> 0 then
    ProCadastro.FieldByName('I_NRO_NOT').AsInteger := VpaDMovimento.NumNota
  else
    ProCadastro.FieldByName('I_NRO_NOT').clear;

  if VpaDMovimento.SeqNotaEntrada <> 0 then
      ProCadastro.FieldByName('I_NOT_ENT').AsInteger := VpaDMovimento.SeqNotaEntrada
  else
    if VpaDMovimento.SeqNotaSaida <> 0 then
      ProCadastro.FieldByName('I_NOT_SAI').AsInteger := VpaDMovimento.SeqNotaSaida;
  try
    ProCadastro.FieldByName('I_LAN_EST').AsInteger := GeraProximoCodigo('I_LAN_EST', 'MovEstoqueProdutos', 'I_EMP_FIL', VpaDMovimento.CodFilial, false,ProCadastro.ASQLConnection );
    ProCadastro.post;
  except
    on e :exception do result := 'ERRO NA GRAVAÇÃO DO MOVIMENTO DE ESTOQUE!!!'#13+e.message;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDCombinacao(VpaDProduto : TRBDProduto);
Var
  VpfDCombinacao : TRBDCombinacao;
  VpfDFigura : TRBDCombinacaoFigura;
begin
  AdicionaSQLAbreTabela(ProProduto,'Select * from COMBINACAO '+
                                   ' Where SEQPRO = '+ IntToStr(VpaDProduto.SeqProduto)+
                                   ' order by CODCOM');
  While not ProProduto.Eof do
  begin
    VpfDCombinacao := VpaDProduto.AddCombinacao;
    VpfDCombinacao.CodCombinacao := ProProduto.FieldByName('CODCOM').AsInteger;
    VpfDCombinacao.CorFundo1 := ProProduto.FieldByName('CORFU1').AsString;
    VpfDCombinacao.CorFundo2 := ProProduto.FieldByName('CORFU2').AsString;
    VpfDCombinacao.TituloFundo1 := ProProduto.FieldByName('TITFU1').AsString;
    VpfDCombinacao.TituloFundo2 := ProProduto.FieldByName('TITFU2').AsString;
    VpfDCombinacao.Espula1 := ProProduto.FieldByName('ESPFU1').AsInteger;
    VpfDCombinacao.Espula2 := ProProduto.FieldByName('ESPFU2').AsInteger;
    VpfDCombinacao.CorCartela := ProProduto.FieldByName('CORCAR').AsInteger;
    VpfDCombinacao.CorUrdumeFigura := ProProduto.FieldByName('CORFUF').AsString;
    VpfDCombinacao.EspulaUrdumeFigura := ProProduto.FieldByName('ESPFUF').AsInteger;
    VpfDCombinacao.TituloFundoFigura := ProProduto.FieldByName('TITFUF').AsString;

    AdicionaSQLAbreTabela(Tabela,'Select * from COMBINACAOFIGURA '+
                                 ' Where SEQPRO = '+ IntToStr(VpaDProduto.SeqProduto)+
                                 ' and CODCOM = '+IntToStr(VpfDCombinacao.CodCombinacao) +
                                 ' order by SEQCOR');
    While not Tabela.eof do
    begin
      VpfDFigura := VpfDCombinacao.AddFigura;
      VpfDFigura.SeqFigura := Tabela.FieldByName('SEQCOR').AsInteger;
      VpfDFigura.CodCor := Tabela.FieldByName('CODCOR').AsString;
      VpfDFigura.TitFio := Tabela.FieldByName('TITFIO').AsString;
      VpfDFigura.NumEspula := Tabela.FieldByName('NUMESP').AsInteger;
      Tabela.Next;
    end;
    ProProduto.next;
  end;
  ProProduto.close;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDEstagio(VpaDProduto : TRBDProduto);
Var
  VpfDEstagio :TRBDEstagioProduto;
begin
  FreeTObjectsList(VpaDProduto.Estagios);
  AdicionaSQLAbreTabela(ProProduto,'Select * from PRODUTOESTAGIO PRO, ESTAGIOPRODUCAO EST'+
                                   ' Where SEQPRODUTO = '+InttoStr(VpaDProduto.SeqProduto)+
                                   ' and PRO.CODESTAGIO = EST.CODEST'+
                                   ' order by PRO.SEQESTAGIO');
  While not ProProduto.Eof do
  begin
    VpfDEstagio := VpaDProduto.AddEstagio;
    VpfDEstagio.SeqEstagio := ProProduto.FieldByName('SEQESTAGIO').AsInteger;
    VpfDEstagio.NumOrdem := ProProduto.FieldByName('NUMORDEM').AsInteger;
    VpfDEstagio.CodEstagio := ProProduto.FieldByName('CODESTAGIO').AsInteger;
    VpfDEstagio.NomEstagio := ProProduto.FieldByName('NOMEST').AsString;
    VpfDEstagio.CodEstagioAnterior := ProProduto.FieldByName('CODESTAGIOANTERIOR').AsInteger;
    if VpfDEstagio.CodEstagioAnterior <> 0 then
      ExisteEstagio(IntTostr(VpfDEstagio.CodEstagioAnterior),VpfDEstagio.NomEstagioAnterior);
    VpfDEstagio.QtdEstagioAnterior := ProProduto.FieldByName('QTDESTAGIOANTERIOR').AsInteger;
    VpfDEstagio.DesEstagio := ProProduto.FieldByName('DESESTAGIO').AsString;
    VpfDEstagio.IndConfig := ProProduto.FieldByName('INDCONFIG').AsString;
    VpfDEstagio.DesTempoConfig := ProProduto.FieldByName('DESTEMPOCONFIG').AsString;
    VpfDEstagio.QtdProducaoHora := ProProduto.FieldByName('QTDPRODUCAOHORA').AsFloat;
    ProProduto.next;
  end;
  ProProduto.close;
end;

{******************************************************************************}
function TFuncoesProduto.ReferenciaProdutoDuplicada(VpaCodCliente,VpaSeqProduto,VpaSeqReferencia, VpaCodCor : Integer):Boolean;
begin
  Aux.Close;
  Aux.Sql.Clear;
  Aux.Sql.Add('Select * from PRODUTO_REFERENCIA '+
              ' Where SEQ_PRODUTO = '+IntToStr(VpaSeqProduto) +
              ' and COD_CLIENTE = '+ IntToStr(VpaCodCliente)+
              ' and SEQ_REFERENCIA <> '+ IntToStr(VpaSeqReferencia));
  if VpaCodCor <> 0 then
    Aux.Sql.Add(' and COD_COR = '+IntToStr(VpaCodCor));
  Aux.Open;
  result := not Aux.eof;
  AUX.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDConsumoMP(VpaDProduto : TRBDProduto;VpaCorKit : Integer) : String;
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoMP;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from MOVKITBASTIDOR '+
                        ' Where SEQPRODUTOKIT = '+ IntToStr(VpaDProduto.SeqProduto)+
                        ' and SEQCORKIT = '+IntToStr(VpaCorkit));
  ExecutaComandoSql(Aux,'Delete from MOVKIT '+
                        ' Where I_PRO_KIT = '+ IntToStr(VpaDProduto.SeqProduto)+
                        ' and I_COD_EMP = '+InttoStr(VpaDProduto.CodEmpresa)+
                        ' and I_COR_KIT = '+IntToStr(VpaCorkit));
  AdicionaSqlAbreTabela(ProCadastro,'Select * from MOVKIT '+
                                    ' Where I_PRO_KIT = 0 AND I_SEQ_MOV = 0 AND I_COR_KIT = 0 ');
  for VpfLaco := 0 to VpaDProduto.ConsumosMP.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLaco]);
    ProCadastro.Insert;
    ProCadastro.FieldByName('I_PRO_KIT').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('I_COR_KIT').AsInteger := VpaCorKit;
    VpfDConsumo.SeqMovimento := VpfLaco + 1;
    ProCadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfDConsumo.SeqMovimento;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpfDConsumo.SeqProduto;
    procadastro.FieldByName('N_QTD_PRO').AsFloat := VpfDConsumo.QtdProduto;
    ProCadastro.FieldByName('I_COD_EMP').AsInteger := VpaDProduto.CodEmpresa;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := now;
    if VpfDConsumo.CodCor <> 0 then
      ProCadastro.FieldByName('I_COD_COR').AsInteger := VpfDConsumo.CodCor;
    if VpfDConsumo.CodCor <> 0 then
      ProCadastro.FieldByName('I_COR_REF').AsInteger := VpfDConsumo.CorReferencia;

    ProCadastro.FieldByName('C_COD_UNI').AsString := VpfdConsumo.UM;

    ProCadastro.FieldByName('N_VLR_UNI').AsFloat:= VpfDConsumo.ValorUnitario;
    ProCadastro.FieldByName('N_VLR_TOT').AsFloat:= VpfDConsumo.ValorTotal;
    ProCadastro.FieldByName('N_PEC_MET').AsFloat:= VpfDConsumo.PecasMT;
    ProCadastro.FieldByName('N_IND_MET').AsFloat:= VpfDConsumo.IndiceMT;

    if VpfDConsumo.Faca.CodFaca <> 0 then
      ProCadastro.FieldByName('I_COD_FAC').AsInteger:= VpfDConsumo.Faca.CodFaca;
    if VpfDConsumo.AlturaMolde <> 0 then
      ProCadastro.FieldByName('I_ALT_MOL').AsFloat:= VpfDConsumo.AlturaMolde;
    if VpfDConsumo.LarguraMolde <> 0 then
      ProCadastro.FieldByName('I_LAR_MOL').AsFloat:= VpfDConsumo.LarguraMolde;
    if VpfDConsumo.Maquina.CodMaquina <> 0 then
      ProCadastro.FieldByName('I_COD_MAQ').AsInteger:= VpfDConsumo.Maquina.CodMaquina;
    if VpfDConsumo.SeqProdutoEntretela <> 0 then
      ProCadastro.FieldByName('I_SEQ_ENT').AsInteger:= VpfDConsumo.SeqProdutoEntretela;
    if VpfDConsumo.SeqProdutoTermoColante <> 0 then
      ProCadastro.FieldByName('I_SEQ_TER').AsInteger:= VpfDConsumo.SeqProdutoTermoColante;
    if VpfDConsumo.QtdEntretela <> 0 then
      ProCadastro.FieldByName('I_QTD_ENT').AsInteger:= VpfDConsumo.QtdEntretela;
    if VpfDConsumo.QtdTermoColante <> 0 then
      ProCadastro.FieldByName('I_QTD_TER').AsInteger:= VpfDConsumo.QtdTermoColante;
    if VpfDConsumo.DatDesenho > MontaData(1,1,1900) then
      ProCadastro.FieldByName('D_DAT_DES').AsDateTime := VpfDConsumo.DatDesenho;


    ProCadastro.FieldByName('C_DES_OBS').AsString := VpfdConsumo.DesObservacoes;
    try
      ProCadastro.Post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DO CONSUMO DO PRODUTO!!!'#13+e.message;
        exit;
      end;
    end;
  end;
  ProCadastro.Close;
  if Result = '' then
    GravaDConsumoMPBastidor(VpaDProduto,VpaCorKit);
end;

{******************************************************************************}
function TFuncoesProduto.GravaDEstagio(VpaDProduto : TRBDProduto) : String;
Var
  VpfLaco : Integer;
  VpfDEstagio : TRBDEstagioProduto;
begin
  result := '';
  ExecutaComandoSql(AUX,'DELETE FROM PRODUTOESTAGIO '+
                        ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOESTAGIO '+
                                    ' Where SEQPRODUTO = 0 AND SEQESTAGIO = 0');
  for VpfLaco := 0 to VpaDProduto.Estagios.Count - 1 do
  begin
    VpfDEstagio := TRBDEstagioProduto(VpaDProduto.Estagios.Items[VpfLaco]);
    ProCadastro.Insert;
    Procadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
    Procadastro.FieldByName('SEQESTAGIO').AsInteger := VpfDEstagio.SeqEstagio;
    Procadastro.FieldByName('NUMORDEM').AsInteger := VpfDEstagio.NumOrdem;
    Procadastro.FieldByName('CODESTAGIO').AsInteger := VpfDEstagio.CodEstagio;
    Procadastro.FieldByName('DESESTAGIO').AsString := VpfDEstagio.DesEstagio;
    Procadastro.FieldByName('QTDPRODUCAOHORA').AsFloat := VpfDEstagio.QtdProducaoHora;
    if VpfDEstagio.CodEstagioAnterior <> 0 then
      Procadastro.FieldByName('CODESTAGIOANTERIOR').AsInteger := VpfDEstagio.CodEstagioAnterior
    else
      Procadastro.FieldByName('CODESTAGIOANTERIOR').clear;
    Procadastro.FieldByName('INDCONFIG').AsString := VpfDEstagio.IndConfig;
    Procadastro.FieldByName('DESTEMPOCONFIG').AsString := VpfDEstagio.DesTempoConfig;
    Procadastro.FieldByName('QTDESTAGIOANTERIOR').AsInteger := VpfDEstagio.QtdEstagioAnterior;
    try
      ProCadastro.Post;
    except
      on e : exception do result := 'ERRO NA GRAVAÇÃO DO ESTAGIO DO PRODUTO!!!'#13+e.message;
    end;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaProdutoImpressoras(VpaSeqProduto : Integer; VpaImpressoras : TList):string;
var
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete PRODUTOIMPRESSORA '+
                        ' Where SEQPRODUTO = ' +IntToStr(VpaSeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOIMPRESSORA ');
  for VpfLaco := 0 to VpaImpressoras.count - 1 do
  begin
    ProCadastro.Insert;
    ProCadastro.FieldByname('SEQPRODUTO').AsInteger := VpaSeqProduto;
    ProCadastro.FieldByname('SEQIMPRESSORA').AsInteger := TRBDProdutoImpressora(VpaImpressoras.Items[Vpflaco]).SeqImpressora;
    try
      ProCadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DAS IMPRESSORAS DO PRODUTO!!!'#13+e.message;
        break;
      end;
    end;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaProdutoReservadoEmExcesso(VpaSeqProduto, VpaCodFilial, VpaSeqOrdem: Integer; VpaDesUM: String; VpaQtdEstoque, VpaQtdReservado, VpaQtdExcesso: Double): String;
begin
  AdicionaSQLAbreTabela(ProCadastro2,'Select * from PRODUTORESERVADOEMEXCESSO '+
                                    ' Where SEQRESERVA = 0 ');
  ProCadastro2.Insert;
  ProCadastro2.FieldByName('DATRESERVA').AsDateTime := now;
  ProCadastro2.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
  ProCadastro2.FieldByName('QTDESTOQUEPRODUTO').AsFloat := VpaQtdEstoque;
  ProCadastro2.FieldByName('QTDRESERVADO').AsFloat := VpaQtdReservado;
  ProCadastro2.FieldByName('QTDEXCESSO').AsFloat := VpaQtdExcesso;
  if VpaSeqOrdem <> 0 then
  begin
    ProCadastro2.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
    ProCadastro2.FieldByName('SEQORDEMPRODUCAO').AsInteger := VpaSeqOrdem;
  end;
  ProCadastro2.FieldByName('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
  ProCadastro2.FieldByName('DESUM').AsString := VpaDesUM;
  ProCadastro2.FieldByName('SEQRESERVA').AsInteger := RSeqReservaExcessoDisponivel;
  ProCadastro2.Post;
  Result := ProCadastro2.AMensagemErroGravacao;
  ProCadastro2.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaPesoCartucho(VpaDPesoCartucho : TRBDPesoCartucho;VpaDProduto : TRBDProduto):string;
var
  VpfSeqBarra : Integer;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from PESOCARTUCHO '+
                                    'Where SEQCARTUCHO = 0');
  ProCadastro.insert;
  ProCadastro.FieldByname('SEQCARTUCHO').AsInteger := VpaDPesoCartucho.SeqCartucho;
  ProCadastro.FieldByname('SEQPRODUTO').AsInteger := VpaDPesoCartucho.SeqProduto;
  ProCadastro.FieldByname('DATPESO').AsDateTime := VpaDPesoCartucho.DatPeso;
  ProCadastro.FieldByname('PESCARTUCHO').AsFloat := VpaDPesoCartucho.PesCartucho;
  ProCadastro.FieldByname('CODUSUARIO').AsInteger := VpaDPesoCartucho.CodUsuario;
  ProCadastro.FieldByname('CODCELULA').AsInteger := VpaDPesoCartucho.CodCelula;
  if VpaDPesoCartucho.SeqPo <> 0 then
    ProCadastro.FieldByname('SEQPRODUTOPO').AsInteger := VpaDPesoCartucho.SeqPo;
  if VpaDPesoCartucho.SeqCilindro <> 0 then
    ProCadastro.FieldByname('SEQPRODUTOCILINDRO').AsInteger := VpaDPesoCartucho.SeqCilindro;
  if VpaDPesoCartucho.SeqChip <> 0 then
    ProCadastro.FieldByname('SEQPRODUTOCHIP').AsInteger := VpaDPesoCartucho.SeqChip;

  try
    ProCadastro.Post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO PESO DO CARTUCHO!!!'+#13+e.message;
  end;
  ProCadastro.close;
  if result = '' then
    if not VpaDProduto.IndProdutoCompativel then
      BaixaProdutoEstoque(VpaDProduto,varia.CodigoEmpFil,varia.OperacaoEstoqueImpressaoEtiqueta,0,0,0,varia.MoedaBase,0,0,date,1,0,VpaDProduto.CodUnidade,'',false,VpfSeqBarra,true);
end;

{******************************************************************************}
function TFuncoesProduto.GravaBaixaConsumoProduto1(VpaCodigoFilial, VpaSeqOrdem,VpaSeqFracao, VpaCodUsuario: Integer;VpaIndConsumoOrdemCorte : Boolean; VpaBaixas: TList): String;
begin
  if VpaSeqFracao <> 0 then
    result := GravaDBaixaConsumoFracaoProduto1(VpaCodigoFilial,VpaSeqOrdem,VpaSeqFracao, VpaCodUsuario, VpaBaixas)
  else
    result := GravaDBaixaConsumoOPProduto(VpaCodigoFilial,VpaSeqOrdem,VpaCodUsuario, VpaIndConsumoOrdemCorte, VpaBaixas);
end;

{******************************************************************************}
function TFuncoesProduto.GravaFigurasGRF(VpaCodComposicao : Integer;VpaFiguras : TList) : string;
var
  VpfLaco : Integer;
  VpfDFigura : TRBDFiguraGRF;
begin
  result := '';
  ExecutaComandoSql(AUX,'DELETE from COMPOSICAOFIGURAGRF ' +
                                     ' Where CODCOMPOSICAO = '+IntToStr(VpaCodComposicao));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from COMPOSICAOFIGURAGRF '+
                                     ' Where CODCOMPOSICAO = 0 AND CODFIGURAGRF = 0 ');
  for Vpflaco := 0 to VpaFiguras.count - 1 do
  begin
    ProCadastro.Insert;
    VpfDFigura := TRBDFiguraGRF(VpaFiguras.Items[VpfLaco]);
    ProCadastro.Insert;
    ProCadastro.FieldByName('CODCOMPOSICAO').AsInteger := VpaCodComposicao;
    ProCadastro.FieldByName('CODFIGURAGRF').AsInteger := VpfDFigura.CodFiguraGRF;
    try
      ProCadastro.Post;
    except
      on e : exception do exit('ERRO NA GRAVAÇÃO DA COMPOSICAOFIGURAGRF!!!'#13+e.message);
    end;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaMovimentoProdutoReservado(VpaSeqProduto, VpaCodFilial, VpaSeqOrdem: Integer; VpaDesUM : String;VpaQtdReservado, VpaQtdInicial,VpaQtdAtual: Double;VpaTipMovimento : String): String;
begin
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM RESERVAPRODUTO '+
                                    ' Where SEQRESERVA = 0 ');
  ProCadastro.Insert;
  ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProduto;
  ProCadastro.FieldByName('DESUM').AsString := VpaDesUM;
  ProCadastro.FieldByName('TIPMOVIMENTO').AsString := VpaTipMovimento;
  ProCadastro.FieldByName('DATRESERVA').AsDateTime := now;
  ProCadastro.FieldByName('QTDRESERVADA').AsFloat := VpaQtdReservado;
  ProCadastro.FieldByName('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
  ProCadastro.FieldByName('QTDINICIAL').AsFloat := VpaQtdInicial;
  ProCadastro.FieldByName('QTDFINAL').AsFloat := VpaQtdAtual;
  if VpaSeqOrdem <> 0 then
  begin
    ProCadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
    ProCadastro.FieldByName('SEQORDEMPRODUCAO').AsInteger := VpaSeqOrdem;
  end;

  ProCadastro.FieldByName('SEQRESERVA').AsFloat := RSeqReservaProdutoDisponivel;
  ProCadastro.Post;
  result := ProCadastro.AMensagemErroGravacao;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.ReprocessaEstoque(VpaMes, VpaAno : Integer): String;
Var
  VpfDatInicial, VpfDatFinal : TDateTime;
begin
  result := '';
  VpfDatInicial := MontaData(1,VpaMes,VpaAno);
  VpfDatFinal := UltimoDiaMes(VpfDatInicial);
  ExcluiMovimentoEstoquePorData(VpfDatInicial,VpfDatFinal);
  result := ReprocessaEstoqueCotacao(VpfDatInicial,VpfDatFinal);
  if result = '' then
    result := ReprocessaEstoqueCompras(VpfDatInicial,VpfDatFinal);
end;

{******************************************************************************}
procedure TFuncoesProduto.ReAbrirMes(VpaData : TDateTime);
begin
  ExecutaComandoSql(AUX,'Update CADFILIAIS '+
                        ' Set D_ULT_FEC = '+ SQLTextoDataAAAAMMMDD(UltimoDiaMes(VpaData))+
                        ' Where I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil));
end;

{******************************************************************************}
procedure TFuncoesProduto.ReorganizaSeqEstagio(VpaDProduto : TRBDProduto);
var
  VpflacoExterno, VpfLacoInterno : integer;
  VpfPrimeiraTroca : Boolean;
  VpfDEstagio : TRBDEstagioProduto;
begin
  VpfPrimeiraTroca := true;
  for VpfLacoExterno := 0 to VpaDProduto.Estagios.count - 1 do
  begin
    VpfDEstagio := TRBDEstagioProduto(VpaDproduto.Estagios.Items[VpfLacoexterno]);
    if VpfDEstagio.SeqEstagio <> VpflacoExterno + 1 then
    begin
      for VpflacoInterno := 0 to VpaDProduto.Estagios.count - 1 do
      begin
        if VpfPrimeiraTroca then
          if TRBDEstagioProduto(VpaDProduto.Estagios.Items[vpfLacoInterno]).CodEstagioAnterior = VpfLacoexterno+1 then
            TRBDEstagioProduto(VpaDProduto.Estagios.Items[vpfLacoInterno]).CodEstagioAnterior :=0;

        if TRBDEstagioProduto(VpaDProduto.Estagios.Items[vpfLacoInterno]).CodEstagioAnterior = VpfDEstagio.SeqEstagio then
          TRBDEstagioProduto(VpaDProduto.Estagios.Items[vpfLacoInterno]).CodEstagioAnterior := VpfLacoexterno+1;
      end;
      VpfDEstagio.SeqEstagio := VpfLacoExterno +1;
      VpfPrimeiraTroca := false;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.CorReferenciaDuplicada(VpaDProduto : TRBDProduto):Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDConsumoExterno, VpfDConsumoInterno : TRBDConsumoMP;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDProduto.ConsumosMP.Count - 2 do
  begin
    VpfDConsumoExterno := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLacoExterno]);
    if VpfDConsumoExterno.CorReferencia <> 0 then
    begin
      for VpfLacoInterno := VpfLacoExterno + 1 to VpaDProduto.ConsumosMP.Count - 1 do
      begin
        VpfDConsumoInterno := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLacoInterno]);
        if VpfDConsumoInterno.CorReferencia <> 0 then
        begin
          if VpfDConsumoExterno.CorReferencia = VpfDConsumoInterno.CorReferencia then
          begin
            result := true;
            exit;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.ConcluiDesenho(VpaSeqProduto, VpaCodCor, VpaSeqMovimento : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVKIT '+
                                    ' Where I_PRO_KIT = '+IntToStr(VpaSeqProduto)+
                                    ' and I_COR_KIT = '+IntToStr(VpaCodCor)+
                                    ' and I_SEQ_MOV = '+IntToStr(VpaSeqMovimento));
  ProCadastro.edit;
  ProCadastro.FieldByName('D_DAT_DES').AsDateTime := now;
  try
    ProCadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DO MOVKIT!!!'#13+e.message;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.ConcluiFichaTecnica(VpaCodFilial,VpaLanOrcamento, VpaSeqItem : Integer):string;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVORCAMENTOS '+
                                    ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                    ' and I_LAN_ORC = '+IntToStr(VpaLanOrcamento)+
                                    ' and I_SEQ_MOV = '+IntToStr(VpaSeqItem));
  ProCadastro.edit;
  ProCadastro.FieldByName('D_DAT_GOP').AsDateTime := date;
  try
    ProCadastro.post;
  except
    on e : Exception do result := 'ERRO NA GRAVAÇAO DA TABELA MOVORCAMENTOS!!!'#13+e.message;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.PreparaImpressaoEtiqueta(VpaEtiquetas : TList;VpaPosInicial : Integer);
Var
  VpfSequencial, Vpflaco, VpfLacoQtd : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
begin
  VpfSequencial := 0;
  ExecutaComandoSql(Tabela,'Delete from ETIQUETAPRODUTO');
  AdicionaSQLAbreTabela(ProCadastro,'Select * from ETIQUETAPRODUTO');
  for vpfLaco := 1 to VpaPosInicial - 1 do
  begin
    inc(VpfSequencial);
    ProCadastro.Insert;
    ProCadastro.FieldByname('SEQETIQUETA').AsInteger := VpfSequencial;
    ProCadastro.FieldByname('INDIMPRIMIR').AsString := 'N';
    ProCadastro.Post;
  end;

  for vpflaco := 0 to VpaEtiquetas.count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLaco]);
    for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
    begin
      inc(VpfSequencial);
      ProCadastro.insert;
      ProCadastro.FieldByname('SEQETIQUETA').AsInteger := VpfSequencial;
      ProCadastro.FieldByname('CODPRODUTO').AsString := VpfDEtiqueta.Produto.CodProduto;
      ProCadastro.FieldByname('NOMPRODUTO').AsString := VpfDEtiqueta.Produto.NomProduto;
      ProCadastro.FieldByname('INDIMPRIMIR').AsString := 'S';
      try
        ProCadastro.post;
      except
        on e : exception do
        begin
          aviso(e.message);
          ProCadastro.close;
          exit;
        end;
      end;
    end;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.CalculaNumeroSerie(VpaNumSerie : Integer) :string;
VAR
  VpfDAta : String;
begin
  VpfData := FormatDateTime('DDMMYYYY',Date);
  result := '';
  case Varia.RegraNumeroSerie of
    rnNNNNNDDMAAD : result := IntToStr(VpaNumSerie)+copy(VpfData,2,1)+copy(VpfData,1,1)+copy(VpfData,3,1)+copy(VpfData,7,2)+copy(VpfData,4,1);
  end;
end;

{******************************************************************************}
function TFuncoesProduto.GeraCodigosBArras : String;
begin
  result := '';
  case Varia.TipCodBarras of
    cbEAN13 : result := GeraCodigoBarrasEAN13;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDFornecedores(VpaDProduto: TRBDProduto);
var
  VpfDFornecedor: TRBDProdutoFornecedor;
begin
  FreeTObjectsList(VpaDProduto.Fornecedores);
  AdicionaSQLAbreTabela(ProProduto,'SELECT PRF.CODCOR,PRF.CODCLIENTE, PRF.DATULTIMACOMPRA, PRF.QTDMINIMACOMPRA,'+
                                   ' PRF.DESREFERENCIA, PRF.VALUNITARIO, PRF.NUMDIAENTREGA, PRF.PERIPI, CLI.C_NOM_CLI'+
                                   ' FROM PRODUTOFORNECEDOR PRF, CADCLIENTES CLI'+
                                   ' WHERE PRF.SEQPRODUTO = '+InttoStr(VpaDProduto.SeqProduto)+
                                   ' AND CLI.I_COD_CLI = PRF.CODCLIENTE');
  while not ProProduto.Eof do
  begin
    VpfDFornecedor:= VpaDProduto.AddFornecedor;
    VpfDFornecedor.CodCOR:= ProProduto.FieldByName('CODCOR').AsInteger;
    VpfDFornecedor.NomCor := RNomeCor(InttoStr(VpfDFornecedor.CodCor));
    VpfDFornecedor.CodCliente:= ProProduto.FieldByName('CODCLIENTE').AsInteger;
    VpfDFornecedor.NomCliente:= ProProduto.FieldByName('C_NOM_CLI').AsString;
    VpfDFornecedor.NumDiaEntrega:= ProProduto.FieldByName('NUMDIAENTREGA').AsInteger;
    VpfDFornecedor.DatUltimaCompra:= ProProduto.FieldByName('DATULTIMACOMPRA').AsDateTime;
    VpfDFornecedor.QtdMinimaCompra:= ProProduto.FieldByName('QTDMINIMACOMPRA').AsFloat;
    VpfDFornecedor.ValUnitario:= ProProduto.FieldByName('VALUNITARIO').AsFloat;
    VpfDFornecedor.PerIPI:= ProProduto.FieldByName('PERIPI').AsFloat;
    VpfDFornecedor.DesReferencia:= ProProduto.FieldByName('DESREFERENCIA').AsString;
    ProProduto.Next;
  end;
  VpaDProduto.IndFornecedoresCarregados:= True;
  ProProduto.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDProdutoFornecedor(VpaCodFornecedor: Integer; VpaDProtudoPedido: TRBDProdutoPedidoCompra);
begin
  AdicionaSQLAbreTabela(ProProduto,'SELECT'+
                                   ' PRF.DESREFERENCIA, PRF.VALUNITARIO'+
                                   ' FROM PRODUTOFORNECEDOR PRF'+
                                   ' WHERE PRF.SEQPRODUTO = '+InttoStr(VpaDProtudoPedido.SeqProduto)+
                                   ' AND PRF.CODCLIENTE = '+IntToStr(VpaCodFornecedor)+
                                   ' AND PRF.CODCOR = '+IntToStr(VpaDProtudoPedido.CodCor));
  if not ProProduto.Eof then
  begin
    VpaDProtudoPedido.ValUnitario:= ProProduto.FieldByName('VALUNITARIO').AsFloat;
    VpaDProtudoPedido.DesReferenciaFornecedor:= ProProduto.FieldByName('DESREFERENCIA').AsString;
  end;
  ProProduto.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.CarDValCusto(VpaDProduto: TRBDProduto; VpaCodFilial : Integer);
var
  VpfDPreco : TRBDProdutoTabelaPreco;
  VpfPrecosVenda : TList;
  VpfLaco : Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'select  MOV.N_QTD_PRO, MOV.N_QTD_MIN, MOV.N_QTD_PED, MOV.N_VLR_CUS, MOV.N_VLR_COM, '+
                               ' COR.COD_COR, COR.NOM_COR, '+
                               ' TAM.CODTAMANHO, TAM.NOMTAMANHO '+
                               ' from MOVQDADEPRODUTO MOV, COR, TAMANHO TAM '+
                               ' Where MOV.I_SEQ_PRO = ' + IntToStr(VpaDProduto.SeqProduto)+
                               ' AND MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                               ' AND '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                               ' ORDER BY COR.COD_COR, TAM.CODTAMANHO');
  while not Tabela.eof do
  begin
    VpfPrecosVenda := RPrecoVendaeCustoProduto(VpaDProduto,Tabela.FieldByName('COD_COR').AsInteger,Tabela.FieldByName('CODTAMANHO').AsInteger);
    if VpfPrecosVenda.Count = 0   then
    begin
      VpfDPreco := VpaDProduto.AddTabelaPreco;
      VpfDPreco.CodTabelaPreco := varia.TabelaPreco;
      VpfDPreco.NomTabelaPreco := RNomTabelaPreco(Varia.TabelaPreco);
      VpfDPreco.CodMoeda := VARIA.MoedaBase;
      VpfDPreco.NomMoeda := FunContasAReceber.RNomMoeda(Varia.MoedaBase);
      VpfDPreco.CodTamanho := Tabela.FieldByName('CODTAMANHO').AsInteger;
      VpfDPreco.NomTamanho := Tabela.FieldByName('NOMTAMANHO').AsString;
      VpfDPreco.CodCliente := 0;
      VpfDPreco.CodCor := Tabela.FieldByName('COD_COR').AsInteger;
      VpfDPreco.NomCor := Tabela.FieldByName('NOM_COR').AsString;
      VpfDPreco.ValVenda := 0;
      VpfDPreco.ValRevenda := 0;
      VpfPrecosVenda.Add(VpfDPreco);
    end;
    for VpfLaco := 0 to VpfPrecosVenda.Count - 1 do
    begin
      VpfDPreco := TRBDProdutoTabelaPreco(VpfPrecosVenda.Items[VpfLaco]);
      VpfDPreco.ValCompra := Tabela.FieldByName('N_VLR_COM').AsFloat;
      VpfDPreco.ValCusto := Tabela.FieldByName('N_VLR_CUS').AsFloat;
      VpfDPreco.QtdEstoque := Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfDPreco.QtdMinima := Tabela.FieldByName('N_QTD_MIN').AsFloat;
      VpfDPreco.QtdIdeal := Tabela.FieldByName('N_QTD_PED').AsFloat;
    end;

    VpfPrecosVenda.free;
    Tabela.next;
  end;
  Tabela.close;
  OrdenaTabelaPrecoProduto(VpaDProduto);
end;

{******************************************************************************}
procedure TFuncoesProduto.CarFigurasGRF(VpaCodComposicao : Integer;VpaFiguras : TList);
var
  VpfDFigura : TRBDFiguraGRF;
begin
  FreeTObjectsList(VpaFiguras);
  AdicionaSQLAbreTabela(Tabela,'select FIG.CODFIGURAGRF, FIG.NOMFIGURAGRF, FIG.DESFIGURAGRF '+
                               ' from  FIGURAGRF FIG, COMPOSICAOFIGURAGRF CFI '+
                               ' WHERE FIG.CODFIGURAGRF = CFI.CODFIGURAGRF '+
                               ' AND CFI.CODCOMPOSICAO = '+IntToStr(VpaCodComposicao));
  while not Tabela.eof  do
  begin
    VpfDFigura := TRBDFiguraGRF.cria;
    VpaFiguras.Add(VpfDFigura);
    VpfDFigura.CodFiguraGRF := Tabela.FieldByName('CODFIGURAGRF').AsInteger;
    VpfDFigura.NOMFiguraGRF := Tabela.FieldByName('NOMFIGURAGRF').AsString;
    VpfDFigura.DESIMAGEM := Tabela.FieldByName('DESFIGURAGRF').AsString;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDFornecedor(
  VpaDProduto: TRBDProduto): String;
Var
  VpfLaco: Integer;
  VpfDFornecedor: TRBDProdutoFornecedor;
begin
  Result:= '';
  ExecutaComandoSql(AUX,'DELETE FROM PRODUTOFORNECEDOR '+
                        ' WHERE SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'SELECT * FROM PRODUTOFORNECEDOR '+
                                    ' WHERE SEQPRODUTO = 0 AND CODCLIENTE = 0 AND CODCOR = 0');
  for VpfLaco:= 0 to VpaDProduto.Fornecedores.Count - 1 do
  begin
    VpfDFornecedor:= TRBDProdutoFornecedor(VpaDProduto.Fornecedores.Items[VpfLaco]);
    ProCadastro.Insert;
    ProCadastro.FieldByName('SEQPRODUTO').AsInteger:= VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('CODCLIENTE').AsInteger:= VpfDFornecedor.CodCliente;
    ProCadastro.FieldByName('CODCOR').AsInteger:= VpfDFornecedor.CodCor;
    ProCadastro.FieldByName('QTDMINIMACOMPRA').AsFloat:= VpfDFornecedor.QtdMinimaCompra;
    ProCadastro.FieldByName('DATULTIMACOMPRA').AsDateTime:= VpfDFornecedor.DatUltimaCompra;
    ProCadastro.FieldByName('VALUNITARIO').AsFloat:= VpfDFornecedor.ValUnitario;
    ProCadastro.FieldByName('NUMDIAENTREGA').AsInteger:= VpfDFornecedor.NumDiaEntrega;
    ProCadastro.FieldByName('PERIPI').AsFloat:= VpfDFornecedor.PerIPI;
    ProCadastro.FieldByName('DESREFERENCIA').AsString := VpfDFornecedor.DesReferencia;
    try
      ProCadastro.Post;
    except
      on E:Exception do
        Result:= 'ERRO NA GRAVAÇÃO DO FORNECEDOR DO PRODUTO!!!'#13+e.message;
    end;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDAcessorio(VpaDProduto : TRBDProduto):string;
var
  VpfLaco : Integer;
  VpfDAcessorio : TRBDProdutoAcessorio;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from PRODUTOACESSORIO '+
                        ' Where SEQPRODUTO = '+IntToStr(VpaDProduto.SeqProduto));
  AdicionaSqlAbreTabela(ProCadastro,'Select * from PRODUTOACESSORIO');
  for VpfLaco := 0 to VpaDProduto.Acessorios.Count - 1 do
  begin
    VpfDAcessorio := TRBDProdutoAcessorio(VpaDProduto.Acessorios.Items[VpfLaco]);
    ProCadastro.insert;
    ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('CODACESSORIO').AsInteger := VpfDAcessorio.CodAcessorio;
    try
      ProCadastro.Post;
    except
      on e : exception do result := 'ERRO NA GRAVAÇÃO DO PRODUTOACESSORIO!!!'#13+e.message;
    end;
    if result <>'' then
      break;
  end;
  ProCadastro.Close;
end;

{******************************************************************************}
function TFuncoesProduto.GravaDTabelaPreco(VpaDProduto : TRBDProduto):string;
Var
  VpfDTabelaPreco : TRBDProdutoTabelaPreco;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(AUX,'Delete from MOVTABELAPRECO '+
                        ' Where I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                        ' AND I_SEQ_PRO = '+ IntToStr(VpaDProduto.SeqProduto));
  AdicionaSQLAbreTabela(ProCadastro,'Select * from MOVTABELAPRECO'+
                                    ' Where I_COD_EMP = 0 AND I_SEQ_PRO = 0 AND I_COD_TAB = 0 AND I_COD_CLI = 0 AND I_COD_MOE = 0 AND I_COD_TAM = 0');
  for VpfLaco := 0 to VpaDProduto.TabelaPreco.Count - 1 do
  begin
    VpfDTabelaPreco := TRBDProdutoTabelaPreco(VpaDProduto.TabelaPreco.Items[Vpflaco]);
    ProCadastro.insert;
    ProCadastro.FieldByName('I_COD_EMP').AsInteger := varia.CodigoEmpresa;
    ProCadastro.FieldByName('I_COD_TAB').AsInteger := VpfDTabelaPreco.CodTabelaPreco;
    ProCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpaDProduto.SeqProduto;
    ProCadastro.FieldByName('I_COD_MOE').AsInteger := VpfDTabelaPreco.CodMoeda;
    ProCadastro.FieldByName('N_VLR_VEN').AsFloat := VpfDTabelaPreco.ValVenda;
    ProCadastro.FieldByName('N_PER_MAX').AsFloat := VpfDTabelaPreco.PerMaximoDesconto;
    ProCadastro.FieldByName('D_ULT_ALT').AsDateTime := now;
    ProCadastro.FieldByName('I_COD_CLI').AsInteger := VpfDTabelaPreco.CodCliente;
    ProCadastro.FieldByName('N_VLR_REV').AsFloat := VpfDTabelaPreco.ValReVenda;
    ProCadastro.FieldByName('I_COD_TAM').AsInteger := VpfDTabelaPreco.CodTamanho;
    ProCadastro.FieldByName('I_COD_COR').AsInteger := VpfDTabelaPreco.CodCor;
    ProCadastro.post;
    result := ProCadastro.AMensagemErroGravacao;
    if ProCadastro.AErronaGravacao then
      break;
  end;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.SincronizarConsumoAmostraProduto(VpaDProduto: TRBDProduto; VpaConsumosAmostra: TList);
var
  VpfLaco: Integer;
  VpfDConsumoAmostra: TRBDConsumoAmostra;
  VpfDConsumoProduto: TRBDConsumoMP;
begin
  for VpfLaco:= 0 to VpaConsumosAmostra.Count-1 do
  begin
    VpfDConsumoAmostra:= TRBDConsumoAmostra(VpaConsumosAmostra.Items[VpfLaco]);
    VpfDConsumoProduto:= VpaDProduto.AddConsumoMP;

    VpfDConsumoProduto.CorKit:= 1;
    VpfDConsumoProduto.SeqProduto:= VpfDConsumoAmostra.SeqProduto;
    VpfDConsumoProduto.CodCor:= VpfDConsumoAmostra.CodCor;
    VpfDConsumoProduto.CodFaca:= VpfDConsumoAmostra.CodFaca;
    VpfDConsumoProduto.CodMaquina:= VpfDConsumoAmostra.CodMaquina;
    VpfDConsumoProduto.AltProduto:= VpfDConsumoAmostra.AltProduto;
    VpfDConsumoProduto.AlturaMolde:= Round(VpfDConsumoAmostra.AltMolde);
    VpfDConsumoProduto.LarguraMolde:= Round(VpfDConsumoAmostra.LarMolde);
    VpfDConsumoProduto.CodProduto:= VpfDConsumoAmostra.CodProduto;
    VpfDConsumoProduto.NomProduto:= VpfDConsumoAmostra.NomProduto;
    VpfDConsumoProduto.NomCor:= VpfDConsumoAmostra.NomCor;
    VpfDConsumoProduto.UMOriginal:= VpfDConsumoAmostra.DesUM;
    VpfDConsumoProduto.UM:= VpfDConsumoAmostra.DesUM;
    VpfDConsumoProduto.QtdProduto:= VpfDConsumoAmostra.Qtdproduto;
    VpfDConsumoProduto.PecasMT:= VpfDConsumoAmostra.QtdPecasemMetro;
    VpfDConsumoProduto.IndiceMT:= VpfDConsumoAmostra.ValIndiceConsumo;
    VpfDConsumoProduto.ValorUnitario:= VpfDConsumoAmostra.ValUnitario;
    VpfDConsumoProduto.ValorTotal:= VpfDConsumoAmostra.ValTotal;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.ImportaEstoqueProdutAExcluir(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
var
  VpfSeqBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MOV.I_EMP_FIL, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.N_QTD_PRO, PRO.C_COD_UNI FROM MOVQDADEPRODUTO MOV, CADPRODUTOS PRO'+
                            ' Where PRO.I_SEQ_PRO = MOV.I_SEQ_PRO '+
                            ' AND PRO.I_SEQ_PRO = '+IntToStr(VpaSeqProdutoaExcluir));
  VpfDProduto := TRBDProduto.Cria;
  CarDProduto(VpfDProduto,varia.CodigoEmpresa,0,VpaSeqProdutoDestino);
  while not Tabela.eof do
  begin
    BaixaProdutoEstoque(VpfDProduto,TABELA.FieldByName('I_EMP_FIL').AsInteger,VARIA.OperacaoAcertoEstoqueEntrada,
                        0,0,0,VARIA.MoedaBase,Tabela.FieldByName('I_COD_COR').AsInteger,Tabela.FieldByName('I_COD_TAM').AsInteger,date,Tabela.FieldByName('N_QTD_PRO').AsFloat,
                        0,Tabela.FieldByName('C_COD_UNI').AsString,'',false,VpfSeqBarra);
    Tabela.next;
  end;
  VpfDProduto.free;
  Tabela.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.ImportaProdutofornecedor(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
var
  VpfLaco : Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from PRODUTOFORNECEDOR'+
                               ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoAExcluir) );
  While not tabela.eof do
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from PRODUTOFORNECEDOR '+
                            ' Where SEQPRODUTO = '+IntToStr(VpaSeqProdutoDestino)+
                            ' and CODCLIENTE = '+IntToStr(Tabela.FieldByName('CODCLIENTE').AsInteger)+
                            ' AND CODCOR = '+Tabela.FieldByName('CODCOR').AsString );
    IF ProCadastro.eof then
    begin
      ProCadastro.insert;
      for VpfLaco := 0 to Tabela.FieldCount - 1 do
        ProCadastro.FieldByName(Tabela.Fields[VpfLaco].DisplayName).AsVariant := Tabela.FieldByName(Tabela.Fields[VpfLaco].DisplayName).AsVariant;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProdutoDestino;
      ProCadastro.post;
    end;
    Tabela.next;
  end;
  Tabela.close;
  ProCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesProduto.ImportaEstoqueTecnico(VpaSeqProdutoAExcluir, VpaSeqProdutoDestino : Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'Select TEC.SEQPRODUTO, TEC.CODTECNICO, TEC.CODFILIAL, '+
                               ' TEC.CODCOR, TEC.CODTAMANHO, TEC.QTDPRODUTO, '+
                               ' PRO.C_COD_UNI '+
                               ' from ESTOQUETECNICO TEC, CADPRODUTOS PRO '+
                               ' Where TEC.SEQPRODUTO = '+IntToStr(VpaSeqProdutoAExcluir)+
                               ' AND TEC.SEQPRODUTO = PRO.I_SEQ_PRO');
  While not Tabela.eof do
  begin
    AdicionaSQLAbreTabela(ProCadastro,'Select * from ESTOQUETECNICO '+
                                   ' Where SEQPRODUTO = '+IntTostr(VpaSeqProdutoDestino)+
                                   ' and CODCOR = '+TABELA.FieldByName('CODCOR').AsString+
                                   ' AND CODFILIAL = '+Tabela.FieldByName('CODFILIAL').AsString+
                                   ' AND CODTAMANHO = '+Tabela.FieldByName('CODTAMANHO').AsString+
                                   ' AND CODTECNICO = '+Tabela.FieldByName('CODTECNICO').AsString);
    if ProCadastro.eof then
    begin
      ProCadastro.insert;
      ProCadastro.FieldByName('SEQPRODUTO').AsInteger := VpaSeqProdutoDestino;
      ProCadastro.FieldByName('CODTECNICO').AsInteger := Tabela.FieldByName('CODTECNICO').AsInteger;
      ProCadastro.FieldByName('CODFILIAL').AsInteger := Tabela.FieldByName('CODFILIAL').AsInteger;
      ProCadastro.FieldByName('CODCOR').AsInteger := Tabela.FieldByName('CODCOR').AsInteger;
      ProCadastro.FieldByName('CODTAMANHO').AsInteger := Tabela.FieldByName('CODTAMANHO').AsInteger;
      ProCadastro.FieldByName('DATALTERACAO').AsDateTime;
    end
    else
      ProCadastro.Edit;
    ProCadastro.FieldByName('QTDPRODUTO').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat +
                          CalculaQdadePadrao(Tabela.FieldByName('C_COD_UNI').AsString,UnidadePadrao(VpaSeqProdutoDestino),
                                 Tabela.FieldByName('QTDPRODUTO').AsFloat,IntToStr(VpaSeqProdutoDestino));
    ProCadastro.post;
    Tabela.next;
  end;
  Tabela.close;
  ProCadastro.close;
end;

{******************************************************************************}
function TFuncoesProduto.BaixaSubmontagemFracao(VpaCodFilial,VpaSeqOrdemProducao, VpaSeqProduto, VpaCodCor : Integer;var VpaQtdProduto : Double;VpaUM, VpaTipOperacao : String):Boolean;
begin
  ProCadastro.close;
  ProCadastro.sql.clear;
  ProCadastro.sql.add('Select * from FRACAOOP '+
                      ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                      ' and SEQORDEM = '+IntToStr(VpaSeqOrdemProducao)+
                      ' and SEQPRODUTO = '+IntToStr(VpaSeqProduto));
  if VpaTipOperacao = 'S' then
    ProCadastro.sql.add(' and CODESTAGIO = '+IntToStr(VARIA.EstagioOrdemProducao))
  else
    ProCadastro.sql.add(' and CODESTAGIO = '+IntToStr(VARIA.EstagioFinalOrdemProducao));
  if VpaCodCor <> 0 then
    ProCadastro.sql.add('and CODCOR = '+IntToStr(VpaCodCor));
  ProCadastro.open;
  While not ProCadastro.eof and (VpaQtdProduto > 0) do
  begin
    if VpaTipOperacao = 'S' then
    begin
      ProCadastro.edit;
      if (VpaQtdProduto >= (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDAFATURAR').AsFloat)) then
      begin
        VpaQtdProduto := VpaQtdProduto - (ProCadastro.FieldByName('QTDPRODUTO').AsFloat - ProCadastro.FieldByName('QTDAFATURAR').AsFloat);
        ProCadastro.FieldByName('QTDAFATURAR').AsFloat := ProCadastro.FieldByName('QTDPRODUTO').AsFloat;
      end
      else
      begin
        ProCadastro.FieldByName('QTDAFATURAR').AsFloat := ProCadastro.FieldByName('QTDAFATURAR').AsFloat + VpaQtdProduto;
        VpaQtdProduto := 0;
      end;
      ProCadastro.Post;
      if ProCadastro.FieldByName('QTDAFATURAR').AsFloat >= ProCadastro.FieldByName('QTDPRODUTO').AsFloat then
        FunOrdemProducao.AlteraEstagioFracaoOP(VpaCodFilial,VpaSeqOrdemProducao,ProCadastro.FieldByName('SEQFRACAO').AsInteger,
                                                Varia.EstagioFinalOrdemProducao);
    end
    else
      if VpaTipOperacao = 'E' then
      begin
        ProCadastro.edit;
        if (VpaQtdProduto >= (ProCadastro.FieldByName('QTDAFATURAR').AsFloat)) then
        begin
          VpaQtdProduto := VpaQtdProduto - ProCadastro.FieldByName('QTDAFATURAR').AsFloat;
          ProCadastro.FieldByName('QTDAFATURAR').Clear;
        end
        else
        begin
          ProCadastro.FieldByName('QTDAFATURAR').AsFloat := ProCadastro.FieldByName('QTDAFATURAR').AsFloat - VpaQtdProduto;
          VpaQtdProduto := 0;
        end;
        ProCadastro.Post;
        if ProCadastro.FieldByName('QTDAFATURAR').AsFloat = 0 then
          FunOrdemProducao.AlteraEstagioFracaoOP(VpaCodFilial,VpaSeqOrdemProducao,ProCadastro.FieldByName('SEQFRACAO').AsInteger,
                                                  VARIA.EstagioOrdemProducao);
      end;
    ProCadastro.next;
  end;
  ProCadastro.close;
  result := VpaQtdProduto = 0;
end;

{******************************************************************************}
function TFuncoesProduto.GeraCodigoBarrasEAN13 : string;
var
  VpfCodBarras : String;
begin
  result := '';
  AdicionaSQLAbreTabela(ProCadastro,'Select * from CADPRODUTOS '+
                                   ' Where C_BAR_FOR IS null' );
  while not ProCadastro.Eof do
  begin
    VpfCodBarras := RCodBarrasEAN13Disponivel;
    if VpfCodBarras = 'FIM FAIXA' then
      result := 'FINAL FAIXA CODIGO EAN!!!'#13'A faixa do código EAN foi esgotado.'
    else
    begin
      ProCadastro.Edit;
      ProCadastro.FieldByName('C_BAR_FOR').AsString := VpfCodBarras;
      ProCadastro.Post;
      result := ProCadastro.AMensagemErroGravacao;
    end;
    ProCadastro.Next;
    if result <> '' then
      break;
  end;
end;

{******************************************************************************}
function TFuncoesProduto.RSeqProdutoDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(AUX,'SELECT MAX(I_SEQ_PRO) ULTIMO FROM CADPRODUTOS');
  Result:= AUX.FieldByName('ULTIMO').AsInteger+1;
  AUX.Close;
end;

{******************************************************************************}
procedure TFuncoesProduto.ApagaSubMontagensdaListaConsumo(VpaDProduto : TRBDProduto);
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoMP;
begin
  for VpfLaco := VpaDProduto.ConsumosMP.Count - 1 downto 0 do
  begin
    VpfDConsumo := TRBDConsumoMP(VpaDProduto.ConsumosMP.Items[VpfLaco]);
    if ExisteConsumoProdutoCor(VpfDConsumo.SeqProduto,VpfDConsumo.CodCor) then
    begin
      VpfDConsumo.Free;
      VpaDProduto.ConsumosMP.Delete(VpfLaco);
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesProduto.ConverteNomesProdutosSemAcento;
begin
  AdicionaSQLAbreTabela(ProCadastro,'Select * from CADPRODUTOS ');
  while not ProCadastro.eof do
  begin
    ProCadastro.Edit;
    ProCadastro.FieldByName('C_NOM_PRO').AsString := RetiraAcentuacao(UpperCase(ProCadastro.FieldByName('C_NOM_PRO').AsString));
    ProCadastro.Post;
    ProCadastro.next;
  end;
end;

end.


