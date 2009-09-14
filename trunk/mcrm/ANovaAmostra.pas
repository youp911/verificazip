unit ANovaAmostra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Tabela,
  CBancoDados, ComCtrls, BotaoCadastro, StdCtrls, Buttons, DBKeyViolation,
  Mask, DBCtrls, Localizacao, UnAmostra, EditorImagem, UnDadosProduto, UnClassificacao,
  DBClient;

type
  TFNovaAmostra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Amostra: TRBSQL;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    PanelColor1: TPanelColor;
    Paginas: TPageControl;
    PAmostra: TTabSheet;
    AmostraCODAMOSTRA: TFMTBCDField;
    AmostraNOMAMOSTRA: TWideStringField;
    AmostraDATAMOSTRA: TSQLTimeStampField;
    AmostraDATENTREGA: TSQLTimeStampField;
    AmostraDATENTREGACLIENTE: TSQLTimeStampField;
    AmostraCODCOLECAO: TFMTBCDField;
    AmostraCODDESENVOLVEDOR: TFMTBCDField;
    AmostraCODPROSPECT: TFMTBCDField;
    AmostraDESIMAGEM: TWideStringField;
    AmostraDESIMAGEMCLIENTE: TWideStringField;
    AmostraINDCOPIA: TWideStringField;
    AmostraVALCUSTO: TFMTBCDField;
    AmostraVALVENDA: TFMTBCDField;
    Label1: TLabel;
    DataAmostra: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    EDatEntrega: TDBEditColor;
    DBEditColor4: TDBEditColor;
    SpeedButton1: TSpeedButton;
    AmostraDATAPROVACAO: TSQLTimeStampField;
    AmostraCODVENDEDOR: TFMTBCDField;
    DBEditLocaliza1: TDBEditLocaliza;
    DBEditLocaliza2: TDBEditLocaliza;
    Localiza: TConsultaPadrao;
    Label14: TLabel;
    SpeedButton2: TSpeedButton;
    Label15: TLabel;
    SpeedButton3: TSpeedButton;
    DBEditLocaliza3: TDBEditLocaliza;
    Label16: TLabel;
    DBEditLocaliza4: TDBEditLocaliza;
    Label17: TLabel;
    SpeedButton4: TSpeedButton;
    Label18: TLabel;
    CCopia: TDBCheckBox;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    Label11: TLabel;
    DBEditColor7: TDBEditColor;
    DBEditColor8: TDBEditColor;
    EDatAprovacao: TDBEditColor;
    Label12: TLabel;
    ValidaGravacao1: TValidaGravacao;
    AmostraTIPAMOSTRA: TWideStringField;
    ETipoAmostra: TDBRadioGroup;
    Label19: TLabel;
    SpeedButton5: TSpeedButton;
    Label20: TLabel;
    EAmostraIndefinida: TDBEditLocaliza;
    AmostraCODAMOSTRAINDEFINIDA: TFMTBCDField;
    BCadastrar: TBitBtn;
    AmostraDESOBSERVACAO: TWideStringField;
    DBMemoColor1: TDBMemoColor;
    Label21: TLabel;
    BConcluir: TBitBtn;
    AmostraQTDAMOSTRA: TFMTBCDField;
    AmostraCODPRODUTO: TWideStringField;
    AmostraQTDPREVISAOCOMPRA: TFMTBCDField;
    DBEditColor3: TDBEditColor;
    Label22: TLabel;
    DBEditColor9: TDBEditColor;
    Label23: TLabel;
    BFoto: TBitBtn;
    BitBtn1: TBitBtn;
    EditorImagem1: TEditorImagem;
    BConsumo: TBitBtn;
    AmostraINDALTERACAO: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    AmostraCODCLIENTE: TFMTBCDField;
    DBRadioGroup1: TDBRadioGroup;
    Label24: TLabel;
    AmostraDESDEPARTAMENTO: TWideStringField;
    Label25: TLabel;
    SpeedButton15: TSpeedButton;
    LNomClassificacao: TLabel;
    ECodClassificacao: TDBEditColor;
    AmostraCODCLASSIFICACAO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure AmostraAfterInsert(DataSet: TDataSet);
    procedure ECodigoChange(Sender: TObject);
    procedure DBEditLocaliza2Cadastrar(Sender: TObject);
    procedure DBEditLocaliza1Cadastrar(Sender: TObject);
    procedure DBEditLocaliza3Cadastrar(Sender: TObject);
    procedure AmostraAfterEdit(DataSet: TDataSet);
    procedure AmostraAfterScroll(DataSet: TDataSet);
    procedure BCadastrarClick(Sender: TObject);
    procedure AmostraAfterPost(DataSet: TDataSet);
    procedure AmostraAfterCancel(DataSet: TDataSet);
    procedure BConcluirClick(Sender: TObject);
    procedure BFotoClick(Sender: TObject);
    procedure BConsumoClick(Sender: TObject);
    procedure ETipoAmostraChange(Sender: TObject);
    procedure ECodClassifcacaoExit(Sender: TObject);
    procedure ECodClassifcacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton15Click(Sender: TObject);
    procedure BotaoGravar1Click(Sender: TObject);
    procedure AmostraBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    VprAcao : Boolean;
    FunAmostra : TRBFuncoesAmostra;
    VprDAmostra: TRBDAmostra;
    FunClassificacao : TFuncoesClassificacao;
    procedure EstadoBotoes(VpaEstado : Boolean);
    function LocalizaClassificacao : boolean;
  public
    { Public declarations }
  end;

