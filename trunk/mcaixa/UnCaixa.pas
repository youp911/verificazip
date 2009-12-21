{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
Unit UnCaixa;
{Verificado
-.edit;
}
Interface

Uses Classes, DBTables, sysUtils, UnDadosCR, SQLExpr, tabela;

//classe localiza
Type TRBLocalizaCaixa = class
  private
  public
    constructor cria;
end;


//classe funcoes
Type
 TRBDOrigemEstorno = (oeContasaPagar,oeContasAReceber,oeConsultaCheque);
 TRBFuncoesCaixa = class(TRBLocalizaCaixa)
  private
    Aux,
    Tabela : TSQLQuery;
    Cadastro : TSQL;
    function RCaixa(VpaContaCaixa : String;VpaCaixas : TList): TRBDCaixa;
    function RFormaPagamentoCaixa(VpaDCaixa : TRBDCaixa;VpaCodFormaPagamento : Integer) : TRBDCaixaFormaPagamento;
    function AdicionaChequesCRCaixa(VpaDBaixa : TRBDBaixaCR):string;
    function AdicionaChequesCPCaixa(VpaDBaixa : TRBDBaixaCP):string;
    function AdicionaParcelasCRCaixa(VpaDBaixa : TRBDBaixaCR):string;
    function AdicionaParcelasCPCaixa(VpaDBaixa : TRBDBaixaCP):string;
    procedure CarDCaixaItem(VpaDCaixa : TRBDCaixa);
    procedure CarDCaixaFormaPagamento(VpaDCaixa : TRBDCaixa);
    procedure AtualizaValAtualCaixa(VpaDCaixa : TRBDCaixa);
    function GravaDCaixaItem(VpaDCaixa : TRBDCaixa) :string;
    function GravaDCaixaFormaPagamento(VpaDCaixa : TRBDCaixa) :string;
    function GravaBaixaCaixas(VpaCaixas : TList) :string;
    function AtualizaSaldoCadConta(VpdCaixa : TRBDCaixa):string;
    procedure AtualizaValorFormasPagamento(VpaDCaixa : TRBDCaixa);
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    function RSeqCaixaDisponivel:Integer;
    function RSeqCaixa(VpaNumConta : String) : Integer;
    function AtualizaSeqCaixaContaCaixa(VpaNumConta : String;VpaSeqCaixa : Integer): string;
    function ContaCaixaAberta(VpaNumConta : String):Boolean;
    function AdicionaBaixaCRCaixa(VpaDBaixa : TRBDBaixaCR):string;
    function AdicionaBaixaCPCaixa(VpaDBaixa : TRBDBaixaCP) : string;
    function AdicionaCompensacaoChequeCaixa(VpaDCheque : TRBDCheque;VpaTipOperacao : String) : string;
    function ExtornaChequeCaixa(VpaCheques : TList;VpaOrigemEstorno : TRBDOrigemEstorno):string;
    function ExtornaParcelaCRCaixa(VpaCodfilial,VpaLanReceber, VpaNumParcela : Integer;VpaIndExtornaDesconto : Boolean):String;
    function ExtornaParcelaCPCaixa(VpaCodfilial,VpaLanPagar, VpaNumParcela : Integer):String;
    procedure CarDCaixa(VpaDCaixa : TRBDCaixa;VpaSeqCaixa : Integer);
    function GravaDCaixa(VpaDCaixa : TRBDCaixa):String;
    function FechaCaixa(VpaDCaixa : TRBDCaixa) : string;
    function RValTotalFormaPagamento(VpaDCaixa : TRBDCaixa):Double;
    function FormaPagamentoDuplicada(VpaDCaixa : TRBDCaixa) : Boolean;
    procedure InicializaValoresCaixa(VpaDCaixa : TRBDCaixa;VpaSeqUltimoCaixa : Integer);
    function TransfereValorCaixa(VpaContaOrigem, VpaContaDestino, VpaDesObservacao : string;VpaValor : Double;VpaData : TDateTime) : string;
end;

var
  FunCaixa : TRBFuncoesCaixa;


implementation

Uses FunSql, Constantes, UncontasAReceber, funObjeto, funData, unContasaPagar;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaCaixa
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaCaixa.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesCaixa
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesCaixa.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Cadastro := TSQL.create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  Aux := TSQLQuery.create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.create(nil);
  Tabela.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesCaixa.destroy;
begin
  Aux.Close;
  Aux.free;
  Cadastro.close;
  Cadastro.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesCaixa.RCaixa(VpaContaCaixa : String;VpaCaixas : TList): TRBDCaixa;
var
  VpfLaco, VpfSeqCaixa : Integer;
  VpfDCaixa : TRBDCaixa;
begin
  result := nil;
  for VpfLaco := 0 to VpaCaixas.Count - 1 do
  begin
    VpfDCaixa := TRBDCaixa(VpaCaixas.Items[VpfLaco]);
    if VpfDCaixa.NumConta = VpaContaCaixa then
    begin
      result := VpfDCaixa;
      break;
    end;
  end;
  if result = nil then
  begin
    VpfSeqCaixa := RSeqCaixa(VpaContaCaixa);
    if VpfSeqCaixa <> 0 then
    begin
      result := TRBDCaixa.cria;
      VpaCaixas.add(result);
      CarDCaixa(result,VpfSeqCaixa);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.RSeqCaixa(VpaNumConta : String) : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_SEQ_CAI from CADCONTAS '+
                                   ' Where C_NRO_CON = '''+VpaNumConta+'''');
  result := Aux.FieldByname('I_SEQ_CAI').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesCaixa.AdicionaChequesCRCaixa(VpaDBaixa : TRBDBaixaCR):string;
var
  VpfLaco : Integer;
  VpfDCheque : TRBDCheque;
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
begin
  result := '';
  for VpfLaco := 0 to VpaDBaixa.Cheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaDBaixa.Cheques.Items[VpfLaco]);
    if (VpfDCheque.DatCompensacao > MontaData(1,1,1900)) or
       (VpfDCheque.TipContaCaixa = 'CA')  then
    begin
      VpfDCaixa := RCaixa(VpfDCheque.NumContaCaixa,VpaDBaixa.Caixas);
      if VpfDCaixa = nil then
      begin
        result := 'CONTA CAIXA "'+VpfDCheque.NumContaCaixa+'" NÃO FOI ABERTO!!!!'#13'É necessário abrir a conta caixa antes e baixar o contas a receber.';
        break;
      end;
      
      VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
      VpfDItemCaixa.CodUsuario := varia.CodigoUsuario;
      VpfDItemCaixa.SeqCheque := VpfDCheque.SeqCheque;
      VpfDItemCaixa.DesLancamento := 'Recebimento do Cheque '+IntToStr(VpfDCheque.NumCheque);
      VpfDItemCaixa.DesDebitoCredito := 'C';
      VpfDItemCaixa.ValLancamento := VpfDCheque.ValCheque;
      VpfDItemCaixa.DatLancamento := now;
      VpfDItemCaixa.DatPagamento := VpaDBaixa.DatPagamento;
      VpfDItemCaixa.CodFormaPagamento := VpfDCheque.CodFormaPagamento;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.RFormaPagamentoCaixa(VpaDCaixa : TRBDCaixa;VpaCodFormaPagamento : Integer) : TRBDCaixaFormaPagamento;
var
  VpfLaco : Integer;
begin
  result := nil;
  for Vpflaco := 0 to VpaDCaixa.FormasPagamento.Count - 1 do
  begin
    if TRBDCaixaFormaPagamento(VpaDCaixa.FormasPagamento.Items[VpfLaco]).CodFormaPagamento = VpaCodFormaPagamento then
    begin
      Result := TRBDCaixaFormaPagamento(VpaDCaixa.FormasPagamento.Items[VpfLaco]);
      break;
    end;
  end;
  if  result = nil then
  begin
    result :=  VpaDCaixa.AddFormaPagamento;
    Result.CodFormaPagamento := VpaCodFormaPagamento;
    Result.ValInicial := 0;
    Result.ValAtual := 0;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.AdicionaChequesCPCaixa(VpaDBaixa : TRBDBaixaCP):string;
var
  VpfLaco : Integer;
  VpfDCheque : TRBDCheque;
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
  VpfNomFornecedor : String;
begin
  result := '';
  if VpaDBaixa.Parcelas.Count > 0 then
    VpfNomFornecedor := TRBDParcelaCP(VpaDBaixa.Parcelas.Items[0]).NomCliente;
  for VpfLaco := 0 to VpaDBaixa.Cheques.Count - 1 do
  begin
    VpfDCheque := TRBDCheque(VpaDBaixa.Cheques.Items[VpfLaco]);
    if  VpfDCheque.DatCompensacao > MontaData(1,1,1900) then
    begin
      VpfDCaixa := RCaixa(VpfDCheque.NumContaCaixa,VpaDBaixa.Caixas);
      if VpfDCaixa = nil then
      begin
        result := 'CONTA CAIXA "'+VpfDCheque.NumContaCaixa+'" NÃO FOI ABERTO!!!!'#13'É necessário abrir a conta caixa antes e baixar o contas a receber.';
        break;
      end;
      VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
      VpfDItemCaixa.CodUsuario := varia.CodigoUsuario;
      VpfDItemCaixa.SeqCheque := VpfDCheque.SeqCheque;
      VpfDItemCaixa.DesLancamento := 'Pgto Cheque '+IntToStr(VpfDCheque.NumCheque) + ' do forn. '+VpfNomFornecedor;
      VpfDItemCaixa.DesDebitoCredito := 'D';
      VpfDItemCaixa.ValLancamento := VpfDCheque.ValCheque;
      VpfDItemCaixa.DatLancamento := now;
      VpfDItemCaixa.CodFormaPagamento := VpfDCheque.CodFormaPagamento;
      VpfDItemCaixa.DatPagamento := VpaDBaixa.DatPagamento;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.AdicionaParcelasCRCaixa(VpaDBaixa : TRBDBaixaCR):string;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
begin
  result := '';
  VpfDCaixa := RCaixa(VpaDBaixa.NumContaCaixa,VpaDBaixa.Caixas);
  if VpfDCaixa = nil then
    result := 'CONTA CAIXA "'+VpaDBaixa.NumContaCaixa+'" NÃO FOI ABERTO!!!!'#13'É necessário abrir a conta caixa antes e baixar o contas a receber.';
  if result = '' then
  begin
    for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[VpfLaco]);
      if not(VpfDParcela.IndDescontado and (VpaDBaixa.CodFormaPagamento = varia.FormaPagamentoBoleto)) then
      begin
        VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
        VpfDItemCaixa.CodUsuario := varia.CodigoUsuario;
        VpfDItemCaixa.CodFilial := VpfDParcela.CodFilial;
        VpfDItemCaixa.LanReceber := VpfDParcela.LanReceber;
        VpfDItemCaixa.NumParcelaReceber := VpfDParcela.NumParcela;
        if VpaDBaixa.IndDesconto then
          VpfDItemCaixa.DesLancamento := 'Desconto da nf '+VpfDParcela.NumDuplicata +' do Cliente "'+VpfDParcela.NomCliente +'" do CR'
        else
          VpfDItemCaixa.DesLancamento := 'Receb da nf '+VpfDParcela.NumDuplicata +' do Cliente "'+VpfDParcela.NomCliente +'" do CR';
        VpfDItemCaixa.DesDebitoCredito := 'C';
        VpfDItemCaixa.ValLancamento := VpfDParcela.ValParcela+VpfDParcela.ValAcrescimo-VpfDParcela.ValDesconto;
        if VpfDParcela.IndGeraParcial then
          VpfDItemCaixa.ValLancamento := VpfDItemCaixa.ValLancamento- VpaDBaixa.ValParcialFaltante;
        VpfDItemCaixa.DatLancamento := now;
        VpfDItemCaixa.CodFormaPagamento := VpaDBaixa.CodFormaPagamento;
        VpfDItemCaixa.DatPagamento := VpaDBaixa.DatPagamento;
      end;
    end;
    if (VpaDBaixa.ValParaGerardeCredito > 0) and
       (VpaDBaixa.Parcelas.Count > 0) then
    begin
      VpfDParcela := TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[0]);
      VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
      VpfDItemCaixa.CodUsuario := varia.CodigoUsuario;
      VpfDItemCaixa.CodFilial := VpfDParcela.CodFilial;
      VpfDItemCaixa.LanReceber := VpfDParcela.LanReceber;
      VpfDItemCaixa.NumParcelaReceber := VpfDParcela.NumParcela;
      VpfDItemCaixa.DesLancamento := 'Credito ref pagto a maior da duplicata '+VpfDParcela.NumDuplicata +' do Cliente "'+VpfDParcela.NomCliente +'" do CR';
      VpfDItemCaixa.DesDebitoCredito := 'C';
      VpfDItemCaixa.ValLancamento := VpaDBaixa.ValParaGerardeCredito;
      VpfDItemCaixa.DatLancamento := now;
      VpfDItemCaixa.CodFormaPagamento := VpaDBaixa.CodFormaPagamento;
      VpfDItemCaixa.DatPagamento := VpaDBaixa.DatPagamento;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.AdicionaParcelasCPCaixa(VpaDBaixa : TRBDBaixaCP):string;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaCP;
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
begin
  result := '';
  VpfDCaixa := RCaixa(VpaDBaixa.NumContaCaixa,VpaDBaixa.Caixas);
  if VpfDCaixa = nil then
    result := 'CONTA CAIXA "'+VpaDBaixa.NumContaCaixa+'" NÃO FOI ABERTO!!!!'#13'É necessário abrir a conta caixa antes e baixar o contas a receber.';
  if result = '' then
  begin
    for VpfLaco := 0 to VpaDBaixa.Parcelas.Count - 1 do
    begin
      VpfDParcela := TRBDParcelaCP(VpaDBaixa.Parcelas.Items[VpfLaco]);
      VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
      VpfDItemCaixa.CodUsuario := varia.CodigoUsuario;
      VpfDItemCaixa.CodFilial := VpfDParcela.CodFilial;
      VpfDItemCaixa.LanPagar := VpfDParcela.LanPagar;
      VpfDItemCaixa.NumParcelaPagar := VpfDParcela.NumParcela;
      VpfDItemCaixa.DesLancamento := 'Pgto da nf '+VpfDParcela.NumDuplicata +' do fornecedor "'+VpfDParcela.NomCliente+'"';
      VpfDItemCaixa.DesDebitoCredito := 'D';
      if VpfDParcela.IndGeraParcial then
        VpfDItemCaixa.ValLancamento := VpfDParcela.ValParcela-VpaDBaixa.ValParcialFaltante
      else
        VpfDItemCaixa.ValLancamento := VpfDParcela.ValParcela+VpfDParcela.ValAcrescimo-VpfDParcela.ValDesconto;
      VpfDItemCaixa.DatLancamento := now;
      VpfDItemCaixa.CodFormaPagamento := VpaDBaixa.CodFormaPagamento;
      VpfDItemCaixa.DatPagamento := VpaDBaixa.DatPagamento;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.ExtornaChequeCaixa(VpaCheques : TList;VpaOrigemEstorno : TRBDOrigemEstorno):string;
var
  VpfLaco : Integer;
  VpfDCheque : TRBDCheque;
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
  VpfCaixas : TList;
begin
  result := '';
  if ConfigModulos.Caixa then
  begin
    VpfCaixas := TList.create;
    for VpfLaco := 0 to VpaCheques.Count - 1 do
    begin
      VpfDCheque := TRBDCheque(VpaCheques.Items[VpfLaco]);
      begin
        if (VpfDCheque.TipCheque = 'C') or
           ((VpfDCheque.TipCheque = 'D') and
            (VpfDCheque.DatCompensacao > MontaData(1,1,1900))) then
        begin
          VpfDCaixa := RCaixa(VpfDCheque.NumContaCaixa,VpfCaixas);
          if VpfDCaixa = nil then
          begin
            result := 'CONTA CAIXA "'+VpfDCheque.NumContaCaixa+'" NÃO FOI ABERTO!!!!'#13'É necessário abrir a conta caixa antes e baixar o contas a receber.';
            break;
          end;
          VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
          VpfDItemCaixa.CodUsuario := varia.CodigoUsuario;
          VpfDItemCaixa.SeqCheque := VpfDCheque.SeqCheque;
          if (VpfDCheque.TipCheque = 'C') and
             (VpaOrigemEstorno in [oeContasAReceber,oeConsultaCheque]) then
          begin
            VpfDItemCaixa.DesDebitoCredito := 'D';
            VpfDItemCaixa.DesLancamento := 'Extorno do Cheque recebido '+IntToStr(VpfDCheque.NumCheque);
          end
          else
          begin
            VpfDItemCaixa.DesDebitoCredito := 'C';
            VpfDItemCaixa.DesLancamento := 'Extorno do Cheque pago '+IntToStr(VpfDCheque.NumCheque);
          end;
          VpfDItemCaixa.ValLancamento := VpfDCheque.ValCheque;
          VpfDItemCaixa.DatLancamento := now;
          VpfDItemCaixa.DatPagamento := VpfDCheque.DatCompensacao;
          VpfDItemCaixa.CodFormaPagamento := VpfDCheque.CodFormaPagamento;
        end;
      end;
    end;
    result := GravaBaixaCaixas(VpfCaixas);
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.ExtornaParcelaCRCaixa(VpaCodfilial,VpaLanReceber, VpaNumParcela : Integer;VpaIndExtornaDesconto : Boolean):String;
var
  VpfDParcela : TRBDParcelaBaixaCR;
  VpfDCaixa : TRBDCaixa;
  VpfCaixas : TList;
  VpfDItemCaixa : TRBDCaixaItem;
begin
  result := '';
  if ConfigModulos.Caixa then
  begin
    VpfCaixas := tList.create;
    VpfDParcela := TRBDParcelaBaixaCR.Cria;
    FunContasAReceber.CarDParcelaBaixa(VpfDParcela,VpaCodfilial,VpaLanReceber,VpaNumParcela);
    if VpfDParcela.NumContaCorrente <> '' then
    begin
      VpfDCaixa := RCaixa(VpfDParcela.NumContaCorrente,VpfCaixas);
      if VpfDCaixa = nil then
        result := 'CONTA CAIXA "'+VpfDParcela.NumContaCorrente+'" NÃO FOI ABERTO!!!!'#13'É necessário abrir a conta caixa antes e baixar o contas a receber.';
      if result = '' then
      begin
        VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
        VpfDItemCaixa.CodUsuario := varia.CodigoUsuario;
        VpfDItemCaixa.CodFilial := VpfDParcela.CodFilial;
        VpfDItemCaixa.LanReceber := VpfDParcela.LanReceber;
        VpfDItemCaixa.NumParcelaReceber := VpfDParcela.NumParcela;
        if VpaIndExtornaDesconto then
        begin
          VpfDItemCaixa.DesLancamento := 'Extorno da desconto da nf'+VpfDParcela.NumDuplicata +' do CR do cliente "'+VpfDParcela.NomCliente+'"';
          VpfDItemCaixa.ValLancamento := VpfDParcela.ValParcela-VpfDParcela.ValTarifaDesconto;
          if VpfDParcela.DatPagamento > montaData(1,1,1900) then
            VpfDItemCaixa.DatLancamento := VpfDParcela.DatPagamento
          else
            VpfDItemCaixa.DatLancamento := date;
        end
        else
        begin
          VpfDItemCaixa.DesLancamento := 'Extorno da nf '+VpfDParcela.NumDuplicata +' do CR do cliente "'+VpfDParcela.NomCliente+'"';
          VpfDItemCaixa.ValLancamento := VpfDParcela.ValPago;
          VpfDItemCaixa.DatLancamento := VpfDParcela.DatPagamento;
        end;
        VpfDItemCaixa.DesDebitoCredito := 'D';
        VpfDItemCaixa.CodFormaPagamento := VpfDParcela.CodFormaPagamento;
        VpfDItemCaixa.DatPagamento := VpfDParcela.DatPagamento;
        if result = '' then
          result := GravaBaixaCaixas(VpfCaixas);
      end;
      FreeTObjectsList(VpfCaixas);
      VpfCaixas.free;
      VpfDParcela.free;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.ExtornaParcelaCPCaixa(VpaCodfilial,VpaLanPagar, VpaNumParcela : Integer):String;
var
  VpfDParcela : TRBDParcelaCP;
  VpfDCaixa : TRBDCaixa;
  VpfCaixas : TList;
  VpfDItemCaixa : TRBDCaixaItem;
begin
  result := '';
  if ConfigModulos.Caixa then
  begin
    VpfCaixas := tList.create;
    VpfDParcela := TRBDParcelaCP.Cria;
    FunContasAPagar.CarDParcelaBaixa(VpfDParcela,VpaCodfilial,VpaLanPagar,VpaNumParcela);
    VpfDCaixa := RCaixa(VpfDParcela.NumContaCorrente,VpfCaixas);
    if VpfDCaixa = nil then
      result := 'CONTA CAIXA "'+VpfDParcela.NumContaCorrente+'" NÃO FOI ABERTO!!!!'#13'É necessário abrir a conta caixa antes e baixar o contas a receber.';
    if result = '' then
    begin
      VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
      VpfDItemCaixa.CodUsuario := varia.CodigoUsuario;
      VpfDItemCaixa.CodFilial := VpfDParcela.CodFilial;
      VpfDItemCaixa.LanReceber := VpfDParcela.LanPagar;
      VpfDItemCaixa.NumParcelaReceber := VpfDParcela.NumParcela;
      VpfDItemCaixa.DesLancamento := 'Extorno da nf '+VpfDParcela.NumDuplicata +' do CP do fornecedor "'+VpfDParcela.NomCliente+'"';
      VpfDItemCaixa.DesDebitoCredito := 'C';
      VpfDItemCaixa.ValLancamento := VpfDParcela.ValPago;
      VpfDItemCaixa.DatLancamento := now;
      VpfDItemCaixa.CodFormaPagamento := VpfDParcela.CodFormaPagamento;
    end;
    if result = '' then
      result := GravaBaixaCaixas(VpfCaixas);
    FreeTObjectsList(VpfCaixas);
    VpfCaixas.free;
    VpfDParcela.free;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.RSeqCaixaDisponivel :Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQCAIXA) ULTIMO From CAIXACORPO');
  result := Aux.FieldByname('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesCaixa.CarDCaixaItem(VpaDCaixa : TRBDCaixa);
var
  VpfDItem : TRBDCaixaItem;
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CAIXAITEM ' +
                               ' Where SEQCAIXA = '+InttoStr(VpaDCaixa.SeqCaixa)+
                               ' order by SEQITEM ');
  While not Tabela.eof do
  begin
    VpfDItem := VpaDCaixa.AddCaixaItem;
    VpfDItem.seqItem := Tabela.FieldByname('SEQITEM').AsInteger;
    VpfDItem.CodUsuario := Tabela.FieldByname('CODUSUARIO').AsInteger;
    VpfDItem.CodFilial := Tabela.FieldByname('CODFILIAL').AsInteger;
    VpfDItem.LanReceber := Tabela.FieldByname('LANRECEBER').AsInteger;
    VpfDItem.LanPagar := Tabela.FieldByname('LANPAGAR').AsInteger;
    VpfDItem.ValLancamento := Tabela.FieldByname('VALLANCAMENTO').AsFloat;
    VpfDItem.NumParcelaReceber := Tabela.FieldByname('NUMPARCELARECEBER').AsInteger;
    VpfDItem.NumParcelaPagar := Tabela.FieldByname('NUMPARCELAPAGAR').AsInteger;
    VpfDItem.SeqCheque := Tabela.FieldByname('SEQCHEQUE').AsInteger;
    VpfDItem.DesLancamento := Tabela.FieldByname('DESLANCAMENTO').AsString;
    VpfDItem.DesDebitoCredito := Tabela.FieldByname('DESDEBITOCREDITO').AsString;
    VpfDItem.DatLancamento := Tabela.FieldByname('DATLANCAMENTO').AsDatetime;
    VpfDItem.DatPagamento := Tabela.FieldByname('DATPAGAMENTO').AsDatetime;
    VpfDItem.CodFormaPagamento := Tabela.FieldByname('CODFORMAPAGAMENTO').AsInteger;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesCaixa.CarDCaixaFormaPagamento(VpaDCaixa : TRBDCaixa);
Var
  VpfDFormaPagamento : TRBDCaixaFormaPagamento;
begin
  FreeTObjectsList(VpaDCaixa.FormasPagamento);
  AdicionaSQLAbreTabela(Tabela,'Select CAF.CODFORMAPAGAMENTO, CAF.VALINICIAL, CAF.VALATUAL, CAF.VALFINAL, '+
                              ' FRM.C_NOM_FRM '+
                              ' from CAIXAFORMAPAGAMENTO CAF, CADFORMASPAGAMENTO FRM '+
                              ' Where CAF.SEQCAIXA = ' +IntToStr(VpaDCaixa.SeqCaixa)+
                              ' AND CAF.CODFORMAPAGAMENTO = FRM.I_COD_FRM');
  While not Tabela.Eof do
  begin
    VpfDFormaPagamento := VpaDCaixa.AddFormaPagamento;
    VpfDFormaPagamento.CodFormaPagamento := Tabela.FieldByname('CODFORMAPAGAMENTO').AsInteger;
    VpfDFormaPagamento.NomFormaPagamento := Tabela.FieldByname('C_NOM_FRM').AsString;
    VpfDFormaPagamento.ValInicial := Tabela.FieldByname('VALINICIAL').AsFloat;
    VpfDFormaPagamento.ValAtual := Tabela.FieldByname('VALATUAL').AsFloat;
    VpfDFormaPagamento.ValFinal := Tabela.FieldByname('VALFINAL').AsFloat;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesCaixa.AtualizaValAtualCaixa(VpaDCaixa : TRBDCaixa);
var
  VpfLaco : Integer;
  VpfDCaixaItem : TRBDCaixaItem;
begin
  VpaDCaixa.ValAtual := VpaDCaixa.ValInicial;
  for VpfLaco := 0 to VpaDCaixa.Items.Count - 1 do
  begin
    VpfDCaixaItem := TRBDCaixaItem(VpaDCaixa.Items.Items[VpfLaco]);
    if VpfDCaixaItem.DesDebitoCredito = 'C' then
      VpaDCaixa.ValAtual := VpaDCaixa.ValAtual +VpfDCaixaItem.ValLancamento
    else
      VpaDCaixa.ValAtual := VpaDCaixa.ValAtual - VpfDCaixaItem.ValLancamento;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.GravaDCaixaItem(VpaDCaixa : TRBDCaixa) :string;
var
  VpfDItemCaixa :TRBDCaixaItem;
  VpfLaco : Integer;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from CAIXAITEM '+
                        ' Where SEQCAIXA = ' +IntToStr(VpaDCaixa.SeqCaixa));
  AdicionaSQLAbreTabela(Cadastro,'Select * from CAIXAITEM '+
                                 ' Where SEQCAIXA = 0 AND SEQITEM = 0 ');
  for VpfLaco := 0 to VpaDCaixa.Items.Count - 1 do
  begin
    VpfDItemCaixa := TRBDCaixaItem(VpaDCaixa.Items.Items[VpfLaco]);
    VpfDItemCaixa.seqItem := VpfLaco +1;
    Cadastro.Insert;
    Cadastro.FieldByname('SEQCAIXA').AsInteger := VpaDCaixa.SeqCaixa;
    Cadastro.FieldByname('SEQITEM').AsInteger := VpfDItemCaixa.seqItem;
    Cadastro.FieldByname('CODUSUARIO').AsInteger := VpfDItemCaixa.CodUsuario;
    Cadastro.FieldByname('CODFORMAPAGAMENTO').AsInteger := VpfDItemCaixa.CodFormaPagamento;
    if VpfDItemCaixa.CodFilial <> 0 then
      Cadastro.FieldByname('CODFILIAL').AsInteger := VpfDItemCaixa.CodFilial;
    if VpfDItemCaixa.LanReceber <> 0 then
      Cadastro.FieldByname('LANRECEBER').AsInteger := VpfDItemCaixa.LanReceber;
    if VpfDItemCaixa.LanPagar <> 0 then
      Cadastro.FieldByname('LANPAGAR').AsInteger := VpfDItemCaixa.LanPagar;
    if VpfDItemCaixa.NumParcelaReceber <> 0 then
      Cadastro.FieldByname('NUMPARCELARECEBER').AsInteger := VpfDItemCaixa.NumParcelaReceber;
    if VpfDItemCaixa.NumParcelaPagar <> 0 then
      Cadastro.FieldByname('NUMPARCELAPAGAR').AsInteger := VpfDItemCaixa.NumParcelaPagar;
    if VpfDItemCaixa.SeqCheque <> 0 then
      Cadastro.FieldByname('SEQCHEQUE').AsInteger := VpfDItemCaixa.SeqCheque;
    Cadastro.FieldByname('DESLANCAMENTO').AsString := VpfDItemCaixa.DesLancamento;
    Cadastro.FieldByname('DESDEBITOCREDITO').AsString := VpfDItemCaixa.DesDebitoCredito;
    Cadastro.FieldByname('VALLANCAMENTO').AsFloat := VpfDItemCaixa.ValLancamento;
    Cadastro.FieldByname('DATLANCAMENTO').AsDateTime := VpfDItemCaixa.DatLancamento;
    Cadastro.FieldByname('DATPAGAMENTO').AsDateTime := VpfDItemCaixa.DatPagamento;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesCaixa.GravaDCaixaFormaPagamento(VpaDCaixa : TRBDCaixa) :string;
var
  VpfLaco : Integer;
  VpfDFormaPagamento : TRBDCaixaFormaPagamento;
begin
  AtualizaValorFormasPagamento(VpaDCaixa);
  ExecutaComandoSql(Aux,'Delete from CAIXAFORMAPAGAMENTO '+
                        ' Where SEQCAIXA = '+IntToStr(VpaDCaixa.SeqCaixa));
  AdicionaSQLAbreTabela(Cadastro,'Select * from CAIXAFORMAPAGAMENTO '+
                                 ' Where SEQCAIXA = 0 AND CODFORMAPAGAMENTO = 0' );
  for VpfLaco := 0 to VpaDCaixa.FormasPagamento.Count - 1 do
  begin
    VpfDFormaPagamento := TRBDCaixaFormaPagamento(VpaDCaixa.FormasPagamento.Items[VpfLaco]);
    Cadastro.Insert;
    cadastro.FieldByname('SEQCAIXA').AsInteger := VpaDCaixa.SeqCaixa;
    cadastro.FieldByname('CODFORMAPAGAMENTO').AsInteger := VpfDFormaPagamento.CodFormaPagamento;
    cadastro.FieldByname('VALINICIAL').AsFloat := VpfDFormaPagamento.ValInicial;
    cadastro.FieldByname('VALATUAL').AsFloat := VpfDFormaPagamento.ValAtual;
    cadastro.FieldByname('VALFINAL').AsFloat := VpfDFormaPagamento.ValFinal;
    Cadastro.post;
    result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      break;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesCaixa.GravaBaixaCaixas(VpaCaixas : TList) :string;
var
  VpfLaco : Integer;
  VpfDCaixa : TRBDCaixa;
begin
  result := '';
  for VpfLaco := 0 to VpaCaixas.Count-1 do
  begin
    VpfDCaixa := TRBDCaixa(VpaCaixas.Items[VpfLaco]);
    result := GravaDCaixa(VpfDCaixa);
    if result <> '' then
      break;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.AtualizaSaldoCadConta(VpdCaixa : TRBDCaixa):string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCONTAS '+
                                 ' Where C_NRO_CON = '''+VpdCaixa.NumConta+'''');
  Cadastro.edit;
  Cadastro.FieldByname('N_SAL_ATU').AsFloat := VpdCaixa.ValAtual;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesCaixa.AtualizaValorFormasPagamento(VpaDCaixa : TRBDCaixa);
var
  VpfLaco : Integer;
  VpfDItemCaixa : TRBDCaixaItem;
  VpfDFormaPagamento : TRBDCaixaFormaPagamento;
begin
  for VpfLaco := 0 to VpaDCaixa.FormasPagamento.Count - 1 do
  begin
    VpfDFormaPagamento := TRBDCaixaFormaPagamento(VpaDCaixa.FormasPagamento.Items[VpfLaco]);
    VpfDFormaPagamento.ValAtual := VpfDFormaPagamento.ValInicial;
  end;

  for VpfLaco := 0 to VpaDCaixa.Items.Count - 1 do
  begin
    VpfDItemCaixa := TRBDCaixaItem(VpaDCaixa.Items.Items[VpfLaco]);
    VpfDFormaPagamento := RFormaPagamentoCaixa(VpaDCaixa,VpfDItemCaixa.CodFormaPagamento);
    if VpfDItemCaixa.DesDebitoCredito = 'D' then
      VpfDFormaPagamento.ValAtual := VpfDFormaPagamento.ValAtual - VpfDItemCaixa.ValLancamento
    else
      VpfDFormaPagamento.ValAtual := VpfDFormaPagamento.ValAtual + VpfDItemCaixa.ValLancamento;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.AtualizaSeqCaixaContaCaixa(VpaNumConta : String;VpaSeqCaixa : Integer):string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADCONTAS '+
                                 ' Where C_NRO_CON = '''+VpaNumConta+'''');
  Cadastro.edit;
  if VpaSeqCaixa <> 0 then
  begin
    Cadastro.FieldByname('I_SEQ_CAI').AsInteger := VpaSeqCaixa;
    Cadastro.FieldByname('I_ULT_CAI').AsInteger := VpaSeqCaixa;
  end
  else
  begin
    Cadastro.FieldByname('I_ULT_CAI').AsInteger := Cadastro.FieldByname('I_SEQ_CAI').AsInteger;
    Cadastro.FieldByname('I_SEQ_CAI').clear;
  end;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesCaixa.ContaCaixaAberta(VpaNumConta : String):Boolean;
begin
  result := true;
  if ConfigModulos.Caixa then
    result := RSeqCaixa(VpaNumConta) <> 0;
end;

{******************************************************************************}
function TRBFuncoesCaixa.AdicionaBaixaCRCaixa(VpaDBaixa : TRBDBaixaCR) : String;
begin
  result := '';
  if VpaDBaixa.Cheques.Count > 0 then
    result := AdicionaChequesCRCaixa(VpaDBaixa)
  else
    result := AdicionaParcelasCRCaixa(VpaDBaixa);
  if result = '' then
  begin
    result := GravaBaixaCaixas(VpaDBaixa.Caixas);
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.AdicionaBaixaCPCaixa(VpaDBaixa : TRBDBaixaCP) : string;
begin
  result := '';
  if VpaDBaixa.Cheques.Count > 0 then
    result := AdicionaChequesCPCaixa(VpaDBaixa)
  else
    result := AdicionaParcelasCPCaixa(VpaDBaixa);
  if result = '' then
  begin
    result := GravaBaixaCaixas(VpaDBaixa.Caixas);
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.AdicionaCompensacaoChequeCaixa(VpaDCheque : TRBDCheque;VpaTipOperacao : String) : string;
var
  VpfDBaixaCP : TRBDBaixaCP;
  VpfDBaixaCR : TRBDBaixaCR;
begin
  if VpaTipOperacao = 'C' then
  begin
    VpfDBaixaCR := TRBDBaixaCR.Cria;
    VpfDBaixaCR.DatPagamento := VpaDCheque.DatCompensacao;
    VpfDBaixaCR.Cheques.add(VpaDCheque);
    result := AdicionaChequesCRCaixa(VpfDBaixaCR);
    if result = '' then
      result := GravaBaixaCaixas(VpfDBaixaCR.Caixas);
  end
  else
  begin
    VpfDBaixaCP := TRBDBaixaCP.Cria;
    VpfDBaixaCP.DatPagamento := VpaDCheque.DatCompensacao;
    VpfDBaixaCP.Cheques.add(VpaDCheque);
    result := AdicionaChequesCPCaixa(VpfDBaixaCP);
    if result = '' then
      result := GravaBaixaCaixas(VpfDBaixaCP.Caixas);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesCaixa.CarDCaixa(VpaDCaixa : TRBDCaixa;VpaSeqCaixa : Integer);
begin
  FreeTObjectsList(VpaDCaixa.Items);
  AdicionaSQLAbreTabela(Tabela,'Select * from CAIXACORPO '+
                               ' Where SEQCAIXA = ' + IntToStr(VpaSeqCaixa));
  VpaDCaixa.SeqCaixa := VpaSeqCaixa;
  VpaDCaixa.CodUsuarioAbertura := Tabela.FieldByname('CODUSUARIOABERTURA').AsInteger;
  VpaDCaixa.NumConta := Tabela.FieldByname('NUMCONTA').AsString;
  VpaDCaixa.ValInicial := Tabela.FieldByname('VALINICIAL').AsFloat;
  VpaDCaixa.ValAtual := Tabela.FieldByname('VALATUAL').AsFloat;
  VpaDCaixa.ValFinal := Tabela.FieldByname('VALFINAL').AsFloat;
  VpaDCaixa.DatAbertura := Tabela.FieldByname('DATABERTURA').AsDateTime;
  VpaDCaixa.DatFechamento := Tabela.FieldByname('DATFECHAMENTO').AsDateTime;

  CarDCaixaItem(VpaDCaixa);
  CarDCaixaFormaPagamento(VpaDCaixa);
  Tabela.close;
end;

{******************************************************************************}
function TRBFuncoesCaixa.GravaDCaixa(VpaDCaixa: TRBDCaixa): String;
begin
  result := '';
  AtualizaValAtualCaixa(VpaDCaixa);
  AdicionaSQLAbreTabela(Cadastro,'Select * from CAIXACORPO '+
                                 ' Where SEQCAIXA = ' +IntToStr(VpaDCaixa.SeqCaixa));
  if VpaDCaixa.SeqCaixa = 0 then
    Cadastro.insert
  else
    Cadastro.edit;
  Cadastro.FieldByname('NUMCONTA').AsString := VpaDCaixa.NumConta;
  Cadastro.FieldByname('DATABERTURA').AsDateTime := VpaDCaixa.DatAbertura;
  if VpaDCaixa.DatFechamento > MontaData(1,1,1900) then
    Cadastro.FieldByname('DATFECHAMENTO').AsDateTime := VpaDCaixa.DatFechamento;
  Cadastro.FieldByname('CODUSUARIOABERTURA').AsInteger := VpaDCaixa.CodUsuarioAbertura;
  Cadastro.FieldByname('VALINICIAL').AsFloat := VpaDCaixa.ValInicial;
  Cadastro.FieldByname('VALATUAL').AsFloat := VpaDCaixa.ValAtual;
  if VpaDCaixa.ValFinal <> 0 then
    Cadastro.FieldByname('VALFINAL').AsFloat := VpaDCaixa.ValFinal;
  if VpaDCaixa.SeqCaixa = 0 then
    VpaDCaixa.SeqCaixa := RSeqCaixaDisponivel;
  Cadastro.FieldByname('SEQCAIXA').AsInteger := VpaDCaixa.SeqCaixa;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;

  if result = '' then
  begin
    result :=  AtualizaSaldoCadConta(VpaDCaixa);
    if result = '' then
    begin
      result := GravaDCaixaItem(VpaDCaixa);
      if result = '' then
        result := GravaDCaixaFormaPagamento(VpaDCaixa);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.FechaCaixa(VpaDCaixa : TRBDCaixa) : string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from CAIXACORPO '+
                                 ' Where SEQCAIXA = ' +IntToStr(VpaDCaixa.SeqCaixa));
  Cadastro.edit;
  Cadastro.FieldByname('DATFECHAMENTO').AsDateTime := VpaDCaixa.DatFechamento;
  Cadastro.FieldByname('CODUSUARIOFECHAMENTO').AsInteger := VpaDCaixa.CodUsuarioFechamento;
  if VpaDCaixa.ValFinal <> 0 then
    Cadastro.FieldByname('VALFINAL').AsFloat := VpaDCaixa.ValFinal;
  Cadastro.post;
  result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
  if result = '' then
    result := AtualizaSeqCaixaContaCaixa(VpaDCaixa.NumConta,0);
end;

{******************************************************************************}
function TRBFuncoesCaixa.RValTotalFormaPagamento(VpaDCaixa : TRBDCaixa):Double;
var
  VpfLaco : Integer;
  VpfDFormaPagamento : TRBDCaixaFormaPagamento;
begin
  result := 0;
  for VpfLaco := 0 to VpaDCaixa.FormasPagamento.Count - 1 do
  begin
    VpfDFormaPagamento := TRBDCaixaFormaPagamento(VpaDCaixa.FormasPagamento.Items[VpfLaco]);
    result := result + VpfDFormaPagamento.ValInicial;
  end;
end;

{******************************************************************************}
function TRBFuncoesCaixa.FormaPagamentoDuplicada(VpaDCaixa : TRBDCaixa) : Boolean;
var
  VpfLacoInterno, VpfLacoExterno : Integer;
  VpfDFormaInterno, VpfDFormaExterno : TRBDCaixaFormaPagamento;
begin
  result := false;
  for VpfLacoExterno := 0 to VpaDCaixa.FormasPagamento.Count -2 do
  begin
    VpfDFormaExterno := TRBDCaixaFormaPagamento(VpaDCaixa.FormasPagamento.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno + 1 to VpaDCaixa.FormasPagamento.Count - 1 do
    begin
      VpfDFormaInterno := TRBDCaixaFormaPagamento(VpaDCaixa.FormasPagamento.Items[VpfLacoInterno]);
      if VpfDFormaInterno.CodFormaPagamento = VpfDFormaExterno.CodFormaPagamento then
      begin
        result := true;
        break;
      end;
    end;
    if result then
      break;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesCaixa.InicializaValoresCaixa(VpaDCaixa : TRBDCaixa;VpaSeqUltimoCaixa : Integer);
var
  VpfDCaixa : TRBDCaixa;
  VpfLaco : Integer;
  VpfDFormaPagamentoDE, VpfDFormaPagamentoPara : TRBDCaixaFormaPagamento;
begin
  FreeTObjectsList(VpaDCaixa.FormasPagamento);
  VpfDCaixa := TRBDCaixa.cria;
  VpfDCaixa.SeqCaixa := VpaSeqUltimoCaixa;
  CarDCaixaFormaPagamento(VpfDCaixa);
  for VpfLaco := 0 to VpfDCaixa.FormasPagamento.Count - 1 do
  begin
    VpfDFormaPagamentoDE := TRBDCaixaFormaPagamento(VpfDCaixa.FormasPagamento.Items[VpfLaco]);
    VpfDFormaPagamentoPara := VpaDCaixa.AddFormaPagamento;
    VpfDFormaPagamentoPara.CodFormaPagamento := VpfDFormaPagamentoDE.CodFormaPagamento;
    VpfDFormaPagamentoPara.NomFormaPagamento := VpfDFormaPagamentoDE.NomFormaPagamento;
    VpfDFormaPagamentoPara.ValInicial := VpfDFormaPagamentoDE.ValAtual;
    VpfDFormaPagamentoPara.ValAtual := VpfDFormaPagamentoPara.ValInicial;
    VpfDFormaPagamentoPara.ValFinal := 0;
  end;

  VpfDCaixa.free;
end;

function TRBFuncoesCaixa.TransfereValorCaixa(VpaContaOrigem, VpaContaDestino, VpaDesObservacao : string;VpaValor : Double;VpaData : TDateTime) : string;
begin

end;

end.
