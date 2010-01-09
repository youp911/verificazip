unit APropostasCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, ComCtrls, StdCtrls, Db, DBTables, Buttons, UnDados, UnProposta,
  UnProspect, UnCrystal, Localizacao, Graficos, Mask, numericos, Menus, UnClientes,
  DBClient;

type
  TFPropostasCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    PanelColor2: TPanelColor;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label4: TLabel;
    Proposta: TSQL;
    DataProposta: TDataSource;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BImprimir: TBitBtn;
    BEmail: TBitBtn;
    BFechar: TBitBtn;
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
    ConsultaPadrao1: TConsultaPadrao;
    BGraEstagio: TBitBtn;
    Label7: TLabel;
    EProposta: Tnumerico;
    PopupMenu1: TPopupMenu;
    TelemarketingReceptivo1: TMenuItem;
    N1: TMenuItem;
    AlterarEstgio1: TMenuItem;
    N2: TMenuItem;
    GerarCotao1: TMenuItem;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    Label9: TLabel;
    ESetor: TEditLocaliza;
    ECliente: TEditLocaliza;
    Label35: TLabel;
    SpeedButton11: TSpeedButton;
    Label34: TLabel;
    PropostaCODFILIAL: TFMTBCDField;
    PropostaSEQPROPOSTA: TFMTBCDField;
    PropostaDATPROPOSTA: TSQLTimeStampField;
    PropostaDATPREVISAOCOMPRA: TSQLTimeStampField;
    PropostaINDCOMPROU: TWideStringField;
    PropostaINDCOMPROUCONCORRENTE: TWideStringField;
    PropostaVALTOTAL: TFMTBCDField;
    PropostaI_COD_CLI: TFMTBCDField;
    PropostaC_NOM_PAG: TWideStringField;
    PropostaC_NOM_CLI: TWideStringField;
    PropostaNOMEST: TWideStringField;
    PropostaNOMSETOR: TWideStringField;
    N3: TMenuItem;
    GerarFichaImplantao1: TMenuItem;
    N4: TMenuItem;
    GerarPedidoCompra1: TMenuItem;
    N5: TMenuItem;
    ConsultaPedidoCompras1: TMenuItem;
    Aux: TSQL;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    EFilial: TEditLocaliza;
    EOrcamentoCompra: Tnumerico;
    BFiltros: TBitBtn;
    Label10: TLabel;
    CPeriodo: TCheckBox;
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
    procedure GerarFichaImplantao1Click(Sender: TObject);
    procedure GerarPedidoCompra1Click(Sender: TObject);
    procedure ConsultaPedidoCompras1Click(Sender: TObject);
    procedure BFiltrosClick(Sender: TObject);
  private
    { Private declarations }
    VprCodFilial,
    VprNumChamado : Integer;
    VprOrdem : String;
    VprDProposta : TRBDPropostaCorpo;
    VprDProspect : TRBDProspect;
    VprDCliente: TRBDCliente;
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
    procedure ConsultaOrcamentoCompras;
  public
    { Public declarations }
    procedure ConsultaPropostas(VpaCodCliente: Integer);
    Procedure ConsultaOrcamentoCompra(VpaCodFilial,VpaSeqSolicitacao : Integer);
    procedure ConsultaPropostasChamado(VpaCodFilial,VpaNumChamado : Integer);
  end;

var
  FPropostasCliente: TFPropostasCliente;

implementation

