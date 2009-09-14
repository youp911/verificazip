unit AConsultacheques;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, Db, DBTables, StdCtrls, Localizacao, Buttons, ComCtrls,
  Mask, numericos, UnContasAReceber, unDadosCR, Menus, DBClient,sqlexpr, RpBase,
  RpSystem, RpRave, RpDefine, RpCon, RpConDS;

type
  TFConsultaCheques = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TGridIndice;
    Cheque: TSQL;
    ChequeSEQCHEQUE: TFMTBCDField;
    ChequeCODBANCO: TFMTBCDField;
    ChequeCODFORMAPAGAMENTO: TFMTBCDField;
    ChequeNOMEMITENTE: TWideStringField;
    ChequeNUMCHEQUE: TFMTBCDField;
    ChequeDATCADASTRO: TSQLTimeStampField;
    ChequeDATVENCIMENTO: TSQLTimeStampField;
    ChequeDATCOMPENSACAO: TSQLTimeStampField;
    ChequeVALCHEQUE: TFMTBCDField;
    ChequeDATDEVOLUCAO: TSQLTimeStampField;
    ChequeCODUSUARIO: TFMTBCDField;
    ChequeNUMCONTACAIXA: TWideStringField;
    ChequeC_NOM_FRM: TWideStringField;
    ChequeC_NOM_CRR: TWideStringField;
    ChequeC_NOM_USU: TWideStringField;
    DataCheque: TDataSource;
    Label8: TLabel;
    Label10: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label19: TLabel;
    ETipoPeriodo: TComboBoxColor;
    Label14: TLabel;
    ESituacao: TComboBoxColor;
    Label23: TLabel;
    SpeedButton1: TSpeedButton;
    Label27: TLabel;
    EFormaPagamento: TEditLocaliza;
    EEmitente: TEditColor;
    Label1: TLabel;
    Label2: TLabel;
    ECheque: Tnumerico;
    EBanco: Tnumerico;
    Label3: TLabel;
    Label28: TLabel;
    SpeedButton3: TSpeedButton;
    Label38: TLabel;
    EContaCorrente: TEditLocaliza;
    Localiza: TConsultaPadrao;
    BCompensar: TBitBtn;
    BDevolver: TBitBtn;
    BExtornar: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    ChequeC_FLA_TIP: TWideStringField;
    PGravar: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    PopupMenu1: TPopupMenu;
    ConsultaContasaPagar1: TMenuItem;
    ConsultaContasaReceber1: TMenuItem;
    N1: TMenuItem;
    ChequeC_TIP_CON: TWideStringField;
    N2: TMenuItem;
    AlterarVencimento1: TMenuItem;
    ChequeTIPCHEQUE: TWideStringField;
    rvCheque: TRvDataSetConnection;
    Rave: TRvProject;
    RvSystem1: TRvSystem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeOrdem(Ordem: String);
    procedure EDatInicioClick(Sender: TObject);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure EFormaPagamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BImprimirClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BCompensarClick(Sender: TObject);
    procedure BDevolverClick(Sender: TObject);
    procedure BExtornarClick(Sender: TObject);
    procedure ChequeAfterScroll(DataSet: TDataSet);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure ConsultaContasaPagar1Click(Sender: TObject);
    procedure ConsultaContasaReceber1Click(Sender: TObject);
    procedure AlterarVencimento1Click(Sender: TObject);
    procedure GradeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    VprAcao,
    VprConsultaChequeBaixaCP : Boolean;
    VprCodFilial,
    VprLanReceber,
    VprLanPagar,
    VprNumParcela,
    VprNumCheque : Integer;
    VprOrdem : String;
    VprDCheque : TRBDCheque;
    procedure AtualizaConsulta(VpaPosicionar : Boolean);
    procedure AdicionaFiltros(VpaSelect : TStrings);
    function CarCheque(VpaCheques : TList):string;
    function CarChequesSelecionados(VpaCheques : TList):string;
    procedure CompensaCheque(VpaSeqCheque : Integer);
    procedure DevolverCheque(VpaSeqCheque : Integer);
    procedure ExtornaCheque(VpaSeqCheque : Integer);
    procedure CarDCheque;
  public
    { Public declarations }
    procedure ConsultaCheques;
    procedure ConsultaChequesContasReceber(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
    procedure ConsultaChequesContasPagar(VpaCodFilial, VpaLanPagar, VpaNumParcela : Integer);
    function  ConsultaChequeBaixaCP(VpaNumCheque : Integer;VpaDCheque : TRBDcheque):Boolean;
  end;

var
  FConsultaCheques: TFConsultaCheques;

implementation

uses APrincipal, FunSql, funData, UnCrystal, Constantes, ConstMsg,
  AContasAPagar, AContasAReceber, ACompensaCheque, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaCheques.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  VprConsultaChequeBaixaCP := false;
  EDatInicio.DateTime := PrimeiroDiaMes(Date);
  EDatFim.DateTime := UltimoDiaMes(date);
  ESituacao.ItemIndex := 4;
  ETipoPeriodo.ItemIndex := 0;
  VprOrdem := 'ORDER BY CHE.DATVENCIMENTO';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaCheques.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Cheque.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFConsultaCheques.ConsultaCheques;
begin
  AtualizaConsulta(false);
  ShowModal;
end;

{******************************************************************************}
procedure TFConsultaCheques.ConsultaChequesContasReceber(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer);
begin
  PanelColor1.Enabled := false;
  VprCodFilial := VpaCodFilial;
  VprLanReceber := VpaLanReceber;
  VprNumParcela := VpaNumParcela;
  AtualizaConsulta(false);
  showmodal;
end;

{******************************************************************************}
procedure TFConsultaCheques.ConsultaChequesContasPagar(VpaCodFilial, VpaLanPagar, VpaNumParcela : Integer);
begin
  PanelColor1.Enabled := false;
  VprCodFilial := VpaCodFilial;
  VprLanPagar := VpaLanPagar;
  VprNumParcela := VpaNumParcela;
  AtualizaConsulta(false);
  showmodal;
end;

{******************************************************************************}
function  TFConsultaCheques.ConsultaChequeBaixaCP(VpaNumCheque : Integer;VpaDCheque : TRBDcheque):Boolean;
begin
  VprDCheque := VpaDCheque;
  VprConsultaChequeBaixaCP := true;
  VprNumCheque := VpaNumCheque;
  AtualizaConsulta(false);
  PGravar.Visible := true;
  PanelColor2.Visible := false;
  ActiveControl := Grade;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFConsultaCheques.AtualizaConsulta(VpaPosicionar : Boolean);
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := Cheque.GetBookmark;
  Cheque.close;
  Cheque.sql.clear;
  Cheque.sql.add('select CHE. SEQCHEQUE, CHE.CODBANCO, CHE.CODFORMAPAGAMENTO,  '+
                 ' CHE.NOMEMITENTE, CHE.NUMCHEQUE, CHE.DATCADASTRO, CHE.TIPCHEQUE, ' +
                 ' CHE.DATVENCIMENTO, CHE.DATCOMPENSACAO, CHE.VALCHEQUE, CHE.DATDEVOLUCAO, CHE.CODUSUARIO, CHE.NUMCONTACAIXA, ' +
                 ' FRM.C_NOM_FRM, FRM.C_FLA_TIP, '+
                 ' CON.C_NOM_CRR, CON.C_TIP_CON, '+
                 ' USU.C_NOM_USU '+
                 ' from CHEQUE CHE, CADFORMASPAGAMENTO FRM, CADCONTAS CON, CADUSUARIOS USU ' +
                 ' Where CHE.CODFORMAPAGAMENTO = FRM.I_COD_FRM  '+
                 ' AND CHE.NUMCONTACAIXA = CON.C_NRO_CON '+
                 ' AND CHE.CODUSUARIO = USU.I_COD_USU');
  AdicionaFiltros(Cheque.sql);
  Cheque.SQl.add(VprOrdem);
  Grade.ALinhaSQLOrderBy := Cheque.sql.count - 1;
  Cheque.open;
  if VpaPosicionar then
    Cheque.GotoBookmark(VpfPosicao);
  Cheque.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFConsultaCheques.AdicionaFiltros(VpaSelect : TStrings);
begin
  if VprLanReceber <> 0 then
  begin
    VpaSelect.Add('and exists (Select SEQCHEQUE FROM CHEQUECR CHR '+
                  ' Where CHR.CODFILIALRECEBER = '+IntToStr(VprCodFilial)+
                  ' AND CHR.LANRECEBER = '+IntToStr(VprLanReceber)+
                  ' AND CHR.NUMPARCELA = '+IntToStr(VprNumParcela)+
                  ' AND CHR.SEQCHEQUE = CHE.SEQCHEQUE )');
  end
  else
    if VprLanPagar <> 0 then
    begin
    VpaSelect.Add('and exists (Select SEQCHEQUE FROM CHEQUECP CHP '+
                  ' Where CHP.CODFILIALPAGAR = '+IntToStr(VprCodFilial)+
                  ' AND CHP.LANPAGAR = '+IntToStr(VprLanPagar)+
                  ' AND CHP.NUMPARCELA = '+IntToStr(VprNumParcela)+
                  ' AND CHP.SEQCHEQUE = CHE.SEQCHEQUE )');
    end
    else
      IF VprNumCheque <> 0 then
        VpaSelect.add('and CHE.NUMCHEQUE = '+IntToStr(VprNumCheque)+
                      ' and CHE.DATCOMPENSACAO IS NULL')
      else
        IF ECheque.AsInteger <> 0 then
          VpaSelect.add('and CHE.NUMCHEQUE = '+ECheque.Text)
        else
        begin
          if VprConsultaChequeBaixaCP then
            VpaSelect.Add(' and CHE.DATCOMPENSACAO IS NULL');
          VpaSelect.add(' AND FRM.C_FLA_TIP IN (''C'',''R'',''P'')');

          case ETipoPeriodo.ItemIndex of
            0 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('CHE.DATVENCIMENTO',EDatInicio.DateTime,EDatFim.DateTime,true));
            1 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('CHE.DATCADASTRO',EDatInicio.DateTime,EDatFim.DateTime,true));
            2 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('CHE.DATCOMPENSACAO',EDatInicio.DateTime,EDatFim.DateTime,true));
          end;

          Case ESituacao.ItemIndex of
            0 : VpaSelect.Add(' and CHE.DATCOMPENSACAO IS NULL');
            1 : VpaSelect.add(' and CHE.DATVENCIMENTO < '+SQLTextoDataAAAAMMMDD(DATE)+ '  and DATCOMPENSACAO IS NULL');
            2 : VpaSelect.add(' and CHE.DATVENCIMENTO = '+SQLTextoDataAAAAMMMDD(DATE)+ '  and DATCOMPENSACAO IS NULL');
            3 : VpaSelect.add(' and CHE.DATVENCIMENTO >= '+SQLTextoDataAAAAMMMDD(DATE)+ '  and DATCOMPENSACAO IS NULL');
          end;
          if EContaCorrente.Text <> '' then
            VpaSelect.Add(' and CHE.NUMCONTACAIXA = '''+EContaCorrente.Text+'''');
          if EFormaPagamento.AInteiro <> 0 then
            VpaSelect.Add(' and CHE.CODFORMAPAGAMENTO = '+EFormaPagamento.Text);
          if EEmitente.Text <> '' then
            VpaSelect.add(' and CHE.NOMEMITENTE LIKE '''+EEmitente.Text+'%''');
          if EBanco.AsInteger <> 0 then
            VpaSelect.add('and CHE.CODBANCO = '+EBanco.Text);
        end;
