unit Constantes;

interface
 uses
   db,Forms, SysUtils, FunValida, classes, dbtables, Menus, Registry, unSistema, UnVersoes,
   windows, StdCtrls,SQLexpr,tabela ;

const
  CT_DIRETORIOREGEDIT = 'Software\Listeners\SisCorp';

























  CNPJ_CopyLine = '04.724.655/0001-63';
  CNPJ_EmbutidosOlho = '07.137.707/0001-93';
  CNPJ_FarmaciaNova = '82.647.207/0001-17';
  CNPJ_IMPOX = '07.615.955/0001-00';
  CNPJ_LaticiniosPomerode = '04.630.689/0001-99';
  CNPJ_MKJ = '02.538.770/0001-18';
  CNPJ_Reloponto = '81.011.082/0001-71';
  CNPJ_RLP = '00.539.911/0001-91';
  CNPJ_Zumm = '81.331.837/0001-15';
  CNPJ_ZummH = '81.331.837/0002-04';
  CNPJ_ZummNeumarkt = '04.958.032/0001-55';
  CNPJ_Kairos = '83.115.485/0001-96';
  CNPJ_AviamentosJaragua = '05.660.967/0001-13';
  CNPJ_EtikArt = '04.288.847/0001-74';
  CNPJ_VilaReal = '05.826.905/0001-39';
  CNPJ_Cadartex = '05.895.359/0001-98';
  CNPJ_Feldmann = '83.527.101/0001-42';
  CNPJ_MetalVidros = '03.279.333/0001-90';
  CNPJ_Atol = '06.881.153/0001-71';
  CNPJ_WorkFabrica = '03.731.084/0001-21';
  CNPJ_Listeners = '04.216.817/0001-52';
  CNPJ_CorBella = '01.771.374/0001-73';
  CNPJ_RafThel = '85.371.243/0001-99';
  CNPJ_R2 = '09.364.080/0001-39';
  CNPJ_Kabran = '83.139.766/0001-89';
  CNPJ_Premer = '05.113.696/0001-86';
  CNPJ_HALF = '07.663.782/0001-98';
  CNPJ_AGZ = '09.661.514/0001-62';
  CNPJ_REELTEX= '00.494.703/0001-13';
  CNPJ_AtelierDuCristal = '79.385.597/0001-90';
  CNPJ_VENETO = '95.757.399/0001-66';
  CNPJ_PERFOR = '09.004.720/0001-08';

type

  TRBDOpcoesPermisaoUsuario = (puAdministrador, puFACompleto, puPLCompleto, puESCompleto, puFICompleto,puCHCompleto, puCRCompleto,
    puFICadastraCR, puFIBaixaCR, puFICadastraCP, puFIBaixaCP, puFIConsultarCPOculto,puPLImprimePedPendentes,puFIEfetuarCobranca, puConsultarCliente,puManutencaoProdutos,
    puPLCadastraCotacao, puPLConsultarCotacao, puPLAlterarCotacao, puPLCancelarCotacao, puPLExcluirCotacao, puPLAlterarExcluirDepoisFaturado,puPLAlterarTipoCotacao,puImprimirPedido,
    puPLGerarNota, puPLGerarCupom, puPLImprimirEtiqueta,puPLUsuarioTelemarketing, puPLSupervisorTelemarketing, puPLSeparaProduto, puPLConferirProduto, puPLEnvioParcialPedido,
    puClienteCompleto,puProdutoCompleto,puServicoCompleto,puImpressao,puRelatorios,puSomenteProdutos,puSomenteMateriaPrima,
    puVerPrecoVendaProduto,puVerPrecoCustoProduto, puConsultarOP,puFAManutencaoNota, puFAConsultarNota, puFAGerarNota,puESAlterarOP, puESCadastrarNotaFiscal, puESManutencaoNotaFiscal,
    puESExcluirOP,puCHCadastrosBasicos,puCHCadastrarChamado,puCHConsultarChamado,puCHGerarCotacao,puCHAlterarChamadoTodosTecnicos,
    puCHAlterarChamadosFinalizados,puESRomaneio,puESCadastrarFaccionista,puESAdicionarFracaoFaccionista,puESConsultarFracaoFaccionista,
    puESExcluirFracaoFaccionista,puESAdicionarRetornoFracaoFaccionista,puESConsultarRetornoFracaoFaccionista,puESExcluirRetornoFracaoFaccionista,
    puESImprimirEtiquetaProduto, puCRSomenteProspectDoVendedor, puESPedidoCompra, puESOrcamentoCompra,puESSolicitacaoCompra,
    puSomenteClientesdoVendedor,puFIBloquearClientes, puVendedorAlteraContrato, puPLImprimirPedidoDuasVezes, puPLImprimirValoresRelatorioPedidosPendentes,
    puESPlanoCorte,puCRSomenteCadastraProspect,puESColetaQtdProduzidoOP,puESReprocessarProdutividade, puESAcertoEstoque,
    puESMenuGerencial, puESRegerarProjeto,puSomenteCondicoesPgtoAutorizadas, puESCadastrarCelulaTrabalho, puESReservaEstoque);

  TRBDPermisaoUsuario = set of TRBDOpcoesPermisaoUsuario;
  TRBDTipoValorComissao = (vcTotalNota,vcTotalProdutos);
  TRBDOperacaoCadastro =(ocInsercao,ocEdicao,ocConsulta);
  TRBDTipoOrdemProducao = (toFracionada,toAgrupada,toSubMontagem);
  TRBDOrientacaoPagina =(opRetrato,opPaisagem);
  TRBDFormatoExportacaoFiscal =(feLince,feWKLiscalforDos,feSantaCatarina,feSintegra,feMTFiscal,feWKRadar,feValidaPR,feDominioSistemas);
  TRBTipoImpressoraFiscal = (ifBematech_FI_2,ifDaruamFS600);
  TRBDRegraNumeroSerie = (rnNNNNNDDMAAD);
  TRBTipoCodigoBArras = (cbNenhum,cbEAN13);


  TVariaveis = class
    private
      procedure EscondeMenuItems(VpaMenuItem : TMenuItem;VpaEstado : Boolean);
    public
      VarAux : TSQLQuery;
      CT_AreaX, CT_AreaY : Integer;    // inicio variaveis do basico
      senha,
      usuario : string;
      ParametroBase : String;
      CodigoUsuario,
      CodigoUsuarioSistema : Integer;
      CodRegiaoVenda,
      CodTecnico,
      CodVendedor,
      CodComprador : Integer;
      NomeUsuario,
      NomeComputador,
      CodigosVendedores,
      CodigosCondicaoPagamento : string;
      GrupoUsuario : integer;
      PermissoesUsuario : TRBDPermisaoUsuario;
      ServidorSMTP,
      ServidorPop,
      UsuarioSMTP,
      SenhaEmail : String;
      CaixaPadrao : String;
      TipFonte : TEditCharCase;

      StatusAbertura : string;
      CodigoEmpresa : integer;
      NomeEmpresa : string;
      NomeFilial,
      RazaoSocialFilial,
      EnderecoFilial,
      EnderecoFilialSemNumero,
      NumEnderecoFilial,
      CNPJFilial,
      IEFilial,
      InscricaoMunicipal,
      CPFResponsavelLegal,
      BairroFilial,
      CepFilial,
      CidadeFilial,
      UFFilial,
      FoneFilial,
      EMailFilial,
      SiteFilial,
      CodCNAE : String;
      CodigoFilial : integer;
      CodigoEmpFil : integer;
      AcaoCancela : boolean;
      MascaraMoeda : string;
      MascaraValor : string;
      DriveFoto : string;
      PathRestauracaoBackup,
      PathVersoes : string;
      PathSybase : string;
      PathBackup,
      PathSecundarioBackup,
      PathCliente: String;
      NomBackup: String;
      PathInSig : string;
      ImpressoraRelatorio,
      ImpressoraAlmoxarifado,
      ImpressoraAssitenciaTecnica  : string;
      MoedaBase : integer;
      DataDaMoeda : TdateTime;
      MoedasVazias,
      VersaoSistema : string;
      Decimais,
      DecimaisQtd,
      VersaoBanco : integer;
      SenhaBanco : string;
      TipoBase : integer;
      DiaValBase : integer;
      ImpressoraCheque : integer;
      DiretorioSistema,
      DiretorioFiscais,
      DiretorioTemporarioCrystal : String; // fim das variaveis do basico
      PlanoContasDevolucaoCotacao : String;
      SeqCampanhaTelemarketing,
      SeqCampanhaCadastrarEmail,
      CondicaoPagamentoContrato,
      FormaPagamentoContrato : integer;
      DatSNGPC : TDateTime;
      PortaComunicacaoBalanca : Integer;
      PortaComunicacaoImpTermica,
      PortaComunicacaoImpTermica2 : String;
      DatInformacaoGerencial : TDateTime;

      //ecf
      TipoECF : TRBTipoImpressoraFiscal;
      ClientePadraoECF,
      CodCondicaoPagamentoECF,
      CodOperacaoEstoqueECF : Integer;
      CodPlanoContasECF : String;

      // produto/estoque
      MascaraQtd : String;
      MascaraValorUnitario : String;
      MascaraCla : string;
      MascaraClaSer : string;
      MascaraPro : string;
      UnidadePadrao,
      UnidadeCX : string;
      UnidadeUN,
      UnidadeKit,
      UnidadeBarra : string;
      ClassificacaoFiscal : string;
      DiasValidade : integer;  // dias de validade para os orcamentos
      TabelaPreco,
      TabelaPrecoServico : Integer;
      CodigoProduto : string; // guarda o campo do produto, codigo ou campo codigo de barra
      OperacaoEstoqueInicial : integer;
      OperacaoEstoqueEstornoEntrada,
      OperacaoEstoqueEstornoSaida,
      OperacaoAcertoEstoqueEntrada,
      OperacaoAcertoEstoqueSaida,
      OperacaoEstoqueImpressaoEtiqueta,
      OperacaoAdicionaReservaSaidaEstoque,
      OperacaoSaidaReservaAdicionaEstoque,
      OperacaoSaidaProdutoBaixaChamado,
      OperacaoEntradaProdutoBaixaChamado : Integer;
      UltimoMesEstoque : integer; // para a sumarizado de estoque,
      UltimoAnoEstoque : integer; // para a sumarizado de estoque,
      UtilizarIpi : Boolean;
      DataUltimoFechamento : TDateTime;//qual foi a data do ultimo fechamento;
      InventarioEntrada,
      InventarioSaida,
      EstagioOrdemProducao,  // est�gio inicial da ordem de producao
      EstagioOrdemProducaoAlmoxarifado,
      EstagioAguardandoEntrega,
      EstagioNaEntrega,
      EstagioFinalOrdemProducao,
      EstagioCotacaoAlterada,
      EstagioCotacaoExtornada,
      EstagioBaixaParcialCancelada,
      EstagioAssistenciaTecnica,
      EstagioInicialChamado,
      EstagioAguardandoAprovacaoChamado,
      EstagioChamadoFinalizado,
      EstagioChamadoFaturado,
      EstagioChamadoAguardandoAgendamendo,
      EstagioEnviadoFaccionista,
      EstagioRetornoFaccionista,
      EstagioSerra,
      EstagioPantografo,
      EstagioOPReimportada,
      EstagioInicialProposta,
      EstagioAguardandoRecebimentoProposta,
      EstagioPropostaEmNegociacao,
      EstagioPropostaConcluida,
      EstagioInicialCompras,
      EstagioComprasAprovado,
      EstagioComprasAguardandoConfirmacaoRecebFornececedor,
      EstagioComprasAguardandoEntregaFornecedor,
      EstagioFinalCompras,
      EstagioInicialOrcamentoCompra,
      EstagioOrcamentoCompraAprovado,
      EstagioFinalOrcamentoCompra,
      TipoCotacao,
      TipoCotacaoPedido,
      TipoCotacaoAmostra,
      TipoCotacaoFaturamentoPosterior,
      TipoCotacaoContrato,
      TipoCotacaoGarantia,
      TipoCotacaoRevenda,
      TipoCotacaoFaturamentoPendente,
      CodTransportadoraVazio,
      CodFilialControladoraEstoque,
      CodVendedorCotacao
      : Integer;
      CodClassificacaoProdutos,
      CodClassificacaoMateriaPrima,
      CodClassificacaoProdutoRotulado : String;
      CodClientePadraoCotacao,
      CodTipoCotacaoMaquinaLocal,
      ModeloEtiquetaNotaEntrada,
      ModeloEtiquetaPequena,
      ModeloEtiquetaCartuchoToner,
      ModeloEtiquetaCartuchoTinta : Integer;
      QuantidadeLetrasClassificacaProdutoUnidadeFabricacao : Integer;
      RegraNumeroSerie : TRBDRegraNumeroSerie;
      CodClassificacaoProdutoGrupo : String;
      CodFilialGrupo : Integer;
      TipCodBarras : TRBTipoCodigoBArras;
      NumPrefixoCodEAN : Double;
      NumUltimoCodigoEAN : Integer;

      //Cartucho
      CodClassificacaoPoTinta,
      CodClassificacaoCilindro,
      CodClassificacaoChip: String;

      // clientes
      SituacaoPadraoCliente: Integer;

      // ecf
      UsarGaveta : string;
      PathRetornoECF : string;
      EstadoPadrao : string;
      TextoPromocional : TStringList;
      CodigoOpeEstEcf : integer;
      TipoComissaoProduto : Integer;
      TipoComissaoServico : Integer;
      BoletoPadraoNota : Integer;
      DadoBoletoPadraoNota : Integer;
      MaiorDescontoPermitido : Integer;
      NaturezaDevolucaoCupom : string;
      NaturezaDevolucaoNotaFiscal : string;
      NaturezaNotaFiscalCupom : string; // quando ultrapassar o desconto maximo da nota
      NaturezaServico : String;
      NaturezaServicoForaEstado,
      NaturezaServicoEProduto,
      NaturezaServicoEProdutoForaEstado : String;
      LayoutECF : integer;
      TamanhoFonteECF : integer;
      FormatoExportacaoFiscal : TRBDFormatoExportacaoFiscal;

      //FISCAL
      ISSQN,
      PerPIS,
      PerCOFINS,
      PerCreditoICMSSimples : Double;
      SerieNota,
      SerieNotaServico : String;
      PlanoContaEcf : String;
      NaturezaNota,
      NaturezaForaEstado : string;
      NotaFiscalPadrao : Integer;
      PathSintegra,
      PlacaVeiculoNota,
      MarcaEmbalagem : string;
      FretePadraoNF,
      CodTransportadora,
      DocPadraoPedido,
      ContaContabilFornecedor,
      ContaContabilCliente,
      CodClienteExportacaoFiscal : integer;
      TextoReducaoImposto,
      TextoReducaoICMSCliente : String;  // fim das variaveis do fiscais
      ValMinimoFaturamentoAutomatico : Double;
      CodIBGEMunicipio : Integer;

      //nfe
      CertificadoNFE,
      UFSefazNFE : string;

      //financeiro
      Mora : Double;           // inicio das variaveis financeiro
      Juro : Double;
      Multa : double;
      ConsultaPor : Char;
      ContaBancaria,
      ContaBancariaBoleto,
      ContaBancariaContrato : String;
      ChequePre : integer;
      DescontoMaximoNota : Double;
      FilialControladora : Integer;
      SenhaLiberacao : String;    // fim das variaveis do financeiro
      GrupoUsuarioMaster : Integer;
      QtdDiasProtesto : Integer;
      MascaraPlanoConta : string;
      FormaPagamentoPadrao,
      FormaPagamentoCarteira,
      FormaPagamentoBoleto,
      FormaPagamentoDinheiro,
      FormaPagamentoDeposito,
      FormaPagamentoCreditoCliente : Integer;
      ClienteFornecedorbancario : Integer;// Baixa da comissao caso seje pagamento parcial
      DocReciboPadrao : Integer;
      PlanoContasBancario,
      PlanoDescontoDuplicata : String;
      CodHistoricoNaoLigado : Integer;
      RodapeECobranca : String;
      emailECobranca : string;
      EmailComercial,
      SenhaEmailComercial : string;
      CentroCustoPadrao,
      TipComissao : Integer;
      TipoValorComissao : TRBDTipoValorComissao;

      // caixa
      ValorTolerancia : Double; // valor de toler�ncia de esouro do caixa - m�ximo e m�nimo.
      OperacaoPagar : Integer; // C�digo do Tipo de Opera��o padrao para carregar uma conta a pagar no caixa.
      OperacaoReceber : Integer; // C�digo do Tipo de Opera��o padrao para carregar uma conta a receber no caixa.
      CondPagtoVista  : Integer; // C�digo da condi��o de pagamento a vista para lan�amento no contas a receber atraves do cadastro de mov. banc�ria.
      SenhaCaixa : string;   // senha de liberacao do caixa

      //Contrato
      MesLocacao,
      AnoLocacao,
      SeqProdutoContrato,
      TipoContratoLocacao : Integer;
      CodProdutoContrato : String;
      DatFimLocacao : TDateTime;
      DatUltimaLeituraLocacao : TDateTime;

      //Assit�ncia T�cnica
      CodServicoChamado,
      CodServicoDeslocamento,
      CodServicoChamadoCotacao,
      TipoChamadoInstalacao,
      CodPesquisaSatisfacaoChamado,
      CodPesquisaSatisfacaoInstalacao,
      CodTecnicoIndefinido : Integer;
      CodSetorTecnica : Integer;
      ValChamado,
      ValKMRodado : Double;

      //CRM
      CRMCorEscuraEmail,
      CRMCorClaraEmail : string;
      CRMTamanhoLogo,
      CRMAlturaLogo,
      CodSetor,
      CodMeioDivulgacaoVisitaVendedor : Integer;
      CodHistoricoLigacaoVisitaVendedor : Integer;

      //Diversos
      PathRemessaBancaria,           //diretorio onde serao salvos os arquivos de importacao
      PathRelatorios,
      ModemTelemarketing: String;  // diretorio onde serao salvos os arquivos de exportacao;

      //Grafica
      ValAcerto : Double;

      //OrdemProducao
      TipoOrdemProducao : TRBDTipoOrdemProducao;
      CodClienteOP : Integer;
      AcrescimoCMEnfesto : Double;

      //Compras
      CodFilialFaturamentoCompras : Integer;
      EmailGeralCompras : String;
      QtdDiasPendenciaCompras : Integer;

      //Nota Fiscal Entrada
      CodFormaPagamentoNotaEntrada : Integer;

      //Cotacao
      QtdPecasAtacado : integer;
      NaturezaOperacaoTroca : String;
      QtdMaximaMesesEntregaPedido : Integer;

      //Amostra
      QtdDiasUteisEntregaAmostra,
      CodDesenvolvedorRequisicaoAmostra : Integer;


      constructor cria(VpaBaseDados : TSQLConnection);
      destructor destroy;override;
      procedure CarPermissaoUsuario(var VpaDPermissao : TRBDPermisaoUsuario;VpaCodEmpFil, VpaCodGrupoUsuario : String);
      procedure EscondeMenus(VpaMenu : TMenu;VpaEstado : Boolean);
      function RCodigosVendedores(VpaCodUsuario : Integer) : String;
      function RCodigosCondicaoPagamento(VpaCodGrupoUsuario : Integer) : String;
