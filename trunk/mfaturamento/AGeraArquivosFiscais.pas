unit AGeraArquivosFiscais;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Buttons, StdCtrls, Componentes1, Localizacao, ComCtrls, ExtCtrls,  FileCtrl,
  PainelGradiente, UnExportacaoFiscal;

type
  TFGeraArquivosFiscais = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ECodFilial: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
  private
    { Private declarations }
    FunExportacaoFiscal : TRBFuncoesExportacaoFiscal;
  public
    { Public declarations }
  end;

var
  FGeraArquivosFiscais: TFGeraArquivosFiscais;

implementation

uses APrincipal, FunData, Constantes, AMostraCriticaFiscal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGeraArquivosFiscais.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunExportacaoFiscal := TRBFuncoesExportacaoFiscal.cria(FPrincipal.BaseDAdos);
  EDatInicio.Datetime := PrimeiroDiaMesAnterior;
  EDatFim.DateTime := UltimodiaMesAnterior;
  ECodFilial.AInteiro := Varia.CodigoEmpFil;
  EcodFilial.Atualiza;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGeraArquivosFiscais.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunExportacaoFiscal.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFGeraArquivosFiscais.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFGeraArquivosFiscais.BGerarClick(Sender: TObject);
var
  VpfDiretorio: string;
  VpfCritica : TStringList;
begin
  VpfDiretorio := Varia.DiretorioFiscais;
  VpfCritica := TStringList.Create;
  VpfDiretorio := VpfDiretorio + '\';
  FunExportacaoFiscal.ExportarNotasPessoas(ECodFilial.AInteiro,EDatInicio.DateTime, EDatFim.DateTime, VpfDiretorio,StatusBar1,VpfCritica);
  if VpfCritica.Count > 0 then
  begin
    FMostraCriticaFiscal := TFMostraCriticaFiscal.CriarSDI(application,'', FPrincipal.VerificaPermisao('FMostraCriticaFiscal'));
    FMostraCriticaFiscal.MostraCritica(VpfCritica);
    FMostraCriticaFiscal.free;
  end;
  VpfCritica.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGeraArquivosFiscais]);
end.
