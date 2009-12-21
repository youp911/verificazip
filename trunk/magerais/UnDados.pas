unit UnDados;

interface
Uses Classes, UnDadosCR, SysUtils;


Type
  TRBDFilial = class
    public
      CodFilial,
      CodIBGEMunicipio,
      CodAtividadeSpedFiscal,
      CodContabilidade,
      NumEndereco : Integer;
      NomFilial,
      NomFantasia,
      DesSite,
      DesEmail,
      DesEmailComercial,
      DesEndereco,
      DesEnderecoSemNumero,
      DesBairro,
      DesCidade,
      DesUF,
      DesCep,
      DesFone,
      DesFax,
      DesCNPJ,
      DesCPFContador,
      DesCRCContador,
      NomContador,
      DesInscricaoEstadual,
      DesInscricaoMunicipal,
      DesPerfilSpedFiscal,
      DesCabecalhoEmailProposta,
      DesMeioEmailProposta,
      DesRodapeEmailProposta : String;
      IndEmiteNFE : Boolean;
      constructor cria;
      destructor destroy;override;
end;


Type
  TRBDDigitacaoProspectItem = class
    public
      CodProspect,
      CodRamoAtividade : Integer;
      NomProspect,
      NomContato,
      NomRamoAtividade,
      DesTipo,
      DesEndereco,
      DesBairro,
      DesCidade,
      DesUF,
      DesFone,
      DesEmail,
      DesHistorico : String;
      DatVisita : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDDigitacaoProspect = class
    public
      CodVendedor : Integer;
      Prospects : TList;
      constructor cria;
      destructor destroy;override;
      function AddProspectItem : TRBDDigitacaoProspectItem;
end;

Type
  TRBDEmailMarketing = class
    public
      SeqEmail : Integer;
      DesEmail,
      DesSenha : String;
      HorUltimoenvio : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDCreditoCliente = class
    public
      CodCliente,
      SeqCredito : Integer;
      ValInicial,
      ValCredito : Double;
      DatCredito : TDateTime;
      TipCredito,
      DesObservacao : String;
      IndFinalizado : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDProdutoInteresseCliente = class
    public
      CodCliente,
      SeqProduto : Integer;
      CodProduto,
      NomProduto : String;
      QtdProduto : Double;
      Constructor cria;
      destructor destroy;override;
end;

Type
  TRBDClientePerdidoVendedor = class
    public
      SeqPerdido,
      CodVendedorDestino,
      CodUsuario,
      QtdDiasSemPedido,
      QtdDiasComPedido,
      CodRegiaoVendas   : Integer;
      DatPerdido : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDAgendaCliente = class
    public
      CodCliente,
      SeqVisita,
      CodTipoAgendamento,
      CodUsuario,
      CodVendedor: Integer;
      DatCadastro,
      DatVisita,
      DatFimVisita: TDateTime;
      IndRealizado,
      DesAgenda,
      DesRealizado: String;
      constructor Cria;
      destructor destroy; override;
end;

Type
  TRBDComprador = class
    public
      CodComprador : Integer;
      NomComprador,
      DesEmail : String;
      constructor cria;
      destructor destroy;override;
end;


type
  TRBDLembreteItem = class
    public
      IndMarcado: Boolean;
      CodUsuario,
      QtdVisualizacao: Integer;
      IndLido,
      NomUsuario: String;
      constructor Cria(VpaMarcado: Boolean);
      destructor Destroy; override;
end;

type
  TRBDLembreteCorpo = class
    public
      SeqLembrete,
      CodUsuario: Integer;
      DatLembrete,
      DatAgenda: TDateTime;
      IndAgendar,
      IndTodos,
      DesTitulo,
      DesLembrete: String;
      Usuarios: TList;
      constructor Cria;
      destructor Destroy; override;
      function AddUsuario: TRBDLembreteItem;
end;

type
  TRBDProdutoPendenteCompra = class
    public
      IndMarcado,
      IndAlterado : Boolean;
      SeqProduto,
      CodCor,
      SeqPedidoGerado: Integer;
      CodClassificacao,
      CodProduto,
      NomProduto,
      NomCor,
      DesTecnica,
      DesUM: String;
      QtdUtilizada,
      QtdAprovada,
      QtdComprada: Double;
      DatAprovacao : TDateTime;
      OrcamentosCompra : TList;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDChamadoParcial = class
    public
      CodFilial,
      NumChamado,
      SeqParcial,
      CodTecnico,
      CodUsuario : Integer;
      IndRetorno : Boolean;
      DatParcial : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDChamadoServicoOrcado = class
    public
      SeqItemOrcado,
      CodEmpresaServico,
      CodServico: Integer;
      QtdServico,
      ValUnitario,
      ValTotal: Double;
      IndAprovado: Boolean;
      NomServico: String;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDChamadoProdutoOrcado = class
    public
      SeqItemOrcado,
      SeqProduto: Integer;
      Quantidade,
      ValUnitario,
      ValTotal: Double;
      CodProduto,
      DesUM,
      NomProduto: String;
      IndAprovado: Boolean;
      UnidadesParentes: TStringList;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDChamadoServicoExecutado = class
    public
      CodServico,
      CodEmpresaServico,
      SeqItemExecutado: Integer;
      NomServico: String;
      Quantidade,
      ValUnitario,
      ValTotal: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDComissaoClassificacaoVendedor = class
    public
      CodEmpresa,
      CodVendedor: Integer;
      TipClassificacao,
      CodClassificacao,
      NomVendedor: String;
      PerComissao: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaServico = class
    public
      SeqItem,
      CodEmpresaServico,
      CodServico: Integer;
      NomServico: String;
      QtdServico,
      ValUnitario,
      ValTotal: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaLocacaoFranquia = class
    public
      SeqItem,
      SeqItemFranquia,
      QtdFranquiaPB,
      QtdFranquiaColor: Integer;
      ValFranquia,
      ValExcedentePB,
      ValExcedenteColor: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaLocacaoCorpo = class
    public
      CodFilial,
      SeqProposta,
      SeqItem,
      SeqProduto: Integer;
      CodProduto,
      NomProduto,
      DesEmail: String;
      Franquias: TList;
      constructor Cria;
      destructor Destroy; override;
      function AddFranquia: TRBDPropostaLocacaoFranquia;
end;

type
  TRBDUsuarioVendedor = class
    public
      CodVendedor: Integer;
      NomVendedor: String;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDSolicitacaoCompraFracaoOP = class
    public
      CodFilialFracao,
      SeqOrdem,
      SeqFracao: Integer;
      NomCliente: String;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDSolicitacaoCompraItem = class
    public
      SeqItem,
      SeqProduto,
      CodCor: Integer;
      CodClassificacao,
      CodProduto,
      NomProduto,
      DesTecnica,
      NomCor,
      DesUM,
      UMOriginal: String;
      IndComprado: Boolean;
      UnidadesParentes: TStringList;
      QtdProduto,
      QtdAprovado,
      QtdComprado : Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDSolicitacaoCompraCorpo = class
    public
      CodFilial,
      SeqSolicitacao,
      CodUsuario,
      CodUsuarioAprovacao,
      CodEstagio,
      CodComprador: Integer;
      DesSituacao,
      IndCancelado,
      DesObservacao: String;
      DatEmissao,
      HorEmissao,
      DatPrevista,
      DatFim,
      DatAprovacao: TDateTime;
      Produtos,
      Fracoes: TList;
      constructor Cria;
      destructor Destroy; override;
      function AddProduto: TRBDSolicitacaoCompraItem;
      function AddFracaoOP: TRBDSolicitacaoCompraFracaoOP;
end;

