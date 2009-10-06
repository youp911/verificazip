unit ANovoContasaPagar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, Db, DBTables, Tabela, StdCtrls,
  DBCtrls, BotaoCadastro, Buttons, Localizacao, UnDados,
  Grids, DBGrids, constantes, Mask, DBKeyViolation, LabelCorMove,
  Spin, EditorImagem, numericos, unContasaPagar, UnDespesas, UnDadosCR, UnClientes,
  FMTBcd, SqlExpr, ComCtrls, CGrades;

type
  TFNovoContasAPagar = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Localiza: TConsultaPadrao;
    Imagem: TEditorImagem;
    ValidaGravacao: TValidaGravacao;
    Aux: TSQLQuery;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BotaoGravar1: TBitBtn;
    BNovo: TBitBtn;
    BotaoCancelar1: TBitBtn;
    PanelColor1: TPanelColor;
    Paginas: TPageControl;
    PGeral: TTabSheet;
    PanelColor3: TPanelColor;
    PCabecalho: TPanelColor;
    Label1: TLabel;
    Label3: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    LNomFornecedor: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    Label6: TLabel;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    Label11: TLabel;
    SpeedButton2: TSpeedButton;
    Label17: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    LParcelas: TLabel;
    EFilial: TEditColor;
    ELanPagar: TEditColor;
    EFornecedor: TEditLocaliza;
    EMoeda: TEditLocaliza;
    ENota: Tnumerico;
    Tempo: TPainelTempo;
    EPlano: TEditColor;
    ECentroCusto: TEditLocaliza;
    ECodBarras: TEditColor;
    EValorparcelas: Tnumerico;
    EQtdParcelas: Tnumerico;
    EValorTotal: Tnumerico;
    PRodape: TPanelColor;
    Label5: TLabel;
    LFoto: TLabel;
    LQtdDiasEntre: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    SpeedButton4: TSpeedButton;
    Label7: TLabel;
    Label4: TLabel;
    SpeedButton5: TSpeedButton;
    Label9: TLabel;
    EDataEmissao: TMaskEditColor;
    EQtdDiasEntre: TSpinEditColor;
    SpinEdit2: TSpinEditColor;
    EdcFormaPgto: TEditLocaliza;
    BFoto: TBitBtn;
    EContaCaixa: TEditLocaliza;
    CBaixarConta: TCheckBox;
    PProjeto: TPanelColor;
    Label16: TLabel;
    SpeedButton6: TSpeedButton;
    LNomProjeto: TLabel;
    EProjeto: TRBEditLocaliza;
    PaginaProjeto: TTabSheet;
    RBStringGridColor1: TRBStringGridColor;
    BAutorizacaoPagamento: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEditColor2Exit(Sender: TObject);
    procedure DBEditButton4Exit(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BNovoClick(Sender: TObject);
    procedure EFornecedorCadastrar(Sender: TObject);
    procedure DBEditColor20Exit(Sender: TObject);
    procedure EValorparcelasExit(Sender: TObject);
    procedure EFilialChange(Sender: TObject);
    procedure EdcFormaPgtoCadastrar(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BotaoGravar1Click(Sender: TObject);
    procedure BotaoCancelar1Click(Sender: TObject);
    procedure EFornecedorAlterar(Sender: TObject);
    procedure ECentroCustoCadastrar(Sender: TObject);
    procedure BFotoClick(Sender: TObject);
    procedure EdcFormaPgtoRetorno(Retorno1, Retorno2: String);
    procedure CBaixarContaClick(Sender: TObject);
    procedure ECodBarrasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure EDataEmissaoExit(Sender: TObject);
    procedure EProjetoCadastrar(Sender: TObject);
    procedure BAutorizacaoPagamentoClick(Sender: TObject);
  private
    VprDContasAPagar : TRBDContasaPagar;
    VprDatEmissao :TDAteTime;
    VprAcao : Boolean;
    VprPressionadoR,
    VprEsconderParcela : Boolean;
    VprContaCaixa : String;
    VprDCliente : TRBDCliente;
    VprTransacao : TTransactionDesc;
    procedure CarDClasse;
    function DadosValidos : string;
    procedure InicializaTela;
    procedure AlteraEstadoBotoes(VpaEstado : Boolean);
    procedure InterpretaCodigoBarras;
    procedure ConfiguraTela;
    procedure AdicionaDespesaProjeto;
  public
    function NovoContasaPagar(VpaCodFornecedor : Integer) : Boolean;
  end;

var
  FNovoContasAPagar: TFNovoContasAPagar;

implementation

uses ConstMsg,  FunData, APrincipal, funString,
  ANovoCliente, funObjeto, funsql, AFormasPagamento,
  ADespesas, APlanoConta,  UnClassesImprimir, ACentroCusto, AProjetos, dmRave;

{$R *.DFM}

{**************************Na criação do Formulário****************************}
procedure TFNovoContasAPagar.FormCreate(Sender: TObject);
begin
  VprPressionadoR := false;
  VprEsconderParcela := false;
  VprDCliente := TRBDCliente.cria;
  VprDContasAPagar := TRBDContasaPagar.cria;
  VprAcao := false;
  VprDatEmissao := date;

  EDataEmissao.EditMask := FPrincipal.CorFoco.AMascaraData;
  ConfiguraTela;
end;

{**********************Quando o formulario e fechado***************************}
procedure TFNovoContasAPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);
  VprDContasAPagar.free;
  VprDCliente.free;
  Action := CaFree;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações de Inicialização
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoContasAPagar.CarDClasse;
begin
  VprDContasAPagar.CodFilial := Varia.CodigoEmpFil;
  VprDContasAPagar.NumNota := ENota.AsInteger;
  VprDContasAPagar.SeqNota := 0;
  VprDContasAPagar.CodFornecedor := EFornecedor.AInteiro;
  VprDContasAPagar.CodBarras := ECodBarras.Text;
  VprDContasAPagar.NomFornecedor := LNomFornecedor.Caption;
  VprDContasAPagar.CodCentroCusto := ECentroCusto.AInteiro;
  VprDContasAPagar.CodFormaPagamento :=  EdcFormaPgto.AInteiro;
  VprDContasAPagar.CodMoeda := EMoeda.AInteiro;
  VprDContasAPagar.CodUsuario := varia.CodigoUsuario;
  VprDContasAPagar.DatEmissao := StrToDate(EDataEmissao.Text);
  VprDContasAPagar.CodPlanoConta := EPlano.text;
  VprDContasAPagar.NumContaCaixa := EContaCaixa.Text;
  VprDContasAPagar.DesPathFoto := LFoto.Caption;
  VprDContasAPagar.QtdParcela := EQtdParcelas.AsInteger;
  if EValorparcelas.AValor = 0 then
    VprDContasAPagar.ValParcela := EValorTotal.AValor / EQtdParcelas.AsInteger
  else
    VprDContasAPagar.ValParcela := EValorparcelas.AValor;
  VprDContasAPagar.QtdDiasPriVen := SpinEdit2.Value;
  VprDContasAPagar.QtdDiasDemaisVen := EQtdDiasEntre.Value;
  VprDContasAPagar.PerDescontoAcrescimo := 0;
  VprDContasAPagar.IndMostrarParcelas :=  true;
  VprDContasAPagar.IndEsconderConta := VprEsconderParcela;
  VprDContasAPagar.IndBaixarConta := CBaixarConta.Checked;
  VprContaCaixa := EContaCaixa.Text;
end;

{******************************************************************************}
function TFNovoContasAPagar.DadosValidos : string;
begin
  result := '';
  if EValorTotal.avalor = 0 then
    EValorTotal.AValor := EValorParcelas.AValor * EQtdParcelas.AsInteger;
  if EValorTotal.AValor = 0 then
  begin
    result := 'VALOR DO TÍTULO NÃO PREENCHIDO!!!'#13'É necessário informar um valor para o título.';
    EValorTotal.SetFocus;
  end;
  if result = '' then
  begin
    if CBaixarConta.Checked and (EContaCaixa.Text = '') then
    begin
      Result := 'CONTA CAIXA NÃO PREENCHIDO!!!'#13'É necessário preencher a conta caixa na baixa automatica.';
    end;
  end;
end;

{*******************permite atualizar os campos relacionados*******************}
procedure TFNovoContasAPagar.InicializaTela;
begin
  VprDContasAPagar.free;
  VprDContasAPagar := TRBDContasaPagar.cria;
  VprDCliente.Free;
  VprDCliente := TRBDCliente.cria;
  PanelColor3.Enabled := true;
  LimpaComponentes(PanelColor3,0);
  LPlano.Caption := '';
  EMoeda.Text := IntTostr(Varia.MoedaBase);
  EMoeda.Atualiza;
  EQtdParcelas.AsInteger := 1; // Somente uma parcela.}
  ECentroCusto.AInteiro := varia.CentroCustoPadrao;
  ECentroCusto.Atualiza;
  EContaCaixa.Text := VprContaCaixa;
  EContaCaixa.Atualiza;
  EFilial.Text := IntTostr(Varia.CodigoEmpFil);  // adiciona o codigo da filial
  EDataEmissao.Text := dateTostr(VprDatEmissao);      // valida campo data
  EQtdParcelas.ReadOnly := False;
  AlteraEstadoBotoes(true);
  ValidaGravacao.execute;
  ActiveControl := ECodBarras;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Chamadas para telas de Cadastros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************Cadastro na Consulta do campo Fornecedores******************}
