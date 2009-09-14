unit UnECF;
{Verificado
-.edit;
}
interface

Uses Classes, UnBematech, DbTables, SysUtils, ComCtrls,db, UnDaruma, forms,
     SQLExpr, Tabela;

type
  TRBLocalizaECF = class
    public
      procedure LocalizaECF(VpaTabela : TDataSet;VpaCodFilial,VpaSeqNota : Integer);overload;
      procedure LocalizaECF(VpaTabela : TDataSet; VpaCodFilial,VpaNroNota : Integer;VpfNumSerie : String);overload;
end;

Type
  TRBFuncoesECF = class(TRBLocalizaECF)
      Aux,
      Tabela : TSQLQuery;
      Cadastro : TSQL;
      VprErro : Integer;
      VprStatusBar : TStatusBar;
      procedure MostraMensagemErro(VpaOperacaoExecutada : String);
      procedure AtualizaBarraStatus(VpaTexto : String);
      function RSeqNotaDisponivel(VpaCodfilial : Integer) : Integer;
      function RNumLojaECF : Integer;
      function RNumCaixa : Integer;
      function RInformacaoECFnoArquivo: ansistring;
      function AbreCupom(VpaCodCliente : Integer) : Boolean;
      procedure ExtornaEstoqueUltimoCupom;
      procedure ExtornaEstoqueCupomCancelado(VpaCadNota,VpaMovNota : TDataSet);
      procedure ExtornaEstoqueFiscalCupomCancelado(VpaMovNota : TDataSet);
      function CupomAPartirdaCotacao(VpaCodFilial,VpaSeqNota : Integer):Boolean;
    public
      constructor cria(VpaStatusBar : TStatusBar;VpaBaseDados : TSQLConnection);
      destructor destroy;override;
      function ExisteCupomAberto : Boolean;
      function RNumECF : Integer;
      function RNumSerieECF : String;
      function RNumeroUltimoItemVendido : Integer;
      function RTextoVencimentos(VpaCodFilial,VpaSeqNota : Integer):TStringList;
      function RTextoVencimentoCotacao(VpaCodFilial,VpaLanOrcamento : Integer):TStringList;
      function RAliquotas : String;
      function RValComissao(VpaValTotal, VpaPerComissao, VpaPerComissaoPreposto : Double;VpaTipComissao, VpaCodVendedor : Integer;VpaProdutos : TDataSet):Double;
      procedure AnalisaBarraStatus;
      function CadastraECF(VpaTabela : TDataSet;VpaCodCliente,VpaCodCondicaoPagamento : Integer) : Boolean;
      function VendeItem(VpaCodProduto,VpaNomProduto,VpaUM : AnsiString;VpaQtdProduto, VpaValUnitario,VpaPerDesconto,VpaPerICMS : Double):String;
      procedure CancelaCupom(VpaCadNota, VpaMovNota : TDataSet;VpaExtornarEstoque : Boolean);
      procedure CancelaCupomAberto;
      procedure CancelaUltimoCupom;
      function CancelaItem(VpaCodFilial,VpaSeqNota,VpaSeqItem, VpaNumItemECF : Integer):Boolean;
      function IniciaFechamento(VpaValor : Double;VpaDescontoAcrescimo,VpaValorPercentual : String) : String;
      procedure FormaPagamentoCupom(VpaDesFormaPagamento, VpaDesCondicaoPagamento : String;VpaValor : Double);
      procedure FinalizaCupom(VpaTexto : TStringlist);
      procedure AdicionaAliquotaICMS(VpaAliquota : Double);
      procedure LeituraX;
      procedure ReducaoZ;
      procedure AbreGaveta;
end;


implementation

Uses FunSql, Constantes, UnClientes, FunString, ConstMsg, UnContasAReceber, UnProdutos;

{******************************************************************************}
procedure TRBLocalizaECF.LocalizaECF(VpaTabela : TDataSet;VpaCodFilial,VpaSeqNota : Integer);
Begin
  AdicionaSqlAbreTabela(VpaTabela,'Select * from CADNOTAFISCAIS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpacodFilial)+
                                  ' and I_SEQ_NOT = '+ IntToStr(VpaSeqNota));
end;

