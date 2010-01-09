unit UnRave;
{Verificado
-.edit;
}
interface
Uses SQLExpr, RpRave, UnDados, SysUtils, RpDefine, RpBase, RpSystem,RPDevice,
     Classes, forms, Graphics, unprodutos, UnClassificacao, UnAmostra, RpRenderPDF,
     unDadosProduto, windows, rpBars, UnSistema, UnordemProducao;


Type
  TRBDTamanhoProdutoRave = class
    public
     CodTamanho : Integer;
     NomTamanho : String;
     QtdEstoque,
     ValEstoque : Double;
     constructor cria;
     destructor destroy;override;
  end;

Type
  TRBDCorProdutoRave = class
    public
      CodCor : Integer;
      NomCor : String;
      QtdEstoque,
      ValEstoque  : Double;
      Tamanhos : TList;
      constructor cria;
      destructor destroy;override;
      function addTamanho : TRBDTamanhoProdutoRave;
end;

Type
  TRBDProdutoRave = class
    public
      SeqProduto : Integer;
      CodProduto,
      NomProduto,
      DesUM,
      DesCifraoMoeda : String;
      QtdEstoque,
      QtdTrocada,
      ValEstoque,
      ValTroca : Double;
      Cores : TList;
      constructor cria;
      destructor destroy;override;
      function AddCor : TRBDCorProdutoRave;
end;

Type
  TRBDClassificacaoRave = class
    CodClassificacao,
    CodReduzido,
    NomClassificacao : String;
    QTdProduto,
    QtdTrocado,
    ValTotal,
    VAlTrocado,
    QtdMesAnterior,
    QtdVenda,
    ValAnterior,
    ValVenda,
    ValCustoVenda : Double;
    IndNovo : Boolean;
  end;

Type
  TRBDPlanoContasRave = class
    CodPlanoCotas,
    CodReduzido,
    NomPlanoContas : String;
    ValPago,
    ValDuplicata,
    ValPrevisto : Double;
    IndNovo : Boolean;
  end;

Type
  TRBDVendaClienteMes = class
    public
      Mes : Integer;
      ValVenda : Double;
      IndReducaoVenda : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDVendaClienteAno = class
    public
      Ano : Integer;
      ValVenda : Double;
      IndReducaoVenda : Boolean;
      Meses : TList;
      Constructor cria;
      destructor destroy;override;
      function addMes : TRBDVendaClienteMes;
end;

Type
  TRBDVendaCliente = class
    public
      Anos : TList;
      Constructor cria;
      destructor destroy;override;
      function addAno : TRBDVendaClienteAno;
end;

type
  TRBFunRave = class
    private
      Aux,
      Tabela,
      Clientes : TSQLQuery;
      RvSystem: TRvSystem;
      RvPDF :  TRvRenderPDF;
      VprCabecalhoEsquerdo,
      VprCabecalhoDireito : TStringList;
      VprCaminhoRelatorio,
      VprNomeRelatorio,
      VprPrimeiraLinha,
      VprNomVendedor,
      VprUfAtual : String;
      VprMes,
      VprAno,
      VprCodProjeto,
      VprFilial,
      VprClienteMaster,
      VprCliente : Integer;
      VprDatInicio,
      VprDatFim : TDateTime;
      VprAgruparPorEstado,
      VprTodosProdutos : Boolean;
      VprDOPEtikArt : TRBDOrdemProducaoEtiqueta;
      FunClassificacao : TFuncoesClassificacao;
      VprNiveis : TList;
      procedure DefineTabelaProdutosPorClassificacao(VpaObjeto : TObject);
      procedure DefineTabelaProdutosComDefeito(VpaObjeto : TObject);
      procedure DefineTabelaResumoCaixas(VpaObjeto : TObject);
      procedure DefineTabelaProdutosVendidoseTrocados(VpaObjeto : TObject);
      procedure DefineTabelaEstoqueProdutos(VpaObjeto : TObject);
      procedure DefineTabelaQtdMinimas(VpaObjeto : TObject);
      procedure DefineTabelaAnaliseFaturamentoMensal(VpaObjeto : TObject);
      procedure DefineTabelaFechamentoEstoque(VpaObjeto : TObject);
      procedure DefineTabelaCPporPlanoContas(VpaObjeto : TObject);
      procedure DefineTabelaCPporPlanoContasSintetico(VpaObjeto : TObject);
      procedure DefineTabelaCPporPlanoContasSinteticoporMes(VpaObjeto : TObject);
      procedure DefineTabelaEntradaMetro(VpaObjeto : TObject);
      procedure DefineTabelaExtratoProdutividade(VpaObjeto : TObject);
      procedure DefineTabelaCustoProjeto(VpaObjeto : TObject);
      procedure DefineTabelaTabelaPreco(VpaObjeto : TObject);
      procedure DefineTabelaTotalAmostraporVendedor(VpaObjeto : TObject);
      procedure DefineTabelaTotalTipoCotacaoXCusto(VpaObjeto : TObject);
      procedure DefineTabelaRomaneioEtikArt(VpaObjeto : TObject);
      procedure DefineTabelaOPEtikArt(VpaObjeto : TObject);
      procedure DefineTabelaRomaneioSeparacaoCotacao(VpaObjeto : TObject);
      procedure ImprimeProdutoPorClassificacao(VpaObjeto : TObject);
      procedure SalvaTabelaProdutosPorCoreTamanho(VpaDProduto :TRBDProdutoRave);
      procedure SalvaTabelaPrecoPorCoreTamanho(VpaDProduto :TRBDProdutoRave);
      procedure SalvaTabelaTrocasProdutos(VpaDProduto :TRBDProdutoRave);
      procedure SalvaTabelaProdutosComDefeito(VpaDProduto :TRBDProdutoRave);
      procedure ImprimeRelEstoqueProdutos(VpaObjeto : TObject);
      procedure ImprimeTotaisNiveis(VpaNiveis : TList;VpaIndice : integer);
      procedure ImprimeTotaisNiveisPlanoContas(VpaNiveis : TList;VpaIndice : integer);
      procedure ImprimeTotalCelulaTrabalho(VpaValTotal : Double;VpaDiaAtua : Integer);
      procedure ImprimeCabecalhoEstoque;
      procedure ImprimeCabecalhoTabelaPreco;
      procedure ImprimeCabecalhoProdutocomDefeito;
      procedure ImprimeCabecalhoTotalTipoPedidoXCusto;
      procedure ImprimeCabecalhoResumoCaixas;
      procedure ImprimeCabecalhoRomaneioEtikArt;
      procedure ImprimeCabecalhoProdutosVendidoseTrocados;
      procedure ImprimeCabecalhoQtdMinima;
      procedure ImprimeCabecalhoAnaliseFaturamento;
      procedure ImprimeCabecalhoFechamentoEstoque;
      procedure ImprimeCabecalhoEntradaMetros;
      procedure ImprimeCabecalhoPlanoContas;
      procedure ImprimeCabecalhoPlanoContasCustoProjeto;
      procedure ImprimeCabecalhoExtratoProdutividade;
      procedure ImprimeCabecalhoTotalAmostrasVendedor;
      procedure ImprimeCabecalhoPorPlanoContasSintetico;
      procedure ImprimeCabecalhoPorPlanoContasSinteticoporMes;
      procedure ImprimeTituloUF(VpaCodUf : String);
      procedure ImprimeTituloClassificacao(VpaNiveis : TList;VpaTudo : boolean);
      procedure ImprimetituloPlanoContas(VpaNiveis : TList;VpaTudo : boolean);
      function RTamanhoProduto(VpaDCor : TRBDCorProdutoRave;VpaCodTamanho : Integer) : TRBDTamanhoProdutoRave;
      function RCorProduto(VpaDProduto : TRBDProdutoRave;VpaCodCor : Integer):TRBDCorProdutoRave;
      function CarDNivel(VpaCodCompleto, VpaCodReduzido : String):TRBDClassificacaoRave;
      function CarregaNiveis(VpaNiveis : TList;VpaCodClassificacao : string):TRBDClassificacaoRave;
      function CarDNivelPlanoContas(VpaCodCompleto, VpaCodReduzido : String):TRBDPlanoContasRave;
      function CarregaNiveisPlanoContas(VpaNiveis : TList;VpaCodPlanoContas : string;VpaImprimirTotal : Boolean):TRBDPlanoContasRave;
      procedure ImprimeRelCustoProjetoContasAPagar;
      procedure ImprimeRelTabelaPreco(VpaObjeto : TObject);
      procedure ImprimeRelProdutosComDefeito(VpaObjeto : TObject);
      procedure ImprimeRelResumoCaixas(VpaObjeto : TObject);

      procedure InicializaVendaCliente(VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente);
      function RMesVenda(VpaDVenda : TRBDVendaCliente;VpaMes, VpaAno : Integer) : TRBDVendaClienteMes;
      procedure AtualizaTotalVenda(VpaDVenda : TRBDVendaCliente);
      function CarValoresFaturadosCliente(VpaCodCliente : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente):boolean;
      function CarValoresPlanoContasMes(VpaPlanoContas : String; VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente):boolean;
      procedure CarValoresContasAPagar(VpaPlanoContas : String; VpaDatInicio,VpaDatFim : TDateTime;Var VpaValPago : Double;Var VpaValtotal : Double);
      procedure CarValorTrocasProdutos(VpaDProduto : TRBDProdutoRave; VpaDatInicio,VpaDatFim : TDateTime;VpaSeqProduto :Integer);
      function RValCustoCotacao(VpaCodFilial,VpaLanOrcamento : Integer) : Double;
      function REspula(VpaNumEspulas : Integer) : String;
      procedure RMetrosFitaManequim(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaLacoInicio,VpaLacoFim : Integer);
      procedure CarCombinacoesOPConvencional(VpaDOPEtikArt : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
      procedure CarCombinacoesOPH(VpaDOPEtikArt : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
      procedure CarManequinsOPConvencional(VpaDOPEtikArt : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
      procedure CarMetrosCombinacaoOPH(VpaDOPEtikArt : TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);

      procedure ConfiguraRelatorioPDF;
      procedure ImprimeRelEstoqueMinimo(VpaObjeto : TObject);
      procedure ImprimeRelAnaliseFaturamentoAnual(VpaObjeto : TObject);
      procedure ImprimeRelFechamentoEstoque(VpaObjeto : TObject);
      procedure ImprimeRelCPporPlanoContas(VpaObjeto : TObject);
      procedure ImprimeRelCPporPlanoContasSintetico(VpaObjeto : TObject);
      procedure ImprimeRelCPPorPlanoContasSinteticoporMes(VpaObjeto : TObject);
      procedure ImprimeRelEntradaMetros(VpaObjeto : TObject);
      procedure ImprimeRelExtratoProdutividade(VpaObjeto : TObject);
      procedure ImprimeRelCustoProjeto(VpaObjeto : TObject);
      procedure ImprimeRelTotalAmostrasVendedor(VpaObjeto : TObject);
      procedure ImprimeRelTotalTipoCotacaoXCusto(VpaObjeto : TObject);
      procedure ImprimeRelRomaneioEtikArt(VpaObjeto : TObject);
      procedure ImprimeRelOPEtikArt(VpaObjeto : TObject);
      procedure ImprimeRelRomaneioSeparacaoCotacao(VpaObjeto : TObject);
      procedure ImprimeCabecalho(VpaObjeto : TObject);
      procedure ImprimeRodape(VpaObjeto : TObject);
    public
      VplArquivoPDF : String;
      constructor cria(VpaBaseDados : TSQLConnection);
      destructor destroy;override;
      procedure EnviaParametrosFilial(VpaProjeto : TrvProject;VpaDFilial : TRBDFilial);
      procedure ImprimeProdutoVendidosPorClassificacao(VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao, VpaCodClienteMaster  : Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho,VpaNomFilial,VpaNomCliente, VpaNomVendedor,VpaNomTipoCotacao, VpaNomClienteMaster : String;VpaAgruparPorEstado, VpaPDF : Boolean);
      procedure ImprimeEstoqueProdutos(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados,VpaSomenteComQtd : Boolean);
      procedure ImprimeAnaliseFaturamentoMensal(VpaCodFilial,VpaCodCliente,VpaCodVendedor : Integer;VpaCaminho, VpaNomFilial,VpaNomCliente,VpaNomVendedor : String;VpaDatInicio, VpaDatFim : TDateTime);
      procedure ImprimeQtdMinimasEstoque(VpaCodFilial, VpaCodFornecedor : Integer;VpaCaminho,VpaCodClassificacao,VpaNomFilial, VpaNomClassificacao, VpaNomFornecedor : String);
      procedure ImprimeEstoqueFiscalProdutos(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados : Boolean);
      procedure ImprimeFechamentoMes(VpaCodFilial : Integer;VpaCaminho, VpaNomFilial : String;VpaData : TDateTime;VpaMostarTodos : Boolean);
      procedure ImprimeContasAPagarPorPlanodeContas(VpaCodFilial : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial : String;VpfTipoPeriodo : Integer);
      procedure ImprimeEntradaMetros(VpaDatInicio, VpaDatFim : TDateTime);
      procedure ImprimeExtratoProdutividade(VpaCaminho : String;VpaData : TDateTime);
      procedure ImprimeCustoProjeto(VpaCodProjeto : Integer;VpaCaminho, VpaNomProjeto : String);
      procedure ImprimeTabelaPreco(VpaCodCliente, VpaCodTabelaPreco : Integer;VpaCaminho,VpaNomCliente,VpaNomTabelaPreco,VpaCodClassificacao, VpaNomClassificacao : String);
      procedure ImprimeEstoqueProdutosReservados(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados : Boolean);
      procedure ImprimeTotaAmostrasPorVendedor(VpaCodVendedor : Integer;VpaCaminho, VpaNomVendedor : String;VpaDatInicio, VpaDatFim : TDateTime);
      procedure ImprimeContasAPagarPorPlanoContasSintetico(VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho : String);
      procedure ImprimeFichaAmosta(VpaDAmostra : TRBDAmostra);
      procedure ImprimeProdutosVendidoseTrocacos(VpaCodFilial, VpaTipCotacao,VpaCodCliente,VpaCodVendedor,VpaCodClienteMaster : Integer;VpaCaminho,VpaNomFilial,VpaNomVendedor,VpaNomTipCotacao,VpaNomCliente,VpaNomClienteMaster:string ;VpaDatInicio,VpaDatFim : TDateTime);
      procedure ImprimeContasAPagarPorPlanoContasSinteticoMes(VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho : String);
      procedure ImprimeTotalTipoCotacaoXCusto(VpaCodFilial, VpaCodCliente, VpaCodVendedor, VpaCodTipoCotacao : Integer;VpaCaminho, VpaNomFilial, VpaNomCliente, VpaNomVendedor,VpaNomTipoCotacao : String;VpaDAtInicio, VpaDatFim : TDAteTime);
      procedure ImprimeProdutosVendidosComDefeito(VpaCodFilial,VpaCodCliente,VpaCodVendedor: Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho,VpaNomFilial,VpaNomCliente, VpaNomVendedor, VpaCodClassificao, VpaNomClassificacao : String;VpaPDF : Boolean);
      procedure ImprimeResumosCaixas(VpaCaminho : String;VpaPDF : Boolean);
      procedure ImprimeRomaneioEtikArt(VpaCodFilial, VpaSeqRomaneio : Integer;VpaVisualizar : Boolean);
      procedure ImprimeOrdemProducaoEtikArt(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta;VpaVisualizar : Boolean);
      procedure ImprimeRomaneioSeparacaoCotacao(VpaCotacoes : TList);
  end;
implementation

Uses FunSql, constantes, funObjeto, funString, FunData, UnContasAReceber, FunNumeros;

{ TRBDVendaClienteMes }

{******************************************************************************}
constructor TRBDVendaClienteMes.cria;
begin
  inherited create;
  IndReducaoVenda := false;
end;

{******************************************************************************}
destructor TRBDVendaClienteMes.destroy;
begin
  inherited destroy;
end;

{ TRBDVendaClienteAno }

{******************************************************************************}
Constructor TRBDVendaClienteAno.cria;
begin
  inherited create;
  Meses := TList.Create;
  IndReducaoVenda := false;
end;

{******************************************************************************}
destructor TRBDVendaClienteAno.destroy;
begin
  FreeTObjectsList(Meses);
  inherited destroy;
end;

{******************************************************************************}
function TRBDVendaClienteAno.addMes : TRBDVendaClienteMes;
begin
  result := TRBDVendaClienteMes.cria;
  Meses.add(result);
end;

{ TRBDVendaCliente }

{******************************************************************************}
Constructor TRBDVendaCliente.cria;
begin
  inherited create;
  Anos := TLIst.Create;
end;

{******************************************************************************}
destructor TRBDVendaCliente.destroy;
begin
  FreeTObjectsList(Anos);
  Anos.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDVendaCliente.addAno : TRBDVendaClienteAno;
begin
  Result := TRBDVendaClienteAno.cria;
  Anos.Add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Dados da classe dos tamanhos dos produtos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************************************************}
constructor TRBDTamanhoProdutoRave.cria;
begin
  inherited create;
end;

{********************************************************************}
destructor TRBDTamanhoProdutoRave.destroy;
begin

  inherited;
end;

{ TRBDTamanhoProdutoRave }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Dados da classe das cores dos produtos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************************************************}
function TRBDCorProdutoRave.addTamanho: TRBDTamanhoProdutoRave;
begin
  result := TRBDTamanhoProdutoRave.cria;
  Tamanhos.add(result);
end;

{********************************************************************}
constructor TRBDCorProdutoRave.cria;
begin
  inherited create;
  Tamanhos := TList.Create;
end;

{********************************************************************}
destructor TRBDCorProdutoRave.destroy;
begin
  FreeTObjectsList(Tamanhos);
  Tamanhos.free;
  inherited;
end;
{ TRBDCorProdutoRave }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Dados da classe dos produtos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************************************************}
function TRBDProdutoRave.AddCor: TRBDCorProdutoRave;
begin
  result := TRBDCorProdutoRave.cria;
  Cores.Add(result);
end;

{********************************************************************}
constructor TRBDProdutoRave.cria;
begin
  inherited create;
  Cores := TList.create;
  QtdEstoque := 0;
  ValEstoque := 0;
end;

{********************************************************************}
destructor TRBDProdutoRave.destroy;
begin
  FreeTObjectsList(Cores);
  Cores.free;
  inherited;
end;
{ TRBDProdutoRave }


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Funcoes de impressao do relatorio
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ TRBFunRave }

{********************************************************************}
constructor TRBFunRave.cria(VpaBaseDados: TSQLConnection);
begin
  inherited create;
  Aux := TSqlQuery.create(nil);
  Aux.SqlConnection := VpaBaseDAdos;
  Tabela := TSqlQuery.create(nil);
  Tabela.SqlConnection := VpaBaseDAdos;
  Clientes := TSqlQuery.create(nil);
  Clientes.SQLConnection := VpaBaseDados;
  VprCabecalhoEsquerdo := TStringList.Create;
  VprCabecalhoDireito := TStringList.create;
  FunClassificacao := TFuncoesClassificacao.criar(NIL,VpaBaseDados);
  VprNiveis := TList.Create;

  RvSystem := TRvSystem.Create(nil);
  RVSystem.SystemPrinter.MarginBottom  := 1;
  RVSystem.SystemPrinter.MarginLeft    := 1;
  RVSystem.SystemPrinter.MarginTop     := 1;
  RVSystem.SystemPrinter.MarginBottom  := 1;
  RVSystem.SystemPrinter.Units         := unCM;
  RVSystem.SystemPrinter.UnitsFactor   := 2.54;
  rpDev.SelectPaper('A4',false);
  rpDev.Copies                          := 1;
  RvPDF := TRvRenderPDF.Create(nil);
  RVSystem.SystemPrinter.Copies        := rpDev.Copies;
  rpDev.Orientation                     := poPortrait;
  RVSystem.SystemPrinter.Orientation   := rpDev.Orientation;
  RVSystem.SystemPreview.RulerType     := rtBothCm;
  RVSystem.SystemSetups := RVSystem.SystemSetups - [ssAllowSetup];
  RVSystem.SystemPreview.FormState     := wsMaximized;
end;