procedure TFNovoContasAPagar.EFornecedorCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'',true);
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.CadClientesC_IND_FOR.AsString := 'S';
  FNovoCliente.CadClientesC_IND_CLI.AsString := 'N';
  FNovoCliente.ShowModal;
  Localiza.AtualizaConsulta;
end;

{*****************Cadastra uma nova forma de Pagamento*************************}
procedure TFNovoContasAPagar.EdcFormaPgtoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.ShowModal;
  Localiza.AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Validação dos campos relacionados
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************************valida o numero da nota fiscal***********************}
procedure TFNovoContasAPagar.DBEditButton4Exit(Sender: TObject);
begin
   aux.close;
   if (ENota.Text <> '') and (Efornecedor.Text <> '' ) then  // verifica se exixte o nro da not, forn, e filial ja cadastrado no CP.
   begin
     AdicionaSQLAbreTabela(aux, 'select I_NRO_NOT from CADCONTASAPAGAR '+
                                ' where I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                                ' and I_NRO_NOT = ' + ENota.Text +
                                ' and I_COD_CLI = ' + EFornecedor.Text);
     if not (aux.EOF) then
       if confirmacao(' Já existe uma Nota Fiscal Cadastrada no Contas a Pagar com o Nº ' +  ENota.Text + ' do Fornecedor  "' +
                     LNomFornecedor.Caption  + '". Deseja cancelar  o cadastro ? ' ) then
         BotaoCancelar1.Click
   end;
   aux.close;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Validação dos campos Gerais
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*****************valida o campo parcela no minimo 1 parcela*******************}
procedure TFNovoContasAPagar.DBEditColor2Exit(Sender: TObject);
begin
  LQtdDiasEntre.Enabled := EQtdParcelas.AsInteger > 1;
  EQtdDiasEntre.Enabled := LQtdDiasEntre.Enabled;