{******************************************************************************}
procedure TRBLocalizaECF.LocalizaECF(VpaTabela : TDataSet; VpaCodFilial,VpaNroNota : Integer;VpfNumSerie : String);
begin
  AdicionasqlAbretabela(VpaTabela,'Select * from CADNOTAFISCAIS '+
                                  ' Where I_EMP_FIL = '+IntToStr(VpacodFilial)+
                                  ' and I_NRO_NOT = '+ IntToStr(VpaNroNota));
  while not VpaTabela.eof and (VpaTabela.FieldByName('C_SER_NOT').AsString <> VpfNumSerie) do
    VpaTabela.Next;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  EVENTOS DA CLASSE DO ECF
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBFuncoesECF.cria(VpaStatusBar : TStatusBar;VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Aux := TSQLQUERY.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  VprStatusBar := VpaStatusBar;
end;

{******************************************************************************}
destructor TRBFuncoesECF.destroy;
begin
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesECF.RTextoVencimentos(VpaCodFilial,VpaSeqNota : Integer):TStringList;
var
  VpfLinha : String;
  VpfQtdParcelas : Integer;
begin
  VpfQtdParcelas := 0;
  VpfLinha := '';
  result := TStringList.Create;
  FunContasAReceber.LocalizaParcelasNotaFiscal(Tabela,VpaCodFilial,VpaSeqNota);
  while not Tabela.Eof do
  begin
    VpfLinha := VpfLinha +' '+FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_VEN').AsDateTime)+' '+FormatFloat('R$###,##0.00',Tabela.FieldByName('N_VLR_PAR').AsFloat);
    inc(VpfQtdParcelas);
    if VpfQtdParcelas >= 2 then
    begin
      result.add(DeletaCharE(VpfLinha,' '));
      VpfLinha := '';
      VpfQtdParcelas := 0;
    end;
    tabela.next;
  end;
  if VpfQtdParcelas > 0 then
    result.add(DeletaCharE(VpfLinha,' '));
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.RTextoVencimentoCotacao(VpaCodFilial,VpaLanOrcamento : Integer):TStringList;
var
  VpfLinha : String;
  VpfQtdParcelas : Integer;
begin
  VpfQtdParcelas := 0;
  VpfLinha := '';
  result := TStringList.Create;
  FunContasAReceber.LocalizaParcelasCotacao(Tabela,VpaCodFilial,VpaLanOrcamento);
  while not Tabela.Eof do
  begin
    VpfLinha := VpfLinha +' '+FormatDateTime('DD/MM/YY',Tabela.FieldByName('D_DAT_VEN').AsDateTime)+' '+FormatFloat('R$###,##0.00',Tabela.FieldByName('N_VLR_PAR').AsFloat);
    inc(VpfQtdParcelas);
    if VpfQtdParcelas >= 2 then
    begin
      result.add(DeletaCharE(VpfLinha,' '));
      VpfLinha := '';
      VpfQtdParcelas := 0;
    end;
    tabela.next;
  end;
  if VpfQtdParcelas > 0 then
    result.add(DeletaCharE(VpfLinha,' '));
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.RAliquotas : String;
begin
  result := AdicionaCharD(' ',result,79);
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_RetornoAliquotas(result);
//    ifDaruamFS600   : VprErro := Daruma_FI_RetornoAliquotas(result);
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.RValComissao(VpaValTotal, VpaPerComissao,VpaPerComissaoPreposto : Double;VpaTipComissao, VpaCodVendedor : Integer;VpaProdutos : TDataSet):Double;
var
  VpfPerComissaoVendedor, VpfPerComissaoProduto, VpfPerComissaoClassificacao : Double;
begin
  result := 0;
  if VpaTipComissao = 0 then // comissao direta
    result := (VpaValTotal * (VpaPerComissao - VpaPerComissaoPreposto))/100
  else
  begin
    VpaProdutos.First;
    while not VpaProdutos.Eof do
    begin
      FunProdutos.CarPerComissoesProduto(VpaProdutos.FieldByname('I_SEQ_PRO').AsInteger,VpaCodVendedor,VpfPerComissaoProduto,VpfPerComissaoClassificacao,VpfPerComissaoVendedor);
      if VpfPerComissaoProduto <> 0 then
        Result := result + ((VpaProdutos.FieldByname('N_TOT_PRO').AsFloat* (VpfPerComissaoProduto - VpaPerComissaoPreposto))/100)
      else
        if VpfPerComissaoVendedor <> 0 then
          Result := result + ((VpaProdutos.FieldByname('N_TOT_PRO').AsFloat* (VpfPerComissaoVendedor - VpaPerComissaoPreposto))/100)
        else
          Result := result + ((VpaProdutos.FieldByname('N_TOT_PRO').AsFloat* (VpfPerComissaoClassificacao - VpaPerComissaoPreposto))/100);

      VpaProdutos.Next;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AnalisaBarraStatus;
var
  VpfAck, VpfSt1,VpfSt2 : Integer;
  VpfSituacao : String;
begin
  exit;
  if VprStatusBar <> nil then
  begin
    VpfAck := 0;
    VpfSt1 := 0;
    VpfSt2 := 0;
    case varia.TipoECF of
      ifBematech_FI_2 : VprErro := Bematech_FI_VerificaEstadoImpressora(VpfAck,VpfSt1,VpfSt2);
//      ifDaruamFS600 : vprErro := Daruma_FI_RetornoImpressora(VpfAck,VpfSt1,VpfSt2);
    end;
   VpfSituacao := RInformacaoECFnoArquivo;
    case VpfSt1 of
      0   : VprStatusBar.Panels[0].Text := 'ST1=OK';
      1   : VprStatusBar.Panels[0].Text := 'ST1=Nro de Parâmetros inválidos';
      2   : VprStatusBar.Panels[0].Text := 'ST1=Cupom Aberto';
      4   : VprStatusBar.Panels[0].Text := 'ST1=Comando Inexistente';
      8   : VprStatusBar.Panels[0].Text := 'ST1=CMD não iniciado com ESC';
      16  : VprStatusBar.Panels[0].Text := 'ST1=Impressora em ERRO';
      32  : VprStatusBar.Panels[0].Text := 'ST1=Erro no relógio';
      64  : VprStatusBar.Panels[0].Text := 'ST1=Pouco papel';
      128 : VprStatusBar.Panels[0].Text := 'ST1=Fim de papel';
    end;

    case VpfSt2 of
      0   : VprStatusBar.Panels[1].Text := 'ST2=OK';
      1   : VprStatusBar.Panels[1].Text := 'ST2=Comando não executado';
      2   : VprStatusBar.Panels[1].Text := 'ST2=CGC/IE não programados';
      4   : VprStatusBar.Panels[1].Text := 'ST2=Cancelamento não permitido';
      8   : VprStatusBar.Panels[1].Text := 'ST2=Aliquotas Lotadas';
      16  : VprStatusBar.Panels[1].Text := 'ST2=Aliquota não programada';
      32  : VprStatusBar.Panels[1].Text := 'ST2=CMOS não Volatil';
      64  : VprStatusBar.Panels[1].Text := 'ST2=Memória Fiscal lotada';
      128 : VprStatusBar.Panels[1].Text := 'ST2=Tipo de parâmetro inválido';
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.RSeqNotaDisponivel(VpaCodfilial : Integer) : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select max(I_SEQ_NOT) ULTIMO from CADNOTAFISCAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.RNumECF : Integer;
var
  VpfNumero : AnsiString;
Begin
  VpfNumero := AdicionaCharD(' ','',6);
  case varia.TipoECF of
    ifBematech_FI_2 :
      begin
        VprErro := Bematech_FI_NumeroCupom(VpfNumero);
        if (DeletaChars(VpfNumero,' ') = '') and (VprErro = 1) then
          VpfNumero := RInformacaoECFnoArquivo;
      end;
//    ifDaruamFS600   : VprErro := Daruma_FI_NumeroCupom(vpfNumero);
  end;
  VpfNumero := DeletaCharD(VpfNumero,' ');
  result := StrtoInt(VpfNumero);
  MostraMensagemErro('CAPTURA DO NUMERO DO ECF!!!');
end;

{******************************************************************************}
function TRBFuncoesECF.RNumSerieECF : String;
var
  VpfNumSerie : AnsiString;
begin
  result := AdicionaCharD(' ','',15);
  case varia.TipoECF of
    ifBematech_FI_2 :
      begin
        VpfNumSerie := AdicionaCharD(' ','',15);
        VprErro := Bematech_FI_NumeroSerie(VpfNumSerie);
        Result := VpfNumSerie;
        if (DeletaChars(result,' ') = '') and (VprErro = 1) then
          result := RInformacaoECFnoArquivo;
      end;
//    ifDaruamFS600   : VprErro := Daruma_FI_NumeroSerie(result);
  end;
  MostraMensagemErro('CAPTURA DO NUMERO DE SERIE!!!');
  result := DeletaEspacoD(result);
end;

{******************************************************************************}
function TRBFuncoesECF.RNumeroUltimoItemVendido : Integer;
var
  VpfUltimoItem : AnsiString;
  iACK, iST1, iST2: Integer;
begin
  vpfUltimoItem := AdicionaCharD(' ','',4);
  AtualizaBarraStatus('Recuperando o número do último item vendido.');
  case varia.TipoECF of
    ifBematech_FI_2 :
      begin
        VprErro := Bematech_FI_UltimoItemVendido(VpfUltimoItem);
        if (DeletaChars(VpfUltimoItem,' ') = '') and (VprErro = 1) then
        begin
          VpfUltimoItem := AdicionaCharD(' ','',4);
          Bematech_FI_RetornoImpressora(iACK, iST1, iST2 );
          Bematech_FI_LeArquivoRetorno(VpfUltimoItem);
        end;
      end;

//    ifDaruamFS600   : VprErro := Daruma_FI_UltimoItemVendido(VpfUltimoItem);
  end;
  try
    result := StrToInt(VpfUltimoItem);
  except
    result :=0;
  end;
  AtualizaBarraStatus('último item vendido recuperado.');
  MostraMensagemErro('RECUPERANDO O NUMERO DO ULTIMO ITEM VENDIDO!!!');
end;

{******************************************************************************}
function TRBFuncoesECF.RNumLojaECF : Integer;
var
  VpfNumero : String;
begin
  VpfNumero := adicionacharD(' ','',4);
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_NumeroSerie(VpfNumero);
//    ifDaruamFS600   : VprErro := Daruma_FI_NumeroSerie(VpfNumero);
  end;
  result := StrToInt(VpfNumero);
  MostraMensagemErro('CAPTURA DO NUMERO DA LOJA!!!');
end;

{******************************************************************************}
function TRBFuncoesECF.RNumCaixa : Integer;
var
  VpfNumero : String;
begin
  VpfNumero := AdicionaCharD(' ','',4);
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro :=  Bematech_FI_NumeroCaixa(VpfNumero);
//    ifDaruamFS600   : VprErro := Daruma_FI_NumeroCaixa(VpfNumero);
  end;
  result := StrToInt(VpfNumero);
  MostraMensagemErro('CAPTURA DO NUMERO DO CAIXA!!!');
end;

{******************************************************************************}
function TRBFuncoesECF.RInformacaoECFnoArquivo: ansistring;
var
  iACK, iST1, iST2: Integer;
begin
  result := AdicionaCharD(' ','',20);
  Bematech_FI_LeArquivoRetorno(Result);
  DeletaCharD(result,' ');
end;

{******************************************************************************}
procedure TRBFuncoesECF.MostraMensagemErro(VpaOperacaoExecutada : String);
Var
  VpfErro : String;
begin
  if VprErro <> 1 then
  begin
    case VprErro of
      0  : VpfErro := 'ERRO DE COMUNICAÇÃO!!!';
     -2  : VpfErro := 'PARÂMETRO INVÁLIDO!!!';
     -3  : VpfErro := 'ALÍQUOTA NÃO PROGRAMADA!!!';
     -4  : VpfErro := 'O ARQUIVO DE INICIALIZACAO BEMAFI32.INI NÃO FOI ENCONTRADO NO DIRETORIO DE SISTEMA DO WINDOWS!!!';
     -5  : VpfErro := 'ERRO AO ABRIR A PORTA DE COMUNICAÇÃO!!!';
     -8  : VpfErro := 'ERRO AO CRIAR OU GRAVAR NO ARQUIVO STATUS.TXT OU RETORNO.TXT!!!';
     -27 : VpfErro := 'STATUS DA IMPRESSORA DIFERENTE DE 6,0,0 (ACK, ST1 e ST2)!!!';
    else
      VpfErro := 'ERRO NÃO DOCUMENTADO"'+IntToStr(VprErro)+'"!!!';
    end;
    VpfErro := 'OCORREU O SEGUINTE ERRO AO TENTAR UTILIZAR A IMPRESSORA FISCAL:'#13+'OPERAÇÃO EXECUTADA : '+VpaOperacaoExecutada+#13+'ERRO : '+IntToStr(VprErro)+' - '+ VpfErro;
    erro(VpfErro);
  end;
  AnalisaBarraStatus;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AtualizaBarraStatus(VpaTexto : String);
begin
  if VprStatusBar <> nil then
  begin
    VprStatusBar.Panels[2].Text := VpaTexto;
    VprStatusBar.Refresh;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.ExisteCupomAberto : Boolean;
var
  VpfAck, VpfSt1,VpfSt2 : Integer;
  VpfInformacao : String;
begin
  VpfAck := 0;
  VpfSt1 := 0;
  VpfSt2 := 0;
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_VerificaEstadoImpressora(VpfAck,VpfSt1,VpfSt2);
//    ifDaruamFS600   : VprErro := Daruma_FI_VerificaEstadoImpressora(VpfAck,VpfSt1,VpfSt2);
  end;
  if (VpfAck = 0) and (VpfSt1 = 0) and (VpfSt2 = 0) then
  begin
    VpfInformacao := AdicionaCharD(' ',VpfInformacao,2);
    Bematech_FI_LeArquivoRetorno(VpfInformacao);
    result := VpfInformacao = '33'
  end
  else
    result := VpfSt1 = 2;
  MostraMensagemErro('VERIFICANDO SE EXISTE CUPOM ABERTO!!!');
end;

{******************************************************************************}
function TRBFuncoesECF.AbreCupom(VpaCodCliente : Integer) : Boolean;
begin
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_AbreCupom( FunClientes.RCGCCPFCliente(VpaCodCliente));
//    ifDaruamFS600   : VprErro := Daruma_FI_AbreCupom(FunClientes.RCGCCPFCliente(VpaCodCliente));
  end;
  MostraMensagemErro('ABERTURA DE CUPOM!!!');
  Result := VprErro = 1;
end;

{******************************************************************************}
procedure TRBFuncoesECF.ExtornaEstoqueUltimoCupom;
var
  VpfNumNota : Integer;
  VpfSerNota : String;
begin
  VpfNumNota := RNumECF-1;
  VpfSerNota := RNumSerieECF;
  AdicionaSQLAbreTabela(Cadastro,'Select * from CADNOTAFISCAIS '+
                               ' Where I_NRO_NOT = '+IntToStr(VpfNumNota));
  while not Cadastro.eof and (Cadastro.FieldByName('C_SER_NOT').AsString <> VpfSerNota) do
    Cadastro.Next;

  if not Cadastro.eof then
  begin
    if Cadastro.FieldByName('C_NOT_CAN').AsString = 'S' then
      aviso('CUPOM JÁ SE ENCONTRA CANCELADO!!!'#13'O último cupom já se encontra cancelado.')
    else
      if Cadastro.FieldByName('I_EMP_FIL').AsInteger <> varia.CodigoEmpFil then
        aviso('FILIAL INVÁLIDA!!!'#13'Não foi possivel cancelar o cupom, pois o mesmo não foi gerado na filial ativa.')
      else
      begin
        AdicionaSQLAbreTabela(Tabela,'Select * from MOVNOTASFISCAIS '+
                                         ' Where I_EMP_FIL = '+ Cadastro.FieldByName('I_EMP_FIL').AsString+
                                         ' and I_SEQ_NOT = '+Cadastro.FieldByName('I_SEQ_NOT').AsString);
        if not CupomAPartirdaCotacao(Cadastro.FieldByName('I_EMP_FIL').AsInteger,Cadastro.FieldByName('I_SEQ_NOT').AsInteger) then
          ExtornaEstoqueCupomCancelado(Cadastro,Tabela);

        ExtornaEstoqueFiscalCupomCancelado(Tabela);

        Cadastro.Edit;
        Cadastro.FieldByName('C_NOT_CAN').AsString := 'S';
        Cadastro.post;
        Tabela.Close;
      end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesECF.ExtornaEstoqueCupomCancelado(VpaCadNota,VpaMovNota : TDataSet);
var
  VpfSeqEstoqueBarra : Integer;
begin
  VpaMovNota.First;
  while not VpaMovNota.Eof do
  begin
    FunProdutos.BaixaProdutoEstoque(VpaCadNota.FieldByname('I_EMP_FIL').AsInteger, VpaMovNota.FieldByName('I_SEQ_PRO').AsInteger,Varia.OperacaoEstoqueEstornoEntrada,VpaCadNota.FieldByName('I_SEQ_NOT').AsInteger,
                                  VpaCadNota.FieldByName('I_NRO_NOT').AsInteger,0,varia.MoedaBase,0,0,date,VpaMovNota.FieldByName('N_QTD_PRO').AsFloat,VpaMovNota.FieldByName('N_TOT_PRO').AsFloat,
                                  VpaMovNota.FieldByName('C_COD_UNI').AsString,FunProdutos.UnidadePadrao(VpaMovNota.FieldByName('I_SEQ_PRO').AsInteger),VpaMovNota.FieldByName('C_PRO_REF').AsString,false,VpfSeqEstoqueBarra,true);

    VpaMovNota.Next;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.ExtornaEstoqueFiscalCupomCancelado(VpaMovNota : TDataSet);
begin
  VpaMovNota.First;
  while not VpaMovNota.Eof do
  begin
    FunProdutos.BaixaEstoqueFiscal(Varia.CodigoEmpfil, VpaMovNota.FieldByName('I_SEQ_PRO').AsInteger,0,0,VpaMovNota.FieldByName('N_QTD_PRO').AsFloat,
                                  VpaMovNota.FieldByName('C_COD_UNI').AsString,FunProdutos.UnidadePadrao(VpaMovNota.FieldByName('I_SEQ_PRO').AsInteger),'E');

    VpaMovNota.Next;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.CupomAPartirdaCotacao(VpaCodFilial,VpaSeqNota : Integer):Boolean;
begin
  AdicionaSqlAbreTabela(Aux,'Select * from MOVNOTAORCAMENTO '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' and I_SEQ_NOT = '+IntToStr(VpaSeqNota));
  result := not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesECF.CadastraECF(VpaTabela : TDataSet; VpaCodCliente,VpaCodCondicaoPagamento : Integer):Boolean;
begin
  AtualizaBarraStatus('Verificando se já existe cupom aberto.');
  if ExisteCupomAberto then
  begin
    AtualizaBarraStatus('Localizando o cupom fiscal no BD.');
    LocalizaECF(VpaTabela,Varia.CodigoEmpFil,RNumECF,RNumSerieECF);
    if VpaTabela.Eof then
    begin
      CancelaCupomAberto;
      result := true;
    end
    else
    begin
      AtualizaBarraStatus('Editando a tabela do cupom fical.');
      VpaTabela.Edit;
      AtualizaBarraStatus('Cupom fiscal aberto com sucesso.');
      result := true;
    end;
  end
  else
  begin
    AtualizaBarraStatus('Abrindo Cupom Fiscal.');
    if AbreCupom(VpaCodCliente) then
    begin
      AtualizaBarraStatus('Localizando o cupom fiscal no BD');
      LocalizaECF(VpaTabela,0,0);
      AtualizaBarraStatus('Inserindo registro na tabela do cupom fiscal');
      VpaTabela.Insert;
      VpaTabela.FieldByName('I_EMP_FIL').AsInteger := Varia.CodigoEmpfil;
      AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal recuperando o seq nota');
      VpaTabela.FieldByName('I_SEQ_NOT').AsInteger := RSeqNotaDisponivel(Varia.CodigoEmpfil);
      AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal recuperando numero do ecf');
      VpaTabela.FieldByName('I_NRO_NOT').AsInteger := RNumECF;
      AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal recuperando o numero de serie');
      VpaTabela.FieldByName('C_SER_NOT').AsString := RNumSerieECF;
      AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal carregando demais dados');
      VpaTabela.FieldByName('I_COD_CLI').AsInteger := VpaCodCliente;
      VpaTabela.FieldByName('I_COD_PAG').AsInteger := VpaCodCondicaoPagamento;
      VpaTabela.FieldByName('D_DAT_EMI').AsDatetime := Date;
      VpaTabela.FieldByName('D_DAT_SAI').AsDateTime := VpaTabela.FieldByName('D_DAT_EMI').AsDatetime;
      VpaTabela.FieldByName('T_HOR_SAI').AsDateTime := now;
    //  VpaTabela.FieldByName('I_NRO_LOJ').AsInteger := RNumLojaECF;
    //  VpaTabela.FieldByName('I_NRO_CAI').AsInteger := RNumCaixa;
      VpaTabela.FieldByName('C_FLA_ECF').AsString := 'S';
      VpaTabela.FieldByName('C_NOT_IMP').AsString := 'N';
      VpaTabela.FieldByName('C_NOT_CAN').AsString := 'N';
      VpaTabela.FieldByName('C_NOT_DEV').AsString := 'N';
      VpaTabela.FieldByName('D_ULT_ALT').AsDatetime := Date;
      VpaTabela.FieldByName('C_FIN_GER').AsString := 'S';
      VpaTabela.FieldByName('I_COD_USU').AsInteger := varia.CodigoUsuario;
      AtualizaBarraStatus('Gravando o registro na tabela do cupom fiscal');
      VpaTabela.Post;
      AtualizaBarraStatus('Editando a tabela do cupom fical.');
      Vpatabela.Edit;
      AtualizaBarraStatus('Cupom fiscal aberto com sucesso.');
      result := true;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.VendeItem(VpaCodProduto,VpaNomProduto, VpaUM : AnsiString;VpaQtdProduto, VpaValUnitario, VpaPerDesconto, VpaPerICMS : Double):String;
Var
  VpfPerAliquota,VpfTipDesconto : AnsiString;
  VpfQtdTentativas : Integer;
begin
  result := '';
  VpfTipDesconto := '%';
  if VpaPerICMS > 0 then
    VpfPerAliquota := DeletaChars(FormatFloat('00.00',VpaPerICMS),',')
  else
    VpfPerAliquota := 'FF';

  AtualizaBarraStatus('Adicionando UM do Item da Venda');
{  case varia.TipoECF of
    ifBematech_FI_2 : begin
                        VprErro := Bematech_FI_UsaUnidadeMedida(PChar(VpaUM));
                      end;
  end;}
  VprErro := 1;
  if VprErro = 1 then
  begin
    AtualizaBarraStatus('Adicionando Item da Venda');

//    for VpfQtdTentativas := 0 to 5 do
    begin
      case varia.TipoECF of
        ifBematech_FI_2 : VprErro := Bematech_FI_VendeItem(VpaCodProduto,copy(VpaNomProduto,1,29),VpfPerAliquota,'F',FormatFloat('0.000',VpaQtdProduto),
                                     2,FormatFloat('0.00',VpaValUnitario),VpfTipDesconto,DeletaChars(FormatFloat('00.00',VpaPerDesconto),','));
  //      ifDaruamFS600   : VprErro := Daruma_FI_VendeItem(VpaCodProduto,copy(VpaNomProduto,1,29),VpfPerAliquota,'F',PChar(FormatFloat('0.000',VpaQtdProduto)),
  //                                   2,PChar(FormatFloat('0.00',VpaValUnitario)),PChar(VpfTipDesconto),PChar(DeletaChars(FormatFloat('00.00',VpaPerDesconto),',')));
      end;

//      if RNumeroUltimoItemVendido <> 0 then
//        break;
    end;
    MostraMensagemErro('Adicionando item de venda');
    if VprErro = 1 then
      AtualizaBarraStatus('Item de venda adicionado');
  end
  else
    MostramensagemErro('Adicionando UM do Item de Venda');
end;

{******************************************************************************}
procedure TRBFuncoesECF.CancelaCupom(VpaCadNota, VpaMovNota : TDataSet;VpaExtornarEstoque : Boolean);
begin
  if not(VpaCadNota.State = dsedit) then
    VpaCadNota.Edit;
  VpaCadNota.FieldByName('C_NOT_CAN').AsString := 'S';
  VpaCadNota.Post;
  if VpaExtornarEstoque then
    ExtornaEstoqueCupomCancelado(VpaCadNota,VpaMovNota);
  ExtornaEstoqueFiscalCupomCancelado(VpaMovNota);
  CancelaCupomAberto;
end;

{******************************************************************************}
procedure TRBFuncoesECF.CancelaCupomAberto;
begin
  AtualizaBarraStatus('Cancelando Cupom fiscal');
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_CancelaCupom;
//    ifDaruamFS600   : VprErro := Daruma_FI_CancelaCupom;
  end;
  MostraMensagemErro('CANCELANDO O CUPOM FISCAL!!!');
  if VprErro = 1 then
    AtualizaBarraStatus('Cupom Fiscal cancelado com sucesso');
    
end;

{******************************************************************************}
procedure TRBFuncoesECF.CancelaUltimoCupom;
begin
  if confirmacao('Tem certeza que deseja cancelar o último cupom ?') then
  begin
    case varia.TipoECF of
      ifBematech_FI_2 : VprErro := Bematech_FI_CancelaCupom;
//      ifDaruamFS600   : VprErro := Daruma_FI_CancelaCupom;
    end;
  end;
  if VprErro = 1 then //cancelamento efetuado com sucesso
  begin
    ExtornaEstoqueUltimoCupom;
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.CancelaItem(VpaCodFilial,VpaSeqNota,VpaSeqItem, VpaNumItemECF : Integer):Boolean;
begin
  result := false;
  AtualizaBarraStatus('Cancelando Item do Cupom fiscal');
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_CancelaItemGenerico(pchar(IntToStr(VpaNumItemECF)));
//    ifDaruamFS600   : VprErro := Daruma_FI_CancelaItemGenerico(pchar(IntToStr(VpaNumItemECF)));
  end;
  MostraMensagemErro('CANCELANDO ITEM DO CUPOM FISCAL!!!');
  if VprErro = 1 then
  begin
    AtualizaBarraStatus('Inicio fechamento efetuado com sucesso');
    result := true;
    ExecutaComandoSql(Aux,'Delete from MOVNOTASFISCAIS '+
                          ' Where I_EMP_FIL = '+IntTostr(VpaCodFilial)+
                          ' and I_SEQ_NOT = ' + IntToStr(VpaSeqNota)+
                          ' and I_SEQ_MOV = '+ IntToStr(VpaSeqItem));
  end;
end;

{******************************************************************************}
function TRBFuncoesECF.IniciaFechamento(VpaValor : Double;VpaDescontoAcrescimo,VpaValorPercentual : String) : String;
var
  VpfValor : String;
begin
  result := '';
  VpfValor := DeletaChars(FormatFloat('0.00',VpaValor),',');
  AtualizaBarraStatus('Iniciando fechamento do Cupom fiscal');
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_IniciaFechamentoCupom(pchar(VpaDescontoAcrescimo),PChar(VpaValorPercentual),PChar(VpfValor));
//    ifDaruamFS600   : VprErro := Daruma_FI_IniciaFechamentoCupom(pchar(VpaDescontoAcrescimo),PChar(VpaValorPercentual),PChar(VpfValor));
  end;
  MostraMensagemErro('INICIANDO FECHAMENTO DO CUPOM FISCAL!!!');
  if VprErro = 1 then
    AtualizaBarraStatus('Inicio fechamento efetuado com sucesso');
end;

{******************************************************************************}
procedure TRBFuncoesECF.FormaPagamentoCupom(VpaDesFormaPagamento, VpaDesCondicaoPagamento : String;VpaValor : Double);
var
  VpfValor : String;
begin
  VpaDesCondicaoPagamento := 'Cond. Pagamento : '+VpaDesCondicaoPagamento;
  VpfValor := DeletaChars(FormatFloat('0.00',VpaValor),',');
  AtualizaBarraStatus('Forma pagamento do Cupom fiscal');
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_EfetuaFormaPagamentoDescricaoForma(pchar(Copy(VpaDesFormaPagamento,1,16)),PChar(VpfValor),PChar(VpaDesCondicaoPagamento));
//    ifDaruamFS600   : VprErro := Daruma_FI_EfetuaFormaPagamentoDescricaoForma(pchar(Copy(VpaDesFormaPagamento,1,16)),PChar(VpfValor),PChar(VpaDesCondicaoPagamento));
  end;
  MostraMensagemErro('FORMA PAGAMENTO DO CUPOM FISCAL!!!');
  if VprErro = 1 then
    AtualizaBarraStatus('Forma pagamento do cupom efetuado com sucesso');
end;

{******************************************************************************}
procedure TRBFuncoesECF.FinalizaCupom(VpaTexto : TStringlist);
begin
  AtualizaBarraStatus('Finalizando fechamento do Cupom fiscal');
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_TerminaFechamentoCupom(pchar(VpaTexto.Text));
//    ifDaruamFS600   : VprErro := Daruma_FI_TerminaFechamentoCupom(pchar(VpaTexto.Text));
  end;
  MostraMensagemErro('FINALIZANDO FECHAMENTO DO CUPOM FISCAL!!!');
  if VprErro = 1 then
    AtualizaBarraStatus('Fechamento efetuado com sucesso');
end;

{******************************************************************************}
procedure TRBFuncoesECF.AdicionaAliquotaICMS(VpaAliquota : Double);
begin
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_ProgramaAliquota(pchar(DeletaChars(FormatFloat('00.00',VpaAliquota),',')),0);
//    ifDaruamFS600   : VprErro := Daruma_FI_ProgramaAliquota(pchar(DeletaChars(FormatFloat('00.00',VpaAliquota),',')),0);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.LeituraX;
begin
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_LeituraX;
//    ifDaruamFS600   : VprErro := Daruma_FI_LeituraX;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.ReducaoZ;
begin
  if confirmacao('Tem certeza que deseja efetuar a Redução Z ?') then
  begin
    case varia.TipoECF of
      ifBematech_FI_2 : VprErro := Bematech_FI_ReducaoZ('','');
//      ifDaruamFS600   : VprErro := Daruma_FI_ReducaoZ('','');
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesECF.AbreGaveta;
begin
  case varia.TipoECF of
    ifBematech_FI_2 : VprErro := Bematech_FI_AcionaGaveta;
//    ifDaruamFS600   : VprErro := Daruma_FI_AcionaGaveta;
  end;
end;

end.