Type
  TRBDTarefaEMarketingProspect = class
    public
      SeqTarefa,
      QtdEmail : Integer;
      DesAssuntoEmail,
      DesLinkInternet,
      NomArquivoAnexo : String;
      constructor cria;
      destructor destroy; override;
end;

Type
  TRBDTarefaEMarketing = class
    public
      SeqTarefa,
      QtdEmail : Integer;
      DesAssuntoEmail,
      DesLinkInternet,
      NomArquivoAnexo : String;
      constructor cria;
      destructor destroy; override;
end;

type
  TRBDFracaoOPPedidoCompra = class
    public
      CodFilialFracao,
      SeqOrdem,
      SeqFracao: Integer;
      NomCliente: String;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDProdutoPedidoCompra = class
    public
      CodFilial,
      SeqPedido,
      SeqItem,
      SeqProduto,
      CodCor,
      CodTamanho : Integer;
      CodProduto,
      NomProduto,
      DesTecnica,
      NomCor,
      NomTamanho,
      DesUM,
      DesReferenciaFornecedor: String;
      UnidadesParentes: TStringList;
      QtdProduto,
      QtdBaixado,
      ValUnitario,
      ValTotal,
      QtdSolicitada,
      PerIPI : Double;
      DatAprovacao : TDateTime;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPedidoCompraCorpo = class
    public
      CodFilial,
      CodFilialFaturamento,
      SeqPedido,
      CodCliente,
      CodUsuario,
      CodComprador,
      CodUsuarioAprovacao,
      NumDiasAtraso,
      CodCondicaoPagto,
      CodFormaPagto,
      CodTransportadora,
      CodEstagio,
      TipFrete: Integer;
      DesSituacao,
      IndCancelado,
      NomContato,
      DesEmailComprador,
      DesTelefone,
      DesObservacao: String;
      ValTotal,
      ValProdutos,
      ValIPI,
      PerDesconto,
      ValDesconto,
      ValFrete: Double;
      DatPedido,
      HorPedido,
      DatPrevista,
      DatPrevistaInicial,
      DatRenegociado,
      DatRenegociadoInicial,
      DatAprovacao,
      DatEntrega,
      DatPagamentoAntecipado: TDateTime;
      Produtos,
      FracaoOP: TList;
      constructor Cria;
      function AddProduto: TRBDProdutoPedidoCompra;
      function AddFracaoOP: TRBDFracaoOPPedidoCompra;
      destructor Destroy; override;
end;

type
  TRBDTelemarketingProspect = class
    public
      CodProspect,
      SeqTele,
      CodUsuario,
      CodFilial,
      SeqProposta,
      CodHistorico,
      QtdSegundosLigacao: Integer;
      DataTempoLigacao: Double;
      DesFaladoCom,
      DesObservacao: String;
      IndAtendeu: Boolean;
      DatLigacao: TDateTime;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDContatoProspect = class
    public
      CodProspect,
      SeqContato,
      CodProfissao,
      CodUsuario,
      QtdVezesEmailInvalido : Integer;
      NomContato,
      NomProfissao,
      FonContato,
      CelContato,
      EmailContato,
      DesObservacoes,
      AceitaEMarketing: String;
      DatNascimento,
      DatCadastro: TDateTime;
      IndExportadoEficacia,
      IndEmailInvalido : Boolean;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDPropostaAmostra = class
    public
      SeqItem,
      CodCor,
      CodAmostra,
      CodAmostraIndefinida : Integer;
      NomCor,
      NomAmostra,
      DesImagem : String;
      QtdAmostra,
      ValUnitario,
      ValTotal: Double;
      constructor Cria;
      destructor Destroy; override;
end;

type
  TRBDProdutoProspect = class
    public
      SeqProduto,
      CodProspect,
      SeqItem,
      CodDono,
      QtdCopias: Integer;
      CodProduto,
      NomProduto,
      NomDono,
      DesSetor,
      NumSerie,
      NumSerieInterno,
      DesUM,
      DesObservacao: String;
      QtdProduto,
      ValConcorrente: Double;
      DatGarantia,
      DatUltimaAlteracao: TDateTime;
      UnidadeParentes: TStringList;
      constructor Cria;
      Destructor Destroy; override;
end;




  TDadosBaixaCP = Class
    public
      CodFilial,
      LancamentoCP,
      NroParcela,
      NumParcelaParcial,
      CodUsuario,
      CodMoedaAtual,
      CodFormaPAgamento  : integer;
      DataVencimento,
      DataPagamento,
      DataVencimentoParcial   : TDateTime;
      ValorDesconto,
      valorAcrescimo,
      ValorPago,
      ValorTotalAserPago : Double;
      NumContaCaixa,
      Observacao,
      TipoFrmPagto,
      PlanoConta,
      FlagDespesaFixa       : String; // S/N
      IndGerouParcial : Boolean;
      Cheques : TList;
      Constructor cria;
      destructor destroy;override;
      function AddCheque : TRBDCheque;
  end;


Type
  TRBDAgendaProspect = class
    public
      CodProspect,
      SeqVisita,
      CodTipoAgendamento,
      CodUsuario,
      CodVendedor: Integer;
      DatCadastro,
      DatVisita,
      DatFimVisita: TDateTime;
      IndRealizado: Char;
      DesAgenda,
      DesRealizado: String;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDContatoCliente = class
    public
      DatNascimento: TDateTime;
      NomContato,
      DesTelefone,
      DesCelular,
      DesEMail,
      NomProfissao,
      DesObservacao,
      AceitaEMarketing: String;
      CodProfissao,
      CodUsuario,
      QtdVezesEmailInvalido: Integer;
      IndExportadoEficacia,
      IndEmailInvalido : Boolean;
      constructor cria;
      destructor destroy; override;
end;


type
  TRBDProspect = class
    public
      CodProspect,
      CodProfissao,
      CodVendedor,
      CodCliente,
      CodRamoAtividade,
      CodConcorrente,
      NumEndereco,
      QtdLigacaoSemProposta,
      QtdLigacaoComProposta: Integer;
      NomProspect,
      NomContato,
      NomFantasia,
      DesEmail,
      DesEmailContato,
      DesEnderecoCompleto,
      DesEndereco,
      DesComplementoEndereco,
      DesBairro,
      DesCep,
      DesCidade,
      DesUF,
      DesCNPJ,
      DesCPF,
      DESInscricaoEstadual,
      DesRG,
      DesTipoPessoa,
      DesFone,
      DesFax,
      DesFone1,
      DesFone2,
      DesObservacaoTelemarketing,
      DesObservacoes: String;
      IndAceitaTeleMarketing,
      IndAceitaSpam: Boolean;
      DatUltimaLigacao,
      DatNascimento: TDateTime;
      constructor cria;
      destructor destroy; override;
end;

Type
  TRBDPropostaProdutoASerRotulado = class
    public
      SeqItem,
      SeqProduto,
      CodFormatoFrasco,
      CodMaterialFrasco,
      AltFrasco,
      LarFrasco,
      ProfundidadeFrasco,
      DiametroFrasco,
      LarRotulo,
      LarContraRotulo,
      LarGargantilha,
      AltRotulo,
      AltContraRotulo,
      AltGargantilha,
      CodMaterialRotulo,
      CodLinerRotulo,
      CodMaterialContraRotulo,
      CodLinerContraRotulo,
      CodMaterialGargantilha,
      CodLinerGargantilha : Integer;
      CodProduto,
      NomProduto,
      NomFormatoFrasco,
      NomMaterialFrasco,
      NomMaterialRotulo,
      NomLinerRotulo,
      NomMaterialContraRotulo,
      NomLinerContraRotulo,
      NomMaterialGargantilha,
      NomLinerGargantilha : String;
      QtdFrascosHora : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDPropostaProdutoSemQtd = class
    public
      SeqItem,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesUM : String;
      ValUnitario : Double;
      UnidadesParentes : TStringList;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDPropostaVendaAdicional = class
    public
      SeqProduto,
      CodCor : Integer;
      CodProduto,
      NomProduto,
      NomCor,
      DesUM,
      UMAnterior,
      UMOriginal : String;
      QtdProduto,
      ValUnitario,
      ValUnitarioOriginal,
      ValTotal : Double;
      UnidadesParentes : TStringList;
      constructor cria;
      destructor destroy;