end;

{*****************caso o valor total > 0 zera o valor das parcelas*************}
procedure TFNovoContasAPagar.DBEditColor20Exit(Sender: TObject);
begin
  if (EValorTotal.avalor > 0) then
    EValorParcelas.AValor := 0;
end;

{******************caso o valor da parcela > 0 zera o valor total**************}
procedure TFNovoContasAPagar.EValorparcelasExit(Sender: TObject);
begin
if (EValorParcelas.AValor > 0) then
   EValorTotal.AValor := 0;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              Botoes de Atividade, novo, alterar, parcelas, etc
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{****Qunado fechar o formulario verifica o capa de lote e o CadContasaPagar****}
procedure TFNovoContasAPagar.BFecharClick(Sender: TObject);
begin
  close;
end;

{***************************adiciona uma nova conta****************************}
procedure TFNovoContasAPagar.BNovoClick(Sender: TObject);
begin
  InicializaTela;
  if Self.Visible then
    ECodBarras.SetFocus;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovoContasAPagar.NovoContasaPagar(VpaCodFornecedor : Integer) : Boolean;
begin
  InicializaTela;
  EFornecedor.AInteiro := VpaCodFornecedor;
  EFornecedor.Atualiza;
  if VpaCodFornecedor <> 0 then
    ActiveControl := ENota;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.AlteraEstadoBotoes(VpaEstado : Boolean);
