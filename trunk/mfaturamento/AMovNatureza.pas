unit AMovNatureza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, BotaoCadastro, StdCtrls, Buttons, DBTables, Tabela,
  Componentes1, ExtCtrls, PainelGradiente, DBKeyViolation, Grids, DBGrids,
  Mask, DBCtrls, Localizacao, UnImpressao, ComCtrls, DBClient, FMTBcd, SqlExpr;

type
  TFMovNatureza = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    Localiza: TConsultaPadrao;
    MovNaturezas: TSQL;
    DataMovNatureza: TDataSource;
    PainelGradiente1: TPainelGradiente;
    PanelColor3: TPanelColor;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton1: TSpeedButton;
    Label13: TLabel;
    Label15: TLabel;
    SpeedButton2: TSpeedButton;
    Label14: TLabel;
    Label6: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    DelOperacaoEstoque: TDBEditLocaliza;
    EPlano: TDBEditNumerico;
    MObs: TDBMemoColorLimite;
    EditColor1: TEditColor;
    PanelColor4: TPanelColor;
    DBGridColor1: TDBGridColor;
    PanelColor5: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar2: TBotaoGravar;
    BotaoCancelar2: TBotaoCancelar;
    BFechar: TBitBtn;
    Aux: TSQLQuery;
    MovNaturezasC_COD_NAT: TWideStringField;
    MovNaturezasI_SEQ_MOV: TFMTBCDField;
    MovNaturezasC_NOM_MOV: TWideStringField;
    MovNaturezasC_GER_FIN: TWideStringField;
    MovNaturezasC_ENT_SAI: TWideStringField;
    MovNaturezasC_BAI_EST: TWideStringField;
    MovNaturezasL_TEX_FIS: TWideStringField;
    MovNaturezasC_CAL_ICM: TWideStringField;
    MovNaturezasC_GER_COM: TWideStringField;
    MovNaturezasC_IMP_AUT: TWideStringField;
    MovNaturezasI_COD_OPE: TFMTBCDField;
    MovNaturezasI_COD_EMP: TFMTBCDField;
    MovNaturezasC_INS_SER: TWideStringField;
    MovNaturezasC_NAT_LOC: TWideStringField;
    MovNaturezasC_INS_PRO: TWideStringField;
    DBEditColor2: TDBEditColor;
    Label3: TLabel;
    MovNaturezasC_MOS_NOT: TWideStringField;
    MovNaturezasD_ULT_ALT: TSQLTimeStampField;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    MovNaturezasC_CAL_ISS: TWideStringField;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    MovNaturezasC_EXI_CPF: TWideStringField;
    MovNaturezasC_CLA_PLA: TWideStringField;
    EProximoCodigo: TDBKeyViolation;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure DelOperacaoEstoqueSelect(Sender: TObject);
    procedure DelOperacaoEstoqueCadastrar(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MovNaturezasAfterInsert(DataSet: TDataSet);
    procedure MovNaturezasBeforePost(DataSet: TDataSet);
    procedure DelOperacaoEstoqueRetorno(Retorno1, Retorno2: String);
    procedure MObsExit(Sender: TObject);
    procedure MovNaturezasAfterPost(DataSet: TDataSet);
    procedure MovNaturezasAfterScroll(DataSet: TDataSet);
    procedure DelOperacaoEstoqueExit(Sender: TObject);
    procedure MovNaturezasAfterEdit(DataSet: TDataSet);
  private
    unImp : TFuncoesImpressao;
    CodNatureza : string;
  public
    procedure PosicionaNatureza( Codigo : String);
  end;

var
  FMovNatureza: TFMovNatureza;

implementation

uses APrincipal, FunSql,AOperacoesEstoques, APlanoConta, constantes, FunObjeto;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           cad naturezas
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ****************** Na criação do Formulário ******************************** }
procedure TFMovNatureza.FormCreate(Sender: TObject);
begin
   unImp := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
   unImp.LocalizaUmItem(aux, varia.NotaFiscalPadrao, 74);
   MObs.AQdadeCaracter := aux.FieldByname('i_tam_cam').AsInteger;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor3,'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMovNatureza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   unImp.Free;
   Aux.close;
   MovNaturezas.close;
   Action := CaFree;
end;

