unit AFichaAmostrasPendentes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Db, Grids,
  DBGrids, Tabela, DBKeyViolation, DBTables, Menus, UnAmostra, DBClient, Localizacao;

type
  TFFichaAmostrasPendentes = class(TFormularioPermissao)
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
    N3: TMenuItem;
    AlterarDesenvolvedor1: TMenuItem;
    EDesenvolvedor: TRBEditLocaliza;
    EDesenvolvedorFiltro: TRBEditLocaliza;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MConsultaAmostraClick(Sender: TObject);
    procedure MConcluiAmostraClick(Sender: TObject);
    procedure EDepartamentoClick(Sender: TObject);
    procedure EDepartamentoFimConsulta(Sender: TObject);
    procedure GerarAmostra1Click(Sender: TObject);
    procedure AlterarDesenvolvedor1Click(Sender: TObject);
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
  FFichaAmostrasPendentes: TFFichaAmostrasPendentes;

implementation

uses APrincipal, AAmostras, Constantes, FunObjeto, Constmsg, ANovaAmostra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFichaAmostrasPendentes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;
  AtualizaConsulta;
end;


procedure TFFichaAmostrasPendentes.GerarAmostra1Click(Sender: TObject);
begin
  if AmostrasCODAMOSTRA.AsInteger <> 0 then
  begin
    FNovaAmostra := tFNovaAmostra.CriarSDI(Self,'',true);
    FNovaAmostra.NovaAmostra(AmostrasCODAMOSTRA.AsInteger);
    FNovaAmostra.free;
    AtualizaConsulta;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFichaAmostrasPendentes.FormClose(Sender: TObject; var Action: TCloseAction);
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
procedure TFFichaAmostrasPendentes.AlterarDesenvolvedor1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if EDesenvolvedor.AAbreLocalizacao then
    VpfResultado :=  FunAmostra.AlteraDesenvolvedor(AmostrasCODAMOSTRA.AsInteger,EDesenvolvedor.AInteiro);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFichaAmostrasPendentes.AtualizaConsulta;
begin
  Amostras.close;
  Amostras.sql.clear;
  Amostras.sql.add('SELECT CODAMOSTRA, NOMAMOSTRA, DATAMOSTRA, DATENTREGACLIENTE, AMO.QTDAMOSTRA, AMO.DESDEPARTAMENTO, '+
                   ' VEN.C_NOM_VEN, '+
                   ' CLI.C_NOM_CLI, '+
                   ' DES.CODDESENVOLVEDOR, DES.NOMDESENVOLVEDOR, '+
                   ' DEP.CODDEPARTAMENTOAMOSTRA, DEP.NOMDEPARTAMENTOAMOSTRA '+
                   ' FROM AMOSTRA AMO, CADVENDEDORES VEN, CADCLIENTES CLI, DESENVOLVEDOR DES, DEPARTAMENTOAMOSTRA DEP '+
                   ' WHERE AMO.DATFICHAAMOSTRA IS NULL '+
                   ' AND AMO.TIPAMOSTRA = ''I'''+
                   ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                   ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                   ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR ' +
                   ' AND AMO.CODDEPARTAMENTOAMOSTRA = DEP.CODDEPARTAMENTOAMOSTRA');
  AdicionaFiltros(Amostras.sql);
  Amostras.sql.add(' ORDER BY AMO.DATENTREGACLIENTE');
  Amostras.open;
end;

{******************************************************************************}
procedure TFFichaAmostrasPendentes.AdicionaFiltros(VpaConsulta : TStrings);
begin
  if EDepartamento.AInteiro <> 0 then
    Amostras.SQL.add('AND AMO.CODDEPARTAMENTOAMOSTRA = '+EDepartamento.Text);
  if EDesenvolvedorFiltro.AInteiro <> 0 then
    Amostras.SQL.Add('AND AMO.CODESENVOLVEDOR = '+EDesenvolvedorFiltro.Text);
end;

{******************************************************************************}
procedure TFFichaAmostrasPendentes.ConfiguraPermissaoUsuario;
begin
  MConcluiAmostra.Visible := true;
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
  end;
end;

{******************************************************************************}
procedure TFFichaAmostrasPendentes.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFFichaAmostrasPendentes.MConsultaAmostraClick(
  Sender: TObject);
begin
  FAmostras := TFAmostras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAmostras'));
  FAmostras.ConsultaAmostrasIndefinidas(AmostrasCODAMOSTRA.AsInteger);
  FAmostras.free;
end;

{******************************************************************************}
procedure TFFichaAmostrasPendentes.MConcluiAmostraClick(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfREsultado := FunAmostra.ConcluirFichaAmostra(AmostrasCODAMOSTRA.AsInteger);
  if VpfREsultado <> '' then
    aviso(VpfREsultado)
  else
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFichaAmostrasPendentes.EDepartamentoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFichaAmostrasPendentes.EDepartamentoFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFichaAmostrasPendentes]);
end.
