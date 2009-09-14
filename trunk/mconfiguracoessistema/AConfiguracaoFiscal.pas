unit AConfiguracaoFiscal;
{  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/199 / Rafael Budag
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, formularios, constMsg, DBCtrls, Tabela,
  Mask, Db, DBTables, BotaoCadastro, Buttons, Componentes1, constantes,
  ColorGrd, LabelCorMove, Grids, DBGrids, Registry, PainelGradiente,
  Localizacao, UnImpressao, DBClient, FMTBcd, SqlExpr;

type
  TFConfiguracoesFiscal = class(TFormularioPermissao)
    CFG: TSQL;
    DataCFG: TDataSource;
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    localiza: TConsultaPadrao;
    kk0y: TPageControl;
    DataNumeroSerie: TDataSource;
    CadNumeroSerie: TSQL;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    CFGC_PAT_ECF: TWideStringField;
    CFGC_EST_ICM: TWideStringField;
    CFGL_TEX_PRO: TWideStringField;
    CFGN_DES_NOT: TFMTBCDField;
    CFGC_ALT_VLR: TWideStringField;
    CFGC_DES_NOT: TWideStringField;
    CFGC_OPE_ECF: TFMTBCDField;
    CFGN_PER_ISQ: TFMTBCDField;
    CFGC_SER_NOT: TWideStringField;
    CFGC_SEN_ALT: TWideStringField;
    Label20: TLabel;
    DBComboBoxUF1: TDBComboBoxUF;
    Aux: TSQLQuery;
    RComPro: TDBRadioGroup;
    RComSer: TDBRadioGroup;
    CFGI_COM_PRO: TFMTBCDField;
    CFGI_COM_SER: TFMTBCDField;
    TabSheet4: TTabSheet;
    CFGC_PLA_ECF: TWideStringField;
    CFGI_DES_MAI: TFMTBCDField;
    TabSheet5: TTabSheet;
    GroupBox6: TGroupBox;
    Label40: TLabel;
    Label41: TLabel;
    ECSenhaLiberacao: TEditColor;
    ECConfirmaSenha: TEditColor;
    Label42: TLabel;
    DBEditColor14: TDBEditColor;
    DBRadioGroup1: TDBRadioGroup;
    DCAltVlrUniNot: TDBCheckBox;
    DCDescontoNota: TDBCheckBox;
    DCAlterarVrlUnitario: TDBCheckBox;
    CFGI_BOL_PAD: TFMTBCDField;
    Boleto: TSQL;
    DataBoleto: TDataSource;
    DadosBoleto: TSQL;
    DataDadosBoleto: TDataSource;
    CFGI_DAD_BOL: TFMTBCDField;
    CFGC_USA_TEF: TWideStringField;
    Label12: TLabel;
    Label15: TLabel;
    DBEditLocaliza2: TDBEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label13: TLabel;
    DBEditLocaliza3: TDBEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    CFGc_cli_cup: TWideStringField;
    CFGI_LAY_ECF: TFMTBCDField;
    CFGI_FON_ECF: TFMTBCDField;
    Sintegra: TEditColor;
    Label32: TLabel;
    CFGC_COD_NAT: TWideStringField;
    CFGC_NAT_NOT: TWideStringField;
    CFGC_NOT_CUP: TWideStringField;
    CFGC_NAT_DEV: TWideStringField;
    CFGI_FRE_NOT: TFMTBCDField;
    Checkbox11: TDBCheckBox;
    CFGC_NRO_NOT: TWideStringField;
    DBEditColor1: TDBEditColor;
    Label34: TLabel;
    DBEditColor2: TDBEditColor;
    Label35: TLabel;
    CFGN_PER_PIS: TFMTBCDField;
    CFGN_PER_COF: TFMTBCDField;
    CAlteraNroNF: TDBCheckBox;
    CFGC_ALT_VNF: TWideStringField;
    PDadosPadraoNota: TTabSheet;
    DBEditLocaliza8: TDBEditLocaliza;
    Label50: TLabel;
    SpeedButton9: TSpeedButton;
    Label49: TLabel;
    Label5: TLabel;
    DBLookupComboBoxColor1: TDBLookupComboBoxColor;
    DBRadioGroup3: TDBRadioGroup;
    Label33: TLabel;
    CFGC_PLA_VEI: TWideStringField;
    DBEditColor3: TDBEditColor;
    Label36: TLabel;
    CItemDuplicadoNFSaida: TDBCheckBox;
    CFGC_DUP_PNF: TWideStringField;
    CFGC_PED_PRE: TWideStringField;
    Label37: TLabel;
    SpeedButton10: TSpeedButton;
    Label38: TLabel;
    DBEditLocaliza5: TDBEditLocaliza;
    DBEditColor4: TDBEditColor;
    Label39: TLabel;
    CFGC_MAR_PRO: TWideStringField;
    CFGI_COD_TRA: TFMTBCDField;
    CFGI_PED_PAD: TFMTBCDField;
    CFGC_TRA_PED: TWideStringField;
    DBEditLocaliza9: TDBEditLocaliza;
    Label53: TLabel;
    SpeedButton12: TSpeedButton;
    Label54: TLabel;
    CFGC_NAT_FOE: TWideStringField;
    CNotaPorFilial: TDBCheckBox;
    CFGC_NNF_FIL: TWideStringField;
    CFGC_VER_DEV: TWideStringField;
    TabSheet7: TTabSheet;
    DBCheckBox2: TDBCheckBox;
    Label47: TLabel;
    SpeedButton11: TSpeedButton;
    Label52: TLabel;
    DBEditLocaliza6: TDBEditLocaliza;
    DBCheckBox1: TDBCheckBox;
    CObservacaoPedido: TDBCheckBox;
    CFGC_OBS_PED: TWideStringField;
    CImprimeCotacaoNaNota: TDBCheckBox;
    CFGC_IMP_NOR: TWideStringField;
    Label6: TLabel;
    CFGI_FOR_EXP: TFMTBCDField;
    EFormatoExportacao: TComboBoxColor;
    TabSheet8: TTabSheet;
    DBEditColor5: TDBEditColor;
    Label55: TLabel;
    CFGI_CCO_FOR: TFMTBCDField;
    CFGI_CCO_CLI: TFMTBCDField;
    Label56: TLabel;
    DBEditColor6: TDBEditColor;
    ENaturezaServico: TDBEditLocaliza;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label7: TLabel;
    CFGC_NAT_SER: TWideStringField;
    CFGC_NAT_PSE: TWideStringField;
    CFGC_NAT_PSF: TWideStringField;
    Label8: TLabel;
    ENaturezaProdutoServico: TDBEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label10: TLabel;
    Label14: TLabel;
    ENatProdutoServicoFora: TDBEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label17: TLabel;
    CMediaProduto: TDBCheckBox;
    CFGC_MED_PRO: TWideStringField;
    GroupBox4: TGroupBox;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoExcluir1: TBotaoExcluir;
    DBGridColor1: TDBGridColor;
    BotaoGravar2: TBotaoGravar;
    BotaoCancelar2: TBotaoCancelar;
    DBCheckBox3: TDBCheckBox;
    CFGC_SEN_DES: TWideStringField;
    CFGC_SEN_LIB: TWideStringField;
    CFGC_INF_INO: TWideStringField;
    DBCheckBox4: TDBCheckBox;
    CFGC_NAT_FSE: TWideStringField;
    Label18: TLabel;
    DBEditLocaliza1: TDBEditLocaliza;
    SpeedButton8: TSpeedButton;
    Label19: TLabel;
    Label21: TLabel;
    DBEditColor7: TDBEditColor;
    CFGN_VAL_MFA: TFMTBCDField;
    CFGI_CLI_EXP: TFMTBCDField;
    Label22: TLabel;
    DBEditColor8: TDBEditColor;
    CMostrarProdutosDevolvidos: TDBCheckBox;
    CFGC_TEX_RIC: TWideStringField;
    Label23: TLabel;
    DBMemoColor1: TDBMemoColor;
    DBCheckBox5: TDBCheckBox;
    CFGC_VOL_OBR: TWideStringField;
    CFGC_CNF_ESC: TWideStringField;
    DBCheckBox6: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEditLocaliza2Retorno(Retorno1, Retorno2: String);
    procedure FecharClick(Sender: TObject);
    procedure mascaraProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure mascaraExit(Sender: TObject);
    procedure mascaraKeyPress(Sender: TObject; var Key: Char);
    procedure DBMemoColor2KeyPress(Sender: TObject; var Key: Char);
    procedure DelHistoricoPadraoCadastrar(Sender: TObject);
    procedure CFGAfterScroll(DataSet: TDataSet);
    procedure CadNumeroSerieAfterPost(DataSet: TDataSet);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure RComProChange(Sender: TObject);
    procedure ECSenhaLiberacaoEnter(Sender: TObject);
    procedure ECSenhaLiberacaoExit(Sender: TObject);
    procedure ECConfirmaSenhaExit(Sender: TObject);
    procedure SintegraExit(Sender: TObject);
    procedure CadNumeroSerieBeforePost(DataSet: TDataSet);
    procedure EFormatoExportacaoClick(Sender: TObject);
    procedure CFGAfterEdit(DataSet: TDataSet);
    procedure CFGAfterPost(DataSet: TDataSet);
    procedure CFGAfterCancel(DataSet: TDataSet);
  private
      UnImp : TFuncoesImpressao;
      procedure AlteraSenha;

  public
    { Public declarations }
  end;

var
  FConfiguracoesFiscal: TFConfiguracoesFiscal;

implementation

uses APrincipal, FunValida, FunSql, funobjeto, APlanoConta, AItensNatureza;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Modulo Básico
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ******************* Na Criacao do formulario ****************************** }
procedure TFConfiguracoesFiscal.FormCreate(Sender: TObject);
begin
   CFG.open;

   InicializaVerdadeiroeFalsoCheckBox(PanelColor1, 'T', 'F');

   UnImp := TFuncoesImpressao.criar(self,FPrincipal.BaseDados);

   DBEditLocaliza2.Atualiza;
   DBEditLocaliza3.Atualiza;
   DBEditLocaliza6.Atualiza;
   CadNumeroSerie.OPEN;
   ECSenhaLiberacao.Text := Varia.SenhaLiberacao;
   ECConfirmaSenha.Text := Varia.SenhaLiberacao;
   Boleto.open;
   DadosBoleto.open;
   Sintegra.Text := varia.PathSintegra;
   EFormatoExportacao.ItemIndex := CFGI_FOR_EXP.AsInteger;

  kk0y.ActivePage := TabSheet3;
  AlterarEnabledDet([EFormatoExportacao],false);
