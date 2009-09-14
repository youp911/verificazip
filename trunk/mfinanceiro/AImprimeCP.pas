unit AImprimeCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, quickrpt, Db, DBTables, Qrctrls, printers,
  StdCtrls, Buttons, Geradores;

type
  TFImprimeCP = class(TForm)
    Aux: TQuery;
    QuickRep1: TQuickRepNovo;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRLabel9: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel11: TQRLabel;
    data1: TQRLabel;
    data2: TQRLabel;
    QRLabel12: TQRLabel;
    QRShape2: TQRShape;
    Sit: TQRBand;
    QRShape3: TQRShape;
    QRSysData2: TQRSysData;
    EmpFil: TQRLabel;
    Par: TQRLabel;
    His: TQRLabel;
    Forn: TQRLabel;
    QRBand1: TQRBand;
    QRLabel13: TQRLabel;
    TextValorAPagar: TQRLabel;
    QRLabel15: TQRLabel;
    TextValorPago: TQRLabel;
    AuxI_LAN_APG: TIntegerField;
    AuxI_NRO_NOT: TIntegerField;
    AuxI_NRO_PAR: TIntegerField;
    AuxC_NRO_DUP: TStringField;
    AuxD_DAT_VEN: TDateField;
    AuxN_VLR_DUP: TFloatField;
    AuxD_DAT_PAG: TDateField;
    AuxN_VLR_PAG: TFloatField;
    AuxC_NRO_CON: TStringField;
    AuxC_NOM_CLI: TStringField;
    AuxN_PER_DES: TFloatField;
    AuxC_NOM_FAN: TStringField;
    AuxI_SEQ_NOT: TIntegerField;
    AuxC_NRO_DOC: TStringField;
    AuxC_NOM_FRM: TStringField;
    AuxI_EMP_FIL: TIntegerField;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    AuxC_NOM_PLA: TStringField;
    RelContasPorPlano: TQuickRepNovo;
    ContasPorPlano: TQuery;
    PageHeaderBand2: TQRBand;
    DetailBand2: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    LFilial: TQRLabel;
    QRShape1: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    ContasPorPlanoPLANO: TStringField;
    SummaryBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRSysData3: TQRSysData;
    QRSysData4: TQRSysData;
    ContasPorPlanoVALDUPLICATA: TFloatField;
    ContasPorPlanoVALPAGO: TFloatField;
    QRDBText11: TQRDBText;
    QRLabel7: TQRLabel;
    LPlanoContas: TQRLabel;
    LPeriodo: TQRLabel;
    LFornecedor: TQRLabel;
    LPeriodoPor: TQRLabel;
    LSituacao: TQRLabel;
    QRShape5: TQRShape;
    QRLabel2: TQRLabel;
    QRGroup2: TQRGroup;
    QRDBText5: TQRDBText;
    QRBand3: TQRBand;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRShape6: TQRShape;
    LTotalMes: TQRLabel;
    QRDBText12: TQRDBText;
    QRLabel3: TQRLabel;
    AuxMes: TStringField;
    QRBand2: TQRBand;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    LTitTotMes: TQRLabel;
    LTotAPagarMes: TQRLabel;
    LTotPagoMes: TQRLabel;
    QRLabel8: TQRLabel;
    LTotEmAberto: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
  private
    { Private declarations }
    VprMes : String;
    VprTotPagoMes,
    VprTotAPagarMes : Double;
    procedure posicionaContaAPagarPlanoContas(VpaTabela : TQuery;VpaCodFilial, VpaCodFonecedor, VpaPlanoContas : String; VpaSituacao, VpaCampoPeriodo : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaNomFilial, VpaNomPlanoContas, VpaNomFornecedor, VpaNomSituacao, VpaNomData : String);
  public
   procedure carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                              NomeEmpresa, NomeFilial, Plano, Conta, Fornecedor, Parcelas,ValorPago,TotalDuplicatas : string);

   procedure ImprimeContasAPagarPlanoContas(VpaCodFilial, VpaCodFonecedor, VpaPlanoContas : String; VpaSituacao, VpaCampoPeriodo : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaNomFilial, VpaNomPlanoContas, VpaNomFornecedor, VpaNomSituacao, VpaNomData : String);
  end;
var
  FImprimeCP: TFImprimeCP;

implementation

Uses FunSql, Constantes, FunData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeCP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeCP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;


