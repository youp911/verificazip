unit ANovaNotaFiscaisFor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Tabela, StdCtrls, Mask, DBCtrls, Componentes1, ExtCtrls,
  PainelGradiente,  Buttons, Grids, DBGrids, Constantes,ConstMsg, UnDados,
  BotaoCadastro, DBKeyViolation, Localizacao, ConvUnidade, UnProdutos, UnNotasFiscaisFor,
  Spin, numericos, UnContasapagar, CGrades, UnDadosProduto, UnCrystal, UnContasAReceber,
  UnDadosLocaliza, FMTBcd, SqlExpr;

Const
  CT_FALTAMPRODUTOS = 'FALTAM PRODUTOS!!! Falta digitar os produtos da nota fiscal...';
  CT_DATAMENORULTIMOFECHAMENTO='DATA NÃO PODE SER MENOR QUE A DO ULTIMO FECHAMENTO!!!A data de digitação do produto não ser menor que a data do ultimo fechamento...';

type
  TFNovaNotaFiscaisFor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Tempo: TPainelTempo;
    ValidaGravacao1: TValidaGravacao;
    Localiza: TConsultaPadrao;
    Aux: TSQLQuery;
    ScrollBox1: TScrollBox;
    PanelColor1: TPanelColor;
    Shape3: TShape;
    Shape2: TShape;
    Shape1: TShape;
    Label6: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Shape4: TShape;
    Label12: TLabel;
    Shape5: TShape;
    Label8: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Shape6: TShape;
    LFilial: TLabel;
    Label13: TLabel;
    Label30: TLabel;
    Label11: TLabel;
    Label21: TLabel;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape15: TShape;
    Label7: TLabel;
    Shape7: TShape;
    Label25: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    Label14: TLabel;
    Shape17: TShape;
    Label23: TLabel;
    Label26: TLabel;
    LNatureza: TLabel;
    Shape20: TShape;
    SpeedButton4: TSpeedButton;
    Label32: TLabel;
    SpeedButton5: TSpeedButton;
    Label33: TLabel;
    Shape21: TShape;
    ENumNota: TEditColor;
    ESerieNota: TEditColor;
    EObservacoes: TMemoColor;
    ECodFornecedor: TEditLocaliza;
    ENatureza: TEditLocaliza;
    ECodTransportadora: TEditLocaliza;
    CFreteEmitente: TRadioButton;
    des: TRadioButton;
    AutoCalculo: TCheckBox;
    EFormaPagamento: TEditLocaliza;
    EQtdParcelas: TSpinEditColor;
    ENumDias: TSpinEditColor;
    EPlano: TEditColor;
    ECor: TEditLocaliza;
    EDatEntrada: TMaskEditColor;
    Shape19: TShape;
    Label31: TLabel;
    Shape18: TShape;
    CAcrescimoDesconto: TRadioGroup;
    CValorPercentual: TRadioGroup;
    BitBtn1: TBitBtn;
    Panel1: TPanelColor;
    BCancela: TBitBtn;
    BFechar: TBitBtn;
    Grade: TRBStringGridColor;
    EValTotalProdutos: Tnumerico;
    EBaseICMS: Tnumerico;
    EValICMS: Tnumerico;
    EValFrete: Tnumerico;
    EValSeguro: Tnumerico;
    EValOutrasDespesas: Tnumerico;
    EValTotIpi: Tnumerico;
    EValTotal: Tnumerico;
    ValidaUnidade: TValidaUnidade;
    EDesconto: Tnumerico;
    BCadastrar: TBitBtn;
    BGravar: TBitBtn;
    Label4: TLabel;
    Shape14: TShape;
    EDatRecebimento: TMaskEditColor;
    BEtiqueta: TBitBtn;
    PEtiqueta: TPanelColor;
    PanelColor3: TPanelColor;
    Label10: TLabel;
    BOK: TBitBtn;
    BCancelar: TBitBtn;
    Label27: TLabel;
    EPosInicial: Tnumerico;
    EBaseIcmsSubs: Tnumerico;
    EValICMSSubs: Tnumerico;
    PDevolucao: TPanelColor;
    Shape16: TShape;
    Label28: TLabel;
    SpeedButton6: TSpeedButton;
    Label29: TLabel;
    EVendedor: TRBEditLocaliza;
    Label34: TLabel;
    EPerComissao: Tnumerico;
    Label35: TLabel;
    BImprimir: TBitBtn;
    Label36: TLabel;
    ETamanho: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EValFreteExit(Sender: TObject);
    procedure ECodFornecedorRetorno(Retorno1, Retorno2: String);
    procedure CFreteEmitenteClick(Sender: TObject);
    procedure BCancelaClick(Sender: TObject);
    procedure AutoCalculoClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure ECodFornecedorCadastrar(Sender: TObject);
    procedure ECodTransportadoraCadastrar(Sender: TObject);
    procedure ENumNotaChange(Sender: TObject);
    procedure EFormaPagamentoCadastrar(Sender: TObject);
    procedure ENaturezaCadastrar(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ENaturezaRetorno(Retorno1, Retorno2: String);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EFormaPagamentoRetorno(Retorno1, Retorno2: String);
    procedure ECorEnter(Sender: TObject);
    procedure ECorCadastrar(Sender: TObject);
    procedure EDatEntradaExit(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDepoisExclusao(Sender: TObject);
    procedure GradeEnter(Sender: TObject);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure BCadastrarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeGetCellAlignment(sender: TObject; ARow, ACol: Integer;
      var HorAlignment: TAlignment; var VerAlignment: TVerticalAlignment);
    procedure BCancelarClick(Sender: TObject);
    procedure BEtiquetaClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure ECodFornecedorSelect(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure ETamanhoRetorno(VpaColunas: TRBColunasLocaliza);
  private
    FunNotaFor : TFuncoesNFFor;
    FunContasPagar : TFuncoesContasAPagar;
    VprICMSPadrao : Double;
    VprOperacao : TRBDOperacaoCadastro;
    VprProdutoAnterior : String;
    VprNotaPedido,
    VprAcao: Boolean;
    VprIndTroca : Boolean;
    VprDNotaFor : TRBDNotaFiscalFor;
    VprDItemNota : TRBDNotaFiscalForItem;
    VprDCliente : TRBDCliente;
    VprDCotacao : TRBDOrcamento;
    VprTransacao : TTransactionDesc;
    procedure ConfiguraPermissaoUsuario;
    procedure CarTitulosGrade;
    procedure InicializaTela;
    procedure InicializaTelaTroca;
    procedure CalculaValorTotalProduto;
    procedure CalculaNota;
    procedure CarDTela;
    procedure CarDClasse;
    procedure CarDesconto;
    procedure CarDescontoTela;
    procedure CarDItem;
    procedure CarregaDadosCliente;
    function LocalizaProduto : Boolean;
    procedure CarregaDesNatureza;
    function ExisteProduto : Boolean;
    function ExisteCor(VpaCodCor :Integer ) : Boolean;
    function ExisteUM : Boolean;
    procedure AlteraEnabledBotao(VpaAcao : Boolean);
    function DadosNotaFiscalValidos : Boolean;
    procedure ImpressaoEtiquetaBarras;
    procedure AlteraProduto;
  public
    function Cadastrar : Boolean;
    function NovaNotaPedido(VpaDNota: TRBDNotaFiscalFor): Boolean;
    function Alterar(VpaDNota : TRBDNotaFiscalFor):Boolean;
    function GeraTroca(VpaDCliente : TRBDCliente;VpaDCotacao :TRBDOrcamento):Boolean;
    procedure ConsultaNota(VpaCodFilial, VpaSeqNota : Integer);
    function GeraNotaDevolucao(VpaNotas : TList):string;
  end;

var
  FNovaNotaFiscaisFor: TFNovaNotaFiscaisFor;

implementation

uses APrincipal, fundata, funstring, ANovoCliente,FunObjeto,
    ANovaTransportadora, AOperacoesEstoques, funsql, FunNumeros,
   ANovaNatureza, APlanoConta, ACores,
  ANaturezas, ALocalizaProdutos, UnClientes, AFormasPagamento,
  ANovoProdutoPro, dmRave;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaNotaFiscaisFor.FormCreate(Sender: TObject);
begin
  PDevolucao.Visible := false;
  VprNotaPedido:= False;
  VprIndTroca := false;
  LFilial.Caption := 'Filial : '+IntToStr(varia.CodigoEmpFil)+'-'+Varia.NomeFilial;
  VprDNotaFor := TRBDNotaFiscalFor.Cria;
  FunNotaFor := TFuncoesNFFor.criar(self,FPrincipal.BaseDados);
  VprDCliente := TRBDCliente.cria;
  ConfiguraPermissaoUsuario;
  CarTitulosGrade;
  Grade.ADados := VprDNotaFor.ItensNota;
  FunContasPagar := TFuncoesContasAPagar.criar(self,FPrincipal.BaseDados);
  ValidaUnidade.AInfo.UnidadeCX := Varia.UnidadeCX;
  ValidaUnidade.AInfo.UnidadeUN := Varia.UnidadeUN;
  ValidaUnidade.AInfo.UnidadeKiT := Varia.UnidadeKit;
  ValidaUnidade.AInfo.UnidadeBarra := Varia.UnidadeBarra;
end;

{*********************Quando o formulario e fechado****************************}
procedure TFNovaNotaFiscaisFor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunNotaFor.free;
  FunContasPagar.Free;
  if not VprNotaPedido then
    VprDNotaFor.Free;
  VprDCliente.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           cabecalho da nota fiscal for
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFNovaNotaFiscaisFor.Cadastrar : Boolean;
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.NovaNotaPedido(VpaDNota: TRBDNotaFiscalFor): Boolean;
begin
  VprNotaPedido:= True;
  VprOperacao := ocInsercao;
  InicializaTela;
  VprDNotaFor:= VpaDNota;
  if Varia.CodFormaPagamentoNotaEntrada <> 0 then
    VpaDNota.CodFormaPagamento := Varia.CodFormaPagamentoNotaEntrada;
  VprDNotaFor.DatEmissao:= DecDia(Now,1);
  VprDNotaFor.DatRecebimento:= Now;
  VprOperacao := ocConsulta;
  CarDTela;
  Grade.ADados:= VpaDNota.ItensNota;
  Grade.CarregaGrade;
  VprOperacao := ocEdicao;
  CalculaNota;
  AlteraEnabledBotao(true);
  ValidaGravacao1.execute;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.Alterar(VpaDNota : TRBDNotaFiscalFor):Boolean;
begin
  VprDNotaFor := VpaDNota;
  if  FunContasPagar.NotaPossuiParcelaPaga(VpaDNota.CodFilial, VpaDNota.SeqNota) then
  begin
    aviso('NOTA POSSUI PARCELA NO CONTAS A PAGAR PAGA!!!'#13'Antes de alterar a nota é necessário extonar as parcelas pagas.');
    result := false;
    close;
    exit;
  end;
  Grade.ADados := VpaDNota.ItensNota;
  Grade.CarregaGrade;
  VprOperacao := ocConsulta;
  CarDTela;
  CarregaDesNatureza;
  VprOperacao := ocEdicao;
  AlteraEnabledBotao(true);
  ValidaGravacao1.execute;
  ShowModal;
  result := vprAcao;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.GeraTroca(VpaDCliente : TRBDCliente;VpaDCotacao :TRBDOrcamento ):Boolean;
begin
  VprIndTroca := true;
  VprDCotacao := VpaDCotacao;
  VprOperacao := ocInsercao;
  InicializaTela;
  IF not VpaDCliente.IndFornecedor then
    FunClientes.SetaClienteComoFornecedor(VpaDCliente.CodCliente);
  ECodFornecedor.AInteiro := VpaDCliente.CodCliente;
  ECodFornecedor.Atualiza;
  InicializaTelaTroca;
  ActiveControl := Grade;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ConsultaNota(VpaCodFilial, VpaSeqNota : Integer);
begin
  VprDNotaFor.CodFilial := VpaCodFilial;
  VprDNotaFor.SeqNota := VpaSeqNota;
  FunNotaFor.CarDNotaFor(VprDNotaFor);
  Grade.ADados := VprDNotaFor.ItensNota;
  Grade.CarregaGrade;
  VprOperacao := ocConsulta;
  CarDTela;
  CarregaDesNatureza;
  AlteraEnabledBotao(false);
  AlterarEnabledDet(PanelColor1,0,false);
  AlterarEnabledDet(PEtiqueta,0,true);
  Grade.Enabled := true;
  ShowModal;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.GeraNotaDevolucao(VpaNotas : TList):string;
begin
  VprOperacao := ocInsercao;
  PDevolucao.Visible := true;
  InicializaTela;
  VprDNotaFor.IndNotaDevolucao := true;
  result := FunNotaFor.GeraNotaDevolucao(VpaNotas,VprDNotaFor);
  CarDTela;
  CalculaNota;
  showmodal;
end;

{************* cadastra nova natureza de operacao *************************** }
procedure TFNovaNotaFiscaisFor.ENaturezaCadastrar(Sender: TObject);
begin
  FNaturezas := TFNaturezas.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNaturezas'));
  FNaturezas.ShowModal;
  FNaturezas.free;
  Localiza.AtualizaConsulta;
end;

{************************Cadastra um novo cliente******************************}
procedure TFNovaNotaFiscaisFor.ECodFornecedorCadastrar(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(application,'',true);
   FNovoCliente.CadClientes.Insert;
   FNovoCliente.CadClientesC_TIP_CAD.AsString := 'F';
   FNovoCliente.ShowModal;
   Localiza.AtualizaConsulta;
end;

{****************Retorna se o fornecedor é fisico ou jurídico******************}
procedure TFNovaNotaFiscaisFor.ECodFornecedorRetorno(Retorno1,
  Retorno2: String);
begin
  CarregaDadosCliente;
end;

{***************************Valida a gravacao**********************************}
procedure TFNovaNotaFiscaisFor.ENumNotaChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao1.execute;
end;

{**********************Cadastra uma nova operação de Estoque*******************}
procedure TFNovaNotaFiscaisFor.EFormaPagamentoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.click;
  FFormasPagamento.showmodal;
  FFormasPagamento.free;
  Localiza.AtualizaConsulta;
end;


{***************************localiza codigo de produto*************************}
function TFNovaNotaFiscaisFor.LocalizaProduto : Boolean;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result := FlocalizaProduto.LocalizaProduto(VprDItemNota); //localiza o produto
  FlocalizaProduto.free; // destroi a classe;
  if result then  // se o usuario nao cancelou a consulta
  begin
    if config.Farmacia then
      result := FunNotaFor.ValidaMedicamentoControlado(VprDNotaFor,VprDItemNota);
    if result then
    begin
      with VprDItemNota do
      begin
        VprDItemNota.UnidadeParentes.free;
        VprDItemNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(UMOriginal);
        VprProdutoAnterior := VprDItemNota.CodProduto;
        QtdProduto := 1;
        Grade.Cells[1,Grade.ALinha] := CodProduto;
        Grade.Cells[2,Grade.ALinha] := NomProduto;
        Grade.Cells[8,Grade.ALinha] := CodClassificacaoFiscal;
        Grade.Cells[10,Grade.ALinha] := UM;
        if VprIndTroca then
          VprDItemNota.ValUnitario := VprDItemNota.ValRevenda;
        if config.EstoquePorTamanho then
        begin
          ETamanho.AInteiro := CodTamanho;
          ETamanho.Atualiza;
        end;

        CalculaValorTotalProduto;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarregaDesNatureza;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_MOV from MOVNATUREZA '+
                            ' Where C_COD_NAT = '''+ VprDNotaFor.CodNatureza+''''+
                            ' AND I_SEQ_MOV = '+IntToStr(VprDNotaFor.SeqNatureza));
  LNatureza.Caption := Aux.FieldByName('C_NOM_MOV').AsString;
  Aux.Close;
end;

{******************** verifica se o produto existe ****************************}
function TFNovaNotaFiscaisFor.ExisteProduto : Boolean;
begin
  if (Grade.Cells[1,Grade.ALinha] <> '') then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      result := true
    else
    begin
      result := FunNotaFor.ExisteProduto(Grade.Cells[1,Grade.ALinha],VprDItemNota);
      if result then
      begin
        if config.Farmacia then
          result := FunNotaFor.ValidaMedicamentoControlado(VprDNotaFor,VprDItemNota);
        if result then
        begin
          VprDItemNota.UnidadeParentes.free;
          VprDItemNota.UnidadeParentes := ValidaUnidade.UnidadesParentes(VprDItemNota.UMOriginal);
          VprProdutoAnterior := VprDItemNota.CodProduto;
          Grade.Cells[1,Grade.ALinha] := VprDItemNota.CodProduto;
          Grade.Cells[2,Grade.ALinha] := VprDItemNota.NomProduto;
          Grade.Cells[10,Grade.ALinha] := VprDItemNota.UM;
          if VprIndTroca then
            VprDItemNota.ValUnitario := VprDItemNota.ValRevenda;

          CalculaValorTotalProduto;
        end;
      end;
    end;
  end
  else
    result := false;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.ExisteCor(VpaCodCor :Integer ) : Boolean;
begin
  Result:= not Config.EstoquePorCor;
  // o retorno padrão da função funciona de acordo com a configuração do estoque.
  // se configurado para utilizar a cor no estoque, ela retorna false,
  // deixando a cor como obrigatória. caso contrario, se não utilizar a cor,
  // ele retorna true, dizendo que uma cor "existe"
  if VpaCodCor <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from COR '+
                              ' Where COD_COR = '+IntToStr(VpacodCor));
    result := not Aux.eof;
    if result then
    begin
      Grade.Cells[4,Grade.ALinha] := Aux.FieldByName('NOM_COR').AsString;
    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.ExisteUM : Boolean;
begin
  if (VprDItemNota.UMAnterior = Grade.cells[10,Grade.ALinha]) then
    result := true
  else
  begin
    result := (VprDItemNota.UnidadeParentes.IndexOf(Grade.Cells[10,Grade.Alinha]) >= 0);
    if result then
    begin
      VprDItemNota.UM := Grade.Cells[7,Grade.Alinha];
      VprDItemNota.UMAnterior := VprDItemNota.UM;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.AlteraEnabledBotao(VpaAcao : Boolean);
begin
  BCancela.Enabled := VpaAcao;
  BCadastrar.Enabled := not VpaAcao;
  BFechar.Enabled := not VpaAcao;
  BGravar.Enabled := false;
end;

{******************************************************************************}
function TFNovaNotaFiscaisFor.DadosNotaFiscalValidos : Boolean;
begin
  result := true;
  if ENumNota.AInteiro = 0 then
  begin
    result := false;
    aviso('NUMERO DA NOTA INVÁLIDO!!!'#13'É necessário digitar um número para a nota fiscal.');
    ActiveControl := ENumNota;
  end
  else
    if ESerieNota.Text = '' then
    begin
      result := false;
      aviso('SÉRIE DA NOTA INVÁLIDA!!!'#13'É necessário digitar a série da nota fiscal.');
      ActiveControl := ESerieNota;
    end
    else
      if ENatureza.Text = '' then
      begin
        result := false;
        aviso('NATUREZA OPERAÇÃO INVÁLIDA!!!'#13'É necessário digitar a natureza de operação da nota fiscal.');
        ActiveControl := ENatureza;
      end
      else
        if ECodFornecedor.AInteiro = 0 then
        begin
          result := false;
          aviso('FORNECEDOR INVÁLID0!!!'#13'É necessário digitar o fornecedor da nota fiscal.');
          ActiveControl := ECodFornecedor;
        end
        else
        if VprDNotaFor.DNaturezaOperacao.IndFinanceiro then
        begin
          if EPlano.Text = '' then
          begin
            result := false;
            aviso('PLANO DE CONTAS INVÁLIDO!!!'#13'É necessário digitar o plano de contas da nota fiscal.');
            ActiveControl := EPlano;
          end
          else
            if EFormaPagamento.AInteiro = 0 then
            begin
              result := false;
              aviso('FORMA DE PAGAMENTO INVÁLIDA!!!'#13'É necessário digitar a forma de pagamento da nota fiscal.');
              ActiveControl := EFormaPagamento;
            end
            else
              if EQtdParcelas.Value = 0 then
              begin
                result := false;
                aviso('QUANTIDADE DE PARDELAS INVÁLIDA!!!'#13'É necessário digitar a quantidade de parcelas da nota fiscal.');
                ActiveControl := EQtdParcelas;
              end;
        end;
  if result then
  begin
    if VprDNotaFor.ItensNota.Count = 0 then
    begin
      result := false;
      aviso('NOTA FISCAL SEM PRODUTOS!!!'#13'É necessário digitar os produtos da nota fiscal.');
      ActiveControl := Grade;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ImpressaoEtiquetaBarras;
begin
  case varia.ModeloEtiquetaNotaEntrada of
    0 : begin // etiqueta 10 X 3 - A4(25mm x 67mm)
          FunNotaFor.PreparaEtiqueta(VprDNotaFor,EPosInicial.AsInteger);
          dtRave := TdtRave.create(self);
          dtRave.ImprimeEtiquetaProduto10X3A4;
          dtRave.free;
        end;
    2,3,4 :  FunNotaFor.ImprimeEtiquetaNota(VprDNotaFor);
    5 : begin
          FunNotaFor.PreparaEtiqueta(VprDNotaFor,EPosInicial.AsInteger);
          FunCrystal.ImprimeRelatorio(Varia.PathRelatorios + '\Etiquetas\XX_Produtos 20 X 4 - A4(12,7mm x 44,45mm).rpt',['1']);
        end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.AlteraProduto;
begin
  if ExisteProduto then
  begin
    FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
    if FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VprDItemNota.SeqProduto) <> nil then
    begin
      VprProdutoAnterior := '-1';
      ExisteProduto;
    end;
    FNovoProdutoPro.free;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            calculos da nota
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ConfiguraPermissaoUsuario;
begin
  if not config.EstoquePorCor then
  begin
    Grade.ColWidths[3] := -1;
    Grade.ColWidths[4] := -1;
    Grade.TabStops[3] := false;
    Grade.TabStops[4] := false;
    Grade.ColWidths[2] := RetornaInteiro(Grade.ColWidths[2] *1.9);
  end;
  if not config.EstoquePorTamanho then
  begin
    Grade.ColWidths[5] := -1;
    Grade.ColWidths[6] := -1;
    Grade.TabStops[5] := false;
    Grade.TabStops[6] := false;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarTitulosGrade;
begin
  grade.Cells[1,0] := 'Código';
  grade.Cells[2,0] := 'Produto';
  grade.Cells[3,0] := 'Cor';
  grade.Cells[4,0] := 'Descrição';
  grade.Cells[5,0] := 'Tamanho';
  grade.Cells[6,0] := 'Descrição';
  grade.Cells[7,0] := 'CFOP';
  grade.Cells[8,0] := 'Cl Fisc.';
  grade.Cells[9,0] := 'CST';
  grade.Cells[10,0] := 'UM';
  grade.Cells[11,0] := 'Qtd';
  grade.Cells[12,0] := 'Valor Unitário';
  grade.Cells[13,0] := 'Valor Total';
  grade.Cells[14,0] := '%ICMS';
  grade.Cells[15,0] := '%IPI';
  grade.Cells[16,0] := 'Valor Venda';
  grade.Cells[17,0] := 'Número Série';
  if config.Farmacia then
    grade.Cells[17,0] := 'Numero Lote';
  grade.Cells[18,0] := 'Ref Fornecedor';
  grade.Cells[19,0] := 'Etiquetas';
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.InicializaTela;
begin
  VprOperacao := ocInsercao;
  LimpaComponentes(ScrollBox1,0);
  VprDNotaFor.Free;
  VprDNotaFor := TRBDNotaFiscalFor.cria;
  VprDNotaFor.IndNotaDevolucao := false;
  Grade.ADados := VprDNotaFor.ItensNota;
  Grade.CarregaGrade;
  Grade.col := 1;
  LFilial.Caption := 'Filial : '+IntToStr(varia.CodigoEmpFil)+'-'+Varia.NomeFilial;
  EDatEntrada.Text := DataToStrFormato(DDMMAA,DecDia(Now,1),'/');
  EDatRecebimento.Text := DataToStrFormato(DDMMAA,Now,'/');
  CAcrescimoDesconto.ItemIndex := 0;
  CValorPercentual.ItemIndex := 0;
  CFreteEmitente.Checked := true;
  AutoCalculo.Checked := true;
  if Varia.CodFormaPagamentoNotaEntrada <> 0 then
  begin
    EFormaPagamento.AInteiro := Varia.CodFormaPagamentoNotaEntrada;
    EFormaPagamento.Atualiza;
    EFormaPagamento.Enabled := false;
  end;

  AlteraEnabledBotao(true);
  ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.InicializaTelaTroca;
begin
  ENumNota.AInteiro := 1;
  ESerieNota.AInteiro := 1;
  EFormaPagamento.AInteiro := varia.FormaPagamentoDinheiro;
  ENatureza.Text := varia.NaturezaOperacaoTroca;
  ENatureza.Atualiza;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CalculaValorTotalProduto;
begin
  if (VprDItemNota.ValUnitario = 0) and (VprDItemNota.ValTotal <> 0) then
    VprDItemNota.ValUnitario := VprDItemNota.ValTotal / VprDItemNota.QtdProduto
  else
//    if (VprDItemNota.ValUnitario <> 0) and (VprDItemNota.ValTotal = 0) then
    VprDItemNota.ValTotal := VprDItemNota.ValUnitario * VprDItemNota.QtdProduto;
  Grade.Cells[11,Grade.ALinha] := FormatFloat(varia.MascaraQtd,VprDItemNota.QtdProduto);
  Grade.Cells[12,Grade.ALinha] := FormatFloat('###,###,###,##0.0000',VprDItemNota.ValUnitario);
  Grade.Cells[13,Grade.ALinha] := FormatFloat(Varia.MascaraValor,VprDItemNota.ValTotal);
  Grade.Cells[16,Grade.ALinha] := FormatFloat(Varia.MascaraValorUnitario,VprDItemNota.ValNovoVenda);
end;


{**************************Calcula o valor da nota*****************************}
procedure TFNovaNotaFiscaisFor.CalculaNota;
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    CarDClasse;
    FunNotaFor.CalculaNota(VprDNotaFor);
    EBaseICms.AValor := VprDNotaFor.ValTotal;
    EValIcms.AValor := VprDNotaFor.ValICMS;
    EValTotalProdutos.AValor := VprDNotaFor.ValTotalProdutos;
    EValTotal.AValor := VprDNotaFor.ValTotal;
    EValTotIpi.AValor := VprDNotaFor.ValIPI;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDTela;
begin
  FunNotaFor.CarDNaturezaOperacao(VprDNotaFor,VprDNotaFor.SeqNatureza);
  with VprDNotaFor do
  begin
    ENumNota.AInteiro := NumNota;
    ESerieNota.Text := SerNota;
    ENatureza.Text := CodNatureza;

    EDatEntrada.Text := FormatDateTime('DD/MM/YY',DatEmissao);
    EDatRecebimento.Text := FormatDateTime('DD/MM/YY',DatRecebimento);
    ECodFornecedor.AInteiro := CodFornecedor;
    EFormaPagamento.AInteiro := CodFormaPagamento;
    EPlano.text := DNaturezaOperacao.CodPlanoContas;
    EQtdParcelas.Value := QtdParcelas;
    ENumDias.Value := NumDiasPrazo;
    EValICMS.Avalor := ValICMS;
    EValICMSSubs.Avalor := ValICMSSubstituicao;
    EBaseIcmsSubs.Avalor := ValBaseICMSSubstituicao;
    EValTotal.Avalor := ValTotal;
    EValFrete.AValor := ValFrete;
    EValSeguro.AValor := ValSeguro;
    EValTotIpi.AValor := ValIPI;
    EValTotalProdutos.AValor := ValTotalProdutos;
    EBaseICMS.AValor := ValTotalProdutos;
    EValOutrasDespesas.AValor := ValOutrasDespesas;
    CFreteEmitente.Checked := IndFreteEmitente;
    ECodTransportadora.AInteiro := CodTransportadora;
    EObservacoes.Lines.Text := DesObservacao;
    EVendedor.AInteiro := CodVendedor;
    EVendedor.Atualiza;
    EPerComissao.AValor := PerComissao;
  end;
  CarDescontoTela;
  AtualizaLocalizas([ENatureza,ECodFornecedor,EFormaPagamento,EPlano,ECodTransportadora]);
  Grade.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDClasse;
begin
  with VprDNotaFor do
  begin
    CodFilial := varia.CodigoEmpFil;
    NumNota := ENumNota.AInteiro;
    SerNota := ESerieNota.Text;
    CodNatureza := ENatureza.Text;
    DatEmissao := StrtoDate(EDatEntrada.text);
    DatRecebimento := StrtoDate(EDatRecebimento.text);
    CodFornecedor := ECodFornecedor.Ainteiro;
    CodFormaPagamento := EFormaPagamento.AInteiro;
    DNaturezaOperacao.CodPlanoContas := EPlano.Text;
    QtdParcelas := EQtdParcelas.Value;
    NumDiasPrazo := ENumDias.Value;
    ValICMS := EValICMS.AValor;
    ValTotal := EValTotal.AValor;
    ValFrete := EValFrete.Avalor;
    ValSeguro := EValSeguro.Avalor;
    ValIPI := EValTotIpi.AValor;
    ValBaseICMSSubstituicao := EBaseIcmsSubs.AValor;
    ValICMSSubstituicao := EValICMSSubs.AValor;
    ValOutrasDespesas := EValOutrasDespesas.Avalor;
    IndFreteEmitente := CFreteEmitente.Checked;
    CodTransportadora := ECodTransportadora.AInteiro;
    DesObservacao := EObservacoes.Lines.Text;
    PerComissao := EPerComissao.AValor;
    CarDesconto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDesconto;
begin
  with VprDNotaFor do
  begin
    PerDesconto := 0;
    ValDesconto := 0;
    if CValorPercentual.ItemIndex = 0 then //valor
    begin
      ValDesconto := EDesconto.AValor;
      if (CAcrescimoDesconto.ItemIndex = 0) then
        ValDesconto := ValDesconto * (-1);
    end
    else
      if CValorPercentual.ItemIndex = 1 then //percentual
      begin
        PerDesconto := EDesconto.AValor;
        if (CAcrescimoDesconto.ItemIndex = 0) then
          PerDesconto := PerDesconto * (-1);
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDescontoTela;
begin
  CValorPercentual.ItemIndex := -1;
  CAcrescimoDesconto.ItemIndex := -1;

  if VprDNotaFor.PerDesconto <> 0 then
  begin
    CValorPercentual.ItemIndex := 1;
    if VprDNotaFor.PerDesconto > 0 then
    begin
      EDesconto.AValor := VprDNotaFor.PerDesconto;
      CAcrescimoDesconto.ItemIndex := 1;
    end
    else
    begin
      EDesconto.AValor := VprDNotaFor.PerDesconto * (-1);
      CAcrescimoDesconto.ItemIndex := 0;
    end;
  end
  else
    if VprDNotaFor.ValDesconto <> 0 then
    begin
      CValorPercentual.ItemIndex := 0;
      if VprDNotaFor.ValDesconto > 0 then
      begin
        EDesconto.AValor := VprDNotaFor.ValDesconto;
        CAcrescimoDesconto.ItemIndex := 1;
      end
      else
      begin
        EDesconto.AValor := VprDNotaFor.ValDesconto *(-1);
        CAcrescimoDesconto.ItemIndex := 0;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarDItem;
begin
  VprDItemNota.CodProduto := Grade.Cells[1,Grade.Alinha];
  if config.PermiteAlteraNomeProdutonaNotaEntrada then
    VprDItemNota.NomProduto := Grade.Cells[2,Grade.Alinha];
  if Grade.Cells[3,Grade.ALinha] <> '' then
    VprDItemNota.CodCor := StrToInt(Grade.Cells[3,Grade.Alinha])
  else
    VprDItemNota.CodCor := 0;
  VprDItemNota.DesCor := Grade.Cells[4,Grade.ALinha];
  if Grade.Cells[5,Grade.ALinha] <> '' then
    VprDItemNota.CodTamanho := StrToInt(Grade.Cells[5,Grade.Alinha])
  else
    VprDItemNota.CodTamanho := 0;
  VprDItemNota.DesTamanho := Grade.Cells[6,Grade.ALinha];
  VprDItemNota.UM := Grade.Cells[10,Grade.ALinha];
  VprDItemNota.QtdProduto := StrToFloat(DeletaChars(Grade.Cells[11,Grade.ALinha],'.'));
  if DeletaChars(DeletaChars(Grade.Cells[12,Grade.ALinha],'0'),',') <> '' then
    VprDItemNota.ValUnitario := StrToFloat(DeletaChars(Grade.Cells[12,Grade.ALinha],'.'))
  else
    if DeletaChars(DeletaChars(Grade.Cells[13,Grade.ALinha],'0'),',') <> '' then
      VprDItemNota.ValTotal := StrToFloat(DeletaChars(Grade.Cells[13,Grade.ALinha],'.'));
  VprDItemNota.PerICMS := StrToFloat(DeletaChars(Grade.Cells[14,Grade.ALinha],'.'));
  VprDItemNota.PerIPI := StrToFloat(DeletaChars(Grade.Cells[15,Grade.ALinha],'.'));
  VprDItemNota.ValNovoVenda := StrToFloat(DeletaChars(Grade.Cells[16,Grade.ALinha],'.'));
  VprDItemNota.DesNumSerie := Grade.Cells[17,Grade.ALinha];
  VprDItemNota.DesReferenciaFornecedor := Grade.Cells[18,Grade.ALinha];
  if Grade.Cells[19,Grade.ALinha] <> '' then
    VprDItemNota.QtdEtiquetas := StrToInt(Grade.Cells[19,Grade.Alinha])
  else
    VprDItemNota.QtdEtiquetas := 0;

  CalculaValorTotalProduto;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.CarregaDadosCliente;
var
  VpfResultado : String;
begin
  if ECodFornecedor.Ainteiro <> VprDNotaFor.CodFornecedor then
  begin
    VprDNotaFor.CodFornecedor := ECodFornecedor.AInteiro;
    VprDCliente.CodCliente :=  VprDNotaFor.CodFornecedor;
    if VprDCliente.CodCliente <> 0 then
    begin
      FunClientes.CarDCliente(VprDCliente,true);
      //carrega o nome do contato
      if (VprOperacao in [ocinsercao,ocEdicao]) then
      begin
        VprDNotaFor.CGC_CPFFornecedor := VprDCliente.CGC_CPF;
        if (Config.SimplesFederal) or not(VprDNotaFor.DNaturezaOperacao.IndCalcularICMS) then
          VprICMSPadrao := 0
        else
          VprICMSPadrao := FunNotaFor.RValICMSFornecedor(VprDCliente.DesUF);
      end;
    end;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Ações dos botões Inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Quando for clicado no autoCalculo**********************}
procedure TFNovaNotaFiscaisFor.AutoCalculoClick(Sender: TObject);
begin
   if autocalculo.Checked then
     CalculaNota;
   EBaseICms.ReadOnly := Autocalculo.Checked;
   EValIcms.ReadOnly := Autocalculo.Checked;
   EValTotalProdutos.ReadOnly := Autocalculo.Checked;
   EValTotal.ReadOnly := Autocalculo.Checked;
   EValTotIPI.ReadOnly := Autocalculo.Checked;
end;

{***********************Quando é cancelado a nota******************************}
procedure TFNovaNotaFiscaisFor.BCancelaClick(Sender: TObject);
begin
  VprAcao:= False;
  LimpaComponentes(ScrollBox1,0);
  FreeTObjectsList(VprDNotaFor.ItensNota);
  Grade.CarregaGrade;
  VprOperacao := ocConsulta;
  AlteraEnabledBotao(false);
  if VprNotaPedido then
    Close;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFNovaNotaFiscaisFor.BFecharClick(Sender: TObject);
begin
  close;
end;

{*******************Cadastra uma nova transportadora***************************}
procedure TFNovaNotaFiscaisFor.ECodTransportadoraCadastrar(Sender: TObject);
begin
   FNovaTransportadora := TFNovaTransportadora.CriarSDI(Application,'',true);
   FNovaTransportadora.CadTransportadoras.Insert;
   FNovaTransportadora.ShowModal;
   Localiza.AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************************Chama o calcla nota********************************}
procedure TFNovaNotaFiscaisFor.EValFreteExit(Sender: TObject);
begin
   CalculaNota;
end;

{********************Quando é alterado quem pagara o frete*********************}
procedure TFNovaNotaFiscaisFor.CFreteEmitenteClick(Sender: TObject);
begin
  VprDNotaFor.IndFreteEmitente := CFreteEmitente.Checked;
  CalculaNota;
end;

{****** pemite alterar o foco com f4 **************************************** }
procedure TFNovaNotaFiscaisFor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  laco, tag : integer;
begin
  tag := 0;
  if key = 115 then
  begin
    for laco := 0 to PanelColor1.ControlCount - 1 do
     if (PanelColor1.Controls[laco] is TWinControl) then
       if (PanelColor1.Controls[laco] as TWinControl).Focused then
         tag := (PanelColor1.Controls[laco] as TWinControl).Tag;
    case tag of
      1 : Grade.SetFocus;
      2 : EBaseICms.SetFocus;
      3 : ENumNota.SetFocus;
    end
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ENaturezaRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    if VprOperacao in [ocInsercao,ocEdicao] then
    begin
      VprDNotaFor.CodNatureza := Retorno1;
      FunNotaFor.CarDNaturezaOperacao(VprDNotaFor);
      EPlano.Text := VprDNotaFor.DNaturezaOperacao.CodPlanoContas;
      EPlanoExit(EPlano);
      LNatureza.Caption := VprDNotaFor.DNaturezaOperacao.NomOperacaoEstoque;
   end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.EPlanoExit(Sender: TObject);
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VprDNotaFor.DNaturezaOperacao.CodPlanoContas := EPlano.text;
  if not FPlanoConta.verificaCodigo( VprDNotaFor.DNaturezaOperacao.CodPlanoContas, 'D', Label33, false,(Sender is TSpeedButton) ) then
    EPlano.SetFocus;
  EPlano.text := VprDNotaFor.DNaturezaOperacao.CodPlanoContas;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 114 then
    EPlanoExit(SpeedButton5);
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.EFormaPagamentoRetorno(Retorno1,
  Retorno2: String);
begin
  VprDNotaFor.TipFormaPagamento := retorno1;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ECorEnter(Sender: TObject);
begin
  ECor.Clear;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application , '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.showmodal;
  FCores.free;
  Localiza.Atualizaconsulta;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.EDatEntradaExit(Sender: TObject);
begin
  if (StrToDate(EDatEntrada.text) <= varia.DataUltimoFechamento) then
  begin
    Aviso(CT_DATAMENORULTIMOFECHAMENTO);
    EDatEntrada.Clear;
  end;

end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItemNota := TRBDNotaFiscalForItem(VprDNotaFor.ItensNota.Items[VpaLinha-1]);
  Grade.Cells[1,VpaLinha] := VprDItemNota.CodProduto;
  Grade.Cells[2,VpaLinha] := VprDItemNota.NomProduto;
  if VprDItemNota.CodCor <> 0 then
    Grade.Cells[3,VpaLinha] := IntToStr(VprDItemNota.CodCor)
  else
    Grade.Cells[3,VpaLinha] := '';
  Grade.Cells[4,VpaLinha] := VprDItemNota.DesCor;

  if VprDItemNota.CodTamanho <> 0 then
    Grade.Cells[5,VpaLinha] := IntToStr(VprDItemNota.CodTamanho)
  else
    Grade.Cells[5,VpaLinha] := '';
  Grade.Cells[6,VpaLinha] := VprDItemNota.DesTamanho;
  Grade.Cells[7,VpaLinha] := VprDItemNota.CodNatureza ;
  Grade.Cells[8,VpaLinha] := VprDItemNota.CodClassificacaoFiscal;
  Grade.Cells[9,VpaLinha] := VprDItemNota.CodCST;
  Grade.Cells[10,VpaLinha] := VprDItemNota.UM;
  Grade.Cells[14,VpaLinha] := FormatFloat('0.00',VprDItemNota.PerICMS);
  Grade.Cells[15,VpaLinha] := FormatFloat('0.00',VprDItemNota.PerIPI);
  CalculaValorTotalProduto;
  Grade.Cells[17,VpaLinha] := VprDItemNota.DesNumSerie;
  Grade.Cells[18,VpaLinha] := VprDItemNota.DesReferenciaFornecedor;
  Grade.Cells[19,VpaLinha] := IntToStr(VprDItemNota.QtdEtiquetas);
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeDepoisExclusao(Sender: TObject);
begin
  CalculaNota;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeEnter(Sender: TObject);
begin
  CarDClasse;
end;

procedure TFNovaNotaFiscaisFor.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3,19 :  Value := '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case Grade.Col of
        1 :  LocalizaProduto;
        3 :  ECor.AAbreLocalizacao;
        5 :  ETamanho.AAbreLocalizacao;
      end;
    end;
    vk_f6 : AlteraProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeKeyPress(Sender: TObject;
  var Key: Char);
begin
  IF (Grade.Col = 4) or ((Grade.Col = 2) and not config.PermiteAlteraNomeProdutonaNotaEntrada) then
    key := #0;

  if (key = '.') and (Grade.col <> 1) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDNotaFor.ItensNota.Count >0 then
  begin
    VprDItemNota := TRBDNotaFiscalForItem(VprDNotaFor.ItensNota.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior := VprDItemNota.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeNovaLinha(Sender: TObject);
begin
  VprDItemNota := VprDNotaFor.AddNotaItem;
  VprDItemNota.PerICMS := VprICMSPadrao;
  VprDItemNota.PerIPI := 0;
  VprDItemNota.CodNatureza := VprDNotaFor.CodNatureza;
  VprDItemNota.SeqNatureza := VprDNotaFor.SeqNatureza;
  Grade.Cells[7,Grade.ALinha] := VprDItemNota.CodNatureza ;
  Grade.Cells[14,Grade.ALinha] := FormatFloat('0.00',VprDItemNota.PerICMS);
  Grade.Cells[15,Grade.ALinha] := FormatFloat('0.00',VprDItemNota.PerIPI);
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1 :if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               Grade.Cells[1,Grade.ALinha] := '';
               Grade.Col := 1;
             end;
           end;
        3 : if Grade.Cells[3,Grade.Alinha] <> '' then
            begin
              if not ExisteCor(StrToInt(Grade.Cells[3,Grade.Alinha])) then
              begin
                if not ECor.AAbreLocalizacao then
                begin
                  Aviso(CT_CORINEXISTENTE);
                  Grade.Col := 3;
                  abort;
                end;
              end;
            end;
        5 : if not ETamanho.AExisteCodigo(Grade.Cells[5,Grade.ALinha]) then
            begin
              if not ETamanho.AAbreLocalizacao then
              begin
                aviso('TAMANHO INEXISTENTE!!!'#13'É necessário digitar um tamanho cadatrado');
                abort;
                Grade.Col := 5;
              end;
            end;
        10: if not ExisteUM then
            begin
              aviso(CT_UNIDADEVAZIA);
              Grade.col := 10;
              abort;
            end;
        11: begin
               if Grade.Cells[11,Grade.ALinha] <> '' then
                 VprDItemNota.QtdProduto := StrToFloat(DeletaChars(Grade.Cells[11,Grade.ALinha],'.'))
               else
                 VprDItemNota.QtdProduto := 0;
               CalculaValorTotalProduto;
               VprDItemNota.QtdEtiquetas := ArredondaPraMaior(VprDItemNota.QtdProduto);
               Grade.Cells[19,Grade.ALinha] := IntToStr(VprDItemNota.QtdEtiquetas);
            end;
        12 : begin
               if Grade.Cells[12,Grade.ALinha] <> '' then
               begin
                 VprDItemNota.ValTotal := 0;
                 VprDItemNota.ValUnitario := StrToFloat(DeletaChars(Grade.Cells[12,Grade.ALinha],'.'));
               end
               else
                 VprDItemNota.ValUnitario := 0;
               CalculaValorTotalProduto;
             end;
        13 :
             begin
               if Grade.Cells[13,Grade.ALinha] <> '' then
               begin
                 VprDItemNota.ValUnitario := 0;
                 VprDItemNota.ValTotal := StrToFloat(DeletaChars(Grade.Cells[13,Grade.ALinha],'.'));
               end
               else
                 VprDItemNota.ValTotal := 0;
               CalculaValorTotalProduto;
             end;
      end;
    end;
end;

procedure TFNovaNotaFiscaisFor.ECorRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[3,Grade.ALinha] := ECor.Text;
    Grade.Cells[4,Grade.ALinha] := Retorno1;
    Grade.AEstadoGrade := egEdicao;
  end;

end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if Grade.Cells[1,Grade.ALinha] = '' then
  begin
    VpaValidos := false;
    aviso(CT_PRODUTOINVALIDO);
  end
  else
    if not ExisteProduto then
    begin
      VpaValidos := false;
      aviso(CT_PRODUTONAOCADASTRADO);
      Grade.col := 1;
    end
    else
      if (Grade.Cells[3,Grade.ALinha] <> '') then
      begin
        if not Existecor(StrToInt(Grade.Cells[3,Grade.ALinha])) then
        begin
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          Grade.Col := 3;
        end;
      end
      else
        if config.ExigirCorNotaEntrada then
        begin
          // se a cor for igual a '' e estiver configurado para controlar estoque
          // pela cor, entao fazer checagem direta.
          VpaValidos := false;
          Aviso(CT_CORINEXISTENTE);
          Grade.Col := 3;
        end;
  if vpavalidos then
  begin
    if not ETamanho.AExisteCodigo(Grade.Cells[5,Grade.ALInha]) then
    begin
      VpaValidos := false;
      Aviso('TAMANHO INEXISTENTE!!!'#13'É necessário digitar um tamanho válido.');
      Grade.Col := 5;
    end
    else
      if (VprDItemNota.UnidadeParentes.IndexOf(Grade.Cells[10,Grade.Alinha]) < 0) then
      begin
        VpaValidos := false;
        aviso(CT_UNIDADEVAZIA);
        Grade.col := 10;
      end
      else
        if (Grade.Cells[11,Grade.ALinha] = '') then
        begin
          VpaValidos := false;
          aviso(CT_QTDPRODUTOINVALIDO);
          Grade.Col := 11;
        end
        else
          if ((Grade.Cells[12,Grade.ALinha] = '') and (Grade.Cells[12,Grade.ALinha] = '')) then
          begin
            VpaValidos := false;
            aviso(CT_VALORUNITARIOINVALIDO);
            Grade.Col := 12;
          end;
  end;

  if VpaValidos then
  begin
    CarDItem;
    CalculaNota;
    if VprDItemNota.QtdProduto = 0 then
    begin
      VpaValidos := false;
      aviso(CT_QTDPRODUTOINVALIDO);
      Grade.col := 11
    end
    else
      if VprDItemNota.ValUnitario = 0 then
      begin
        VpaValidos := false;
        aviso(CT_VALORUNITARIOINVALIDO);
        Grade.Col := 12;
      end;
  end;
  if VpaValidos then
  begin
    if config.Farmacia then
    begin
      if (VprDItemNota.IndMedicamentoControlado) and (VprDItemNota.DesNumSerie = '') then
      begin
        VpaValidos := false;
        aviso('NUMERO DO LOTE NÃO PREENCHIDO!!!'#13'É necessário preencher o numero do lote quando o medicamento é controlado.');
        Grade.Col := 17;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BCadastrarClick(Sender: TObject);
begin
  InicializaTela;
  ENumNota.SetFocus;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if DadosNotaFiscalValidos then
  begin
    CarDClasse;
    if FPrincipal.BaseDados.InTransaction then
      FPrincipal.BaseDados.Rollback(VprTransacao);
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
    try
      if (VprOperacao = ocEdicao) then//se é alteraçao da nota fiscal de entrada
      begin
        if FunContasPagar.ExcluiContaNotaFiscal(VprDNotaFor.SeqNota ) then
        begin
          FunNotaFor.EstornaNotaEntrada(VprDNotaFor.CodFilial,VprDNotaFor.SeqNota);
        end
        else
          VpfResultado :='NÃO FOI POSSÍVEL EXCLUIR O CONTAS A PAGAR.';
      end;

      if VpfResultado = '' then
      begin
        VpfResultado := FunNotaFor.GravaDNotaFor(VprDNotaFor);
        if VpfResultado <>'' then
          aviso(VpfResultado)
        else
        begin
          Tempo.execute('Atualizando Estoque Produto...');
          FunNotaFor.BaixaProdutosEstoque(VprDNotaFor);
          Tempo.fecha;
          Tempo.execute('Gerando o Contas a Pagar...');
          VpfResultado :=  FunNotaFor.GeraContasaPagar(VprDNotaFor);
          if VpfResultado = '' then
          begin
            if VprDNotaFor.IndNotaDevolucao then
            begin
              VpfResultado := FunContasAReceber.GeraComissaoNegativa(VprDNotaFor);
            end;
          end;
          Tempo.fecha;
        end;
      end;
      if VpfResultado = '' then
      begin
        FPrincipal.BaseDados.Commit(VprTransacao);
        VprAcao:= True;
        AlteraEnabledBotao(false);
      end
      else
      begin
        FPrincipal.BaseDados.Rollback(VprTransacao);
        aviso(VpfResultado);
      end;
    except
      on e : Exception do
      begin
        FPrincipal.BaseDados.Rollback(VprTransacao);
        aviso(e.message);
      end;
    end;
    if VprAcao then
    begin
      if VprIndTroca then
      begin
        VprDCotacao.ValTroca := VprDNotaFor.ValTotal;
        VprDCotacao.SeqNotaEntrada := VprDNotaFor.SeqNota;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.GradeGetCellAlignment(sender: TObject; ARow,
  ACol: Integer; var HorAlignment: TAlignment;
  var VerAlignment: TVerticalAlignment);
begin
  if ACol = 16 then
    HorAlignment :=  taRightJustify;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BCancelarClick(Sender: TObject);
begin
  PEtiqueta.Visible := false;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BEtiquetaClick(Sender: TObject);
begin
  case varia.ModeloEtiquetaNotaEntrada of
    0, 5 : PEtiqueta.Visible := true;
    2,3,4,6,7 :  FunNotaFor.ImprimeEtiquetaNota(VprDNotaFor);
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BOKClick(Sender: TObject);
begin
  ImpressaoEtiquetaBarras;
  PEtiqueta.Visible := false;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ECodFornecedorSelect(Sender: TObject);
begin
  ECodFornecedor.ASelectLocaliza.Text := 'Select * from CadClientes where c_nom_Cli like ''@%''';
  ECodFornecedor.ASelectValida.Text := 'select * from CadClientes where I_COD_CLI = @';
  if not VprDNotaFor.IndNotaDevolucao then
  begin
   ECodFornecedor.ASelectLocaliza.Text := ECodFornecedor.ASelectLocaliza.Text +' and c_ind_for = ''S''';
   ECodFornecedor.ASelectValida.Text := ECodFornecedor.ASelectValida.Text +' and c_ind_for = ''S''';
  end;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeNotaFiscalEntrada(VprDNotaFor.CodFilial,VprDNotaFor.SeqNota,false);
  dtRave.free;
end;

{******************************************************************************}
procedure TFNovaNotaFiscaisFor.ETamanhoRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if (VprOperacao in [ocinsercao,ocedicao]) and
     (VprDItemNota <> nil) then
  begin
    if VpaColunas.items[0].AValorRetorno <> '' then
    begin
      VprDItemNota.CodTamanho := StrToINt(VpaColunas.items[0].AValorRetorno);
      VprDItemNota.DesTamanho := VpaColunas.items[1].AValorRetorno;
      Grade.Cells[5,Grade.ALinha] := VpaColunas.items[0].AValorRetorno;
      Grade.Cells[6,Grade.ALinha] := VpaColunas.items[1].AValorRetorno;
    end
    else
    begin
      VprDItemNota.CodTamanho := 0;
      VprDItemNota.DesTamanho := '';
    end;
  end;
end;

Initialization
{***************Registra a classe para evitar duplicidade**********************}
   RegisterClasses([TFNovaNotaFiscaisFor]);
end.

