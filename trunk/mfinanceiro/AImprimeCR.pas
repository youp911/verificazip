unit AImprimeCR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, quickrpt, Db, DBTables, Qrctrls, printers,
  StdCtrls, Buttons, Geradores;

type
  TFImprimeCR = class(TForm)
    Aux: TQuery;
    QuickRep1: TQuickRepNovo;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    data1: TQRLabel;
    data2: TQRLabel;
    QRLabel12: TQRLabel;
    QRShape2: TQRShape;
    Sit: TQRBand;
    QRShape3: TQRShape;
    QRSysData2: TQRSysData;
    EmpFil: TQRLabel;
    AuxI_LAN_REC: TIntegerField;
    AuxL_OBS_REC: TMemoField;
    AuxI_COD_CLI: TIntegerField;
    AuxI_NRO_NOT: TIntegerField;
    AuxI_NRO_PAR: TIntegerField;
    AuxD_DAT_VEN: TDateField;
    AuxN_VLR_PAR: TFloatField;
    AuxD_DAT_PAG: TDateField;
    AuxN_VLR_PAG: TFloatField;
    AuxC_NOM_CLI: TStringField;
    QRBand1: TQRBand;
    TextTotalaPagar1: TQRLabel;
    TextTotalDuplicatas1: TQRLabel;
    TextTotalDuplicatas: TQRLabel;
    TextTotalaPagar: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QEmAberto: TQuickRepNovo;
    QRBand2: TQRBand;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText14: TQRDBText;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    LDataFim: TQRLabel;
    QRShape1: TQRShape;
    LFilial: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRBand4: TQRBand;
    QRShape4: TQRShape;
    QRSysData4: TQRSysData;
    QRBand5: TQRBand;
    LTotal: TQRLabel;
    ClientesEmAberto: TQuery;
    ClientesEmAbertoI_COD_CLI: TIntegerField;
    ClientesEmAbertoC_NOM_CLI: TStringField;
    ClientesEmAbertoC_FO1_CLI: TStringField;
    ClientesEmAbertoC_CPF_CLI: TStringField;
    ClientesEmAbertoI_NRO_NOT: TIntegerField;
    ClientesEmAbertoI_NRO_PAR: TIntegerField;
    ClientesEmAbertoD_DAT_VEN: TDateField;
    ClientesEmAbertoN_VLR_PAR: TFloatField;
    ClientesEmAbertoI_LAN_REC: TIntegerField;
    QRLabel8: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    ETotalCliente: TQRLabel;
    ETotalNota: TQRLabel;
    ECPF: TQRLabel;
    ETelefone: TQRLabel;
    ENomCliente: TQRLabel;
    ECodCliente: TQRLabel;
    QRSysData3: TQRSysData;
    LCliente: TQRLabel;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRLabel3: TQRLabel;
    QRBand6: TQRBand;
    QRDBText4: TQRDBText;
    AuxD_DAT_EMI: TDateField;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    LPrazo: TQRLabel;
    Par: TQRLabel;
    Cli: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel7: TQRLabel;
    LMediaPrazos: TQRLabel;
    LTotalMes: TQRLabel;
    LTotalAReceber: TQRLabel;
    LTotalRecebido: TQRLabel;
    AuxC_DUP_DES: TStringField;
    QRLabel14: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel21: TQRLabel;
    LTotDupDescontadas: TQRLabel;
    LNroNota: TQRLabel;
    AuxC_IND_CON: TStringField;
    QRDBText3: TQRDBText;
    LTotAReceberDia: TQRLabel;
    LTotRecebidoDia: TQRLabel;
    QRLabel6: TQRLabel;
    LNroDuplicata: TQRLabel;
    AuxC_NRO_DOC: TStringField;
    L001Cliente: TQRLabel;
    QRLabel24: TQRLabel;
    QRDBText2: TQRDBText;
    AuxC_FUN_PER: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand6BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    VprClienteAnterior,
    VprNotaAtual,
    VprQtdPrazos : Integer;
    VprTotNota,
    VprTotCliente,
    VprTotEmAberto,
    VprTotDescontado,
    VprTotaReceberDia,
    VprTotRecebidoDia,
    VprTotAReceberMes,
    VprTotRecebidoMes,
    VprTotPrazos : Double;
    VprMesAtual : Integer;
    procedure SelectCliEmAberto(VpaTabela : TQuery; VpaDatFim : TDateTime;VpaCodFilial : String;VpaCodCliente : String;VpaIndParcial : Boolean);
    procedure ConfiguraTela(VpaDatFim : TDateTime;VpaCodFilial : String;VpaCodCliente : String);
    procedure LimpaCamposCliente;
  public
   procedure carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                              NomeEmpresa, NomeFilial, Plano, Cliente, Parcelas: String;TotalaPagar,TotalDuplicatas : Double);
   procedure ImprimeClienteEmAberto(VpaDatFim : TDateTime;VpaCodFilial : String;VpaCodCliente : String;VpaIndParcial, VpaVisualizar : Boolean);
  end;