end;

Type
  TRBDPropostaProduto = class
    public
      SeqMovimento,
      SeqProduto,
      CodCor,
      NumOpcao: Integer;
      CodProduto,
      NomProduto,
      DesCor,
      UM,
      UMAnterior,
      UMOriginal,
      PathFoto,
      CodReduzido,
      DesTecnica :String;
      QtdProduto,
      QtdEstoque,
      ValUnitario,
      ValUnitarioOriginal,
      ValTotal,
      ValDesconto : Double;
      UnidadeParentes : TStringList;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDPropostaCorpo = class
    public
      CodFilial,
      SeqProposta,
      CodSetor,
      CodProspect,
      CodCliente,
      CodCondicaoPagamento,
      CodFormaPagamento,
      LanOrcamento,
      CodConcorrente,
      CodMotivoVenda,
      CodProfissao,
      CodVendedor,
      CodUsuario,
      CodEstagio,
      CodTipoProposta,
      SeqProdutoInteresse,
      QtdPrazoEntrega,
      TipFrete,
      TipModeloProposta : Integer;
      NomContato,
      NomSetor,
      DesEmail,
      DesEmailSetor,
      DesObservacao,
      DesRodapeSetor : String;
      IndComprou,
      IndComprouConcorrente,
      IndDevolveraVazio : Boolean;
      PerDesconto,
      ValDesconto,
      ValConcorrente,
      ValTotal : Double;
      DatProposta,
      DatValidade,
      DatPrevisaoCompra : TDatetime;
      Produtos,
      ProdutosSemQtd,
      ProdutosASeremRotulados,
      Amostras,
      Locacoes,
      Servicos,
      VendaAdicinal : TList;
      constructor cria;
      destructor destroy;override;
      function addProduto : TRBDPropostaProduto;
      function addProdutoSemQtd : TRBDPropostaProdutoSemQtd;
      function addAmostra : TRBDPropostaAmostra;
      function AddLocacao: TRBDPropostaLocacaoCorpo;
      function AddServico: TRBDPropostaServico;
      function addProdutoAseremRotulados : TRBDPropostaProdutoASerRotulado;
      function addVendaAdicional : TRBDPropostaVendaAdicional;
end;

Type
  TRBDCotacaoGrafica = class
    QtdCorFrente,
    QtdCorVerso,
    QtdCopias,
    Altura,
    Largura : Integer;
    ValAcerto,
    ValTotal : Double;
    constructor cria;
    destructor destroy; override; 
end;

Type
  TRBDPesquisaSatisfacaoItem = class
    SeqPergunta,
    NumBomRuim,
    NumNota : Integer;
    DesSimNao,
    DesTexto : String;
    constructor cria;
    destructor destroy;override;
end;

Type
  TRBDPesquisaSatisfacaoCorpo = Class
    public
      CodFilial,
      SeqPesquisa,
      CodPesquisa,
      CodUsuario,
      NumChamado,
      CodTecnico : Integer;
      DatPesquisa : TDateTime;
      Items : TList;
      constructor cria;
      destructor destroy;override;
      function AddPesquisaItem : TRBDPesquisaSatisfacaoItem;
end;

Type
  TRBDColunaAgenda = class
    NomCampo : String;
    TamCampo : Integer;
end;

Type
  TRBDChamadoProdutoTrocado = class
    public
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesUM,
      UMOriginal : String;
      QtdProduto,
      ValUnitario,
      ValTotal : Double;
      UnidadeParentes : TStringList;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDChamadoProdutoExtra = class
    public
      SeqItem,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      UM,
      UMOriginal : String;
      QtdProduto,
      QtdBaixado : Double;
      IndFaturado : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDChamadoProduto = Class
    public
      CodFilialChamado,
      SeqItem,
      SeqContrato,
      SeqItemContrato,
      SeqItemProdutoCliente,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesContrato,
      NumSerie,
      NumSerieInterno,
      DesSetor,
      DesProblema,
      DesServicoExecutado,
      DesUM,
      DesUMOriginal : String;
      NumContador : Integer;
      DatGarantia : TDateTime;
      QtdProduto,
      QtdBaixado,
      QtdABaixar : Double;
      UnidadeParentes : TStringList;
      ProdutosTrocados,
      ServicosExecutados,
      ProdutosOrcados,
      ServicosOrcados: TList;
      constructor cria;
      destructor destroy;override;
      function AddProdutoTrocado : TRBDChamadoProdutoTrocado;
      function AddServicoExecutado: TRBDChamadoServicoExecutado;
      function AddProdutoOrcado: TRBDChamadoProdutoOrcado;
      function AddServicoOrcado: TRBDChamadoServicoOrcado;
end;

Type
  TRBDChamado = class
    public
      CodFilial,
      NumChamado,
      NumChamadoAnterior,
      CodCliente,
      CodTecnico,
      CodTipoChamado,
      CodUsuario,
      CodEstagio,
      NumModeloEmail : Integer;
      NomSolicitante,
      NomContato,
      DesEmail,
      DesEnderecoAtendimento : String;
      DatChamado,
      DatPrevisao : TDateTime;
      ValChamado,
      ValDeslocamento : Double;
      IndGarantia,
      IndPesquisaSatisfacao : Boolean;
      Produtos,
      ProdutosExtras : TList;
      constructor cria;
      destructor destroy;override;
      function AddProdutoChamado : TRBDChamadoProduto;
      function AddProdutoExtra : TRBDChamadoProdutoExtra;
end;

Type
  TRBDAgenda = class
    public
      CodUsuario,
      CodUsuarioAnterior,
      SeqAgenda,
      CodCliente,
      CodTipoAgendamento,
      CodUsuarioAgendou,
      CodFilialCompra,
      SeqPedidoCompra : Integer;
      DesObservacoes : string;
      DatCadastro,
      DatInicio,
      DatFim,
      DatRealizado : TDatetime;
      IndRealizado,
      IndCancelado : boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDProdutoCliente = class
    public
      SeqProduto,
      SeqItem,
      CodDono,
      QtdCopias  : Integer;
      CodProduto,
      NomProduto,
      NumSerieProduto,
      NumSerieInterno,
      DesSetorEmpresa,
      NomDono,
      UM,
      UMOriginal,
      DesObservacoes : string;
      DatGarantia,
      DatUltimaAlteracao : TDatetime;
      UnidadeParentes : TStringList;
      ValConcorrente,
      QtdProduto : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDLeituraLocacaoItem = class
    public
      SeqItem,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      NumSerieProduto,
      NumSerieInterno,
      DesSetorEmpresa : String;
      QtdUltimaLeitura,
      QtdUltimaLeituraColor,
      QtdMedidorAtual,
      QtdMedidorAtualColor,
      QtdDefeitos,
      QtdDefeitosColor,
      QtdTotalCopias,
      QtdTotalCopiasColor  : Integer;
      DatUltimaLeitura : TDatetime;
      IndDesativar : Boolean;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDLeituraLocacaoCorpo = class
    public
      CodFilial,
      SeqLeitura,
      CodCliente,
      MesLocacao,
      AnoLocacao,
      SeqContrato,
      CodTecnicoLeitura,
      QtdCopias,
      QtdCopiasColor,
      QtdExcedente,
      QtdExcednteColor,
      QtdDefeitos,
      QtdDefeitosColor,
      LanOrcamento,
      CodUsuario,
      QtdFranquia,
      QtdFranquiaColor : Integer;
      DesObservacao :String;
      DatDigitacao,
      DatLeitura,
      DatProcessamento  : TDateTime;
      ValDesconto,
      ValTotal,
      ValTotalComDesconto,
      ValContrato,
      ValExcessoFranquia,
      ValExcessoFranquiaColor : Double;
      IndProcessamentoFrio : Boolean;
      ItensLeitura : TList;
      constructor cria;
      destructor destroy;override;
      function AddItemLeitura : TRBDLeituraLocacaoItem;