{********************************************************************}
destructor TRBFunRave.destroy;
begin
  Tabela.close;
  Tabela.free;
  Aux.close;
  Aux.free;
  Clientes.close;
  Clientes.free;
  RVSystem.free;
  RvPDF.free;
  VprCabecalhoEsquerdo.free;
  VprCabecalhoDireito.free;
  FunClassificacao.free;
  FreeTObjectsList(VprNiveis);
  inherited;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaProdutosComDefeito(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,2.6,0.1,Boxlinenone,0); //Codigo Produto
     SetTab(NA,pjLeft,7.6,0.5,Boxlinenone,0); //nomeproduto
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd Defeito
     SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //Per Defeito
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Val Perdido
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaProdutosPorClassificacao(VpaObjeto :TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,2.6,0.1,Boxlinenone,0); //Codigo Produto
     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,7.8,0.5,Boxlinenone,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,8.7,0.5,Boxlinenone,0) //nomeproduto
       else
         if (config.EstoquePorTamanho) then
           SetTab(NA,pjLeft,10.3,0.5,Boxlinenone,0) //nomeproduto
         else
           SetTab(NA,pjLeft,11.3,0.5,Boxlinenone,0); //nomeproduto
     if (config.EstoquePorCor) then
       SetTab(NA,pjLeft,2.6,0.2,Boxlinenone,0); //Cor
     if (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Valor total
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     SaveTabs(2);
   end;
end;

(******************************************************************************)
procedure TRBFunRave.DefineTabelaProdutosVendidoseTrocados(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,8,0.1,Boxlinenone,0); //espaco vazio
     SetTab(NA,pjCenter,4.6,0.3,BOXLINEBOTTOM,0); //vendas
     SetTab(NA,pjCenter,0.2,0.3,BOXLINENONE,0); //
     SetTab(NA,pjCenter,4.6,0.3,BOXLINEBOTTOM,0); //Trocas
     SaveTabs(2);
     clearTabs;
     SetTab(1.2,pjLeft,2,0.1,Boxlinenone,0); //Codigo Produto
     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,4.8,0.5,Boxlinenone,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,5.7,0.5,Boxlinenone,0) //nomeproduto
       else
         if (config.EstoquePorTamanho) then
           SetTab(NA,pjLeft,7.3,0.5,Boxlinenone,0) //nomeproduto
         else
           SetTab(NA,pjLeft,5.8,0.5,Boxlinenone,0); //nomeproduto
     if (config.EstoquePorCor) then
       SetTab(NA,pjLeft,1.5,0.2,Boxlinenone,0); //Cor
     if (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd vendida
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Valor total vendido
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd trocado
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Valor total trocado
     SetTab(NA,pjRight,2,0,Boxlinenone,0); //percentual
     SaveTabs(3);
   end;
end;

(******************************************************************************)
procedure TRBFunRave.DefineTabelaEstoqueProdutos(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,3.0,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,2.6,0.1,Boxlinenone,0); //Codigo Produto
     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,7.8,0.5,Boxlinenone,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,8.2,0.5,Boxlinenone,0) //nomeproduto
       else
         if (config.EstoquePorTamanho) then
           SetTab(NA,pjLeft,10.3,0.5,Boxlinenone,0) //nomeproduto
         else
           SetTab(NA,pjLeft,11.3,0.5,Boxlinenone,0); //nomeproduto
     if (config.EstoquePorCor) and (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,2.6,0.2,Boxlinenone,0) //Cor
     else
       SetTab(NA,pjLeft,3.1,0.2,Boxlinenone,0); //Cor
     if (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Valor total
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaQtdMinimas(VpaObjeto : TObject);
var
  VpfTamanhoColProduto : Double;
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.5,pjLeft,1.6,0.1,Boxlinenone,0); //Codigo Produto
     VpfTamanhoColProduto := 10;
     if not config.EstoquePorCor then
       VpfTamanhoColProduto := VpfTamanhoColProduto +1;
     if not config.EstoquePorTamanho then
       VpfTamanhoColProduto := VpfTamanhoColProduto +1;
     SetTab(NA,pjLeft,VpfTamanhoColProduto,0.5,Boxlinenone,0); //nomeproduto
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     if  config.EstoquePorCor then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Cor
     if config.EstoquePorTamanho then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Qtd Atal
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Qtd Minima
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Qtd Ideal
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Qtd Faltante
     SetTab(NA,pjRight,2.1,0,Boxlinenone,0); //Val Unitario
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Valor total
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaResumoCaixas(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1,pjLeft,3.5,0.1,Boxlinenone,0); //Banco
     SetTab(NA,pjRight,2.4,0.4,Boxlinenone,0); //Conta
     SetTab(NA,pjLeft,5,0.4,Boxlinenone,0); //Correntista
     SetTab(NA,pjRight,2.7,0,Boxlinenone,0); //Saldo Conta
     SetTab(NA,pjRight,2.7,0,Boxlinenone,0); //Val Cheques
     SetTab(NA,pjRight,2.7,0,Boxlinenone,0); //Saldo Real
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaRomaneioEtikArt(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjcenter,1.8,0.5,BOXLINEALL,0); //nro Pedido
     SetTab(NA,pjCenter,2.5,0.5,BOXLINEALL,0); //codigo Produto
     SetTab(NA,pjCenter,3.5,0.5,BOXLINEALL,0); //manequim
     SetTab(NA,pjcenter,2.3,0.5,BOXLINEALL,0); //Combinacoes
     SetTab(NA,pjCenter,1.5,0.5,BOXLINEALL,0); //fitas
     SetTab(NA,pjright,1.8,0.5,BOXLINEALL,0); //Metros fita
     SetTab(NA,pjright,2,0.5,BOXLINEALL,0); //total KM
     SetTab(NA,pjright,2.3,0.5,BOXLINEALL,0); //Val Unitario
     SetTab(NA,pjright,2.3,0.5,BOXLINEALL,0); //Val total
     SetTab(NA,pjleft,8,0.5,BOXLINEALL,0); //Descricao
     SaveTabs(1);
     clearTabs;
     SetTab(12.5,pjLeft,2,0.1,BOXLINEALL,0); //icms
     SetTab(NA,pjRight,1.9,0.5,BOXLINEALL,0); //Val icms
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaRomaneioSeparacaoCotacao(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjLeft,2.5,0.5,BOXLINEALL,0);//codigo Produto
     SetTab(NA,pjLeft,7,0.5,BOXLINEALL,0); //nomeProduto
     SetTab(NA,pjLeft,1.5,0.5,BOXLINEALL,0); //Localição
     SetTab(NA,pjCenter,1,0.5,BOXLINEALL,0); //UM
     SetTab(NA,pjright,1.8,0.5,BOXLINEALL,0); //Quantidade
     SetTab(NA,pjright,2,0.5,BOXLINEALL,0); //Altura
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaTabelaPreco(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,3.0,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,3.6,0.1,Boxlinenone,0); //Codigo Produto
     if (config.EstoquePorCor) and config.EstoquePorTamanho then
       SetTab(NA,pjLeft,8.8,0.5,Boxlinenone,0) //nomeproduto
     else
       if (config.EstoquePorCor) then
         SetTab(NA,pjLeft,9.2,0.5,Boxlinenone,0) //nomeproduto
       else
         if (config.EstoquePorTamanho) then
           SetTab(NA,pjLeft,11.3,0.5,Boxlinenone,0) //nomeproduto
         else
           SetTab(NA,pjLeft,12.3,0.5,Boxlinenone,0); //nomeproduto
     if config.EstoquePorCor then
     begin
       if (config.EstoquePorCor) and (config.EstoquePorTamanho) then
         SetTab(NA,pjLeft,2.6,0.2,Boxlinenone,0) //Cor
       else
         SetTab(NA,pjLeft,3.1,0.2,Boxlinenone,0); //Cor
     end;
     if (config.EstoquePorTamanho) then
       SetTab(NA,pjLeft,1,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.6,0,Boxlinenone,0); //Valor total
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaTotalAmostraporVendedor(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,7.0,0.5,BOXLINEALL,0); //Vendedor
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd solicitada
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd Entregue
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd Aprovadas
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Qtd Clientes;
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Per Aprovacao;
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaTotalTipoCotacaoXCusto(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjRight,1.0,0.5,BOXLINEALL,0); //Codigo
     SetTab(NA,pjleft,7.0,0.2,BOXLINEALL,0); //Tipo Cotacao
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Qtd Pedidos
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Total Total
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Val Produtos
     SetTab(NA,pjRight,2.5,0.2,BOXLINEALL,0); //Val Custo
     SetTab(NA,pjRight,1,0.2,BOXLINEALL,0); //%Produto
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaAnaliseFaturamentoMensal(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,10,0.5,BoxlineNONE,0); //Vendedor
     SaveTabs(1);
     clearTabs;
     SetTab(1,pjLeft,6.5,0.1,BOXLINEALL,0); //Cliente
     SetTab(NA,pjCenter,1,0,BOXLINEALL,0); //ano
     SetTab(NA,pjRight,1.5,0,BOXLINEALL,0); //Janeiro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Fevereiro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Março
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Abril
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Maio
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Junho
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Julho
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Agosto
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Setembro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Outubro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Novembro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Dezembro
     SetTab(NA,pjRight,1.5,0.2,BOXLINEALL,0); //Total
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCPporPlanoContas(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo planoContas
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomPlanoContas
     SaveTabs(1);
     clearTabs;
     SetTab(1.5,pjLeft,7.8,0.1,Boxlinenone,0); //Fornecedor
     SetTab(NA,pjRight,1.9,0.5,Boxlinenone,0); //nro Nota
     SetTab(NA,pjCenter,2.0,0.2,Boxlinenone,0); //vencimento
     SetTab(NA,pjRight,2.5,0.2,Boxlinenone,0); //Valor a pagar
     SetTab(NA,pjCenter,2.0,0,Boxlinenone,0); //DtPagamento
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Valor  PAGO
     SaveTabs(2);
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Valor Previsto
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //Valor total
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //Valor total Pago
     SaveTabs(3);
     clearTabs;
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCPporPlanoContasSintetico(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(0.8,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo planoContas
     SetTab(NA,pjleft,7.5,0.5,BoxlineNONE,0); //NomPlanoContas
     SetTab(NA,pjRight,2,0.5,Boxlinenone,0); //Valor a pagar
     SetTab(NA,pjRight,2,0.5,Boxlinenone,0); //Valor pago
     SetTab(NA,pjRight,2,0.5,Boxlinenone,0); //Valor total
     SetTab(NA,pjRight,2,0.5,Boxlinenone,0); //Valor previsto
     SetTab(NA,pjRight,1.2,0.5,Boxlinenone,0); //% diferenca
     SaveTabs(1);
   end;

end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCPporPlanoContasSinteticoporMes(VpaObjeto: TObject);
begin
  with RVSystem.BaseReport do begin
    clearTabs;
    SetTab(0.8,pjleft,2,0.5,BoxlineNONE,0); //Codigo planoContas
    SetTab(NA,pjleft,4.5,0.5,BoxlineNONE,0); //NomPlanoContas
    SetTab(NA,pjLeft,0.65,0.1,Boxlinenone,0); //Ano
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Janeiro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Fevereiro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Marco
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Abril
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Maio
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Junho
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Julho
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Agosto
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Setembro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Outubro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Novembro
    SetTab(NA,pjRight,1.6,0.1,Boxlinenone,0); //Dezembro
    SetTab(NA,pjRight,1.65,0.1,Boxlinenone,0); //Total
    SaveTabs(1);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaCustoProjeto(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo planoContas
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomPlanoContas
     SaveTabs(1);
     clearTabs;
     SetTab(1.5,pjLeft,9,0.1,Boxlinenone,0); //Fornecedor
     SetTab(NA,pjRight,1.9,0.5,Boxlinenone,0); //nro Nota
     SetTab(NA,pjCenter,2.0,0.2,Boxlinenone,0); //Emissão
     SetTab(NA,pjRight,2.5,0.2,Boxlinenone,0); //Valor a pagar
     SetTab(NA,pjRight,2.5,0,Boxlinenone,0); //Percentual Conta
     SaveTabs(2);
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Valor Previsto
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //Valor total
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //Valor total Pago
     SaveTabs(3);
     clearTabs;
     SetTab(2.0,pjCenter,18,0.5,BoxlineNONE,0); //Valor Previsto
     SaveTabs(4);
     clearTabs;
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaEntradaMetro(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,5.0,0.5,BOXLINEALL,0); //Familia
     SetTab(NA,pjCenter,7,0.5,BOXLINEALL,0); //Amostra
     SetTab(NA,pjCenter,7,0.5,BOXLINEALL,0); //Pedido
     SetTab(NA,pjCenter,7,0.5,BOXLINEALL,0); //Total
     SaveTabs(1);
     clearTabs;
     SetTab(1.0,pjleft,5.0,0.5,BOXLINEALL,0); //Familia
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Qtd Metros Amostra
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Valor Amostra
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Qtd Metros Pedido
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Valor Pedidos
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Qtd Metros Total
     SetTab(NA,pjRight,3.5,0.5,BOXLINEALL,0); //Valor Total
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaExtratoProdutividade(VpaObjeto : TObject);
var
  VpfLaco : Integer;
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(0.8,pjLeft,4,0.1,BOXLINEALL,0); //CelulaTrabalho
     for VpfLaco := 1 to 31 do
       SetTab(NA,pjRight,0.75,0,BOXLINEALL,0); //Dia do mes
     SetTab(NA,pjRight,1.3,0,BOXLINEALL,0); //Dia do mes
     SaveTabs(1);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaFechamentoEstoque(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.2,pjLeft,1.2,0.1,Boxlinenone,0); //Codigo Produto
     SetTab(NA,pjLeft,9.4,0.5,Boxlinenone,0); //nomeproduto
     SetTab(NA,pjRight,2.2,0,Boxlinenone,0); //qtd vendas
     SetTab(NA,pjRight,2.2,0,Boxlinenone,0); //Valor Vendas
     SetTab(NA,pjRight,2.2,0,Boxlinenone,0); //custo
     SetTab(NA,pjRight,1.8,0,Boxlinenone,0); //margem
     SaveTabs(2);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.DefineTabelaOPEtikArt(VpaObjeto: TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(0.5,pjright,2.1,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,3.3,0.5,BoxlineNONE,0);
     SetTab(NA,pjright,2.2,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,1.9,0.5,BoxlineNONE,0);
     SaveTabs(1);
     clearTabs;
     SetTab(0.5,pjright,2.1,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,1.5,0.5,BoxlineNONE,0);
     SetTab(NA,pjright,1.5,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,1.5,0.5,BoxlineNONE,0);
     SetTab(NA,pjright,2.0,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,0.9,0.5,BoxlineNONE,0);
     SaveTabs(2);
     clearTabs;
     SetTab(0.5,pjright,2.1,0.5,BoxlineNONE,0);
     SetTab(NA,pjleft,7.4,0.5,BoxlineNONE,0);
     SaveTabs(3);
     clearTabs;
     SetTab(0.5,pjcenter,9.5,0.5,BoxlineNONE,0);
     SaveTabs(4);
     clearTabs;
     SetTab(0.5,pjCenter,0.7,0.5,BoxlineNONE,0);//combinacao
     SetTab(NA,pjcenter,0.7,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjleft,3.6,0.5,BoxlineNONE,0);//cor
     SetTab(NA,pjleft,2.5,0.5,BoxlineNONE,0);//titulo
     SetTab(NA,pjright,2.0,0.5,BoxlineNONE,0);//fundo
     SaveTabs(5);
     clearTabs;
     SetTab(0.5,pjCenter,0.7,0.5,BoxlineNONE,0);//combinacao
     SetTab(NA,pjcenter,0.7,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjleft,2.6,0.5,BoxlineNONE,0);//cor
     SetTab(NA,pjleft,2.0,0.5,BoxlineNONE,0);//titulo
     SetTab(NA,pjright,1.5,0.5,BoxlineNONE,0);//fundo
     SetTab(NA,pjright,2.0,0.5,BoxlineNONE,0);//Qtd Peças
     SaveTabs(6);
     clearTabs;
     SetTab(0.5,pjcenter,1.9,0.5,BoxlineNONE,0);//combinacao
     SetTab(NA,pjcenter,1.9,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjcenter,1.9,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjcenter,1.9,0.5,BoxlineNONE,0); //fitas
     SetTab(NA,pjcenter,1.9,0.5,BoxlineNONE,0); //fitas
     SaveTabs(7);
     clearTabs;
     SetTab(0.5,pjCenter,0.7,0.5,BoxlineNONE,0);//combinacao
     SetTab(NA,pjcenter,1.2,0.5,BoxlineNONE,0); //manequim
     SetTab(NA,pjright,3,0.5,BoxlineNONE,0);//metros por fita;
     SetTab(NA,pjright,2.5,0.5,BoxlineNONE,0);//Qtd Fitas
     SaveTabs(8);
   end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutoPorClassificacao(VpaObjeto : TObject);
var
  VpfQtdProduto,VpfQtdGeral, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual,  VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  VprUfAtual := '';
  VpfDClassificacao := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
          SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
          VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
          VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
        end;

        if VprAgruparPorEstado and (VprUFAtual <> Tabela.FieldByName('C_EST_CLI').AsString)  then
        begin
          ImprimeTotaisNiveis(VprNiveis,0);
          ImprimeTituloUF(Tabela.FieldByName('C_EST_CLI').AsString);
          VprUFAtual := Tabela.FieldByName('C_EST_CLI').AsString;
          VpfClassificacaoAtual := '';
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('UMPADRAO').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
      end;
      vpfDCor := RCorProduto(VpfDProduto,Tabela.FieldByName('I_COD_COR').AsInteger);
      VpfDTamanho := RTamanhoProduto(vpfDCor,Tabela.FieldByName('I_COD_TAM').AsInteger);

      VpfQtdProduto := FunProdutos.CalculaQdadePadrao( Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,
                                       Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
      VpfDProduto.QtdEstoque := VpfDProduto.QtdEstoque + VpfQtdproduto;
      VpfDProduto.ValEstoque := VpfDProduto.ValEstoque + Tabela.FieldByName('N_VLR_TOT').AsFloat;

      vpfDCor.QtdEstoque := vpfDCor.QtdEstoque+ VpfQtdproduto;
      VpfDCor.ValEstoque := VpfDCor.ValEstoque + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      VpfDTamanho.QtdEstoque := VpfDTamanho.QtdEstoque + VpfQtdproduto;
      VpfDTamanho.ValEstoque := VpfDTamanho.ValEstoque + Tabela.FieldByName('N_VLR_TOT').AsFloat;

      VpfQtdGeral := VpfQTdGeral + VpfQtdProduto;
      VpfValGeral := VpfValGeral + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);

    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
      VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
      VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    if config.EstoquePorCor then
      PrintTab('');
    if config.EstoquePorTamanho then
      PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.SalvaTabelaPrecoPorCoreTamanho(VpaDProduto: TRBDProdutoRave);
var
  VpfLacoCor, vpfLacoTamanho : Integer;
  VpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  with RVSystem.BaseReport do
  begin
    PrintTab(VpaDProduto.CodProduto);
    PrintTab(VpaDProduto.NomProduto);
    VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[0]);
    VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count = 1) then
      begin
        if config.EstoquePorCor then
        begin
          if (VpfDCor.CodCor <> 0) then
            PrintTab(VpfDCor.NomCor)
          else
            PrintTab('');
        end;
        if config.EstoquePorTamanho then
        begin
          if (VpfDCor.Tamanhos.Count = 1) then
          begin
            if (VpfDTamanho.CodTamanho <> 0) then
              PrintTab(VpfDTamanho.NomTamanho)
            else
              PrintTab('');
          end;
        end;
      end
      else
      begin
        if config.EstoquePorCor then
          PrintTab('');
        if config.EstoquePorTamanho then
          PrintTab('');
      end;
    end;
    PrintTab(FormatFloat(VpaDProduto.DesCifraoMoeda+ ' '+ varia.MascaraValor,VpaDProduto.ValEstoque));
    PrintTab('  '+VpaDProduto.DesUM);
    newline;
    If LinesLeft<=1 Then
      NewPage;
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count > 1) or (VpfDCor.Tamanhos.count > 1) then
      begin
        for VpfLacoCor := 0 to VpaDProduto.Cores.Count - 1 do
        begin
          VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]);
          PrintTab('');//codigo produto
          PrintTab('');//nome produto
          PrintTab(IntToStr(VpfDCor.CodCor)+'-'+ VpfDCor.NomCor);
          if (VpfDCor.Tamanhos.Count = 1) and
              config.EstoquePorTamanho then
          begin
            VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
            PrintTab(VpfDTamanho.NomTamanho);
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque));
            PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
          end
          else
          begin
            if config.EstoquePorTamanho then
              PrintTab('');//tamanho
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDCor.QtdEstoque));
            PrintTab(FormatFloat(varia.MascaraValor,VpfDCor.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
            if config.EstoquePorTamanho then
            begin
              for vpfLacoTamanho := 0 to VpfDCor.Tamanhos.Count - 1 do
              begin
                VpfDtamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[VpfLacoTamanho]);
                PrintTab('');//codigo produto
                PrintTab('');//nome produto
                PrintTab('');//cor
                PrintTab(VpfDTamanho.NomTamanho);
                PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque));
                PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
                newline;
                If LinesLeft<=1 Then
                  NewPage;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.SalvaTabelaProdutosComDefeito(VpaDProduto: TRBDProdutoRave);
var
  VpfLacoCor, vpfLacoTamanho : Integer;
  VpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
  VpfPerDefeito : Double;
begin
  with RVSystem.BaseReport do
  begin
    PrintTab(VpaDProduto.CodProduto);
    PrintTab(VpaDProduto.NomProduto);
    PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdEstoque));
    PrintTab(FormatFloat(varia.MascaraValor,VpaDProduto.QtdTrocada));
    if (VpaDProduto.QtdEstoque > 0) and (VpaDProduto.QtdTrocada > 0) then
    begin
      vpfperDefeito := (VpaDProduto.QtdTrocada*100)/VpaDProduto.QtdEstoque;
      if VpfPerDefeito > 15 then
        FontColor := clred;
      if VpfPerDefeito > 50 then
        Bold := true;
      PrintTab(FormatFloat('0.00%',VpfPerDefeito));
      FontColor := clBlack;
      Bold := false;
    end
    else
      PrintTab('');
    PrintTab(FormatFloat(varia.MascaraValor,VpaDProduto.ValTroca));
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.SalvaTabelaProdutosPorCoreTamanho(VpaDProduto: TRBDProdutoRave);
var
  VpfLacoCor, vpfLacoTamanho : Integer;
  VpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  with RVSystem.BaseReport do
  begin
    PrintTab(VpaDProduto.CodProduto);
    PrintTab(VpaDProduto.NomProduto);
    VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[0]);
    VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count = 1) then
      begin
        if config.EstoquePorCor then
        begin
          if (VpfDCor.CodCor <> 0) then
            PrintTab(VpfDCor.NomCor)
          else
            PrintTab('');
        end;
        if config.EstoquePorTamanho then
        begin
          if (VpfDCor.Tamanhos.Count = 1) then
          begin
            if (VpfDTamanho.CodTamanho <> 0) then
              PrintTab(VpfDTamanho.NomTamanho)
            else
              PrintTab('');
          end;
        end;
      end
      else
      begin
        if config.EstoquePorCor then
          PrintTab('');
        if config.EstoquePorTamanho then
          PrintTab('');
      end;
    end;
    PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdEstoque));
    PrintTab(FormatFloat(varia.MascaraValor,VpaDProduto.ValEstoque));
    if (RvSystem.Tag = 16) then //relatorio de produtos vendidos e trocados
    begin                       //adiciona nas proximas colunas os valores das trocas;
      SalvaTabelaTrocasProdutos(VpaDProduto);
      exit;
    end;
    PrintTab('  '+VpaDProduto.DesUM);
    newline;
    If LinesLeft<=1 Then
      NewPage;
    if config.EstoquePorCor or config.EstoquePorTamanho  then
    begin
      if (VpaDProduto.Cores.Count > 1) or (VpfDCor.Tamanhos.count > 1) then
      begin
        for VpfLacoCor := 0 to VpaDProduto.Cores.Count - 1 do
        begin
          VpfDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]);
          PrintTab('');//codigo produto
          PrintTab('');//nome produto
          PrintTab(IntToStr(VpfDCor.CodCor)+'-'+ VpfDCor.NomCor);
          if (VpfDCor.Tamanhos.Count = 1) and
              config.EstoquePorTamanho then
          begin
            VpfDTamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[0]);
            PrintTab(VpfDTamanho.NomTamanho);
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque));
            PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
          end
          else
          begin
            if config.EstoquePorTamanho then
              PrintTab('');//tamanho
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDCor.QtdEstoque));
            PrintTab(FormatFloat(varia.MascaraValor,VpfDCor.ValEstoque));
            PrintTab('  ');
            newline;
            If LinesLeft<=1 Then
              NewPage;
            if config.EstoquePorTamanho then
            begin
              for vpfLacoTamanho := 0 to VpfDCor.Tamanhos.Count - 1 do
              begin
                VpfDtamanho := TRBDTamanhoProdutoRave(VpfDCor.Tamanhos.Items[VpfLacoTamanho]);
                PrintTab('');//codigo produto
                PrintTab('');//nome produto
                PrintTab('');//cor
                PrintTab(VpfDTamanho.NomTamanho);
                PrintTab(FormatFloat(varia.MascaraQtd,VpfDTamanho.QtdEstoque));
                PrintTab(FormatFloat(varia.MascaraValor,VpfDTamanho.ValEstoque));
                newline;
                If LinesLeft<=1 Then
                  NewPage;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