var
  FImprimeCR: TFImprimeCR;

implementation

Uses FunSql, FunData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeCR.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprTotDescontado := 0;
  VprClienteAnterior := 0;
  VprQtdPrazos := 0;
  VprTotPrazos := 0;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeCR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações da impressao do conta a receber
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************** imprime o contas a receber ******************************}
procedure TFImprimeCR.carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                                       NomeEmpresa, NomeFilial, Plano, Cliente, Parcelas: String;TotalaPagar,TotalDuplicatas : Double);
begin
  VprTotaReceberDia := 0;
  VprTotRecebidoDia := 0;
    FImprimeCR.Aux.sql.clear;
    FImprimeCR.Aux.sql.Text := ComandoSQL;

    FImprimeCR.Aux.open;
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

    Cli.Caption := 'Clientes : ';
    if Cliente <> '' then
       Cli.Caption := Cli.Caption + Cliente
    else
       Cli.Caption := Cli.Caption + 'Todas';

    TextTotalaPagar.caption :=  FormatFloat('R$ ###,###,###,##0.00',totalaPagar);
    TextTotalDuplicatas.Caption := FormatFloat('R$ ###,###,###,##0.00',TotalDuplicatas);
    VprMesAtual := Mes(AuxD_DAT_VEN.AsDateTime);
    FImprimeCR.QuickRep1.Preview;
  FImprimeCR.Close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações do relatorio do saldos em aberto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************** carrega a select dos clientes em aberto **********************}
procedure TFImprimeCR.SelectCliEmAberto(VpaTabela : TQuery; VpaDatFim : TDateTime;VpaCodFilial : String;VpaCodCliente : String;VpaIndParcial : Boolean);
begin
  ClientesEmAberto.close;
  ClientesEmAberto.sql.clear;
  ClientesEmAberto.sql.add('Select CLI.I_COD_CLI, CLI.C_NOM_CLI, C_FO1_CLI, C_CPF_CLI, '+
                           ' CR.I_NRO_NOT, MCR.I_NRO_PAR, MCR.D_DAT_VEN, MCR.N_VLR_PAR,CR.I_LAN_REC '+
                           '  from  MovContasaReceber MCR, CadContasaReceber CR, '+
                           '  CadClientes CLI, '+
                           ' Where CR.I_EMP_FIL = MCR.I_EMP_FIL '+
                           ' and CR.I_LAN_REC = MCR.I_LAN_REC '+
                           ' and CR.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND CR.C_IND_CON IS NULL '+
                           ' AND MCR.D_DAT_PAG IS NULL '+
                           ' and MCR.D_DAT_VEN <= '+SQLTextoDataAAAAMMMDD(VpaDatFim));
//                           ' AND CR.D_DAT_EMI < ''2007/10/26''');
  if VpaCodFilial <> '' then
    ClientesEmAberto.SQL.Add('and MCR.I_EMP_FIL = '+ VpaCodFilial);
  if VpaCodCliente <> '' then
    ClientesEmAberto.SQL.Add('and CLI.I_COD_CLI = '+ VpaCodCliente);

  if VpaIndParcial then
    ClientesEmAberto.SQL.Add('and CR.C_IND_CAD = ''N''');

  ClientesEmAberto.sql.add('ORDER BY CLI.C_NOM_CLI, MCR.D_DAT_VEN, CR.I_NRO_NOT, MCR.I_NRO_PAR ');
  ClientesEmAberto.OPEN;
