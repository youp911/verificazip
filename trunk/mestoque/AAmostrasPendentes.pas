unit AAmostrasPendentes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Db, Grids,
  DBGrids, Tabela, DBKeyViolation, DBTables, Menus, UnAmostra, DBClient;

type
  TFAmostrasPendentes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Amostras: TSQL;
    AmostrasCODAMOSTRA: TFMTBCDField;
    AmostrasNOMAMOSTRA: TWideStringField;
    AmostrasDATAMOSTRA: TSQLTimeStampField;
    AmostrasDATENTREGACLIENTE: TSQLTimeStampField;
    AmostrasC_NOM_VEN: TWideStringField;
    AmostrasC_NOM_CLI: TWideStringField;
    GridIndice1: TGridIndice;
    DataAmostras: TDataSource;
    AmostrasQTDAMOSTRA: TFMTBCDField;
    PopupMenu1: TPopupMenu;
    MConsultaAmostra: TMenuItem;
    N1: TMenuItem;
    MConcluiAmostra: TMenuItem;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    EDepartamento: TComboBoxColor;
    AmostrasDepartamento: TWideStringField;
    AmostrasDESDEPARTAMENTO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MConsultaAmostraClick(Sender: TObject);
    procedure MConcluiAmostraClick(Sender: TObject);
    procedure EDepartamentoClick(Sender: TObject);
    procedure AmostrasCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FunAmostra : TRBFuncoesAmostra;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaConsulta : TStrings);
    procedure ConfiguraPermissaoUsuario;
  public
    { Public declarations }
  end;

var
  FAmostrasPendentes: TFAmostrasPendentes;

implementation

uses APrincipal, AAmostras, Constantes, FunObjeto, Constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAmostrasPendentes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;
  EDepartamento.ItemIndex := 3;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAmostrasPendentes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra.free;
  Amostras.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAmostrasPendentes.AtualizaConsulta;
begin
  Amostras.close;
  Amostras.sql.clear;
  Amostras.sql.add('SELECT CODAMOSTRA, NOMAMOSTRA, DATAMOSTRA, DATENTREGACLIENTE, AMO.QTDAMOSTRA, AMO.DESDEPARTAMENTO, '+
                   ' VEN.C_NOM_VEN, '+
                   ' CLI.C_NOM_CLI '+
                   ' FROM AMOSTRA AMO, CADVENDEDORES VEN, CADCLIENTES CLI '+
                   ' WHERE AMO.DATENTREGA IS NULL '+
                   ' AND AMO.TIPAMOSTRA = ''I'''+
                   ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                   ' AND AMO.CODCLIENTE = CLI.I_COD_CLI ');
  AdicionaFiltros(Amostras.sql);
  Amostras.sql.add(' ORDER BY AMO.DATAMOSTRA');
  Amostras.open;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.AdicionaFiltros(VpaConsulta : TStrings);
begin
  case EDepartamento.ItemIndex of
    0 : Amostras.sql.add('AND AMO.DESDEPARTAMENTO = ''D''');
    1 : Amostras.sql.add('AND AMO.DESDEPARTAMENTO = ''F''');
    2 : Amostras.sql.add('AND AMO.DESDEPARTAMENTO = ''A''');
  end;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.ConfiguraPermissaoUsuario;
begin
  MConcluiAmostra.Visible := true;
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([MConcluiAmostra],false);
  end;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.MConsultaAmostraClick(
  Sender: TObject);
begin
  FAmostras := TFAmostras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAmostras'));
  FAmostras.ConsultaAmostrasIndefinidas(AmostrasCODAMOSTRA.AsInteger);
  FAmostras.free;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.MConcluiAmostraClick(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfREsultado := FunAmostra.ConcluiAmostra(AmostrasCODAMOSTRA.AsInteger,date);
  if VpfREsultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFAmostrasPendentes.EDepartamentoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFAmostrasPendentes.AmostrasCalcFields(DataSet: TDataSet);
begin
  if AmostrasDESDEPARTAMENTO.AsString = 'D' THEN
    AmostrasDepartamento.AsString := 'Desenvolvimento'
  else
    if AmostrasDESDEPARTAMENTO.AsString = 'F' THEN
      AmostrasDepartamento.AsString := 'Ficha Técnica'
    else
    if AmostrasDESDEPARTAMENTO.AsString = 'A' THEN
      AmostrasDepartamento.AsString := 'Amostras';
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAmostrasPendentes]);
end.
