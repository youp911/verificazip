unit UnRave;
{Verificado
-.edit;
}
interface
Uses SQLExpr, RpRave, UnDados, SysUtils, RpDefine, RpBase, RpSystem,RPDevice,
     Classes, forms, Graphics, unprodutos, UnClassificacao;


Type
  TRBDTamanhoProdutoRave = class
    public
     CodTamanho : Integer;
     NomTamanho : String;
     QtdEstoque : Double;
     constructor cria;
     destructor destroy;override;
  end;

Type
  TRBDCorProdutoRave = class
    public
      CodCor : Integer;
      NomCor : String;
      QtdEstoque : Double;
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
      NomProduto : String;
      QtdEstoque : Double;
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
    ValTotal,
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
      Tabela,
      Clientes : TSQLQuery;
      RvSystem: TRvSystem;
      VprCabecalhoEsquerdo,
      VprCabecalhoDireito : TStringList;
      VprCaminhoRelatorio,
      VprNomeRelatorio,
      VprPrimeiraLinha,
      VprNomVendedor,
      VprUfAtual : String;
      VprMes,
      VprAno,
      VprCodProjeto : Integer;
      VprDatInicio,
      VprDatFim : TDateTime;
      VprAgruparPorEstado,
      VprTodosProdutos : Boolean;
      FunClassificacao : TFuncoesClassificacao;
      VprNiveis : TList;
      procedure DefineTabelaProdutosPorClassificacao(VpaObjeto : TObject);
      procedure DefineTabelaEstoqueProdutos(VpaObjeto : TObject);
      procedure DefineTabelaQtdMinimas(VpaObjeto : TObject);
      procedure DefineTabelaAnaliseFaturamentoMensal(VpaObjeto : TObject);
      procedure DefineTabelaFechamentoEstoque(VpaObjeto : TObject);
      procedure DefineTabelaCPporPlanoContas(VpaObjeto : TObject);
      procedure DefineTabelaEntradaMetro(VpaObjeto : TObject);
      procedure DefineTabelaExtratoProdutividade(VpaObjeto : TObject);
      procedure DefineTabelaCustoProjeto(VpaObjeto : TObject);
      procedure ImprimeProdutoPorClassificacao(VpaObjeto : TObject);
      procedure ImprimeRelEstoqueProdutos(VpaObjeto : TObject);
      procedure ImprimeTotaisNiveis(VpaNiveis : TList;VpaIndice : integer);
      procedure ImprimeTotaisNiveisPlanoContas(VpaNiveis : TList;VpaIndice : integer);
      procedure ImprimeTotalCelulaTrabalho(VpaValTotal : Double;VpaDiaAtua : Integer);
      procedure ImprimeCabecalhoEstoque;
      procedure ImprimeCabecalhoQtdMinima;
      procedure ImprimeCabecalhoAnaliseFaturamento;
      procedure ImprimeCabecalhoFechamentoEstoque;
      procedure ImprimeCabecalhoEntradaMetros;
      procedure ImprimeCabecalhoPlanoContas;
      procedure ImprimeCabecalhoPlanoContasCustoProjeto;
      procedure ImprimeCabecalhoExtratoProdutividade;
      procedure ImprimeTituloUF(VpaCodUf : String);
      procedure ImprimeTituloClassificacao(VpaNiveis : TList;VpaTudo : boolean);
      procedure ImprimetituloPlanoContas(VpaNiveis : TList;VpaTudo : boolean);
      procedure CarCorTamanhoProduto(VpaDProduto : TRBDProdutoRave;VpaDCor : TRBDCorProdutoRave;VpaDTamanho : TRBDTamanhoProdutoRave;VpaCodCor, VpaCodTamanho : Integer);
      function CarDNivel(VpaCodCompleto, VpaCodReduzido : String):TRBDClassificacaoRave;
      function CarregaNiveis(VpaNiveis : TList;VpaCodClassificacao : string):TRBDClassificacaoRave;
      function CarDNivelPlanoContas(VpaCodCompleto, VpaCodReduzido : String):TRBDPlanoContasRave;
      function CarregaNiveisPlanoContas(VpaNiveis : TList;VpaCodPlanoContas : string):TRBDPlanoContasRave;
      procedure ImprimeRelCustoProjetoContasAPagar;

      procedure InicializaVendaCliente(VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente);
      function RMesVenda(VpaDVenda : TRBDVendaCliente;VpaMes, VpaAno : Integer) : TRBDVendaClienteMes;
      procedure AtualizaTotalVenda(VpaDVenda : TRBDVendaCliente);
      function CarValoresFaturadosCliente(VpaCodCliente : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaDVenda : TRBDVendaCliente):boolean;

      procedure ImprimeRelEstoqueMinimo(VpaObjeto : TObject);
      procedure ImprimeRelAnaliseFaturamentoAnual(VpaObjeto : TObject);
      procedure ImprimeRelFechamentoEstoque(VpaObjeto : TObject);
      procedure ImprimeRelCPporPlanoContas(VpaObjeto : TObject);
      procedure ImprimeRelEntradaMetros(VpaObjeto : TObject);
      procedure ImprimeRelExtratoProdutividade(VpaObjeto : TObject);
      procedure ImprimeRelCustoProjeto(VpaObjeto : TObject);

      procedure ImprimeCabecalho(VpaObjeto : TObject);
      procedure ImprimeRodape(VpaObjeto : TObject);
    public
      constructor cria(VpaBaseDados : TSQLConnection);
      destructor destroy;override;
      procedure EnviaParametrosFilial(VpaProjeto : TrvProject;VpaDFilial : TRBDFilial);
      procedure ImprimeProdutoVendidosPorClassificacao(VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao : Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho,VpaNomFilial,VpaNomCliente, VpaNomVendedor,VpaNomTipoCotacao : String;VpaAgruparPorEstado : Boolean);
      procedure ImprimeEstoqueProdutos(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados : Boolean);
      procedure ImprimeAnaliseFaturamentoMensal(VpaCodFilial,VpaCodCliente,VpaCodVendedor : Integer;VpaCaminho, VpaNomFilial,VpaNomCliente,VpaNomVendedor : String;VpaDatInicio, VpaDatFim : TDateTime);
      procedure ImprimeQtdMinimasEstoque(VpaCodFilial, VpaCodFornecedor : Integer;VpaCaminho,VpaCodClassificacao,VpaNomFilial, VpaNomClassificacao, VpaNomFornecedor : String);
      procedure ImprimeEstoqueFiscalProdutos(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados : Boolean);
      procedure ImprimeFechamentoMes(VpaCodFilial : Integer;VpaCaminho, VpaNomFilial : String;VpaData : TDateTime;VpaMostarTodos : Boolean);
      procedure ImprimeContasAPagarPorPlanodeContas(VpaCodFilial : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial : String;VpfTipoPeriodo : Integer);
      procedure ImprimeEntradaMetros(VpaDatInicio, VpaDatFim : TDateTime);
      procedure ImprimeExtratoProdutividade(VpaCaminho : String;VpaData : TDateTime);
      procedure ImprimeCustoProjeto(VpaCodProjeto : Integer;VpaCaminho, VpaNomProjeto : String);
  end;