var
  FNovaAmostra: TFNovaAmostra;

implementation

uses APrincipal, AAmostras, ADesenvolvedor, AColecao, ANovoProspect, FunObjeto,
  Constmsg, Constantes, AAmostraConsumo, ALocalizaClassificacao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaAmostra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Amostra.open;
  VprAcao := false;
  FunAmostra := TRBFuncoesAmostra.cria(FPrincipal.BaseDados);
  FunClassificacao := TFuncoesClassificacao.criar(self,FPrincipal.BaseDados);
  VprDAmostra:= TRBDAmostra.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaAmostra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunAmostra.free;
  FunClassificacao.free;
  VprDAmostra.Free;
  if Amostra.State in [dsedit,dsinsert] then
    Amostra.cancel;
  Amostra.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFNovaAmostra.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterInsert(DataSet: TDataSet);
begin
  activecontrol := ECodClassificacao;
  ECodigo.ProximoCodigo;
  AmostraINDCOPIA.AsString := 'N';
  AmostraINDALTERACAO.AsString := 'N';
  AmostraTIPAMOSTRA.AsString := 'D';
  AmostraDESDEPARTAMENTO.AsString := 'D';
  AmostraDATAMOSTRA.AsDateTime := now;
  EDatEntrega.ReadOnly := true;
  EDatAprovacao.readonly := true;
  EstadoBotoes(false);
end;

{******************************************************************************}
procedure TFNovaAmostra.ECodigoChange(Sender: TObject);
begin
  if Amostra.State in [dsedit,dsinsert] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaAmostra.DBEditLocaliza2Cadastrar(Sender: TObject);
begin
  FDesenvolvedor := TFDesenvolvedor.CriarSDI(self,'',FPrincipal.VerificaPermisao('FDesenvolvedor'));
  FDesenvolvedor.BotaoCadastrar1.click;
  FDesenvolvedor.showmodal;
  Localiza.AtualizaConsulta;
  FDesenvolvedor.free;
end;

{******************************************************************************}
procedure TFNovaAmostra.DBEditLocaliza1Cadastrar(Sender: TObject);
begin
  FColecao := TFColecao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FColecao'));
  FColecao.BotaoCadastrar1.Click;
  FColecao.ShowModal;
  FColecao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaAmostra.DBEditLocaliza3Cadastrar(Sender: TObject);