procedure TRBFunRave.SalvaTabelaTrocasProdutos(VpaDProduto: TRBDProdutoRave);
begin
  CarValorTrocasProdutos(VpaDProduto,VprDatInicio,VprDatFim,VpaDProduto.SeqProduto);
  with RVSystem.BaseReport do
  begin
    PrintTab(FormatFloat(varia.MascaraQtd,VpaDProduto.QtdTrocada));
    PrintTab(FormatFloat(varia.MascaraValor,VpaDProduto.ValTroca));
    if (VpaDProduto.QtdEstoque <> 0) and (VpaDProduto.QtdTrocada <> 0) then
      PrintTab(FormatFloat('#,##0.00 %',(VpaDProduto.QtdTrocada *100)/VpaDProduto.QtdEstoque ));
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelEstoqueProdutos(VpaObjeto : TObject);
var
  VpfQtdProduto, VpfQtdGeral, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual, VpfUM : string;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
  VpfDClassificacao : TRBDClassificacaoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  VpfDClassificacao := nil;
  VpfDProduto := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
          SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        if VpfDProduto <> nil then
          VpfDProduto.free;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('C_COD_UNI').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
//       if varia.CNPJFilial = CNPJ_AtelierduCristal then
//         PrintTab(Tabela.FieldByName('C_BAR_FOR').AsString)
      end;

      vpfDCor := RCorProduto(VpfDProduto,Tabela.FieldByName('I_COD_COR').AsInteger);
      VpfDTamanho := RTamanhoProduto(vpfDCor,Tabela.FieldByName('I_COD_TAM').AsInteger);

      if RvSystem.Tag = 2 then
        VpfQtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat
      else
        if RvSystem.Tag = 12 then
          VpfQtdProduto := Tabela.FieldByName('N_QTD_RES').AsFloat;

      VpfDProduto.QtdEstoque := VpfDProduto.QtdEstoque + VpfQtdProduto;
      VpfDProduto.ValEstoque := VpfDProduto.ValEstoque + (VpfQtdProduto * Tabela.FieldByName('N_VLR_CUS').AsFloat);
      vpfDCor.QtdEstoque := vpfDCor.QtdEstoque+ VpfQtdProduto;
      VpfDCor.ValEstoque := VpfDCor.ValEstoque + (VpfQtdProduto * Tabela.FieldByName('N_VLR_CUS').AsFloat);
      VpfDTamanho.QtdEstoque := VpfDTamanho.QtdEstoque + VpfQtdProduto;
      VpfDTamanho.ValEstoque := VpfDTamanho.ValEstoque + (VpfQtdProduto * Tabela.FieldByName('N_VLR_CUS').AsFloat);

      VpfQtdGeral := VpfQTdGeral +VpfQtdProduto;
      VpfValGeral := VpfValGeral + (VpfQtdProduto * Tabela.FieldByName('N_VLR_CUS').AsFloat);
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaProdutosPorCoreTamanho(VpfDProduto);
    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    if config.EstoquePorCor then
      PrintTab('');
    if config.EstoquePorTamanho then
      PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotaisNiveis(VpaNiveis : TList;VpaIndice : integer);
var
  VpfLaco : Integer;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfQtdProduto, VpfValTotal,VpfQtdAnterior, VpfQtdVenda, VpfValAnterior,VpfValVenda, VpfValCustoVenda, VpfQtdTrocado,VpfValTrocado : Double;
begin
  VpfQtdproduto := 0;
  VpfValTotal := 0;
  VpfQtdAnterior := 0;
  VpfQtdVenda := 0;
  VpfValAnterior := 0;
  VpfValVenda := 0;
  VpfValCustoVenda := 0;
  for Vpflaco  := VpaNiveis.count -1 downto VpaIndice  do
  begin
    VpfDClassificacao := TRBDClassificacaoRave(VpaNiveis.items[VpfLaco]);
    with RVSystem.BaseReport do
    begin
      if VpfLaco = 0 then
      begin
        SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
        FillRect(CreateRect(MarginLeft-0.1,YPos+LineHeight-1+0.3,PageWidth-0.3,YPos+0.1));
      end;
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto + VpfQtdProduto;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfValTotal;
      VpfDClassificacao.QtdMesAnterior := VpfDClassificacao.QtdMesAnterior + VpfQtdAnterior;
      VpfDClassificacao.ValAnterior := VpfDClassificacao.ValAnterior + VpfValAnterior;
      VpfDClassificacao.QtdVenda := VpfDClassificacao.QtdVenda + VpfQtdVenda;
      VpfDClassificacao.QtdTrocado  := VpfDClassificacao.QtdTrocado + VpfQtdTrocado;
      VpfDClassificacao.ValTrocado  := VpfDClassificacao.QtdTrocado + VpfValTrocado;
      VpfDClassificacao.ValVenda := VpfDClassificacao.ValVenda + VpfValVenda;
      VpfDClassificacao.ValCustoVenda := VpfDClassificacao.ValCustoVenda + VpfValCustoVenda;
      PrintTab('');
      if VpfLaco > 0 then
        PrintTab('Total Classificação : '+VpfDClassificacao.CodClassificacao+'-'+VpfDClassificacao.NomClassificacao)
      else
      begin
        if VprAgruparPorEstado then
          PrintTab('Total '+VprUfAtual)
        else
          PrintTab('');
      end;

      bold := true;
      if RvSystem.tag = 6 then
      begin
        PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.QtdVenda));
        PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.ValVenda));
        PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.ValCustoVenda));
        if VpfDClassificacao.ValCustoVenda <> 0  then
          PrintTab(FormatFloat('#,##0.00%',(((VpfDClassificacao.ValVenda/VpfDClassificacao.ValCustoVenda)-1)*100)))
        else
          PrintTab(FormatFloat('0.00%',0));
      end
      else
        if RvSystem.tag = 19 then
        begin
          PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.QTdProduto));
          PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.QtdTrocado));
          if (VpfDClassificacao.QTdProduto <> 0) and  (VpfDClassificacao.QtdTrocado <> 0) then
            PrintTab(FormatFloat('0.00%',(VpfDClassificacao.QtdTrocado*100)/VpfDClassificacao.QTdProduto))
          else
            PrintTab('');
          PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDClassificacao.VAlTrocado));
        end
        else
        begin
          if config.EstoquePorCor then
            PrintTab('');
          if config.EstoquePorTamanho then
            PrintTab('');
          if RvSystem.Tag = 4 then
          begin
            PrintTab('');
            PrintTab('');
          end;
          PrintTab(FormatFloat(varia.MascaraQtd,VpfDClassificacao.QtdProduto));
          if RvSystem.Tag = 4 then
            PrintTab('');
          PrintTab(FormatFloat(varia.MascaraValor,VpfDClassificacao.ValTotal));
          if RvSystem.tag = 16 then//produtos trocados
          begin
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDClassificacao.QtdTrocado));
            PrintTab(FormatFloat(varia.MascaraQtd,VpfDClassificacao.VAlTrocado));
            if (VpfDClassificacao.QTdProduto <> 0) and (VpfDClassificacao.QtdTrocado <> 0) then
              PrintTab(FormatFloat('#,##0.00 %',(VpfDClassificacao.QtdTrocado *100)/VpfDClassificacao.QTdProduto ));
          end;
          PrintTab('  ');
        end;
      VpfQtdProduto := VpfDClassificacao.QtdProduto;
      VpfValTotal := VpfDClassificacao.ValTotal;
      VpfQtdAnterior := VpfDClassificacao.QtdMesAnterior;
      VpfValAnterior := VpfDClassificacao.ValAnterior;
      VpfQtdVenda := VpfDClassificacao.QtdVenda;
      VpfValVenda := VpfDClassificacao.ValVenda;
      VpfValCustoVenda := VpfDClassificacao.ValCustoVenda;
      VpfQtdTrocado := VpfDClassificacao.QtdTrocado;
      VpfValTrocado := VpfDClassificacao.VAlTrocado;

      newline;
      If LinesLeft<=1 Then
        NewPage;
      Bold := false;
    end;
    VpfDClassificacao.free;
    VpaNiveis.delete(VpfLaco);
  end;
  if VpaIndice > 0  then
  begin
    VpfDClassificacao := TRBDClassificacaoRave(VpaNiveis.items[VpaIndice-1]);
    VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto + VpfQtdProduto;
    VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfValTotal;
    VpfDClassificacao.QtdMesAnterior := VpfDClassificacao.QtdMesAnterior + VpfQtdAnterior;
    VpfDClassificacao.ValAnterior := VpfDClassificacao.ValAnterior + VpfValAnterior;
    VpfDClassificacao.QtdVenda := VpfDClassificacao.QtdVenda + VpfQtdVenda;
    VpfDClassificacao.ValVenda := VpfDClassificacao.ValVenda + VpfValVenda;
    VpfDClassificacao.ValCustoVenda := VpfDClassificacao.ValCustoVenda + VpfValCustoVenda;
    VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado + VpfQtdTrocado;
    VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfValTrocado;
  end;
end;

procedure TRBFunRave.ImprimeTotaisNiveisPlanoContas(VpaNiveis : TList;VpaIndice : integer);
var
  VpfLaco : Integer;
  VpfDPlanoContas : TRBDPlanoContasRave;
  VpfValDuplicata, VpfValPago, VpfValPrevisto: Double;
begin
  VpfValDuplicata := 0;
  VpfValPrevisto := 0;
  VpfValPago := 0;
  for Vpflaco  := VpaNiveis.count -1 downto VpaIndice  do
  begin
    VpfDPlanoContas := TRBDPlanoContasRave(VpaNiveis.items[VpfLaco]);
    VpfDPlanoContas.free;
    VpaNiveis.delete(VpfLaco);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotalCelulaTrabalho(VpaValTotal: Double;VpaDiaAtua: Integer);
var
  VpfLaco : Integer;
begin
  with RVSystem.BaseReport do begin
    for VpfLaco := VpaDiaAtua to 30 do
      PrintTab('');

    PrintTab(FormatFloat('0',VpaValTotal));
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoEstoque;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Qtd');
      PrintTab('Valor');
      PrintTab('  UM');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoQtdMinima;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      PrintTab('  UM');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Qtd Atual');
      PrintTab('Qtd Min');
      PrintTab('Qtd Ideal');
      PrintTab('Qtd Faltante');
      PrintTab('Val Unit');
      PrintTab('Val Total');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoResumoCaixas;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Banco');
      PrintTab('Conta');
      PrintTab('  Correntista');
      PrintTab('Saldo Conta');
      PrintTab('Valor Cheques');
      PrintTab('Saldo Real');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoRomaneioEtikArt;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Nr. Pedido');
      PrintTab('Cod Produto');
      PrintTab('Manequim');
      PrintTab('Combinações');
      PrintTab('Fitas');
      PrintTab('Mts Fita ');
      PrintTab('Total KM ');
      PrintTab('Val Unitário ');
      PrintTab('Valor Total ');
      PrintTab(' Descrição');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoTabelaPreco;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Valor');
      PrintTab('  UM');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoTotalAmostrasVendedor;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Vendedor');
      PrintTab('Qtd Solicitada ');
      PrintTab('Qtd Entregue ');
      PrintTab('Qtd Aprovadas ');
      PrintTab('Qtd Clientes ');
      PrintTab('% Aprovação ');
      bold := false;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoTotalTipoPedidoXCusto;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab('Código');
      PrintTab('Tipo Cotação');
      PrintTab('Qtd');
      PrintTab('Val Total ');
      PrintTab('Total Produto ');
      PrintTab('Custo ');
      PrintTab('% ');
      bold := false;
      newline;
    end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoAnaliseFaturamento;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(1);
      bold := true;
      PrintTab(VprNomVendedor);
      Bold := false;
      newline;
      RestoreTabs(2);
      bold := true;
      PrintTab('Cliente');
      PrintTab('Ano');
      PrintTab('Janeiro');
      PrintTab('Fevereiro');
      PrintTab('Março');
      PrintTab('Abril');
      PrintTab('Maio');
      PrintTab('Junho');
      PrintTab('Julho');
      PrintTab('Agosto');
      PrintTab('Setembro');
      PrintTab('Outubro');
      PrintTab('Novembro');
      PrintTab('Dezembro');
      PrintTab('Total');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoFechamentoEstoque;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(2);
    bold := true;
    PrintTab('Código');
    PrintTab('Nome');
    PrintTab('Qtd');
    PrintTab('Valor');
    PrintTab('Custo');
    PrintTab('Margem');
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoPlanoContas;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(2);
    bold := true;
    PrintTab('Fornecedor');
    PrintTab('Nro Nota');
    PrintTab('Vcto');
    PrintTab('Valor a Pagar');
    PrintTab('Pgto');
    PrintTab('Valor Pago');
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoPlanoContasCustoProjeto;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(2);
    bold := true;
    PrintTab('Fornecedor');
    PrintTab('Nro Nota');
    PrintTab('Emissão');
    PrintTab('Valor');
    PrintTab('Percentual');
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoPorPlanoContasSintetico;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('Código');
    PrintTab('Plano Contas');
    PrintTab('Val Aberto ');
    PrintTab('Valor Pago');
    PrintTab('Valor Total');
    PrintTab('Val Previsto');
    PrintTab('%');
    Bold := false;
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

procedure TRBFunRave.ImprimeCabecalhoPorPlanoContasSinteticoporMes;
begin
  with RVSystem.BaseReport do
  begin
    SetFont('Arial',8);
    RestoreTabs(1);
    bold := true;
    PrintTab('Código');
    PrintTab('Plano Contas');
    PrintTab('Ano');
    PrintTab('Janeiro');
    PrintTab('Fevereiro');
    PrintTab('Março');
    PrintTab('Abril');
    PrintTab('Maio');
    PrintTab('Junho');
    PrintTab('Julho');
    PrintTab('Agosto');
    PrintTab('Setembro');
    PrintTab('Outubro');
    PrintTab('Novembro');
    PrintTab('Dezembro');
    PrintTab('Total');
    Bold := false;
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoProdutocomDefeito;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      PrintTab('Qtd Vendida');
      PrintTab('Qtd Defeitos');
      PrintTab('% Defeito ');
      PrintTab('Valor Perdido');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoProdutosVendidoseTrocados;
begin
    with RVSystem.BaseReport do
    begin
      RestoreTabs(2);
      bold := true;
      PrintTab('');
      PrintTab('Vendidos');
      PrintTab('');
      PrintTab('Trocados');
      newline;
      RestoreTabs(3);
      bold := true;
      PrintTab('Código');
      PrintTab('Nome');
      if config.EstoquePorCor then
        PrintTab('Cor');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho');
      PrintTab('Qtd');
      PrintTab('Valor');
      PrintTab('Qtd');
      PrintTab('Valor');
      PrintTab('  Percentual');
      Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoExtratoProdutividade;
var
  Vpflaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('Celula Trabalho');
    for VpfLaco := 1 to 31 do
    begin
      if (Vpflaco <= Dia(UltimoDiaMes(MontaData(1,vprmes,VprAno)))) then
      begin
        if (DiaSemanaNumerico(MontaData(Vpflaco,VprMes,VprAno)) in [1,7]) then
          FontColor := clRed;
      end;
      PrintTab(IntToStr(VpfLaco));
      FontColor := clblack;
    end;
    PrintTab('Total');
    Bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalhoEntradaMetros;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    PrintTab('');
    PrintTab('AMOSTRA');
    PrintTab('PEDIDO');
    PrintTab('TOTAL');
    Bold := false;

    newline;
    RestoreTabs(2);
    bold := true;
    PrintTab('  FAMÍLIA');
    PrintTab('METROS');
    PrintTab('VALOR');
    PrintTab('METROS');
    PrintTab('VALOR');
    PrintTab('METROS');
    PrintTab('VALOR');
    Bold := false;
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTituloUF(VpaCodUf : String);
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    bold := true;
    FontColor := clRed;
    PrintTab(VpaCodUf);
    Bold := false;
    FontColor := clBlack;
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTituloClassificacao(VpaNiveis : TList;VpaTudo : boolean);
var
  VpfLaco : Integer;
  VpfDClassificacao : TRBDClassificacaoRave;
begin
  for VpfLaco := 0 to VpaNiveis.Count - 1 do
  begin
    VpfDClassificacao := TRBDClassificacaoRave(Vpaniveis.Items[VpfLaco]);
    if (vpaTudo) or VpfDClassificacao.IndNovo  then
    begin
      VpfDClassificacao.Indnovo := false;
      with RVSystem.BaseReport do
      begin
        RestoreTabs(1);
        bold := true;
        PrintTab(AdicionaCharE(' ','',VpfLaco*1)+VpfDClassificacao.CodClassificacao);
        PrintTab(AdicionaCharE(' ','',VpfLaco*1)+VpfDClassificacao.NomClassificacao);
        Bold := false;
        newline;
        If LinesLeft<=1 Then
          NewPage;
      if VpaTudo then
        MarginTop := MarginTop+LineHeight;
      end;
    end;
  end;
  if VpaNiveis.Count > 0 then
  begin
    with RVSystem.BaseReport do
    begin
      case RvSystem.Tag of
       1,2,12 : ImprimeCabecalhoEstoque;
       4 : ImprimeCabecalhoQtdMinima;
       6 : ImprimeCabecalhoFechamentoEstoque;
       16 : ImprimeCabecalhoProdutosVendidoseTrocados;
       11 : ImprimeCabecalhoTabelaPreco;
       19 : ImprimeCabecalhoProdutocomDefeito;
      end;
      newline;
      If LinesLeft<=1 Then
        NewPage;
      if VpaTudo then
        MarginTop := MarginTop+LineHeight;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimetituloPlanoContas(VpaNiveis : TList;VpaTudo : boolean);
var
  VpfLaco : Integer;
  VpfDPlanoContas : TRBDPlanoContasRave;
begin
  for VpfLaco := 0 to VpaNiveis.Count - 1 do
  begin
    VpfDPlanoContas := TRBDPlanoContasRave(Vpaniveis.Items[VpfLaco]);
    if (vpaTudo) or VpfDPlanoContas.IndNovo  then
    begin
      VpfDPlanoContas.Indnovo := false;
      with RVSystem.BaseReport do
      begin
        RestoreTabs(1);
        bold := true;
        PrintTab(AdicionaCharE(' ','',VpfLaco*1)+VpfDPlanoContas.CodPlanoCotas);
        PrintTab(AdicionaCharE(' ','',VpfLaco*1)+VpfDPlanoContas.NomPlanoContas);
        Bold := false;
        newline;
        If LinesLeft<=1 Then
          NewPage;
      if VpaTudo then
        MarginTop := MarginTop+LineHeight;
      end;
    end;
  end;
  if VpaNiveis.Count > 0 then
  begin
    with RVSystem.BaseReport do
    begin
      case RvSystem.Tag of
       7 : ImprimeCabecalhoPlanoContas;
      10 : ImprimeCabecalhoPlanoContasCustoProjeto;
      end;
      newline;
      If LinesLeft<=1 Then
        NewPage;
      if VpaTudo then
        MarginTop := MarginTop+LineHeight;
    end;
  end;
end;

{******************************************************************************}
function TRBFunRave.RCorProduto(VpaDProduto: TRBDProdutoRave; VpaCodCor: Integer): TRBDCorProdutoRave;
var
  VpfLacoCor : Integer;
begin
  result := nil;
  for VpfLacoCor := 0 to VpaDProduto.Cores.Count - 1 do
  begin
    if (TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]).CodCor = VpaCodCor) then
    begin
      result := TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]);
      break;
    end;
  end;

  if result = nil then
  begin
    result := VpaDProduto.AddCor;
    result.CodCor := VpaCodCor;
    if result.CodCor = 0 then
      result.NomCor := 'SEM COR'
    else
      result.NomCor := FunProdutos.RNomeCor(IntTosTr(Result.CodCor));
    Result.QtdEstoque := 0;
  end;
end;

{******************************************************************************}
function TRBFunRave.REspula(VpaNumEspulas: Integer): String;
begin
  if VpaNumEspulas > 1 then
    result := ' X '+IntToStr(VpaNumEspulas)
  else
    result := '';
end;

{******************************************************************************}
function TRBFunRave.RTamanhoProduto(VpaDCor: TRBDCorProdutoRave; VpaCodTamanho: Integer): TRBDTamanhoProdutoRave;
var
  VpfLacoTamanho : Integer;
begin
  result := nil;
  for VpfLacoTamanho := 0 to VpaDCor.Tamanhos.Count - 1 do
  begin
    if TRBDTamanhoProdutoRave(VpaDCor.Tamanhos.Items[VpfLacoTamanho]).CodTamanho = VpaCodTamanho then
    begin
      result := TRBDTamanhoProdutoRave(VpaDCor.Tamanhos.Items[VpfLacoTamanho]);
      break;
    end;
  end;

  if result = nil then
  begin
    Result := VpaDCor.addTamanho;
    Result.CodTamanho := VpaCodTamanho;
    if Result.CodTamanho = 0 then
      Result.NomTamanho := 'SEM TAMANHO'
    else
      Result.NomTamanho := FunProdutos.RNomeTamanho(VpaCodTamanho);
  end;
end;

{******************************************************************************}
function TRBFunRave.RValCustoCotacao(VpaCodFilial, VpaLanOrcamento: Integer): Double;
Var
  VpfQtd, VpfValCusto : Double;
