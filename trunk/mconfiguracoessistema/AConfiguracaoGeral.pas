unit AConfiguracaoGeral;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: configurações das variáveis do sistema
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/1999 / Rafael Budag
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, formularios, constMsg, DBCtrls, Tabela,
  Mask, Db, DBTables, BotaoCadastro, Buttons, Componentes1, constantes,
  ColorGrd, LabelCorMove, Grids, DBGrids, Registry, PainelGradiente,
  FileCtrl,printers, Localizacao, numericos, CBancoDados,
  DBKeyViolation, Menus, UnZebra, DBClient;

type
  TFConfiguracoesGeral = class(TFormularioPermissao)
    CFG: TSQL;
    DataCFG: TDataSource;
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    ConfigImpressora: TPrinterSetupDialog;
    localiza: TConsultaPadrao;
    kk0y: TPageControl;
    PGeral: TTabSheet;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    DBEditLocaliza2: TDBEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    DBEditLocaliza3: TDBEditLocaliza;
    SpeedButton3: TSpeedButton;
    DBRadioGroup1: TDBRadioGroup;
    GroupBox1: TGroupBox;
    Label34: TLabel;
    SpeedButton1: TSpeedButton;
    Label35: TLabel;
    DBEditLocaliza1: TDBEditLocaliza;
    DBEditColor17: TDBEditColor;
    TabSheet3: TTabSheet;
    LeitorCodigoBarras: TDBCheckBox;
    CFGI_EMP_FIL: TFMTBCDField;
    CFGI_COD_EMP: TFMTBCDField;
    CFGC_MAS_DAT: TWideStringField;
    CFGC_MAS_MOE: TWideStringField;
    CFGD_DAT_MOE: TSQLTimeStampField;
    CFGI_MOE_BAS: TFMTBCDField;
    CFGC_MOE_VAZ: TWideStringField;
    CFGI_GRU_MAS: TFMTBCDField;
    CFGI_DEC_VAL: TFMTBCDField;
    CFGI_DEC_QTD: TFMTBCDField;
    CFGC_COD_BAR: TWideStringField;
    Label32: TLabel;
    DBEditLocaliza6: TDBEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label39: TLabel;
    DBEditNumerico2: TDBEditNumerico;
    Label26: TLabel;
    DBEditNumerico3: TDBEditNumerico;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CFGC_VER_FOR: TWideStringField;
    AtualizaPermissao: TDBCheckBox;
    PDiretorios: TTabSheet;
    Label31: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    ESybase: TEditColor;
    Label27: TLabel;
    Label11: TLabel;
    EInSig: TEditColor;
    Label12: TLabel;
    Label13: TLabel;
    CFGL_ATU_IGN: TWideStringField;
    DBMemoColor1: TDBMemoColor;
    Label2: TLabel;
    DBEditLocaliza4: TDBEditLocaliza;
    Label3: TLabel;
    SpeedButton4: TSpeedButton;
    Label14: TLabel;
    CFGI_COD_USU: TFMTBCDField;
    TabSheet4: TTabSheet;
    CFGC_SER_SMT: TWideStringField;
    CFGC_USU_SMT: TWideStringField;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    Label15: TLabel;
    Label16: TLabel;
    PContratos: TTabSheet;
    EformaPgto: TDBEditLocaliza;
    Label20: TLabel;
    SpeedButton5: TSpeedButton;
    Label28: TLabel;
    Label17: TLabel;
    ECondPagamento: TDBEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label18: TLabel;
    CFaturamentoMinimo: TDBCheckBox;
    CFGI_PAG_CON: TFMTBCDField;
    CFGI_FRM_CON: TFMTBCDField;
    CFGC_FAT_MIN: TWideStringField;
    CFGC_SEN_EMA: TWideStringField;
    DBEditColor3: TDBEditColor;
    Label21: TLabel;
    CFGC_SER_POP: TWideStringField;
    Label22: TLabel;
    DBEditColor4: TDBEditColor;
    CFGI_ANO_LOC: TFMTBCDField;
    CFGI_MES_LOC: TFMTBCDField;
    DBEditColor5: TDBEditColor;
    Label23: TLabel;
    DBEditColor6: TDBEditColor;
    Label24: TLabel;
    CFGD_FIM_LOC: TSQLTimeStampField;
    Label25: TLabel;
    DBEditColor7: TDBEditColor;
    CFGC_FAT_POS: TWideStringField;
    CFaturamentoPosterior: TDBCheckBox;
    PChamado: TTabSheet;
    DBEditLocaliza12: TDBEditLocaliza;
    Label29: TLabel;
    SpeedButton13: TSpeedButton;
    Label30: TLabel;
    CFGI_EST_ICH: TFMTBCDField;
    PCotacao: TTabSheet;
    CFGC_COT_ECC: TWideStringField;
    EClientePadraoCotacao: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    Label33: TLabel;
    Label36: TLabel;
    SpeedButton9: TSpeedButton;
    Label37: TLabel;
    Label38: TLabel;
    ETipoCotacao: TEditLocaliza;
    CFGI_PRO_CON: TFMTBCDField;
    CFGC_PRO_CON: TWideStringField;
    Label40: TLabel;
    SpeedButton10: TSpeedButton;
    Label41: TLabel;
    DBEditLocaliza5: TDBEditLocaliza;
    CFGI_PES_SAA: TFMTBCDField;
    CFGI_PES_INS: TFMTBCDField;
    CFGI_CHA_INS: TFMTBCDField;
    Label42: TLabel;
    DBEditLocaliza7: TDBEditLocaliza;
    SpeedButton11: TSpeedButton;
    Label43: TLabel;
    Label44: TLabel;
    DBEditLocaliza8: TDBEditLocaliza;
    SpeedButton12: TSpeedButton;
    Label45: TLabel;
    Label46: TLabel;
    DBEditLocaliza9: TDBEditLocaliza;
    SpeedButton14: TSpeedButton;
    Label47: TLabel;
    CFGI_CON_LOC: TFMTBCDField;
    Label48: TLabel;
    ETipoContratoLocacao: TDBEditLocaliza;
    SpeedButton15: TSpeedButton;
    Label49: TLabel;
    Label50: TLabel;
    SpeedButton16: TSpeedButton;
    Label51: TLabel;
    DBEditLocaliza10: TDBEditLocaliza;
    CFGI_TEC_IND: TFMTBCDField;
    DBCheckBox1: TDBCheckBox;
    CFGC_CHA_EET: TWideStringField;
    CFGC_COT_EEE: TWideStringField;
    PCRM: TTabSheet;
    CFGC_CRM_CES: TWideStringField;
    CFGC_CRM_CCL: TWideStringField;
    CFGI_CRM_TIM: TFMTBCDField;
    DBEditColor10: TDBEditColor;
    Label54: TLabel;
    CFGI_CRM_AIM: TFMTBCDField;
    DBEditColor11: TDBEditColor;
    Label55: TLabel;
    CFGC_CON_EMA: TWideStringField;
    CFGC_CON_NOT: TWideStringField;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    CFGC_COT_TPC: TWideStringField;
    CFGI_CEN_CUS: TFMTBCDField;
    PFinanceiro: TTabSheet;
    Label56: TLabel;
    SpeedButton17: TSpeedButton;
    Label57: TLabel;
    DBEditLocaliza11: TDBEditLocaliza;
    PBalaca: TTabSheet;
    EPortaBalanca: TComboBoxColor;
    Label58: TLabel;
    ColorDialog1: TColorDialog;
    Label52: TLabel;
    SpeedButton26: TSpeedButton;
    Label53: TLabel;
    DBEditLocaliza22: TDBEditLocaliza;
    Label59: TLabel;
    SpeedButton18: TSpeedButton;
    Label60: TLabel;
    DBEditLocaliza13: TDBEditLocaliza;
    Label61: TLabel;
    SpeedButton19: TSpeedButton;
    Label62: TLabel;
    DBEditLocaliza14: TDBEditLocaliza;
    CFGI_EST_CRI: TFMTBCDField;
    CFGI_EST_CAR: TFMTBCDField;
    CFGI_EST_CRF: TFMTBCDField;
    Label63: TLabel;
    CFGC_IND_DPC: TWideStringField;
    DBCheckBox7: TDBCheckBox;
    CFGC_CON_CPC: TWideStringField;
    CFGC_EST_FAP: TWideStringField;
    CFGC_EST_TRV: TWideStringField;
    CFGC_COT_ATC: TWideStringField;
    CFGC_COT_LSP: TWideStringField;
    PCompras: TTabSheet;
    Label64: TLabel;
    SpeedButton20: TSpeedButton;
    Label65: TLabel;
    DBEditLocaliza15: TDBEditLocaliza;
    CFGI_EST_COI: TFMTBCDField;
    Label66: TLabel;
    DBEditLocaliza16: TDBEditLocaliza;
    SpeedButton21: TSpeedButton;
    Label67: TLabel;
    CFGI_EST_COA: TFMTBCDField;
    CFGC_CON_COT: TWideStringField;
    CFGC_COT_SCB: TWideStringField;
    DBCheckBox14: TDBCheckBox;
    CFGC_COT_MCN: TWideStringField;
    CFGI_EST_CRN: TFMTBCDField;
    Label68: TLabel;
    SpeedButton22: TSpeedButton;
    Label69: TLabel;
    DBEditLocaliza17: TDBEditLocaliza;
    TabSheet6: TTabSheet;
    Label70: TLabel;
    SpeedButton23: TSpeedButton;
    Label71: TLabel;
    Label72: TLabel;
    SpeedButton24: TSpeedButton;
    Label73: TLabel;
    DBEditLocaliza18: TDBEditLocaliza;
    DBEditLocaliza19: TDBEditLocaliza;
    CFGI_EST_OCI: TFMTBCDField;
    CFGI_EST_OCA: TFMTBCDField;
    CFGC_COT_TPR: TWideStringField;
    CFGI_EST_COF: TFMTBCDField;
    Label76: TLabel;
    SpeedButton27: TSpeedButton;
    Label77: TLabel;
    ESetor: TDBEditLocaliza;
    CFGI_COD_SET: TFMTBCDField;
    POrdemProducao: TTabSheet;
    Label78: TLabel;
    SpeedButton28: TSpeedButton;
    Label79: TLabel;
    EClienteDevolucao: TDBEditLocaliza;
    CFGI_ORP_ICP: TFMTBCDField;
    CFGC_COT_OGO: TWideStringField;
    DBCheckBox17: TDBCheckBox;
    CFGC_COT_ECV: TWideStringField;
    Label74: TLabel;
    SpeedButton25: TSpeedButton;
    Label75: TLabel;
    DBEditLocaliza20: TDBEditLocaliza;
    DBCheckBox19: TDBCheckBox;
    CFGC_COT_PCE: TWideStringField;
    Label80: TLabel;
    EPortaImpressora2: TComboBoxColor;
    Label81: TLabel;
    SpeedButton29: TSpeedButton;
    Label82: TLabel;
    DBEditLocaliza21: TDBEditLocaliza;
    Label83: TLabel;
    SpeedButton30: TSpeedButton;
    Label84: TLabel;
    DBEditLocaliza23: TDBEditLocaliza;
    CFGI_EST_CCR: TFMTBCDField;
    CFGI_EST_CAE: TFMTBCDField;
    DBCheckBox20: TDBCheckBox;
    CFGC_ORP_AQI: TWideStringField;
    PVendedores: TTabSheet;
    DBCheckBox21: TDBCheckBox;
    CFGC_MET_VEN: TWideStringField;
    PCliente: TTabSheet;
    CFGI_SIT_CLI: TFMTBCDField;
    Label85: TLabel;
    DBEditLocaliza24: TDBEditLocaliza;
    SpeedButton31: TSpeedButton;
    Label86: TLabel;
    DBCheckBox22: TDBCheckBox;
    CFGC_COT_PBN: TWideStringField;
    CFGI_EST_OCF: TFMTBCDField;
    Label87: TLabel;
    SpeedButton32: TSpeedButton;
    Label88: TLabel;
    DBEditLocaliza25: TDBEditLocaliza;
    CFGC_DIR_VER: TWideStringField;
    CFGC_DIR_FOT: TWideStringField;
    CFGC_DIR_REL: TWideStringField;
    CFGC_DIR_REM: TWideStringField;
    DBEditColor8: TDBEditColor;
    DBEditColor9: TDBEditColor;
    DBEditColor12: TDBEditColor;
    DBEditColor13: TDBEditColor;
    CAtualizaVersoesAutomaticamente: TCheckBox;
    CFGC_DIR_BKP: TWideStringField;
    CFGC_NOM_BKP: TWideStringField;
    Label89: TLabel;
    DBEditColor15: TDBEditColor;
    Label10: TLabel;
    DBEditColor14: TDBEditColor;
    Label90: TLabel;
    DBEditColor16: TDBEditColor;
    CFGC_DRB_SEC: TWideStringField;
    PNotaEntrada: TTabSheet;
    CFGI_FRM_NEN: TFMTBCDField;
    Label91: TLabel;
    Label92: TLabel;
    EFormapagamentoDinheiro: TDBEditLocaliza;
    SpeedButton33: TSpeedButton;
    CFGI_SET_TEC: TFMTBCDField;
    Label93: TLabel;
    SpeedButton34: TSpeedButton;
    Label94: TLabel;
    DBEditLocaliza26: TDBEditLocaliza;
    CFGI_EST_AAC: TFMTBCDField;
    Label95: TLabel;
    SpeedButton35: TSpeedButton;
    Label96: TLabel;
    DBEditLocaliza27: TDBEditLocaliza;
    DBRadioGroup2: TDBRadioGroup;
    CFGC_TIP_ORP: TWideStringField;
    EPorta1Termica: TEditColor;
    DBCheckBox23: TDBCheckBox;
    CFGC_CRM_REV: TWideStringField;
    DBCheckBox24: TDBCheckBox;
    CFGC_COT_CSC: TWideStringField;
    CFGC_ORP_PEA: TWideStringField;
    DBCheckBox25: TDBCheckBox;
    DBCheckBox26: TDBCheckBox;
    CFGC_ORP_BCE: TWideStringField;
    DBCheckBox27: TDBCheckBox;
    CFGC_COT_SPA: TWideStringField;
    CFGI_COT_QPA: TFMTBCDField;
    DBEditColor18: TDBEditColor;
    Label97: TLabel;
    CFGC_DIR_CLI: TWideStringField;
    Label98: TLabel;
    DBEditColor19: TDBEditColor;
    CFGC_ORP_AAE: TWideStringField;
    DBCheckBox28: TDBCheckBox;
    CFGC_COT_CTR: TWideStringField;
    DBCheckBox29: TDBCheckBox;
    Label99: TLabel;
    SpeedButton36: TSpeedButton;
    Label100: TLabel;
    ENatProdutoServicoFora: TDBEditLocaliza;
    CFGC_COT_NTR: TWideStringField;
    TabSheet1: TTabSheet;
    DataEmailMarketing: TDataSource;
    GEmailMarketings: TGridIndice;
    Label101: TLabel;
    Label102: TLabel;
    DBEditColor21: TDBEditColor;
    DBEditColor22: TDBEditColor;
    Label103: TLabel;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar2: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar2: TBotaoGravar;
    BotaoCancelar2: TBotaoCancelar;
    EmailMarketing: TRBSQL;
    ESeqEmail: TDBKeyViolation;
    DBRadioGroup3: TDBRadioGroup;
    CFGC_TIP_FON: TWideStringField;
    DBCheckBox16: TDBCheckBox;
    CFGC_COT_CSP: TWideStringField;
    DBCheckBox30: TDBCheckBox;
    CFGC_ORP_AET: TWideStringField;
    DBCheckBox31: TDBCheckBox;
    CFGC_CRM_PPR: TWideStringField;
    BZebra: TBitBtn;
    PopupMenu1: TPopupMenu;
    ResetaImpressora1: TMenuItem;
    ImprimeConfiguracoes1: TMenuItem;
    Reseta2Impressora1: TMenuItem;
    Label104: TLabel;
    SpeedButton37: TSpeedButton;
    Label105: TLabel;
    DBEditLocaliza28: TDBEditLocaliza;
    CFGI_DIV_VVE: TFMTBCDField;
    CFGI_HIS_VVE: TFMTBCDField;
    Label106: TLabel;
    SpeedButton38: TSpeedButton;
    Label107: TLabel;
    DBEditLocaliza29: TDBEditLocaliza;
    CFGN_ACR_TEC: TFMTBCDField;
    Label108: TLabel;
    DBEditColor20: TDBEditColor;
    Label109: TLabel;
    CFGC_EMA_COM: TWideStringField;
    Label110: TLabel;
    DBEditColor23: TDBEditColor;
    DBCheckBox32: TDBCheckBox;
    CFGC_ORP_IEA: TWideStringField;
    DBCheckBox33: TDBCheckBox;
    DBCheckBox34: TDBCheckBox;
    DBCheckBox35: TDBCheckBox;
    DBCheckBox36: TDBCheckBox;
    DBCheckBox37: TDBCheckBox;
    DBCheckBox38: TDBCheckBox;
    DBCheckBox39: TDBCheckBox;
    CFGC_CLI_OTR: TWideStringField;
    CFGC_CLI_OCP: TWideStringField;
    CFGC_CLI_OFP: TWideStringField;
    CFGC_CLI_OVE: TWideStringField;
    CFGC_CLI_OVP: TWideStringField;
    CFGC_CLI_ONC: TWideStringField;
    CFGC_CLI_OEM: TWideStringField;
    CFGI_DIA_AVC: TFMTBCDField;
    DBEditColor24: TDBEditColor;
    Label111: TLabel;
    DBCheckBox40: TDBCheckBox;
    CFGC_AUT_INT: TWideStringField;
    CFGC_OBP_PED: TWideStringField;
    DBCheckBox15: TDBCheckBox;
    DBCheckBox41: TDBCheckBox;
    CFGC_ORP_CMM: TWideStringField;
    DBCheckBox42: TDBCheckBox;
    CFGC_COT_PPP: TWideStringField;
    ScrollBox1: TScrollBox;
    CExigirCEPeCNPJCotacaoPadrao: TDBCheckBox;
    CPermanecerVendedorCotacao: TCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox18: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBEditColor25: TDBEditColor;
    Label19: TLabel;
    CFGI_COT_QME: TFMTBCDField;
    Amostra: TTabSheet;
    PanelColor2: TPanelColor;
    CFGI_COD_DEA: TFMTBCDField;
    CFGI_DIA_AMO: TFMTBCDField;
    Label112: TLabel;
    SpeedButton39: TSpeedButton;
    Label113: TLabel;
    DBEditLocaliza30: TDBEditLocaliza;
    DBEditColor26: TDBEditColor;
    Label114: TLabel;
    PNotaFiscal: TTabSheet;
    n: TPanelColor;
    DBCheckBox43: TDBCheckBox;
    CFGC_NOF_ICO: TWideStringField;
    CFGC_OBS_BOL: TWideStringField;
    DBMemoColor2: TDBMemoColor;
    PanelColor3: TPanelColor;
    DBCheckBox44: TDBCheckBox;
    CFGC_AMO_CAC: TWideStringField;
    PanelColor4: TPanelColor;
    DBEditColor27: TDBEditColor;
    CFGC_DIR_FAM: TWideStringField;
    PSolidWork: TTabSheet;
    PanelColor5: TPanelColor;
    CFGC_SOW_IMC: TWideStringField;
    DBCheckBox45: TDBCheckBox;
    CFGI_COE_PAD: TFMTBCDField;
    DBEditLocaliza31: TDBEditLocaliza;
    Label115: TLabel;
    SpeedButton40: TSpeedButton;
    Label116: TLabel;
    PanelColor6: TPanelColor;
    CFGI_LAR_BAL: TFMTBCDField;
    CFGI_ALT_BAL: TFMTBCDField;
    DBEditColor28: TDBEditColor;
    Label117: TLabel;
    Label118: TLabel;
    DBEditColor29: TDBEditColor;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    DBEditColor30: TDBEditColor;
    DBEditColor31: TDBEditColor;
    CFGI_LAR_PRE: TFMTBCDField;
    CFGI_ALT_PRE: TFMTBCDField;
    DBCheckBox46: TDBCheckBox;
    CFGC_CHA_SEC: TWideStringField;
    CFGC_COT_APG: TWideStringField;
    DBCheckBox47: TDBCheckBox;
    Label125: TLabel;
    DBEditColor32: TDBEditColor;
    CFGI_MES_SCS: TFMTBCDField;
    PanelColor7: TPanelColor;
    DBCheckBox48: TDBCheckBox;
    CFGC_AMO_FTC: TWideStringField;
    DBCheckBox49: TDBCheckBox;
    CFGC_COT_BPN: TWideStringField;
    PanelColor8: TPanelColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CFGAfterPost(DataSet: TDataSet);
    procedure DBEditLocaliza3Select(Sender: TObject);
    procedure FecharClick(Sender: TObject);
    procedure DBEditLocaliza1Retorno(Retorno1, Retorno2: String);
    procedure DBEditLocaliza1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEditNumerico2Exit(Sender: TObject);
    procedure CFGAfterScroll(DataSet: TDataSet);
    procedure DBEditLocaliza2Retorno(Retorno1, Retorno2: String);
    procedure BBAjudaClick(Sender: TObject);
    procedure CFGAfterInsert(DataSet: TDataSet);
    procedure ESybaseExit(Sender: TObject);
    procedure EBackupExit(Sender: TObject);
    procedure EInSigExit(Sender: TObject);
    procedure ERemessaBancarioExit(Sender: TObject);
    procedure ERelatoriosExit(Sender: TObject);
    procedure ECondPagamentoSelect(Sender: TObject);
    procedure EClientePadraoCotacaoFimConsulta(Sender: TObject);
    procedure CPermanecerVendedorCotacaoClick(Sender: TObject);
    procedure ETipoCotacaoFimConsulta(Sender: TObject);
    procedure DBEditLocaliza5Retorno(Retorno1, Retorno2: String);
    procedure EPortaBalancaChange(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure EPortaImpressoraChange(Sender: TObject);
    procedure EPortaImpressora2Change(Sender: TObject);
    procedure CAtualizaVersoesAutomaticamenteClick(Sender: TObject);
    procedure DBEditColor8DblClick(Sender: TObject);
    procedure EmailMarketingAfterInsert(DataSet: TDataSet);
    procedure EmailMarketingAfterPost(DataSet: TDataSet);
    procedure ResetaImpressora1Click(Sender: TObject);
    procedure ImprimeConfiguracoes1Click(Sender: TObject);
    procedure Reseta2Impressora1Click(Sender: TObject);
  private
      ini : TRegIniFile;
  public
    { Public declarations }
  end;

var
  FConfiguracoesGeral: TFConfiguracoesGeral;

implementation

uses APrincipal, FunValida, FunSql, funobjeto, funData;

{$R *.DFM}

{ |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
 |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                            Modulo Básico
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| }

{ ******************* Na Criacao do formulario ****************************** }
procedure TFConfiguracoesGeral.FormCreate(Sender: TObject);
begin
  kk0y.ActivePageIndex := 0;
  ini := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  CFG.open;
//  Drives.Text := varia.DriveFoto;
//  ERemessaBancario.Text := Varia.PathRemessaBancaria;
  CAtualizaVersoesAutomaticamente.Checked:= Config.AtualizarVersaoAutomaticamente;
  ESybase.Text := varia.PathSybase;
//  EBackup.text := varia.PathBackup;
  EInSig.text := varia.PathInSig;
  EPortaBalanca.ItemIndex := Varia.PortaComunicacaoBalanca;
  EPorta1Termica.Text := Varia.PortaComunicacaoImpTermica;
  if Varia.PortaComunicacaoImpTermica2 <> '' then
    EPortaImpressora2.ItemIndex := EPortaImpressora2.Items.IndexOf(Varia.PortaComunicacaoImpTermica2)
  else
    EPortaImpressora2.ItemIndex := -1;
  EClientePadraoCotacao.AInteiro := Varia.CodClientePadraoCotacao;
  EClientePadraoCotacao.Atualiza;
  ETipoCotacao.AInteiro := Varia.CodTipoCotacaoMaquinaLocal;
  ETipoCotacao.Atualiza;

  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'T','F');

  if not ConfigModulos.CodigoBarra then
    LeitorCodigoBarras.Enabled := false;
  EmailMarketing.open;