begin
  FNovoProspect := tFNovoProspect.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProspect'));
  FNovoProspect.Prospect.Insert;
  FNovoProspect.ShowModal;
  FNovoProspect.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterEdit(DataSet: TDataSet);
begin
  EstadoBotoes(false);
  BConsumo.Enabled := true;
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterScroll(DataSet: TDataSet);
begin
  AtualizaLocalizas(PanelColor1);
  ECodClassifcacaoExit(ECodClassificacao);
end;

procedure TFNovaAmostra.AmostraBeforePost(DataSet: TDataSet);
begin
  if Amostra.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFNovaAmostra.BCadastrarClick(Sender: TObject);
begin
  Amostra.insert;
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterPost(DataSet: TDataSet);
begin
  EstadoBotoes(true);
end;

{******************************************************************************}
procedure TFNovaAmostra.AmostraAfterCancel(DataSet: TDataSet);
begin
  BCadastrar.enabled := true;
end;

{******************************************************************************}
procedure TFNovaAmostra.EstadoBotoes(VpaEstado : Boolean);
begin
  BCadastrar.Enabled := VpaEstado;
  BConsumo.Enabled := VpaEstado;
end;

{******************************************************************************}
function TFNovaAmostra.LocalizaClassificacao : boolean;
var
  VpfCodClassificacao, VpfNomClassificacao : string;
begin
  result := true;
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao, 'P') then
  begin
    if Amostra.State in [dsedit,dsinsert] then
      AmostraCODCLASSIFICACAO.AsString := VpfCodClassificacao;
    LNomClassificacao.Caption := VpfNomClassificacao;
  end
  else
    result := false;
end;

{******************************************************************************}
procedure TFNovaAmostra.BConcluirClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfREsultado := FunAmostra.ConcluiAmostra(AmostraCODAMOSTRA.AsInteger,date);
  if VpfREsultado <> '' then
    aviso(VpfREsultado);

end;

{******************************************************************************}
procedure TFNovaAmostra.BFotoClick(Sender: TObject);
begin
  if Amostra.State in [ dsInsert, dsedit] then
     if editorImagem1.execute(varia.DriveFoto + AmostraDESIMAGEM.AsString) then
        AmostraDESIMAGEM.asstring := EditorImagem1.PathImagem;

end;

procedure TFNovaAmostra.BotaoGravar1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovaAmostra.BConsumoClick(Sender: TObject);
begin
  VprDAmostra.CodAmostra := AmostraCODAMOSTRA.AsInteger;
  FAmostraConsumo := TFAmostraConsumo.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAmostraConsumo'));
  FAmostraConsumo.ConsumosAmostra(VprDAmostra);
  FAmostraConsumo.free;
end;

{******************************************************************************}
procedure TFNovaAmostra.ETipoAmostraChange(Sender: TObject);
begin
  if ETipoAmostra.ItemIndex = 0 then
  begin
    EAmostraIndefinida.ACampoObrigatorio := true;
    BConcluir.Enabled := true;
  end
  else
  begin
    BConcluir.Enabled := false;
    EAmostraIndefinida.ACampoObrigatorio := false;
  end;
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaAmostra.ECodClassifcacaoExit(Sender: TObject);
var
  VpfNomClassificacao : String;
begin
//  if Amostra.State in [dsedit,dsinsert] then
  begin
    if AmostraCODCLASSIFICACAO.AsString <> '' then
    begin
      if not FunClassificacao.ValidaClassificacao(AmostraCODCLASSIFICACAO.AsString,VpfNomClassificacao, 'P') then
      begin
         if not LocalizaClassificacao then
           ECodClassificacao.SetFocus;
      end
      else
      begin
        LNomClassificacao.Caption := VpfNomClassificacao;
      end;
    end
    else
      LNomClassificacao.Caption := '';
  end;
end;

{******************************************************************************}
procedure TFNovaAmostra.ECodClassifcacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFNovaAmostra.SpeedButton15Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaAmostra]);
end.
