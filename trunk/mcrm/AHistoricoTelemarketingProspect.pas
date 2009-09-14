unit AHistoricoTelemarketingProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, StdCtrls, Buttons, Localizacao,
  ComCtrls, Db, DBTables, DBCtrls, Tabela, Grids, DBGrids, DBKeyViolation,
  Mask, numericos, Menus, DBClient;

type
  TFHistoricoTelemarketingProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BFechar: TBitBtn;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Label5: TLabel;
    SpeedButton4: TSpeedButton;
    Label4: TLabel;
    BUsuario: TSpeedButton;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ECodProspect: TEditLocaliza;
    ECodUsuario: TEditLocaliza;
    ECodHistorico: TEditLocaliza;
    Localiza: TConsultaPadrao;
    Label2: TLabel;
    LNomUsuario: TLabel;
    Label7: TLabel;
    PanelColor3: TPanelColor;
    LIGACOES: TSQL;
    DataLIGACOES: TDataSource;
    Grade: TGridIndice;
    EObservacoes: TDBMemoColor;
    Splitter1: TSplitter;
    LIGACOESSEQTELE: TFMTBCDField;
    LIGACOESDATLIGACAO: TSQLTimeStampField;
    LIGACOESDESFALADOCOM: TWideStringField;
    LIGACOESDESOBSERVACAO: TWideStringField;
    LIGACOESDATTEMPOLIGACAO: TSQLTimeStampField;
    LIGACOESCODPROSPECT: TFMTBCDField;
    LIGACOESNOMPROSPECT: TWideStringField;
    LIGACOESC_NOM_USU: TWideStringField;
    LIGACOESDESHISTORICO: TWideStringField;
    PanelColor4: TPanelColor;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CAtualizarTotais: TCheckBox;
    EQtdLigacoes: Tnumerico;
    ETempoTotal: TEditColor;
    ETempoMedio: TEditColor;
    Aux: TSQL;
    PopupMenu1: TPopupMenu;
    TelemarketingReceptivo1: TMenuItem;
    LIGACOESTIPO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure CAtualizarTotaisClick(Sender: TObject);
    procedure TelemarketingReceptivo1Click(Sender: TObject);
  private
    VprOrdem: String;
    procedure InicializaTela;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
    procedure AdicionaFiltroCliente(VpaComandoSql : TStrings);
    function RQtdLigacoes(var VpaTempoTotal, VpaMedia: Integer): Integer;
    procedure ConfiguraPermissaoUsuario;
  public
  end;

var
  FHistoricoTelemarketingProspect: TFHistoricoTelemarketingProspect;

implementation
uses
  APrincipal, FunString, FunNumeros, FunSQL, FunData, Constantes,
  ANovoTelemarketingProspect;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFHistoricoTelemarketingProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ConfiguraPermissaoUsuario;
  VprOrdem:= ' ORDER BY SEQTELE';
  InicializaTela;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFHistoricoTelemarketingProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.InicializaTela;
begin
  EDatInicio.DateTime:= PrimeiroDiaMes(Date);
  EDatFim.DateTime:= UltimoDiaMes(Date);
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.AdicionaFiltros(VpaSelect: TStrings);
begin
  if CPeriodo.Checked then
    VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('TEL.DATLIGACAO',EDatInicio.DateTime,IncDia(EDatFim.Datetime,1),True));
  if ECodProspect.AInteiro <> 0 then
    VpaSelect.Add(' AND TEL.CODPROSPECT = '+ECodProspect.Text);
  if ECodUsuario.Ainteiro <> 0 then
    VpaSelect.Add(' AND TEL.CODUSUARIO = '+ECodUsuario.Text);
  if ECodHistorico.AInteiro <> 0 then
    VpaSelect.Add(' AND TEL.CODHISTORICO = '+ECodHistorico.Text);
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.AdicionaFiltroCliente(VpaComandoSql : TStrings);
begin
  if ECodProspect.AInteiro <> 0 then
    VpaComandoSql.Add(' AND TEL.CODCLIENTE = 0');
  if CPeriodo.Checked then
    VpaComandoSql.add(SQLTextoDataEntreAAAAMMDD('TEL.DATLIGACAO',EDatInicio.DateTime,incdia(EDatFim.Datetime,1),true));
  if ECodUsuario.Ainteiro <> 0 then
    VpaComandoSql.add(' and TEL.CODUSUARIO = '+ECodUsuario.Text);
  if ECodHistorico.AInteiro <> 0 then
    VpaComandoSql.add(' and TEL.CODHISTORICO = '+ECodHistorico.Text);
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.AtualizaConsulta;
begin
  LIGACOES.SQL.Clear;
  LIGACOES.SQL.Add('SELECT'+
                   ' ''SUSPECT'' TIPO,TEL.SEQTELE, TEL.DATLIGACAO, TEL.DESFALADOCOM,'+
                   ' TEL.DESOBSERVACAO, TEL.DATTEMPOLIGACAO, TEL.CODPROSPECT,'+
                   ' PRO.NOMPROSPECT,'+
                   ' USU.C_NOM_USU,'+
                   ' HIS.DESHISTORICO'+
                   ' FROM'+
                   ' TELEMARKETINGPROSPECT TEL, PROSPECT PRO, CADUSUARIOS USU, HISTORICOLIGACAO HIS'+
                   ' WHERE'+
                   ' TEL.CODPROSPECT = PRO.CODPROSPECT'+
                   ' AND TEL.CODUSUARIO = USU.I_COD_USU'+
                   ' AND TEL.CODHISTORICO = HIS.CODHISTORICO');
  AdicionaFiltros(LIGACOES.SQL);
  Ligacoes.SQL.ADD('union '+
                   ' select ''PROSPECT'' TIPO,TEL.SEQTELE, TEL.DATLIGACAO,TEL.DESFALADOCOM,  TEL.DESOBSERVACAO, TEL.DATTEMPOLIGACAO, TEL.CODCLIENTE, '+
                   ' CLI.C_NOM_CLI, '+
                   ' USU.C_NOM_USU, '+
                   ' HIS.DESHISTORICO '+
                   ' from TELEMARKETING TEL, CADCLIENTES CLI, CADUSUARIOS USU, HISTORICOLIGACAO HIS '+
                   ' Where TEL.CODCLIENTE = CLI.I_COD_CLI '+
                   ' and TEL.CODUSUARIO = USU.I_COD_USU '+
                   ' and TEL.CODHISTORICO = HIS.CODHISTORICO ');
  AdicionaFiltroCliente(LIGACOES.sql);
  LIGACOES.SQL.Add('order by 2');
  LIGACOES.Open;
  Grade.ALinhaSQLOrderBy:= LIGACOES.SQL.Count-1;
  CAtualizarTotaisClick(CAtualizarTotais);
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.CAtualizarTotaisClick(Sender: TObject);
var
  VpfTempoTotal, VpfMedia: Integer;