end;

{ ******************* No fechamento do formulário **************************** }
procedure TFConfiguracoesGeral.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CFG.close;
  EmailMarketing.close;
  ini.free;
  Action := cafree;
end;

{ *************** fecha o formulario *************************************** }
procedure TFConfiguracoesGeral.FecharClick(Sender: TObject);
begin
  Close;
end;

{ ******** codigo para liberação da alteração da moeda base CTRL+ALT+SHIF+A****}
procedure TFConfiguracoesGeral.DBEditLocaliza1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if (Shift = [ssShift, ssAlt, ssCtrl]) and (key = 65) then
begin
  DBEditLocaliza1.ReadOnly := false;
  Aviso(CT_AutorizacaoMoedaBase);
end;
end;

{ ************ Adiciona a Unidade monetária ********************************* }
procedure TFConfiguracoesGeral.DBEditLocaliza1Retorno(Retorno1,
  Retorno2: String);
begin
if retorno1 <> '' then
  CFGC_MAS_MOE.Value := retorno1;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
          configurações de Inicialização da Filial e Empresas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{ ********** Monta a select da Filial conforme empresa *********************** }
procedure TFConfiguracoesGeral.DBEditLocaliza3Select(Sender: TObject);
begin
DBEditLocaliza3.ASelectValida.Clear;
DBEditLocaliza3.ASelectValida.Add('select * from CadFiliais where I_COD_EMP = ' + DBEditLocaliza2.Text +
                              ' and I_EMP_FIL = @');
