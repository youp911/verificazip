unit ARelPedido;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, PainelGradiente, Componentes1, Formularios, StdCtrls, Buttons,
  Localizacao, ComCtrls, Mask, numericos, Db, DBTables, UnProdutos,
  Grids, CGrades, UnClassificacao, Spin, UnCotacao, UnRave;

type
  TFRelPedido = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    ScrollBox1: TScrollBox;
    BFechar: TBitBtn;
    PFilial: TPanelColor;
    Localiza: TConsultaPadrao;
    Label24: TLabel;
    EFilial: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    LFilial: TLabel;
    PCliente: TPanelColor;
    LTextoCliente: TLabel;
    ECliente: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    LCliente: TLabel;
    PCidade: TPanelColor;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    LCidade: TLabel;
    ECidade: TEditLocaliza;
    PEstado: TPanelColor;
    Label4: TLabel;
    SpeedButton3: TSpeedButton;
    Label5: TLabel;
    EEstado: TEditLocaliza;
    PCondPgto: TPanelColor;
    Label6: TLabel;
    SpeedButton4: TSpeedButton;
    LCondPgto: TLabel;
    ECondPgto: TEditLocaliza;
    PPeriodo: TPanelColor;
    LPeriodo: TLabel;
    CDataIni: TCalendario;
    CDataFim: TCalendario;
    Label9: TLabel;
    PTipoCotacao: TPanelColor;
    Label3: TLabel;
    ETipoCotacao: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    LTipoCotacao: TLabel;
    PVendedor: TPanelColor;
    Label11: TLabel;
    EVendedor: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    LVendedor: TLabel;
    PSituacao: TPanelColor;
    Label7: TLabel;
    RFlagSituacao: TRadioGroup;
    PDataFinal: TPanelColor;
    LDataFinal: TLabel;
    CDataFinal: TCalendario;
    PSitCliente: TPanelColor;
    Label8: TLabel;
    SpeedButton8: TSpeedButton;
    LSituacaoCliente: TLabel;
    ESituacaoCliente: TEditLocaliza;
    Aux: TQuery;
    PEmpresa: TPanelColor;
    Label10: TLabel;
    SpeedButton9: TSpeedButton;
    LEmpresa: TLabel;
    ECodEmpresa: TEditLocaliza;
    PTabelaPreco: TPanelColor;
    Label13: TLabel;
    SpeedButton10: TSpeedButton;
    LNomTabelaPreco: TLabel;
    ECodTabelaPreco: TEditLocaliza;
    PProduto: TPanelColor;
    Label14: TLabel;
    EProduto: TEditLocaliza;
    SpeedButton11: TSpeedButton;
    LProduto: TLabel;
    PBanco: TPanelColor;
    Label15: TLabel;
    EBanco: TEditLocaliza;
    SpeedButton12: TSpeedButton;
    LBanco: TLabel;
    PUsuario: TPanelColor;
    Label16: TLabel;
    SpeedButton13: TSpeedButton;
    LNomUsuario: TLabel;
    ECodUsuario: TEditLocaliza;
    PFormaPagamento: TPanelColor;
    Label17: TLabel;
    SpeedButton14: TSpeedButton;
    LFormaPagamento: TLabel;
    EFormaPagamento: TEditLocaliza;
    BMostrarConta: TSpeedButton;
    PClassificacaoProduto: TPanelColor;
    Label12: TLabel;
    SpeedButton15: TSpeedButton;
    LNomClassificacao: TLabel;
    ECodClassifcacao: TEditColor;
    PQtdVias: TPanelColor;
    Label18: TLabel;
    EQtdVias: TSpinEditColor;
    PEstagio: TPanelColor;
    Label19: TLabel;
    SpeedButton16: TSpeedButton;
    LEstagio: TLabel;
    ECodEstagio: TEditLocaliza;
    PTransportadora: TPanelColor;
    Label20: TLabel;
    SpeedButton17: TSpeedButton;
    LTransportadora: TLabel;
    ETransportadora: TEditLocaliza;
    PFundoPerdido: TPanelColor;
    CFundoPerdido: TCheckBox;
    PTipoContrato: TPanelColor;
    Label21: TLabel;
    SpeedButton18: TSpeedButton;
    LNomTipoContrato: TLabel;
    ECodTipoContrato: TEditLocaliza;
    PPreposto: TPanelColor;
    Label22: TLabel;
    SpeedButton19: TSpeedButton;
    LPreposto: TLabel;
    EPreposto: TEditLocaliza;
    PTecnico: TPanelColor;
    LTituloTecnico: TLabel;
    ETecnico: TEditLocaliza;
    SpeedButton20: TSpeedButton;
    LTecnico: TLabel;
    POperacaoEstoque: TPanelColor;
    Label25: TLabel;
    SpeedButton21: TSpeedButton;
    LOperacaoEstoque: TLabel;
    EOperacaoEstoque: TEditLocaliza;
    PCor: TPanelColor;
    Label27: TLabel;
    SpeedButton22: TSpeedButton;
    LCor: TLabel;
    ECodCor: TEditLocaliza;
    PCotacaoCancelada: TPanelColor;
    Label26: TLabel;
    ESituacaoCotacao: TComboBoxColor;
    PClienteMaster: TPanelColor;
    Label28: TLabel;
    SpeedButton23: TSpeedButton;
    LClienteMaster: TLabel;
    EClienteMaster: TEditLocaliza;
    PCentroCusto: TPanelColor;
    Label29: TLabel;
    SpeedButton24: TSpeedButton;
    LCentroCusto: TLabel;
    ECentroCusto: TRBEditLocaliza;
    PNumerico1: TPanelColor;
    LNumerico1: TLabel;
    ENumerico1: Tnumerico;
    BImprimir: TBitBtn;
    PTipoPeriodo: TPanelColor;
    Label1: TLabel;
    ETipoPeriodo: TComboBoxColor;
    PProjeto: TPanelColor;
    Label23: TLabel;
    SpeedButton25: TSpeedButton;
    LProjeto: TLabel;
    EProjeto: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ECodTabelaPrecoSelect(Sender: TObject);
    procedure EProdutoSelect(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure BMostrarContaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton15Click(Sender: TObject);
    procedure ECodClassifcacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodClassifcacaoExit(Sender: TObject);
  private
    { Private declarations }
    VprArquivo, VprCaminhoRelatorio, VprNomRelatorio: string;
    VprSeqProduto : Integer;
    VprPressionadoR : Boolean;
    FunClassificacao : TFuncoesClassificacao;
    FunRave : TRBFunRave;
    procedure SetarVisibleFalsePanels;
    procedure RedimensionarFormulario;
//d5    function CriaPanel(VpaParametro: TCrpeParamFields;VpaCriarLabel : Boolean): TPanelColor;
    function CriaLabel(VpaDono : TComponent; VpaPrompt: string): TLabel;
    function CriaNumerico(VpaParametro: string): TNumerico;
    function CriaCheckBox(VpaParametro : String) : TCheckBox;
//d5    procedure CriaPanelNumerico(VpaParametro: TCrpeParamFields);
//d5    procedure CriaPanelBooleano(VpaParametro: TCrpeParamFields);
    function RetornaVlrFiltroGenerico(VpaParametro: string): string;
    procedure RotinasRelatoriosEspeciais;
    procedure LeParametros;
    function LocalizaClassificacao : boolean;
    procedure MostraFiltrosRelatorio(VpaNomRelatorio : String);
  public
    { Public declarations }
    procedure CarregarRelatorio(VpaArquivo, VpaNomeRel: string);
  end;

var
  FRelPedido: TFRelPedido;

implementation

{$R *.DFM}

uses APrincipal, ConstMsg, FunData, FunSql, Constantes, FunObjeto,
  ALocalizaClassificacao, dmRave, funString, funarquivos;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                   FORMULÁRIO
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRelPedido.FormCreate(Sender: TObject);
begin
  ScrollBox1.BorderStyle := bsNone;
  CDataIni.DateTime := PrimeiroDiaMes(Now);
  CDataFim.DateTime := UltimoDiaMes(Now);
  CDataFinal.DateTime := Now;
  EFilial.AInteiro := varia.CodigoEmpFil;
  EFilial.Atualiza;
  ESituacaoCotacao.ItemIndex := 0;
  VprPressionadoR := false;
  FunClassificacao := TFuncoesClassificacao.criar(self,FPrincipal.BaseDados);
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                   SUBROTINAS
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRelPedido.SetarVisibleFalsePanels;
var
  Laco: integer;
begin
  Laco := 0;
  while Laco < ScrollBox1.ControlCount do
  begin
    if ScrollBox1.Controls[Laco] is TPanelColor then
    begin
      if (TPanelColor(ScrollBox1.Controls[Laco]).Name[1] = 'X') and
        (TPanelColor(ScrollBox1.Controls[Laco]).Name[2] = 'X') then
        TPanelColor(ScrollBox1.Controls[Laco]).Free
      else
        begin
          TPanelColor(ScrollBox1.Controls[Laco]).Hide;// := false;
          inc(Laco);
        end;
    end;
  end;
end;

{******************************************************************************}
procedure TFRelPedido.RedimensionarFormulario;
var
  Laco, TotPanels: integer;
begin
  TotPanels := 0;
  for Laco := 0 to ScrollBox1.ControlCount -1 do
    if ScrollBox1.Controls[Laco] is TPanelColor then
      if TPanelColor(ScrollBox1.Controls[Laco]).Visible then
        inc(TotPanels);

  Self.Height := PainelGradiente1.Height + PanelColor2.Height +
    (TotPanels * PFilial.Height) + 40;

  if Self.Height > 525 then
    Self.Height := 525;
end;

{d5 ******************************************************************************
procedure TFRelPedido.ExibePanel(VpaParametro: TCrpeParamFields);
begin
                                PEmpresa.Visible := true;
                                ECodEmpresa.AInteiro := varia.CodigoEmpresa;
                                ECodEmpresa.Atualiza;
                                begin
                                  PTabelaPreco.Visible := true;
                                  ECodTabelaPreco.AInteiro := varia.TabelaPreco;
                                  ECodTabelaPreco.Atualiza;
                                end
                                else
end;

{d5 ******************************************************************************
function TFRelPedido.CriaPanel(VpaParametro: TCrpeParamFields;VpaCriarLabel : Boolean): TPanelColor;
Var
  VpfLabel : TLabel;
begin
//  inc(VprTotGenerico);
  Result        := TPanelColor.Create(Application);
  Result.Name   := 'XXP'+VpaParametro.Name;
  Result.Caption:= '';
  Result.Height := 29;
  Result.Align  := alTop;
  Result.BevelOuter  := bvNone;
  Result.ACorForm    := PFilial.ACorForm;
  Result.ParentFont := false;
  result.Font := PFilial.Font;
  if VpaCriarLabel then
  begin
    VpfLabel := CriaLabel(Result, VpaParametro.Prompt);
    result.InsertControl(VpfLabel);
  end;
end;

{******************************************************************************}
function TFRelPedido.CriaLabel(VpaDono : TComponent; VpaPrompt: string): TLabel;
begin
  Result       := TLabel.Create(VpaDono);
  Result.AutoSize := false;
  if screen.Height = 768 then
    Result.Left  := 8
  else
    Result.Left  := 8;
  Result.Top   := 5;
  Result.Width := 150;
  Result.Height:= 16;
  Result.Alignment:= taRightJustify;
  Result.Caption  := VpaPrompt ;
end;

{******************************************************************************}
function TFRelPedido.CriaNumerico(VpaParametro: string): TNumerico;
begin
  Result     := Tnumerico.Create(Application);
  result.ACorFoco := FPrincipal.CorFoco;
  Result.Name:= VpaParametro;
  if screen.Height = 768 then
    Result.Left  := 164
  else
    Result.Left  := 129;
  Result.Top   := 2;
  Result.Width := 87;
  Result.Height:= 24;
  Result.ADecimal:= 3;
  Result.AMascara:= '0';
  Result.ParentFont := false;
  Result.font := EFilial.Font;
  result.ACorFoco := EFilial.ACorFoco;
end;

{******************************************************************************}
function TFRelPedido.CriaCheckBox(VpaParametro : String) : TCheckBox;
begin
  Result     := TCheckBox.Create(Application);
  Result.Name:= VpaParametro;
  Result.Left  := 164;
  Result.Top   := 2;
  Result.ParentFont := false;
  Result.font := EFilial.Font;
  result.Width := 300;
end;

{d5 ******************************************************************************
procedure TFRelPedido.CriaPanelNumerico(VpaParametro: TCrpeParamFields);
var
  VpfPanel : TPanelColor;
  VpfNumerico : Tnumerico;
begin
  VpfPanel := CriaPanel(VpaParametro,true);
  VpfPanel.ACorForm := FPrincipal.CorForm;
  VpfNumerico := CriaNumerico(VpaParametro.Name);
  VpfPanel.InsertControl(VpfNumerico);


  ScrollBox1.InsertControl(VpfPanel);
end;

{d5 ******************************************************************************
procedure TFRelPedido.CriaPanelBooleano(VpaParametro: TCrpeParamFields);
var
  VpfPanel : TPanelColor;
  VpfCheckBox : TCheckBox;
begin
  VpfPanel := CriaPanel(VpaParametro,False);
  VpfCheckBox := CriaCheckBox(VpaParametro.Name);
  VpfCheckBox.Caption := VpaParametro.Prompt;
  VpfPanel.InsertControl(VpfCheckBox);


  ScrollBox1.InsertControl(VpfPanel);
end;

{******************************************************************************}
function TFRelPedido.RetornaVlrFiltroGenerico(VpaParametro: string): string;
var
  VpfLaco, VpfLaco2: integer;
  Vpfachou: boolean;
  VpfPanelAtual: TPanelColor;
  VpfComponenteAtual: TComponent;
begin
  Vpfachou := false;
  Vpflaco := 0;
  while (Vpflaco < ScrollBox1.ControlCount) and (not Vpfachou) do
  begin
    if ScrollBox1.Controls[Vpflaco] is TPanelColor then
    begin
      Vpflaco2 := 0;
      VpfPanelAtual := TPanelColor(ScrollBox1.Controls[Vpflaco]);
      while Vpflaco2 < VpfPanelAtual.ControlCount do
      begin
        VpfComponenteAtual := TComponent(VpfPanelAtual.Controls[VpfLaco2]);
        if VpfComponenteAtual.Name = VpaParametro then
        begin
          Vpfachou := true;
          if VpfComponenteAtual is TCalendario then
            Result := DateToStr(TCalendario(VpfComponenteAtual).DateTime)
          else
            if VpfComponenteAtual is TCheckBox then
            begin
              if TCheckBox(VpfComponenteAtual).Checked then
                result := 'true'
              else
                result := 'false';
            end
            else
              Result := TCustomEdit(VpfComponenteAtual).Text;
        end;
        inc(Vpflaco2);
      end;
    end;
    inc(Vpflaco);
  end;
end;

{******************************************************************************}
procedure TFRelPedido.CarregarRelatorio(VpaArquivo, VpaNomeRel: string);
var
  VpfLaco: integer;
begin
  VprArquivo := VpaArquivo;
  VprNomRelatorio := Uppercase(VpaNomeRel);
  VprCaminhoRelatorio := RetornaDiretorioArquivo(VpaArquivo);
  VprCaminhoRelatorio := NomeModulo+'  Relatorios'+SubstituiStr(Copy(VprCaminhoRelatorio,length(varia.PathRelatorios)+1,length(VprCaminhoRelatorio)-length(varia.PathRelatorios)), '\','->')+VpaNomeRel;
  PainelGradiente1.Caption := '   ' + VpaNomeRel + '   ';
  MostraFiltrosRelatorio(VprNomRelatorio);

  RedimensionarFormulario;
  Self.ShowModal;
end;


{******************************************************************************}
procedure TFRelPedido.RotinasRelatoriosEspeciais;
begin
  if (UpperCase(VprNomRelatorio) = 'CLIENTES SEM PEDIDO')or (UpperCase(VprNomRelatorio) = 'CLIENTES COM PEDIDO') then
  begin
    ExecutaComandoSql(Aux,'Update CFG_GERAL SET D_CLI_PED = ' + SQLTextoDataAAAAMMMDD(CDataFinal.DateTime));
  end
  else
    if (UpperCase(VprNomRelatorio) = 'PRODUTOS FATURADOS POR MES E ESTADO') then
    begin
      FunProdutos.CarProdutoFaturadosnoMes(CDataIni.DateTime,CDataFim.DateTime,EFilial.AInteiro);
    end
    else
      if (UpperCase(VprNomRelatorio) = 'ENTRADA METROS DIARIOS') then
        FunCotacao.AtualizaEntradaMetrosDiario(CDataIni.DateTime,CDataFim.DateTime);
end;

{******************************************************************************}
procedure TFRelPedido.LeParametros;
var
  Laco: integer;
begin
{d5  for Laco := 0 to CCrystal.ParamFields.Count -1 do
  begin
    if CCrystal.ParamFields[Laco].ParamType = pfDateTime then
      CCrystal.ParamFields[Laco].AsDateTime := StrToDateTime(RetornaValores(CCrystal.ParamFields[Laco]))
    else
      if CCrystal.ParamFields[Laco].ParamType = pfDate then
        CCrystal.ParamFields[Laco].AsDate := StrToDateTime(RetornaValores(CCrystal.ParamFields[Laco]))
      else
        if CCrystal.ParamFields[Laco].ParamType = pfTime then
          CCrystal.ParamFields[Laco].AsTime := StrToDateTime(RetornaValores(CCrystal.ParamFields[Laco]))
        else
          CCrystal.ParamFields[Laco].Value := RetornaValores(CCrystal.ParamFields[Laco]);
  end;}
end;

{******************************************************************************}
function TFRelPedido.LocalizaClassificacao : Boolean;
var
  VpfCodClassificacao, VpfNomClassificacao : string;
begin
  result := true;
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao, 'P') then
  begin
    ECodClassifcacao.Text := VpfCodClassificacao;
    LNomClassificacao.Caption := VpfNomClassificacao;
  end
  else
    result := false;
end;

{******************************************************************************}
procedure TFRelPedido.MostraFiltrosRelatorio(VpaNomRelatorio : String);
begin
  SetarVisibleFalsePanels;
  if (VPANOMRELATORIO = 'NOTAS FISCAIS EMITIDAS') then
    AlterarVisibleDet([PVendedor,PFilial,PCliente,PClienteMaster, PPeriodo,PCotacaoCancelada],true)
  else
    if (VPANOMRELATORIO = 'PEDIDOS POR DIA') then
      AlterarVisibleDet([PVendedor,PFilial,PCliente,PPeriodo,PTipoCotacao,PSituacao],true)
    else
      if (VPANOMRELATORIO = 'PRODUTOS VENDIDOS POR CLASSIFICACAO') or
         (VPANOMRELATORIO = 'PRODUTOS VENDIDOS POR CLASSIFICACAO E ESTADO') then
        AlterarVisibleDet([PVendedor,PFilial,PCliente,PPeriodo,PTipoCotacao],true)
      else
        if (VPANOMRELATORIO = 'CLIENTES SEM PEDIDO') then
        begin
          AlterarVisibleDet([PVendedor,PSitCliente,PTipoCotacao,PDataFinal,PPreposto],true);
          LDataFinal.Caption := 'Desde : ';
        end
        else
          if (VPANOMRELATORIO = 'LEITURA DOS CONTRATOS') then
          begin
            AlterarVisibleDet([PTecnico,PCliente,PTipoContrato,PNumerico1],true);
            LTituloTecnico.Caption := 'Resp. Leitura :';
            LNumerico1.Caption := 'Dia Leitura : ';
          end
          else
            if (VPANOMRELATORIO = 'ESTOQUE PRODUTOS')or
               (VPANOMRELATORIO = 'ESTOQUE PRODUTOS RESERVADOS') then
            begin
              AlterarVisibleDet([PClassificacaoProduto,PFilial,PFundoPerdido],true);
              CFundoPerdido.Caption := 'Somente Produtos Monitorados';
              CFundoPerdido.Checked := false;
            end
            else
              if (VPANOMRELATORIO = 'VENDA ANALITICO') then
                AlterarVisibleDet([PCliente,PFilial,PTipoCotacao,PCondPgto,PVendedor,PPreposto,PPeriodo,PCidade,PEstado],true)
              else
                if (VPANOMRELATORIO = 'CONSISTENCIA DE ESTOQUE') then
                begin
                  AlterarVisibleDet([PFilial,PPeriodo,PProduto,PFundoPerdido],true);
                  cFundoPerdido.Caption := 'Somente Produtos Monitorados';
                  cFundoPerdido.Checked := false;
                end
                else
                  if (VPANOMRELATORIO = 'ESTOQUE MINIMO') then
                  begin
                    AlterarVisibleDet([PClassificacaoProduto,PFilial,PCliente],true);
                    LTextoCliente.Caption := 'Fornecedor : ';
                  end
                  else
                    if (VPANOMRELATORIO = 'ANALISE FATURAMENTO ANUAL') then
                      AlterarVisibleDet([PPeriodo,PCliente,PVendedor],true)
                    else
                      if (VPANOMRELATORIO = 'DEVOLUCOES PENDENTES') then
                      begin
                        AlterarVisibleDet([PFilial,PDataFinal,PCliente,PEstagio,PTransportadora],true);
                        LDataFinal.Caption := 'Desde : ';
                      end
                      else
                        if (VPANOMRELATORIO = 'ESTOQUE FISCAL') then
                          AlterarVisibleDet([PProduto,PFilial],true)
                        else
                          if (VPANOMRELATORIO = 'ESTOQUE POR GRUPOS E PRODUTOS') then
                          begin
                            AlterarVisibleDet([PFilial,PDataFinal,PFundoPerdido],true);
                            LDataFinal.Caption := 'Mes/Ano : ';
                            CFundoPerdido.Caption := 'Somente Produtos com Venda';
                          end
                          else
                            if (VPANOMRELATORIO = 'COTACOES EM ABERTO POR ESTAGIO') then
                              AlterarVisibleDet([PEstagio,PTransportadora,PPeriodo],true)
                            else
                              if (VPANOMRELATORIO = 'POR PLANO DE CONTAS ANALITICO') then
                                AlterarVisibleDet([PFilial,PPeriodo,PTipoPeriodo],true)
                              else
                                if (VPANOMRELATORIO = 'PRODUTIVIDADE PRODUCAO') then
                                begin
                                  AlterarVisibleDet([PDataFinal],true);
                                  LDataFinal.Caption := 'Mês : ';
                                end
                                else
                                  if (VPANOMRELATORIO = 'TOTAL CLIENTES ATENDIDOS E PRODUTOS VENDIDOS POR VENDEDOR') then
                                    AlterarVisibleDet([PPeriodo,PClienteMaster],true)
                                  else
                                    if (VPANOMRELATORIO = 'CUSTO PROJETO') then
                                      AlterarVisibleDet([PProjeto],true)
                                    else
                                      if (VPANOMRELATORIO = 'ESTOQUE DE PRODUTOS POR TECNICO') then
                                        AlterarVisibleDet([PTecnico],true)
                                      else
                                        if (VPANOMRELATORIO = 'PRODUTOS RETORNADOS COM DEFEITO') then
                                          AlterarVisibleDet([PTecnico,PPeriodo],true)
                                        else
                                          if (VPANOMRELATORIO = 'CONSISTENCIA RESERVA ESTOQUE') then
                                            AlterarVisibleDet([PProduto,PPeriodo],true)
                                          else
                                            if (VPANOMRELATORIO = 'FILA CHAMADOS POR TECNICO') then
                                              AlterarVisibleDet([PEstagio,PTecnico,PPeriodo],true)
                                            else
                                              if (VPANOMRELATORIO = 'VENDAS POR ESTADO E CIDADE') or
                                                 (VPANOMRELATORIO = 'TOTAL VENDAS POR ESTADO E CIDADE') then
                                                AlterarVisibleDet([PPeriodo,PTipoCotacao,PCliente,PCidade,PEstado,PCondPgto],true)
                                              else
                                                if (VPANOMRELATORIO = 'CLIENTES POR VENDEDOR') then
                                                  AlterarVisibleDet([PVendedor,PSitCliente,PCidade,PEstado],true)
                                                else
                                                  if (VPANOMRELATORIO = 'TOTAL VENDAS POR CLIENTE') or
                                                     (VPANOMRELATORIO = 'TOTAL VENDAS POR CLIENTE(CURVA ABC)')then
                                                    AlterarVisibleDet([PFilial,PVendedor,PPeriodo,PCondPgto,PTipoCotacao,PCidade,PEstado],true)
end;


{******************************************************************************}
procedure TFRelPedido.BImprimirClick(Sender: TObject);
Var
  VpfNomCampo : String;
begin
  dtRave := TdtRave.create(self);
  if (VPRNOMRELATORIO = 'NOTAS FISCAIS EMITIDAS') then
    dtRave.ImprimeNotasFiscaisEmitidas(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ECliente.AInteiro,EClienteMaster.AInteiro, EVendedor.Ainteiro,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,ESituacaoCotacao.itemindex)
  else
    if (VPRNOMRELATORIO = 'PEDIDOS POR DIA') then
      dtRave.ImprimePedidosPorDia(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ECliente.AInteiro,EVendedor.Ainteiro,ETipoCotacao.Ainteiro,RFlagSituacao.Itemindex,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,LTipoCotacao.Caption,RFlagSituacao.Items.Strings[RFlagSituacao.Itemindex])
    else
      if (VPRNOMRELATORIO = 'PRODUTOS VENDIDOS POR CLASSIFICACAO') then
        FunRave.ImprimeProdutoVendidosPorClassificacao(EFilial.AInteiro,ECliente.AInteiro,EVendedor.Ainteiro,ETipoCotacao.Ainteiro,CDataIni.Date,CdataFim.Date,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,LTipoCotacao.Caption,false)
      else
        if (VPRNOMRELATORIO = 'CLIENTES SEM PEDIDO') then
          dtRave.ImprimeClientesSemPedido(EVendedor.AInteiro,EPreposto.AInteiro, ESituacaoCliente.AInteiro,ETipoCotacao.AInteiro,CDataFinal.Date,LVendedor.Caption,LPreposto.Caption,LSituacaoCliente.Caption,LTipoCotacao.Caption,VprCaminhoRelatorio)
        else
          if (VPRNOMRELATORIO = 'LEITURA DOS CONTRATOS') then
            dtRave.ImprimeLeituraContratos(ECliente.Ainteiro,ETecnico.AInteiro,ECodTipoContrato.AInteiro, ENumerico1.AsInteger, VprCaminhoRelatorio,
                                           LCliente.caption,LTecnico.Caption,LNomTipoContrato.Caption)
          else
            if (VPRNOMRELATORIO = 'ESTOQUE PRODUTOS') then
              FunRave.ImprimeEstoqueProdutos(EFilial.AInteiro,VprCaminhoRelatorio,ECodClassifcacao.Text,'TOTAL',LFilial.caption,LNomClassificacao.Caption,CFundoPerdido.Checked)
            else
              if (VPRNOMRELATORIO = 'VENDA ANALITICO') then
                dtRave.ImprimeVendasAnalitico(EFilial.AInteiro,ECliente.Ainteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,EVendedor.AInteiro,EPreposto.AInteiro,
                                         CDataIni.DateTime,CDataFim.Date,VprCaminhoRelatorio,ECidade.Text,EEstado.Text,LCliente.Caption,LCondPgto.Caption,
                                         LTipoCotacao.Caption,LVendedor.Caption,LFilial.Caption,LPreposto.Caption)
            else
              if (VPRNOMRELATORIO = 'CONSISTENCIA DE ESTOQUE') then
                dtRave.ImprimeConsistenciadeEstoque(EFilial.AInteiro,VprSeqProduto,CDataIni.DateTime,CDataFim.Date,VprCaminhoRelatorio,
                                         LFilial.Caption,LProduto.Caption,CFundoPerdido.Checked)
              else
                if (VPRNOMRELATORIO = 'ESTOQUE MINIMO') then
                  FunRave.ImprimeQtdMinimasEstoque(EFilial.AInteiro,ECliente.AInteiro,VprCaminhoRelatorio,
                                           ECodClassifcacao.Text, LFilial.Caption,LNomClassificacao.Caption,LCliente.Caption)
                else
                  if (VPRNOMRELATORIO = 'ANALISE FATURAMENTO ANUAL') then
                    FunRave.ImprimeAnaliseFaturamentoMensal(EFilial.AInteiro,ECliente.AInteiro,EVendedor.AInteiro, VprCaminhoRelatorio,
                                             LFilial.Caption,LCliente.Caption,LVendedor.Caption,CDataIni.DateTime,CDataFim.Date)
                  else
                    if (VPRNOMRELATORIO = 'DEVOLUCOES PENDENTES') then
                      dtRave.ImprimeDevolucoesPendente(EFilial.AInteiro,ECliente.AInteiro,ETransportadora.AInteiro,ECodEstagio.AInteiro,CDataFinal.Date,VprCaminhoRelatorio,
                                               LFilial.Caption,LCliente.Caption,LTransportadora.Caption,LEstagio.Caption)
                  else
                    if (VPRNOMRELATORIO = 'ESTOQUE FISCAL') then
                      dtRave.ImprimeEstoqueFiscal(EFilial.AInteiro,VprSeqProduto,VprCaminhoRelatorio,
                                               LFilial.Caption,LProduto.Caption)
                    else
                      if (VPRNOMRELATORIO = 'ESTOQUE POR GRUPOS E PRODUTOS') then
                        FunRave.ImprimeFechamentoMes(EFilial.AInteiro,VprCaminhoRelatorio,LFilial.Caption,CDataFinal.Date,not CFundoPerdido.Checked)
                      else
                        if (VPRNOMRELATORIO = 'COTACOES EM ABERTO POR ESTAGIO') then
                          dtRave.ImprimePedidosEmAbertoPorEstagio(ECodEstagio.AInteiro,ETransportadora.AInteiro, VprCaminhoRelatorio,LEstagio.Caption,CDataIni.Date,CDataFim.Date)
                        else
                          if (VPRNOMRELATORIO = 'POR PLANO DE CONTAS ANALITICO') then
                          begin
                            FunRave.ImprimeContasAPagarPorPlanodeContas(EFilial.AInteiro,CDataIni.DateTime,CDataFim.DateTime,VprCaminhoRelatorio,LFilial.Caption,ETipoPeriodo.ItemIndex);
                          end
                          else
                            if (VPRNOMRELATORIO = 'PRODUTOS VENDIDOS POR CLASSIFICACAO E ESTADO') then
                              FunRave.ImprimeProdutoVendidosPorClassificacao(EFilial.AInteiro,ECliente.AInteiro,EVendedor.Ainteiro,ETipoCotacao.Ainteiro,CDataIni.Date,CdataFim.Date,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,LTipoCotacao.Caption,true)
                            else
                              if (VPRNOMRELATORIO = 'PRODUTIVIDADE PRODUCAO') then
                                FunRave.ImprimeExtratoProdutividade(VprCaminhoRelatorio,CDataFinal.Date)
                              else
                                if (VPRNOMRELATORIO = 'TOTAL CLIENTES ATENDIDOS E PRODUTOS VENDIDOS POR VENDEDOR') then
                                  dtRave.ImprimeTotalClientesAtendidoseProdutosVendidosporVendedor(EClienteMaster.AInteiro,VprCaminhoRelatorio,LClienteMaster.Caption,CDataIni.Date,CDataFim.Date)
                                else
                                  if (VPRNOMRELATORIO = 'CUSTO PROJETO') then
                                    FunRave.ImprimeCustoProjeto(EProjeto.AInteiro,VprCaminhoRelatorio,LProjeto.Caption)
                                  else
                                    if (VPRNOMRELATORIO = 'ESTOQUE DE PRODUTOS POR TECNICO') then
                                      dtRave.ImprimeEstoqueProdutoporTecnico(ETecnico.AInteiro,VprCaminhoRelatorio,LTecnico.Caption)
                                    else
                                      if (VPRNOMRELATORIO = 'PRODUTOS RETORNADOS COM DEFEITO') then
                                        dtRave.ImprimeProdutosRetornadosComDefeito(ETecnico.AInteiro,VprCaminhoRelatorio,LTecnico.Caption,CDataIni.Date,CDataFim.Date)
                                      else
                                        if (VPRNOMRELATORIO = 'CONSISTENCIA RESERVA ESTOQUE') then
                                          dtRave.ImprimeConsistenciaReservaEstoque(VprSeqProduto,VprCaminhoRelatorio,LProduto.Caption,CDataIni.Date,CDataFim.Date)
                                        else
                                          if (VPRNOMRELATORIO = 'FILA CHAMADOS POR TECNICO') then
                                            dtRave.ImprimeFilaChamadosPorTecnico(ECodEstagio.AInteiro,ETecnico.AInteiro,VprCaminhoRelatorio,LEstagio.Caption,LTecnico.Caption,CDataIni.Date,CDataFim.Date)
                                          else
                                            if (VPRNOMRELATORIO = 'VENDAS POR ESTADO E CIDADE') then
                                              dtRave.ImprimeVendasPorEstadoeCidade(ECliente.AInteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,VprCaminhoRelatorio,LCliente.Caption,LCondPgto.Caption,LTipoCotacao.Caption,LCidade.CAPTION,EEstado.text,CDataIni.Date,CDataFim.Date)
                                            else
                                              if (VPRNOMRELATORIO = 'TOTAL VENDAS POR ESTADO E CIDADE') then
                                                dtRave.ImprimeTotalVendasPorEstadoeCidade(ECliente.AInteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,VprCaminhoRelatorio,LCliente.Caption,LCondPgto.Caption,LTipoCotacao.Caption,LCidade.CAPTION,EEstado.text,CDataIni.Date,CDataFim.Date)
                                              else
                                                if (VPRNOMRELATORIO = 'CLIENTES POR VENDEDOR') then
                                                  dtRave.ImprimeClientesPorVendedor(EVendedor.AInteiro,ESituacaoCliente.AInteiro,vprCaminhoRelatorio,LVendedor.Caption,LSituacaoCliente.Caption,LCidade.CAPTION,EEstado.text)
                                                else
                                                  if (VPRNOMRELATORIO = 'TOTAL VENDAS POR CLIENTE') then
                                                    dtRave.ImprimeTotalVendasCliente(EVendedor.AInteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,EFilial.AInteiro,vprCaminhoRelatorio,LVendedor.Caption,LCondPgto.Caption,LTipoCotacao.Caption,LFilial.Caption, LCidade.CAPTION,EEstado.text,CDataIni.Date,CDataFim.Date,false)
                                                  else
                                                    if (VPRNOMRELATORIO = 'TOTAL VENDAS POR CLIENTE(CURVA ABC)') then
                                                      dtRave.ImprimeTotalVendasCliente(EVendedor.AInteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,EFilial.AInteiro,vprCaminhoRelatorio,LVendedor.Caption,LCondPgto.Caption,LTipoCotacao.Caption,LFilial.Caption, LCidade.CAPTION,EEstado.text,CDataIni.Date,CDataFim.Date,true)
                                                  else
                                                    if (VPRNOMRELATORIO = 'ESTOQUE PRODUTOS RESERVADOS') then
                                                      FunRave.ImprimeEstoqueProdutosReservados(EFilial.AInteiro,VprCaminhoRelatorio,ECodClassifcacao.Text,'TOTAL',LFilial.caption,LNomClassificacao.Caption,CFundoPerdido.Checked);
  dtRave.free;
end;

{******************************************************************************}
procedure TFRelPedido.BFecharClick(Sender: TObject);
begin
  Self.Close;
end;

{******************************************************************************}
procedure TFRelPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunClassificacao.Free;
  FunRave.free;
  Action := caFree;
end;

{******************************************************************************}
procedure TFRelPedido.ECodTabelaPrecoSelect(Sender: TObject);
begin
  ECodTabelaPreco.ASelectValida.text := 'Select * from CADTABELAPRECO Where I_COD_TAB = @ ';
  ECodTabelaPreco.ASelectLocaliza.Text := 'Select * from CADTABELAPRECO Where C_NOM_TAB like ''@%''';
  if ECodempresa.Ainteiro <> 0 then
  begin
    ECodTabelaPreco.ASelectValida.text := ECodTabelaPreco.ASelectValida.text + ' and I_COD_EMP = '+ECodEmpresa.Text;
    ECodTabelaPreco.ASelectLocaliza.text := ECodTabelaPreco.ASelectLocaliza.text + ' and I_COD_EMP = '+ECodEmpresa.Text;
  end;
end;

{******************************************************************************}
procedure TFRelPedido.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select '+Varia.CodigoProduto+',CAD.C_NOM_PRO, CAD.I_SEQ_PRO from CADPRODUTOS CAD, MOVQDADEPRODUTO MOV '+
                                 ' Where '+Varia.CodigoProduto + ' = ''@'' and CAD.C_ATI_PRO = ''S'''+
                                 ' AND MOV.I_SEQ_PRO = CAD.I_SEQ_PRO AND MOV.I_EMP_FIL = '+IntToStr(EFilial.AInteiro);
  EPRoduto.ASelectLocaliza.Text := 'Select '+Varia.CodigoProduto+',CAD.C_NOM_PRO, CAD.I_SEQ_PRO  from CADPRODUTOS CAD, MOVQDADEPRODUTO MOV '+
                                   ' Where CAD.C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S'''+
                                   ' AND MOV.I_SEQ_PRO = CAD.I_SEQ_PRO AND MOV.I_EMP_FIL = '+IntToStr(EFilial.AInteiro);

end;

{******************************************************************************}
procedure TFRelPedido.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqProduto := StrtoInt(Retorno1)
  else
    VprSeqProduto := 0;
end;

{******************************************************************************}
procedure TFRelPedido.BMostrarContaClick(Sender: TObject);
begin
  BMostrarConta.visible := false;
end;

procedure TFRelPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
      begin
        if (key = 77) then
          BMostrarConta.Visible := true;
        VprPressionadoR := false;
      end;
  end;

end;

{******************************************************************************}
procedure TFRelPedido.SpeedButton15Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFRelPedido.ECodClassifcacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    LocalizaClassificacao;

end;

{******************************************************************************}
procedure TFRelPedido.ECodClassifcacaoExit(Sender: TObject);
var
  VpfNomClassificacao : String;
begin
  if ECodClassifcacao.Text <> '' then
  begin
    if not FunClassificacao.ValidaClassificacao(ECodClassifcacao.Text,VpfNomClassificacao, 'P') then
    begin
       if not LocalizaClassificacao then
         ECodClassifcacao.SetFocus;
    end
    else
    begin
      LNomClassificacao.Caption := VpfNomClassificacao;
    end;
  end
  else
    LNomClassificacao.Caption := '';
end;

end.