end;

{******************************************************************************}
function TFConsultaCheques.CarCheque(VpaCheques : TList):string;
var
  VpfDCheque : TRBDCheque;
begin
  result := '';
  if not (ChequeDATDEVOLUCAO.isnull) then
    result := 'CHEQUE JÁ FOI DEVOLVIDO NO SISTEMA!!!'#13'O cheque "'+ChequeNUMCHEQUE.AsString+'" do emitente "'+ChequeNOMEMITENTE.AsString+
              '" já foi devolvido no sistema.';

  IF (ChequeC_FLA_TIP.AsString <> 'C') and (ChequeC_FLA_TIP.AsString <> 'R')then
    result :='TIPO DA FORMA DE PAGAMENTO INVÁLIDO!!!!'#13'Essa operação só é permitido com formas de pagamento do tipo CHEQUE  e CHEQUE DE TERCEIROS';

  if result = '' then
  begin
    VpfDCheque := TRBDCheque.cria;
    FunContasAReceber.CarDCheque(VpfDCheque,ChequeSEQCHEQUE.AsInteger);
    VpaCheques.add(VpfDCheque);
  end;
end;

{******************************************************************************}
function TFConsultaCheques.CarChequesSelecionados(VpaCheques : TList):string;
Var
  VpfLaco : Integer;