begin
  result := 0;
  AdicionaSQLAbreTabela(Aux,'Select MOV.N_QTD_PRO, MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_COD_TAM, MOV.I_EMP_FIL, MOV.C_COD_UNI, '+
                            ' PRO.C_COD_UNI UMORIGINAL '+
                           ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                           ' Where MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                           ' AND MOV.I_LAN_ORC = '+ IntToStr(VpaLanOrcamento)+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO');
  while not Aux.Eof do
  begin
    FunProdutos.CQtdValorCusto(VpaCodFilial,Aux.FieldByName('I_SEQ_PRO').AsInteger,Aux.FieldByName('I_COD_COR').AsInteger,VpfQtd,VpfValCusto);
    result := result + FunProdutos.ValorPelaUnidade(Aux.FieldByName('UMORIGINAL').AsString,Aux.FieldByName('C_COD_UNI').AsString,Aux.FieldByName('I_SEQ_PRO').AsInteger,VpfValCusto );
    aux.Next;
  end;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFunRave.CarCombinacoesOPConvencional(VpaDOPEtikArt: TRBDOrdemProducaoEtiqueta; VpaDProduto: TRBDProduto);
var
  VpfDCombinacao : TRBDCombinacao;
  vpfDCombinacaoFigura : TRBDCombinacaoFigura;
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco, VpfLacoFigura, VpfCodCombAnt,VpfQtdEtiquetas : Integer;
begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(5);
    VpfCodCombAnt := 0;
    VpfQtdEtiquetas := 0;
    PrintTab('CB');
    PrintTab('Fts');
    PrintTab('Cor ');
    PrintTab('Título');
    PrintTab('Fundo');
    newline;
    for VpfLaco := 0 to VpaDOPEtikArt.Items.Count - 1 do
    begin
      VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[VpfLaco]);
      if VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt then
      begin
        if VpfLaco <> 0 then
        begin
          PrintTab('');
          PrintTab('');
          PrintTab('   QTD = '+IntToStr(VpfQtdEtiquetas));
          newline;
          If LinesLeft<=1 Then
            NewPage;
          VpfQtdEtiquetas := 0;
        end;
        VpfDCombinacao := FunProdutos.RCombinacao(VpaDProduto,VpfDOrdemItem.CodCombinacao);
        //urdume
        PrintTab(IntToStr(VpfDCombinacao.CodCombinacao));
        PrintTab(IntToStr(VpfDOrdemItem.QtdFitas));
        PrintTab(VpfDCombinacao.CorFundo1+ ' URDUME ');
        PrintTab(VpfDCombinacao.TituloFundo1+REspula(VpfDCombinacao.Espula1));
        PrintTab(IntToStr(VpfDCombinacao.CorCartela));
        newline;
        If LinesLeft<=1 Then
           NewPage;
          //URDUME FIGURA
        IF VpfDCombinacao.CorUrdumeFigura <> '' then
        begin
          PrintTab('');
          PrintTab('');
          PrintTab(VpfDCombinacao.CorUrdumeFigura+' URDUMEFI ');
          PrintTab(VpfDCombinacao.TituloFundoFigura+REspula(VpfDCombinacao.EspulaUrdumeFigura));
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        //trama
        PrintTab('');
        PrintTab('');
        PrintTab(VpfDCombinacao.CorFundo2);
        PrintTab(VpfDCombinacao.TituloFundo2+REspula(VpfDCombinacao.Espula2));
        PrintTab('');
        newline;
        If LinesLeft<=1 Then
          NewPage;
        for VpfLacoFigura := 0 to VpfDCombinacao.Figuras.Count - 1 do
        begin
          vpfDCombinacaoFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);
          PrintTab('');
          PrintTab('');
          PrintTab(vpfDCombinacaoFigura.CodCor);
          PrintTab(vpfDCombinacaoFigura.TitFio+REspula(vpfDCombinacaoFigura.NumEspula));
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        VpfCodCombAnt := VpfDOrdemItem.CodCombinacao;
      end;
      VpfQtdEtiquetas := VpfQtdEtiquetas + VpfDOrdemItem.QtdEtiquetas;
    end;
    PrintTab('');
    PrintTab('');
    PrintTab('   QTD = '+IntToStr(VpfQtdEtiquetas));
    newline;
    If LinesLeft<=1 Then
      NewPage;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarCombinacoesOPH(VpaDOPEtikArt: TRBDOrdemProducaoEtiqueta;VpaDProduto: TRBDProduto);
var
  VpfDCombinacao : TRBDCombinacao;
  vpfDCombinacaoFigura : TRBDCombinacaoFigura;
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco, VpfLacoFigura, VpfCodCombAnt : Integer;
  VpfQtdPecas : String;
begin
  VpfCodCombAnt := 0;
  with RVSystem.BaseReport do
  begin
    RestoreTabs(6);
    PrintTab('CB');
    PrintTab('Fts');
    PrintTab('Cor ');
    PrintTab('Título');
    PrintTab('Fundo');
    PrintTab('Qdade(PC)');
    newline;

    for VpfLaco := 0 to VpaDOPEtikArt.Items.Count - 1 do
    begin
      VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[VpfLaco]);
      if VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt then
      begin
        if VpfLaco <> 0 then
        begin
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        VpfDCombinacao := FunProdutos.RCombinacao(VpaDProduto,VpfDOrdemItem.CodCombinacao);
        if VpfDOrdemItem.CodManequim = '' then
          VpfQtdPecas := FormatFloat('0',VpfDOrdemItem.MetrosFita)
        else
          VpfQtdPecas := '';
        //urdume
        PrintTab(IntToStr(VpfDCombinacao.CodCombinacao));
        PrintTab(IntToStr(VpfDOrdemItem.QtdFitas));
        PrintTab(VpfDCombinacao.CorFundo1+ ' URD ');
        PrintTab(VpfDCombinacao.TituloFundo1+REspula(VpfDCombinacao.Espula1));
        PrintTab(VpfQtdPecas);
        newline;
        If LinesLeft<=1 Then
          NewPage;
        //urdume figura
        if VpfDCombinacao.CorUrdumeFigura <> '' then         //urdume Figura
        begin
          PrintTab('');
          PrintTab('');
          PrintTab(VpfDCombinacao.CorUrdumeFigura+ ' URD2 ');
          PrintTab(VpfDCombinacao.TituloFundoFigura+REspula(VpfDCombinacao.EspulaUrdumeFigura));
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        //trama
        PrintTab('');
        PrintTab('');
        PrintTab(VpfDCombinacao.CorFundo2+ ' ');
        PrintTab(VpfDCombinacao.TituloFundo2+REspula(VpfDCombinacao.Espula2));
        PrintTab('');
        newline;
        If LinesLeft<=1 Then
          NewPage;
        for VpfLacoFigura := 0 to VpfDCombinacao.Figuras.Count - 1 do
        begin
          vpfDCombinacaoFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);
          //figuras
          PrintTab('');
          PrintTab('');
          PrintTab(vpfDCombinacaoFigura.CodCor +' ');
          PrintTab(vpfDCombinacaoFigura.TitFio+REspula(vpfDCombinacaoFigura.NumEspula));
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
          vpfDCombinacaoFigura := TRBDCombinacaoFigura(VpfDCombinacao.Figuras.Items[VpfLacoFigura]);
        end;
        VpfCodCombAnt := VpfDOrdemItem.CodCombinacao;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFunRave.CarDNivel(VpaCodCompleto, VpaCodReduzido : String):TRBDClassificacaoRave;
begin
  Result := TRBDClassificacaoRave.create;
  Result.CodClassificacao := VpaCodCompleto;
  result.CodReduzido := VpaCodReduzido;
  Result.NomClassificacao := FunClassificacao.RetornaNomeClassificacao(DeletaChars(result.CodClassificacao,'.'),'P');
  Result.QTdProduto := 0;
  Result.ValTotal :=0;
  Result.IndNovo := true;
end;

{******************************************************************************}
function TRBFunRave.CarDNivelPlanoContas(VpaCodCompleto,VpaCodReduzido: String): TRBDPlanoContasRave;
begin
  Result := TRBDPlanoContasRave.create;
  Result.CodPlanoCotas := VpaCodCompleto;
  result.CodReduzido := VpaCodReduzido;
  Result.NomPlanoContas := FunContasAReceber.RNomPlanoContas(Varia.CodigoEmpresa,DeletaChars(result.CodPlanoCotas,'.'));
  Result.ValPago := 0;
  Result.ValDuplicata :=0;
  Result.ValPrevisto :=0;
  result.IndNovo := true;
end;

{******************************************************************************}
procedure TRBFunRave.CarManequinsOPConvencional(VpaDOPEtikArt: TRBDOrdemProducaoEtiqueta; VpaDProduto: TRBDProduto);
var
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco, VpfLacoInicio, VpfCodCombAnt, VpfQtdManequins : Integer;
begin
  VpfQtdManequins := 0;
  VpfLacoInicio := 0;
  VpfCodCombAnt := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[0]).CodCombinacao ;
  with RVSystem.BaseReport do
  begin
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    restoretabs(7);
    for VpfLaco := 0 to VpaDOPEtikArt.Items.Count - 1 do
    begin
      VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[VpfLaco]) ;
      if (VpfDOrdemItem.CodManequim = '') then
        exit;

      if (VpfQtdManequins > 4) or (VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt) then
      begin
        newline;
        VpfQtdManequins := 0;
        RMetrosFitaManequim(VpaDOPEtikArt,VpfLacoInicio,VpfLaco-1);
        newline;
        If LinesLeft<=1 Then
          NewPage;
        VpfLacoInicio := VpfLaco;
        if (VpfDOrdemItem.CodCombinacao <> VpfCodCombAnt) then
          break;
      end;
      PrintTab(VpfDOrdemItem.CodManequim);
      inc(VpfQtdManequins);
    end;
    if (Vpflaco >= VpaDOPEtikArt.Items.Count) then
      dec(VpfLaco);
    if VpfQtdManequins <> 0 then
    begin
        Newline;
        RMetrosFitaManequim(VpaDOPEtikArt,VpfLacoInicio,vpflaco);
        newline;
        If LinesLeft<=1 Then
          NewPage;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarMetrosCombinacaoOPH(VpaDOPEtikArt: TRBDOrdemProducaoEtiqueta;VpaDProduto : TRBDProduto);
var
  VpfDOrdemItem : TRBDOrdemProducaoItem;
  VpfLaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    NewPage;
    SetFont('Arial',10);
    RestoreTabs(8);
    PrintTab('CB');
    PrintTab('Manequim');
    PrintTab('Metros por Fita');
    PrintTab('Qtd Fitas');
    newline;
    for VpfLaco := 0 to VpaDOPEtikArt.Items.Count - 1 do
    begin
      VpfDOrdemItem := TRBDOrdemProducaoItem(VpaDOPEtikArt.Items.Items[VpfLaco]);
      PrintTab(IntTosTr(VpfDOrdemItem.CodCombinacao));
      PrintTab(VpfDOrdemItem.CodManequim);
      PrintTab(FormatFloat('##,##0.00',(VpfDOrdemItem.MetrosFita * VpaDProduto.CmpProduto)/1000));
      PrintTab(IntTostr(VpfDOrdemItem.QtdFitas));
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;
  end;
end;

{******************************************************************************}
Function TRBFunRave.CarregaNiveis(VpaNiveis : TList;VpaCodClassificacao : string):TRBDClassificacaoRave;
var
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfMascaraProduto : STring;
  VpfCodClaCompleto,
  VpfCodClassificacaoAtual : String;
  VpfNivel, VpfTamanhoAtual : Integer;
begin
  VpfMascaraProduto := varia.MascaraCla;
  VpfNivel := 0;
  VpfCodClaCompleto := '';

  while VpaCodClassificacao <> '' do
  begin
    inc(VpfNivel);
    VpfTamanhoAtual := length(CopiaAteChar(VpfMascaraProduto,'.'));
    vpfMascaraProduto := DeleteAteChar(VpfMascaraProduto,'.');
    VpfCodClassificacaoAtual := copy(VpaCodClassificacao,1,VpfTamanhoAtual);
    VpacodClassificacao := copy(VpaCodClassificacao,VpfTamanhoAtual+1,length(VpacodClassificacao)-VpfTamanhoAtual);
    if VpfCodClaCompleto <> '' then
      VpfCodClaCompleto := VpfCodClaCompleto +'.'+VpfCodClassificacaoAtual
    else
      VpfCodClaCompleto := VpfCodClassificacaoAtual;

    if VpfNivel > VpaNiveis.count then
    begin
      VpfDClassificacao := CarDNivel(VpfCodClaCompleto,VpfCodClassificacaoAtual);
      VpaNiveis.add(VpfDClassificacao);
    end
    else
      if VpfCodClassificacaoAtual <> TRBDClassificacaoRave(VpaNiveis.Items[VpfNivel-1]).CodReduzido then
      begin
        ImprimeTotaisNiveis(VpaNiveis,VpfNivel-1);
        VpfDClassificacao := CarDNivel(VpfCodClaCompleto,VpfCodClassificacaoAtual);
        VpaNiveis.add(VpfDClassificacao);
      end;
    result := VpfDClassificacao;
  end;
end;

{******************************************************************************}
function TRBFunRave.CarregaNiveisPlanoContas(VpaNiveis: TList;VpaCodPlanoContas: string;VpaImprimirTotal : Boolean): TRBDPlanoContasRave;
var
  VpfDPlanoContas : TRBDPlanoContasRave;
  VpfMascaraPlanoContas : STring;
  VpfCodPlanoCompleto,
  VpfCodPlanoContasAtual : String;
  VpfNivel, VpfTamanhoAtual : Integer;
begin
  VpfMascaraPlanoContas := varia.MascaraPlanoConta;
  VpfNivel := 0;
  VpfCodPlanoCompleto := '';

  while VpaCodPlanoContas <> '' do
  begin
    inc(VpfNivel);
    VpfTamanhoAtual := length(CopiaAteChar(VpfMascaraPlanoContas,'.'));
    VpfMascaraPlanoContas := DeleteAteChar(VpfMascaraPlanoContas,'.');
    VpfCodPlanoContasAtual := copy(VpaCodPlanoContas,1,VpfTamanhoAtual);
    VpaCodPlanoContas := copy(VpaCodPlanoContas,VpfTamanhoAtual+1,length(VpaCodPlanoContas)-VpfTamanhoAtual);
    if VpfCodPlanoCompleto <> '' then
      VpfCodPlanoCompleto := VpfCodPlanoCompleto +'.'+VpfCodPlanoContasAtual
    else
      VpfCodPlanoCompleto := VpfCodPlanoContasAtual;

    if VpfNivel > VpaNiveis.count then
    begin
      VpfDPlanoContas := CarDNivelPlanoContas(VpfCodPlanoCompleto,VpfCodPlanoContasAtual);
      VpaNiveis.add(VpfDPlanoContas);
    end
    else
      if VpfCodPlanoContasAtual <> TRBDPlanoContasRave(VpaNiveis.Items[VpfNivel-1]).CodReduzido then
      begin
        ImprimeTotaisNiveisPlanoContas(VpaNiveis,VpfNivel-1);
        VpfDPlanoContas := CarDNivelPlanoContas(VpfCodPlanoCompleto,VpfCodPlanoContasAtual);
        VpaNiveis.add(VpfDPlanoContas);
      end;
    result := VpfDPlanoContas;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.InicializaVendaCliente(VpaDatInicio,VpaDatFim : TDateTime; VpaDVenda : TRBDVendaCliente);
var
  VpfLacoAno, VpfLacoMes : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  VpaDVenda.Free;
  VpaDVenda := TRBDVendaCliente.cria;
  for VpfLacoAno := Ano(VpaDatInicio) to Ano(VpaDatFim) do
  begin
    VpfDVendaAno := VpaDVenda.addAno;
    VpfDVendaAno.Ano := VpfLacoAno;
    for VpfLacoMes := 1 to 12 do
    begin
      VpfDVendaMes := VpfDVendaAno.addMes;
      VpfDVendaMes.Mes := VpfLacoMes;
    end;
  end;
end;

{******************************************************************************}
function TRBFunRave.RMesVenda(VpaDVenda : TRBDVendaCliente;VpaMes, VpaAno : Integer) : TRBDVendaClienteMes;
var
  VpfLacoAno, VpfLacoMes : Integer;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  result := nil;
  for VpflacoAno := 0 to VpaDVenda.Anos.Count - 1 do
  begin
    VpfDVendaAno := TRBDVendaClienteAno(VpaDVenda.Anos.Items[VpfLacoAno]);
    if VpfDVendaAno.Ano = VpaAno then
    begin
      for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
      begin
        VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
        if VpfDVendaMes.Mes = VpaMes then
          exit(VpfDVendaMes);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.RMetrosFitaManequim(VpaDOrdemProducao: TRBDOrdemProducaoEtiqueta; VpaLacoInicio,VpaLacoFim: Integer);
var
  VpfLaco : Integer;
begin
  with RVSystem.BaseReport do
  begin
    for VpfLaco := VpaLacoInicio to VpaLacoFim do
      printTab(FloatToStr(TRBDOrdemProducaoItem(VpaDOrdemProducao.Items.Items[VpfLaco]).MetrosFita));
    newline;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.AtualizaTotalVenda(VpaDVenda : TRBDVendaCliente);
var
  VpfLacoAno, VpfLacoMes : Integer;
  VpfDVendaAno,VpfDVendaAnoAnterior : TRBDVendaClienteAno;
  VpfDVendaMes, VpfDVendaMesAnterior : TRBDVendaClienteMes;
begin
  for VpflacoAno := 0 to VpaDVenda.Anos.Count - 1 do
  begin
    VpfDVendaAno := TRBDVendaClienteAno(VpaDVenda.Anos.Items[VpfLacoAno]);
    VpfDVendaAno.ValVenda := 0;
    for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
    begin
      VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
      VpfDVendaAno.ValVenda := VpfDVendaAno.ValVenda + VpfDVendaMes.ValVenda;
    end;
  end;
  for VpfLacoAno := 1 to VpaDVenda.Anos.Count - 1 do
  begin
    VpfDVendaAnoAnterior := TRBDVendaClienteAno(VpaDVenda.Anos.Items[VpfLacoAno -1]);
    VpfDVendaAno := TRBDVendaClienteAno(VpaDVenda.Anos.Items[VpfLacoAno]);
    for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
    begin
      VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
      VpfDVendaMesAnterior := TRBDVendaClienteMes(VpfDVendaAnoAnterior.Meses.Items[VpfLacoMes]);
      if VpfDVendaMes.ValVenda = 0  then
        VpfDVendaMes.IndReducaoVenda := true
      else
        if ((VpfDVendaMes.ValVenda * 0.9) < VpfDVendaMesAnterior.ValVenda) then
          VpfDVendaMes.IndReducaoVenda := true;
    end;
    if VpfDVendaAno.ValVenda = 0 then
      VpfDVendaAno.IndReducaoVenda := true
    else
      if ((VpfDVendaAno.ValVenda * 0.9) < VpfDVendaAnoAnterior.ValVenda) then
        VpfDVendaAno.IndReducaoVenda := true;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.CarValoresContasAPagar(VpaPlanoContas: String; VpaDatInicio, VpaDatFim: TDateTime; var VpaValPago, VpaValTotal: Double);
begin
  AdicionaSQLAbreTabela(Aux,'SELECT SUM(N_VLR_PAG) TOTALPAGO ,  SUM(NVL(N_VLR_PAG,N_VLR_DUP)) TOTAL ' +
                            ' FROM CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV ' +
                            ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                            ' AND CAD.I_LAN_APG = MOV.I_LAN_APG '+
                            ' AND CAD.I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa)+
                            ' AND CAD.C_CLA_PLA LIKE '''+VpaPlanoContas+'%'''+
                             SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,TRUE));
 VpaValPago := Aux.FieldByName('TOTALPAGO').AsFloat;
 VpaValtotal := Aux.FieldByName('TOTAL').AsFloat;
 Aux.close;
end;

{******************************************************************************}
function TRBFunRave.CarValoresFaturadosCliente(VpaCodCliente : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente):Boolean ;
var
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  InicializaVendaCliente(VpaDatInicio,VpaDatFim,VpaDVenda);
  AdicionaSQLAbreTabela(Tabela,'select SUM(N_TOT_NOT) TOTAL, EXTRACT(Year FROM D_DAT_EMI) ANO, EXTRACT(MONTH FROM D_DAT_EMI) MES '+
                               ' from CADNOTAFISCAIS NOF '+
                               ' Where NOF.I_COD_CLI = '+IntToStr(VpaCodCliente)+
                               ' AND NOF.C_NOT_CAN = ''N'''+
                               ' AND NOF.C_FIN_GER = ''S'''+
                               SQLTextoDataEntreAAAAMMDD('D_DAT_EMI',VpaDatInicio,VpaDatFim,true)+
                               ' GROUP BY EXTRACT(Year FROM D_DAT_EMI), EXTRACT(MONTH FROM D_DAT_EMI) '+
                               ' ORDER BY 2,3');
  result := not Tabela.Eof;
  while not Tabela.Eof do
  begin
    VpfDVendaMes := RMesVenda(VpaDVenda,Tabela.FieldByName('MES').AsInteger,Tabela.FieldByName('ANO').AsInteger);
    VpfDVendaMes.ValVenda := Tabela.FieldByName('TOTAL').AsFloat;
    Tabela.next;
  end;
  AtualizaTotalVenda(VpaDVenda);
end;

{******************************************************************************}
function TRBFunRave.CarValoresPlanoContasMes(VpaPlanoContas: String; VpaDatInicio, VpaDatFim: TDateTime; VpaDVenda: TRBDVendaCliente): boolean;
var
  VpfDVendaMes : TRBDVendaClienteMes;
begin
  InicializaVendaCliente(VpaDatInicio,VpaDatFim,VpaDVenda);
  AdicionaSQLAbreTabela(Tabela,'SELECT   SUM(NVL(N_VLR_PAG,N_VLR_DUP)) TOTAL ,EXTRACT(Year FROM CAD.D_DAT_EMI) ANO, EXTRACT(MONTH FROM CAD.D_DAT_EMI) MES '+
                               ' FROM CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV '+
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                               ' AND CAD.I_LAN_APG = MOV.I_LAN_APG '+
                               ' AND CAD.I_COD_EMP =  '+IntToStr(varia.CodigoEmpresa)+
                               ' AND CAD.C_CLA_PLA like '''+VpaPlanoContas+'%'''+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,true)+
                               ' group by EXTRACT(Year FROM CAD.D_DAT_EMI), EXTRACT(MONTH FROM CAD.D_DAT_EMI) '+
                               ' ORDER BY 2,3');
  result := not Tabela.Eof;
  while not Tabela.Eof do
  begin
    VpfDVendaMes := RMesVenda(VpaDVenda,Tabela.FieldByName('MES').AsInteger,Tabela.FieldByName('ANO').AsInteger);
    VpfDVendaMes.ValVenda := Tabela.FieldByName('TOTAL').AsFloat;
    Tabela.next;
  end;
  AtualizaTotalVenda(VpaDVenda);
