unit AImprimeCR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, quickrpt, Db, DBTables, Qrctrls, printers,
  StdCtrls, Buttons, Geradores;

type
  TFImprimeCR = class(TForm)
    Aux: TQuery;
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
    AuxD_DAT_EMI: TDateField;
    AuxC_DUP_DES: TStringField;
    AuxC_IND_CON: TStringField;
    AuxC_NRO_DOC: TStringField;
    AuxC_FUN_PER: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand5BeforePrint(Sender: TQRCustomBand;
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


Initialization
 RegisterClasses([TFImprimeCR]);
end.