implementation

Uses FunSql, constantes, funObjeto, funString, FunData, UnContasAReceber;

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
  Clientes.close;
  Clientes.free;
  RVSystem.free;
  VprCabecalhoEsquerdo.free;
  VprCabecalhoDireito.free;
  FunClassificacao.free;
  FreeTObjectsList(VprNiveis);
  inherited;
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
     SetTab(1.5,pjLeft,1.6,0.1,Boxlinenone,0); //Codigo Produto
     SetTab(NA,pjLeft,8.4,0.5,Boxlinenone,0); //nomeproduto
     SetTab(NA,pjLeft,2.1,0.2,Boxlinenone,0); //Cor
     SetTab(NA,pjLeft,1.5,0.2,Boxlinenone,0); //Tamanho
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Qtd
     SetTab(NA,pjRight,2.3,0,Boxlinenone,0); //Valor total
     SetTab(NA,pjLeft,0.8,0,Boxlinenone,0); //um
     SaveTabs(2);
   end;
end;

(******************************************************************************)
procedure TRBFunRave.DefineTabelaEstoqueProdutos(VpaObjeto : TObject);
begin
   with RVSystem.BaseReport do begin
     clearTabs;
     SetTab(1.0,pjleft,2.5,0.5,BoxlineNONE,0); //Codigo classificacao
     SetTab(NA,pjleft,10,0.5,BoxlineNONE,0); //NomeClassificacao;
     SaveTabs(1);
     clearTabs;
     SetTab(1.5,pjLeft,1.6,0.1,Boxlinenone,0); //Codigo Produto
     SetTab(NA,pjLeft,8.4,0.5,Boxlinenone,0); //nomeproduto
     SetTab(NA,pjLeft,2.6,0.2,Boxlinenone,0); //Cor
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
procedure TRBFunRave.ImprimeProdutoPorClassificacao(VpaObjeto : TObject);
var
  VpfQtdProduto, VpfTotalProduto, VpfQtdGeral, VpfValGeral : Double;
  VpfProdutoAtual, VpaTamanhoAtual,VpaCorAtual : Integer;
  VpfClassificacaoAtual,  VpfUM : string;
  VpfDClassificacao : TRBDClassificacaoRave;
