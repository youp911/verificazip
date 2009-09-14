unit ANovaTransferencia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, StdCtrls, Buttons,
  ComCtrls, Mask, numericos, UnDadosCR, UnCaixa;

type
  TFNovaTransferencia = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label28: TLabel;
    SpeedButton3: TSpeedButton;
    Label38: TLabel;
    Label1: TLabel;
    EContaCorrente: TEditLocaliza;
    EDatTransferencia: TCalendario;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    EValor: Tnumerico;
    Label2: TLabel;
    Label3: TLabel;
    EObservacao: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprCaixaOrigem : String;
    FunCaixa : TRBFuncoesCaixa;
    function DadosValidos : String;
    function GravaCaixaOrigem : String;
    function GravaCaixaDestino : String;
  public
    { Public declarations }
    function TransferenciaCaixa(VpaCaixaOrigem : String):Boolean;
  end;

var
  FNovaTransferencia: TFNovaTransferencia;

implementation

uses APrincipal, Constantes, constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaTransferencia.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  FunCaixa := TRBFuncoesCaixa.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaTransferencia.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = ''  then
  begin
    VpfResultado :=  GravaCaixaOrigem;
    if VpfResultado = '' then
      VpfResultado := GravaCaixaDestino;
  end;

  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao := true;
    close;
  end;
end;

procedure TFNovaTransferencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunCaixa.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovaTransferencia.TransferenciaCaixa(VpaCaixaOrigem : String):Boolean;
begin
  VprCaixaOrigem := VpaCaixaOrigem;
  showmodal;
  result := VprAcao;
end;


{******************************************************************************}
function TFNovaTransferencia.DadosValidos : String;
begin
  result := '';
  if VprCaixaOrigem = EContaCorrente.Text then
    result := 'CONTA CAIXA DESTINO IGUAL A CONTA ORIGEM!!!'#13'A conta caixa destino não pode ser igual a conta caixa origem.';
  if result = '' then
  begin
    if FunCaixa.RSeqCaixa(VprCaixaOrigem)= 0  then
      result := 'CAIXA ORIGEM NÃO ABERTO!!!'#13'É necessário abrir o caixa origem antes de fazer a transferência.';
    if result = '' then
    begin
      if FunCaixa.RSeqCaixa(EContaCorrente.Text)= 0  then
        result := 'CAIXA DESTINO NÃO ABERTO!!!'#13'É necessário abrir o caixa destino antes de fazer a transferência.';
    end;
  end;
end;

{******************************************************************************}
function TFNovaTransferencia.GravaCaixaOrigem : String;
var
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
  VpfSeqCaixaOrigem : Integer;
begin
  VpfDCaixa := TRBDCaixa.cria;
  VpfSeqCaixaOrigem := FunCaixa.RSeqCaixa(VprCaixaOrigem);
  FunCaixa.CarDCaixa(VpfDCaixa,VpfSeqCaixaOrigem);

  VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
  VpfDItemCaixa.CodUsuario := varia.codigoUsuario;
  VpfDItemCaixa.CodFormaPagamento := varia.FormaPagamentoDinheiro;
  VpfDItemCaixa.DesLancamento := 'Transferência entre caixa "'+EContaCorrente.Text+'" '+EObservacao.Text;
  VpfDItemCaixa.DesDebitoCredito := 'D';
  VpfDItemCaixa.ValLancamento := EValor.AValor;
  VpfDItemCaixa.DatPagamento := Date;
  VpfDItemCaixa.DatLancamento := Date;
  result := FunCaixa.GravaDCaixa(VpfDCaixa);
end;

{******************************************************************************}
function TFNovaTransferencia.GravaCaixaDestino : String;
var
  VpfDCaixa : TRBDCaixa;
  VpfDItemCaixa : TRBDCaixaItem;
  VpfSeqCaixaDestino : Integer;
begin
  VpfDCaixa := TRBDCaixa.cria;
  VpfSeqCaixaDestino := FunCaixa.RSeqCaixa(EContaCorrente.Text);
  FunCaixa.CarDCaixa(VpfDCaixa,VpfSeqCaixaDestino);

  VpfDItemCaixa := VpfDCaixa.AddCaixaItem;
  VpfDItemCaixa.CodUsuario := varia.codigoUsuario;
  VpfDItemCaixa.CodFormaPagamento := varia.FormaPagamentoDinheiro;
  VpfDItemCaixa.DesLancamento := 'Transferência entre caixa "'+VprCaixaOrigem+'" '+EObservacao.Text;
  VpfDItemCaixa.DesDebitoCredito := 'C';
  VpfDItemCaixa.ValLancamento := EValor.AValor;
  VpfDItemCaixa.DatPagamento := Date;
  VpfDItemCaixa.DatLancamento := Date;
  result := FunCaixa.GravaDCaixa(VpfDCaixa);
end;

{******************************************************************************}
procedure TFNovaTransferencia.BCancelarClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTransferencia]);
end.
