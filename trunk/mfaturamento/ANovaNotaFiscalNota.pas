unit ANovaNotaFiscalNota;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  DBTables, ConvUnidade, DBKeyViolation, Localizacao, Db,
  Tabela, BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls,
  PainelGradiente, Grids, DBCtrls, Mask, DBGrids, UnNotaFiscal, Spin, Constantes,
  numericos, UnImpressao, ShellApi, UnProdutos, UnCotacao,  UnContasAReceber,
  UnDados, UnClientes,UnComissoes, UnDadosCR, UnDadosProduto, CGrades, UnSistema,
  Parcela, ComCtrls, UnOrdemProducao, UnImpressaoBoleto, Menus, UnCrystal, UnClassesImprimir,
  FMTBcd, SqlExpr, DBClient, ACBrNFeDANFEClass, ACBrNFeDANFERave, UnNFE;

Const
  CT_DATAMENORULTIMOFECHAMENTO='DATA NÃO PODE SER MENOR QUE A DO ÚLTIMO FECHAMENTO!!!A data de digitação do produto não ser menor que a data do ultimo fechamento...';


type
  TFNovaNotaFiscalNota = class(TFormularioPermissao)
    FundoNota: TScrollBox;
    Shape4: TShape;
    Shape5: TShape;
    Shape3: TShape;
    Shape2: TShape;
    Shape20: TShape;
    Shape12: TShape;
    Label21: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Shape7: TShape;
    Shape9: TShape;
    cv: TLabel;
    Shape10: TShape;
    Label18: TLabel;
    Label17: TLabel;
    Shape11: TShape;
    Label19: TLabel;
    Label20: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Label22: TLabel;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Label24: TLabel;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Label39: TLabel;
    Label40: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    LIEFilial: TLabel;
    Label73: TLabel;
    Label78: TLabel;
    LNomFilial: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton5: TSpeedButton;
    MObservacoes: TMemoColor;
    ECodCliente: TEditLocaliza;
    ECodNatureza: TEditLocaliza;
    CAutoCalculo: TCheckBox;
    Panel1: TPanelColor;
    BtbImprimeBoleto: TBitBtn;
    BotaoCadastrar1: TBitBtn;
    BotaoGravar1: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    BotaoCancelar1: TBitBtn;
    BObservacao: TBitBtn;
    Localiza: TConsultaPadrao;
    Aux: TSQLQUERY;
    MovNatureza: TSQL;
    LCGCFilial: TLabel;
    Panel2: TPanel;
    GRADEPAR: TStringGrid;
    LTituloFaturas: TLabel;
    Panel4: TPanel;
    Shape6: TShape;
    Shape37: TShape;
    Label41: TLabel;
    Shape32: TShape;
    Label42: TLabel;
    Shape33: TShape;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Shape34: TShape;
    Shape35: TShape;
    Shape36: TShape;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Shape38: TShape;
    Shape39: TShape;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Shape40: TShape;
    Shape41: TShape;
    Shape42: TShape;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Shape43: TShape;
    Label62: TLabel;
    Shape44: TShape;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Shape45: TShape;
    Shape46: TShape;
    Shape47: TShape;
    Shape48: TShape;
    Shape49: TShape;
    Shape50: TShape;
    Shape51: TShape;
    Label4: TLabel;
    Shape52: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label23: TLabel;
    Label71: TLabel;
    SpeedButton2: TSpeedButton;
    Label72: TLabel;
    SpeedButton3: TSpeedButton;
    BCondicao: TSpeedButton;
    LNomCondicao: TLabel;
    Label36: TLabel;
    EPlacaVeiculo: TEditColor;
    ECodTipoFrete: Tnumerico;
    EBaseICMS: TNumerico;
    EValFrete: TNumerico;
    EValTotalProdutos: TNumerico;
    EValSubsICM: TNumerico;
    EBaseSubICMS: TNumerico;
    EValICMS: Tnumerico;
    EValSeguro: TNumerico;
    EValOutrasDespesas: TNumerico;
    EValTotalNota: TNumerico;
    EMarca: TEditColor;
    EEspecie: TEditColor;
    EUFVeiculo: TEditColor;
    ECoDVendedor: TEditLocaliza;
    ECodTransportadora: TEditLocaliza;
    ECondicoes: TEditColor;
    MAdicional: TMemoColorLimite;
    EClaFiscal: TEditColor;
    EQtd: Tnumerico;
    EPesoBruto: Tnumerico;
    EPesoLiquido: Tnumerico;
    EValDescontoAcrescimo: TNumerico;
    EValTotalIPI: TNumerico;
    CAcrescimoDesconto: TRadioGroup;
    CValorPercentual: TRadioGroup;
    EPerComissao: Tnumerico;
    Label31: TLabel;
    ENumeroEmbalagem: TEditColor;
    Tempo: TPainelTempo;
    CADBOLETO: TSQLQUERY;
    RomaneioItem: TSQLQUERY;
    BAlterarNumero: TBitBtn;
    Shape25: TShape;
    Shape26: TShape;
    ValidaGravacao1: TValidaGravacao;
    Label33: TLabel;
    EOrdemCompra: TEditColor;
    ECor: TEditLocaliza;
    RTipoNota: TRadioGroup;
    ENumNota: Tnumerico;
    ESerieNota: TEditColor;
    ECodFilial: TEditColor;
    Label34: TLabel;
    LCGCCPF: TLabel;
    LInscricaoEstadual: TLabel;
    LEndereco: TLabel;
    LBairro: TLabel;
    LCep: TLabel;
    LCidade: TLabel;
    LUF: TLabel;
    LFone: TLabel;
    LFax: TLabel;
    EDatEmissao: TMaskEditColor;
    EDatSaida: TMaskEditColor;
    EHorSaida: TMaskEditColor;
    GProdutos: TRBStringGridColor;
    ValidaUnidade: TValidaUnidade;
    Label30: TLabel;
    LCGCTranposrtadora: TLabel;
    LEnderecoTransportadora: TLabel;
    LNumEnderecoTransportadora: TLabel;
    LMunicipioTransportadora: TLabel;
    LUFTransportadora: TLabel;
    LInscricaoTransportadora: TLabel;
    CriaParcelas: TCriaParcelasReceber;
    StatusBar1: TStatusBar;
    BAlterarNota: TSpeedButton;
    PSERVICO: TPanel;
    GServicos: TRBStringGridColor;
    Shape1: TShape;
    Label32: TLabel;
    Shape24: TShape;
    Label35: TLabel;
    EValIss: Tnumerico;
    Shape8: TShape;
    EValTotalServicos: Tnumerico;
    Label37: TLabel;
    Shape27: TShape;
    Label38: TLabel;
    Label52: TLabel;
    SpeedButton4: TSpeedButton;
    ECodPreposto: TEditLocaliza;
    Label70: TLabel;
    Label74: TLabel;
    EComissaoPreposto: Tnumerico;
    PopupMenu1: TPopupMenu;
    Envelopes1: TMenuItem;
    EPerISSQN: Tnumerico;
    BFinanceiroOculto: TSpeedButton;
    CRevendaEdson: TCheckBox;
    Shape28: TShape;
    ETextoFiscal: TEditColor;
    Label76: TLabel;
    EValTroca: Tnumerico;
    N1: TMenuItem;
    EspelhodaNota1: TMenuItem;
    Label75: TLabel;
    EChaveNFE: TEditColor;
    BEnviar: TBitBtn;
    procedure BFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ECodNaturezaRetorno(Retorno1, Retorno2: String);
    procedure ECodClienteRetorno(Retorno1, Retorno2: String);
    procedure ECodClienteCadastrar(Sender: TObject);
    procedure ECodNaturezaCadastrar(Sender: TObject);
    procedure EValFreteExit(Sender: TObject);
    procedure ECondicoesExit(Sender: TObject);
    procedure ECodTransportadoraRetorno(Retorno1, Retorno2: String);
    procedure ECoDVendedorRetorno(Retorno1, Retorno2: String);
    procedure BCondicaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BotaoCancelar1Click(Sender: TObject);
    procedure BotaoGravar1Click(Sender: TObject);
    procedure ECondicoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure BObservacaoClick(Sender: TObject);
    procedure ECodTipoFreteKeyPress(Sender: TObject; var Key: Char);
    procedure BImprimirClick(Sender: TObject);
    procedure BtbImprimeBoletoClick(Sender: TObject);
    procedure BAlterarNumeroClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ECodNaturezaSelect(Sender: TObject);
    procedure ECondicoesChange(Sender: TObject);
    procedure ECodTransportadoraCadastrar(Sender: TObject);
    procedure CAutoCalculoClick(Sender: TObject);
    procedure ECoDVendedorCadastrar(Sender: TObject);
    procedure ECorCadastrar(Sender: TObject);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosDepoisExclusao(Sender: TObject);
    procedure GProdutosEnter(Sender: TObject);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorEnter(Sender: TObject);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EValDescontoAcrescimoExit(Sender: TObject);
    procedure GProdutosExit(Sender: TObject);
    procedure EDatEmissaoExit(Sender: TObject);
    procedure EDatSaidaExit(Sender: TObject);
    procedure ValidaGravacao1DadosInvalidos;
    procedure BAlterarNotaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ECodClienteAlterar(Sender: TObject);
    procedure GServicosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GServicosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GServicosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GServicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GServicosKeyPress(Sender: TObject; var Key: Char);
    procedure GServicosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GServicosNovaLinha(Sender: TObject);
    procedure GServicosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ECodPrepostoRetorno(Retorno1, Retorno2: String);
    procedure Envelopes1Click(Sender: TObject);
    procedure BFinanceiroOcultoClick(Sender: TObject);
    procedure ECoDVendedorSelect(Sender: TObject);
    procedure ECodPrepostoSelect(Sender: TObject);
    procedure EspelhodaNota1Click(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
  private
     VprPerISSQN : Double;
     VprOperacao : TRBDOperacaoCadastro;
     VprDNota : TRBDNotaFiscal;
     VprDProdutoNota : TRBDNotaFiscalProduto;
     VprDServicoNota : TRBDNotaFiscalServico;
     VprDContasaReceber : TRBDContasCR;
     VprCodNaturezaAtual,
     VprServicoAnterior,
     VprProdutoAnterior : String;
     VprDCliente : TRBDCliente;
     VprDTransportadora : TRBDTransportadora;
     FunOrdemProducao : TRBFuncoesOrdemProducao;
     FunImprimeBoleto : TImpressaoBoleto;
     VprAcao,
     VprNotaAutomatica  : Boolean;

     //antigos
     UnImp : TFuncoesImpressao;
     LancamentoReceber : Integer;
     VprOrcamento : Boolean; // para quando consulta naum executar servicos;

     NroLinhaProdutos,
     NroLinhaFatura,
     NroConjuntoFatura,
     NroLinhaObs : Integer;

     VprTextoReducao : string;
     VprCotacoes : TList;
     VprTransacao : TTransactionDesc;
     //funcoes novas;
     procedure CarTitulosGrade;
     function LimiteCreditoOK(VpaDCliente : TRBDCliente) : Boolean;
     function SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : Boolean;
     procedure CardClienteNota(VpaDCliente : TRBDCliente);
     procedure CarDTransportadoraTela;
     procedure CarDProdutoNota;
     procedure CarDServicoNota;
     procedure CarDTela;
     procedure CarDValorTotalTela;
     function CarDClasse : string;
     procedure CarDValorTotal;
     procedure CarDDesconto;
     procedure CalculaValorTotalProduto;
     function ExisteProduto : Boolean;
     function ExisteServico : Boolean;
     procedure CalculaValorTotal;
     procedure CalculaValorTotalServico;
     function LocalizaProduto : Boolean;
     function LocalizaServico : Boolean;
     function ExisteUM : Boolean;
     function ExisteCor : Boolean;
     function ExisteCondicaoPagamento : Boolean;
     function LocalizaCondicaoPagto : Boolean;
     procedure ReferenciaProduto;
     procedure InicializaNota;
     function VerificaVariaveis : string;
     procedure CarregaDadosFilial;
     procedure ValidaValorUnitarioProduto;
     function DadosNotaValidos : String;
     procedure AtualizaStatus(VpaStatus : String);
     procedure LimpaDadosClientes;
     procedure AdicionaItemProduto(VpaDProdutoNota : TRBDNotaFiscalProduto);
     function RNumerosPedido : String;
     procedure TelaModoConsulta(VpaConsulta : Boolean);

     //funcoes antigas
     procedure ConfiguraItemNota( NroDoc : Integer);

     Procedure EstadoBotoes(Estado : Boolean);
     procedure LimpaStringGrid;

     procedure MontaObservacao;

     procedure MontaPArcelasCR(VpaParcelaOculta : Boolean);
     procedure ExcluiFinanceiroCotacao;
     function GeraFinanceiroNota : String;
     function GeraFinanceiroOculto : String;
     function BaixaEstoqueNota : string;
     function BaixaEstoqueFiscal : String;
     function BaixaFinanceiro : string;
     function BaixaNota : String;
     procedure ArrumaDuplicatasFinanceiro;
     function ROrdensCompra : String;

     procedure AlteraLocalizasOrcamento;

     procedure GeraMovNotasFiscaisOrcamentos(VpaCotacoes : TList;VpaSomenteServico : Boolean=false);
     procedure GeraMovNotasFiscaisRomaneio(VpaEmpFil, VpaNumRomaneio : String);
     procedure GeraMovNotasFiscaisRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio : Integer);
     procedure OrdenaCotacoesPorDataEntrega(VpaCotacoes : TList);
     procedure CarProBaixadosOrcamento;
     procedure CarDOrcamentoNota(VpaDOrcamento : TRBDOrcamento;VpaDNota : TRBDNotaFiscal);
     procedure CarDClienteNovaNota(VpaDNota : TRBDNotaFiscal;VpaCodCliente : Integer);
     procedure AdicionaAcrescimosDescontoCotacoesNota(VpaCotacoes : TList;VpaDNota : TRBDNotaFiscal);
     procedure CarNaturezaOperacaoNota;
     function FinalizaNotaAutomatico : String;
     procedure GeraNotaFiscalFriaContrato;
     function DadoNfeValidos(VpaDCliente : TRBDCliente) : string;
  public
     function NovaNotaFiscal : Boolean;
     function GeraNotaCotacoes(VpaCotacoes : TList;VpaSomenteServico : Boolean = false):Boolean;
     function GeraNotaCotacoesAutomatico(VpaCotacoes : TList;VpaDCliente : TRBDCliente;VpaBarraStatus : TStatusBar):string;
     function GeraNotaRomaneio(VpaEmpfil,VpaNumRomaneio : String) : boolean;
     function GeraNotaRomaneioGenerico(VpaCodFilial, VpaSeqRomaneio,VpaCodCliente : Integer):Boolean;
     procedure ConsultaNota(VpaDNota : TRBDNotaFiscal);
  end;

var
  FNovaNotaFiscalNota: TFNovaNotaFiscalNota;

implementation

uses APrincipal, constmsg, ANovaNatureza, ANovoCliente, funsql,
     ALocalizaProdutos, AConsultaCondicaoPgto, funnumeros, FunObjeto,
     AObservacoesNota, ANovoServico, funstring, FunData,
     AItensNatureza, funprinter,
  ANovaTransportadora, ANovoVendedor, ACores, AMostraObservacaoCliente,
  ALocalizaServico, FunArquivos, dmRave;

{$R *.DFM}

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Rotinas Gerais do formulario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************* quando cria o formulario ************************************ }
procedure TFNovaNotaFiscalNota.FormCreate(Sender: TObject);
begin
  VprAcao := false;
  VprNotaAutomatica := false;
  CarTitulosGrade;
  ValidaUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ValidaUnidade.Ainfo.UnidadeUN := varia.unidadeUN;
  ValidaUnidade.Ainfo.UnidadeKit := varia.unidadeKit;
  ValidaUnidade.Ainfo.UnidadeBarra := varia.UnidadeBarra;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);

  FundoNota.VertScrollBar.Position := 0;
  FunImprimeBoleto := TImpressaoBoleto.cria(Fprincipal.BaseDados);
  VprDCliente := TRBDCliente.cria;
  VprDTransportadora := TRBDTransportadora.Create;
  VprDContasaReceber := TRBDContasCR.cria;
  UnImp := TFuncoesImpressao.criar(self, FPrincipal.BaseDados);
  // permite ou nao alterar o numero da nota fiscal
  ENumNota.ReadOnly := not config.AlterarNroNF;

  if ConfigModulos.Servico then
    PSERVICO.Visible := true
  else
    PSERVICO.Visible := false;



{  if not config.AlterarValorUnitarioNota then
    Grade.Columns[6].ReadOnly := true;}

  if not config.DescontoNota then
    EValDescontoAcrescimo.ReadOnly := true;
  CRevendaEdson.Visible := (Varia.CNPJFilial = CNPJ_Kairos) or (Varia.CNPJFilial = CNPJ_AviamentosJaragua);
end;

{************ no close da nota fiscal *************************************** }
procedure TFNovaNotaFiscalNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.BaseDados.InTransaction then
     FPrincipal.BaseDados.Rollback(VprTransacao);
  MovNatureza.close;
  CADBOLETO.close;
  FunImprimeBoleto.free;
  VprDContasaReceber.free;
  Aux.Close;
  action := cafree;
end;

{****************** fechamento da nota fiscal ****************************** }
procedure TFNovaNotaFiscalNota.BFecharClick(Sender: TObject);
begin
  self.close;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.LimiteCreditoOK(VpaDCliente : TRBDCliente) : Boolean;
