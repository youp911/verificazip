unit UnDadosCR;

interface
Uses Classes;

Type
  TRBDCondicaoPagamentoGrupoUsuario = class
    public
      CodCondicao : Integer;
      NomCondicao : String;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBTipoParcela = (tpProximoMes,tpQtdDias,tpDiaFixo,tpDataFixa);
  TRBDParcelaCondicaoPagamento = class
    public
      NumParcela,
      QtdDias,
      DiaFixo : Integer;
      PerParcela,
      PerAcrescimoDesconto : Double;
      TipAcrescimoDesconto: String;
      DatFixa : TDatetime;
      TipoParcela : TRBTipoParcela;
      constructor cria;
      destructor destroy;override;
  end;

Type
  TRBDCondicaoPagamento = class
    public
      CodCondicaoPagamento,
      QtdParcelas : Integer;
      NomCondicaoPagamento : String;
      Parcelas : TList;
      constructor cria;
      destructor destroy;override;
      function AddParcela : TRBDParcelaCondicaoPagamento;
end;

Type
  TRBDDERVendedor = class
    public
      CodVendedor : Integer;
      NomVendedor : String;
      ValMeta,
      ValRealizado : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDDERCorpo = class
    public
      Mes,
      Ano : Integer;
      IndMensal : Boolean;
      Vendedores : TList;
      constructor Cria;
      destructor destroy;override;
      function addVendedor : TRBDDERVendedor;
end;

Type TRBDCheque = class
  public
    SeqCheque,
    CodBanco,
    CodFormaPagamento,
    NumCheque,
    CodUsuario : Integer;
    NumContaCaixa,
    NomContaCaixa,
    NomEmitente,
    NomFormaPagamento,
    TipFormaPagamento,
    TipCheque,
    TipContaCaixa : String;
    ValCheque : Double;
    DatCadastro,
    DatVencimento,
    DatCompensacao,
    DatDevolucao : TDatetime;
    constructor cria;
    destructor destroy;override;
end;


type
  TRBDParcelaBaixaCR = class
    public
      CodFilial,
      LanReceber,
      NumParcela,
      NumParcelaParcial,
      CodCliente,
      CodFormaPagamento,
      NumNotaFiscal,
      NumDiasAtraso,
      NumDiasCarencia,
      QtdParcelas : Integer;
      NumContaCorrente,
      NomCliente,
      NomFormaPagamento,
      NumDuplicata,
      DesObservacoes: String;
      DatEmissao,
      DatVencimento,
      DatPagamento : TDateTime;
      ValParcela,
      ValPago,
      ValAcrescimo,
      ValDesconto,
      ValDescontoAteVencimento,
      ValTarifaDesconto,
      PerMora,
      PerJuros,
      PerMulta: Double;
      IndValorQuitaEssaParcela,
      IndGeraParcial,
      IndContaOculta,
      IndDescontado : Boolean;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDFluxoCaixaDia = Class
    public
      Dia : Integer;
      ValCRPrevisto,
      ValCRDuvidoso,
      ValCobrancaPrevista,
      ValDescontoDuplicata,
      ValChequesCR,
      ValCP,
      ValChequesCP,
      ValTotalReceita,
      ValTotalReceitaAcumulada,
      ValTotalDespesa,
      ValTotalDespesaAcumulada,
      Valtotal,
      ValTotalAcumulado :Double;
      Parcelas,
      ChequesCR,
      ChequesCP  : TList;
      constructor cria;
      destructor destroy;override;
      function addParcela : TRBDParcelaBaixaCR;
      function AddChequeCR(VpaDatVencimento : TDateTime) : TRBDCheque;
      function AddChequeCP(VpaDatVencimento : TDateTime) : TRBDCheque;
end;

Type
  TRBDFluxoCaixaMes = Class
    public
      Mes,
      Ano : Integer;
      ValCRPrevisto,
      ValCRDuvidoso,
      ValCobrancaPrevista,
      ValDescontoDuplicata,
      ValChequesCR,
      ValCP,
      ValChequesCP,
      ValTotalReceita,
      ValTotalReceitaAcumulada,
      ValTotalDespesa,
      ValTotalDespesaAcumulada,
      Valtotal,
      ValTotalAcumulado :Double;
      Dias : TList;
      constructor cria;
      destructor destroy;override;
      function addDia(VpaDia : Integer) : TRBDFluxoCaixaDia;