begin
  BNovo.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
  BotaoCancelar1.Enabled := VpaEstado;
  BotaoGravar1.Enabled := VpaEstado;
  BAutorizacaoPagamento.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.InterpretaCodigoBarras;
begin
  if length(ECodBarras.Text)>=20 then
  begin
    FunContasAPagar.InterpretaCodigoBarras(VprDContasAPagar,ECodBarras.Text);
    EValorTotal.AValor := VprDContasAPagar.ValBoleto;
    EdcFormaPgto.AInteiro := VprDContasAPagar.CodFormaPagamento;
    EdcFormaPgto.Atualiza;
    EFornecedor.AInteiro := VprDContasAPagar.CodFornecedor;
    EFornecedor.Atualiza;
  end;
  if EFornecedor.AInteiro = 0 then
    ActiveControl := EFornecedor
  else
    ActiveControl := ENota;
end;

{ ***************** valida a gravacao dos registros *********************** }
procedure TFNovoContasAPagar.ConfiguraTela;
begin
  PaginaProjeto.TabVisible := Config.ControlarProjeto;
  PProjeto.Visible := Config.ControlarProjeto;
  if not config.ControlarProjeto then
    self.Height := self.Height -24 ;
end;

{ ***************** valida a gravacao dos registros *********************** }
procedure TFNovoContasAPagar.AdicionaDespesaProjeto;
var
  VpfDDespesaProjeto : TRBDContasaPagarProjeto;
begin
  if config.ControlarProjeto then
  begin
    if EProjeto.AInteiro <> 0 then
    begin
      FreeTObjectsList(VprDContasAPagar.DespesaProjeto);
      VpfDDespesaProjeto := VprDContasAPagar.addDespesaProjeto;
      VpfDDespesaProjeto.CodProjeto := EProjeto.AInteiro;
      VpfDDespesaProjeto.NomProjeto := LNomProjeto.Caption;
      VpfDDespesaProjeto.PerDespesa := 100;
      if EValorparcelas.AValor <> 0 then
        VpfDDespesaProjeto.ValDespesa := EValorparcelas.AValor * EQtdParcelas.AsInteger
      else
        VpfDDespesaProjeto.ValDespesa := EValorTotal.AValor;
    end;
  end;
end;

{ ***************** valida a gravacao dos registros *********************** }
procedure TFNovoContasAPagar.EFilialChange(Sender: TObject);
begin
  if BotaoGravar1 <> nil then
  begin
     ValidaGravacao.execute;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'D', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;


procedure TFNovoContasAPagar.EProjetoCadastrar(Sender: TObject);
begin
  FProjetos := tFProjetos.CriarSDI(self,'',true);
  FProjetos.BotaoCadastrar1.Click;
  FProjetos.ShowModal;
  FProjetos.free;
end;

procedure TFNovoContasAPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
        if (key = 87) then
        begin
          if BotaoGravar1.Enabled then
          begin
            VprEsconderParcela := true;
            BotaoGravar1.Click;
            VprEsconderParcela := false;
            VprPressionadoR := false;
          end;
        end
        else
          VprPressionadoR := false;
  end;

