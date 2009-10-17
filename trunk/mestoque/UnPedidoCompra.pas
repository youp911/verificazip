unit UnPedidoCompra;
{Verificado
-.edit;
-post;
}
interface
uses
  UnDados, UnClientes, UnSolicitacaoCompra,IdMessage, IdSMTP,
  Classes, SysUtils, Forms, DbTables, Db, unSistema, UnContasAreceber,
  UnDadosProduto, UnNOtaFiscal, idText,IdAttachmentfile,SQLExpr,tabela;

type
  TRBFunPedidoCompra = class
    private
      Aux,
      Tabela : TSQlQuery;
      Cadastro: TSQL;
      FunOrcamentoCompra: TRBFunSolicitacaoCompra;
      VprMensagem: TidMessage;
      VprSMTP: TIdSMTP;
      function RSeqPedidoDisponivel(VpaCodFilial: Integer): Integer;
      function RSeqEstagioDisponivel(VpaCodFilial, VpaSeqPedido: Integer): Integer;
      function RSeqPedidoCompraNotafiscalItem(VpaCodFilial,VpaSeqPedido,SeqNota : Integer) : Integer;
      function RSeqPendenciaCompraDisponivel(VpaCodFilial, VpaSeqPedido : Integer):integer;
      function RRodapePedidoCompra(VpaCodFilial : Integer):String;
      function RTextoAcrescismoDesconto(VpaDPedidoCompra : TRBDPedidoCompraCorpo):string;
      function RValorAcrescimoDesconto(VpaDPedidoCompra : TRBDPedidoCompraCorpo):string;
      procedure ApagaProdutos(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
      procedure ApagaFracaoOP(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
      procedure ApagaEstagio(VpaDPedidoCompra : TRBDPedidoCompraCorpo);
      function GravaDProdutos(VpaDPedidoCompra: TRBDPedidoCompraCorpo): String;
      function GravaDFracaoOP(VpaDPedidoCompra: TRBDPedidoCompraCorpo): String;
      procedure CarDProdutoPedidoCompra(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
      procedure CarDFracaoOPPedidoCompra(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
      function GravaLogEstagio(VpaCodFilial, VpaSeqPedido, VpaCodEstagio: Integer; VpaDesMotivo: String): String;
      procedure MontaCabecalhoEmail(VpaTexto : TStrings; VpaDPedidoCompra : TRBDPedidoCompraCorpo;VpaDFilial : TRBDFilial);
      procedure MontaEmailPedidoCompra(VpaTexto : TStrings; VpaDPedidoCompra : TRBDPedidoCompraCorpo;VpaDCliente : TRBDCliente; VpaDComprador : TRBDComprador; VpaDFilial : TRBDFilial);
      function EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDComprador : TRBDComprador) : string;
      procedure AtualizarQtdeProdutoPedido(VpaDNotaItem: TRBDNotaFiscalForItem; VpaDPedidoCompraCorpo: TRBDPedidoCompraCorpo);
      function GravaDVinculoNotaFiscalItem(VpaCodFilial, VpaSeqNota, VpaSeqPedido,VpaSeqProduto, VpaCodCor: Integer; VpaQuantidade: Double): String;
      function GeraPendenciaCompra(VpaDPedidoCompra : TRBDPedidoCompraCorpo):string;
    public
      constructor Cria(VpaBaseDados : TSQLConnection );
      destructor Destroy; override;
      procedure CalculaValorTotal(VpaDPedidoCorpo: TRBDPedidoCompraCorpo);
      function ExisteFracaoOP(VpaCodFilial, VpaOP,VpaFracao: Integer): Boolean;
      function ExisteOP(VpaCodFilial, VpaOP: Integer): Boolean;
      function ExisteClienteFracaoOP(VpaDFracaoOPPedido: TRBDFracaoOPPedidoCompra): Boolean;
      procedure ApagaPedido(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
      function EnviaEmailFornecedor(VpaDPedidoCompra : TRBDPedidoCompraCorpo) : String;
      function GravaDPedidoCompra(VpaDPedidoCompra: TRBDPedidoCompraCorpo): String;
      procedure CarDPedidoCompra(VpaCodFilial, VpaSeqPedido: Integer; VpaDPedidoCompra: TRBDPedidoCompraCorpo);
      function AprovarPedido(VpaCodFilial, VpaSeqPedido : Integer): String;
      function BaixarPagamentoAntecipado(VpaCodFilial, VpaSeqPedido: Integer): String;
      function ConcluiPedidoCompra(VpaCodFilial, VpaSeqPedido: Integer): String;
      function ConcluiPendenciaCompras(VpaCodFilial,VpaSeqPedido,VpaSeqPendencia : Integer):string;
      function AlteraEstagioPedidoCompra(VpaCodFilial, VpaSeqPedido, VpaCodEstagio: Integer; VpaDesMotivo: String):String;
      function ExtornaPedidoCompra(VpaCodFilial, VpaSeqPedido: Integer): String;
      function VerificaProdutoNaoRecebido(VpaCodFilial, VpaSeqPedido, VpaSeqProduto, VpaCodCor: Integer; var VpaQuantidadeSobra: Double): String;
      function AjustarQuantidadesProdutoPedidoCompra(VpaCodFilial, VpaSeqPedido, VpaSeqItem: Integer; VpaDProdutoPendente: TRBDProdutoPendenteCompra): String;
      procedure BaixarQtdeProdutoPedido(VpaDNota: TRBDNotaFiscalFor; VpaListaPedidos: TList);
      function ProdutosEmAberto(VpaDPedidoCompraCorpo: TRBDPedidoCompraCorpo): Boolean;
      function GravaVinculoNotaFiscal(VpaDNota: TRBDNotaFiscalFor; VpaListaPedidos: TList): STring;
      procedure ConsultaNotasFiscais(VpaSeqPedido: Integer);
      procedure AdicionaTodosProdutosFornecedor(VpaCodFornecedor : Integer;VpaDPedidoCompra : TRBDPedidoCompraCorpo);
end;

implementation
uses
  Constantes, FunSQL, FunData, UnProdutos, FunObjeto, ANovaNotaFiscaisFor, ConstMsg, FunString;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                TRBFunPedidoCompra
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBFunPedidoCompra.Cria(VpaBaseDados : TSQLConnection );
begin
  inherited Create;
  FunOrcamentoCompra:= TRBFunSolicitacaoCompra.Cria(VpaBaseDados);
  Tabela := TSQLQuery.Create(NIL);
  Tabela.SQLConnection := VpaBaseDados;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Cadastro := TSQL.Create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  VprMensagem := TIdMessage.Create(nil);
  VprSMTP := TIdSMTP.Create(nil);
end;

{******************************************************************************}
destructor TRBFunPedidoCompra.Destroy;
begin
  Aux.Free;
  Tabela.Free;
  Cadastro.Free;
  FunOrcamentoCompra.Free;
  VprMensagem.free;
  VprSMTP.free;
  inherited Destroy;
end;

{******************************************************************************}
function TRBFunPedidoCompra.ExisteFracaoOP(VpaCodFilial, VpaOP, VpaFracao: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT CODFILIAL FROM FRACAOOP '+
                            ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' AND SEQORDEM = '+IntToStr(VpaOP)+
                            ' AND SEQFRACAO = '+IntToStr(VpaFracao));
  Result:= not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.ExisteOP(VpaCodFilial, VpaOP: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT EMPFIL FROM ORDEMPRODUCAOCORPO '+
                            ' WHERE EMPFIL = '+IntToStr(VpaCodFilial)+
                            ' AND SEQORD = '+IntToStr(VpaOP));
  Result:= not Aux.Eof;
  Aux.Close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.ExisteClienteFracaoOP(VpaDFracaoOPPedido: TRBDFracaoOPPedidoCompra): Boolean;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT CLI.C_NOM_CLI'+
                               ' FROM ORDEMPRODUCAOCORPO OPC, CADCLIENTES CLI'+
                               ' WHERE OPC.CODCLI = CLI.I_COD_CLI'+
                               ' AND OPC.EMPFIL = '+IntToStr(VpaDFracaoOPPedido.CodFilialFracao)+
                               ' AND OPC.SEQORD = '+IntToStr(VpaDFracaoOPPedido.SeqOrdem));
  VpaDFracaoOPPedido.NomCliente:= Tabela.FieldByName('C_NOM_CLI').AsString;
  Result:= (VpaDFracaoOPPedido.NomCliente <> '');
  Tabela.Close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.GravaDPedidoCompra(VpaDPedidoCompra: TRBDPedidoCompraCorpo): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PEDIDOCOMPRACORPO '+
                                ' Where CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                                ' AND SEQPEDIDO = '+IntToStr(VpaDPedidoCompra.SeqPedido));

  if Cadastro.Eof then
    Cadastro.Insert
  else
    Cadastro.Edit;

  Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDPedidoCompra.CodFilial;
  Cadastro.FieldByName('CODFILIALFATURAMENTO').AsInteger:= VpaDPedidoCompra.CodFilialFaturamento;
  Cadastro.FieldByName('DESSITUACAO').AsString:= VpaDPedidoCompra.DesSituacao;
  Cadastro.FieldByName('INDCANCELADO').AsString:= VpaDPedidoCompra.IndCancelado;
  Cadastro.FieldByName('DATPEDIDO').AsDateTime:= VpaDPedidoCompra.DatPedido;
  Cadastro.FieldByName('HORPEDIDO').AsDateTime:= VpaDPedidoCompra.HorPedido;
  Cadastro.FieldByName('CODCLIENTE').AsInteger:= VpaDPedidoCompra.CodCliente;
  Cadastro.FieldByName('CODUSUARIO').AsInteger:= VpaDPedidoCompra.CodUsuario;
  if VpaDPedidoCompra.CodTransportadora <> 0 then
    Cadastro.FieldByName('CODTRANSPORTADORA').AsInteger:= VpaDPedidoCompra.CodTransportadora
  else
    Cadastro.FieldByName('CODTRANSPORTADORA').Clear;
  Cadastro.FieldByName('TIPFRETE').AsInteger:= VpaDPedidoCompra.TipFrete;

  if VpaDPedidoCompra.DatPrevista > MontaData(1,1,1900) then
    Cadastro.FieldByName('DATPREVISTA').AsDateTime:= VpaDPedidoCompra.DatPrevista
  else
    Cadastro.FieldByName('DATPREVISTA').Clear;
  if VpaDPedidoCompra.DatRenegociado > MontaData(1,1,1900) then
    Cadastro.FieldByName('DATRENEGOCIADO').AsDateTime:= VpaDPedidoCompra.DatRenegociado
  else
    Cadastro.FieldByName('DATRENEGOCIADO').Clear;
  if VpaDPedidoCompra.DatEntrega > MontaData(1,1,1900) then
    Cadastro.FieldByName('DATENTREGA').AsDateTime:= VpaDPedidoCompra.DatEntrega
  else
    Cadastro.FieldByName('DATENTREGA').Clear;
  Cadastro.FieldByName('NUMDIASATRASO').AsInteger:= VpaDPedidoCompra.NumDiasAtraso;
  Cadastro.FieldByName('NOMCONTATO').AsString:= VpaDPedidoCompra.NomContato;
  Cadastro.FieldByName('DESEMAILCOMPRADOR').AsString:= VpaDPedidoCompra.DesEmailComprador;
  if VpaDPedidoCompra.CodCondicaoPagto <> 0 then
    Cadastro.FieldByName('CODCONDICAOPAGAMENTO').AsInteger:= VpaDPedidoCompra.CodCondicaoPagto
  else
    Cadastro.FieldByName('CODCONDICAOPAGAMENTO').Clear;
  if VpaDPedidoCompra.CodFormaPagto <> 0 then
    Cadastro.FieldByName('CODFORMAPAGAMENTO').AsInteger:= VpaDPedidoCompra.CodFormaPagto
  else
    Cadastro.FieldByName('CODFORMAPAGAMENTO').Clear;
  Cadastro.FieldByName('CODESTAGIO').AsInteger:= VpaDPedidoCompra.CodEstagio;
  Cadastro.FieldByName('CODCOMPRADOR').AsInteger:= VpaDPedidoCompra.CodComprador;
  Cadastro.FieldByName('VALTOTAL').AsFloat:= VpaDPedidoCompra.ValTotal;
  Cadastro.FieldByName('PERDESCONTO').AsFloat:= VpaDPedidoCompra.PerDesconto;
  Cadastro.FieldByName('VALDESCONTO').AsFloat:= VpaDPedidoCompra.ValDesconto;
  Cadastro.FieldByName('DESOBSERVACAO').AsString:= VpaDPedidoCompra.DesObservacao;
  if VpaDPedidoCompra.DatAprovacao > MontaData(1,1,1900) then
    Cadastro.FieldByName('DATAPROVACAO').AsDateTime:= VpaDPedidoCompra.DatAprovacao
  else
    Cadastro.FieldByName('DATAPROVACAO').Clear;
  Cadastro.FieldByName('CODUSUARIOAPROVACAO').AsInteger:= VpaDPedidoCompra.CodUsuarioAprovacao;
  if VpaDPedidoCompra.DatPagamentoAntecipado > MontaData(1,1,1900) then
    Cadastro.FieldByName('DATPAGAMENTOANTECIPADO').AsDateTime:= VpaDPedidoCompra.DatPagamentoAntecipado
  else
    Cadastro.FieldByName('DATPAGAMENTOANTECIPADO').Clear;
  Cadastro.FieldByName('VALFRETE').AsFloat:= VpaDPedidoCompra.ValFrete;

  if Cadastro.State = dsInsert then
    VpaDPedidoCompra.SeqPedido:= RSeqPedidoDisponivel(VpaDPedidoCompra.CodFilial);
  Cadastro.FieldByName('SEQPEDIDO').AsInteger:= VpaDPedidoCompra.SeqPedido;

  Cadastro.Post;
  Result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
  if Result = '' then
  begin
    Result:= GravaDProdutos(VpaDPedidoCompra);
    if Result = '' then
    begin
      Result:= GravaDFracaoOP(VpaDPedidoCompra);
      if Result = '' then
      begin
        Result:= FunClientes.AtualizaCliente(VpaDPedidoCompra);
        if result = '' then
        begin
          if (VpaDPedidoCompra.DatPrevista <> VpaDPedidoCompra.DatPrevistaInicial) or
             (VpaDPedidoCompra.DatRenegociado <> VpaDPedidoCompra.DatRenegociadoInicial) then
            result := GeraPendenciaCompra(VpaDPedidoCompra);
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFunPedidoCompra.GravaDFracaoOP(VpaDPedidoCompra: TRBDPedidoCompraCorpo): String;
var
  VpfLaco: Integer;
  VpfDFracaoOP: TRBDFracaoOPPedidoCompra;
begin
  Result:= '';
  ApagaFracaoOP(VpaDPedidoCompra);
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PEDIDOCOMPRAFRACAOOP');
  for VpfLaco:= 0 to VpaDPedidoCompra.FracaoOP.Count - 1 do
  begin
    Cadastro.Insert;
    VpfDFracaoOP:= TRBDFracaoOPPedidoCompra(VpaDPedidoCompra.FracaoOP.Items[VpfLaco]);

    Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDPedidoCompra.CodFilial;
    Cadastro.FieldByName('SEQPEDIDO').AsInteger:= VpaDPedidoCompra.SeqPedido;
    Cadastro.FieldByName('CODFILIALFRACAO').AsInteger:= VpfDFracaoOP.CodFilialFracao;
    Cadastro.FieldByName('SEQORDEM').AsInteger:= VpfDFracaoOP.SeqOrdem;
    Cadastro.FieldByName('SEQFRACAO').AsInteger:= VpfDFracaoOP.SeqFracao;

    Cadastro.Post;
    Result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      Break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.GravaDProdutos(VpaDPedidoCompra: TRBDPedidoCompraCorpo): String;
var
  VpfLaco: Integer;
  VpfDProdutoPedido: TRBDProdutoPedidoCompra;
begin
  Result:= '';
  ApagaProdutos(VpaDPedidoCompra);
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PEDIDOCOMPRAITEM'+
                                 ' Where CODFILIAL = 0 AND SEQPEDIDO = 0 ');
  for VpfLaco:= 0 to VpaDPedidoCompra.Produtos.Count - 1 do
  begin
    Cadastro.Insert;
    VpfDProdutoPedido:= TRBDProdutoPedidoCompra(VpaDPedidoCompra.Produtos.Items[VpfLaco]);

    Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDPedidoCompra.CodFilial;
    Cadastro.FieldByName('SEQPEDIDO').AsInteger:= VpaDPedidoCompra.SeqPedido;
    VpfDProdutoPedido.SeqItem:= VpfLaco+1;
    Cadastro.FieldByName('SEQITEM').AsInteger:= VpfDProdutoPedido.SeqItem;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger:= VpfDProdutoPedido.SeqProduto;
    Cadastro.FieldByName('CODCOR').Clear;
    if VpfDProdutoPedido.CodCor <> 0 then
      Cadastro.FieldByName('CODCOR').AsInteger:= VpfDProdutoPedido.CodCor;
    if VpfDProdutoPedido.CodTamanho <> 0 then
      Cadastro.FieldByName('CODTAMANHO').AsInteger:= VpfDProdutoPedido.CodTamanho;
    Cadastro.FieldByName('DESUM').AsString:= VpfDProdutoPedido.DesUM;
    Cadastro.FieldByName('QTDPRODUTO').AsFloat:= VpfDProdutoPedido.QtdProduto;
    Cadastro.FieldByName('QTDBAIXADO').AsFloat:= VpfDProdutoPedido.QtdBaixado;
    Cadastro.FieldByName('VALUNITARIO').AsFloat:= VpfDProdutoPedido.ValUnitario;
    Cadastro.FieldByName('VALTOTAL').AsFloat:= VpfDProdutoPedido.ValTotal;
    Cadastro.FieldByName('DESREFERENCIAFORNECEDOR').AsString:= VpfDProdutoPedido.DesReferenciaFornecedor;
    Cadastro.FieldByName('QTDSOLICITADA').AsFloat:= VpfDProdutoPedido.QtdSolicitada;
    if VpfDProdutoPedido.PerIPI <> 0 then
      Cadastro.FieldByName('PERIPI').AsFloat:= VpfDProdutoPedido.PerIPI;
    if VpfDProdutoPedido.DatAprovacao > MontaData(1,1,1900) then
      Cadastro.FieldByName('DATAPROVACAO').AsDateTime := VpfDProdutoPedido.DatAprovacao;

    Cadastro.Post;
    Result := Cadastro.AMensagemErroGravacao;
    if Cadastro.AErronaGravacao then
      Break;
  end;
  Cadastro.Close;
  if not ProdutosEmAberto(VpaDPedidoCompra) then
    Result:= AlteraEstagioPedidoCompra(VpaDPedidoCompra.CodFilial,
                                       VpaDPedidoCompra.SeqPedido,
                                       Varia.EstagioFinalCompras,
                                       'Todos os produtos recebidos.');
end;

{******************************************************************************}
function TRBFunPedidoCompra.RSeqPedidoDisponivel(VpaCodFilial: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQPEDIDO) ULTIMO FROM PEDIDOCOMPRACORPO'+
                            ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial));
  Result:= Aux.FieldByName('ULTIMO').AsInteger+1;
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.CarDPedidoCompra(VpaCodFilial, VpaSeqPedido: Integer; VpaDPedidoCompra: TRBDPedidoCompraCorpo);
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT PCC.*, CLI.C_FON_COM'+
                               ' FROM PEDIDOCOMPRACORPO PCC, CADCLIENTES CLI'+
                               ' WHERE PCC.CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND PCC.SEQPEDIDO = '+IntToStr(VpaSeqPedido)+
                               ' AND PCC.CODCLIENTE = CLI.I_COD_CLI');
  VpaDPedidoCompra.CodFilial:= VpaCodFilial;
  VpaDPedidoCompra.SeqPedido:= VpaSeqPedido;
  VpaDPedidoCompra.CodFilialFaturamento := Tabela.FieldByName('CODFILIALFATURAMENTO').AsInteger;
  VpaDPedidoCompra.CodCliente:= Tabela.FieldByName('CODCLIENTE').AsInteger;
  VpaDPedidoCompra.CodUsuario:= Tabela.FieldByName('CODUSUARIO').AsInteger;
  VpaDPedidoCompra.CodComprador:= Tabela.FieldByName('CODCOMPRADOR').AsInteger;  
  VpaDPedidoCompra.NumDiasAtraso:= Tabela.FieldByName('NUMDIASATRASO').AsInteger;
  VpaDPedidoCompra.CodCondicaoPagto:= Tabela.FieldByName('CODCONDICAOPAGAMENTO').AsInteger;
  VpaDPedidoCompra.CodTransportadora:= Tabela.FieldByName('CODTRANSPORTADORA').AsInteger;
  VpaDPedidoCompra.TipFrete := Tabela.FieldByName('TIPFRETE').AsInteger;
  VpaDPedidoCompra.CodFormaPagto:= Tabela.FieldByName('CODFORMAPAGAMENTO').AsInteger;
  VpaDPedidoCompra.DesSituacao:= Tabela.FieldByName('DESSITUACAO').AsString;
  VpaDPedidoCompra.IndCancelado:= Tabela.FieldByName('INDCANCELADO').AsString;
  VpaDPedidoCompra.NomContato:= Tabela.FieldByName('NOMCONTATO').AsString;
  VpaDPedidoCompra.DesEmailComprador:= Tabela.FieldByName('DESEMAILCOMPRADOR').AsString;
  VpaDPedidoCompra.DesObservacao:= Tabela.FieldByName('DESOBSERVACAO').AsString;
  VpaDPedidoCompra.ValTotal:= Tabela.FieldByName('VALTOTAL').AsFloat;
  VpaDPedidoCompra.ValFrete:= Tabela.FieldByName('VALFRETE').AsFloat;
  VpaDPedidoCompra.PerDesconto:= Tabela.FieldByName('PERDESCONTO').AsFloat;
  VpaDPedidoCompra.ValDesconto:= Tabela.FieldByName('VALDESCONTO').AsFloat;
  VpaDPedidoCompra.DatPedido:= Tabela.FieldByName('DATPEDIDO').AsDateTime;
  VpaDPedidoCompra.HorPedido:= Tabela.FieldByName('HORPEDIDO').AsDateTime;
  VpaDPedidoCompra.DatRenegociado := Tabela.FieldByName('DATRENEGOCIADO').AsDateTime;
  VpaDPedidoCompra.DatRenegociadoInicial := VpaDPedidoCompra.DatRenegociado;
  if Tabela.FieldByName('DATPREVISTA').AsDateTime < MontaData(1,1,1900) then
    VpaDPedidoCompra.DatPrevista:= MontaData(1,1,1900)
  else
    VpaDPedidoCompra.DatPrevista:= Tabela.FieldByName('DATPREVISTA').AsDateTime;
  VpaDPedidoCompra.DatPrevistaInicial := VpaDPedidoCompra.DatPrevista;
  if Tabela.FieldByName('DATENTREGA').AsDateTime < MontaData(1,1,1900) then
    VpaDPedidoCompra.DatEntrega:= MontaData(1,1,1900)
  else
    VpaDPedidoCompra.DatEntrega:= Tabela.FieldByName('DATENTREGA').AsDateTime;
  if Tabela.FieldByName('DATAPROVACAO').AsDateTime < MontaData(1,1,1900) then
    VpaDPedidoCompra.DatAprovacao:= MontaData(1,1,1900)
  else
    VpaDPedidoCompra.DatAprovacao:= Tabela.FieldByName('DATAPROVACAO').AsDateTime;
  VpaDPedidoCompra.CodUsuarioAprovacao:= Tabela.FieldByName('CODUSUARIOAPROVACAO').AsInteger;
  VpaDPedidoCompra.CodEstagio := Tabela.FieldByName('CODESTAGIO').AsInteger;
  if Tabela.FieldByName('DATPAGAMENTOANTECIPADO').AsDateTime < MontaData(1,1,1900) then
    VpaDPedidoCompra.DatPagamentoAntecipado:= MontaData(1,1,1900)
  else
    VpaDPedidoCompra.DatPagamentoAntecipado:= Tabela.FieldByName('DATPAGAMENTOANTECIPADO').AsDateTime;
  VpaDPedidoCompra.DesTelefone:= Tabela.FieldByName('C_FON_COM').AsString;

  Tabela.Close;
  CarDProdutoPedidoCompra(VpaDPedidoCompra);
  CarDFracaoOPPedidoCompra(VpaDPedidoCompra);
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.CarDFracaoOPPedidoCompra(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
var
  VpfDFracaoOPPedidoCompra: TRBDFracaoOPPedidoCompra;
begin
  FreeTObjectsList(VpaDPedidoCompra.FracaoOP);
  AdicionaSQLAbreTabela(Tabela,
                        ' SELECT PCF.CODFILIALFRACAO, PCF.SEQORDEM, PCF.SEQFRACAO,'+
                        ' CLI.C_NOM_CLI'+
                        ' FROM PEDIDOCOMPRAFRACAOOP PCF, CADCLIENTES CLI, ORDEMPRODUCAOCORPO OPC'+
                        ' WHERE PCF.CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                        ' AND PCF.SEQPEDIDO = '+IntToStr(VpaDPedidoCompra.SeqPedido)+
                        ' AND OPC.EMPFIL = PCF.CODFILIALFRACAO'+
                        ' AND OPC.SEQORD = PCF.SEQORDEM'+
                        ' AND CLI.I_COD_CLI = OPC.CODCLI');
  while not Tabela.Eof do
  begin
    VpfDFracaoOPPedidoCompra:= VpaDPedidoCompra.AddFracaoOP;

    VpfDFracaoOPPedidoCompra.CodFilialFracao:= Tabela.FieldByName('CODFILIALFRACAO').AsInteger;
    VpfDFracaoOPPedidoCompra.SeqOrdem:= Tabela.FieldByName('SEQORDEM').AsInteger;
    VpfDFracaoOPPedidoCompra.SeqFracao:= Tabela.FieldByName('SEQFRACAO').AsInteger;
    VpfDFracaoOPPedidoCompra.NomCliente:= Tabela.FieldByName('C_NOM_CLI').AsString;

    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.CarDProdutoPedidoCompra(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
var
  VpfDProdutoPedidoCompra: TRBDProdutoPedidoCompra;
begin
  FreeTObjectsList(VpaDPedidoCompra.Produtos);
  AdicionaSQLAbreTabela(Tabela,'SELECT PCI.SEQPRODUTO, PCI.CODCOR,  COR.NOM_COR,'+
                               ' PCI.DESREFERENCIAFORNECEDOR, PCI.DESUM, PCI.QTDPRODUTO, PCI.QTDBAIXADO, PCI.PERIPI,'+
                               ' PCI.VALUNITARIO, PCI.QTDSOLICITADA, PCI.VALTOTAL, PCI.CODTAMANHO, '+
                               ' PRO.L_DES_TEC, PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                               ' TAM.NOMTAMANHO ' +
                               ' FROM PEDIDOCOMPRAITEM PCI, CADPRODUTOS PRO, COR COR, TAMANHO TAM'+
                               ' WHERE CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                               ' AND SEQPEDIDO = '+IntToStr(VpaDPedidoCompra.SeqPedido)+
                               ' AND PRO.I_SEQ_PRO = PCI.SEQPRODUTO'+
                               ' AND '+ SQLTextoRightJoin('PCI.CODCOR','COR.COD_COR')+
                               ' AND '+ SQLTextoRightJoin('PCI.CODTAMANHO','TAM.CODTAMANHO')+
                               ' ORDER BY PCI.SEQITEM');

  while not Tabela.Eof do
  begin
    VpfDProdutoPedidoCompra:= VpaDPedidoCompra.AddProduto;

    VpfDProdutoPedidoCompra.SeqProduto:= Tabela.FieldByName('SEQPRODUTO').AsInteger;
    VpfDProdutoPedidoCompra.CodCor:= Tabela.FieldByName('CODCOR').AsInteger;
    VpfDProdutoPedidoCompra.CodTamanho := Tabela.FieldByName('CODTAMANHO').AsInteger;
    VpfDProdutoPedidoCompra.CodProduto:= Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDProdutoPedidoCompra.NomProduto:= Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDProdutoPedidoCompra.DesTecnica := Tabela.FieldByName('L_DES_TEC').AsString;
    VpfDProdutoPedidoCompra.NomCor:= Tabela.FieldByName('NOM_COR').AsString;
    VpfDProdutoPedidoCompra.NomTamanho := Tabela.FieldByName('NOMTAMANHO').AsString;
    VpfDProdutoPedidoCompra.DesReferenciaFornecedor:= Tabela.FieldByName('DESREFERENCIAFORNECEDOR').AsString;
    VpfDProdutoPedidoCompra.DesUM:= Tabela.FieldByName('DESUM').AsString;
    VpfDProdutoPedidoCompra.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpfDProdutoPedidoCompra.DesUM);
    VpfDProdutoPedidoCompra.QtdProduto:= Tabela.FieldByName('QTDPRODUTO').AsFloat;
    VpfDProdutoPedidoCompra.QtdBaixado:= Tabela.FieldByName('QTDBAIXADO').AsFloat;
    VpfDProdutoPedidoCompra.ValUnitario:= Tabela.FieldByName('VALUNITARIO').AsFloat;
    VpfDProdutoPedidoCompra.ValTotal:= Tabela.FieldByName('VALTOTAL').AsFloat;
    VpfDProdutoPedidoCompra.QtdSolicitada:= Tabela.FieldByName('QTDSOLICITADA').AsFloat;
    VpfDProdutoPedidoCompra.PerIPI:= Tabela.FieldByName('PERIPI').AsFloat;

    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.ApagaFracaoOP(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
begin
  ExecutaComandoSql(Cadastro,'DELETE FROM PEDIDOCOMPRAFRACAOOP'+
                             ' WHERE CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                             ' AND SEQPEDIDO = '+IntToStr(VpaDPedidoCompra.SeqPedido));
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.ApagaEstagio(VpaDPedidoCompra : TRBDPedidoCompraCorpo);
begin
  ExecutaComandoSql(Cadastro,'DELETE FROM ESTAGIOPEDIDOCOMPRA '+
                             ' WHERE CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                             ' AND SEQPEDIDO = '+IntToStr(VpaDPedidoCompra.SeqPedido));
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.ApagaProdutos(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
begin
  ExecutaComandoSql(Cadastro,'DELETE FROM PEDIDOCOMPRAITEM'+
                             ' WHERE CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                             ' AND SEQPEDIDO = '+IntToStr(VpaDPedidoCompra.SeqPedido));
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.ApagaPedido(VpaDPedidoCompra: TRBDPedidoCompraCorpo);
begin
  ApagaProdutos(VpaDPedidoCompra);
  ApagaFracaoOP(VpaDPedidoCompra);
  ApagaEstagio(VpaDPedidoCompra);
  ExecutaComandoSql(Aux,'Delete from PEDIDOSOLICITACAOCOMPRA '+
                        ' WHERE CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                        ' AND SEQPEDIDO = '+IntToStr(VpaDPedidoCompra.SeqPedido));
  ExecutaComandoSql(Cadastro,'DELETE FROM PENDENCIACOMPRA'+
                             ' WHERE CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                             ' AND SEQPEDIDO = '+IntToStr(VpaDPedidoCompra.SeqPedido));
  ExecutaComandoSql(Cadastro,'DELETE FROM PEDIDOCOMPRACORPO'+
                             ' WHERE CODFILIAL = '+IntToStr(VpaDPedidoCompra.CodFilial)+
                             ' AND SEQPEDIDO = '+IntToStr(VpaDPedidoCompra.SeqPedido));
end;

{******************************************************************************}
function TRBFunPedidoCompra.EnviaEmailFornecedor(VpaDPedidoCompra : TRBDPedidoCompraCorpo) : String;
var
  VpfEmailHTML : TIdText;
  VpfEmailVendedor, VpfEmailFornecedor : String;
  VpfDFilial : TRBDFilial;
  VpfDCliente : TRBDCliente;
  VpfDComprador : TRBDComprador;
  VpfChar : char;
begin
  result := '';
  if VpaDPedidoCompra.DesEmailComprador = '' then
    result := 'E-MAIL DO FORNECEDOR NÃO PREENCHIDO!!!'#13'Falta preencher o e-mail do fornecedor.';
  if result = '' then
  begin
    VpfDFilial := TRBDFilial.cria;
    if VpaDPedidoCompra.CodFilialFaturamento <> 0 then
      Sistema.CarDFilial(VpfDFilial,VpaDPedidoCompra.CodFilialFaturamento)
    else
      Sistema.CarDFilial(VpfDFilial,VpaDPedidoCompra.CodFilial);

    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VpaDPedidoCompra.CodCliente;
    FunClientes.CarDCliente(VpfDCliente,true);

    VpfDComprador := TRBDComprador.cria;
    FunClientes.CarDComprador(VpfDComprador,VpaDPedidoCompra.CodComprador);

    VpfEmailHTML := TIdText.Create(VprMensagem.MessageParts);
    VpfEmailHTML.ContentType := 'text/html';

    MontaEmailPedidoCompra(VpfEmailHTML.Body,VpaDPedidoCompra,VpfDCliente,VpfDComprador, VpfDFilial);

    VpfEmailHTML.Body.Text := RetiraAcentuacaoHTML(VpfEmailHtml.Body.Text);
    VpfEmailFornecedor := VpaDPedidoCompra.DesEmailComprador;
    VpfChar := ',';
    if ExisteLetraString(';',VpfEmailFornecedor) then
      VpfChar := ';';
    while Length(VpfEmailFornecedor) > 0 do
    begin
      VprMensagem.Recipients.Add.Address := DeletaChars(CopiaAteChar(VpfEmailFornecedor,VpfChar),VpfChar);
      VpfEmailFornecedor := DeleteAteChar(VpfEmailFornecedor,VpfChar);
    end;

    VprMensagem.ReplyTo.EMailAddresses := VpfDComprador.DesEmail;
    VprMensagem.Recipients.Add.Address := VpfDComprador.DesEmail;
    if varia.EmailGeralCompras <> '' then
      VprMensagem.Recipients.Add.Address := varia.EmailGeralCompras;

    VprMensagem.Subject := VpfDFilial.NomFantasia+' - Pedido Compra ' +IntToStr(VpaDPedidoCompra.SeqPedido);
    result := EnviaEmail(VprMensagem,VprSMTP,VpfDFilial,VpfDComprador);
    if Result = '' then
      result := AlteraEstagioPedidoCompra(VpaDPedidoCompra.CodFilial,VpaDPedidoCompra.SeqPedido,Varia.EstagioComprasAguardandoConfirmacaoRecebFornececedor,'E-mail enviado');
  end;
  VpfDFilial.free;
  VpfDCliente.free;
  VpfDComprador.free;
end;

{******************************************************************************}
function TRBFunPedidoCompra.AprovarPedido(VpaCodFilial, VpaSeqPedido : Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PEDIDOCOMPRACORPO'+
                                 ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                                 ' AND SEQPEDIDO = '+IntToStr(VpaSeqPedido));
  Cadastro.Edit;

  Cadastro.FieldByName('DATAPROVACAO').AsDateTime:= Now;
  Cadastro.FieldByName('CODUSUARIOAPROVACAO').AsInteger:= varia.codigoUsuario;

  Cadastro.Post;
  Result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.AlteraEstagioPedidoCompra(VpaCodFilial, VpaSeqPedido, VpaCodEstagio: Integer; VpaDesMotivo: String):String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from PEDIDOCOMPRACORPO '+
                                 ' Where CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                 ' and SEQPEDIDO = '+IntToStr(VpaSeqPedido));
  Cadastro.Edit;
  if Varia.EstagioFinalCompras = VpaCodEstagio then
    Cadastro.FieldByName('DATENTREGA').AsDateTime:= Now;
  Cadastro.FieldByname('CODESTAGIO').AsInteger:= VpaCodEstagio;
  Cadastro.post;
  Result := Cadastro.AMensagemErroGravacao;
  if Result = '' then
  begin
    Result:= GravaLogEstagio(VpaCodFilial,VpaSeqPedido,VpaCodEstagio,VpaDesMotivo);
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.ExtornaPedidoCompra(VpaCodFilial,VpaSeqPedido: Integer): String;
begin
  Result:= '';
  try
    ExecutaComandoSql(Tabela,'UPDATE PEDIDOCOMPRACORPO'+
                             ' SET DATAPROVACAO = NULL,'+
                             ' CODUSUARIOAPROVACAO = NULL,'+
                             ' DATENTREGA = NULL'+
                             ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND SEQPEDIDO = '+IntToStr(VpaSeqPedido));
  except
    on E:Exception do
    begin
      Result:= 'ERRO AO EXTORNAR O PEDIDO DE COMPRA'+E.Message;
    end;
  end;
end;

{******************************************************************************}
function TRBFunPedidoCompra.BaixarPagamentoAntecipado(VpaCodFilial, VpaSeqPedido: Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PEDIDOCOMPRACORPO'+
                                 ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                                 ' AND SEQPEDIDO = '+IntToStr(VpaSeqPedido));
  Cadastro.Edit;

  Cadastro.FieldByName('DATPAGAMENTOANTECIPADO').AsDateTime:= Now;

  Cadastro.Post;
  Result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.ConcluiPedidoCompra(VpaCodFilial, VpaSeqPedido: Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PEDIDOCOMPRACORPO'+
                                 ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                                 ' AND SEQPEDIDO = '+IntToStr(VpaSeqPedido));
  Cadastro.Edit;

  Cadastro.FieldByName('DATENTREGA').AsDateTime:= Date;

  Cadastro.Post;
  Result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.ConcluiPendenciaCompras(VpaCodFilial,VpaSeqPedido,VpaSeqPendencia : Integer):string;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from PENDENCIACOMPRA '+
                                 ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                                 ' and SEQPEDIDO = '+IntToStr(VpaSeqPedido)+
                                 ' and SEQPENDENCIA = '+IntToStr(VpaSeqPendencia));
  Cadastro.edit;
  Cadastro.FieldByName('DATCONCLUSAO').AsDateTime := DATE;
  Cadastro.FieldByName('CODUSUARIOCONCLUSAO').AsInteger := varia.CodigoUsuario;
  Cadastro.post;
  Result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.GravaLogEstagio(VpaCodFilial, VpaSeqPedido, VpaCodEstagio: Integer; VpaDesMotivo: String): String;
var
  VpfLaco : Integer;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM ESTAGIOPEDIDOCOMPRA');


  Cadastro.Insert;

  Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaCodFilial;
  Cadastro.FieldByName('SEQPEDIDO').AsInteger:= VpaSeqPedido;
  Cadastro.FieldByName('CODUSUARIO').AsInteger:= varia.CodigoUsuario;
  Cadastro.FieldByName('CODESTAGIO').AsInteger:= VpaCodEstagio;
  if VpaDesMotivo <> '' then
    Cadastro.FieldByName('DESMOTIVO').AsString:= VpaDesMotivo
  else
    Cadastro.FieldByName('DESMOTIVO').Clear;
  Cadastro.FieldByName('DATESTAGIO').AsDateTime:= Now;
  Cadastro.FieldByName('SEQESTAGIO').AsInteger:= RSeqEstagioDisponivel(VpaCodFilial,VpaSeqPedido);

  AdicionaSQLAbreTabela(Tabela,'Select * from PEDIDOCOMPRACORPO '+
                               ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' and SEQPEDIDO = '+IntToStr(VpaSeqPedido));
  for VpfLaco := 0 to Tabela.FieldCount - 1 do
  begin
    Cadastro.FieldByname('LOGALTERACAO').AsString := Cadastro.FieldByname('LOGALTERACAO').AsString+
                                         Tabela.Fields[VpfLaco].DisplayName+' = "'+ Tabela.Fields[VpfLaco].AsString+'"'+#13;
  end;

  Cadastro.Post;
  Result := Cadastro.AMensagemErroGravacao;
  Cadastro.close;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.MontaCabecalhoEmail(VpaTexto : TStrings; VpaDPedidoCompra : TRBDPedidoCompraCorpo;VpaDFilial : TRBDFilial);
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDPedidoCompra.CodFilial)+' - Pedido de Compra : '+IntToStr(VpaDPedidoCompra.SeqPedido));
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <a href="http://'+VpaDFilial.DesSite+ '">');
  VpaTexto.add('      <IMG src="cid:'+IntToStr(VpaDPedidoCompra.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+'border="0" >');
  VpaTexto.add('    </a></td> <td bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <b>'+VpaDFilial.NomFilial+ '.</b>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesEndereco+'              Bairro : '+VpaDFilial.DesBairro);
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesCidade +' / '+VpaDFilial.DesUF+ '                CEP : '+VpaDFilial.DesCep);
  VpaTexto.add('    <br>');
  VpaTexto.add('    Fone : '+VpaDFilial.DesFone +'         -             e-mail comercial :'+VpaDFilial.DesEmailComercial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    CNPJ : '+VpaDFilial.DesCNPJ +'         -             Inscrição Estadual :'+VpaDFilial.DesInscricaoEstadual);
  VpaTexto.add('    <br>');
  VpaTexto.add('    site : <a href="http://'+VpaDFilial.DesSite+'">'+VpaDFilial.DesSite);
  VpaTexto.add('    </td><td bgcolor="#'+varia.CRMCorClaraEmail+'"> ');
  VpaTexto.add('    <center>');
  VpaTexto.add('    <h3> Pedido de Compra </h3>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <h2> '+formatFloat('###,###,##0',VpaDPedidoCompra.SeqPedido)+'</h2>');
  VpaTexto.add('    </center>');
  VpaTexto.add('    </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('</left>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    <br>');
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.MontaEmailPedidoCompra(VpaTexto : TStrings; VpaDPedidoCompra : TRBDPedidoCompraCorpo;VpaDCliente : TRBDCliente; VpaDComprador : TRBDComprador; VpaDFilial : TRBDFilial);
var
  VpfLaco : Integer;
  Vpfbmppart : TIdAttachmentfile;
  VpfDItem : TRBDProdutoPedidoCompra;
  VpfObservacoes : TStringList;
  VpfCamposRetorno : String;
  VpfDTransportadora : TRBDTransportadora;
  VpfTamanhoColCor, VpfTamanhoColTamanho : Integer;
begin
  if config.EstoquePorTamanho then
  begin
    VpfTamanhoColCor := 9;
    VpfTamanhoColTamanho := 6;
  end
  else
  begin
    VpfTamanhoColCor := 15;
    VpfTamanhoColTamanho := 0;
  end;

  VpfDTransportadora := TRBDTransportadora.Create;
  VpfCamposRetorno := '';
  Vpfbmppart := TIdAttachmentFile.Create(VprMensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDPedidoCompra.CodFilial)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDPedidoCompra.CodFilial)+'.jpg';
  Vpfbmppart.DisplayName := inttoStr(VpaDPedidoCompra.CodFilial)+'.jpg';

  MontaCabecalhoEmail(VpaTexto,VpaDPedidoCompra,VpaDFilial);
  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="100%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="2"><b>');
  VpfCamposRetorno := '';
  if VpaDPedidoCompra.DatPrevista <= MontaData(1,1,1900) then
    VpfCamposRetorno := 'O PRAZO DE ENTREGA, ';
  if VpaDPedidoCompra.CodCondicaoPagto = 0 then
    VpfCamposRetorno := VpfCamposRetorno + ' A CONDIÇÃO DE PAGAMENTO, ';
  if VpaDPedidoCompra.CodFormaPagto = 0 then
    VpfCamposRetorno := VpfCamposRetorno + ' A FORMA DE PAGAMENTO,';
  if VpfCamposRetorno <> '' then
  begin
    VpfCamposRetorno := copy(VpfCamposRetorno,1,length(VpfCamposRetorno)-1);
    VpaTexto.add('ATENÇÃO FORNECEDOR!!!<br>');
    VpaTexto.add('RESPONDA ESSE EMAIL PREENCHENDO '+VpfCamposRetorno+' NOS CAMPOS AMARELO ABAIXO.<br>');
  end;
  VpaTexto.add('  </td></tr></table>');
  VpaTexto.add('<br>');

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Data</td><td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY',VpaDPedidoCompra.DatPedido)+' - '+FormatDateTime('HH:MM',VpaDPedidoCompra.HorPedido)+ '</td>');
  VpaTexto.add('<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Comprador</td><td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDComprador.NomComprador  +'</td>');
  VpaTexto.add('<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Prazo Entrega</td><td width="20%" bgcolor="#FFFF00"><font face="Verdana" size="3">&nbsp;<b>');
  if VpaDPedidoCompra.DatPrevista > MontaData(1,1,1900) then
    VpaTexto.add(FormatDateTime('DD/MM/YYYY',VpaDPedidoCompra.DatPrevista))
  else
    VpaTexto.add('      ');
  VpaTexto.add('</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  //fornecedor
  VpaTexto.add('    <br>');
  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fornecedor</td>');
  VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDCliente.CodCliente)+ '-'+VpaDCliente.NomCliente +' </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Endere&ccedil;o</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesEndereco+'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Bairro</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesBairro +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cep</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CepCliente+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cidade</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesCidade+'/'+VpaDCliente.DesUF +'</td>');
  if VpaDCliente.TipoPessoa = 'F' Then
  begin
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;CPF</td>');
    VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CGC_CPF+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;RG</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.RG+'</td>');
  end
  else
  begin
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;CNPJ</td>');
    VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.CGC_CPF+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Inscrição Estadual</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.InscricaoEstadual+'</td>');
  end;
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fone</td>');
  VpaTexto.add('	<td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFone1 +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Fax</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDCliente.DesFax+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;contato</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+VpaDPedidoCompra.NomContato+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width=100%>');
  VpaTexto.add('  <tr>');
  if VpaDPedidoCompra.CodCondicaoPagto = 0 then
    VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Condição Pagamento</td><td width="35%" bgcolor="#FFFF00"><font face="Verdana" size="3">&nbsp;<b>      </td>')
  else
    VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Condição Pagamento</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FunContasAReceber.RNomCondicaoPagamento(VpaDPedidoCompra.CodCondicaoPagto)+'</td>');
  if VpaDPedidoCompra.CodFormaPagto = 0 then
    VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Forma Pagamento</td><td width="35%" bgcolor="#FFFF00"><font face="Verdana" size="3">&nbsp;<b>      </td>')
  else
    VpaTexto.add('<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Forma Pagamento</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FunContasAReceber.RNomFormaPagamento(VpaDPedidoCompra.CodFormaPagto) +'</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td colspan=8 align="center" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="3"><b>Produtos</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('        <td width="10%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Ref Fornecedor</td>');
  VpaTexto.add('        <td width="30%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Produto</td>');
  VpaTexto.add('        <td width="'+IntToStr(VpfTamanhoColCor) +'%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Cor</td>');
  if config.EstoquePorTamanho then
    VpaTexto.add('        <td width="'+IntToStr(VpfTamanhoColTamanho) +'%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Tamanho</td>');
  VpaTexto.add('        <td width="5%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;UM</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Quantidade</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Unitário</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('	<td width="5%" bgcolor="#'+varia.CRMCorEscuraEmail+'" align="center"><font face="Verdana" size="-1"><b>&nbsp;%IPI</td>');
  for VpfLaco := 0 to VpaDPedidoCompra.Produtos.Count - 1 do
  begin
    VpfDItem := TRBDProdutoPedidoCompra(VpaDPedidoCompra.Produtos.Items[VpfLaco]);
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('        <td width="10%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+VpfDItem.DesReferenciaFornecedor +'</td>');
    if (VpfDItem.DesTecnica <> '') and (config.ObservacaoProdutoPedidoCompra) then
      VpaTexto.add('        <td width="30%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+VpfDItem.DesTecnica+'</td>')
    else
      VpaTexto.add('        <td width="30%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+VpfDItem.CodProduto+'-'+VpfDItem.NomProduto+'</td>');
    if VpfDItem.NomCor <> '' then
      VpaTexto.add('        <td width="'+IntToStr(VpfTamanhoColCor) +'%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+IntToStr(VpfDItem.CodCor)+'-'+ VpfDItem.NomCor+'</td>')
    else
      VpaTexto.add('        <td width="'+IntToStr(VpfTamanhoColCor) +'%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+VpfDItem.NomCor+'</td>');
    if config.EstoquePorTamanho then
      VpaTexto.add('        <td width="'+IntToStr(VpfTamanhoColTamanho) +'%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+VpfDItem.NomTamanho+'</td>');
    VpaTexto.add('        <td width="5%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">&nbsp;'+VpfDItem.DesUM+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraQtd,VpfDItem.QtdProduto)+'</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraValorUnitario,VpfDItem.ValUnitario)+'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+FormatFloat(varia.MascaraValor,VpfDItem.ValTotal)+'</td>');
    VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraEmail+'" align="center"><font face="Verdana" size="-1">'+FloatToStr(VpfDItem.PerIPI)+'</td>');
  end;
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table><br>');

  if VpaDPedidoCompra.CodTransportadora <> 0 then
    FunNotaFiscal.CarDTransportadora(VpfDTransportadora,VpaDPedidoCompra.CodTransportadora);

  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>Transportadora</td>');
  VpaTexto.add('	<td width="50%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">'+VpfDTransportadora.Nome +' </td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Frete por Conta</td>');
  if VpaDPedidoCompra.TipFrete = 1 then
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;Emitente</td>')
  else
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;Destinatário</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table>');


  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1">'+RTextoAcrescismoDesconto(VpaDPedidoCompra) +'</td>');
  VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1">'+RValorAcrescimoDesconto(VpaDPedidoCompra) +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Frete</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FormatFloat(varia.MascaraValor,VpaDPedidoCompra.ValFrete)+'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FormatFloat(varia.MascaraValor,VpaDPedidoCompra.ValTotal)+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpfObservacoes := TStringList.create;
  VpfObservacoes.Text := VpaDPedidoCompra.DesObservacao;
  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="1"><b>&nbsp;Observações</td>');
  VpaTexto.add('</tr><tr>');
  if VpfObservacoes.Count > 0 then
    VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="2">&nbsp;'+VpfObservacoes.Strings[0] +'<br>')
  else
    VpaTexto.add('	<td align="left" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="2">&nbsp;');
  for Vpflaco := 1 to VpfObservacoes.count - 1 do
    VpaTexto.add(VpfObservacoes.strings[VpfLaco]+'<br>');
  VpaTexto.add('</td></tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<b><li>Obrigatório colocar o número da ordem de compra na nota fiscal, caso contrário será devolvido;</b>');
  VpaTexto.add('<li>Favor confirmar o recebimento desse pedido por escrito;');
  VpaTexto.add('<li>Mercadorias estão sujeitas a conferência de preço, qualidade e quantidade.');
  VpfObservacoes.Text := RRodapePedidoCompra(VpaDPedidoCompra.CodFilial);
  for VpfLaco := 0 to VpfObservacoes.Count - 1 do
    VpaTexto.Add(VpfObservacoes.Strings[VpfLaco]);

  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  if Varia.CNPJFilial <> CNPJ_Reeltex then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
  VpfObservacoes.free;
  VpfDTransportadora.free;
end;

{******************************************************************************}
function TRBFunPedidoCompra.EnviaEmail(VpaMensagem : TIdMessage;VpaSMTP : TIdSMTP;VpaDFilial : TRBDFilial;VpaDComprador : TRBDComprador) : string;
begin
  VpaMensagem.Priority := TIdMessagePriority(0);
  VpaMensagem.ContentType := 'multipart/mixed';
  VpaMensagem.From.Address := VpaDComprador.DesEmail;
  VpaMensagem.From.Name := VpaDFilial.NomFantasia;

  VpaSMTP.UserName := varia.UsuarioSMTP;
  VpaSMTP.Password := Varia.SenhaEmail;
  VpaSMTP.Host := Varia.ServidorSMTP;
  VpaSMTP.Port := 25;
  VpaSMTP.AuthType := satDefault;

  VpaMensagem.ReceiptRecipient.Text  := lowerCase(VpaDComprador.DesEmail);

  if VpaMensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DO COMPRADOR !!!'#13'É necessário preencher o e-mail do comprador.';
  if VpaSMTP.UserName = '' then
    result := 'USUARIO DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações o e-mail de origem.';
  if VpaSMTP.Password = '' then
    result := 'SENHA SMTP DO E-MAIL ORIGEM NÃO CONFIGURADO!!!'#13'É necessário preencher nas configurações a senha do e-mail de origem';
  if VpaSMTP.Host = '' then
    result := 'SERVIDOR DE SMTP NÃO CONFIGURADO!!!'#13'É necessário configurar qual o servidor de SMTP...';
  if result = '' then
  begin
    VpaSMTP.Connect;
    try
      VpaSMTP.Send(VpaMensagem);
    except
      on e : exception do
      begin
        result := 'ERRO AO ENVIAR O E-MAIL!!!'#13+e.message;
        VpaSMTP.Disconnect;
      end;
    end;
    VpaSMTP.Disconnect;
  end;
  VpaMensagem.Recipients.Clear;
  VpaMensagem.Clear;
end;

{******************************************************************************}
function TRBFunPedidoCompra.RSeqEstagioDisponivel(VpaCodFilial, VpaSeqPedido: Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQESTAGIO) PROXIMO'+
                            ' FROM ESTAGIOPEDIDOCOMPRA'+
                            ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' AND SEQPEDIDO = '+IntToStr(VpaSeqPedido));
  Result:= Aux.FieldByName('PROXIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.RSeqPedidoCompraNotafiscalItem(VpaCodFilial,VpaSeqPedido,SeqNota : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQITEM) PROXIMO'+
                            ' FROM PEDIDOCOMPRANOTAFISCALITEM'+
                            ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' AND SEQPEDIDO = '+IntToStr(VpaSeqPedido)+
                            ' AND SEQNOTA = ' +IntToStr(SeqNota));
  Result:= Aux.FieldByName('PROXIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.RSeqPendenciaCompraDisponivel(VpaCodFilial, VpaSeqPedido : Integer):integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(SEQPENDENCIA) ULTIMO from PENDENCIACOMPRA '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' AND SEQPEDIDO = '+IntToStr(VpaSeqPedido));
  result := Aux.FieldByName('ULTIMO').AsInteger +1;
  Aux.close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.RRodapePedidoCompra(VpaCodFilial : Integer):String;
begin
  AdicionaSQLAbreTabela(Aux,'Select L_OBS_COM from CADFILIAIS '+
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial));
  result := Aux.FieldByname('L_OBS_COM').AsString;
  Aux.close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.RTextoAcrescismoDesconto(VpaDPedidoCompra : TRBDPedidoCompraCorpo):string;
begin
  result := '';
  if (VpaDPedidoCompra.PerDesconto > 0) or (VpaDPedidoCompra.ValDesconto > 0) then
    result := 'Desconto'
  else
    if (VpaDPedidoCompra.PerDesconto < 0) or (VpaDPedidoCompra.PerDesconto < 0) then
      result := 'Acréscimo';
end;

{******************************************************************************}
function TRBFunPedidoCompra.RValorAcrescimoDesconto(VpaDPedidoCompra : TRBDPedidoCompraCorpo):string;
begin
  result := '';
  if VpaDPedidoCompra.PerDesconto > 0 then
    result := FormatFloat('0%',VpaDPedidoCompra.PerDesconto)
  else
    if VpaDPedidoCompra.PerDesconto < 0 then
      result := FormatFloat('0%',VpaDPedidoCompra.PerDesconto*-1);
  if VpaDPedidoCompra.ValDesconto > 0 then
    Result := FormatFloat(varia.MascaraValor,VpaDPedidoCompra.ValDesconto)
  else
    if VpaDPedidoCompra.ValDesconto > 0 then
      Result := FormatFloat(varia.MascaraValor,VpaDPedidoCompra.ValDesconto*-1);
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.CalculaValorTotal(VpaDPedidoCorpo: TRBDPedidoCompraCorpo);
var
  VpfLaco: Integer;
  VpfDProdutoPedido: TRBDProdutoPedidoCompra;
begin
  VpaDPedidoCorpo.ValTotal:= 0;
  VpaDPedidoCorpo.ValProdutos := 0;
  VpaDPedidoCorpo.ValIPI := 0;

  for VpfLaco:= 0 to VpaDPedidoCorpo.Produtos.Count - 1 do
  begin
    VpfDProdutoPedido:= TRBDProdutoPedidoCompra(VpaDPedidoCorpo.Produtos.Items[VpfLaco]);
    VpaDPedidoCorpo.ValProdutos := VpaDPedidoCorpo.ValProdutos + VpfDProdutoPedido.ValTotal;
    VpaDPedidoCorpo.ValIPI := VpaDPedidoCorpo.ValIPI + ((VpfDProdutoPedido.ValTotal * VpfDProdutoPedido.PerIPI)/100);
  end;
  VpaDPedidoCorpo.ValTotal := VpaDPedidoCorpo.ValProdutos + VpaDPedidoCorpo.ValIPI;

  if VpaDPedidoCorpo.PerDesconto <> 0 then
    VpaDPedidoCorpo.ValTotal:= VpaDPedidoCorpo.ValTotal - ((VpaDPedidoCorpo.ValTotal * VpaDPedidoCorpo.PerDesconto)/100)
  else
    if VpaDPedidoCorpo.ValDesconto <> 0 then
      VpaDPedidoCorpo.ValTotal:= VpaDPedidoCorpo.ValTotal - VpaDPedidoCorpo.ValDesconto;
  VpaDPedidoCorpo.ValTotal:= VpaDPedidoCorpo.ValTotal + VpaDPedidoCorpo.ValFrete;
end;

{******************************************************************************}
function TRBFunPedidoCompra.VerificaProdutoNaoRecebido(VpaCodFilial, VpaSeqPedido, VpaSeqProduto, VpaCodCor: Integer; var VpaQuantidadeSobra: Double): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Tabela,'SELECT PCC.SEQPEDIDO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PCI.CODCOR, COR.NOM_COR,'+
                               ' PCI.QTDSOLICITADA, PCI.QTDPRODUTO, PCI.DESUM'+
                               ' FROM PEDIDOCOMPRACORPO PCC, PEDIDOCOMPRAITEM PCI, CADPRODUTOS PRO, COR COR'+
                               ' WHERE'+
                               ' PCC.CODESTAGIO = '+IntToStr(varia.EstagioComprasAguardandoEntregaFornecedor)+
                               ' AND PCC.CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND PCC.SEQPEDIDO <> '+IntToStr(VpaSeqPedido)+
                               ' AND PCI.SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                               ' AND PCI.CODCOR = '+IntToStr(VpaCodCor)+
                               ' AND PCI.QTDSOLICITADA < PCI.QTDPRODUTO'+
                               ' AND PCI.CODFILIAL = PCC.CODFILIAL'+
                               ' AND PCI.SEQPEDIDO = PCC.SEQPEDIDO'+
                               ' AND PCI.SEQPRODUTO = PRO.I_SEQ_PRO '+
                               ' AND '+ SQLTextoRightJoin('PCI.CODCOR','COR.COD_COR'));
  if not Tabela.Eof then
  begin
    VpaQuantidadeSobra:= Tabela.FieldByName('QTDPRODUTO').AsFloat -
                         Tabela.FieldByName('QTDSOLICITADA').AsFloat;

    Result:= 'O pedido de compra Nº '+Tabela.FieldByName('SEQPEDIDO').AsString+
             ' está com '+FormatFloat(Varia.MascaraQtd,VpaQuantidadeSobra)+' '+Tabela.FieldByName('DESUM').AsString+'s '+
             ' de sobra para o produto '+Tabela.FieldByName('C_COD_PRO').AsString+' - '+Tabela.FieldByName('C_NOM_PRO').AsString;

    if Tabela.FieldByName('CODCOR').AsInteger <> 0 then
      Result:= Result + ' na cor '+Tabela.FieldByName('CODCOR').AsString+' - '+Tabela.FieldByName('NOM_COR').AsString;

    Result:= Result+'.'#13+
                    'Talvez ele não tenha sido completamente entregue.'+
                    'Deseja adicionar a quantidade de sobra deste produto ao pedido que está sendo feito agora ?';

  end;

  Tabela.Close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.AjustarQuantidadesProdutoPedidoCompra(VpaCodFilial, VpaSeqPedido, VpaSeqItem: Integer; VpaDProdutoPendente: TRBDProdutoPendenteCompra): String;
var
  VpfQtdSaldo: Double;
begin
  AdicionaSQLAbreTabela(Cadastro,'SELECT * '+
                                 ' FROM PEDIDOCOMPRAITEM'+
                                 ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                                 ' AND SEQPEDIDO = '+IntToStr(VpaSeqPedido)+
                                 ' AND SEQITEM = '+IntToStr(VpaSeqItem));
  if not Cadastro.Eof then
  begin
    Cadastro.Edit;

    VpfQtdSaldo:= Cadastro.FieldByName('QTDPRODUTO').AsFloat - Cadastro.FieldByName('QTDSOLICITADA').AsFloat;
    if VpaDProdutoPendente.QtdAprovada >= VpfQtdSaldo then
    begin
      Cadastro.FieldByName('QTDSOLICITADA').AsFloat:= FunProdutos.CalculaQdadePadrao(Cadastro.FieldByName('DESUM').AsString,
                                                                                     VpaDProdutoPendente.DesUM,
                                                                                     Cadastro.FieldByName('QTDPRODUTO').AsFloat,
                                                                                     Cadastro.FieldByName('SEQPRODUTO').AsString);
      VpaDProdutoPendente.QtdAprovada:= VpaDProdutoPendente.QtdAprovada - VpfQtdSaldo;
    end
    else
    begin
      Cadastro.FieldByName('QTDSOLICITADA').AsFloat:= FunProdutos.CalculaQdadePadrao(Cadastro.FieldByName('DESUM').AsString,
                                                                                     VpaDProdutoPendente.DesUM,
                                                                                     (Cadastro.FieldByName('QTDSOLICITADA').AsFloat + vpaDProdutoPendente.QtdAprovada),
                                                                                     Cadastro.FieldByName('SEQPRODUTO').AsString);
      VpaDProdutoPendente.QtdAprovada:= 0;
    end;

    Cadastro.Post;
    Result := Cadastro.AMensagemErroGravacao;
    if Result = '' then
      FunOrcamentoCompra.FinalizaVinculoPedidoOrcamento(Varia.CodigoEmpFil,
                                                        VpaSeqPedido,
                                                        VpaDProdutoPendente);
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.BaixarQtdeProdutoPedido(VpaDNota: TRBDNotaFiscalFor; VpaListaPedidos: TList);
var
  VpfLacoItensNota,
  VpfLacoPedidos: Integer;
  VpfDNotaItem: TRBDNotaFiscalForItem;
  VpfDPedidoCompraCorpo: TRBDPedidoCompraCorpo;
begin
  for VpfLacoItensNota:= 0 to VpaDNota.ItensNota.Count-1 do
  begin
    VpfDNotaItem:= TRBDNotaFiscalForItem(VpaDNota.ItensNota.Items[VpfLacoItensNota]);
    for VpfLacoPedidos:= 0 to VpaListaPedidos.Count-1 do
    begin
      VpfDPedidoCompraCorpo:= TRBDPedidoCompraCorpo(VpaListaPedidos.Items[VpfLacoPedidos]);
      VpfDNotaItem.CodFilial:= VpaDNota.CodFilial;
      VpfDNotaItem.SeqNota:= VpaDNota.SeqNota;
      AtualizarQtdeProdutoPedido(VpfDNotaItem,VpfDPedidoCompraCorpo);
    end;
  end;
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.AtualizarQtdeProdutoPedido(VpaDNotaItem: TRBDNotaFiscalForItem; VpaDPedidoCompraCorpo: TRBDPedidoCompraCorpo);
var
  VpfLaco: Integer;
  VpfDProdutoPedidoCompra: TRBDProdutoPedidoCompra;
  VpfResultado: String;
begin
  if VpaDNotaItem.QtdProduto <> 0 then
  begin
    for VpfLaco:= 0 to VpaDPedidoCompraCorpo.Produtos.Count-1 do
    begin
      VpfDProdutoPedidoCompra:= TRBDProdutoPedidoCompra(VpaDPedidoCompraCorpo.Produtos.Items[VpfLaco]);
      if (VpaDNotaItem.SeqProduto = VpfDProdutoPedidoCompra.SeqProduto) and
         (VpaDNotaItem.CodCor = VpfDProdutoPedidoCompra.CodCor) then
      begin
        if (VpfDProdutoPedidoCompra.QtdProduto - VpfDProdutoPedidoCompra.QtdBaixado) > 0 then
        begin
          if VpaDNotaItem.QtdProduto > (VpfDProdutoPedidoCompra.QtdProduto - VpfDProdutoPedidoCompra.QtdBaixado) then
          begin
            VpaDNotaItem.QtdProduto:= VpaDNotaItem.QtdProduto - (VpfDProdutoPedidoCompra.QtdProduto - VpfDProdutoPedidoCompra.QtdBaixado);
            VpfResultado:= GravaDVinculoNotaFiscalItem(VpaDNotaItem.CodFilial, VpaDNotaItem.SeqNota, VpaDPedidoCompraCorpo.SeqPedido, VpfDProdutoPedidoCompra.SeqProduto, VpfDProdutoPedidoCompra.CodCor,
                                                       VpfDProdutoPedidoCompra.QtdBaixado);
            VpfDProdutoPedidoCompra.QtdBaixado:= VpfDProdutoPedidoCompra.QtdProduto;
          end
          else
          begin
            VpfDProdutoPedidoCompra.QtdBaixado:= VpfDProdutoPedidoCompra.QtdBaixado + VpaDNotaItem.QtdProduto;
            VpfResultado:= GravaDVinculoNotaFiscalItem(VpaDNotaItem.CodFilial, VpaDNotaItem.SeqNota, VpaDPedidoCompraCorpo.SeqPedido, VpfDProdutoPedidoCompra.SeqProduto, VpfDProdutoPedidoCompra.CodCor,
                                                       VpaDNotaItem.QtdProduto);
            VpaDNotaItem.QtdProduto:= 0;
          end;
        end;
      end;
      if VpfResultado <> '' then
      begin
        aviso(VpfResultado);
        Break;
      end;
    end;
    GravaDProdutos(VpaDPedidoCompraCorpo);
  end;
end;

{******************************************************************************}
function TRBFunPedidoCompra.GravaDVinculoNotaFiscalItem(VpaCodFilial,
  VpaSeqNota, VpaSeqPedido, VpaSeqProduto, VpaCodCor: Integer;
  VpaQuantidade: Double): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PEDIDOCOMPRANOTAFISCALITEM');
  Cadastro.Insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaCodFilial;
  Cadastro.FieldByName('SEQNOTA').AsInteger:= VpaSeqNota;
  Cadastro.FieldByName('SEQPEDIDO').AsInteger:= VpaSeqPedido;
  Cadastro.FieldByName('SEQITEM').AsInteger:= RSeqPedidoCompraNotafiscalItem(VpaCodFilial,VpaSeqPedido,VpaSeqNota);
  Cadastro.FieldByName('SEQPRODUTO').AsInteger:= VpaSeqProduto;
  if VpaCodcor <> 0 then
    Cadastro.FieldByName('CODCOR').AsInteger:= VpaCodCor;
  Cadastro.FieldByName('QTDPRODUTO').AsFloat:= Cadastro.FieldByName('QTDPRODUTO').AsFloat + VpaQuantidade;

  Cadastro.Post;
  Result := Cadastro.AMensagemErroGravacao;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFunPedidoCompra.GeraPendenciaCompra(VpaDPedidoCompra : TRBDPedidoCompraCorpo):string;
begin
  result := '';
  if (DiasPorPeriodo(VpaDPedidoCompra.DatPedido,VpaDPedidoCompra.DatPrevista) > varia.QtdDiasPendenciaCompras) or
     (DiasPorPeriodo(VpaDPedidoCompra.DatPedido,VpaDPedidoCompra.DatRenegociado) > varia.QtdDiasPendenciaCompras)then
  begin
    AdicionaSQLAbreTabela(Cadastro,'Select * from PENDENCIACOMPRA ');
    Cadastro.insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDPedidoCompra.CodFilial;
    Cadastro.FieldByName('SEQPEDIDO').AsInteger := VpaDPedidoCompra.SeqPedido;
    Cadastro.FieldByName('DATPENDENCIA').AsDateTime := now;
    Cadastro.FieldByName('SEQPENDENCIA').AsInteger := RSeqPendenciaCompraDisponivel(VpaDPedidoCompra.CodFilial,VpaDPedidoCompra.SeqPedido);
    Cadastro.post;
    Result := Cadastro.AMensagemErroGravacao;
    Cadastro.close;
  end;
end;

{******************************************************************************}
function TRBFunPedidoCompra.ProdutosEmAberto(VpaDPedidoCompraCorpo: TRBDPedidoCompraCorpo): Boolean;
var
  VpfLaco: Integer;
  VpfDProdutoPedidoCompra: TRBDProdutoPedidoCompra;
begin
  Result:= False;
  for VpfLaco:= 0 to VpaDPedidoCompraCorpo.Produtos.Count-1 do
  begin
    VpfDProdutoPedidoCompra:= TRBDProdutoPedidoCompra(VpaDPedidoCompraCorpo.Produtos.Items[VpfLaco]);
    if VpfDProdutoPedidoCompra.QtdBaixado < VpfDProdutoPedidoCompra.QtdProduto then
    begin
      Result:= True;
      Break;
    end;
  end;
end;

{******************************************************************************}
function TRBFunPedidoCompra.GravaVinculoNotaFiscal(VpaDNota: TRBDNotaFiscalFor; VpaListaPedidos: TList): STring;
var
  VpfLaco: Integer;
  VpfDPedidoCompraCorpo: TRBDPedidoCompraCorpo;
begin
  Result:= '';
  for VpfLaco:= 0 to VpaListaPedidos.Count-1 do
  begin
    VpfDPedidoCompraCorpo:= TRBDPedidoCompraCorpo(VpaListaPedidos.Items[VpfLaco]);
    AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM PEDIDOCOMPRANOTAFISCAL'+
                                   ' WHERE CODFILIAL = '+IntToStr(VpaDNota.CodFilial)+
                                   ' AND SEQNOTA = '+IntToStr(VpaDNota.SeqNota)+
                                   ' AND SEQPEDIDO = '+IntToStr(VpfDPedidoCompraCorpo.SeqPedido));
    if Cadastro.Eof then
    begin
      Cadastro.Insert;
      Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDNota.CodFilial;
      Cadastro.FieldByName('SEQNOTA').AsInteger:= VpaDNota.SeqNota;
      Cadastro.FieldByName('SEQPEDIDO').AsInteger:= VpfDPedidoCompraCorpo.SeqPedido;
      Cadastro.Post;
      Result := Cadastro.AMensagemErroGravacao;
      if Cadastro.AErronaGravacao then
        Break;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.ConsultaNotasFiscais(VpaSeqPedido: Integer);
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM PEDIDOCOMPRANOTAFISCAL'+
                               ' WHERE SEQPEDIDO = '+IntToStr(VpaSeqPedido));
  while not Tabela.Eof do
  begin
    FNovaNotaFiscaisFor:= TFNovaNotaFiscaisFor.CriarSDI(Application,'',True);
    FNovaNotaFiscaisFor.ConsultaNota(Tabela.FieldByName('CODFILIAL').AsInteger,
                                     Tabela.FieldByName('SEQNOTA').AsInteger);
    FNovaNotaFiscaisFor.Free;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFunPedidoCompra.AdicionaTodosProdutosFornecedor(VpaCodFornecedor: Integer; VpaDPedidoCompra: TRBDPedidoCompraCorpo);
Var
  VpfDPedidoItem : TRBDProdutoPedidoCompra;
begin
  FreeTObjectsList(VpaDPedidoCompra.Produtos);
  AdicionaSQLAbreTabela(Tabela,'Select PFO.SEQPRODUTO, PFO.QTDMINIMACOMPRA, PFO.VALUNITARIO,  '+
                               ' PFO.DESREFERENCIA, PFO.CODCOR, PFO.PERIPI, '+
                               ' PRO.C_COD_PRO '+
                               ' from PRODUTOFORNECEDOR PFO, CADPRODUTOS PRO '+
                               ' Where CODCLIENTE = '+IntToStr(VpaCodFornecedor)+
                               ' AND PRO.I_SEQ_PRO = PFO.SEQPRODUTO');
  While not Tabela.eof do
  begin
    VpfDPedidoItem := VpaDPedidoCompra.AddProduto;
    VpfDPedidoItem.SeqProduto := Tabela.FieldByname('SEQPRODUTO').AsInteger;
    FunProdutos.ExisteProduto(Tabela.FieldByname('C_COD_PRO').AsString,VpfDPedidoItem);
    IF Tabela.FieldByname('QTDMINIMACOMPRA').AsFloat <> 0 then
      VpfDPedidoItem.QtdProduto := Tabela.FieldByname('QTDMINIMACOMPRA').AsFloat;
    VpfDPedidoItem.QtdSolicitada := VpfDPedidoItem.QtdProduto;
    IF Tabela.FieldByname('VALUNITARIO').AsFloat <> 0 then
      VpfDPedidoItem.ValUnitario := Tabela.FieldByname('VALUNITARIO').AsFloat;
    VpfDPedidoItem.DesReferenciaFornecedor := Tabela.FieldByname('DESREFERENCIA').AsString;
    IF Tabela.FieldByname('CODCOR').AsInteger <> 0 then
    begin
      VpfDPedidoItem.CodCor := Tabela.FieldByname('CODCOR').AsInteger;
      FunProdutos.ExisteCor(IntTostr(VpfDPedidoItem.CodCor),VpfDPedidoItem.NomCor);
    end;
    VpfDPedidoItem.ValTotal := VpfDPedidoItem.QtdProduto * VpfDPedidoItem.ValUnitario;
    VpfDPedidoItem.PerIPI := Tabela.FieldByname('PERIPI').AsFloat;
    Tabela.next;
  end;
  Tabela.close;
end;

end.

