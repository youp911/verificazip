unit APedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, StdCtrls, ComCtrls, Buttons,
  Localizacao, Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables, Mask,
  numericos, UnPedidoCompra, UnDados, Menus, UnNotasFiscaisFor, DBClient, UnProdutos;

type
  TFPedidoCompra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    DataFinal: TCalendario;
    Label4: TLabel;
    DataInicial: TCalendario;
    Label1: TLabel;
    ETipoPeriodo: TComboBoxColor;
    Label6: TLabel;
    EFornecedor: TEditLocaliza; 
    BFornecedor: TSpeedButton;
    LFornecedor: TLabel;
    Localiza: TConsultaPadrao;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BExcluir: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    PanelColor4: TPanelColor;
    PEDIDOCOMPRACORPO: TSQL;
    DataPEDIDOCOMPRACORPO: TDataSource;
    PRODUTOPEDIDO: TSQL;
    DataPRODUTOPEDIDO: TDataSource;
    PRODUTOPEDIDOC_NOM_PRO: TWideStringField;
    PRODUTOPEDIDONOM_COR: TWideStringField;
    PRODUTOPEDIDODESREFERENCIAFORNECEDOR: TWideStringField;
    PRODUTOPEDIDOQTDPRODUTO: TFMTBCDField;
    PRODUTOPEDIDODESUM: TWideStringField;
    PRODUTOPEDIDOVALUNITARIO: TFMTBCDField;
    PRODUTOPEDIDOVALTOTAL: TFMTBCDField;
    PEDIDOCOMPRACORPOSEQPEDIDO: TFMTBCDField;
    PEDIDOCOMPRACORPODATPREVISTA: TSQLTimeStampField;
    PEDIDOCOMPRACORPOC_NOM_CLI: TWideStringField;
    PEDIDOCOMPRACORPOVALTOTAL: TFMTBCDField;
    PEDIDOCOMPRACORPOC_NOM_PAG: TWideStringField;
    PEDIDOCOMPRACORPOCODFILIAL: TFMTBCDField;
    PopupMenu1: TPopupMenu;
    AprovarPedido1: TMenuItem;
    PEDIDOCOMPRACORPODATAPROVACAO: TSQLTimeStampField;
    PEDIDOCOMPRACORPOC_NOM_USU: TWideStringField;
    PEDIDOCOMPRACORPODATENTREGA: TSQLTimeStampField;
    Label7: TLabel;
    ESituacao: TComboBoxColor;
    PanelColor5: TPanelColor;
    GPedidoItem: TGridIndice;
    Splitter1: TSplitter;
    GPedidoCorpo: TGridIndice;
    PanelColor3: TPanelColor;
    Label2: TLabel;
    Label5: TLabel;
    CAtualiza: TCheckBox;
    EQuantidade: Tnumerico;
    EValor: Tnumerico;
    Baixar1: TMenuItem;
    PEDIDOCOMPRACORPODATPAGAMENTOANTECIPADO: TSQLTimeStampField;
    Label8: TLabel;
    Aux: TSQL;
    PEDIDOCOMPRACORPONOMEST: TWideStringField;
    PEDIDOCOMPRACORPOCODESTAGIO: TFMTBCDField;
    PEDIDOCOMPRACORPOUSUAPROVACAO: TWideStringField;
    PEDIDOCOMPRACORPODATPEDIDO: TSQLTimeStampField;
    EEstagio: TEditLocaliza;
    BEstagio: TSpeedButton;
    Label9: TLabel;
    AlterarEstgio1: TMenuItem;
    ConcluirPedidoCompra1: TMenuItem;
    ExtornarPedidoCompra1: TMenuItem;
    PRODUTOPEDIDOQTDSOLICITADA: TFMTBCDField;
    Label13: TLabel;
    EComprador: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    PEDIDOCOMPRACORPONOMCOMPRADOR: TWideStringField;
    Label10: TLabel;
    SpeedButton1: TSpeedButton;
    Label12: TLabel;
    ESolicitacao: TEditLocaliza;
    CPeriodo: TCheckBox;
    Label3: TLabel;
    SpeedButton3: TSpeedButton;
    Label14: TLabel;
    Label15: TLabel;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    Label17: TLabel;
    SpeedButton7: TSpeedButton;
    Label18: TLabel;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    BGerarNF: TBitBtn;
    PEDIDOCOMPRACORPOCODCLIENTE: TFMTBCDField;
    PEDIDOCOMPRACORPOCODFORMAPAGAMENTO: TFMTBCDField;
    PRODUTOPEDIDOQTDBAIXADO: TFMTBCDField;
    N1: TMenuItem;
    N2: TMenuItem;
    ImprimirPedidosPendentes1: TMenuItem;
    PEDIDOCOMPRACORPODATRENEGOCIADO: TSQLTimeStampField;
    EPedidoCompra: Tnumerico;
    BFiltros: TBitBtn;
    Label19: TLabel;
    N3: TMenuItem;
    ConsultarNotasFiscais1: TMenuItem;
    N4: TMenuItem;
    ConsultaAgendamento1: TMenuItem;
    Label20: TLabel;
    SpeedButton2: TSpeedButton;
    Label21: TLabel;
    EProduto: TEditColor;
    N5: TMenuItem;
    ConsultaSolicitaoCompra1: TMenuItem;
    PRODUTOPEDIDOC_COD_PRO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure DataInicialCloseUp(Sender: TObject);
    procedure PEDIDOCOMPRACORPOAfterScroll(DataSet: TDataSet);
    procedure GPedidoCorpoOrdem(Ordem: String);
    procedure GPedidoItemOrdem(Ordem: String);
    procedure CAtualizaClick(Sender: TObject);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure BExcluirClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure AprovarPedido1Click(Sender: TObject);
    procedure Baixar1Click(Sender: TObject);
    procedure AlterarEstgio1Click(Sender: TObject);
    procedure ConcluirPedidoCompra1Click(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure ExtornarPedidoCompra1Click(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure GerarNotaFiscaldeentrada1Click(Sender: TObject);
    procedure ImprimirPedidosPendentes1Click(Sender: TObject);
    procedure BFiltrosClick(Sender: TObject);
    procedure EPedidoCompraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ConsultarNotasFiscais1Click(Sender: TObject);
    procedure ConsultaAgendamento1Click(Sender: TObject);
    procedure EProdutoExit(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ConsultaSolicitaoCompra1Click(Sender: TObject);
  private
    FunNotaFor: TFuncoesNFFor;
    VprSeqProduto: Integer;
    FunPedidoCompra: TRBFunPedidoCompra;
    VprOrdem: String;
    VprOrdemItens: String;
    procedure InicializaTela;
    procedure AtualizaConsulta(VpaPosicionar : Boolean = false);
    procedure AdicionaFiltros(VpaSelect: TStrings);
    procedure PosItensPedido;
    procedure AtualizaTotais;
    procedure InsereNaListaPedidos(VpaListaPedidos: TList; VpaDPedidoCompraCorpo: TRBDPedidoCompraCorpo);
    procedure CarDClassePedidos(VpaListaPedidos: TList);
    function ExisteProduto: Boolean;
    function LocalizaProduto: Boolean;
  public
    procedure ConsultaPedidosSolicitacao(VpaSeqSolicitacao: Integer);
    procedure ConsultaPedidosOrdemProducao(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao : Integer);
  end;

var
  FPedidoCompra: TFPedidoCompra;

implementation
uses
  APrincipal, ANovoPedidoCompra, ConstMSG, Constantes, FunSQL, FunData,
  AAlteraEstagioPedidoCompra, UnCrystal, FunObjeto, ANovaNotaFiscaisFor,
  UnDadosProduto, AAgendamentos, dmRave, ALocalizaProdutos, ASolicitacaoCompras;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPedidoCompra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunNotaFor:= TFuncoesNFFor.criar(Self,FPrincipal.BaseDados);
  FunPedidoCompra:= TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
  InicializaTela;
  VprOrdem:= ' ORDER BY PCC.SEQPEDIDO';
  VprOrdemItens:= ' ORDER BY PRO.C_NOM_PRO';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPedidoCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Aux.Close;
  PRODUTOPEDIDO.Close;
  PEDIDOCOMPRACORPO.Close;
  FunPedidoCompra.Free;
  FunNotaFor.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPedidoCompra.ConsultaPedidosSolicitacao(VpaSeqSolicitacao: Integer);
begin
  ESolicitacao.AInteiro:= VpaSeqSolicitacao;
  ESolicitacao.Atualiza;
  CPeriodo.Checked := false;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFPedidoCompra.ConsultaPedidosOrdemProducao(VpaCodFilial, VpaSeqOrdemProducao, VpaSeqFracao : Integer);
begin
  EFilial.AInteiro := VpaCodFilial;
  EFilial.Atualiza;
  EOrdemProducao.AInteiro := VpaSeqOrdemProducao;
  EOrdemProducao.AInteiro;
  EFracao.AInteiro := VpaSeqFracao;
  EFracao.Atualiza;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFPedidoCompra.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFPedidoCompra.AdicionaFiltros(VpaSelect: TStrings);
begin
  if EPedidoCompra.AsInteger <> 0 then
    VpaSelect.Add('and PCC.SEQPEDIDO = ' +EPedidoCompra.Text)
  else
  begin
    if CPeriodo.Checked then
      case ETipoPeriodo.ItemIndex of
        0: VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('PCC.DATPEDIDO',DataInicial.DateTime,DataFinal.DateTime,True));
        1: VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('PCC.DATPREVISTA',DataInicial.DateTime,DataFinal.DateTime,True));
      end;
    if EFornecedor.AInteiro <> 0 then
      VpaSelect.Add(' AND PCC.CODCLIENTE = '+EFornecedor.Text);
    case ESituacao.ItemIndex of
      1: VpaSelect.Add(' AND PCC.DATAPROVACAO IS NOT NULL');
      2: VpaSelect.Add(' AND PCC.DATAPROVACAO IS NULL');
      3: VpaSelect.Add(' AND PCC.DATENTREGA IS NULL');
    end;
    if EEstagio.Text <> '' then
      VpaSelect.Add(' AND PCC.CODESTAGIO = '+EEstagio.Text);
    if EComprador.Text <> '' then
      VpaSelect.Add(' AND PCC.CODCOMPRADOR = '+EComprador.Text);
    if ESolicitacao.Text <> '' then
      VpaSelect.Add(' AND EXISTS('+
                    ' SELECT *'+
                    ' FROM PEDIDOSOLICITACAOCOMPRA PSC'+
                    ' WHERE PSC.CODFILIAL = PCC.CODFILIAL'+
                    ' AND PSC.SEQSOLICITACAO = '+ESolicitacao.Text+
                    ' AND PCC.SEQPEDIDO = PSC.SEQPEDIDO)');
    if EProduto.Text <> '' then
      VpaSelect.Add(' AND EXISTS (SELECT PCI.SEQPEDIDO '+
                    '             FROM PEDIDOCOMPRAITEM PCI'+
                    '             WHERE PCI.SEQPRODUTO = '+IntToStr(VprSeqProduto)+
                    '             AND PCC.CODFILIAL = PCI.CODFILIAL'+
                    '             AND PCC.SEQPEDIDO = PCI.SEQPEDIDO )');
    if (EOrdemProducao.AInteiro <> 0) or (EFracao.AInteiro <> 0) then
    begin
      VpaSelect.Add('AND EXISTS '+
                    '( SELECT * FROM PEDIDOCOMPRAFRACAOOP FRA '+
                    ' Where FRA.CODFILIALFRACAO = '+IntToStr(EFilial.AInteiro));
      if EOrdemProducao.AInteiro <> 0 then
        VpaSelect.add(' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro));
      if EFracao.AInteiro <> 0 then
        VpaSelect.add(' AND FRA.SEQFRACAO = '+IntToStr(EFracao.AInteiro));
      VpaSelect.add('AND FRA.CODFILIAL = PCC.CODFILIAL '+
                    ' AND FRA.SEQPEDIDO = PCC.SEQPEDIDO )');
    end;
  end;

end;

{******************************************************************************}
procedure TFPedidoCompra.AtualizaConsulta(VpaPosicionar : Boolean = false);
Var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := PEDIDOCOMPRACORPO.GetBookmark;
  PRODUTOPEDIDO.Close;
  PEDIDOCOMPRACORPO.close;
  PEDIDOCOMPRACORPO.SQL.Clear;
  PEDIDOCOMPRACORPO.SQL.Add('SELECT'+
                            ' PCC.CODCLIENTE, PCC.CODFORMAPAGAMENTO, PCC.SEQPEDIDO, PCC.DATPEDIDO, PCC.DATPREVISTA, PCC.DATENTREGA,'+
                            ' PCC.DATRENEGOCIADO, '+
                            ' CLI.C_NOM_CLI, PCC.VALTOTAL, CPA.C_NOM_PAG,'+
                            ' PCC.CODFILIAL, PCC.DATAPROVACAO,'+
                            ' EST.NOMEST, PCC.CODESTAGIO, PCC.DATPAGAMENTOANTECIPADO,'+
                            ' USUAPR.C_NOM_USU USUAPROVACAO,'+
                            ' USU.C_NOM_USU, COM.NOMCOMPRADOR'+
                            ' FROM'+
                            ' PEDIDOCOMPRACORPO PCC, CADCLIENTES CLI, CADCONDICOESPAGTO CPA,'+
                            ' CADUSUARIOS USUAPR, ESTAGIOPRODUCAO EST, CADUSUARIOS USU,'+
                            ' COMPRADOR COM'+
                            ' WHERE '+SQLTextoRightJoin('PCC.CODCLIENTE','CLI.I_COD_CLI')+
                            ' AND '+SQLTextoRightJoin('PCC.CODCONDICAOPAGAMENTO','CPA.I_COD_PAG')+
                            ' AND '+SQLTextoRightJoin('PCC.CODUSUARIOAPROVACAO','USUAPR.I_COD_USU')+
                            ' AND USU.I_COD_USU = PCC.CODUSUARIO'+
                            ' AND '+SQLTextoRightJoin('PCC.CODESTAGIO','EST.CODEST')+
                            ' AND '+SQLTextoRightJoin('PCC.CODCOMPRADOR','COM.CODCOMPRADOR')+
                            ' AND PCC.CODFILIAL = '+IntToStr(Varia.CodigoEmpFil));
  AdicionaFiltros(PEDIDOCOMPRACORPO.SQL);
  PEDIDOCOMPRACORPO.SQL.Add(VprOrdem);
  GPedidoCorpo.ALinhaSQLOrderBy:= PEDIDOCOMPRACORPO.SQL.Count-1;
  PEDIDOCOMPRACORPO.Open;
  if VpaPosicionar then
  begin
    try
      PEDIDOCOMPRACORPO.GotoBookmark(VpfPosicao);
    except
    end;
    PEDIDOCOMPRACORPO.FreeBookmark(vpfPosicao);
  end;
  if CAtualiza.Checked then
    AtualizaTotais;
end;

{******************************************************************************}
procedure TFPedidoCompra.InicializaTela;
begin
  CPeriodo.Checked:= True;
  ETipoPeriodo.ItemIndex:= 0;
  ESituacao.ItemIndex:= 0;
  EComprador.AInteiro:= Varia.CodComprador;
  EComprador.Atualiza;
  DataInicial.DateTime:= PrimeiroDiaMes(Date);
  DataFinal.DateTime:= UltimoDiaMes(Date);
  EFornecedor.Clear;
  CAtualiza.Checked:= False;
end;

{******************************************************************************}
procedure TFPedidoCompra.DataInicialCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPedidoCompra.PEDIDOCOMPRACORPOAfterScroll(DataSet: TDataSet);
begin
  PosItensPedido;
end;

{******************************************************************************}
procedure TFPedidoCompra.PosItensPedido;
begin
  if not PEDIDOCOMPRACORPOSEQPEDIDO.IsNull then
  begin
    PRODUTOPEDIDO.Close;
    PRODUTOPEDIDO.SQL.Clear;
    PRODUTOPEDIDO.SQL.Add('SELECT'+
                          ' PRO.C_COD_PRO, PRO.C_NOM_PRO, COR.NOM_COR, PCI.DESREFERENCIAFORNECEDOR,'+
                          ' PCI.QTDPRODUTO, PCI.QTDBAIXADO, PCI.DESUM, PCI.VALUNITARIO, PCI.VALTOTAL, PCI.QTDSOLICITADA'+
                          ' FROM PEDIDOCOMPRAITEM PCI, CADPRODUTOS PRO, COR COR'+
                          ' WHERE'+
                          ' PRO.I_SEQ_PRO = PCI.SEQPRODUTO'+
                          ' AND '+SQLTextoRightJoin('PCI.CODCOR','COR.COD_COR')+
                          ' AND PCI.CODFILIAL = '+PEDIDOCOMPRACORPOCODFILIAL.AsString+
                          ' AND PCI.SEQPEDIDO = '+PEDIDOCOMPRACORPOSEQPEDIDO.AsString);
    PRODUTOPEDIDO.SQL.Add(VprOrdemItens);
    GPedidoItem.ALinhaSQLOrderBy:= PRODUTOPEDIDO.SQL.Count-1;
    PRODUTOPEDIDO.Open;
  end
  else
    PRODUTOPEDIDO.Close;
end;

procedure TFPedidoCompra.SpeedButton2Click(Sender: TObject);
begin
  if LocalizaProduto then
    AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFPedidoCompra.AtualizaTotais;
begin
  EQuantidade.AValor:= 0;
  EValor.AValor:= 0;
  if CAtualiza.Checked then
  begin
    Aux.SQL.Clear;
    Aux.SQL.Add('SELECT COUNT(PCC.SEQPEDIDO) QTD, SUM(PCC.VALTOTAL) VALOR'+
                ' FROM PEDIDOCOMPRACORPO PCC'+
                ' WHERE SEQPEDIDO = SEQPEDIDO ');
    AdicionaFiltros(Aux.SQL);
    Aux.Open;
    EQuantidade.AValor:= Aux.FieldByName('QTD').AsInteger;
    EValor.AValor:= Aux.FieldByName('VALOR').AsFloat;
  end;
end;

{******************************************************************************}
procedure TFPedidoCompra.GPedidoCorpoOrdem(Ordem: String);
begin
  VprOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFPedidoCompra.GPedidoItemOrdem(Ordem: String);
begin
  VprOrdemItens:= Ordem;
end;

{******************************************************************************}
procedure TFPedidoCompra.CAtualizaClick(Sender: TObject);
begin
  AtualizaTotais;
end;

{******************************************************************************}
procedure TFPedidoCompra.EFornecedorRetorno(Retorno1, Retorno2: String);
begin
  DataInicialCloseUp(EFornecedor);
end;

{******************************************************************************}
procedure TFPedidoCompra.BCadastrarClick(Sender: TObject);
begin
  FNovoPedidoCompra:= TFNovoPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoPedidoCompra'));
  if FNovoPedidoCompra.NovoPedido then
    AtualizaConsulta;
  FNovoPedidoCompra.Free;
end;

{******************************************************************************}
procedure TFPedidoCompra.BExcluirClick(Sender: TObject);
begin
  if PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger <> 0 then
  begin
    FNovoPedidoCompra:= TFNovoPedidoCompra.CriarSDI(Application,'',True);
    if FNovoPedidoCompra.Apagar(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger) then
      AtualizaConsulta;
    FNovoPedidoCompra.Free;
  end;
end;

{******************************************************************************}
procedure TFPedidoCompra.BConsultarClick(Sender: TObject);
begin
  if PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger <> 0 then
  begin
    FNovoPedidoCompra:= TFNovoPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoPedidoCompra'));
    FNovoPedidoCompra.Consultar(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
    FNovoPedidoCompra.Free;
  end;
end;

{******************************************************************************}
procedure TFPedidoCompra.BAlterarClick(Sender: TObject);
begin
  if PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger <> 0 then
  begin
    FNovoPedidoCompra:= TFNovoPedidoCompra.CriarSDI(Application,'',True);
    if FNovoPedidoCompra.Alterar(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger) then
      AtualizaConsulta(true);
    FNovoPedidoCompra.Free;
  end;
end;

{******************************************************************************}
procedure TFPedidoCompra.AprovarPedido1Click(Sender: TObject);
var
  VpfResultado: String;
begin
  if PEDIDOCOMPRACORPODATAPROVACAO.IsNull then
  begin
    if Confirmacao('Tem certeza que deseja aprovar este pedido?') then
    begin
      VpfResultado:= FunPedidoCompra.AprovarPedido(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
      if VpfResultado = '' then
      begin
        Informacao('Pedido aprovado com sucesso.');
        VpfResultado:= FunPedidoCompra.AlteraEstagioPedidoCompra(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger,varia.EstagioComprasAprovado,'Aprovação');
        AtualizaConsulta;
      end
      else
        aviso(VpfResultado);
    end;
  end
  else
    aviso('Este pedido já foi aprovado!')
end;


{******************************************************************************}
procedure TFPedidoCompra.Baixar1Click(Sender: TObject);
var
  VpfResultado: String;
begin
  if PEDIDOCOMPRACORPODATPAGAMENTOANTECIPADO.IsNull then
  begin
    if Confirmacao('Deseja baixar o pagamento antecipado deste pedido?') then
    begin
      VpfResultado:= FunPedidoCompra.BaixarPagamentoAntecipado(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
      if VpfResultado = '' then
      begin
        Informacao('Pagamento antecipado baixado com sucesso.');
        AtualizaConsulta;
      end
      else
        aviso(VpfResultado);
    end;
  end
  else
    Informacao('Este pagamento já foi baixado.');
end;


procedure TFPedidoCompra.AlterarEstgio1Click(Sender: TObject);
begin
  FAlteraEstagioPedidoCompra := TFAlteraEstagioPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraEstagioPedidoCompra'));
  if FAlteraEstagioPedidoCompra.AlteraEstagioPedido(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger) then
    AtualizaConsulta(True);
  FAlteraEstagioPedidoCompra.free;
end;

{******************************************************************************}
procedure TFPedidoCompra.ConcluirPedidoCompra1Click(Sender: TObject);
var
  VpfResultado: String;
begin
  if PEDIDOCOMPRACORPODATENTREGA.IsNull then
  begin
    if Confirmacao('Tem certeza que deseja concluir o pedido?') then
    begin
      VpfResultado:= FunPedidoCompra.ConcluiPedidoCompra(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
      if VpfResultado = '' then
      begin
        Informacao('Pedido concluído com sucesso.');
        AtualizaConsulta;
      end
      else
        aviso(VpfResultado);
    end;
  end
  else
    Informacao('Pedido já concluído.');
end;

{******************************************************************************}
procedure TFPedidoCompra.BImprimirClick(Sender: TObject);
begin
  if PEDIDOCOMPRACORPOCODFILIAL.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimePedidoCompra(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
function TFPedidoCompra.ExisteProduto: Boolean;
var
  VpfUM,
  VpfNomProduto: String;
begin
  Result:= FunProdutos.ExisteProduto(EProduto.Text,VprSeqProduto,VpfNomProduto,VpfUM);
  if Result then
    Label21.Caption:= VpfNomProduto
  else
    Label21.Caption:= '';
end;

{******************************************************************************}
procedure TFPedidoCompra.ExtornarPedidoCompra1Click(Sender: TObject);
var
  VpfResultado: String;
begin
  if Confirmacao('Tem certeza que deseja extornar o pedido?') then
  begin
    if not PEDIDOCOMPRACORPODATAPROVACAO.IsNull then
    begin
      VpfResultado:= FunPedidoCompra.ExtornaPedidoCompra(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
      if VpfResultado = '' then
      begin
        aviso('Pedido de compra extornado com sucesso.');
        AtualizaConsulta;
      end
      else
        aviso(VpfResultado)
    end
    else
      aviso('Pedido de compra já extornado.');
  end;
end;

procedure TFPedidoCompra.EOrdemProducaoSelect(Sender: TObject);
begin
  EOrdemProducao.ASelectLocaliza.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND CLI.C_NOM_CLI like ''@%''';
  EOrdemProducao.ASelectValida.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI From ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND ORD.SEQORD = @';
end;

{******************************************************************************}
procedure TFPedidoCompra.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{******************************************************************************}
procedure TFPedidoCompra.GerarNotaFiscaldeentrada1Click(Sender: TObject);
var
  VpfListaPedidos: TList;
  VpfDNota: TRBDNotaFiscalFor;
begin
  VpfListaPedidos:= TList.Create;
  CarDClassePedidos(VpfListaPedidos);
  VpfDNota:= TRBDNotaFiscalFor.cria;
  VpfDNota.CodFornecedor:= PEDIDOCOMPRACORPOCODCLIENTE.AsInteger;
  VpfDNota.CodFormaPagamento:= PEDIDOCOMPRACORPOCODFORMAPAGAMENTO.AsInteger;
  FunNotaFor.PreencheProdutosNotaPedido(VpfListaPedidos,VpfDNota);
  FNovaNotaFiscaisFor:= TFNovaNotaFiscaisFor.CriarSDI(Application,'',True);
  if FNovaNotaFiscaisFor.NovaNotaPedido(VpfDNota) then
  begin
    FunPedidoCompra.GravaVinculoNotaFiscal(VpfDNota, VpfListaPedidos);
    FunPedidoCompra.BaixarQtdeProdutoPedido(VpfDNota, VpfListaPedidos);
    AtualizaConsulta(true);
  end;
  FNovaNotaFiscaisFor.Free;
  FreeTObjectsList(VpfListaPedidos);
  VpfListaPedidos.Free;
  VpfDNota.Free
end;

{******************************************************************************}
procedure TFPedidoCompra.CarDClassePedidos(VpaListaPedidos: TList);
var
  VpfLaco: Integer;
  VpfBookmark: TBookmark;
  VpfDPedidoCompraCorpo: TRBDPedidoCompraCorpo;
begin
  if GPedidoCorpo.SelectedRows.Count = 0 then
  begin
    if PEDIDOCOMPRACORPOCODFILIAL.AsInteger <> 0 then
    begin
      VpfDPedidoCompraCorpo:= TRBDPedidoCompraCorpo.Cria;
      FunPedidoCompra.CarDPedidoCompra(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,
                                       PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger,
                                       VpfDPedidoCompraCorpo);
      InsereNaListaPedidos(VpaListaPedidos,VpfDPedidoCompraCorpo);
    end;
  end
  else
    for VpfLaco:= 0 to GPedidoCorpo.SelectedRows.Count-1 do
    begin
      VpfBookmark:= TBookmark(GPedidoCorpo.SelectedRows.Items[VpfLaco]);
      PEDIDOCOMPRACORPO.GotoBookmark(VpfBookmark);
      VpfDPedidoCompraCorpo:= TRBDPedidoCompraCorpo.Cria;
      FunPedidoCompra.CarDPedidoCompra(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,
                                       PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger,
                                       VpfDPedidoCompraCorpo);
      InsereNaListaPedidos(VpaListaPedidos,VpfDPedidoCompraCorpo);
    end;
end;

{******************************************************************************}
procedure TFPedidoCompra.InsereNaListaPedidos(VpaListaPedidos: TList; VpaDPedidoCompraCorpo: TRBDPedidoCompraCorpo);
var
  VpfLaco: Integer;
  VpfDPedidoCompraCorpo: TRBDPedidoCompraCorpo;
  VpfInseriu: Boolean;
begin
  VpfInseriu:= False;
  for VpfLaco:= 0 to VpaListaPedidos.Count-1 do
  begin
    VpfDPedidoCompraCorpo:= TRBDPedidoCompraCorpo(VpaListaPedidos.Items[VpfLaco]);
    if VpaDPedidoCompraCorpo.DatPedido < VpfDPedidoCompraCorpo.DatPedido then
    begin
      VpaListaPedidos.Insert(VpfLaco,VpaDPedidoCompraCorpo);
      VpfInseriu:= True;
      Break;
    end;
  end;
  if not VpfInseriu then
    VpaListaPedidos.Add(VpaDPedidoCompraCorpo);
end;

{******************************************************************************}
function TFPedidoCompra.LocalizaProduto: Boolean;
var
  VpfCodProduto,
  VpfNomProduto,
  VpfDesUM,
  VpfClaFiscal: String;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result:= FlocalizaProduto.LocalizaProduto(VprSeqProduto,VpfCodProduto,VpfNomProduto,VpfDesUM,VpfClaFiscal);
  FlocalizaProduto.free;
  if Result then
  begin
    EProduto.Text:= VpfCodProduto;
    Label21.Caption:= VpfNomProduto;
  end
  else
  begin
    EProduto.Text:= '';
    Label21.Caption:= '';
  end;

end;

{******************************************************************************}
procedure TFPedidoCompra.ImprimirPedidosPendentes1Click(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimePedidoCompraPendente;
  dtRave.free;
end;

procedure TFPedidoCompra.BFiltrosClick(Sender: TObject);
begin
  if BFiltros.Caption = '>>' then
  begin
    if screen.Height = 768 then
      PanelColor1.Height := 260
    else
      PanelColor1.Height := 211;
    BFiltros.Caption := '<<';
  end
  else
  begin
    if screen.Height = 768 then
      PanelColor1.Height := 67
    else
      PanelColor1.Height := 52;
    BFiltros.Caption := '>>';
  end;
end;

{******************************************************************************}
procedure TFPedidoCompra.EPedidoCompraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    13 : AtualizaConsulta;
  end;

end;

procedure TFPedidoCompra.EProdutoExit(Sender: TObject);
begin
  ExisteProduto;
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFPedidoCompra.EProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: begin
          if ExisteProduto then
            AtualizaConsulta(false)
          else
            if LocalizaProduto then
              AtualizaConsulta(false);
        end;
    114: if LocalizaProduto then
           AtualizaConsulta(false);
  end;
end;

{******************************************************************************}
procedure TFPedidoCompra.ConsultarNotasFiscais1Click(Sender: TObject);
begin
  FunPedidoCompra.ConsultaNotasFiscais(PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
end;

{******************************************************************************}
procedure TFPedidoCompra.ConsultaSolicitaoCompra1Click(Sender: TObject);
begin
  FSolicitacaoCompra := TFSolicitacaoCompra.CriarSDI(self,'',true);
  FSolicitacaoCompra.ConsultaPedidoCompa(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
  FSolicitacaoCompra.free;
end;

{******************************************************************************}
procedure TFPedidoCompra.ConsultaAgendamento1Click(Sender: TObject);
begin
  if PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger <> 0 then
  begin
    FAgendamentos:= TFAgendamentos.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendamentos'));
    FAgendamentos.ConsultaPedidoCompra(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger);
    FAgendamentos.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPedidoCompra]);
end.