begin
  result := true;
  if config.LimiteCreditoCliente then
  begin
    if (VprDCliente.LimiteCredito < (VprDCliente.DuplicatasEmAberto + VprDNota.ValTotal)) then
    begin
     result := false;
     if confirmacao('CLIENTE COM LIMITE DE CRÉDITO ESTOURADO!!!'#13'Esse cliente possui um limite de crédito de "'+FormatFloat('#,###,###,##0.00',VprDCliente.LimiteCredito)+
            '", e o valor das duplicatas em aberto somam "'+FormatFloat('#,###,###,##0.00',VprDCliente.DuplicatasEmAberto + VprDNota.ValTotal)+ '".Deseja alterar o limite de crédito do cliente?') then
     begin
       FNovoCliente := TFNovoCliente.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovoCliente'));
       FNovoCliente.CadClientes.FindKey([VpaDCliente.CodCliente]);
       FNovoCliente.CadClientes.Edit;
       FNovoCliente.Showmodal;
       FNovoCliente.free;
       FunClientes.CarDCliente(VpaDCliente);
     end
     else
       ECodCliente.Clear;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarTitulosGrade;
begin
  GProdutos.Cells[1,0] := 'CÓDIGO';
  GProdutos.Cells[2,0] := 'DESCRIÇÃO DO PRODUTO';
  GProdutos.Cells[3,0] := 'COR';
  GProdutos.Cells[4,0] := 'DESCRIÇÃO COR';
  GProdutos.Cells[5,0] := 'C.F.';
  GProdutos.Cells[6,0] := 'CST';
  GProdutos.Cells[7,0] := 'UNID.';
  GProdutos.Cells[8,0] := 'QTD';
  GProdutos.Cells[9,0] := 'VALOR UNITÁRIO';
  GProdutos.Cells[10,0] := 'VALOR TOTAL';
  if config.NumeroSerieProduto then
    GProdutos.Cells[11,0] := 'NÚMERO SÉRIE'
  else
    GProdutos.Cells[11,0] := 'REFERÊNCIA CLIENTE';
  GProdutos.Cells[12,0] := 'ORDEM COMPRA';
  GProdutos.Cells[13,0] := 'ICMS';
  GProdutos.Cells[14,0] := 'IPI';
  GProdutos.Cells[15,0] := 'VALOR IPI';

  GServicos.Cells[1,0] := 'CÓDIGO';
  GServicos.Cells[2,0] := 'DESCRIÇÃO';
  GServicos.Cells[3,0] := 'DESCRIÇÃO ADICIONAL';
  GServicos.Cells[4,0] := 'QTD';
  GServicos.Cells[5,0] := 'VAL UNITÁRIO';
  GServicos.Cells[6,0] := 'VALOR TOTAL';
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : Boolean;
begin
  result := LimiteCreditoOK(VpaDCliente);
  if result then
  begin
    if config.BloquearClienteEmAtraso then
    begin
      if VprDCliente.DuplicatasEmAtraso > 0 then
      begin
        if not Confirmacao('CLIENTE COM DUPLICATAS VENCIDAS!!!'#13'Este cliente possui duplicatas vencidas no valor de "'+FormatFloat('#,###,###,###,##0.00',VprDCliente.DuplicatasEmAtraso)+'". Deseja faturar para esse cliente ?') then
          ECodCliente.Clear;
      end;
    end;
  end;
  if VprDCliente.IndBloqueado then
  begin
    aviso('CLIENTE BLOQUEADO!!!'#13'Este cliente encontra-se bloqueado, não é permitido fazer cotações para clientes bloqueados. Solicite o desbloqueio desse cliente.');
    ECodCliente.clear;
    VprDCliente.CodCliente := 0;
    Result := false;
  end;

end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CardClienteNota(VpaDCliente : TRBDCliente);
begin
  LCGCCPF.Caption := VpaDCliente.CGC_CPF;
  LInscricaoEstadual.Caption := VpaDCliente.InscricaoEstadual;
  if (VprDCliente.DesEnderecoCobranca <> '')  and config.MostrarEnderecoCobrancanaNota then
  begin
    LEndereco.Caption := VpaDCliente.DesEnderecoCobranca+', '+VpaDCliente.NumEnderecoCobranca ;
    LBairro.Caption := VpaDCliente.DesBairroCobranca;
    LCep.Caption := VpaDCliente.CepClienteCobranca;
    LCidade.Caption := VpaDCliente.DesCidadeCobranca;
    LUF.Caption := vpaDCliente.DesUfCobranca;
    LFone.Caption := VpaDCliente.Fone_FAX;
  end
  else
  begin
    LEndereco.Caption := VpaDCliente.DesEndereco+', '+VpaDCliente.NumEndereco + ' - '+ VpaDCliente.DesComplementoEndereco ;
    LBairro.Caption := VpaDCliente.DesBairro;
    LCep.Caption := VpaDCliente.CepCliente;
    LCidade.Caption := VpaDCliente.DesCidade;
    LUF.Caption := vpaDCliente.DesUF;
    LFone.Caption := VpaDCliente.Fone_FAX;
  end;
  if (VpadCliente.CodCondicaoPagamento <> 0) and (VprDNota.IndGeraFinanceiro) then
  begin
    ECondicoes.AInteiro := VpaDCliente.CodCondicaoPagamento;
    CalculaValorTotal;
  end;
  if (VpaDCliente.CodFormaPagamento <> 0) and (VprDNota.CodFormaPagamento = 0) then
    VprDNota.CodFormaPagamento := VpaDCliente.CodFormaPagamento;
  if (VpaDCliente.CodVendedor <> 0) and (VprDNota.CodVendedor = 0) then
  begin
    ECoDVendedor.AInteiro := VpaDCliente.CodVendedor;
    ECoDVendedor.Atualiza;
  end;
  if (VpaDCliente.PerComissao <> 0) and (VprDNota.PerComissao = 0) then
    EPerComissao.AValor := VpaDCliente.PerComissao;
  if VprDCliente.PerISS <> 0 then
    VprPerISSQN := VprDCliente.PerISS
  else
    VprPerISSQN := Varia.ISSQN;
  if not VprDNota.IndCalculaISS then
    VprPerISSQN := 0;
  VprDNota.PerIssqn := VprPerISSQN;
  EPerISSQN.AValor := VprDNota.PerIssqn;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDTransportadoraTela;
begin
  with VprDTransportadora do
  begin
    LCGCTranposrtadora.Caption := CGC_CPF;
    LEnderecoTransportadora.Caption := Endereco;
    LNumEnderecoTransportadora.Caption := NroEndereco;
    LMunicipioTransportadora.Caption := Cidade;
    LUFTransportadora.Caption := UF;
    LInscricaoTransportadora.Caption := InscricaoEstadual;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDProdutoNota;
begin
  VprDProdutoNota.CodProduto := GProdutos.Cells[1,GProdutos.Alinha];
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDProdutoNota.NomProduto := GProdutos.Cells[2,GProdutos.ALinha]; 

  if GProdutos.Cells[3,GProdutos.ALinha] <> '' then
    VprDProdutoNota.CodCor := StrToInt(GProdutos.Cells[3,GProdutos.Alinha])
  else
    VprDProdutoNota.CodCor := 0;
  VprDProdutoNota.DesCor := GProdutos.Cells[4,GProdutos.ALinha];
  VprDProdutoNota.CodClassificacaoFiscal := GProdutos.Cells[5,GProdutos.ALinha];
  VprDProdutoNota.CodCST := GProdutos.Cells[6,GProdutos.ALinha];
  VprDProdutoNota.UM := GProdutos.Cells[7,GProdutos.ALinha];
  VprDProdutoNota.QtdProduto := StrToFloat(DeletaChars(GProdutos.Cells[8,GProdutos.ALinha],'.'));
  VprDProdutoNota.ValUnitario := StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'));
  if config.NumeroSerieProduto then
    VprDProdutoNota.DesRefCliente := GProdutos.Cells[11,GProdutos.ALinha];
  VprDProdutoNota.DesOrdemCompra := GProdutos.Cells[12,GProdutos.ALinha];
  if GProdutos.Cells[13,GProdutos.ALinha] <> '' then
    VprDProdutoNota.PerICMS := StrToFloat(DeletaChars(DeletaChars(GProdutos.Cells[13,GProdutos.ALinha],'.'),'%'))
  else
    VprDProdutoNota.PerICMS := 0;
  if GProdutos.Cells[14,GProdutos.ALinha] <> '' then
    VprDProdutoNota.PerIPI := StrToFloat(DeletaChars(DeletaChars(GProdutos.Cells[14,GProdutos.ALinha],'.'),'%'))
  else
    VprDProdutoNota.PerIPI := 0;
  if GProdutos.Cells[15,GProdutos.ALinha] <> '' then
    VprDProdutoNota.ValIPI := StrToFloat(DeletaChars(GProdutos.Cells[15,GProdutos.ALinha],'.'))
  else
    VprDProdutoNota.ValIPI := 0;

  CalculaValorTotalProduto;
  if ((VprDProdutoNota.QtdEstoque - VprDProdutoNota.QtdProduto) < VprDProdutoNota.QtdMinima) then
  begin
    if config.AvisaQtdMinima then
      aviso(CT_EstoqueProdutoMinimo);
  end
  else
    if ((VprDProdutoNota.QtdEstoque -  VprDProdutoNota.QtdProduto) < VprDProdutoNota.QtdPedido) Then
    begin
      if Config.AvisaQtdPedido Then
        aviso(CT_EstoquePedido);
    end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDServicoNota;
begin
  VprDServicoNota.CodServico := StrToInt(GServicos.Cells[1,GServicos.Alinha]);
  if config.PermiteAlteraNomeProdutonaCotacao then
    VprDServicoNota.NomServico := GServicos.Cells[2,GServicos.ALinha];
  VprDServicoNota.DesAdicional := GServicos.Cells[3,GServicos.ALinha];
  VprDServicoNota.QtdServico := StrToFloat(DeletaChars(GServicos.Cells[4,GServicos.ALinha],'.'));
  VprDServicoNota.ValUnitario := StrToFloat(DeletaChars(GServicos.Cells[5,GServicos.ALinha],'.'));
  CalculaValorTotalServico;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDTela;
begin
  with VprDNota do
  begin
    ESerieNota.text := DesSerie;
    ECodFilial.AInteiro := CodFilial;
    ECodNatureza.Text := CodNatureza;
    ECodCliente.AInteiro := CodCliente;
    ENumNota.AsInteger := NumNota;
    if DesTipoNota = 'E' then
      RTipoNota.ItemIndex := 0
    else
      RTipoNota.ItemIndex := 1;
    EDatEmissao.Text := FormatDateTime('DD/MM/YY',DatEmissao);
    if DatSaida > MontaData(1,1,1900) then
      EDatSaida.Text := FormatDateTime('DD/MM/YY',DatSaida)
    else
      EDatSaida.Text := '00/00/00';
    EHorSaida.Text := FormatDateTime('HH:MM',HorSaida);
    ECodTransportadora.AInteiro := CodTransportadora;
    EPlacaVeiculo.Text := DesPlacaVeiculo;
    EUFVeiculo.Text := DesUFPlacaVeiculo;
    EQtd.AValor := QtdEmbalagem;
    EEspecie.Text := DesEspecie;
    EMarca.Text := DesMarcaEmbalagem;
    ENumeroEmbalagem.Text := NumEmbalagem;
    EOrdemCompra.Text := DesOrdemCompra;
    ECondicoes.AInteiro := CodCondicaoPagamento;
    ECoDVendedor.AInteiro := CodVendedor;
    ECoDVendedor.Atualiza;
    ECodPreposto.AInteiro := CodVendedorPreposto;
    ECodPreposto.Atualiza;
    EComissaoPreposto.AValor := PerComissaoPreposto;
    EPerComissao.AValor := PerComissao;
    EPerISSQN.AValor := PerIssqn;
    EClaFiscal.Text := DesClassificacaoFiscal;
    MAdicional.Lines.Text := DesDadosAdicinais.text;
    CRevendaEdson.Checked := IndRevendaEdson;
    EValTroca.AValor := ValDescontoTroca;
    EChaveNFE.Text := VprDNota.DesChaveNFE;
  end;
  AtualizaLocalizas([ECodCliente,ECodNatureza,ECodTransportadora,ECondicoes]);
  CarDValorTotalTela;
  CarDTransportadoraTela;
  ExisteCondicaoPagamento;
  MontaObservacao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDValorTotalTela;
begin
  with VprDNota do
  begin
    EBaseICMS.AValor :=  ValBaseICMS;
    EValICMS.AValor := ValICMS;
    EValSubsICM.AValor := ValICMSSubtituicao;
    EBaseSubICMS.AValor := ValBaseICMSSubstituicao;
    EValTotalProdutos.AValor := ValTotalProdutos;
    EValFrete.AValor := ValFrete;
    EValSeguro.AValor := ValSeguro;
    EValOutrasDespesas.aValor := ValOutrasDepesesas;
    EValTotalIPI.AValor := ValTotalIPI;
    EValTotalNota.AValor := ValTotal;
    ECodTipoFrete.AsInteger := CodTipoFrete;
    EPesoBruto.AValor := PesBruto;
    EPesoLiquido.AValor := PesLiquido;
    EValTotalServicos.AValor := ValTotalServicos;
    EValIss.AValor := ValIssqn;
    EPerISSQN.AValor := PerIssqn;
    CAcrescimoDesconto.ItemIndex := 1;
    CValorPercentual.ItemIndex := 1;
    if ValDesconto <> 0 then
    begin
      CValorPercentual.ItemIndex := 0;
      if ValDesconto > 0 then
      begin
        EValDescontoAcrescimo.AValor := ValDesconto;
        CAcrescimoDesconto.ItemIndex := 1;
      end
      else
      begin
        EValDescontoAcrescimo.AValor := ValDesconto * -1;
        CAcrescimoDesconto.ItemIndex := 0;
      end;
    end
    else
      if PerDesconto <> 0 then
      begin
        CValorPercentual.ItemIndex := 1;
        if PerDesconto > 0 then
        begin
           EValDescontoAcrescimo.AValor := PerDesconto;
           CAcrescimoDesconto.ItemIndex := 1;
        end
        else
        begin
           EValDescontoAcrescimo.AValor := PerDesconto * -1;
           CAcrescimoDesconto.ItemIndex := 0;
        end;
      end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.CarDClasse : string;
begin
  result := '';
  try
    StrToDate(EDatEmissao.text);
  except
    result := 'DATA EMISSÃO INVÁLIDA!!!'#13'A data de emissao da nota fiscal não é uma data válida ou não foi preenchida...';
  end;
  try
    if DeletaChars(DeletaChars(EDatSaida.Text,'/'),'0') = '' then
      VprDNota.DatSaida := MontaData(1,1,1900)
    else
      VprDNota.DatSaida := StrToDate(EDatSaida.text);
  except
    result := 'DATA DE SAÍDA INVÁLIDA!!!'#13'A data de saida da nota fiscal não é uma data válida ou não foi preenchida...';
  end;


  if result = '' then
    result := DadoNfeValidos(VprDCliente);

  if result = '' then
  begin
    with VprDNota do
    begin
      if config.NotaFiscalConjugada then
        DesSerie := Varia.SerieNota
      else
      begin
        if VprDNota.Produtos.Count > 0  then
          DesSerie := Varia.SerieNota
        else
          DesSerie := Varia.SerieNotaServico;
      end;

      CodNatureza := ECodNatureza.Text;
      NumNota := ENumNota.AsInteger;
      CodCliente := ECodCliente.AInteiro;
      DatEmissao := StrToDate(EDatEmissao.text);
      CarDValorTotal;

      CodTransportadora := ECodTransportadora.AInteiro;
      DesPlacaVeiculo := EPlacaVeiculo.Text;
      DesUFPlacaVeiculo := EUFVeiculo.Text;
      QtdEmbalagem := EQtd.AsInteger;
      DesEspecie := EEspecie.Text;
      DesMarcaEmbalagem := EMarca.Text;
      NumEmbalagem := ENumeroEmbalagem.Text;
      PesBruto := EPesoBruto.AValor;
      PesLiquido := EPesoLiquido.AValor;
      DesOrdemCompra := EOrdemCompra.Text;
      CodCondicaoPagamento := ECondicoes.AInteiro;
      PerComissao := EPerComissao.AValor;
      CodVendedor := ECoDVendedor.AInteiro;
      CodVendedorPreposto := ECodPreposto.AInteiro;
      PerComissaoPreposto := EComissaoPreposto.AValor;
      if VprOrcamento and (VprCotacoes <> nil) then
        VprDNota.NumPedidos := RNumerosPedido ;

      if config.LimiteCreditoCliente then
      begin
        if not LimiteCreditoOK(VprDCliente) then
        begin
          result := 'CLIENTE COM LIMITE DE CRÉDITO ESTOURADO!!!'#13'Esse cliente possui um limite de crédito de "'+FormatFloat('#,###,###,##0.00',VprDCliente.LimiteCredito)+
                '", e o valor das duplicatas em aberto mais essa nota somam "'+FormatFloat('#,###,###,##0.00',VprDCliente.DuplicatasEmAberto+VprDNota.ValTotal)+ '".';
        end;
      end;
      DesClassificacaoFiscal := FunNotaFiscal.RTextoClassificacaoFiscal(VprDNota) ;
      DesDadosAdicinais.Text := MAdicional.Lines.Text;
      IndRevendaEdson := CRevendaEdson.Checked;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDValorTotal;
begin
  with VprDNota do
  begin
    ValBaseICMS := EBaseICMS.AValor;
    ValICMS := EValICMS.AValor;
    ValICMSSubtituicao := EValSubsICM.AValor;
    ValBaseICMSSubstituicao := EBaseSubICMS.AValor;
    ValFrete := EValFrete.AValor;
    ValSeguro := EValSeguro.AValor;
    ValOutrasDepesesas := EValOutrasDespesas.aValor;
    ValTotal := EValTotalNota.AValor;
    CodTipoFrete := ECodTipoFrete.AsInteger;
    CodCondicaoPagamento := ECondicoes.AInteiro;
    PerIssqn := EPerISSQN.AValor;
  end;
  CarDDesconto;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDDesconto;
begin
  with VprDNota do
  begin
    PerDesconto := 0;
    ValDesconto := 0;
    if CValorPercentual.ItemIndex = 0 then //valor
    begin
      ValDesconto := EValDescontoAcrescimo.AValor;
      if (CAcrescimoDesconto.ItemIndex = 0) then
        ValDesconto := ValDesconto * (-1);
    end
    else
      if CValorPercentual.ItemIndex = 1 then //percentual
      begin
        PerDesconto := EValDescontoAcrescimo.AValor;
        if (CAcrescimoDesconto.ItemIndex = 0) then
          PerDesconto := PerDesconto * (-1);
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CalculaValorTotalProduto;
begin
  VprDProdutoNota.ValTotal := VprDProdutoNota.ValUnitario * VprDProdutoNota.QtdProduto;
  VprDProdutoNota.ValIPI := ArredondaDecimais((VprDProdutoNota.ValTotal * VprDProdutoNota.PerIPI)/100,2);
  GProdutos.Cells[8,GProdutos.ALinha] := FormatFloat(varia.MascaraQtd,VprDProdutoNota.QtdProduto);
  GProdutos.Cells[9,GProdutos.ALinha] := FormatFloat('###,###,###,##0.0000',VprDProdutoNota.ValUnitario);
  GProdutos.Cells[10,GProdutos.ALinha] := FormatFloat('R$ #,###,###,###,##0.000',VprDProdutoNota.ValTotal);
  GProdutos.Cells[15,GProdutos.ALinha] := FormatFloat('#,###,###,###,##0.000',VprDProdutoNota.ValIPI);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteProduto : Boolean;
begin
  if (GProdutos.Cells[1,GProdutos.ALinha] <> '') then
  begin
    if GProdutos.Cells[1,GProdutos.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      VprDProdutoNota.SeqProduto := 0;
      result := FunNotaFiscal.ExisteProduto(GProdutos.Cells[1,GProdutos.ALinha],VprDNota,VprDProdutoNota);
      if result then
      begin
        VprDProdutoNota.UnidadeParentes.free;
        VprDProdutoNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDProdutoNota.UMOriginal);
        VprProdutoAnterior := VprDProdutoNota.CodProduto;
        if VprDProdutoNota.IndReducaoICMS then
          GProdutos.Cells[13,GProdutos.ALinha] := FormatFloat('0.00%',(VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMS)/100);

        GProdutos.Cells[1,GProdutos.ALinha] := VprDProdutoNota.CodProduto;
        GProdutos.Cells[2,GProdutos.ALinha] := VprDProdutoNota.NomProduto;
        GProdutos.Cells[7,GProdutos.ALinha] := VprDProdutoNota.UM;
        GProdutos.Cells[5,GProdutos.ALinha] := VprDProdutoNota.CodClassificacaoFiscal;
        ReferenciaProduto;
        CalculaValorTotalProduto;
        if VprDNota.IndBaixarEstoque then
          if FUnProdutos.TextoPossuiEstoque(1, VprDProdutoNota.QtdEstoque,' kit ') then
            FUnProdutos.TextoQdadeMinimaPedido( VprDProdutoNota.QtdMinima,VprDProdutoNota.QtdPedido, 1);
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteServico : Boolean;
begin
  if (GServicos.Cells[1,GServicos.ALinha] <> '') then
  begin
    if (GServicos.Cells[1,GServicos.ALinha] = VprServicoAnterior)  then
      result := true
    else
    begin
      result := FunNotaFiscal.ExisteServico(GServicos.Cells[1,GServicos.ALinha],VprDNota,VprDServicoNota);
      if result then
      begin
        VprServicoAnterior := GServicos.Cells[1,GServicos.ALinha];
        GServicos.Cells[2,GServicos.Alinha] := VprDServicoNota.NomServico;
        GServicos.Cells[4,GServicos.ALinha] :=  FormatFloat(varia.MascaraQtd,VprDServicoNota.QtdServico);
        GServicos.Cells[5,GServicos.ALinha] :=  FormatFloat(varia.MascaraValorUnitario,VprDServicoNota.ValUnitario);
        if VprDNota.IndCalculaISS then
        begin
          if VprDServicoNota.PerISSQN <> 0 then
            EPerISSQN.AValor := VprDServicoNota.PerISSQN
          else
            EPerISSQN.AValor := VprPerISSQN;
        end;
        CalculaValorTotalServico;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CalculaValorTotal;
begin
  if CAutoCalculo.Checked then
  begin
    if VprOperacao in [ocInsercao,ocEdicao] then
    begin
      CarDValorTotal;
      FunNotaFiscal.CalculaValorTotal(VprDNota,VprDCliente);
      CarDValorTotalTela;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CalculaValorTotalServico;
begin
  VprDServicoNota.ValTotal := VprDServicoNota.ValUnitario * VprDServicoNota.QtdServico;
  GServicos.Cells[6,GServicos.ALinha] := FormatFloat(varia.MascaraValor,VprDServicoNota.ValTotal);
end;

{******************************************************************************}
function  TFNovaNotaFiscalNota.LocalizaProduto : Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDProdutoNota,ECodCliente.Ainteiro); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    with VprDProdutoNota do
    begin
      VprDProdutoNota.UnidadeParentes.free;
      VprDProdutoNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(UMOriginal);
      VprProdutoAnterior := CodProduto;
      GProdutos.Cells[1,GProdutos.ALinha] := CodProduto;
      GProdutos.Cells[2,GProdutos.ALinha] := NomProduto;
      GProdutos.Cells[5,GProdutos.ALinha] := CodClassificacaoFiscal;
      GProdutos.Cells[7,GProdutos.ALinha] := UM;
      if VprDProdutoNota.IndReducaoICMS then
        GProdutos.Cells[13,GProdutos.ALinha] := FormatFloat('0.00%',(VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMS)/100);
      CalculaValorTotalProduto;
      ReferenciaProduto;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.LocalizaServico : Boolean;
begin

  FlocalizaServico := TFlocalizaServico.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaServico'));
  result := FlocalizaServico.LocalizaServico(VprdServicoNota);
  FlocalizaServico.free; // destroi a classe;

  if result then  // se o usuario nao cancelou a consulta
  begin
    VprDServicoNota.QtdServico := 1;
    GServicos.Cells[1,GServicos.ALinha] := IntToStr(VprDServicoNota.CodServico);
    GServicos.Cells[2,GServicos.ALinha] := VprDServicoNota.NomServico;
    GServicos.Cells[4,GServicos.ALinha] :=  FormatFloat(varia.mascaraQtd,VprDServicoNota.QtdServico);
    GServicos.Cells[5,GServicos.ALinha] :=  FormatFloat(varia.MascaraValorUnitario,VprDServicoNota.ValUnitario);
    if VprDNota.IndCalculaISS then
    begin
      if VprDServicoNota.PerISSQN <> 0 then
        EPerISSQN.AValor := VprDServicoNota.PerISSQN
      else
        EPerISSQN.AValor := VprPerISSQN;
    end;
    CalculaValorTotalServico;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteUM : Boolean;
begin
  if (VprDProdutoNota.UMAnterior = GProdutos.cells[7,GProdutos.ALinha]) then
    result := true
  else
  begin
    result := (VprDProdutoNota.UnidadeParentes.IndexOf(GProdutos.Cells[7,GProdutos.Alinha]) >= 0);
    if result then
    begin
      VprDProdutoNota.UM := GProdutos.Cells[7,GProdutos.Alinha];
      VprDProdutoNota.UMAnterior := VprDProdutoNota.UM;
      VprDProdutoNota.ValUnitario := FunProdutos.ValorPelaUnidade(VprDProdutoNota.UMOriginal,VprDProdutoNota.UM,VprDProdutoNota.SeqProduto,
                                               VprDProdutoNota.ValUnitarioOriginal);
      CalculaValorTotalProduto;
    end;
  end;
end;

{***************** verifica se as variaveis necessarias esta iniciadas *******}
function TFNovaNotaFiscalNota.VerificaVariaveis : string;
begin
  result := '';
  if Varia.NotaFiscalPadrao = 0 then
    result := CT_NotaFaltante;

  if result = '' then
  begin
    if ConfigModulos.Caixa then
      if varia.OperacaoReceber = 0 then
        result := CT_FaltaCFGOpeCaixaRC;
  end;
  //verifica se não faltam dados do cfg
  if result = '' then
  begin
    if (varia.CodigoEmpresa = 0) or (varia.CodigoEmpFil = 0) or (varia.EstadoPadrao = '')   then
      result := CT_FaltaCFGFiscalECF;
  end;
  if result = '' then
  begin
    if config.EmiteNFe then
    begin
      if varia.CodIBGEMunicipio = 0  then
        result := 'CODIGO IBGE MUNICIPIO EMITENTE NÃO PREENCHIDO!!!'#13'É necessário importar os municipios com o codigo o IBGE, em seguida altere a filial entre e saia do campo cidade.';
    end;
  end;
end;

{************ monta nova nota, chamada externa ******************************* }
function TFNovaNotaFiscalNota.NovaNotaFiscal : Boolean;
var
  VpfResultado : String;
begin
  result := false;
  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;

   VpfResultado :=  VerificaVariaveis;
   if VpfResultado = '' then
   begin
     ConfiguraItemNota(Varia.NotaFiscalPadrao);
     InicializaNota;
     ShowModal;
     result := VprAcao;
   end
   else
     aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.InicializaNota;
begin
  VprPerISSQN := varia.ISSQN;
  VprCodNaturezaAtual := '';
  LimpaDadosClientes;
  VprDCliente.free;
  VprDCliente := TRBDCliente.cria;
  VprDTransportadora.free;
  VprDTransportadora := TRBDTransportadora.Create;
  VprDNota.free;
  VprDNota := TRBDNotaFiscal.cria;
  with VprDNota do
  begin
    IndNotaCancelada := false;
    IndECF := false;
    IndNotaImpressa := false;
    IndNotaDevolvida := false;
    IndReducaoICMS := false;
    IndRevendaEdson := false;
    CodFilial := Varia.CodigoEmpFil;
    CodNatureza := Varia.NaturezaNota;
    CodUsuario := Varia.CodigoUsuario;
    CodTipoFrete := varia.FretePadraoNF;
    if CodTipoFrete = 0 then
       CodTipoFrete := 2;
    DatEmissao := date;
    DatSaida := date;
    HorSaida := now;
    DesSerie := Varia.SerieNota;
    if varia.MarcaEmbalagem <> '' then
      DesMarcaEmbalagem := varia.MarcaEmbalagem;
    DesPlacaVeiculo := varia.PlacaVeiculoNota;
    CodTransportadora := varia.CodTransportadora;
    CodCondicaoPagamento := varia.CondPagtoVista;  // condicao de pagamento default
    DesTipoNota := 'S';
    ValDesconto:= 0;
    PerDesconto := 0;
    PerIssqn := varia.ISSQN;
  end;

  GProdutos.ADados := VprDNota.Produtos;
  GServicos.ADados := VprDNota.Servicos;
  LimpaComponentes(FundoNota,0);
  EstadoBotoes(true);
  CarDTela;
  CAutoCalculo.Checked := true;
  LimpaStringGrid;
  ActiveControl := ECodNatureza;
  CarregaDadosFilial;  // carrega o cgc e incricao da filial
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Funcoes dos componentes superiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{****************Carrega o cgc e o cpf da filial da nota fiscal****************}
procedure TFNovaNotaFiscalNota.CarregaDadosFilial;
begin
   FunNotaFiscal.LocalizaFilial(Aux,Varia.CodigoEmpFil);
   LCGCFilial.Caption := aux.fieldByName('C_CGC_FIL').AsString;
   LIEFilial.Caption := aux.fieldByName('C_INS_FIL').AsString;
   LNomFilial.Caption := aux.fieldByName('C_NOM_FAN').AsString;
   VprTextoReducao := aux.fieldByName('C_TEX_RED').AsString;
   VprDNota.DesDadosAdicinais.text := aux.fieldByName('C_DAD_ADI').AsString;
  MAdicional.Clear;
     // daddos adionais
  if VprDNota.DesDadosAdicinais.text <> '' then
    MAdicional.Lines.Text := VprDNota.DesDadosAdicinais.text;

   Aux.Close;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ValidaValorUnitarioProduto;
begin
  if GProdutos.Cells[9,GProdutos.ALinha] <> '' then
  begin
    VprDProdutoNota.ValUnitario := StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'));
    if VprDProdutoNota.ValUnitario <> FunProdutos.ValorPelaUnidade(VprDProdutoNota.UMOriginal,VprDProdutoNota.UM,VprDProdutoNota.SeqProduto,
                                 VprDProdutoNota.ValUnitarioOriginal) then
    begin
     if not FunProdutos.ValidaAlterarValorUnitario( FPrincipal.CorForm.ACorPainel, FPrincipal.CorFoco.AFundoComponentes ) then
     begin
       VprDProdutoNota.ValUnitario := FunProdutos.ValorPelaUnidade(VprDProdutoNota.UMOriginal,VprDProdutoNota.UM,VprDProdutoNota.SeqProduto,
                                 VprDProdutoNota.ValUnitarioOriginal);
     end
     else
       VprDProdutoNota.ValUnitarioOriginal := FunProdutos.ValorPelaUnidade(VprDProdutoNota.UM,VprDProdutoNota.UMOriginal,VprDProdutoNota.SeqProduto,VprDProdutoNota.ValUnitario);
    end;
  end
  else
    VprDProdutoNota.ValUnitario := 0;
  CalculaValorTotalProduto;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.DadoNfeValidos(VpaDCliente: TRBDCliente): string;
begin
  result := '';
  if config.EmiteNFe then
  begin
    if VpaDCliente.DesEndereco = '' then
      result := 'ENDEREÇO DO CLIENTE NÃO PREENCHIDO!!!'#13'É necessário preencher o endereço do cliente.';
    if Result = '' then
    begin
      if Result = '' then
      begin
        if VpaDCliente.DesBairro = '' then
          result := 'BAIRRO DO CLIENTE NÃO PREENCHIDO!!!!'#13'É necessário preencher o bairro do cliente.';
        if Result = '' then
        begin
          if VpaDCliente.CodIBGECidade = 0 then
            result := 'CODIGO IBGE DA CIDADE NÃO PREENCHIDA!!!!'#13'É necessário preencher o codigo do IBGE da Cidade do cliente.';
          if Result = '' then
          begin
            if VpaDCliente.CodPais = 0 then
              result := 'CODIGO IBGE DO PAIS NÃO PREENCHIDO!!!!'#13'É necessário preencher o codigo do IBGE do pais do cliente.';
          end;
        end;
      end;
    end;
    if result = '' then
    begin
      if VprDNota.CodTransportadora <> 0 then
      begin
        if VprDTransportadora.Endereco = '' then
          result := 'ENDEREÇO DA TRANSPORTADORA NÃO PREENCHIDO!!!'#13+'É necessário preencher o endereço da transportadora'
        else
          if VprDTransportadora.CGC_CPF = '' then
            result := 'CNPJ DA TRANSPORTADORA NÃO PREENCHIDO!!!'+#13+'É necessário preencher o CNPJ da transportadora '
          else
            if VprDTransportadora.InscricaoEstadual = '' then
              result := 'INSCRIÇÃO ESTADUAL DA TRANSPORTADORA NÃO PREENCHIDA!!!'+#13+'É necessário preencher a INSCRIÇÃO ESTADUAL da transportadora.'
            else
              if VprDTransportadora.Cidade = ''  then
                result := 'CIDADE DA TRANSPORTADORA NÃO PREENCHIDA!!!'+#13+'É necessário preencher a cidade da transportadora.'
              else
                if VprDTransportadora.UF = '' then
                  result := 'UF DA TRANSPORTADORA NÃO PREENCHIDA!!!'+#13+'É necessário preencher a UF da transportadora.';
      end;
      if result = '' then
      begin
        if ((EPlacaVeiculo.Text <> '') and (EUFVeiculo.Text = '')) or
           ((EPlacaVeiculo.Text = '') and (EUFVeiculo.Text <> ''))then
          result := 'PLACA DO VEICULO E UF DO VEICULOA NÃO FORAM PREENCHIDOS!!!'#13'É necessario preencher a UF e a placa do veiculo.';
      end;
      if result = '' then
      begin

      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.DadosNotaValidos : String;
begin
  AtualizaStatus('Validados os dados da nota.');
  result := '';
  if ((VprDNota.Produtos.Count = 0) and (VprDNota.Servicos.Count=0)) and
     (VprDNota.IndNaturezaProduto or VprDNota.IndNaturezaServico) then
    result := 'NÃO FOI ADICIONADO NENHUM PRODUTO OU SERVIÇO!!!'#13'Não é possivel gravar a nota fiscal porque não foram adicinados nenhum produto ou serviço.';
  if result = '' then
  begin
    if VprDNota.CodCliente = 0 then
      result := 'FALTA SELECIONAR CLIENTE!!!'#13'É necessário preencher o cliente.';

    if result = '' then
    begin
      if VprDNota.IndGeraFinanceiro then
      begin
        if (VprDNota.CodCondicaoPagamento = 0) then
          result := 'FALTA SELECIONAR A CONDIÇÃO DE PAGAMENTO!!!'#13'É necessário preencher a condição de pagamento.'
        else
          if VprDNota.CodFormaPagamento = 0 then
            result := 'FALTA SELECIONAR A FORMA DE PAGAMENTO!!!'#13'É necessário preencher a forma de pagamento.';
      end;

      if result = '' then
      begin
        if (VprDNota.CodVendedor = 0) and (VprDNota.IndGeraComissao) then
          result := 'FALTA SELECIONAR O VENDEDOR!!!'#13'É necessário preencher o vendedor.';
      end;
    end;
  end;
  if result = '' then
  begin
    if VprDNota.CodNatureza = '' then
      result :=  'FALTA SELECIONAR A NATUREZA DE OPERAÇÃO!!!'#13'É necessário preencher a natureza de operação.';
    if result = '' then
    begin
      if VprDNota.SeqItemNatureza = 0 then
        result := 'FALTA SELECIONAR O ITEM DA NATUREZA DE OPERACÃO!!!'#13'É necessário preencher o item da natureza de operação.';
    end;
  end;

  if (config.QtdVolumeObrigatorio) and not(GProdutos.Focused) and not(GServicos.Focused) then
  begin
    if EQtd.AsInteger = 0 then
      result := 'QUANTIDADE DE VOLUMES NÃO PREENCHIDA!!!'#13'É obrigatório digitar a quantidade de volumes na nota fiscal.';
  end;
  if not(config.NotaFiscalConjugada) and (VprDNota.Produtos.Count > 0) and
     (VprDNota.Servicos.Count > 0) then
    result := 'NÃO É PERMITIDO NOTA FISCAL CONJUGADA!!!'#13'Não é possivel adicionar produtos e serviços na mesma nota fiscal.';


  if result = '' then
  begin
    if (varia.CNPJFilial = CNPJ_Kairos) or (Varia.CNPJFilial = CNPJ_AviamentosJaragua) then
    begin
      if (varia.CodigoUsuario = 8) and not(CRevendaEdson.Checked) then
      begin
        if not confirmacao('REVENDA EDSON NÃO SELECIONADO!!!'#13'Cara Geisa, você não selecionou a Revenda Edson. Tem certeza  deseja continuar?') then
          result := 'TIPO REVENDA NÃO SELECIONADO!!!'#13'Faltou selecionar a opção Revenda Edson.';
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AtualizaStatus(VpaStatus : String);
begin
  StatusBar1.Panels[0].Text := VpaStatus;
  StatusBar1.Refresh;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.LimpaDadosClientes;
begin
  Label34.Caption := '';
  LCGCCPF.Caption := '';
  LEndereco.Caption := '';
  LBairro.Caption := '';
  LCep.Caption := '';
  LCidade.Caption := '';
  LUF.Caption := '';
  LFone.Caption := '';
  LCGCTranposrtadora.Caption := '';
  LEnderecoTransportadora.Caption := '';
  LNumEnderecoTransportadora.Caption := '';
  LMunicipioTransportadora.Caption := '';
  LUFTransportadora.Caption := '';
  LInscricaoTransportadora.Caption := '';
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.AdicionaItemProduto(VpaDProdutoNota : TRBDNotaFiscalProduto);
begin
  FunNotaFiscal.ExisteProduto('',VprDNota,VpaDProdutoNota);
  VprDProdutoNota.UnidadeParentes.free;
  VprDProdutoNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDProdutoNota.UMOriginal);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.RNumerosPedido : String;
var
  VpfLaco : Integer;
begin
  result := '';
  if VprCotacoes <> nil then
  begin
    for VpfLaco := 0 to VprCotacoes.Count - 1 do
    begin
      result := result + IntTostr(TRBDOrcamento(VprCotacoes.Items[Vpflaco]).LanOrcamento)+'; ';
    end;
    if result <> '' then
    begin
      result := copy(result,1,length(result)-2);
      result := 'Cotacoes : '+ result;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.TelaModoConsulta(VpaConsulta : Boolean);
begin
  AlteraReadOnlyDet(FundoNota,0,VpaConsulta);
  AlterarEnabledDet([CAutoCalculo,CAcrescimoDesconto,CValorPercentual,RTipoNota],not VpaConsulta);
  if VpaConsulta then
    GProdutos.Options := [gofixedVertLine,gofixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing]
  else
    GProdutos.Options := [gofixedVertLine,gofixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing,goEditing,goTabs];
end;

{********************** select da natureza de operacao ********************* }
procedure TFNovaNotaFiscalNota.ECodNaturezaSelect(Sender: TObject);
begin
  ECodNatureza.ASelectLocaliza.Clear;
  ECodNatureza.ASelectLocaliza.add(' Select * from CadNatureza where c_nom_nat like ''@%'' ' +
                                  ' and c_cod_nat in ( select c_cod_nat from movNatureza ' +
                                  '                    where c_mos_not = ''S'' '  );
  ECodNatureza.ASelectValida.clear;
  ECodNatureza.ASelectValida.Add(' select * from CadNatureza where C_COD_NAT = ''@'' ' +
                                ' and c_cod_nat in ( select c_cod_nat from movNatureza ' +
                                '                    where c_mos_not = ''S'' '  );
  if ConfigModulos.Estoque then
  begin
    ECodNatureza.ASelectLocaliza.add(' and i_cod_ope is not null');
    ECodNatureza.ASelectValida.Add(' and i_cod_ope is not null');
  end;
  if ConfigModulos.ContasAReceber then
  begin
    ECodNatureza.ASelectLocaliza.add(' and C_CLA_PLA is not null');
    ECodNatureza.ASelectValida.Add(' and C_CLA_PLA is not null');
  end;
  ECodNatureza.ASelectLocaliza.add(' )');
  ECodNatureza.ASelectValida.Add(' ) ');
end;

{*************** retorno da localizacao da natureza ************************ }
procedure TFNovaNotaFiscalNota.ECodNaturezaRetorno(Retorno1, Retorno2: String);
begin
  if (retorno1 <> '')and (retorno1 <> VprCodNaturezaAtual) then
  begin
    FunNotaFiscal.LocalizaMovNatureza(MovNatureza, retorno1, true );

    if FunNotaFiscal.ContaLinhasTabela(MovNatureza) > 1 then
    begin
      FItensNatureza := TFItensNatureza.CriarSDI(application, '', true);
      FItensNatureza.PosicionaNatureza(MovNatureza);
      FItensNatureza.free;
    end;
    VprDNota.CodNatureza := MovNatureza.fieldbyName('C_COD_NAT').AsString;
    VprDNota.SeqItemNatureza := MovNatureza.fieldbyName('i_seq_mov').AsInteger;
    FunNotaFiscal.CarDNaturezaOperacao(VprDNota);

    MontaObservacao;
    if VprOperacao in [ocInsercao,ocEdicao] then
      FunNotaFiscal.AlteraValorICMS(VprDNota);
    GProdutos.CarregaGrade;

    //verifica se o tipo de nota é de entrada ou saída
    if retorno2  = 'S' then
    begin
      VprDNota.DesTipoNota := 'S';
      RTipoNota.ItemIndex := 1;
    end
    else
    begin
      VprDNota.DesTipoNota := 'E';
      RTipoNota.ItemIndex := 0;
    end;

    // caso a natureza nao permita insercao de produtos.
    if VprOperacao in [ocInsercao,ocEdicao] then
      if MovNatureza.FieldByname('c_ins_pro').AsString  = 'N' then
        GProdutos.Options := GProdutos.Options - [goEditing,goTabs] // [gofixedVertLine,gofixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing]
      else
        GProdutos.Options := GProdutos.Options + [goEditing,goTabs];//[gofixedVertLine,gofixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goRowSizing,goColSizing,goEditing,goTabs];

    // caso nao gere contas a receber
    if not VprDNota.IndGeraFinanceiro then
    begin
      if not((VprOrcamento) and (config.GerarFinanceiroCotacao) and not(config.ExcluirFinanceiroCotacaoQuandoGeraNota)) then
      begin
        AlterarEnabledDet([Econdicoes,BCondicao],false);
        ECondicoes.ACampoObrigatorio := false;
        Econdicoes.ACampoObrigatorio := false;
        ECondicoes.Clear;
        LNomCondicao.Caption := '';
      end;
    end
    else
    begin
      AlterarEnabledDet([Econdicoes,BCondicao],true);
      Econdicoes.ACampoObrigatorio := true;
    end;
    if VprOperacao in [ocInsercao,ocEdicao] then
        ValidaGravacao1.Execute;
    VprCodNaturezaAtual := retorno1;
  end;
end;

{*************** cadastro de nova natureza *********************************** }
procedure TFNovaNotaFiscalNota.ECodNaturezaCadastrar(Sender: TObject);
begin
   FNovaNatureza := TFNovaNatureza.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNatureza'));
   FNovaNatureza.CadNaturezas.Insert;
   FNovaNatureza.BotaoGravar1.AFecharAposOperacao := true;
   FNovaNatureza.ShowModal;
   Localiza.AtualizaConsulta;
   AtualizaSQLTabela(MovNatureza);
end;

{*************** retorno da localizacao do cliente ************************* }
procedure TFNovaNotaFiscalNota.ECodClienteRetorno(Retorno1, Retorno2: String);
var
  VpfAcao : boolean;
  VpfResultado : String;
begin
  VpfAcao := true;
  if retorno1 <> '' then
  begin
    if StrToInt(Retorno1) <> VprDCliente.CodCliente then
    begin
      VprDCliente.CodCliente := StrToInt(retorno1);
      VpfResultado := FunClientes.CarDCliente(VprDCliente,false,VprDNota.IndExigirCPFCNPJ);
      if VpfResultado = '' then
      begin
         VpfResultado := DadoNfeValidos(VprDCliente);

        if VpfResultado = '' then
        begin
          if (VprOperacao in [ocInsercao,OcEdicao]) then
          begin
            VprDNota.IndClienteRevenda := VprDCliente.IndRevenda;
            VprDNota.IndDescontarISS := VprDCliente.IndDescontarISS;
            if not VprNotaAutomatica then
              VpfAcao := SituacaoFinanceiraOK(VprDCliente);

            if VprDCliente.TipoPessoa <> 'E' then
            begin
              if VprDNota.IndNaturezaEstadoLocal then
              begin
                if Uppercase(VprDCliente.DesUF) <> UpperCase(Varia.EstadoPadrao) then
                 VpfAcao := False;
              end
              else
                if UpperCase(VprDCliente.DesUF) = UpperCase(Varia.EstadoPadrao) then
                  VpfAcao := False;
            end;

            If VpfAcao Then
            begin
              CardClienteNota(VprDCliente);
              if (VprDNota.IndCalculaICMS) and (VprDCliente.IndDestacarICMSNota) then
                VprDNota.ValICMSPadrao := FunNotaFiscal.RValICMSPadrao(VprDCliente.DesUF,VprDCliente.InscricaoEstadual,VprDCliente.TipoPessoa[1] = 'J',false)
              else
                VprDNota.ValICMSPadrao := 0;
              if (VprDCliente.DesObservacao <> '') and not VprNotaAutomatica then
              begin
                FMostraObservacaoCliente := TFMostraObservacaoCliente.CriarSDI(application , '', FPrincipal.VerificaPermisao('FMostraObservacaoCliente'));
                FMostraObservacaoCliente.MostraObservacaoCliente(VprDCliente);
                FMostraObservacaoCliente.free;
              end;
            end;
          end;
        end;
      end;

      if not VpfAcao or (VpfResultado <> '') then
      begin
        if VprOrcamento and (VpfResultado = '') then
          ECodNatureza.Clear
        else
        begin
          if VpfResultado = '' then
            aviso(CT_NaturezaErrada)
          else
            aviso(VpfResultado);
          ECodCliente.Clear;
          if Visible then
            ECodCliente.SetFocus
          else
            ActiveControl := ECodCliente;
          VprDCliente.CodCliente:=0;
        end;
      end;
    end;
  end
  else
  begin
    VprDNota.CodCliente := 0;
    LimpaDadosClientes;
  end;
 // CalculaValorTotal;
end;

{************* cadastro de novo cliente ************************************* }
procedure TFNovaNotaFiscalNota.ECodClienteCadastrar(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(application,'', true);
   FNovoCliente.CadClientes.Insert;
   FNovoCliente.ShowModal;
   Localiza.AtualizaConsulta;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        Tratamentos dos produtos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteCor : Boolean;
begin
  result := false;
  if (GProdutos.Cells[3,GProdutos.Alinha]<> '') then
  begin
    result := FunNotaFiscal.Existecor(GProdutos.Cells[3,GProdutos.ALinha],VprDProdutoNota);
    if result then
    begin
      GProdutos.Cells[4,GProdutos.ALinha] := VprDProdutoNota.DesCor;
      ReferenciaProduto;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ExisteCondicaoPagamento : Boolean;
begin
  result := true;
  if ECondicoes.AInteiro <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from CADCONDICOESPAGTO '+
                              ' Where I_COD_PAG = '+ECondicoes.Text);
    result := not Aux.Eof;
    if result then
    begin
      LNomCondicao.Caption := Aux.FieldByName('C_NOM_PAG').AsString;
      if VprDNota.PerDesconto = 0 then
        VprDNota.PerDesconto := Aux.FieldByName('N_PER_DES').AsFloat;
      CarDValorTotalTela;
      CalculaValorTotal;
    end;
    Aux.Close;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ReferenciaProduto;
begin
  VprDProdutoNota.DesRefCliente := FunProdutos.RReferenciaProduto(VprDProdutoNota.SeqProduto,VprDNota.CodCliente,GProdutos.Cells[3,GProdutos.ALinha]);
  GProdutos.Cells[11,GProdutos.ALinha] := VprDProdutoNota.DesRefCliente;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Funcoes do Corpo da Nota - inferior
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************** chamada para calcular a nota fiscal ************************* }
procedure TFNovaNotaFiscalNota.EValFreteExit(Sender: TObject);
begin
 CalculaValorTotal;