end;

{******************************************************************************}
procedure TRBFunRave.CarValorTrocasProdutos(VpaDProduto: TRBDProdutoRave; VpaDatInicio, VpaDatFim: TDateTime; VpaSeqProduto: Integer);
begin
  Aux.Close;
  Aux.sql.clear;
  AdicionaSqlTabela(Aux,'Select sum(MOV.N_QTD_PRO) QTDPRODUTO, SUM(MOV.N_TOT_PRO) TOTAL '+
                            ' from CADNOTAFISCAISFOR CAD, MOVNOTASFISCAISFOR MOV, CADCLIENTES CLI '+
                            ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                            ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                            ' AND MOV.I_SEQ_PRO = '+IntToStr(VpaDProduto.SeqProduto)+
                            ' and CAD.I_COD_CLI = CLI.I_COD_CLI '+
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  if VprClienteMaster <> 0  then
    AdicionaSqlTabela(Aux,' and CLI.I_CLI_MAS = '+InttoStr(VprClienteMaster));
  if VprCliente <> 0  then
    AdicionaSqlTabela(Aux,' and CLI.I_COD_CLI = '+InttoStr(VprCliente));
  if VprFilial <> 0  then
    AdicionaSqlTabela(Aux,' and CAD.I_EMP_FIL = '+InttoStr(VprFilial));
  Aux.open;
  VpaDProduto.QtdTrocada := Aux.FieldByName('QTDPRODUTO').AsFloat;
  VpaDProduto.ValTroca := Aux.FieldByName('TOTAL').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TRBFunRave.ConfiguraRelatorioPDF;
begin
  RpDev.DevMode.dmPaperSize := DMPAPER_A4;
  if VplArquivoPDF <> '' then
  begin
    rvSystem.DefaultDest := rdFile;
    rvSystem.DoNativeOutput := false;
    rvSystem.RenderObject := rvPDF;
    rvSystem.OutputFileName := VplArquivoPDF;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelEstoqueMinimo(VpaObjeto : TObject);
var
  VpfQtdProduto, VpfQtdMinima,VpfQtdIdeal,VpfQtdFaltante, VpfTotalProduto, VpfQtdGeral,VpfValUnitario, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual, VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
        begin
          PrintTab(FormatFloat('#,###,##0.00',VpfQtdProduto));
          PrintTab(FormatFloat('#,###,##0.00',VpfQtdMinima));
          PrintTab(FormatFloat('#,###,##0.00',VpfQtdIdeal));
          PrintTab(FormatFloat('#,###,##0.00',VpfQtdFaltante));
          PrintTab(FormatFloat('#,###,##0.00',VpfValUnitario)); //valor unitario;
          PrintTab(FormatFloat('#,###,##0.00',VpfTotalProduto));
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfQtdFaltante;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfTotalProduto;
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
       VpfQtdproduto := 0;
       VpfQtdMinima := 0;
       VpfQtdIdeal := 0;
       VpfQtdFaltante := 0;
       VpfTotalProduto := 0;
       VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
       PrintTab(Tabela.FieldByName('C_COD_PRO').AsString);
       PrintTab(Tabela.FieldByName('C_NOM_PRO').AsString);
       PrintTab('  '+Tabela.FieldByname('C_COD_UNI').AsString);
       if config.EstoquePorCor then
         PrintTab('');
       if config.EstoquePorTamanho then
         PrintTab('');
      end;
      VpfQtdProduto := VpfQtdProduto + Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfQtdMinima := VpfQtdMinima + Tabela.FieldByName('N_QTD_MIN').AsFloat;
      VpfQtdIdeal := VpfQtdIdeal + Tabela.FieldByName('N_QTD_PED').AsFloat;
      VpfQtdFaltante := VpfQtdFaltante + (Tabela.FieldByName('N_QTD_PED').AsFloat -Tabela.FieldByName('N_QTD_PRO').AsFloat);
      VpfTotalProduto := VpfTotalProduto + ((Tabela.FieldByName('N_QTD_PED').AsFloat -Tabela.FieldByName('N_QTD_PRO').AsFloat) * Tabela.FieldByName('N_VLR_COM').AsFloat);
      VpfValUnitario := Tabela.FieldByName('N_VLR_COM').AsFloat;
      VpfQtdGeral := VpfQTdGeral +(Tabela.FieldByName('N_QTD_PED').AsFloat -Tabela.FieldByName('N_QTD_PRO').AsFloat);
      VpfValGeral := VpfValGeral + ((Tabela.FieldByName('N_QTD_PED').AsFloat -Tabela.FieldByName('N_QTD_PRO').AsFloat) * Tabela.FieldByName('N_VLR_COM').AsFloat);
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
    begin
      PrintTab(FormatFloat('#,###,##0.00',VpfQtdProduto));
      PrintTab(FormatFloat('#,###,##0.00',VpfQtdMinima));
      PrintTab(FormatFloat('#,###,##0.00',VpfQtdIdeal));
      PrintTab(FormatFloat('#,###,##0.00',VpfQtdFaltante));
      PrintTab(FormatFloat('#,###,##0.00',VpfValUnitario)); //valor unitario;
      PrintTab(FormatFloat('#,###,##0.00',VpfTotalProduto));
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;
    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfQtdFaltante;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfTotalProduto;
    end;
    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelAnaliseFaturamentoAnual(VpaObjeto : TObject);
var
  VpfVendedorAnterior : Integer;
  VpfDVenda : TRBDVendaCliente;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
  VpfLacoAno,VpfLacoMes : Integer;
  VpfNomCliente : String;
begin
  VpfVendedorAnterior := 0;
  VpfDVenda := TRBDVendaCliente.cria;
  with RVSystem.BaseReport do begin
    while not Clientes.Eof  do
    begin
      if VpfVendedorAnterior <> Clientes.FieldByName('I_COD_VEN').AsInteger then
      begin
        if VpfVendedorAnterior <> 0  then
        begin
          VprNomVendedor := Clientes.FieldByName('C_NOM_VEN').AsString;
          NewPage;
        end;
      end;
      if CarValoresFaturadosCliente(Clientes.FieldByName('I_COD_CLI').AsInteger,VprDatInicio,VprDatFim,VpfDVenda) then
      begin
        VpfNomCliente := ' '+Clientes.FieldByName('C_NOM_CLI').AsString;
        for VpfLacoAno := 0 to VpfDVenda.Anos.Count - 1 do
        begin
          NewLine;
          If LinesLeft<=1 Then
            NewPage;
          VpfDVendaAno := TRBDVendaClienteAno(VpfDVenda.Anos.Items[VpfLacoAno]);
          PrintTab(VpfNomCliente);
          PrintTab(IntToStr(VpfDVendaAno.Ano));
          for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
          begin
            VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
            if VpfDVendaMes.ValVenda <> 0 then
            begin
              if VpfDVendaMes.IndReducaoVenda then
                Italic := true;
              PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaMes.ValVenda))
            end
            else
              PrintTab('');
            Italic := false;
          end;
          if VpfDVendaAno.IndReducaoVenda  then
            bold := true;
          PrintTab(FormatFloat('#,###,###,###,##0',VpfDVendaAno.ValVenda));
          Bold := false;
          VpfNomCliente := '';
        end;
      end;
      Clientes.next;
    end;

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
//    PrintTab('Total Geral');
    bold := true;
    PrintTab('');
    PrintTab('');
//    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
//    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;
  end;
  Clientes.Close;
  VpfDVenda.free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelFechamentoEstoque(VpaObjeto : TObject);
Var
  VpfClassificacaoAtual : String;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfQtdVendaMes, VpfValVendaMes, VpfQtdGeralAnterior,VpfQtdGeralVenda, VpfQtdGeralProduto,VpfValGeralAnterior,
  VpfValGeralVenda, VpfValGeralProduto, VpfValGeralCustoVenda : Double;
begin
  VpfClassificacaoAtual := '';
  VpfQtdGeralAnterior := 0;
  VpfQtdGeralVenda := 0;
  VpfQtdGeralProduto := 0;
  VpfValGeralAnterior := 0;
  VpfValGeralVenda := 0;
  VpfValGeralProduto := 0;
  VpfValGeralCustoVenda := 0;
  with RVSystem.BaseReport do
  begin
    while not Tabela.Eof  do
    begin
      VpfQtdVendaMes := Tabela.FieldByName('N_QTD_VEN_MES').AsFloat - Tabela.FieldByName('N_QTD_DEV_VEN').AsFloat;
      VpfValVendaMes := Tabela.FieldByName('N_VLR_VEN_MES').AsFloat - Tabela.FieldByName('N_VLR_DEV_VEN').AsFloat;
      if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
      begin
        VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
        ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
        VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
      end;
      if (VprTodosProdutos) or (VpfQtdVendaMes <> 0)  then
      begin
        VpfDClassificacao.ValCustoVenda := VpfDClassificacao.ValCustoVenda + Tabela.FieldByName('N_VLR_CMV').AsFloat;
        VpfValGeralCustoVenda := VpfValGeralCustoVenda + Tabela.FieldByName('N_VLR_CMV').AsFloat;
        PrintTab(Tabela.FieldByName('C_COD_PRO').AsString);
        PrintTab(Tabela.FieldByName('C_NOM_PRO').AsString);
        PrintTab(FormatFloat('#,###,###,##0.00',VpfQtdVendaMes));
        PrintTab(FormatFloat('#,###,###,##0.00',VpfValVendaMes));
        PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_VLR_CMV').AsFloat));
        if Tabela.FieldByName('N_VLR_CMV').AsFloat <> 0  then
          PrintTab(FormatFloat('#,##0.00%',((((Tabela.FieldByName('N_VLR_VEN_MES').AsFloat - Tabela.FieldByName('N_VLR_DEV_VEN').AsFloat)/Tabela.FieldByName('N_VLR_CMV').AsFloat)-1)*100)))
        else
          PrintTab(FormatFloat('0.00%',0));
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
      end;
      VpfDClassificacao.QtdMesAnterior := VpfDClassificacao.QtdMesAnterior + Tabela.FieldByName('N_QTD_ANT').AsFloat;
      VpfDClassificacao.ValAnterior := VpfDClassificacao.ValAnterior +(Tabela.FieldByName('N_QTD_ANT').AsFloat*Tabela.FieldByName('N_VLR_COM').AsFloat);
      VpfDClassificacao.QtdVenda := VpfDClassificacao.QtdVenda + VpfQtdVendaMes;
      VpfDClassificacao.ValVenda := VpfDClassificacao.ValVenda + VpfValVendaMes;
      VpfDClassificacao.QTdProduto := VpfDClassificacao.QTdProduto + Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal +(Tabela.FieldByName('N_QTD_PRO').AsFloat*Tabela.FieldByName('N_VLR_COM').AsFloat);
      VpfQtdGeralAnterior := VpfQtdGeralAnterior + Tabela.FieldByName('N_QTD_ANT').AsFloat;
      VpfQtdGeralVenda := VpfQtdGeralVenda + VpfQtdVendaMes;
      VpfQtdGeralProduto := VpfQtdGeralProduto + Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfValGeralAnterior := VpfValGeralAnterior+(Tabela.FieldByName('N_QTD_ANT').AsFloat*Tabela.FieldByName('N_VLR_COM').AsFloat);
      VpfValGeralVenda := VpfValGeralVenda + VpfValVendaMes;
      VpfValGeralProduto := VpfValGeralProduto + (Tabela.FieldByName('N_QTD_PRO').AsFloat*Tabela.FieldByName('N_VLR_COM').AsFloat);
      Tabela.next;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfQtdGeralVenda));
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfValGeralVenda));
    PrintTab(FormatFloat('#,###,###,###,##0.00',VpfValGeralCustoVenda));
    if VpfValGeralVenda <> 0  then
      PrintTab(FormatFloat('#,##0.00%',(100 - ((VpfValGeralCustoVenda*100)/VpfValGeralVenda))))
    else
      PrintTab(FormatFloat('0.00%',0));
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelOPEtikArt(VpaObjeto: TObject);
Var
  VpfDProduto : TRBDProduto;
  VpfPosicaoFinalLinha : Double;
  VpfObservacoes : TStringList;
  VpfLaco : Integer;
begin
  VpfDProduto := TRBDProduto.Cria;
  FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,VprDOPEtikArt.CodEmpresafilial,VprDOPEtikArt.SeqProduto);
  FunProdutos.CarDCombinacao(VpfDProduto);

  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
    PrintTab('Número OP :');
    PrintTab(' '+ intToStr(VprDOPEtikArt.SeqOrdem));
    PrintTab('Pedido :');
    PrintTab(' '+intToStr(VprDOPEtikArt.NumPedido));
    newline;
    PrintTab('OP Cliente :');
    PrintTab(' '+intToStr(VprDOPEtikArt.NroOPCliente));
    PrintTab('Entrega :');
    PrintTab(' '+FormatDateTime('DD/MM/YYYY',VprDOPEtikArt.DatEntregaPrevista));
    newline;
    PrintTab('Data :');
    PrintTab(' '+FormatDateTime('DD/MM/YYYY',VprDOPEtikArt.DatEmissao));
    PrintTab('Programad :');
    PrintTab(' '+Sistema.RNomUsuario(VprDOPEtikArt.CodProgramador));
    newline;
    PrintTab('Faturar :');
    if VprDOPEtikArt.TipPedido in [0,3] then
      PrintTab(' N')
    else
      PrintTab(' S');
    newline;
    PrintTab('Tear :');
    PrintTab(' '+IntToStr(VprDOPEtikArt.CodMaquina) +' - ' +FunOrdemProducao.RNomeMaquina(IntToStr(VprDOPEtikArt.CodMaquina)));
    PrintTab('Fitas :');
    PrintTab(' '+intTostr(VprDOPEtikArt.QtdFita));
    newline;
    PrintTab('Mts Total :');
    PrintTab(' '+FloattoStr(VprDOPEtikArt.TotMetros));
    PrintTab('Acréscimo :');
    PrintTab(' '+IntToStr(VprDOPEtikArt.PerAcrescimo)+'%');
    newline;
    RestoreTabs(2);
    PrintTab('Mts Fita :');
    PrintTab(' '+FloattoStr(VprDOPEtikArt.MetFita));
    PrintTab('Súmula :');
    if VprDOPEtikArt.TipPedido = 0 then
      PrintTab(' A'+IntToStr(VpfDProduto.CodSumula))
    else
      if VprDOPEtikArt.TipPedido = 1 then
        PrintTab(' V'+IntToStr(VpfDProduto.CodSumula))
      else
        PrintTab(' '+IntToStr(VpfDProduto.CodSumula));
    PrintTab('UM Pedido :');
    PrintTab(' '+VprDOPEtikArt.UMPedido);
    SetPen(clBlack,psDashDot,2,pmCopy);
    moveto(0.5,YPos+0.1);
    lineto(10.2,YPos+0.1);
    newline;
    RestoreTabs(3);
    PrintTab('Produto :');
    PrintTab(' '+VprDOPEtikArt.CodProduto+' - '+VpfDProduto.NomProduto);
    newline;
    RestoreTabs(2);
    PrintTab('Largura :');
    PrintTab(' '+IntToStr(VpfDProduto.LarProduto));
    PrintTab('Comp. :');
    PrintTab(' '+IntToStr(VpfDProduto.CmpProduto));
    PrintTab('Comp. Fig :');
    PrintTab(' '+IntToStr(VpfDProduto.CmpFigura));
    newline;
    RestoreTabs(1);
    PrintTab('Tipo Fundo :');
    if VpfDProduto.CodTipoFundo <> 0 then
      PrintTab(' '+IntToStr(VpfDProduto.CodTipoFundo) +' - ' + FunProdutos.RNomeFundo(IntToStr(VpfDProduto.CodTipoFundo)))
    else
      PrintTab(' ');
    PrintTab('Calandragem:');
    PrintTab(' '+VpfDProduto.IndCalandragem);
    newline;
    PrintTab('Tp Emenda :');
    if VpfDProduto.CodTipoEmenda <> 0 then
      PrintTab(' '+IntToStr(VpfDProduto.CodTipoEmenda) + ' - '+ FunProdutos.RNomeTipoEmenda(IntToStr(VpfDProduto.CodTipoEmenda)))
    else
      PrintTab(' ');
    PrintTab('Engomagem:');
    PrintTab(' '+VpfDProduto.IndEngomagem);
    newline;
    RestoreTabs(2);
    PrintTab('Pente :');
    PrintTab(' '+VpfDProduto.Pente);
    PrintTab('Bat P :');
    PrintTab(' '+VpfDProduto.BatProduto);
    PrintTab('Bat Tear :');
    PrintTab(' '+VpfDProduto.NumBatidasTear);
    newline;
    RestoreTabs(1);
    PrintTab('Tipo Corte :');
    if VprDOPEtikArt.CodTipoCorte <> 0 then
      PrintTab(' '+IntToStr(VprDOPEtikArt.CodTipoCorte)+ ' - '+FunProdutos.RNomeTipoCorte(VprDOPEtikArt.CodTipoCorte))
    else
      PrintTab(' ');
    PrintTab('Prod Novo:');
    PrintTab(' '+VprDOPEtikArt.IndProdutoNovo);
    SetPen(clBlack,psSolid,2,pmCopy);
    moveto(0.5,YPos+0.1);
    lineto(10.2,YPos+0.1);
    newline;
    RestoreTabs(4);
    PrintTab('NR Fios ' + VpfDProduto.NumFios);
    moveto(0.5,YPos+0.1);
    lineto(10.2,YPos+0.1);
    newline;

    if YPos > 14 then
      VpfPosicaoFinalLinha := PageHeight - 1
    else
      VpfPosicaoFinalLinha := 14;
    if VprDOPEtikArt.TipTear = 0 then
    begin
      CarCombinacoesOPConvencional(VprDOPEtikArt,VpfDProduto);
      CarManequinsOPConvencional(VprDOPEtikArt,VpfDProduto);
      FontSize := 14;
      PrintXY(2,VpfPosicaoFinalLinha-0.5,FloattoStr(VprDOPEtikArt.MetFita) + ' MTS');
      FontSize := 10;
    end
    else
    begin
      CarCombinacoesOPH(VprDOPEtikArt,VpfDProduto);
      CarManequinsOPConvencional(VprDOPEtikArt,VpfDProduto);
    end;

    SetPen(clBlack,psSolid,3,pmCopy);
    //quadrado grando do lado esquerdo
    moveto(0.5,0.5);
    lineto(10.2,0.5);
    moveto(0.5,0.5);
    lineto(0.5,VpfPosicaoFinalLinha);
    moveto(10.2,0.5);
    lineto(10.2,VpfPosicaoFinalLinha);
    moveto(0.5,VpfPosicaoFinalLinha);
    lineto(10.2,VpfPosicaoFinalLinha);
    //quadrado grando do lado direito
    moveto(10.5,0.5);
    lineto(21,0.5);
    moveto(10.5,0.5);
    lineto(10.5,VpfPosicaoFinalLinha);
    moveto(21,0.5);
    lineto(21,VpfPosicaoFinalLinha);
    moveto(10.5,VpfPosicaoFinalLinha);
    lineto(21,VpfPosicaoFinalLinha);
    //Linhas internas do quadrado
    moveto(10.5,1.5);
    lineto(21,1.5);
    PrintXY(10.7,0.9,'Horas Produção :');
    PrintXY(13.7,0.9,VprDOPEtikArt.HorProducao);
    PrintXY(15.5,0.9,'Preço Unitário :');
    PrintXY(19,0.9,FormatFloat('R$ ###,###,##0.00',VprDOPEtikArt.ValUnitario));
    PrintXY(10.7,1.3,'Data Prevista Termino :');
    PrintXY(17,1.3,'Unid :');
    PrintXY(10.7,1.9,'ANOT');
    PrintXY(12.7,1.9,'INICIO');
    PrintXY(15,1.9,'FIM');
    PrintXY(18.5,1.9,'C.Q.');
    moveto(10.5,2.0);
    lineto(21,2.0);
    PrintXY(10.7,3.1,'Data');
    moveto(10.5,3.15);
    lineto(16.5,3.15);
    moveto(11.8,1.5);
    lineto(11.8,7);
    moveto(14.3,1.5);
    lineto(14.3,7);
    moveto(16.5,1.5);
    lineto(16.5,7);
    PrintXY(10.7,3.7,'Horas');
    moveto(10.5,3.75);
    lineto(16.5,3.75);
    PrintXY(10.7,4.2,'Rel. A');
    moveto(10.5,4.25);
    lineto(16.5,4.25);
    PrintXY(10.7,4.7,'Rel. B');
    moveto(10.5,4.75);
    lineto(16.5,4.75);
    PrintXY(10.7,5.3,'Rel. C');
    moveto(10.5,5.35);
    lineto(16.5,5.35);
    PrintXY(10.7,5.8,'Rel. D');
    moveto(10.5,5.85);
    lineto(16.5,5.85);
    PrintXY(10.7,6.4,'Engre');
    PrintXY(12.7,6.3,VpfDProduto.Engrenagem);
    moveto(10.5,7);
    lineto(21,7);

    PrintXY(18,3.7,'Aprovação');
    PrintXY(17.5,4.5,'____/____/____');

    PrintXY(18,5.5,'____:____hrs');
    PrintXY(16.7,6.5,'Ass :');
    moveto(10.5,7);
    lineto(21,7);
    PrintXY(10.7,7.4,'Data');
    PrintXY(12.5,7.4,'Relogio');
    PrintXY(14.5,7.4,'P. Tr');
    moveto(10.5,7.45);
    lineto(21,7.45);
    PrintXY(14.5,7.9,'Nome');
    moveto(10.5,7.95);
    lineto(21,7.95);
    PrintXY(14.5,8.5,'Batida');
    moveto(10.5,8.55);
    lineto(21,8.55);
    PrintXY(14.5,9.1,'Comp');
    moveto(10.5,9.15);
    lineto(21,9.15);
    PrintXY(14.5,9.7,'Oper');
    moveto(10.5,9.75);
    lineto(21,9.75);
    PrintXY(14.5,10.3,'Disk');
    moveto(10.5,10.35);
    lineto(21,10.35);
    PrintXY(14.5,10.9,'Obs');
    VpfObservacoes := DivideString(VprDOPEtikArt.DesObservacoes,30);
    for vpflaco:= 0 to VpfObservacoes.Count - 1 do
      PrintXY(15.6,10.9+(0.5 *VpfLaco),VpfObservacoes.Strings[VpfLaco]);

    PrintXY(12.1,13.9,'Prateleira');
    PrintXY(14.4,13.9,VpfDProduto.PraProduto);
    moveto(12,7);
    lineto(12,14);
    moveto(14.3,7);
    lineto(14.3,14);
    moveto(15.5,7);
    lineto(15.5,14);
    if VprDOPEtikArt.TipPedido = 4 then
      PrintXY(6,VpfPosicaoFinalLinha-0.5,'PEDIDO DE ESTOQUE - NÃO PRODUZIR')
    else
      if VprDOPEtikArt.TipPedido > 1 then
        PrintXY(6,VpfPosicaoFinalLinha-0.5,'Reprogramação');
    With TRPBars2of5.Create(RVSystem.BaseReport) do
    Begin
     BarHeight  := 1;
     BarWidth   := 0.05;
     WideFactor := BarWidth;
     Text := '*'+IntToStr(VprDOPEtikArt.SeqOrdem)+'*';
     PrintXY(4.3,0.7);
     Free;
   end;

    if VprDOPEtikArt.TipTear = 1 then
      CarMetrosCombinacaoOPH(VprDOPEtikArt,VpfDProduto);
  end;
  VpfDProduto.Free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelProdutosComDefeito(VpaObjeto: TObject);
