unit AAmostrasPendentes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Db, Grids,
  DBGrids, Tabela, DBKeyViolation, DBTables, Menus, UnAmostra, DBClient, Localizacao;

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
    AmostrasDESDEPARTAMENTO: TWideStringField;
    EDepartamento: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    N2: TMenuItem;
    GerarAmostra1: TMenuItem;
    AmostrasCODDESENVOLVEDOR: TFMTBCDField;
    AmostrasNOMDESENVOLVEDOR: TWideStringField;
    AmostrasCODDEPARTAMENTOAMOSTRA: TFMTBCDField;
    AmostrasNOMDEPARTAMENTOAMOSTRA: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MConsultaAmostraClick(Sender: TObject);
    procedure MConcluiAmostraClick(Sender: TObject);
    procedure EDepartamentoClick(Sender: TObject);
    procedure EDepartamentoFimConsulta(Sender: TObject);
    procedure GerarAmostra1Click(Sender: TObject);
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

uses APrincipal, AAmostras, Constantes, FunObjeto, Constmsg, ANovaAmostra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAmostrasPendentes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;
  AtualizaConsulta;
end;


procedure TFAmostrasPendentes.GerarAmostra1Click(Sender: TObject);
begin
  if AmostrasCODAMOSTRA.AsInteger <> 0 then
  begin
    FNovaAmostra := tFNovaAmostra.CriarSDI(Self,'',true);
    FNovaAmostra.NovaAmostra(AmostrasCODAMOSTRA.AsInteger);
    FNovaAmostra.free;
  end;
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
                   ' CLI.C_NOM_CLI, '+
                   ' DES.CODDESENVOLVEDOR, DES.NOMDESENVOLVEDOR, '+
                   ' DEP.CODDEPARTAMENTOAMOSTRA, DEP.NOMDEPARTAMENTOAMOSTRA '+
                   ' FROM AMOSTRA AMO, CADVENDEDORES VEN, CADCLIENTES CLI, DESENVOLVEDOR DES, DEPARTAMENTOAMOSTRA DEP '+
                   ' WHERE AMO.DATENTREGA IS NULL '+
                   ' AND AMO.TIPAMOSTRA = ''I'''+
                   ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                   ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                   ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR ' +
                   ' AND AMO.CODDEPARTAMENTOAMOSTRA = DEP.CODDEPARTAMENTOAMOSTRA');
  AdicionaFiltros(Amostras.sql);
  Amostras.sql.add(' ORDER BY AMO.DATAMOSTRA');
  Amostras.open;
end;

{******************************************************************************}
procedure TFAmostrasPendentes.AdicionaFiltros(VpaConsulta : TStrings);
begin
  if EDepartamento.AInteiro <> 0 then
    Amostras.SQL.add('AND AMO.CODDEPARTAMENTOAMOSTRA = '+EDepartamento.Text);
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

{******************************************************************************}
procedure TFAmostrasPendentes.EDepartamentoFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAmostrasPendentes]);
end.