end;

Type
  TRBDFluxoCaixaConta = Class
    public
      NumContaCaixa,
      NomContaCaixa : String;
      LinContasReceberPrevisto,
      LinChequesaCompensarCR,
      LinReceitasAcumuladas : Integer;
      ValSaldoAtual,
      ValSaldoAnterior,
      ValAplicado,
      ValLimiteCredito : Double;
      ParcelasSaldoAnterior,
      Meses : TList;
      constructor cria;
      destructor destroy;override;
      function RDia(VpaDatVencimento : TDatetime):TRBDFluxoCaixaDia;
      function addMes(VpaMes,VpaAno : Integer) : TRBDFluxoCaixaMes;
      function addParcelaSaldoAnterior : TRBDParcelaBaixaCR;
      function addParcela(VpaData : TDateTime) : TRBDParcelaBaixaCR;
      function addChequeCR(VpaDatVencimento : TDateTime) : TRBDCheque;
      function addChequeCP(VpaDatVencimento : TDateTime) : TRBDCheque;
end;

Type
  TRBDFluxoCaixaCorpo = Class
    public
      Mes,
      Ano,
      QtdColunas,
      LinTotalAcumulado : Integer;
      IndDiario : Boolean;
      IndSeparaCRDuvidoso,
      IndMostrarCobrancaPrevista,
      IndSomenteClientesQuePagamEmDia : Boolean;
      ValSaldoAnterior,
      ValSaldoAtual,
      ValAplicacao,
      ValTotalAcumulado : Double;
      DatInicio,
      DatFim : TDateTime;
      ContasCaixa : TList;
      constructor cria;
      destructor destroy;override;
      function addContaCaixa : TRBDFluxoCaixaConta;
      procedure OrdenaDias;
      procedure CalculaValoresTotais;
end;


Type
  TRBDCaixaFormaPagamento = class
    public
      CodFormaPagamento : Integer;
      NomFormaPagamento : String;
      ValInicial,
      ValAtual,
      ValFinal : Double;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDCaixaItem = class
    public
      seqItem,
      CodUsuario,
      CodFilial,
      LanReceber,
      LanPagar,
      NumParcelaReceber,
      NumParcelaPagar,
      SeqCheque,
      CodFormaPagamento : Integer;
      DesLancamento,
      DesDebitoCredito : String;
      ValLancamento : Double;
      DatPagamento,
      DatLancamento : TDatetime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDCaixa = class
    public
      SeqCaixa,
      CodUsuarioAbertura,
      CodUsuarioFechamento : Integer;
      NumConta : String;
      ValInicial,
      ValAtual,
      ValFinal : double;
      DatAbertura,
      DatFechamento : TDateTime;
      FormasPagamento,
      Items : TList;
      constructor cria;
      destructor destroy;override;
      function AddCaixaItem : TRBDCaixaItem;
      function AddFormaPagamento : TRBDCaixaFormaPagamento;
end;


type
  TRBDParcelaCP = class
    public
      CodFilial,
      LanPagar,
      NumParcela,
      NumParcelaParcial,
      CodCliente,
      CodFormaPagamento,
      NumNotaFiscal,
      NumDiasAtraso,
      QtdParcelas : Integer;
      NumContaCorrente,
      NomCliente,
      NomFormaPagamento,
      NumDuplicata,
      DesObservacoes,
      CodBarras : String;
      DatEmissao,
      DatVencimento,
      DatPagamento : TDateTime;
      ValParcela,
      ValPago,
      ValAcrescimo,
      ValDesconto,
      PerMora,
      PerJuros,
      PerMulta: Double;
      IndValorQuitaEssaParcela,
      IndGeraParcial,
      IndContaOculta : Boolean;
      constructor Cria;
      destructor Destroy; override;
end;