var
  VpfQtdProduto,VpfQtdGeral, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual,  VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  VprUfAtual := '';
  VpfDClassificacao := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
          SalvaTabelaProdutosComDefeito(VpfDProduto);

        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
          VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
          VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('UMPADRAO').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
      end;
      VpfQtdProduto := FunProdutos.CalculaQdadePadrao( Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,
                                       Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
      VpfDProduto.QtdEstoque := VpfDProduto.QtdEstoque + VpfQtdproduto;
      VpfDProduto.ValEstoque := VpfDProduto.ValEstoque + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      if Tabela.FieldByName('I_TIP_ORC').AsInteger = Varia.TipoCotacaoGarantia then
      begin
        VpfDProduto.QtdTrocada := VpfDProduto.QtdTrocada + VpfQtdproduto;
        VpfDProduto.ValTroca := VpfDProduto.ValTroca + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      end;

      VpfQtdGeral := VpfQTdGeral + VpfQtdProduto;
      VpfValGeral := VpfValGeral + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaProdutosComDefeito(VpfDProduto);

    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfDProduto.QtdEstoque;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfDProduto.ValEstoque;
      VpfDClassificacao.QtdTrocado := VpfDClassificacao.QtdTrocado +VpfDProduto.QtdTrocada;
      VpfDClassificacao.VAlTrocado := VpfDClassificacao.VAlTrocado + VpfDProduto.ValTroca;
    end;

    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveis(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
{    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;}
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelResumoCaixas(VpaObjeto: TObject);
VAR
  VpfSaldoTotal, VpfTotalCheques, VpfValCheque: Double;
  VpfZebrado : Boolean;
begin
  VpfSaldoTotal := 0;
  VpfTotalCheques := 0;
  with RVSystem.BaseReport do begin
    RestoreTabs(1);
    NewLine;
    while not Tabela.Eof  do
    begin
      if VpfZebrado then
      begin
        SetBrush(ShadeToColor(clSilver,20),bsSolid,nil);
        FillRect(CreateRect(MarginLeft-0.1,YPos+LineHeight-1+0.3,PageWidth-0.3,YPos+0.1));
      end;
      VpfZebrado := not VpfZebrado;
      PrintTab(Tabela.FieldByName('I_COD_BAN').AsString+'-'+Tabela.FieldByName('C_NOM_BAN').AsString);
      PrintTab(Tabela.FieldByName('C_NRO_CON').AsString);
      PrintTab('  '+Tabela.FieldByName('C_NOM_CRR').AsString);
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_SAL_ATU').AsFloat));
      VpfValCheque := FunContasAReceber.RValChequesNaoCompesadosContaCaixa(Tabela.FieldByName('C_NRO_CON').AsString);
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValCheque));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_SAL_ATU').AsFloat+VpfValCheque));

      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      VpfSaldoTotal := VpfSaldoTotal + Tabela.FieldByName('N_SAL_ATU').AsFloat;
      VpfTotalCheques := VpfTotalCheques +VpfValCheque;
      Tabela.next;
    end;

    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab(FormatFloat(varia.MascaraQtd,VpfSaldoTotal));
    PrintTab(FormatFloat(varia.MascaraQtd,VpfTotalCheques));
    PrintTab(FormatFloat(varia.MascaraQtd,VpfSaldoTotal + VpfTotalCheques));
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelRomaneioEtikArt(VpaObjeto: TObject);
var
  VpfValUnitario, VpfTotalKM, VpfTotalGeralKM, VpfValTotalGeral, VpfMetFita : Double;
  VpfCodCombinacao, VpfNumFitas, VpfNumPedido, VpfNumFitasPedido, VpfSeqOrdemProducao : Integer;
  VpfSegundaCombinacao : Boolean;
  VpfCombinacoes, VpfManequins, VpfCodProduto, VpfNomProduto : String;
begin
  VpfValTotalGeral := 0;
  VpfTotalGeralKM := 0;
  with RVSystem.BaseReport do begin
    RestoreTabs(1);
    NewLine;
    while not Tabela.eof do
    begin
      if (VpfNumPedido  <> Tabela.FieldByName('NUMPED').AsInteger) or
         ( VpfCodCombinacao <> Tabela.FieldByName('CODCOM').AsInteger) or
         (VpfNumFitasPedido <> Tabela.FieldByName('NROFIT').AsInteger ) or
         (VpfSeqOrdemProducao <> Tabela.FieldByName('SEQORD').AsInteger) then
      begin
        if VpfSeqOrdemProducao <> 0 then
        begin
          PrintTab(IntToStr(VpfNumPedido));
          PrintTab(VpfCodProduto);
          if length(VpfManequins) >= 30 then
             PrintTab('Vários')
          else
             PrintTab(copy(VpfManequins,1,length(VpfManequins)-2));
          PrintTab(copy(VpfCombinacoes,1,length(VpfCombinacoes)-2));
          PrintTab(IntToStr(VpfNumFitas));
          PrintTab(FormatFloat('###,###,##0.00',VpfMetFita)+' ');
          PrintTab(FormatFloat(varia.mascaraqtd,VpfTotalKm)+' ');
          PrintTab(FormatFloat('###,###,##0.00',VpfValUnitario)+' ');
          PrintTab(FormatFloat('###,###,##0.00',ArredondaDecimais(VpfTotalKm,3) * VpfValUnitario)+' ');
          PrintTab(' '+VpfNomProduto);
          VpfValTotalGeral := VpfValTotalGeral +(ArredondaDecimais(VpfTotalKm,4) * VpfValUnitario);
          VpfTotalGeralKM := VpfTotalGeralKM + VpfTotalKm;
          NewLine;
          If LinesLeft<=1 Then
            NewPage;
        end;
        VpfCombinacoes := '';
        VpfManequins :='';
        VpfCodCombinacao := 0;
        VpfNumFitas := 0;
        VpfMetFita := 0;
        VpfTotalKm := 0;
        VpfSegundaCombinacao := false;
        VpfCodProduto := Tabela.FieldByName('CODPRO').AsString;
        VpfNomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
        VpfNumPedido := Tabela.FieldByName('NUMPED').AsInteger;
        VpfNumFitasPedido := Tabela.FieldByName('NROFIT').AsInteger;
        VpfSeqOrdemProducao := Tabela.FieldByName('SEQORD').AsInteger;
      end;

      VpfValUnitario := Tabela.FieldByName('VALUNI').AsFloat;
      VpfTotalKm := VpfTotalKm + (Tabela.FieldByName('METCOL').AsFloat * Tabela.FieldByName('NROFIT').AsInteger) /1000;
      if (Tabela.FieldByName('TIPTEA').AsInteger in [0,1]) then
      begin
        if ((VpfCodCombinacao = Tabela.FieldByName('CODCOM').AsInteger) or
           (VpfCodCombinacao = 0)) and not(VpfSegundaCombinacao) then
          VpfMetFita := VpfMetFita + Tabela.FieldByName('METCOL').AsFloat;
      end
      else
        VpfMetFita := VpfMetFita + Tabela.FieldByName('METCOL').AsFloat; //tear H sempre soma os metros porque as combinações não rodam paralelamente

      if VpfCodCombinacao <> Tabela.FieldByName('CODCOM').AsInteger then
      begin
        if VpfCodCombinacao <> 0 then
          VpfSegundaCombinacao := true;
        VpfCodCombinacao := Tabela.FieldByName('CODCOM').AsInteger;
        if Tabela.FieldByName('TIPTEA').AsInteger in [0,1] then //tear convencional
          VpfNumFitas := VpfNumFitas + Tabela.FieldByName('NROFIT').AsInteger
        else
          VpfNumFitas := Tabela.FieldByName('NROFIT').AsInteger; //tear H não soma o número de fitas porque as combinações não correm paralelamente.
        VpfCombinacoes := VpfCombinacoes + Tabela.FieldByName('CODCOM').AsString + ', ';
      end;

      if Tabela.FieldByName('CODMAN').AsString <> '' then
        VpfManequins := VpfManequins + Tabela.FieldByName('CODMAN').AsString+ ', ';

      Tabela.next;
    end;
    if VpfSeqOrdemProducao <> 0 then
    begin
      PrintTab(IntToStr(VpfNumPedido));
      PrintTab(VpfCodProduto);
      if length(VpfManequins) >= 30 then
         PrintTab('Vários')
      else
         PrintTab(copy(VpfManequins,1,length(VpfManequins)-2));
      PrintTab(copy(VpfCombinacoes,1,length(VpfCombinacoes)-2));
      PrintTab(IntToStr(VpfNumFitas));
      PrintTab(FormatFloat('###,###,##0.00',VpfMetFita)+' ');
      PrintTab(FormatFloat(varia.mascaraqtd,VpfTotalKm)+' ');
      PrintTab(FormatFloat('###,###,##0.00',VpfValUnitario)+' ');
      PrintTab(FormatFloat('###,###,##0.00',ArredondaDecimais(VpfTotalKm,3) * VpfValUnitario)+' ');
      PrintTab(' '+VpfNomProduto);
      VpfValTotalGeral := VpfValTotalGeral +(ArredondaDecimais(VpfTotalKm,4) * VpfValUnitario);
      VpfTotalGeralKM := VpfTotalGeralKM + VpfTotalKm;
      NewLine;
      If LinesLeft<=1 Then
        NewPage;
    end;
    Bold := true;
    PrintTab('');
    PrintTab('');
    PrintTab('TOTAL');
    PrintTab('');
    PrintTab('');
    PrintTab('');
    PrintTab(FormatFloat('###,###,##0.00',VpfTotalGeralKm)+' ');
    PrintTab('');
    PrintTab(FormatFloat('###,###,##0.00',vpfValTotalGeral)+' ');
    PrintTab('');
    NewLine;
    NewLine;
    If LinesLeft<=1 Then
      NewPage;
    RestoreTabs(2);
    PrintTab('ICMS');
    PrintTab(FormatFloat('###,###,##0.00',vpfValTotalGeral*0.17)+' ');
    bold := false;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelRomaneioSeparacaoCotacao(VpaObjeto: TObject);

begin
  with RVSystem.BaseReport do
  begin
    RestoreTabs(1);
  end;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelTabelaPreco(VpaObjeto: TObject);
var
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual,  VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
  VpfDProduto : TRBDProdutoRave;
  vpfDCor : TRBDCorProdutoRave;
  VpfDTamanho : TRBDTamanhoProdutoRave;
begin
  VpfProdutoAtual := 0;
  VpfClassificacaoAtual := '';
  VpfDClassificacao := nil;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
          SalvaTabelaPrecoPorCoreTamanho(VpfDProduto);

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
        VpfDProduto := TRBDProdutoRave.cria;
        VpfDProduto.SeqProduto := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.CodProduto := Tabela.FieldByname('C_COD_PRO').AsString;
        VpfDProduto.NomProduto := Tabela.FieldByname('C_NOM_PRO').AsString;
        VpfDProduto.DesCifraoMoeda := Tabela.FieldByname('C_CIF_MOE').AsString;
        VpfDProduto.DesUM := Tabela.FieldByname('C_COD_UNI').AsString;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfDProduto.ValEstoque := Tabela.FieldByName('VLRVENDA').AsFloat;
      end;
      vpfDCor := RCorProduto(VpfDProduto,Tabela.FieldByName('COD_COR').AsInteger);
      VpfDTamanho := RTamanhoProduto(vpfDCor,Tabela.FieldByName('CODTAMANHO').AsInteger);


      VpfDCor.ValEstoque := Tabela.FieldByName('VLRVENDA').AsFloat;
      VpfDTamanho.ValEstoque := Tabela.FieldByName('VLRVENDA').AsFloat;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
      SalvaTabelaPrecoPorCoreTamanho(VpfDProduto);
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelTotalAmostrasVendedor(VpaObjeto: TObject);
Var
  VpfQtdSolicitada, VpfQtdEntregue, VpfQtdAprovada, VpfQtdCliente : Integer;
  VpfTotSolicitada, VpfTotEntregue, VpfTotAprovada, VpfTotCliente : Integer;
  VpfFunAmostra : TRBFuncoesAmostra;
begin
  VpfFunAmostra := TRBFuncoesAmostra.cria(Tabela.SQLConnection);
  VpfTotSolicitada :=0;
  VpfTotEntregue := 0;
  VpfTotAprovada := 0;
  VpfTotCliente :=0;
  with RVSystem.BaseReport do begin
    newline;
    while not Tabela.Eof  do
    begin
      VpfQtdSolicitada := VpfFunAmostra.RQtdAmostraSolicitada(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger);
      VpfQtdEntregue :=VpfFunAmostra.RQtdAmostraEntregue(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger);
      VpfQtdAprovada :=VpfFunAmostra.RQtdAmostraAprovada(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger);
      VpfQtdCliente :=VpfFunAmostra.RQtdClientesAmostra(VprDatInicio,VprDatFim,Tabela.FieldByName('I_COD_VEN').AsInteger);
      if (VpfQtdSolicitada <> 0) or (VpfQtdEntregue <> 0) or
         (VpfQtdAprovada <> 0) then
      begin
        PrintTab('  ' +Tabela.FieldByName('C_NOM_VEN').AsString);
        PrintTab(IntToStr(VpfQtdSolicitada)+' ');
        PrintTab(IntToStr(VpfQtdEntregue)+' ');
        PrintTab(IntToStr(VpfQtdAprovada)+' ');
        PrintTab(IntToStr(VpfQtdCliente)+' ');
        if VpfQtdSolicitada <> 0 then
          PrintTab(FormatFloat('#,##0.00 %',(VpfQtdAprovada *100)/VpfQtdSolicitada))
        else
          PrintTab(FormatFloat('#,##0.00 %',0));
        newline;
        If LinesLeft<=1 Then
          NewPage;
      end;
      VpfTotSolicitada := VpfTotSolicitada + VpfQtdSolicitada;
      VpfTotEntregue := VpfTotEntregue +VpfQtdEntregue;
      VpfTotAprovada := VpfTotAprovada + VpfQtdAprovada;
      VpfTotCliente := VpfTotCliente + VpfQTDCliente;
      Tabela.next;
    end;
    Bold := true;
    PrintTab('  TOTAL');
    PrintTab(IntToStr(VpfTotSolicitada)+' ');
    PrintTab(IntToStr(VpfTotEntregue)+' ');
    PrintTab(IntToStr(VpfTotAprovada)+' ');
    PrintTab(IntToStr(VpfTotCliente)+' ');
    if VpfTotSolicitada <> 0 then
      PrintTab(FormatFloat('#,##0.00 %',(VpfTotAprovada *100)/VpfTotSolicitada))
    else
      PrintTab(FormatFloat('#,##0.00 %',0));
    Bold := false;
  end;
  Tabela.close;
  VpfFunAmostra.free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelTotalTipoCotacaoXCusto(VpaObjeto: TObject);
var
  VpfCodTipAtual : Integer;
  VpfValTotal, VpfValProdutos, VpfValCusto : Double;
  VpfQtdPedidos : Integer;
  VpfNomTipo : String;
begin
  VpfCodTipAtual := -1;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfCodTipAtual <> Tabela.FieldByName('I_COD_TIP').AsInteger then
      begin
        if VpfCodTipAtual <> -1 then
        begin
          PrintTab(IntToStr(VpfCodTipAtual));
          PrintTab('  '+VpfNomTipo);
          PrintTab(IntToStr(VpfQtdPedidos));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotal )+' ');
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValProdutos)+' ');
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValCusto)+' ');
          PrintTab('');
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        VpfValTotal := 0; VpfValProdutos := 0; VpfValCusto := 0; VpfQtdPedidos := 0;
        VpfCodTipAtual := Tabela.FieldByName('I_COD_TIP').AsInteger;
        VpfNomTipo := Tabela.FieldByName('C_NOM_TIP').AsString;
      end;
      inc(VpfQTdPedidos);
      VpfValTotal := VpfValTotal + Tabela.FieldByName('N_VLR_LIQ').AsFloat;
      VpfValProdutos := VpfValProdutos + Tabela.FieldByName('N_VLR_PRO').AsFloat;
      VpfValCusto := VpfValCusto + RValCustoCotacao(Tabela.FieldByName('I_EMP_FIL').AsInteger,Tabela.FieldByName('I_LAN_ORC').AsInteger);
      Tabela.Next;
    end;
    if VpfCodTipAtual <> -1 then
    begin
      PrintTab(IntToStr(VpfCodTipAtual));
      PrintTab('  '+VpfNomTipo);
      PrintTab(IntToStr(VpfQtdPedidos));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotal )+' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValProdutos)+' ');
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValCusto)+' ');
      PrintTab('');
      newline;
    end;
  end;
  Tabela.Close;
end;


{******************************************************************************}
procedure TRBFunRave.ImprimeRelCPporPlanoContas(VpaObjeto : TObject);
var
  VpfValPago, VpfValDuplicata, VpfTotalPago,VpfTotalDuplicata : Double;
  VpfPlanoContasAtual : string;
  VpfDClassificacao : TRBDPlanoContasRave;
begin
  VpfValPago := 0;
  VpfValDuplicata := 0;
  VpfTotalPago := 0;
  VpfTotalDuplicata := 0;
  VpfPlanoContasAtual := '';
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfPlanoContasAtual <> Tabela.FieldByName('C_CLA_PLA').AsString then
      begin
        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.ValPago := VpfDClassificacao.ValPago +VpfValPago;
          VpfDClassificacao.ValDuplicata := VpfDClassificacao.ValDuplicata + VpfValDuplicata;
        end;

        VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Tabela.FieldByName('C_CLA_PLA').AsString,true);
        ImprimetituloPlanoContas(VprNiveis,VpfPlanoContasAtual = '');
        VpfPlanoContasAtual := Tabela.FieldByName('C_CLA_PLA').AsString;
        VpfValPago := 0;
        VpfValDuplicata := 0;
      end;
      PrintTab(Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString);
      PrintTab(Tabela.FieldByName('I_NRO_NOT').AsString);
      PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_VEN').AsDatetime));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_VLR_DUP').AsFloat));
      if Tabela.FieldByName('D_DAT_PAG').IsNull then
        PrintTab('')
      else
        PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_PAG').AsDatetime));
      if Tabela.FieldByName('N_VLR_PAG').IsNull then
        PrintTab('')
      else
        PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_VLR_PAG').AsFloat));

      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      VpfValPago := VpfValPago + Tabela.FieldByName('N_VLR_PAG').AsFloat;
      VpfValDuplicata := VpfValDuplicata + Tabela.FieldByName('N_VLR_DUP').AsFloat;
      VpfTotalPago := VpfTotalPago + Tabela.FieldByName('N_VLR_PAG').AsFloat;
      VpfTotalDuplicata := VpfTotalDuplicata + Tabela.FieldByName('N_VLR_DUP').AsFloat;
      Tabela.next;
    end;

    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.ValPago := VpfDClassificacao.ValPago +VpfValPago;
      VpfDClassificacao.ValDuplicata := VpfDClassificacao.ValDuplicata + VpfValDuplicata;
    end;
    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveisPlanoContas(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfTotalDuplicata));
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraValor,VpfTotalPago));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCPporPlanoContasSintetico(VpaObjeto: TObject);
var
  VpfValPago, VpfValDuplicata, VpfValEmAberto : Double;
  VpfDClassificacao : TRBDPlanoContasRave;
  VpfQtdNiveisAnterior : Integer;
begin
  VpfValDuplicata := 0;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Tabela.FieldByName('C_CLA_PLA').AsString,false);
      if ContaLetra(VpfDClassificacao.CodPlanoCotas,'.') < VpfQtdNiveisAnterior then
        NewLine;
      VpfQtdNiveisAnterior := ContaLetra(VpfDClassificacao.CodPlanoCotas,'.');
      PrintTab(AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.'))+ VpfDClassificacao.CodPlanoCotas);
      PrintTab(AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.')*2)+VpfDClassificacao.NomPlanoContas);
      CarValoresContasAPagar(Tabela.FieldByName('C_CLA_PLA').AsString,VprDatInicio,VprDatFim,VpfValPago,VpfValDuplicata);
      VpfValEmAberto := VpfValDuplicata - VpfValPago;
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValEmAberto));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValPago));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValDuplicata));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('N_VLR_PRE').AsFloat));

      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      Tabela.next;
    end;

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    bold := false;
  end;
  Tabela.Close;
  FreeTObjectsList(VprNiveis);
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCPPorPlanoContasSinteticoporMes(VpaObjeto : TObject);
var
  VpfDVenda : TRBDVendaCliente;
  VpfDVendaAno : TRBDVendaClienteAno;
  VpfDVendaMes : TRBDVendaClienteMes;
  VpfLacoAno,VpfLacoMes : Integer;
  VpfDClassificacao : TRBDPlanoContasRave;
  VpfQtdNiveisAnterior : Integer;
  VpfCodPlanoConta, VpfNomPlanoContas : string;