begin
  if CAtualizarTotais.Checked then
  begin
    EQtdLigacoes.AValor:= RQtdLigacoes(VpfTempoTotal,VpfMedia);
    ETempoTotal.Text:= FormatDateTime('HH:MM:SS',VpfTempoTotal);
    ETempoMedio.Text:= FormatDateTime('HH:MM:SS',VpfMedia);
  end
  else
  begin
    EQtdLigacoes.AValor:= 0;
    ETempoTotal.Text:= FormatDateTime('HH:MM:SS',0);
    ETempoMedio.Text:= FormatDateTime('HH:MM:SS',0);
  end;
end;

{******************************************************************************}
function TFHistoricoTelemarketingProspect.RQtdLigacoes(var VpaTempoTotal, VpaMedia: Integer): Integer;
begin
  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT COUNT(*) QTD,'+
              '       SUM(QTDSEGUNDOSLIGACAO) TEMPO,'+
              '       AVG(QTDSEGUNDOSLIGACAO) MEDIA'+
              ' FROM TELEMARKETINGPROSPECT TEL'+
              ' WHERE TEL.SEQTELE = TEL.SEQTELE');
  Adicionafiltros(Aux.SQL);
  Aux.Open;
  Result:= Aux.FieldByName('QTD').AsInteger;
  VpaTempoTotal:= Aux.FieldByName('TEMPO').AsInteger;
  VpaMedia:= Aux.FieldByName('MEDIA').AsInteger;

  Aux.SQL.Clear;
  Aux.SQL.Add('SELECT COUNT(*) QTD,'+
              '       SUM(QTDSEGUNDOSLIGACAO) TEMPO,'+
              '       AVG(QTDSEGUNDOSLIGACAO) MEDIA'+
              ' FROM TELEMARKETING TEL'+
              ' WHERE TEL.SEQTELE = TEL.SEQTELE');
  AdicionaFiltroCliente(Aux.SQL);
  Aux.open;
  Result:=  result + Aux.FieldByName('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.ConfiguraPermissaoUsuario;
begin
  if (puSomenteClientesdoVendedor in varia.PermissoesUsuario) then
  begin
    ECodUsuario.AInteiro := Varia.CodigoUsuario;
    ECodUsuario.Atualiza;
    ECodUsuario.Enabled := false;
    BUsuario.Enabled := false;
    LNomUsuario.Enabled := false;
  end;
end;

{******************************************************************************}
procedure TFHistoricoTelemarketingProspect.TelemarketingReceptivo1Click(
  Sender: TObject);
begin
  if not LIGACOESCODPROSPECT.AsInteger <> 0 then
  begin
    FNovoTeleMarketingProspect:= TFNovoTeleMarketingProspect.CriarSDI(Application,'',True);
    FNovoTeleMarketingProspect.TeleMarketingProspect(LIGACOESCODPROSPECT.AsInteger);
    FNovoTeleMarketingProspect.Free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFHistoricoTelemarketingProspect]);
end.