end;

{************************ no exit da condicao de pagamento ****************** }
procedure TFNovaNotaFiscalNota.ECondicoesExit(Sender: TObject);
begin
  if (VprOperacao in [ocInsercao,ocEdicao]) then
    if not ExisteCondicaoPagamento then
    begin
      Econdicoes.Clear;
      LocalizaCondicaoPagto;
    end;
end;

{************** Localiza Condicao de pagto ********************************** }
function  TFNovaNotaFiscalNota.LocalizaCondicaoPagto : Boolean;
begin
  CarDClasse;
  FConsultaCondicaoPgto := TFConsultaCondicaoPgto.CREATE(SELF);
  result := FConsultaCondicaoPgto.VisualizaParcelasNota(VprDNota);
  if result then
  begin
    ECondicoes.AInteiro := VprDNota.CodCondicaoPagamento;
    CalculaValorTotal;
    CarDTela;
  end;
  try
    FConsultaCondicaoPgto.free;
  except
  end;
end;

{********************* No retorno da transportadora ************************* }
procedure TFNovaNotaFiscalNota.ECodTransportadoraRetorno(Retorno1,
  Retorno2: String);
begin
  if ECodTransportadora.Text <> '' then
  begin
    FunNotaFiscal.CarDTransportadora(VprDTransportadora,ECodTransportadora.AInteiro);
    CarDTransportadoraTela;
  end;