begin
  VpfDVenda := TRBDVendaCliente.cria;
  with RVSystem.BaseReport do begin
    while not  Clientes.Eof  do
    begin
      VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Clientes.FieldByName('C_CLA_PLA').AsString,false);
      if ContaLetra(VpfDClassificacao.CodPlanoCotas,'.') < VpfQtdNiveisAnterior then
        NewLine;
      VpfQtdNiveisAnterior := ContaLetra(VpfDClassificacao.CodPlanoCotas,'.');
      VpfCodPlanoConta :=AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.'))+ VpfDClassificacao.CodPlanoCotas;
      VpfNomPlanoContas := AdicionaCharD(' ','',ContaLetra(VpfDClassificacao.CodPlanoCotas,'.')*2)+VpfDClassificacao.NomPlanoContas;
      CarValoresPlanoContasMes(Clientes.FieldByName('C_CLA_PLA').AsString,VprDatInicio,VprDatFim,VpfDVenda);
      for VpfLacoAno := 0 to VpfDVenda.Anos.Count - 1 do
      begin
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
        VpfDVendaAno := TRBDVendaClienteAno(VpfDVenda.Anos.Items[VpfLacoAno]);
        PrintTab(VpfCodPlanoConta);
        PrintTab(VpfNomPlanoContas);
        VpfCodPlanoConta := '';
        VpfNomPlanoContas := '';
        PrintTab(IntToStr(VpfDVendaAno.Ano));
        for VpfLacoMes := 0 to VpfDVendaAno.Meses.Count - 1 do
        begin
          VpfDVendaMes := TRBDVendaClienteMes(VpfDVendaAno.Meses.Items[VpfLacoMes]);
          if VpfDVendaMes.ValVenda <> 0 then
          begin
            PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDVendaMes.ValVenda))
          end
          else
            PrintTab('');
        end;
        PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDVendaAno.ValVenda));
      end;
      Clientes.next;
    end;

  end;
  Clientes.Close;
  VpfDVenda.free;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCustoProjeto(VpaObjeto: TObject);
begin
  ImprimeRelCustoProjetoContasAPagar;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelCustoProjetoContasAPagar;
var
  VpfValDuplicata, VpfTotalDuplicata : Double;
  VpfPlanoContasAtual : string;
  VpfDClassificacao : TRBDPlanoContasRave;
begin
  VpfValDuplicata := 0;
  VpfTotalDuplicata := 0;
  VpfPlanoContasAtual := '';
  with RVSystem.BaseReport do begin
    RestoreTabs(4);
    NewLine;
    SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
    FillRect(CreateRect(MarginLeft-0.1,YPos-0.6,PageWidth-0.3,YPos+0.1));
    Bold := TRUE;
    FontSize := 18;
    PrintTab('CONTAS A PAGAR');
    NewLine;
    NewLine;
    Bold := false;
    FontSize := 10;
    while not Tabela.Eof  do
    begin
      if VpfPlanoContasAtual <> Tabela.FieldByName('C_CLA_PLA').AsString then
      begin
        if VpfDClassificacao <> nil then
          VpfDClassificacao.ValDuplicata := VpfDClassificacao.ValDuplicata + VpfValDuplicata;

        VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Tabela.FieldByName('C_CLA_PLA').AsString,true);
        ImprimetituloPlanoContas(VprNiveis,VpfPlanoContasAtual = '');
        VpfPlanoContasAtual := Tabela.FieldByName('C_CLA_PLA').AsString;
        VpfValDuplicata := 0;
      end;
      PrintTab(Tabela.FieldByName('I_COD_CLI').AsString+'-'+Tabela.FieldByName('C_NOM_CLI').AsString);
      PrintTab(Tabela.FieldByName('I_NRO_NOT').AsString);
      PrintTab(FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_EMI').AsDatetime));
      PrintTab(FormatFloat('#,###,###,##0.00',Tabela.FieldByName('VALDESPESA').AsFloat));
      PrintTab(FormatFloat('##0.00 %',Tabela.FieldByName('PERDESPESA').AsFloat));

      NewLine;
      If LinesLeft<=1 Then
        NewPage;
      VpfValDuplicata := VpfValDuplicata + Tabela.FieldByName('VALDESPESA').AsFloat;
      VpfTotalDuplicata := VpfTotalDuplicata + Tabela.FieldByName('VALDESPESA').AsFloat;
      Tabela.next;
    end;

    if VpfDClassificacao <> nil then
      VpfDClassificacao.ValDuplicata := VpfDClassificacao.ValDuplicata + VpfValDuplicata;
    if VprNiveis.Count > 0  then
      ImprimeTotaisNiveisPlanoContas(VprNiveis,0);

    newline;
    newline;
    newline;
    If LinesLeft<=1 Then
      NewPage;
    PrintTab('');
    bold := true;
    PrintTab('Total Geral');
    bold := true;
    PrintTab('');
    PrintTab(FormatFloat(varia.MascaraQtd,VpfTotalDuplicata));
    PrintTab('  ');
    bold := false;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelEntradaMetros(VpaObjeto : TObject);
var
  VpfMetroAmostra, VpfMetrosPedido, VpfMetrosItem : Double;
  VpfTotMetroAmostra, VpfTotMetPedido, VpfMetrosTotal : Double;
  VpfValAmostra, VpfValPedido, VpfValItem  : Double;
  VpfTotValAmostra,VpfTotValPedido,VpfValTotal : Double;
  VpfCodClassificacao, VpfNomClassificacao : String;
begin
  VpfTotMetroAmostra :=0; VpfTotMetPedido :=0;VpfMetrosTotal:=0;
  VpfTotValAmostra := 0; VpfTotValPedido :=0;VpfValTotal:=0;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfCodClassificacao <> Tabela.FieldByName('CODCLASSIFICACAO').AsString then
      begin
        if VpfCodClassificacao <> '' then
        begin
          PrintTab('  '+VpfNomClassificacao);
          PrintTab(FormatFloat('#,###,###,##0.00',VpfMetroAmostra));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValAmostra));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosPedido));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValPedido));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosItem));
          PrintTab(FormatFloat('#,###,###,##0.00',VpfValItem));
        end;
        VpfMetroAmostra :=0;
        VpfMetrosPedido :=0;
        VpfMetrosItem := 0;
        VpfValAmostra := 0;
        VpfValPedido :=0;
        VpfValItem := 0;
        VpfCodClassificacao := Tabela.FieldByName('CODCLASSIFICACAO').AsString;
        VpfNomClassificacao := Tabela.FieldByName('C_NOM_CLA').AsString;
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
      end;
      VpfMetroAmostra := VpfMetroAmostra + Tabela.FieldByName('QTDMETROAMOSTRA').AsFloat;
      VpfMetrosPedido := VpfMetrosPedido + Tabela.FieldByName('QTDMETROPEDIDO').AsFloat;
      VpfMetrosItem := VpfMetrosItem + Tabela.FieldByName('QTDMETROTOTAL').AsFloat;
      VpfValAmostra := VpfValAmostra + Tabela.FieldByName('VALAMOSTRA').AsFloat;
      VpfValPedido := VpfValPedido + Tabela.FieldByName('VALPEDIDO').AsFloat;
      VpfValItem := VpfValItem + Tabela.FieldByName('VALTOTAL').AsFloat;
      VpfTotMetroAmostra := VpfTotMetroAmostra + Tabela.FieldByName('QTDMETROAMOSTRA').AsFloat;
      VpfTotMetPedido := VpfTotMetPedido + Tabela.FieldByName('QTDMETROPEDIDO').AsFloat;
      VpfMetrosTotal := VpfMetrosTotal + Tabela.FieldByName('QTDMETROTOTAL').AsFloat;
      VpfTotValAmostra := VpfTotValAmostra + Tabela.FieldByName('VALAMOSTRA').AsFloat;
      VpfTotValPedido := VpfTotValPedido + Tabela.FieldByName('VALPEDIDO').AsFloat;
      VpfValTotal := VpfValTotal + Tabela.FieldByName('VALTOTAL').AsFloat;
      Tabela.next;
    end;
    if VpfCodClassificacao <> '' then
    begin
      PrintTab('  '+VpfNomClassificacao);
      PrintTab(FormatFloat('#,###,###,##0.00',VpfMetroAmostra));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValAmostra));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosPedido));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValPedido));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosItem));
      PrintTab(FormatFloat('#,###,###,##0.00',VpfValItem));
      NewLine;
    end;
    bold := true;
    PrintTab('  TOTAL');
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotMetroAmostra));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotValAmostra));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotMetPedido));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfTotValPedido));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfMetrosTotal));
    PrintTab(FormatFloat('#,###,###,##0.00',VpfValTotal));
    NewLine;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelExtratoProdutividade(VpaObjeto : TObject);
var
  VpfDia, VpfCelulaTrabalhoAtual, VpfLaco,VpfQtdColetas : Integer;
  VpfValTotal : Double;
begin
  VpfDia := 1;
  VpfCelulaTrabalhoAtual := 0;
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfCelulaTrabalhoAtual <> Tabela.FieldByName('CODCELULA').AsInteger then
      begin
        if VpfCelulaTrabalhoAtual <> 0 then
        begin
          ImprimeTotalCelulaTrabalho(VpfValTotal/VpfQtdColetas,VpfDia);
        end;
        VpfDia := 0;
        VpfQtdColetas := 0;
        VpfValTotal := 0;
        NewLine;
        If LinesLeft<=1 Then
          NewPage;
        VpfCelulaTrabalhoAtual := Tabela.FieldByName('CODCELULA').AsInteger;
        PrintTab('  '+Tabela.FieldByName('NOMCELULA').AsString );
      end;
      inc(VpfQtdColetas);
      VpfValTotal := VpfValTotal +Tabela.FieldByName('PERPRODUTIVIDADE').AsFloat;

      if (VpfDia +1) = DIA(Tabela.FieldByName('DATPRODUTIVIDADE').AsDateTime) then
        inc(VpfDia);
      for VpfDia := VpfDia to DIA(Tabela.FieldByName('DATPRODUTIVIDADE').AsDateTime)-2 do
        PrintTab('');
      VpfDia := DIA(Tabela.FieldByName('DATPRODUTIVIDADE').AsDateTime);
      if (Tabela.FieldByName('PERPRODUTIVIDADE').AsFloat < 50) then
        FontColor := clRed
      else
        if (Tabela.FieldByName('PERPRODUTIVIDADE').AsFloat > 100) then
          FontColor := clGreen;
      PrintTab(FormatFloat('0',Tabela.FieldByName('PERPRODUTIVIDADE').AsFloat));
      FontColor := clBlack;
      Tabela.next;
    end;
    if VpfCelulaTrabalhoAtual <> 0 then
    begin
      ImprimeTotalCelulaTrabalho(VpfValTotal/VpfQtdColetas,VpfDia);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCabecalho(VpaObjeto : TObject);
var
  VpfLaco : Integer;
  VpfQtdLinhasCabecalho : Integer;
begin
   with RVSystem.BaseReport do begin
    SetFont('Arial',16);
    MarginTop := 0.5;
    Home;
    Bold := true;
    PrintHeader(VprNomeRelatorio, pjCenter);
    Bold := false;
    if VprCabecalhoDireito.count > VprCabecalhoEsquerdo.count then
      VpfQtdLinhasCabecalho := VprCabecalhoDireito.count
    else
      VpfQtdLinhasCabecalho := VprCabecalhoEsquerdo.count;

    SetFont('Arial',10);
    for VpfLaco := 0 to VpfQtdLinhasCabecalho - 1 do
    begin
      MarginTop := MarginTop+LineHeight;
      Home;
       if VpfLaco <= VprCabecalhoEsquerdo.count -1 then
         PrintHeader(VprCabecalhoEsquerdo.Strings[VpfLaco], pjLeft);
       if VpfLaco <= VprCabecalhoDireito.count -1 then
         PrintHeader(VprCabecalhoDireito.Strings[VpfLaco], pjRight);
    end;
    // Traca uma linha
    Canvas.Pen.Width := 7;
    Canvas.Pen.Color := clBlack;
    MoveTo(MarginLeft,YPos+0.1);
    LineTo(PageWidth-MarginRight,YPos+0.1);
     MarginTop := MarginTop+LineHeight+0.2;
     Home;
     AdjustLine;
     case RvSystem.Tag of
       1,2,4,6,11,19 : ImprimeTituloClassificacao(VprNiveis,true);
       3 : ImprimeCabecalhoAnaliseFaturamento;
       8 : ImprimeCabecalhoEntradaMetros;
       9 : ImprimeCabecalhoExtratoProdutividade;
      13 : ImprimeCabecalhoTotalAmostrasVendedor;
      14 : ImprimeCabecalhoPorPlanoContasSintetico;
      17 : ImprimeCabecalhoPorPlanoContasSinteticoporMes;
      18 : ImprimeCabecalhoTotalTipoPedidoXCusto;
      20 : ImprimeCabecalhoResumoCaixas;
      21 : ImprimeCabecalhoRomaneioEtikArt;
     end;
   end;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRodape(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do
  begin
    if RvSystem.SystemPrinter.Orientation = poPortrait then
    begin
      MoveTo(0,28.5);
      LineTo(21,28.5);
      YPos := 29.0;
    end
    else
    begin
      MoveTo(0,20);
      LineTo(30,20);
      YPos := 20.5;
    end;
    SetFont('Arial',10);
    Bold := False;
    PrintLeft('Data Impressao : '  + FormatDatetime('DD/MM/YYYY - HH:MM:SS',NOW),0.3);
    Printright('Página ' + Macro(midCurrentPage) + ' de ' +
                Macro(midTotalPages),PageWidth-0.5);
    SetFont('Arial',4);
    PrintCenter(VprCaminhorelatorio,PageWidth/2);
  end;
end;

{******************************************************************************}
procedure TRBFunRave.EnviaParametrosFilial(VpaProjeto: TrvProject;VpaDFilial : TRBDFilial );
begin
  vpaProjeto.clearParams;
  VpaProjeto.SetParam('CODFILIAL',IntToStr(VpaDFilial.CodFilial));
  VpaProjeto.SetParam('NOMFILIAL',VpaDFilial.NomFantasia);
  VpaProjeto.SetParam('ENDFILIAL',VpaDFilial.DesEndereco);
  VpaProjeto.SetParam('BAIFILIAL',VpaDFilial.DesBairro);
  VpaProjeto.SetParam('CIDFILIAL',VpaDFilial.DesCidade+'/'+VpaDFilial.DesUF);
  VpaProjeto.SetParam('CEPFILIAL',VpaDFilial.DesCEP);
  VpaProjeto.SetParam('FONFILIAL',VpaDFilial.DesFone);
  VpaProjeto.SetParam('FAXFILIAL',VpaDFilial.DesFax);
  VpaProjeto.SetParam('SITFILIAL',Lowercase(VpaDFilial.DesSite));
  VpaProjeto.SetParam('EMAFILIAL',Lowercase(VpaDFilial.DESEMAIL));
  VpaProjeto.SetParam('CGCFILIAL',Lowercase(VpaDFilial.DesCNPJ));
  VpaProjeto.SetParam('IESFILIAL',Lowercase(VpaDFilial.DesInscricaoEstadual));
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutoVendidosPorClassificacao(VpaCodFilial,VpaCodCliente, VpaCodVendedor, VpaCodTipoCotacao, VpaCodClienteMaster : Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial,VpaNomCliente, VpaNomVendedor,VpaNomTipoCotacao, VpaNomClienteMaster : String;VpaAgruparPorEstado, VpaPDF : Boolean);
begin
  RvSystem.Tag := 1;
  VprAgruparPorEstado := VpaAgruparPorEstado;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI UMPADRAO, ' +
                           ' MOV.N_QTD_PRO, MOV.N_VLR_TOT, MOV.I_COD_TAM, MOV.I_COD_COR, MOV.C_COD_UNI, MOV.I_SEQ_PRO, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' CLI.C_EST_CLI, '+
                           ' COR.NOM_COR ' +
                           ' FROM MOVORCAMENTOS MOV, CADORCAMENTOS CAD, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR, CADCLIENTES CLI ' +
                           ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                           ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC ' +
                           ' AND CAD.C_IND_CAN = ''N'''+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ' +
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor   <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
  if VpaCodTipoCotacao <> 0  then
    AdicionaSqlTabela(Tabela,' and CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));
  if VpaCodClienteMaster <> 0  then
    AdicionaSqlTabela(Tabela,' and CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));

  if VpaAgruparPorEstado then
    AdicionaSqlTabela(Tabela,' ORDER BY CLI.C_EST_CLI, CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ')
  else
    AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaProdutosPorClassificacao;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeProdutoporClassificacao;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtos Vendidos por Classificação';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);
  if DeletaChars(VpaNomTipoCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipoCotacao);
  if VpaCodClienteMaster <> 0 then
    VprCabecalhoEsquerdo.add('Cliente Master : ' +VpaNomClienteMaster);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeEstoqueProdutos(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados,VpaSomenteComQtd : Boolean);
begin
  RvSystem.Tag := 2;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, PRO.C_BAR_FOR, ' +
                           ' MOV.N_QTD_PRO,  MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_CUS, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR ' +
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ' +
                           ' WHERE  PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ');
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');

  if VpaIndProdutosMonitorados  then
    AdicionaSQLTabela(Tabela,'and PRO.C_IND_MON = ''S''');
  if VpaSomenteComQtd then
    AdicionaSQLTabela(Tabela,' and MOV.N_QTD_PRO <> 0 ');

  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_NOM_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaEstoqueProdutos;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEstoqueProdutos;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Estoque Atual Produtos';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeAnaliseFaturamentoMensal(VpaCodFilial,VpaCodCliente,VpaCodVendedor : Integer;VpaCaminho, VpaNomFilial,VpaNomCliente,VpaNomVendedor : String;VpaDatInicio, VpaDatFim : TDateTime);
begin
  RvSystem.Tag := 3;
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  LimpaSQlTabela(Clientes);
  AdicionaSqltabela(Clientes,'SELECT VEN.C_NOM_VEN, VEN.I_COD_VEN, I_COD_CLI, C_NOM_CLI '+
                             ' FROM CADCLIENTES CLI, CADVENDEDORES VEN '+
                             ' WHERE '+SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN')+
                             ' AND CLI.C_IND_CLI = ''S''');
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Clientes,' and CLI.I_COD_CLI = '+InttoStr(VpaCodCliente));

  if VpaCodVendedor <> 0  then
    AdicionaSqlTabela(Clientes,' and CLI.I_COD_VEN = '+InttoStr(VpaCodVendedor));

  AdicionaSqlTabela(Clientes,'ORDER BY C_NOM_VEN, C_NOM_CLI');
  Clientes.open;
  VprNomVendedor := Clientes.FieldByName('C_NOM_VEN').AsString;
  RvSystem.SystemPrinter.Orientation := poLandScape;

  rvSystem.onBeforePrint := DefineTabelaAnaliseFaturamentoMensal;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelAnaliseFaturamentoAnual;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Analise Faturamento Anual';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodCliente <> 0  then
    VprCabecalhoDireito.add('Cliente : ' +VpaNomCliente);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeQtdMinimasEstoque(VpaCodFilial, VpaCodFornecedor : Integer;VpaCaminho,VpaCodClassificacao,VpaNomFilial, VpaNomClassificacao, VpaNomFornecedor : String);
begin
  RvSystem.Tag := 4;
  FreeTObjectsList(VprNiveis);
  RvSystem.SystemPrinter.Orientation := poLandScape;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, ' +
                           ' MOV.N_QTD_PRO, MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_COM, ' +
                           ' MOV.N_QTD_MIN, MOV.N_QTD_PED, '+
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR '+
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ');
  if VpaCodFornecedor <> 0 then
    AdicionaSqltabela(Tabela,', PRODUTOFORNECEDOR PFO');

  AdicionaSqltabela(Tabela,' WHERE PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' AND MOV.N_QTD_PRO < MOV.N_QTD_MIN');
  if VpaCodFornecedor <> 0 then
    AdicionaSqltabela(Tabela,' AND MOV.I_SEQ_PRO = PFO.SEQPRODUTO '+
                             ' AND MOV.I_COD_COR = PFO.CODCOR '+
                             ' AND PFO.CODCLIENTE = '+IntToStr(VpaCodFornecedor));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');


  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaQtdMinimas;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEstoqueMinimo;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Estoque Minimo';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
{  if DeletaChars(VpaomTipoCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipoCotacao);}

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);
  if VpaNomFornecedor <> ''  then
    VprCabecalhoDireito.add('Fornecedor : ' +VpaNomFornecedor+ '   ');
  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeEstoqueFiscalProdutos(VpaCodFilial: Integer;VpaCaminho, VpaCodClassificacao, VpaTipoRelatorio, VpaNomFilial, VpaNomClassificacao: String; VpaIndProdutosMonitorados: Boolean);
begin
  RvSystem.Tag := 5;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, ' +
                           ' MOV.N_QTD_PRO,  MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_CUS, ' +
                           ' MOV.N_QTD_FIS, '+
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR ' +
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ' +
                           ' WHERE  PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ');
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');

  if VpaIndProdutosMonitorados  then
    AdicionaSQLTabela(Tabela,'and PRO.C_IND_MON = ''S''');

  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaEstoqueProdutos;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEstoqueProdutos;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Estoque Atual Produtos';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeFechamentoMes(VpaCodFilial: Integer; VpaCaminho,VpaNomFilial: String; VpaData: TDateTime;VpaMostarTodos : Boolean);
begin
  RvSystem.Tag := 6;
  VprTodosProdutos := VpaMostarTodos;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'Select CLA.C_COD_CLA, CLA.C_NOM_CLA, '+
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                           ' MOV.N_VLR_COM, '+
                           ' SUE.I_EMP_FIL, SUE.N_QTD_PRO, SUE.N_VLR_CMV, SUE.N_VLR_VEN_MES, '+
                           ' SUE.N_QTD_VEN_MES, SUE.N_VLR_DEV_VEN, SUE.N_QTD_DEV_VEN, '+
                           ' SUE.I_MES_FEC, SUE.I_ANO_FEC, SUE.N_QTD_ANT, SUE.C_REL_PRO, '+
                           ' SUE.N_VLR_VEN_LIQ '+
                           ' FROM CADCLASSIFICACAO CLA, CADPRODUTOS PRO, MOVQDADEPRODUTO MOV, MOVSUMARIZAESTOQUE SUE '+
                           ' Where PRO.I_COD_EMP = CLA.I_COD_EMP '+
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' AND PRO.I_SEQ_PRO = MOV.I_SEQ_PRO '+
                           ' AND SUE.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                           ' AND SUE.C_REL_PRO = ''S'''+
//                           ' and cla.c_cod_cla like ''02308%'''+
                           ' AND SUE.I_MES_FEC = '+IntToStr(Mes(VpaData))+
                           ' AND SUE.I_ANO_FEC = '+IntToStr(Ano(VpaData))+
                           ' AND SUE.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                           ' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO ');

  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaFechamentoEstoque;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelFechamentoEstoque;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Fechamento Mensal';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeContasAPagarPorPlanodeContas(VpaCodFilial : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial : String;VpfTipoPeriodo : Integer);
