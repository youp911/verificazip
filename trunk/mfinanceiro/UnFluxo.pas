unit UnFluxo;

interface

uses
    Db, DBTables, classes, sysUtils, vcf1, Graphics;

const
   QdadeLinhas = 200;
   LinhaInicialFluxo = 2;
   ColunaInicialFluxo = 1;

// calculos
type
  TCalculosFluxo = class
  private
     calcula : TQuery;
    function ExisteDadosProximoNivel( VpaPlanoConta : string; VpaFilialEmpresa, VpaTipoFluxo : Integer;
                                      VpaDataInicial, VpaDataFinal : TDateTime; VpaAPagar : Boolean ) : Boolean;
    Function SqlTipoFluxoData( VpaTipoFluxo : Integer; VpaAlias : String ) : String;// tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
    Function SqlTipoFluxoValor( VpaTipoFluxo : Integer; VpaAlias : String; VpaAPagar : Boolean  ) : String;// tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
    Function SqlTipoFluxoDataVencimento( VpaDiario : boolean; VpaAlias : String ) : String;// tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
    function SQLTextoFilial( VpaAlias : String; FilialEmpresa : Integer ) : string; //0 - filial atual, 1 empresa atual
  public
    constructor criar( aowner : TComponent; ADataBase : TDataBase ); virtual;
    destructor destroy; override;
    function TamanhoPlanoIncial(TamanhoPai : Integer): integer;
    function SomaCRVencidasVencer( VpaData : TDateTime; VpaTipoFluxo : Integer; FilialEmpresa : Integer; MenorQueData : Boolean) : double ; // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
    function SomaCPVencidasVencer( VpaData : TDateTime; VpaTipoFluxo : Integer; FilialEmpresa : Integer; MenorQueData : Boolean) : Double; // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
    function SomaComissaoVencidasVencer( VpaData : TDateTime; VpaTipoFluxo : Integer; FilialEmpresa : Integer; MenorQueData : Boolean) : Double; // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas

end;

// localizacao
Type
  TLocalizaFluxo = class(TCalculosFluxo)
  private
  public
    procedure LocalizaDadosCP(Tabela : TQuery; VpaPlanoConta : string;
                              VpaDataInicial, VpaDataFinal : TDateTime;
                              VpaDiario : Boolean; VpaTipoFluxo : Integer;
                              FilialEmpresa : Integer); // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
    procedure LocalizaDadosCR(VpaTabela : TQuery; VpaPlanoConta : string;
                              VpaDataInicial, VpaDataFinal : TDateTime;
                              VpaDiario : Boolean; VpaTipoFluxo : Integer;
                              FilialEmpresa : Integer;
                              VpaClienteConfiavel : Boolean); // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
   procedure LocalizaDadosBancos(Tabela : TQuery; VpaDataAtual : TDateTime);
   procedure LocalizaDadosCaixa(Tabela : TQuery; VpaFilialEmpresa : Integer);
   procedure LocalizaDadosComissao(Tabela : Tquery; VpaDataInicial, VpaDataFinal : TDateTime;
                                   VpaDiario : Boolean; VpaFilialEmpresa : Integer; VpaTipoFluxo : Integer);

   procedure LocalizaContasDiaPagar(Tabela : Tquery; Data : TDateTime; PlanoConta : string; FilialEmpresa, TipoFluxo : integer);
   procedure LocalizaContasDiaReceber(Tabela : Tquery; Data : TDateTime; PlanoConta : string; FilialEmpresa, TipoFluxo : integer);
   procedure LocalizaContasSituacao(Tabela : Tquery; Data : TDateTime; PlanoConta : string; FilialEmpresa, TipoFluxo : integer; Porbanco, Diario : boolean);
end;

// funcoes
type
  TFuncoesFluxo = class(TLocalizaFluxo)
    Fluxo : TQuery;
    DataBase : TDataBase;
  private
    // cores
    CorFundo,  CorFundoDestaque, CorFonte, CorFonteDestaque, CorNegativo : TColor;
    // fonte
    TamanhoFonte : integer;
    NomeFonte : string;


    // somatorios fluxo
    SomaDiaCP : array[1..31] of double;
    SomaDiaCR : array[1..31] of double;
    SomaDiaComissao : array[1..31] of double;
    SomaComissaoVendedor : array[1..QdadeLinhas] of double;
    TotalReceitas : array[1..31] of double;
    SomaPlano : array[1..QdadeLinhas] of double;
    SomaBanco : double;
    SomaCaixa : double;
    Receber : double;
    Pagar : double;
    Comissoes : double;
    ReceberVencidas, ReceberVencer, PagarVencidas, PagarVencer,
    ComissaoVencidas, ComissaoVencer : Double;

    // local onde se encontra o contas a receber e pagar
    AreaCP, AreaCR : array[1..2] of integer;

  public
     // global mes dia publica
    FluxoDiario : Boolean;
    MesDia : integer;
    TextoMesDia : String;
    TamanhoGrade : integer;
    DataInicio, DataFim : TdateTime;
    TextoCabecalho : string;
    TextoPagina : string;
    TextoTipoFluxo1, TextoTipoFluxo2 : string; //texto vencidos, a pagar, pagos, todos etc

    constructor criar( aowner : TComponent; ADataBase : TDataBase ); override;
    destructor Destroy; override;
    procedure MudaTamanhoColuna( grade : TF1Book; TamanhoColuna : Integer );
    procedure CarregaCores(CorFundo,  CorFundoDestaque, CorFonte, CorFonteDestaque, CorNegativo : TColor; NomeFonte : string; TamFonte : Integer);
    procedure ConfiguraVariaveisMesDia(VpaMes : boolean; VpaDiaInicial,VpaDiaFinal, VpaQualMes, VpaQualAno : Integer; VpaTipoFluxo : Integer  );
    function AdicionaDias(grade : TF1Book; colunaInicial, LinhaInicial : Integer; TamanhoLinha : Integer) : Integer;
    function CarregaFluxoCP(grade : TF1Book; colunaInicial, LinhaInicial, TipoFluxo, FilialEmpresa : Integer; PlanoConta : String) : Integer;
    function CarregaFluxoCR(grade : TF1Book; colunaInicial, LinhaInicial, TipoFluxo, FilialEmpresa : Integer; PlanoConta : String;VpaClienteConfiavel : Boolean) : Integer;
    function CarregaFluxoComissao(grade : TF1Book; colunaInicial, LinhaInicial, TipoFluxo, FilialEmpresa : Integer) : Integer;
    function CarregaFluxoBancos(grade : TF1Book; colunaInicial, LinhaInicial : Integer) : Integer;
    function CarregaFluxoCaixa(grade : TF1Book; colunaInicial, LinhaInicial : Integer; FilialEmpresa : Integer) : Integer;
    function CarregaTotalReceitas(grade : TF1Book; colunaInicial, LinhaInicial : Integer) : Integer;
    function CarregaTotalDespesa(grade : TF1Book; colunaInicial, LinhaInicial : Integer) : Integer;
    function CarregaTotalFluxo(grade : TF1Book; colunaInicial, LinhaInicial : Integer) : Integer;
    function CarregaTotalGeral(grade : TF1Book; colunaInicial, LinhaInicial : Integer; TipoSomatorio : Integer; TipoFluxo, FilialEmpresa : Integer) : Integer;
    function IdentificaPagarReceber( Linha : Integer ) : integer; //  0 nenhum, 1 cp, 2 cr
    function CarregaContaDia(Tabela : TQuery; Data : TDateTime;
                             PlanoConta : string; Linha, FilialEmpresa, TipoFluxo : Integer  ) : string;
    procedure CarregaTabelaTempFluxo;
    procedure SuprimirFluxo( grade : TF1Book; IgnorarColuna : integer  );
    function ExisteDadosNivelSuperior( VpaPlanoConta : string; VpaFilialEmpresa, VpaTipoFluxo : Integer;
                                       VpaAPagar : Boolean ) : Boolean;
    procedure FormataCodPlanoTam( grade  : TF1Book; AteLinha : Integer );
    procedure Redesenha( Grade : TF1Book; CorIni,CorFim, LinhaAtual, TamanhoFonte : Integer; Fundo : Boolean);
 end;

implementation

uses constMsg, constantes, funSql, funData, FunObjeto;