end;

{************************* configura a tela ***********************************}
procedure TFImprimeCR.ConfiguraTela(VpaDatFim : TDateTime;VpaCodFilial : String;VpaCodCliente : String);
begin
  LDataFim.Caption := DataToStrFormato(DDMMAAAA,VpaDatFim,'/');
  if VpaCodFilial = '' then
    LFilial.Caption := 'Filial : Todas'
  else
    LFilial.Caption := 'Filial : '+ VpaCodFilial;
  if VpaCodCliente = '' then
    LCliente.Caption := 'Cliente : Todos'
  else
    LCliente.Caption := 'Cliente : '+ VpaCodCliente;
end;

{*********************** limpa os campos do cliente ***************************}
procedure TFImprimeCR.LimpaCamposCliente;
begin
  ECodCliente.Caption :='';
  ENomCliente.Caption :='';
  ETelefone.Caption :='';
  ECPF.Caption :='';
  ETotalCliente.Caption :='';
  ETotalNota.Caption :='';
end;

{***************** imprime os clientes em aberto ******************************}
procedure TFImprimeCR.ImprimeClienteEmAberto(VpaDatFim : TDateTime;VpaCodFilial : String;VpaCodCliente : String;VpaIndParcial,VpaVisualizar : Boolean);
begin
  VprClienteAnterior := 0;
  VprTotEmAberto := 0;
  SelectCliEmAberto(ClientesEmAberto,VpaDatFim,VpaCodFilial,VpaCodCliente,VpaIndParcial);
  ConfiguraTela(VpaDatFim,VpaCodFilial,VpaCodCliente);
  if VpaVisualizar then
    QEmAberto.Preview
  else
    QEmAberto.Print;

  ClientesEmAberto.close;
end;

{********************* antes de imprimir os clientes **************************}
procedure TFImprimeCR.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if VprClienteAnterior <> ClientesEmAbertoI_COD_CLI.AsInteger then
  begin
    VprClienteAnterior := ClientesEmAbertoI_COD_CLI.AsInteger;
    ECodCliente.Caption := ClientesEmAbertoI_COD_CLI.AsString;
    ENomCliente.Caption := ClientesEmAbertoC_NOM_CLI.AsString;
    ECPF.Caption := ClientesEmAbertoC_CPF_CLI.AsString;
    ETelefone.Caption := ClientesEmAbertoC_FO1_CLI.AsString;
    ETotalCliente.Caption :='';
    ETotalNota.Caption :='';
    VprTotNota :=0;
    VprTotCliente := 0;
  end
  else
    LimpaCamposCliente;
  VprTotNota := VprTotNota + ClientesEmAbertoN_VLR_PAR.AsFloat;
  VprTotCliente := VprTotCliente + ClientesEmAbertoN_VLR_PAR.AsFloat;
  VprTotEmAberto := VprTotEmAberto + ClientesEmAbertoN_VLR_PAR.AsFloat;
  VprNotaAtual := ClientesEmAbertoI_NRO_NOT.AsInteger;

  if not ClientesEmAberto.Eof then
    ClientesEmAberto.Next;

  if (ClientesEmAbertoI_COD_CLI.AsInteger <> VprClienteAnterior) or
     (ClientesEmAberto.Eof) then
  begin
    ETotalCliente.Caption := FormatFloat('#,###,###,##0.00',VprTotCliente);
    ETotalNota.Caption := FormatFloat('#,###,###,##0.00',VprTotNota);
    VprTotCliente := 0;
    VprTotNota := 0;
  end
  else
    if (ClientesEmAbertoI_NRO_NOT.AsInteger <> VprNotaAtual) then
    begin
      ETotalNota.Caption := FormatFloat('#,###,###,##0.00',VprTotNota);
      VprTotNota := 0;
    end;

  if not ClientesEmAberto.Eof then
    ClientesEmAberto.Prior;
end;

procedure TFImprimeCR.QRBand5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  LTotal.Caption := 'Total em Aberto : '+FormatFloat('#,###,###,###,###,##0.00',VprTotEmAberto);
  VprTotEmAberto := 0;
  VprClienteAnterior := 0;