begin
  FreeTObjectsList(VpaCheques);
  if Grade.SelectedRows.Count = 0 then
    result := CarCheque(VpaCheques)
  else
  begin
    for VpfLaco:= 0 to Grade.SelectedRows.Count-1 do
    begin
      Cheque.GotoBookmark(TBookmark(Grade.SelectedRows.Items[VpfLaco]));
      result := CarCheque(VpaCheques);
      if result <> '' then
        break;
    end;
  end;
  if result <> '' then
    FreeTObjectsList(VpaCheques);
end;

{******************************************************************************}
procedure TFConsultaCheques.CompensaCheque(VpaSeqCheque : Integer);
var
  VpfDCheque : TRBDCheque;
begin
  if VpaSeqCheque <> 0 then
  begin
    IF (ChequeC_FLA_TIP.AsString <> 'C') and (ChequeC_FLA_TIP.AsString <> 'R') and (ChequeC_FLA_TIP.AsString <> 'P')then
      aviso('TIPO DA FORMA DE PAGAMENTO INVÁLIDO!!!!'#13'Essa operação só é permitido com formas de pagamento do tipo CHEQUE  e CHEQUE DE TERCEIROS')
    else
    begin
      VpfDCheque := TRBDCheque.cria;
      FunContasAReceber.CarDCheque(VpfDCheque,ChequeSEQCHEQUE.AsInteger);
      FCompensaCheque := TFCompensaCheque.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCompensaCheque'));
      if FCompensaCheque.CompensaCheque(VpfDCheque) then
        AtualizaConsulta(true);
      FCompensaCheque.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFConsultaCheques.DevolverCheque(VpaSeqCheque : Integer);
var
  VpfData : TDAteTime;
  VpfResultado : string;
  VpfCheques : TList;
  VpfTransacao : TTransactionDesc;
begin
  VpfData := date;
  if EntraData('Devolução do Cheque','Data de Devolução : ',VpfData) then
  begin
    VpfCheques := TList.Create;
    VpfTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VpfTransacao);
    VpfResultado := CarChequesSelecionados(VpfCheques);
    if VpfResultado = '' then
      VpfResultado := FunContasAReceber.DevolveCheque(VpfCheques,VpfData);

    if VpfResultado <> '' then
    begin
      FPrincipal.BaseDados.Rollback(VpfTransacao);
      aviso(VpfResultado)
    end
    else
    begin
      FPrincipal.BaseDados.Commit(VpfTransacao);
      AtualizaConsulta(true);
    end;
    FreeTObjectsList(VpfCheques);
  end;