DBEditLocaliza3.ASelectLocaliza.Clear;
DBEditLocaliza3.ASelectLocaliza.Add('select * from CadFiliais where I_COD_EMP = ' + DBEditLocaliza2.Text +
                                ' and C_NOM_FIL like ''@%''');
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              configurações de Inicialização do Sistema
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ******************* Apos Gravar as alterações na tabela CFG **************** }
procedure TFConfiguracoesGeral.CFGAfterPost(DataSet: TDataSet);
begin
  CarregaCFG(FPrincipal.BaseDados);
  FPrincipal.CorFoco.AMascaraData := CFG.fieldByname('C_MAS_DAT').AsString;
  FPrincipal.AlteraNomeEmpresa;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Grava Path foto, Porta Impressora e Relatorios
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}



{*************************Grava o path do Sybase ******************************}
procedure TFConfiguracoesGeral.ESybaseExit(Sender: TObject);
begin
  ini.WriteString('DIRETORIOS','PATH_SYBASE',ESybase.Text);
  varia.PathSybase := ESybase.Text;
end;

{*************************Grava o path do Backup ******************************}
procedure TFConfiguracoesGeral.EBackupExit(Sender: TObject);
begin
{  ini.WriteString('DIRETORIOS','PATH_BACKUP',EBackup.Text);
  varia.PathBackup := EBackup.Text;}
