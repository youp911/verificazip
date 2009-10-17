unit ANovoGrupo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Tabela,
  DBKeyViolation, StdCtrls, Mask, DBCtrls, BotaoCadastro, Buttons, ComCtrls,
  DBClient, Localizacao, Grids, CGrades, UnDadosCR, UnDAdosLocaliza, unContasAReceber;

type
  TFNovoGrupo = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEditColor2: TDBEditColor;
    ECodFilial: TDBEditColor;
    CadGrupos: TSQL;
    CadGruposI_EMP_FIL: TFMTBCDField;
    CadGruposI_COD_GRU: TFMTBCDField;
    CadGruposC_NOM_GRU: TWideStringField;
    CadGruposD_ULT_ALT: TSQLTimeStampField;
    DataCadGrupos: TDataSource;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    CadGruposC_ADM_SIS: TWideStringField;
    CadGruposC_FIN_COM: TWideStringField;
    CadGruposC_EST_COM: TWideStringField;
    CadGruposC_POL_COM: TWideStringField;
    CadGruposC_FAT_COM: TWideStringField;
    CadGruposC_FIN_CCR: TWideStringField;
    CadGruposC_FIN_BCR: TWideStringField;
    CadGruposC_FIN_CCP: TWideStringField;
    CadGruposC_FIN_BCP: TWideStringField;
    CadGruposC_POL_IPP: TWideStringField;
    CadGruposC_GER_COC: TWideStringField;
    CadGruposC_GER_MPR: TWideStringField;
    CadGruposC_POL_CCO: TWideStringField;
    CadGruposC_POL_ACO: TWideStringField;
    CadGruposC_POL_VCO: TWideStringField;
    CadGruposC_POL_ICO: TWideStringField;
    CadGruposC_POL_CGN: TWideStringField;
    CadGruposC_POL_CGC: TWideStringField;
    CadGruposC_GER_MCP: TWideStringField;
    CadGruposC_GER_MCC: TWideStringField;
    CadGruposC_GER_MCS: TWideStringField;
    CadGruposC_GER_IMP: TWideStringField;
    CadGruposC_GER_REL: TWideStringField;
    CadGruposC_POL_UTE: TWideStringField;
    CadGruposC_POL_STE: TWideStringField;
    CadGruposC_GER_SPA: TWideStringField;
    CadGruposC_GER_SMP: TWideStringField;
    CadGruposC_GER_PRV: TWideStringField;
    CadGruposC_GER_PRC: TWideStringField;
    CadGruposC_EST_COP: TWideStringField;
    CadGruposC_FAT_MNO: TWideStringField;
    CadGruposC_FAT_GNO: TWideStringField;
    CadGruposC_EST_AOP: TWideStringField;
    CadGruposC_EST_EOP: TWideStringField;
    CadGruposC_CHA_COM: TWideStringField;
    CadGruposC_CHA_CBA: TWideStringField;
    CadGruposC_CHA_CAC: TWideStringField;
    CadGruposC_CHA_COC: TWideStringField;
    CadGruposC_CHA_GEC: TWideStringField;
    CadGruposC_CHA_ATC: TWideStringField;
    CadGruposC_CHA_ACF: TWideStringField;
    CadGruposC_POL_ECO: TWideStringField;
    CadGruposC_POL_AEF: TWideStringField;
    CadGruposC_EST_ROM: TWideStringField;
    CadGruposC_EST_CFA: TWideStringField;
    CadGruposC_EST_AFF: TWideStringField;
    CadGruposC_EST_CFF: TWideStringField;
    CadGruposC_EST_EFF: TWideStringField;
    CadGruposC_EST_ARF: TWideStringField;
    CadGruposC_EST_CRF: TWideStringField;
    CadGruposC_EST_ERF: TWideStringField;
    CadGruposC_IND_PER: TWideStringField;
    CadGruposC_RES_LEL: TWideStringField;
    CadGruposC_FIN_CPO: TWideStringField;
    CadGruposC_CRM_COM: TWideStringField;
    CadGruposC_IND_SCV: TWideStringField;
    CadGruposC_POL_CAC: TWideStringField;
    CadGruposC_FIN_ECO: TWideStringField;
    CadGruposC_POL_ATC: TWideStringField;
    CadGruposC_EST_CNF: TWideStringField;
    CadGruposC_EST_MNF: TWideStringField;
    CadGruposC_EST_IEP: TWideStringField;
    CadGruposC_CRM_SPV: TWideStringField;
    CadGruposC_EST_PEC: TWideStringField;
    CadGruposC_FIN_BCL: TWideStringField;
    CadGruposC_GER_VAC: TWideStringField;
    CadGruposC_EST_SCO: TWideStringField;
    CadGruposC_POL_PIP: TWideStringField;
    CadGruposC_POL_IVP: TWideStringField;
    PanelColor4: TPanelColor;
    PageControl1: TPageControl;
    PGeral: TTabSheet;
    CAdministrador: TDBCheckBox;
    CConsultaCliente: TDBCheckBox;
    CManutencaoProdutos: TDBCheckBox;
    CProdutoCompleto: TDBCheckBox;
    CServicoCompleto: TDBCheckBox;
    CImpressao: TDBCheckBox;
    CClienteCompleto: TDBCheckBox;
    CRelatorios: TDBCheckBox;
    CSomenteProdutos: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox34: TDBCheckBox;
    DBCheckBox35: TDBCheckBox;
    DBCheckBox38: TDBCheckBox;
    DBCheckBox48: TDBCheckBox;
    PFinanceiro: TTabSheet;
    CCompletoFinanceiro: TDBCheckBox;
    CCadastrarCR: TDBCheckBox;
    CBaixarCR: TDBCheckBox;
    CCadastrarCP: TDBCheckBox;
    CBaixarCP: TDBCheckBox;
    DBCheckBox36: TDBCheckBox;
    DBCheckBox40: TDBCheckBox;
    DBCheckBox47: TDBCheckBox;
    PPontodeLoja: TTabSheet;
    CCompletoPontoLoja: TDBCheckBox;
    CImprimirPedPendentes: TDBCheckBox;
    CCadastraCotacao: TDBCheckBox;
    CConsultaCotacao: TDBCheckBox;
    CAlteraCotacao: TDBCheckBox;
    CImprimiCotacao: TDBCheckBox;
    CGerarNota: TDBCheckBox;
    CGerarCupom: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    CUsuarioTelemarketing: TDBCheckBox;
    CSupervisorTelemarketing: TDBCheckBox;
    DBCheckBox15: TDBCheckBox;
    DBCheckBox16: TDBCheckBox;
    DBCheckBox39: TDBCheckBox;
    DBCheckBox41: TDBCheckBox;
    DBCheckBox50: TDBCheckBox;
    DBCheckBox51: TDBCheckBox;
    PFaturamento: TTabSheet;
    CCompletoFaturamento: TDBCheckBox;
    CFatGerarNotaFiscal: TDBCheckBox;
    CFatManutencaoNotas: TDBCheckBox;
    PEstoque: TTabSheet;
    CCompletoEstoque: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox17: TDBCheckBox;
    DBCheckBox18: TDBCheckBox;
    DBCheckBox19: TDBCheckBox;
    DBCheckBox20: TDBCheckBox;
    DBCheckBox21: TDBCheckBox;
    ScrollBox1: TScrollBox;
    PanelColor3: TPanelColor;
    DBCheckBox22: TDBCheckBox;
    DBCheckBox23: TDBCheckBox;
    DBCheckBox24: TDBCheckBox;
    DBCheckBox25: TDBCheckBox;
    DBCheckBox26: TDBCheckBox;
    DBCheckBox27: TDBCheckBox;
    DBCheckBox28: TDBCheckBox;
    DBCheckBox29: TDBCheckBox;
    DBCheckBox30: TDBCheckBox;
    DBCheckBox31: TDBCheckBox;
    DBCheckBox32: TDBCheckBox;
    DBCheckBox33: TDBCheckBox;
    DBCheckBox42: TDBCheckBox;
    DBCheckBox43: TDBCheckBox;
    DBCheckBox44: TDBCheckBox;
    DBCheckBox46: TDBCheckBox;
    DBCheckBox49: TDBCheckBox;
    TabSheet1: TTabSheet;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox14: TDBCheckBox;
    PCRM: TTabSheet;
    DBCheckBox37: TDBCheckBox;
    DBCheckBox45: TDBCheckBox;
    DBCheckBox52: TDBCheckBox;
    CadGruposC_EST_PCO: TWideStringField;
    DBCheckBox53: TDBCheckBox;
    CadGruposC_CRM_CSP: TWideStringField;
    DBCheckBox54: TDBCheckBox;
    DBCheckBox55: TDBCheckBox;
    CadGruposC_EST_CLP: TWideStringField;
    CadGruposC_EST_RPC: TWideStringField;
    DBCheckBox56: TDBCheckBox;
    CadGruposC_EST_ACE: TWideStringField;
    DBCheckBox57: TDBCheckBox;
    DBCheckBox58: TDBCheckBox;
    CadGruposC_EST_APC: TWideStringField;
    CadGruposC_EST_EPC: TWideStringField;
    DBCheckBox59: TDBCheckBox;
    CadGruposC_EST_MGE: TWideStringField;
    DBCheckBox60: TDBCheckBox;
    CadGruposC_EST_OCO: TWideStringField;
    DBCheckBox61: TDBCheckBox;
    CadGruposC_EST_RGP: TWideStringField;
    ECodigo: TDBKeyViolation;
    DBCheckBox62: TDBCheckBox;
    DBCheckBox63: TDBCheckBox;
    CadGruposC_POL_PSP: TWideStringField;
    CadGruposC_POL_PCP: TWideStringField;
    DBCheckBox64: TDBCheckBox;
    CadGruposC_POL_ECP: TWideStringField;
    CadGruposC_FAT_CNO: TWideStringField;
    DBCheckBox65: TDBCheckBox;
    CadGruposC_POL_IPE: TWideStringField;
    CadGruposC_COD_CLA: TWideStringField;
    CadGruposI_COD_FIL: TFMTBCDField;
    Label4: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditLocaliza1: TDBEditLocaliza;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    Label6: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    PCondicaoPagamento: TTabSheet;
    GCondicaoPagamento: TRBStringGridColor;
    ECondicaoPagamento: TRBEditLocaliza;
    DBCheckBox66: TDBCheckBox;
    CadGruposC_GER_COP: TWideStringField;
    DBCheckBox67: TDBCheckBox;
    CadGruposC_EST_CAC: TWideStringField;
    DBCheckBox68: TDBCheckBox;
    CadGruposC_EST_RES: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadGruposAfterInsert(DataSet: TDataSet);
    procedure CadGruposBeforePost(DataSet: TDataSet);
    procedure CadGruposAfterEdit(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure ECodGrupoChange(Sender: TObject);
    procedure GCondicaoPagamentoCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GCondicaoPagamentoDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure ECondicaoPagamentoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GCondicaoPagamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GCondicaoPagamentoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GCondicaoPagamentoNovaLinha(Sender: TObject);
    procedure GCondicaoPagamentoSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CadGruposAfterPost(DataSet: TDataSet);
    procedure CadGruposAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    VprCondicoesPagamento : TList;
    VprDCondicaoPagamento : TRBDCondicaoPagamentoGrupoUsuario;
    procedure CarTitulosGrade;
  public
    { Public declarations }
  end;

var
  FNovoGrupo: TFNovoGrupo;

implementation

uses APrincipal, AGrupos,Constantes, FunObjeto, Constmsg;

{$R *.DFM}


{ ****************** Na cria��o do Formul�rio ******************************** }
procedure TFNovoGrupo.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualiza��o de menus }
  VprCondicoesPagamento := TList.Create;
  GCondicaoPagamento.ADados := VprCondicoesPagamento;
  GCondicaoPagamento.CarregaGrade;
  PageControl1.ActivePageIndex := 0;
  CadGrupos.open;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor4,'T','F');
  CarTitulosGrade;
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCondicaoPagamento := TRBDCondicaoPagamentoGrupoUsuario(VprCondicoesPagamento.Items[VpaLinha-1]);
  if VprDCondicaoPagamento.CodCondicao <> 0 then
    GCondicaoPagamento.Cells[1,VpaLinha]:= InttoStr(VprDCondicaoPagamento.CodCondicao)
  else
    GCondicaoPagamento.Cells[1,VpaLinha]:= '';
  GCondicaoPagamento.Cells[2,VpaLinha]:= VprDCondicaoPagamento.NomCondicao;
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ECondicaoPagamento.AExisteCodigo(GCondicaoPagamento.Cells[1,GCondicaoPagamento.ALinha]) then
  begin
    VpaValidos := false;
    aviso('MARCA N�O CADASTRADA!!!'#13'A marca digitada n�o existe cadastrada.');
    GCondicaoPagamento.Col := 1;
  end;
  if Vpavalidos then
  begin
    if FunContasAReceber.CondicaoPagamentoDuplicada(VprCondicoesPagamento) then
    begin
      VpaValidos := false;
      aviso('CONDI��O PAGAMENTO DUPLICADA!!!'#13'Essa condi��o de pagamento j� foi digitada.');
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case GCondicaoPagamento.AColuna of
        1: ECondicaoPagamento.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprCondicoesPagamento.Count >0 then
  begin
    VprDCondicaoPagamento := TRBDCondicaoPagamentoGrupoUsuario(VprCondicoesPagamento.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoNovaLinha(Sender: TObject);
begin
  VprDCondicaoPagamento := TRBDCondicaoPagamentoGrupoUsuario.cria;
  VprCondicoesPagamento.add(VprDCondicaoPagamento);
end;

{******************************************************************************}
procedure TFNovoGrupo.GCondicaoPagamentoSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GCondicaoPagamento.AEstadoGrade in [egInsercao,EgEdicao] then
    if GCondicaoPagamento.AColuna <> ACol then
    begin
      case GCondicaoPagamento.AColuna of
        1 :if not ECondicaoPagamento.AExisteCodigo(GCondicaoPagamento.Cells[1,GCondicaoPagamento.ALinha]) then
           begin
             if not ECondicaoPagamento.AAbreLocalizacao then
             begin
               GCondicaoPagamento.Cells[1,GCondicaoPagamento.ALinha] := '';
               abort;
             end;
           end;
      end;
    end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoGrupo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualiza��o de menus }
  CadGrupos.Close;
  FreeTObjectsList(VprCondicoesPagamento);
  VprCondicoesPagamento.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            A��es Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoGrupo.CadGruposAfterInsert(DataSet: TDataSet);
begin
  CadGruposI_EMP_FIL.AsInteger := Varia.CodigoEmpFil;
  ECodigo.Proximocodigo;
  InicializaCheckBox(PanelColor4,'F');
end;

procedure TFNovoGrupo.CadGruposAfterPost(DataSet: TDataSet);
var
  VpfResultado : String;
begin
  VpfResultado := FunContasAReceber.GravaDCondicaoPagamentoGrupoUsuario(CadGruposI_COD_GRU.AsInteger,VprCondicoesPagamento);
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoGrupo.CadGruposAfterScroll(DataSet: TDataSet);
begin
  if VprCondicoesPagamento <> nil then
  begin
    FunContasAReceber.CarDCondicaoPagamentoGrupoUsuario(CadGruposI_COD_GRU.AsInteger,VprCondicoesPagamento);
    GCondicaoPagamento.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFNovoGrupo.CadGruposBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadGruposD_ULT_ALT.AsDateTime := Date;
  if CadGrupos.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFNovoGrupo.CadGruposAfterEdit(DataSet: TDataSet);
begin
end;

{******************************************************************************}
procedure TFNovoGrupo.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoGrupo.ECodGrupoChange(Sender: TObject);
begin
  if (CadGrupos.State in [dsinsert,dsedit]) then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoGrupo.ECondicaoPagamentoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDCondicaoPagamento.CodCondicao := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDCondicaoPagamento.NomCondicao := VpaColunas.items[1].AValorRetorno;
    GCondicaoPagamento.Cells[1,GCondicaoPagamento.ALinha] := VpaColunas.items[0].AValorRetorno;
    GCondicaoPagamento.Cells[2,GCondicaoPagamento.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDCondicaoPagamento.CodCondicao := 0;
    VprDCondicaoPagamento.NomCondicao := '';
  end;

end;

{******************************************************************************}
procedure TFNovoGrupo.CarTitulosGrade;
begin
  GCondicaoPagamento.Cells[1,0] := 'C�digo';
  GCondicaoPagamento.Cells[2,0] := 'Condi��o Pagamento';
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoGrupo]);
end.