{#############################################################################
                        TCalculoFluxo
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TCalculosFluxo.criar( aowner : TComponent; ADataBase : TDataBase );
begin
  inherited;
  calcula := TQuery.Create(aowner);
  calcula.DatabaseName := ADataBase.DatabaseName;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosFluxo.destroy;
begin
  calcula.Destroy;
inherited;
end;

{verifica se existe dados em um nivle superior do plano de conta passado com paramentro}
function TCalculosFluxo.ExisteDadosProximoNivel( VpaPlanoConta : string; VpaFilialEmpresa, VpaTipoFluxo : Integer;
                                        VpaDataInicial, VpaDataFinal : TDateTime; VpaAPagar : Boolean ) : Boolean;
var
 SqlPagarReceber : string;
begin
  if VpaAPagar then
    SqlPagarReceber := ' cadContasaPagar as c Key join movContasaPagar as m '
  else
    SqlPagarReceber := ' cadContasaReceber as c Key join movContasaReceber as m ';

  LimpaSQLTabela(calcula);
  AdicionaSQLTabela(calcula, ' select c.i_emp_fil from ' +
                             SqlPagarReceber +
                             ' where ' +
                             SQLTextoDataEntreAAAAMMDD('m.D_DAT_VEN', VpaDataInicial, VpaDataFinal, false) +
                             ' and c.c_cla_pla like ''' + VpaPlanoConta + '_%'' ' +
                             SQLTextoFilial('m',VpaFilialEmpresa) +
                             SqlTipoFluxoData(VpaTipoFluxo, 'm') +
                             ' and isnull(m.c_dup_can, ''N'') = ''N'' ' );
  AbreTabela(calcula);
  result := not calcula.Eof;
end;



{************ texto se n_vlr_dup ou n_vlr_par ******************************* }
Function TCalculosFluxo.SqlTipoFluxoData( VpaTipoFluxo : Integer; VpaAlias : string ) : String;// tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
begin
    result := '';
    case VpaTipoFluxo of
    0 :  result := ' and ' + VpaAlias + '.d_dat_pag is null '; // abertas
    1 :  result := ' and ' + VpaAlias + '.d_dat_pag is not null '; // pagas
    2 : begin // todas
//          result := ' and isnull( ' + VpaAlias + '.c_fla_par,''N'') = ''N'' ';
        end;
   end;
end;

{**************** nome do campo valor conforme tipo de fluxo ***************** }
Function TCalculosFluxo.SqlTipoFluxoValor( VpaTipoFluxo : Integer; VpaAlias : String; VpaAPagar : Boolean ) : String;// tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
begin
  case VpaTipoFluxo of
    0,2 : begin
             result := VpaAlias;
             if VpaAPagar then
               result := 'isnull(' + result + '.n_vlr_pag,' + Vpaalias + '.n_vlr_dup * moe.n_vlr_dia)' // abertas, todas cp
             else
               result := 'isnull(' + result + '.n_vlr_pag,' + Vpaalias + '.n_vlr_par * moe.n_vlr_dia)' // abertas, todas cr
           end;
    1 :  result := VpaAlias + '.n_vlr_pag '; // pagas
  end;
end;

{**************** nome do campo data conforme mensal, diario ***************** }
Function TCalculosFluxo.SqlTipoFluxoDataVencimento( VpaDiario : boolean; VpaAlias : String) : String;// tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
begin
  if VpaDiario then
    result  := VpaAlias + '.d_dat_ven vencimento'
  else
    result  := 'month(' + VpaAlias + '.d_dat_ven ) vencimento'
end;

{************************* Filtro da filial ********************************* }
function TCalculosFluxo.SQLTextoFilial( VpaAlias : string; FilialEmpresa : Integer ) : string; //0 - filial atual, 1 empresa atual
begin
  result := '  ';
  if FilialEmpresa = 0 then
      result := ' and ' + VpaAlias + '.i_emp_fil = ' + IntToStr(varia.CodigoEmpFil)
  else
     result := ' and ' + VpaAlias + '.i_emp_fil like ''' + IntToStr(varia.CodigoEmpFil) + '%''';
end;


{************* retorna o tamnaho do plano de conta inicial, 04 = 2 *********** }
function TCalculosFluxo.TamanhoPlanoIncial(TamanhoPai : Integer): integer;
begin
  AdicionaSQLAbreTabela(calcula, ' SELECT MIN(LENGTH(C_CLA_PLA)) MINIMO ' +
                                 ' FROM CAD_PLANO_CONTA ' +
                                 ' WHERE  LENGTH(C_CLA_PLA) > ' + IntToStr(TamanhoPai));
  if calcula.EOF then
    Result := 0
  else
    Result := Calcula.FieldByName('MINIMO').AsInteger;
end;

{***************** calcula parcelas CR vencidadas **************************** }
function TCalculosFluxo.SomaCRVencidasVencer( VpaData : TDateTime; VpaTipoFluxo : Integer; FilialEmpresa : Integer; MenorQueData : Boolean) : Double; // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
var
  sinal :  string;
begin
  if MenorQueData then
    sinal := ' < '
  else
    sinal := ' > ';
  LimpaSQLTabela(calcula);
  AdicionaSQLTabela(calcula, ' select sum(' + SqlTipoFluxoValor(VpaTipoFluxo,'mcr',false) +
                                 ' ) ValorDup from ' +
                                 ' movcontasareceber mcr key join cadcontasareceber cr, ' +
                                 ' cadSituacoes as Sit, cadmoedas as moe ' +
                                 ' where ' +
                                 ' mcr.d_dat_ven ' + sinal  + SQLTextoDataAAAAMMMDD(VpaData) +
                                 SqlTipoFluxoData(VpaTipoFluxo,'mcr') +  // caso isnull dat_pag  e parciais
                                 ' and isnull(mcr.c_dup_can,''N'') = ''N'' ' +
                                 ' and mcr.i_cod_sit = sit.i_cod_sit ' +
                                 ' and isnull(sit.c_ign_flu,''N'') = ''N'' ' +
                                 ' and mcr.i_cod_moe = moe.i_cod_moe ' );
  AbreTabela(calcula);
  result := calcula.fieldByName('ValorDup').AsFloat;
  FechaTabela(calcula);
end;

{***************** calcula parcelas CP vencidadas **************************** }
function TCalculosFluxo.SomaCPVencidasVencer( VpaData : TDateTime; VpaTipoFluxo : Integer; FilialEmpresa : Integer; MenorQueData : Boolean) : Double; // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
var
  sinal :  string;
begin
  if MenorQueData then
    sinal := ' < '
  else
    sinal := ' > ';
  LimpaSQLTabela(calcula);
  AdicionaSQLTabela(calcula, ' select sum(' + SqlTipoFluxoValor(VpaTipoFluxo,'mcp',true) +
                                 ' ) ValorDup from ' +
                                 ' movcontasaPagar mcp key join cadcontasapagar cp, ' +
                                 ' cadmoedas as moe ' +
                                 ' where ' +
                                 ' mcp.d_dat_ven ' + sinal  + SQLTextoDataAAAAMMMDD(VpaData) +
                                 SqlTipoFluxoData(VpaTipoFluxo,'mcp') +  // caso isnull dat_pag  e parciais
                                 ' and isnull(mcp.c_dup_can,''N'') = ''N'' ' +
                                 ' and mcp.i_cod_moe = moe.i_cod_moe ' );
  AbreTabela(calcula);
  result := calcula.fieldByName('ValorDup').AsFloat;
  FechaTabela(calcula);
end;

{***************** calcula parcelas CP vencidadas **************************** }
function TCalculosFluxo.SomaComissaoVencidasVencer( VpaData : TDateTime; VpaTipoFluxo : Integer; FilialEmpresa : Integer; MenorQueData : Boolean) : Double; // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
var
  dataPag, sinal :  string;
begin
  if MenorQueData then
    sinal := ' < '
  else
    sinal := ' > ';

    case VpaTipoFluxo of
      0 : dataPag := ' and mov.d_dat_pag is null '; // abertas
      1 : dataPag := ' and mov.d_dat_pag is not null '; // pagas
      2 : dataPag := '';
    end;

  LimpaSQLTabela(calcula);
  AdicionaSQLTabela(calcula, ' select  sum(mov.n_vlr_com) ValorCom ' +
                             ' from movcomissoes as mov ' +
                             ' where ' +
                             ' mov.d_dat_ven ' + sinal +  SQLTextoDataAAAAMMMDD(VpaData) +
                              dataPag +
                              SQLTextoFilial('mov',FilialEmpresa) +
                             ' and isnull(mov.c_can_com, ''N'') = ''N'' ' );
  AbreTabela(calcula);
  result := calcula.fieldByName('ValorCom').AsFloat;
  FechaTabela(calcula);
end;


{#############################################################################
                        TLocalizaComissoes
#############################################################################  }


{************* dados do fluxo do contas a pagar ****************************** }
procedure TLocalizaFluxo.LocalizaDadosCP(Tabela : TQuery; VpaPlanoConta : string;
                                         VpaDataInicial, VpaDataFinal : TDateTime;
                                         VpaDiario : Boolean; VpaTipoFluxo : Integer;
                                         FilialEmpresa : Integer); // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
var
  VpfTamanhoPlano : Integer;
  VpfFiltroPlano : string;
begin

  // calcula o tamanho do plano de conta
  if VpaPlanoConta = '' then   // caso vazio, primeiro nivel
  begin
    VpfTamanhoPlano := TamanhoPlanoIncial(0);
    VpfFiltroPlano := ''; // primeiro nivel naum precisa filtrar o plano
  end
  else
  begin
    VpfTamanhoPlano := TamanhoPlanoIncial(Length(VpaPlanoConta));
    VpfFiltroPlano := ' and cp.c_cla_pla like ''' + VpaPlanoConta + '%'' ';  // somente deste nivel
  end;

  // cria select
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela,' select ' + SqlTipoFluxoDataVencimento(VpaDiario,'mcp')  +
                           ' , p.c_nom_pla, ' +
                           ' sum(' + SqlTipoFluxoValor(VpaTipoFluxo,'mcp',true) +
                           ' ) ValorDup, ' +
                           ' substr(cp.c_cla_pla,0, ' + IntTostr(VpfTamanhoPlano) + ') plano ' +
                           ' from ' +
                           ' cadcontasapagar as cp Key join movcontasapagar as mcp, ' +
                           ' cad_plano_conta as p,  cadmoedas as moe ' +
                           ' where ' +
                           SQLTextoDataEntreAAAAMMDD('mcp.D_DAT_VEN',VpaDataInicial,VpaDataFinal,false) +
                           VpfFiltroPlano +         // somente deste nivel
                           ' and length(plano) <= ' + IntTostr(VpfTamanhoPlano) +  // somente os niveis mais externos
                           SQLTextoFilial('mcp',FilialEmpresa) + // somente uma filial, ou todas
                           SqlTipoFluxoData(VpaTipoFluxo,'mcp') +  // caso isnull dat_pag  e parciais
                           ' and isnull(mcp.c_dup_can, ''N'') = ''N'' ' +
                           ' and p.i_cod_emp = cp.i_cod_emp ' +
                           ' and p.c_cla_pla = plano ' +
                           ' and mcp.i_cod_moe = moe.i_cod_moe ' +
                           ' group by plano, P.c_nom_pla, vencimento '+
                           ' order by P.c_nom_pla ' );
  AbreTabela(Tabela);
end;

{************* dados do fluxo do contas a receber **************************** }
procedure TLocalizaFluxo.LocalizaDadosCR(VpaTabela : TQuery; VpaPlanoConta : string;
                                         VpaDataInicial, VpaDataFinal : TDateTime;
                                         VpaDiario : Boolean; VpaTipoFluxo : Integer;
                                         FilialEmpresa : Integer;
                                         VpaClienteConfiavel : Boolean); // tipo fluxo = 0 - abertas, 1 - pagas, 2 - todas
begin
  VpaTabela.sql.Clear;
  VpaTabela.sql.add(' select '+SqlTipoFluxoDataVencimento(VpaDiario,'MCR')+
                 ' , sum(' + SqlTipoFluxoValor(VpaTipoFluxo,'mcr', false) +
                 ' ) ValorDup ' +
                 ' from CADCONTASARECEBER CR, MOVCONTASARECEBER MCR, ' +
                 ' CADMOEDAS MOE, CADCLIENTES CLI ' +
                 ' where CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                 ' and CLI.I_COD_CLI = CR.I_COD_CLI '+
                 ' and CR.I_LAN_REC = MCR.I_LAN_REC '+
                 SQLTextoDataEntreAAAAMMDD('MCR.D_DAT_VEN',VpaDataInicial,VpaDataFinal,true) +
                  SQLTextoFilial('MCR',FilialEmpresa) + // somente uma filial, ou todas
                  SqlTipoFluxoData(VpaTipoFluxo,'mcr') +  // caso isnull dat_pag  e parciais
                 ' and ISNULL(CR.C_IND_CON,''N'') <> ''S''' +
                 ' and ISNULL(MCR.C_COB_EXT,''N'') <> ''S'''+
                 ' and mcr.i_cod_moe = moe.i_cod_moe ');
  if VpaClienteConfiavel then
    VpaTabela.sql.add('and cli.C_FIN_CON = ''S''');
  VpaTabela.SQl.add(' group by vencimento');
  VpaTabela.open;
end;

{**************** carrega a tabela fluxo com os dados dos Bancos ************* }
procedure TLocalizaFluxo.LocalizaDadosBancos(Tabela : TQuery; VpaDataAtual : TDateTime);
begin
  LimpaSQLTabela(Tabela);
end;

{**************** carrega a tabela fluxo com os dados dos caixas ************* }
procedure TLocalizaFluxo.LocalizaDadosCaixa(Tabela : TQuery; VpaFilialEmpresa : Integer );
var
  TextoFilial : string;
begin
  LimpaSQLTabela(Tabela);
end;

{ *********************** localiza dados da comissao ************************* }
procedure TLocalizaFluxo.LocalizaDadosComissao(Tabela : Tquery; VpaDataInicial, VpaDataFinal : TDateTime;
                                                VpaDiario : Boolean; VpaFilialEmpresa : Integer; VpaTipoFluxo : Integer);
var
  dataPag, vencimento : string;
begin

    case VpaTipoFluxo of
      0 : dataPag := ' and mov.d_dat_pag is null '; // abertas
      1 : dataPag := ' and mov.d_dat_pag is not null '; // pagas
      2 : dataPag := '';
    end;

    if VpaDiario then
      vencimento := ' mov.d_dat_ven vencimento '
    else
      vencimento := ' month(mov.d_dat_ven) vencimento ';

  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela(Tabela,' select ven.c_nom_ven, mov.i_cod_ven, ' +
                           ' sum(mov.n_vlr_com) ValorCom, ' + vencimento +
                           ' from movcomissoes as mov, cadvendedores as ven ' +
                           ' where ' +
                           SQLTextoDataEntreAAAAMMDD( 'mov.d_dat_ven',VpaDataInicial, VpaDataFinal, false) +
                           dataPag +
                           SQLTextoFilial('mov',VpaFilialEmpresa) +
                           ' and isnull(mov.c_can_com, ''N'') = ''N'' ' +
                           ' and mov.i_cod_ven = ven.i_cod_ven  ' +
                           ' group by mov.i_cod_ven, vencimento, ven.c_nom_ven '+
                           ' order By mov.i_cod_ven');
  AbreTabela(Tabela);
end;


{************ mostra as conta a pagar de um unico dia ************************ }
procedure TLocalizaFluxo.LocalizaContasDiaPagar(Tabela : Tquery; Data : TDateTime; PlanoConta : string; FilialEmpresa, TipoFluxo : integer);
begin
  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela( Tabela,
                  'select P.C_NOM_PLA, mcp.d_dat_ven, MCP.C_NRO_DUP, (n_vlr_dup * moe.n_vlr_dia) as valor, ' +
                  ' c.c_nom_cli, C.I_COD_CLI  from ' +
                  ' movcontasapagar as mcp key join cadcontasapagar as cp, CAD_PLANO_CONTA as P, CadClientes as C, cadMoedas as MOE ' +
                  ' where ' +
                  ' d_dat_ven = ''' +  DataToStrFormato(AAAAMMDD,Data,'/') + '''' +
                  SQLTextoFilial('mcp',FilialEmpresa) +
                  ' and cp.c_cla_pla like ''' + PlanoConta + '%''' +
                  ' and isnull(mcp.c_dup_can, ''N'') = ''N'' ' +
                   SqlTipoFluxoData(TipoFluxo,'mcp') +
                  ' and CP.C_CLA_PLA = P.C_CLA_PLA ' +
                  ' and cp.I_cod_Cli = C.i_cod_Cli '+
                  ' and moe.i_cod_moe = mcp.i_cod_moe ' +
                  ' order by P.C_NOM_PLA, mcp.d_dat_ven ');
  AbreTabela(Tabela);
end;

{************ mostra as conta a receber de um unico dia ********************** }
procedure TLocalizaFluxo.LocalizaContasDiaReceber(Tabela : Tquery; Data : TDateTime; PlanoConta : string; FilialEmpresa, TipoFluxo : integer);
begin
  AdicionaSQLAbreTabela( Tabela,
                      'select P.C_NOM_PLA, MOV.d_dat_ven,( n_vlr_par * moe.n_vlr_dia) as valor, ' +
                      ' MOV.C_NRO_DUP, ' +
                      ' CLI.c_nom_cli, CLI.I_COD_CLI  from ' +
                      ' MOVCONTASARECEBER MOV, CADCONTASARECEBER CR, ' +
                      ' CAD_PLANO_CONTA P, CadClientes CLI, CADMOEDAS MOE ' +
                      ' where ' +
                      ' MOV.D_DAT_VEN = ''' +  DataToStrFormato(AAAAMMDD,Data,'/') + '''' +
                      SQLTextoFilial('MOV',FilialEmpresa) +
                      SqlTipoFluxoData(TipoFluxo,'MOV') +
                      ' AND MOV.I_EMP_FIL = CR.I_EMP_FIL '+
                      ' AND MOV.I_LAN_REC = CR.I_LAN_REC '+
                      ' and CR.C_CLA_PLA = P.C_CLA_PLA ' +
                      ' and CR.I_COD_EMP = P.I_COD_EMP '+
                      ' and cr.I_cod_cli = CLI.i_cod_cli ' +
                      ' and moe.i_cod_moe = MOV.i_cod_moe ' +
                      ' order by P.C_NOM_PLA, MOV.D_DAT_VEN ');
end;

{************ mostra as conta a receber da situacoes ************************* }
procedure TLocalizaFluxo.LocalizaContasSituacao(Tabela : Tquery; Data : TDateTime; PlanoConta : string; FilialEmpresa, TipoFluxo : integer; Porbanco, Diario : boolean);
var
  banco, cadBanco, JoinBanco, TextoData : string;
begin

  if Porbanco then
  begin
    banco := ', mcr.i_cod_ban, ban.c_nom_ban ';
    CadBanco := ', cadBancos ban ';
    JoinBanco := ' and mcr.i_cod_ban *= ban.i_cod_ban ';
  end
  else
  begin
    banco := '';
    cadbanco := '';
    JoinBanco := '';
  end;

  if diario then
    TextoData := ' mcr.d_dat_ven = ' + SQLTextoDataAAAAMMMDD(data)
  else
    TextoData :=  ' month( mcr.d_dat_ven) = ' + IntToStr(mes(data)) + ' and  year( mcr.d_dat_ven) = ' + intToStr(ano(data));

  LimpaSQLTabela(Tabela);
  AdicionaSQLTabela( Tabela, ' select  sit.c_nom_sit, sum (n_vlr_par * moe.n_vlr_dia) as valor ' + banco +
                             ' from  movcontasareceber as mcr key join cadcontasareceber as cr, ' +
                             ' cadMoedas as MOE , cadsituacoes sit ' + cadbanco +
                             ' where ' +
                             TextoData +
                             SQLTextoFilial('mcr',FilialEmpresa) +
                             ' and cr.c_cla_pla like ''' + PlanoConta + '%''' +
                             ' and isnull(mcr.c_dup_can, ''N'') = ''N'' ' +
                              SqlTipoFluxoData(TipoFluxo,'mcr') +
                             ' and mcr.i_cod_sit = sit.i_cod_sit ' +
                             ' and isnull(sit.c_ign_flu,''N'') = ''N'' '+
                             ' and moe.i_cod_moe = mcr.i_cod_moe ' +
                             ' and mcr.i_cod_sit = sit.i_cod_sit ' +
                             joinBanco  +
                             ' group by ' +
                             ' mcr.i_cod_sit, sit.c_nom_sit ' + banco );
  ImprimeSqlArq(tabela, 'c:\x\sit.sql');
  AbreTabela(Tabela);
end;

{#############################################################################
                        TFuncoesComissoes
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesFluxo.criar( aowner : TComponent; ADataBase : TDataBase );
begin
inherited;
    DataBase := AdataBase;
    Fluxo := TQuery.Create(aowner);
    Fluxo.DatabaseName := ADataBase.Name;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesFluxo.Destroy;
begin
    FechaTabela(Fluxo);
    Fluxo.Destroy;
inherited;
end;

{***************** muda tamanho das colunas ********************************** }
procedure TFuncoesFluxo.MudaTamanhoColuna( grade : TF1Book; TamanhoColuna : Integer );
begin
  MudaTamanhoColunaGrade( Grade, ColunaInicialFluxo + 2, (MesDia + ColunaInicialFluxo + 2), TamanhoColuna * 10 );
end;

{************** carrega as cores padrao do fluxo **************************** }
procedure TFuncoesFluxo.CarregaCores(CorFundo,  CorFundoDestaque, CorFonte, CorFonteDestaque, CorNegativo : TColor; NomeFonte : string; TamFonte : Integer);
begin
  self.CorFundo :=          CorFundo;
  self.CorFundoDestaque :=  CorFundoDestaque;
  self.CorFonte :=          CorFonte;
  self.CorFonteDestaque :=  CorFonteDestaque;
  self.CorNegativo :=       CorNegativo;
  self.TamanhoFonte :=      TamFonte;
  self.NomeFonte :=         NomeFonte;
end;

{********** carrega variaveis conforme ano ou mes *************************** }
procedure TFuncoesFluxo.ConfiguraVariaveisMesDia(VpaMes : boolean; VpaDiaInicial,VpaDiaFinal, VpaQualMes, VpaQualAno : Integer; VpaTipoFluxo : Integer );
var
  VpfLaco : integer;
begin
  for VpfLaco:=1 to 31 do   // zera somatorios cp e rc
  begin
    SomaDiaCP[VpfLaco] := 0;
    SomaDiaCR[VpfLaco] := 0;
    SomaDiaComissao[VpfLaco] := 0;
    TotalReceitas[VpfLaco] := 0;
  end;

  for VpfLaco:=1 to QdadeLinhas do  // zera somatorio plano de conta
  begin
    SomaPlano[VpfLaco] := 0;
    SomaComissaoVendedor[VpfLaco] := 0;
  end;

  SomaBanco := 0;  SomaCaixa := 0;  Receber := 0;  Pagar := 0;
  Comissoes := 0;  ReceberVencidas := 0; ReceberVencer := 0;
  PagarVencidas := 0; PagarVencer := 0; ComissaoVencidas  := 0;
  ComissaoVencer := 0;

  case VpaTipoFluxo of
    0 : begin TextoTipoFluxo1 := 'Vencidos'; TextoTipoFluxo2 := 'a Vencer'; end;
    1 : begin TextoTipoFluxo1 := 'Pagos'; TextoTipoFluxo2 := 'a Pagar'; end;
    2 : begin TextoTipoFluxo1 := 'Todos'; TextoTipoFluxo2 := 'Todos'; end;
  end;

  if not VpaMes then
  begin
    FluxoDiario := false;
    MesDia := 12; // Meses.
    TextoMesDia := 'Ano . . .';
    TamanhoGrade  := 15;
    DataInicio := MontaData(01, 01, VpaQualAno);
    DataFim := UltimoDiaMes(MontaData(01, 12, VpaQualAno));
    TextoCabecalho := 'Fluxo Mensal. Referente ao Ano :  ' +  FormatFloat('0000', VpaQualAno) + '.';
    TextoPagina := 'Ano : ' + FormatFloat('0000', VpaQualAno)+ ' - Gerado ' + DateToStr(date);
  end
  else
  begin
    FluxoDiario := True;
    MesDia := 31; // Dia.
    TextoMesDia := 'Mês . . .';
    TamanhoGrade  := 34;

    if ValidaData(VpaDiaInicial, VpaQualMes, VpaQualAno) then
      DataInicio := MontaData(VpaDiaInicial, VpaQualMes, VpaQualAno)
    else
      DataInicio := MontaData(dia(UltimoDiaMes(MontaData(1,VpaQualMes, VpaQualAno))), VpaQualMes, VpaQualAno); // caso o dia inicial seja 31, 30 e o mes naum possue tal dia

    if ValidaData(VpaDiaFinal, VpaQualMes, VpaQualAno) then
      DataFim := MontaData(VpaDiaFinal, VpaQualMes, VpaQualAno)
    else
       DataFim := MontaData(dia(UltimoDiaMes(MontaData(1,VpaQualMes, VpaQualAno))), VpaQualMes, VpaQualAno); // caso o dia inicial seja 31, 30 e o mes naum possue tal dia

    TextoCabecalho := 'Fluxo Diario.  Referente ao Mês :  ' +
                       FormatFloat('00', VpaQualMes) + '/' + FormatFloat('0000', VpaQualAno) + '.';
    TextoPagina := 'Mês : ' + FormatFloat('00', VpaQualMes) + '/' + FormatFloat('0000', VpaQualAno) + ' - Gerado ' + DateToStr(date);
  end;
end;

{************** adicona os dias ou mes no fluxo ***************************** }
function TFuncoesFluxo.AdicionaDias(grade : TF1Book; colunaInicial, LinhaInicial : Integer; TamanhoLinha : Integer) : Integer;
var
  Laco : Integer;
  coluna, linha : integer;
begin
  limpagrade(grade,1,37,1,200);  //limpa toda a grade
  grade.MaxCol := TamanhoGrade;  // coloca o tamnaho necessario de linhas
  coluna := colunaInicial;
  Linha := LinhaInicial;
  // Tamanho Primeira coluna.
  Grade.ColWidth[coluna] := 750;
//  FormataCelula(grade, coluna, coluna, Linha, 200, CorFundo, CorFundo, True);
  // Tamanho Segunda Coluna.
  inc(coluna);
  Grade.TextRC[linha,coluna] := 'Plano de Conta / ' + TextoMesDia; // Texto Plano de conta,  Texto ano ou mes...
  Grade.ColWidth[coluna] := 10000;
  // tamanho 31 Colunas restantes com o tamanho selecionado.
  inc(coluna);
  Grade.SetColWidth(coluna, (MesDia + coluna + 1), TamanhoLinha * 10, True); //(4) vencidas ou pagas ou todas, a vencer ou a pagar ou todoas e totalMes, TotalGeral
  FormataCelula(grade, coluna-1, (MesDia + coluna), linha, linha, TamanhoFonte, CorFundoDestaque, CorFonteDestaque,true, false, NomeFonte);
  FormataBordaCelula(grade, coluna-1, (MesDia + coluna), linha, linha, clGray, false);
  Grade.SetAlignment(F1HAlignCenter,false,F1HAlignCenter,0);
  dec(coluna);
  if MesDia < 15 then
  begin
    for Laco:=1 to MesDia do
     Grade.TextRC[linha,Laco+Coluna] := NumeroMes(laco,true) + '/'+ IntToStr(ano(DataInicio));
  end
  else
  begin
    for Laco:=1 to MesDia do
      Grade.NumberRC[linha,Laco+Coluna] := Laco;
  end;
  // texto no final das linha do fluxo
  coluna := laco + coluna;
  Grade.TextRC[linha,coluna] := 'Total'; // Texto linha 2 coluna 34.
  result := Linha + 1;
end;

{************************ Carrega fluxo do contas a pagar ****************** }
function TFuncoesFluxo.CarregaFluxoCP(grade : TF1Book; colunaInicial, LinhaInicial, TipoFluxo, FilialEmpresa : Integer; PlanoConta : String) : Integer;
var
  Laco : Integer;
  coluna, linha : integer;
  PlanoAtual : string;
  DiaMesVen : word;
  Total : double;
begin
  DiaMesVen := 1;
  coluna := colunaInicial+1;
  Linha := LinhaInicial;
  LocalizaDadosCP( Fluxo,PlanoConta,DataInicio, DataFim, FluxoDiario, TipoFluxo, FilialEmpresa);

  // Coloca o texto em azul.
  FormataCelula(grade, coluna, coluna, Linha, Linha, TamanhoFonte, CorFundo, CorFonteDestaque, true, false, NomeFonte);
  Grade.TextRC[Linha, coluna] := 'Contas a Pagar. . . ';

  Fluxo.First;
  while not Fluxo.Eof do
  begin
    if PlanoAtual <> Fluxo.fieldByName('C_NOM_PLA').AsString then
    begin
      PlanoAtual := fluxo.fieldByName('C_NOM_PLA').AsString;
      Inc(Linha);
      // Escreve o Nome do Palno de conta.
      FormataCelula(grade, coluna,coluna,Linha,Linha, TamanhoFonte, CorFundo, CorFonte,true, false, NomeFonte); // para o texto do plano
      Grade.TextRC[Linha,coluna] := Fluxo.fieldByName('PLANO').AsString + ' - ' + PlanoAtual;
      Grade.TextRC[Linha,coluna-1] := Fluxo.fieldByName('PLANO').AsString;
    end;

    // Coloca o valor da soma de dias na sua celula.
    if FluxoDiario then
      DiaMesVen :=  Dia(Fluxo.fieldByName('vencimento').AsDateTime)
    else
      DiaMesVen :=  Fluxo.fieldByName('vencimento').AsInteger;

    Grade.NumberRC[Linha, DiaMesVen + 2] := Fluxo.fieldByName('ValorDup').AsCurrency;

    // Acumula a soma de dias no vetor.
    SomaDiaCP[DiaMesVen] := SomaDiaCP[DiaMesVen] + Fluxo.fieldByName('ValorDup').AsCurrency;
    // Acumula a soma de historicos no vetor.
    SomaPlano[Linha] := SomaPlano[Linha] + Fluxo.fieldByName('valorDup').AsCurrency;
    Fluxo.Next;
  end;

  FormataCelula( grade, coluna + 2, (MesDia + 3), LinhaInicial, Linha, TamanhoFonte, CorFundo, CorFonte, false,false,NomeFonte);
  Total := 0;
  // Linha de totais do contas a pagar.
  Inc(Linha);
  Grade.textRC[Linha,coluna] := 'Total Contas a Pagar';
  for Laco := 1 to MesDia do
  begin
    if (SomaDiaCP[Laco] <> 0) then
      Grade.NumberRC[Linha,Laco+2] :=  SomaDiaCP[Laco];
    Total := Total + SomaDiaCP[Laco];
  end;

  for Laco := LinhaInicial + 1 to linha do   // totais do plano de conta
  begin
       Grade.NumberRC[laco,Mesdia+3] :=  Somaplano[Laco];
  end;

  Grade.NumberRC[Linha, (MesDia + 3)] :=  Total;
  Pagar := total;

  FormataCelula(grade, coluna, (MesDia + 3), Linha, Linha, TamanhoFonte, CorFundoDestaque, CorFonte, true, false, NomeFonte);
  FormataCelula(grade, (MesDia + 3), (MesDia + 3), LinhaInicial + 1, Linha, TamanhoFonte, CorFundoDestaque, CorFonte, true, false, NomeFonte);
  FormataBordaCelula(grade, colunaInicial+1, Grade.MaxCol, LinhaInicial+1, linha, clGray, true );
  AreaCP[1] := LinhaInicial + 1;
  AreaCP[2] := linha;
  result := linha + 1;
end;

{************************ Carrega fluxo do contas a receber ****************** }
function TFuncoesFluxo.CarregaFluxoCR(grade : TF1Book; colunaInicial, LinhaInicial, TipoFluxo, FilialEmpresa : Integer; PlanoConta : String;VpaClienteConfiavel : Boolean) : Integer;
var
  Laco : Integer;
  coluna, linha : integer;
  PlanoAtual : string;
  DiaMesVen : word;
  Total : double;
begin
  DiaMesVen := 1;
  coluna := colunaInicial+1;
  Linha := LinhaInicial;
  LocalizaDadosCR( Fluxo,PlanoConta,DataInicio, DataFim, FluxoDiario, TipoFluxo,FilialEmpresa,VpaClienteConfiavel);

  // Coloca o texto em azul.
  FormataCelula(grade, coluna, coluna, Linha, Linha,TamanhoFonte, CorFundo,  CorFonteDestaque, true, false, NomeFonte);
  Grade.TextRC[Linha,coluna] := 'Contas a Receber. . . ';
  inc(Linha);
  Fluxo.First;
  while not Fluxo.Eof do
  begin
      // Escreve o número do histórico.
      FormataCelula(grade, coluna, coluna, Linha, Linha, TamanhoFonte, CorFundo, CorFonte, true, false, NomeFonte);
      Grade.TextRC[Linha,coluna] := 'Receitas';
      Grade.TextRC[Linha,coluna-1] := 'Receitas';

    if FluxoDiario then
      DiaMesVen :=  Dia(Fluxo.fieldByName('vencimento').AsDateTime)
    else
      DiaMesVen := Fluxo.fieldByName('vencimento').AsInteger;
    Grade.NumberRC[Linha, DiaMesVen + 2] := Fluxo.fieldByName('valorDup').AsCurrency;

    // Acumula a soma de dias no vetor.
    SomaDiaCR[DiaMesVen] := SomaDiaCR[DiaMesVen] + Fluxo.fieldByName('valorDup').AsCurrency;
    // acumula o tatal das recietas
    TotalReceitas[DiaMesVen] := TotalReceitas[DiaMesVen] + Fluxo.fieldByName('valorDup').AsCurrency;

    // Acumula a soma de historicos no vetor.
    SomaPlano[Linha] := SomaPlano[Linha] + Fluxo.fieldByName('valorDup').AsCurrency;
    Fluxo.Next;
  end;

  FormataCelula( grade, coluna + 2, (MesDia + 3), LinhaInicial, Linha, TamanhoFonte, CorFundo, CorFonte, false,false,NomeFonte);  Inc(Linha);
  // Linha de totais do contas a Receber.
  Grade.textRC[Linha,coluna] := 'Total Contas a Receber';

  Total := 0;
  for Laco := 1 to MesDia do   // valores por dia
  begin
   if SomaDiaCR[Laco] <> 0 then
       Grade.NumberRC[Linha,Laco+2] :=  SomaDiaCR[Laco];
       total := total + SomaDiaCR[Laco];
  end;

  for Laco := LinhaInicial + 1 to linha do   // totais do plano de conta
  begin
       Grade.NumberRC[laco,Mesdia+3] :=  Somaplano[Laco];
  end;

  Receber := Total;
  Grade.NumberRC[Linha, (MesDia + 3)] :=  Total;
  FormataCelula(grade, coluna, (MesDia + 3), Linha, Linha, TamanhoFonte, CorFundoDestaque, CorFonte, True, false, NomeFonte);
  FormataCelula(grade, (MesDia + 3), (MesDia + 3),LinhaInicial+1,Linha, TamanhoFonte, CorFundoDestaque,CorFonte,true, false, NomeFonte);
  FormataBordaCelula(grade, colunaInicial+1, Grade.MaxCol, LinhaInicial+1, linha, clGray, true  );
  AreaCR[1] := LinhaInicial + 1;
  AreaCR[2] := linha;
  result := linha + 1;
end;

{************************ Carrega fluxo das Comissoes *********************** }
function TFuncoesFluxo.CarregaFluxoComissao(grade : TF1Book; colunaInicial, LinhaInicial, TipoFluxo, FilialEmpresa : Integer) : Integer;
var
  Laco : Integer;
  coluna, linha : integer;
  VendedorAtual : string;
  DiaMesVen : word;
  Total : double;
begin
  DiaMesVen := 1;
  coluna := colunaInicial+1;
  Linha := LinhaInicial;
  LocalizaDadosComissao( Fluxo,DataInicio, DataFim, FluxoDiario, FilialEmpresa,TipoFluxo );

  // Coloca o texto em azul.
  FormataCelula(grade, coluna, coluna, Linha, Linha, TamanhoFonte, CorFundo, CorFonteDestaque, true, false, NomeFonte);
  Grade.TextRC[Linha,coluna] := 'Comissão. . . ';

  Fluxo.First;
  while not Fluxo.Eof do
  begin
    if VendedorAtual <> Fluxo.fieldByName('I_COD_VEN').AsString then
    begin
      VendedorAtual := Fluxo.fieldByName('I_COD_VEN').AsString;
      Inc(Linha);
      // Escreve o número do histórico.
      FormataCelula(grade, coluna, coluna, Linha, Linha, TamanhoFonte, CorFundo, CorFonte, true, false, NomeFonte);
      Grade.TextRC[Linha,coluna] := VendedorAtual + ' - ' + Fluxo.fieldByName('c_nom_ven').AsString;
      Grade.TextRC[Linha,coluna-1] := Fluxo.fieldByName('I_COD_VEN').AsString;
    end;

    if FluxoDiario then
      DiaMesVen :=  Dia(Fluxo.fieldByName('vencimento').AsDateTime)
    else
      DiaMesVen := Fluxo.fieldByName('vencimento').AsInteger;
    Grade.NumberRC[Linha, DiaMesVen + 2] := Fluxo.fieldByName('ValorCom').AsCurrency;

    // Acumula a soma de dias no vetor.
    SomaDiaComissao[DiaMesVen] := SomaDiaComissao[DiaMesVen] + Fluxo.fieldByName('valorCom').AsCurrency;
    SomaComissaoVendedor[Linha] := SomaComissaoVendedor[Linha] + Fluxo.fieldByName('valorCom').AsCurrency;
    Fluxo.Next;
  end;

  FormataCelula( grade, coluna + 2, (MesDia + 3), LinhaInicial, Linha, TamanhoFonte, CorFundo, CorFonte, false,false,NomeFonte);  Inc(Linha);
  // Linha de totais do contas a Receber.
  Grade.textRC[Linha,coluna] := 'Total das Comissões';

  Total := 0;
  for Laco := 1 to MesDia do
  begin
   if SomaDiaComissao[Laco] <> 0 then
       Grade.NumberRC[Linha,Laco+2] :=  SomaDiaComissao[Laco];
       total := total + SomaDiaComissao[Laco];
  end;

  for Laco := LinhaInicial + 1 to linha do   // totais do plano de conta
  begin
       Grade.NumberRC[laco,Mesdia+3] :=  SomaComissaoVendedor[Laco];
  end;

  Comissoes := Total;
  Grade.NumberRC[Linha, (MesDia + 3)] :=  Total;
  FormataCelula(grade, coluna, (MesDia + 3), Linha, Linha, TamanhoFonte, CorFundoDestaque, CorFonte, True, false, NomeFonte);
  FormataCelula(grade, (MesDia + 3), (MesDia + 3),LinhaInicial+1,Linha, TamanhoFonte, CorFundoDestaque,CorFonte,true, false, NomeFonte);
  FormataBordaCelula(grade, colunaInicial+1, Grade.MaxCol, LinhaInicial+1, linha, clGray, true  );
  result := linha + 1;
end;

{************************ Carrega fluxo do movimento bancario *************** }
function TFuncoesFluxo.CarregaFluxoBancos(grade : TF1Book; colunaInicial, LinhaInicial : Integer) : Integer;
var
  coluna, linha : integer;
  ContaAtual : string;
  DiaMesVen : word;
begin
  exit;
  DiaMesVen := 1;
  coluna := colunaInicial+1;
  Linha := LinhaInicial;
  LocalizaDadosBancos(Fluxo, date);

  // linha de inicio
  FormataCelula(grade, coluna, (coluna + 1), Linha, Linha, TamanhoFonte, CorFundo, CorFonteDestaque, True, false, NomeFonte);
  Grade.TextRC[Linha,coluna] := 'Movimento Bancário. . . ';

  Fluxo.First;
  while not Fluxo.Eof do
  begin
    if ContaAtual <> Fluxo.fieldByName('C_NRO_CON').AsString then
    begin
      ContaAtual := Fluxo.fieldByName('C_NRO_CON').AsString;
      Inc(Linha);
      // Escreve o número da conta
      FormataCelula(grade, coluna, coluna, Linha, Linha, TamanhoFonte, CorFundo, CorFonte, true, false, NomeFonte);
      Grade.TextRC[Linha,coluna] := ContaAtual;
    end;

    if FluxoDiario then
      DiaMesVen :=  Dia(date)
    else
      DiaMesVen := mes(date);

     // cor caso negativo ou positivo
     if Fluxo.fieldByName('n_sal_atu').AsCurrency >= 0 then
         FormataCelula( grade, DiaMesVen + 2, DiaMesVen + 2, Linha, Linha, TamanhoFonte, CorFundo, CorFonte, false, false, NomeFonte)
     else
        FormataCelula( grade, DiaMesVen + 2, DiaMesVen + 2, Linha, Linha, TamanhoFonte, CorFundo, CorNegativo, false, false, NomeFonte);

    // escreve valor da conta
    Grade.NumberRC[Linha, DiaMesVen + 2] := Fluxo.fieldByName('n_sal_atu').AsCurrency;

    // Acumula a soma de dias no vetor.
    SomaBanco := SomaBanco + Fluxo.fieldByName('n_sal_atu').AsCurrency;
    // acumula o tatal das recietas
    TotalReceitas[DiaMesVen] := TotalReceitas[DiaMesVen] + Fluxo.fieldByName('n_sal_atu').AsCurrency;

    Fluxo.Next;
  end;

  // Linha de totais da contas.
  FormataCelula( grade, coluna, (DiaMesVen + 2), Linha, Linha, TamanhoFonte, CorFundoDestaque, CorFonte, True, false, NomeFonte);//cor cinza da celula
  Grade.textRC[Linha,coluna] := 'Total das Contas Bancárias...';
  // para valores negativo
  FormataNegativo( grade, DiaMesVen + 2,linha, TamanhoFonte, true, false, CorFundoDestaque,CorNegativo, SomaBanco, NomeFonte);
  Grade.NumberRC[Linha,DiaMesVen + 2] :=  SomaBanco;

  FormataBordaCelula(grade, colunaInicial+1, coluna, LinhaInicial+1, linha, clGray, true  );  // format a bordfa no inicio
  FormataBordaCelula(grade, DiaMesVen+2, DiaMesVen+2, LinhaInicial+1, linha, clGray, true  );  // format a celula dos totais
  FormataBordaCelulaContorno(grade, coluna+1, DiaMesVen+1, LinhaInicial+1, linha );  // format a celula do inicio  ate totais

  result := linha + 1;
end;

{************************ Carrega fluxo do caixa **************************** }
function TFuncoesFluxo.CarregaFluxoCaixa(grade : TF1Book; colunaInicial, LinhaInicial : Integer; FilialEmpresa : Integer) : Integer;
var
  coluna, linha : integer;
  CaixaAtual : string;
  DiaMesVen : word;
begin
  DiaMesVen := 1;
  coluna := colunaInicial+1;
  Linha := LinhaInicial;
  LocalizaDadosCaixa(Fluxo,FilialEmpresa);

  // linha de inicio
  FormataCelula(grade, coluna, (coluna + 1), Linha, Linha, TamanhoFonte, CorFundo, CorFonteDestaque, True, false, NomeFonte);
  Grade.TextRC[Linha,coluna] := 'Caixa . . . ';

  Fluxo.First;
  while not Fluxo.Eof do
  begin
    if CaixaAtual <> Fluxo.fieldByName('num_caixa').AsString then
    begin
      CaixaAtual := Fluxo.fieldByName('num_caixa').AsString;
      Inc(Linha);
      // Escreve o número da conta
      FormataCelula(grade, coluna, coluna, Linha, Linha, TamanhoFonte, CorFundo, CorFonte, true, false, NomeFonte);
      Grade.TextRC[Linha,coluna] := CaixaAtual + ' - ' + Fluxo.fieldByName('des_caixa').AsString;;
    end;

    if FluxoDiario then
      DiaMesVen :=  Dia(date)
    else
      DiaMesVen := mes(date);

    // escreve valor do caixa
    Grade.NumberRC[Linha, DiaMesVen + 2] := Fluxo.fieldByName('valor').AsCurrency;

    // Acumula a soma de dias no vetor.
    SomaCaixa := SomaCaixa + Fluxo.fieldByName('valor').AsCurrency;

    // acumula o tatal das recietas
    TotalReceitas[DiaMesVen] := TotalReceitas[DiaMesVen] + Fluxo.fieldByName('valor').AsCurrency;

    Fluxo.Next;
  end;

  FormataCelula( grade, coluna + 2, (MesDia + 3), LinhaInicial, Linha, TamanhoFonte, CorFundo, CorFonte, false,false,NomeFonte);  Inc(Linha);
  // Linha de totais do caixa.
  FormataCelula(grade, coluna, (DiaMesVen + 2), Linha, Linha, TamanhoFonte, CorFundoDestaque, CorFonte, True, false, NomeFonte);//cor cinza da celula
  Grade.textRC[Linha,coluna] := 'Total dos Caixas...';
  FormataNegativo(grade, DiaMesVen + 2,linha,TamanhoFonte, true, false, CorFundoDestaque, CorNegativo, SomaCaixa, NomeFonte);
  Grade.NumberRC[Linha,DiaMesVen + 2] :=  SomaCaixa;

  FormataBordaCelula(grade, colunaInicial+1, coluna, LinhaInicial+1, linha, clGray, true  );  // format a bordfa no inicio
  FormataBordaCelula(grade, DiaMesVen+2, DiaMesVen+2, LinhaInicial+1, linha, clGray, true  );  // format a celula dos totais
  FormataBordaCelulaContorno(grade, coluna+1, DiaMesVen+1, LinhaInicial+1, linha );  // format a celula do inicio  ate totais

  result := linha + 1;
end;

{************************ Carrega total das receitas np fluxo **************** }
function TFuncoesFluxo.CarregaTotalReceitas(grade : TF1Book; colunaInicial, LinhaInicial : Integer) : Integer;
var
  Laco : Integer;
  coluna, linha : integer;
  Total : Double;
begin
  coluna := colunaInicial+1;
  Linha := LinhaInicial;

  // Linha de totais das receitas
  Grade.textRC[Linha,coluna] := 'Sub Total das Receitas';
  // Linha de totais das receitas acumuladas
  Grade.textRC[Linha+1,coluna] := 'Total das Receitas Acumuladas';


  // formata a cor do fundo e fonte das celulas
  FormataCelula(grade, coluna, (MesDia + 3), Linha, Linha+1, TamanhoFonte, CorFundoDestaque, CorFonte, True, false, NomeFonte);
  Total := 0;
  for Laco := 1 to MesDia do
  begin
    if TotalReceitas[Laco] <> 0 then
    begin
      FormataNegativo(grade, laco + 2,linha, TamanhoFonte, true, false, CorFundoDestaque,CorNegativo, TotalReceitas[Laco], NomeFonte); // caso negativo
      Grade.NumberRC[Linha,Laco+2] :=  TotalReceitas[Laco];   // total  por dia
      total := total + TotalReceitas[Laco];
      FormataNegativo(grade, laco + 2,linha+1, TamanhoFonte, true, false, CorFundoDestaque, CorNegativo, Total, NomeFonte); // caso negativo
      Grade.NumberRC[Linha+1,Laco+2] :=  Total;  // total acumulado
    end;
  end;
  Grade.NumberRC[Linha, (MesDia + 3)] :=  Total;
  FormataBordaCelula(grade, colunaInicial+1, Grade.MaxCol, LinhaInicial, linha+1, clGray, true  );
  result := linha + 2;
end;

{************************ Carrega total das despesas np fluxo **************** }
function TFuncoesFluxo.CarregaTotalDespesa(grade : TF1Book; colunaInicial, LinhaInicial : Integer) : Integer;
var
  Laco : Integer;
  coluna, linha : integer;
  Total : Double;
begin
  coluna := colunaInicial+1;
  Linha := LinhaInicial;

  // Linha de totais das receitas
  Grade.textRC[Linha,coluna] := 'Sub Total das Despesas';
  // Linha de totais das receitas acumuladas
  Grade.textRC[Linha+1,coluna] := 'Total das Despesas Acumuladas';

  // formata a cor do fundo e fonte das celulas
  FormataCelula(grade, coluna, (MesDia + 3), Linha, Linha+1, TamanhoFonte, CorFundoDestaque, CorFonte, True, false, NomeFonte);
  Total := 0;
  for Laco := 1 to MesDia do
  begin
    if (SomaDiaCP[Laco] <> 0) or (SomaDiaComissao[laco] <> 0 ) then
    begin
      Grade.NumberRC[Linha,Laco+2] := (SomaDiaCP[Laco] + SomaDiaComissao[laco]);   // total  por dia
      total := total + (SomaDiaCP[Laco] + SomaDiaComissao[laco]);
      Grade.NumberRC[Linha+1,Laco+2] :=  Total;  // total acumulado
    end;
  end;
  Grade.NumberRC[Linha, (MesDia + 3)] :=  Total;
  FormataBordaCelula(grade, colunaInicial+1, Grade.MaxCol, LinhaInicial, linha+1, clGray, true  );
  result := linha + 2;
end;

{************************ Carrega total do fluxo ***************************** }
function TFuncoesFluxo.CarregaTotalFluxo(grade : TF1Book; colunaInicial, LinhaInicial : Integer) : Integer;
var
  Laco : Integer;
  coluna, linha : integer;
  Total : Double;
begin
  coluna := colunaInicial+1;
  Linha := LinhaInicial;

  // Linha de totais das receitas
  Grade.textRC[Linha,coluna] := 'Sub Total do Fluxo';
  // Linha de totais das receitas acumuladas
  Grade.textRC[Linha+1,coluna] := 'Total do Fluxo Acumulado';


  // formata a cor do fundo e fonte das celulas
  FormataCelula(grade, coluna, (MesDia + 3), Linha, Linha+1, TamanhoFonte, CorFundoDestaque, CorFonte, True, false, NomeFonte);
  Total := 0;
  for Laco := 1 to MesDia do
  begin
    FormataNegativo(grade, laco + 2,linha,TamanhoFonte, true, false, CorFundoDestaque, CorNegativo, TotalReceitas[Laco] - (somaDiaCP[laco] + SomaDiaComissao[laco]), NomeFonte); // caso negativo
    Grade.NumberRC[Linha,Laco+2] :=  TotalReceitas[Laco] - (somaDiaCP[laco] + SomaDiaComissao[laco]);   // total  por dia
    total := total + (TotalReceitas[Laco] - (somaDiaCP[laco] + SomaDiaComissao[laco]));
    FormataNegativo(grade, laco + 2,linha+1, TamanhoFonte, true, false, CorFundoDestaque, CorNegativo, Total, NomeFonte); // caso negativo
    Grade.NumberRC[Linha+1,Laco+2] :=  Total;  // total acumulado
  end;
  Grade.NumberRC[Linha, (MesDia + 3)] :=  Total;
  FormataBordaCelula(grade, colunaInicial+1, Grade.MaxCol, LinhaInicial, linha+1, clGray, true  );
  result := linha + 2;
end;


{************************ Carrega total Geral ******************************** }
function TFuncoesFluxo.CarregaTotalGeral(grade : TF1Book; colunaInicial, LinhaInicial : Integer; TipoSomatorio : Integer; TipoFluxo, FilialEmpresa : Integer) : Integer;
var
  Texto : string;
  Valor : Double;
  FundoDestaque : Boolean;
begin
  colunaInicial := colunaInicial + 1;
  // Escreve o número da conta

  case  TipoSomatorio of
    0  : Begin Texto := 'Avaliação Geral'; Valor := 0; FundoDestaque := true; end;
    2  : Begin Texto := 'Saldo Bancário'; Valor := SomaBanco; FundoDestaque := false; end;
    3  : Begin Texto := 'Saldo em Caixa'; Valor := SomaCaixa; FundoDestaque := false; end;
    4  : Begin Texto := 'Receber - ' + TextoTipoFluxo1; Valor := SomaCRVencidasVencer(DataInicio,TipoFluxo,FilialEmpresa, true); FundoDestaque := false; ReceberVencidas := valor; end;
    5  : Begin Texto := 'Total a Receber no Período'; Valor := Receber; FundoDestaque := false; end;
    6  : Begin Texto := 'Receber - ' + TextoTipoFluxo2; Valor := SomaCRVencidasVencer(DataFim,TipoFluxo,FilialEmpresa, false); FundoDestaque := false; ReceberVencer := valor; end;
    7  : Begin Texto := 'Pagar - ' + TextoTipoFluxo1; Valor := SomaCPVencidasVencer(DataInicio,TipoFluxo,FilialEmpresa, true); FundoDestaque := false; PagarVencer := valor; end;
    8  : Begin Texto := 'Total das Despesas no Período'; Valor := Pagar; FundoDestaque := false; end;
    9  : Begin Texto := 'Pagar - ' + TextoTipoFluxo2; Valor := SomaCPVencidasVencer(DataFim,TipoFluxo,FilialEmpresa, false); FundoDestaque := false; PagarVencidas := valor; end;
    10 : Begin Texto := 'Comissão - '+ TextoTipoFluxo1; Valor := SomaComissaoVencidasVencer(DataInicio,TipoFluxo,FilialEmpresa, true); FundoDestaque := false; ComissaoVencidas := Valor; end;
    11 : Begin Texto := 'Total de Comissão no Período'; Valor := comissoes; FundoDestaque := false; end;
    12 : Begin Texto := 'Comissão ' + TextoTipoFluxo2; Valor := SomaComissaoVencidasVencer(DataFim,TipoFluxo,FilialEmpresa, false); FundoDestaque := false; ComissaoVencer := valor;  end;
    13 : Begin Texto := 'Sub Total Receitas'; Valor := (Receber + SomaBanco + SomaCaixa + ReceberVencidas + ReceberVencer ); FundoDestaque := true;  end;// format a celula de texto
    14 : Begin Texto := 'Sub Total Despesas'; Valor := (Pagar + Comissoes + PagarVencidas + PagarVencer  + ComissaoVencidas + ComissaoVencer); FundoDestaque := true;  end;// format a celula de texto
    15 : Begin Texto := 'Total'; Valor := ((Receber + SomaBanco + SomaCaixa + ReceberVencidas + ReceberVencer ) - (Pagar + Comissoes + PagarVencidas + PagarVencer + ComissaoVencidas + ComissaoVencer)); FundoDestaque := true;  end;// format a celula de texto

 end;

  if FundoDestaque then
    FormataCelula(grade, colunaInicial, colunaInicial+1, LinhaInicial, LinhaInicial, TamanhoFonte, CorFundoDestaque, CorFonte, True, false, NomeFonte)
  else
    FormataCelula(grade, colunaInicial, colunaInicial+1, LinhaInicial, LinhaInicial, TamanhoFonte, CorFundo, CorFonte, true, false, NomeFonte);

  // texto do valor
  Grade.TextRC[Linhainicial,colunaInicial] := Texto;

  // formata celula caso negativo
  if FundoDestaque then
    FormataNegativo(grade, colunaInicial + 1,linhaInicial,TamanhoFonte, true, false, CorFundoDestaque, CorNegativo, valor, NomeFonte) // caso negativo
  else
    FormataNegativo(grade,  colunaInicial + 1,linhaInicial, TamanhoFonte, false, false, CorFundo, CorNegativo, valor, NomeFonte); // caso negativo

  // valor
  if TipoSomatorio <> 0 then
    Grade.NumberRC[LinhaInicial,colunaInicial+1] :=  valor;   // total

  // bordas
  FormataBordaCelula(grade, colunaInicial, colunaInicial+1, LinhaInicial, linhaInicial, clGray, true  );
  result := linhaInicial + 1;
end;

{******************* identifica conforme linha se é cp ou cr ***************** }
function TFuncoesFluxo.IdentificaPagarReceber( Linha : Integer ) : integer; //  0 nenhum, 1 cp, 2 cr
begin
  result := 0;
  if (linha >= AreaCP[1]) and (linha <= AreaCP[2]) then
    result := 1
  else
    if (linha >= AreaCR[1]) and (linha <= AreaCR[2])  then
      result := 2;
end;

{ **********  detalhes da conta de um unico dia ****************************** }
function TFuncoesFluxo.CarregaContaDia(Tabela : TQuery; Data : TDateTime;
                                       PlanoConta : string; Linha, FilialEmpresa, TipoFluxo : Integer  ) : string;
var
  CP_CR : Integer;
begin
  result := '';
  CP_CR := IdentificaPagarReceber(linha);
  if CP_CR = 1 then
  begin
      result := 'Fornecedores';
      LocalizaContasDiaPagar(Tabela,data,PlanoConta,FilialEmpresa,TipoFluxo);
  end
  else
    if CP_CR = 2  then
    begin
        result := 'Clientes';
        LocalizaContasDiaReceber(Tabela,data,PlanoConta,FilialEmpresa,TipoFluxo);
    end;
end;

{*********** carrega uma tabela temporaria para gerar graficos *************** }
procedure TFuncoesFluxo.CarregaTabelaTempFluxo;
var
  laco : integer;
begin
  fluxo.RequestLive := true;
  LimpaSQLTabela(Fluxo);
  AdicionaSQLTabela(Fluxo, 'delete TemporariaFluxo');
  Fluxo.ExecSQL;

  AdicionaSQLAbreTabela(Fluxo, 'select * from TemporariaFluxo');

  for laco := dia(DataInicio) to dia(DataFim) do
  begin
    InserirReg(Fluxo);
    Fluxo.FieldByName('c_dat_flu').AsInteger := laco;
    Fluxo.FieldByName('n_vlr_des').AsFloat := SomaDiaCP[laco] + SomaDiaComissao[laco];
    Fluxo.FieldByName('n_vlr_rec').AsFloat := TotalReceitas[laco];
    Fluxo.FieldByName('n_acu_flu').AsFloat := TotalReceitas[laco] - (SomaDiaCP[laco] + SomaDiaComissao[laco]);
    GravaReg(Fluxo);
  end;
  FechaTabela(fluxo);
  Fluxo.RequestLive := false;
end;

{********* esconde as colunas com valores zerados ****************************}
procedure TFuncoesFluxo.SuprimirFluxo( grade  : TF1Book; IgnorarColuna : integer );
var
  laco : integer;
begin
  for laco := 1 to MesDia do
    if (Laco+1+ColunaInicialFluxo) <> IgnorarColuna then
      if ((SomaDiaCP[Laco] + SomaDiaComissao[laco]) = 0) and (TotalReceitas[Laco] = 0) then
         Grade.ColWidth[Laco+1+ColunaInicialFluxo] := 0;
end;

{*********** verifica se existe dados no proximo nivel do plano ************** }
function TFuncoesFluxo.ExisteDadosNivelSuperior( VpaPlanoConta : string; VpaFilialEmpresa, VpaTipoFluxo : Integer;
                                                VpaAPagar : Boolean ) : Boolean;
begin
  result := ExisteDadosProximoNivel(VpaPlanoConta,VpaFilialEmpresa, VpaTipoFluxo, DataInicio, DataFim, VpaAPagar);
  if not result then
    aviso(CT_FluxoFimNivel);
end;

{********** formata o tamanho do fluxo e esconde o texto da primeira coluna ***}
procedure TFuncoesFluxo.FormataCodPlanoTam( grade  : TF1Book; AteLinha : Integer );
begin
  grade.MaxRow := AteLinha;
  FormataCelula( grade,ColunaInicialFluxo,ColunaInicialFluxo,LinhaInicialFluxo,AteLinha, TamanhoFonte, CorFundo,CorFundo,false, false, NomeFonte);
end;

procedure TFuncoesFluxo.Redesenha(Grade : TF1Book; CorIni,CorFim, LinhaAtual, TamanhoFonte : Integer; Fundo : Boolean);
begin
  RedesenhaFluxo( grade,CorIni, CorFim, fundo, LinhaAtual,TamanhoFonte);
  FormataCelula( grade,ColunaInicialFluxo,ColunaInicialFluxo,LinhaInicialFluxo, LinhaAtual,
                TamanhoFonte, CorFundo, CorFundo, false, false, NomeFonte);
end;

end.