Type
  TRBDContasaPagarProjeto = class
    public
      CodProjeto : Integer;
      NomProjeto : String;
      PerDespesa,
      ValDespesa : Double;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDContasaPagar = Class
    public
      CodFilial,
      LanPagar,
      NumNota,
      SeqNota,
      CodFornecedor,
      CodCentroCusto,
      CodFormaPagamento,
      CodBancoBoleto,
      CodMoeda,
      CodProjeto,
      CodUsuario,
      QtdParcela,
      FatorVencimento  : integer;
      DatEmissao : TDateTime;
      NomFornecedor,
      NumContaCaixa,
      CodPlanoConta,
      DesIdentificacaoBancarioFornecedor,
      CodBarras,
      DesPathFoto : string;
      ValParcela,
      ValTotal,
      ValBoleto     : double;
      QtdDiasPriVen,
      QtdDiasDemaisVen  : integer;
      PerDescontoAcrescimo : double;
      IndBaixarConta,
      IndMostrarParcelas,
      IndEsconderConta : Boolean;
      DesTipFormaPagamento : String;
      DesObservacao : String;
      Parcelas,
      DespesaProjeto : TList;
      constructor cria;
      destructor Destroy;override;
      function addParcela : TRBDParcelaCP;
      function addDespesaProjeto : TRBDContasaPagarProjeto;
  end;


Type
  TRBDComissaoItem = class
    public
      NumParcela : Integer;
      ValComissaoParcela : Double;
      DatVencimento,
      DatPagamento,
      DatLiberacao : TDateTime;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDComissao = class
    public
      CodFilial,
      SeqComissao,
      LanReceber,
      CodVendedor,
      TipComissao : Integer;
      DesObservacao : string;
      PerComissao,
      ValTotalComissao : Double;
      DatEmissao : TDateTime;
      Parcelas : TList;
      constructor cria;
      destructor destroy;override;
      function AddParcela : TRBDComissaoItem;
end;


Type
  TRBDECobrancaItem = class
    public
      CodFilial,
      LanReceber,
      NumParcela : Integer;
      UsuarioEmail,
      DesEmail,
      DesEstatus,
      NomCliente,
      NomFantasiaFilial : String;
      DatEnvio : TDatetime;
      IndEnviado : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDECobrancaCorpo = class
    public
      SeqEmail,
      SeqItemEmailDisponivel : Integer;
      DatEnvio : TDateTime;
      QtdEnvidados,
      QtdNaoEnviados,
      CodUsuario : Integer;
      Items : TList;
      constructor cria;
      destructor destroy; override;
      function AddECobrancaItem : TRBDECobrancaItem;
end;

Type
  TRBDFormaPagamento = class
    public
      CodForma : Integer;
      NomForma : String;
      FlaTipo : char;
      IndBaixarConta : Boolean;
      constructor cria;
      destructor destroy;override;
end;

type
  TRBDMovContasCR = class
    public
      NumParcela,
      CodFormaPagamento,
      CodBanco,
      NumDiasAtraso,
      DiasCarencia : integer;
      Valor,
      ValorBruto,
      ValAcrescimo,
      ValDesconto,
      ValTarifasBancarias,
      PerJuros,
      PerMora,
      PerMulta,
      PerDescontoVencimento,
      PerDesconto,
      ValCheque,
      ValAcrescimoFrm : Double;
      DatVencimento,
      DatProrrogacao,
      DatPagamento: TDateTime;
      NroAgencia,
      NumContaCaixa,
      NroContaBoleto,
      NroDuplicata,
      NroDocumento,
      NossoNumero,
      DesObservacoes : String;
      IndBaixarConta : Boolean;
      constructor cria;
      destructor destroy;override;
end;

Type
  TRBDContasCR = class
    public
      CodEmpFil,
      LanReceber,
      NroNota,
      SeqNota,
      LanOrcamento,
      SeqParcialCotacao,
      CodCondicaoPgto,
      CodCliente,
      CodFrmPagto,
      CodMoeda,
      CodUsuario : Integer;
      DatMov,
      DatEmissao : TDateTime;
      NomCliente,
      PlanoConta,
      NumContaCaixa,
      NumContaCorrente,
      DesObservacao: string;
      MostrarParcelas,
      EsconderConta,
      IndDevolucao,
      IndGerarComissao,
      IndCobrarFormaPagamento : Boolean;
      CodVendedor,
      CodPreposto : Integer;
      ValTotal,
      ValTotalAcrescimoFormaPagamento,
      PercentualDesAcr,
      PerComissao,
      PerComissaoPreposto,
      ValComissao,
      ValComissaoPreposto : Double;
      TipComissao,
      TipComissaoPreposto : Integer; // 0 direta 1 produtos
      DPNumDuplicata : Integer;
      Parcelas : TList;
      constructor cria;
      destructor destroy;override;
      function AddParcela : TRBDMovContasCR;
end;