end;

{************ no retorno do vendedor ***************************************** }
procedure TFNovaNotaFiscalNota.ECoDVendedorRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
     if VprDCliente.PerComissao = 0 then
       EPerComissao.AValor := StrToFloat(retorno1);
  end;
end;

{************ no click do botao localiza condicao pagamento ***************** }
procedure TFNovaNotaFiscalNota.BCondicaoClick(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    LocalizaCondicaoPagto;
end;

procedure TFNovaNotaFiscalNota.BEnviarClick(Sender: TObject);
var
  VpfFunNFE : TRBFuncoesNFe;
  VpfResultado : String;
begin
  VpfFunNFE := TRBFuncoesNFe.cria(FPrincipal.BaseDados);
  VpfResultado := VpfFunNFE.EnviaEmailDanfe(VprDNota,VprDCliente);
  VpfFunNFE.free;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{************** localiza condicoes de pagamento F3 ************************** }
procedure TFNovaNotaFiscalNota.ECondicoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
  begin
    LocalizaCondicaoPagto;
  end;
end;

{********** verifica se 0 usuario digita somente 1 ou 2 ********************** }
procedure TFNovaNotaFiscalNota.ECodTipoFreteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in [ '1','2', #8, #46]) then
     Key := #0;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Funcoes dos Botoes inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{***************** quando cancela uma nota fiscal *************************** }
procedure TFNovaNotaFiscalNota.BotaoCancelar1Click(Sender: TObject);
begin
  LimpaComponentes(FundoNota,0);
  FreeTObjectsList(VprDNota.Produtos);
  GProdutos.CarregaGrade;
  EstadoBotoes(False);
  BotaoGravar1.Enabled := false;
  if VprOrcamento then
    close;
end;

{***************** grava uma nova nota fiscal ******************************** }
procedure TFNovaNotaFiscalNota.BotaoGravar1Click(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao :  TTransactionDesc;
begin
  VpfResultado := '';
  AtualizaStatus('Validando a condição de pagamento');
  if VprOrcamento then
    if not LocalizaCondicaoPagto then
      Econdicoes.Clear;

  if ((Econdicoes.text = '') or ( VprDNota.CodFormaPagamento = 0)) and VprDNota.IndGeraFinanceiro then
  begin
    if not LocalizaCondicaoPagto then
      vpfResultado := 'CONDIÇÃO DE PAGAMENTO NÃO PREENCHIDA!!!'#13'Para gravar a nota é obrigatório preencher a condição de pagamento.';
  end;

  if VpfResultado = '' then
  begin
    AtualizaStatus('Carregando os dados para a classe.');
    VpfResultado := CarDClasse;
    if VpfResultado = '' then
    begin
      AtualizaStatus('Validando os dados da nota');
      VpfResultado := DadosNotaValidos;
      if VpfResultado = '' then
      begin
        VpfResultado := GeraFinanceiroNota;
        if VpfResultado = '' then
        begin
          if FPrincipal.BaseDados.intransaction then
            FPrincipal.BaseDados.Rollback(VpfTransacao);
          VpfTransacao.IsolationLevel :=xilREADCOMMITTED;
          FPrincipal.BaseDados.StartTransaction(vpfTransacao);
          AtualizaStatus('Gravando os dados da nota fiscal');
          vpfResultado := FunNotaFiscal.GravaDNotaFiscal(VprDNota);
          if VpfResultado = '' then
          begin
            VpfResultado := BaixaNota;
            if VpfResultado = '' then
            begin
              if VprOrcamento Then
              begin
                CarProBaixadosOrcamento;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  if VpfResultado = '' then
  begin
    FPrincipal.BaseDados.Commit(vpfTransacao);
    EstadoBotoes(false);
    BotaoGravar1.Enabled := false;
    VprAcao := true;
    ENumNota.AsInteger := VprDNota.NumNota;
    EClaFiscal.Text := VprDNota.DesClassificacaoFiscal;
    AtualizaStatus('Nota fiscal gravada com sucesso.');
    TelaModoConsulta(true);
  end
  else
  begin
    if FPrincipal.BaseDados.intransaction then
      FPrincipal.BaseDados.Rollback(VpfTransacao);
    aviso(VpfREsultado);
  end;
end;

{*********** cadastra uma nova nota fiscal *********************************** }
procedure TFNovaNotaFiscalNota.BotaoCadastrar1Click(Sender: TObject);
begin
  VprOperacao := ocinsercao;
  VprOrcamento := false;
  TelaModoConsulta(false);
  InicializaNota;
end;

{************* gera a tela de digitacao de observacao ************************ }
procedure TFNovaNotaFiscalNota.BObservacaoClick(Sender: TObject);
begin
   MontaObservacao;
   FObservacoesNota := TFObservacoesNota.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FObservacoesNota'));
   FObservacoesNota.ObservacaodaNota(MObservacoes.lines.text,vprdNota, NroLinhaObs);
   MontaObservacao;
end;

{************ imprime a nota fiscal ***************************************** }
procedure TFNovaNotaFiscalNota.BImprimirClick(Sender: TObject);
var
  VpfFunNFE : TRBFuncoesNFe;
  VpfResultado : String;
begin
  if config.EmiteNFe then
  begin
    if not Config.NotaFiscalConjugada and
      (VprDNota.Servicos.Count > 0) then
      UnImp.ImprimirNotaFiscal(VprDNota)
    else
    begin
      VpfFunNFE := TRBFuncoesNFe.cria(FPrincipal.BaseDados);
      if VprDNota.DesChaveNFE = '' then
      begin
        VpfResultado :=  VpfFunNFE.EmiteNota(VprDNota,VprDCliente,StatusBar1);
        EChaveNFE.Text := VprDNota.DesChaveNFE;
        if Vpfresultado <> ''  then
          aviso(Vpfresultado)
        else
        begin
          VpfResultado := FunNotaFiscal.GravaDNotaFiscal(VprDNota);
          if VpfResultado <> '' then
            aviso(VpfResultado)
          else
            VpfFunNFE.ImprimeDanfe(VprDNota);
        end;
      end
      else
        VpfResultado := VpfFunNFE.ImprimeDanfe(VprDNota);
      VpfFunNFE.free;
      if config.NFEHomologacao then
        UnImp.ImprimirNotaFiscal(VprDNota);
    end;
  end
  else
    UnImp.ImprimirNotaFiscal(VprDNota);

  EstadoBotoes(false);
  BAlterarNumero.visible := false;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Diveros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************ configura a fatura e campos tipo, ipi, valor ipi, servico ****** }
procedure TFNovaNotaFiscalNota.ConfiguraItemNota( NroDoc : Integer);
begin
  UnImp.LocalizaCab(aux, NroDoc);  // abre cabecalho do documento

  FunNotaFiscal.ConfiguraFatura(GRADEPAR, Aux.FieldByName('i_qtd_col').AsInteger, LTituloFaturas);
  NroLinhaProdutos := Aux.FieldByName('i_qtd_lin').AsInteger;
  NroLinhaFatura := Aux.FieldByName('i_qtd_fat').AsInteger;
  NroConjuntoFatura := Aux.FieldByName('i_qtd_col').AsInteger;
  MAdicional.AQdadeLinha := Aux.FieldByName('I_QTD_ADI').AsInteger;
  NroLinhaObs := Aux.FieldByName('I_QTD_OBS').AsInteger;

  GRADEPAR.RowCount := NroLinhaFatura;

  if NroLinhaFatura > 1 then   // configura a rolagem da grade de parcelas
    GRADEPAR.ScrollBars := ssVertical
  else
    GRADEPAR.ScrollBars := ssNone;
end;

{*********** muda o foco ***************************************************** }
procedure TFNovaNotaFiscalNota.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 115 then
  begin
    if GProdutos.Focused then
    begin
      if ConfigModulos.Servico then
        GServicos.SetFocus
      else
        ECodTransportadora.SetFocus;
    end
    else
      if PossuiFoco(Panel4) then
      begin
        ECodCliente.SetFocus;
        FundoNota.VertScrollBar.Position := 0;
      end
      else
        if GServicos.Focused then
        begin
          ECodTransportadora.SetFocus;
        end
        else
        begin
          GProdutos.SetFocus;
          FundoNota.VertScrollBar.Position := 0;
        end;
  end;
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
    begin
      BAlterarNota.Visible := true;
      BFinanceiroOculto.visible := true;
      TelaModoConsulta(false);
    end;
  end;
end;

{*************** modifica os botoes conforme acao da nota fiscal ************* }
Procedure TFNovaNotaFiscalNota.EstadoBotoes(Estado : Boolean);
begin
   BObservacao.Enabled := Estado;
   BImprimir.Enabled := not Estado;
   BEnviar.Enabled := not estado;
   BtbImprimeBoleto.Enabled := Not Estado;
   BotaoCancelar1.Enabled := Estado;
   BFechar.Enabled := not Estado;
   BotaoCadastrar1.Enabled := not estado;
   BImprimir.Enabled := not Estado;
   BtbImprimeBoleto.Enabled := not Estado;
end;

{***************************Limpa o StringGrig*********************************}
procedure TFNovaNotaFiscalNota.LimpaStringGrid;
var
   x,y : Integer;
begin
// zera o stringGrid
  for y := 0 to 1 do
    for x := 0 to 5 do
       gradepar.Cells[x,y] := '';
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.MontaObservacao;
begin
  MObservacoes.clear;

   // caso tenha reducao
//  if VprTextoReducao <> '' then
//    MObservacoes.Lines.add(VprTextoReducao);
  if VprTextoReducao <> '' then
    ETextoFiscal.text := VprTextoReducao;

  // texto fiscal conforme naturesas
//  MObservacoes.Lines.Add(VprDNota.DesTextoFiscal);
  if VprDNota.DesTextoFiscal <> '' then
    ETextoFiscal.Text := VprDNota.DesTextoFiscal;


  // observacao digitada pelo usuario
  if VprDNota.DesObservacao.Text <> '' then
    MObservacoes.Lines.add(VprDNota.DesObservacao.Text);

  if MObservacoes.Lines.Strings[MObservacoes.Lines.Count - 1] = '' then
    MObservacoes.Lines.Delete(MObservacoes.Lines.Count - 1);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          baixas da nota
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{********************Carrega o Titulos do grid de Parcelas*********************}
procedure TFNovaNotaFiscalNota.MontaPArcelasCR(VpaParcelaOculta : Boolean);
var
   laco,x,y : Integer;
begin
  LimpaStringGrid;

  x := 0;
  y := 0;

  aux.close;
  aux.sql.Clear;
  aux.sql.Add('select CR.I_LAN_REC, MCR.C_NRO_DUP, MCR.N_VLR_PAR, MCR.D_DAT_VEN ' +
              ' from CadContasAReceber CR, MovContasaReceber MCR ' +
              ' where  ' +
              ' CR.I_SEQ_NOT = ' + IntToStr(VprDNota.SeqNota) +
              ' and CR.I_EMP_FIL = ' + IntToStr(Varia.CodigoEMpFil) +
              ' and CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
              ' and CR.I_LAN_REC =  MCR.I_LAN_REC');
  if VpaParcelaOculta then
    aux.sql.Add(' and CR.C_IND_CAD = ''S''')
  else
    aux.sql.Add(' and CR.C_IND_CAD = ''N''');

  aux.sql.Add(' order by MCR.D_DAT_VEN' );
//  Aux.sql.saveToFile(RetornaDiretorioCorrente+'consulta.sql');
  aux.open;

  LancamentoReceber := aux.fieldByName('I_LAN_REC').AsInteger;

  aux.First;
  while not Aux.Eof do
  begin
     gradepar.Cells[x,y] := aux.fieldByName('C_NRO_DUP').AsString;
     gradepar.Cells[x+1,y] := aux.fieldByName('D_DAT_VEN').AsString;
     gradepar.Cells[x+2,y] := FormatFloat(Varia.MascaraMoeda, aux.fieldByName('N_VLR_PAR').AsFloat);
     inc(y);
     aux.Next;
     if y >= NroLinhaFatura  then
     begin
       y := 0;
       inc(x,3);
       if (x  + 1) > (NroConjuntoFatura * 3) then
        Break;
     end;
  end;
  aux.close;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ExcluiFinanceiroCotacao;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  for VpfLaco := 0 to VprCotacoes.Count - 1 do
  begin
    VpfDCotacao :=TRBDorcamento(VprCotacoes.Items[vpfLaco]);
    FunCotacao.ExcluiFinanceiroOrcamento(VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento);
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraFinanceiroNota : String;
var
  VpfOcultar : Boolean;
begin
  VpfOcultar := false;
  if VprCotacoes <> nil then
    if VprCotacoes.Count > 0 then
      VpfOcultar := trbdorcamento(VprCotacoes.Items[0]).IndProcessamentoFrio;
  VprDNota.IndGerouFinanceiroOculto := VpfOcultar;
  VprDContasaReceber.free;
  VprDContasaReceber := TRBDContasCR.cria;
  result := FunNotaFiscal.GeraFinanceiroNota(VprDNota,VprCotacoes,VprDCliente,VprDContasaReceber, vpfOcultar,false);
  if result = '' then
  begin
    if VprDContasaReceber.ValTotalAcrescimoFormaPagamento <> 0 then
    begin
      VprDNota.ValOutrasDepesesas := VprDNota.ValOutrasDepesesas + VprDContasaReceber.ValTotalAcrescimoFormaPagamento;
      EValOutrasDespesas.AValor := VprDNota.ValOutrasDepesesas;
      CalculaValorTotal;
    end;
    if VprDContasaReceber.ValUtilizadoCredito > 0 then
    begin
      VprDNota.DesObservacao.add('Abatido do Crédito "'+FormatFloat('R$ #,###,###,###,##0.00',VprDContasaReceber.ValUtilizadoCredito)+'". Saldo Crédito "'+FormatFloat('R$ #,###,###,###,##0.00',VprDContasaReceber.ValSaldoCreditoCliente)+'" - '+FormatDateTime('DD/MM/YYYY - HH:MM',now));
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraFinanceiroOculto : String;
begin
  VprDContasaReceber.free;
  VprDContasaReceber := TRBDContasCR.cria;
  result := FunNotaFiscal.GeraFinanceiroNota(VprDNota,VprCotacoes,VprDCliente,VprDContasaReceber, true,true);
  VprDNota.IndGerouFinanceiroOculto := true;
  if result = '' then
    MontaPArcelasCR(true);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.BaixaEstoqueNota : string;
var
  VpfLaco, VpfSeqEstoqueBarra : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  try
    // baixa em estoque
    if ConfigModulos.Estoque then
    begin
      if VprDNota.IndBaixarEstoque then
      begin
        Tempo.execute('Atualizando Estoque Produto...');
        AtualizaStatus('Atualizando Estoque Produtos');
        for VpfLaco := 0 to VprDNota.Produtos.count - 1 do
        begin
          VpfDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpfLaco]);
          VpfDProduto := TRBDProduto.Cria;
          FunProdutos.CarDProduto(VpfDProduto,0,VprDNota.CodFilial,VpfDProdutoNota.SeqProduto);
          FunProdutos.BaixaProdutoEstoque(VpfDProduto,VprDNota.CodFilial,
                                          MovNatureza.fieldByName('I_COD_OPE').AsInteger,
                                          VprDNota.SeqNota,
                                          VprDNota.NumNota,0,
                                          varia.MoedaBase,VpfDProdutoNota.CodCor,0,
                                          VprDNota.DatEmissao,
                                          VpfDProdutoNota.QtdProduto,
                                          VpfDProdutoNota.ValTotal,
                                          VpfDProdutoNota.UM,
                                          VpfDProdutoNota.DesRefCliente,false,VpfSeqEstoqueBarra);
          VpfDProduto.free;
        end;
      end;
      if result = '' then
        result := BaixaEstoqueFiscal;
      Tempo.fecha;
    end;
  except
    on e : Exception do result := 'ERRO NA BAIXA DO ESTOQUE!!!'#13+e.message;
  end;
  Tempo.fecha;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.BaixaEstoqueFiscal : String;
