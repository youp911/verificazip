unit AEnviaEmailCobrancaPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Gauges,
  ComCtrls;

type
  TFEnviaEmailCobrancaPedidoCompra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BarraStatus: TStatusBar;
    Animacao: TAnimate;
    Progresso: TProgressBar;
    BEnviar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
  private
  public
    procedure EnviarEmails(VpaCodFilial, VpaSeqEmail: Integer);
  end;

var
  FEnviaEmailCobrancaPedidoCompra: TFEnviaEmailCobrancaPedidoCompra;

implementation
uses
  APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEnviaEmailCobrancaPedidoCompra.FormCreate(Sender: TObject);
begin
  { abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEnviaEmailCobrancaPedidoCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.BEnviarClick(Sender: TObject);
begin
  // Falar com o rafael para fazer a rotina de enviar os emails.
end;

{******************************************************************************}
procedure TFEnviaEmailCobrancaPedidoCompra.EnviarEmails(VpaCodFilial, VpaSeqEmail: Integer);
begin
  ShowModal;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEnviaEmailCobrancaPedidoCompra]);
end.