begin
  VpfProdutoAtual := 0;
  VpfQtdGeral := 0;
  VpfValGeral := 0;
  VpfClassificacaoAtual := '';
  VprUfAtual := '';
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
        begin
          PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdProduto));
          PrintTab(FormatFloat(varia.MascaraValor,VpfTotalProduto));
          PrintTab('  '+VpfUM);
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfQtdProduto;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfTotalProduto;
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
        VpfQtdproduto := 0;
        VpfTotalProduto := 0;
        VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
        VpfUM := Tabela.FieldByname('UMPADRAO').AsString;
        PrintTab(Tabela.FieldByName('C_COD_PRO').AsString);
        PrintTab(Tabela.FieldByName('C_NOM_PRO').AsString);
        PrintTab('');
        PrintTab('');
      end;
      VpfQtdProduto := VpfQtdProduto + FunProdutos.CalculaQdadePadrao( Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,
                                       Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
      VpfTotalProduto := VpfTotalProduto + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      VpfQtdGeral := VpfQTdGeral + FunProdutos.CalculaQdadePadrao( Tabela.FieldByName('C_COD_UNI').AsString,Tabela.FieldByName('UMPADRAO').AsString,
                                       Tabela.FieldByName('N_QTD_PRO').AsFloat,Tabela.FieldByName('I_SEQ_PRO').AsString);
      VpfValGeral := VpfValGeral + Tabela.FieldByName('N_VLR_TOT').AsFloat;
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
    begin
      PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdProduto));
      PrintTab(FormatFloat(varia.MascaraValor,VpfTotalProduto));
      PrintTab('  '+VpfUM);
      newline;
      If LinesLeft<=1 Then
        NewPage;
    end;
    if VpfDClassificacao <> nil then
    begin
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfQtdProduto;
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
    PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdGeral));
    PrintTab(FormatFloat(varia.MascaraValor,VpfValGeral));
    PrintTab('  ');
    bold := false;

  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeRelEstoqueProdutos(VpaObjeto : TObject);