end;

{******************************************************************************}
procedure TFImprimeCR.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  L001Cliente.Caption := AuxI_COD_CLI.AsString+'-'+AuxC_NOM_CLI.Asstring;
  if AuxC_IND_CON.AsString = 'S' then
  begin
    LNroNota.Caption := 'CONSOLIDADA';
    LPrazo.Caption := '';
  end
  else
  begin
    LNroNOta.Caption := AuxI_NRO_NOT.AsString +'/'+ AuxI_NRO_PAR.AsString ;
    if AuxI_NRO_NOT.AsString <> AuxC_NRO_DOC.AsString then
      LNroDuplicata.Caption :=  AuxC_NRO_DOC.AsString
    else
      LNroDuplicata.Caption := '';
    LPrazo.Caption := IntToStr(DiasPorPeriodo(AuxD_DAT_VEN.AsDateTime,AuxD_DAT_EMI.AsDateTime));
    VprTotRecebidoMes := VprTotRecebidoMes + aux.FieldByName('N_VLR_PAG').AsFloat;
    if Aux.FieldByName('N_VLR_PAG').AsFloat = 0 then
      VprTotAReceberMes := VprTotAReceberMes + Aux.FieldByName('N_VLR_PAR').AsFloat;
    if Aux.FieldByName('C_DUP_DES').AsString = 'S' Then
      VprTotDescontado := VprTotDescontado + Aux.FieldByName('N_VLR_PAR').AsFloat;
    VprTotPrazos := VprTotPrazos + Strtoint(LPrazo.Caption);
    VprTotaReceberDia := VprTotaReceberDia + Aux.FieldByName('N_VLR_PAR').AsFloat;
    VprTotRecebidoDia := VprTotRecebidoDia + aux.FieldByName('N_VLR_PAG').AsFloat;
    inc(VprQtdPrazos);
    if AuxC_FUN_PER.AsString = 'S' then
      DetailBand1.Color := clred
    else
      DetailBand1.Color := clwhite;
  end;
end;

{******************************************************************************}
procedure TFImprimeCR.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  LMediaPrazos.Caption := FormatFloat('0',VprTotPrazos/VprQtdPrazos)+ ' dias';
  LTotDupDescontadas.Caption := FormatFloat('R$ ###,###,###,##0.00',VprTotDescontado) ;
  VprTotDescontado := 0;
  VprTotPrazos := 0;
  VprQtdPrazos := 0;
  VprTotAReceberMes := 0;
  VprTotRecebidoMes := 0;
end;

procedure TFImprimeCR.QRBand6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Aux.next;
  LTotAReceberDia.Caption := FormatFloat(' ###,###,###,###,##0.00',VprTotaReceberDia);
  LTotRecebidoDia.Caption := FormatFloat(' ###,###,###,###,##0.00',VprTotRecebidoDia);
  VprTotaReceberDia := 0;
  VprTotRecebidoDia := 0;
  if Mes(AuxD_DAT_VEN.AsDateTime) <> VprMesAtual then
  begin
    QRBand6.Height := 36;
    LTotalMes.Caption := 'Total do mês de '+ TextoMes(MontaData(1,VprMesAtual,Ano(date)),false);
    LTotalAReceber.Caption := 'A Receber : ' +FormatFloat('R$ ###,###,###,##0.00',VprTotAReceberMes) ;
    LTotalRecebido.Caption := 'Recebido : ' +FormatFloat('R$ ###,###,###,##0.00',VprTotRecebidoMes) ;
    VprTotAReceberMes := 0;
    VprTotRecebidoMes := 0;
    VprMesAtual := Mes(AuxD_DAT_VEN.AsDateTime);
  end
  else
  begin
    LTotalMes.Caption := '';
    LTotalAReceber.Caption := '';
    LTotalRecebido.Caption := '';
    QRBand6.Height := 17;
  end;
  if not Aux.eof then
    Aux.Prior
  else
  begin
    Aux.Prior;
    Aux.Next;
  end;
end;

Initialization
 RegisterClasses([TFImprimeCR]);
end.
