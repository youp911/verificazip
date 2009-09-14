unit AReajusteContrato;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Spin, Buttons, Mask,
  numericos, Db, DBTables, ComCtrls, Grids, DBGrids, Tabela, DBKeyViolation;

type
  TFReajusteContrato = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BReajuste: TBitBtn;
    PanelColor3: TPanelColor;
    Label4: TLabel;
    DataInicial: TCalendario;
    DataFinal: TCalendario;
    CPeriodo: TCheckBox;
    GReajusteItem: TGridIndice;
    Splitter1: TSplitter;
    GReajuste: TGridIndice;
    REAJUSTECONTRATOCORPO: TQuery;
    DataREAJUSTECONTRATOCORPO: TDataSource;
    REAJUSTECONTRATOCORPOMESREAJUSTE: TIntegerField;
    REAJUSTECONTRATOCORPOANOREAJUSTE: TIntegerField;
    REAJUSTECONTRATOCORPOINDICEREAJUSTE: TFloatField;
    REAJUSTECONTRATOCORPODATREAJUSTE: TDateTimeField;
    REAJUSTECONTRATOCORPOC_NOM_USU: TStringField;
    REAJUSTECONTRATOITEM: TQuery;
    DataREAJUSTECONTRATOITEM: TDataSource;
    REAJUSTECONTRATOITEMCODFILIALCONTRATO: TIntegerField;
    REAJUSTECONTRATOITEMSEQCONTRATO: TIntegerField;
    REAJUSTECONTRATOITEMNUMCONTRATO: TStringField;
    REAJUSTECONTRATOITEMC_NOM_CLI: TStringField;
    REAJUSTECONTRATOITEMVALCONTRATO: TFloatField;
    REAJUSTECONTRATOITEMDATASSINATURA: TDateField;
    REAJUSTECONTRATOITEMNOMTIPOCONTRATO: TStringField;
    REAJUSTECONTRATOCORPOSEQREAJUSTE: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BReajusteClick(Sender: TObject);
    procedure CPeriodoClick(Sender: TObject);
    procedure GReajusteOrdem(Ordem: String);
    procedure REAJUSTECONTRATOCORPOAfterScroll(DataSet: TDataSet);
    procedure GReajusteItemOrdem(Ordem: String);
  private
    VprOrdemCorpo,
    VprOrdemItens: String;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
  public

  end;

var
  FReajusteContrato: TFReajusteContrato;

implementation

uses APrincipal, FunData, Funsql, Funstring, ConstMsg,
  ANovoReajusteContrato;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFReajusteContrato.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  DataInicial.Date:= PrimeiroDiaMes(date);
  DataFinal.Date:= UltimoDiaMes(Date);
  VprOrdemCorpo:= ' ORDER BY DATREAJUSTE';
  VprOrdemItens:= ' ORDER BY C_NOM_CLI';  
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFReajusteContrato.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFReajusteContrato.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFReajusteContrato.BReajusteClick(Sender: TObject);
begin
  FNovoReajusteContrato:= TFNovoReajusteContrato.CriarSDI(Application,'',True);
  if FNovoReajusteContrato.ReajustaContratos then
    AtualizaConsulta;
  FNovoReajusteContrato.Free;
end;

{******************************************************************************}
procedure TFReajusteContrato.AtualizaConsulta;
begin
  REAJUSTECONTRATOCORPO.SQL.Clear;
  REAJUSTECONTRATOCORPO.SQL.Add('SELECT'+
                                ' RCC.SEQREAJUSTE,'+
                                ' RCC.ANOREAJUSTE, RCC.MESREAJUSTE, RCC.INDICEREAJUSTE,'+
                                ' RCC.DATREAJUSTE, USU.C_NOM_USU'+
                                ' FROM'+
                                ' REAJUSTECONTRATOCORPO RCC, CADUSUARIOS USU'+
                                ' WHERE'+
                                ' RCC.CODUSUARIO = USU.I_COD_USU');
  AdicionaFiltros(REAJUSTECONTRATOCORPO.SQL);
  REAJUSTECONTRATOCORPO.SQL.Add(VprOrdemCorpo);
  GReajuste.ALinhaSQLOrderBy:= REAJUSTECONTRATOCORPO.SQL.Count-1;
  REAJUSTECONTRATOCORPO.Open;
end;

{******************************************************************************}
procedure TFReajusteContrato.AdicionaFiltros(VpaSelect: TStrings);
begin
  if CPeriodo.Checked then
    VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('DATREAJUSTE',DataInicial.DateTime,IncDia(DataFinal.DateTime,1),True));
end;

{******************************************************************************}
procedure TFReajusteContrato.CPeriodoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFReajusteContrato.GReajusteOrdem(Ordem: String);
begin
  VprOrdemCorpo:= Ordem;
end;

{******************************************************************************}
procedure TFReajusteContrato.REAJUSTECONTRATOCORPOAfterScroll(DataSet: TDataSet);
begin
  REAJUSTECONTRATOITEM.SQL.Clear;
  REAJUSTECONTRATOITEM.SQL.Add('SELECT'+
                               ' RCI.CODFILIALCONTRATO, RCI.SEQCONTRATO,'+
                               ' CTC.NUMCONTRATO, CLI.C_NOM_CLI, TIP.NOMTIPOCONTRATO,'+
                               ' RCI.VALCONTRATO,  CTC.DATASSINATURA'+
                               ' FROM'+
                               ' REAJUSTECONTRATOITEM RCI, CONTRATOCORPO CTC,'+
                               ' CADCLIENTES CLI, TIPOCONTRATO TIP'+
                               ' WHERE'+
                               ' CTC.CODFILIAL = RCI.CODFILIALCONTRATO'+
                               ' AND CTC.SEQCONTRATO = RCI.SEQCONTRATO'+
                               ' AND CLI.I_COD_CLI = CTC.CODCLIENTE'+
                               ' AND TIP.CODTIPOCONTRATO = CTC.CODTIPOCONTRATO'+
                               ' AND RCI.SEQREAJUSTE = '+REAJUSTECONTRATOCORPOSEQREAJUSTE.AsString);
  REAJUSTECONTRATOITEM.SQL.Add(VprOrdemItens);
  GReajusteItem.ALinhaSQLOrderBy:= REAJUSTECONTRATOITEM.SQL.Count-1;
  REAJUSTECONTRATOITEM.Open;
end;

{******************************************************************************}
procedure TFReajusteContrato.GReajusteItemOrdem(Ordem: String);
begin
  VprOrdemItens:= Ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFReajusteContrato]);
end.
