unit AEstagioProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, StdCtrls, Mask,
  DBCtrls, Tabela, DBKeyViolation, Db, DBTables, CBancoDados, Buttons,
  BotaoCadastro, Grids, DBGrids, DBClient;

type
  TFEstagioProducao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EstagioProducao: TRBSQL;
    EstagioProducaoCODEST: TFMTBCDField;
    EstagioProducaoNOMEST: TWideStringField;
    EstagioProducaoCODTIP: TFMTBCDField;
    Label1: TLabel;
    DataEstagioProducao: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    ETipoEstagio: TDBEditLocaliza;
    Localiza: TConsultaPadrao;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Consulta: TLocalizaEdit;
    Grade: TGridIndice;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    EstagioProducaoINDFIN: TWideStringField;
    EPlanoContas: TDBEditLocaliza;
    Label17: TLabel;
    BPlano: TSpeedButton;
    LPlano: TLabel;
    EstagioProducaoCODPLA: TWideStringField;
    EstagioProducaoCODEMP: TFMTBCDField;
    EstagioProducaoINDOBS: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBEditColor2: TDBEditColor;
    Label6: TLabel;
    EstagioProducaoMAXDIA: TFMTBCDField;
    DBRadioGroup1: TDBRadioGroup;
    EstagioProducaoTIPEST: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeOrdem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure EstagioProducaoAfterInsert(DataSet: TDataSet);
    procedure EstagioProducaoAfterEdit(DataSet: TDataSet);
    procedure EstagioProducaoAfterPost(DataSet: TDataSet);
    procedure EstagioProducaoBeforePost(DataSet: TDataSet);
    procedure EstagioProducaoAfterScroll(DataSet: TDataSet);
    procedure ETipoEstagioCadastrar(Sender: TObject);
    procedure ECodigoChange(Sender: TObject);
    procedure EPlanoContasRetorno(Retorno1, Retorno2: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEstagioProducao: TFEstagioProducao;

implementation

uses APrincipal, ATipoEstagioProducao, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEstagioProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  COnSULTA.aTUALIZACONSULTA;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEstagioProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEstagioProducao.GradeOrdem(Ordem: String);
begin
  Consulta.AOrdem := Ordem;
end;

{******************************************************************************}
procedure TFEstagioProducao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFEstagioProducao.EstagioProducaoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
  EstagioProducaoINDFIN.AsString := 'N';
  EstagioProducaoINDOBS.AsString := 'N';
  EstagioProducaoTIPEST.AsString := 'P';
end;

{******************************************************************************}
procedure TFEstagioProducao.EstagioProducaoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFEstagioProducao.EstagioProducaoAfterPost(DataSet: TDataSet);
begin
  Consulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEstagioProducao.EstagioProducaoBeforePost(DataSet: TDataSet);
begin
  if EstagioProducao.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFEstagioProducao.EstagioProducaoAfterScroll(DataSet: TDataSet);
begin
  ETipoEstagio.Atualiza;
  EPlanoContas.Atualiza;
end;

{******************************************************************************}
procedure TFEstagioProducao.ETipoEstagioCadastrar(Sender: TObject);
begin
  FTipoEstagioProducao := TFTipoEstagioProducao.criarSDI(Application,'',FPrincipal.verificaPermisao('FTipoEstagioProducao'));
  FTipoEstagioProducao.BotaoCadastrar1.Click;
  FTipoEstagioProducao.Showmodal;
  FTipoEstagioProducao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEstagioProducao.ECodigoChange(Sender: TObject);
begin
  if (EstagioProducao.State in [dsedit,dsinsert]) then
    ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFEstagioProducao.EPlanoContasRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    EstagioProducaoCODEMP.AsString := Retorno1
  else
    EstagioProducaoCODEMP.Clear;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEstagioProducao]);
end.