var
  VpfLaco : Integer;
  VpfDProdutoNota : TRBDNotaFiscalProduto;
begin
  if config.EstoqueFiscal and (VprCotacoes.Count > 0) then
  begin
    if VprOrcamento then
      if TRBDOrcamento(VprCotacoes.Items[0]).NumCupomfiscal <> '' then //o estoque fiscal já foi baixado no ECF
        exit;

    Tempo.execute('Atualizando Estoque Fiscal...');
    AtualizaStatus('Atualizando Estoque Fiscal');
    for VpfLaco := 0 to VprDNota.Produtos.count - 1 do
    begin
      VpfDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpfLaco]);
      FunProdutos.BaixaEstoqueFiscal(VprDNota.CodFilial,
                                     VpfDProdutoNota.SeqProduto,
                                      VpfDProdutoNota.CodCor,
                                      0,
                                      VpfDProdutoNota.QtdProduto,
                                      VpfDProdutoNota.UM,
                                      VpfDProdutoNota.UMOriginal,
                                      VprDNota.DesTipoNota);
    end;
    Tempo.fecha;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.BaixaFinanceiro : string;
var
  VpfDOrcamento : TRBDOrcamento;
begin
  ArrumaDuplicatasFinanceiro;
  if VprCotacoes <> nil then
  begin
    VpfDOrcamento := TRBDOrcamento(VprCotacoes.Items[0]);
    if Config.ExcluirFinanceiroCotacaoQuandoGeraNota then
      FunCotacao.ExcluiFinanceiroCotacoes(VprCotacoes);
    if not(VprDNota.IndGeraFinanceiro) and (config.GerarFinanceiroCotacao) and not(Config.ExcluirFinanceiroCotacaoQuandoGeraNota)
       and(VprDNota.ValTotal = VpfDOrcamento.ValTotal) then
    begin
      FunContasAReceber.AssociaFinanceiroCotacaoNaNota(VprDNota,VpfDOrcamento);
    end;
  end;
  If VprDNota.IndGeraFinanceiro then
    result :=  FunContasAReceber.GravaContasaReceber(VprDContasaReceber);

  MontaPArcelasCR(VprDNota.IndGerouFinanceiroOculto);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.BaixaNota : String;
begin
  result := BaixaFinanceiro;
  if result = '' then
  begin
    MontaPArcelasCR(VprDNota.IndGerouFinanceiroOculto);
    result := BaixaEstoqueNota;
  end;

  if result = '' then
  begin
    // imprime a nota fiscal automaticamente
    if MovNatureza.FieldByName('C_IMP_AUT').AsString = 'S' then
       BImprimir.Click;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ArrumaDuplicatasFinanceiro;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDMovContasCR;
begin
  VprDContasaReceber.SeqNota := VprDNota.SeqNota;
  VprDContasaReceber.NroNota := VprDNota.NumNota;
  for VpfLaco := 0 to VprDContasaReceber.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDMovContasCR(VprDContasaReceber.Parcelas.Items[VpfLaco]);
    if (VpfDParcela.NroDuplicata = '') then
    begin
      VpfDParcela.NroDuplicata := IntToStr(VprDNota.NumNota)+'/'+IntToStr(VpfLaco + 1);
      VpfDParcela.NroDocumento := VpfDParcela.NroDuplicata;
    end;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.ROrdensCompra : String;
var
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfOrdensCompra : TStringList;
begin
  VpfOrdensCompra := TStringList.create;
  result := '';
  For VpfLaco := 0 to VprCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VprCotacoes.Items[VpfLaco]);
    if VpfDCotacao.OrdemCompra <> '' then
    begin
      if VpfOrdensCompra.IndexOf(VpfDCotacao.OrdemCompra) < 0 then
      begin
        result := result +' '+ VpfDCotacao.OrdemCompra+';';
        VpfOrdensCompra.Add(VpfDCotacao.OrdemCompra);
      end;
    end;
  end;
  VpfOrdensCompra.free;
  if result <> '' then
    result := copy(result,1,length(result)-1);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Eventos da consulta da nota fiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarProBaixadosOrcamento;
var
  VpfQtdProduto : Double;
  VpfLacoNota,VpfLaco, VpfLacoProdutos : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacao : TRBDOrcProduto;
  VpfUnidadeAtual : String;
begin
  if VprCotacoes = nil then
    exit;
  if config.BaixaQTDCotacaonaNota then
  begin
    for VpfLacoNota := 0 to VprDNota.Produtos.Count - 1 do
    begin
      OrdenaCotacoesPorDataEntrega(VprCotacoes);
      VprDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpfLacoNota]);
      VpfQtdProduto := VprDProdutoNota.QtdProduto;
      VpfUnidadeAtual := VprDProdutoNota.UM;
      for VpfLaco := 0 to VprCotacoes.Count - 1 do
      begin
        VpfDCotacao := TRBDOrcamento(VprCotacoes.Items[Vpflaco]);
        for VpfLacoProdutos := 0 to VpfDCotacao.Produtos.Count - 1 do
        begin
          VpfDProCotacao := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpfLacoProdutos]);
          if (VpfDProCotacao.SeqProduto = VprDProdutoNota.SeqProduto) then
          begin
            if (config.EstoquePorCor) and (VpfDProCotacao.CodCor <> VprDProdutoNota.CodCor) then
              continue;

            if (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado) > 0 then
            begin
              VpfQtdProduto := FunProdutos.CalculaQdadePadrao(VpfUnidadeAtual,VpfDProCotacao.UM,VpfQtdProduto,IntToStr(VprDProdutoNota.SeqProduto));
              VpfUnidadeAtual := VpfDProCotacao.UM;
              if (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado) >= VpfQtdProduto then
              begin
                VpfDProCotacao.QtdBaixado := VpfDProCotacao.QtdBaixado + VpfQtdProduto;
                VpfQtdProduto := 0;
              end
              else
              begin
                VpfQtdProduto := VpfQtdProduto - (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado);
                VpfDProCotacao.QtdBaixado := VpfDProCotacao.QtdProduto;
              end;
            end;
          end;
          if VpfQtdProduto = 0 then
            break;
        end;
        if VpfQtdProduto = 0 then
          break;
      end;
    end;
  end;
  //carrega o numero das notas fiscais nas cotacoes
  for VpfLaco := 0 to VprCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VprCotacoes.Items[VpfLaco]);
    VpfDCotacao.IndProcessada := true;
    FunNotaFiscal.AssociaNotaOrcamento(VprDNota.CodFilial,VprDNota.SeqNota,VpfDCotacao.LanOrcamento);
    if VpfDCotacao.NumNotas = '' then
      VpfDCotacao.NumNotas := IntToStr(VprDNota.NumNota)
    else
      VpfDCotacao.NumNotas := IntToStr(VprDNota.NumNota)+'/'+ VpfDCotacao.NumNotas;
    if VpfDCotacao.DatEntrega = 0 then
    begin
      VpfDCotacao.DatEntrega := date;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDOrcamentoNota(VpaDOrcamento : TRBDOrcamento;VpaDNota : TRBDNotaFiscal);
