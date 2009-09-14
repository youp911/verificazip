unit AConfiguracaoFilial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Buttons, StdCtrls, Mask,
  DBCtrls, Tabela, Localizacao, Db, DBTables, ComCtrls, BotaoCadastro, DBClient;

type
  TFConfiguracaoFilial = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    PageControl: TPageControl;
    PCotacao: TTabSheet;
    DataFiliais: TDataSource;
    localiza: TConsultaPadrao;
    CadFiliais: TSQL;
    PProduto: TTabSheet;
    CCondicaoPagamentoCotacao: TDBCheckBox;
    CadFiliaisC_FIN_COT: TWideStringField;
    CodigoTabela: TDBEditLocaliza;
    ETabelaServico: TDBEditLocaliza;
    CadFiliaisI_COD_TAB: TFMTBCDField;
    CadFiliaisI_TAB_SER: TFMTBCDField;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    CadFiliaisI_COD_EMP: TFMTBCDField;
    CExcluiFinaceiroCotacao: TDBCheckBox;
    CadFiliaisC_EXC_FIC: TWideStringField;
    CRegerarFinanceiroQuandoAltera: TDBCheckBox;
    CadFiliaisC_FIN_ACO: TWideStringField;
    PFinanceiro: TTabSheet;
    EContaPadrao: TDBEditLocaliza;
    Label29: TLabel;
    SpeedButton4: TSpeedButton;
    Label38: TLabel;
    CadFiliaisC_CON_BAN: TWideStringField;
    CadFiliaisC_CON_BOL: TWideStringField;
    Label17: TLabel;
    SpeedButton11: TSpeedButton;
    Label18: TLabel;
    EContaBoletoPadrao: TDBEditLocaliza;
    TabSheet1: TTabSheet;
    CEmiteECF: TDBCheckBox;
    CadFiliaisC_IND_ECF: TWideStringField;
    CCorFiscal: TDBCheckBox;
    CadFiliaisC_EST_FIS: TWideStringField;
    PFiscal: TTabSheet;
    CadFiliaisN_PER_ISQ: TFMTBCDField;
    DBEditColor1: TDBEditColor;
    Label5: TLabel;
    PContratos: TTabSheet;
    DBEditLocaliza1: TDBEditLocaliza;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    CadFiliaisC_CON_CON: TWideStringField;
    CadFiliaisN_VAL_CHA: TFMTBCDField;
    CadFiliaisN_VAL_DKM: TFMTBCDField;
    PAssistenciaTecnica: TTabSheet;
    EValChamado: TDBEditNumerico;
    EValKM: TDBEditNumerico;
    Label8: TLabel;
    Label9: TLabel;
    CadFiliaisC_IND_CLA: TWideStringField;
    CUtilizarClassificacao: TDBCheckBox;
    CadFiliaisC_IND_NSU: TWideStringField;
    DBCheckBox2: TDBCheckBox;
    CadFiliaisC_SIM_FED: TWideStringField;
    PCRM: TTabSheet;
    Label10: TLabel;
    DBEditColor2: TDBEditColor;
    DBMemoColor1: TDBMemoColor;
    CadFiliaisC_EMA_COM: TWideStringField;
    CadFiliaisL_ROD_EMA: TWideStringField;
    Label11: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    DBEditColor8: TDBEditColor;
    DBEditColor9: TDBEditColor;
    CadFiliaisC_CRM_CES: TWideStringField;
    CadFiliaisC_CRM_CCL: TWideStringField;
    DBCheckBox3: TDBCheckBox;
    CadFiliaisC_COB_FRM: TWideStringField;
    DBCheckBox4: TDBCheckBox;
    CadFiliaisC_COT_BEC: TWideStringField;
    CadFiliaisC_COT_COM: TWideStringField;
    DBCheckBox5: TDBCheckBox;
    DBEditColor3: TDBEditColor;
    Label12: TLabel;
    CadFiliaisC_SEN_EMC: TWideStringField;
    TabSheet2: TTabSheet;
    CadFiliaisL_OBS_COM: TWideStringField;
    DBMemoColor2: TDBMemoColor;
    Label13: TLabel;
    CadFiliaisC_CAB_EMA: TWideStringField;
    CadFiliaisC_MEI_EMA: TWideStringField;
    DBMemoColor3: TDBMemoColor;
    Label14: TLabel;
    DBMemoColor4: TDBMemoColor;
    Label15: TLabel;
    CadFiliaisN_PER_CSS: TFMTBCDField;
    DBEditColor5: TDBEditColor;
    CadFiliaisC_DIR_ECF: TWideStringField;
    Label19: TLabel;
    PNFE: TTabSheet;
    GroupBox4: TGroupBox;
    Label20: TLabel;
    DBComboBoxColor1: TDBComboBoxColor;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    CadFiliaisC_UFD_NFE: TWideStringField;
    CadFiliaisC_AMH_NFE: TWideStringField;
    CadFiliaisC_MOM_NFE: TWideStringField;
    RDANFE: TDBRadioGroup;
    DBEditColor6: TDBEditColor;
    Label21: TLabel;
    CadFiliaisC_DAN_NFE: TWideStringField;
    CadFiliaisC_CER_NFE: TWideStringField;
    CadFiliaisC_IND_NFE: TWideStringField;
    DBCheckBox8: TDBCheckBox;
    ENotaPAdrao: TDBEditLocaliza;
    Label23: TLabel;
    SpeedButton5: TSpeedButton;
    Label24: TLabel;
    DBMemoColor5: TDBMemoColor;
    Label25: TLabel;
    CadFiliaisC_DAD_ADI: TWideStringField;
    CadFiliaisC_TEX_RED: TWideStringField;
    DBMemoColor6: TDBMemoColor;
    Label26: TLabel;
    DBEditColor10: TDBEditColor;
    Label27: TLabel;
    DBEditColor11: TDBEditColor;
    Label28: TLabel;
    CadFiliaisC_SER_NOT: TWideStringField;
    CadFiliaisC_SER_SER: TWideStringField;
    PanelColor2: TPanelColor;
    DBCheckBox1: TDBCheckBox;
    Label16: TLabel;
    DBEditColor4: TDBEditColor;
    CadFiliaisI_DOC_NOT: TFMTBCDField;
    DBCheckBox10: TDBCheckBox;
    CadFiliaisC_NOT_CON: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FecharClick(Sender: TObject);
    procedure CodigoTabelaSelect(Sender: TObject);
    procedure ETabelaServicoSelect(Sender: TObject);
    procedure EContaPadraoSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConfiguracaoFilial: TFConfiguracaoFilial;