var
  VpfCampoData : String;
begin
  case VpfTipoPeriodo of
    0 : VpfCampoData := 'CAD.D_DAT_EMI';
    1 : VpfCampoData := 'MOV.D_DAT_VEN';
  else
    VpfCampoData := 'CAD.D_DAT_EMI';
  end;
  RvSystem.Tag := 7;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'Select  PLA.N_VLR_PRE, PLA.C_CLA_PLA, PLA.C_NOM_PLA, '+
                           ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                           ' CAD.I_NRO_NOT , '+
                           ' MOV.I_EMP_FIL , MOV.D_DAT_VEN, MOV.N_VLR_DUP, MOV.D_DAT_PAG, MOV.N_VLR_PAG , MOV.I_NRO_PAR '+
                           ' from CAD_PLANO_CONTA PLA, CADCLIENTES CLI, CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV '+
                           ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                           ' AND CAD.I_LAN_APG = MOV.I_LAN_APG '+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND CAD.C_CLA_PLA = PLA.C_CLA_PLA '+
                           SQLTextoDataEntreAAAAMMDD(VpfCampoData,VpaDatInicio,VpaDatFim,true));

  if VpaCodFilial <> 0 then
    AdicionaSqlTabela(Tabela,'and MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial));

  AdicionaSqlTabela(Tabela,' ORDER BY PLA.C_CLA_PLA, CLI.C_NOM_CLI');

  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaCPporPlanoContas;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCPporPlanoContas;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Contas a Pagar Analítico por Plano de Contas';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeEntradaMetros(VpaDatInicio, VpaDatFim : TDateTime);
begin
  RvSystem.Tag := 8;
  RvSystem.SystemPrinter.Orientation := poLandScape;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqlAbreTabela(Tabela,'SELECT MET.DATENTRADA, MET.CODCLASSIFICACAO, MET.QTDMETROAMOSTRA, MET.QTDMETROPEDIDO, MET.QTDMETROTOTAL, '+
                                  ' MET.VALAMOSTRA, MET.VALPEDIDO, MET.VALTOTAL, '+
                                  ' CLA.C_NOM_CLA '+
                                  ' FROM  ENTRADAMETRODIARIO MET, CADCLASSIFICACAO CLA '+
                                  ' WHERE MET.CODCLASSIFICACAO = CLA.C_COD_CLA '+
                                  ' AND CLA.C_TIP_CLA = ''P'''+
                                  ' ORDER BY CODCLASSIFICACAO');


  rvSystem.onBeforePrint := DefineTabelaEntradaMetro;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEntradaMetros;

//  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Entrada de Metros';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Período : ' +FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' - '+FormatDateTime('DD/MM/YYYY',VpaDatFim));

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeExtratoProdutividade(VpaCaminho : String;VpaData : TDateTime);
begin
  RvSystem.Tag := 9;
  VprMes := Mes(VpaData);
  VprAno := Ano(VpaData);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'Select CEL.CODCELULA, CEL.NOMCELULA, '+
                             ' TRA.DATPRODUTIVIDADE, TRA.PERPRODUTIVIDADE '+
                             ' from CELULATRABALHO CEL, PRODUTIVIDADECELULATRABALHO TRA '+
                             ' Where CEL.CODCELULA = TRA.CODCELULA'+
                              SQLTextoDataEntreAAAAMMDD('TRA.DATPRODUTIVIDADE',PrimeiroDiaMes(VpaData),UltimoDiaMes(VpaData),true));

  AdicionaSqlTabela(Tabela,'ORDER BY CEL.NOMCELULA, TRA.DATPRODUTIVIDADE');
  Tabela.open;
  RvSystem.SystemPrinter.Orientation := poLandScape;

  rvSystem.onBeforePrint := DefineTabelaExtratoProdutividade;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelExtratoProdutividade;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtividade Diária';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Mês : ' +IntToStr(Mes(VpaData)));

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeCustoProjeto(VpaCodProjeto: Integer; VpaCaminho, VpaNomProjeto: String);
begin
  RvSystem.Tag := 10;
  VprCodProjeto := VpaCodProjeto;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'Select  PLA.C_CLA_PLA, PLA.C_NOM_PLA, '+
                           ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                           ' CAD.I_NRO_NOT , CAD.D_DAT_EMI, '+
                           ' CPR.VALDESPESA, CPR.PERDESPESA '+
                           ' from CAD_PLANO_CONTA PLA, CADCLIENTES CLI, CADCONTASAPAGAR CAD, CONTAAPAGARPROJETO CPR '+
                           ' Where CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND CAD.C_CLA_PLA = PLA.C_CLA_PLA '+
                           ' AND CAD.I_EMP_FIL = CPR.CODFILIAL '+
                           ' AND CAD.I_LAN_APG = CPR.LANPAGAR '+
                           ' AND CPR.CODPROJETO = '+IntToStr(VpaCodProjeto));
  AdicionaSqlTabela(Tabela,' ORDER BY PLA.C_CLA_PLA, CLI.C_NOM_CLI');
  Tabela.open;
  RvSystem.SystemPrinter.Orientation := poPortrait;

  rvSystem.onBeforePrint := DefineTabelaCustoProjeto;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCustoProjeto;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Custo Projeto';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Projeto : ' +IntToStr(VpaCodProjeto)+'-'+VpaNomProjeto);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTabelaPreco(VpaCodCliente, VpaCodTabelaPreco: Integer; VpaCaminho, VpaNomCliente, VpaNomTabelaPreco,VpaCodClassificacao, VpaNomClassificacao: String);
begin
  RvSystem.Tag := 11;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, '+
                           ' PRE.C_CIF_MOE, PRE.N_VLR_VEN VLRVENDA, '+
                           ' TAM.CODTAMANHO, TAM.NOMTAMANHO, '+
                           ' COR.COD_COR, COR.NOM_COR '+
                           ' from MOVTABELAPRECO PRE, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR '+
                           ' Where PRE.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP '+
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA '+
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' AND PRO.I_COD_EMP = PRE.I_COD_EMP '+
                           ' AND PRO.C_ATI_PRO = ''S'''+
                           ' AND PRO.IMPPRE = ''S'''+
                           ' AND '+SQLTextoRightJoin('PRE.I_COD_TAM','TAM.CODTAMANHO')+
                           ' AND '+SQLTextoRightJoin('PRE.I_COD_COR','COR.COD_COR')+
                           ' AND PRE.I_COD_EMP =  '+IntTostr(Varia.CodigoEmpresa)+
                           ' AND PRE.I_COD_CLI =  '+IntToStr(VpaCodCliente)+
                           ' AND PRE.I_COD_TAB = '+IntToStr(VpaCodTabelaPreco));
  if VpaCodClassificacao <> '' then
    AdicionaSqltabela(Tabela,'AND PRO.C_COD_CLA LIKE '''+VpaCodClassificacao+'%''');

  AdicionaSqltabela(Tabela,' ORDER BY PRO.C_COD_CLA, PRO.C_COD_PRO, COR.COD_COR, TAM.CODTAMANHO');
  Tabela.open;
  RvSystem.SystemPrinter.Orientation := poPortrait;

  rvSystem.onBeforePrint := DefineTabelaTabelaPreco;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelTabelaPreco;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Tabela de Preço';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Tabela : ' +IntToStr(VpaCodTabelaPreco)+'-'+VpaNomTabelaPreco);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> '' then
    VprCabecalhoDireito.Add(VpaNomClassificacao);
  if (VpaCodCliente <> 0) then
    VprCabecalhoDireito.Add(VpaNomCliente);
  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeEstoqueProdutosReservados(VpaCodFilial: Integer; VpaCaminho, VpaCodClassificacao, VpaTipoRelatorio, VpaNomFilial,VpaNomClassificacao: String; VpaIndProdutosMonitorados: Boolean);
begin
  RvSystem.Tag := 12;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI, PRO.C_BAR_FOR, ' +
                           ' MOV.N_QTD_RES,  MOV.I_COD_TAM, MOV.I_COD_COR, MOV.I_SEQ_PRO, MOV.N_VLR_CUS, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' COR.NOM_COR ' +
                           ' FROM MOVQDADEPRODUTO MOV,  CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR ' +
                           ' WHERE  PRO.C_ATI_PRO = ''S'''+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA '+
                           ' AND MOV.N_QTD_RES <> 0 ');
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and MOV.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodClassificacao <> '' then
    AdicionaSqlTabela(Tabela,'And PRO.C_COD_CLA like '''+VpaCodClassificacao+ '%''');

  if VpaIndProdutosMonitorados  then
    AdicionaSQLTabela(Tabela,'and PRO.C_IND_MON = ''S''');

  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_NOM_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaEstoqueProdutos;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelEstoqueProdutos;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Estoque Atual Produtos Reservados';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotaAmostrasPorVendedor(VpaCodVendedor: Integer; VpaCaminho, VpaNomVendedor: String; VpaDatInicio,VpaDatFim: TDateTime);
begin
  RvSystem.Tag := 13;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  VprDatInicio :=  VpaDatInicio;
  VprDatFim :=  VpaDatFim;
  AdicionaSqltabela(Tabela,'Select I_COD_VEN, C_NOM_VEN '+
                           ' FROM CADVENDEDORES '+
                           ' Where C_IND_ATI = ''S''');
  if VpaCodVendedor <> 0 then
    AdicionaSqlTabela(Tabela,' and I_COD_VEN = '+InttoStr(VpaCodVendedor));

  AdicionaSqlTabela(Tabela,' ORDER BY C_NOM_VEN ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaTotalAmostraporVendedor;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelTotalAmostrasVendedor;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Amostras por Vendedor';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Periodo de ' + FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+ FormatDateTime('DD/MM/YYYY',VpaDatFim));
  if  VpaCodVendedor <> 0 then
    VprCabecalhoEsquerdo.add('Vendedor : ' +VpaNomVendedor);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeContasAPagarPorPlanoContasSintetico(VpaDatInicio, VpaDatFim: TDateTime; VpaCaminho : String);
var
  VpfCampoData : String;
begin
  VpfCampoData := 'CAD.D_DAT_EMI';
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  RvSystem.Tag := 14;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT * FROM CAD_PLANO_CONTA '+
                           ' WHERE C_TIP_PLA = ''D'''+
                           ' and I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa)+
                           ' ORDER BY C_CLA_PLA');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaCPporPlanoContasSintetico;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCPporPlanoContasSintetico;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Contas a Pagar Sintetico por Plano de Contas';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Empresa : ' +Varia.NomeEmpresa);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de ' +FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim)+'  ');

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeFichaAmosta(VpaDAmostra: TRBDAmostra);
begin
  RvSystem.Tag := 15;
  FreeTObjectsList(VprNiveis);

  rvSystem.onBeforePrint := DefineTabelaCPporPlanoContasSintetico;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCPporPlanoContasSintetico;

  VprNomeRelatorio := 'Ficha Amostra';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Empresa : ' +Varia.NomeEmpresa);

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutosVendidoseTrocacos(VpaCodFilial, VpaTipCotacao, VpaCodCliente, VpaCodVendedor, VpaCodClienteMaster: Integer;
  VpaCaminho, VpaNomFilial, VpaNomVendedor, VpaNomTipCotacao, VpaNomCliente, VpaNomClienteMaster : string; VpaDatInicio, VpaDatFim: TDateTime);
begin
  RvSystem.Tag := 16;
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  VprClienteMaster := VpaCodClienteMaster;
  VprCliente :=  VpaCodCliente;
  VprFilial := VpaCodFilial;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI UMPADRAO, ' +
                           ' MOV.N_QTD_PRO, MOV.N_VLR_TOT, MOV.I_COD_TAM, MOV.I_COD_COR, MOV.C_COD_UNI, MOV.I_SEQ_PRO, ' +
                           ' TAM.NOMTAMANHO, ' +
                           ' CLI.C_EST_CLI, '+
                           ' COR.NOM_COR ' +
                           ' FROM MOVORCAMENTOS MOV, CADORCAMENTOS CAD, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR, CADCLIENTES CLI ' +
                           ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                           ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC ' +
                           ' AND CAD.C_IND_CAN = ''N'''+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ' +
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaTipCotacao <> 0  then
    AdicionaSqlTabela(Tabela,' and CAD.I_TIP_ORC = '+InttoStr(VpaTipCotacao));
  if VpaCodClienteMaster <> 0  then
    AdicionaSqlTabela(Tabela,' and CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));

  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaProdutosVendidoseTrocados;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeProdutoporClassificacao;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtos Vendidos e Trocados';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);
  if DeletaChars(VpaNomTipCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipCotacao);
  if VpaCodClienteMaster <> 0 then
    VprCabecalhoEsquerdo.add('Cliente Master : ' +VpaNomClienteMaster);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeContasAPagarPorPlanoContasSinteticoMes(VpaDatInicio, VpaDatFim: TDateTime; VpaCaminho: String);
var
  VpfCampoData : String;
begin
  VpfCampoData := 'CAD.D_DAT_EMI';
  VprDatInicio := VpaDatInicio;
  VprDatFim := VpaDatFim;
  RvSystem.Tag := 17;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Clientes);
  AdicionaSqltabela(Clientes,'SELECT * FROM CAD_PLANO_CONTA '+
                           ' WHERE C_TIP_PLA = ''D'''+
                           ' and I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa)+
                           ' ORDER BY C_CLA_PLA');
  Clientes.open;

  RvSystem.SystemPrinter.Orientation := poLandScape;
  rvSystem.onBeforePrint := DefineTabelaCPporPlanoContasSinteticoporMes;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelCPporPlanoContasSinteticoporMes;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Contas a Pagar Sintetico por Mes e Plano de Contas';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Empresa : ' +Varia.NomeEmpresa);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de ' +FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim)+'  ');

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeTotalTipoCotacaoXCusto(VpaCodFilial, VpaCodCliente, VpaCodVendedor, VpaCodTipoCotacao: Integer; VpaCaminho, VpaNomFilial, VpaNomCliente, VpaNomVendedor, VpaNomTipoCotacao: String; VpaDAtInicio, VpaDatFim: TDAteTime);
begin
  RvSystem.Tag := 18;
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'select ORC.I_EMP_FIL, ORC.I_LAN_ORC, TIP.I_COD_TIP, N_VLR_LIQ, N_VLR_PRO, ORC.I_LAN_ORC QTD,  TIP.C_NOM_TIP  '+
                           ' from CADORCAMENTOS ORC, CADTIPOORCAMENTO TIP '+
                           ' Where ORC.I_TIP_ORC = TIP.I_COD_TIP '+
                            SQLTextoDataEntreAAAAMMDD('ORC.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and ORC.I_EMP_FIL = '+InttoStr(VpaCodFilial));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and ORC.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor   <> 0 then
    AdicionaSqlTabela(Tabela,' and ORC.I_COD_VEN = '+InttoStr(VpaCodVendedor));
  if VpaCodTipoCotacao <> 0  then
    AdicionaSqlTabela(Tabela,' and ORC.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));

  AdicionaSqlTabela(Tabela,' ORDER BY TIP.I_COD_TIP ');

  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaTotalTipoCotacaoXCusto;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelTotalTipoCotacaoXCusto;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Valor ';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);
  if DeletaChars(VpaNomTipoCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipoCotacao);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;

end;

{******************************************************************************}
procedure TRBFunRave.ImprimeProdutosVendidosComDefeito(VpaCodFilial, VpaCodCliente, VpaCodVendedor: Integer; VpaDatInicio, VpaDatFim: TDateTime;VpaCaminho, VpaNomFilial, VpaNomCliente, VpaNomVendedor, VpaCodClassificao, VpaNomClassificacao: String; VpaPDF: Boolean);
begin
  RvSystem.Tag := 19;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqltabela(Tabela,'SELECT  CLA.C_COD_CLA, CLA.C_NOM_CLA, ' +
                           ' PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_COD_UNI UMPADRAO, ' +
                           ' MOV.N_QTD_PRO, MOV.N_VLR_TOT, MOV.I_COD_TAM, MOV.I_COD_COR, MOV.C_COD_UNI, MOV.I_SEQ_PRO, ' +
                           ' CAD.I_TIP_ORC, '+
                           ' TAM.NOMTAMANHO, ' +
                           ' CLI.C_EST_CLI, '+
                           ' COR.NOM_COR ' +
                           ' FROM MOVORCAMENTOS MOV, CADORCAMENTOS CAD, CADPRODUTOS PRO, CADCLASSIFICACAO CLA, TAMANHO TAM, COR, CADCLIENTES CLI ' +
                           ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                           ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC ' +
                           ' AND CAD.C_IND_CAN = ''N'''+
                           ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
                           ' AND MOV.I_COD_TAM = TAM.CODTAMANHO(+) ' +
                           ' AND MOV.I_COD_COR = COR.COD_COR(+) ' +
                           ' AND PRO.I_COD_EMP = CLA.I_COD_EMP ' +
                           ' AND PRO.C_COD_CLA = CLA.C_COD_CLA ' +
                           ' AND PRO.C_TIP_CLA = CLA.C_TIP_CLA ' +
                            SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial))
  else
    AdicionaSqlTabela(Tabela,' and PRO.I_COD_EMP = '+InttoStr(Varia.CodigoEmpresa));
  if VpaCodCliente <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
  if VpaCodVendedor   <> 0 then
    AdicionaSqlTabela(Tabela,' and CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
  if VpaCodClassificao <> '' then
    AdicionaSqlTabela(Tabela,' and PRO.C_COD_CLA LIKE '''+VpaCodClassificao+'%''');

  AdicionaSqlTabela(Tabela,' ORDER BY CLA.C_COD_CLA, PRO.C_COD_PRO, COR.NOM_COR, TAM.NOMTAMANHO ');
  Tabela.open;

  rvSystem.onBeforePrint := DefineTabelaProdutosComDefeito;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelProdutosComDefeito;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Produtos Com Defeito';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Filial : ' +VpaNomFilial);
  if VpaCodCliente <> 0 then
    VprCabecalhoEsquerdo.add('Cliente : ' +VpaNomCliente);

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeResumosCaixas(VpaCaminho : String;VpaPDF: Boolean);
begin
  RvSystem.Tag := 20;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqlAbretabela(Tabela,'select CON.C_NRO_CON, CON.I_COD_BAN, CON.C_NOM_CRR, CON.C_NRO_AGE, CON.C_TIP_CON, CON.N_SAL_ATU, '+
                           ' BAN.C_NOM_BAN '+
                           ' from CADCONTAS CON, CADBANCOS BAN '+
                           ' WHERE CON.C_IND_ATI = ''T'''+
                           ' AND CON.I_COD_BAN = BAN.I_COD_BAN '+
                           ' ORDER BY I_COD_BAN, C_NOM_CRR');

  rvSystem.onBeforePrint := DefineTabelaResumoCaixas;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelResumoCaixas;

  VprCaminhoRelatorio := VpaCaminho;
  VprNomeRelatorio := 'Resumo Caixas';
  VprCabecalhoEsquerdo.Clear;

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRomaneioEtikArt(VpaCodFilial, VpaSeqRomaneio: Integer; VpaVisualizar: Boolean);
begin
  RvSystem.Tag := 21;
  RvSystem.SystemPrinter.Orientation := poLandScape;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);
  AdicionaSqlAbretabela(Tabela,'select PRO.C_NOM_PRO, ' +
                               ' OP.NUMPED, OP.CODPRO, OP.VALUNI, OP.TIPTEA, OP.SEQORD, '+
                               ' OPI.CODCOM, OPI.CODMAN, OPI.NROFIT, OPI.METCOL, (OPI.METCOL * OPI.NROFIT) / 1000 TOTALKM '+
                               ' from ORDEMPRODUCAOCORPO OP, COLETAOPITEM opi, CADPRODUTOS PRO, ROMANEIOITEM RIT '+
                               ' WHERE OPI.EMPFIL = OP.EMPFIL '+
                               ' AND OPI.SEQORD = OP.SEQORD '+
                               ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                               ' AND RIT.EMPFIL = OPI.EMPFIL '+
                               ' AND RIT.SEQORD = OPI.SEQORD '+
                               ' AND RIT.SEQCOL = OPI.SEQCOL '+
                               ' AND RIT.EMPFIL = '+IntToStr(VpaCodFilial)+
                               ' and rit.SEQROM = '+IntToStr(VpaSeqRomaneio)+
                               ' order by OP.NUMPED, OPI.CODCOM, OPI.CODMAN');

  rvSystem.onBeforePrint := DefineTabelaRomaneioEtikArt;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelRomaneioEtikArt;

  VprNomeRelatorio := 'Romaneio de Faturamento';
  VprCabecalhoEsquerdo.Clear;
  VprCabecalhoEsquerdo.add('Romaneio : ' + inttoStr(VpaSeqRomaneio));

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;


{******************************************************************************}
procedure TRBFunRave.ImprimeOrdemProducaoEtikArt(VpaDOrdemProducao : TRBDOrdemProducaoEtiqueta; VpaVisualizar: Boolean);
begin
  RvSystem.Tag := 22;
  VprDOPEtikArt := VpaDOrdemProducao;
  FreeTObjectsList(VprNiveis);
  LimpaSQlTabela(Tabela);

  rvSystem.onBeforePrint := DefineTabelaOPEtikArt;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelOPEtikArt;

  VprNomeRelatorio := 'Romaneio de Faturamento';
  VprCabecalhoEsquerdo.Clear;

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRomaneioSeparacaoCotacao(VpaCotacoes: TList);
begin
  RvSystem.Tag := 23;
  FreeTObjectsList(VprNiveis);

  rvSystem.onBeforePrint := DefineTabelaRomaneioSeparacaoCotacao;
  rvSystem.onNewPage := ImprimeCabecalho;
  rvSystem.onPrintFooter := Imprimerodape;
  rvSystem.onPrint := ImprimeRelRomaneioSeparacaoCotacao;

  VprNomeRelatorio := 'Romaneio de Separação';
  VprCabecalhoEsquerdo.Clear;

  VprCabecalhoDireito.Clear;

  ConfiguraRelatorioPDF;
  RvSystem.execute;
end;


end.