end;

Type
  TRBDBrindeCliente = class
    public
      SeqProduto,
      CodUsuario : Integer;
      CodProduto,
      NomProduto,
      NomUsuario,
      UM,
      UMOriginal : string;
      UnidadeParentes : TStringList;
      QtdProduto : Double;
      DatCadastro: TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDTelemarketingFaccionista = class
    public
      CodFaccionista,
      SeqTele,
      CodUsuario,
      CodHistorico,
      QtdSegundosLigacao : Integer;
      DesFaladoCom,
      DesObservacoes : String; 
      DatLigacao,
      DatPrometido : TDateTime;
      IndAtendeu,
      IndPrometeuData : Boolean;
     constructor cria;
     destructor destroy;override;
end;

Type
  TRBDTelemarketing = class
    public
      CodFilial,
      CodCliente,
      SeqTele,
      CodUsuario,
      SeqCampanha,
      LanOrcamento,
      CodHistorico,
      QtdDiasProximaLigacao,
      QtdSegundosLigacao : Integer;
      DesFaladoCom,
      DesObservacao,
      DesObsProximaLigacao :String;
      DatLigacao,
      DatProximaLigacao,
      DatTempoLigacao : TDateTime;
      IndAtendeu,
      IndProximaLigacao : Boolean;
      Constructor cria;
      destructor destroy;override;
end;

Type
  TRBDContratoProcessadoItem = class
    public
      SeqContrato,
      LanOrcamento : Integer;
      IndProcessado : Boolean;
      DesErro : String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDContratoProcessadoCorpo = class
    public
      CodFilial,
      SeqProcessado,
      CodUsuario : Integer;
      DatProcessado : TDateTime;
      Items : TList;
      constructor cria;
      destructor destroy;override;
      function AddItem : TRBDContratoProcessadoItem;
end;

Type
  TRBDContratoItem = class
    public
      SeqItem,
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      NumSerieProduto,
      NumSerieInterno,
      DesSetorEmpresa : String;
      QtdUltimaLeitura,
      QtdUltimaLeituraColor,
      QtdLeituraDesativacao,
      QtdLeituraDesativacaoColor : Integer;
      DatUltimaLeitura,
      DatDesativacao : TDatetime;
      constructor cria;
      destructor destroy;override;

end;

Type
  TRBDContratoCorpo = class
    public
      CodFilial,
      SeqContrato,
      CodCliente,
      CodTipoContrato,
      QtdMeses,
      QtdFranquia,
      QtdFranquiaColorida,
      CodServico,
      CodVendedor,
      CodPreposto,
      CodTecnicoLeitura,
      CodCondicaoPagamento,
      CodFormaPagamento,
      NumTextoServico,
      TipPeriodicidade,
      NumDiaLeitura : Integer;
      NumContrato,
      NomContato,
      NomServico,
      NumContaBancaria,
      NotaFiscalCupom : String;
      DatAssinatura,
      DatUltimaExecucao,
      DatCancelamento : TDateTime;
      ValContrato,
      ValExcedenteFranquia,
      ValExcedenteColorido,
      ValDesconto,
      PerComissao,
      PerComissaoPreposto : Double;
      IndNotaFiscal,
      IndProcessamentoAutomatico : Boolean;
      ItensContrato : TList;
      constructor cria;
      destructor destroy;override;
      function addItemContrato : TRBDContratoItem;
end;

Type
  TRBDCobrancaItem = Class
    public
      CodFilial,
      LanReceber,
      NumParcela : Integer;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDCobrancoCorpo = class
    public
      SeqCobranca,
      CodHistorico,
      CodMotivo,
      CodUsuario,
      CodCliente : Integer;
      DesFaladoCom,
      DesObservacao,
      DesObsProximaLigacao : string;
      DatProximaLigacao,
      DatPromessa,
      DatCobranca : TDateTime;
      IndCobrarCliente,
      IndAtendeu : Boolean;
      Items : TList;
      constructor cria;
      destructor destroy;override;
      function addItem : TRBDCobrancaItem;
end;

Type
  TRBDParenteCliente = class
    public
      CodCliente : Integer;
      NomCliente : String;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDFaixaEtariaCliente = class
    public
      CodFaixaEtaria : Integer;
      NomFaixaEtaria : String;
      Constructor cria;
      destructor destroy;override;
end;

Type
  TRBDMarcaCliente = Class
    public
      CodMarca : Integer;
      NomMarca  : String;
      constructor cria;
      destructor destroy;
end;