type
  TDadosNovaContaCR = Class
    CodEmpFil,
    NroNota,
    SeqNota,
    CodCondicaoPgto,
    CodCliente,
    CodFrmPagto,
    CodMoeda,
    CodUsuario: Integer;
    DataMov,
    DataEmissao : TDateTime;
    PlanoConta: string;
    ValorTotal : Double;
    PercentualDescAcr : double;
    VerificarCaixa,
    BaixarConta,
    MostrarParcelas,
    MostrarTelaCaixa,
    GerarComissao,
    EsconderConta : Boolean;
    TipoFrmPAgto : String;
    ValorPro, PercPro : TstringList;
    CodVendedor : Integer;
    PercComissaoPro,
    PercComissaoServ,
    ValorComPro,
    ValorComServ : Double;
    TipoComissao  : Integer; // 0 direta 1 produtos
end;

type
  TDadosNovaParcelaCR = Class
    EmpresaFilial      : integer;
    LancamentoCR       : integer;
    ValorTotal         : double;
    CodigoFrmPagto     : Integer;
    CodigoConPagamento : integer;
    CodMoeda           : Integer;
    NumeroDup          : string;
    PercentualDesAcr   : Double;
    DataEmissao        : TDateTime;
    ParcelaPerson      : Boolean;
    DataVenPerson,
    ValorVenPrson      : TStringList;
    SeqTef             : Integer;
end;


type
  TRBDBaixaCP = class
    public
      CodFormaPagamento: Integer;
      TipFormaPagamento,
      NumContaCaixa : String;
      ValorAcrescimo,
      ValorDesconto,
      ValorPago,
      ValParcialFaltante : Double;
      DatPagamento,
      DatVencimentoParcial : TDateTime;
      IndPagamentoParcial : Boolean;
      Parcelas,
      Cheques,
      Caixas : TList;
      constructor Cria;
      destructor Destroy; override;
      function AddParcela: TRBDParcelaCP;
      function AddCheque : TRBDCheque;
      function AddCaixa : TRBDCaixa;
end;


type
  TRBDBaixaCR = class
    public
      CodFormaPagamento: Integer;
      TipFormaPagamento,
      NumContaCaixa: String;
      ValorAcrescimo,
      ValorDesconto,
      ValorPago,
      ValParcialFaltante : Double;
      DatPagamento,
      DatVencimentoParcial : TDateTime;
      IndPagamentoParcial,
      IndBaixaRetornoBancario,
      IndDesconto,
      IndBaixaUtilizandoOCreditodoCliente : Boolean;
      Parcelas,
      Cheques,
      Caixas : TList;
      constructor Cria;
      destructor Destroy; override;
      function AddParcela: TRBDParcelaBaixaCR;
      function AddCheque : TRBDCheque;
      function AddCaixa : TRBDCaixa;
end;


implementation

Uses FunObjeto, FunData;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDFluxoCaixaConta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFluxoCaixaMes.cria;
begin
  inherited create;
  Dias := TList.create;
end;

{******************************************************************************}
destructor TRBDFluxoCaixaMes.destroy;
begin
  FreeTObjectsList(Dias);
  Dias.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDFluxoCaixaMes.addDia(VpaDia : Integer) : TRBDFluxoCaixaDia;
begin
  Result := TRBDFluxoCaixaDia.cria;
  result.Dia := VpaDia;
  Dias.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDFluxoCaixaConta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFluxoCaixaConta.cria;
begin
  inherited create;
  Meses := TList.create;
  ParcelasSaldoAnterior := TList.Create;
end;

{******************************************************************************}
destructor TRBDFluxoCaixaConta.destroy;
begin
  FreeTObjectsList(Meses);
  Meses.free;
  FreeTObjectsList(ParcelasSaldoAnterior);
  ParcelasSaldoAnterior.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.RDia(VpaDatVencimento : TDatetime):TRBDFluxoCaixaDia;
var
  VpfLacoMes, VpfLacoDia : Integer;
  VpfDFluxoMes : TRBDFluxoCaixaMes;