end;

{*************************Grava o path do InSig ******************************}
procedure TFConfiguracoesGeral.EInSigExit(Sender: TObject);
begin
  ini.WriteString('DIRETORIOS','PATH_SISCORP',EInSig.Text);
  varia.PathInSig := EInSig.Text;
end;

{********* configura decimais da quantidade e valores ************************ }
procedure TFConfiguracoesGeral.DBEditNumerico2Exit(Sender: TObject);
begin
//if not((Sender as TDBEditNumerico).Field.AsInteger in [2,3]) then
//   (Sender as TDBEditNumerico).Field.AsInteger := 2;
end;

{*****************Chama a rotina para atualizar os localizas*******************}
procedure TFConfiguracoesGeral.CFGAfterScroll(DataSet: TDataSet);
begin
  AtualizaLocalizas(PanelColor1);
end;



procedure TFConfiguracoesGeral.DBEditLocaliza2Retorno(Retorno1,
  Retorno2: String);
begin
DBEditLocaliza3.Atualiza;
end;

procedure TFConfiguracoesGeral.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FConfiguracoesGeral.HelpContext);
end;

procedure TFConfiguracoesGeral.CFGAfterInsert(DataSet: TDataSet);
begin
  if ConfigModulos.CodigoBarra then
    CFGC_COD_BAR.AsString := 'N';
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.ERemessaBancarioExit(Sender: TObject);
begin
{  ini.WriteString('DIRETORIOS','PATH_REMESSABANCARIA',ERemessaBancario.Text);
  varia.PathRemessaBancaria := ERemessaBancario.Text;}
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.ERelatoriosExit(Sender: TObject);
begin
{  ini.WriteString('DIRETORIOS','PATH_RELATORIOS',ERelatorios.Text);
  varia.PathRelatorios := ERelatorios.Text;}
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.ECondPagamentoSelect(Sender: TObject);
begin
  ECondPagamento.ASelectValida.Clear;
  ECondPagamento.ASelectValida.Add(' select I_Cod_Pag, C_Nom_Pag, I_Qtd_Par From CadCondicoesPagto ' +
                                   ' where I_Cod_Pag = @ ' );
  ECondPagamento.ASelectLocaliza.Clear;
  ECondPagamento.ASelectLocaliza.add(' select I_Cod_Pag, C_Nom_Pag, I_Qtd_Par From CadCondicoesPagto ' +
                                     ' where c_Nom_Pag like ''@%'''+
                                     ' order by c_Nom_Pag asc');
