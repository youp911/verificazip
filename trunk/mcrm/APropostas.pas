unit APropostas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, ComCtrls, StdCtrls, Db, DBTables, Buttons, UnDados, UnProposta,
  UnProspect, UnCrystal, Localizacao, Graficos, Mask, numericos, Menus, DBClient;

type
  TFPropostas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    PanelColor2: TPanelColor;
    Label3: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label4: TLabel;
    Proposta: TSQL;
    DataProposta: TDataSource;
    PropostaCODFILIAL: TFMTBCDField;
    PropostaSEQPROPOSTA: TFMTBCDField;
    PropostaDATPROPOSTA: TSQLTimeStampField;
    PropostaDATPREVISAOCOMPRA: TSQLTimeStampField;
    PropostaINDCOMPROU: TWideStringField;
    PropostaINDCOMPROUCONCORRENTE: TWideStringField;
    PropostaVALTOTAL: TFMTBCDField;
    PropostaC_NOM_PAG: TWideStringField;
    PropostaNOMPROSPECT: TWideStringField;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    PropostaCODPROSPECT: TFMTBCDField;
    PGraficos: TCorPainelGra;
    BitBtn4: TBitBtn;
    PanelColor5: TPanelColor;
    Label17: TLabel;
    Label18: TLabel;
    BMeioDivulgacao: TBitBtn;
    BFechaGrafico: TBitBtn;
    BVendedor: TBitBtn;
    BProduto: TBitBtn;
    BData: TBitBtn;
    BFlag: TBitBtn;
    BCondicao: TBitBtn;
    BEstado: TBitBtn;
    GraficosTrio: TGraficosTrio;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    LNomVendedor: TLabel;
    EVendedor: TEditLocaliza;
    BGraficos: TBitBtn;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    EEstagio: TEditLocaliza;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    EProspect: TEditLocaliza;
    ConsultaPadrao1: TConsultaPadrao;
    PropostaNOMEST: TWideStringField;
    BGraEstagio: TBitBtn;
    Label7: TLabel;
    EProposta: Tnumerico;
    PopupMenu1: TPopupMenu;
    TelemarketingReceptivo1: TMenuItem;
    N1: TMenuItem;
    AlterarEstgio1: TMenuItem;
    N2: TMenuItem;
    GerarCotao1: TMenuItem;
    PropostaNOMSETOR: TWideStringField;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    Label9: TLabel;
    ESetor: TEditLocaliza;
    BEmail: TBitBtn;
    N3: TMenuItem;
    GerarOrcamentoCompras1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDatInicioExit(Sender: TObject);
    procedure BEmailClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BMeioDivulgacaoClick(Sender: TObject);
    procedure BGraficosClick(Sender: TObject);
    procedure BFechaGraficoClick(Sender: TObject);
    procedure BVendedorClick(Sender: TObject);
    procedure BProdutoClick(Sender: TObject);
    procedure BDataClick(Sender: TObject);
    procedure BFlagClick(Sender: TObject);
    procedure BCondicaoClick(Sender: TObject);
    procedure BEstadoClick(Sender: TObject);
    procedure BGraEstagioClick(Sender: TObject);
    procedure EPropostaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TelemarketingReceptivo1Click(Sender: TObject);
    procedure AlterarEstgio1Click(Sender: TObject);
    procedure GerarCotao1Click(Sender: TObject);
    procedure GerarOrcamentoCompras1Click(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    VprDProposta : TRBDPropostaCorpo;
    VprDProspect : TRBDProspect;
    FunProposta : TRBFuncoesProposta;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    function RRodapeGrafico : String;
    procedure GraficoMeioDivulgacao;
    procedure GraficoVendedor;
    procedure GraficoCidade;
    procedure GraficoRamoAtividade;
    procedure GraficoProfissao;
    procedure GraficoData;
    procedure GraficoUF;
    procedure GraficoEstagio;
  public
    { Public declarations }
    procedure ConsultaPropostasProspect(VpaCodProspect :Integer);
  end;

var
  FPropostas: TFPropostas;

implementation

uses APrincipal, funSql, funData, Constmsg, ANovaProposta, constantes,
  ANovoTelemarketingProspect, AAlteraEstagioProposta, ANovaCotacao,
  ANovoChamadoTecnico, ANovaSolicitacaoCompra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPropostas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta := TRBFuncoesProposta.cria(FPrincipal.BaseDados);
  VprDProposta := TRBDPropostaCorpo.cria;
  VprDProspect := TRBDProspect.cria;
  EDatInicio.Datetime := PrimeiroDiaMes(date);
  EDatFim.DAtetime := UltimoDiaMes(date);
  VprOrdem := ' order by PRO.DATPROPOSTA';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPropostas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta.Free;
  VprDProposta.free;
  VprDProspect.free;
  Proposta.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPropostas.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := Proposta.GetBookmark;
  Proposta.close;
  Proposta.sql.clear;
  Proposta.Sql.add('select PRO.CODFILIAL, PRO.SEQPROPOSTA, PRO.DATPROPOSTA, PRO.DATPREVISAOCOMPRA, '+
                   ' PRO.INDCOMPROU, PRO.INDCOMPROUCONCORRENTE, PRO.VALTOTAL,'+
                   ' PRO.CODPROSPECT,'+
                   ' CON.C_NOM_PAG, '+
                   ' PCT.NOMPROSPECT, '+
                   ' EST.NOMEST, '+
                   ' STR.NOMSETOR '+
                   ' from PROPOSTA PRO, CADCONDICOESPAGTO CON, PROSPECT PCT, ESTAGIOPRODUCAO EST, SETOR STR'+
                   ' Where PRO.CODCONDICAOPAGAMENTO = CON.I_COD_PAG '+
                   ' AND PRO.CODPROSPECT = PCT.CODPROSPECT '+
                   ' AND EST.CODEST = PRO.CODESTAGIO'+
                   ' AND PRO.CODSETOR *= STR.CODSETOR');
  AdicionaFiltros(Proposta.sql);
  Proposta.sql.add(VprOrdem);
  Proposta.open;
  try
    Proposta.GotoBookmark(VpfPosicao);
  except
  end;
  Proposta.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFPropostas.AdicionaFiltros(VpaSelect : TStrings);
begin
  if EProposta.AsInteger <> 0 then
    VpaSelect.Add(' AND SEQPROPOSTA = ' +EProposta.Text)
  else
  begin
    VpaSelect.add(SQLTextoDataEntreAAAAMMDD('DATPROPOSTA',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
    if EVendedor.Ainteiro <> 0 then
      VpaSelect.Add('AND PRO.CODVENDEDOR = ' +EVendedor.Text);
    if EProspect.AInteiro <> 0 then
      VpaSelect.Add('AND PRO.CODPROSPECT = '+EProspect.Text);
    if EEstagio.AInteiro <> 0 then
      VpaSelect.Add('AND PRO.CODESTAGIO = '+EEstagio.Text);
    if ESetor.AInteiro <> 0 then
      VpaSelect.Add('AND PRO.CODSETOR = '+ESetor.Text);
  end;
end;

{******************************************************************************}
function TFPropostas.RRodapeGrafico : String;
begin
  result := 'Período de :'+ FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' até : '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime);
  if EVendedor.AInteiro <> 0 then
    result := result + ' - Vendedor : '+ LNomVendedor.Caption;
end;

{******************************************************************************}
procedure TFPropostas.GraficoMeioDivulgacao;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, MEI.DESMEIODIVULGACAO MEIO '+
                    ' from PROPOSTA PRO, PROSPECT PCT, MEIODIVULGACAO MEI '+
                    ' Where PCT.CODMEIODIVULGACAO = MEI.CODMEIODIVULGACAO'+
                    ' AND PRO.CODPROSPECT = PCT.CODPROSPECT');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY MEIO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'MEIO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Meio Divulgação';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico das Propostas';
  graficostrio.info.TituloX := 'Meio Divulgação';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostas.GraficoVendedor;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, VEN.C_NOM_VEN VENDEDOR '+
                    ' from PROPOSTA PRO, CADVENDEDORES VEN '+
                    ' Where PRO.CODVENDEDOR = VEN.I_COD_VEN');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY VENDEDOR');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'VENDEDOR';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Vendedores';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Vendedor';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostas.GraficoCidade;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, PCT.DESCIDADE CIDADE '+
                    ' from PROPOSTA PRO, PROSPECT PCT '+
                    ' Where PRO.CODPROSPECT = PCT.CODPROSPECT ');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CIDADE order by 1 desc');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CIDADE';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Cidades';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'CIDADE';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostas.GraficoRamoAtividade;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, RAM.NOM_RAMO_ATIVIDADE AS CAMPO '+
                    ' from PROPOSTA PRO, PROSPECT PCT, RAMO_ATIVIDADE RAM '+
                    ' Where PCT.CODRAMOATIVIDADE *= RAM.COD_RAMO_ATIVIDADE '+
                    ' AND PRO.CODPROSPECT = PCT.CODPROSPECT');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO ORDER BY 2');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Ramo Atividades';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Ramo Atividade';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostas.GraficoProfissao;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, PRF.C_NOM_PRF CAMPO '+
                    ' from PROPOSTA PRO, PROSPECT PCT, CADPROFISSOES PRF '+
                    ' Where PCT.CODPROFISSAOCONTATO *= PRF.I_COD_PRF '+
                    '  AND PRO.CODPROSPECT = PCT.CODPROSPECT' );
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Profissão Contato';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Profissão Contato';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostas.GraficoData;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, dateformat(PRO.DATPROPOSTA,''DD/MM/YYYY'') CAMPO '+
                    ' from PROPOSTA PRO '+
                    ' Where PRO.SEQPROPOSTA = PRO.SEQPROPOSTA ');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Proposta - Data';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Data';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostas.GraficoUF;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, DESUF CAMPO '+
                    ' from PROPOSTA PRO, PROSPECT PCT '+
                    ' Where PRO.CODPROSPECT = PCT.CODPROSPECT ');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - UF';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'UF';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostas.GraficoEstagio;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, EST.NOMEST CAMPO '+
                    ' from PROPOSTA PRO, ESTAGIOPRODUCAO EST '+
                    ' Where  PRO.CODESTAGIO = EST.CODEST' );
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Estagios';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Estagio Proposta';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostas.ConsultaPropostasProspect(VpaCodProspect :Integer);
begin
  EProspect.AInteiro := VpaCodProspect;
  EDatInicio.DateTime := DecMes(PrimeiroDiaMes(date),3);
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFPropostas.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPropostas.BEmailClick(Sender: TObject);
begin
  aviso('Rotina desabilitada');