end;

{******************************************************************************}
procedure TFNovoContasAPagar.BotaoGravar1Click(Sender: TObject);
var
  vpfResultado : String;
begin
  vpfResultado := DadosValidos;
  Tempo.execute('Criando as Parcelas...');
  if vpfResultado = '' then
  begin
    CarDClasse;
    AdicionaDespesaProjeto;
    if not FPrincipal.BaseDados.InTransaction then
    begin
//      VprTransacao.IsolationLevel := xilREADCOMMITTED;
//      FPrincipal.Basedados.StartTransaction(VprTransacao);
    end;
    vpfResultado := FunContasAPagar.CriaContaPagar(VprDContasAPagar,VprDCliente);
    if vpfResultado = '' then
    begin
      ELanPagar.AInteiro := VprDContasAPagar.LanPagar;
      EValorTotal.AValor := VprDContasAPagar.ValTotal;
    end;
  end;
  Tempo.Fecha;

  if vpfResultado = '' then
  begin
    if FPrincipal.BaseDados.InTransaction then
      FPrincipal.BaseDados.Commit(VprTransacao);
    AlteraEstadoBotoes(false);
    VprAcao := true;
  end
  else
  begin
    if FPrincipal.BaseDados.InTransaction then
      FPrincipal.BaseDados.Rollback(VprTransacao);
    aviso(vpfResultado);
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.BotaoCancelar1Click(Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja cancelar a digitação do Contas a Pagar?') then
  begin
    AlteraEstadoBotoes(false);
    PanelColor3.Enabled := false;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EFornecedorAlterar(Sender: TObject);
begin
  if EFornecedor.ALocaliza.Loca.Tabela.FieldByName(EFornecedor.AInfo.CampoCodigo).AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
    FNovoCliente.CadClientes.FindKey([EFornecedor.ALocaliza.Loca.Tabela.FieldByName(EFornecedor.AInfo.CampoCodigo).Value]);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    Localiza.AtualizaConsulta;
    FNovoCliente.free;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.ECentroCustoCadastrar(Sender: TObject);
begin
  FCentroCusto := TFCentroCusto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCentroCusto'));
  FCentroCusto.BotaoCadastrar1.Click;
  FCentroCusto.Showmodal;
  FCentroCusto.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.BFotoClick(Sender: TObject);
begin
  if Imagem.execute(varia.DriveFoto) then
    LFoto.Caption := Imagem.PathImagem;
end;

procedure TFNovoContasAPagar.BAutorizacaoPagamentoClick(Sender: TObject);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeAutorizacaoPagamento(VprDContasAPagar.CodFilial,VprDContasAPagar.LanPagar,0,Date,date);
  dtRave.free;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EdcFormaPgtoRetorno(Retorno1,
  Retorno2: String);
begin
  CBaixarConta.Enabled := Retorno2 = 'S';
  if not CBaixarConta.Enabled then
    CBaixarConta.Checked := false;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.CBaixarContaClick(Sender: TObject);
begin
  EContaCaixa.ACampoObrigatorio := CBaixarConta.Checked;
  ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.ECodBarrasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    InterpretaCodigoBarras;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EFornecedorRetorno(Retorno1,
  Retorno2: String);
begin
  if EFornecedor.AInteiro <> 0 then
  begin
    if EFornecedor.AInteiro <> VprDCliente.CodCliente then
    begin
      VprDCliente.CodCliente := EFornecedor.AInteiro;
      FunClientes.CarDCliente(VprDCliente,true);
      IF VprDCliente.CodPlanoContas <> '' then
      begin
        EPlano.Text := VprDCliente.CodPlanoContas;
        EPlanoExit(EPlano);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EDataEmissaoExit(Sender: TObject);
begin
  VprDatEmissao := StrToDate(EDataEmissao.Text);
end;

Initialization
 RegisterClasses([TFNovoContasAPagar]);
end.

