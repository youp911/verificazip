unit ANovoPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons, Mask,
  Localizacao, ComCtrls, Grids, CGrades, UnDados, DBKeyViolation, UnPedidoCompra,
  numericos, FunData, UnDadosProduto, Constantes, Menus, Db, DBTables, UnSolicitacaoCompra,
  DBGrids, Tabela, IdBaseComponent, IdComponent, IdTCPConnection, UnDadosLocaliza,
  IdTCPClient, IdMessageClient, IdSMTP, FMTBcd, DBClient, SqlExpr;

type
  TFNovoPedidoCompra = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BCadastrar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BEnviar: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    ValidaGravacao: TValidaGravacao;
    PopupMenu1: TPopupMenu;
    VisualizarOrdemProduo1: TMenuItem;
    Aux: TSQLQuery;
    Estagios: TSQL;
    DataEstagios: TDataSource;
    EstagiosDATESTAGIO: TSQLTimeStampField;
    EstagiosDESMOTIVO: TWideStringField;
    EstagiosNOMEST: TWideStringField;
    EstagiosC_NOM_USU: TWideStringField;
    PageControl1: TPageControl;
    PPedidos: TTabSheet;
    PEstagio: TTabSheet;
    ScrollBox1: TScrollBox;
    GEstagios: TGridIndice;
    PopupMenu2: TPopupMenu;
    AdicionarTodososProdutosdoFornecedor1: TMenuItem;
    PanelColor4: TPanelColor;
    PanelCabecalho: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BFornecedor: TSpeedButton;
    LFornecedor: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LFilial: TLabel;
    BCondicoesPgto: TSpeedButton;
    LCondicoesPagto: TLabel;
    BFormaPagto: TSpeedButton;
    LFormaPagamento: TLabel;
    Label3: TLabel;
    LUsuario: TLabel;
    Bevel1: TBevel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label14: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    SpeedButton3: TSpeedButton;
    LDataRenegociado: TLabel;
    ENumero: TEditColor;
    EData: TMaskEditColor;
    EPrazo: TMaskEditColor;
    EFornecedor: TEditLocaliza;
    EContato: TEditColor;
    ECondicoesPagto: TEditLocaliza;
    EFormaPagto: TEditLocaliza;
    EHora: TMaskEditColor;
    EEmailComprador: TEditColor;
    EFilial: TEditLocaliza;
    EUsuario: TEditLocaliza;
    EComprador: TEditLocaliza;
    ETelefone: TEditColor;
    EFilialFaturamento: TEditLocaliza;
    EDatRenegociado: TMaskEditColor;
    PanelColor2: TPanelColor;
    Paginas: TPageControl;
    PProdutos: TTabSheet;
    GProdutos: TRBStringGridColor;
    ECor: TEditLocaliza;
    PFracaoOP: TTabSheet;
    GFracaoOP: TRBStringGridColor;
    PanelColor3: TPanelColor;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    EObservacoes: TMemoColor;
    RDesconto: TRadioGroup;
    RTipoDesconto: TRadioGroup;
    EValTotal: Tnumerico;
    EValor: Tnumerico;
    EValorFrete: Tnumerico;
    EValProdutos: Tnumerico;
    EValIPI: Tnumerico;
    Label26: TLabel;
    SpeedButton5: TSpeedButton;
    Label27: TLabel;
    ECodTransportadora: TEditLocaliza;
    Label28: TLabel;
    CEmitente: TRadioButton;
    CDestinatario: TRadioButton;
    ETamanho: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GFracaoOPCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GFracaoOPDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GFracaoOPGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GFracaoOPMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GFracaoOPNovaLinha(Sender: TObject);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure RTipoDescontoClick(Sender: TObject);
    procedure EFornecedorChange(Sender: TObject);
    procedure EFornecedorCadastrar(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EValorChange(Sender: TObject);
    procedure EFornecedorEnter(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure VisualizarOrdemProduo1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure GFracaoOPSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ECompradorCadastrar(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
    procedure EEmailCompradorKeyPress(Sender: TObject; var Key: Char);
    procedure EFornecedorAlterar(Sender: TObject);
    procedure AdicionarTodososProdutosdoFornecedor1Click(Sender: TObject);
    procedure ECodTransportadoraCadastrar(Sender: TObject);
    procedure ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EContatoChange(Sender: TObject);
  private
    VprAcao,
    VprIndSolicitacaoCompra : Boolean;
    VprOperacao: TRBDOperacaoCadastro;
    VprCorAnterior,
    VprFornecedorAnterior,
    VprProdutoAnterior: String;
    VprProdutosPendentes,
    VprProdutosFinalizados : Tlist;
    VprDPedidoCorpo: TRBDPedidoCompraCorpo;
    VprDProdutoPedido: TRBDProdutoPedidoCompra;
    VprDFracaoOPPedido: TRBDFracaoOPPedidoCompra;
    FunPedidoCompra: TRBFunPedidoCompra;
    FunSolicitacao: TRBFunSolicitacaoCompra;
    procedure EstadoBotoes(VpaEstado: Boolean);
    procedure CarTitulosGrade;
    procedure InicializaTela;
    function ExisteProduto: Boolean;
    function ExisteCor: Boolean;
    function ExisteFracao: Boolean;
    function ExisteClienteFracaoOP: Boolean;
    function FracaoOPJaUsada: Boolean;
    function LocalizaProduto: Boolean;
    function DadosValidosCorpo: String;
    procedure CarDClasseCorpo;
    procedure CarDClasseOP;
    procedure CarDClasseProdutos;
    procedure CarDTela;
    procedure CarDFornecedorTela;
    procedure BloquearTela;
    procedure VerificaPrecoFornecedor;
    procedure CalculaValorTotal;
    procedure CalculaValorTotalProduto;
    procedure CalculaValorUnitarioProduto;
    procedure CarDDesconto;
    procedure CarDValoresTela;
    procedure CarDValorTotal;
    procedure PosEstagios;
    procedure CarDProdutoOrcamentoTela(VpaProdutos: TList);
    procedure CarDFracoesOrcamentoTela(VpaFracoes : TList);
    procedure VerificaProdutoNaoRecebido(VpaDProdutoPedido: TRBDProdutoPedidoCompra);
    procedure AtualizaReferenciaFornecedor;
  public
    function NovoPedido: Boolean;
    function NovoPedidoProdutosPendentes(VpaProdutos, VpaFracoesOP, VpaProdutosPendentes, VpaProdutosFinalizados: TList): Boolean;
    function Alterar(VpaCodFilial, VpaSeqPedido: Integer): Boolean;
    function Apagar(VpaCodFilial, VpaSeqPedido: Integer): Boolean;
    procedure Consultar(VpaCodFilial, VpaSeqPedido: Integer);
  end;

var
  FNovoPedidoCompra: TFNovoPedidoCompra;

implementation
uses
  APrincipal, UnProdutos, ALocalizaProdutos, ConstMsg, FunString, FunObjeto,
  ANovoCliente, FunSQL, UnCrystal, AOrdemProducaoGenerica, UnClientes,
  ACompradores, ANovoProdutoPro, ANovaTransportadora, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoPedidoCompra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprIndSolicitacaoCompra := false;
  if Varia.EstagioInicialCompras = 0 then
    aviso('ESTAGIO INICIAL COMPRAS NÃO PREENCHIDO!!!'#13'É necessário preencher nas configurações gerais o estagio inicial do pedido de compra.');
  VprAcao:= False;
  VprDPedidoCorpo:= TRBDPedidoCompraCorpo.Cria;
  FunPedidoCompra:= TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
  CarTitulosGrade;

  GProdutos.ADados:= VprDPedidoCorpo.Produtos;
  GFracaoOP.ADados:= VprDPedidoCorpo.FracaoOP;
  GProdutos.CarregaGrade;
  GFracaoOP.CarregaGrade;
  PageControl1.ActivePage:= PPedidos;
  Paginas.ActivePage:= PProdutos;
  ActiveControl:= EFornecedor;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoPedidoCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunPedidoCompra.Free;
  VprDPedidoCorpo.Free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFNovoPedidoCompra.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarTitulosGrade;
begin
  GProdutos.Cells[1,0]:= 'Código';
  GProdutos.Cells[2,0]:= 'Produto';
  GProdutos.Cells[3,0]:= 'Código';
  GProdutos.Cells[4,0]:= 'Cor';
  GProdutos.Cells[5,0]:= 'Código';
  GProdutos.Cells[6,0]:= 'Tamanho';
  GProdutos.Cells[7,0]:= 'UM';
  GProdutos.Cells[8,0]:= 'Qtd Solicitado';
  GProdutos.Cells[9,0]:= 'Qtd Pedido';
  GProdutos.Cells[10,0]:= 'Valor Unitário';
  GProdutos.Cells[11,0]:= 'Valor Total';
  GProdutos.Cells[12,0]:= 'Ref. Fornecedor';
  GProdutos.Cells[13,0]:= '%IPI';

  GFracaoOP.Cells[1,0]:= 'Filial';
  GFracaoOP.Cells[2,0]:= 'Ordem Produção';
  GFracaoOP.Cells[3,0]:= 'Fração';
  GFracaoOP.Cells[4,0]:= 'Cliente';

  if not Config.EstoquePorCor then
  begin
    GProdutos.ColWidths[2] := 450;
    GProdutos.ColWidths[3] := -1;
    GProdutos.ColWidths[4] := -1;
    GProdutos.TabStops[3] := false;
    GProdutos.TabStops[4] := false;
  end;
  if not config.EstoquePorTamanho then
  begin
    GProdutos.ColWidths[5] := -1;
    GProdutos.ColWidths[6] := -1;
    GProdutos.TabStops[5] := false;
    GProdutos.TabStops[6] := false;
  end;

end;

{******************************************************************************}
procedure TFNovoPedidoCompra.InicializaTela;
begin
  Paginas.ActivePage:= PProdutos;
  ScrollBox1.VertScrollBar.Position := 0;
  AlterarVisibleDet([LDataRenegociado,EDatRenegociado],false);

  VprDPedidoCorpo.free;
  VprDPedidoCorpo := TRBDPedidoCompraCorpo.cria;
  GProdutos.ADados := VprDPedidoCorpo.Produtos;
  GFracaoOP.ADados := VprDPedidoCorpo.FracaoOP;
  GProdutos.CarregaGrade;
  GFracaoOP.CarregaGrade;

  VprDPedidoCorpo.CodFilial := varia.CodigoEmpFil;
  VprDPedidoCorpo.CodEstagio := varia.EstagioInicialCompras;
  VprDPedidoCorpo.CodUsuario:= Varia.CodigoUsuario;
  VprDPedidoCorpo.CodComprador:= Varia.CodComprador;
  VprDPedidoCorpo.CodFilialFaturamento := varia.CodFilialFaturamentoCompras;
  VprDPedidoCorpo.NumDiasAtraso:= 0;
  VprDPedidoCorpo.DesSituacao:= 'A';
  VprDPedidoCorpo.IndCancelado:= 'N';
  VprDPedidoCorpo.DatPedido:= Date;
  VprDPedidoCorpo.HorPedido:= now;

  EData.Text:= FormatDateTime('DD/MM/YYYY',VprDPedidoCorpo.DatPedido);
  EHora.Text:= FormatDateTime('HH:MM',VprDPedidoCorpo.HorPedido);

  EFilial.AInteiro:= VprDPedidoCorpo.CodFilial;
  EUsuario.AInteiro:= VprDPedidoCorpo.CodUsuario;
  EComprador.AInteiro:= VprDPedidoCorpo.CodComprador;
  EFilialFaturamento.AInteiro := VprDPedidoCorpo.CodFilialFaturamento;
  AtualizaLocalizas(PanelCabecalho);

  RDesconto.ItemIndex:= 0;
  RTipoDesconto.ItemIndex:= 0;
end;

{******************************************************************************}
function TFNovoPedidoCompra.ExisteProduto: Boolean;
begin
  Result:= False;
  if GProdutos.Cells[1,GProdutos.ALinha] <> '' then
  begin
    if GProdutos.Cells[1,GProdutos.ALinha] = VprProdutoAnterior then
      Result:= True
    else
    begin
      Result:= FunProdutos.ExisteProduto(GProdutos.Cells[1,GProdutos.ALinha],VprDProdutoPedido);
      if Result then
      begin
        VprProdutoAnterior:= VprDProdutoPedido.CodProduto;
        VprCorAnterior:= '';

        GProdutos.Cells[2,GProdutos.ALinha]:= VprDProdutoPedido.NomProduto;
        GProdutos.Cells[7,GProdutos.ALinha]:= VprDProdutoPedido.DesUM;
        GProdutos.Cells[8,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPedido.Qtdproduto);
        GProdutos.Cells[10,GProdutos.ALinha]:= FormatFloat(Varia.MascaraValor,VprDProdutoPedido.ValUnitario);
        GProdutos.Cells[13,GProdutos.ALinha]:= FormatFloat('0.00',VprDProdutoPedido.PerIPI);

        VerificaPrecoFornecedor;
      end;
    end;
  end
end;

{******************************************************************************}
function TFNovoPedidoCompra.ExisteCor: Boolean;
begin
  Result:= True;
  if GProdutos.Cells[3,GProdutos.ALinha] <> '' then
  begin
    if (GProdutos.Cells[3,GProdutos.ALinha] = VprCorAnterior) then
      Result:= True
    else
    begin
      Result:= FunProdutos.ExisteCor(GProdutos.Cells[3,GProdutos.ALinha],VprDProdutoPedido.NomCor);
      if Result then
      begin
        GProdutos.Cells[4,GProdutos.ALinha]:= VprDProdutoPedido.NomCor;

        VprCorAnterior:= GProdutos.Cells[3,GProdutos.ALinha];

        VprDProdutoPedido.CodCor:= StrToInt(GProdutos.Cells[3,GProdutos.ALinha]);
        VprDPedidoCorpo.CodCliente:= EFornecedor.AInteiro;
        VerificaPrecoFornecedor;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovoPedidoCompra.LocalizaProduto: Boolean;
var
  VpfClaFiscal: String;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDProdutoPedido,eFornecedor.Ainteiro);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprProdutoAnterior := VprDProdutoPedido.CodProduto;
    VprCorAnterior:= '';

    GProdutos.Cells[1,GProdutos.ALinha]:= VprDProdutoPedido.CodProduto;
    GProdutos.Cells[2,GProdutos.ALinha]:= VprDProdutoPedido.NomProduto;
    GProdutos.Cells[7,GProdutos.ALinha]:= VprDProdutoPedido.DesUM;
    GProdutos.Cells[8,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPedido.QtdSolicitada);
    GProdutos.Cells[9,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPedido.Qtdproduto);
    GProdutos.Cells[10,GProdutos.ALinha]:= FormatFloat(Varia.MascaraValor,VprDProdutoPedido.ValUnitario);
    GProdutos.Cells[13,GProdutos.ALinha]:= FormatFloat('0.00',VprDProdutoPedido.PerIPI);
    if config.EstoquePorTamanho then
    begin
      ETamanho.AInteiro := VprDProdutoPedido.CodTamanho;
      ETamanho.Atualiza;
    end;

    VerificaPrecoFornecedor;
    GProdutos.Col:= 3;
  end;
end;

{******************************************************************************}
function TFNovoPedidoCompra.NovoPedido: Boolean;
begin
  VprOperacao:= ocInsercao;
  EstadoBotoes(False);

  InicializaTela;

  ValidaGravacao.execute;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFNovoPedidoCompra.NovoPedidoProdutosPendentes(VpaProdutos, VpaFracoesOP, VpaProdutosPendentes, VpaProdutosFinalizados: TList): Boolean;
begin
  VprIndSolicitacaoCompra := true;
  VprProdutosPendentes := VpaProdutosPendentes;
  VprProdutosFinalizados := VpaProdutosFinalizados;
  VprOperacao:= ocInsercao;
  EstadoBotoes(False);

  InicializaTela;

  CarDProdutoOrcamentoTela(VpaProdutos);
  CarDFracoesOrcamentoTela(VpaFracoesOP);

  ValidaGravacao.execute;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFNovoPedidoCompra.DadosValidosCorpo: String;
begin
  Result:= '';
  try
    if DeletaChars(DeletaChars(EPrazo.Text,' '),'/') <> '' then
      StrToDate(EPrazo.Text);
  except
    Result:= 'PRAZO DE ENTREGA NÃO PREENCHIDO!!!'#13'É necessário preencher o prazo de entrega';
    ActiveControl:= EPrazo;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= DadosValidosCorpo;
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    CarDClasseCorpo;
    VpfResultado:= FunPedidoCompra.GravaDPedidoCompra(VprDPedidoCorpo);

    ENumero.AInteiro:= VprDPedidoCorpo.SeqPedido;
    EstadoBotoes(True);
    if VpfResultado = '' then
    begin
      if VprIndSolicitacaoCompra then
        FunSolicitacao.FinalizarProdutos(VprDPedidoCorpo.SeqPedido,VprDPedidoCorpo.Produtos,VprProdutosPendentes,VprProdutosFinalizados);
    end
    else
      aviso(VpfResultado);
    EstadoBotoes(True);
    VprAcao:= True;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.EstadoBotoes(VpaEstado: Boolean);
begin
  BCadastrar.Enabled:= VpaEstado;
  BGravar.Enabled:= not VpaEstado;
  BCancelar.Enabled:= not VpaEstado;
  BEnviar.Enabled:= VpaEstado;
  BImprimir.Enabled:= VpaEstado;
  BFechar.Enabled:= VpaEstado;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProdutoPedido:= TRBDProdutoPedidoCompra(VprDPedidoCorpo.Produtos.Items[VpaLinha-1]);

  GProdutos.Cells[1,GProdutos.ALinha]:= VprDProdutoPedido.CodProduto;
  GProdutos.Cells[2,GProdutos.ALinha]:= VprDProdutoPedido.NomProduto;
  if VprDProdutoPedido.CodCor <> 0 then
    GProdutos.Cells[3,GProdutos.ALinha]:= IntToStr(VprDProdutoPedido.CodCor)
  else
    GProdutos.Cells[3,GProdutos.ALinha]:= '';
  GProdutos.Cells[4,GProdutos.ALinha]:= VprDProdutoPedido.NomCor;
  if VprDProdutoPedido.CodTamanho <> 0 then
    GProdutos.Cells[5,GProdutos.ALinha]:= IntToStr(VprDProdutoPedido.CodTamanho)
  else
    GProdutos.Cells[5,GProdutos.ALinha]:= '';
  GProdutos.Cells[6,GProdutos.ALinha]:= VprDProdutoPedido.NomTamanho;
  GProdutos.Cells[7,GProdutos.ALinha]:= VprDProdutoPedido.DesUM;
  if VprDProdutoPedido.QtdSolicitada <> 0 then
    GProdutos.Cells[8,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPedido.QtdSolicitada)
  else
    GProdutos.Cells[8,GProdutos.ALinha]:= '';
  if VprDProdutoPedido.QtdProduto <> 0 then
    GProdutos.Cells[9,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPedido.QtdProduto)
  else
    GProdutos.Cells[9,GProdutos.ALinha]:= '';
  if VprDProdutoPedido.ValUnitario <> 0 then
    GProdutos.Cells[10,GProdutos.ALinha]:= FormatFloat(Varia.MascaraValor,VprDProdutoPedido.ValUnitario)
  else
    GProdutos.Cells[10,GProdutos.ALinha]:= '';
  CalculaValorTotalProduto;
  CalculaValorTotal;
  if VprDProdutoPedido.ValTotal <> 0 then
    GProdutos.Cells[11,GProdutos.ALinha]:= FormatFloat(Varia.MascaraValor,VprDProdutoPedido.ValTotal)
  else
    GProdutos.Cells[11,GProdutos.ALinha]:= '';
  GProdutos.Cells[12,GProdutos.ALinha]:= VprDProdutoPedido.DesReferenciaFornecedor;
  if VprDProdutoPedido.ValTotal <> 0 then
    GProdutos.Cells[13,GProdutos.ALinha]:= FormatFloat('0.00',VprDProdutoPedido.PerIPI)
  else
    GProdutos.Cells[13,GProdutos.ALinha]:= '';
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;

  ExisteCor;
  if GProdutos.Cells[1,GProdutos.ALinha] = '' then
  begin
    VpaValidos:= False;
    aviso('PRODUTO NÃO PREENCHIDO!!!'#13'É necessário preencher o produto.');
    GProdutos.Col:= 1;
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos:= False;
      aviso('PRODUTO NÃO CADASTRADO!!!'#13'É necessário digitar um produto cadastrado.');
      GProdutos.Col:= 1;
    end
    else
      if (GProdutos.Cells[3,GProdutos.ALinha] <> '') then
      begin
        if not Existecor then
        begin
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          GProdutos.Col := 3;
        end;
      end
      else
        if config.ExigirCorNotaEntrada then
        begin
          // se a cor for igual a '' e estiver configurado para controlar estoque
          // pela cor, entao fazer checagem direta.
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          GProdutos.Col := 3;
        end;

  if VpaValidos then
  begin
    if not ETamanho.AExisteCodigo(GProdutos.Cells[5,GProdutos.ALinha]) then
    begin
      VpaValidos := false;
      Aviso('TAMANHO NÃO CADASTRADO!!!'#13'É necessário digitar um tamanho cadastrado.');
      GProdutos.Col := 5;
    end
    else
      if VprDProdutoPedido.UnidadesParentes.IndexOf(GProdutos.Cells[7,GProdutos.ALinha]) < 0 then
      begin
        VpaValidos:= False;
        aviso(CT_UNIDADEVAZIA);
        GProdutos.Col:= 7;
      end
      else
        if GProdutos.Cells[8,GProdutos.ALinha] = '' then
        begin
          VpaValidos:= False;
          aviso('QUANTIDADE SOLICITADA NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade solicitada.');
          GProdutos.Col:= 8;
        end
        else
          if GProdutos.Cells[9,GProdutos.ALinha] = '' then
          begin
            VpaValidos:= False;
            aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do produto.');
            GProdutos.Col:= 9;
          end
          else
          begin
            CalculaValorTotalProduto;
            if GProdutos.Cells[11,GProdutos.ALinha] <> '' then
              if StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.')) <> 0 then
                CalculaValorUnitarioProduto;
            if GProdutos.Cells[10,GProdutos.ALinha] = '' then
            begin
              VpaValidos:= False;
              aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário preencher o valor unitário.');
              GProdutos.Col:= 10;
            end;
          end;
  end;

  CalculaValorTotalProduto;
  if VpaValidos then
  begin
    CarDClasseProdutos;

    VerificaProdutoNaoRecebido(VprDProdutoPedido);

    if VprDProdutoPedido.QtdSolicitada = 0 then
    begin
      VpaValidos:= False;
      aviso('QUANTIDADE SOLICITADA NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade solicitada.');
      GProdutos.Col:= 8;
    end
    else
      if VprDProdutoPedido.QtdProduto = 0 then
      begin
        VpaValidos:= False;
        aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do produto');
        GProdutos.Col:= 9;
      end
      else
        if VprDProdutoPedido.ValUnitario = 0 then
        begin
          VpaValidos:= False;
          aviso('VALOR UNITÁRIO NÃO PREENCHIDO!!!'#13'É necessário preencher o valor unitário.');
          GProdutos.Col:= 10;
        end
        else
          if VprDProdutoPedido.PerIPI >100 then
          begin
            VpaValidos:= False;
            aviso('PERCENTUAL DE IPI INVÁLIDO!!!'#13'O percentual de IPI não pode ser maior que 99%');
            GProdutos.Col:= 13;
          end;
    CalculaValorTotal;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.VerificaProdutoNaoRecebido(VpaDProdutoPedido: TRBDProdutoPedidoCompra);
var
  VpfResultado: String;
  VpfQuantidade: Double;
begin
  VpfResultado:= FunPedidoCompra.VerificaProdutoNaoRecebido(VprDPedidoCorpo.CodFilial,
                                                            VprDPedidoCorpo.SeqPedido,
                                                            VpaDProdutoPedido.SeqProduto,
                                                            VpaDProdutoPedido.CodCor,
                                                            VpfQuantidade);
  if VpfResultado <> '' then
  begin
    if Confirmacao(VpfResultado) then
    begin
      // adicionar a quantidade ao produto daquele pedido
      // se estiver gerando a partir de uma solicitacao entao
      //   criar os vinculos
      // descontar ou remover o produto do pedido atual, dependendo da quantidade
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.AtualizaReferenciaFornecedor;
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VprDPedidoCorpo.Produtos.Count - 1 do
  begin
    GProdutos.row := VpfLaco +1;
    VprDProdutoPedido := TRBDProdutoPedidoCompra(VprDPedidoCorpo.Produtos.Items[VpfLaco]);
    VerificaPrecoFornecedor;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDClasseProdutos;
begin
  VprDProdutoPedido.CodProduto:= GProdutos.Cells[1,GProdutos.ALinha];
  VprDProdutoPedido.NomProduto:= GProdutos.Cells[2,GProdutos.ALinha];
  if GProdutos.Cells[3,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.CodCor:= StrToInt(GProdutos.Cells[3,GProdutos.ALinha])
  else
    VprDProdutoPedido.CodCor:= 0;
  VprDProdutoPedido.NomCor:= GProdutos.Cells[4,GProdutos.ALinha];
  if GProdutos.Cells[5,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.CodTamanho:= StrToInt(GProdutos.Cells[5,GProdutos.ALinha])
  else
    VprDProdutoPedido.CodTamanho:= 0;
  VprDProdutoPedido.NomTamanho:= GProdutos.Cells[6,GProdutos.ALinha];
  VprDProdutoPedido.DesUM:= GProdutos.Cells[7,GProdutos.ALinha];
  if GProdutos.Cells[8,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.QtdSolicitada:= StrToFloat(DeletaChars(GProdutos.Cells[8,GProdutos.ALinha],'.'))
  else
    VprDProdutoPedido.QtdSolicitada:= 0;
  if GProdutos.Cells[9,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.QtdProduto:= StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'))
  else
    VprDProdutoPedido.QtdProduto:= 0;
  if GProdutos.Cells[10,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.ValUnitario:= StrToFloat(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.'))
  else
    VprDProdutoPedido.ValUnitario:= 0;
  if GProdutos.Cells[11,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.ValTotal:= StrToFloat(DeletaChars(GProdutos.Cells[11,GProdutos.ALinha],'.'))
  else
    VprDProdutoPedido.ValTotal:= 0;
  CalculaValorTotal;
  VprDProdutoPedido.DesReferenciaFornecedor:= GProdutos.Cells[12,GProdutos.ALinha];
  if GProdutos.Cells[13,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.PerIPI:= StrToFloat(DeletaChars(GProdutos.Cells[13,GProdutos.ALinha],'.'))
  else
    VprDProdutoPedido.PerIPI:= 0;
  if VprDProdutoPedido.QtdSolicitada > VprDProdutoPedido.QtdProduto then
    VprDProdutoPedido.QtdSolicitada := VprDProdutoPedido.QtdProduto;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GProdutosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    case GProdutos.Col of
      1: LocalizaProduto;
      3: ECor.AAbreLocalizacao;
      5: ETamanho.AAbreLocalizacao;
    end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.ECorRetorno(Retorno1, Retorno2: String);
begin
  GProdutos.Cells[3,GProdutos.ALinha]:= Retorno1;
  GProdutos.Cells[4,GProdutos.ALinha]:= Retorno2;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = '.' then
    case GProdutos.Col of
      8: Key:= DecimalSeparator;
      9: Key:= DecimalSeparator;
     10: Key:= DecimalSeparator;
     11: Key:= DecimalSeparator;
    end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDPedidoCorpo.Produtos.Count > 0 then
  begin
    VprDProdutoPedido:= TRBDProdutoPedidoCompra(VprDPedidoCorpo.Produtos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior:= VprDProdutoPedido.CodProduto;
    VprCorAnterior:= IntToStr(VprDProdutoPedido.CodCor);
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GProdutosNovaLinha(Sender: TObject);
begin
  VprDProdutoPedido:= VprDPedidoCorpo.AddProduto;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egEdicao,egInsercao] then
  begin
    if GProdutos.AColuna <> ACol then
    begin
      case GProdutos.AColuna of
        1: if not ExisteProduto then
             if not LocalizaProduto then
             begin
               GProdutos.Cells[1,GProdutos.ALinha]:= '';
               GProdutos.Cells[2,GProdutos.ALinha]:= '';
               Abort;
             end;
        3: if not ExisteCor then
           begin
             GProdutos.Cells[3,GProdutos.ALinha]:= '';
             GProdutos.Cells[4,GProdutos.ALinha]:= '';
             Abort;
           end;
        5 : if not ETamanho.AExisteCodigo(GProdutos.Cells[5,GProdutos.ALinha]) then
              if not ETamanho.AAbreLocalizacao then
              begin
               GProdutos.Cells[5,GProdutos.ALinha]:= '';
               GProdutos.Cells[6,GProdutos.ALinha]:= '';
               Abort;
              end;
        9,10: begin
               CalculaValorTotalProduto;
             end;
       11: begin
             CalculaValorUnitarioProduto;
           end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GFracaoOPCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFracaoOPPedido:= TRBDFracaoOPPedidoCompra(VprDPedidoCorpo.FracaoOP.Items[VpaLinha-1]);

  if VprDFracaoOPPedido.CodFilialFracao <> 0 then
    GFracaoOP.Cells[1,GFracaoOP.ALinha]:= IntToStr(VprDFracaoOPPedido.CodFilialFracao)
  else
    GFracaoOP.Cells[1,GFracaoOP.ALinha]:= '';
  if VprDFracaoOPPedido.SeqOrdem <> 0 then
    GFracaoOP.Cells[2,GFracaoOP.ALinha]:= IntToStr(VprDFracaoOPPedido.SeqOrdem)
  else
    GFracaoOP.Cells[2,GFracaoOP.ALinha]:= '';
  if VprDFracaoOPPedido.SeqFracao <> 0 then
    GFracaoOP.Cells[3,GFracaoOP.ALinha]:= IntToStr(VprDFracaoOPPedido.SeqFracao)
  else
    GFracaoOP.Cells[3,GFracaoOP.ALinha]:= '';
  GFracaoOP.Cells[4,GFracaoOP.ALinha]:= VprDFracaoOPPedido.NomCliente;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GFracaoOPDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if GFracaoOP.Cells[1,GFracaoOP.ALinha] = '' then
  begin
    aviso('FILIAL NÃO PREENCHIDA!!!'#13'É necessário digitar a filial.');
    VpaValidos:= False;
    GFracaoOP.Col:= 1;
  end
  else
    if GFracaoOP.Cells[2,GFracaoOP.ALinha] = '' then
    begin
      aviso('ORDEM DE PRODUÇÃO NÃO PREENCHIDA!!!'#13'É necessário digitar a ordem de produção.');
      VpaValidos:= False;
      GFracaoOP.Col:= 2;
    end;
  if VpaValidos then
  begin
    if GFracaoOP.Cells[3,GFracaoOP.ALinha] <> '' then
    // verificar se é diferente de '' para não dar erro na conversão
      if StrToInt(GFracaoOP.Cells[3,GFracaoOP.ALinha]) = 0 then
      // checar aqui para ele não fazer a rotina ExisteFracao, pesquizando SEQFRACAO com 0
      begin
        GFracaoOP.Cells[3,GFracaoOP.ALinha]:= '';
        GFracaoOP.Col:= 3;
      end;

    if not ExisteFracao then
    begin
      aviso('FRAÇÃO NÃO CADASTRADA!!!'#13'Informe uma fração que esteja cadastrada.');
      VpaValidos:= False;
      GFracaoOP.Col:= 1;
    end;
  end;
  if VpaValidos then
  begin
    CarDClasseOP;
    if FracaoOPJaUsada then
    begin
      aviso('FRACAO OP JÁ UTILIZADA!!!'#13'Informe uma fração op que ainda não esteja em uso.');
      VpaValidos:= False;
      GFracaoOP.Col:= 1;
    end;

    if StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha]) = 0 then
    begin
      GFracaoOP.Cells[1,GFracaoOP.ALinha]:= '';
      GFracaoOP.Col:= 1;
    end
    else
      if StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha]) = 0 then
      begin
        GFracaoOP.Cells[2,GFracaoOP.ALinha]:= '';
        GFracaoOP.Col:= 2;
      end;


  end;
end;

{******************************************************************************}
function TFNovoPedidoCompra.ExisteFracao: Boolean;
begin
  Result:= False;
  if (GFracaoOP.Cells[1,GFracaoOP.ALinha] <> '') and
     (GFracaoOP.Cells[2,GFracaoOP.ALinha] <> '') and
     (GFracaoOP.Cells[3,GFracaoOP.ALinha] <> '') then
    Result:= FunPedidoCompra.ExisteFracaoOP(StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha]),
                                            StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha]),
                                            StrToInt(GFracaoOP.Cells[3,GFracaoOP.ALinha]))
  else {para verificar apenas pela op}
    if (GFracaoOP.Cells[1,GFracaoOP.ALinha] <> '') and
       (GFracaoOP.Cells[2,GFracaoOP.ALinha] <> '') then
      Result:= FunPedidoCompra.ExisteOP(StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha]),
                                        StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha]));
end;

{******************************************************************************}
function TFNovoPedidoCompra.FracaoOPJaUsada: Boolean;
var
  VpfLaco: Integer;
  VpfPedidoFracaoOP: TRBDFracaoOPPedidoCompra;
begin
  Result:= False;
  for VpfLaco:= 0 to VprDPedidoCorpo.FracaoOP.Count - 1 do
  begin
    if VpfLaco+1 <> GFracaoOP.ALinha then // diferente da linha que estou modificando
    begin
      VpfPedidoFracaoOP:= TRBDFracaoOPPedidoCompra(VprDPedidoCorpo.FracaoOP[VpfLaco]);
      if (VpfPedidoFracaoOP.CodFilialFracao = VprDFracaoOPPedido.CodFilialFracao) and
         (VpfPedidoFracaoOP.SeqOrdem = VprDFracaoOPPedido.SeqOrdem) and
         (VpfPedidoFracaoOP.SeqFracao = VprDFracaoOPPedido.SeqFracao) then
      begin
        Result:= True;
        Break;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDClasseOP;
begin
  if GFracaoOP.Cells[1,GFracaoOP.ALinha] <> '' then
    VprDFracaoOPPedido.CodFilialFracao:= StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha])
  else
    VprDFracaoOPPedido.CodFilialFracao:= 0;
  if GFracaoOP.Cells[2,GFracaoOP.ALinha] <> '' then
    VprDFracaoOPPedido.SeqOrdem:= StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha])
  else
    VprDFracaoOPPedido.SeqOrdem:= 0;
  if GFracaoOP.Cells[3,GFracaoOP.ALinha] <> '' then
    VprDFracaoOPPedido.SeqFracao:= StrToInt(GFracaoOP.Cells[3,GFracaoOP.ALinha])
  else
    VprDFracaoOPPedido.SeqFracao:= 0;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GFracaoOPGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1,2,3: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GFracaoOPMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDPedidoCorpo.FracaoOP.Count > 0 then
    VprDFracaoOPPedido:= TRBDFracaoOPPedidoCompra(VprDPedidoCorpo.FracaoOP.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GFracaoOPNovaLinha(Sender: TObject);
begin
  VprDFracaoOPPedido:= VprDPedidoCorpo.AddFracaoOP;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDClasseCorpo;
begin
  VprDPedidoCorpo.CodFilial:= EFilial.AInteiro;
  VprDPedidoCorpo.CodFilialFaturamento := EFilialFaturamento.AInteiro;
  VprDPedidoCorpo.CodCliente:= EFornecedor.AInteiro;
  VprDPedidoCorpo.CodUsuario:= EUsuario.AInteiro;
  VprDPedidoCorpo.CodComprador:= EComprador.AInteiro;
  VprDPedidoCorpo.CodCondicaoPagto:= ECondicoesPagto.AInteiro;
  VprDPedidoCorpo.CodFormaPagto:= EFormaPagto.AInteiro;
  VprDPedidoCorpo.NomContato:= EContato.Text;
  VprDPedidoCorpo.DesEmailComprador:= EEmailComprador.Text;
  VprDPedidoCorpo.DesObservacao:= EObservacoes.Text;
  VprDPedidoCorpo.ValTotal:= EValTotal.AValor;
  VprDPedidoCorpo.ValFrete:= EValorFrete.AValor;
  VprDPedidoCorpo.CodTransportadora := ECodTransportadora.AInteiro;
  if CDestinatario.Checked then
    VprDPedidoCorpo.TipFrete := 2
  else
    VprDPedidoCorpo.TipFrete := 1;

  CarDDesconto;

  try
    if DeletaEspaco(DeletaChars(EPrazo.Text,'/')) = '' then
      VprDPedidoCorpo.DatPrevista:= MontaData(1,1,1900)
    else
      VprDPedidoCorpo.DatPrevista:= StrToDate(EPrazo.Text);
  except
    aviso('PRAZO DE ENTREGA INVÁLIDA!!!'#13'Informe o prazo de entrega corretamente.');
    ActiveControl:= EPrazo;
  end;
  if VprOperacao = ocinsercao then
    VprDPedidoCorpo.DatRenegociado := VprDPedidoCorpo.DatPrevista
  else
  begin
    try
      if DeletaEspaco(DeletaChars(EDatRenegociado.Text,'/')) = '' then
        VprDPedidoCorpo.DatRenegociado:= MontaData(1,1,1900)
      else
        VprDPedidoCorpo.DatRenegociado:= StrToDate(EDatRenegociado.Text);
    except
      aviso('PRAZO DE RENEGOCIADO INVÁLIDA!!!'#13'Informe a data renegociada corretamente.');
      ActiveControl:= EDatRenegociado;
    end;
  end;
end;


{******************************************************************************}
procedure TFNovoPedidoCompra.EFornecedorRetorno(Retorno1,
  Retorno2: String);
begin
  if VprOperacao in [ocinsercao,ocEdicao] then
  begin
    if EFornecedor.text <> VprFornecedorAnterior then
      CarDFornecedorTela;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDFornecedorTela;
var
  VpfDCliente: TRBDCliente;
begin
  VpfDCliente:= TRBDCliente.cria;
  VpfDCliente.CodCliente:= EFornecedor.AInteiro;
  FunClientes.CarDCliente(VpfDCliente,True);

  if VpfDCliente.NumDiasEntrega <> 0 then
    EPrazo.Text := FormatDateTime('DD/MM/YYYY',IncDia(date,VpfDCliente.NumDiasEntrega));
  EContato.Text:= VpfDCliente.NomContatoFornecedor;
  EEmailComprador.Text:= VpfDCliente.DesEmailFornecedor;
  ECondicoesPagto.AInteiro:= VpfDCliente.CodCondicaoPagamento;
  EFormaPagto.AInteiro:= VpfDCliente.CodFormaPagamento;
  ECondicoesPagto.Atualiza;
  EFormaPagto.Atualiza;
  EValorFrete.AValor:= VpfDCliente.ValFrete;
  ETelefone.Text := VpfDCliente.DesFone1;
  VpfDCliente.Free;
  AtualizaReferenciaFornecedor;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.RTipoDescontoClick(Sender: TObject);
begin
  if RTipoDesconto.ItemIndex = 0 then
    EValor.AMascara:= 'R$,0.00;-R$,0.00'
  else
    if RTipoDesconto.ItemIndex = 1 then
      EValor.AMascara:= ',0.00 %;,0.00 %';
  EValorChange(nil);
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.EFornecedorChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao.execute;
end;

{******************************************************************************}
function TFNovoPedidoCompra.Apagar(VpaCodFilial, VpaSeqPedido: Integer): Boolean;
begin
  Result:= False;
  VprOperacao := ocConsulta;
  FunPedidoCompra.CarDPedidoCompra(VpaCodFilial,VpaSeqPedido,VprDPedidoCorpo);
  CarDTela;

  Show;
  if Confirmacao('Deseja excluir o pedido de compra número '+IntToStr(VprDPedidoCorpo.SeqPedido)+'?') then
  begin
    FunPedidoCompra.ApagaPedido(VprDPedidoCorpo);
    Result:= True;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDTela;
begin
  EFilial.AInteiro:= VprDPedidoCorpo.CodFilial;
  EFilialFaturamento.AInteiro := VprDPedidoCorpo.CodFilialFaturamento;
  ENumero.AInteiro:= VprDPedidoCorpo.SeqPedido;
  EFornecedor.AInteiro:= VprDPedidoCorpo.CodCliente;
  EUsuario.AInteiro:= VprDPedidoCorpo.CodUsuario;
  EComprador.AInteiro:= VprDPedidoCorpo.CodComprador;
  ECondicoesPagto.AInteiro:= VprDPedidoCorpo.CodCondicaoPagto;
  EFormaPagto.AInteiro:= VprDPedidoCorpo.CodFormaPagto;
  ETelefone.Text:= VprDPedidoCorpo.DesTelefone;
  ECodTransportadora.AInteiro := VprDPedidoCorpo.CodTransportadora;
  ECodTransportadora.Atualiza;
  if VprDPedidoCorpo.TipFrete = 2 then
    CDestinatario.Checked := true
  else
    CEmitente.Checked := true;
  //verificar
  EContato.Text:= VprDPedidoCorpo.NomContato;
  EEmailComprador.Text:= VprDPedidoCorpo.DesEmailComprador;
  EObservacoes.Text:= VprDPedidoCorpo.DesObservacao;

  EData.Text:= FormatDateTime('DD/MM/YYYY',VprDPedidoCorpo.DatPedido);
  EHora.Text:= FormatDateTime('HH:MM',VprDPedidoCorpo.HorPedido);

  if VprDPedidoCorpo.DatRenegociado > MontaData(1,1,1900) then
    EDatRenegociado.Text:= FormatDateTime('DD/MM/YYYY',VprDPedidoCorpo.DatRenegociado)
  else
    EDatRenegociado.clear;

  if VprDPedidoCorpo.DatPrevista > MontaData(1,1,1900) then
    EPrazo.Text:= FormatDateTime('DD/MM/YYYY',VprDPedidoCorpo.DatPrevista)
  else
    EPrazo.clear;

  GProdutos.ADados:= VprDPedidoCorpo.Produtos;
  GFracaoOP.ADados:= VprDPedidoCorpo.FracaoOP;
  GProdutos.CarregaGrade;
  GFracaoOP.CarregaGrade;

  EValTotal.AValor:= VprDPedidoCorpo.ValTotal;
  EValorFrete.AValor:= VprDPedidoCorpo.ValFrete;
  CarDValoresTela;
  AtualizaLocalizas(ScrollBox1);
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDDesconto;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    VprDPedidoCorpo.PerDesconto:= 0;
    VprDPedidoCorpo.ValDesconto:= 0;
    if RTipoDesconto.ItemIndex = 0 then
    begin
      VprDPedidoCorpo.ValDesconto:= EValor.AValor;
      if RDesconto.ItemIndex = 0 then
        VprDPedidoCorpo.ValDesconto:= VprDPedidoCorpo.ValDesconto * (-1);
    end
    else
      if RTipoDesconto.ItemIndex = 1 then
      begin
        VprDPedidoCorpo.PerDesconto:= EValor.AValor;
        if RDesconto.ItemIndex = 0 then
          VprDPedidoCorpo.PerDesconto:= VprDPedidoCorpo.PerDesconto * (-1);
      end;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDValoresTela;
begin
  EValTotal.AValor:= VprDPedidoCorpo.ValTotal;
  EValProdutos.AValor := VprDPedidoCorpo.ValProdutos;
  EValIPI.AValor := VprDPedidoCorpo.ValIPI;
  if VprDPedidoCorpo.ValDesconto <> 0 then
  begin
    if VprDPedidoCorpo.ValDesconto > 0 then
    begin
      EValor.AValor:= VprDPedidoCorpo.ValDesconto;
      RDesconto.ItemIndex:= 1;
    end
    else
    begin
      EValor.AValor:= VprDPedidoCorpo.ValDesconto * (-1);
      RDesconto.ItemIndex:= 0;
     end;
    RTipoDesconto.ItemIndex:= 0;
  end
  else
    if VprDPedidoCorpo.PerDesconto <> 0 then
    begin
      if VprDPedidoCorpo.PerDesconto > 0 then
      begin
        EValor.AValor:= VprDPedidoCorpo.PerDesconto;
        RDesconto.ItemIndex:= 1;
      end
      else
      begin
        EValor.AValor:= VprDPedidoCorpo.PerDesconto * (-1);
        RDesconto.ItemIndex:= 0;
      end;
      RTipoDesconto.ItemIndex:= 1;
    end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.Consultar(VpaCodFilial,VpaSeqPedido: Integer);
begin
  VprOperacao:= ocConsulta;
  FunPedidoCompra.CarDPedidoCompra(VpaCodFilial,VpaSeqPedido,VprDPedidoCorpo);
  CarDTela;
  BloquearTela;
  EstadoBotoes(True);

  ShowModal;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.BloquearTela;
begin
  AlteraReadOnlyDet(ScrollBox1,0,true);

  GProdutos.APermiteExcluir:= False;
  GProdutos.APermiteInserir:= False;
  GFracaoOP.APermiteExcluir:= False;
  GFracaoOP.APermiteInserir:= False;

  RDesconto.Enabled:= False;
  RTipoDesconto.Enabled:= False;

  EstadoBotoes(False);
end;

{******************************************************************************}
function TFNovoPedidoCompra.Alterar(VpaCodFilial, VpaSeqPedido: Integer): Boolean;
begin
  VprOperacao:= ocConsulta;
  FunPedidoCompra.CarDPedidoCompra(VpaCodFilial,VpaSeqPedido,VprDPedidoCorpo);
  CarDTela;
  EstadoBotoes(False);
  VprOperacao:= ocEdicao;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.EFornecedorCadastrar(Sender: TObject);
begin
  FNovoCliente:= TFNovoCliente.CriarSDI(Application,'',True);
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.CadClientesC_IND_FOR.AsString := 'S';
  FNovoCliente.CadClientesC_IND_CLI.AsString := 'N';
  FNovoCliente.CadClientesC_IND_PRC.AsString := 'N';
  FNovoCliente.ShowModal;
  FNovoCliente.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimePedidoCompra(VprDPedidoCorpo.CodFilial,VprDPedidoCorpo.SeqPedido,false);
  dtRave.free;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  VpfCodProduto, VpfSeqProduto,VpfNomProduto,VpfPath,VpfKit,VpfCifrao : String;
begin
  if Key = VK_F4 then
    if (ActiveControl = GProdutos) or (ActiveControl = GFracaoOP) then
      ActiveControl:= EObservacoes;

  if Key = VK_F6 then
  begin
    if ExisteProduto then
    begin
      VpfCodProduto:= IntToStr(VprDProdutoPedido.SeqProduto);
      FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
      if FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VprDProdutoPedido.SeqProduto) <> nil then
      begin
        VprProdutoAnterior:= '';
        ExisteProduto;
      end;
      FNovoProdutoPro.free;
      VerificaPrecoFornecedor;
    end
    else
    begin
      aviso('PRODUTO NÃO PRENCHIDO!!!'#13'Informe um produto para alterar.');
      ActiveControl:= GProdutos;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.VerificaPrecoFornecedor;
begin
  VprDPedidoCorpo.CodCliente:= EFornecedor.AInteiro;
  FunProdutos.CarDProdutoFornecedor(VprDPedidoCorpo.CodCliente,VprDProdutoPedido);
  GProdutos.Cells[10,GProdutos.ALinha]:= FormatFloat(Varia.MascaraValor,VprDProdutoPedido.ValUnitario);
  GProdutos.Cells[12,GProdutos.ALinha]:= VprDProdutoPedido.DesReferenciaFornecedor;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CalculaValorTotalProduto;
begin
  if GProdutos.Cells[9,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.QtdProduto:= StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'))
  else
    VprDProdutoPedido.QtdProduto:= 0;
  if GProdutos.Cells[10,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.ValUnitario:= StrToFloat(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.'))
  else
    VprDProdutoPedido.ValUnitario:= 0;

  VprDProdutoPedido.ValTotal:= VprDProdutoPedido.ValUnitario * VprDProdutoPedido.QtdProduto;
  GProdutos.Cells[9,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPedido.QtdProduto);
  GProdutos.Cells[10,GProdutos.ALinha]:= FormatFloat(Varia.MascaraValorUnitario,VprDProdutoPedido.ValUnitario);
  GProdutos.Cells[11,GProdutos.ALinha]:= FormatFloat(varia.MascaraValor,VprDProdutoPedido.ValTotal);
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CalculaValorUnitarioProduto;
begin
  if GProdutos.Cells[9,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.QtdProduto:= StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'))
  else
    VprDProdutoPedido.QtdProduto:= 0;
  if GProdutos.Cells[11,GProdutos.ALinha] <> '' then
    VprDProdutoPedido.ValTotal:= StrToFloat(DeletaChars(GProdutos.Cells[11,GProdutos.ALinha],'.'))
  else
    VprDProdutoPedido.ValTotal:= 0;

  try
    VprDProdutoPedido.ValUnitario:= VprDProdutoPedido.ValTotal / VprDProdutoPedido.QtdProduto;
  except
    VprDProdutoPedido.ValUnitario:= 0;
  end;
  GProdutos.Cells[9,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPedido.QtdProduto);
  GProdutos.Cells[10,GProdutos.ALinha]:= FormatFloat(Varia.MascaraValorUnitario,VprDProdutoPedido.ValUnitario);
  GProdutos.Cells[11,GProdutos.ALinha]:= FormatFloat(varia.MascaraValor,VprDProdutoPedido.ValTotal);
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CalculaValorTotal;
begin
  CarDValorTotal;
  FunPedidoCompra.CalculaValorTotal(VprDPedidoCorpo);

  CarDValoresTela;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDValorTotal;
begin
  if VprOperacao in [ocEdicao,ocInsercao] then
  begin
    VprDPedidoCorpo.ValFrete:= EValorFrete.AValor;
    CarDDesconto;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.EValorChange(Sender: TObject);
begin
  if (VprOperacao in [ocEdicao,ocInsercao]) then
    CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.EFornecedorEnter(Sender: TObject);
begin
  VprFornecedorAnterior := EFornecedor.Text;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.BCadastrarClick(Sender: TObject);
begin
  VprOperacao:= ocInsercao;
  VprDPedidoCorpo.Free;
  VprDPedidoCorpo:= TRBDPedidoCompraCorpo.Cria;
  GProdutos.ADados:= VprDPedidoCorpo.Produtos;
  GFracaoOP.ADados:= VprDPedidoCorpo.FracaoOP;
  GProdutos.CarregaGrade;
  GFracaoOP.CarregaGrade;
  LimpaComponentes(ScrollBox1,0);
  EstadoBotoes(False);
  InicializaTela;
  ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.VisualizarOrdemProduo1Click(Sender: TObject);
begin
  FOrdemProducaoGenerica := TFOrdemProducaoGenerica.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrdemProducaoGenerica'));
  FOrdemProducaoGenerica.ConsultaOps(VprDFracaoOPPedido.CodFilialFracao,VprDFracaoOPPedido.SeqOrdem,VprDFracaoOPPedido.SeqFracao);
  FOrdemProducaoGenerica.Free;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.PosEstagios;
begin
  AdicionaSQLAbreTabela(Estagios,
                        'SELECT EPC.DATESTAGIO, EPC.DESMOTIVO, EST.NOMEST, USU.C_NOM_USU'+
                        ' FROM ESTAGIOPEDIDOCOMPRA EPC, ESTAGIOPRODUCAO EST, CADUSUARIOS USU'+
                        ' WHERE EST.CODEST = EPC.CODESTAGIO'+
                        ' AND USU.I_COD_USU = EPC.CODUSUARIO'+
                        ' AND EPC.SEQPEDIDO = '+ENumero.Text+
                        ' order by EPC.SEQESTAGIO ');
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = PEstagio then
    if ENumero.AInteiro <> 0 then
      PosEstagios;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.GFracaoOPSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GFracaoOP.AEstadoGrade in [egInsercao, egEdicao] then
  begin
    case GFracaoOP.AColuna of
      2: begin
           if ExisteClienteFracaoOP then
           begin
             GFracaoOP.Cells[4,GFracaoOP.ALinha]:= VprDFracaoOPPedido.NomCliente;
           end;
         end;
    end;
  end;
end;

{******************************************************************************}
function TFNovoPedidoCompra.ExisteClienteFracaoOP: Boolean;
begin
  Result:= False;
  if GFracaoOP.Cells[1,GFracaoOP.ALinha] <> '' then
    VprDFracaoOPPedido.CodFilialFracao:= StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha])
  else
    VprDFracaoOPPedido.CodFilialFracao:= 0;
  if GFracaoOP.Cells[2,GFracaoOP.ALinha] <> '' then
    VprDFracaoOPPedido.SeqOrdem:= StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha])
  else
    VprDFracaoOPPedido.SeqOrdem:= 0;
  Result:= FunPedidoCompra.ExisteClienteFracaoOP(VprDFracaoOPPedido);
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.ECompradorCadastrar(Sender: TObject);
begin
  FCompradores:= TFCompradores.CriarSDI(Application,'',True);
  FCompradores.BCadastrar.Click;
  FCompradores.ShowModal;
  FCompradores.Free;
  Localiza.AtualizaConsulta;
end;

procedure TFNovoPedidoCompra.EContatoChange(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDProdutoOrcamentoTela(VpaProdutos: TList);
var
  VpfLaco: Integer;
  VpfDProdutoPedidoCompra,
  VpfDProdutoPedidoCompraAux: TRBDProdutoPedidoCompra;
begin
  for VpfLaco:= 0 to VpaProdutos.Count-1 do
  begin
    VpfDProdutoPedidoCompraAux:= TRBDProdutoPedidoCompra(VpaProdutos.Items[VpfLaco]);
    // fazer a importação dos produtos para a lista do pedido aqui, pois será
    // necessário fazer um controle externo na lista de produtos mais tarde.
    VpfDProdutoPedidoCompra:= VprDPedidoCorpo.AddProduto;
    VpfDProdutoPedidoCompra.SeqProduto:= VpfDProdutoPedidoCompraAux.SeqProduto;
    VpfDProdutoPedidoCompra.CodCor:= VpfDProdutoPedidoCompraAux.CodCor;
    VpfDProdutoPedidoCompra.CodProduto:= VpfDProdutoPedidoCompraAux.CodProduto;
  end;
  GProdutos.CarregaGrade;
  GProdutos.Col:= 1;

  for VpfLaco:= 1 to GProdutos.RowCount-1 do
  begin
    VpfDProdutoPedidoCompraAux:= TRBDProdutoPedidoCompra(VpaProdutos.Items[VpfLaco-1]);
    VprProdutoAnterior:= '';
    VprCorAnterior:= '';
    GProdutos.ALinha:= VpfLaco;
    VprDProdutoPedido:= TRBDProdutoPedidoCompra(VprDPedidoCorpo.Produtos.Items[VpfLaco-1]);
    ExisteProduto;
    ExisteCor;
    VprDProdutoPedido.QtdSolicitada:= VpfDProdutoPedidoCompraAux.QtdSolicitada;
    VprDProdutoPedido.QtdProduto:= VpfDProdutoPedidoCompraAux.QtdProduto;
    // carregar corretamente a quantidade do produto, já que ela é redefinida
    // para 1 dentro do ExisteProduto
    GProdutos.Cells[8,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VpfDProdutoPedidoCompraAux.QtdSolicitada);
    GProdutos.Cells[9,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VpfDProdutoPedidoCompraAux.QtdProduto);
    CarDClasseProdutos;
  end;
  GProdutos.CarregaGrade;
  GProdutos.Col:= 1;
  CalculaValorTotal;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.CarDFracoesOrcamentoTela(VpaFracoes : TList);
var
  VpfLaco : Integer;
  VpfDFracaoOrcamento : TRBDSolicitacaoCompraFracaoOP;
begin
  for VpfLaco := 0 to VpaFracoes.Count - 1 do
  begin
    VpfDFracaoOrcamento := TRBDSolicitacaoCompraFracaoOP(VpaFracoes.Items[VpfLaco]);
    VprDFracaoOPPedido := VprDPedidoCorpo.AddFracaoOP;
    VprDFracaoOPPedido.CodFilialFracao := VpfDFracaoOrcamento.CodFilialFracao;
    VprDFracaoOPPedido.SeqOrdem := VpfDFracaoOrcamento.SeqOrdem;
    VprDFracaoOPPedido.SeqFracao := VpfDFracaoOrcamento.SeqFracao;
    VprDFracaoOPPedido.NomCliente := VpfDFracaoOrcamento.NomCliente;
  end;
  GFracaoOP.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.BEnviarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado :=  FunPedidoCompra.EnviaEmailFornecedor(VprDPedidoCorpo);
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.EEmailCompradorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key in [' ','/','ç','\','ã',':'] then
    key := #0;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.EFornecedorAlterar(Sender: TObject);
begin
  if EFornecedor.ALocaliza.Loca.Tabela.FieldByName(EFornecedor.AInfo.CampoCodigo).AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+EFornecedor.ALocaliza.Loca.Tabela.FieldByName(EFornecedor.AInfo.CampoCodigo).asString);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.Paginas.ActivePage := FNovoCliente.PFornecedor;
    FNovoCliente.ShowModal;
    Localiza.AtualizaConsulta;
    FNovoCliente.free;
  end;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.AdicionarTodososProdutosdoFornecedor1Click(
  Sender: TObject);
begin
  FunPedidoCompra.AdicionaTodosProdutosFornecedor(EFornecedor.AInteiro,VprDPedidoCorpo);
  GProdutos.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.ECodTransportadoraCadastrar(Sender: TObject);
begin
  FNovaTransportadora := TFNovaTransportadora.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaTransportadora'));
  FNovaTransportadora.CadTransportadoras.Insert;
  FNovaTransportadora.ShowModal;
  FNovaTransportadora.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoPedidoCompra.ETamanhoRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if (VprOperacao in [ocinsercao,ocedicao]) and
     (VprDProdutoPedido <> nil) then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDProdutoPedido.CodTamanho := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDProdutoPedido.NomTamanho := VpaColunas.items[1].AValorRetorno;
      GProdutos.Cells[5,GProdutos.ALinha] := VpaColunas.items[0].AValorRetorno;
      GProdutos.Cells[6,GProdutos.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDProdutoPedido.CodTamanho := 0;
      VprDProdutoPedido.NomTamanho := '';
    end;
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoPedidoCompra]);
end.
