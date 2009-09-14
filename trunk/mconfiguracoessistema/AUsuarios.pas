unit AUsuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, Grids, DBGrids, ExtCtrls, Buttons,
  Constantes, formularios, Menus, BotaoCadastro, constMsg,
  Componentes1, Tabela, PainelGradiente, funValida, Localizacao, DBClient,
  DBKeyViolation;

type
  TFUsuarios = class(TFormularioPermissao)
    DataUsuarios: TDataSource;
    menu: TPopupMenu;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Consultar1: TMenuItem;
    Atividade1: TMenuItem;
    N1: TMenuItem;
    Selecionar1: TMenuItem;
    Ativos1: TMenuItem;
    Todos1: TMenuItem;
    NoAtivos1: TMenuItem;
    N2: TMenuItem;
    Fechar1: TMenuItem;
    CadUsuarios: TSQL;
    CadUsuariosI_COD_USU: TFMTBCDField;
    CadUsuariosC_NOM_USU: TWideStringField;
    CadUsuariosC_NOM_LOG: TWideStringField;
    CadUsuariosD_DAT_MOV: TSQLTimeStampField;
    Grade: TGridIndice;
    PanelColor1: TPanelColor;
    EAtividade: TComboBoxColor;
    PanelColor2: TPanelColor;
    BotaoAlterar: TBotaoAlterar;
    BotaoConsultar: TBotaoConsultar;
    BitBtn1: TBitBtn;
    BAtividade: TBitBtn;
    BFechar: TBitBtn;
    PainelGradiente1: TPainelGradiente;
    CadUsuariosC_SEN_USU: TWideStringField;
    Label2: TLabel;
    Localiza: TConsultaPadrao;
    BotaoCadastrar1: TBotaoCadastrar;
    BitBtn2: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BAtividadeClick(Sender: TObject);
    procedure BotaoCadastrarAntesAtividade(Sender: TObject);
    procedure BotaoCadastrarDepoisAtividade(Sender: TObject);
    procedure BotaoAlterarAtividade(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoAlterarDepoisAtividade(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EliminarFraseSQL;
    procedure BotaoConsultarAntesAtividade(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EAtividadeChange(Sender: TObject);
    procedure BotaoAlterarClick(Sender: TObject);
    procedure GradeOrdem(Ordem: string);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure Adicionafiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FUsuarios: TFUsuarios;
  FraseDeleteSQL : integer;
  DeletarFrase : boolean;
implementation

uses ANovoUsuario, AAlteraAtividadeUsuario, APrincipal,
  AAlteraPermissaoFilial, FunSql;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFUsuarios.FormCreate(Sender: TObject);
begin
  EAtividade.itemIndex := 0;
  VprOrdem := 'order by C_NOM_USU';
  AtualizaConsulta;
end;

procedure TFUsuarios.GradeOrdem(Ordem: string);
begin
  VprOrdem := Ordem;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
CadUsuarios.close;
Action := Cafree;
end;

{ **************** Cria novo filtro para o tipo de usuario, ativo, etc ******* }
procedure TFUsuarios.Adicionafiltros(VpaSelect : TStrings);
begin
  case EAtividade.ItemIndex of
    0 : VpaSelect.add(' and C_USU_ATI = ''S''');
    2 : VpaSelect.add(' and C_USU_ATI = ''N''');
  end;
end;


{ *************** Aciona o formulario de mudança de Atividade *************** }
procedure TFUsuarios.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := CadUsuarios.GetBookmark;
  CadUsuarios.close;
  CadUsuarios.sql.clear;
  CadUsuarios.sql.add('Select * from CADUSUARIOS '+
                      ' Where I_COD_USU = I_COD_USU');
  AdicionaFiltros(Cadusuarios.sql);
  CadUsuarios.Sql.add(VprOrdem);
  Grade.ALinhaSQLOrderBy := CadUsuarios.SQL.Count -1;
  CadUsuarios.open;
  CadUsuarios.GotoBookmark(VpfPosicao);
  CadUsuarios.FreeBookmark(VpfPosicao);
end;

procedure TFUsuarios.BAtividadeClick(Sender: TObject);
begin
  FAlterarAtividade := TFAlterarAtividade.CriarSDI(application,'',FPrincipal.VerificaPermisao('FAlterarAtividade'));
  FAlterarAtividade.ShowModal;
  CadUsuarios.close;
  CadUsuarios.open;
end;

{ *********** Cria o formulario de cadastro, alteracao ou consulta *********** }
procedure TFUsuarios.BotaoCadastrarAntesAtividade(Sender: TObject);
begin
   FNovoUsuario := TFNovoUsuario.CriarSDI(application,'',Fprincipal.VerificaPermisao('FNovoUsuario'))
end;

{ ******** Aciona o formulario de cadastro, alteracao ou consulta ************ }
procedure TFUsuarios.BotaoCadastrarDepoisAtividade(Sender: TObject);
begin
  FNovoUsuario.ShowModal;
  FUsuarios.CadUsuarios.close;
  FUsuarios.CadUsuarios.open;
end;

{ ********* Localiza usuarios para alteracao ou consulta ******************** }
procedure TFUsuarios.BotaoAlterarAtividade(Sender: TObject);
begin
  AdicionaSqlAbreTabela(FNovoUsuario.CadUsuarios,'Select * from CADUSUARIOS '+
                                                 ' Where I_COD_USU = ' +IntToStr(CadUsuariosI_COD_USU.AsInteger));
end;


procedure TFUsuarios.BotaoAlterarClick(Sender: TObject);
begin

end;

{ *************** Fecha o formulario **************************************** }
procedure TFUsuarios.BFecharClick(Sender: TObject);
begin
close;
end;

{ *************** Verifica a senha do usuario para alteracao ***************** }
procedure TFUsuarios.BotaoAlterarDepoisAtividade(Sender: TObject);
begin
  FNovoUsuario.Senhas.text := Descriptografa(FNovoUsuario.CadUsuarios.FieldByName('C_SEN_USU').AsString);
  FNovoUsuario.ConfSenha.Text := FNovoUsuario.Senhas.text;
  FNovoUsuario.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFUsuarios.BitBtn1Click(Sender: TObject);
begin
Localiza.info.DataBase := Fprincipal.BaseDados;
Localiza.info.ComandoSQL := 'Select * from cadusuarios where i_emp_fil = ' +
                            IntToStr(Varia.CodigoEmpFil) + ' and c_nom_usu like ''@%''';
Localiza.info.caracterProcura := '@';
Localiza.info.ValorInicializacao := '';
Localiza.info.CamposMostrados[0] := 'i_cod_usu';
Localiza.info.CamposMostrados[1] := 'c_nom_usu';
Localiza.info.DescricaoCampos[0] := 'codigo';
Localiza.info.DescricaoCampos[1] := 'nome';
Localiza.info.TamanhoCampos[0] := 8;
Localiza.info.TamanhoCampos[1] := 40;
Localiza.info.CamposRetorno[0] := 'i_cod_usu';
Localiza.info.SomenteNumeros := false;
Localiza.info.CorFoco := FPrincipal.CorFoco;
Localiza.info.CorForm := FPrincipal.CorForm;
Localiza.info.CorPainelGra := FPrincipal.CorPainelGra;
Localiza.info.TituloForm := 'Localizar Usuários';

if Localiza.execute then
begin
  CadUsuarios.close;
  FraseDeleteSQL := CadUsuarios.sql.Add(' and i_cod_usu = ' + localiza.retorno[0]);
  CadUsuarios.open;
  DeletarFrase := true;
end;
end;

procedure TFUsuarios.EAtividadeChange(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFUsuarios.EliminarFraseSQL;
begin
if  deletarfrase then
begin
  CadUsuarios.sql.Delete(FraseDeleteSQL);
  deletarfrase := false;
end;
end;

procedure TFUsuarios.BotaoConsultarAntesAtividade(Sender: TObject);
begin
   FNovoUsuario := TFNovoUsuario.CriarSDI(application,'',true)
end;

{******************************************************************************}
procedure TFUsuarios.BitBtn2Click(Sender: TObject);
begin
  if CadUsuariosI_COD_USU.AsInteger <> 0 then
  begin
    FAlteraPermissaoFilial := TFAlteraPermissaoFilial.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraPermissaoFilial'));
    FAlteraPermissaoFilial.AlteraPermissaoUsuario(CadUsuariosI_COD_USU.AsInteger);
    FAlteraPermissaoFilial.free;
  end;
end;

Initialization
 RegisterClasses([TFUsuarios]);
end.