{************Posiciona a tabela passada conforme o codigo passado**************}
procedure TFMovNatureza.PosicionaNatureza( Codigo : String );
begin
  AdicionaSQLAbreTabela(MovNaturezas,' Select * from MovNatureza ' +
                                     ' Where C_Cod_Nat = ''' + Codigo + '''');
  CodNatureza := Codigo;
  self.ShowModal;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFMovNatureza.BFecharClick(Sender: TObject);
begin
   close;
end;

{******************Carrega a Select da operacao de estoque*********************}
procedure TFMovNatureza.DelOperacaoEstoqueSelect(Sender: TObject);
begin
   DelOperacaoEstoque.ASelectValida.text := 'Select * from CadOperacaoEstoque '  +
                                            ' Where I_Cod_Ope = @ ';
   DelOperacaoEstoque.ASelectLocaliza.text := 'Select * from CadOperacaoEstoque '+
                                              ' Where C_Nom_Ope like ''@%''';
end;


{********************Cadastra uma nova operação de Estoque*********************}
procedure TFMovNatureza.DelOperacaoEstoqueCadastrar(Sender: TObject);
begin
   FOperacoesEstoques := TFOperacoesEstoques.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FOperacoesEstoques'));
   FOperacoesEstoques.BotaoCadastrar1.Click;
   FOperacoesEstoques.ShowModal;
   Localiza.AtualizaConsulta;
end;

{************ localiza plano de contas ************************************** }
procedure TFMovNatureza.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Field.AsString;
  if not FPlanoConta.verificaCodigo( VpfCodigo, '', Label14, false,(Sender is TSpeedButton) ) then
    EPlano.SetFocus;
  if MovNaturezas.State in [ dsEdit, dsInsert] then
  begin
    EPlano.Field.AsString := VpfCodigo;
    if EPlano.Text = '' then
      MovNaturezasC_CLA_PLA.Clear;
  end;
end;

procedure TFMovNatureza.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = 114 then
  EPlanoExit(SpeedButton2);
end;


procedure TFMovNatureza.MovNaturezasAfterEdit(DataSet: TDataSet);
begin
  DBEditcolor2.readOnly := false;
end;

procedure TFMovNatureza.MovNaturezasAfterInsert(DataSet: TDataSet);
begin
   EProximocodigo.proximocodigo;
   DBEditcolor2.readOnly := false;
   MovNaturezasC_COD_NAT.AsString := CodNatureza;
   MovNaturezasC_ENT_SAI.AsString := 'S'; // SOMENTE PARA SAIDA DE PRODUTOS
   MovNaturezasC_BAI_EST.AsString := 'S';
   MovNaturezasC_CAL_ICM.AsString := 'S';
   MovNaturezasC_GER_COM.AsString := 'S';
   MovNaturezasC_IMP_AUT.AsString := 'N';
   MovNaturezasC_INS_PRO.AsString := 'S';
   MovNaturezasC_INS_SER.AsString := 'N';
   MovNaturezasC_NAT_LOC.AsString := 'S';
   MovNaturezasC_GER_FIN.AsString := 'S';
   MovNaturezasC_MOS_NOT.AsString := 'S';
   MovNaturezasC_CAL_ISS.AsString := 'S';
   MovNaturezasC_EXI_CPF.AsString := 'S';
end;

{******************* antes de gravar o registro *******************************}
procedure TFMovNatureza.MovNaturezasBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  MovNaturezasD_ULT_ALT.AsDateTime := Date;

   if MovNaturezas.State = dsinsert Then
      EProximoCodigo.VerificaCodigoutilizado;
end;

procedure TFMovNatureza.DelOperacaoEstoqueRetorno(Retorno1,
  Retorno2: String);
begin
  EditColor1.Text := Retorno1;
end;

procedure TFMovNatureza.MObsExit(Sender: TObject);
begin
  if BotaoGravar2.Enabled then
    BotaoGravar2.SetFocus;
end;

procedure TFMovNatureza.MovNaturezasAfterPost(DataSet: TDataSet);
begin
  AtualizaSQLTabela(MovNaturezas);
  DBEditcolor2.readOnly := true;
end;

procedure TFMovNatureza.MovNaturezasAfterScroll(DataSet: TDataSet);
begin
  DelOperacaoEstoque.Atualiza;
  EPlanoExit(EPlano);
end;

procedure TFMovNatureza.DelOperacaoEstoqueExit(Sender: TObject);
begin
  if MovNaturezas.State in [ dsEdit, dsInsert ] then
    if DelOperacaoEstoque.text = '' then
      MovNaturezasI_COD_OPE.Clear;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMovNatureza]);
end.