end;

{******************************************************************************}
procedure TFConsultaCheques.ExtornaCheque(VpaSeqCheque : Integer);
var
  VpfResultado : string;
  VpfDCheque : TRBDCheque;
begin
  if Confirmacao('Tem certeza que deseja extornar o cheque?') then
  begin
    IF (ChequeC_FLA_TIP.AsString <> 'C') and (ChequeC_FLA_TIP.AsString <> 'R') AND (ChequeC_FLA_TIP.AsString <> 'P')then
      aviso('TIPO DA FORMA DE PAGAMENTO INVÁLIDO!!!!'#13'Essa operação só é permitido com formas de pagamento do tipo CHEQUE  e CHEQUE DE TERCEIROS')
    else
    begin
      if VpaSeqCheque <> 0 then
      begin
        VpfDCheque := TRBDCheque.cria;
        FunContasAReceber.CarDCheque(VpfDCheque,VpaSeqCheque);
        VpfResultado := FunContasAReceber.EstornaCheque(VpfDCheque);
        if VpfResultado <> '' then
          aviso(VpfResultado)
        else
          AtualizaConsulta(true);
        VpfDCheque.free;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFConsultaCheques.CarDCheque;
begin
  VprDCheque.SeqCheque := ChequeSEQCHEQUE.AsInteger;
  VprDCheque.CodBanco := ChequeCODBANCO.AsInteger;
  VprDCheque.NumCheque := ChequeNUMCHEQUE.AsInteger;
  VprDCheque.NumContaCaixa := ChequeNUMCONTACAIXA.AsString;
  VprDCheque.NomEmitente := ChequeNOMEMITENTE.AsString;
  VprDCheque.ValCheque := ChequeVALCHEQUE.AsFloat;
  VprDCheque.DatVencimento := ChequeDATVENCIMENTO.AsDateTime;
  VprDCheque.TipCheque := 'C';
  VprDCheque.TipContaCaixa := ChequeC_TIP_CON.AsString;
end;

{******************************************************************************}
procedure TFConsultaCheques.GradeOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

procedure TFConsultaCheques.EDatInicioClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFConsultaCheques.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFConsultaCheques.EFormaPagamentoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFConsultaCheques.BImprimirClick(Sender: TObject);
begin
  if ChequeSEQCHEQUE.AsInteger <> 0 then
  begin
    Rave.close;
    Rave.ProjectFile := varia.PathRelatorios+'\Financeiro\XX_Cheque.rav';
    Rave.SetParam('PERIODO',FormatDateTime('DD/MM/YY',EDatInicio.DateTime)+' - '+FormatDateTime('DD/MM/YY',EDatFim.DateTime));
    Rave.execute;
  end;
end;

{******************************************************************************}
procedure TFConsultaCheques.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConsultaCheques.BCompensarClick(Sender: TObject);
begin
  CompensaCheque(ChequeSEQCHEQUE.AsInteger);
end;

{******************************************************************************}
procedure TFConsultaCheques.BDevolverClick(Sender: TObject);
begin
  DevolverCheque(ChequeSEQCHEQUE.AsInteger);
end;

{******************************************************************************}
procedure TFConsultaCheques.BExtornarClick(Sender: TObject);
begin
  ExtornaCheque(ChequeSEQCHEQUE.AsInteger);
end;

{******************************************************************************}
procedure TFConsultaCheques.ChequeAfterScroll(DataSet: TDataSet);
begin
  BCompensar.Enabled := ChequeDATCOMPENSACAO.IsNull;
  BDevolver.Enabled := ChequeDATDEVOLUCAO.IsNull;
end;

{******************************************************************************}
procedure TFConsultaCheques.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConsultaCheques.BGravarClick(Sender: TObject);
begin
  if ChequeSEQCHEQUE.AsInteger <> 0 then
  begin
    VprAcao := true;
    CarDCheque;
    close;
  end;
end;

{******************************************************************************}
procedure TFConsultaCheques.ConsultaContasaPagar1Click(Sender: TObject);
begin
  if ChequeSEQCHEQUE.AsInteger <> 0 then
  begin
    FContasaPagar := TFContasaPagar.CriarSDI(self,'',FPrincipal.VerificaPermisao('FContasaPagar'));
    FContasaPagar.ConsultaContasdoCheque(ChequeSEQCHEQUE.AsInteger);
    FContasaPagar.free;
  end;
end;

{******************************************************************************}
procedure TFConsultaCheques.ConsultaContasaReceber1Click(Sender: TObject);
begin
  if ChequeSEQCHEQUE.AsInteger <> 0 then
  begin
    FContasaReceber := TFContasaReceber.CriarSDI(self,'',FPrincipal.VerificaPermisao('FContasaReceber'));
    FContasaReceber.ConsultaContasdoCheque(ChequeSEQCHEQUE.AsInteger);
    FContasaReceber.free;
  end;
end;

{******************************************************************************}
procedure TFConsultaCheques.AlterarVencimento1Click(Sender: TObject);
var
  VpfDatVencimento : TDateTime;
  VpfResultado : string;
begin
  VpfDatVencimento := date;
  if (ChequeDATCOMPENSACAO.IsNull) and (ChequeSEQCHEQUE.AsInteger <> 0) then
  begin
    if EntraData('Vencimento','Vencimento : ',VpfDatVencimento) then
    begin
      VpfResultado := FunContasAReceber.AlteraVencimentoCheque(ChequeSEQCHEQUE.AsInteger,VpfDatVencimento);
      if VpfResultado <> '' then
        aviso(VpfResultado)
      else
        AtualizaConsulta(true);
    end;
  end;
end;

procedure TFConsultaCheques.GradeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (State = [gdSelected]) then
  begin
    Grade.Canvas.Font.Color:= clWhite;
    Grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
  end
  else
    if (ChequeTIPCHEQUE.AsString = 'C') then
    begin
      Grade.Canvas.Font.Color:= clGreen;
      Grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
    end
    else
    begin
      Grade.Canvas.Font.Color:= clred;
      Grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
    end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsultaCheques]);
end.