begin
  result := nil;
  VpfDFluxoMes := nil;
  for VpfLacoMes := 0 to Meses.Count - 1 do
  begin
    if (mes(VpaDatVencimento) = TRBDFluxoCaixaMes(Meses.Items[VpfLacoMes]).Mes) and
       (ano(VpaDatVencimento) = TRBDFluxoCaixaMes(Meses.Items[VpfLacoMes]).Ano) then
    begin
      VpfDFluxoMes := TRBDFluxoCaixaMes(Meses.Items[VpfLacoMes]);
      for VpfLacoDia := 0 to VpfDFluxoMes.Dias.Count - 1 do
      begin
        if (dia(VpaDatVencimento) = TRBDFluxoCaixaDia(VpfDFluxoMes.Dias.Items[VpfLacoDia]).Dia) then
          result := TRBDFluxoCaixaDia(VpfDFluxoMes.Dias.Items[VpfLacoDia]);
      end;
    end;
  end;
  if result = nil then
  begin
    if VpfDFluxoMes = nil then
      VpfDFluxoMes := addMes(Mes(VpaDatVencimento),Ano(VpaDatVencimento));
    result := VpfDFluxoMes.addDia(Dia(VpaDatVencimento));
  end;
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addMes(VpaMes,VpaAno : Integer) : TRBDFluxoCaixaMes;
begin
  Result := TRBDFluxoCaixaMes.cria;
  result.Mes := VpaMes;
  Result.Ano := VpaAno;
  Meses.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addParcelaSaldoAnterior : TRBDParcelaBaixaCR;
begin
  result := TRBDParcelaBaixaCR.Cria;
  ParcelasSaldoAnterior.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addParcela(VpaData : TDateTime) : TRBDParcelaBaixaCR;
var
  VpfDiaLacoMes, VpfLacoDia : Integer;
  VpfDFluxoMes : TRBDFluxoCaixaMes;
begin
  result := RDia(VpaData).addParcela;
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addChequeCR(VpaDatVencimento : TDateTime) : TRBDCheque;
begin
  result :=  RDia(VpaDatVencimento).AddChequeCR(VpaDatVencimento);
end;

{******************************************************************************}
function TRBDFluxoCaixaConta.addChequeCP(VpaDatVencimento : TDateTime) : TRBDCheque;
begin
  result :=  RDia(VpaDatVencimento).AddChequeCP(VpaDatVencimento);
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDFluxoCaixaCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFluxoCaixaCorpo.cria;
begin
  inherited create;
  ContasCaixa := TList.Create;
end;

{******************************************************************************}
destructor TRBDFluxoCaixaCorpo.destroy;
begin
  FreeTObjectsList(ContasCaixa);
  ContasCaixa.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDFluxoCaixaCorpo.addContaCaixa : TRBDFluxoCaixaConta;
begin
  result := TRBDFluxoCaixaConta.cria;
  ContasCaixa.add(result);
end;

{******************************************************************************}
procedure TRBDFluxoCaixaCorpo.OrdenaDias;
var
  VpfLacoContas, VpfLacoMes, VpfLacoDiaInterno, VpfLacoDiaExterno : Integer;
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDMes : TRBDFluxoCaixaMes;
  VpfDDia : TRBDFluxoCaixaDia;
