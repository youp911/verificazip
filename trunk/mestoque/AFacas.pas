unit AFacas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, StdCtrls, Mask, DBCtrls, Tabela, DBKeyViolation, Db,
  BotaoCadastro, Buttons, DBTables, CBancoDados, Componentes1,
  PainelGradiente, Grids, DBGrids, Localizacao, DBClient;

type
  TFFacas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Faca: TRBSQL;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    FacaCODFACA: TFMTBCDField;
    FacaNOMFACA: TWideStringField;
    FacaALTFACA: TFMTBCDField;
    FacaLARFACA: TFMTBCDField;
    FacaQTDPROVA: TFMTBCDField;
    Label1: TLabel;
    DataFaca: TDataSource;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    Bevel1: TBevel;
    Label5: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    DBEditColor4: TDBEditColor;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelColor1Click(Sender: TObject);
    procedure FecharClick(Sender: TObject);
    procedure FacaAfterInsert(DataSet: TDataSet);
    procedure FacaAfterEdit(DataSet: TDataSet);
    procedure FacaAfterPost(DataSet: TDataSet);
    procedure FacaBeforePost(DataSet: TDataSet);
    procedure GridIndice1Ordem(Ordem: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFacas: TFFacas;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFacas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFacas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Faca.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFFacas.PanelColor1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFFacas.FecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFFacas.FacaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  Ecodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFFacas.FacaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFFacas.FacaAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFacas.FacaBeforePost(DataSet: TDataSet);
begin
  if Faca.state = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

procedure TFFacas.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFacas]);
end.
