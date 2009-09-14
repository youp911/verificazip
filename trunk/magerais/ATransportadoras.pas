unit ATransportadoras;
{          Autor: Rafael Budag
    Data Criação: 25/03/1999;
          Função: Cadastrar Transportadoras
  Data Alteração: 25/03/1999;
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Mask, DBCtrls, Db, DBTables, Tabela, BotaoCadastro,
  Buttons, ExtCtrls, Componentes1, DBCidade, DBKeyViolation, DBGrids,
  Localizacao, PainelGradiente, constantes, Constmsg, Grids, DBClient;

type
  TFTransportadoras = class(TFormularioPermissao)
    DataTransportadora: TDataSource;
    PainelGradiente1: TPainelGradiente;
    DBGridColor1: TGridIndice;
    PanelColor2: TPanelColor;
    PanelColor1: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    Consulta: TLocalizaEdit;
    Label1: TLabel;
    BotaoConsultar1: TBotaoConsultar;
    CadTransportadoras: TSQL;
    CadTransportadorasI_COD_TRA: TFMTBCDField;
    CadTransportadorasC_NOM_TRA: TWideStringField;
    CadTransportadorasC_END_TRA: TWideStringField;
    CadTransportadorasC_BAI_TRA: TWideStringField;
    CadTransportadorasI_NUM_TRA: TFMTBCDField;
    CadTransportadorasC_CID_TRA: TWideStringField;
    CadTransportadorasC_EST_TRA: TWideStringField;
    CadTransportadorasC_FON_TRA: TWideStringField;
    CadTransportadorasC_FAX_TRA: TWideStringField;
    CadTransportadorasC_NOM_GER: TWideStringField;
    CadTransportadorasC_CGC_TRA: TWideStringField;
    CadTransportadorasC_INS_TRA: TWideStringField;
    CadTransportadorasD_DAT_MOV: TSQLTimeStampField;
    CadTransportadorasC_WWW_TRA: TWideStringField;
    CadTransportadorasC_END_ELE: TWideStringField;
    BFechar: TBitBtn;
    CadTransportadorasC_CEP_TRA: TWideStringField;
    CadTransportadorasC_COM_END: TWideStringField;
    CadTransportadorasL_OBS_TRA: TWideStringField;
    CadTransportadorasCOD_CIDADE: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridColor1TitleClick(Column: TColumn);
    procedure DBGridColor1DblClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure BotaoConsultar1AntesAtividade(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTransportadoras: TFTransportadoras;

implementation

uses APrincipal, ANovaTransportadora,funSQl;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFTransportadoras.FormCreate(Sender: TObject);
begin
   CadTransportadoras.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTransportadoras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadTransportadoras.close;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{***************Cria o formluario pra cadastrar novos registros****************}
procedure TFTransportadoras.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
   FNovaTransportadora := TFNovaTransportadora.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaTransportadora'));
end;

{*************Chama a tela de novos registros e atualiza a tabela**************}
procedure TFTransportadoras.BotaoCadastrar1DepoisAtividade(
  Sender: TObject);
begin
   FNovaTransportadora.ShowModal;
   Consulta.AtualizaTabela;
end;

{*****************************Procura o registro*******************************}
procedure TFTransportadoras.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSqlAbreTabela(FNovaTransportadora.CadTransportadoras,
                          'SELECT * FROM CADTRANSPORTADORAS Where I_COD_TRA = ' +CadTransportadorasI_COD_TRA.AsString);
end;

{*********************Mostra o registro que será excluido**********************}
procedure TFTransportadoras.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
   FNovaTransportadora.Show;
end;

{***********Fecha o Formulario de novos registros e atualiza a tabela**********}
procedure TFTransportadoras.BotaoExcluir1DestroiFormulario(
  Sender: TObject);
begin
   FNovaTransportadora.Close;
   consulta.atualizatabela;
end;

{************************Fecha o formulario corrente***************************}
procedure TFTransportadoras.BotaoFechar1Click(Sender: TObject);
begin
   Close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFTransportadoras.DBGridColor1TitleClick(Column: TColumn);
begin
end;

{*************No duplo click do grid altera o registro selecionado*************}
procedure TFTransportadoras.DBGridColor1DblClick(Sender: TObject);
begin
   BotaoAlterar1.Click;
end;

{************************Fecha o formulario corrente***************************}
procedure TFTransportadoras.BFecharClick(Sender: TObject);
begin
   close;
end;

{***************** atualiza a ordem da consulta *******************************}
procedure TFTransportadoras.DBGridColor1Ordem(Ordem: String);
begin
  Consulta.AOrdem := Ordem;
end;

procedure TFTransportadoras.BotaoConsultar1AntesAtividade(Sender: TObject);
begin
   FNovaTransportadora := TFNovaTransportadora.CriarSDI(Application,'',true);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTransportadoras]);
end.
 