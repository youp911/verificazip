unit ANovoAgendamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Localizacao, UnDados, Constantes,
  Mask, ComCtrls, DBKeyViolation, UnClientes;

type
  TFNovoAgedamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Label1: TLabel;
    EDatCadastro: TEditColor;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ECliente: TEditLocaliza;
    BCliente: TSpeedButton;
    ConsultaPadrao1: TConsultaPadrao;
    Label10: TLabel;
    Label11: TLabel;
    ETipoAgendamento: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label12: TLabel;
    EDatAgendamento: TCalendario;
    Label13: TLabel;
    EUsuario: TEditLocaliza;
    BUsuario: TSpeedButton;
    Label14: TLabel;
    EHorInicio: TMaskEditColor;
    EHorFim: TMaskEditColor;
    EObservacoes: TMemoColor;
    ValidaGravacao1: TValidaGravacao;
    CRealizado: TRadioButton;
    CARealizar: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ETipoAgendamentoCadastrar(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure EHorInicioExit(Sender: TObject);
    procedure EClienteChange(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprOperacao : TRBDOperacaoCadastro;
    VprDAgenda : TRBDAgenda;
    procedure InicializaClasse;
    procedure CarDTela;
    function CarDClasse : Boolean;
  public
    { Public declarations }
    function AgendaPeloTelemarketing(VpaCodCliente,VpaCodUsuario : Integer) : Boolean;
    function NovaAgenda(VpaCodUsuario : Integer) : Boolean;
    function NovaAgendaPedidoCompra(VpaCodUsuario, VpaCodFilial,VpaSeqPedido : Integer):boolean;
    function NovaAgendaCliente(VpaCodCliente : Integer) : Boolean;
    function AlteraAgendamento(VpaDAgenda : TRBDAgenda):Boolean;
    procedure ConsultaAgenda(VpaDAgenda : TRBDAgenda);
  end;

var
  FNovoAgedamento: TFNovoAgedamento;

implementation

uses APrincipal, ATipoAgendamento, FunData, ConstMsg, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoAgedamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  VprDAgenda := TRBDAgenda.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoAgedamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDAgenda.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFNovoAgedamento.InicializaClasse;
begin
  VprDAgenda.SeqAgenda := 0;
  VprDAgenda.DatCadastro := now;
  VprDAgenda.IndRealizado := false;
  VprDAgenda.DatInicio := IncHora(now,0);
  VprDAgenda.DatFim := VprDAgenda.DatInicio;
end;

{******************************************************************************}
procedure TFNovoAgedamento.CarDTela;
begin
  EDatCadastro.Text := FormatDateTime('DD/MM/YYY HH:MM',VprDAgenda.DatCadastro);
  ECliente.AInteiro := VprDAgenda.CodCliente;
  ECliente.Atualiza;
  EUsuario.AInteiro := VprDAgenda.CodUsuario;
  EUsuario.Atualiza;
  ETipoAgendamento.AInteiro := VprDAgenda.CodTipoAgendamento;
  ETipoAgendamento.Atualiza;
  EDatAgendamento.DateTime := VprDAgenda.DatInicio;
  EHorInicio.Text := FormatDateTime('HH:MM',VprDAgenda.DatInicio);
  EHorFim.Text := FormatDateTime('HH:MM',VprDAgenda.DatFim);
  EObservacoes.Lines.Text := VprDAgenda.DesObservacoes;
end;

{******************************************************************************}
function TFNovoAgedamento.CarDClasse : Boolean;
begin
  result := true;
  VprDAgenda.CodCliente := ECliente.AInteiro;
  VprDAgenda.CodUsuario := EUsuario.AInteiro;
  VprDAgenda.CodTipoAgendamento := ETipoAgendamento.AInteiro;
  VprDAgenda.DesObservacoes := EObservacoes.Lines.Text;
  VprDAgenda.DatInicio := MontaData(dia(EDatAgendamento.Date),mes(EDatAgendamento.Date),ano(EDatAgendamento.Date)) + StrToTime(EHorInicio.Text);
  VprDAgenda.DatFim := MontaData(dia(EDatAgendamento.Date),mes(EDatAgendamento.Date),ano(EDatAgendamento.Date)) + StrToTime(EHorFim.Text);
  VprDAgenda.IndRealizado := CRealizado.Checked; 
  if VprDAgenda.DatInicio > VprDAgenda.DatFim then
  begin
    aviso('HORA FINAL INVÁLIDA!!!!'#13'A hora final não pode ser menor que a hora inicial.');
    result := false;
  end;
end;

{******************************************************************************}
procedure TFNovoAgedamento.ETipoAgendamentoCadastrar(Sender: TObject);
begin
  FTipoAgendamento := TFTipoAgendamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FTipoAgendamento'));
  FTipoAgendamento.BotaoCadastrar1.Click;
  FTipoAgendamento.showmodal;
  FTipoAgendamento.free;
  ConsultaPadrao1.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoAgedamento.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoAgedamento.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
function TFNovoAgedamento.AgendaPeloTelemarketing(VpaCodCliente,VpaCodUsuario : Integer) : Boolean;
begin
  InicializaClasse;
  VprOperacao := ocInsercao;
  VprDAgenda.CodCliente := VpaCodCliente;
  ECliente.ReadOnly := true;
  BCliente.Enabled := false;
  VprDAgenda.CodUsuarioAgendou := VpaCodUsuario;
  VprDAgenda.CodUsuario := VpaCodUsuario;
  CarDTela;
  activeControl := ETipoAgendamento;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovoAgedamento.NovaAgenda(VpaCodUsuario : Integer) : Boolean;
begin
  InicializaClasse;
  VprOperacao := ocInsercao;
  VprDAgenda.CodUsuarioAgendou := VpaCodUsuario;
  VprDAgenda.CodUsuario := VpaCodUsuario;
  CarDTela;
  activeControl := ECliente;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovoAgedamento.NovaAgendaPedidoCompra(VpaCodUsuario, VpaCodFilial,VpaSeqPedido : Integer):boolean;
begin
  InicializaClasse;
  VprOperacao := ocInsercao;
  VprDAgenda.CodUsuarioAgendou := VpaCodUsuario;
  VprDAgenda.CodUsuario := VpaCodUsuario;
  VprDAgenda.CodFilialCompra := VpaCodFilial;
  VprDAgenda.SeqPedidoCompra := VpaSeqPedido;
  CarDTela;
  activeControl := ECliente;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovoAgedamento.NovaAgendaCliente(VpaCodCliente : Integer) : Boolean;
begin
  InicializaClasse;
  VprOperacao := ocInsercao;
  VprDAgenda.CodUsuarioAgendou := varia.CodigoUsuario;
  VprDAgenda.CodUsuario := varia.CodigoUsuario;
  VprDAgenda.CodCliente := VpaCodCliente;
  CarDTela;
  activeControl := ETipoAgendamento;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovoAgedamento.AlteraAgendamento(VpaDAgenda : TRBDAgenda):Boolean;
begin
  VprDAgenda := VpaDAgenda;
  CarDTela;
  VprOperacao := ocEdicao;
  ActiveControl := ECliente;
  ShowModal;
  result := vprAcao;
end;

{******************************************************************************}
procedure TFNovoAgedamento.ConsultaAgenda(VpaDAgenda : TRBDAgenda);
begin
  VprDAgenda := VpaDAgenda;
  CarDTela;
  VprOperacao := ocConsulta;
  ActiveControl := BFechar;
  PanelColor1.Enabled := false;
  BGravar.Enabled := false;
  BCancelar.Enabled := false;
  ShowModal;
end;

{******************************************************************************}
procedure TFNovoAgedamento.EHorInicioExit(Sender: TObject);
begin
  VprDAgenda.DatInicio := MontaData(dia(EDatAgendamento.Date),mes(EDatAgendamento.Date),ano(EDatAgendamento.Date)) + StrToTime(EHorInicio.Text);
  VprDAgenda.DatFim := IncMinuto(VprDAgenda.DatInicio,5);
  EHorFim.Text := FormatDateTime('HH:MM',VprDAgenda.DatFim);
end;

{******************************************************************************}
procedure TFNovoAgedamento.EClienteChange(Sender: TObject);
begin
  if (VprOperacao in [ocInsercao,ocEdicao]) then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoAgedamento.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if CarDClasse then
    VpfResultado := FunClientes.GravaDAgenda(VprDAgenda);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao := true;
    close;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoAgedamento]);
end.