implementation

uses APrincipal, FunSql, Constantes,funobjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConfiguracaoFilial.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AdicionaSQLAbreTabela(CadFiliais,'Select * from CADFILIAIS '+
                                    ' Where I_EMP_FIL = '+ IntToStr(varia.CodigoEmpFil));
  PageControl.ActivePageIndex := 0;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'T','F');
  AtualizaLocalizas([ETabelaServico,CodigoTabela,EContaPadrao,EContaBoletoPadrao]);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConfiguracaoFilial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CadFiliais.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFConfiguracaoFilial.FecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConfiguracaoFilial.CodigoTabelaSelect(Sender: TObject);
begin
  CodigoTabela.ASelectValida.Clear;
  CodigoTabela.ASelectValida.Add(' select I_cod_tab, c_nom_tab  from cadtabelapreco ' +
                                  ' where i_cod_emp = ' + CadFiliais.fieldByname('i_cod_emp').asstring +
                                  ' and i_cod_tab = @' );
  CodigoTabela.ASelectLocaliza.Clear;
  CodigoTabela.ASelectLocaliza.Add(' select I_cod_tab, c_nom_tab  from cadtabelapreco '+
                                    ' where i_cod_emp = ' + CadFiliais.fieldByname('i_cod_emp').asstring +
                                    ' and i_cod_tab like ''@%''');
end;

{******************************************************************************}
procedure TFConfiguracaoFilial.ETabelaServicoSelect(Sender: TObject);
begin
  ETabelaServico.ASelectValida.Clear;
  ETabelaServico.ASelectValida.Add(' select I_cod_tab, c_nom_tab  from cadtabelapreco ' +
                                  ' where i_cod_emp = ' + CadFiliais.fieldByname('i_cod_emp').asstring +
                                  ' and i_cod_tab = @' );
  ETabelaServico.ASelectLocaliza.Clear;
  ETabelaServico.ASelectLocaliza.Add(' select I_cod_tab, c_nom_tab from cadtabelapreco '+
                                    ' where i_cod_emp = ' + CadFiliais.fieldByname('i_cod_emp').asstring +
                                    ' and i_cod_tab like ''@%''');
end;

procedure TFConfiguracaoFilial.EContaPadraoSelect(Sender: TObject);
begin

  TDBEditLocaliza(sender).ASelectLocaliza.Text := 'Select * from cadbancos Ban, CadContas Co'+
                                       ' where  Ban.I_COD_BAN = Co.I_COD_BAN  '+
                                       ' and CO.I_EMP_FIL = '+IntTostr(varia.CodigoempFil)+
                                       ' and Co.C_NRO_CON like ''@%'''+
                                       ' AND CO.C_IND_ATI = ''T''';
  TDBEditLocaliza(sender).ASelectValida.Text := 'Select * from cadbancos Ban, CadContas Co'+
                                       ' where  Ban.I_COD_BAN = Co.I_COD_BAN  '+
                                       ' and CO.I_EMP_FIL = '+IntTostr(varia.CodigoempFil)+
                                       ' and Co.C_NRO_CON = ''@'''+
                                       ' AND CO.C_IND_ATI = ''T''';

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConfiguracaoFilial]);
end.