end;

{******************************************************************************}
procedure TFPropostas.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFPropostas.BConsultarClick(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    FNovaProposta.ConsultaProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    FNovaProposta.free;
  end;
end;

{******************************************************************************}
procedure TFPropostas.BCadastrarClick(Sender: TObject);
begin
  FNovaProposta := tFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
  if FNovaProposta.NovaProposta then
    AtualizaConsulta;
  FNovaProposta.free;
end;

{******************************************************************************}
procedure TFPropostas.BAlterarClick(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    if  FNovaProposta.AlteraProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger) then
      AtualizaConsulta;
    FNovaProposta.free;
  end;
end;

{******************************************************************************}
procedure TFPropostas.BImprimirClick(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
  begin
    FunCrystal.ImprimeRelatorio(Varia.PathRelatorios + '\CRM\XX_PropostaAntiga.rpt',[PropostaCODFILIAL.AsString,PropostaSEQPROPOSTA.AsString]);
  end;

end;

{******************************************************************************}
procedure TFPropostas.BMeioDivulgacaoClick(Sender: TObject);
begin
  GraficoMeioDivulgacao;
end;

{******************************************************************************}
procedure TFPropostas.BGraficosClick(Sender: TObject);
begin
  PanelColor1.Enabled := false;
  PanelColor2.Enabled := false;
  GridIndice1 .Enabled := false;
  PGraficos.Top := 50;
  PGraficos.Visible := true;
end;

{******************************************************************************}
procedure TFPropostas.BFechaGraficoClick(Sender: TObject);
begin
  PanelColor1.Enabled := true;
  PanelColor2.Enabled := true;
  GridIndice1 .Enabled := true;
  PGraficos.Visible := false;
end;

{******************************************************************************}
procedure TFPropostas.BVendedorClick(Sender: TObject);
begin
  GraficoVendedor;
end;

procedure TFPropostas.BProdutoClick(Sender: TObject);
begin
  GraficoCidade;
end;

{******************************************************************************}
procedure TFPropostas.BDataClick(Sender: TObject);
begin
  GraficoRamoAtividade;
end;

{******************************************************************************}
procedure TFPropostas.BFlagClick(Sender: TObject);
begin
  GraficoProfissao;
end;

{******************************************************************************}
procedure TFPropostas.BCondicaoClick(Sender: TObject);
begin
  GraficoData;
end;

{******************************************************************************}
procedure TFPropostas.BEstadoClick(Sender: TObject);
begin
  GraficoUF;
end;

{******************************************************************************}
procedure TFPropostas.BGraEstagioClick(Sender: TObject);
begin
  GraficoEstagio;
end;

{******************************************************************************}
procedure TFPropostas.EPropostaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPropostas.TelemarketingReceptivo1Click(Sender: TObject);
begin
  if not Proposta.Eof then
  begin
    FNovoTeleMarketingProspect:= TFNovoTeleMarketingProspect.CriarSDI(Application,'',True);
    FNovoTeleMarketingProspect.TeleMarketingProspect(PropostaCODPROSPECT.AsInteger);
    FNovoTeleMarketingProspect.Free;
  end;
end;

{******************************************************************************}
procedure TFPropostas.AlterarEstgio1Click(Sender: TObject);
begin
  if not PropostaCODFILIAL.AsInteger <> 0 then
  begin
    FAlteraEstagioProposta:= TFAlteraEstagioProposta.CriarSDI(Application,'',True);
    if FAlteraEstagioProposta.AlteraEstagioProposta(PropostaSEQPROPOSTA.Asinteger) then
      AtualizaConsulta;
    FAlteraEstagioProposta.Free;
  end;

end;

{******************************************************************************}
procedure TFPropostas.GerarCotao1Click(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
  begin
    if Confirmacao('Deseja gerar uma nova cotação à partir desta proposta?') then
    begin
      FNovaCotacao:= TFNovaCotacao.CriarSDI(Application,'',True);
      FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
      FunProspect.CarDProspect(VprDProspect,VprDProposta.CodProspect);
      FNovaCotacao.NovaCotacaoProposta(VprDProposta);
      FNovaCotacao.Free;
    end;
  end;
end;

{******************************************************************************}
procedure TFPropostas.GerarOrcamentoCompras1Click(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
    FNovaSolicitacaoCompras.NovoOrcamentoProposta(VprDProposta);
    FNovaSolicitacaoCompras.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPropostas]);
end.
