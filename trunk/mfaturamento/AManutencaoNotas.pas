unit AManutencaoNotas;
{          Autor: Rafael Budag
    Data Criação: 19/05/1999;
          Função: Consultar as notas fiscais

Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  formularios, StdCtrls, Componentes1, ExtCtrls, PainelGradiente,
  Localizacao, Buttons, Db, DBTables, ComCtrls,  Grids,
  DBGrids, printers, Mask, numericos, Tabela, DBCtrls, DBKeyViolation,
  Geradores, UnNotaFiscal, UnEDi, FileCtrl, UnDadosProduto, FMTBcd, SqlExpr,
  DBClient;

type
  TFManutencaoNotas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    NOTAS: TSQL;
    DATANOTAS: TDataSource;
    BitBtn3: TBitBtn;
    PageControl1: TPageControl;
    NOTASI_NRO_NOT: TFMTBCDField;
    NOTASC_NOM_CLI: TWideStringField;
    NOTASC_TIP_CAD: TWideStringField;
    NOTASC_FLA_ECF: TWideStringField;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    Data1: TCalendario;
    data2: TCalendario;
    EClientes: TEditLocaliza;
    NOTASc_not_can: TWideStringField;
    NOTASL_OBS_NOT: TWideStringField;
    NOTASN_TOT_PRO: TFMTBCDField;
    NOTASN_TOT_NOT: TFMTBCDField;
    NOTASI_NRO_LOJ: TFMTBCDField;
    NOTASI_NRO_CAI: TFMTBCDField;
    MObs: TDBMemoColor;
    NotaGrid: TGridIndice;
    NOTASC_NOT_IMP: TWideStringField;
    BCancelaNota: TBitBtn;
    BExcuiNota: TBitBtn;
    NOTASI_EMP_FIL: TFMTBCDField;
    NOTASI_SEQ_NOT: TFMTBCDField;
    T: TPainelTempo;
    CupomNota: TRadioGroup;
    NOTASD_DAT_EMI: TSQLTimeStampField;
    NOTASC_NOM_NAT: TWideStringField;
    BNotaDevolucao: TBitBtn;
    NOTASC_NOT_DEV: TWideStringField;
    Label27: TLabel;
    SpeedButton2: TSpeedButton;
    ENatureza: TEditLocaliza;
    Label4: TLabel;
    NOTASC_TIP_NOT: TWideStringField;
    ENota: TEditColor;
    NOTASNatureza: TWideStringField;
    NOTASi_COD_CLI: TFMTBCDField;
    NOTASC_COD_NAT: TWideStringField;
    MovNatureza: TSQLQuery;
    EItemNat: TEditColor;
    NOTASI_ITE_NAT: TFMTBCDField;
    NOTASC_SER_NOT: TWideStringField;
    ESerie: TEditColor;
    Label12: TLabel;
    BEDI: TBitBtn;
    BitBtn4: TBitBtn;
    NOTASC_CHA_NFE: TWideStringField;
    NOTASC_REC_NFE: TWideStringField;
    NOTASC_PRO_NFE: TWideStringField;
    NOTASC_STA_NFE: TWideStringField;
    NOTASC_MOT_NFE: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ENotasRetorno(Retorno1, Retorno2: String);
    procedure Data1Exit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure NOTASAfterScroll(DataSet: TDataSet);
    procedure BExcuiNotaClick(Sender: TObject);
    procedure BCancelaNotaClick(Sender: TObject);
    procedure CupomNotaClick(Sender: TObject);
    procedure BNotaDevolucaoClick(Sender: TObject);
    procedure ENotaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ENaturezaRetorno(Retorno1, Retorno2: String);
    procedure BEDIClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure NotaGridOrdem(Ordem: String);
  private
     VprOrdem : string;
     VprDNota : TRBDNotaFiscal;
     DevolucaoCupomNotaFiscal : Boolean;
     FunEDI : TRBFuncoesEDI;
     procedure ConfiguraPermissaoUsuario;
     procedure PosicionaNota(VpaGuardarPosicao : Boolean = false);
     procedure AdicionaFiltros(VpaSelect : TStrings);
     procedure CarNotasSelecionadas(VpaNotas : TList);
  public
    { Public declarations }
  end;

var
  FManutencaoNotas: TFManutencaoNotas;

implementation

uses APrincipal, Constantes, Fundata, ConstMsg,
     Funstring, FunNumeros, FunSql, funObjeto,
     AItensNatureza, ANovaNotaFiscalNota, ANovaNotaFiscaisFor;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFManutencaoNotas.FormCreate(Sender: TObject);
begin
  Data1.DateTime := PrimeiroDiaMes(date);
  Data2.DateTime := UltimoDiaMes(Date);
  VprOrdem := '';
  PosicionaNota;
  FunEDI := TRBFuncoesEDI.cria;
  ConfiguraPermissaoUsuario;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFManutencaoNotas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(Notas);
  FechaTabela(MovNatureza);
  FunEdi.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Eventos da Consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFManutencaoNotas.ConfiguraPermissaoUsuario;
begin
  AlterarVisibleDet([BNotaDevolucao,BCancelaNota,BExcuiNota,BEDI],false);

  if (puFAManutencaoNota in varia.PermissoesUsuario)then
    AlterarVisibleDet([BNotaDevolucao,BCancelaNota,BExcuiNota,BEDI],true);
end;

{*********************** atualiza a consulta **********************************}
procedure TFManutencaoNotas.PosicionaNota(VpaGuardarPosicao : Boolean = false);
Var
  VpfPosicao : TBookMark;
begin
  VpfPosicao := NOTAS.GetBookmark;
  LimpaSQLTabela(Notas);
  Notas.Sql.Add(' select ' +
    ' NF.I_NRO_NOT, Cli.C_NOM_CLI, Cli.C_TIP_CAD, NF.C_FLA_ECF, NF.c_not_can, NF.L_OBS_NOT, ' +
    ' NF.N_TOT_PRO, NF.N_TOT_NOT, NF.I_NRO_LOJ, NF.I_NRO_CAI, NF.I_EMP_FIL, NF.I_SEQ_NOT, ' +
    ' NF.D_DAT_EMI, NF.C_COD_NAT,Nat.C_Cod_Nat ||''-''|| nat.C_NOM_NAT Natureza, nat.C_NOM_NAT,' +
    ' NF.C_NOT_DEV, NF.C_NOT_IMP, NF.C_TIP_NOT, NF.I_COD_CLI, NF.I_ITE_NAT, NF.C_SER_NOT, ' +
    ' NF.C_CHA_NFE, NF.C_REC_NFE, NF.C_PRO_NFE, NF.C_STA_NFE, NF.C_MOT_NFE '+
    ' from ' +
    ' CadNotaFiscais NF, CadClientes  CLI, CadNatureza  Nat ');

  AdicionaFiltros(Notas.Sql);

  Notas.Sql.Add(VprOrdem);
  NOTAS.open;
  NotaGrid.ALinhaSQLOrderBy := NOTAS.Sql.Count - 1;

  try
    if (VpaGuardarPosicao) and (not Notas.eof) then
      NOTAS.GotoBookmark(VpfPosicao);
    NOTAS.FreeBookmark(VpfPosicao);
  except
  end;
end;

{**************** adiciona os filtros da select *******************************}
procedure TFManutencaoNotas.AdicionaFiltros(VpaSelect : TStrings);
begin
  VpaSelect.Add(' where  NF.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
                ' and nf.i_nro_not is not null '  +
                ' and '+SQLTextoRightJoin('NF.I_COD_CLI','CLI.I_COD_CLI')+
                ' and '+SQLTextoRightJoin('NF.C_COD_NAT','NAT.C_COD_NAT'));

  if ENota.Text <> '' Then
    VpaSelect.Add(' and NF.I_Nro_not = '+ ENota.Text)
  else
  begin
    VpaSelect.Add(SQLTextoDataEntreAAAAMMDD( ' NF.D_DAT_EMI ', Data1.Date, Data2.Date, true));

    if (EClientes.Text <> '') then
      VpaSelect.Add(' and NF.I_COD_CLI = ' + EClientes.Text);

    if ENatureza.Text <> '' then
      VpaSelect.Add(' and NF.C_COD_NAT = ''' + ENatureza.Text + '''' +
                    ' and i_ite_nat = ' + EItemNat.text  );

    case CupomNota.ItemIndex of
      0 : VpaSelect.Add(' and NF.C_FLA_ECF = ''S''');
      1 : VpaSelect.Add(' and '+SqlTextoIsNull('NF.C_FLA_ECF','''N''')+' = ''N''');
    end;

   if ESerie.Text <> '' then
     VpaSelect.Add(' and NF.C_SER_NOT = ''' + ESerie.Text + '''' );

  end;
end;

{******************************************************************************}
procedure TFManutencaoNotas.CarNotasSelecionadas(VpaNotas : TList);
var
  VpfLaco : Integer;
  VpfDNota : TRBDNotaFiscal;
begin
  FreeTObjectsList(VpaNotas);
  if (NotaGrid.SelectedRows.Count = 0) and (NOTASI_SEQ_NOT.AsInteger <> 0) then
  begin
    VpfDNota := TRBDNotaFiscal.cria;
    FunNotaFiscal.CarDNotaFiscal(VpfDNota,NOTASI_EMP_FIL.AsInteger,NOTASI_SEQ_NOT.AsInteger);
    VpaNotas.add(VpfDNota);
  end
  else
  begin
    for VpfLaco := 0 to  NotaGrid.SelectedRows.Count - 1 do
    begin
      NOTAS.GotoBookmark(TBookmark(NotaGrid.SelectedRows.Items[VpfLaco]));
      VpfDNota := TRBDNotaFiscal.cria;
      FunNotaFiscal.CarDNotaFiscal(VpfDNota,NOTASI_EMP_FIL.AsInteger,NOTASI_SEQ_NOT.AsInteger);
      VpaNotas.add(VpfDNota);
    end;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Evetos dos filtros superiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************** atualica a consulta da grade *******************************}
procedure TFManutencaoNotas.ENotasRetorno(Retorno1, Retorno2: String);
begin
  PosicionaNota;
end;

{****************** retorno da natureza ************************************* }
procedure TFManutencaoNotas.ENaturezaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
      // verifica natureza
    FunNotaFiscal.LocalizaMovNatureza(MovNatureza, retorno1, false );

    if MovNatureza.RecordCount > 1 then
    begin
      FItensNatureza := TFItensNatureza.CriarSDI(application, '', true);
      FItensNatureza.PosicionaNatureza(MovNatureza);
    end;

    EItemNat.Text := MovNatureza.fieldByName('i_seq_mov').AsString;
    if EItemNat.Text = '' then
      EItemNat.Text := '0';

  end
  else
    EItemNat.Text := '';

  PosicionaNota;
end;

{**************** chama a rotina para atualizar a consulta ********************}
procedure TFManutencaoNotas.Data1Exit(Sender: TObject);
begin
  PosicionaNota;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        eventos dos botões inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************** fecha o formulario ***********************************}
procedure TFManutencaoNotas.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

{************************ exclui a nota fiscal *******************************}
procedure TFManutencaoNotas.BExcuiNotaClick(Sender: TObject);
var
  VpfDNotaFiscal : TRBDNotaFiscal;
begin
  T.Execute('Excluindo nota fiscal...');
  VpfDNotaFiscal := TRBDNotaFiscal.cria;
  VpfDNotaFiscal.CodFilial := NOTASI_EMP_FIL.AsInteger;
  VpfDNotaFiscal.SeqNota := NOTASI_SEQ_NOT.AsInteger;
  FunNotaFiscal.CarDNotaFiscal(VpfDNotaFiscal);
  FunNotaFiscal.ExcluiNotaFiscal(VpfDNotaFiscal);
  PosicionaNota(True);
  T.Fecha;
end;

{******************* cancela a nota fiscal ************************************}
procedure TFManutencaoNotas.BCancelaNotaClick(Sender: TObject);
var
  VpfResultado : String;
begin
  T.Execute('Cancelando nota fiscal...');
  VpfResultado := FunNotaFiscal.CancelaNotaFiscal(NOTASI_EMP_FIL.AsInteger, NOTASI_SEQ_NOT.AsInteger,true);
  PosicionaNota(true);
  T.Fecha;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFManutencaoNotas.CupomNotaClick(Sender: TObject);
begin
  PosicionaNota;
end;

{******************** devolucao do cupom fiscal *******************************}
procedure TFManutencaoNotas.BNotaDevolucaoClick(Sender: TObject);
var
  VpfNotas : TList;
begin
  VpfNotas := TList.create;
  CarNotasSelecionadas(VpfNotas);
  FNovaNotaFiscaisFor := TFNovaNotaFiscaisFor.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscaisFor'));
  FNovaNotaFiscaisFor.GeraNotaDevolucao(VpfNotas);
  FNovaNotaFiscaisFor.free;
  FreeTObjectsList(VpfNotas);
  VpfNotas.free;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************* apos o scrool da tabela ****************************}
procedure TFManutencaoNotas.NOTASAfterScroll(DataSet: TDataSet);
begin
  // devolucao total = S, naum devolvida = N
  // canceladas = S
  AlterarEnabledDet([BExcuiNota, BCancelaNota, BNotaDevolucao ], false);
//  if CupomNota.ItemIndex = 1 then
  begin
    BExcuiNota.Enabled := (NOTASC_NOT_IMP.AsString = 'N') AND (NOTASC_NOT_DEV.AsString = 'N');
    BCancelaNota.Enabled := (NOTASC_NOT_DEV.AsString = 'N') AND (NOTASC_NOT_CAN.AsString = 'N');
    BNotaDevolucao.Enabled := (NOTASC_NOT_DEV.AsString = 'N') AND (NOTASC_NOT_CAN.AsString = 'N') AND (NOTASC_TIP_NOT.AsString = 'S');
  end;
//  else
  begin
    BNotaDevolucao.Enabled := (NOTASC_NOT_DEV.AsString = 'N') AND (NOTASC_NOT_CAN.AsString = 'N');
  end;
end;

{********************* atualiza a consulta ************************************}
procedure TFManutencaoNotas.ENotaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    13 : PosicionaNota;
  end;
end;


procedure TFManutencaoNotas.BEDIClick(Sender: TObject);
begin
  if NOTASI_NRO_NOT.AsInteger <> 0 then
  begin
    FunEDI.GeraArquivoEDI(NOTASI_EMP_FIL.AsString,NOTASI_SEQ_NOT.AsString);
  end;
end;

{******************************************************************************}
procedure TFManutencaoNotas.BitBtn4Click(Sender: TObject);
begin
  VprDNota := TRBDNotaFiscal.cria;
  VprDNota.CodFilial := NOTASI_EMP_FIL.AsInteger;
  VprDNota.SeqNota := NOTASI_SEQ_NOT.AsInteger;
  FunNotaFiscal.CarDNotaFiscal(VprDNota);
  FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(self,'',true);
  FNovaNotaFiscalNota.ConsultaNota(VprDNota);
  FNovaNotaFiscalNota.free;
end;

{******************************************************************************}
procedure TFManutencaoNotas.NotaGridOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

Initialization
 RegisterClasses([TFManutencaoNotas]);
end.
