unit dmRave;

interface

uses
  SysUtils, Classes, DSServer, FMTBcd, RpDefine, RpCon, RpConDS, DB, SqlExpr,
  RpRave, DBClient, Tabela, RpBase, RpSystem, UnRave, UnDados,RvLDCompiler;

type
  TdtRave = class(TDSServerModule)
    Principal: TSQL;
    rvPrincipal: TRvDataSetConnection;
    Rave: TRvProject;
    RvSystem1: TRvSystem;
    PedidosPendentes: TSQL;
    rvPedidosPendentes: TRvDataSetConnection;
    PedidosPendentesI_EMP_FIL: TFMTBCDField;
    PedidosPendentesD_DAT_PRE: TSQLTimeStampField;
    PedidosPendentesD_DAT_ORC: TSQLTimeStampField;
    PedidosPendentesI_LAN_ORC: TFMTBCDField;
    PedidosPendentesI_COD_CLI: TFMTBCDField;
    PedidosPendentesT_HOR_ENT: TSQLTimeStampField;
    PedidosPendentesC_NOM_CLI: TWideStringField;
    PedidosPendentesC_ORD_COM: TWideStringField;
    PedidosPendentesN_QTD_PRO: TFMTBCDField;
    PedidosPendentesQTDREAL: TFMTBCDField;
    PedidosPendentesC_NOM_PRO: TWideStringField;
    PedidosPendentesC_COD_PRO: TWideStringField;
    PedidosPendentesC_COD_UNI: TWideStringField;
    PedidosPendentesC_DES_COR: TWideStringField;
    PedidosPendentesC_PRO_REF: TWideStringField;
    PedidosPendentesI_SEQ_MOV: TFMTBCDField;
    PedidosPendentesTOTAL: TFMTBCDField;
    Item: TSQL;
    rvItem: TRvDataSetConnection;
    Item2: TSQL;
    rvItem2: TRvDataSetConnection;
    Item3: TSQL;
    rvItem3: TRvDataSetConnection;
    PedidosPendentesI_SEQ_ORD: TFMTBCDField;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FunRave : TRBFunRave;
    VprDFilial : TRBDFilial;
  public
    { Public declarations }
    procedure ImprimeRetorno(VpaCodFilial, VpaSeqRetorno : Integer);
    procedure ImprimeRemessa(VpaCodFilial, VpaSeqRemessa : Integer);
    procedure ImprimePedidoPendente(VpaCodFilial,VpaCodCliente,VpaCodClienteMaster, VpaSeqProduto : Integer;VpaCodClassificacao,VpaNomClassificacao,VpaNomCliente : String;VpaDatInicio,VpaDatFim : TDateTime;VpaClienteMaster : Boolean);
    procedure ImprimePedidoParcial(VpaCodFilial,VpaLanOrcamento, VpaSeqParcial : Integer);
    procedure ImprimeNotasFiscaisEmitidas(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodClienteMaster,VpaCodVendedor : Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor : String;VpaSituacaoNota : Integer);
    procedure ImprimePedidosPorDia(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao, VpaSituacaoCotacao: Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor,VpaNomTipoCotacao,VpaNomSituacao : String);
    procedure ImprimePedido(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
    procedure ImprimeGarantia(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
    procedure ImprimeChamado(VpaCodFilial,VpaNumChamado : Integer;VpaVisualizar : Boolean);
    procedure ImprimeEnvelope(VpaDCliente : TRBDCliente);
    procedure ImprimeEnvelopeEntrega(VpaDCliente : TRBDCliente);
    procedure ImprimeEnvelopeCobranca(VpaDCliente : TRBDCliente);
    procedure ImprimeExtratoLocacao(VpaCodFilial, VpaSeqLeitura : Integer);
    procedure ImprimeCaixa(VpaSeqCaixa : Integer);
    procedure ImprimeEspelhoNota(VpaCodFilial,VpaSeqNota : Integer);
    procedure ImprimeClientesSemPedido(VpaCodVendedor, VpaPreposto, VpaCodSituacaoCliente,VpaCodTipoCotacao : Integer;VpaDatDesde : TDateTime;VpaNomVendedor,VpaNomPreposto,VpaNomSituacaoCliente,VpaNomTipCotacao, VpaCaminhoRelatorio: String);
    procedure ImprimeChamadodaCotacao(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
    procedure ImprimePedidoCompra(VpaCodFilial,VpaSeqPedido : Integer;VpaVisualizar : Boolean);
    procedure ImprimeLeituraContratos(VpaCodCliente,VpaCodTecnico,VpaCodTipoContrato, VpaNumDiaLeitura: Integer;VpaCaminhoRelatorio,VpaNomCliente,VpaNomTecnico,VpaNomTipoContrato : String);
    procedure ImprimeFracaoOP(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer;VpaVisualizar : Boolean);
    procedure ImprimeOrdemCorteOP(VpaCodFilial, VpaSeqOrdem : Integer;VpaVisualizar : Boolean);
    procedure ImprimePedidoCompraPendente;
    procedure ImprimeVendasAnalitico(VpaCodFilial,VpaCodCliente,VpaCodCondicaoPagamento, VpaCodTipoCotacao,VpaCodVendedor,VpaCodPreposto : Integer;VpaDatInicio,VpaDatFim : TDatetime;VpaCaminhoRelatorio,VpaDesCidade,VpaUF,VpaNomCliente,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaNomVendedor,VpaNomFilial,VpaNomPreposto : string);
    procedure ImprimeConsistenciadeEstoque(VpaCodFilial, VpaSeProduto : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaCaminhoRelatorio,VpaNomFilial,VpaNomProduto : String;VpaIndSomenteMonitorados : Boolean);
    procedure ImprimeConsumoSubmontagem(VpaCodFilial, VpaSeqOrdemProduccao, VpaSeqFracao : Integer;VpaSomenteAReservar, VpaConsumoExcluir : Boolean);
    procedure ImprimeRecibo(VpaCodFilial : Integer;VpaDCliente : TRBDCliente;VpaDesDuplicata, VpaValDuplicata,VpaValExtenso,VpaLocaleData : String);
    procedure ImprimeDevolucoesPendente(VpaCodFilial,VpaCodCliente,VpaCodTransportadora,VpaCodEstagio : Integer; VpaData : TDatetime;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomTranportadora,VpaNomEstagio : String);
    procedure ImprimeEstoqueFiscal(VpaCodFilial,VpaSeqProduto : integer;VpaCaminhoRelatorio,VpaNomFilial, VpaNomProduto : String);
    procedure ImprimeNotaFiscalEntrada(VpaCodFilial,VpaSeqNota : integer;VpaVisualizar : Boolean);
    procedure ImprimeOrdemSerra(VpaCodFilial, VpaSeqOrdemProducao : Integer);
    procedure ImprimeEtiquetaProduto10X3A4;
    procedure ImprimePedidosEmAbertoPorEstagio(VpaCodEstagio, VpaCodTransportadora: Integer;VpaCaminho, VpaNomEstagio : String;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeFilaChamadosPorTecnico(VpaCodEstagio,VpaCodTecnico : Integer;VpaCaminhoRelatorio, VpaNomEstagio,VpaNomTecnico : String;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeFichaDesenvolvimento(VpaCodAmostra : Integer);
    procedure ImprimeExtratoColetaFracaoUsuario(VpaDatInicio, VpaDatFim : TDatetime;VpaCodCelula : Integer;VpaNomCelula : String);
    procedure ImprimeAutorizacaoPagamento(VpaCodFilial,VpaLanPagar, VpaNumParcela : Integer;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeTotalClientesAtendidoseProdutosVendidosporVendedor(VpaCodClienteMaster : INteger;VpaCaminho, VpaNomClienteMaster : String;VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeEstoqueProdutoporTecnico(VpaCodTEcnico : Integer; VpaCaminho, VpaNomTecnico : String);
    procedure ImprimeProdutosRetornadosComDefeito(VpaCodTEcnico : Integer; VpaCaminho, VpaNomTecnico : String;VpaDatInicio,VpaDatFim : TDateTime);
    procedure ImprimeConsistenciaReservaEstoque(VpaSeProduto : Integer; VpaCaminho, VpaNomProduto : String;VpaDatInicio,VpaDatFim : TDateTime);
    procedure ImprimeVendasPorEstadoeCidade(VpaCodCliente, VpaCodCondicaoPagamento, VpaTipCotacao, VpaCodTransportadora : Integer;VpaCaminho, VpaNomCliente,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaCidade, VpaUF,VpaNomTransportadora : String;VpaDatInicio,VpaDatFim : TDatetime);
    procedure ImprimeTotalVendasPorEstadoeCidade(VpaCodCliente, VpaCodCondicaoPagamento, VpaTipCotacao : Integer;VpaCaminho, VpaNomCliente,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaCidade, VpaUF : String;VpaDatInicio,VpaDatFim : TDatetime);
    procedure ImprimeClientesPorVendedor(VpaCodVendedor,VpaCodSituacao : Integer;VpaCaminho, VpaNomVendedor,VpaNOmSituacao,VpaCidade,VpaEstado : String);
    procedure ImprimeTotalVendasCliente(VpaCodVendedor,VpaCodCondicaoPagamento,VpaCodTipoCotacao, VpaCodfilial : Integer;VpaCaminho, VpaNomVendedor,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaNomfilial,VpaCidade, VpaUF : String;VpaDatInicio,VpaDatFim : TDatetime;VpaCurvaABC : Boolean);
    procedure ImprimeExtratoColetaFracaoOPProduto(VpaSeqProduto, VpaSeqEstagio : Integer;VpaNomProduto, VpaNomEstagio : String; VpaDatInicio, VpaDatFim : TDateTime);
    procedure ImprimeInventarioProduto(VpaCodFilial, VpaSeqInventario : Integer;VpaCaminho, VpaNomfilial: String);
    procedure ImprimeContasaReceberPorEmissao(VpaCodFilial : Integer;VpaDatInicio, VpaDatFim : TDateTime;VpaCaminho, VpaNomFilial : String;VpaMostrarFrio : Boolean);
    procedure ImprimeTotalProspectPorRamoAtividade(VpaCaminho : string);
    procedure ImprimeProspectPorCeP(VpaSomenteNaoVisitados : boolean; VpaCaminho : string);
    procedure ImprimeNotasFiscaisEmitidasPorNaturezaOperacao(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodClienteMaster,VpaCodVendedor : Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor : String;VpaSituacaoNota : Integer);
  end;


var
  dtRave: TdtRave;

implementation

uses APrincipal, FunSql, Constantes, UnSistema,FunData, FunString;

{$R *.dfm}

{******************************************************************************}
procedure TdtRave.DSServerModuleCreate(Sender: TObject);
begin
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
  VprDFilial := TRBDFilial.Cria;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidoParcial(VpaCodFilial, VpaLanOrcamento,  VpaSeqParcial: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Cotacao Parcial '+IntToStr(VpaLanOrcamento);
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_COTACAOPARCIAL.rav';
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlabreTabeLa(Principal,'select PAR.CODFILIAL, PAR.LANORCAMENTO, PAR.SEQPARCIAL, PAR.DATPARCIAL, PAR.VALTOTAL, '+
                                 ' ORC.D_DAT_ORC, ORC.T_HOR_ORC, ORC.C_CON_ORC, ORC.I_TIP_FRE, ORC.C_ORD_COM,'+
                                 ' ORC.L_OBS_ORC, ORC.D_DAT_PRE, '+
                                 ' CLI.C_NOM_CLI, CLI.C_END_CLI, CLI.I_NUM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_FO1_CLI, '+
                                 ' CLI.C_FON_FAX, CLI.C_END_ELE,CLI.I_COD_CLI, CLI.C_CGC_CLI, CLI.C_INS_CLI, '+
                                 ' CLI.C_CID_CLI, CLI.C_EST_CLI, '+
                                 ' TRA.C_NOM_TRA , '+
                                 ' VEN.C_NOM_VEN, '+
                                 ' PAG.C_NOM_PAG '+
                                 ' from ORCAMENTOPARCIALCORPO PAR, CADORCAMENTOS ORC, CADCLIENTES CLI, CADTRANSPORTADORAS TRA, CADVENDEDORES VEN, '+
                                 ' CADCONDICOESPAGTO PAG '+
                                 ' WHERE PAR.CODFILIAL = ORC.I_EMP_FIL '+
                                 ' AND PAR.LANORCAMENTO = ORC.I_LAN_ORC '+
                                 ' AND ORC.I_COD_CLI = CLI.I_COD_CLI '+
                                 ' AND '+SQLTextoRightJoin('ORC.I_COD_TRA','TRA.I_COD_TRA')+
                                 ' AND ORC.I_COD_VEN = VEN.I_COD_VEN '+
                                 ' AND ORC.I_COD_PAG = PAG.I_COD_PAG '+
                                 ' AND PAR.CODFILIAL =  '+IntToStr(VpaCodFilial)+
                                 ' AND PAR.LANORCAMENTO = '+IntToStr(VpaLanOrcamento)+
                                 ' and PAR.SEQPARCIAL = '+IntToSTr(VpaSEqParcial));
  AdicionaSqlabreTabela(Item,'select ITE.CODFILIAL, ITE.LANORCAMENTO, ITE.SEQPARCIAL, '+
                             ' ITE.VALPRODUTO, ITE.DESUM, ITE.VALTOTAL, ITE.QTDPARCIAL, '+
                             ' PRO.C_COD_PRO,  PRO.C_NOM_PRO, '+
                             ' MOV.C_DES_COR NOM_COR '+
                             ' from ORCAMENTOPARCIALITEM ITE, CADPRODUTOS PRO, COR, MOVORCAMENTOS MOV '+
                             '  WHERE PRO.I_SEQ_PRO = ITE.SEQPRODUTO '+
                             '  AND '+SQLTextoRightJoin('ITE.CODCOR','COR.COD_COR')+
                             '  AND ITE.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             '  AND ITE.LANORCAMENTO = '+IntToStr(VpaLanOrcamento)+
                             ' AND ITE.CODFILIAL = MOV.I_EMP_FIL '+
                             ' AND ITE.LANORCAMENTO = MOV.I_LAN_ORC '+
                             ' AND ITE.SEQMOVORCAMENTO = MOV.I_SEQ_MOV '+
                             ' and ITE.SEQPARCIAL = '+IntToSTr(VpaSEqParcial));
  AdicionaSqlabreTabela(Item2,'select MOV.N_VLR_PAR, MOV.I_NRO_PAR, MOV.D_DAT_VEN '+
                              ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                              ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_REC = MOV.I_LAN_REC'+
                              ' AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                              ' AND CAD.I_NRO_NOT = '+IntToStr(VpaLanOrcamento)+
                              ' and CAD.I_SEQ_PAR = '+IntToSTr(VpaSEqParcial));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeNotasFiscaisEmitidas(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodClienteMaster, VpaCodVendedor : Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor : String;VpaSituacaoNota : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Notas fiscais emitidas';
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\1000FA_Notas Fiscais Emitidas.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CAD.D_DAT_EMI, CAD.C_COD_NAT, CAD.I_NRO_NOT, CAD.N_TOT_NOT, CAD.C_TIP_NOT,' +
                             ' CAD.N_VLR_ICM, CAD.N_TOT_IPI, CAD.C_NOT_IMP, CAD.C_NOT_CAN, CAD.C_FIN_GER, ' +
                             ' CAD.N_TOT_PRO, '+
                             ' CLI.C_NOM_CLI ' +
                             ' from CADNOTAFISCAIS CAD, CADCLIENTES CLI ' +
                             ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                             ' AND CAD.D_DAT_EMI BETWEEN '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                             ' AND ' +SQLTextoDataAAAAMMMDD(VpaDatFim));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  case VpaSituacaoNota of
    1 : Principal.sql.add('AND CAD.C_NOT_CAN = ''S''');
    2 : Principal.sql.add('AND CAD.C_NOT_CAN = ''N''');
  end;
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodClienteMaster <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CAD.D_DAT_EMI');
  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeNotasFiscaisEmitidasPorNaturezaOperacao(VpaDatInicio, VpaDatFim: TDateTime; VpaCodFilial, VpaCodCliente,
  VpaCodClienteMaster, VpaCodVendedor: Integer; VpaCaminhoRelatorio, VpaNomFilial, VpaNomCliente, VpaNomVendedor: String;
  VpaSituacaoNota: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Notas fiscais emitidas por Natureza Operacao';
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\2000FA_Notas Fiscais Emitidas por Natureza Operacao.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CAD.D_DAT_EMI, CAD.C_COD_NAT, CAD.I_NRO_NOT, CAD.N_TOT_NOT, CAD.C_TIP_NOT,' +
                             ' CAD.N_VLR_ICM, CAD.N_TOT_IPI, CAD.C_NOT_IMP, CAD.C_NOT_CAN, CAD.C_FIN_GER, ' +
                             ' CAD.N_TOT_PRO, '+
                             ' CLI.C_NOM_CLI,  ' +
                             ' NAT.C_NOM_NAT '+
                             ' from CADNOTAFISCAIS CAD, CADCLIENTES CLI, CADNATUREZA NAT ' +
                             ' WHERE CAD.I_COD_CLI = CLI.I_COD_CLI ' +
                             ' AND CAD.C_COD_NAT = NAT.C_COD_NAT '+
                             ' AND CAD.D_DAT_EMI BETWEEN '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                             ' AND ' +SQLTextoDataAAAAMMMDD(VpaDatFim));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  case VpaSituacaoNota of
    1 : Principal.sql.add('AND CAD.C_NOT_CAN = ''S''');
    2 : Principal.sql.add('AND CAD.C_NOT_CAN = ''N''');
  end;
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodClienteMaster <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CAD.C_COD_NAT, CAD.D_DAT_EMI');
  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidosPorDia(VpaDatInicio,VpaDatFim : TDateTime;VpaCodFilial,VpaCodCliente,VpaCodVendedor,VpaCodTipoCotacao, VpaSituacaoCotacao: Integer;VpaCaminhoRelatorio,VpaNomFilial,VpaNomCliente,VpaNomVendedor,VpaNomTipoCotacao,VpaNomSituacao : String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos por dia';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\1000PL_Pedidos por Dia.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CAD.D_DAT_ORC, CAD.I_EMP_FIL, CAD.I_LAN_ORC, ' +
                        ' CAD.D_DAT_PRE,  CAD.D_DAT_ENT, CAD.I_COD_CLI , CAD.C_IND_CAN , '+
                        ' CLI.C_NOM_CLI, ' +
                        ' N_VLR_TOT, PAG.I_COD_PAG, PAG.C_NOM_PAG ' );
  AdicionaSqlTabeLa(Principal,'from cadorcamentos CAD, CADCLIENTES CLI, CADCONDICOESPAGTO PAG ');
  AdicionaSqlTabeLa(Principal,'WHERE CAD.I_COD_CLI = CLI.I_COD_CLI '+
                        ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                        ' AND CAD.C_IND_CAN = ''N'''+
                        SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  Rave.SetParam('PERIODO','Período de '+FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDatetime('DD/MM/YYYY',VpaDatFim));
  if vpacodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodTipoCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaSituacaoCotacao = 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.C_FLA_SIT = ''A''');
    Rave.SetParam('SITUACAOCOTACAO','Em Aberto');
  end
  else
    if VpaSituacaoCotacao = 1 then
    begin
      AdicionaSqlTabeLa(Principal,'AND CAD.C_FLA_SIT = ''E''');
      Rave.SetParam('SITUACAOCOTACAO','Entregue');
    end
    else
      Rave.SetParam('SITUACAOCOTACAO','Todas');

  if (varia.CNPJFilial = CNPJ_Kairos) or (varia.CNPJFilial = CNPJ_AviamentosJaragua) then
    AdicionaSqlTabeLa(Principal,' and CAD.I_EMP_FIL <> 13 ');

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  AdicionaSqlTabeLa(Principal,'ORDER BY CAD.D_DAT_ORC,CAD.I_LAN_ORC');
  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeProdutosRetornadosComDefeito(VpaCodTEcnico: Integer; VpaCaminho, VpaNomTecnico: String; VpaDatInicio, VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Produtos Retornados com Defeito';
  Rave.projectfile := varia.PathRelatorios+'\Produto\2500ES_Produtos Retornados com Defeito.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select PRO.C_NOM_PRO, '+
                              ' PDE.DATMOVIMENTO, PDE.QTDPRODUTO, PDE.DESUM, PDE.DESDEFEITO, '+
                              ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                              ' From CADPRODUTOS PRO,  PRODUTODEFEITO PDE, TECNICO TEC '+
                              ' Where PDE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              ' AND PDE.CODTECNICO = TEC.CODTECNICO');
  if VpaCodTEcnico <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND TEC.CODTECNICO = '+InttoStr(VpaCodTecnico));
    Rave.SetParam('TECNICO','Técnico : '+VpaNomTecnico);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('PDE.DATMOVIMENTO',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' ORDER BY  TEC.NOMTECNICO, PDE.DATMOVIMENTO');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedido(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Cotação '+IntToStr(VpaNumPedido);
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_Cotacao.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'select CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.C_CON_ORC, CAD.D_DAT_ORC, CAD.T_HOR_ORC, CAD.C_ORD_COM, CAD.N_VLR_TOT, '+
                                  ' CAD.D_DAT_PRE, CAD.L_OBS_ORC, CAD.I_TIP_FRE, CAD.N_VLR_PRO, CAD.N_VLR_DES, CAD.N_PER_DES, CAD.T_HOR_ENT, '+
                                  ' CAD.N_VLR_TRO, CAD.N_QTD_TRA, CAD.C_ESP_TRA, CAD.C_MAR_TRA, CAD.N_PES_BRU, CAD.N_PES_LIQ, '+
                                  ' TIP.I_COD_TIP, TIP.C_NOM_TIP, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  '  CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                                  ' TRA.C_NOM_TRA, '+
                                  ' PAG.C_NOM_PAG, '+
                                  ' FRM.C_NOM_FRM '+
                                  ' from CADORCAMENTOS CAD, CADTIPOORCAMENTO TIP, CADCLIENTES CLI, CADVENDEDORES VEN, CADTRANSPORTADORAS TRA, '+
                                  ' CADCONDICOESPAGTO PAG, CADFORMASPAGAMENTO FRM '+
                                  ' where CAD.I_TIP_ORC = TIP.I_COD_TIP '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                                  ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_TRA')+
                                  ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                                  ' AND CAD.I_COD_FRM = FRM.I_COD_FRM '+
                                  ' and CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and CAD.I_LAN_ORC = ' +IntToStr(VpaNumPedido));
  AdicionaSqlAbreTabela(Item,'select  MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_PRO, MOV.N_VLR_TOT, MOV.C_NOM_PRO PRODUTOCOTACAO, '+
                             ' MOV.C_IND_BRI, MOV.N_SAL_BRI, MOV.C_DES_COR, '+
                             ' MOV.C_DES_COR CORCOTACAO, MOV.C_PRO_REF, MOV.N_PER_DES, MOV.C_ORD_COM, MOV.I_COD_TAM, '+
                             ' COR.COD_COR, COR.NOM_COR, '+
                             ' PRO.C_NOM_PRO, '+
                             ' TAM.NOMTAMANHO '+
                             ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO, COR, TAMANHO TAM '+
                             ' where MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                             ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                             ' AND '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                             ' ORDER BY MOV.I_SEQ_MOV');
  AdicionaSqlAbreTabela(Item2,'select SER.I_COD_SER, SER.C_NOM_SER,C_DES_ADI, '+
                             ' MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.N_VLR_TOT '+
                             ' from  MOVSERVICOORCAMENTO MOV, CADSERVICO SER '+
                             ' WHERE MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_COD_SER = SER.I_COD_SER');
  AdicionaSqlAbreTabela(Item3,'SELECT MOV.C_NRO_DUP, MOV.N_VLR_PAR, MOV.D_DAT_VEN, MOV.C_NRO_AGE, MOV.C_NRO_CON, '+
                              ' FRM.I_COD_FRM, FRM.C_NOM_FRM, '+
                              ' BAN.I_COD_BAN, BAN.C_NOM_BAN, '+
                              ' CON.C_NOM_CRR '+
                              ' FROM MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADFORMASPAGAMENTO FRM, CADBANCOS BAN, CADCONTAS CON '+
                              ' WHERE CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                              ' AND CAD.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                              ' AND MOV.I_COD_FRM = FRM.I_COD_FRM '+
                              ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                              ' AND MOV.I_LAN_REC = CAD.I_LAN_REC '+
                              ' and MOV.D_DAT_PAG IS NULL '+
                              ' AND '+SQLTextoRightJoin('MOV.C_NRO_CON','CON.C_NRO_CON')+
                              ' AND '+SQLTextoRightJoin('MOV.I_COD_BAN','BAN.I_COD_BAN'));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeGarantia(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Formulario de Garantia '+IntToStr(VpaNumPedido);
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_Garantia.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'select CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.C_CON_ORC, CAD.D_DAT_ORC, CAD.T_HOR_ORC, CAD.C_ORD_COM, CAD.N_VLR_TOT, '+
                                  ' CAD.D_DAT_PRE, CAD.L_OBS_ORC, '+
                                  ' TIP.I_COD_TIP, TIP.C_NOM_TIP, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  '  CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                                  ' TRA.C_NOM_TRA, '+
                                  ' PAG.C_NOM_PAG, '+
                                  ' FRM.C_NOM_FRM '+
                                  ' from CADORCAMENTOS CAD, CADTIPOORCAMENTO TIP, CADCLIENTES CLI, CADVENDEDORES VEN, CADTRANSPORTADORAS TRA, '+
                                  '           CADCONDICOESPAGTO PAG, CADFORMASPAGAMENTO FRM '+
                                  ' where CAD.I_TIP_ORC = TIP.I_COD_TIP '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                                  ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_TRA')+
                                  ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                                  ' AND CAD.I_COD_FRM = FRM.I_COD_FRM '+
                                  ' and CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and CAD.I_LAN_ORC = ' +IntToStr(VpaNumPedido));
  AdicionaSqlAbreTabela(Item,'select  MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_PRO, MOV.N_VLR_TOT, '+
                             ' MOV.C_IND_BRI, MOV.N_SAL_BRI, '+
                             ' PRO.C_NOM_PRO '+
                             ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                             ' where MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                             ' ORDER BY MOV.I_SEQ_MOV');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeChamado(VpaCodFilial,VpaNumChamado : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Chamado Técnico '+IntToStr(VpaNumChamado);
  Rave.projectfile := varia.PathRelatorios+'\Chamado\XX_Chamado.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.NOMCONTATO, CHA.NOMSOLICITANTE, CHA.DESENDERECOATENDIMENTO, '+
                                  ' CHA.DATCHAMADO, CHA.DATPREVISAO, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' USU.C_NOM_USU, '+
                                  ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                                  'FROM CHAMADOCORPO CHA, CADCLIENTES CLI, CADUSUARIOS USU, TECNICO TEC '+
                                  ' Where CHA.CODFILIAL =  '+IntToStr(VpaCodFilial)+
                                  ' AND CHA.NUMCHAMADO = '+IntToStr(VpaNumChamado)+
                                  ' AND CHA.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND CHA.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND CHA.CODTECNICO = TEC.CODTECNICO');
  AdicionaSqlAbreTabela(Item,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                             ' CHP.NUMSERIE, CHP.NUMCONTADOR, CHP.NUMSERIEINTERNO,CHP.DESSETOR, CHP.DESPROBLEMA, '+
                             ' CHP.DESSERVICOEXECUTADO, CHP.DATGARANTIA, '+
                             ' TIP.NOMTIPOCONTRATO '+
                             ' from CHAMADOPRODUTO CHP, CADPRODUTOS PRO, CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                             ' Where CHP.CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND CHP.NUMCHAMADO = '+ IntToStr(VpaNumChamado)+
                             ' AND CHP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND '+SQLTEXTORightJoin('CHP.CODFILIALCONTRATO','CON.CODFILIAL')+
                             ' AND '+SQLTEXTORightJoin('CHP.SEQCONTRATO','CON.SEQCONTRATO')+
                             ' AND '+SQLTEXTORightJoin('CON.CODTIPOCONTRATO','TIP.CODTIPOCONTRATO'));
  Rave.Execute;
end;


procedure TdtRave.ImprimeClientesSemPedido(VpaCodVendedor, VpaPreposto,  VpaCodSituacaoCliente, VpaCodTipoCotacao: Integer; VpaDatDesde: TDateTime;  VpaNomVendedor, VpaNomPreposto, VpaNomSituacaoCliente, VpaNomTipCotacao, VpaCaminhoRelatorio: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes sem pedido';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0100PL_Clientes Sem Pedido.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CON_CLI, CLI.C_CID_CLI,C_EST_CLI, CLI.C_FO1_CLI, CLI.I_COD_VEN , '+
                              ' VEN.C_NOM_VEN ');
  AdicionaSqlTabeLa(Principal,' from CADCLIENTES CLI, CADVENDEDORES VEN '+
                              ' Where CLI.I_COD_VEN = VEN.I_COD_VEN ');
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_COD_VEN = '+IntTostr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaPreposto <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_VEN_PRE = '+IntTostr(VpaPreposto));
    Rave.SetParam('PREPOSTO',VpaNomPreposto);
  end;
  if VpaCodSituacaoCliente <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and CLI.I_COD_SIT = '+IntTostr(VpaCodSituacaoCliente));
    Rave.SetParam('SITUACAOCLIENTE',VpaNomSituacaoCliente);
  end;
  AdicionaSqlTabela(Principal,' AND not exists (select * from CADORCAMENTOS CAD '+
                              ' where CAD.I_COD_CLI = CLI.I_COD_CLI ');
  if VpaCodTipoCotacao <> 0 then
  begin
    AdicionaSQLTabela(Principal,'and CAD.I_TIP_ORC ='+IntToStr(VpaCodTipoCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipCotacao);
  end;
  AdicionaSQLTabela(Principal,'and CAD.D_DAT_ORC >='+SQLTextoDataAAAAMMMDD(VpaDatDesde));
  Rave.SetParam('DATA',FormatDatetime('DD/MM/YYYY',VpaDatDesde));
  AdicionaSQLTabela(Principal,' and c_ind_cli = ''S'')');
  AdicionaSQLTabela(Principal,'order by ven.i_cod_ven, cli.c_est_cli, cli.c_cid_cli, cli.c_nom_cli');
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeChamadodaCotacao(VpaCodFilial,VpaNumPedido : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Chamado '+IntToStr(VpaNumPedido);
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_Chamado.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'select CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.C_CON_ORC, CAD.D_DAT_ORC, CAD.T_HOR_ORC, CAD.C_ORD_COM, CAD.N_VLR_TOT, '+
                                  ' CAD.D_DAT_PRE, CAD.L_OBS_ORC, CAD.I_TIP_FRE,  CAD.C_DES_CHA, '+
                                  ' TIP.I_COD_TIP, TIP.C_NOM_TIP, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  '  CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                                  ' USU.C_NOM_USU '+
                                  ' from CADORCAMENTOS CAD, CADTIPOORCAMENTO TIP, CADCLIENTES CLI, CADVENDEDORES VEN, CADUSUARIOS USU '+
                                  ' where CAD.I_TIP_ORC = TIP.I_COD_TIP '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                                  ' AND CAD.I_COD_USU = USU.I_COD_USU '+
                                  ' and CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' and CAD.I_LAN_ORC = ' +IntToStr(VpaNumPedido));
  AdicionaSqlAbreTabela(Item,'select  MOV.C_COD_PRO, MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.N_VLR_PRO, MOV.N_VLR_TOT, '+
                             ' MOV.C_IND_BRI, MOV.N_SAL_BRI, MOV.C_DES_COR, '+
                             ' PRO.C_NOM_PRO '+
                             ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                             ' where MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                             ' ORDER BY MOV.I_SEQ_MOV');
  AdicionaSqlAbreTabela(Item2,'select SER.I_COD_SER, SER.C_NOM_SER,'+
                             ' MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.N_VLR_TOT '+
                             ' from  MOVSERVICOORCAMENTO MOV, CADSERVICO SER '+
                             ' WHERE MOV.I_EMP_FIL = '+ IntToStr(VpaCodFilial)+
                             ' AND MOV.I_LAN_ORC = '+IntToStr(VpaNumPedido)+
                             ' AND MOV.I_COD_SER = SER.I_COD_SER');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidoCompra(VpaCodFilial,VpaSeqPedido : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedido Compra '+IntToStr(VpaSeqPedido);
  Rave.projectfile := varia.PathRelatorios+'\Compra\XX_Pedido de Compra.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'Select COR.CODFILIAL, COR.SEQPEDIDO, COR.DATPEDIDO, COR.HORPEDIDO, COR.DATPREVISTA, COR.NOMCONTATO, '+
                                  ' COR.CODCONDICAOPAGAMENTO, COR.VALTOTAL, COR.PERDESCONTO, COR.VALDESCONTO, COR.DESOBSERVACAO, '+
                                  ' COR.VALFRETE, COR.TIPFRETE, '+
                                  ' CLI.C_NOM_CLI, CLI.C_END_CLI, CLI.I_NUM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_FO1_CLI, '+
                                  ' CLI.C_FON_FAX, CLI.C_END_ELE,CLI.I_COD_CLI, CLI.C_CGC_CLI, CLI.C_INS_CLI, '+
                                  ' CLI.C_CID_CLI, CLI.C_EST_CLI, '+
                                  ' COM.NOMCOMPRADOR , '+
                                  ' USU.C_NOM_USU, '+
                                  ' TRA.C_NOM_TRA, '+
                                  ' FRM.C_NOM_FRM, '+
                                  ' PAG.C_NOM_PAG '+
                                  ' from PEDIDOCOMPRACORPO COR, CADCLIENTES CLI, COMPRADOR COM, '+
                                  ' CADUSUARIOS USU, CADTRANSPORTADORAS TRA, CADFORMASPAGAMENTO FRM, CADCONDICOESPAGTO PAG '+
                                  ' Where COR.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND COR.CODCOMPRADOR = COM.CODCOMPRADOR '+
                                  ' AND COR.CODUSUARIO = USU.I_COD_USU '+
                                  ' AND '+ SQLTextoRightJoin('COR.CODTRANSPORTADORA','TRA.I_COD_TRA')+
                                  ' AND '+ SQLTextoRightJoin('COR.CODFORMAPAGAMENTO','FRM.I_COD_FRM')+
                                  ' AND '+ SQLTextoRightJoin('COR.CODCONDICAOPAGAMENTO','PAG.I_COD_PAG')+
                                  ' and COR.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                  ' and COR.SEQPEDIDO = ' +IntToStr(VpaSeqPedido));
  AdicionaSqlAbreTabela(Item,'select PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.L_DES_TEC, '+
                             ' ITE.QTDPRODUTO,ITE.VALUNITARIO,ITE.VALTOTAL, ITE.CODCOR, ITE.CODTAMANHO, '+
                             ' ITE.DESUM, ITE.DESREFERENCIAFORNECEDOR, '+
                             ' COR.NOM_COR, '+
                             ' TAM.NOMTAMANHO '+
                             ' from  PEDIDOCOMPRAITEM ITE, CADPRODUTOS PRO, COR COR, TAMANHO TAM '+
                             ' WHERE ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' and ITE.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                             ' and ITE.SEQPEDIDO = ' +IntToStr(VpaSeqPedido)+
                             ' AND '+SQLTextoRightJoin('ITE.CODCOR','COR.COD_COR')+
                             ' AND '+SQLTextoRightJoin('ITE.CODTAMANHO','TAM.CODTAMANHO'));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEnvelope(VpaDCliente : TRBDCliente);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Envelope "'+VpaDCliente.NomCliente+'"';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\XX_Envelope.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,Varia.CodigoEmpFil);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  Rave.SetParam('CODCLIENTE',IntToStr(VpaDCliente.CodCliente));
  Rave.SetParam('NOMCLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('ENDCLIENTE',VpaDCliente.DesEndereco+', '+VpaDCliente.NumEndereco+ ' - '+VpaDCliente.DesComplementoEndereco);
  Rave.SetParam('BAICLIENTE',VpaDCliente.DesBairro);
  Rave.SetParam('CEPCLIENTE',VpaDCliente.CepCliente);
  Rave.SetParam('CIDCLIENTE',VpaDCliente.DesCidade);
  Rave.SetParam('UFCLIENTE',VpaDCliente.DesUF);
  Rave.SetParam('CONCLIENTE',VpaDCliente.NomContato);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEnvelopeEntrega(VpaDCliente : TRBDCliente);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Envelope "'+VpaDCliente.NomCliente+'"';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\XX_Envelope.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,Varia.CodigoEmpFil);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  Rave.SetParam('CODCLIENTE',IntToStr(VpaDCliente.CodCliente));
  Rave.SetParam('NOMCLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('ENDCLIENTE',VpaDCliente.DesEnderecoEntrega+', '+VpaDCliente.NumEnderecoEntrega );
  Rave.SetParam('BAICLIENTE',VpaDCliente.DesBairroEntrega);
  Rave.SetParam('CEPCLIENTE',VpaDCliente.CepEntrega);
  Rave.SetParam('CIDCLIENTE',VpaDCliente.DesCidadeEntrega);
  Rave.SetParam('UFCLIENTE',VpaDCliente.DesUFEntrega);
  Rave.SetParam('CONCLIENTE',VpaDCliente.NomContatoEntrega);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEnvelopeCobranca(VpaDCliente : TRBDCliente);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Envelope "'+VpaDCliente.NomCliente+'"';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\XX_Envelope.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,Varia.CodigoEmpFil);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  Rave.SetParam('CODCLIENTE',IntToStr(VpaDCliente.CodCliente));
  Rave.SetParam('NOMCLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('ENDCLIENTE',VpaDCliente.DesEnderecoCobranca+', '+VpaDCliente.NumEnderecoCobranca );
  Rave.SetParam('BAICLIENTE',VpaDCliente.DesBairroCobranca);
  Rave.SetParam('CEPCLIENTE',VpaDCliente.CepClienteCobranca);
  Rave.SetParam('CIDCLIENTE',VpaDCliente.DesCidadeCobranca);
  Rave.SetParam('UFCLIENTE',VpaDCliente.DesUFCobranca);
  Rave.SetParam('CONCLIENTE',VpaDCliente.NomContatoFinanceiro);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeExtratoColetaFracaoUsuario(VpaDatInicio,VpaDatFim: TDatetime; VpaCodCelula: Integer; VpaNomCelula: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Extrato Coleta Fração Celula '+VpaNomCelula;
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_Extrato Coleta Fracao Celula.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;

  AdicionaSqlAbreTabela(Principal,'SELECT PRO.C_NOM_PRO, ' +
                                  ' COL.CODFILIAL, COL.SEQORDEM, COL.SEQFRACAO, COL.SEQESTAGIO, ' +
                                  ' COL.SEQCOLETA, COL.CODCELULA, COL.DESUM, COL.QTDCOLETADO, ' +
                                  ' COL.QTDPRODUCAOHORA, COL.QTDPRODUCAOIDEAL, ' +
                                  ' COL.PERPRODUTIVIDADE, COL.DATINICIO, COL.DATFIM, ' +
                                  ' to_char(substr(COL.DATINICIO,1,8)) DATA, '+
                                  ' PRE.DESESTAGIO ' +
                                  ' FROM CADPRODUTOS PRO, COLETAFRACAOOP COL, PRODUTOESTAGIO PRE, FRACAOOPESTAGIO FRA ' +
                                  ' WHERE FRA.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                                  ' AND FRA.SEQPRODUTO = PRE.SEQPRODUTO ' +
                                  ' AND FRA.SEQESTAGIO = PRE.SEQESTAGIO ' +
                                  ' AND COL.CODFILIAL = FRA.CODFILIAL ' +
                                  ' AND COL.SEQORDEM = FRA.SEQORDEM ' +
                                  ' AND COL.SEQFRACAO = FRA.SEQFRACAO ' +
                                  ' AND COL.SEQESTAGIO = FRA.SEQESTAGIO'+
                                   SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',VpaDatInicio,IncDia(VpaDatFim,1),true)+
                                   ' AND COL.CODCELULA = '+IntToStr(VpaCodCelula)+
                                   ' ORDER BY COL.DATINICIO');
  Rave.SetParam('NOMCELULA',VpaNomCelula);
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeAutorizacaoPagamento(VpaCodFilial,VpaLanPagar, VpaNumParcela : Integer;VpaDatInicio, VpaDatFim : TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Autorização Pagamento '+IntToStr(VpaLanPagar);
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\xx_AutorizacaoPagamento.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;

  Principal.close;
  Principal.sql.clear;
  AdicionaSqlTabela(Principal,'select   CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' CAD.I_LAN_APG, CAD.D_DAT_EMI, CAD.I_QTD_PAR, '+
                              ' MOV.D_DAT_VEN, MOV.C_NRO_DUP, MOV.N_VLR_DUP, MOV.L_OBS_APG, MOV.I_NRO_PAR, '+
                              ' CLA.C_NOM_PLA '+
                              ' from CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV, CADCLIENTES CLI, CAD_PLANO_CONTA CLA '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_APG = MOV.I_LAN_APG '+
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND CLA.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                              ' AND CAD.C_CLA_PLA = CLA.C_CLA_PLA '+
                              ' AND CAD.I_EMP_FIL =  '+IntToStr(VpaCodFilial));
  if VpaLanPagar <> 0  then
  begin
    AdicionaSQLTabela(Principal,' AND CAD.I_LAN_APG = ' +IntToStr(VpaLanPagar));
    if VpaNumParcela <> 0  then
      AdicionaSQLTabela(Principal,'AND MOV.I_NRO_PAR = '+IntTosTr(VpaNumParcela));
  end
  else
    AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  AdicionaSQLTabela(Principal,'ORDER BY MOV.I_EMP_FIL, MOV.I_LAN_APG, MOV.I_NRO_PAR ');
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeExtratoLocacao(VpaCodFilial, VpaSeqLeitura : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Extrato locação '+IntToStr(VpaSeqLeitura);
  Rave.projectfile := varia.PathRelatorios+'\Contrato\XX_ExtratoLocacao.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPrinter;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'Select  LEI.CODFILIAL, LEI.SEQLEITURA, LEI.DATLEITURA, LEI.VALTOTALDESCONTO, LEI.QTDCOPIA, '+
                                  ' LEI.QTDDEFEITO, LEI.QTDEXCEDENTE, LEI.QTDCOPIACOLOR, LEI.QTDFRANQUIACOLOR, '+
                                  ' LEI.QTDEXCEDENTECOLOR, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE , '+
                                  ' CON.QTDFRANQUIA '+
                                  ' from LEITURALOCACAOCORPO LEI, CADCLIENTES CLI, CONTRATOCORPO CON '+
                                  ' Where LEI.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND LEI.CODFILIAL = CON.CODFILIAL '+
                                  ' AND LEI.SEQCONTRATO = CON.SEQCONTRATO '+
                                  ' AND LEI.CODFILIAL = '+InttoStr(VpaCodFilial)+
                                  ' AND LEI.SEQLEITURA = '+IntToStr(VpaSeqLeitura));
  AdicionaSqlAbreTabela(Item,'select ITE.CODFILIAL, ITE.SEQLEITURA, ITE.SEQITEM, ITE.CODPRODUTO, ITE.NUMSERIE, ITE.NUMSERIEINTERNO, ITE.DESSETOR, '+
                             ' ITE.QTDULTIMALEITURA, ITE.QTDLEITURA, ITE.QTDCOPIAS, ITE.QTDULTIMALEITURACOLOR, ITE.QTDLEITURACOLOR, '+
                             ' ITE.QTDCOPIASCOLOR, '+
                             ' PRO.C_COD_CTB, PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                             ' from LEITURALOCACAOITEM ITE, CADPRODUTOS PRO '+
                             ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND ITE.CODFILIAL = '+InttoStr(VpaCodFilial)+
                             ' AND ITE.SEQLEITURA = '+IntToStr(VpaSeqLeitura)+
                             ' order by ITE.SEQITEM');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeCaixa(VpaSeqCaixa : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Caixa '+IntToStr(VpaSeqCaixa);
  Rave.projectfile := varia.PathRelatorios+'\Caixa\XX_Caixa.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'SELECT COR.SEQCAIXA, COR.NUMCONTA, COR.DATABERTURA, COR.DATFECHAMENTO, COR.VALINICIAL, COR.VALATUAL, '+
                                  ' ITE.SEQITEM, ITE.VALLANCAMENTO, ITE.DESDEBITOCREDITO, ITE.DESLANCAMENTO, ITE.DATLANCAMENTO, '+
                                  ' ITE.DATPAGAMENTO, '+
                                  ' FRM.C_NOM_FRM '+
                                  ' FROM CAIXACORPO COR, CAIXAITEM ITE, CADFORMASPAGAMENTO FRM '+
                                  ' WHERE '+SQLTextoRightJoin('COR.SEQCAIXA','ITE.SEQCAIXA')+
                                  ' AND '+SQLTextoRightJoin('ITE.CODFORMAPAGAMENTO','FRM.I_COD_FRM')+
                                  ' AND COR.SEQCAIXA = '+IntToStr(VpaSeqCaixa)+
                                  ' ORDER BY ITE.DATPAGAMENTO, ITE.SEQITEM ' );
  AdicionaSQLAbreTabela(Item,'SELECT CAF.CODFORMAPAGAMENTO, CAF.VALINICIAL, CAF.VALATUAL, CAF.VALFINAL, '+
                             ' FRM.C_NOM_FRM '+
                             ' FROM CAIXAFORMAPAGAMENTO CAF, CADFORMASPAGAMENTO FRM '+
                             ' Where CAF.CODFORMAPAGAMENTO = FRM.I_COD_FRM '+
                             ' AND CAF.SEQCAIXA = '+IntToStr(VpaSeqCaixa));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEspelhoNota(VpaCodFilial,VpaSeqNota : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Espelho nota fiscal '+IntToStr(VpaSeqNota);
  Rave.projectfile := varia.PathRelatorios+'\Faturamento\8000FA_Espelho da Nota Fiscal.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT CAD.I_EMP_FIL ,CAD.I_SEQ_NOT, CAD.C_TIP_NOT, CAD.I_NRO_NOT, CAD.C_SER_NOT, '+
                                  ' CAD.D_DAT_EMI, CAD.D_DAT_SAI, CAD.L_OBS_NOT,  CAD.N_BAS_CAL, CAD.N_VLR_ICM, '+
                                  ' CAD.N_BAS_SUB, CAD.N_TOT_PRO, CAD.N_VLR_FRE, CAD.N_VLR_SEG, CAD.N_OUT_DES, '+
                                  ' CAD.N_TOT_IPI, CAD.N_TOT_NOT, CAD.I_TIP_FRE, CAD.C_NRO_PLA, CAD.C_EST_PLA, '+
                                  ' CAD.I_QTD_VOL, CAD.C_TIP_EMB, CAD.C_MAR_PRO, CAD.C_NRO_PAC, CAD.N_PES_BRU, '+
                                  ' CAD.N_PES_LIQ, CAD.C_NUM_PED, CAD.C_ORD_COM, CAD.L_OB1_NOT, '+
                                  ' NAT.C_COD_NAT, NAT.C_NOM_NAT, '+
                                  ' TRA.C_NOM_TRA, TRA.C_CGC_TRA, TRA.C_END_TRA, TRA.C_CID_TRA, TRA.C_EST_TRA, '+
                                  ' TRA.C_INS_TRA, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  ' CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  ' CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE '+
                                  ' FROM CADNOTAFISCAIS  CAD, CADNATUREZA NAT, CADCLIENTES CLI, CADTRANSPORTADORAS TRA '+
                                  ' WHERE CAD.C_COD_NAT = NAT.C_COD_NAT '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND '+SQLTextoRightJoin('CAD.I_COD_TRA','TRA.I_COD_TRA')+
                                  ' AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                                  ' AND CAD.I_SEQ_NOT = '+IntToSTr(VpaSEqNOta));
  AdicionaSqlAbreTabela(Item,'Select MOV.C_COD_PRO,  MOV.C_COD_CST, MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_TOT_PRO, MOV.N_PER_ICM, '+
                             ' MOV.N_PER_IPI, MOV.N_VLR_IPI, '+
                             ' PRO.C_NOM_PRO '+
                             ' FROM MOVNOTASFISCAIS MOV, CADPRODUTOS PRO '+
                             ' Where MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                             ' AND MOV.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                             ' AND MOV.I_SEQ_NOT = '+IntToSTr(VpaSEqNOta)+
                             ' order by MOV.I_SEQ_MOV');
  AdicionaSqlAbreTabela(Item3,'SELECT MOV.C_NRO_DUP, MOV.N_VLR_PAR, MOV.D_DAT_VEN, MOV.C_NRO_AGE, MOV.C_NRO_CON,'+
                              ' FRM.I_COD_FRM, FRM.C_NOM_FRM, '+
                              ' BAN.I_COD_BAN, BAN.C_NOM_BAN '+
                              ' FROM MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADFORMASPAGAMENTO FRM, CADBANCOS BAN '+
                              ' WHERE CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                              ' AND  CAD.I_SEQ_NOT = '+IntToSTr(VpaSEqNOta)+
                              ' AND MOV.I_COD_FRM = FRM.I_COD_FRM '+
                              ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                              ' AND MOV.I_LAN_REC = CAD.I_LAN_REC '+
                              ' AND MOV.I_COD_BAN = BAN.I_COD_BAN');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidoPendente(VpaCodFilial, VpaCodCliente,VpaCodClienteMaster, VpaSeqProduto: Integer; VpaCodClassificacao,VpaNomClassificacao,VpaNomCliente: String;VpaDatInicio,VpaDatFim : TDateTime;VpaClienteMaster : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos Pendentes';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\XX_PedidosPendentes.rav';
  PedidosPendentes.sql.clear;
  PedidosPendentes.sql.add('select  CAD.I_EMP_FIL, cad.d_dat_pre, cad.d_dat_orc, cad.i_lan_orc, cad.i_cod_cli, CAD.T_HOR_ENT, cli.c_nom_cli, '+
                             ' CAD.C_ORD_COM, '+
                             ' mov.n_qtd_pro, MOV.N_QTD_PRO - '+SQLTextoIsnull('MOV.N_QTD_BAI','0')+' QTDREAL, ' +
                             ' (MOV.N_QTD_PRO - '+SQLTextoIsnull('MOV.N_QTD_BAI','0')+')  * MOV.N_VLR_PRO TOTAL, ' +
                             ' pro.c_nom_pro,PRO.C_COD_PRO, mov.c_cod_uni, mov.n_vlr_pro, '+
                             ' MOV.C_DES_COR, MOV.C_PRO_REF, MOV.I_SEQ_MOV, MOV.I_SEQ_ORD '+
                             ' from cadorcamentos cad, movorcamentos mov, cadclientes cli, cadprodutos pro '+
                             ' where cad.i_emp_fil = mov.i_emp_fil '+
                             ' and cad.i_lan_orc = mov.i_lan_orc '+
                             ' and cad.i_cod_cli = cli.i_cod_cli '+
                             ' and mov.i_seq_pro = pro.i_seq_pro '+
                             ' and cad.c_fla_sit = ''A'''+
                             ' and (MOV.N_QTD_PRO - '+SqlTextoIsNull('MOV.N_QTD_BAI','0')+') > 0 ');

  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (VpaCodFilial = 0) then
    PedidosPendentes.sql.add(' and CAD.I_EMP_FIL <> 13');

  if (puPLImprimirValoresRelatorioPedidosPendentes in varia.PermissoesUsuario) or
     (puPLCompleto in varia.PermissoesUsuario) or
     (puAdministrador in varia.PermissoesUsuario) then
    Rave.SetParam('IMPRIMEVALOR','S')
  else
    Rave.SetParam('IMPRIMEVALOR','N');
  if VpaCodFilial <> 0 then
    PedidosPendentes.sql.add(' and cad.i_emp_fil = '+ IntToStr(VpaCodFilial));
  if VpaCodCliente <> 0 then
  begin
    Rave.SetParam('CLIENTE','Cliente : '+IntToStr(VpaCodCliente)+' - ' +VpaNomCliente);
    PedidosPendentes.sql.add(' and CAD.I_COD_CLI = '+ IntToStr(VpaCodCliente));
  end;
  if not VpaClienteMaster then
    PedidosPendentes.sql.add(' and CLI.I_CLI_MAS IS NULL');

  if VpaCodClienteMaster <> 0 then
    PedidosPendentes.sql.add(' and CLI.I_CLI_MAS = '+ IntToStr(VpaCodClienteMaster));
  if VpaSeqProduto <> 0 then
    PedidosPendentes.sql.add(' and MOV.I_SEQ_PRO = '+ IntToStr(VpaSeqProduto));
  if VpaCodClassificacao <> '' then
  begin
    Rave.SetParam('CLASSIFICACAO','Classificacao : '+VpaCodClassificacao+' - ' +VpaNomClassificacao);
    PedidosPendentes.sql.add(' and PRO.C_COD_CLA like '''+VpaCodClassificacao+'%''');
  end;
  if Config.ImprimirPedidoPendentesPorPeriodo then
  begin
    Rave.SetParam('PERIODO','Período de '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+  ' até ' +FormatDateTime('DD/MM/YYYY',VpaDatFim));
    PedidosPendentes.sql.add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_PRE',VpaDatInicio,VpaDatFim,true));
  end;

  if varia.CNPJFilial = CNPJ_METALVIDROS then
    PedidosPendentes.sql.add(' and CAD.I_TIP_ORC = '+ IntToStr(Varia.TipoCotacaoPedido));

  PedidosPendentes.sql.add(' and CAD.C_IND_CAN = ''N''');
  PedidosPendentes.sql.add(' order by cad.d_dat_pre, CAD.T_HOR_ENT, CAD.I_LAN_ORC ');
  PedidosPendentes.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeRemessa(VpaCodFilial, VpaSeqRemessa: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Remessa Bancaria';
  AdicionaSQlAbreTabela(Principal,'select BAN.I_COD_BAN, BAN.C_NOM_BAN, '+
                                  ' COR.NUMCONTA, COR.DATINICIO, COR.DATENVIO, COR.CODFILIAL,COR.SEQREMESSA, '+
                                  ' ITE.NOMMOTIVO, '+
                                  ' CON.C_NOM_CRR, '+
                                  ' MOV.C_NRO_DUP, MOV.D_DAT_VEN, MOV.N_VLR_PAR, '+
                                  ' CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                                  ' from REMESSACORPO COR, CADCONTAS CON, CADBANCOS BAN, REMESSAITEM ITE, MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, '+
                                  ' CADCLIENTES CLI '+
                                  ' Where COR.NUMCONTA = CON.C_NRO_CON '+
                                  ' AND  CON.I_COD_BAN = BAN.I_COD_BAN '+
                                  ' AND COR.CODFILIAL = ITE.CODFILIAL '+
                                  ' AND COR.SEQREMESSA = ITE.SEQREMESSA '+
                                  ' AND ITE.CODFILIAL= MOV.I_EMP_FIL '+
                                  ' AND ITE.LANRECEBER = MOV.I_LAN_REC '+
                                  ' AND ITE.NUMPARCELA = MOV.I_NRO_PAR '+
                                  ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' AND COR.CODFILIAL = '+ Inttostr(VpaCodFilial)+
                                  ' AND COR.SEQREMESSA = '+InttoStr(VpaSeqRemessa));

  Rave.projectfile := varia.PathRelatorios+'\Financeiro\XX_Remessa.rav';
  Rave.Execute;
end;

{*******************************************************************************}
procedure TdtRave.ImprimeRetorno(VpaCodFilial, VpaSeqRetorno: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Retorno Bancario';
  AdicionaSQlAbreTabela(Principal,'Select  * ' +
                          ' from RETORNOCORPO COR, RETORNOITEM ITE '+
                          ' Where COR.CODFILIAL = ITE.CODFILIAL '+
                          ' AND COR.SEQRETORNO = ITE.SEQRETORNO ' +
                          ' AND COR.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                          ' AND COR.SEQRETORNO = '+IntToSTr(VpaSeqRetorno)+
                          ' AND ITE.INDPOSSUIERRO = ''N'''+
                          ' ORDER BY ITE.INDPOSSUIERRO, ITE.CODOCORRENCIA');
  AdicionaSQlAbreTabela(Item,'Select  * ' +
                          ' from RETORNOCORPO COR, RETORNOITEM ITE '+
                          ' Where COR.CODFILIAL = ITE.CODFILIAL '+
                          ' AND COR.SEQRETORNO = ITE.SEQRETORNO ' +
                          ' AND COR.CODFILIAL = ' +IntToStr(VpaCodFilial)+
                          ' AND COR.SEQRETORNO = '+IntToSTr(VpaSeqRetorno)+
                          ' AND ITE.INDPOSSUIERRO = ''S'''+
                          ' ORDER BY ITE.INDPOSSUIERRO, ITE.CODOCORRENCIA');

  Rave.projectfile := varia.PathRelatorios+'\Financeiro\XX_Retorno.rav';
  Rave.Execute;
end;

{*******************************************************************************}
procedure TdtRave.ImprimeLeituraContratos(VpaCodCliente,VpaCodTecnico,VpaCodTipoContrato, VpaNumDiaLeitura: Integer;VpaCaminhoRelatorio,VpaNomCliente,VpaNomTecnico,VpaNomTipoContrato : String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Leitura dos Contratos ';
  Principal.close;
  Principal.sql.clear;
  AdicionaSQlTabela(Principal,'select  CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CID_CLI, CLI.C_FO1_CLI, ' +
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                              ' CON.CODFILIAL, CON.SEQCONTRATO, CON.CODTIPOCONTRATO, CON.DATASSINATURA, CON.DATCANCELAMENTO, '+
                              ' CON.QTDFRANQUIA, CON.NOMCONTATO, CON.NUMDIALEITURA, '+
                              ' TEC.CODTECNICO, TEC.NOMTECNICO, '+
                              ' TIP.NOMTIPOCONTRATO '+
                              ' FROM CONTRATOCORPO CON, CADCLIENTES CLI, CADVENDEDORES VEN, TECNICO TEC, TIPOCONTRATO TIP '+
                              ' Where CON.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND CON.CODVENDEDOR = VEN.I_COD_VEN '+
                              ' AND '+SQLTextoRightJoin('CON.CODTECNICOLEITURA','TEC.CODTECNICO')+
                              ' AND CON.CODTIPOCONTRATO =  TIP.CODTIPOCONTRATO '+
                              ' AND CON.DATCANCELAMENTO IS NULL');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.CODCLIENTE = '+Inttostr(VpacodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodTipoContrato <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.CODTIPOCONTRATO = '+Inttostr(VpacodTipoContrato));
    Rave.SetParam('TIPOCONTRATO',VpaNomTipoContrato);
  end;
  if VpaCodTecnico <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.CODTECNICOLEITURA = '+Inttostr(VpacodTecnico));
    Rave.SetParam('TECNICO',VpaNomTecnico);
  end;
  if VpaNumDiaLeitura <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CON.NUMDIALEITURA = '+Inttostr(VpaNumDiaLeitura));
    Rave.SetParam('DIALEITURA',Inttostr(VpaNumdiaLeitura));
  end;
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  AdicionaSqlTabela(Principal,' ORDER BY TEC.CODTECNICO');
  Principal.open;
  AdicionaSQlAbreTabela(Item,'select ITE.CODFILIAL, ITE.SEQCONTRATO, ITE.SEQITEM, ITE.NUMSERIE, ITE.DATULTIMALEITURA, ITE.QTDULTIMALEITURA, ' +
                             ' ITE.DESSETOR, ITE.NUMSERIEINTERNO, ITE.DATDESATIVACAO, ITE.QTDULTIMALEITURACOLOR, '+
                             ' PRO.C_NOM_PRO '+
                             ' from CONTRATOITEM ITE, CADPRODUTOS PRO '+
                             ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND ITE.DATDESATIVACAO IS NULL'+
                             ' ORDER BY ITE.CODFILIAL, ITE.SEQCONTRATO,ITE.SEQITEM');
  Rave.projectfile := varia.PathRelatorios+'\Contrato\0200PL_Leitura dos Contratos.rav';
  Rave.Execute;
end;

procedure TdtRave.ImprimeFracaoOP(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Fração Op '+IntToStr(VpaSeqOrdem);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_FracaoOP.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  AdicionaSqlAbreTabela(Principal,'Select  CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                                  ' ORC.I_LAN_ORC, ORC.D_DAT_ORC, T_HOR_ORC, '+
                                  ' PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                                  ' OPC.EMPFIL, OPC.SEQORD,  OPC.CODCOM, OPC.QTDFRA, OPC.ORDCLI, OPC.DESOBS, OPC.UNMPED, OPC.PROREF, '+
                                  ' COR.NOM_COR, '+
                                  ' FRA.SEQFRACAO, FRA.QTDPRODUTO, FRA.DATENTREGA, FRA.CODBARRAS '+
                                  ' from ORDEMPRODUCAOCORPO OPC, CADCLIENTES CLI, CADORCAMENTOS ORC, CADPRODUTOS PRO, COR, FRACAOOP FRA '+
                                  ' Where OPC.CODCLI = CLI.I_COD_CLI '+
                                  ' AND OPC.SEQPRO = PRO.I_SEQ_PRO '+
                                  ' AND OPC.EMPFIL = ORC.I_EMP_FIL '+
                                  ' AND OPC.NUMPED = ORC.I_LAN_ORC '+
                                  ' AND OPC.CODCOM = COR.COD_COR '+
                                  ' AND OPC.EMPFIL = FRA.CODFILIAL '+
                                  ' AND OPC.SEQORD = FRA.SEQORDEM '+
                                  ' AND FRA.CODFILIAL = '+IntTosTr(VpaCodFilial)+
                                  ' AND FRA.SEQORDEM = '+IntTosTr(VpaSeqOrdem)+
                                  ' AND FRA.SEQFRACAO = '+IntTosTr(VpaSEqFracao));
  AdicionaSqlAbreTabela(Item,'select FRE.SEQESTAGIO, FRE.INDPRODUCAO, '+
                             ' PRE.DESESTAGIO, '+
                             ' EST.CODEST, EST.NOMEST '+
                             ' from FRACAOOPESTAGIO FRE, PRODUTOESTAGIO PRE, ESTAGIOPRODUCAO EST '+
                             ' Where FRE.SEQPRODUTO = PRE.SEQPRODUTO '+
                             ' AND FRE.SEQESTAGIO = PRE.SEQESTAGIO '+
                             ' AND PRE.CODESTAGIO = EST.CODEST '+
                             ' AND FRE.CODFILIAL = '+IntTosTr(VpaCodFilial)+
                             ' AND FRE.SEQORDEM = '+IntTosTr(VpaSeqOrdem)+
                             ' AND FRE.SEQFRACAO = '+IntTosTr(VpaSEqFracao)+
                             ' ORDER BY FRE.SEQESTAGIO');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeOrdemCorteOP(VpaCodFilial, VpaSeqOrdem : Integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Ordem Corte '+IntToStr(VpaSeqOrdem);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_OrdemCorte.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  AdicionaSqlAbreTabela(Principal,'select BAS.LARBASTIDOR, BAS.ALTBASTIDOR, '+
                                  ' CLI.C_NOM_CLI, '+
                                  ' PRO.C_NOM_PRO, '+
                                  ' MAP.C_COD_PRO CODMATPRIMA, MAP.C_NOM_PRO NOMMATPRIMA, '+
                                  ' ENT.C_COD_PRO CODENTRETELA, ENT.C_NOM_PRO NOMENTRETELA, '+
                                  ' TER.C_COD_PRO CODTERMOCOLANTE, TER.C_NOM_PRO NOMTERMOCOLANTE, '+
                                  ' COR.NOM_COR, '+
                                  ' COM.NOM_COR CORMATPRIMA, '+
                                  ' FAC.NOMFACA,  FAC.ALTFACA, FAC.LARFACA, FAC.QTDPROVA, '+
                                  ' MAQ.NOMMAQ, '+
                                  ' OCI.CODMAQUINA, OCI.CODFACA, OCI.DESOBSERVACAO, OCI.LARMOLDE, OCI.ALTMOLDE, OCI.QTDPRODUTO, '+
                                  ' OCI.SEQTERMOCOLANTE, OCI.SEQENTRETELA, OCI.QTDTERMOCOLANTE, OCI.QTDENTRETELA, '+
                                  ' OCI.CODBASTIDOR, OCI.QTDPECASBASTIDOR, '+
                                  ' ORD.EMPFIL, ORD.SEQORD, ORD.DATEMI, ORD.DATENP, ORD.CODPRO, ORD.CODCOM, ORD.DESOBS, '+
                                  ' ORD.UNMPED, ORD.QTDORP, ORD.QTDFRA '+
                                  ' from ORDEMCORTEITEM OCI, ORDEMPRODUCAOCORPO ORD, BASTIDOR BAS,  CADCLIENTES CLI, CADPRODUTOS PRO, CADPRODUTOS MAP, CADPRODUTOS ENT, '+
                                  '         CADPRODUTOS TER, COR, COR COM, FACA FAC, MAQUINA MAQ '+
                                  ' WHERE OCI.CODFILIAL = ORD.EMPFIL '+
                                  ' AND OCI.SEQORDEMPRODUCAO = ORD.SEQORD '+
                                  ' AND OCI.SEQPRODUTO = MAP.I_SEQ_PRO '+
                                  ' AND OCI.CODCOR = COM.COD_COR '+
                                  ' AND '+ SQLTextoRightJoin('OCI.CODFACA','FAC.CODFACA')+
                                  ' AND '+ SQLTextoRightJoin('OCI.CODMAQUINA','MAQ.CODMAQ')+
                                  ' AND '+ SQLTextoRightJoin('OCI.SEQENTRETELA','ENT.I_SEQ_PRO')+
                                  ' AND '+ SQLTextoRightJoin('OCI.SEQTERMOCOLANTE','TER.I_SEQ_PRO')+
                                  ' AND '+ SQLTextoRightJoin('OCI.CODBASTIDOR','BAS.CODBASTIDOR')+
                                  ' AND ORD.CODCLI = CLI.I_COD_CLI '+
                                  ' AND ORD.SEQPRO = PRO.I_SEQ_PRO '+
                                  ' AND ORD.CODCOM = COR.COD_COR '+
                                  ' AND ORD.EMPFIL = '+IntTosTr(VpaCodFilial)+
                                  ' AND ORD.SEQORD = '+IntTosTr(VpaSeqOrdem)+
                                  ' ORDER BY OCI.SEQITEM');
  AdicionaSqlAbreTabela(Item,'Select CODFILIAL, SEQORDEM, SEQFRACAO, QTDPRODUTO, CODBARRAS '+
                             ' from FRACAOOP '+
                             ' WHERE CODFILIAL = '+IntTosTr(VpaCodFilial)+
                             ' AND SEQORDEM = '+IntTosTr(VpaSeqOrdem)+
                             ' ORDER BY SEQFRACAO ');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidoCompraPendente;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos Compras Pendentes';
  Rave.projectfile := varia.PathRelatorios+'\Compra\xx_PedidoPendente.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'select CLI.C_NOM_CLI, '+
                                  ' PRO.C_NOM_PRO, '+
                                  ' COR.NOM_COR, '+
                                  ' COP.CODFILIAL, COP.SEQPEDIDO, COP.DATPEDIDO, COP.CODCLIENTE, COP.DATPREVISTA, COP.DATENTREGA, COP.DATRENEGOCIADO, '+
                                  ' ITE.DESUM, ITE.QTDPRODUTO, ITE.QTDBAIXADO, ITE.VALTOTAL '+
                                  ' from PEDIDOCOMPRAITEM ITE, PEDIDOCOMPRACORPO COP, CADCLIENTES CLI, CADPRODUTOS PRO, COR '+
                                  ' WHERE COP.CODFILIAL = ITE.CODFILIAL '+
                                  ' AND COP.SEQPEDIDO = ITE.SEQPEDIDO '+
                                  ' AND COP.CODCLIENTE = CLI.I_COD_CLI '+
                                  ' AND ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                  ' AND ITE.CODCOR = COR.COD_COR '+
                                  ' AND COP.DATENTREGA IS NULL '+
                                  ' AND NVL(ITE.QTDBAIXADO,0) < ITE.QTDPRODUTO '+
                                  ' ORDER BY COP.DATPREVISTA');
  Rave.Execute;
end;


{******************************************************************************}
procedure TdtRave.ImprimeVendasAnalitico(VpaCodFilial,VpaCodCliente,VpaCodCondicaoPagamento, VpaCodTipoCotacao,VpaCodVendedor,VpaCodPreposto : Integer;VpaDatInicio,VpaDatFim : TDatetime;VpaCaminhoRelatorio,VpaDesCidade,VpaUF,VpaNomCliente,VpaNomCondicaoPagamento,VpaNomTipoCotacao,VpaNomVendedor,VpaNomFilial,VpaNomPreposto : string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Vendas Analitico';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0100PL_Venda Analitico.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.close;
  Principal.sql.clear;
  Principal.sql.add('SELECT CAD.I_EMP_FIL , CAD.I_LAN_ORC, CAD.D_DAT_ORC, CAD.N_VLR_TOT, CAD.C_NRO_NOT, CAD.I_TIP_ORC, '+
                    ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                    ' PAG.I_COD_PAG, PAG.C_NOM_PAG, '+
                    ' VEN.C_NOM_VEN '+
                    ' FROM CADORCAMENTOS CAD, CADCLIENTES CLI, CADCONDICOESPAGTO PAG, CADVENDEDORES VEN '+
                    ' Where CAD.I_COD_CLI = CLI.I_COD_CLI '+
                    ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                    ' AND CAD.I_COD_VEN = VEN.I_COD_VEN ');
  Item.Close;
  Item.sql.clear;
  Item.sql.add('SELECT CAD.I_EMP_FIL , CAD.I_LAN_ORC, '+
                              ' MOV.C_COD_PRO, MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_VLR_TOT, '+
                              ' PRO.C_NOM_PRO '+
                              ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADPRODUTOS PRO, CADCLIENTES CLI '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ');
  Item2.Close;
  Item2.sql.clear;
  Item2.sql.add('SELECT CAD.I_EMP_FIL , CAD.I_LAN_ORC, '+
                              ' MOV.I_COD_SER, ''SE'', MOV.N_QTD_SER, MOV.N_VLR_SER, MOV.N_VLR_TOT, '+
                              ' SER.C_NOM_SER '+
                              ' FROM CADORCAMENTOS CAD, MOVSERVICOORCAMENTO MOV, CADSERVICO SER, CADCLIENTES CLI '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND MOV.I_COD_SER = SER.I_COD_SER ');

  if VpaCodFilial <> 0  then
  begin
   Principal.sql.add('AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial));
   Item.sql.add('AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial));
   Item2.sql.add('AND CAD.I_EMP_FIL = '+IntToStr(VpaCodFilial));
   Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaCodCliente <> 0 then
  begin
   Principal.sql.add('AND CAD.I_COD_CLI = '+IntToStr(VpaCodCliente));
   Item.sql.add('AND CAD.I_COD_CLI = '+IntToStr(VpaCodCliente));
   Item2.sql.add('AND CAD.I_COD_CLI = '+IntToStr(VpaCodCliente));
   Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if VpaCodCondicaoPagamento <> 0  then
  begin
   Principal.sql.add('AND CAD.I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
   Item.sql.add('AND CAD.I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
   Item2.sql.add('AND CAD.I_COD_PAG = '+IntToStr(VpaCodCondicaoPagamento));
   Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCondicaoPagamento);
  end;
  if VpaCodTipoCotacao <> 0  then
  begin
   Principal.sql.add('AND CAD.I_TIP_ORC = '+IntToStr(VpaCodTipoCotacao));
   Item.sql.add('AND CAD.I_TIP_ORC = '+IntToStr(VpaCodTipoCotacao));
   Item2.sql.add('AND CAD.I_TIP_ORC = '+IntToStr(VpaCodTipoCotacao));
   Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaCodVendedor <> 0  then
  begin
   Principal.sql.add('AND CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
   Item.sql.add('AND CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
   Item2.sql.add('AND CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
   Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodPreposto <> 0  then
  begin
   Principal.sql.add('AND CAD.I_VEN_PRE = '+IntToStr(VpaCodPreposto));
   Item.sql.add('AND CAD.I_VEN_PRE = '+IntToStr(VpaCodPreposto));
   Item2.sql.add('AND CAD.I_VEN_PRE = '+IntToStr(VpaCodPreposto));
   Rave.SetParam('PREPOSTO',VpaNomPreposto);
  end;
  if VpaDesCidade <> ''  then
  begin
   Principal.sql.add('AND CLI.C_CID_CLI = '''+VpaDesCidade+'''');
   Item.sql.add('AND CLI.C_CID_CLI = '''+VpaDesCidade+'''');
   Item2.sql.add('AND CLI.C_CID_CLI = '''+VpaDesCidade+'''');
   Rave.SetParam('CIDADE',VpaDesCidade);
  end;
  if VpaUF <> ''  then
  begin
   Principal.sql.add('AND CLI.C_EST_CLI = '''+VpaUF+'''');
   Item.sql.add('AND CLI.C_EST_CLI = '''+VpaUF+'''');
   Item2.sql.add('AND CLI.C_EST_CLI = '''+VpaUF+'''');
   Rave.SetParam('UF',VpaUF);
  end;
  Rave.SetParam('PERIODO',FormatDateTime('DD/MM/YY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YY',VpaDatFim));
  Principal.sql.add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                    ' and CAD.C_IND_CAN = ''N''');
  Item.sql.add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                    ' and CAD.C_IND_CAN = ''N''');
  Item2.sql.add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                    ' and CAD.C_IND_CAN = ''N''');

  Principal.sql.add(' ORDER BY CAD.D_DAT_ORC, CAD.I_LAN_ORC');
  Item.sql.add(' ORDER BY CAD.I_EMP_FIL, CAD.I_LAN_ORC');
  Item2.sql.Add(' ORDER BY CAD.I_EMP_FIL, CAD.I_LAN_ORC');
  Rave.Execute;
end;

procedure TdtRave.ImprimeConsistenciadeEstoque(VpaCodFilial, VpaSeProduto : Integer;VpaDatInicio,VpaDatFim : TDateTime;VpaCaminhoRelatorio,VpaNomFilial,VpaNomProduto : String;VpaIndSomenteMonitorados : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Consistencia Estoque';
  Rave.projectfile := varia.PathRelatorios+'\Produto\1000ESPLFA_Consistencia de Estoque.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT  OPE.C_NOM_OPE, '+
                              ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                              ' MOV.I_EMP_FIL, MOV.I_COD_OPE, MOV.D_DAT_MOV, MOV.N_QTD_MOV, '+
                              ' MOV.N_VLR_MOV, MOV.I_NRO_NOT, MOV.C_COD_UNI,MOV.I_LAN_ORC, MOV.I_SEQ_ORD, '+
                              ' MOV.I_COD_COR, MOV.I_COD_TAM,MOV.I_NRO_NOT, MOV.N_QTD_INI, MOV.N_QTD_FIN, '+
                              ' COR.NOM_COR, '+
                              ' TAM.NOMTAMANHO, '+
                              ' TEC.NOMTECNICO ');
  AdicionaSqlTabeLa(Principal,' FROM  MOVESTOQUEPRODUTOS MOV, CADOPERACAOESTOQUE OPE, CADPRODUTOS PRO, COR , TAMANHO TAM, TECNICO TEC '+
                              ' Where MOV.I_COD_OPE = OPE.I_COD_OPE '+
                              ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                              ' AND '+SQLTextoRightJoin('MOV.I_COD_COR','COR.COD_COR')+
                              ' AND '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                              ' AND '+SQLTextoRightJoin('MOV.I_COD_TEC','TEC.CODTECNICO')+
                              SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_MOV',VpaDatInicio,VpaDatFim,True));
  if VpaCodFILIAL <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and MOV.I_EMP_FIL = '+IntTostr(VpaCodFilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;
  if VpaSeProduto <> 0 then
  begin
    AdicionaSqlTabela(Principal,'and MOV.I_SEQ_PRO = '+IntTostr(VpaSeProduto));
    Rave.SetParam('PRODUTO',VpaNomProduto);
  end;
  if VpaIndSomenteMonitorados then
  begin
    AdicionaSqlTabela(Principal,'and PRO.C_IND_MON = ''S''');
  end;
  AdicionaSqlTabela(Principal,'ORDER BY MOV.D_DAT_MOV, MOV.I_COD_OPE');
  Rave.SetParam('PERIODO',FormatDatetime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeConsistenciaReservaEstoque(VpaSeProduto: Integer; VpaCaminho, VpaNomProduto: String; VpaDatInicio,  VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Consistencia Reserva Produto';
  Rave.projectfile := varia.PathRelatorios+'\Produto\Reserva Estoque\1000ES_Consistencia Reserva Estoque.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT PRE.SEQPRODUTO, PRE.TIPMOVIMENTO, PRE.DATRESERVA, PRE.QTDRESERVADA , PRE.QTDINICIAL, '+
                              ' PRE.QTDFINAL, PRE.SEQORDEMPRODUCAO, PRE.DESUM, '+
                              ' PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                              '  USU.C_NOM_USU '+
                              ' FROM RESERVAPRODUTO PRE, CADUSUARIOS USU, CADPRODUTOS PRO '+
                              ' Where PRE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              ' AND PRE.CODUSUARIO = USU.I_COD_USU');
  if VpaSeProduto <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND PRO.I_SEQ_PRO = '+InttoStr(VpaSeProduto));
    Rave.SetParam('PRODUTO','Produto : '+VpaNomProduto);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('PRE.DATRESERVA',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' ORDER BY  PRE.DATRESERVA, PRE.TIPMOVIMENTO');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeConsumoSubmontagem(VpaCodFilial, VpaSeqOrdemProduccao, VpaSeqFracao : Integer;VpaSomenteAReservar, VpaConsumoExcluir : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Consumo Submontagem op '+IntToStr(VpaSeqOrdemProduccao);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_ConsumoSubmontagem.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.Close;
  Principal.SQL.clear;
  AdicionaSqlTabela(Principal,'select CLA.C_COD_CLA, CLA.C_NOM_CLA, '+
                                  '  PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                                  ' MP.C_COD_PRO CODMP, MP.C_NOM_PRO NOMMP, '+
                                  ' IMP.DESUM, IMP.QTDPRODUTO, IMP.QTDBAIXADO, IMP.QTDRESERVADA, '+
                                  ' IMP.QTDARESERVAR, IMP.INDMATERIALEXTRA, '+
                                  ' FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO '+
                                  ' from CADCLASSIFICACAO CLA, CADPRODUTOS PRO, CADPRODUTOS MP, FRACAOOP FRA, IMPRESSAOCONSUMOFRACAO IMP '+
                                  ' Where MP.I_COD_EMP = CLA.I_COD_EMP '+
                                  ' AND MP.C_COD_CLA = CLA.C_COD_CLA '+
                                  ' AND MP.C_TIP_CLA = CLA.C_TIP_CLA '+
                                  ' AND MP.I_SEQ_PRO = IMP.SEQMATERIAPRIMA '+
                                  ' AND IMP.CODFILIAL = FRA.CODFILIAL '+
                                  ' AND IMP.SEQORDEM = FRA.SEQORDEM '+
                                  ' AND IMP.SEQFRACAO = FRA.SEQFRACAO '+
                                  ' AND FRA.SEQPRODUTO = PRO.I_SEQ_PRO ');
  if VpaSomenteAReservar  then
    AdicionaSQLTabela(Principal,'AND IMP.QTDARESERVAR > 0 ');

  AdicionaSqlTabela(Principal,' ORDER BY PRO.C_COD_PRO, CLA.C_COD_CLA, MP.C_NOM_PRO');
  Principal.open;
  if  VpaConsumoExcluir then
    Rave.SetParam('DESTITULO','PRODUTOS A EXCLUIR');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeDevolucoesPendente(VpaCodFilial, VpaCodCliente,  VpaCodTransportadora, VpaCodEstagio: Integer; VpaData: TDatetime;  VpaCaminhoRelatorio, VpaNomFilial, VpaNomCliente, VpaNomTranportadora,  VpaNomEstagio: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Devoluções pendentes';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\0300PL_Devolucoes Pendentes.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.close;
  Principal.sql.clear;
  AdicionaSQlTabela(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.D_DAT_ORC, CAD.I_COD_TRA, CAD.I_COD_EST, CAD.C_IND_PEN, '+
                              ' PRO.C_NOM_PRO, PRO.C_IND_RET, '+
                              ' MOV.N_QTD_PRO, MOV.C_COD_UNI, MOV.C_COD_PRO, MOV.N_QTD_DEV, '+
                              ' (MOV.N_QTD_PRO - NVL(N_QTD_DEV,0)) QTDPENDENTE '+
                              ' FROM CADCLIENTES CLI, CADORCAMENTOS CAD, CADPRODUTOS PRO, MOVORCAMENTOS MOV '+
                              ' Where CLI.I_COD_CLI = CAD.I_COD_CLI '+
                              ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                              ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                              ' AND MOV.I_LAN_ORC = CAD.I_LAN_ORC '+
                              ' AND CAD.C_IND_PEN = ''S'' '+
                              ' AND PRO.C_IND_RET = ''S'' '+
                              ' AND CAD.D_DAT_ORC > '+SQLTextoDataAAAAMMMDD(VpaData)+
                              ' AND MOV.N_QTD_PRO > NVL(MOV.N_QTD_DEV,0) ');
  if VpaCodFilial <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND CAD.I_EMP_FIL =  '+IntTostr(VpaCodfilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end;

  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND CAD.I_COD_TRA =  '+IntTostr(VpaCodTransportadora));
    Rave.SetParam('TRANSPORTADORA',VpaNomTranportadora);
  end;

  if VpaCodEstagio <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND CAD.I_COD_EST =  '+IntTostr(VpaCodEstagio));
    Rave.SetParam('ESTAGIO',VpaNomEstagio);
  end;

  if VpaCodCliente <> 0 then
  begin
    AdicionaSQlTabela(Principal,'AND CAD.I_COD_CLI = '+Inttostr(VpacodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  Rave.SetParam('DATFINAL',FormatDateTime('DD/MM/YYYY',VpaData));

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  AdicionaSqlTabela(Principal,' ORDER BY CAD.I_EMP_FIL , CAD.I_LAN_ORC');
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeRecibo(VpaCodFilial : Integer ;VpaDCliente : TRBDCliente;VpaDesDuplicata, VpaValDuplicata,VpaValExtenso,VpaLocaleData : String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Recibo';
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\XX_Recibo.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;

  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);

  Rave.SetParam('CODCLIENTE',IntToStr(VpaDCliente.CodCliente));
  Rave.SetParam('NOMCLIENTE',VpaDCliente.NomCliente);
  Rave.SetParam('ENDCLIENTE',VpaDCliente.DesEndereco+', '+VpaDCliente.NumEndereco+ ' - '+VpaDCliente.DesComplementoEndereco);
  Rave.SetParam('BAICLIENTE',VpaDCliente.DesBairro);
  Rave.SetParam('CEPCLIENTE',VpaDCliente.CepCliente);
  Rave.SetParam('CIDCLIENTE',VpaDCliente.DesCidade);
  Rave.SetParam('UFCLIENTE',VpaDCliente.DesUF);
  Rave.SetParam('CONCLIENTE',VpaDCliente.NomContato);
  Rave.SetParam('DESDATADUPLICATA',VpaLocaleData);
  Rave.SetParam('DESDUPLICATA',VpaDesDuplicata);
  Rave.SetParam('VALDUPLICATA',VpaValDuplicata);
  Rave.SetParam('VALEXTENSO',VpaValExtenso);
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEstoqueFiscal(VpaCodFilial, VpaSeqProduto: integer; VpaCaminhoRelatorio, VpaNomFilial,  VpaNomProduto: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Estoque Fiscal';
  Rave.projectfile := varia.PathRelatorios+'\Produto\Estoque\3000ESPL_Estoque Fiscal.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Principal.close;
  Principal.sql.clear;
  AdicionaSQlTabela(Principal,'select  PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO,  PRO.C_ATI_PRO, '+
                              ' MOV.I_EMP_FIL, MOV.N_VLR_COM, MOV.I_COD_COR, NVL(MOV.N_QTD_FIS,0) N_QTD_FIS '+
                              ' from CADPRODUTOS PRO, MOVQDADEPRODUTO MOV '+
                              ' Where PRO.I_SEQ_PRO = MOV.I_SEQ_PRO '+
                              ' AND PRO.C_ATI_PRO = ''S'' ');
  if VpaCodFilial <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND MOV.I_EMP_FIL =  '+IntTostr(VpaCodfilial));
    Rave.SetParam('FILIAL',VpaNomFilial);
  end
  else
  begin
    AdicionaSQlTabela(Principal,' AND CAD.I_COD_EMP =  '+IntTostr(Varia.CodigoEmpresa));
    Rave.SetParam('EMPRESA',Varia.NomeEmpresa);
  end;

  if VpaSeqProduto <> 0 then
  begin
    AdicionaSQlTabela(Principal,' AND CAD.I_SEQ_PRO =  '+IntTostr(VpaSeqProduto));
    Rave.SetParam('PRODUTO',VpaNomProduto);
  end;

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);
  AdicionaSqlTabela(Principal,' ORDER BY MOV.N_QTD_FIS');
  Principal.open;
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeEstoqueProdutoporTecnico(VpaCodTEcnico: Integer; VpaCaminho, VpaNomTecnico: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Estoque de produtos por tecnico';
  Rave.projectfile := varia.PathRelatorios+'\Produto\2000ES_Estoque de Produtos Por Tecnico.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select PRO.C_COD_PRO, PRO.C_COD_UNI, PRO.C_NOM_PRO, '+
                              ' EST.QTDPRODUTO, '+
                              ' TEC.NOMTECNICO '+
                              ' from CADPRODUTOS PRO, ESTOQUETECNICO EST, TECNICO TEC '+
                              ' Where PRO.I_SEQ_PRO = EST.SEQPRODUTO '+
                              ' AND EST.CODTECNICO = TEC.CODTECNICO '+
                              ' AND EST.QTDPRODUTO <> 0');
  if VpaCodTEcnico <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND TEC.CODTECNICO = '+InttoStr(VpaCodTecnico));
    Rave.SetParam('TECNICO','Técnico : '+VpaNomTecnico);
  end;
  AdicionaSqlTabeLa(Principal,' ORDER BY  TEC.NOMTECNICO');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeNotaFiscalEntrada(VpaCodFilial,VpaSeqNota : integer;VpaVisualizar : Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Nota fiscal de Entrada '+IntToStr(VpaSeqNota);
  Rave.projectfile := varia.PathRelatorios+'\Nota Entrada\XX_NotaEntrada.rav';
  Rave.clearParams;
  if VpaVisualizar then
    RvSystem1.defaultDest := rdPreview
  else
    RvSystem1.defaultDest := rdPrinter;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'Select CLI.I_COD_CLI, CLI.C_NOM_CLI,  CLI.C_NOM_FAN, CLI.C_END_CLI, CLI.I_NUM_END, '+
                                  '  CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CGC_CLI, '+
                                  '  CLI.C_INS_CLI, CLI.C_FO1_CLI, CLI.C_FON_FAX, CLI.C_END_ELE, '+
                                  '  CAD.I_EMP_FIL, CAD.I_SEQ_NOT, CAD.N_TOT_NOT, '+
                                  '  PRO.C_COD_PRO, PRO.C_NOM_PRO NOMEORIGINAL, '+
                                  '  MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_TOT_PRO, MOV.C_NOM_PRO '+
                                  '  FROM CADCLIENTES CLI, CADNOTAFISCAISFOR CAD, CADPRODUTOS PRO, MOVNOTASFISCAISFOR MOV '+
                                  '  Where CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  '  AND CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                  '  AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                                  '  AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                  '  AND CAD.I_EMP_FIL = ' + IntToStr(VpaCodFilial)+
                                  '  AND CAD.I_SEQ_NOT = ' + IntToStr(VpaSeqNota));
  Rave.Execute;
end;


{******************************************************************************}
procedure TdtRave.ImprimeOrdemSerra(VpaCodFilial, VpaSeqOrdemProducao : Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Ordem Serra op '+IntToStr(VpaSeqOrdemProducao);
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\XX_OrdemSerra.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  Sistema.CarDFilial(VprDFilial,VpaCodFilial);
  FunRave.EnviaParametrosFilial(Rave,VprDFilial);
  AdicionaSqlAbreTabela(Principal,'SELECT PRO.I_SEQ_PRO, PRO.C_COD_PRO, '+
                                  ' MAP.C_NOM_PRO NOMMATERIAPRIMA, MAP.L_DES_TEC DESTECNICAMATERIAPRIMA, '+
                                  ' POP.C_NOM_PRO NOMPRODUTOOP, '+
                                  ' OP.EMPFIL, OP.SEQORD, '+
                                  ' ORS.SEQORDEMSERRA, ORS.SEQPRODUTO, ORS.COMMATERIAPRIMA, ORS.QTDPRODUTO '+
                                  ' FROM CADPRODUTOS PRO, CADPRODUTOS MAP, CADPRODUTOS POP, ORDEMPRODUCAOCORPO OP, ORDEMSERRA ORS '+
                                  ' WHERE OP.SEQPRO = POP.I_SEQ_PRO '+
                                  ' AND ORS.CODFILIAL = OP.EMPFIL '+
                                  ' AND ORS.SEQORDEMPRODUCAO = OP.SEQORD '+
                                  ' AND ORS.SEQMATERIAPRIMA = MAP.I_SEQ_PRO '+
                                  ' AND ORS.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                  ' AND ORS.CODFILIAL = '+IntToStr(VpaCodFilial)+
                                  ' AND ORS.SEQORDEMPRODUCAO  = '+IntToStr(VpaSeqOrdemProducao)+
                                  ' ORDER BY MAP.C_NOM_PRO, ORS.SEQORDEMSERRA');
  Rave.Execute;
end;


{******************************************************************************}
procedure TdtRave.ImprimeEtiquetaProduto10X3A4;
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Etiqueta Produto';
  Rave.projectfile := varia.PathRelatorios+'\Etiqueta\XX_Produtos 10 X 3 - A4(25mm x 67mm).rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'Select * from ETIQUETAPRODUTO order by CODPRODUTO');
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimePedidosEmAbertoPorEstagio(VpaCodEstagio, VpaCodTransportadora : Integer; VpaCaminho, VpaNomEstagio: String;VpaDatInicio, VpaDatFim : TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Pedidos em Aberto por Estagio';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\2000PL_Cotacoes em Aberto por Estagio.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT  CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' ORC.I_EMP_FIL, ORC.I_LAN_ORC, ORC.D_DAT_ORC, ORC.T_HOR_ORC,'+
                              ' ORC.D_DAT_PRE, ORC.I_COD_EST, '+
                              ' EST.NOMEST '+
                              'FROM CADCLIENTES CLI, CADORCAMENTOS ORC, ESTAGIOPRODUCAO EST '+
                              ' Where ORC.I_COD_CLI = CLI.I_COD_CLI '+
                              ' AND ORC.I_COD_EST = EST.CODEST'+
                               SQLTextoDataEntreAAAAMMDD('ORC.D_DAT_ORC',VpaDatInicio,VpaDatFim,true));
  if VpaCodEstagio <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND ORC.I_COD_EST = '+InttoStr(VpaCodEstagio));
    Rave.SetParam('ESTAGIO',VpaNomEstagio);
  end;
  if VpaCodTransportadora <> 0 then
    AdicionaSqlTabeLa(Principal,'AND ORC.I_COD_TRA = '+InttoStr(VpaCodTransportadora));

  AdicionaSqlTabeLa(Principal,'ORDER BY EST.NOMEST, ORC.D_DAT_ORC');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeFilaChamadosPorTecnico(VpaCodEstagio,  VpaCodTecnico: Integer; VpaCaminhoRelatorio, VpaNomEstagio,  VpaNomTecnico: String;VpaDatInicio, VpaDatFim : TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Fila chamados por tecnico';
  Rave.projectfile := varia.PathRelatorios+'\Chamado\1000CH_Fila Chamados por Tecnico.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CID_CLI, '+
                              ' CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.DATCHAMADO, CHA.DATPREVISAO, CHA.DATPREVISAO HORA, CHA.NOMSOLICITANTE, '+
                              ' CHA.CODESTAGIO, '+
                              ' CHP.DESPROBLEMA, '+
                              ' EST.CODEST, EST.NOMEST, '+
                              ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                              ' from CADCLIENTES CLI, CHAMADOCORPO CHA, CHAMADOPRODUTO CHP, ESTAGIOPRODUCAO EST, TECNICO TEC '+
                              ' WHERE CHA.CODFILIAL= CHP.CODFILIAL '+
                              ' AND CHA.NUMCHAMADO = CHP.NUMCHAMADO '+
                              ' AND CHA.CODTECNICO = TEC.CODTECNICO '+
                              ' AND CHA.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND CHA.CODESTAGIO = EST.CODEST '+
                              ' AND CHA.CODESTAGIO < 170 ');

  if VpaCodEstagio <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CHA.CODESTAGIO = '+InttoStr(VpaCodEstagio));
    Rave.SetParam('ESTAGIO',VpaNomEstagio);
  end;
  if VpaCodTecnico <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CHA.CODTECNICO = '+InttoStr(VpaCodTecnico));
    Rave.SetParam('TECNICO',VpaNomTecnico);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CHA.DATPREVISAO',VpaDatInicio,IncDia(VpaDatFim,1),true));
  Rave.SetParam('PERIODO','Período de '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));

  AdicionaSqlTabeLa(Principal,'ORDER BY TEC.NOMTECNICO,EST.CODEST, CHA.DATPREVISAO');

  Rave.SetParam('CAMINHO',VpaCaminhoRelatorio);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeFichaDesenvolvimento(VpaCodAmostra: Integer);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Ficha Desenvolvimento';
  Rave.projectfile := varia.PathRelatorios+'\Amostra\xx_FichaDesenvolvimento.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlAbreTabeLa(Principal,'select AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA, AMO.DATENTREGACLIENTE, AMO.INDCOPIA, '+
                              ' AMO.TIPAMOSTRA, AMO.DESOBSERVACAO, AMO.QTDAMOSTRA, '+
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN, '+
                              ' COL.NOMCOLECAO, '+
                              ' DES.NOMDESENVOLVEDOR '+
                              ' from AMOSTRA AMO, CADCLIENTES CLI, CADVENDEDORES VEN, COLECAO COL, DESENVOLVEDOR DES '+
                              ' Where AMO.CODCOLECAO = COL.CODCOLECAO '+
                              ' AND AMO.CODDESENVOLVEDOR = DES.CODDESENVOLVEDOR '+
                              ' AND AMO.CODVENDEDOR = VEN.I_COD_VEN '+
                              ' AND AMO.CODCLIENTE = CLI.I_COD_CLI '+
                              ' AND AMO.CODAMOSTRA = '+IntToStr(VpaCodAmostra));


  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTotalClientesAtendidoseProdutosVendidosporVendedor(VpaCodClienteMaster: INteger; VpaCaminho, VpaNomClienteMaster: String; VpaDatInicio, VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes atendidos e produtos vendidos por vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Vendedor\1000PL_Total Clientes Atendidos e Produtos Vendidos por Vendedor.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select VEN.C_NOM_VEN, SUM(MOV.N_VLR_TOT) VALPRODUTO, SUM(MOV.N_QTD_PRO) QTDPRODUTO, COUNT(DISTINCT(CAD.I_COD_CLI))QTDCLIENTE, COUNT(DISTINCT(MOV.I_SEQ_PRO))PRODUTOS '+
                              ' From CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADVENDEDORES VEN, CADCLIENTES CLI '+
                              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                              ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                              ' AND CAD.I_COD_VEN = VEN.I_COD_VEN '+
                              ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                              ' and CAD.C_IND_CAN = ''N''');
  if VpaCodClienteMaster <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_CLI_MAS = '+InttoStr(VpaCodClienteMaster));
    Rave.SetParam('CLIENTEMASTER','Cliente Master : '+VpaNomClienteMaster);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' GROUP BY VEN.C_NOM_VEN '+
                              ' ORDER BY 1');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeVendasPorEstadoeCidade(VpaCodCliente, VpaCodCondicaoPagamento, VpaTipCotacao, VpaCodTransportadora : Integer; VpaCaminho, VpaNomCliente, VpaNomCondicaoPagamento, VpaNomTipoCotacao, VpaCidade, VpaUF, VpaNomTransportadora: String; VpaDatInicio, VpaDatFim: TDatetime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Vendas por Estado e Cidade';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0200PL_Vendas por Estado e Cidade.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_EST_CLI, CLI.C_CID_CLI, '+
                              ' PAG.C_NOM_PAG, '+
                              ' CAD.I_EMP_FIL, CAD.I_LAN_ORC, CAD.I_COD_PAG, CAD.D_DAT_ORC, CAD.I_COD_VEN, '+
                              ' CAD.N_VLR_TOT, CAD.C_NRO_NOT, CAD.I_TIP_ORC '+
                              ' from CADCLIENTES CLI, CADCONDICOESPAGTO PAG, CADORCAMENTOS CAD '+
                              ' WHERE CLI.I_COD_CLI = CAD.I_COD_CLI '+
                              ' AND CAD.I_COD_PAG = PAG.I_COD_PAG '+
                              SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                              ' AND CAD.C_IND_CAN = ''N''');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaUF <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaUF+'''');
    Rave.SetParam('ESTADO',VpaUF);
  end;
  if VpaCodCondicaoPagamento <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_PAG = '+InttoStr(VpaCodCondicaoPagamento));
    Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCondicaoPagamento);
  end;
  if VpaTipCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaTipCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaCodTransportadora <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_TRA = '+InttoStr(VpaCodTransportadora));
  end;

  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' ORDER BY CLI.C_EST_CLI, CLI.C_CID_CLI');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTotalVendasPorEstadoeCidade(VpaCodCliente, VpaCodCondicaoPagamento, VpaTipCotacao: Integer; VpaCaminho, VpaNomCliente,VpaNomCondicaoPagamento, VpaNomTipoCotacao, VpaCidade, VpaUF: String; VpaDatInicio, VpaDatFim: TDatetime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Total Vendas por Estado e Cidade';
  Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0250PL_Total Vendas por Estado e Cidade.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.C_EST_CLI, CLI.C_CID_CLI, SUM(CAD.N_VLR_TOT)VALOR ' +
                              ' from CADCLIENTES CLI, CADORCAMENTOS CAD ' +
                              ' WHERE CLI.I_COD_CLI = CAD.I_COD_CLI ' +
                              SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true)+
                              ' AND CAD.C_IND_CAN = ''N''');
  if VpaCodCliente <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_CLI = '+InttoStr(VpaCodCliente));
    Rave.SetParam('CLIENTE',VpaNomCliente);
  end;
  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaUF <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaUF+'''');
    Rave.SetParam('ESTADO',VpaUF);
  end;
  if VpaCodCondicaoPagamento <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_PAG = '+InttoStr(VpaCodCondicaoPagamento));
    Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCondicaoPagamento);
  end;
  if VpaTipCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaTipCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  AdicionaSQLTabela(Principal,SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,True));
  Rave.SetParam('PERIODO','Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até ' + FormatDateTime('DD/MM/YYYY',VpaDatFim));
  AdicionaSqlTabeLa(Principal,' GROUP BY CLI.C_EST_CLI, CLI.C_CID_CLI ' +
                              ' ORDER BY 1,3 DESC ');
  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeClientesPorVendedor(VpaCodVendedor, VpaCodSituacao: Integer; VpaCaminho, VpaNomVendedor, VpaNOmSituacao, VpaCidade,VpaEstado: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Clientes por Vendedor';
  Rave.projectfile := varia.PathRelatorios+'\Cliente\0200PL_Clientes por Vendedor.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, CLI.C_CID_CLI, CLI.C_FO1_CLI, CLI.C_END_CLI, '+
                              ' CLI.I_NUM_END, CLI.C_BAI_CLI, CLI.C_EST_CLI, '+
                              ' VEN.I_COD_VEN, VEN.C_NOM_VEN '+
                              ' from CADCLIENTES CLI, CADVENDEDORES VEN '+
                              ' Where '+SQLTextoRightJoin('CLI.I_COD_VEN','VEN.I_COD_VEN')+
                              ' AND CLI.C_IND_CLI = ''S''');

  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaEstado <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaEstado+'''');
    Rave.SetParam('ESTADO',VpaEstado);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodSituacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_SIT_CLI = '+InttoStr(VpaCodSituacao));
    Rave.SetParam('SITUACAO',VpaNOmSituacao);
  end;
  AdicionaSqlTabeLa(Principal,'ORDER BY VEN.C_NOM_VEN, CLI.C_EST_CLI, CLI.C_NOM_CLI');
  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTotalVendasCliente(VpaCodVendedor, VpaCodCondicaoPagamento, VpaCodTipoCotacao, VpaCodfilial: Integer; VpaCaminho,  VpaNomVendedor, VpaNomCondicaoPagamento, VpaNomTipoCotacao, VpaNomfilial, VpaCidade, VpaUF: String; VpaDatInicio, VpaDatFim: TDatetime;VpaCurvaABC: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Total Vendas Clientes';
  if VpaCurvaABC then
    Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0301PL_Total Vendas por Cliente(Curva ABC).rav'
  else
    Rave.projectfile := varia.PathRelatorios+'\Cotacao\Venda\0300PL_Total Vendas por Cliente.rav';
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'select CLI.I_COD_CLI, CLI.C_NOM_CLI, SUM(CAD.N_VLR_TOT)VALOR '+
                              ' from CADCLIENTES CLI, CADORCAMENTOS CAD '+
                              ' WHERE CLI.I_COD_CLI = CAD.I_COD_CLI '+
                               SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_ORC',VpaDatInicio,VpaDatFim,true) +
                              ' AND CAD.C_IND_CAN = ''N''');

  if DeletaEspaco(VpaCidade) <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_CID_CLI = '''+ VpaCidade+'''');
    Rave.SetParam('CIDADE',VpaCidade);
  end;
  if VpaUF <> '' then
  begin
    AdicionaSqlTabeLa(Principal,'AND CLI.C_EST_CLI = '''+ VpaUf+'''');
    Rave.SetParam('ESTADO',VpaUF);
  end;
  if VpaCodVendedor <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_VEN = '+InttoStr(VpaCodVendedor));
    Rave.SetParam('VENDEDOR',VpaNomVendedor);
  end;
  if VpaCodTipoCotacao <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_TIP_ORC = '+InttoStr(VpaCodTipoCotacao));
    Rave.SetParam('TIPOCOTACAO',VpaNomTipoCotacao);
  end;
  if VpaCodCondicaoPagamento <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_COD_PAG = '+InttoStr(VpaCodCondicaoPagamento));
    Rave.SetParam('CONDICAOPAGAMENTO',VpaNomCondicaoPagamento);
  end;
  if VpaCodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND CAD.I_EMP_FIL = '+InttoStr(VpaCodfilial));
    Rave.SetParam('FILIAL',VpaNomfilial );
  end;
  Rave.SetParam('PERIODO',FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' até '+FormatDateTime('DD/MM/YYYY',VpaDatFim));
  if VpaCurvaABC then
    AdicionaSqlTabeLa(Principal,'GROUP BY CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                                'ORDER BY 3 DESC')
  else
    AdicionaSqlTabeLa(Principal,'GROUP BY CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                                'ORDER BY 2');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Principal.open;

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeExtratoColetaFracaoOPProduto(VpaSeqProduto, VpaSeqEstagio: Integer; VpaNomProduto, VpaNomEstagio: String; VpaDatInicio,  VpaDatFim: TDateTime);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Extrato Coleta Fracao Produto - '+VpaNomProduto;
  Rave.projectfile := varia.PathRelatorios+'\Ordem Producao\xx_Extrato Coleta Fracao Produto.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'select CEL.CODCELULA, CEL.NOMCELULA, '+
                                  ' COL.CODFILIAL, COL.SEQORDEM, COL.SEQFRACAO, COL.SEQESTAGIO, COL.SEQCOLETA, COL.DESUM, COL.QTDCOLETADO, COL.QTDPRODUCAOHORA, '+
                                  ' COL.QTDPRODUCAOIDEAL, COL.PERPRODUTIVIDADE, COL.DATINICIO, COL.DATINICIO HORAINICIO, COL.DATFIM '+
                                  ' from CELULATRABALHO CEL, COLETAFRACAOOP COL, FRACAOOPESTAGIO FOE '+
                                  ' Where FOE.CODFILIAL = COL.CODFILIAL '+
                                  ' AND FOE.SEQORDEM = COL.SEQORDEM '+
                                  ' AND FOE.SEQFRACAO = COL.SEQFRACAO '+
                                  ' AND FOE.SEQESTAGIO = COL.SEQESTAGIO '+
                                  ' AND COL.CODCELULA = CEL.CODCELULA '+
                                  ' AND FOE.SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                                  ' AND COL.SEQESTAGIO = '+ IntTosTr(VpaSeqEstagio)+
                                  SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',VpaDatInicio,IncDia(VpaDatFim,1),true)+
                                  ' order by CEL.CODCELULA, COL.DATINICIO' );
  AdicionaSqlAbreTabela(Item,'select MAX(COL.PERPRODUTIVIDADE) PERCENTUAL, CEL.NOMCELULA '+
                                  ' from CELULATRABALHO CEL, COLETAFRACAOOP COL, FRACAOOPESTAGIO FOE '+
                                  ' Where FOE.CODFILIAL = COL.CODFILIAL '+
                                  ' AND FOE.SEQORDEM = COL.SEQORDEM '+
                                  ' AND FOE.SEQFRACAO = COL.SEQFRACAO '+
                                  ' AND FOE.SEQESTAGIO = COL.SEQESTAGIO '+
                                  ' AND COL.CODCELULA = CEL.CODCELULA '+
                                  ' AND FOE.SEQPRODUTO = '+IntToStr(VpaSeqProduto)+
                                  ' AND COL.SEQESTAGIO = '+ IntTosTr(VpaSeqEstagio)+
                                  SQLTextoDataEntreAAAAMMDD('COL.DATINICIO',VpaDatInicio,IncDia(VpaDatFim,1),true)+
                                  ' GROUP BY CEL.NOMCELULA '+
                                  ' ORDER BY 1 DESC ' );
  Rave.SetParam('PRODUTO',VpaNomProduto);
  Rave.SetParam('ESTAGIO',VpaNomEstagio);
  Rave.SetParam('PERIODO','Período de  '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYY',VpaDatFim));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeInventarioProduto(VpaCodFilial, VpaSeqInventario: Integer; VpaCaminho, VpaNomfilial: String);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Inventario Produto';
  Rave.projectfile := varia.PathRelatorios+'\Produto\xx_Inventario Produto.rav';
  Rave.clearParams;
  RvSystem1.defaultDest := rdPreview;
  AdicionaSqlAbreTabela(Principal,'select  PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                                  ' COR.NOM_COR, '+
                                  ' ITE.COD_FILIAL, ITE.SEQ_INVENTARIO, ITE.COD_UNIDADE, ITE.QTD_PRODUTO, '+
                                  ' TAM.NOMTAMANHO '+
                                  ' from CADPRODUTOS PRO, COR, TAMANHO TAM, INVENTARIOITEM ITE '+
                                  ' Where ITE.SEQ_PRODUTO = PRO.I_SEQ_PRO '+
                                  ' AND ' +SQLTextoRightJoin('ITE.COD_COR','COR.COD_COR')+
                                  ' AND ' +SQLTextoRightJoin('ITE.COD_TAMANHO','TAM.CODTAMANHO')+
                                  ' AND ITE.COD_FILIAL = ' + IntToStr(VpaCodFilial)+
                                  ' AND ITE.SEQ_INVENTARIO = '+IntToStr(VpaSeqInventario)+
                                  ' ORDER BY PRO.C_NOM_PRO, COR.NOM_COR, TAM.NOMTAMANHO');
  Rave.SetParam('FILIAL',VpaNomfilial);
  Rave.SetParam('INVENTARIO',IntToStr(VpaSeqInventario));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeContasaReceberPorEmissao(VpaCodFilial: Integer; VpaDatInicio, VpaDatFim: TDateTime; VpaCaminho, VpaNomFilial: String;VpaMostrarFrio: Boolean);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Contas a Receber por Emissao';
  Rave.projectfile := varia.PathRelatorios+'\Financeiro\Contas a Receber\0100PLFI_Contas a Receber por Emissao.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT REC.I_EMP_FIL, REC.D_DAT_EMI, REC.I_NRO_NOT, REC.N_VLR_TOT, REC.I_QTD_PAR, '+
                              ' CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                              ' FROM CADCONTASARECEBER REC, CADCLIENTES CLI '+
                              ' Where REC.I_COD_CLI = CLI.I_COD_CLI'+
                               SQLTextoDataEntreAAAAMMDD('REC.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  if VpaCodfilial <> 0 then
  begin
    AdicionaSqlTabeLa(Principal,'AND REC.I_EMP_FIL = '+InttoStr(VpaCodfilial));
    Rave.SetParam('FILIAL',VpaNomfilial );
  end;
  if not VpaMostrarFrio then
    AdicionaSqlTabeLa(Principal,'and C_IND_CAD = ''N''');
  AdicionaSqlTabeLa(Principal,'order BY REC.D_DAT_EMI, REC.I_NRO_NOT');

  Rave.SetParam('CAMINHO',VpaCaminho);

  Rave.SetParam('PERIODO','Período de  '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+' até '+FormatDateTime('DD/MM/YYY',VpaDatFim));
  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeTotalProspectPorRamoAtividade(VpaCaminho : string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Total Prospect por Ramo Atividade';
  Rave.projectfile := varia.PathRelatorios+'\Prospect\0300PLCRES_Total Prospects por Ramo Atividade.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'SELECT  RAM.NOM_RAMO_ATIVIDADE, COUNT(I_COD_CLI) QTD '+
                              ' FROM CADCLIENTES CLI, RAMO_ATIVIDADE RAM '+
                              ' Where CLI.C_IND_PRC = ''S'''+
                              ' AND CLI.I_COD_RAM = RAM.COD_RAMO_ATIVIDADE (+) '+
                              ' GROUP BY RAM.NOM_RAMO_ATIVIDADE '+
                              ' ORDER BY 1 ');
  Rave.SetParam('CAMINHO',VpaCaminho);

  Rave.Execute;
end;

{******************************************************************************}
procedure TdtRave.ImprimeProspectPorCeP(VpaSomenteNaoVisitados : boolean; VpaCaminho: string);
begin
  Rave.close;
  RvSystem1.SystemPrinter.Title := 'Eficácia - Prospect por CEP';
  Rave.projectfile := varia.PathRelatorios+'\Prospect\0100CRPL_Prospects por CEP.rav';
  RvSystem1.defaultDest := rdPreview;
  Rave.clearParams;
  LimpaSqlTabela(Principal);
  AdicionaSqlTabeLa(Principal,'Select CLI.I_COD_CLI, CLI.C_NOM_CLI, C_END_CLI, CLI.C_COM_END, CLI.C_BAI_CLI, ' +
                              ' CLI.C_CEP_CLI, CLI.C_CID_CLI, CLI.C_IND_VIS, ' +
                              ' RAM.NOM_RAMO_ATIVIDADE ' +
                              ' FROM CADCLIENTES CLI, RAMO_ATIVIDADE RAM ' +
                              ' Where CLI.I_COD_RAM = RAM.COD_RAMO_ATIVIDADE (+) ');
  if VpaSomenteNaoVisitados then
    AdicionaSqlTabeLa(Principal,'AND CLI.C_IND_VIS = ''N''');
  AdicionaSqlTabeLa(Principal,' ORDER BY CLI.C_CEP_CLI, C_END_CLI');
  Rave.SetParam('CAMINHO',VpaCaminho);
  Rave.Execute;
end;


end.
