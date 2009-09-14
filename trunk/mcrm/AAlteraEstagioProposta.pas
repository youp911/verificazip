unit AAlteraEstagioProposta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, PainelGradiente, ExtCtrls, Componentes1,
  DBKeyViolation, Localizacao, UnProposta;

type
  TFAlteraEstagioProposta = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ConsultaPadrao1: TConsultaPadrao;
    EUsuario: TEditLocaliza;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    BChamado: TSpeedButton;
    Label1: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label8: TLabel;
    ECodEstagio: TEditLocaliza;
    EProposta: TEditLocaliza;
    EEstagioAtual: TEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    EMotivo: TMemoColor;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EUsuarioChange(Sender: TObject);
    procedure EPropostaRetorno(Retorno1, Retorno2: String);
    procedure EPropostaSelect(Sender: TObject);
    procedure EChamadoChange(Sender: TObject);
    procedure ECodEstagioRetorno(Retorno1, Retorno2: String);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprIndCliente: Boolean;
    VprPropostas : String;
    FunProposta : TRBFuncoesProposta;
    function DadosValidos : String;
  public
    { Public declarations }
    function AlteraEstagioProposta:Boolean;overload;
    function AlteraEstagioProposta(VpaSeqProposta : Integer) :Boolean;overload;
    function AlteraEstagioPropostaCliente(VpaSeqProposta: Integer): Boolean;
    function AlteraEstagioPropostas(VpaPropostas : String):Boolean;
  end;

var
  FAlteraEstagioProposta: TFAlteraEstagioProposta;

implementation

uses APrincipal,Constantes, ConstMsg, FunObjeto, AEstagioProducao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraEstagioProposta.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  VprIndCliente:= False;
  FunProposta := TRBFuncoesProposta.cria(fprincipal.BaseDados);
  VprPropostas := '';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraEstagioProposta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAlteraEstagioProposta.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
  begin
    if VprPropostas = '' then
      VpfResultado := FunProposta.AlteraEstagioProposta(varia.CodigoEmpfil,EProposta.AInteiro,EUsuario.AInteiro,ECodEstagio.AInteiro,EMotivo.Lines.text)
    else
      VpfResultado := FunProposta.AlteraEstagioPropostas(varia.CodigoEmpfil,EUsuario.AInteiro,ECodEstagio.AInteiro,VprPropostas,EMotivo.Lines.Text);
    if VpfResultado = '' then
    begin
      VprAcao := true;
      close;
    end
  end;
  if VpfResultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.EUsuarioChange(Sender: TObject);
begin
  ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.EPropostaRetorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
    EEstagioAtual.Text := Retorno1
  else
    EEstagioAtual.clear;
  EEstagioAtual.Atualiza;

end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.EPropostaSelect(Sender: TObject);
begin
  if not VprIndCliente then
  begin
    EProposta.AInfo.CampoNome:= 'NOMPROSPECT';
    EProposta.ASelectValida.Text:= 'Select PRO.SEQPROPOSTA, PRO.CODESTAGIO, PCT.NOMPROSPECT '+
                                   ' from PROPOSTA PRO, PROSPECT PCT '+
                                   ' Where PRO.CODPROSPECT = PCT.CODPROSPECT '+
                                   ' AND PRO.SEQPROPOSTA = @ '+
                                   ' AND PRO.CODFILIAL = ' +IntToStr(varia.CodigoEmpFil);
    EProposta.ASelectLocaliza.Text:= 'Select PRO.SEQPROPOSTA, PRO.CODESTAGIO, PCT.NOMPROSPECT '+
                                     ' from PROPOSTA PRO, PROSPECT PCT '+
                                     ' Where PRO.CODPROSPECT = PCT.CODPROSPECT '+
                                     ' AND PCT.NOMPROSPECT LIKE ''@%'''+
                                     ' AND PRO.CODFILIAL = ' +IntToStr(varia.CodigoEmpFil);
  end
  else
  begin
    EProposta.AInfo.CampoNome:= 'C_NOM_CLI';
    EProposta.ASelectValida.Text:= 'Select PRO.SEQPROPOSTA, PRO.CODESTAGIO, CLI.C_NOM_CLI'+
                                   ' from PROPOSTA PRO, CADCLIENTES CLI '+
                                   ' Where PRO.CODCLIENTE = CLI.I_COD_CLI'+
                                   ' AND PRO.SEQPROPOSTA = @ '+
                                   ' AND PRO.CODFILIAL = ' +IntToStr(varia.CodigoEmpFil);
    EProposta.ASelectLocaliza.Text:= 'Select PRO.SEQPROPOSTA, PRO.CODESTAGIO, CLI.C_NOM_CLI'+
                                     ' from PROPOSTA PRO, CADCLIENTES CLI'+
                                     ' Where PRO.CODCLIENTE = CLI.I_COD_CLI'+
                                     ' AND CLI.C_NOM_CLI LIKE ''@%'''+
                                     ' AND PRO.CODFILIAL = ' +IntToStr(varia.CodigoEmpFil);
  end;
end;

{******************************************************************************}
function TFAlteraEstagioProposta.AlteraEstagioProposta:Boolean;
begin
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioProposta.AlteraEstagioProposta(VpaSeqProposta : Integer) :Boolean;
begin
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  EProposta.AInteiro := VpaSeqProposta;
  EProposta.Atualiza;
  ActiveControl := ECodEstagio;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioProposta.AlteraEstagioPropostaCliente(VpaSeqProposta: Integer): Boolean;
begin
  VprIndCliente:= True;
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  EProposta.AInteiro := VpaSeqProposta;
  EProposta.Atualiza;
  ActiveControl := ECodEstagio;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioProposta.AlteraEstagioPropostas(VpaPropostas : String):Boolean;
begin
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  VprPropostas := VpaPropostas;
  AlterarEnabledDet([EProposta,BChamado],false);
  EProposta.ACampoObrigatorio := false;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFAlteraEstagioProposta.DadosValidos : String;
begin
  result := '';
  if EMotivo.ACampoObrigatorio then
    if EMotivo.Lines.Text = '' then
      result := 'MOTIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o motivo pelo qual se está mudando de estágio';
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.EChamadoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFAlteraEstagioProposta.ECodEstagioRetorno(Retorno1,
  Retorno2: String);
begin
  EMotivo.ACampoObrigatorio := false;
  if retorno1 <> '' then
  begin
    if Retorno1 = 'S' then
      EMotivo.ACampoObrigatorio := true;
  end;
end;


initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEstagioProposta]);
end.