Type
  TRBDCliente = class
    public
      CodCliente,
      CodVendedor,
      CodProspect,
      CodVendedorPreposto,
      CodTecnico,
      CodCondicaoPagamento,
      CodFormaPagamento,
      CodTransportadora,
      CodTipoCotacao,
      CodTabelaPreco,
      CodConcorrente,
      CodProfissao,
      CodIBGECidade,
      CodPais,
      QtdLigacoesSemVenda,
      QtdLigacoesComVenda,
      SeqCampanha,
      QtdDiasProtesto,
      NumDiasEntrega : Integer;
      ValFrete: Double;
      CodPlanoContas,
      DesIdentificacaoBancariaFornecedor,
      NomCliente,
      NomFantasia,
      NomContato,
      NomContatoFinanceiro,
      NomContatoFornecedor,
      NomContatoEntrega,
      ContaBancariaDeposito,
      DesEndereco,
      DesEnderecoCobranca,
      DesEnderecoEntrega,
      DesEmail,
      DesEmailFinanceiro,
      DesEmailFornecedor,
      DesEmailNfe,
      DesComplementoEndereco,
      NumEndereco,
      NumEnderecoCobranca,
      NumEnderecoEntrega,
      DesBairro,
      DesBairroCobranca,
      DesBairroEntrega,
      CepCliente,
      CepClienteCobranca,
      CepEntrega,
      DesCidade,
      DesCidadeCobranca,
      DesCidadeEntrega,
      DesUF,
      DesUfCobranca,
      DesUFEntrega,
      CGC_CPF,
      RG,
      Fone_FAX,
      DesFone1,
      DesFone2,
      DesFone3,
      DesFoneFinanceiro,
      DesFax,
      TipoPessoa,
      InscricaoEstadual,
      DesObservacao,
      DesLigarDiaSemana,
      DesLigarPeriodo,
      DesObsTeleMarketing :String;
      LimiteCredito,
      DuplicatasEmAberto,
      DuplicatasEmAtraso,
      PerComissao,
      PerDescontoFinanceiro,
      PerDescontoCotacao,
      PerISS : Double;
      IndFornecedor,
      IndRevenda,
      IndNotaFiscal,
      IndQuarto,
      IndMeia,
      IndVintePorcento,
      IndDescontarISS,
      IndAceitaTeleMarketing,
      IndPossuiContrato,
      IndPendenciaSerasa,
      IndProtestar,
      IndBloqueado,
      IndCobrarFormaPagamento,
      IndDestacarICMSNota : Boolean;
      DatUltimoTeleMarketing,
      DatProximaLigacao,
      DatUltimaConsultaSerasa,
      DatUltimoRecebimento : TDateTime;
      constructor cria;
  end;

  TRBDTransportadora = class
    public
      Codigo   : String;
      Nome     : String;
      Endereco : String;
      NroEndereco: String;
      Bairro   : String;
      Cep      : String;
      Cidade   : String;
      UF       : String;
      CGC_CPF  : String;
      Telefone : string;
      PlacaVeic: String;
      UFPlaca  : String;
      InscricaoEstadual: String;
      Qtd      : Double;
      Especie  : String;
      Numero   : String;
      PesoBruto: Double;
      PesoLiq  : Double;
  end;

    TRBDDadosCedente = record
    CNPJ         : String;
    Nome         : String;
    CodigoCedente: String;
    DigitoCodigoCedente: String;

    {Endereço do cedente}
    Rua        : String;
    Numero     : String;
    Complemento: String;
    Bairro     : String;
    Cidade     : String;
    Estado     : String;
    CEP        : String;
    Email      : String;

    {Dados bancários do cedente}
    CodigoBanco : String;
    CodigoAgencia: String;
    DigitoAgencia: String;
    NumeroConta  : String;
    DigitoConta  : String;
  end;

  TRBDRetornoItem = class
    public
      CodOcorrencia,
      CodFilialRec,
      LanReceber,
      NumParcela,
      CodCancelada : Integer;
      NomOcorrencia,
      CodLiquidacao,
      DesLiquidacao,
      CodErros,
      DesErro,
      NumDuplicata,
      NomSacado,
      DesNossoNumero : String;
      IndProcessada,
      IndPossuiErro : Boolean;
      ValTitulo,
      ValLiquido,
      ValTarifa,
      ValOutrasDespesas,
      ValJuros : Double;
      DatOcorrencia,
      DatVencimento,
      DatCredito : TDateTime;
      constructor cria;
      destructor destroy;override;
  end;

  TRBDRetornoCorpo = class
    public
      CodFilial,
      SeqRetorno,
      SeqArquivo,
      CodBanco,
      CodUsuario,
      CodFornecedorBancario : Integer;
      NomArquivo,
      NomBanco,
      NumConta : String;
      DatRetorno,
      DatGeracao,
      DatCredito : TDatetime;
      Itens : TList;
      constructor cria;
      destructor destroy;override;
      function addItem : TRBDREtornoItem;
  end;

  TRBDRemessaItem = class
    public
      NumNossoNumero,
      CNPJCedente,
      NumDuplicata,
      TipCliente,
      CPFCNPJCliente,
      NomCliente,
      EndCliente,
      BaiCliente,
      CidCliente,
      CEPCliente,
      UFCliente : String;
      CodMovimento,
      DiasProtesto,
      CodFilial,
      LanReceber,
      NumParcela : Integer;
      ValMora,
      ValReceber,
      PerMulta : Double;
      DatEmissao,
      DatVencimento : TDateTime;
      IndDescontado : Boolean;
      constructor cria;
      destructor destroy;override;
  end;

  TRBDRemessaCorpo = class
    public
      CodFilial,
      SeqRemessa,
      CodBanco,
      CodUsuario,
      NumCarteira  : Integer;
      NumAgencia,
      NumConta,
      NomCorrentista,
      NomBanco,
      NumContrato,
      NumConvenioBanco,
      CodProdutoBanco : String;
      DatInicio,
      DatEnvio : TDateTime;
      IndEmiteBoleto : Boolean;
      Itens : TList;
      constructor cria;
      destructor destroy;override;
      function addIten : TRBDRemessaItem;
  end;

  TRBDItemContasConsolidadasCR = class
    public
      LanReceber,
      NroParcela,
      NroNota,
      CodCondicaoPagamento,
      CodFormaPagamento,
      CodSituacao,
      CodMoeda : Integer;
      CodPlanoContas : String;
      DatEmissao,
      DatVencimento : TDateTime;
      Cliente : String;
      ValParcela : Double;
      constructor cria;
      destructor destroy;override;
  end;

  TRBDContasConsolidadasCR = class
    public
      LanReceber,
      CodFilial,
      CodCliente : Integer;
      CodPlanoContas,
      NroNotasFiscais : String;
      DatVencimento : TDateTime;
      PerDesconto,
      ValDesconto,
      ValConsolidacao : Double;
      ItemsContas : TList;
      constructor cria;
      destructor destroy;override;
      function AddItemConta : TRBDItemContasConsolidadasCR;
  end;

//classes da visulização dos arquivos de vendas do Pao de açucar
Type
  TRBDVendasPaoAcucar = class
    public
      CodProdutoEAN : Double;
      NomProduto : String;
      QtdVendida,
      QtdEntrada : Double;
      Constructor cria;
      destructor destroy;override;
end;

Type
  TRBDFiliaisVendasPaoAcucar = class
    public
      CodEanFilial,
      QtdVendidaTotal,
      QtdEntradaTotal : Double;
      NomFilial : String;
      Vendas : TList;
      constructor cria;
      destructor destroy;override;
      function AddVendasPaoAcucar : TRBDVendasPaoAcucar;
end;

Type
  TRBDDatasVendasPaoAcucar = class
    public
      DatVenda : TDateTime;
      Filiais : TList;
      constructor cria;
      destructor destroy;override;
      function AddFiliaisPaoAcucar : TRBDFiliaisVendasPaoAcucar;
end;

Type
  TRBDArquivoVendasPaoAcucar = class
    public
      Datas : TList;
      constructor cria;
      destructor destroy;override;
      function AddDAtaVendaPaoAcucar : TRBDDatasVendasPaoAcucar;
end;


Type
  TRBDNaturezaOperacao = class
    public
      CodOperacaoEstoque : Integer;
      NomOperacaoEstoque,
      TipOperacaoEstoque,
      FuncaoOperacaoEstoque,
      CodPlanoContas : String;
      IndFinanceiro,
      IndBaixarEstoque,
      IndCalcularICMS,
      IndCalcularPis,
      IndCalcularCofins : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDSpedfiscalRegistroC190 = class
    public
      CodCFOP : Integer;
      CodCST : String;
      PerICMS,
      ValOperacao,
      ValBaseCalculoICMS,
      ValICMS,
      ValBaseCalculoICMSSubstituica,
      ValICMSSubstituicao,
      ValReducaBaseCalculo,
      ValIPI : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBCod_Fin = (cfRemessaOriginal,cfRemessaSubtituto);
  TRBDSpedFiscal = class
    public
     CodFilial,
     CodModeloDocumento : integer;
     DatInicio,
     DatFinal : TDateTime;
     PerICMSInterno : Double;
     CodFinalidade : TRBCod_Fin;
     DFilial : TRBDFilial;
     DContabilidade : TRBDCliente;
     QtdLinhasBloco0,
     QtdLinhasBlocoC,
     QtdLinhasBlocoD,
     QtdLinhasBlocoE,
     QtdLinhasBlocoH,
     QtdLinhasBloco1,
     QtdLinhasBloco9 : Integer;
     QtdLinhasRegistro0150,
     QtdLinhasRegistro0190,
     QtdLinhasRegistro0200,
     QtdLinhasRegistro0400,
     QtdLinhasRegistroC100,
     QtdLinhasRegistroC140,
     QtdLinhasRegistroC141,
     QtdLinhasRegistroC160,
     QtdLinhasRegistroC170,
     QtdLinhasRegistroC190,

     QtdLinhasRegistro9900     : Integer;
     Arquivo,
     Incosistencias : TStringList;
     RegistroC190 : TList;
     constructor cria;
     destructor destroy;override;
     function RRegistroC190(VpaCodCST : String; VpaCodCFOP : Integer; VpaPerICMS : Double):TRBDSpedfiscalRegistroC190;
  end;