begin
  for VpfLacoContas := 0 to ContasCaixa.Count - 1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(ContasCaixa.Items[VpfLacoContas]);
    for VpfLacoMes := 0 to VpfDConta.Meses.Count - 1 do
    begin
      VpfDMes := TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]);
      for VpfLacoDiaExterno := 0 to VpfDMes.Dias.Count - 2 do
      begin
        VpfDDia := TRBDFluxoCaixaDia(VpfDMes.Dias.Items[VpfLacoDiaExterno]);
        for VpfLacoDiaInterno := VpfLacoDiaExterno + 1 to VpfDMes.Dias.Count - 1 do
        begin
          if TRBDFluxoCaixaDia(VpfDMes.Dias.Items[VpfLacoDiaInterno]).Dia < VpfDDia.Dia then
          begin
            VpfDMes.Dias.Items[VpfLacoDiaExterno] := VpfDMes.Dias.Items[VpfLacoDiaInterno];
            VpfDMes.Dias.Items[VpfLacoDiaInterno] := VpfDDia;
            VpfDDia := TRBDFluxoCaixaDia(VpfDMes.Dias.Items[VpfLacoDiaExterno]);
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBDFluxoCaixaCorpo.CalculaValoresTotais;
var
  VpfLacoContas, VpfLacoMes, VpfLacoDia, VpfLacoParcela : Integer;
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDMes : TRBDFluxoCaixaMes;
  VpfDDia : TRBDFluxoCaixaDia;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  OrdenaDias;
  ValTotalAcumulado := 0;
  for VpfLacoContas := 0 to ContasCaixa.Count - 1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(ContasCaixa.Items[VpfLacoContas]);
    for VpfLacoMes := 0 to VpfDConta.Meses.Count - 1 do
    begin
      VpfDMes := TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]);
      VpfDMes.ValCRPrevisto := 0;
      VpfDMes.ValCRDuvidoso := 0;
      VpfDMes.ValCobrancaPrevista := 0;
      VpfDMes.ValDescontoDuplicata := 0;
      VpfDMes.ValTotalReceita := 0;
      VpfDMes.ValTotalReceitaAcumulada := VpfDConta.ValAplicado +VpfDConta.ValSaldoAnterior + VpfDConta.ValSaldoAtual ;
      for VpfLacoDia := 0 to VpfDMes.Dias.Count - 1 do
      begin
        VpfDDia := TRBDFluxoCaixaDia(VpfDMes.Dias.Items[VpfLacoDia]);
        VpfDDia.ValCRPrevisto := 0;
        VpfDDia.ValCRDuvidoso := 0;
        VpfDDia.ValCobrancaPrevista := 0;
        VpfDDia.ValDescontoDuplicata := 0;
        VpfDDia.ValTotalReceitaAcumulada := VpfDMes.ValTotalReceitaAcumulada;

        for VpfLacoParcela := 0 to VpfDDia.Parcelas.Count - 1 do
        begin
          VpfDParcela := TRBDParcelaBaixaCR(VpfDDia.Parcelas.Items[VpfLacoParcela]);
          VpfDDia.ValCRPrevisto := VpfDDia.ValCRPrevisto + VpfDParcela.ValParcela;
          VpfDMes.ValCRPrevisto := VpfDMes.ValCRPrevisto + VpfDParcela.ValParcela;
          if VpfDParcela.IndDescontado then
          begin
            VpfDDia.ValDescontoDuplicata := VpfDDia.ValDescontoDuplicata + VpfDParcela.ValParcela;
            VpfDMes.ValDescontoDuplicata := VpfDMes.ValDescontoDuplicata + VpfDParcela.ValParcela;
          end
          else
          begin
            VpfDDia.ValTotalReceita := VpfDDia.ValTotalReceita + VpfDParcela.ValParcela;
            VpfDMes.ValTotalReceita := VpfDMes.ValTotalReceita + VpfDParcela.ValParcela;
          end;
          VpfDMes.ValTotalReceitaAcumulada := VpfDMes.ValTotalReceitaAcumulada +VpfDParcela.ValParcela ;
          VpfDDia.ValTotalReceitaAcumulada := VpfDDia.ValTotalReceitaAcumulada + VpfDParcela.ValParcela;
        end;
      end;
      ValTotalAcumulado := ValTotalAcumulado + VpfDMes.ValTotalReceitaAcumulada;
    end;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDFluxoCaixaItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFluxoCaixaDia.cria;
begin
  inherited create;
  Parcelas := TList.create;
  ChequesCR := TList.create;
  ChequesCP := TList.create;
end;

{******************************************************************************}
destructor TRBDFluxoCaixaDia.destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.free;
  FreeTObjectsList(ChequesCR);
  ChequesCR.free;
  FreeTObjectsList(ChequesCP);
  ChequesCP.free;
  inherited destroy;
end;


{******************************************************************************}
function TRBDFluxoCaixaDia.addParcela : TRBDParcelaBaixaCR;
begin
  result := TRBDParcelaBaixaCR.cria;
  Parcelas.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaDia.AddChequeCR(VpaDatVencimento : TDateTime) : TRBDCheque;
var
  VpfLaco : Integer;
  VpfInseriu : Boolean;
begin
  VpfInseriu := false;

  result := TRBDCheque.cria;
  result.DatVencimento := VpaDatVencimento;

  for VpfLaco := 0 to ChequesCR.Count - 1 do
  begin
    if VpaDatVencimento < TRBDCheque(ChequesCR).DatVencimento then
    begin
      ChequesCR.Insert(VpfLaco,Result);
      VpfInseriu := true;
    end;
  end;
  if not VpfInseriu then
    ChequesCR.add(result);
end;

{******************************************************************************}
function TRBDFluxoCaixaDia.AddChequeCP(VpaDatVencimento : TDateTime) : TRBDCheque;
var
  VpfLaco : Integer;
  VpfInseriu : Boolean;