begin
  //informaçoes do cliente;

  VpaDNota.CodVendedor := VpaDOrcamento.CodVendedor;
  ECoDVendedor.Atualiza;

  CardClienteNovaNota(VpaDNota,VpaDOrcamento.CodCliente);
  VpaDNota.CodVendedor := VpaDOrcamento.CodVendedor;
  VpaDNota.PerComissao := VpaDOrcamento.PerComissao;
  VpaDNota.CodVendedorPreposto := VpaDOrcamento.CodPreposto;
  VpaDNota.PerComissaoPreposto := VpaDOrcamento.PerComissaoPreposto;
  VpaDNota.CodCondicaoPagamento := VpaDOrcamento.CodCondicaoPagamento;
  VpaDNota.CodFormaPagamento := VpaDOrcamento.CodFormaPaqamento;
  VpaDNota.NumContaCorrente := VpaDOrcamento.NumContaCorrente;
  if config.CopiarTransportadoraPedido then
    VpaDNota.CodTransportadora := VpaDOrcamento.CodTransportadora;
  VpaDNota.DesMarcaEmbalagem := VpaDOrcamento.MarTransportadora;
  VpaDNota.DesEspecie := VpaDOrcamento.EspTransportadora;
  if VpaDOrcamento.TipFrete <> 0 then
    VpaDNota.CodTipoFrete := VpaDOrcamento.TipFrete;
  if VpaDOrcamento.NumTransportadora <> 0 then
  VpaDNota.NumEmbalagem := IntToStr(VpaDOrcamento.NumTransportadora);
  VpaDNota.DesUFPlacaVeiculo := VpaDOrcamento.UFVeiculo;
  VpaDNota.DesPlacaVeiculo := VpaDOrcamento.PlaVeiculo;
  if VpaDOrcamento.PesBruto <> 0 then
    VpaDNota.PesBruto := VpaDOrcamento.PesBruto;
  if VpaDOrcamento.PesLiquido <> 0 then
    VpaDNota.PesLiquido := VpaDOrcamento.PesLiquido;
  if VpaDOrcamento.QtdVolumesTransportadora <> 0 then
    VpaDNota.QtdEmbalagem := VpaDOrcamento.QtdVolumesTransportadora;
  VpaDNota.PerDesconto := VpaDOrcamento.PerDesconto;
  if VprDCliente.IndQuarto then
    VpaDNota.ValDesconto := VpaDOrcamento.ValDesconto / 4
  else
    VpaDNota.ValDesconto := VpaDOrcamento.ValDesconto;
  if VpaDOrcamento.ValTaxaEntrega <> 0 then
    VpaDNota.ValFrete := VpaDOrcamento.ValTaxaEntrega;
  if not config.NaoCopiarObservacaoPedidoNotaFiscal then
  begin
    if config.ObservacaoFiscalNaCotacao then
      VpaDNota.DesObservacao.text := VpaDOrcamento.DesObservacaoFiscal
    else
      VpaDNota.DesObservacao.text := VpaDOrcamento.DesObservacao.Text;
  end;
  VpaDNota.ValDescontoTroca := VpaDOrcamento.ValTroca;
  VpaDNota.DesOrdemCompra := ROrdensCompra;
  if VpaDOrcamento.NumCupomfiscal <> '' then
  begin
    VpaDNota.DesDadosAdicinais.Add('Cupom : '+VpaDOrcamento.NumCupomfiscal);
  end;
  CarDTela;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarDClienteNovaNota(VpaDNota : TRBDNotaFiscal;VpaCodCliente : Integer);
begin
  VpaDNota.CodCliente := VpaCodCliente;
  if UpperCase(FunClientes.RUFCliente(VpaDNota.CodCliente)) = UpperCase(varia.EstadoPadrao) then
    VpaDNota.CodNatureza := Varia.NaturezaNota
  else
    VpaDNota.CodNatureza := Varia.NaturezaForaEstado;
  ECodNatureza.Text := VprDNota.CodNatureza;
  ECodNatureza.Atualiza;
  VprDCliente.CodCliente := 0;
  ECodCliente.AInteiro := VpaDNota.CodCliente;
  ECodCliente.Atualiza;
end;
{******************************************************************************}
procedure TFNovaNotaFiscalNota.AdicionaAcrescimosDescontoCotacoesNota(VpaCotacoes : TList;VpaDNota : TRBDNotaFiscal);
var
  VpfDCotacao : TRBDOrcamento;
  VpfLaco : Integer;
begin
  VpaDNota.PerDesconto := 0;
  VpaDNota.ValFrete := 0;
  VpaDNota.ValDesconto := 0;
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLaco]);
    if VprDCliente.IndQuarto then
      VpaDNota.ValDesconto :=  VpaDNota.ValDesconto + (VpfDCotacao.ValDesconto / 4)
    else
      VpaDNota.ValDesconto :=  VpaDNota.ValDesconto + VpfDCotacao.ValDesconto;
    VpaDNota.ValFrete := VpaDNota.ValFrete + VpfDCotacao.ValTaxaEntrega;
    if VpfDCotacao.PerDesconto <> 0 then
      VpaDNota.PerDesconto := VpfDCotacao.PerDesconto;
  end;
  CarDValorTotalTela;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CarNaturezaOperacaoNota;
begin

  if VprDNota.Produtos.Count = 0 then
  begin
    if UpperCase(VprDCliente.DesUF) = UpperCase(varia.EstadoPadrao) then
      VprDNota.CodNatureza := Varia.NaturezaServico
    else
      VprDNota.CodNatureza := Varia.NaturezaServicoForaEstado;
  end
  else
    if (VprDNota.Produtos.Count > 0) and (VprDNota.Servicos.Count > 0) then
    begin
      if UpperCase(VprDCliente.DesUF) = UpperCase(varia.EstadoPadrao) then
        VprDNota.CodNatureza := Varia.NaturezaServicoEProduto
      else
        VprDNota.CodNatureza := Varia.NaturezaServicoEProdutoForaEstado;
    end;

  if VprOrcamento then
  begin
    if VprCotacoes <> nil then
    begin
      if TRBDOrcamento(VprCotacoes.Items[0]).NumCupomfiscal <> '' then
        VprDNota.CodNatureza := Varia.NaturezaNotaFiscalCupom;
    end;
  end;

  ECodNatureza.Text := VprDNota.CodNatureza;
  ECodNatureza.Atualiza;
  if not VprDNota.IndCalculaISS then
  begin
    VprPerISSQN := 0;
    EPerISSQN.Avalor := 0;
    EValIss.AValor := 0;
    VprDNota.PerIssqn := 0;
    VprDNota.ValIssqn :=0;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.FinalizaNotaAutomatico : String;
begin
  result := '';
  AtualizaStatus('Carregando os dados para a classe.');
  Result := CarDClasse;
  VprDNota.IndMostrarParcelas := false;
  if Result = '' then
  begin
    AtualizaStatus('Validando os dados da nota');
    Result := DadosNotaValidos;
    if Result = '' then
    begin
      VprTransacao.IsolationLevel := xilREADCOMMITTED;
      FPrincipal.BaseDados.StartTransaction(VprTransacao);
      AtualizaStatus('Gravando os dados da nota fiscal');
      Result := FunNotaFiscal.GravaDNotaFiscal(VprDNota);
      if Result = '' then
      begin
        EstadoBotoes(false);
        BotaoGravar1.Enabled := false;
        GeraFinanceiroNota;
        BaixaNota;

        if VprOrcamento Then
          CarProBaixadosOrcamento;
      end;
    end;
  end;

  if Result = '' then
  begin
    FPrincipal.BaseDados.Commit(VprTransacao);
    VprAcao := true;
    ENumNota.AsInteger := VprDNota.NumNota;
    EClaFiscal.Text := VprDNota.DesClassificacaoFiscal;
    AtualizaStatus('Nota fiscal gravada com sucesso.');
    TelaModoConsulta(true);
  end
  else
  begin
    if FPrincipal.BaseDados.InTransaction then
      FPrincipal.BaseDados.Rollback(VprTransacao);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GeraNotaFiscalFriaContrato;
begin
  FreeTObjectsList(VprDNota.Servicos);
  ECodNatureza.Text := Varia.NaturezaNota;
  ECodNatureza.Atualiza;
  VprDNota.CodNatureza := Varia.NaturezaNota;
  VprDNota.PerDesconto := 0;
  VprDNota.ValDesconto := 0;
  VprDProdutoNota := VprDNota.AddProduto;
  VprDProdutoNota.SeqProduto := Varia.SeqProdutoContrato;
  FunNotaFiscal.ExisteProduto(Varia.CodProdutoContrato,VprDNota,VprDProdutoNota);
  VprDProdutoNota.ValUnitario := VprDNota.ValTotal * 0.3;
  IF VprDProdutoNota.ValUnitario > 60 then
    VprDProdutoNota.ValUnitario := 50 + random(10);
  VprDProdutoNota.ValTotal := VprDProdutoNota.ValUnitario;
  CalculaValorTotalProduto;
  CalculaValorTotal;
  TRBDOrcamento(VprCotacoes.Items[0]).IndProcessamentoFrio := false;
  VprDNota.CodFormaPagamento := varia.FormaPagamentoContrato;
  VprDNota.CodCondicaoPagamento := varia.CondicaoPagamentoContrato;
  VprDNota.DesObservacao.clear;

  GeraFinanceiroNota;
  BaixaFinanceiro;
  aviso('Posicione a nota fiscal..');
  BImprimir.Click;
end;

{******************* imprime boletos bancarios **************************** }
procedure TFNovaNotaFiscalNota.BtbImprimeBoletoClick(Sender: TObject);
var
  VpfDBoleto : TDadosBoleto;
begin
  begin
    FunNotaFiscal.LocalizaParcelasBoleto(Aux, VprDNota.SeqNota);
    if not config.ImprimirBoletoFolhaBranco then
      UnIMP.InicializaImpressao(varia.BoletoPadraoNota,  UnIMP.RetornaImpressoraPadrao(Varia.BoletoPadraoNota));

    while not aux.Eof do
    begin
      if config.ImprimirBoletoFolhaBranco then
        FunImprimeBoleto.ImprimeBoleto(Aux.FieldByName('I_EMP_FIL').AsInteger,Aux.FieldByName('I_LAN_REC').AsInteger,
                                       Aux.FieldByName('I_NRO_PAR').AsInteger,VprDCliente,false,'',false)
      else
      begin
        VpfDBoleto := TDadosBoleto.Create;

        with VpfDBoleto do
        begin
          Valor := aux.fieldByName('n_vlr_par').AsCurrency;
          Desconto := 0;
          Acrescimos := 0;
          Vencimento := aux.fieldByName('d_dat_ven').AsDateTime;


          UnImp.LocalizaTipoBoleto(CadBoleto, varia.DadoBoletoPadraoNota);

          Instrucoes := TStringList.create;
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN1').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN2').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN3').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN4').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN5').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN6').AsString);
          Instrucoes.Add(CADBOLETO.FieldByName('C_DES_LN7').AsString);

          sacado := TStringList. create;
          Sacado.Add(Aux.fieldByName('C_NOM_CLI').AsString);
          if (Aux.fieldByName('C_BAI_CLI').AsString = '') then
             Sacado.Add(Aux.fieldByName('C_END_CLI').AsString + '' +
             Aux.fieldByName('I_NUM_END').AsString)
          else
            Sacado.Add(Aux.fieldByName('C_END_CLI').AsString  + '' +
            Aux.fieldByName('I_NUM_END').AsString + ',  ' +
            Aux.fieldByName('C_BAI_CLI').AsString);

          if (Aux.fieldByName('C_CEP_CLI').AsString = '') then
            Sacado.Add(AdicionaBrancoD(Aux.fieldByName('C_CID_CLI').AsString, 40) +
            Aux.fieldByName('C_EST_CLI').AsString)
          else
            Sacado.Add(AdicionaBrancoD(Aux.fieldByName('C_CID_CLI').AsString, 40) +
            Aux.fieldByName('C_EST_CLI').AsString + '   CEP: ' +
            Aux.fieldByName('C_CEP_CLI').AsString);

          NumeroDocumento := Aux.fieldByName('I_NRO_NOT').AsString;
          LanReceber := Aux.fieldByName('I_LAN_REC').AsInteger;
          NumParcela := Aux.fieldByName('I_NRO_PAR').AsInteger;
          Carteira := Aux.FieldByName('I_NUM_CAR').AsString;


          DataDocumento := Date;
          DataProcessamento := Date;
          Desconto := 0;
          Acrescimos := 0;
          ValorDocumento := Aux.fieldByName('N_VLR_PAR').AsFloat;
          LocalPagamento := CADBOLETO.FieldByName('C_DES_LOC').AsString;
          Cedente := CADBOLETO.FieldByName('C_DES_CED').AsString;
          EspecieDocumento := CADBOLETO.FieldByName('C_DES_ESP').AsString;
          Aceite := CADBOLETO.FieldByName('C_DES_ACE').AsString;
          Especie := CADBOLETO.FieldByName('C_ESP_MOE').AsString;
          Quantidade := '';
          Agencia := '';
          NossoNumero := '';
          Outras := 0;
          MoraMulta := 0;
          ValoCobrado := Aux.fieldByName('N_VLR_PAR').AsFloat;
          UnIMP.ImprimeBoleto(VpfDBoleto); // Imprime 1 documento.
         end;
        end;
       aux.Next;
    end;
    if not config.ImprimirBoletoFolhaBranco then
      UnIMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       eventos do orcamento na nota fiscal
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** altera os localizas para o orcamento ******************}
procedure TFNovaNotaFiscalNota.AlteraLocalizasOrcamento;
begin
  ECodNatureza.ASelectLocaliza.Text := 'Select * from dba.CadNatureza '+
                                      ' where c_nom_nat like ''@%''' +
                                      ' and C_Ent_Sai = ''S''';
  ECodNatureza.ASelectValida.Text := 'Select * from dba.CadNatureza '+
                                      ' where c_cod_nat = ''@'' ' +
                                      ' and C_Ent_Sai = ''S''';
  ECodNatureza.Atualiza;
  ECodCliente.Atualiza;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GeraMovNotasFiscaisOrcamentos(VpaCotacoes : TList;VpaSomenteServico : Boolean=false);
var
  VpfLaco, VpfLacoProdutos,VpfLacoServicos : Integer;
  VpfDCotacao : TRBDOrcamento;
  VpfDProCotacao : TRBDOrcProduto;
  VpfDServicoCotacao : TRBDOrcServico;
  VpfFaturarTodos : Boolean;