end;

{ ******************* No fechamento do formulário **************************** }
procedure TFConfiguracoesFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    CFG.close;
    CadNumeroSerie.close;
    UnImp.Free;
    Boleto.close;
    DadosBoleto.close;
    Aux.close;
    action := cafree;
end;

{ *************** fecha o formulario *************************************** }
procedure TFConfiguracoesFiscal.FecharClick(Sender: TObject);
begin
close;
end;

{ ******* Adiciona o nome da nova empresa *********************************** }
procedure TFConfiguracoesFiscal.DBEditLocaliza2Retorno(Retorno1,
  Retorno2: String);
begin
end;


{ |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
 |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                         Produtos
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| }



procedure TFConfiguracoesFiscal.mascaraProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
if (not (key in [#57, #8])) then
 key := #0;
end;

procedure TFConfiguracoesFiscal.mascaraExit(Sender: TObject);
begin
   if (sender as TDBEditColor).Text <> '' then
   if ((sender as TDBEditColor).Text[Length((sender as TDBEditColor).Text)] = '.') then
     (sender as TDBEditColor).Field.Value := copy((sender as TDBEditColor).Text,0, Length((sender as TDBEditColor).Text)-1);
end;

procedure TFConfiguracoesFiscal.mascaraKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (key in [ #46, #57, #8]) then
   begin
      if ((sender as TDBEditColor).Text <> '') then
      begin
         if ((sender as TDBEditColor).Text[Length((sender as TDBEditColor).Text)] = '.') and (Key = '.') then
           key := #0;
      end
      else
        if ((sender as TDBEditColor).Text = '') and (Key = '.') then
          key := #0;
   end
   else
       key := #0;
end;



{ |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
 |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                            Financeiro
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| }


procedure TFConfiguracoesFiscal.DBMemoColor2KeyPress(Sender: TObject;
  var Key: Char);
begin
   if (length(TDBMemocolor(Sender).Lines.Strings[TDBMemocolor(Sender).CaretPos.y]) > 140) and (key <> #8) and (key <> #13) then
      key := #0;

   if (key = #13) and (TDBMemocolor(sender).Lines.count >= 3) then
      key := #0;
end;

{******************Cadastrar um novo historico Padrao**************************}
procedure TFConfiguracoesFiscal.DelHistoricoPadraoCadastrar(Sender: TObject);
begin
end;

{*****************Chama a rotina para atualizar os localizas*******************}
procedure TFConfiguracoesFiscal.CFGAfterScroll(DataSet: TDataSet);
begin
//   AtualizaLocalizas(PanelColor1);
end;

{******************atualiza a tabela de série padrão***************************}
procedure TFConfiguracoesFiscal.CadNumeroSerieAfterPost(DataSet: TDataSet);
begin
  AtualizaSQLTabela(CadNumeroSerie);
end;

procedure TFConfiguracoesFiscal.BotaoCadastrar1DepoisAtividade(
  Sender: TObject);
begin
   Self.ActiveControl := DBGridColor1;
end;

procedure TFConfiguracoesFiscal.RComProChange(Sender: TObject);
begin
  if RComPro.ItemIndex in [ 0, 1, 2, 3 ] then
  begin
    RComSer.ItemIndex := 2;
    RComSer.Enabled := false;
  end
  else
    RComSer.Enabled := true;
end;

procedure TFConfiguracoesFiscal.ECSenhaLiberacaoEnter(Sender: TObject);
begin
   if cfg.State in [dsinsert,dsedit] then
      AlteraSenha;
end;

{******************************************************************************}
procedure TFConfiguracoesFiscal.ECSenhaLiberacaoExit(Sender: TObject);
begin
  if length(ECSenhaLiberacao.Text) < 4 then
  begin
    aviso('SENHA INVÁLIDA!!!'#13'A senha tem que possuir no mínimo 4 caracteres.');
    ECSenhaLiberacao.Clear;
    ECConfirmaSenha.Clear;
    abort;
  end
  else
   ECConfirmaSenha.SetFocus;
end;

procedure TFConfiguracoesFiscal.ECConfirmaSenhaExit(Sender: TObject);
begin
   if ECSenhaLiberacao.Text <> ECConfirmaSenha.Text then
   begin
      erro(CT_SenhaInvalida);
      ECSenhaLiberacao.SetFocus;
      ECSenhaLiberacao.SelectAll;
   end
   else
   begin
      if cfg.state in [dsedit,dsinsert] then
         CFGC_SEN_LIB.AsString := Criptografa(ECSenhaLiberacao.Text);
      ECSenhaLiberacao.ReadOnly := true;
      ECConfirmaSenha.ReadOnly := true;
    end;
end;

{**************************Altera a senha de permissão*************************}
procedure TFConfiguracoesFiscal.AlteraSenha;
var
   Senha : String;
begin
  if ECSenhaLiberacao.ReadOnly then
    if  entrada('Alteração da Senha','Digite a Senha Atual : ',Senha,true,ECSenhaLiberacao.Color,PanelColor1.Color) Then
    begin
       if (Varia.SenhaLiberacao = senha) Then
       begin
          ECSenhaLiberacao.ReadOnly := false;
          ECConfirmaSenha.ReadOnly := false;
       end
       else
       begin
          erro(CT_SenhaInvalida);
       end;
     end;
end;


procedure TFConfiguracoesFiscal.SintegraExit(Sender: TObject);
var
  ini : TRegIniFile;
begin
  ini := TRegIniFile.Create(CT_DIRETORIOREGEDIT);
  ini.WriteString('SINTEGRA','PATH', Sintegra.Text);
  ini.free;
  varia.PathSintegra := Sintegra.Text;
end;

{******************* antes de gravar o registro *******************************}
procedure TFConfiguracoesFiscal.CadNumeroSerieBeforePost(
  DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadNumeroSerie.FieldByname('D_ULT_ALT').AsDateTime := DATE;
end;

{******************************************************************************}
procedure TFConfiguracoesFiscal.EFormatoExportacaoClick(Sender: TObject);
begin
  if CFG.State = dsedit then
    CFGI_FOR_EXP.AsInteger := EFormatoExportacao.ItemIndex;
end;

{******************************************************************************}
procedure TFConfiguracoesFiscal.CFGAfterEdit(DataSet: TDataSet);
begin
  AlterarEnabledDet([EFormatoExportacao],true);
end;

{******************************************************************************}
procedure TFConfiguracoesFiscal.CFGAfterPost(DataSet: TDataSet);
begin
  AlterarEnabledDet([EFormatoExportacao],false);
end;

{******************************************************************************}
procedure TFConfiguracoesFiscal.CFGAfterCancel(DataSet: TDataSet);
begin
  AlterarEnabledDet([EFormatoExportacao],false);
end;


Initialization
{*****************Registra a Classe para Evitar duplicidade********************}
   RegisterClasses([TFConfiguracoesFiscal]);
end.