end;

type
  TConfig = Class
//-------------------Geral
    AtualizaPermissao : Boolean; // permite ou naum gravar formularios na tabela de formularios
    CodigoBarras : Boolean; // true utiliza leitor de c�dio de barras
    EmitirECF : Boolean; //permite a emissao do cupom fiscal;
    Farmacia : Boolean;
    ManutencaoImpressoras : boolean;
    RelogioPonto : Boolean;
    Grafica : Boolean;
    SoftwareHouse : boolean;
    RotuladorasAutomatizadas : Boolean;
    UtilizarPercentualConsulta : Boolean;
    ResponsavelLeituraLocacao : Boolean;
    ServidorInternetRequerAutenticacao : Boolean;


//contratos
    ControlarFaturamentoMinimoContrato,
    ExibirMensagemAntesdeImprimirNotanoFaturamentoMensal,
    NoFaturamentoMensalProcessarFaturamentoPosterior : Boolean;
    EnviarEmailFaturamentoMensal,
    EmitirNotaFaturamentoMensal,
    NoFaturamentoMensalCondPagamentoCliente : Boolean;

//-------------------Produtos
    AvisaIndMoeda : Boolean;       // para moedas, indice vazio - Basico
    AvisaDataAtualInvalida : Boolean;   // para moedas com data desatualizadas - Basico
    AvisaQtdPedido : Boolean;     // avisa se qtd de produtos � = a qtd estoque - Qtd Pedido
    AvisaQtdMinima : Boolean;     // Avisa se qtd de produtos � = a qtd m�mima - Qtd Minima
    QtdNegativa : Integer;        // Quantidade negativa de produtos
    VerCodigoProdutos : Boolean; // mostra ou naum o codigo dos produtos na arvore
    MascaraProdutoPadrao  : Boolean; // utiliza mascara padrao do produto..
    CodigoUnicoProduto : Boolean; //Cas true, o codigo do produto e gerado por empresa, senaum por classificacao
    PermiteItemNFEntradaDuplicado : Boolean; // Permite duplicat item de da Nota Fiscal de entrada duplicado
    CadastroEtiqueta,             //No cadastro dos produto mostra os dados t�cnicos da etiqueta.
    CadastroCadarco,
    MostrarAcessoriosnoProduto  : Boolean;   //No cadastro dos produtos mostra os dados t�cnicos do cadar�o.
    EstoquePorCor,                //Se controla o estoque dos produtos pela cor
    EstoquePorTamanho,
    EstoquePorNumeroSerie,
    PrecoPorClienteAutomatico,
    ExigirDataEntregaPrevista,
    ExcluirCotacaoQuandoNFCancelada  : Boolean;
    NomDesenhoIgualCodigo : Boolean;
    EstoqueCentralizado : Boolean;
    NumeroSerieProduto : Boolean;
    EstoqueFiscal : Boolean;
    ControlarBrinde : Boolean;
    PermiteAlteraNomeProdutonaCotacao : boolean;
    PermiteAlteraNomeProdutonaNotaEntrada : Boolean;
    UtilizarClassificacaoFiscalnosProdutos : Boolean;
    ValordeCompraComFrete : Boolean;
    CodigoProdutoCompostopelaClasificacao : Boolean;
    ConsumodoProdutoporCombinacao : Boolean;
    ValorVendaProdutoAutomatico : Boolean;
    AcertodeEstoquePeloSequencial : Boolean;
    ExigirPrecoCustoProdutonoCadastro : Boolean;
    ExigirPrecoVendaProdutonoCadastro : Boolean;
    ExigirQdMetrosQuandoDiferenteMT : Boolean;
    ReferenciaClienteCadastrarAutomatica : Boolean;
    MostrarOrdemProducaoNoAcertoEstoque : Boolean;
    MostrarCodBarrasCorNoAcertoEstoque : Boolean;

//-------------------Financeiro
    CapaLote : Boolean;            // verica capa de lote
    BaixaMovBancario : Boolean;    // permite a baixa bancaria ou n�o no cad novo contas a pagar
    BaixaCPCadastro : Boolean;     //permite a baixa CP ou n�o no cad novo contas a pagar
    BaixaCRCadastro : Boolean;     //permite a baixa CR ou n�o no cad novo contas a receber
    DataVencimentoMenor : Boolean;  // trava data de vencimento menor que a atual
    DataBaixaMenor : Boolean;       // trava a data da baixa menor que a atual
    BaixaParcelaAntVazia : Boolean;  // trava baixa da parcela se anterior estiver vazia
    JurosMultaDoDia : Boolean;  // Identifica o tipo de clculo de juro, da parcela ou atual
    ComissaoDireta  : Boolean;  // para definir somente comissoes direta para os vendedores
    NumeroDuplicata : Boolean; // se true gera o numero da duplicata igual ao da nota senao um sequencial
    NumeroDocumento : Boolean; // se true gera o numero do documento igual ao da duplicata senao um sequencial + parcela = 34/1
    PermitirParcial : Boolean; // permitir gerar parcelas parciais
    AlterarValorUnitarioNota : Boolean ; // se altera o valor unitario na nota fiscal
    DescontoNota : Boolean;  /// Dar desconto na nota
    AlterarValorUnitarioComSenha : Boolean ; // se altera o valor unitario somente com senha;
    AlterarDescontoComSenha : Boolean;
    GerarDespesasFixa : Boolean; // true para gerar despesas fixas, false naum
    AtualizarDespesas : Boolean; // Atualiza despesas fixas
    ConfirmaBancario : Boolean; // Pergunta antes de lan�ar o movimento banc�rio.
    FilialControladora :Boolean;// Verifica se existir� uma filial controladora ou seja tudo � pago em uma filal
    LimiteCreditoCliente : Boolean; //Permite o cliente comprar at� o limite de cr�dito.
    BloquearClienteEmAtraso : Boolean; //Bloquear o Cliente que est� em atraso
    ImprimirBoletoFolhaBranco : Boolean;
    GerarFinanceiroCotacao : Boolean;
    BaixarEstoqueCotacao : Boolean;
    QuandoFaturarAdicionarnaRemessa : Boolean;
    ECobrancaEnviarAvisoProgramacaoPagamento : Boolean;
    ECobrancaEnviarAvisoPagamentoAtrasado : Boolean;
    ECobrancaEnviarValoresCorrigidos : Boolean;
    CobrarFormaPagamento : Boolean;
    SalvarDataUltimaBaixaCR : Boolean;
    BaixaContasReceberCalcularJuros: Boolean;
    AdicionarRemessaAoImprimirBoleto: Boolean; // adicionar a nota fiscal no arquivo de remessa ao imprimir o boleto bancario
    EmailCobrancaPelaDataCobranca : Boolean;
    ControlarProjeto : Boolean;

    //-----------------------Cotacao
    ExcluirFinanceiroCotacaoQuandoGeraNota : Boolean;
    RegerarFinanceiroQuandoCotacaoAlterada,
    BaixaQTDCotacaonaNota,
    NaoPermitirAlterarCotacaoAposImpressa,
    TecniconaCotacao,
    MostrarCotacoesSomenteFilialAtiva,
    CopiarTransportadoraPedido : Boolean;
    DataFinanceiroIgualDataCotacao : boolean;
    ImprimeCotacaocomEntregadorSomenteAlmoxarifado : Boolean;
    ImprimirEnvolopeSomentecomNotaFatMensal,
    ImprimirCotacaoFatMensal,
    AlterarCotacaoSomentenoDiaEmissao,
    ObservacaoFiscalNaCotacao,
    PermitirAlterarVendedornaCotacao,
    ExigirCNPJeCEPCotacaoPadrao,
    AlterarCotacaoComOPGerada,
    PermanecerOVendedorDaUltimaVenda,
    EnviaCotacaoEmailTransportadora : Boolean;
    UtilizarTabelaPreconaCotacao : Boolean;
    TransportadoraObrigatorianaCotacao : Boolean;
    DescontoNosProdutodaCotacao : Boolean;
    GerarNotaPelaQuantidadeProdutos,
    EstagioFinalOpparaCotacaoFaturamentoPosterior,
    EstagioFinalOPparaCotacaoTransportadoraVaiza : Boolean;
    PermitirAlterarTipoCotacao : Boolean;
    UtilizarLeitorSeparacaoProduto : Boolean;
    UtilizarCompose : Boolean;
    NaCotacaoBuscaroContato,
    SolicitarSenhaparaCancelarBaixaParcial,
    QuandoGerarFinanceiorMostrarCotacoesNaoFaturadas : Boolean;
    PermitirGravaCotacaoSemCNPJaVista,
    ObrigarObservacaoNaGarantia : boolean;
    PermitirCancelareExtornarCotacao : Boolean;
    PermitirBaixarNumeroPedido: Boolean;
    ControlarASeparacaodaCotacao : Boolean;
    ConferirAQuantidadeSeparada : Boolean;
    SugerirPrecoAtacado : Boolean;
    ControlarTrocasnaCotacao : Boolean;
    ImprimirPedidoPendentesPorPeriodo : Boolean;
    MostrarImagemProdutoNaTeladaCotacao : Boolean;

    //-----------------------Caixa
    VariosCaixasDia : Boolean;  // true permite abrir v�rios caixas no mesmo dia (um de cada vez).
    LogDireto : Boolean;  // true efetua o log do caixa direto, sem pedir o usu�rio e a sua senha.
    SenhaAlteracao : Boolean; // utilizar senha de liberacao na alteracao de caixa
    SenhaEstorno : Boolean; // Utilizar senha de liberacao para estorno
    ParcialCaixaDataAnterior : Boolean; // Permitir abrir parcial em um caixa com data retroativa
    itemCaixaDataAnterior : Boolean; // Permitir lancar item em um caixa com data retroativa

    //-----------------------Fiscal
    ImpPorta : Boolean;
    UsaTEF : Boolean; // Usa o TEF discado no sistema
    MostraDadosClienteCupom : Boolean; // permite ou naum mostrar os dados do cliente na emissao do cupom fiscal
    AlterarNroNF : Boolean; // permite alterar o numero da nota fiscal
    AlterarValorNotaCR : Boolean;
    ItemNFSaidaDuplicado : Boolean;// permite duplicar os produtos na nota fiscal de saida
    ImprimirPedEmPreImp: boolean;
    UtilizarTransPedido: boolean;
    NotaFiscalPorFilial : Boolean;
    MostrarNotasDevolvidasnaVenda,
    NaoCopiarObservacaoPedidoNotaFiscal,
    ImprimirNumeroCotacaonaNotaFiscal,
    NaNotaFazerMediaValProdutosDuplicados : Boolean;
    UtilizarNSU,
    SimplesFederal,
    ImprimirnaNotaDescricaoItemNatureza : Boolean;
    QtdVolumeObrigatorio : Boolean;
    CancelarNotaCancelarBaixaCotacao : Boolean;
    EmiteNFe : Boolean;
    NotaFiscalConjugada : Boolean;
    MostrarEnderecoCobrancanaNota : Boolean;
    QuandoForQuartodeNotanoRomaneioFazeroValorFaltante : Boolean;
    ImprimirCodigoCorNaNota : Boolean;

    //---------------------Ecf
    BaixarEstoqueECF, //baixar o estoque quando gera um cupom direto pela tela de cupom sem estar associado a uma cota��o
    GerarFinanceiroECF ,  //Gerar financeiro quando gera um cupom direto pela tela de cupom sem estar associado a uma cota��o
    MostrarFormaPagamentoECFGeradoPelaCotacao,
    UtilizarGaveta,
    PassarDescontodaCotacao: Boolean;
    //---------------------cliente
    ExigirCPFCNPJCliente,
    ExigirCEPCliente :Boolean;
    UtilizarMailing : Boolean;
    ExigirTransportadoraCliente,
    ExigirCondicaoPagamentoCliente,
    ExigirFormaPagamentoCliente,
    ExigirVendedorCliente,
    ExigirPrepostoCliente,
    ExigirContatoCliente,
    ExigirEmailCliente : Boolean;

    //---------------------Chamados
    EnviaChamadoEmailTecnico : Boolean;

    //---------------------Ordem de produ��o
    AdicionarQtdIdealEstoquenaOP : Boolean;
    ProximoEstagioOPAutomatico : Boolean;
    BaixarConsumonaAlteracaoEstagioOP : Boolean;
    AutoCadastraAlteraEstagio : Boolean;
    AlterarEstagioFracaoPeloTipoEstagio : boolean;
    ImprimirEtiquetanaAlteracaodoEstagio : Boolean;
    ConverterMTeCMparaMM : Boolean;

    //------------------------Vendas
    MetaVendedorpelaCarteiradeClientes : Boolean;

    //CRM
    RetornoEmailPropostaParaoVendedor,
    ProdutosRotuladosnaProposta : Boolean;

    //Nota Fiscal de Entrada
    ExigirCorNotaEntrada : Boolean;

    //Pedido de Compra
    ObservacaoProdutoPedidoCompra : Boolean;

    //nfe
    NFEHomologacao,
    NFEDanfeRetrato : Boolean;

    //------------------------Outros
    AtualizarVersaoAutomaticamente: Boolean;