procedure TFImprimeCP.carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                                       NomeEmpresa, NomeFilial, Plano, Conta, Fornecedor, Parcelas,ValorPago,TotalDuplicatas : string);
begin
    Aux.sql. clear;
    Aux.SQL.TEXT := ComandoSQL;
    Aux.Sql.Strings[0] := 'Select  Month(MCP.D_DAT_VEN) ||''/''|| Year(MCP.D_DAT_VEN) Mes,'+ copy(Aux.Sql.Strings[0],7,Length(Aux.Sql.Strings[0])-7);
    Aux.Sql.Strings[Aux.sql.Count-1] := 'order by D_DAT_VEN ';
    Aux.opeN;
    Aux.First;
    VprMes := Aux.FieldByName('Mes').AsString;
    VprTotPagoMes := 0;
    VprTotAPagarMes := 0;
    data1.Caption := dateToStr(DataInicio);
    data2.Caption := dateToStr(DataFim);

    EmpFil.Caption := 'Empresa : ';
    if NomeEmpresa <> '' then
       EmpFil.Caption := EmpFil.Caption + NomeEmpresa
    else
       EmpFil.Caption := EmpFil.Caption + 'Todas';

    EmpFil.Caption := EmpFil.Caption + '  -  Filial : ';
    if NomeFilial <> '' then
       EmpFil.Caption := EmpFil.Caption + NomeFilial
    else
       EmpFil.Caption := EmpFil.Caption + 'Todas';

    Par.Caption := 'Parcelas : ' + Parcelas;

{    Situ.Caption := 'Contas   : ';
    if Conta <> '' then
       Situ.Caption := Situ.Caption + Conta
    else
       Situ.Caption := Situ.Caption + 'Todas'; }

    Forn.Caption := 'Fornecedores : ';
    if Fornecedor <> '' then
       Forn.Caption := Forn.Caption + Fornecedor
    else
       Forn.Caption := Forn.Caption + 'Todas';

    His.Caption :=  'Plano de Contas : ';
    if Plano <> '' then
       His.Caption := His.Caption + Plano
    else
       His.Caption := His.Caption + 'Todos';
    TextValorAPagar.Caption := FormatFloat('#,###,###,##0.00',Strtofloat(ValorPago));
    TextValorPago.Caption := FormatFloat('#,###,###,##0.00',Strtofloat(TotalDuplicatas));
    LTotEmAberto.Caption := FormatFloat('#,###,###,##0.00',Strtofloat(TotalDuplicatas)-Strtofloat(ValorPago) );

    FImprimeCP.QuickRep1.Preview;
  FImprimeCP.Close;
end;


{********* posiciona a contas a pagar conforme o plano de contas **************}
procedure TFImprimeCP.posicionaContaAPagarPlanoContas(VpaTabela : TQuery;VpaCodFilial, VpaCodFonecedor, VpaPlanoContas : String; VpaSituacao, VpaCampoPeriodo : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaNomFilial, VpaNomPlanoContas, VpaNomFornecedor, VpaNomSituacao, VpaNomData : String);
begin
  LFornecedor.Caption :='' ;
  LPlanoContas.Caption :='' ;
  LSituacao.Caption := VpaNomSituacao;
  LPeriodo.Caption := VpaNomData;
  VpaTabela.Close;
  VpaTabela.Sql.Clear;
  VpaTabela.Sql.Add('select PLA.C_CLA_PLA ||'' - ''|| PLA.C_NOM_PLA PLANO,'+
                    ' SUM(MOV.N_VLR_DUP * MOE.N_VLR_DIA) VALDUPLICATA,' +
                    'SUM (MOV.N_VLR_PAG * MOE.N_VLR_DIA) VALPAGO '+
                    ' from CADCONTASAPAGAR CAD, CAD_PLANO_CONTA PLA, MOVCONTASAPAGAR MOV, '+
                    '      CADMOEDAS MOE ' +
                    ' WHERE  CAD.I_COD_EMP = PLA.I_COD_EMP ' +
                    ' AND    CAD.C_CLA_PLA  = PLA.C_CLA_PLA '+
                    ' AND    CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND    CAD.I_LAN_APG = MOV.I_LAN_APG '+
                    ' AND   MOV.I_COD_MOE = MOE.I_COD_MOE');
  LPeriodo.Caption := 'Período : '+FormatDateTime('DD/MM/YYYY',VPADATINICIO) + ' - '+FormatDateTime('DD/MM/YYYY',VPADATFIM); 
  case VpaCampoPeriodo of
    // VENCIMENTO;
    0 : VpaTabela.Sql.Add(SQLTextoDataEntreAAAAMMDD( 'MOV.D_DAT_VEN',
                VpaDatInicio, VpaDatFim, true) );
    // EMISSÃO.
    1 : VpaTabela.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',
               VpaDatInicio, VpaDatFim, true)  );
    // PAGAMENTO.
    2 : VpaTabela.Sql.Add(SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_PAG',
               VpaDatInicio, VpaDatFim, true) );
    // cadastro.
    3 : VpaTabela.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_MOV',
                       VpaDatInicio, VpaDatFim, true) );
  end;



  case VpaSituacao of
    0 : VpaTabela.Sql.Add(' AND MOV.D_DAT_PAG is null' );     // A Pagar
    1 : VpaTabela.Sql.Add(' and MOV.D_DAT_VEN < ' + SQLTextoDataAAAAMMMDD(date) +
                                      ' and MOV.D_DAT_PAG is null ' );  // Vencidas
    2 : VpaTabela.Sql.Add(' and not(MOV.D_DAT_PAG is null)' );  //  Pagas
    3 : VpaTabela.Sql.Add(' and MOV.D_DAT_VEN = ''' + DataToStrFormato(AAAAMMDD,Date,'/') + '''' +
                                      ' and MOV.D_DAT_PAG is null' );  // Vence hoje
    4 : VpaTabela.Sql.Add(' and MOV.D_DAT_VEN > ''' + DataToStrFormato(AAAAMMDD,Date,'/') + '''' +
                                      ' and MOV.D_DAT_PAG is null ' );  // A Vencer
  end;

 // filtro empresa / filial
    if VpaCodFilial <> '' then
    begin
      VpaTabela.Sql.Add(' and MOV.I_EMP_FIL = ' +VpaCodFilial );
      LFilial.Caption := 'Filial : ' + VpaCodFilial + ' - '+ VpaNomFilial;
    end
    else
    begin
      VpaTabela.Sql.Add(' and PLA.I_COD_EMP = ' + IntTostr(varia.CodigoEmpresa) );
      LFilial.Caption := 'Empresa : '+ IntTostr(varia.CodigoEmpresa)+' - ' + Varia.NomeEmpresa;
    end;

  // FILTRO DO PLANO DE CONTAS
  if VpaPlanoContas <> '' then
  begin
    VpaTabela.Sql.Add(' and CAD.C_CLA_PLA like ''' + Trim(VpaPlanoContas) + '%''' );
    LPlanoContas.Caption := 'Plano Contas : ' + VpaPlanoContas + ' - '+ VpaNomPlanoContas;
  end;

  // filtro fornecedor
  if VpaCodFonecedor <> '' then
  begin
    VpaTabela.Sql.Add(' and CAD.I_COD_CLI = ' + VpaCodFonecedor );
    LFornecedor.Caption := 'Fornecedor : '+ VpaCodFonecedor + ' - ' + VpaNomFornecedor;
  end;

  VpaTabela.Sql.Add(' GROUP BY PLA.C_CLA_PLA, PLA.C_NOM_PLA ');
  VpaTabela.Open;