implementation
Uses FunObjeto, FunData;

{******************************************************************************}
constructor TRBDDigitacaoProspectItem.cria;
begin

end;

{******************************************************************************}
destructor TRBDDigitacaoProspectItem.destroy;
begin

end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDDigitacaoProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
constructor TRBDDigitacaoProspect.cria;
begin
  inherited create;
  Prospects := TList.create;
end;

{******************************************************************************}
destructor TRBDDigitacaoProspect.destroy;
begin
  FreeTObjectsList(Prospects);
  Prospects.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDDigitacaoProspect.AddProspectItem : TRBDDigitacaoProspectItem;
begin
  result := TRBDDigitacaoProspectItem.cria;
  Prospects.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDCreditoCliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
constructor TRBDEmailMarketing.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDEmailMarketing.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDCreditoCliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCreditoCliente.cria;
begin
  inherited create;
  IndFinalizado := false;
end;

{******************************************************************************}
destructor TRBDCreditoCliente.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      TRBDProdutoInteresseCliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDProdutoInteresseCliente.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProdutoInteresseCliente.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      TRBDClientePerdidoVendedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDClientePerdidoVendedor.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDClientePerdidoVendedor.destroy;
begin
  Inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      TRBDAgendaCliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDAgendaCliente.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDAgendaCliente.destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDProdutoPendenteCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDComprador.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDComprador.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDLembreteItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDLembreteItem.Cria(VpaMarcado: Boolean);
begin
  inherited Create;
  IndMarcado:= VpaMarcado;
end;

{******************************************************************************}
destructor TRBDLembreteItem.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                   TRBDLembrete
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDLembreteCorpo.Cria;
begin
  inherited Create;
  Usuarios:= TList.Create;
end;

{******************************************************************************}
destructor TRBDLembreteCorpo.Destroy;
begin
  FreeTObjectsList(Usuarios);
  Usuarios.Free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDLembreteCorpo.AddUsuario: TRBDLembreteItem;
begin
  Result:= TRBDLembreteItem.Cria(False);
  Usuarios.Add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDProdutoPendenteCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoPendenteCompra.Cria;
begin
  inherited Create;
  OrcamentosCompra:= TList.Create;
  SeqPedidoGerado:= 0;
  IndAlterado := false;
end;

{******************************************************************************}
destructor TRBDProdutoPendenteCompra.Destroy;
begin
  // não limpar o conteudo da lista de orçamentos por aqui, porque podem existir
  // N orçamentos para N produtos pendentes, deve ser feito um controle externo.
  OrcamentosCompra.Free;
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBChamadoServicoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoParcial.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDChamadoParcial.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRDBChamadoServicoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoServicoOrcado.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDChamadoServicoOrcado.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRBDChamadoProdutoOrcado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoProdutoOrcado.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDChamadoProdutoOrcado.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDChamadoServicoExecutado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoServicoExecutado.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDChamadoServicoExecutado.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       TRBDComissaoClassificacaoVendedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDComissaoClassificacaoVendedor.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDComissaoClassificacaoVendedor.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                               TRBDPropostaServico
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaServico.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDPropostaServico.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            TRBDPropostaLocacaoFranquia
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaLocacaoFranquia.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDPropostaLocacaoFranquia.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDProspostaLocacaoCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaLocacaoCorpo.Cria;
begin
  inherited Create;
  Franquias:= TList.Create;
end;

{******************************************************************************}
destructor TRBDPropostaLocacaoCorpo.Destroy;
begin
  FreeTObjectsList(Franquias);
  Franquias.Free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDPropostaLocacaoCorpo.AddFranquia: TRBDPropostaLocacaoFranquia;
begin
  Result:= TRBDPropostaLocacaoFranquia.Cria;
  Franquias.Add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDUsuarioVendedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDUsuarioVendedor.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDUsuarioVendedor.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDOrcamentoCompraFracaoOP
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSolicitacaoCompraFracaoOP.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDSolicitacaoCompraFracaoOP.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDOrcamentoCompraItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSolicitacaoCompraItem.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDSolicitacaoCompraItem.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            TRBDSolicitacaoCompraCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSolicitacaoCompraCorpo.Cria;
begin
  inherited Create;
  Produtos:= TList.Create;
  Fracoes:= TList.Create;
end;

{******************************************************************************}
destructor TRBDSolicitacaoCompraCorpo.Destroy;
begin
  FreeTObjectsList(Produtos);
  Produtos.Free;
  FreeTObjectsList(Fracoes);
  Fracoes.Free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDSolicitacaoCompraCorpo.AddFracaoOP: TRBDSolicitacaoCompraFracaoOP;
begin
  Result:= TRBDSolicitacaoCompraFracaoOP.Cria;
  Fracoes.Add(Result);
end;

{******************************************************************************}
function TRBDSolicitacaoCompraCorpo.AddProduto: TRBDSolicitacaoCompraItem;
begin
  Result:= TRBDSolicitacaoCompraItem.Cria;
  Produtos.Add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDTarefaEMarketingProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDTarefaEMarketingProspect.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDTarefaEMarketingProspect.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDTarefaEMarketing
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDTarefaEMarketing.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDTarefaEMarketing.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDFracaoOPPedidoCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFracaoOPPedidoCompra.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDFracaoOPPedidoCompra.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDProdutoPedidoCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoPedidoCompra.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDProdutoPedidoCompra.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDPedidoCompraCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPedidoCompraCorpo.Cria;
begin
  inherited Create;
  Produtos:= TList.Create;
  FracaoOP:= TList.Create;
  DatPrevistaInicial := montadata(1,1,1900);
  DatRenegociadoInicial := montadata(1,1,1900);
end;

{******************************************************************************}
function TRBDPedidoCompraCorpo.AddProduto: TRBDProdutoPedidoCompra;
begin
  Result:= TRBDProdutoPedidoCompra.Cria;
  Produtos.Add(Result);
end;

{******************************************************************************}
function TRBDPedidoCompraCorpo.AddFracaoOP: TRBDFracaoOPPedidoCompra;
begin
  Result:= TRBDFracaoOPPedidoCompra.Cria;
  FracaoOP.Add(Result);
end;

{******************************************************************************}
destructor TRBDPedidoCompraCorpo.Destroy;
begin
  FreeTObjectsList(Produtos);
  FreeTObjectsList(FracaoOP);
  Produtos.Free;
  FracaoOP.Free;
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDTelemarketingProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDTelemarketingProspect.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDTelemarketingProspect.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDContatoProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContatoProspect.Cria;
begin
  inherited Create;
  IndExportadoEficacia := false;
  IndEmailInvalido := false;
  DatCadastro := now;
end;

{******************************************************************************}
destructor TRBDContatoProspect.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 TRBDPropostaAmostra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaAmostra.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDPropostaAmostra.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              TRBDProdutoProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProdutoProspect.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDProdutoProspect.Destroy;
begin
  inherited Destroy;
end;