uses APrincipal, funSql, funData, Constmsg, ANovaProposta, constantes,
  ANovoTelemarketingProspect, AAlteraEstagioProposta, ANovaCotacao,
  ANovoTeleMarketing, ANovoChamadoTecnico, ANovaSolicitacaoCompra,
  ASolicitacaoCompras, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPropostasCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta := TRBFuncoesProposta.cria(FPrincipal.BaseDados);
  VprDProposta := TRBDPropostaCorpo.cria;
  VprDProspect := TRBDProspect.cria;
  VprDCliente:= TRBDCliente.cria;
  EDatInicio.Datetime := PrimeiroDiaMes(date);
  EDatFim.DAtetime := UltimoDiaMes(date);
  VprOrdem := ' order by PRO.DATPROPOSTA';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPropostasCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta.Free;
  VprDProposta.free;
  VprDProspect.free;
  VprDCliente.Free;
  Proposta.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPropostasCliente.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := Proposta.GetBookmark;
  Proposta.close;

  Proposta.sql.clear;
  Proposta.Sql.add('select PRO.CODFILIAL, PRO.SEQPROPOSTA, PRO.DATPROPOSTA, PRO.DATPREVISAOCOMPRA,'+
                   ' PRO.INDCOMPROU, PRO.INDCOMPROUCONCORRENTE, PRO.VALTOTAL,'+
                   ' CLI.I_COD_CLI,'+
                   ' CON.C_NOM_PAG,'+
                   ' CLI.C_NOM_CLI,'+
                   ' EST.NOMEST,'+
                   ' STR.NOMSETOR'+
                   ' from PROPOSTA PRO, CADCONDICOESPAGTO CON, CADCLIENTES CLI, ESTAGIOPRODUCAO EST, SETOR STR'+
                   ' Where PRO.CODCONDICAOPAGAMENTO = CON.I_COD_PAG'+
                   ' AND PRO.CODCLIENTE = CLI.I_COD_CLI'+
                   ' AND PRO.CODESTAGIO = EST.CODEST'+
                   ' AND PRO.CODSETOR = STR.CODSETOR');
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
procedure TFPropostasCliente.AdicionaFiltros(VpaSelect : TStrings);
begin
  if EProposta.AsInteger <> 0 then
    VpaSelect.Add(' AND SEQPROPOSTA = ' +EProposta.Text)
  else
  begin
    if CPeriodo.Checked then
      VpaSelect.add(SQLTextoDataEntreAAAAMMDD('DATPROPOSTA',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
    if EVendedor.Ainteiro <> 0 then
      VpaSelect.Add('AND PRO.CODVENDEDOR = ' +EVendedor.Text);
    if ECliente.AInteiro <> 0 then
      VpaSelect.Add('AND PRO.CODCLIENTE = '+ECliente.Text);
    if EEstagio.AInteiro <> 0 then
      VpaSelect.Add('AND PRO.CODESTAGIO = '+EEstagio.Text);
    if ESetor.AInteiro <> 0 then
      VpaSelect.Add('AND PRO.CODSETOR = '+ESetor.Text);
    if (EOrcamentoCompra.AsInteger <> 0) then
    begin
      VpaSelect.Add('AND EXISTS '+
                    '( SELECT * FROM PROPOSTASOLICITACAOCOMPRA PRT '+
                    ' Where PRT.SEQSOLICITACAO = '+IntToStr(EOrcamentoCompra.AsInteger));
      if EFilial.AInteiro <> 0 then
        VpaSelect.add(' and PRT.CODFILIAL = '+IntToStr(EFilial.AInteiro));
      VpaSelect.add('AND PRT.CODFILIAL = PRO.CODFILIAL '+
                    ' AND PRT.SEQPROPOSTA = PRO.SEQPROPOSTA )');
    end;
    if (VprNumChamado <> 0) then
    begin
      VpaSelect.Add('and EXISTS (Select * from CHAMADOPROPOSTA CHP '+
                           ' Where PRO.CODFILIAL = CHP.CODFILIAL '+
                           ' AND PRO.SEQPROPOSTA = CHP.SEQPROPOSTA '+
                           ' AND CHP.NUMCHAMADO = '+IntToStr(VprNumChamado)+
                           ' AND CHP.CODFILIAL = '+IntToStr(VprCodFilial)+ ')');
    end;
  end;
end;

{******************************************************************************}
function TFPropostasCliente.RRodapeGrafico : String;
begin
  result := 'Período de :'+ FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' até : '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime);
  if EVendedor.AInteiro <> 0 then
    result := result + ' - Vendedor : '+ LNomVendedor.Caption;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoMeioDivulgacao;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, MEI.DESMEIODIVULGACAO MEIO '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI, MEIODIVULGACAO MEI '+
                    ' Where CLI.I_PRC_MDV = MEI.CODMEIODIVULGACAO'+
                    ' AND PRO.CODCLIENTE = CLI.I_COD_CLI');
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
procedure TFPropostasCliente.GraficoVendedor;
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
procedure TFPropostasCliente.GraficoCidade;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, CLI.C_CID_CLI CIDADE '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI'+
                    ' Where PRO.CODCLIENTE = CLI.I_COD_CLI');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CIDADE order by 1 desc');
  VpfComandosql.savetofile('c:\consulta.sql');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CIDADE';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Cidades';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'CIDADE';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoRamoAtividade;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, RAM.NOM_RAMO_ATIVIDADE AS CAMPO '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI, RAMO_ATIVIDADE RAM '+
                    ' Where CLI.I_COD_RAM *= RAM.COD_RAMO_ATIVIDADE '+
                    ' AND PRO.CODCLIENTE = CLI.I_COD_CLI');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO ORDER BY 2');
  VpfComandosql.savetofile('c:\consulta.sql');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Ramo Atividades';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Ramo Atividade';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoProfissao;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, PRF.C_NOM_PRF CAMPO '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI, CADPROFISSOES PRF '+
                    ' Where CLI.I_PRC_PRF *= PRF.I_COD_PRF '+
                    '  AND PRO.CODCLIENTE = CLI.I_COD_CLI');
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
procedure TFPropostasCliente.GraficoData;
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
procedure TFPropostasCliente.GraficoUF;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, C_EST_CLI CAMPO '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI'+
                    ' Where PRO.CODCLIENTE = CLI.I_COD_CLI');
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
procedure TFPropostasCliente.GraficoEstagio;
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
procedure TFPropostasCliente.ConsultaOrcamentoCompras;
begin
  FSolicitacaoCompra := TFSolicitacaoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrcamentoCompra'));
  FSolicitacaoCompra.ConsultaProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
  FSolicitacaoCompra.free;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaPropostas(VpaCodCliente: Integer);