begin
  for VpfLaco := 0 to VpaCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[Vpflaco]);
    VpfFaturarTodos := FunCotacao.FaturarTodosProdutos(VpfDCotacao);
    VprDNota.DesOrdemCompra := VprDNota.DesOrdemCompra + VpfDCotacao.OrdemCompra +' ';
    if not VpaSomenteServico then
    begin
      for VpfLacoProdutos := 0 to VpfDCotacao.Produtos.Count - 1 do
      begin
        VpfDProCotacao := TRBDOrcProduto(VpfDCotacao.Produtos.Items[VpflacoProdutos]);
        if not VpfDProCotacao.IndBrinde then
        begin
          if VpfFaturarTodos or VpfDProCotacao.IndFaturar or not(config.EstoqueFiscal) then
          begin
            if ((VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado) > 0) or
                config.GerarFinanceiroCotacao or config.GerarNotaPelaQuantidadeProdutos then
            begin
              VprDProdutoNota := VprDNota.AddProduto;
              VprDProdutoNota.CodCST :=  '000';
              VprDProdutoNota.SeqProduto := VpfDProCotacao.SeqProduto;
              AdicionaItemProduto(VprDProdutoNota);
              if VprDProdutoNota.IndReducaoICMS then
                VprDProdutoNota.PerICMS :=  (VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMS)/100
              else
                VprDProdutoNota.PerICMS :=  VprDNota.ValICMSPadrao;
              if VpfDProCotacao.CodCor <> 0 then
                VprDProdutoNota.CodCor := VpfDProCotacao.CodCor;
              if config.PermiteAlteraNomeProdutonaCotacao then
                VprDProdutoNota.NomProduto := VpfDProCotacao.NomProduto;
              VprDProdutoNota.CodProduto := VpfDProCotacao.CodProduto;
              VprDProdutoNota.DesCor := VpfDProCotacao.DesCor;
              if config.GerarFinanceiroCotacao or config.GerarNotaPelaQuantidadeProdutos then
                VprDProdutoNota.QtdProduto := VpfDProCotacao.QtdProduto
              else
                VprDProdutoNota.QtdProduto := (VpfDProCotacao.QtdProduto - VpfDProCotacao.QtdBaixado);
              if VprDCliente.IndQuarto then
                VprDProdutoNota.ValUnitario := VpfDProCotacao.ValUnitario / 4
              else
                if VprDCliente.IndMeia then
                  VprDProdutoNota.ValUnitario := VpfDProCotacao.ValUnitario / 2
                else
                  if VprDCliente.IndVintePorcento then
                     VprDProdutoNota.ValUnitario := VpfDProCotacao.ValUnitario / 5
                   else
                     VprDProdutoNota.ValUnitario := VpfDProCotacao.ValUnitario;
              VprDProdutoNota.UM := VpfDProCotacao.UM;
              VprDProdutoNota.DesRefCliente := VpfDProCotacao.DesRefCliente;
              VprDProdutoNota.DesOrdemCompra := VpfDProCotacao.DesOrdemCompra;
              VprDProdutoNota.ValTotal := VprDProdutoNota.ValUnitario * VprDProdutoNota.QtdProduto;
              VprDProdutoNota.ValIPI := ArredondaDecimais((VprDProdutoNota.ValTotal * VprDProdutoNota.PerIPI)/100,2);
              FunNotaFiscal.VerificaItemNotaDuplicado(VprDNota);
            end;
          end;
        end;
      end;
    end;

    for VpfLacoServicos := 0 to VpfDCotacao.Servicos.Count - 1 do
    begin
      VpfDServicoCotacao := TRBDOrcServico(VpfDCotacao.Servicos.Items[VpflacoServicos]);
      VprDServicoNota := VprDNota.AddServico;
      VprDServicoNota.CodServico := VpfDServicoCotacao.CodServico;
      VprDServicoNota.NomServico := VpfDServicoCotacao.NomServico;
      VprDServicoNota.DesAdicional := VpfDServicoCotacao.DesAdicional;
      VprDServicoNota.QtdServico := VpfDServicoCotacao.QtdServico;
      VprDServicoNota.PerComissaoClassificacao := VpfDServicoCotacao.PerComissaoClassificacao;
      VprDServicoNota.CodClassificacao := VpfDServicoCotacao.CodClassificacao;

      if VprDCliente.IndQuarto then
      begin
        VprDServicoNota.ValUnitario := VpfDServicoCotacao.ValUnitario / 4;
        VprDServicoNota.ValTotal := VpfDServicoCotacao.ValTotal / 4;
      end
      else
        if VprDCliente.IndMeia then
        begin
          VprDServicoNota.ValUnitario := VpfDServicoCotacao.ValUnitario / 2;
          VprDServicoNota.ValTotal := VpfDServicoCotacao.ValTotal / 2;
        end
        else
        if VprDCliente.IndVintePorcento then
          begin
            VprDServicoNota.ValUnitario := VpfDServicoCotacao.ValUnitario / 5;
            VprDServicoNota.ValTotal := VpfDServicoCotacao.ValTotal / 5;
          end
          else
          begin
            VprDServicoNota.ValUnitario := VpfDServicoCotacao.ValUnitario;
            VprDServicoNota.ValTotal := VpfDServicoCotacao.ValTotal;
          end;
      VprDServicoNota.PerISSQN := VpfDServicoCotacao.PerISSQN;
      if VprDServicoNota.PerISSQN <> 0 then
        EPerISSQN.AValor := VprDServicoNota.PerISSQN
      else
        EPerISSQN.AValor := VprPerISSQN;
      if not VprDNota.IndCalculaISS then
      begin
        EPerISSQN.Clear;
        VprDServicoNota.PerISSQN := 0;
      end;

      if VpaCotacoes.Count > 1 then
        FunNotaFiscal.VerificaServicoNotaDuplicado(VprDNota);
    end;
  end;
  CalculaValorTotal;
  GServicos.CarregaGrade;
  GProdutos.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GeraMovNotasFiscaisRomaneio(VpaEmpFil,VpaNumRomaneio :String);
Var
  VpfPedidoAnterior : Integer;
  VpfTotalKM : Double;
begin
  AdicionaSQLAbreTabela(RomaneioItem,'select PRO.C_NOM_PRO, ' +
                                       ' OP.NUMPED, OP.CODPRO, OP.VALUNI, OP.SEQPRO, '+
                                       ' OPI.CODCOM, OPI.CODMAN, OPI.NROFIT, OPI.METCOL, (OPI.METCOL * OPI.NROFIT) / 1000 TOTALKM '+
                                       ' from ORDEMPRODUCAOCORPO OP, COLETAOPITEM opi, CADPRODUTOS PRO, ROMANEIOITEM RIT '+
                                       ' WHERE OPI.EMPFIL = OP.EMPFIL '+
                                       ' AND OPI.SEQORD = OP.SEQORD '+
                                       ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                                       ' AND RIT.EMPFIL = OPI.EMPFIL '+
                                       ' AND RIT.SEQORD = OPI.SEQORD '+
                                       ' AND RIT.SEQCOL = OPI.SEQCOL '+
                                       ' AND RIT.EMPFIL = ' +VpaEmpFil +
                                       ' and rit.SEQROM = '+VpaNumRomaneio+
                                       ' order by OP.NUMPED' );
  VpfPedidoAnterior := -90838443;
  While not RomaneioItem.Eof do
  begin
    if VpfPedidoAnterior <> RomaneioItem.FieldByName('NUMPED').AsInteger then
    begin
      VprDProdutoNota := VprDNota.AddProduto;
      VprDProdutoNota.SeqProduto := RomaneioItem.FieldByName('SEQPRO').AsInteger;
      VprDProdutoNota.CodProduto := RomaneioItem.FieldByName('CODPRO').AsString;
      AdicionaItemProduto(VprDProdutoNota);
      VpfTotalKM := RomaneioItem.FieldByName('TOTALKM').AsFloat;
      VprDProdutoNota.QtdProduto := RomaneioItem.FieldByName('TOTALKM').AsFloat;
      VprDProdutoNota.ValUnitario := RomaneioItem.FieldByName('VALUNI').AsFloat;
      VprDProdutoNota.UM := 'KM';
      VpfPedidoAnterior := RomaneioItem.FieldByName('NUMPED').AsInteger;
    end
    else
    begin
      VpfTotalKM := VpfTotalKM + RomaneioItem.FieldByName('TOTALKM').AsFloat;
      VprDProdutoNota.QtdProduto :=VpfTotalKM ;
    end;
    RomaneioItem.next;
  end;

  GProdutos.CarregaGrade;
  CalculaValorTotal;
  ActiveControl := ECodNatureza;
  RomaneioItem.close;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GeraMovNotasFiscaisRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio : Integer);
var
  VpfCotacoes, VpfOrdensCompra : TStringList;
begin
  VpfCotacoes := TStringList.Create;
  VpfOrdensCompra := TStringList.Create;
  AdicionaSQLAbreTabela(RomaneioItem,'select  CRO.QTDCOLETADO, CRO.DESUM, '+
                                     ' OP.CODPRO, OP.SEQPRO, OP.CODCOM, OP.NUMPED,OP.VALUNI, OP.ORDCLI, '+
                                     ' OP.PROREF, OP.UNMPED '+
                                     ' from  ROMANEIOPRODUTOITEM ROI, COLETAROMANEIOOP CRO, ORDEMPRODUCAOCORPO OP '+
                                     ' Where ROI.CODFILIAL = CRO.CODFILIAL '+
                                     ' AND ROI.SEQORDEM = CRO.SEQORDEM '+
                                     ' AND ROI.SEQFRACAO = CRO.SEQFRACAO '+
                                     ' AND ROI.SEQCOLETA = CRO.SEQCOLETA '+
                                     ' AND ROI.CODFILIAL = OP.EMPFIL '+
                                     ' AND ROI.SEQORDEM = OP.SEQORD '+
                                     ' AND ROI.CODFILIAL = '+ IntToStr(VpaCodFilial)+
                                     ' AND ROI.SEQROMANEIO = '+IntToStr(VpaSeqRomaneio));
  while not RomaneioItem.eof do
  begin
    VprDProdutoNota := VprDNota.AddProduto;
    VprDProdutoNota.CodCST :=  '000';
    VprDProdutoNota.SeqProduto := RomaneioItem.FieldByName('SEQPRO').AsInteger;
    AdicionaItemProduto(VprDProdutoNota);
    if VprDProdutoNota.IndReducaoICMS then
      VprDProdutoNota.PerICMS :=  (VprDNota.ValICMSPadrao * VprDProdutoNota.PerReducaoICMS)/100
    else
      VprDProdutoNota.PerICMS :=  VprDNota.ValICMSPadrao;

    if RomaneioItem.FieldByName('CODCOM').AsInteger <> 0 then
    begin
      VprDProdutoNota.CodCor := RomaneioItem.FieldByName('CODCOM').AsInteger;
      VprDProdutoNota.DesCor := FunProdutos.RNomeCor(inttoStr(VprDProdutoNota.CodCor));
    end;
    VprDProdutoNota.CodProduto := RomaneioItem.FieldByName('CODPRO').AsString;
    VprDProdutoNota.QtdProduto := FunProdutos.CalculaQdadePadrao(RomaneioItem.FieldByName('DESUM').AsString,RomaneioItem.FieldByName('UNMPED').AsString,
                                    RomaneioItem.FieldByName('QTDCOLETADO').AsFloat,IntToStr(VprDProdutoNota.SeqProduto));
    VprDProdutoNota.ValUnitario := RomaneioItem.FieldByName('VALUNI').AsFloat;
    VprDProdutoNota.UM := RomaneioItem.FieldByName('UNMPED').AsString;
    VprDProdutoNota.DesRefCliente := RomaneioItem.FieldByName('PROREF').AsString;
    VprDProdutoNota.ValTotal := VprDProdutoNota.ValUnitario * VprDProdutoNota.QtdProduto;
    VprDProdutoNota.ValIPI := ArredondaDecimais((VprDProdutoNota.ValTotal * VprDProdutoNota.PerIPI)/100,2);
    FunNotaFiscal.VerificaItemNotaDuplicado(VprDNota);
    if (VpfCotacoes.IndexOf(RomaneioItem.FieldByName('NUMPED').AsString)  < 0) Then
    begin
      VpfCotacoes.add(RomaneioItem.FieldByName('NUMPED').AsString);
      VprDNota.NumPedidos := VprDNota.NumPedidos+ RomaneioItem.FieldByName('NUMPED').AsString +',';
    end;
    if (VpfOrdensCompra.IndexOf(RomaneioItem.FieldByName('ORDCLI').AsString)  < 0) Then
    begin
      VpfOrdensCompra.add(RomaneioItem.FieldByName('ORDCLI').AsString);
      VprDNota.DesOrdemCompra := VprDNota.DesOrdemCompra + RomaneioItem.FieldByName('ORDCLI').AsString +',';
    end;

    RomaneioItem.next;
  end;
  RomaneioItem.close;
  if VprDNota.NumPedidos <> '' then
    VprDNota.NumPedidos := copy(VprDNota.NumPedidos,1,length(VprDNota.NumPedidos)-1);
  if VprDNota.DesOrdemCompra <> '' then
  begin
    VprDNota.DesOrdemCompra := copy(VprDNota.DesOrdemCompra,1,length(VprDNota.DesOrdemCompra)-1);
    EOrdemCompra.Text := VprDNota.DesOrdemCompra;
  end;
  GProdutos.CarregaGrade;
  CalculaValorTotal;
  ActiveControl := ECodNatureza;
  VpfCotacoes.free;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.OrdenaCotacoesPorDataEntrega(VpaCotacoes : TList);
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfUltimaCotacao : TRBDOrcamento;
begin
  for VpflacoExterno := VpaCotacoes.Count - 1 downto 0 do
  begin
    VpfUltimaCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoExterno]);
    for VpfLacoInterno := VpfLacoExterno - 1 downto 0 do
    begin
      if VpfUltimaCotacao.DatPrevista < TRBDOrcamento(VpaCotacoes.Items[VpfLacoInterno]).DatPrevista then
      begin
        VpaCotacoes.Items[VpfLacoExterno] := VpaCotacoes.Items[VpfLacoInterno];
        VpaCotacoes.Items[VpfLacoInterno] := VpfUltimaCotacao;
        VpfUltimaCotacao := TRBDOrcamento(VpaCotacoes.Items[VpfLacoExterno]);
      end;
    end;
  end;

end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaCotacoes(VpaCotacoes : TList;VpaSomenteServico : Boolean = false): Boolean;
var
  VpfDCotacao : TRBDOrcamento;
  VpfResultado : String;
begin
  result := false;
  if VpaCotacoes.Count > 0 then
  begin
    VprDNota := TRBDNotaFiscal.cria;
    VprOperacao := ocInsercao;
    VprCotacoes := VpaCotacoes;
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[0]);
    VprOrcamento := true;
    VpfResultado :=  VerificaVariaveis;
    if VpfResultado = '' then
    begin
      ConfiguraItemNota(Varia.NotaFiscalPadrao);
      InicializaNota;
      AlteraLocalizasOrcamento;
      CarDOrcamentoNota(VpfDCotacao,VprDNota);
      AdicionaAcrescimosDescontoCotacoesNota(VpaCotacoes,VprDNota);
      GeraMovNotasFiscaisOrcamentos(VpaCotacoes,VpaSomenteServico);
      CarNaturezaOperacaoNota;
      ShowModal;
      result := VprAcao;
    end
    else
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaCotacoesAutomatico(VpaCotacoes : TList;VpaDCliente : TRBDCliente; VpaBarraStatus : TStatusBar):string;
var
  VpfDCotacao : TRBDOrcamento;
begin
  result := '';
//09/08/2009 - foi colocado em comentario para ver se para de dar o acces violation no faturamento diario;
//  VpaBarraStatus := StatusBar1;
  VprNotaAutomatica := true;
  if VpaCotacoes.Count > 0 then
  begin
    VprDNota := TRBDNotaFiscal.cria;
    VprOperacao := ocInsercao;
    VprCotacoes := VpaCotacoes;
    VpfDCotacao := TRBDOrcamento(VpaCotacoes.Items[0]);

    VprOrcamento := true;
    Result :=  VerificaVariaveis;
    if Result = '' then
    begin
      ConfiguraItemNota(Varia.NotaFiscalPadrao);
      InicializaNota;
      AlteraLocalizasOrcamento;
      CarDOrcamentoNota(VpfDCotacao,VprDNota);
      AdicionaAcrescimosDescontoCotacoesNota(VpaCotacoes,VprDNota);
      GeraMovNotasFiscaisOrcamentos(VpaCotacoes);
      CarNaturezaOperacaoNota;
      result := FinalizaNotaAutomatico;
      if config.ExibirMensagemAntesdeImprimirNotanoFaturamentoMensal then
        aviso('NOTA FISCAL PRONTA PARA IMPRESSÃO!!!'#13'A nota fiscal está pronta para ser impressa, pressione o botão OK para continuar.');
      if VpfDCotacao.IndProcessamentoFrio then
        aviso('Posicione a nota fiscal.');
      if result = '' then
        BImprimir.Click;
      if VpfDCotacao.IndProcessamentoFrio then
        GeraNotaFiscalFriaContrato;
    end
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaRomaneio(VpaEmpfil,VpaNumRomaneio : String) : boolean;
var
  VpfResultado : String;
begin
  result := false;
  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;
  VprOrcamento := true;
  VpfResultado :=  VerificaVariaveis;
  if VpfResultado = '' then
  begin
    ConfiguraItemNota(Varia.NotaFiscalPadrao);
    InicializaNota;
    AlteraLocalizasOrcamento;
    VprDNota.CodCliente := 11024;
    VprDNota.CodNatureza := Varia.NaturezaNota;
    CarDTela;
    GeraMovNotasFiscaisRomaneio(VpaEmpFil,VpaNumRomaneio);
    CarNaturezaOperacaoNota;
    ShowModal;
    result := VprAcao;
    if result then
      VpfResultado:= FunOrdemProducao.BaixaRomaneioComoFaturado(StrToInt(VpaEmpfil),StrToInt(VpaNumRomaneio),VprDNota.SeqNota,VprDNota.CodFilial);
  end;
  if Vpfresultado <> '' then
    aviso(vpfResultado);
end;

{******************************************************************************}
function TFNovaNotaFiscalNota.GeraNotaRomaneioGenerico(VpaCodFilial, VpaSeqRomaneio,VpaCodCliente : Integer):Boolean;
var
  VpfResultado : String;
begin
  result := false;
  VprDNota := TRBDNotaFiscal.cria;
  VprOperacao := ocInsercao;
  VprOrcamento := true;
  VpfResultado :=  VerificaVariaveis;
  if VpfResultado = '' then
  begin
    ConfiguraItemNota(Varia.NotaFiscalPadrao);
    InicializaNota;
    AlteraLocalizasOrcamento;
    CarDClienteNovaNota(VprDNota,VpaCodCliente);
    CarDTela;
    GeraMovNotasFiscaisRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio);
    CarNaturezaOperacaoNota;
    ShowModal;
    result := VprAcao;
    if result then
      VpfResultado:= FunOrdemProducao.BaixaRomaneioGenerico(VpaCodFilial,VpaSeqRomaneio,VprDNota.SeqNota,IntToStr(VprDNota.NumNota));
  end;
  if Vpfresultado <> '' then
    aviso(vpfResultado);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ConsultaNota(VpaDNota : TRBDNotaFiscal);
var
  VpfResultado : String;