var
  VpfQtdProduto, VpfTotalProduto, VpfQtdGeral, VpfValGeral : Double;
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
  with RVSystem.BaseReport do begin
    while not Tabela.Eof  do
    begin
      if VpfProdutoAtual <> Tabela.FieldByName('I_SEQ_PRO').AsInteger then
      begin
        if VpfProdutoAtual <> 0  then
        begin
          PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdProduto));
          PrintTab(FormatFloat(varia.MascaraValor,VpfTotalProduto));
          PrintTab('  '+VpfUM);
          newline;
          If LinesLeft<=1 Then
            NewPage;
        end;
        if VpfDClassificacao <> nil then
        begin
          VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto +VpfQtdProduto;
          VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfTotalProduto;
        end;

        if VpfClassificacaoAtual <> Tabela.FieldByName('C_COD_CLA').AsString then
        begin
          VpfDClassificacao := CarregaNiveis(VprNiveis,Tabela.FieldByName('C_COD_CLA').AsString);
          ImprimeTituloClassificacao(VprNiveis,VpfClassificacaoAtual = '');
          VpfClassificacaoAtual := Tabela.FieldByName('C_COD_CLA').AsString;
        end;
       VpfQtdproduto := 0;
       VpfTotalProduto := 0;
       VpfProdutoAtual := Tabela.FieldByname('I_SEQ_PRO').AsInteger;
       VpfUM := Tabela.FieldByname('C_COD_UNI').AsString;
       PrintTab(Tabela.FieldByName('C_COD_PRO').AsString);
       PrintTab(Tabela.FieldByName('C_NOM_PRO').AsString);
       if varia.CNPJFilial = CNPJ_AtelierduCristal then
         PrintTab(Tabela.FieldByName('C_BAR_FOR').AsString)
       else
         PrintTab('');
       PrintTab('');
      end;

      CarCorTamanhoProduto(VpfDProduto,vpfDCor,VpfDTamanho,Tabela.FieldByName('I_COD_COR').AsInteger,Tabela.FieldByName('I_COD_TAM').AsInteger);

      VpfQtdProduto := VpfQtdProduto + Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfTotalProduto := VpfTotalProduto + (Tabela.FieldByName('N_QTD_PRO').AsFloat * Tabela.FieldByName('N_VLR_CUS').AsFloat);
      VpfQtdGeral := VpfQTdGeral +Tabela.FieldByName('N_QTD_PRO').AsFloat;
      VpfValGeral := VpfValGeral + (Tabela.FieldByName('N_QTD_PRO').AsFloat * Tabela.FieldByName('N_VLR_CUS').AsFloat);
      Tabela.next;
    end;

    if VpfProdutoAtual <> 0  then
    begin
      PrintTab(FormatFloat(varia.MascaraQtd,VpfQtdProduto));
      PrintTab(FormatFloat(varia.MascaraValor,VpfTotalProduto));
      PrintTab('  '+VpfUM);
      newline;
      If LinesLeft<=1 Then
        NewPage;
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
  VpfQtdProduto, VpfValTotal,VpfQtdAnterior, VpfQtdVenda, VpfValAnterior,VpfValVenda, VpfValCustoVenda : Double;
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
{        Canvas.Pen.Width := 7;
        Canvas.Pen.Color := clBlack;
        MoveTo(MarginLeft,YPos+0.1);
        LineTo(PageWidth-MarginRight,YPos+0.1);}
      end;
      VpfDClassificacao.QtdProduto := VpfDClassificacao.QtdProduto + VpfQtdProduto;
      VpfDClassificacao.ValTotal := VpfDClassificacao.ValTotal + VpfValTotal;
      VpfDClassificacao.QtdMesAnterior := VpfDClassificacao.QtdMesAnterior + VpfQtdAnterior;
      VpfDClassificacao.ValAnterior := VpfDClassificacao.ValAnterior + VpfValAnterior;
      VpfDClassificacao.QtdVenda := VpfDClassificacao.QtdVenda + VpfQtdVenda;
      VpfDClassificacao.ValVenda := VpfDClassificacao.ValVenda + VpfValVenda;
      VpfDClassificacao.ValCustoVenda := VpfDClassificacao.ValCustoVenda + VpfValVenda;
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
      begin
        PrintTab('');
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
        PrintTab('  ');
      end;
      VpfQtdProduto := VpfDClassificacao.QtdProduto;
      VpfValTotal := VpfDClassificacao.ValTotal;
      VpfQtdAnterior := VpfDClassificacao.QtdMesAnterior;
      VpfValAnterior := VpfDClassificacao.ValAnterior;
      VpfQtdVenda := VpfDClassificacao.QtdVenda;
      VpfValVenda := VpfDClassificacao.ValVenda;
      VpfValCustoVenda := VpfDClassificacao.ValCustoVenda;

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
    with RVSystem.BaseReport do
    begin
      if VpfLaco = 0 then
      begin
        SetBrush(ShadeToColor(clBlack,20),bsSolid,nil);
        FillRect(CreateRect(MarginLeft-0.1,YPos+LineHeight-1+0.3,PageWidth-0.3,YPos+0.1));
{        Canvas.Pen.Width := 7;
        Canvas.Pen.Color := clBlack;
        MoveTo(MarginLeft,YPos+0.1);
        LineTo(PageWidth-MarginRight,YPos+0.1);}
      end;
      VpfDPlanoContas.ValPago := VpfDPlanoContas.ValPago + VpfValPago;
      VpfDPlanoContas.ValDuplicata := VpfDPlanoContas.ValDuplicata + VpfValDuplicata;
      VpfDPlanoContas.ValPrevisto := VpfDPlanoContas.ValPrevisto + VpfValPrevisto;
      bold := true;
      Italic := true;
      if VpfLaco > 0 then
        PrintTab('Total Plano Contas : '+VpfDPlanoContas.CodPlanoCotas+'-'+VpfDPlanoContas.NomPlanoContas)
      else
        PrintTab('');
      PrintTab('');
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDPlanoContas.ValDuplicata));
      PrintTab('');
      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDPlanoContas.ValPago));