begin
  ECliente.AInteiro:= VpaCodCliente;
  EDatInicio.DateTime:= DecMes(PrimeiroDiaMes(date),3);
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
Procedure TFPropostasCliente.ConsultaOrcamentoCompra(VpaCodFilial,VpaSeqSolicitacao : Integer);
begin
  EFilial.AInteiro:= VpaCodFilial;
  EFilial.Atualiza;
  CPeriodo.Checked := false;
  EOrcamentoCompra.AsInteger := VpaSeqSolicitacao;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaPropostasChamado(VpaCodFilial,VpaNumChamado : Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprNumChamado := VpaNumChamado;
  CPeriodo.Checked := false;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFPropostasCliente.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPropostasCliente.BEmailClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    VprDProposta.free;
    VprDProposta := TRBDPropostaCorpo.cria;
    FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    VprDCliente.CodCliente:= VprDProposta.CodCliente;
    FunClientes.CarDCliente(VprdCliente);
    VpfResultado:= FunProposta.EnviaEmailCliente(VprDProposta,VprDCliente);
    if  vpfresultado <> '' then
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFPropostasCliente.BConsultarClick(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    FNovaProposta.ConsultaProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    FNovaProposta.free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.BCadastrarClick(Sender: TObject);
begin
  FNovaProposta := tFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
  if FNovaProposta.NovaProposta then
    AtualizaConsulta;
  FNovaProposta.free;
end;

{******************************************************************************}
procedure TFPropostasCliente.BAlterarClick(Sender: TObject);
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
procedure TFPropostasCliente.BImprimirClick(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
  begin
    dtRave := TdtRave.Create(self);
    dtRave.ImprimeProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger,true);
    dtRave.Free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.BMeioDivulgacaoClick(Sender: TObject);
begin
  GraficoMeioDivulgacao;
end;

{******************************************************************************}
procedure TFPropostasCliente.BGraficosClick(Sender: TObject);
begin
  PanelColor1.Enabled := false;
  PanelColor2.Enabled := false;
  GridIndice1 .Enabled := false;
  PGraficos.Top := 50;
  PGraficos.Visible := true;
end;

{******************************************************************************}
procedure TFPropostasCliente.BFechaGraficoClick(Sender: TObject);
begin
  PanelColor1.Enabled := true;
  PanelColor2.Enabled := true;
  GridIndice1 .Enabled := true;
  PGraficos.Visible := false;
end;

{******************************************************************************}
procedure TFPropostasCliente.BVendedorClick(Sender: TObject);
begin
  GraficoVendedor;
end;

procedure TFPropostasCliente.BProdutoClick(Sender: TObject);
begin
  GraficoCidade;
end;

{******************************************************************************}
procedure TFPropostasCliente.BDataClick(Sender: TObject);
begin
  GraficoRamoAtividade;
end;

{******************************************************************************}
procedure TFPropostasCliente.BFlagClick(Sender: TObject);
begin
  GraficoProfissao;
end;

{******************************************************************************}
procedure TFPropostasCliente.BCondicaoClick(Sender: TObject);
begin
  GraficoData;
end;

{******************************************************************************}
procedure TFPropostasCliente.BEstadoClick(Sender: TObject);
begin
  GraficoUF;
end;

{******************************************************************************}
procedure TFPropostasCliente.BGraEstagioClick(Sender: TObject);
begin
  GraficoEstagio;
end;

{******************************************************************************}
procedure TFPropostasCliente.EPropostaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPropostasCliente.TelemarketingReceptivo1Click(Sender: TObject);
begin
  if not Proposta.Eof then
  begin
    FNovoTeleMarketing:= TFNovoTeleMarketing.CriarSDI(Application,'',True);
    FNovoTeleMarketing.TeleMarketingCliente(PropostaI_COD_CLI.AsInteger);
    FNovoTeleMarketing.Free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.AlterarEstgio1Click(Sender: TObject);
begin
  if not Proposta.Eof then
  begin
    FAlteraEstagioProposta:= TFAlteraEstagioProposta.CriarSDI(Application,'',True);
    if FAlteraEstagioProposta.AlteraEstagioPropostaCliente(PropostaSEQPROPOSTA.Asinteger) then
      AtualizaConsulta;
    FAlteraEstagioProposta.Free;
  end; 
end;

{******************************************************************************}
procedure TFPropostasCliente.GerarCotao1Click(Sender: TObject);
begin
  if Confirmacao('Deseja gerar uma nova cotação à partir desta proposta?') then
  begin
    FNovaCotacao:= TFNovaCotacao.CriarSDI(Application,'',True);
    FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    if FNovaCotacao.NovaCotacaoProposta(VprDProposta) then
    begin
      FunProposta.AlteraEstagioProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger,varia.Codigousuario,
                                         varia.EstagioPropostaConcluida,'Proposta Faturada');
      AtualizaConsulta;
    end;
    FNovaCotacao.Free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.GerarFichaImplantao1Click(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
  begin
    if confirmacao('Deseja gerar uma ficha de implantação à partir desta proposta?') then
    begin
      FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
      FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
      FNovoChamado.NovoChamadoProposta(VprDProposta);
      FNovoChamado.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.GerarPedidoCompra1Click(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    VprDProposta.free;
    VprDProposta := TRBDPropostaCorpo.cria;
    FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
    FNovaSolicitacaoCompras.NovoOrcamentoProposta(VprDProposta);
    FNovaSolicitacaoCompras.free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaPedidoCompras1Click(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
    ConsultaOrcamentoCompras;
end;

procedure TFPropostasCliente.BFiltrosClick(Sender: TObject);
begin
  if BFiltros.Caption = '>>' then
  begin
    if screen.Height = 768 then
      PanelColor1.Height := 260
    else
      PanelColor1.Height := 211;
    BFiltros.Caption := '<<';
  end
  else
  begin
    if screen.Height = 768 then
      PanelColor1.Height := 67
    else
      PanelColor1.Height := 52;
    BFiltros.Caption := '>>';
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPropostasCliente]);
end.