begin
  VprOperacao := ocConsulta;

   VpfResultado :=  VerificaVariaveis;
   if VpfResultado = '' then
   begin
     ConfiguraItemNota(Varia.NotaFiscalPadrao);
     InicializaNota;
     VprDNota.free;
     VprDNota := VpaDNota;
     GProdutos.ADados := VpaDNota.Produtos;
     GProdutos.CarregaGrade;
     GServicos.ADados := VpaDNota.Servicos;
     GServicos.CarregaGrade;
     VprDCliente.CodCliente := VpaDNota.CodCliente;
     FunClientes.CarDCliente(VprDCliente);
     CarDTela;
     CardClienteNota(VprDCliente);
     MontaPArcelasCR(false);
     EstadoBotoes(false);
     BotaoGravar1.Enabled := false;
     TelaModoConsulta(true);
     if VpaDNota.IndNotaCancelada then
     begin
       if VpaDNota.IndECF then
         LNomFilial.Caption := 'CUPOM CANCELADO'
       else
         LNomFilial.Caption := 'NOTA CANCELADA';
       LNomFilial.Font.Color := clred;
     end
     else
       if VpaDNota.IndECF then
       begin
         LNomFilial.Caption := 'CUPOM FISCAL';
         LNomFilial.Font.Color := clgreen;
       end
       else
         if VpaDNota.CodFilial <> varia.CodigoEmpFil then
         begin
           LNomFilial.Caption :=Sistema.RNomFilial(VpaDNota.CodFilial);
         end;
     ShowModal;
   end
   else
     aviso(VpfResultado);
end;

{********************* Atlera o numero da nota ********************************}
procedure TFNovaNotaFiscalNota.BAlterarNumeroClick(Sender: TObject);
var
  VpfNovoNumero : String;
begin
  if EntradaNumero('Novo Número','Digite o Novo numero da Nota : ',VpfNovoNumero,False,EDatEmissao.color,color,false) then
  begin
    ExecutaComandoSql(Aux,'Update CadNotaFiscais ' +
                          'Set I_Nro_not = ' + VpfNovoNumero +
                          ' Where I_Emp_Fil = '+ IntToStr(VprDNota.CodFilial) +
                          ' and I_Seq_Not = ' + IntToStr(VprDNota.SeqNota));
    VprDNota.NumNota := StrToInt(VpfNovoNumero);
    ENumNota.AsInteger := VprDNota.NumNota;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.FormShow(Sender: TObject);
begin
  ECodNatureza.SetFocus;
end;

{********************* valida a gravacao do botao *****************************}
procedure TFNovaNotaFiscalNota.ECondicoesChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao1.execute;
end;

{********************* cadastra a transportadora ******************************}
procedure TFNovaNotaFiscalNota.ECodTransportadoraCadastrar(Sender: TObject);
begin
  FNovaTransportadora := tFNovaTransportadora.CriarSDI(Application,'',Fprincipal.VerificaPermisao('FNovaTransportadora'));
  FNovaTransportadora.CadTransportadoras.Insert;
  FNovaTransportadora.ShowModal;
  Localiza.AtualizaConsulta;
  FNovaTransportadora.free;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.CAutoCalculoClick(Sender: TObject);
begin
  EValTotalNota.ReadOnly := CAutoCalculo.Checked;
  EBaseICMS.ReadOnly := CAutoCalculo.Checked;
  EValICMS.ReadOnly := CAutoCalculo.Checked;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECoDVendedorCadastrar(Sender: TObject);
begin
  FNovoVendedor := TFNovoVendedor.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoVendedor'));
  FNovoVendedor.CadVendedores.Insert;
  FNovoVendedor.showmodal;
  FNovoVendedor.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application, '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECorRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GProdutos.Cells[3,GProdutos.ALinha] := ECor.Text;
    GProdutos.Cells[4,GProdutos.ALinha] := Retorno1;
    ReferenciaProduto;
    GProdutos.AEstadoGrade := egEdicao;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  if ((VpaLinha-1) < VprDNota.Produtos.Count) then
  begin
    VprDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpaLinha-1]);
    GProdutos.Cells[1,VpaLinha] := VprDProdutoNota.CodProduto;
    GProdutos.Cells[2,VpaLinha] := VprDProdutoNota.NomProduto;
    if VprDProdutoNota.CodCor <> 0 then
      GProdutos.Cells[3,VpaLinha] := IntToStr(VprDProdutoNota.CodCor)
    else
      GProdutos.Cells[3,VpaLinha] := '';
    GProdutos.Cells[4,VpaLinha] := VprDProdutoNota.DesCor;
    GProdutos.Cells[5,VpaLinha] := VprDProdutoNota.CodClassificacaoFiscal;
    GProdutos.Cells[6,VpaLinha] := VprDProdutoNota.CodCST;
    GProdutos.Cells[7,VpaLinha] := VprDProdutoNota.UM;
    GProdutos.Cells[11,VpaLinha] := VprDProdutoNota.DesRefCliente;
    GProdutos.Cells[12,VpaLinha] := VprDProdutoNota.DesOrdemCompra;
    if VprDProdutoNota.PerICMS <> 0 then
      GProdutos.Cells[13,VpaLinha] := FormatFloat('0.00%',VprDProdutoNota.PerICMS)
    else
      GProdutos.Cells[13,VpaLinha] := '';
    if VprDProdutoNota.PerIPI <> 0 then
      GProdutos.Cells[14,VpaLinha] := FormatFloat('0.00%',VprDProdutoNota.PerIPI)
    else
      GProdutos.Cells[14,VpaLinha] := '';
    if VprDProdutoNota.ValIPI <> 0 then
      GProdutos.Cells[15,VpaLinha] := FormatFloat('0.00',VprDProdutoNota.ValIPI)
    else
      GProdutos.Cells[15,VpaLinha] := '';

    CalculaValorTotalProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if GProdutos.Cells[1,GProdutos.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      GProdutos.col := 1;
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
        if (GProdutos.Cells[7,GProdutos.Alinha] <> VprDProdutoNota.UMAnterior) and (VprDProdutoNota.UnidadeParentes.IndexOf(GProdutos.Cells[7,GProdutos.Alinha]) < 0) then
        begin
          VpaValidos := false;
          aviso(CT_UNIDADEVAZIA);
          GProdutos.col := 7;
        end
        else
          if (GProdutos.Cells[8,GProdutos.ALinha] = '') then
          begin
            VpaValidos := false;
            aviso(CT_QTDPRODUTOINVALIDO);
            GProdutos.Col := 8;
          end
          else
            if (GProdutos.Cells[9,GProdutos.ALinha] = '') then
            begin
              VpaValidos := false;
              aviso(CT_VALORUNITARIOINVALIDO);
              GProdutos.Col := 9;
            end;

  if VpaValidos then
  begin
    CarDProdutoNota;
    CalculaValorTotal;
    if VprDProdutoNota.QtdProduto = 0 then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      GProdutos.col := 8;
    end
    else
      if VprDProdutoNota.ValUnitario = 0 then
      begin
        VpaValidos := false;
        aviso(CT_VALORUNITARIOINVALIDO);
        GProdutos.Col := 9;
      end
      else
        if not FunProdutos.VerificaEstoque( VprDProdutoNota.UM,VprDProdutoNota.UMOriginal,VprDProdutoNota.QtdProduto,VprDProdutoNota.SeqProduto,VprDProdutoNota.CodCor,0) then
          VpaValidos := false;
      ValidaValorUnitarioProduto;
  end;
  if VpaValidos then
  begin
    if FunNotaFiscal.VerificaItemNotaDuplicado(VprDNota) then
    begin
      CalculaValorTotalProduto;
      GProdutos.CarregaGrade;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosDepoisExclusao(Sender: TObject);
begin
  calculavalortotal;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosEnter(Sender: TObject);
var
  VpfResultado : String;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    vpfResultado :=   CarDClasse;
    if vpfResultado <> '' then
    begin
      aviso(vpfResultado);
      ActiveControl := ECodNatureza;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3 :  Value := '00000;0; ';
  end;

end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GProdutos.Col of
        1 :  LocalizaProduto;
        3 :  ECor.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECorEnter(Sender: TObject);
begin
  ECor.clear;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  IF (GProdutos.Col = 11) and not(config.NumeroSerieProduto) then  //referencia do cliente
    key := #0;

  if (key = '.') and (GProdutos.col <> 1) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDNota.Produtos.Count >0 then
  begin
    VprDProdutoNota := TRBDNotaFiscalProduto(VprDNota.Produtos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDProdutoNota.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosNovaLinha(Sender: TObject);
begin
  VprDProdutoNota := VprDNota.AddProduto;
  VprDProdutoNota.PerICMS :=  VprDNota.ValICMSPadrao;
  VprDProdutoNota.CodCST :=  '000';
  VprProdutoAnterior := '-10';
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GProdutos.AColuna <> ACol then
    begin
      case GProdutos.AColuna of
        1 :if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GProdutos.Cells[1,GProdutos.ALinha] := '';
               GProdutos.Col := 1;
             end;
           end;
        3 : if GProdutos.Cells[3,GProdutos.Alinha] <> '' then
            begin
              if not Existecor then
              begin
                Aviso(CT_CORINEXISTENTE);
                GProdutos.Col := 3;
                abort;
              end;
            end
            else
              ReferenciaProduto;
        7 : if not ExisteUM then
            begin
              aviso(CT_UNIDADEVAZIA);
              GProdutos.col := 7;
              abort;
            end;
        8 :
             begin
               if GProdutos.Cells[8,GProdutos.ALinha] <> '' then
                 VprDProdutoNota.QtdProduto := StrToFloat(DeletaChars(GProdutos.Cells[8,GProdutos.ALinha],'.'))
               else
                 VprDProdutoNota.QtdProduto := 0;
               CalculaValorTotalProduto;
             end;
        9 :  ValidaValorUnitarioProduto;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EValDescontoAcrescimoExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,OcEdicao] then
  begin
            CarDValorTotal;
    CalculaValorTotal;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GProdutosExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    MontaObservacao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EDatEmissaoExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    try
      StrToDate(EDatEmissao.text);
      VprDNota.DatEmissao :=StrToDate(EDatEmissao.text);
      if VprDNota.DatEmissao <= Varia.DataUltimoFechamento then
      begin
        aviso(CT_DATAMENORULTIMOFECHAMENTO);
        EDatEmissao.SetFocus;
      end;

    except
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.EDatSaidaExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    try
      StrToDate(EDatSaida.text);
      VprDNota.DatSaida := StrToDate(EDatSaida.text);
      if VprDNota.DatSaida < Varia.DataUltimoFechamento then
      begin
        aviso(CT_DATAMENORULTIMOFECHAMENTO);
        EDatSaida.SetFocus;
      end;
    except
    end;
  end;
end;

procedure TFNovaNotaFiscalNota.ValidaGravacao1DadosInvalidos;
var
  i : integer;
begin
 i :=0;
 if i > 0 then
   aviso('oi');
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.BAlterarNotaClick(Sender: TObject);
begin
  BAlterarNota.Visible := false;
  TelaModoConsulta(true);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.FormDestroy(Sender: TObject);
begin
  UnImp.Free;
  VprDCliente.free;
  VprDTransportadora.free;
  VprDNota.free;
  FunOrdemProducao.free;
end;

procedure TFNovaNotaFiscalNota.ECodClienteAlterar(Sender: TObject);
begin
  if ECodCliente.ALocaliza.Loca.Tabela.FieldByName(ECodCliente.AInfo.CampoCodigo).AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+ECodCliente.ALocaliza.Loca.Tabela.FieldByName(ECodCliente.AInfo.CampoCodigo).asString);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    Localiza.AtualizaConsulta;
    FNovoCliente.free;
    VprDNota.CodCliente := -1;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDServicoNota := TRBDNotaFiscalServico(VprDNota.Servicos.Items[VpaLinha-1]);
  if VprDServicoNota.CodServico <> 0 then
    GServicos.Cells[1,VpaLinha] := IntToStr(VprDServicoNota.CodServico)
  else
    GServicos.Cells[1,VpaLinha] := '';
  GServicos.Cells[2,VpaLinha] := VprDServicoNota.NomServico;
  GServicos.Cells[3,VpaLinha] := VprDServicoNota.DesAdicional;
  GServicos.Cells[4,VpaLinha] := FormatFloat(Varia.MascaraQtd,VprDServicoNota.QtdServico);
  GServicos.cells[5,VpaLinha] := FormatFloat(Varia.MascaraValorUnitario,VprDServicoNota.ValUnitario);
  GServicos.Cells[6,VpaLinha] := FormatFloat(Varia.MascaraValor,VprDServicoNota.ValTotal);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := false;
  if not ExisteServico then
  begin
    GServicos.col := 1;
    aviso('SERVIÇO NÃO PREENCHIDO!!!'#13'É necessário preencher o código do serviço.');
  end
  else
    if GServicos.Cells[4,GServicos.ALinha] = '' then
    begin
      GServicos.col := 4;
      Aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do serviço.');
    end
    else
      if GServicos.Cells[5,GServicos.ALinha] = '' then
      begin
        GServicos.col := 5;
        aviso('VALOR UNITÁRIO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do serviço.');
     end
      else
        VpaValidos := true;
  if VpaValidos then
  begin
    CarDServicoNota ;
    CalculaValorTotal;
    if VprDServicoNota.QtdServico = 0 then
    begin
      VpaValidos := false;
      GServicos.col := 4;
      Aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do serviço.');
    end
    else
      if VprDServicoNota.ValUnitario = 0 then
      begin
        VpaValidos := false;
        GServicos.col := 5;
        aviso('VALOR UNITÁRIO INVÁLIDO!!!'#13'É necessário preencher o valor unitário do serviço.');
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1 :  Value := '0000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case GProdutos.Col of
        1 :  LocalizaServico;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosKeyPress(Sender: TObject;
  var Key: Char);
begin
//  IF GServicos.Col = 2 then  //referencia do cliente
//    key := #;

  if (key = '.')  then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDNota.Servicos.Count >0 then
  begin
    VprDServicoNota := TRBDNotaFiscalServico(VprDNota.Servicos.Items[VpaLinhaAtual-1]);
    VprServicoAnterior := InttoStr(VprDServicoNota.CodServico);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.GServicosNovaLinha(Sender: TObject);
begin
  VprDServicoNota := VprDNota.AddServico;
  VprServicoAnterior := '-10';
end;

procedure TFNovaNotaFiscalNota.GServicosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GServicos.AEstadoGrade in [egInsercao,EgEdicao] then
    if GServicos.AColuna <> ACol then
    begin
      case GServicos.AColuna of
        1 :if not ExisteServico then
           begin
             if not LocalizaServico then
             begin
               GServicos.Cells[1,GServicos.ALinha] := '';
               GServicos.Col := 1;
             end;
           end;
        4,5 :
             begin
               if GServicos.Cells[4,GServicos.ALinha] <> '' then
                 VprDServicoNota.QtdServico := StrToFloat(DeletaChars(GServicos.Cells[4,GServicos.ALinha],'.'))
               else
                 VprDServicoNota.QtdServico := 0;
               if GServicos.Cells[5,GServicos.ALinha] <> '' then
                 VprDServicoNota.ValUnitario := StrToFloat(DeletaChars(GServicos.Cells[5,GServicos.ALinha],'.'))
               else
                 VprDServicoNota.ValUnitario := 0;
               CalculaValorTotalServico;
             end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECodPrepostoRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    EComissaoPreposto.AValor := StrToFloat(retorno1);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.Envelopes1Click(Sender: TObject);
begin
  FunCrystal.ImprimeRelatorioDiretoImpressora(varia.ImpressoraRelatorio, Varia.PathRelatorios+ '\Clientes\XX_Envelope.rpt',[IntToStr(VprDNota.CodCliente),IntToStr(VprDNota.CodFilial)],opPaisagem );
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.BFinanceiroOcultoClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := GeraFinanceiroOculto;
  if vpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECoDVendedorSelect(Sender: TObject);
begin
  if VprNotaAutomatica then
  begin
    ECoDVendedor.ASelectValida.Text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_COM, I_TIP_COM '+
                                       ' from CADVENDEDORES '+
                                       ' where I_COD_VEN  = @ ';
    ECoDVendedor.ASelectLocaliza.text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_COM, I_TIP_COM '+
                                         ' from CADVENDEDORES '+
                                         ' where C_NOM_VEN like ''@%'''+
                                         ' order by C_NOM_VEN ';
  end
  else
  begin
    ECoDVendedor.ASelectValida.Text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_COM, I_TIP_COM '+
                                       ' from CADVENDEDORES '+
                                       ' where I_COD_VEN  = @ '+
                                       ' and C_IND_ATI = ''S''';
    ECoDVendedor.ASelectLocaliza.text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_COM, I_TIP_COM '+
                                         ' from CADVENDEDORES '+
                                         ' where C_NOM_VEN like ''@%'''+
                                         ' and C_IND_ATI = ''S'''+
                                         ' order by C_NOM_VEN ';
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscalNota.ECodPrepostoSelect(Sender: TObject);
begin
  if VprNotaAutomatica then
  begin
    ECodPreposto.ASelectValida.Text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_PRE, I_TIP_COM '+
                                       ' from CADVENDEDORES '+
                                       ' where I_COD_VEN  = @ ';
    ECodPreposto.ASelectLocaliza.text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_PRE, I_TIP_COM '+
                                         ' from CADVENDEDORES '+
                                         ' where C_NOM_VEN like ''@%'''+
                                         ' AND C_IND_PRE = ''S'''+
                                         ' order by C_NOM_VEN ';
  end
  else
  begin
    ECodPreposto.ASelectValida.Text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_PRE, I_TIP_COM '+
                                       ' from CADVENDEDORES '+
                                       ' where I_COD_VEN  = @ '+
                                       ' and C_IND_ATI = ''S''';
    ECodPreposto.ASelectLocaliza.text := 'Select I_COD_VEN, C_NOM_VEN, N_PER_PRE, I_TIP_COM '+
                                         ' from CADVENDEDORES '+
                                         ' where C_NOM_VEN like ''@%'''+
                                         ' and C_IND_ATI = ''S'''+
                                         ' AND C_IND_PRE = ''S'''+
                                         ' order by C_NOM_VEN ';
  end;
end;
{******************************************************************************}
procedure TFNovaNotaFiscalNota.EspelhodaNota1Click(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeEspelhoNota(VprDNota.CodFilial,VprDNota.SeqNota);
  dtRave.free;
end;

Initialization
{3254}
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaNotaFiscalNota]);
end.