//      PrintTab(FormatFloat('#,###,###,###,##0.00',VpfDPlanoContas.ValPrevisto));
      VpfValPago := VpfDPlanoContas.ValPago;
      VpfValDuplicata := VpfDPlanoContas.ValDuplicata;
      VpfValPrevisto := VpfDPlanoContas.ValPrevisto;
      newline;
      If LinesLeft<=1 Then
        NewPage;
      Bold := false;
      Italic := false;
    end;
    VpfDPlanoContas.free;
    VpaNiveis.delete(VpfLaco);
  end;
  if VpaIndice > 0  then
  begin
    VpfDPlanoContas := TRBDPlanoContasRave(VpaNiveis.items[VpaIndice-1]);
    VpfDPlanoContas.ValPago := VpfDPlanoContas.ValPago + VpfValPago;
    VpfDPlanoContas.ValDuplicata := VpfDPlanoContas.ValDuplicata + VpfValDuplicata;
    VpfDPlanoContas.ValPrevisto := VpfDPlanoContas.ValPrevisto + VpfValPrevisto;
  end;
  with RVSystem.BaseReport do
  begin
      newline;
      if LinesLeft<=1 Then
        NewPage;
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
        PrintTab('Cor')
      else
        PrintTab('');
      if config.EstoquePorTamanho then
        PrintTab('Tamanho')
      else
        printTab('');
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
       1,2 : ImprimeCabecalhoEstoque;
       4 : ImprimeCabecalhoQtdMinima;
       6 : ImprimeCabecalhoFechamentoEstoque;
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
procedure TRBFunRave.CarCorTamanhoProduto(VpaDProduto: TRBDProdutoRave; VpaDCor: TRBDCorProdutoRave; VpaDTamanho: TRBDTamanhoProdutoRave; VpaCodCor, VpaCodTamanho: Integer);
var
  VpfLacoCor, VpfLacoTamanho : Integer;