begin
  VpfInseriu := false;

  result := TRBDCheque.cria;
  result.DatVencimento := VpaDatVencimento;

  for VpfLaco := 0 to ChequesCP.Count - 1 do
  begin
    if VpaDatVencimento < TRBDCheque(ChequesCP).DatVencimento then
    begin
      ChequesCP.Insert(VpfLaco,Result);
      VpfInseriu := true;
    end;
  end;
  if not VpfInseriu then
    ChequesCP.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDParcelaBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCaixaFormaPagamento.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCaixaFormaPagamento.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDParcelaBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

constructor TRBDCaixaItem.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCaixaItem.Destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDParcelaBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCaixa.cria;
begin
  inherited create;
  Items := TList.create;
  FormasPagamento := TList.Create;
end;

{******************************************************************************}
destructor TRBDCaixa.destroy;
begin
  FreeTObjectsList(Items);
  FreeTObjectsList(FormasPagamento);
  Items.free;
  FormasPagamento.Free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDCaixa.AddCaixaItem : TRBDCaixaItem;
begin
  result := TRBDCaixaItem.cria;
  Items.add(result);
end;

{******************************************************************************}
function TRBDCaixa.AddFormaPagamento : TRBDCaixaFormaPagamento;
begin
  result := TRBDCaixaFormaPagamento.cria;
  FormasPagamento.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 TRBDDERCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDDERVendedor.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDDERVendedor.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 TRBDDERCorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDDERCorpo.Cria;
begin
  inherited create;
  Vendedores := TList.Create;
end;

{******************************************************************************}
destructor TRBDDERCorpo.destroy;
begin
  FreeTObjectsList(Vendedores);
  Vendedores.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDDERCorpo.addVendedor : TRBDDERVendedor;
begin
  result := TRBDDERVendedor.cria;
  Vendedores.add(result);
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBDParcelaBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDParcelaBaixaCR.Cria;
begin
  inherited Create;
  ValAcrescimo:= 0;
  ValDesconto:= 0;
  IndValorQuitaEssaParcela := true;
  IndGeraParcial := false;
end;

{******************************************************************************}
destructor TRBDParcelaBaixaCR.Destroy;
begin
  inherited Destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                    TRBDBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDBaixaCP.Cria;
begin
  inherited Create;
  Parcelas:= TList.Create;
  Cheques := TList.Create;
  Caixas := TList.Create;
end;

{******************************************************************************}
destructor TRBDBaixaCP.Destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.Free;
  FreeTObjectsList(Cheques);
  Cheques.free;
  FreeTObjectsList(Caixas);
  Caixas.free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDBaixaCP.AddParcela: TRBDParcelaCP;
begin
  Result:=  TRBDParcelaCP.Cria;
  Parcelas.Add(Result);
end;

{******************************************************************************}
function TRBDBaixaCP.AddCheque : TRBDCheque;
begin
  result := TRBDCheque.cria;
  Cheques.add(result);
end;

{******************************************************************************}
function TRBDBaixaCP.AddCaixa : TRBDCaixa;
begin
  result := TRBDCaixa.cria;
  Caixas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                    TRBDBaixaCR
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDBaixaCR.Cria;
begin
  inherited Create;
  Parcelas:= TList.Create;
  Cheques := TList.Create;
  Caixas := TList.Create;
  IndBaixaRetornoBancario := false;
  IndDesconto := false;
  IndBaixaUtilizandoOCreditodoCliente := false;
end;

{******************************************************************************}
destructor TRBDBaixaCR.Destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.Free;
  FreeTObjectsList(Cheques);
  Cheques.free;
  FreeTObjectsList(Caixas);
  Caixas.free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBDBaixaCR.AddParcela: TRBDParcelaBaixaCR;
begin
  Result:=  TRBDParcelaBaixaCR.Cria;
  Parcelas.Add(Result);
end;

{******************************************************************************}
function TRBDBaixaCR.AddCheque : TRBDCheque;
begin
  result := TRBDCheque.cria;
  Cheques.add(result);
end;

{******************************************************************************}
function TRBDBaixaCR.AddCaixa : TRBDCaixa;
begin
  result := TRBDCaixa.cria;
  Caixas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Parcela Baixa CP
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{******************************************************************************}
constructor TRBDParcelaCP.Cria;
begin
  inherited Create;
  ValAcrescimo:= 0;
  ValDesconto:= 0;
  IndValorQuitaEssaParcela := true;
  IndGeraParcial := false;