end;

type                             //    tag Nenhum : 0
  TConfigModulo = Class          //    tag Gerais : 1
    Bancario : Boolean;          //    tag Bancario : 2
    Caixa : Boolean;             //    tag Caixa : 3
    Comissao : Boolean;          //    tag Comissao : 4
    ContasAPagar : Boolean;      //    tag ContasAPagar : 5
    ContasAReceber : Boolean;    //    tag ContasAReceber : 6
    Faturamento : Boolean;       //    tag Faturamento : 7
    Fluxo : Boolean;             //    tag Fluxo : 8
    Produto : Boolean;           //    tag Produto : 9
    Custo : Boolean;             //    tag Custo : 10
    Estoque : Boolean;           //    tag Estoque : 11

    Servico : Boolean;
    NotaFiscal : Boolean;
    TEF : Boolean;
    ECF : Boolean;
    CodigoBarra : Boolean;
    Gaveta : Boolean;
    ImpDocumentos : Boolean;
    OrcamentoVenda : Boolean;
    Imp_Exp : Boolean;
    SenhaGrupo : Boolean;
    MalaDiretaCliente : Boolean;
    AgendaHistoricoCliente : boolean;
    PedidoVenda : boolean;
    OrdemServico : boolean;
    TeleMarketing : boolean;
    Faccionista : Boolean;
    Amostra : Boolean;
    OrdemProducao : Boolean;
end;

procedure ConfiguraVideo;
procedure CarregaEmpresaFilial( VpaCodEmpresa, VpaCodEmpFil : integer; VpaBaseDados : TSQLConnection );
procedure CarregaDiretorios;
procedure carregaCFG( VpaBaseDados : TSQLConnection);
//function RCodBancoConta(VpaContaCorrente : String) : Integer;
function TipoCheck(flag : string) : Boolean;
function GeraProximoCodigo(VpaCampo, VpaTabelaProximoCod, VpaCampoFilial : string; VpaCodEmpFil : Integer; VpacodSequencial : Boolean; VpaBaseDados : TSQLConnection ) : Integer;

var
    Varia : TVariaveis;
    Config : TConfig;
    ConfigModulos : TConfigModulo;

implementation

uses
   FunSql, FunArquivos, funData;

{******************************************************************************}
constructor TVariaveis.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  VarAux := TSQLQuery.Create(nil);
  VarAux.SQLConnection := VpaBaseDados;
  PermissoesUsuario := [];
end;

{******************************************************************************}
destructor TVariaveis.destroy;
begin
  VarAux.Free;
  inherited destroy;
end;

{******************************************************************************}
procedure TVariaveis.EscondeMenuItems(VpaMenuItem : TMenuItem;VpaEstado : Boolean);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaMenuItem.Count - 1 do
  begin
    EscondeMenuItems(TMenuItem(VpaMenuItem.Items[VpfLaco]),VpaEstado);
  end;
  VpaMenuItem.Visible := VpaEstado;
end;

