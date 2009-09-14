unit UnImpressaoRelatorio;
{Verificado
-.edit;
}
interface

uses
  Menus, Classes, SysUtils, Forms;


type
  TRBModulosRelatorio = (mrEstoque,mrPontoLoja,mrFinanceiro,mrFaturamento,mrChamado,mrCRM,mrCaixa);
  TImpressaoRelatorio = class
    private
      procedure ImprimirFiltroPedido(Sender: TObject);
      function RelatorioModulo(VpaModulo : TRBModulosRelatorio;VpaNomArquivo : String) : Boolean;
      function ExisteRelatorioModulo(VpaModulo : TRBModulosRelatorio;VpaDiretorio : String):Boolean;
      procedure AdicionaRelatoriosDiretorio(VpaModulo :TRBModulosRelatorio;VpaMenu : TMenuItem;VpaNomDiretorio : String);
      function MenuRaiz(VpaItemAtual: TMenuItem): TMenuItem;
      function IdentificadorRepetido(VpaItemMenu: TMenuItem; VpaIdentificador: string): boolean;
      function AdicionarSubItem(VpaItemMenu: TMenuItem; VpaPathDiretorio: string): TMenuItem;
      procedure SetarEventoImpressao(VpaItemMenu: TMenuItem; VpaPathArquivo: string);
      procedure AdicionarArquivo(VpaItemMenu: TMenuItem; VpaPathArquivo: string);
    public
      procedure CarregarMenuRel(VpaModuloAtual: TRBModulosRelatorio; VpaMenuRel: TMenuItem);
  end;

implementation

uses FunArquivos, ConstMsg, FunString, ARelPedido, constantes;

{******************************************************************************}
procedure TImpressaoRelatorio.ImprimirFiltroPedido(Sender: TObject);
var
  VpfPathRel, VpfNomeRel: string;
begin
  VpfPathRel := TMenuItem(Sender).hint;
  TMenuItem(Sender).Caption := DeletaChars(TMenuItem(Sender).Caption,'&');
  VpfNomeRel := TMenuItem(Sender).Caption;
  FRelPedido := TFRelPedido.CriarSDI(application,TMenuItem(Sender).Caption,true);
  FRelPedido.CarregarRelatorio(VpfPathRel, VpfNomeRel);
end;

{******************************************************************************}
function TImpressaoRelatorio.RelatorioModulo(VpaModulo : TRBModulosRelatorio;VpaNomArquivo : String) : Boolean;
var
  VpfLetrasModulo : String;