begin
  VpaDCor := nil;
  VpaDTamanho := nil;
  if VpaDCor.CodCor <> VpaCodCor then
  begin
    for VpfLacoCor := 0 to VpaDProduto.Cores.Count - 1 do
    begin
      if (TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]).CodCor = VpaCodCor) then
      begin
        VpaDCor := TRBDCorProdutoRave(VpaDProduto.Cores.Items[VpfLacoCor]);
        break;
      end;
    end;
  end;
  for VpfLacoTamanho := 0 to VpaDCor.Tamanhos.Count - 1 do
  begin
    if TRBDTamanhoProdutoRave(VpaDCor.Tamanhos.Items[VpfLacoTamanho]).CodTamanho = VpaCodTamanho then
    begin
      VpaDTamanho := TRBDTamanhoProdutoRave(VpaDCor.Tamanhos.Items[VpfLacoTamanho]);
      break;
    end;
  end;

  if VpaDCor = nil then
  begin
    VpaDCor := VpaDProduto.AddCor;
    VpaDCor.CodCor := VpaCodCor;
    if VpaDCor.CodCor = 0 then
      VpaDCor.NomCor := 'SEM COR'
    else
      VpaDCor.NomCor := FunProdutos.RNomeCor(IntTosTr(VpaDCor.CodCor));
    VpaDcor.QtdEstoque := 0;
  end;
  if VpaDTamanho = nil then
  begin
    VpaDTamanho := VpaDCor.addTamanho;
    VpaDTamanho.CodTamanho := VpaCodTamanho;
    if VpaDTamanho.CodTamanho = 0 then
      VpaDTamanho.NomTamanho := 'SEM TAMANHO'
    else
      VpaDTamanho.NomTamanho := FunProdutos.RNomeTamanho(VpaCodTamanho);
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
function TRBFunRave.CarregaNiveisPlanoContas(VpaNiveis: TList;VpaCodPlanoContas: string): TRBDPlanoContasRave;
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
    if VpfValGeralCustoVenda <> 0  then
      PrintTab(FormatFloat('#,##0.00%',(100 - ((VpfValGeralCustoVenda*100)/VpfValGeralVenda))))
    else
      PrintTab(FormatFloat('0.00%',0));
    bold := false;
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

        VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Tabela.FieldByName('C_CLA_PLA').AsString);
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

        VpfDClassificacao := CarregaNiveisPlanoContas(VprNiveis,Tabela.FieldByName('C_CLA_PLA').AsString);
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
       1,2,4,6 : ImprimeTituloClassificacao(VprNiveis,true);
       3 : ImprimeCabecalhoAnaliseFaturamento;
       8 : ImprimeCabecalhoEntradaMetros;
       9 : ImprimeCabecalhoExtratoProdutividade;
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
procedure TRBFunRave.ImprimeProdutoVendidosPorClassificacao(VpaCodFilial,VpaCodCliente, VpaCodVendedor, VpaCodTipoCotacao: Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial,VpaNomCliente, VpaNomVendedor,VpaNomTipoCotacao : String;VpaAgruparPorEstado : Boolean);
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
  if VpaCodTipoCotacao <> 0  then
    AdicionaSqlTabela(Tabela,' and CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));

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

  VprCabecalhoDireito.Clear;
  VprCabecalhoDireito.add('Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até ' +FormatDatetime('DD/MM/YYYY',VpaDatFim)+'     ');
  if VpaCodVendedor <> 0  then
    VprCabecalhoDireito.add('Vendedor : ' +VpaNomVendedor);

  RvSystem.execute;
end;

{******************************************************************************}
procedure TRBFunRave.ImprimeEstoqueProdutos(VpaCodFilial : Integer;VpaCaminho,VpaCodClassificacao,VpaTipoRelatorio,VpaNomFilial, VpaNomClassificacao : String;VpaIndProdutosMonitorados : Boolean);
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
{  if DeletaChars(VpaomTipoCotacao,' ') <> '' then
    VprCabecalhoEsquerdo.add('Tipo Cotação : ' +VpaNomTipoCotacao);}

  VprCabecalhoDireito.Clear;
  if VpaCodClassificacao <> ''  then
    VprCabecalhoDireito.add('Classificacao : ' +VpaNomClassificacao);

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
                             ' and '+SQLTextoMes('TRA.DATPRODUTIVIDADE')+' = '+IntTostr(Mes(VpaData)));

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

  RvSystem.execute;
end;


end.