end;


{******************************************************************************}
procedure TFConfiguracoesGeral.EClientePadraoCotacaoFimConsulta(
  Sender: TObject);
begin
  ini.WriteInteger('COTACAO','CLIENTEPADRAO',EClientePadraoCotacao.AInteiro);
  varia.CodClientePadraoCotacao := EClientePadraoCotacao.AInteiro;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.CPermanecerVendedorCotacaoClick(
  Sender: TObject);
begin
  ini.WriteBool('COTACAO','PERMANECERULTIMOVENDEDOR',CPermanecerVendedorCotacao.Checked);
  config.PermanecerOVendedorDaUltimaVenda := CPermanecerVendedorCotacao.Checked;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.ETipoCotacaoFimConsulta(Sender: TObject);
begin
  ini.WriteInteger('COTACAO','TIPOCOTACAO',ETipoCotacao.AInteiro);
  varia.CodTipoCotacaoMaquinaLocal := ETipoCotacao.AInteiro;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.DBEditLocaliza5Retorno(Retorno1,
  Retorno2: String);
begin
  if CFG.State = dsedit then
  begin
    if Retorno1 <> '' then
      CFGI_PRO_CON.AsString := Retorno1
    else
      CFGI_PRO_CON.Clear;
  end;
end;

procedure TFConfiguracoesGeral.EPortaBalancaChange(Sender: TObject);
begin
  ini.WriteInteger('PERIFERICOS','PORTABALANCA',EPortaBalanca.ItemIndex);
  varia.PortaComunicacaoBalanca := EPortaBalanca.ItemIndex;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.SpeedButton18Click(Sender: TObject);