{#############################################################################
                     Classe do conta a pagar
#############################################################################  }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                  Baixa Contas a Pagar
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TDadosBaixaCP.cria;
begin
  inherited create;
  Cheques := TList.create;
end;

{******************************************************************************}
destructor TDadosBaixaCP.destroy;
begin
  FreeTObjectsList(Cheques);
  Cheques.free;
  inherited destroy;
end;

{******************************************************************************}
function TDadosBaixaCP.AddCheque : TRBDCheque;
begin
  result := TRBDCheque.cria;
  Cheques.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 TRBDAgendaProspect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDAgendaProspect.Cria;
begin
  inherited Create;
end;

{******************************************************************************}
destructor TRBDAgendaProspect.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe Contatos do Cliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContatoCliente.cria;
begin
  inherited create;
  IndExportadoEficacia := false;
  IndEmailInvalido := false;
end;

{******************************************************************************}
destructor TRBDContatoCliente.destroy;
begin
  inherited destroy;
end;
    
{******************************************************************************}
constructor TRBDFilial.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFilial.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do prospect
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDProspect.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDProspect.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da Proposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaProdutoASerRotulado.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaProdutoASerRotulado.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da Proposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaProdutoSemQtd.cria;
begin
  inherited create;
  UnidadesParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDPropostaProdutoSemQtd.destroy;
begin
  UnidadesParentes.free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da TRBDPropostaVendaAdicional
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaVendaAdicional.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaVendaAdicional.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da Proposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaProduto.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDPropostaProduto.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da Proposta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPropostaCorpo.cria;
begin
  inherited create;
  Produtos := TList.create;
  ProdutosASeremRotulados := TList.Create;
  Amostras := TList.Create;
  Locacoes:= TList.Create;
  Servicos:= TList.Create;
  ProdutosSemQtd := TList.Create;
  VendaAdicinal := TList.create;
end;

{******************************************************************************}
destructor TRBDPropostaCorpo.destroy;
begin
  FreeTObjectsList(Produtos);
  FreeTObjectsList(Amostras);
  FreeTObjectsList(Locacoes);
  FreeTObjectsList(Servicos);
  FreeTObjectsList(ProdutosASeremRotulados);
  FreeTObjectsList(ProdutosSemQtd);
  FreeTObjectsList(VendaAdicinal);
  Produtos.free;
  Amostras.Free;
  Locacoes.Free;
  Servicos.Free;
  ProdutosASeremRotulados.free;
  ProdutosSemQtd.free;
  VendaAdicinal.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDPropostaCorpo.addProduto : TRBDPropostaProduto;
begin
  result := TRBDPropostaProduto.cria;
  Produtos.add(result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addProdutoSemQtd : TRBDPropostaProdutoSemQtd;
begin
  result := TRBDPropostaProdutoSemQtd.cria;
  ProdutosSemQtd.add(result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addAmostra: TRBDPropostaAmostra;
begin
  Result:= TRBDPropostaAmostra.Cria;
  Amostras.Add(Result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.AddLocacao: TRBDPropostaLocacaoCorpo;
begin
  Result:= TRBDPropostaLocacaoCorpo.Cria;
  Locacoes.Add(Result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.AddServico: TRBDPropostaServico;
begin
  Result:= TRBDPropostaServico.Cria;
  Servicos.Add(Result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addProdutoAseremRotulados : TRBDPropostaProdutoASerRotulado;
begin
  result := TRBDPropostaProdutoASerRotulado.Cria;
  ProdutosASeremRotulados.add(result);
end;

{******************************************************************************}
function TRBDPropostaCorpo.addVendaAdicional : TRBDPropostaVendaAdicional;
begin
  result := TRBDPropostaVendaAdicional.cria;
  VendaAdicinal.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da cotacao grafica
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCotacaoGrafica.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCotacaoGrafica.destroy;
begin
  inherited destroy;
end;
                    
{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da pesquisa de satisfação
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPesquisaSatisfacaoItem.cria;
begin
  inherited create;
  NumNota := -1
end;

{******************************************************************************}
destructor TRBDPesquisaSatisfacaoItem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da pesquisa de satisfação
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDPesquisaSatisfacaoCorpo.cria;
begin
  inherited create;
  Items := TList.create;
end;

{******************************************************************************}
destructor TRBDPesquisaSatisfacaoCorpo.destroy;
begin
  FreeTObjectsList(Items);
  Items.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDPesquisaSatisfacaoCorpo.AddPesquisaItem : TRBDPesquisaSatisfacaoItem;
begin
  result := TRBDPesquisaSatisfacaoItem.cria;
  Items.add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do Produto Trocado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoProdutoTrocado.cria;
begin
  inherited create;
  UnidadeParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDChamadoProdutoTrocado.destroy;
begin
  UnidadeParentes.free;
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do chamado Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoProdutoExtra.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDChamadoProdutoExtra.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do chamado Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamadoProduto.cria;
begin
  inherited create;
  ProdutosTrocados := TList.create;
  ServicosExecutados:= TList.Create;
  ProdutosOrcados:= TList.Create;
  ServicosOrcados:= TList.Create;
  UnidadeParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDChamadoProduto.destroy;
begin
  FreeTObjectsList(ServicosExecutados);
  ServicosExecutados.Free;
  FreeTObjectsList(ProdutosTrocados);
  ProdutosTrocados.free;
  FreeTObjectsList(ProdutosOrcados);
  ProdutosOrcados.Free;
  FreeTObjectsList(ServicosOrcados);
  ServicosOrcados.Free;
  UnidadeParentes.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDChamadoProduto.AddProdutoTrocado : TRBDChamadoProdutoTrocado;
begin
  result := TRBDChamadoProdutoTrocado.cria;
  ProdutosTrocados.add(result);
end;

{******************************************************************************}
function TRBDChamadoProduto.AddServicoExecutado: TRBDChamadoServicoExecutado;
begin
  Result:= TRBDChamadoServicoExecutado.Cria;
  ServicosExecutados.Add(Result);
end;

{******************************************************************************}
function TRBDChamadoProduto.AddProdutoOrcado: TRBDChamadoProdutoOrcado;
begin
  Result:= TRBDChamadoProdutoOrcado.Cria;
  ProdutosOrcados.Add(Result);
end;

{******************************************************************************}
function TRBDChamadoProduto.AddServicoOrcado: TRBDChamadoServicoOrcado;
begin
  Result:= TRBDChamadoServicoOrcado.Cria;
  ServicosOrcados.Add(Result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do chamado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDChamado.cria;
begin
  inherited create;
  IndPesquisaSatisfacao := false;
  Produtos := TList.create;
  ProdutosExtras := TList.Create;
end;

{******************************************************************************}
destructor TRBDChamado.destroy;
begin
  FreeTObjectsList(Produtos);
  Produtos.free;
  FreeTObjectsList(ProdutosExtras);
  ProdutosExtras.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDChamado.AddProdutoChamado : TRBDChamadoProduto;
begin
  result := TRBDChamadoProduto.cria;
  produtos.add(result);
end;

{******************************************************************************}
function TRBDChamado.AddProdutoExtra : TRBDChamadoProdutoExtra;
begin
  result := TRBDChamadoProdutoExtra.cria;
  ProdutosExtras.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do produto do cliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDAgenda.cria;
begin
  inherited create;
  IndCancelado := false;
  IndRealizado := false;
end;

{******************************************************************************}
destructor TRBDAgenda.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do produto do cliente
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
constructor TRBDProdutoCliente.cria;
begin
  inherited create;
  UnidadeParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDProdutoCliente.destroy;
begin
  UnidadeParentes.free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do leitura contrato item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDLeituraLocacaoItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDLeituraLocacaoItem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do leitura contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDLeituraLocacaoCorpo.cria;
begin
  inherited create;
  ItensLeitura := TList.Create;
  IndProcessamentoFrio := false;
end;

{******************************************************************************}
destructor TRBDLeituraLocacaoCorpo.destroy;
begin
  FreeTObjectsList(ItensLeitura);
  ItensLeitura.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDLeituraLocacaoCorpo.AddItemLeitura : TRBDLeituraLocacaoItem;
begin
  result := TRBDLeituraLocacaoItem.cria;
  ItensLeitura.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDBrindeCliente.cria;
begin
  inherited create;
  UnidadeParentes := TStringList.create;
end;

{******************************************************************************}
destructor TRBDBrindeCliente.destroy;
begin
  UnidadeParentes.free;
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDTelemarketingFaccionista.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDTelemarketingFaccionista.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDTelemarketing.cria;
begin

end;

{******************************************************************************}
destructor TRBDTelemarketing.destroy;
begin

end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContratoProcessadoItem.cria;
begin
  inherited create;
  IndProcessado := true;
end;

{******************************************************************************}
destructor TRBDContratoProcessadoItem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContratoProcessadoCorpo.cria;
begin
  inherited create;
  Items := TList.Create;
end;

{******************************************************************************}
destructor TRBDContratoProcessadoCorpo.destroy;
begin
  FreeTObjectsList(Items);
  Items.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDContratoProcessadoCorpo.AddItem : TRBDContratoProcessadoItem;
begin
  result := TRBDContratoProcessadoItem.cria;
  Items.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContratoItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDContratoItem.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe do contrato corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContratoCorpo.cria;
begin
  inherited create;
  ItensContrato := TList.create;
end;

{******************************************************************************}
destructor TRBDContratoCorpo.destroy;
begin
  FreeTObjectsList(ItensContrato);
  ItensContrato.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDContratoCorpo.addItemContrato : TRBDContratoItem;
begin
  result := TRBDContratoItem.cria;
  ItensContrato.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da cobranca corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCobrancaItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCobrancaItem.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe da cobranca corpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCobrancoCorpo.cria;
begin
  inherited create;
  Items := TList.create;
  IndCobrarCliente := false;
end;

{******************************************************************************}
destructor TRBDCobrancoCorpo.destroy;
begin
  FreeTObjectsList(Items);
  Items.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDCobrancoCorpo.addItem : TRBDCobrancaItem;
begin
  result := TRBDCobrancaItem.cria;
  Items.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe de clientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDParenteCliente.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDParenteCliente.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe de clientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDFaixaEtariaCliente.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFaixaEtariaCliente.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe de clientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDMarcaCliente.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDMarcaCliente.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da classe de clientes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCliente.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe RETORNOITEM
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

constructor TRBDREtornoItem.cria;
begin
  inherited create;
  IndProcessada := false;
  IndPossuiErro := true;
end;

{******************************************************************************}
destructor TRBDREtornoItem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe RETORNOCORPO
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDRetornoCorpo.cria;
begin
  inherited create;
  Itens := TList.create;
end;

{******************************************************************************}
destructor TRBDRetornoCorpo.destroy;
begin
  FreeTObjectsList(Itens);
  Itens.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDRetornoCorpo.addItem : TRBDREtornoItem;
begin
  result := TRBDREtornoItem.cria;
  itens.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe de contas consolidadas Item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDRemessaItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDRemessaItem.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe de contas consolidadas Item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDRemessaCorpo.cria;
begin
  inherited create;
  Itens := TList.create;
end;

{******************************************************************************}
destructor TRBDRemessaCorpo.destroy;
begin
  FreeTObjectsList(Itens);
  Itens.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDRemessaCorpo.addIten : TRBDRemessaItem;
begin
  result := TRBDRemessaItem.cria;
  Itens.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe de contas consolidadas Item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDItemContasConsolidadasCR.cria;
begin
  inherited;
end;

{******************************************************************************}
destructor TRBDItemContasConsolidadasCR.destroy;
begin
  inherited
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Dados da classe de contas consolidadas Item
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContasConsolidadasCR.cria;
begin
  inherited create;
  ItemsContas := TList.Create;
end;  

{******************************************************************************}
destructor TRBDContasConsolidadasCR.destroy;
begin
  FreeTObjectsList(ItemsContas);
  inherited destroy;
end;

{******************************************************************************}
function TRBDContasConsolidadasCR.AddItemConta : TRBDItemContasConsolidadasCR;
begin
  result := TRBDItemContasConsolidadasCR.cria;
  ItemsContas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do pao de açucar
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDVendasPaoAcucar.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDVendasPaoAcucar.destroy;
begin
 inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das filias das vendas do pao de açucar
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFiliaisVendasPaoAcucar.cria;
begin
  inherited create;
  Vendas := TList.Create;
  QtdVendidaTotal := 0;
  QtdEntradaTotal := 0;
end;

{******************************************************************************}
destructor TRBDFiliaisVendasPaoAcucar.destroy;
begin
  FreeTObjectsList(Vendas);
  Vendas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDFiliaisVendasPaoAcucar.AddVendasPaoAcucar : TRBDVendasPaoAcucar;
begin
  Result := TRBDVendasPaoAcucar.cria;
  Vendas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do Pao de Acucar.
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDDatasVendasPaoAcucar.cria;
begin
  inherited create;
  Filiais := TList.create;
end;

{******************************************************************************}
destructor TRBDDatasVendasPaoAcucar.destroy;
begin
  FreeTObjectsList(Filiais);
  Filiais.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDDatasVendasPaoAcucar.AddFiliaisPaoAcucar : TRBDFiliaisVendasPaoAcucar;
begin
  result := TRBDFiliaisVendasPaoAcucar.cria;
  Filiais.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do Pao de Acucar.
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDArquivoVendasPaoAcucar.cria;
begin
  inherited create;
  Datas := TList.Create;
end;

{******************************************************************************}
destructor TRBDArquivoVendasPaoAcucar.destroy;
begin
  FreeTObjectsList(datas);
  Datas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDArquivoVendasPaoAcucar.AddDAtaVendaPaoAcucar : TRBDDatasVendasPaoAcucar;
begin
  Result := TRBDDatasVendasPaoAcucar.cria;
  Datas.add(result);
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe das vendas do Pao de Acucar.
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
constructor TRBDNaturezaOperacao.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDNaturezaOperacao.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe da classe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSpedFiscal.cria;
begin
  inherited create;
  Arquivo := TStringList.Create;
  Incosistencias := TStringList.Create;
  DFilial := TRBDFilial.cria;
  DContabilidade := TRBDCliente.cria;
  RegistroC190 := TList.create;
end;

{******************************************************************************}
destructor TRBDSpedFiscal.destroy;
begin
  DFilial.free;
  DContabilidade.free;
  Incosistencias.free;
  Arquivo.free;
  FreeTObjectsList(RegistroC190);
  RegistroC190.free;
  inherited;
end;

{******************************************************************************}
function TRBDSpedFiscal.RRegistroC190(VpaCodCST : String; VpaCodCFOP: Integer; VpaPerICMS: Double): TRBDSpedfiscalRegistroC190;
var
  VpfLaco : Integer;
  VpfDRegistroC190 : TRBDSpedfiscalRegistroC190;
begin
  result := nil;
  for Vpflaco := 0 to RegistroC190.Count - 1 do
  begin
    VpfDRegistroC190 := TRBDSpedfiscalRegistroC190(RegistroC190.Items[VpfLaco]);
    if (VpfDRegistroC190.CodCST = VpaCodCST) and
       (VpfDRegistroC190.CodCFOP = VpaCodCFOP) and
       (VpfDRegistroC190.PerICMS = VpaPerICMS) then
    begin
      result := VpfDRegistroC190;
      break;
    end;
  end;
  if result = nil then
  begin
    result := TRBDSpedfiscalRegistroC190.cria;
    RegistroC190.add(result);
    Result.CodCST := VpaCodCST;
    Result.CodCFOP := VpaCodCFOP;
    result.PerICMS := VpaPerICMS;
  end;
end;

{ TRBDSpedFiscal }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Classe da classe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDSpedfiscalRegistroC190.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDSpedfiscalRegistroC190.destroy;
begin
  inherited destroy;
end;

{ TRBDSpedfiscalRegistroC190 }


end.
