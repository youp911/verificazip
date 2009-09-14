unit AColetaFracaoOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, UnOrdemProducao,
  DBKeyViolation, ComCtrls, Db, DBTables, StdCtrls, Localizacao, Buttons,
  Mask, numericos, Menus;

type
  TFColetaFracaoOP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Paginas: TPageControl;
    PColetas: TTabSheet;
    GColetas: TGridIndice;
    PanelColor3: TPanelColor;
    PFracoes: TTabSheet;
    Coletas: TQuery;
    DataColetas: TDataSource;
    ColetasDATINICIO: TDateTimeField;
    ColetasDATFIM: TDateTimeField;
    ColetasCODFILIAL: TIntegerField;
    ColetasSEQORDEM: TIntegerField;
    ColetasSEQFRACAO: TIntegerField;
    ColetasSEQESTAGIO: TIntegerField;
    ColetasSEQCOLETA: TIntegerField;
    ColetasQTDCOLETADO: TFloatField;
    ColetasDESUM: TStringField;
    ColetasQTDPRODUCAOIDEAL: TFloatField;
    ColetasQTDPRODUCAOHORA: TFloatField;
    ColetasPERPRODUTIVIDADE: TIntegerField;
    ColetasNOMCELULA: TStringField;
    ColetasDATA: TDateTimeField;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    ColetasDESESTAGIO: TStringField;
    Localiza: TConsultaPadrao;
    Label9: TLabel;
    SpeedButton5: TSpeedButton;
    Label10: TLabel;
    ECelulaTrabalho: TEditLocaliza;
    BCadastrar: TBitBtn;
    BExcluir: TBitBtn;
    BFechar: TBitBtn;
    ColetasCODCELULA: TIntegerField;
    PanelColor1: TPanelColor;
    GridIndice2: TGridIndice;
    Excesso: TQuery;
    DataExcesso: TDataSource;
    ExcessoCODFILIAL: TIntegerField;
    ExcessoSEQORDEM: TIntegerField;
    ExcessoSEQFRACAO: TIntegerField;
    ExcessoSEQESTAGIO: TIntegerField;
    ExcessoQTDPRODUZIDO: TFloatField;
    ExcessoQTDPRODUTO: TFloatField;
    ExcessoC_NOM_PRO: TStringField;
    ExcessoDESESTAGIO: TStringField;
    ExcessoNOMCELULA: TStringField;
    ExcessoPerAcrescimo: TFloatField;
    EPerAcrescimo: Tnumerico;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    EProduto: TEditLocaliza;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label6: TLabel;
    EIDEstagio: TEditLocaliza;
    PProcessosColetados: TTabSheet;
    GridIndice3: TGridIndice;
    ProcessosColetados: TQuery;
    DataProcessosColetados: TDataSource;
    ProcessosColetadosC_NOM_PRO: TStringField;
    ProcessosColetadosSEQESTAGIO: TIntegerField;
    ProcessosColetadosDESESTAGIO: TStringField;
    ProcessosColetadosQTDCELULA: TIntegerField;
    ProcessosColetadosQTDCOLETAS: TIntegerField;
    ProcessosColetadosQTDCOLETADO: TFloatField;
    ProcessosColetadosTOTALMINUTOS: TIntegerField;
    Aux: TQuery;
    ProcessosColetadosI_SEQ_PRO: TIntegerField;
    ProcessosColetadosProdutividade: TFloatField;
    PopupMenu1: TPopupMenu;
    AlterarEstgiosProduto1: TMenuItem;
    ColetasPRODUTO: TStringField;
    ColetasI_SEQ_PRO: TIntegerField;
    BExtratoCelula: TBitBtn;
    BExtratoProduto: TBitBtn;
    PProdutividadeTipoEstagio: TTabSheet;
    PanelColor6: TPanelColor;
    ProdutividadeEstagio: TQuery;
    DataProdutividadeEstagio: TDataSource;
    GridIndice1: TGridIndice;
    ProdutividadeEstagioNOMEST: TStringField;
    ProdutividadeEstagioNOMCELULA: TStringField;
    ProdutividadeEstagioQTDCOLETAS: TIntegerField;
    ProdutividadeEstagioPRODUTIVIDADE: TFloatField;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    Label12: TLabel;
    ETipoEstagio: TEditLocaliza;
    PProdutividadeEstagio: TTabSheet;
    ProdutividadeEstagioProduto: TQuery;
    DataProdutividadeEstagioProduto: TDataSource;
    ProdutividadeEstagioProdutoSEQESTAGIO: TIntegerField;
    ProdutividadeEstagioProdutoDESESTAGIO: TStringField;
    ProdutividadeEstagioProdutoNOMCELULA: TStringField;
    ProdutividadeEstagioProdutoQTDCOLETAS: TIntegerField;
    ProdutividadeEstagioProdutoPRODUTIVIDADE: TFloatField;
    GridIndice4: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaginasChange(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure ExcessoCalcFields(DataSet: TDataSet);
    procedure EPerAcrescimoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EIDEstagioSelect(Sender: TObject);
    procedure ProcessosColetadosCalcFields(DataSet: TDataSet);
    procedure AlterarEstgiosProduto1Click(Sender: TObject);
    procedure BExtratoCelulaClick(Sender: TObject);
    procedure BExtratoProdutoClick(Sender: TObject);
  private
    { Private declarations }
    VprSeqProduto : Integer;
    VprOrdemColeta : String;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    function RProdutividadeEstagio(VpaDataInicio, VpaDatFim : TDateTime;VpaSeqProduto,VpaSeqEstagio, VpaCodCelula, VpaTotalMinutos : Integer):Integer;
    procedure AtualizaConsultaColeta;
    procedure AdicionaFiltroColeta(VpaConsulta : TStrings);
    procedure AtualizaConsultaProducaoExcesso;
    procedure AdicinaFiltroProducaoExcesso(VpaConsulta : TStrings);
    procedure AtualizaConsutlaProcessosColetados;
    procedure AdicionaFiltroProcessosColetados(VpaConsulta : TStrings);
    procedure AtualizaConsultaProdutividadeEstagio;
    procedure AdicionaFiltroProdutividadeEstagio(VpaConsulta : TStrings);
    procedure AtualizaConsultaProdutividadeEstagioProduto;
    procedure AdicionaFiltroProdutividadeEstagioProduto(VpaConsulta : TStrings);
  public
    { Public declarations }
  end;

var
  FColetaFracaoOP: TFColetaFracaoOP;

implementation

uses APrincipal, FunSql, FunData, ANovaColetaFracaoOP, ConstMsg, FunNumeros,
  unCrystal, Constantes, ANovoProdutoPro;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFColetaFracaoOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  Paginas.ActivePageIndex := 0;
  EDatInicio.DateTime := date;
  EDatFim.DateTime := date;
  VprSeqProduto := 0;
  VprOrdemColeta := 'order by CEL.NOMCELULA, COL.DATINICIO';
  AtualizaConsultaColeta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFColetaFracaoOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Coletas.close;
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFColetaFracaoOP.RProdutividadeEstagio(VpaDataInicio, VpaDatFim : TDateTime;VpaSeqProduto,VpaSeqEstagio,VpaCodCelula,VpaTotalMinutos : Integer):Integer;
var
  VpfPerTempo : double;
  VpfCelula : String;
begin
  result := 0;
  if VpaCodCelula <> 0 then
    VpfCelula := ' and COL.CODCELULA = '+IntToStr(VPACODCelula);
  AdicionaSQLAbreTabela(Aux,'Select COL.QTDMINUTOS, COL.PERPRODUTIVIDADE  '+
                           ' from COLETAFRACAOOP COL, FRACAOOPESTAGIO FRE '+
                           ' Where COL.CODFILIAL = FRE.CODFILIAL '+
                           ' AND COL.SEQORDEM = FRE.SEQORDEM '+
                           ' AND COL.SEQFRACAO = FRE.SEQFRACAO '+
                           ' AND COL.SEQESTAGIO = FRE.SEQESTAGIO '+
                            SQLTextoDataEntreAAAAMMDD('DATINICIO',VpaDataInicio,IncDia(VpaDatFim,1),true)+
                           ' AND FRE.SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                           ' AND FRE.SEQESTAGIO = '+IntToStr(VpaSeqEstagio)+
                           VpfCelula);
  While not Aux.Eof do
  begin
    VpfPerTempo := (Aux.FieldByName('QTDMINUTOS').AsInteger * 100)/VpaTotalMinutos;
    result := result +RetornaInteiro((Aux.FieldByName('PERPRODUTIVIDADE').AsInteger * VpfperTempo)/100);
    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AtualizaConsultaColeta;
begin
  Coletas.Sql.Clear;
  Coletas.Sql.add('SELECT COL.DATINICIO DATA, COL.DATINICIO, COL.DATFIM, COL.CODFILIAL, COL.SEQORDEM, '+
                  ' COL.SEQFRACAO, COL.SEQESTAGIO, COL.SEQCOLETA, COL.QTDCOLETADO,'+
                  ' COL.DESUM, COL.QTDPRODUCAOIDEAL, COL.QTDPRODUCAOHORA, COL.PERPRODUTIVIDADE, ' +
                  ' CEL.CODCELULA, CEL.NOMCELULA, '+
                  ' PRO.C_COD_PRO ||''-''|| PRO.C_NOM_PRO PRODUTO, PRO.I_SEQ_PRO,  '+
                  ' ESP.DESESTAGIO '+
                  ' FROM COLETAFRACAOOP COL, CELULATRABALHO CEL, FRACAOOPESTAGIO FRE, CADPRODUTOS PRO, PRODUTOESTAGIO ESP '+
                  ' WHERE COL.CODCELULA = CEL.CODCELULA '+
                  ' AND COL.CODFILIAL = FRE.CODFILIAL '+
                  ' AND COL.SEQORDEM = FRE.SEQORDEM '+
                  ' AND COL.SEQFRACAO = FRE.SEQFRACAO '+
                  ' AND COL.SEQESTAGIO = FRE.SEQESTAGIO '+
                  ' AND FRE.SEQPRODUTO = PRO.I_SEQ_PRO'+
                  ' AND FRE.SEQPRODUTO = ESP.SEQPRODUTO '+
                  ' AND FRE.SEQESTAGIO = ESP.SEQESTAGIO');
  AdicionaFiltroColeta(Coletas.sql);
  Coletas.sql.add(VprOrdemColeta);
  Coletas.SQL.SaveToFile('c:\consulta.sql');
  Coletas.open;
  GColetas.ALinhaSQLOrderBy := Coletas.SQL.Count - 1;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AdicionaFiltroColeta(VpaConsulta : TStrings);
begin
  VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
  if ECelulaTrabalho.AInteiro <> 0 then
    VpaConsulta.Add(' AND COL.CODCELULA = '+ECelulaTrabalho.Text);
  if VprSeqProduto <> 0 then
    VpaConsulta.Add(' AND PRO.I_SEQ_PRO = '+IntToStr(VprSeqProduto));
  if EIDEstagio.AInteiro <> 0 then
    VpaConsulta.add(' AND FRE.SEQESTAGIO = '+EIDEstagio.Text);
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AtualizaConsultaProducaoExcesso;
begin
  exit;
  Excesso.Sql.clear;
  Excesso.sql.add('select FRE.CODFILIAL, FRE.SEQORDEM,FRE.SEQFRACAO, FRE.SEQESTAGIO, FRE.QTDPRODUZIDO, '+
                  ' FRA.QTDPRODUTO, '+
                  ' PRO.C_NOM_PRO, '+
                  ' ESP.DESESTAGIO, '+
                  ' CEL.NOMCELULA '+
                  ' from FRACAOOPESTAGIO FRE, FRACAOOP FRA, COLETAFRACAOOP COL, PRODUTOESTAGIO ESP, CADPRODUTOS PRO, CELULATRABALHO CEL '+
                  ' WHERE FRE.CODFILIAL = COL.CODFILIAL '+
                  ' AND FRE.SEQORDEM = COL.SEQORDEM ' +
                  ' AND FRE.SEQFRACAO = COL.SEQFRACAO ' +
                  ' AND FRE.SEQESTAGIO = COL.SEQESTAGIO '+
                  ' AND FRE.CODFILIAL = FRA.CODFILIAL '+
                  ' AND FRE.SEQORDEM = FRA.SEQORDEM '+
                  ' AND FRE.SEQFRACAO = FRA.SEQFRACAO '+
                  ' AND FRE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                  ' AND FRE.SEQPRODUTO = ESP.SEQPRODUTO '+
                  ' AND FRE.SEQESTAGIO = ESP.SEQESTAGIO '+
                  ' AND COL.CODCELULA = CEL.CODCELULA');
  AdicinaFiltroProducaoExcesso(Excesso.sql);
  Excesso.open;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AdicinaFiltroProducaoExcesso(VpaConsulta : TStrings);
begin
  VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
  if ECelulaTrabalho.AInteiro <> 0 then
    VpaConsulta.Add(' AND COL.CODCELULA = '+ECelulaTrabalho.Text);
  VpaConsulta.add(' and ((FRE.QTDPRODUZIDO * 100)/FRA.QTDPRODUTO)-100 > '+EPerAcrescimo.Text);
  if VprSeqProduto <> 0 then
    VpaConsulta.Add(' AND PRO.I_SEQ_PRO = '+IntToStr(VprSeqProduto));
  if EIDEstagio.AInteiro <> 0 then
    VpaConsulta.add(' AND FRE.SEQESTAGIO = '+EIDEstagio.Text);
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AtualizaConsutlaProcessosColetados;
begin
  ProcessosColetados.Sql.clear;
  ProcessosColetados.Sql.add('select PRO.I_SEQ_PRO, PRO.C_NOM_PRO, ESP.SEQESTAGIO, ESP.DESESTAGIO, COUNT(DISTINCT(COL.CODCELULA)) QTDCELULA, '+
                            ' COUNT(COL.CODCELULA) QTDCOLETAS, SUM(COL.QTDCOLETADO) QTDCOLETADO, SUM(COL.QTDMINUTOS) TOTALMINUTOS ' +
                            ' from COLETAFRACAOOP COL, FRACAOOPESTAGIO FRE, PRODUTOESTAGIO ESP, CADPRODUTOS PRO '+
                            ' WHERE COL.CODFILIAL = FRE.CODFILIAL '+
                            ' AND COL.SEQORDEM = FRE.SEQORDEM '+
                            ' AND COL.SEQFRACAO = FRE.SEQFRACAO '+
                            ' AND COL.SEQESTAGIO = FRE.SEQESTAGIO '+
                            ' AND FRE.SEQPRODUTO = ESP.SEQPRODUTO '+
                            ' AND FRE.SEQESTAGIO = ESP.SEQESTAGIO '+
                            ' AND FRE.SEQPRODUTO = PRO.I_SEQ_PRO ');
  AdicionaFiltroProcessosColetados(ProcessosColetados.SQL);
  ProcessosColetados.Sql.add('GROUP BY  PRO.I_SEQ_PRO,PRO.C_NOM_PRO, ESP.SEQESTAGIO, ESP.DESESTAGIO '+
                               ' ORDER BY 2,3 ');
  ProcessosColetados.sql.saveToFile('c:\Consulta.sql');
  ProcessosColetados.open;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AdicionaFiltroProcessosColetados(VpaConsulta : TStrings);
begin
  VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
  if ECelulaTrabalho.AInteiro <> 0 then
    VpaConsulta.Add(' AND COL.CODCELULA = '+ECelulaTrabalho.Text);
  if VprSeqProduto <> 0 then
    VpaConsulta.Add(' AND PRO.I_SEQ_PRO = '+IntToStr(VprSeqProduto));
  if EIDEstagio.AInteiro <> 0 then
    VpaConsulta.add(' AND FRE.SEQESTAGIO = '+EIDEstagio.Text);
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AtualizaConsultaProdutividadeEstagio;
begin
  ProdutividadeEstagio.sql.clear;
  ProdutividadeEstagio.sql.add('select EST.NOMEST, CEL.NOMCELULA, COUNT(COL.CODCELULA) QTDCOLETAS,  AVG(COL.PERPRODUTIVIDADE) PRODUTIVIDADE '+
                               ' from COLETAFRACAOOP COL, FRACAOOPESTAGIO FRE, PRODUTOESTAGIO ESP, ESTAGIOPRODUCAO EST, CELULATRABALHO CEL '+
                               ' WHERE COL.CODFILIAL = FRE.CODFILIAL '+
                               ' AND COL.SEQORDEM = FRE.SEQORDEM '+
                               ' AND COL.SEQFRACAO = FRE.SEQFRACAO '+
                               ' AND COL.SEQESTAGIO = FRE.SEQESTAGIO '+
                               ' AND FRE.SEQPRODUTO = ESP.SEQPRODUTO '+
                               ' AND FRE.SEQESTAGIO = ESP.SEQESTAGIO '+
                               ' AND COL.CODCELULA = CEL.CODCELULA ' +
                               ' AND ESP.CODESTAGIO = EST.CODEST ');
  AdicionaFiltroProdutividadeEstagio(ProdutividadeEstagio.sql);
  ProdutividadeEstagio.sql.add('GROUP BY  EST.NOMEST, CEL.NOMCELULA' +
                               ' ORDER BY 1, 4 desc');
  ProdutividadeEstagio.sql.saveToFile('c:\Consulta.sql');
  ProdutividadeEstagio.open;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AdicionaFiltroProdutividadeEstagio(VpaConsulta : TStrings);
begin
  VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
  if ECelulaTrabalho.AInteiro <> 0 then
    VpaConsulta.Add(' AND COL.CODCELULA = '+ECelulaTrabalho.Text);
  if VprSeqProduto <> 0 then
    VpaConsulta.Add(' AND ESP.SEQPRODUTO = '+IntToStr(VprSeqProduto));
  if EIDEstagio.AInteiro <> 0 then
    VpaConsulta.add(' AND FRE.SEQESTAGIO = '+EIDEstagio.Text);
  if ETipoEstagio.AInteiro <> 0 then
    VpaConsulta.add(' AND EST.CODEST = '+ETipoEstagio.Text);
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AtualizaConsultaProdutividadeEstagioProduto;
begin
  ProdutividadeEstagioProduto.Sql.Clear;
  ProdutividadeEstagioProduto.sql.add('select ESP.SEQESTAGIO, ESP.DESESTAGIO, CEL.NOMCELULA, COUNT(COL.CODCELULA) QTDCOLETAS,  AVG(COL.PERPRODUTIVIDADE) PRODUTIVIDADE '+
                                  ' from COLETAFRACAOOP COL, FRACAOOPESTAGIO FRE, PRODUTOESTAGIO ESP,  CELULATRABALHO CEL ' +
                                  ' WHERE COL.CODFILIAL = FRE.CODFILIAL ' +
                                  ' AND COL.SEQORDEM = FRE.SEQORDEM '+
                                  ' AND COL.SEQFRACAO = FRE.SEQFRACAO '+
                                  ' AND COL.SEQESTAGIO = FRE.SEQESTAGIO '+
                                  ' AND FRE.SEQPRODUTO = ESP.SEQPRODUTO '+
                                  ' AND FRE.SEQESTAGIO = ESP.SEQESTAGIO '+
                                  ' AND COL.CODCELULA = CEL.CODCELULA ');
  AdicionaFiltroProdutividadeEstagioProduto(ProdutividadeEstagioProduto.Sql);
  ProdutividadeEstagioProduto.sql.add('GROUP BY  ESP.SEQESTAGIO , ESP.DESESTAGIO, CEL.NOMCELULA '+
                                  ' ORDER BY 1, 5 desc ');
  ProdutividadeEstagioProduto.sql.SavetoFile('c:\consulta.sql');
  ProdutividadeEstagioProduto.open;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AdicionaFiltroProdutividadeEstagioProduto(VpaConsulta : TStrings);
begin
  VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
  if ECelulaTrabalho.AInteiro <> 0 then
    VpaConsulta.Add(' AND COL.CODCELULA = '+ECelulaTrabalho.Text);
  if VprSeqProduto <> 0 then
    VpaConsulta.Add(' AND ESP.SEQPRODUTO = '+IntToStr(VprSeqProduto));
  if EIDEstagio.AInteiro <> 0 then
    VpaConsulta.add(' AND FRE.SEQESTAGIO = '+EIDEstagio.Text);
end;

{******************************************************************************}
procedure TFColetaFracaoOP.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PColetas then
    AtualizaConsultaColeta
  else
    if Paginas.ActivePage = PFracoes then
      AtualizaConsultaProducaoExcesso
    else
      if Paginas.ActivePage = PProcessosColetados then
        AtualizaConsutlaProcessosColetados
      else
        if Paginas.ActivePage = PProdutividadeTipoEstagio then
          AtualizaConsultaProdutividadeEstagio
        else
          if Paginas.ActivePage = PProdutividadeEstagio then
            AtualizaConsultaProdutividadeEstagioProduto;

end;

{******************************************************************************}
procedure TFColetaFracaoOP.BCadastrarClick(Sender: TObject);
begin
  FNovaColetaFracaoOP := TFNovaColetaFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaColetaFracaoOP'));
  FNovaColetaFracaoOP.NovaColeta;
  FNovaColetaFracaoOP.free;
  AtualizaConsultaColeta;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.BExcluirClick(Sender: TObject);
begin
  IF ColetasSEQORDEM.AsInteger <> 0 then
    if confirmacao('EXCLUIR COLETA!!!'#13'Tem certeza que deseja excluir a coleta ?') then
    begin
      FunOrdemProducao.ExcluiColetaFracaoOP(ColetasCODFILIAL.AsInteger,ColetasSEQORDEM.AsInteger,ColetasSEQFRACAO.AsInteger,ColetasSEQESTAGIO.AsInteger,ColetasSEQCOLETA.AsInteger);
      AtualizaConsultaColeta;
    end;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.ExcessoCalcFields(DataSet: TDataSet);
begin
  ExcessoPerAcrescimo.AsFloat := ((ExcessoQTDPRODUZIDO.AsFloat * 100)/ExcessoQTDPRODUTO.AsFloat)-100;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.EPerAcrescimoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsultaProducaoExcesso;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqProduto := StrToInt(Retorno1)
  else
    VprSeqProduto := 0;
  PaginasChange(Paginas);
end;

{******************************************************************************}
procedure TFColetaFracaoOP.EIDEstagioSelect(Sender: TObject);
begin
  EIDEstagio.ASelectValida.Text := 'Select ESP.SEQESTAGIO, ESP.DESESTAGIO FROM PRODUTOESTAGIO ESP '+
                                   ' Where SEQPRODUTO = '+IntToStr(VprSeqProduto)+
                                   ' AND SEQESTAGIO = @ ';
  EIDEstagio.ASelectLocaliza.Text := 'Select ESP.SEQESTAGIO, ESP.DESESTAGIO FROM PRODUTOESTAGIO ESP '+
                                   ' Where SEQPRODUTO = '+IntToStr(VprSeqProduto)+
                                   ' AND DESESTAGIO LIKE ''@%''';
end;

{******************************************************************************}
procedure TFColetaFracaoOP.ProcessosColetadosCalcFields(DataSet: TDataSet);
begin
  ProcessosColetadosProdutividade.AsFloat := RProdutividadeEstagio(EDatInicio.DateTime,EDatFim.DateTime, ProcessosColetadosI_SEQ_PRO.AsInteger,ProcessosColetadosSEQESTAGIO.AsInteger,ECelulaTrabalho.AInteiro, ProcessosColetadosTOTALMINUTOS.AsInteger);
end;

{******************************************************************************}
procedure TFColetaFracaoOP.AlterarEstgiosProduto1Click(Sender: TObject);
var
  codigo, desc, Path, kit, cifraoMoeda, sequencial : string;
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  if FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,ColetasI_SEQ_PRO.AsInteger) <> nil then
    FunOrdemProducao.RegeraFracaoOPEstagio(ColetasI_SEQ_PRO.AsInteger);
  FNovoProdutoPro.free;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.BExtratoCelulaClick(Sender: TObject);
begin
  if ColetasCODFILIAL.AsInteger <> 0 then
  begin
    FunCrystal.ImprimeRelatorio(Varia.PathRelatorios+ '\Ordem Produção\XX_Extrato Coleta Fracao Usuario.rpt',[FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime),FormatDateTime('DD/MM/YYYY',EDatFim.DateTime),ColetasCODCELULA.AsString,ColetasNOMCELULA.AsString]);
  end;
end;

{******************************************************************************}
procedure TFColetaFracaoOP.BExtratoProdutoClick(Sender: TObject);
begin
  if ColetasCODFILIAL.AsInteger <> 0 then
  begin
    FunCrystal.ImprimeRelatorio(Varia.PathRelatorios+ '\Ordem Produção\XX_Extrato Coleta Fracao Produto.rpt',[FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime),FormatDateTime('DD/MM/YYYY',EDatFim.DateTime),ColetasI_SEQ_PRO.AsString,ColetasPRODUTO.AsString,ColetasSEQESTAGIO.AsString,ColetasDESESTAGIO.AsString]);
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFColetaFracaoOP]);
end.