begin
{  if ColorDialog1.Execute then
    CFGC_CRM_CES.AsString := formatFloat('0',ColorToRGB(ColorDialog1.Color));}
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.EPortaImpressoraChange(Sender: TObject);
begin
  ini.WriteString('PERIFERICOS','PORTAIMPTERMICA',EPorta1Termica.Text);
  varia.PortaComunicacaoImpTermica := EPorta1Termica.Text;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.EPortaImpressora2Change(Sender: TObject);
begin
  ini.WriteString('PERIFERICOS','PORTAIMPTERMICA2',EPortaImpressora2.Text);
  varia.PortaComunicacaoImpTermica2 := EPortaImpressora2.Text;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.CAtualizaVersoesAutomaticamenteClick(Sender: TObject);
var
  VpfRegistry : TRegistry;
begin
  VpfRegistry := TRegistry.Create;
  VpfRegistry.RootKey := HKEY_LOCAL_MACHINE;
  VpfRegistry.OpenKey(CT_DIRETORIOREGEDIT+'\Versoes',true);
  VpfRegistry.WriteBool('ATUALIZAAUTOMATICAMENTEVERSAO',CAtualizaVersoesAutomaticamente.Checked);
  Config.AtualizarVersaoAutomaticamente:= CAtualizaVersoesAutomaticamente.Checked;
  VpfRegistry.free;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.DBEditColor8DblClick(Sender: TObject);
