unit ALocalizaFracaoOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, StdCtrls, Buttons, Localizacao, Mask, numericos, UnDadosProduto,
  Db, DBTables, UnOrdemproducao, DBClient;

type
  TFLocalizaFracaoOP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    PanelColor2: TPanelColor;
    Label7: TLabel;
    Label15: TLabel;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    ENumeroOp: Tnumerico;
    EFilial: TEditLocaliza;
    Localiza: TConsultaPadrao;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    EProduto: TEditLocaliza;
    Fracoes: TSQL;
    DataFracoes: TDataSource;
    FracoesCODFILIAL: TFMTBCDField;
    FracoesSEQORDEM: TFMTBCDField;
    FracoesSEQFRACAO: TFMTBCDField;
    FracoesINDPLANOCORTE: TWideStringField;
    FracoesC_COD_PRO: TWideStringField;
    FracoesC_NOM_PRO: TWideStringField;
    CNaoAdicionados: TCheckBox;
    BAdicionar: TBitBtn;
    FracoesSEQPRODUTO: TFMTBCDField;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EFilialFimConsulta(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure BAdicionarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprOrdem : string;
    VprPlanoCorte : TRBDPlanoCorteCorpo;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
    function LocalizaFracao(VpaDPlanoCorte : TRBDPlanoCorteCorpo):boolean;
  end;

var
  FLocalizaFracaoOP: TFLocalizaFracaoOP;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFLocalizaFracaoOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by PRO.C_COD_PRO ';
  VprAcao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFLocalizaFracaoOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFLocalizaFracaoOP.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
function TFLocalizaFracaoOP.LocalizaFracao(VpaDPlanoCorte : TRBDPlanoCorteCorpo):boolean;
begin
  VprPlanoCorte := VpaDPlanoCorte;
  EFilial.AInteiro := VprPlanoCorte.CodFilial;
  EFilial.Atualiza;
//  ENumeroOp.AsInteger := VpaDPlanoCorte.SeqOrdemProducao;
  showmodal;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := Fracoes.GetBookmark;
  Fracoes.close;
  Fracoes.sql.clear;
  Fracoes.sql.add('select FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO,  INDPLANOCORTE, '+
                  ' FRA.SEQPRODUTO, '+
                  ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                  ' from FRACAOOP FRA, CADPRODUTOS PRO '+
                  ' WHERE FRA.SEQPRODUTO = PRO.I_SEQ_PRO ');
  AdicionaFiltros(Fracoes.sql);
  Fracoes.Sql.add(VprOrdem);
  GridIndice1.ALinhaSQLOrderBy := Fracoes.SQL.count-1;
  Fracoes.open;
  try
    Fracoes.GotoBookmark(VpfPosicao);
  except
  end;
  Fracoes.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.AdicionaFiltros(VpaSelect : TStrings);
begin
  if EFilial.AInteiro <> 0 then
    VpaSelect.Add('and FRA.CODFILIAL = '+ EFilial.Text);
  if ENumeroOp.AsInteger <> 0 then
    VpaSelect.Add('and FRA.SEQORDEM = '+ENumeroOp.Text);
  if VprPlanoCorte.SeqMateriaPrima <> 0 then
    VpaSelect.add(' and exists(Select FRC.CODFILIAL FROM FRACAOOPCONSUMO FRC '+
                  ' Where FRA.CODFILIAL = FRC.CODFILIAL '+
                  ' AND FRA.SEQORDEM = FRC.SEQORDEM '+
                  ' AND FRA.SEQFRACAO = FRC.SEQFRACAO '+
                  ' AND FRC.SEQPRODUTO = '+IntToStr(VprPlanoCorte.SeqMateriaPrima)+')');
  if CNaoAdicionados.Checked then
    VpaSelect.add('AND FRA.INDPLANOCORTE = ''N''');


end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.EFilialFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprPlanoCorte.SeqMateriaPrima := StrToInt(Retorno1)
  else
    VprPlanoCorte.SeqMateriaPrima := 0;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.BAdicionarClick(Sender: TObject);
var
  VpfDFracao : TRBDPlanoCorteFracao;
begin
  if FracoesSEQPRODUTO.AsInteger <> 0 then
  begin
    VpfDFracao :=  FunOrdemProducao.AdicionaFracaoPlanoCorte(VprPlanoCorte,FracoesSEQPRODUTO.AsInteger,FracoesC_COD_PRO.AsString,FracoesC_NOM_PRO.AsString);
    VpfDFracao.CodFilial := FracoesCODFILIAL.AsInteger;
    VpfDFracao.SeqOrdem := FracoesSEQORDEM.AsInteger;
    VpfDFracao.SeqFracao := FracoesSEQFRACAO.AsInteger;
    FunOrdemProducao.SetaPlanoCorteGerado(FracoesCODFILIAL.AsInteger,FracoesSEQORDEM.AsInteger,FracoesSEQFRACAO.AsInteger,true);
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFLocalizaFracaoOP]);
end.
