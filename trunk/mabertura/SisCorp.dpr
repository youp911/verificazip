program SisCorp;

uses
  Forms,
  Dialogs,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  Abertura in '..\MaGerais\Abertura.pas' {FAbertura},
  Constantes in '..\MConfiguracoesSistema\Constantes.pas',
  UnAtualizacao in '..\MaGerais\UnAtualizacao.pas',
  AMenssagemAtualizando in 'AMenssagemAtualizando.pas' {FMensagemAtualizando},
  UnSistema in '..\magerais\UnSistema.pas',
  UnDados in '..\magerais\UnDados.pas',
  UnDadosCR in '..\mfinanceiro\UnDadosCR.pas',
  UnVersoes in '..\magerais\UnVersoes.pas';

{$R *.RES}
var
  ParametroNomeSistema : String;

begin
  Application.Initialize;
  Application.Title := 'SisCorp';
  Application.CreateForm(TFPrincipal, FPrincipal);

  varia.ParametroBase := ParamStr(1);
  VglParametroOficial := ParamStr(2);

  if ParamCount < 2 then
  begin
    VglParametroOficial := '1';
    if ParamCount < 1 Then
      Varia.parametroBase := 'SisCorp';
  end;

  if VglParametroOficial = '0' Then
    FPrincipal.MostraMenssagemDemostracao;

  ParametroNomeSistema := 'SisCorp - ' + Varia.ParametroBase;
  Fprincipal.VplParametroBaseDados := Varia.ParametroBase;
  if not FPrincipal.ProgramaEmExecucao(ParametroNomeSistema) then
  begin
    FPrincipal.Caption := ParametroNomeSistema;
    FPrincipal.ResetaIni;
    Application.Run
  end
  else
    FPrincipal.close;
end.