var
  VpfTexto : String;
begin
  if CFG.State = dsedit then
    if Entrada('Senha','Senha Secreta :',VpfTexto,true,DBEditLocaliza2.Color,PanelColor1.color) then
    begin
      if Uppercase(VpfTexto) = 'MORRO' then
        CFGC_DIR_REL.AsString := 'D:\Eficacia\siscorp\minstalacao\relatorios';
    end;
end;

procedure TFConfiguracoesGeral.EmailMarketingAfterInsert(
  DataSet: TDataSet);
begin
  ESeqEmail.ProximoCodigo;
end;

procedure TFConfiguracoesGeral.EmailMarketingAfterPost(DataSet: TDataSet);
begin
  EmailMarketing.close;
  EmailMarketing.open;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.ResetaImpressora1Click(Sender: TObject);
var
  FunZebra : TRBFuncoesZebra;
begin
  FunZebra := TRBFuncoesZebra.cria(EPorta1Termica.Text,176,lzEPL);
  FunZebra.ResetaImpressora;
  FunZebra.free;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.ImprimeConfiguracoes1Click(Sender: TObject);
var
  FunZebra : TRBFuncoesZebra;
begin
  FunZebra := TRBFuncoesZebra.cria(EPorta1Termica.Text,176,lzEPL);
  FunZebra.ImprimeConfiguracao;
  FunZebra.free;
end;

{******************************************************************************}
procedure TFConfiguracoesGeral.Reseta2Impressora1Click(Sender: TObject);
var
  FunZebra : TRBFuncoesZebra;
begin
  FunZebra := TRBFuncoesZebra.cria(EPorta1Termica.Text,176,lzEPL);
  FunZebra.ResetaImpressora2;
  FunZebra.free;
end;

Initialization
{*****************Registra a Classe para Evitar duplicidade********************}
   RegisterClasses([TFConfiguracoesGeral]);
end.
