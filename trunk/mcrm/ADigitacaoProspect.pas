unit ADigitacaoProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, StdCtrls,
  Localizacao, Buttons, UnDados, UnDadosLocaliza, UnClientes, UnProspect,
  DBKeyViolation;

type
  TFDigitacaoProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    PanelColor2: TPanelColor;
    ECodVendedor: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ECliente: TRBEditLocaliza;
    ERamoAtividade: TRBEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    EUF: TRBEditLocaliza;
    ESuspect: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure ERamoAtividadeRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EClienteRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure ECodVendedorChange(Sender: TObject);
    procedure EUFRetorno(VpaColunas: TRBColunasLocaliza);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure ESuspectRetorno(VpaColunas: TRBColunasLocaliza);
  private
    { Private declarations }
    VprDDigiProspects : TRBDDigitacaoProspect;
    VprDProspect : TRBDDigitacaoProspectItem;
    VprDCliente : TRBDCliente;
    VprDSuspect : TRBDProspect;
    VprUltimaCidade,
    VprUltimoUF : string;
    VprUltimaData : TDateTime;
    procedure VerificaVariaveis;
    procedure CarTitulosGrade;
    procedure InicializaTela;
    procedure CarDGradeClasse;
  public
    { Public declarations }
    function CadastraProspect : Boolean;
  end;

var
  FDigitacaoProspect: TFDigitacaoProspect;

implementation

uses APrincipal, Constantes, FunData, FunString, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDigitacaoProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VerificaVariaveis;
  VprDDigiProspects := TRBDDigitacaoProspect.cria;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDigitacaoProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDDigiProspects.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFDigitacaoProspect.VerificaVariaveis;
