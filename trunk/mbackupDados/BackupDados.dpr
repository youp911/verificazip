program BackupDados;

uses
  Forms,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  Constantes in '..\mconfiguracoessistema\Constantes.pas',
  UnSistema in '..\magerais\UnSistema.pas',
  UnDados in '..\magerais\UnDados.pas',
  UnDadosCR in '..\mfinanceiro\UnDadosCR.pas',
  UnVersoes in '..\magerais\UnVersoes.pas',
  ACompactador in 'ACompactador.pas' {FCompactador};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFCompactador, FCompactador);
  Application.Run;
end.