end;

{************** imprime o contas a pagar por plano de contas ******************}
procedure TFImprimeCP.ImprimeContasAPagarPlanoContas(VpaCodFilial, VpaCodFonecedor, VpaPlanoContas : String; VpaSituacao, VpaCampoPeriodo : Integer; VpaDatInicio, VpaDatFim : TDateTime;VpaNomFilial, VpaNomPlanoContas, VpaNomFornecedor, VpaNomSituacao, VpaNomData : String);
begin
  posicionaContaAPagarPlanoContas(ContasPorPlano,VpaCodFilial, VpaCodFonecedor, VpaPlanoContas, VpaSituacao, VpaCampoPeriodo, VpaDatInicio, VpaDatFim,VpaNomFilial, VpaNomPlanoContas, VpaNomFornecedor, VpaNomSituacao, VpaNomData);
  RelContasPorPlano.Preview;
  ContasPorPlano.close;
  Close;
end;

{**************** carrega o caption do total do mes ***************************}
procedure TFImprimeCP.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  LTotalMes.Caption := 'Total Mes '+ Aux.FieldByName('MES').AsString;
end;

procedure TFImprimeCP.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    VprTotPagoMes := VprTotPagoMes + aux.FieldByName('N_VLR_PAG').AsFloat;
    VprTotAPagarMes := VprTotAPagarMes + Aux.FieldByName('N_VLR_DUP').AsFloat;
end;

{******************************************************************************}
procedure TFImprimeCP.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Aux.next;
  if (vprmes <> Aux.FieldByName('Mes').AsString) or (Aux.Eof) then
  begin
    LTitTotMes.caption := 'Total Mes '+ Vprmes;
   vprmes := Aux.FieldByName('Mes').AsString;
   QRBand2.Height := 48;
   LTotAPagarMes.caption := formatfloat('###,###,###,0.00',VprTotAPagarMes);
   LTotPagoMes.caption := formatfloat('###,###,###,0.00',VprTotPagoMes);
   VprTotPagoMes := 0;
   VprTotAPagarMes := 0;
  end
  else
  begin
    QRBand2.Height := 20;
    LTitTotMes.caption := '';
    LTotAPagarMes.caption := '';
    LTotPagoMes.caption :='';
  end;
  if not aux.eof then
    aux.prior;
end;

{******************************************************************************}
procedure TFImprimeCP.QRBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Aux.First;
  VprMes := Aux.FieldByName('Mes').AsString;
end;

Initialization
 RegisterClasses([TFImprimeCP]);
end.