end;

{******************************************************************************}
destructor TRBDParcelaCP.Destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da ComissaoItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
Constructor TRBDContasaPagar.Cria;
begin
  inherited;
  IndEsconderConta := false;
  Parcelas := TList.create;
  DespesaProjeto := TList.create;
end;

{******************************************************************************}
destructor TRBDContasaPagar.Destroy;
begin
  FreeTObjectsList(DespesaProjeto);
  FreeTObjectsList(Parcelas);
  DespesaProjeto.free;
  Parcelas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDContasaPagar.addDespesaProjeto: TRBDContasaPagarProjeto;
begin
  result := TRBDContasaPagarProjeto.cria;
  DespesaProjeto.add(result);
end;

{******************************************************************************}
function TRBDContasaPagar.addParcela : TRBDParcelaCP;
begin
  result := TRBDParcelaCP.cria;
  Parcelas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da ComissaoItem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDComissaoItem.cria;
begin
  Inherited create;
end;

{******************************************************************************}
destructor TRBDComissaoItem.destroy;
begin

  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da Comissao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDComissao.cria;
begin
  inherited Create;
  Parcelas := TList.create;
end;

{******************************************************************************}
destructor TRBDComissao.destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDComissao.AddParcela : TRBDComissaoItem;
begin
  result := TRBDComissaoItem.cria;
  Parcelas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da ecobrancaitem
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDECobrancaItem.cria;
begin
  inherited create;

end;

{******************************************************************************}
destructor TRBDECobrancaitem.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da ecobrancacorpo
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDECobrancaCorpo.cria;
begin
  inherited create;
  Items := TList.create;
end;

{******************************************************************************}
destructor TRBDECobrancaCorpo.destroy;
begin
  FreeTObjectsList(Items);
  Items.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDECobrancaCorpo.AddECobrancaItem : TRBDECobrancaItem;
begin
  Result := TRBDECobrancaItem.cria;
  Items.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Dados da forma de pagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDFormaPagamento.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDFormaPagamento.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   Dados da parcela da nova contas a receber
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDMovContasCR.cria;
begin
  inherited create;
  ValDesconto := 0;
end;

{******************************************************************************}
destructor TRBDMovContasCR.destroy;
begin
  inherited destroy;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados da nova contas a receber
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContasCR.cria;
begin
  inherited create;
  Parcelas := TList.create;
  MostrarParcelas := false;
  EsconderConta := false;
  SeqParcialCotacao := 0;
  LanOrcamento := 0;
  IndCobrarFormaPagamento := false;
  IndDevolucao := false;
end;

{******************************************************************************}
destructor TRBDContasCR.destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDContasCR.AddParcela : TRBDMovContasCR;
begin
  result := TRBDMovContasCR.Cria;
  Parcelas.add(result);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Dados do Cheque
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCheque.cria;
begin
  SeqCheque := 0;
end;

{******************************************************************************}
destructor TRBDCheque.destroy;
begin
  inherited;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Dados da condicao de pagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TRBDCondicaoPagamento.AddParcela: TRBDparcelaCondicaoPagamento;
begin
  result := TRBDParcelaCondicaoPagamento.cria;
  Parcelas.add(result);
end;

{******************************************************************************}
constructor TRBDCondicaoPagamento.cria;
begin
  inherited create;
  Parcelas := TList.Create;
end;

{******************************************************************************}
destructor TRBDCondicaoPagamento.destroy;
begin
  FreeTObjectsList(Parcelas);
  Parcelas.free;
  inherited;
end;
{ TRBDCondicaoPagamento }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRBDPercentuaisCondicaoPagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDParcelaCondicaoPagamento.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDParcelaCondicaoPagamento.destroy;
begin

  inherited;
end;
{ TRBDPercentuaisCondicaoPagamento }

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          TRBDPercentuaisCondicaoPagamento
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDCondicaoPagamentoGrupoUsuario.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDCondicaoPagamentoGrupoUsuario.destroy;
begin
  inherited;
end;
{ TRBDCondicaoPagamentoGrupoUsuario }


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    dados da classe do contas a pagar do projeto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDContasaPagarProjeto.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDContasaPagarProjeto.destroy;
begin

  inherited;
end;

{ TRBDContasaPagarProjeto }

end.