{******************************************************************************}
procedure TVariaveis.CarPermissaoUsuario(var VpaDPermissao : TRBDPermisaoUsuario;VpaCodEmpFil, VpaCodGrupoUsuario : String);
begin
  AdicionaSQLAbreTabela(VarAux,'Select * from CADGRUPOS '+
                               ' Where I_EMP_FIL = '+VpaCodEmpFil +
                               ' and I_COD_GRU = '+VpaCodGrupoUsuario);
  VpaDPermissao := [];
  if TipoCheck(VarAux.FieldByName('C_ADM_SIS').AsString) then
    VpaDPermissao := VpaDPermissao + [puAdministrador];
  if TipoCheck(VarAux.FieldByName('C_FIN_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puFICompleto];
  if TipoCheck(VarAux.FieldByName('C_EST_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puESCompleto];
  if TipoCheck(VarAux.FieldByName('C_POL_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLCompleto];
  if TipoCheck(VarAux.FieldByName('C_FAT_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puFACompleto];
  if TipoCheck(VarAux.FieldByName('C_FIN_CCR').AsString) then
    VpaDPermissao := VpaDPermissao + [puFICadastraCR];
  if TipoCheck(VarAux.FieldByName('C_FIN_BCR').AsString) then
    VpaDPermissao := VpaDPermissao + [puFIBaixaCR];
  if TipoCheck(VarAux.FieldByName('C_FIN_CCP').AsString) then
    VpaDPermissao := VpaDPermissao + [puFICadastraCP];
  if TipoCheck(VarAux.FieldByName('C_FIN_BCP').AsString) then
    VpaDPermissao := VpaDPermissao + [puFIBaixaCP];
  if TipoCheck(VarAux.FieldByName('C_FIN_CPO').AsString) then
    VpaDPermissao := VpaDPermissao + [puFIConsultarCPOculto];
  if TipoCheck(VarAux.FieldByName('C_POL_IPP').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLImprimePedPendentes];
  if TipoCheck(VarAux.FieldByName('C_FIN_ECO').AsString) then
    VpaDPermissao := VpaDPermissao + [puFIEfetuarCobranca];
  if TipoCheck(VarAux.FieldByName('C_GER_COC').AsString) then
    VpaDPermissao := VpaDPermissao + [puConsultarCliente];
  if TipoCheck(VarAux.FieldByName('C_GER_MPR').AsString) then
    VpaDPermissao := VpaDPermissao + [puManutencaoProdutos];
  if TipoCheck(VarAux.FieldByName('C_POL_CCO').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLCadastraCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_CAC').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLCancelarCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_ACO').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLAlterarCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_VCO').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLConsultarCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_ICO').AsString) then
    VpaDPermissao := VpaDPermissao + [puImprimirPedido];
  if TipoCheck(VarAux.FieldByName('C_POL_CGN').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLGerarNota];
  if TipoCheck(VarAux.FieldByName('C_POL_CGC').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLGerarCupom];
  if TipoCheck(VarAux.FieldByName('C_POL_IPE').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLImprimirEtiqueta];
  if TipoCheck(VarAux.FieldByName('C_GER_MCP').AsString) then
    VpaDPermissao := VpaDPermissao + [puProdutoCompleto];
  if TipoCheck(VarAux.FieldByName('C_GER_MCC').AsString) then
    VpaDPermissao := VpaDPermissao + [puClienteCompleto];
  if TipoCheck(VarAux.FieldByName('C_GER_MCS').AsString) then
    VpaDPermissao := VpaDPermissao + [puServicoCompleto];
  if TipoCheck(VarAux.FieldByName('C_GER_IMP').AsString) then
    VpaDPermissao := VpaDPermissao + [puImpressao];
  if TipoCheck(VarAux.FieldByName('C_GER_REL').AsString) then
    VpaDPermissao := VpaDPermissao + [puRelatorios];
  if TipoCheck(VarAux.FieldByName('C_POL_UTE').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLUsuarioTelemarketing];
  if TipoCheck(VarAux.FieldByName('C_POL_STE').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLSupervisorTelemarketing];
  if TipoCheck(VarAux.FieldByName('C_GER_SPA').AsString) then
    VpaDPermissao := VpaDPermissao + [puSomenteProdutos];
  if TipoCheck(VarAux.FieldByName('C_GER_SMP').AsString) then
    VpaDPermissao := VpaDPermissao + [puSomenteMateriaPrima];
  if TipoCheck(VarAux.FieldByName('C_GER_SPA').AsString) then
    VpaDPermissao := VpaDPermissao + [puSomenteProdutos];
  if TipoCheck(VarAux.FieldByName('C_GER_PRV').AsString) then
    VpaDPermissao := VpaDPermissao + [puVerPrecoVendaProduto];
  if TipoCheck(VarAux.FieldByName('C_GER_PRC').AsString) then
    VpaDPermissao := VpaDPermissao + [puVerPrecoCustoProduto];
  if TipoCheck(VarAux.FieldByName('C_EST_COP').AsString) then
    VpaDPermissao := VpaDPermissao + [puConsultarOP];
  if TipoCheck(VarAux.FieldByName('C_FAT_GNO').AsString) then
    VpaDPermissao := VpaDPermissao + [puFAGerarNota];
  if TipoCheck(VarAux.FieldByName('C_FAT_MNO').AsString) then
    VpaDPermissao := VpaDPermissao + [puFAManutencaoNota];
  if TipoCheck(VarAux.FieldByName('C_EST_AOP').AsString) then
    VpaDPermissao := VpaDPermissao + [puESAlterarOP];
  if TipoCheck(VarAux.FieldByName('C_EST_CNF').AsString) then
    VpaDPermissao := VpaDPermissao + [puESCadastrarNotaFiscal];
  if TipoCheck(VarAux.FieldByName('C_EST_MNF').AsString) then
    VpaDPermissao := VpaDPermissao + [puESManutencaoNotaFiscal];
  if TipoCheck(VarAux.FieldByName('C_EST_EOP').AsString) then
    VpaDPermissao := VpaDPermissao + [puESExcluirOP];
  if TipoCheck(VarAux.FieldByName('C_CHA_COM').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHCompleto];
  if TipoCheck(VarAux.FieldByName('C_CHA_CBA').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHCadastrosBasicos];
  if TipoCheck(VarAux.FieldByName('C_CHA_CAC').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHCadastrarChamado];
  if TipoCheck(VarAux.FieldByName('C_CHA_COC').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHConsultarChamado];
  if TipoCheck(VarAux.FieldByName('C_CHA_GEC').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHGerarCotacao];
  if TipoCheck(VarAux.FieldByName('C_CHA_ATC').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHAlterarChamadoTodosTecnicos];
  if TipoCheck(VarAux.FieldByName('C_CHA_ACF').AsString) then
    VpaDPermissao := VpaDPermissao + [puCHAlterarChamadosFinalizados];
  if TipoCheck(VarAux.FieldByName('C_POL_ECO').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLExcluirCotacao];
  if TipoCheck(VarAux.FieldByName('C_POL_AEF').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLAlterarExcluirDepoisFaturado];
  if TipoCheck(VarAux.FieldByName('C_POL_ATC').AsString) then
    VpaDPermissao := VpaDPermissao + [puPLAlterarTipoCotacao];
  if TipoCheck(VarAux.FieldByName('C_EST_ROM').AsString) then
   VpaDPermissao := VpaDPermissao + [puESRomaneio];
  if TipoCheck(VarAux.FieldByName('C_EST_CFA').AsString) then
   VpaDPermissao := VpaDPermissao + [puESCadastrarFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_AFF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESAdicionarFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_CFF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESConsultarFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_EFF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESExcluirFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_ARF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESAdicionarRetornoFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_CRF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESConsultarRetornoFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_ERF').AsString) then
   VpaDPermissao := VpaDPermissao + [puESExcluirRetornoFracaoFaccionista];
  if TipoCheck(VarAux.FieldByName('C_EST_IEP').AsString) then
   VpaDPermissao := VpaDPermissao + [puESImprimirEtiquetaProduto];
  if TipoCheck(VarAux.FieldByName('C_CRM_COM').AsString) then
   VpaDPermissao := VpaDPermissao + [puCRCompleto];
  if TipoCheck(VarAux.FieldByName('C_IND_SCV').AsString) then
   VpaDPermissao := VpaDPermissao + [puSomenteClientesdoVendedor];
  if TipoCheck(VarAux.FieldByName('C_CRM_SPV').AsString) then
   VpaDPermissao := VpaDPermissao + [puCRSomenteProspectDoVendedor];
  if TipoCheck(VarAux.FieldByName('C_EST_PEC').AsString) then
   VpaDPermissao := VpaDPermissao + [puESPedidoCompra];
  if TipoCheck(VarAux.FieldByName('C_FIN_BCL').AsString) then
   VpaDPermissao := VpaDPermissao + [puFIBloquearClientes];
  if TipoCheck(VarAux.FieldByName('C_GER_VAC').AsString) then
   VpaDPermissao := VpaDPermissao + [puVendedorAlteraContrato];
  if TipoCheck(VarAux.FieldByName('C_EST_SCO').AsString) then
   VpaDPermissao := VpaDPermissao + [puESSolicitacaoCompra];
  if TipoCheck(VarAux.FieldByName('C_EST_OCO').AsString) then
   VpaDPermissao := VpaDPermissao + [puESOrcamentoCompra];
  if TipoCheck(VarAux.FieldByName('C_POL_PIP').AsString) then
   VpaDPermissao:= VpaDPermissao + [puPLImprimirPedidoDuasVezes];
  if TipoCheck(VarAux.FieldByName('C_POL_IVP').AsString) then
   VpaDPermissao:= VpaDPermissao + [puPLImprimirValoresRelatorioPedidosPendentes];
  if TipoCheck(VarAux.FieldByName('C_EST_PCO').AsString) then
   VpaDPermissao := VpaDPermissao + [puESPlanoCorte];
  if TipoCheck(VarAux.FieldByName('C_CRM_CSP').AsString) then
   VpaDPermissao := VpaDPermissao + [puCRSomenteCadastraProspect];
  if TipoCheck(VarAux.FieldByName('C_EST_CLP').AsString) then
   VpaDPermissao := VpaDPermissao + [puESColetaQtdProduzidoOP];
  if TipoCheck(VarAux.FieldByName('C_EST_RPC').AsString) then
   VpaDPermissao := VpaDPermissao + [puESReprocessarProdutividade];
  if TipoCheck(VarAux.FieldByName('C_EST_ACE').AsString) then
   VpaDPermissao := VpaDPermissao + [puESAcertoEstoque];
  if TipoCheck(VarAux.FieldByName('C_EST_MGE').AsString) then
   VpaDPermissao := VpaDPermissao + [puESMenuGerencial];
  if TipoCheck(VarAux.FieldByName('C_EST_RGP').AsString) then
   VpaDPermissao := VpaDPermissao + [puESRegerarProjeto];
  if TipoCheck(VarAux.FieldByName('C_POL_PSP').AsString) then
   VpaDPermissao := VpaDPermissao + [puPLSeparaProduto];
  if TipoCheck(VarAux.FieldByName('C_POL_PCP').AsString) then
   VpaDPermissao := VpaDPermissao + [puPLConferirProduto];
  if TipoCheck(VarAux.FieldByName('C_POL_ECP').AsString) then
   VpaDPermissao := VpaDPermissao + [puPLEnvioParcialPedido];
  if TipoCheck(VarAux.FieldByName('C_FAT_CNO').AsString) then
   VpaDPermissao := VpaDPermissao + [puFAConsultarNota];
  if TipoCheck(VarAux.FieldByName('C_GER_COP').AsString) then
   VpaDPermissao := VpaDPermissao + [puSomenteCondicoesPgtoAutorizadas];
  if TipoCheck(VarAux.FieldByName('C_EST_CAC').AsString) then
   VpaDPermissao := VpaDPermissao + [puESCadastrarCelulaTrabalho];
  if TipoCheck(VarAux.FieldByName('C_EST_RES').AsString) then
   VpaDPermissao := VpaDPermissao + [puESReservaEstoque];

  config.UtilizarPercentualConsulta := TipoCheck(VarAux.fieldByName('C_IND_PER').AsString);
  config.ResponsavelLeituraLocacao := TipoCheck(VarAux.fieldByName('C_RES_LEL').AsString);
  Varia.CodClassificacaoProdutoGrupo := VarAux.FieldByName('C_COD_CLA').AsString;
  varia.CodFilialGrupo := VarAux.FieldByName('I_COD_FIL').AsInteger;

  VarAux.close;
end;

{******************************************************************************}
procedure TVariaveis.EscondeMenus(VpaMenu : TMenu;VpaEstado : Boolean);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 1 to VpaMenu.Items.Count - 2 do
  begin
    EscondeMenuItems(TMenuItem(VpaMenu.Items.Items[VpfLaco]),VpaEstado);
  end;
end;

{******************************************************************************}
function TVariaveis.RCodigosCondicaoPagamento(VpaCodGrupoUsuario: Integer): String;
begin
  result := '(0';
  AdicionaSQLAbreTabela(VarAux,'Select CON.I_COD_PAG, CON.C_NOM_PAG  '+
                               ' FROM CADCONDICOESPAGTO CON, CONDICAOPAGAMENTOGRUPOUSUARIO GRU '+
                               ' Where CON.I_COD_PAG = GRU.CODCONDICAOPAGAMENTO '+
                               ' AND GRU.CODGRUPOUSUARIO = '+IntToStr(VpaCodGrupoUsuario));
  while not VarAux.Eof do
  begin
    result := result + ','+VarAux.FieldByname('I_COD_PAG').AsString;
    VArAux.Next;
  End;
  VarAux.close;
  result := result + ')';
end;

{******************************************************************************}
function TVariaveis.RCodigosVendedores(VpaCodUsuario : Integer) : String;
begin
  result := '(0';
  AdicionaSQLAbreTabela(VarAux,'Select CODVENDEDOR from USUARIOVENDEDOR '+
                               ' Where CODUSUARIO = '+IntToStr(VpaCodUsuario));
  while not VarAux.Eof do
  begin
    result := result + ','+VarAux.FieldByname('CODVENDEDOR').AsString;
    VArAux.Next;
  End;
  VarAux.close;
  result := result + ')';
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TipoCheck(flag : string) : Boolean;
begin
  result := true;
  if flag = 'F' then
    result := false;
end;


{******************************************************************************}
procedure configuraVideo;
begin
 if  screen.Height =  600 then
   begin
      Varia.CT_AreaX := 796;
      Varia.CT_AreaY := 470;
   end
   else
     if screen.Height = 480 then
     begin
       Varia.CT_AreaX := 635;
       Varia.CT_AreaY := 350;
     end
     else
     if screen.Height = 768 then
     begin
        Varia.CT_AreaX := 1020;
        Varia.CT_AreaY := 638;
     end;
end;

{************* gera o proximo codigo ***************************************** }
function GeraProximoCodigo(VpaCampo, VpaTabelaProximoCod, VpaCampoFilial : string; VpaCodEmpFil : Integer; VpacodSequencial : Boolean;VpaBaseDados : TSQLConnection ) : Integer;
var
 Vpftabela : TSQL;
 VpfCodigo : integer;
begin
  //cria e abre a tabela de codigos
  Vpftabela := TSQL.Create(nil);
  Vpftabela.ASQLConnection := VpaBaseDados;
  AdicionaSQLAbreTabela(Vpftabela, 'select * from CADCODIGO' +
                                ' where ' + VpaCampoFilial + ' = ' + IntToStr(VpaCodEmpFil) );
  //se o registro n�o existir, inseri
  if Vpftabela.Eof then
  begin
    Vpftabela.Insert;
    Vpftabela.FieldByName(VpaCampoFilial).AsInteger := VpaCodEmpFil;
  end
  else
    VpfTabela.edit;

  if (Vpftabela.FieldByName(VpaCampo).AsInteger = 0) or VpaCodSequencial then
  begin
     if VpaCodEmpFil <> 0 then
       Vpfcodigo := ProximoCodigoFilial(VpaTabelaProximoCod,VpaCampo,VpaCampoFilial,VpaCodEmpFil,VpaBaseDados)
     else
       Vpfcodigo := ProximoCodigo(VpaTabelaProximoCod,VpaCampo);
  end
  else
    VpfCodigo := Vpftabela.FieldByName(VpaCampo).AsInteger + 1;

  result := Vpfcodigo;
  Vpftabela.FieldByName(Vpacampo).AsInteger := Vpfcodigo;
  Vpftabela.post;
  Vpftabela.close;
  Vpftabela.free;
end;

{********** carrega dados da empresa e filial para constantes do sistema ***** }
procedure CarregaEmpresaFilial( VpaCodEmpresa, VpaCodEmpFil : integer; VpaBaseDados : TSQLConnection );
var
 VpfTabela : TSQlQuery;
begin
  VpfTabela := TSQLQuery.Create(nil);
  VpfTabela.SQLConnection := VpaBaseDados;
  // dados da empresa
  AdicionaSQLAbreTabela(Vpftabela, 'select * from Cadempresas' +
                                ' where I_Cod_Emp = ' + IntToStr(VpaCodEmpresa) );
  if not VpfTabela.Eof then
  begin
    with Varia do
    begin
      CodigoEmpresa := VpfTabela.fieldByName('I_COD_EMP').AsInteger;
      NomeEmpresa :=   VpfTabela.fieldByName('C_NOM_EMP').AsString;
      MascaraPro :=  VpfTabela.fieldByName('C_PIC_PRO').AsString;
      MascaraCla :=  VpfTabela.fieldByName('C_PIC_CLA').AsString;
      MascaraClaSer :=  VpfTabela.fieldByName('C_CLA_SER').AsString;
      MascaraPlanoConta := VpfTabela.fieldByName('C_MAS_PLA').AsString;
      PlanoContasDevolucaoCotacao := VpfTabela.fieldByName('C_PLA_DEC').AsString;
      PlanoContasBancario := VpfTabela.fieldByName('C_PLA_RET').AsString;
      PlanoDescontoDuplicata := VpfTabela.fieldByName('C_PLA_DES').AsString;
      DadoBoletoPadraoNota := VpfTabela.fieldByName('I_BOL_PAD').AsInteger;
      SeqCampanhaTelemarketing := VpfTabela.fieldByName('I_SEQ_CAM').AsInteger;
      SeqCampanhaCadastrarEmail := VpfTabela.fieldByName('I_CAM_CEM').AsInteger;
      CodVendedorCotacao := VpfTabela.fieldByName('I_VEN_COT').AsInteger;
      CodServicoChamadoCotacao := VpfTabela.fieldByName('I_SER_CHA').AsInteger;
      CodServicoChamado := VpfTabela.fieldByName('I_SER_CPR').AsInteger;
      CodServicoDeslocamento := VpfTabela.fieldByName('I_SER_DPR').AsInteger;
      ValAcerto := VpfTabela.fieldByName('N_VAL_ACE').AsFloat;
      ModeloEtiquetaCartuchoToner := VpfTabela.fieldByName('I_MOD_ETO').AsInteger;
      ModeloEtiquetaCartuchoTinta := VpfTabela.fieldByName('I_MOD_ETI').AsInteger;
      CodClassificacaoPoTinta:= VpfTabela.FieldByName('C_CLA_POT').AsString;
      CodClassificacaoCilindro:= VpfTabela.FieldByName('C_CLA_CIL').AsString;
      CodClassificacaoChip:= VpfTabela.FieldByName('C_CLA_CHI').AsString;
      CodFilialFaturamentoCompras := VpfTabela.FieldByName('I_FIL_COM').AsInteger;
    end;
    with Config do   // boolean
    begin
      BaixaQTDCotacaonaNota := TipoCheck(VpfTabela.fieldByName('C_BAI_QCO').AsString);
      NaoPermitirAlterarCotacaoAposImpressa := TipoCheck(VpfTabela.fieldByName('C_BDI_COT').AsString);
      TecniconaCotacao := TipoCheck(VpfTabela.fieldByName('C_TEC_COT').AsString);
      ExigirCPFCNPJCliente := TipoCheck(VpfTabela.fieldByName('C_CPF_CLI').AsString);
      ExigirCEPCliente := TipoCheck(VpfTabela.fieldByName('C_CEP_CLI').AsString);
      MostrarCotacoesSomenteFilialAtiva := TipoCheck(VpfTabela.fieldByName('C_FIL_COT').AsString);
      CopiarTransportadoraPedido := TipoCheck(VpfTabela.fieldByName('C_CTP_COT').AsString);
      DataFinanceiroIgualDataCotacao := TipoCheck(VpfTabela.fieldByName('C_DAR_COT').AsString);
      ImprimeCotacaocomEntregadorSomenteAlmoxarifado := TipoCheck(VpfTabela.fieldByName('C_IMP_ALM').AsString);
      ImprimirEnvolopeSomentecomNotaFatMensal := TipoCheck(VpfTabela.fieldByName('C_FME_IEN').AsString);
      ImprimirCotacaoFatMensal := TipoCheck(VpfTabela.fieldByName('C_FME_ICO').AsString);
      Farmacia := TipoCheck(VpfTabela.fieldByName('C_IND_FAR').AsString);
      ManutencaoImpressoras := TipoCheck(VpfTabela.fieldByName('C_IND_MIM').AsString);
      RelogioPonto := TipoCheck(VpfTabela.fieldByName('C_IND_MRE').AsString);
      Grafica := TipoCheck(VpfTabela.fieldByName('C_IND_GRA').AsString);
      SoftwareHouse := TipoCheck(VpfTabela.fieldByName('C_IND_SOF').AsString);
      RotuladorasAutomatizadas := TipoCheck(VpfTabela.fieldByName('C_IND_ROT').AsString);
      AlterarCotacaoSomentenoDiaEmissao := TipoCheck(VpfTabela.fieldByName('C_ALC_SDE').AsString);
      ObservacaoFiscalNaCotacao := TipoCheck(VpfTabela.fieldByName('C_COT_TFI').AsString);
      UtilizarMailing := TipoCheck(VpfTabela.fieldByName('C_IND_MAI').AsString);
      ExibirMensagemAntesdeImprimirNotanoFaturamentoMensal := TipoCheck(VpfTabela.fieldByName('C_IND_AIN').AsString);
      PermitirAlterarVendedornaCotacao := TipoCheck(VpfTabela.fieldByName('C_COT_CAV').AsString);
      AlterarCotacaoComOPGerada := TipoCheck(VpfTabela.fieldByName('C_ALT_COG').AsString);
      TransportadoraObrigatorianaCotacao := TipoCheck(VpfTabela.fieldByName('C_TRA_OBR').AsString);
      GerarNotaPelaQuantidadeProdutos := TipoCheck(VpfTabela.fieldByName('C_NOT_QPR').AsString);
      MostrarImagemProdutoNaTeladaCotacao := TipoCheck(VpfTabela.fieldByName('C_COT_ICS').AsString);
    end;
  end;

    // dados da filial
  AdicionaSQLAbreTabela(VpfTabela, 'select * from CadFiliais' +
                                ' where I_Emp_Fil = ' + IntToStr(VpaCodEmpFil) );
  if not VpfTabela.Eof then
  begin
    with Varia do
    begin
        CodigoEmpFil := VpfTabela.fieldByName('I_EMP_FIL').AsInteger;
        NomeFilial := VpfTabela.fieldByName('C_NOM_FAN').AsString;
        RazaoSocialFilial := VpfTabela.fieldByName('C_NOM_FIL').AsString;
        CodigoFilial := VpfTabela.fieldByName('I_COD_FIL').AsInteger;
        SerieNota := VpfTabela.fieldByName('C_Ser_Not').AsString;
        SerieNotaServico := VpfTabela.fieldByName('C_SER_SER').AsString;
        TabelaPreco := VpfTabela.fieldByName('I_COD_TAB').AsInteger;
        TabelaPrecoServico := VpfTabela.fieldByName('I_TAB_SER').AsInteger;
        NotaFiscalPadrao := VpfTabela.fieldByName('I_DOC_NOT').AsInteger;
        DataUltimoFechamento := VpfTabela.fieldByName('D_ULT_FEC').AsDateTime;
        EnderecoFilial := VpfTabela.fieldByName('C_END_FIL').AsString + ', '+ VpfTabela.fieldByName('I_NUM_FIL').AsString;
        EnderecoFilialSemNumero := VpfTabela.fieldByName('C_END_FIL').AsString;
        NumEnderecoFilial := VpfTabela.fieldByName('I_NUM_FIL').AsString;
        CepFilial := VpfTabela.FieldByName('I_CEP_FIL').AsString;
        BairroFilial := VpfTabela.FieldByName('C_BAI_FIL').AsString;
        CidadeFilial := VpfTabela.FieldByName('C_CID_FIL').AsString;
        UFFilial := VpfTabela.FieldByName('C_EST_FIL').AsString;
        CNPJFilial := VpfTabela.FieldByName('C_CGC_FIL').AsString;
        IEFilial := VpfTabela.FieldByName('C_INS_FIL').AsString;
        InscricaoMunicipal := VpfTabela.FieldByName('C_INS_MUN').AsString;
        CPFResponsavelLegal := VpfTabela.FieldByName('C_CPF_RES').AsString;
        SiteFilial := VpfTabela.FieldByName('C_WWW_FIL').AsString;
        FoneFilial := VpfTabela.fieldByName('C_FON_FIL').AsString  ;
        if VpfTabela.fieldByName('C_FAX_FIL').AsString <> '' then
          FoneFilial :=  FoneFilial + '/'+VpfTabela.fieldByName('C_FAX_FIL').AsString  ;
        EMailFilial := VpfTabela.fieldByName('C_END_ELE').AsString;
        ISSQN := VpfTabela.fieldByName('N_PER_ISQ').AsFloat;
        TextoReducaoImposto := VpfTabela.fieldByName('C_TEX_RED').AsString;
        DatSNGPC := VpfTabela.fieldByName('D_DAT_SNG').AsDateTime;;
        PerCreditoICMSSimples := VpfTabela.fieldByName('N_PER_CSS').AsFloat;
        CodCNAE := VpfTabela.fieldByName('C_COD_CNA').AsString;

        //FINANCEIRO
        ContaBancaria := VpfTabela.fieldByName('C_CON_BAN').AsString;
        ContaBancariaBoleto := VpfTabela.fieldByName('C_CON_BOL').AsString;
        ContaBancariaContrato := VpfTabela.fieldByName('C_CON_CON').AsString;
        ValChamado := VpfTabela.fieldByName('N_VAL_CHA').AsFloat;
        ValKMRodado := VpfTabela.fieldByName('N_VAL_DKM').AsFloat;
        //CRM
        EmailComercial := VpfTabela.fieldByName('C_EMA_COM').AsString;
        SenhaEmailComercial := VpfTabela.fieldByName('C_SEN_EMC').AsString;
        CRMCorEscuraEmail := VpfTabela.FieldByName('C_CRM_CES').AsString;
        CRMCorClaraEmail := VpfTabela.FieldByName('C_CRM_CCL').AsString;

        //ecf
        PathRetornoECF := VpfTabela.FieldByName('C_DIR_ECF').AsString;

        //nfe
        CertificadoNFE := VpfTabela.FieldByName('C_CER_NFE').AsString;
        UFSefazNFE := VpfTabela.FieldByName('C_UFD_NFE').AsString;
        CodIBGEMunicipio := VpfTabela.FieldByName('I_COD_FIS').AsInteger;
    end;
    with Config do   // boolean
    begin
      GerarFinanceiroCotacao := TipoCheck(VpfTabela.fieldByName('C_FIN_COT').AsString);
      BaixarEstoqueCotacao := TipoCheck(VpfTabela.fieldByName('C_COT_BEC').AsString);
      ExcluirFinanceiroCotacaoQuandoGeraNota := TipoCheck(VpfTabela.fieldByName('C_EXC_FIC').AsString);
      RegerarFinanceiroQuandoCotacaoAlterada := TipoCheck(VpfTabela.fieldByName('C_FIN_ACO').AsString);
      EstoqueFiscal := TipoCheck(VpfTabela.fieldByName('C_EST_FIS').AsString);
      EmitirECF := TipoCheck(VpfTabela.fieldByName('C_IND_ECF').AsString);
      //
      UtilizarClassificacaoFiscalnosProdutos := TipoCheck(VpfTabela.fieldByName('C_IND_CLA').AsString);
      UtilizarNSU := TipoCheck(VpfTabela.fieldByName('C_IND_NSU').AsString);
      SimplesFederal := TipoCheck(VpfTabela.fieldByName('C_SIM_FED').AsString);
      CobrarFormaPagamento := TipoCheck(VpfTabela.fieldByName('C_COB_FRM').AsString);
      UtilizarCompose := TipoCheck(VpfTabela.fieldByName('C_COT_COM').AsString);
      EmiteNFe := TipoCheck(VpfTabela.fieldByName('C_IND_NFE').AsString);
      NFEHomologacao := TipoCheck(VpfTabela.fieldByName('C_AMH_NFE').AsString);
      NFEDanfeRetrato := VpfTabela.fieldByName('C_IND_NFE').AsString = 'R';
      NotaFiscalConjugada := TipoCheck(VpfTabela.fieldByName('C_NOT_CON').AsString);
    end;
  end;
  VpfTabela.close;
  VpfTabela.free;
end;

{******************************************************************************}
procedure CarregaDiretorios;
var
 VpfIni : TRegIniFile;
 VpfRegistry : TRegistry;
begin
 // informacoes do ini
 try
    VpfIni := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
    Varia.ImpressoraRelatorio :=  VpfIni.ReadString('IMPRESSORA','RELATORIO',   'A');  // carrega drive da jato tinta;
    Varia.ImpressoraAlmoxarifado :=  VpfIni.ReadString('IMPRESSORA','ALMOXARIFADO','');
    varia.PortaComunicacaoBalanca := VpfIni.ReadInteger('PERIFERICOS','PORTABALANCA',1);
    varia.PortaComunicacaoImpTermica := VpfIni.ReadString('PERIFERICOS','PORTAIMPTERMICA','');
    varia.PortaComunicacaoImpTermica2 := VpfIni.ReadString('PERIFERICOS','PORTAIMPTERMICA2','');
    Varia.ImpressoraAssitenciaTecnica := VpfIni.ReadString('IMPRESSORA','ASSISTENCIA','');
    Varia.PathRestauracaoBackup := VpfIni.ReadString('DIRETORIOS','RESTAURACAO','c:\Eficacia\Restauracao');
    Varia.PathSybase  := VpfIni.ReadString('DIRETORIOS','PATH_SYBASE','A');
    varia.UsarGaveta := VpfIni.ReadString('ECF','USARGAVETA','N');
    varia.PathSintegra := VpfIni.ReadString('SINTEGRA','PATH', '');
    varia.SenhaBanco := Descriptografa(VpfIni.ReadString(varia.ParametroBase+'\BANCODADOS','SENHA',''));
    varia.PathInSig := VpfIni.ReadString('DIRETORIOS','PATH_SISCORP','C:\Eficacia');
    varia.ImpressoraCheque := VpfIni.ReadInteger('IMPRESSORA','CHEQUE', 0);
    varia.ModemTelemarketing := VpfIni.ReadString('TELEMARKETING','MODEM','');
    varia.CodClientePadraoCotacao := VpfIni.ReadInteger('COTACAO','CLIENTEPADRAO',0);
    varia.CodTipoCotacaoMaquinaLocal :=VpfIni.ReadInteger('COTACAO','TIPOCOTACAO',0);
    config.PermanecerOVendedorDaUltimaVenda :=VpfIni.ReadBool('COTACAO','PERMANECERULTIMOVENDEDOR',False);
    Varia.DiretorioFiscais :=  VpfIni.ReadString('DIRETORIOS','ARQUIVOSFISCAIS',RetornaDiretorioCorrente+'\FiscaisGerados');
    varia.DiretorioTemporarioCrystal :=  VpfIni.ReadString('DIRETORIOS','TEMPORARIOCRYSTAL',RetornaDiretorioCorrente+'\Crystal\temp');
    if not existeDiretorio(Varia.DiretorioFiscais) then
      CriaDiretorio(Varia.DiretorioFiscais);
    if not existeDiretorio(varia.DiretorioTemporarioCrystal) then
      CriaDiretorio(varia.DiretorioTemporarioCrystal);
  finally
    VpfIni.Free;
  end;

  VpfRegistry := TRegistry.Create;
  VpfRegistry.RootKey := HKEY_LOCAL_MACHINE;
  VpfRegistry.OpenKey(CT_DIRETORIOREGEDIT+'\Versoes',true);
  if VpfRegistry.KeyExists('ATUALIZAAUTOMATICAMENTEVERSAO') then
    Config.AtualizarVersaoAutomaticamente:= VpfRegistry.ReadBool('ATUALIAAUTOMATICAMENTEVERSAO')
  else
    Config.AtualizarVersaoAutomaticamente := true;

  VpfRegistry.free;
end;

{******* carrega informacoes do cfg ****************************************** }
procedure carregaCFG( VpaBaseDados : TSQLConnection);
var
 VpfTabela : TSQLQuery;
begin
  VpfTabela := TSQLQuery.Create(nil);
  VpfTabela.SQLConnection := VpaBaseDados;
  Varia.NomeComputador :=  Sistema.RNomComputador;
  AdicionaSQLAbreTabela(VpfTabela, 'select * from cfg_geral');
  if not VpfTabela.Eof then
  begin
    with Varia do
    begin
    //-------  geral
       CodigoEmpresa := VpfTabela.fieldByName('I_COD_EMP').AsInteger;
       CodigoEmpFil := VpfTabela.fieldByName('I_EMP_FIL').AsInteger;
       CodigoUsuarioSistema := VpfTabela.fieldByName('I_COD_USU').AsInteger;
       case VpfTabela.fieldByName('I_DEC_VAl').AsInteger of
          2 : MascaraValorUnitario := '#,###,###,###,##0.00';
          3 : MascaraValorUnitario := '#,###,###,###,##0.000';
          4 : MascaraValorUnitario := '#,###,###,###,##0.0000';
       else
          MascaraValorUnitario := '#,###,###,###,##0.00';
       end;
       MascaraValor :=  MascaraValorUnitario;

       MascaraMoeda := VpfTabela.fieldByName('C_MAS_MOE').AsString + ' ' + MascaraValorUnitario ;
       CurrencyString := VpfTabela.fieldByName('C_MAS_MOE').AsString;

       case VpfTabela.fieldByName('I_DEC_QTD').AsInteger of
         0 : MascaraQtd :=  '#,###,###,###,##0';
         1 : MascaraQtd :=  '#,###,###,###,##0.0';
         2 : MascaraQtd :=  '#,###,###,###,##0.00';
         3 : MascaraQtd :=  '#,###,###,###,##0.000';
         4 : MascaraQtd :=  '#,###,###,###,##0.0000';
       else
          MascaraQtd :=  '#,###,###,###,##0.00';
       end;
       DecimaisQtd := VpfTabela.fieldByName('I_DEC_QTD').AsInteger;

       MoedaBase := VpfTabela.fieldByName('I_MOE_BAS').AsInteger;
       DataDaMoeda := VpfTabela.fieldByName('D_DAT_MOE').AsDateTime;
       MoedasVazias := VpfTabela.fieldByName('C_MOE_VAZ').AsString;
       Decimais := VpfTabela.fieldByName('I_DEC_VAL').AsInteger;
       GrupoUsuarioMaster := VpfTabela.fieldByName('I_GRU_MAS').AsInteger;
       VersaoBanco := VpfTabela.fieldByName('I_ULT_ALT').AsInteger;
       TipoBase :=  VpfTabela.fieldByName('I_TIP_BAS').AsInteger;
       DiaValBase :=  VpfTabela.fieldByName('I_DIA_VAl').AsInteger;
       ServidorSMTP := lowercase(VpfTabela.fieldByName('C_SER_SMT').AsString);
       ServidorPop := lowercase(VpfTabela.fieldByName('C_SER_POP').AsString);
       UsuarioSMTP := lowercase(VpfTabela.fieldByName('C_USU_SMT').AsString);
       SenhaEmail := lowercase(VpfTabela.fieldByName('C_SEN_EMA').AsString);
       CondicaoPagamentoContrato := VpfTabela.fieldByName('I_PAG_CON').AsInteger;
       FormaPagamentoContrato := VpfTabela.fieldByName('I_FRM_CON').AsInteger;
       MesLocacao := VpfTabela.fieldByName('I_MES_LOC').AsInteger;
       AnoLocacao := VpfTabela.FieldByName('I_ANO_LOC').AsInteger;
       TipoContratoLocacao := VpfTabela.FieldByName('I_CON_LOC').AsInteger;
       SeqProdutoContrato := VpfTabela.FieldByName('I_PRO_CON').AsInteger;
       CodProdutoContrato := VpfTabela.FieldByName('C_PRO_CON').AsString;
       DatFimLocacao := VpfTabela.FieldByName('D_FIM_LOC').AsDateTime;
       EstagioInicialChamado := VpfTabela.fieldByName('I_EST_ICH').AsInteger;
       EstagioAguardandoAprovacaoChamado := VpfTabela.fieldByName('I_EST_AAC').AsInteger;
       TipoChamadoInstalacao := VpfTabela.fieldByName('I_CHA_INS').AsInteger;
       CodPesquisaSatisfacaoChamado := VpfTabela.fieldByName('I_PES_SAA').AsInteger;
       CodPesquisaSatisfacaoInstalacao := VpfTabela.fieldByName('I_PES_INS').AsInteger;
       CodTecnicoIndefinido := VpfTabela.fieldByName('I_TEC_IND').AsInteger;
       DatUltimaLeituraLocacao := VpfTabela.FieldByname('D_ULT_LEL').AsDateTime;
       CRMTamanhoLogo := VpfTabela.FieldByName('I_CRM_TIM').AsInteger;
       CRMAlturaLogo := VpfTabela.FieldByName('I_CRM_AIM').AsInteger;
       CentroCustoPadrao := VpfTabela.FieldByName('I_CEN_CUS').AsInteger;
       EstagioInicialProposta := VpfTabela.FieldByName('I_EST_CRI').AsInteger;
       EstagioAguardandoRecebimentoProposta := VpfTabela.FieldByName('I_EST_CAR').AsInteger;
       EstagioPropostaEmNegociacao := VpfTabela.FieldByName('I_EST_CRN').AsInteger;
       EstagioPropostaConcluida := VpfTabela.FieldByName('I_EST_CRF').AsInteger;
       EstagioInicialCompras := VpfTabela.FieldByName('I_EST_COI').AsInteger;
       EstagioComprasAprovado := VpfTabela.FieldByName('I_EST_COA').AsInteger;
       EstagioComprasAguardandoConfirmacaoRecebFornececedor:= VpfTabela.FieldByName('I_EST_CCR').AsInteger;
       EstagioComprasAguardandoEntregaFornecedor:= VpfTabela.FieldByName('I_EST_CAE').AsInteger;
       EstagioFinalCompras:= VpfTabela.FieldByName('I_EST_COF').AsInteger;
       EstagioInicialOrcamentoCompra := VpfTabela.FieldByName('I_EST_OCI').AsInteger;
       EstagioOrcamentoCompraAprovado := VpfTabela.FieldByName('I_EST_OCA').AsInteger;
       EstagioFinalOrcamentoCompra := VpfTabela.FieldByName('I_EST_OCF').AsInteger;
       CodSetor:= VpfTabela.FieldByName('I_COD_SET').AsInteger;
       CodMeioDivulgacaoVisitaVendedor := VpfTabela.FieldByName('I_DIV_VVE').AsInteger;
       CodHistoricoLigacaoVisitaVendedor := VpfTabela.FieldByName('I_HIS_VVE').AsInteger;
       CodClienteOP := VpfTabela.FieldByName('I_ORP_ICP').AsInteger;
       AcrescimoCMEnfesto := VpfTabela.FieldByName('N_ACR_TEC').AsFloat;
       SituacaoPadraoCliente:= VpfTabela.FieldByName('I_SIT_CLI').AsInteger;

       PathVersoes:= VpfTabela.FieldByName('C_DIR_VER').AsString;
       DriveFoto:= VpfTabela.FieldByName('C_DIR_FOT').AsString;
       PathRelatorios:= VpfTabela.FieldByName('C_DIR_REL').AsString;
       PathCliente := VpfTabela.FieldByName('C_DIR_CLI').AsString;
       PathRemessaBancaria:= VpfTabela.FieldByName('C_DIR_REM').AsString;
       PathBackup:= VpfTabela.FieldByName('C_DIR_BKP').AsString;
       PathSecundarioBackup:= VpfTabela.FieldByName('C_DRB_SEC').AsString;
       NomBackup:= VpfTabela.FieldByName('C_NOM_BKP').AsString;
       CodFormaPagamentoNotaEntrada := VpfTabela.FieldByName('I_FRM_NEN').AsInteger;
       CodSetorTecnica := VpfTabela.FieldByName('I_SET_TEC').AsInteger;
       case VpfTabela.FieldByName('C_TIP_ORP').AsString[1] of
         'F' : TipoOrdemProducao := toFracionada;
         'A' : TipoOrdemProducao := toAgrupada;
         'S' : TipoOrdemProducao := toSubMontagem;
       else
         TipoOrdemProducao := toFracionada;
       end;
       QtdPecasAtacado := VpfTabela.FieldByName('I_COT_QPA').AsInteger;
       NaturezaOperacaoTroca := VpfTabela.FieldByName('C_COT_NTR').AsString;
       EmailGeralCompras := VpfTabela.FieldByName('C_EMA_COM').AsString;
       QtdDiasPendenciaCompras := VpfTabela.FieldByName('I_DIA_AVC').AsInteger;
       DatInformacaoGerencial :=  DataSemHora(VpfTabela.FieldByName('D_INF_GER').AsDateTime);
       QtdMaximaMesesEntregaPedido := VpfTabela.FieldByName('I_COT_QME').AsInteger;
       QtdDiasUteisEntregaAmostra := VpfTabela.FieldByName('I_DIA_AMO').AsInteger;
       CodDesenvolvedorRequisicaoAmostra := VpfTabela.FieldByName('I_COD_DEA').AsInteger;
    end;

    with Config do   // boolean
    begin
      CodigoBarras := TipoCheck(VpfTabela.fieldByName('C_COD_BAR').AsString);
      AtualizaPermissao := TipoCheck(VpfTabela.fieldByName('C_VER_FOR').AsString);
      ImpPorta :=  TipoCheck(VpfTabela.fieldByName('C_IMP_PRT').AsString);
      ControlarFaturamentoMinimoContrato := TipoCheck(VpfTabela.fieldByName('C_FAT_MIN').AsString);
      NoFaturamentoMensalProcessarFaturamentoPosterior := TipoCheck(VpfTabela.fieldByName('C_FAT_POS').AsString);
      ExigirCNPJeCEPCotacaoPadrao := TipoCheck(VpfTabela.fieldByName('C_COT_ECC').AsString);
      EnviaCotacaoEmailTransportadora := TipoCheck(VpfTabela.fieldByName('C_COT_EEE').AsString);
      EnviaChamadoEmailTecnico := TipoCheck(VpfTabela.fieldByName('C_CHA_EET').AsString);
      EnviarEmailFaturamentoMensal := TipoCheck(VpfTabela.fieldByName('C_CON_EMA').AsString);
      NoFaturamentoMensalCondPagamentoCliente := TipoCheck(VpfTabela.fieldByName('C_CON_CPC').AsString);
      EmitirNotaFaturamentoMensal := TipoCheck(VpfTabela.fieldByName('C_CON_NOT').AsString);
      UtilizarTabelaPreconaCotacao := TipoCheck(VpfTabela.fieldByName('C_COT_TPC').AsString);
      DescontoNosProdutodaCotacao := TipoCheck(VpfTabela.fieldByName('C_IND_DPC').AsString);
      EstagioFinalOpParaCotacaoFaturamentoPosterior := TipoCheck(VpfTabela.fieldByName('C_EST_FAP').AsString);
      EstagioFinalOPparaCotacaoTransportadoraVaiza := TipoCheck(VpfTabela.fieldByName('C_EST_TRV').AsString);
      PermitirAlterarTipoCotacao := TipoCheck(VpfTabela.fieldByName('C_COT_ATC').AsString);
      UtilizarLeitorSeparacaoProduto := TipoCheck(VpfTabela.fieldByName('C_COT_LSP').AsString);
      NaCotacaoBuscaroContato := TipoCheck(VpfTabela.fieldByName('C_CON_COT').AsString);
      SolicitarSenhaparaCancelarBaixaParcial := TipoCheck(VpfTabela.fieldByName('C_COT_SCB').AsString);
      QuandoGerarFinanceiorMostrarCotacoesNaoFaturadas := TipoCheck(VpfTabela.fieldByName('C_COT_MCN').AsString);
      AdicionarQtdIdealEstoquenaOP := TipoCheck(VpfTabela.fieldByName('C_ORP_AQI').AsString);
      PermitirGravaCotacaoSemCNPJaVista := TipoCheck(VpfTabela.fieldByName('C_COT_ECV').AsString);
      ObrigarObservacaoNaGarantia := TipoCheck(VpfTabela.fieldByName('C_COT_OGO').AsString);
      PermitirCancelareExtornarCotacao := TipoCheck(VpfTabela.fieldByName('C_COT_PCE').AsString);
      PermitirBaixarNumeroPedido:= TipoCheck(VpfTabela.fieldByName('C_COT_PBN').AsString);
      MetaVendedorpelaCarteiradeClientes := TipoCheck(VpfTabela.fieldByName('C_MET_VEN').AsString);
      RetornoEmailPropostaParaoVendedor := TipoCheck(VpfTabela.fieldByName('C_CRM_REV').AsString);
      ProdutosRotuladosnaProposta := TipoCheck(VpfTabela.fieldByName('C_CRM_PPR').AsString);
      ControlarASeparacaodaCotacao := TipoCheck(VpfTabela.fieldByName('C_COT_CSC').AsString);
      ConferirAQuantidadeSeparada := TipoCheck(VpfTabela.fieldByName('C_COT_CSP').AsString);
      ProximoEstagioOPAutomatico := TipoCheck(VpfTabela.fieldByName('C_ORP_PEA').AsString);
      BaixarConsumonaAlteracaoEstagioOP := TipoCheck(VpfTabela.fieldByName('C_ORP_BCE').AsString);
      SugerirPrecoAtacado := TipoCheck( VpfTabela.fieldByName('C_COT_SPA').AsString);
      ControlarTrocasnaCotacao := TipoCheck( VpfTabela.fieldByName('C_COT_CTR').AsString);
      ImprimirPedidoPendentesPorPeriodo := TipoCheck( VpfTabela.fieldByName('C_COT_PPP').AsString);
      AutoCadastraAlteraEstagio := TipoCheck( VpfTabela.fieldByName('C_ORP_AAE').AsString);
      AlterarEstagioFracaoPeloTipoEstagio := TipoCheck( VpfTabela.fieldByName('C_ORP_AET').AsString);
      ImprimirEtiquetanaAlteracaodoEstagio := TipoCheck( VpfTabela.fieldByName('C_ORP_IEA').AsString);
      ExigirTransportadoraCliente := TipoCheck( VpfTabela.fieldByName('C_CLI_OTR').AsString);
      ExigirCondicaoPagamentoCliente := TipoCheck( VpfTabela.fieldByName('C_CLI_OCP').AsString);
      ExigirFormaPagamentoCliente := TipoCheck( VpfTabela.fieldByName('C_CLI_OFP').AsString);
      ExigirVendedorCliente := TipoCheck( VpfTabela.fieldByName('C_CLI_OVE').AsString);
      ExigirPrepostoCliente := TipoCheck( VpfTabela.fieldByName('C_CLI_OVP').AsString);
      ExigirContatoCliente := TipoCheck( VpfTabela.fieldByName('C_CLI_ONC').AsString);
      ExigirEmailCliente := TipoCheck( VpfTabela.fieldByName('C_CLI_OEM').AsString);
      ServidorInternetRequerAutenticacao := TipoCheck( VpfTabela.fieldByName('C_AUT_INT').AsString);
      ObservacaoProdutoPedidoCompra := TipoCheck( VpfTabela.fieldByName('C_OBP_PED').AsString);
      ConverterMTeCMparaMM := TipoCheck( VpfTabela.fieldByName('C_ORP_CMM').AsString);
      ImprimirCodigoCorNaNota := TipoCheck( VpfTabela.fieldByName('C_NOF_ICO').AsString);
    end;
  end;

   CarregaEmpresaFilial(varia.CodigoEmpresa, Varia.CodigoEmpFil, VpaBaseDados );

    // -- produtos
    AdicionaSQLAbreTabela(VpfTabela, 'select * from cfg_produto');
    if not VpfTabela.Eof then
    begin
      with Varia do
      begin
         DiasValidade := VpfTabela.fieldByName('I_DIA_ORC').AsInteger;
         UnidadePadrao := VpfTabela.fieldByName('C_UNI_PAD').AsString;
         UnidadeCX := VpfTabela.fieldByName('C_UNI_CAX').AsString;
         UnidadeUN := VpfTabela.fieldByName('C_UNI_PEC').AsString;
         UnidadeKit := VpfTabela.fieldByName('C_UNI_KIT').AsString;
         UnidadeBarra := VpfTabela.fieldByName('C_UNI_BAR').AsString;
         OperacaoEstoqueInicial := VpfTabela.fieldByName('I_OPE_INI').AsInteger;
         UltimoMesEstoque := VpfTabela.fieldByName('I_MES_EST').AsInteger;
         UltimoAnoEstoque := VpfTabela.fieldByName('I_ANO_EST').AsInteger;
         UtilizarIpi := TipoCheck(VpfTabela.fieldByName('C_FLA_IPI').AsString);
         InventarioEntrada := VpfTabela.FieldByName('I_INV_ENT').AsInteger;
         InventarioSaida := VpfTabela.FieldByName('I_INV_SAI').AsInteger;
         EstagioOrdemProducao := VpfTabela.FieldByName('CODEST').AsInteger;
         EstagioOrdemProducaoAlmoxarifado := VpfTabela.FieldByName('I_EST_ALM').AsInteger;
         EstagioAguardandoEntrega := VpfTabela.FieldByName('I_EST_AEN').AsInteger;
         EstagioNaEntrega := VpfTabela.FieldByName('I_EST_NEN').AsInteger;
         EstagioFinalOrdemProducao := VpfTabela.FieldByName('I_EST_FIN').AsInteger;
         EstagioCotacaoAlterada := VpfTabela.FieldByName('I_EST_ALT').AsInteger;
         EstagioCotacaoExtornada := VpfTabela.FieldByName('I_EST_CEX').AsInteger;
         EstagioBaixaParcialCancelada := VpfTabela.FieldByName('I_EST_BCC').AsInteger;
         EstagioAssistenciaTecnica := VpfTabela.FieldByName('I_EST_AST').AsInteger;
         EstagioChamadoFinalizado := VpfTabela.fieldByName('I_EST_CFI').AsInteger;
         EstagioChamadoFaturado := VpfTabela.fieldByName('I_EST_CFA').AsInteger;
         EstagioChamadoAguardandoAgendamendo := VpfTabela.fieldByName('I_EST_CAA').AsInteger;
         EstagioEnviadoFaccionista := VpfTabela.fieldByName('I_EST_FAC').AsInteger;
         EstagioRetornoFaccionista := VpfTabela.fieldByName('I_EST_RFA').AsInteger;
         EstagioSerra := VpfTabela.fieldByName('I_EST_SER').AsInteger;
         EstagioPantografo := VpfTabela.fieldByName('I_EST_PAN').AsInteger;
         EstagioOPReimportada := VpfTabela.fieldByName('I_EST_REI').AsInteger;
         TipoCotacao := VpfTabela.FieldByName('I_TIP_ORC').AsInteger;
         TipoCotacaoPedido := VpfTabela.FieldByName('I_ORC_PED').AsInteger;
         TipoCotacaoAmostra := VpfTabela.FieldByName('I_ORC_AMO').AsInteger;
         TipoCotacaoFaturamentoPosterior := VpfTabela.FieldByName('I_ORC_FPO').AsInteger;
         TipoCotacaoContrato := VpfTabela.FieldByName('I_ORC_CON').AsInteger;
         TipoCotacaoGarantia := VpfTabela.FieldByName('I_ORC_GAR').AsInteger;
         TipoCotacaoRevenda := VpfTabela.FieldByName('I_ORC_REV').AsInteger;
         TipoCotacaoFaturamentoPendente := VpfTabela.FieldByName('I_FAT_PEN').AsInteger;
         CodTransportadoraVazio := VpfTabela.FieldByName('I_COD_TRA').AsInteger;
         OperacaoEstoqueEstornoEntrada := VpfTabela.FieldByName('I_OPE_EEN').AsInteger;
         OperacaoEstoqueEstornoSaida := VpfTabela.FieldByName('I_OPE_ESA').AsInteger;
         OperacaoAcertoEstoqueEntrada := VpfTabela.FieldByName('I_OPE_EXE').AsInteger;
         OperacaoAcertoEstoqueSaida := VpfTabela.FieldByName('I_OPE_EXS').AsInteger;
         OperacaoEstoqueImpressaoEtiqueta := VpfTabela.FieldByName('I_OPE_EIE').AsInteger;
         OperacaoAdicionaReservaSaidaEstoque := VpfTabela.FieldByName('I_OPE_RES').AsInteger;
         OperacaoSaidaReservaAdicionaEstoque := VpfTabela.FieldByName('I_OPE_REE').AsInteger;
         OperacaoSaidaProdutoBaixaChamado := VpfTabela.FieldByName('I_OPE_SBC').AsInteger;
         OperacaoEntradaProdutoBaixaChamado := VpfTabela.FieldByName('I_OPE_EBC').AsInteger;

         CodFilialControladoraEstoque := VpfTabela.FieldByName('I_FIL_EST').AsInteger;
         ClassificacaoFiscal := VpfTabela.fieldByName('C_CLA_FIS').AsString;
         CodClassificacaoProdutos := VpfTabela.fieldByName('C_CLA_PRO').AsString;
         CodClassificacaoMateriaPrima := VpfTabela.fieldByName('C_CLA_MAP').AsString;
         CodClassificacaoProdutoRotulado := VpfTabela.fieldByName('C_CLA_PRR').AsString;
         ModeloEtiquetaNotaEntrada := VpfTabela.fieldByName('I_MOD_ENE').AsInteger;
         ModeloEtiquetaPequena := VpfTabela.fieldByName('I_MOD_EPE').AsInteger;
         QuantidadeLetrasClassificacaProdutoUnidadeFabricacao := VpfTabela.fieldByName('I_QTD_LUF').AsInteger;
         case VpfTabela.FieldByName('I_REG_LOT').AsInteger of
           0 : RegraNumeroSerie := rnNNNNNDDMAAD;
         end;
         case VpfTabela.FieldByName('I_TIP_BAR').AsInteger of
           0 : TipCodBarras := cbNenhum;
           1 : TipCodBarras := cbEAN13;
         end;
         NumPrefixoCodEAN := VpfTabela.fieldByName('N_PRE_EAN').AsFloat;
         NumUltimoCodigoEAN := VpfTabela.fieldByName('I_ULT_EAN').AsInteger;
       end;

      with Config do   // boolean
      begin
        AvisaQtdPedido := TipoCheck(VpfTabela.fieldByName('C_Qtd_Est').AsString);
        AvisaQtdMinima := TipoCheck(VpfTabela.fieldByName('C_Qtd_Min').AsString);
        QtdNegativa := VpfTabela.fieldbyname('I_Est_Neg').AsInteger;
        MascaraProdutoPadrao := TipoCheck(VpfTabela.fieldByName('C_MAS_PRO').AsString);
        VerCodigoProdutos := TipoCheck(VpfTabela.fieldByName('C_VER_PRO').AsString);
        CodigoUnicoProduto := not TipoCheck(VpfTabela.fieldByName('C_Cod_Uni').AsString);
        PermiteItemNFEntradaDuplicado := TipoCheck(VpfTabela.fieldByName('C_Ent_Rep').AsString);
        CadastroEtiqueta := TipoCheck(VpfTabela.fieldByName('C_IND_ETI').AsString);
        CadastroCadarco := TipoCheck(VpfTabela.fieldByName('C_IND_CAR').AsString);
        MostrarAcessoriosnoProduto := TipoCheck(VpfTabela.fieldByName('C_IND_ACE').AsString);
        EstoquePorCor := TipoCheck(VpfTabela.fieldByName('C_EST_COR').AsString);
        EstoquePorTamanho := TipoCheck(VpfTabela.fieldByName('C_EST_TAM').AsString);
        PrecoPorClienteAutomatico := TipoCheck(VpfTabela.fieldByName('C_PRC_AUT').AsString);
        ExigirDataEntregaPrevista := TipoCheck(VpfTabela.fieldByName('C_EXI_DAP').AsString);
        ExcluirCotacaoQuandoNFCancelada := TipoCheck(VpfTabela.fieldByName('C_EXC_CNF').AsString);
        NomDesenhoIgualCodigo := TipoCheck(VpfTabela.fieldByName('C_DES_ICO').AsString);
        EstoqueCentralizado := TipoCheck( VpfTabela.fieldByName('C_EST_CEN').AsString);
        NumeroSerieProduto := TipoCheck( VpfTabela.fieldByName('C_SER_PRO').AsString);
        ControlarBrinde := TipoCheck( VpfTabela.fieldByName('C_IND_BRI').AsString);
        PermiteAlteraNomeProdutonaCotacao := TipoCheck( VpfTabela.fieldByName('C_ALT_DPR').AsString);
        PermiteAlteraNomeProdutonaNotaEntrada := TipoCheck( VpfTabela.fieldByName('C_ALT_DPE').AsString);
        ValordeCompraComFrete := TipoCheck( VpfTabela.fieldByName('C_VCO_FRE').AsString);
        CodigoProdutoCompostopelaClasificacao := TipoCheck( VpfTabela.fieldByName('C_COD_MCD').AsString);
        ConsumodoProdutoporCombinacao := TipoCheck( VpfTabela.fieldByName('C_COM_COR').AsString);
        ValorVendaProdutoAutomatico := TipoCheck( VpfTabela.fieldByName('C_VLV_AUT').AsString);
        ExigirCorNotaEntrada := TipoCheck( VpfTabela.fieldByName('C_COR_NOE').AsString);
        AcertodeEstoquePeloSequencial := TipoCheck( VpfTabela.fieldByName('C_EST_LSA').AsString);
        ExigirPrecoCustoProdutonoCadastro := TipoCheck( VpfTabela.fieldByName('C_CUS_OBR').AsString);
        ExigirPrecoVendaProdutonoCadastro := TipoCheck( VpfTabela.fieldByName('C_PRE_OBR').AsString);
        ExigirQdMetrosQuandoDiferenteMT := TipoCheck( VpfTabela.fieldByName('C_DMT_OQC').AsString);
        ReferenciaClienteCadastrarAutomatica := TipoCheck( VpfTabela.fieldByName('C_REF_CLI').AsString);
        MostrarOrdemProducaoNoAcertoEstoque := TipoCheck( VpfTabela.fieldByName('C_ORP_ACE').AsString);
        MostrarCodBarrasCorNoAcertoEstoque := TipoCheck( VpfTabela.fieldByName('C_EAN_ACE').AsString);
        EstoquePorNumeroSerie := TipoCheck( VpfTabela.fieldByName('C_EST_SER').AsString);
      end;
    end;
    if not Config.EstoqueCentralizado then
      Varia.CodFilialControladoraEstoque := Varia.CodigoEmpFil;

    //--------------- financeiro ----------------------------------------
    AdicionaSQLAbreTabela(VpfTabela, 'select * from cfg_financeiro');
    if not VpfTabela.Eof then
    begin
      with Varia do
      begin
        Mora :=  VpfTabela.fieldByName('N_PER_MOR').AsCurrency;
        Juro := VpfTabela.fieldByName('N_PER_JUR').AsCurrency;
        Multa := VpfTabela.fieldByName('N_PER_MUL').AsCurrency;
        ChequePre := VpfTabela.fieldByName('I_CHE_PRE').AsInteger;
        QtdDiasProtesto := VpfTabela.fieldByName('I_DIA_PTS').AsInteger;
        ValorTolerancia := VpfTabela.fieldByName('VAL_TOLERANCIA').AsFloat;
        OperacaoPagar := VpfTabela.fieldByName('COD_OPERACAO_PADRAO_PAGAR').AsInteger;
        OperacaoReceber := VpfTabela.fieldByName('COD_OPERACAO_PADRAO_RECEBER').AsInteger;
        CondPagtoVista := VpfTabela.fieldByName('I_COD_PAG').AsInteger;
        SenhaCaixa := Descriptografa(VpfTabela.fieldByName('C_SEN_CAI').Asstring);
        FormaPagamentoPadrao := VpfTabela.fieldByName('I_FRM_PAD').AsInteger;
        FormaPagamentoCarteira := VpfTabela.fieldByName('I_FRM_CAR').AsInteger;
        FormaPagamentoBoleto := VpfTabela.fieldByName('I_FRM_BOL').AsInteger;
        FormaPagamentoDinheiro := VpfTabela.fieldByName('I_FRM_DIN').AsInteger;
        FormaPagamentoDeposito := VpfTabela.fieldByName('I_FRM_DEP').AsInteger;
        FormaPagamentoCreditoCliente := VpfTabela.fieldByName('I_FRM_CRE').AsInteger;
        ClienteFornecedorbancario := VpfTabela.fieldByName('I_CLI_BAN').AsInteger;
        DocReciboPadrao := VpfTabela.fieldByName('I_REC_PAD').AsInteger;
        if LENGTH(VpfTabela.fieldByName('C_CON_GER').AsString) > 0 then
          ConsultaPor := VpfTabela.fieldByName('C_CON_GER').AsString[1]
        else
          ConsultaPor := 'O'; // N�mero de Ordem.
        FilialControladora := VpfTabela.fieldByName('I_FIL_CON').AsInteger;
        CodHistoricoNaoLigado := VpfTabela.fieldByName('I_HIS_NLI').AsInteger;
        RodapeECobranca := VpfTabela.fieldByName('C_ROD_ECO').AsString;
        emailECobranca := VpfTabela.fieldByName('C_EMA_ECO').AsString;
        TipComissao := VpfTabela.fieldByName('I_TIP_COM').AsInteger;
        case VpfTabela.FieldByName('I_TIP_VCO').AsInteger of
          0 : TipoValorComissao := vcTotalNota;
          1 : TipoValorComissao := vcTotalProdutos;
        end;
      end;
      with Config do   // boolean
      begin
        CapaLote := TipoCheck(VpfTabela.fieldByName('C_CAP_LOT').AsString);
        BaixaMovBancario :=TipoCheck(VpfTabela.fieldByName('C_BAI_CHE').AsString);
        BaixaCPCadastro :=TipoCheck(VpfTabela.fieldByName('C_BAI_COP').AsString);
        BaixaCRCadastro :=TipoCheck(VpfTabela.fieldByName('C_BAI_COR').AsString);
        DataVencimentoMenor := TipoCheck(VpfTabela.fieldByName('C_DAT_VEN').AsString);
        DataBaixaMenor := TipoCheck(VpfTabela.fieldByName('C_DAT_BAI').AsString);
        BaixaParcelaAntVazia := TipoCheck(VpfTabela.fieldByName('C_PAR_ANT').AsString);
        JurosMultaDoDia := TipoCheck(VpfTabela.fieldByName('C_JUR_ATU').AsString);
        ComissaoDireta := TipoCheck(VpfTabela.fieldByName('C_COM_DIR').AsString);
        NumeroDuplicata := TipoCheck(VpfTabela.fieldByName('C_NRO_DUP').AsString);
        NumeroDocumento := TipoCheck(VpfTabela.fieldByName('C_NRO_DOC').AsString);
        PermitirParcial := TipoCheck(VpfTabela.fieldByName('C_PER_PAR').AsString);
        GerarDespesasFixa := TipoCheck(VpfTabela.fieldByName('C_DES_FIX').AsString);

        AvisaIndMoeda := TipoCheck(VpfTabela.fieldByName('C_Ind_Moe').AsString);
        AvisaDataAtualInvalida := TipoCheck(VpfTabela.fieldByName('C_Dat_Inv').AsString);

        VariosCaixasDia := TipoCheck(VpfTabela.fieldByName('FLA_VARIOS_GERAIS').AsString);
        LogDireto := TipoCheck(VpfTabela.fieldByName('FLA_LOG_DIRETO').AsString);
        SenhaAlteracao := TipoCheck(VpfTabela.fieldByName('C_SEN_ALT').AsString);
        SenhaEstorno := TipoCheck(VpfTabela.fieldByName('C_SEN_EST').AsString);
        ParcialCaixaDataAnterior := TipoCheck(VpfTabela.fieldByName('C_PAR_DAT').AsString);
        itemCaixaDataAnterior := TipoCheck(VpfTabela.fieldByName('C_ITE_DAT').AsString);
        AtualizarDespesas := TipoCheck(VpfTabela.fieldByName('C_FLA_ATD').AsString);
        ConfirmaBancario := TipoCheck(VpfTabela.fieldByName('C_FLA_BAN').AsString);
        FilialControladora := TipoCheck(VpfTabela.fieldByName('C_FIL_CON').AsString);
        LimiteCreditoCliente := TipoCheck(VpfTabela.fieldByName('C_LIM_CRE').AsString);
        BloquearClienteEmAtraso := TipoCheck(VpfTabela.fieldByName('C_BLO_CAT').AsString);
        QuandoFaturarAdicionarnaRemessa := TipoCheck(VpfTabela.fieldByName('C_REM_AUT').AsString);
        ECobrancaEnviarAvisoProgramacaoPagamento := TipoCheck(VpfTabela.fieldByName('C_ECO_AVP').AsString);
        ECobrancaEnviarAvisoPagamentoAtrasado := TipoCheck(VpfTabela.fieldByName('C_ECO_APE').AsString);
        ECobrancaEnviarValoresCorrigidos := TipoCheck(VpfTabela.fieldByName('C_ECO_VAC').AsString);
        if VpfTabela.FieldByName('C_TIP_BOL').AsString = 'B' Then
          ImprimirBoletoFolhaBranco := true
        else
          ImprimirBoletoFolhaBranco := false;
        SalvarDataUltimaBaixaCR := TipoCheck(VpfTabela.fieldByName('C_SAL_DAB').AsString);
        BaixaContasReceberCalcularJuros:= TipoCheck(VpfTabela.fieldByName('C_JUR_AUT').AsString);
        AdicionarRemessaAoImprimirBoleto:= TipoCheck(VpfTabela.fieldByName('C_IMB_AAR').AsString);
        EmailCobrancaPelaDataCobranca := TipoCheck(VpfTabela.fieldByName('C_EMA_DCO').AsString);
        ControlarProjeto := TipoCheck(VpfTabela.fieldByName('C_CON_PRO').AsString);
      end;
    end;

    //--------------------fiscal-------------------------------------
    AdicionaSQLAbreTabela(VpfTabela, 'select * from cfg_fiscal');
    if not VpfTabela.Eof then
    begin
      with Varia do
      begin
        EstadoPadrao := VpfTabela.fieldByName('C_EST_ICM').AsString;
        TextoPromocional := TStringList.create;
        TextoPromocional.Add(VpfTabela.fieldByName('L_TEX_PRO').AsString);
        CodigoOpeEstEcf := VpfTabela.fieldByName('C_OPE_ECF').AsInteger;
        PlanoContaEcf := VpfTabela.fieldByName('C_PLA_ECF').AsString;
        DescontoMaximoNota := VpfTabela.fieldByName('N_DES_NOT').AsFloat;
        NaturezaNota := VpfTabela.fieldByName('C_Cod_Nat').AsString;
        NaturezaForaEstado := VpfTabela.fieldByName('C_NAT_FOE').AsString;
        FretePadraoNF := VpfTabela.fieldByName('I_FRE_NOT').AsInteger;
        TipoComissaoProduto := VpfTabela.fieldByName('I_COM_PRO').AsInteger;
        TipoComissaoServico := VpfTabela.fieldByName('I_COM_SER').AsInteger;
        MaiorDescontoPermitido := VpfTabela.fieldByName('I_DES_MAI').AsInteger;
        SenhaLiberacao := Descriptografa(VpfTabela.fieldByName('C_Sen_Lib').AsString);
        BoletoPadraoNota := VpfTabela.fieldByName('I_BOL_PAD').AsInteger;
        NaturezaDevolucaoCupom := VpfTabela.fieldByName('C_NAT_DEV').AsString;
        NaturezaDevolucaoNotaFiscal := VpfTabela.fieldByName('C_NAT_NOT').AsString;
        NaturezaNotaFiscalCupom := VpfTabela.fieldByName('C_NOT_CUP').AsString;
        NaturezaServico := VpfTabela.fieldByName('C_NAT_SER').AsString;
        NaturezaServicoEProduto := VpfTabela.fieldByName('C_NAT_PSE').AsString;
        NaturezaServicoForaEstado := VpfTabela.fieldByName('C_NAT_FSE').AsString;
        NaturezaServicoEProdutoForaEstado := VpfTabela.fieldByName('C_NAT_PSF').AsString;
        LayoutECF := VpfTabela.fieldByName('I_LAY_ECF').AsInteger;
        TamanhoFonteECF := VpfTabela.fieldByName('I_FON_ECF').AsInteger;
        PerPIS := VpfTabela.FieldByname('N_PER_PIS').AsFloat;
        PerCOFINS := VpfTabela.FieldByname('N_PER_COF').AsFloat;
        PlacaVeiculoNota := VpfTabela.FieldByname('C_PLA_VEI').AsString;
        MarcaEmbalagem := VpfTabela.FieldByName('C_MAR_PRO').AsString;
        CodTransportadora :=  VpfTabela.FieldByName('I_COD_TRA').AsInteger;
        ContaContabilFornecedor := VpfTabela.FieldByName('I_CCO_FOR').AsInteger;
        ContaContabilCliente := VpfTabela.FieldByName('I_CCO_CLI').AsInteger;
        CodClienteExportacaoFiscal := VpfTabela.FieldByName('I_CLI_EXP').AsInteger;
        DocPadraoPedido :=  VpfTabela.FieldByName('I_PED_PAD').AsInteger;
        case VpfTabela.FieldByName('I_FOR_EXP').AsInteger of
          0 :  FormatoExportacaoFiscal := feLince;
          1 :  FormatoExportacaoFiscal := feWKLiscalforDos;
          2 :  FormatoExportacaoFiscal := feSantaCatarina;
          3 :  FormatoExportacaoFiscal := feSintegra;
          4 :  FormatoExportacaoFiscal := feMTFiscal;
          5 :  FormatoExportacaoFiscal :=  feWKRadar;
          6 :  FormatoExportacaoFiscal :=  feValidaPR;
          7 :  FormatoExportacaoFiscal :=  feDominioSistemas;
        end;
        ValMinimoFaturamentoAutomatico := VpfTabela.FieldByname('N_VAL_MFA').AsFloat;
        TextoReducaoICMSCliente := VpfTabela.FieldByName('C_TEX_RIC').AsString;
      end;

      with Config do   // boolean
      begin
        AlterarValorUnitarioNota := TipoCheck(VpfTabela.fieldByName('C_ALT_VLR').AsString);
        DescontoNota := TipoCheck(VpfTabela.fieldByName('C_DES_NOT').AsString);
        AlterarValorUnitarioComSenha := TipoCheck(VpfTabela.fieldByName('C_SEN_ALT').AsString);
        AlterarDescontoComSenha := TipoCheck(VpfTabela.fieldByName('C_SEN_DES').AsString);
        UsaTEF := TipoCheck(VpfTabela.fieldByName('C_USA_TEF').AsString);
        MostraDadosClienteCupom := TipoCheck(VpfTabela.fieldByName('C_CLI_CUP').AsString);
        AlterarNroNF := TipoCheck(VpfTabela.fieldByName('C_NRO_NOT').AsString);
        AlterarValorNotaCR := TipoCheck(VpfTabela.fieldByName('C_ALT_VNF').AsString);
        ItemNFSaidaDuplicado := TipoCheck(VpfTabela.fieldByName('C_DUP_PNF').AsString);
        ImprimirPedEmPreImp := TipoCheck(VpfTabela.fieldByName('C_PED_PRE').AsString);
        UtilizarTransPedido := TipoCheck(VpfTabela.fieldByName('C_TRA_PED').AsString);
        NotaFiscalPorFilial := TipoCheck(VpfTabela.fieldByName('C_NNF_FIL').AsString);
        MostrarNotasDevolvidasnaVenda := TipoCheck(VpfTabela.fieldByName('C_VER_DEV').AsString);
        NaoCopiarObservacaoPedidoNotaFiscal := TipoCheck(VpfTabela.fieldByName('C_OBS_PED').AsString);
        ImprimirNumeroCotacaonaNotaFiscal := TipoCheck(VpfTabela.fieldByName('C_IMP_NOR').AsString);
        NaNotaFazerMediaValProdutosDuplicados := TipoCheck(VpfTabela.fieldByName('C_MED_PRO').AsString);
        ImprimirnaNotaDescricaoItemNatureza := TipoCheck(VpfTabela.fieldByName('C_INF_INO').AsString);
        QtdVolumeObrigatorio := TipoCheck(VpfTabela.fieldByName('C_VOL_OBR').AsString);
        CancelarNotaCancelarBaixaCotacao := TipoCheck(VpfTabela.fieldByName('C_CNF_ESC').AsString);
        MostrarEnderecoCobrancanaNota := TipoCheck(VpfTabela.fieldByName('C_NOT_IEC').AsString);
        QuandoForQuartodeNotanoRomaneioFazeroValorFaltante := TipoCheck(VpfTabela.fieldByName('C_COM_ROM').AsString);
      end;
    end;

    AdicionaSQLAbreTabela(VpfTabela, 'select * from CFG_ECF ');
    if not VpfTabela.Eof then
    begin
      with varia do
      begin
        case VpfTabela.FieldByName('NUMTIPOECF').AsInteger of
          0 : TipoECF := ifBematech_FI_2;
          1 : TipoECF := ifDaruamFS600;
        end;
        ClientePadraoECF := VpfTabela.fieldByName('CODCLIENTEPADRAO').AsInteger;
        CodPlanoContasECF := VpfTabela.fieldByName('CODPLANOCONTAS').AsString;
        CodOperacaoEstoqueECF := VpfTabela.fieldByName('CODOPERACAOESTOQUE').AsInteger;
        CodCondicaoPagamentoECF := VpfTabela.fieldByName('CODCONDICAOPAGAMENTO').AsInteger;
      end;
      with config do
      begin
        GerarFinanceiroECF := TipoCheck(VpfTabela.fieldByName('INDGERAFINANCEIRO').AsString);
        BaixarEstoqueECF := TipoCheck(VpfTabela.fieldByName('INDBAIXAESTOQUE').AsString);
        MostrarFormaPagamentoECFGeradoPelaCotacao := TipoCheck(VpfTabela.fieldByName('INDFORMAPAGAMENTOCOTACAO').AsString);
        UtilizarGaveta := TipoCheck(VpfTabela.fieldByName('INDUTILIZAGAVETA').AsString);
        PassarDescontodaCotacao := TipoCheck(VpfTabela.fieldByName('INDDESCONTOCOTACAO').AsString);
      end;
    end;

    AdicionaSQLAbreTabela(VpfTabela, 'select * from cfg_modulo');
    if not VpfTabela.Eof then
    begin
      with ConfigModulos do   // boolean
        begin
          Bancario := TipoCheck(VpfTabela.fieldByName('FLA_BANCARIO').AsString);
          Caixa := TipoCheck(VpfTabela.fieldByName('FLA_CAIXA').AsString);
          Comissao := TipoCheck(VpfTabela.fieldByName('FLA_COMISSAO').AsString);
          ContasAPagar := TipoCheck(VpfTabela.fieldByName('FLA_CONTA_PAGAR').AsString);
          ContasAReceber := TipoCheck(VpfTabela.fieldByName('FLA_CONTA_RECEBER').AsString);
          Faturamento := TipoCheck(VpfTabela.fieldByName('FLA_FATURAMENTO').AsString);
          Fluxo := TipoCheck(VpfTabela.fieldByName('FLA_FLUXO').AsString);
          Custo := TipoCheck(VpfTabela.fieldByName('FLA_CUSTO').AsString);
          Produto := TipoCheck(VpfTabela.fieldByName('FLA_PRODUTO').AsString);
          Estoque := TipoCheck(VpfTabela.fieldByName('FLA_ESTOQUE').AsString);

          Servico := TipoCheck(VpfTabela.fieldByName('FLA_SERVICO').AsString);
          NotaFiscal := TipoCheck(VpfTabela.fieldByName('FLA_NOTA_FISCAL').AsString);
          TEF := TipoCheck(VpfTabela.fieldByName('FLA_TEF').AsString);
          ECF := TipoCheck(VpfTabela.fieldByName('FLA_ECF').AsString);
          CodigoBarra := TipoCheck(VpfTabela.fieldByName('FLA_CODIGOBARRA').AsString);
          Gaveta := TipoCheck(VpfTabela.fieldByName('FLA_GAVETA').AsString);
          ImpDocumentoS := TipoCheck(VpfTabela.fieldByName('FLA_IMPDOCUMENTOS').AsString);
          OrcamentoVenda := TipoCheck(VpfTabela.fieldByName('FLA_ORCAMENTOVENDA').AsString);
          Imp_Exp := TipoCheck(VpfTabela.fieldByName('FLA_IMP_EXP').AsString);
          SenhaGrupo := TipoCheck(VpfTabela.fieldByName('FLA_SENHAGRUPO').AsString);
          MalaDiretaCliente := TipoCheck(VpfTabela.fieldByName('FLA_MALACLIENTE').AsString);
          AgendaHistoricoCliente := TipoCheck(VpfTabela.fieldByName('FLA_AGENDACLIENTE').AsString);
          PedidoVenda := TipoCheck(VpfTabela.fieldByName('FLA_PEDIDO').AsString);
          OrdemServico := TipoCheck(VpfTabela.fieldByName('FLA_ORDEMSERVICO').AsString);
          TeleMarketing := TipoCheck(VpfTabela.fieldByName('FLA_TELEMARKETING').AsString);
          Faccionista := TipoCheck(VpfTabela.fieldByName('FLA_FACCIONISTA').AsString);
          Amostra := TipoCheck(VpfTabela.fieldByName('FLA_AMOSTRA').AsString);
          OrdemProducao := TipoCheck(VpfTabela.fieldByName('FLA_ORDEMPRODUCAO').AsString);
        end;
   end;
  //desativado em 19/04/2006 por nenhum cliente estar utilizando.
{  if config.CodigoBarras then
   varia.CodigoProduto := 'C_COD_BAR'
  else
   varia.CodigoProduto := 'C_COD_PRO';}
  varia.CodigoProduto := 'C_COD_PRO';

  CarregaDiretorios;
  Varia.CodigosVendedores :=  Varia.RCodigosVendedores(Varia.CodigoUsuario);
  varia.CodigosCondicaoPagamento := varia.RCodigosCondicaoPagamento(varia.GrupoUsuario);

  if varia.TipoBase = 0 then
  begin
    LimpaSQLTabela(VpfTabela); // soma dia na base de demonstracao
    AdicionaSQLTabela(VpfTabela, ' update cfg_geral ' +
                              ' set I_DIA_VAL = ' + IntToStr(varia.DiaValBase-1) );
    VpfTabela.ExecSQL;
  end;
  VpfTabela.Close;
  VpfTabela.free;
  Varia.CarPermissaoUsuario(Varia.PermissoesUsuario,IntToStr(Varia.CodigoEmpFil),Inttostr(Varia.GrupoUsuario));
end;

{D5 VERIFICAR SE ESSA ROTINA � UTILIZADA
******************************************************************************
function RCodBancoConta(VpaContaCorrente : String) : Integer;
var
  VpfTabela : TQuery;
begin
  VpfTabela := TQuery.Create(nil);
  VpfTabela.DataBaseName := 'BaseDados';
  AdicionaSQlAbreTabela(vpfTabela,'Select * from CADCONTAS '+
                          ' Where C_NRO_CON = '''+VpaContaCorrente+ '''');
  result := VpfTabela.FieldByName('I_COD_BAN').AsInteger;
  VpfTabela.free;
end;}
end.