begin
  if Varia.CodMeioDivulgacaoVisitaVendedor = 0 then
    aviso('MEIO DIVULGAÇÃO VISITA VENDEDOR NÃO PREENCHIDO!!!'#13'É necessário preencher nas configurações gerais do sistema, na página CRM o meio de divulgação da visita do vendedor.');
  if varia.SeqCampanhaTelemarketing = 0 then
    aviso('CAMPANHA PADRÃO DE VENDAS NÃO PREENCHIDO!!!'#13'É necessário preencher nas configurações da empresa, na página TELEMARKETING a campanha padrão.');
  if varia.CodHistoricoLigacaoVisitaVendedor = 0 then
    aviso('HISTORICO LIGAÇÃO VISITA VENDEDOR NÃO PREENCHIDO!!!'#13'É necessário preencher nas configurações gerais do sistema, na página CRM o histórigo ligação da visita do vendedor.');
end;

{******************************************************************************}
procedure TFDigitacaoProspect.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Data';
  Grade.Cells[2,0] := 'Tipo';
  Grade.Cells[3,0] := 'Prospect';
  Grade.Cells[4,0] := 'Endereço';
  Grade.Cells[5,0] := 'Bairro';
  Grade.Cells[6,0] := 'Cidade';
  Grade.Cells[7,0] := 'UF';
  Grade.Cells[8,0] := 'Contato';
  Grade.Cells[9,0] := 'e-mail';
  Grade.Cells[10,0] := 'Ramo Atividade';
  Grade.Cells[11,0] := 'Fone 1';
  Grade.Cells[12,0] := 'Fone 2';
  Grade.Cells[13,0] := 'Histórico';
end;

{******************************************************************************}
procedure TFDigitacaoProspect.InicializaTela;
begin
  ECodVendedor.AInteiro := Varia.CodVendedor;
  ECodVendedor.Atualiza;
  if ECodVendedor.AInteiro <> 0 then
    ActiveControl := Grade
  else
    ActiveControl := ECodVendedor;
  Grade.ADados := VprDDigiProspects.Prospects;
  Grade.CarregaGrade;
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.CarDGradeClasse;
begin
  VprDProspect.DatVisita := StrToDate(Grade.Cells[1,Grade.ALinha]);
  VprDProspect.DesTipo := UpperCase(Grade.Cells[2,Grade.ALinha]);
  if VprDProspect.CodProspect = 0 then
  begin
    VprDProspect.NomProspect := UpperCase(RetiraAcentuacao(Grade.Cells[3,Grade.ALinha]));
    VprDProspect.DesEndereco := UpperCase(RetiraAcentuacao(Grade.Cells[4,Grade.ALinha]));
    VprDProspect.DesBairro := UpperCase(RetiraAcentuacao(Grade.Cells[5,Grade.ALinha]));
    VprDProspect.DesCidade := UpperCase(RetiraAcentuacao(Grade.Cells[6,Grade.ALinha]));
    VprDProspect.DesUF := UpperCase(RetiraAcentuacao(Grade.Cells[7,Grade.ALinha]));
    VprDProspect.NomContato := UpperCase(RetiraAcentuacao(Grade.Cells[8,Grade.ALinha]));
    VprDProspect.DesEmail := UpperCase(RetiraAcentuacao(Grade.Cells[9,Grade.ALinha]));
    VprDProspect.DesFone := UpperCase(RetiraAcentuacao(Grade.Cells[11,Grade.ALinha]));
    VprDProspect.DesFone2 := UpperCase(RetiraAcentuacao(Grade.Cells[12,Grade.ALinha]));
  end;
  VprDProspect.DesHistorico := UpperCase(RetiraAcentuacao(Grade.Cells[13,Grade.ALinha]));
  VprUltimaCidade := UpperCase(RetiraAcentuacao(VprDProspect.DesCidade));
  VprUltimaData := VprDProspect.DatVisita;
  VprUltimoUF := UpperCase(RetiraAcentuacao(VprDProspect.DesUF));
end;

{******************************************************************************}
function TFDigitacaoProspect.CadastraProspect : Boolean;
begin
  InicializaTela;
  ShowModal;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProspect := TRBDDigitacaoProspectItem(VprDDigiProspects.Prospects.Items[VpaLinha-1]);
  if VprDProspect.DatVisita > montadata(1,1,1900) then
    Grade.Cells[1,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDProspect.DatVisita)
  else
    Grade.Cells[1,VpaLinha] := '';
  Grade.Cells[2,VpaLinha] := VprDProspect.DesTipo;
  Grade.Cells[3,VpaLinha] := VprDProspect.NomProspect;
  Grade.Cells[4,VpaLinha] := VprDProspect.DesEndereco;
  Grade.Cells[5,VpaLinha] := VprDProspect.DesBairro;
  Grade.Cells[6,VpaLinha] := VprDProspect.DesCidade;
  Grade.Cells[7,VpaLinha] := VprDProspect.DesUF;
  Grade.Cells[8,VpaLinha] := VprDProspect.NomContato;
  Grade.Cells[9,VpaLinha] := VprDProspect.DesEmail;
  Grade.Cells[10,VpaLinha] := VprDProspect.NomRamoAtividade;
  Grade.Cells[11,VpaLinha] := VprDProspect.DesFone;
  Grade.Cells[12,VpaLinha] := VprDProspect.DesFone2;
  Grade.Cells[13,VpaLinha] := VprDProspect.DesHistorico;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if DeletaChars(DeletaChars(Grade.Cells[1,Grade.ALinha],'/'),' ') = '' then
  begin
    Grade.col := 1;
    aviso('DATA DA VISITA INVÁLIDA!!!'#13'É necessário digitar a data da visita.');
    VpaValidos := false;
  end
  else
    if (Grade.Cells[2,Grade.ALinha] <> 'P')and
       (Grade.Cells[2,Grade.ALinha] <> 'S') then
    begin
      Grade.col := 2;
      aviso('TIPO CADASTRO INVÁLIDO!!!'#13'É necessário digitar o tipo do cadastro :'#13'P - PROSPECT'#13'S - SUSPECT');
      VpaValidos := false;
    end
    else
      if DeletaChars(Grade.Cells[3,Grade.ALinha],' ') = '' then
      begin
        Grade.col := 3;
        aviso('PROSPECT INVÁLIDO!!!'#13'É necessário digitar o nome do prospect.');
        VpaValidos := false;
      end
      else
        if not EUF.AExisteCodigo(Grade.Cells[7,Grade.ALinha]) then
        begin
          Grade.col := 7;
          aviso('UF INVÁLIDA!!!'#13'É necessário digitar uma UF válida.');
          VpaValidos := false;
        end
        else
          if DeletaChars(Grade.Cells[12,Grade.ALinha],' ') = '' then
          begin
            Grade.col := 12;
            aviso('HISTORICO INVÁLIDO!!!'#13'É necessário digitar o histórico do prospect.');
            VpaValidos := false;
          end
          else
            begin
              try
                StrToDate(Grade.Cells[1,Grade.ALinha]);
              except
                Grade.col := 1;
                VpaValidos := false;
                aviso('DATA DA VISITA INVÁLIDA!!!'#13'Foi preenchida um valor inválido para a data de visita.');
              end;
            end;
  if VpaValidos then
  begin
    CarDGradeClasse;
  end;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1 :  Value := '!99/00/0000;1;_';
    11,12 : Value := '!\(00\)>#000-0000;1; ';
  end;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114: case Grade.AColuna of
           3 : begin
                 if (Grade.Cells[2,Grade.ALinha] = 'P')then
                   ECliente.AAbreLocalizacao
                 else
                   if (Grade.Cells[2,Grade.ALinha] = 'S')then
                     ESuspect.AAbreLocalizacao;
               end;
           9 : ERamoAtividade.AAbreLocalizacao;
         end;
  end;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDDigiProspects.Prospects.Count > 0 then
  begin
    VprDProspect:= TRBDDigitacaoProspectItem(VprDDigiProspects.Prospects.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.ERamoAtividadeRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  Grade.cells[10,Grade.ALinha] := VpaColunas[1].AValorRetorno;
  IF VpaColunas[0].AValorRetorno <> '' then
    VprDProspect.CodRamoAtividade := StrToInt(VpaColunas[0].AValorRetorno)
  else
    VprDProspect.CodRamoAtividade := 0;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.EClienteRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas[0].AValorRetorno <> '' then
  begin
    VprDCliente.free;
    VprDCliente := TRBDCliente.cria;
    VprDCliente.CodCliente := StrToInt(VpaColunas[0].AValorRetorno);
    VprDProspect.CodProspect := VprDCliente.CodCliente;
    FunClientes.CarDCliente(VprDCliente);
    Grade.Cells[3,Grade.ALinha] := VprDCliente.NomFantasia;
    Grade.Cells[4,Grade.ALinha] := VprDCliente.DesEndereco;
    Grade.Cells[5,Grade.ALinha] := VprDCliente.DesBairro;
    Grade.Cells[6,Grade.ALinha] := VprDCliente.DesCidade;
    Grade.Cells[7,Grade.ALinha] := VprDCliente.DesUF;
    Grade.Cells[8,Grade.ALinha] := VprDCliente.NomContato;
    Grade.Cells[9,Grade.ALinha] := VprDCliente.DesEmail;
    Grade.Cells[11,Grade.ALinha] := VprDCliente.DesFone1;
    Grade.Cells[12,Grade.ALinha] := VprDCliente.DesFone2;
    VprDProspect.NomProspect := VprDCliente.NomFantasia;
    VprDProspect.DesEndereco := VprDCliente.DesEndereco;
    VprDProspect.DesBairro := VprDCliente.DesBairro;
    VprDProspect.DesCidade := VprDCliente.DesCidade;
    VprDProspect.DesUF := VprDCliente.DesUF;
    VprDProspect.NomContato := VprDCliente.NomContato;
    VprDProspect.DesFone := VprDCliente.DesFone1;
  end
  else
  begin
    if VprDProspect.CodProspect <> 0 then
    begin
      Grade.Cells[3,Grade.ALinha] := '';
      Grade.Cells[4,Grade.ALinha] := '';
      Grade.Cells[5,Grade.ALinha] := '';
      Grade.Cells[6,Grade.ALinha] := '';
      Grade.Cells[7,Grade.ALinha] := '';
      Grade.Cells[8,Grade.ALinha] := '';
      Grade.Cells[9,Grade.ALinha] := '';
      Grade.Cells[11,Grade.ALinha] := '';
      Grade.Cells[12,Grade.ALinha] := '';
      VprDProspect.CodProspect := 0;
    end;
  end;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.GradeNovaLinha(Sender: TObject);
begin
  VprDProspect := VprDDigiProspects.AddProspectItem;
  VprDProspect.DesTipo := 'P';
  VprDProspect.DesCidade := VprUltimaCidade;
  VprDProspect.DesUF := VprUltimoUF;
  VprDProspect.DatVisita := VprUltimaData;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egEdicao, egInsercao] then
  begin
    if Grade.AColuna <> ACol then
    begin
      case Grade.Acoluna of
        2: begin
             if (Grade.Cells[2,Grade.ALinha] <> 'P') AND
                (Grade.Cells[2,Grade.ALinha] <> 'S') then
             begin
               Grade.col := 2;
               aviso('TIPO CADASTRO INVÁLIDO!!!'#13'É necessário digitar o tipo do cadastro :'#13'P - PROSPECT'#13'S - SUSPECT');
               abort;
             end
           end;
        7: begin
             if not EUF.AExisteCodigo(Grade.Cells[7,Grade.ALinha]) then
               EUF.AAbreLocalizacao;
           end;
      end;
      case Acol of
        3: begin
             if (Grade.Cells[2,Grade.ALinha] = 'P')then
               ECliente.AAbreLocalizacao
             else
               if (Grade.Cells[2,Grade.ALinha] = 'S')then
                 ESuspect.AAbreLocalizacao;
           end;
       10: if VprDProspect.CodProspect = 0 then
             ERamoAtividade.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VprDDigiProspects.CodVendedor := ECodVendedor.AInteiro;
  VpfREsultado := FunClientes.GravaDDigitacaoProspect(VprDDigiProspects);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    close;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.ECodVendedorChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.EUFRetorno(VpaColunas: TRBColunasLocaliza);
begin
  Grade.cells[7,Grade.ALinha] := VpaColunas[0].AValorRetorno;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.GradeKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Grade.AColuna of
    2 : key := UpCase(key);
  end;
  if VprDProspect.CodProspect <> 0 then
    case Grade.AColuna of
      3,4,5,6,7 : key := #0;
    end;
end;

{******************************************************************************}
procedure TFDigitacaoProspect.ESuspectRetorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas[0].AValorRetorno <> '' then
  begin
    VprDSuspect.free;
    VprDSuspect := TRBDProspect.cria;
    FunProspect.CarDProspect(VprDSuspect,StrToInt(VpaColunas[0].AValorRetorno));
    VprDProspect.CodProspect := VprDSuspect.CodProspect;
    Grade.Cells[3,Grade.ALinha] := VprDSuspect.NomFantasia;
    Grade.Cells[4,Grade.ALinha] := VprDSuspect.DesEndereco;
    Grade.Cells[5,Grade.ALinha] := VprDSuspect.DesBairro;
    Grade.Cells[6,Grade.ALinha] := VprDSuspect.DesCidade;
    Grade.Cells[7,Grade.ALinha] := VprDSuspect.DesUF;
    Grade.Cells[8,Grade.ALinha] := VprDSuspect.NomContato;
    Grade.Cells[9,Grade.ALinha] := VprDSuspect.DesEmail;
    Grade.Cells[11,Grade.ALinha] := VprDSuspect.DesFone1;
    Grade.Cells[12,Grade.ALinha] := VprDSuspect.DesFone2;
    VprDProspect.NomProspect := VprDSuspect.NomFantasia;
    VprDProspect.DesEndereco := VprDSuspect.DesEndereco;
    VprDProspect.DesBairro := VprDSuspect.DesBairro;
    VprDProspect.DesCidade := VprDSuspect.DesCidade;
    VprDProspect.DesUF := VprDSuspect.DesUF;
    VprDProspect.NomContato := VprDSuspect.NomContato;
    VprDProspect.DesFone := VprDSuspect.DesFone1;
  end
  else
  begin
    if VprDProspect.CodProspect <> 0 then
    begin
      Grade.Cells[3,Grade.ALinha] := '';
      Grade.Cells[4,Grade.ALinha] := '';
      Grade.Cells[5,Grade.ALinha] := '';
      Grade.Cells[6,Grade.ALinha] := '';
      Grade.Cells[7,Grade.ALinha] := '';
      Grade.Cells[8,Grade.ALinha] := '';
      Grade.Cells[9,Grade.ALinha] := '';
      Grade.Cells[11,Grade.ALinha] := '';
      Grade.Cells[12,Grade.ALinha] := '';
      VprDProspect.CodProspect := 0;
    end;
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFDigitacaoProspect]);
end.