begin
  result := false;
  VpaNomArquivo := copy(VpaNomArquivo, NPosicao('\', VpaNomArquivo,ContaLetra(VpaNomarquivo, '\')) + 1,70);
  VpaNomArquivo := CopiaAteChar(VpaNomArquivo,'_');
  while length(VpaNomArquivo) > 1 do
  begin
    VpfLetrasModulo := UpperCase(Copy(VpaNomArquivo,1,2));
    if (VpaModulo = mrEstoque) then
    begin
      if VpfLetrasModulo = 'ES' then
        result := true;
    end
    else
      if (VpaModulo = mrPontoLoja) then
      begin
        if VpfLetrasModulo = 'PL' then
          result := true;
      end
      else
        if (VpaModulo = mrFinanceiro) then
        begin
          if VpfLetrasModulo = 'FI' then
            result := true;
        end
        else
          if (VpaModulo = mrFaturamento) then
          begin
            if VpfLetrasModulo = 'FA' then
              result := true;
          end
          else
            if (VpaModulo = mrChamado) then
            begin
              if VpfLetrasModulo = 'CH' then
                result := true;
            end
            else
              if (VpaModulo = mrCRM) then
              begin
                if VpfLetrasModulo = 'CR' then
                  result := true;
              end
              else
                if (VpaModulo = mrCaixa) then
                begin
                  if VpfLetrasModulo = 'CA' then
                    result := true;
                end;
    if result then
      exit;
    VpaNomArquivo := copy(VpaNomArquivo,3,length(VpaNomArquivo)-2);
  end;
end;

{******************************************************************************}
function TImpressaoRelatorio.ExisteRelatorioModulo(VpaModulo : TRBModulosRelatorio;VpaDiretorio : String):Boolean;
var
  VpfLaco : Integer;
  VpfArquivos,VpfDiretorios : TStringList;
begin
  result := false;
  VpfDiretorios := RetornaListaDeSubDir(VpaDiretorio);
  for VpfLaco := 0 to VpfDiretorios.Count - 1 do
  begin
    result := ExisteRelatorioModulo(VpaModulo,VpfDiretorios.Strings[VpfLaco]);
    if result then
      exit;
  end;
  VpfDiretorios.free;
  VpfArquivos := RetornaListaDeArquivos(VpaDiretorio,'*.rav');
  for VpfLaco := 0 to VpfArquivos.Count - 1 do
  begin
    if RelatorioModulo(VpaModulo,VpfArquivos.Strings[VpfLaco]) then
    begin
      result := true;
      exit;
    end;
  end;
end;

{******************************************************************************}
procedure TImpressaoRelatorio.AdicionaRelatoriosDiretorio(VpaModulo :TRBModulosRelatorio;VpaMenu : TMenuItem;VpaNomDiretorio : String);
var
  VpfLaco : Integer;
  VpfArquivos,VpfDiretorios : TStringList;
  VpfItemMenu: TMenuItem;
begin
  VpfDiretorios := RetornaListaDeSubDir(VpaNomDiretorio);
  for VpfLaco := 0 to VpfDiretorios.Count - 1 do
  begin
    if ExisteRelatorioModulo(VpaModulo,VpfDiretorios.Strings[VpfLaco]) then
    begin
      VpfItemMenu := AdicionarSubItem(VpaMenu, VpfDiretorios.Strings[VpfLaco]);
      AdicionaRelatoriosDiretorio(VpaModulo,VpfItemMenu,VpfDiretorios.Strings[VpfLaco]);
    end;
  end;
  VpfDiretorios.free;
  VpfArquivos := RetornaListaDeArquivos(VpaNomDiretorio,'*.rav');
  for VpfLaco := 0 to VpfArquivos.Count - 1 do
  begin
    if RelatorioModulo(VpaModulo,VpfArquivos.Strings[VpfLaco]) then
    begin
      AdicionarArquivo(VpaMenu,VpfArquivos.Strings[VpfLaco]);
    end;
  end;
  VpfArquivos.free;
end;

{******************************************************************************}
function TImpressaoRelatorio.MenuRaiz(VpaItemAtual: TMenuItem): TMenuItem;
begin
  Result := VpaItemAtual;
  while Result.Parent <> nil do
    Result := Result.Parent;
end;

{ ***** Verifica se ja existe um item de menu com o mesmo identificador ****** }
function TImpressaoRelatorio.IdentificadorRepetido(VpaItemMenu: TMenuItem; VpaIdentificador: string): boolean;
var
  VpfItemAux: TMenuItem;
  VpfLaco: integer;
begin
  Result := false;
  VpfItemAux := VpaItemMenu;
  VpfLaco := 0;
  while (VpfLaco < VpfItemAux.Count) and (not Result) do
  begin
    Result := VpaIdentificador = copy(VpfItemAux.Items[VpfLaco].Caption, 0, 4);
    inc(VpfLaco);
  end;

  VpfLaco := 0;
  while (VpfLaco < VpfItemAux.Count) and (not Result) do
  begin
    if VpfItemAux.Items[VpfLaco].Count > 0 then
      Result := IdentificadorRepetido(VpfItemAux.Items[VpfLaco], VpaIdentificador);
    inc(VpfLaco);
  end;
end;

{ Adiciona um item no menu que corresponde ao diretorio onde esta o relatorio  }
function TImpressaoRelatorio.AdicionarSubItem(VpaItemMenu: TMenuItem; VpaPathDiretorio: string): TMenuItem;
begin
  Result := TMenuItem.Create(VpaItemMenu);
  Result.Caption := copy(VpaPathDiretorio, NPosicao('\', VpaPathDiretorio,ContaLetra(VpaPathDiretorio, '\')) + 1,30);

  VpaItemMenu.Add(Result);
end;

{ *** Seta o evento de impressao para o relatorio conforme sua localização *** }
procedure TImpressaoRelatorio.SetarEventoImpressao(VpaItemMenu: TMenuItem; VpaPathArquivo: string);
var
  VpfDirArquivo, VpfPathExe: string;
begin
  VpfPathExe    := ExtractFilePath(Application.ExeName);
  VpfDirArquivo := ExtractFilePath(VpaPathArquivo);

//  if UpperCase(VpfDirArquivo) = UpperCase((VpfPathExe + 'relatorios\PEDIDO\')) then
    VpaItemMenu.OnClick := ImprimirFiltroPedido;
end;

{ ** Adiciona o relatório contido em "VpaPathArquivo" no menu "VpaItemMenu" ** }
procedure TImpressaoRelatorio.AdicionarArquivo(VpaItemMenu: TMenuItem; VpaPathArquivo: string);
var
  VpfItemMenu: TMenuItem;
  VpfNomeRel, VpfIdentif: string;
begin
  VpfNomeRel := CopiaAteChar(ExtractFileName(VpaPathArquivo), '.');
  VpfIdentif := copy(VpfNomeRel, 1, 4);
//  if not IdentificadorRepetido(MenuRaiz(VpaItemMenu), VpfIdentif) then
  begin
    VpfItemMenu := TMenuItem.Create(VpaItemMenu);
    VpfItemMenu.Caption := DeleteAteChar(VpfNomeRel,'_');
    VpfItemMenu.Hint := VpaPathArquivo;
    SetarEventoImpressao(VpfItemMenu, VpaPathArquivo);

    VpaItemMenu.Add(VpfItemMenu);
  end
 // else
//    aviso('O identificador "' + VpfIdentif + '" esta repetido.');
end;

{ **** Carrega os relatórios contidos em "VpaDiretorio", no "VpaMenuRel" ***** }
procedure TImpressaoRelatorio.CarregarMenuRel(VpaModuloAtual: TRBModulosRelatorio; VpaMenuRel: TMenuItem);
var
  VpfListaDiretorios : TStringList;
  VpfLaco: integer;
  VpfItemMenu: TMenuItem;
  VpfDiretorio : String;
begin
  VpfDiretorio := varia.PathRelatorios;
  if ExisteDiretorio(VpfDiretorio) then
  begin
    VpfListaDiretorios := RetornaListaDeSubDir(VpfDiretorio);

    for VpfLaco := 0 to VpfListaDiretorios.Count -1 do
    begin
      if ExisteRelatorioModulo(VpaModuloAtual,VpfListaDiretorios.Strings[VpfLaco]) then
      begin
        VpfItemMenu := AdicionarSubItem(VpaMenuRel, VpfListaDiretorios.Strings[VpfLaco]);
        AdicionaRelatoriosDiretorio(VpaModuloAtual,VpfItemMenu,VpfListaDiretorios.Strings[VpfLaco]);
      end;
    end;
    VpfListaDiretorios.Free;
  end;
//  else
//    aviso('A pasta de relatórios "' + VpaDiretorio + '", não foi encontrada.');
end;

end.
