unit AChequesOO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, unDadosCR, unDados,
  StdCtrls, Buttons, Mask, numericos, Localizacao, UnDadosLocaliza;

type
  TFChequesOO = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    EFormaPagamento: TEditLocaliza;
    Localiza: TConsultaPadrao;
    EContaCaixa: TEditLocaliza;
    PanelColor4: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    EValParcela: Tnumerico;
    EValCheques: Tnumerico;
    EBanco: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure EFormaPagamentoRetorno(Retorno1, Retorno2: String);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GradeDepoisExclusao(Sender: TObject);
    procedure EFormaPagamentoChange(Sender: TObject);
    procedure EContaCaixaRetorno(Retorno1, Retorno2: String);
    procedure EBancoRetorno(VpaColunas: TRBColunasLocaliza);
  private
    { Private declarations }
    VprAcao,
    VprCadastrandoChequeAvulso : Boolean;
    VprNomCliente : String;
    VprCodFormaPagamentoAnterior : Integer;
    VprDBaixa : TRBDBaixaCR;
    VprDCheque : TRBDCheque;
    function ExisteFormaPagamento : Boolean;
    function ExisteContaCorrente : Boolean;
    procedure CarTitulosGrade;
    procedure CarDChequeClasse;
  public
    { Public declarations }
    function CadastraCheques(VpaDBaixa : TRBDBaixaCR) : boolean;
    procedure ConsultaCheques(VpaCheques : TList);
    function CadastraChequesAvulso : Boolean;
  end;

var
  FChequesOO: TFChequesOO;

implementation

uses APrincipal,Constantes, funData, funString,ConstMsg, unContasAReceber,
  AFormasPagamento, unClientes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFChequesOO.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  VprCadastrandoChequeAvulso := false;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFChequesOO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFChequesOO.ExisteFormaPagamento : Boolean;
begin
  result := false;
  if Grade.Cells[2,Grade.ALinha] <> '' then
  begin
    if StrToInt(Grade.Cells[2,Grade.ALinha]) = VprCodFormaPagamentoAnterior then
    result := true
    else
    begin
      result := FunContasAReceber.ExisteFormaPagamento(StrToInt(Grade.Cells[2,Grade.ALinha]));
      if result then
      begin
        EFormaPagamento.Text := Grade.Cells[2,Grade.ALinha];
        EFormaPagamento.Atualiza;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFChequesOO.ExisteContaCorrente : Boolean;
begin
  result := false;
  if Grade.Cells[8,Grade.ALinha] <> '' then
  begin
    result := FunContasAReceber.ExisteContaCorrente(Grade.Cells[8,Grade.ALinha]);
    if result then
    begin
      EContaCaixa.Text := Grade.Cells[8,Grade.ALinha];
      EContaCaixa.Atualiza;
    end;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Banco';
  Grade.Cells[2,0] := 'Código';
  Grade.Cells[3,0] := 'Forma Pagamento';
  Grade.Cells[4,0] := 'Valor';
  Grade.Cells[5,0] := 'Emitente';
  Grade.Cells[6,0] := 'Nro Cheque';
  Grade.Cells[7,0] := 'Vencimento';
  Grade.Cells[8,0] := 'Conta Caixa';
  Grade.Cells[9,0] := 'Descrição';
end;

{******************************************************************************}
procedure TFChequesOO.CarDChequeClasse;
begin
  if Grade.Cells[1,Grade.ALinha] <> '' then
    VprDCheque.CodBanco := StrToInt(Grade.Cells[1,Grade.ALinha])
  else
    VprDCheque.CodBanco := 0;
  if Grade.Cells[2,Grade.ALinha] <> '' then
    VprDCheque.CodFormaPagamento := StrToInt(Grade.Cells[2,Grade.ALinha])
  else
    VprDCheque.CodFormaPagamento := 0;
  VprDCheque.ValCheque := StrToFloat(DeletaChars(Grade.Cells[4,Grade.ALinha],'.'));
  VprDCheque.NomEmitente := Grade.Cells[5,Grade.alinha];
  if Grade.Cells[6,Grade.ALinha] <> '' then
    VprDCheque.NumCheque := StrToInt(Grade.Cells[6,Grade.ALinha])
  else
    VprDCheque.NumCheque := 0;
  try
    VprDCheque.DatVencimento := StrToDate(Grade.Cells[7,Grade.ALinha])
  except
    VprDCheque.DatVencimento :=  MontaData(1,1,1900);
  end;
  VprDCheque.NumContaCaixa := Grade.Cells[8,Grade.ALinha];
  VprDCheque.CodUsuario := varia.CodigoUsuario;
  VprDCheque.DatCadastro := now;
end;


{******************************************************************************}
function TFChequesOO.CadastraCheques(VpaDBaixa : TRBDBaixaCR) : boolean;
begin
  VprDBaixa := VpaDBaixa;
  VprDBaixa.Cheques := VpaDBaixa.Cheques;
  Grade.ADados := VprDBaixa.Cheques;
  Grade.CarregaGrade;
  EValParcela.AValor := VpaDBaixa.ValorPago;
  if VpaDBaixa.Parcelas.Count > 0 then
    VprNomCliente := FunClientes.RNomCliente(InttoStr(TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[0]).CodCliente));
  EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFChequesOO.ConsultaCheques(VpaCheques : TList);
begin
  VprDBaixa := TRBDBaixaCR.cria;
  VprDBaixa.Cheques := VpaCheques;
  Grade.ADados := VpaCheques;
  Grade.CarregaGrade;
  show;
end;

{******************************************************************************}
function TFChequesOO.CadastraChequesAvulso : Boolean;
begin
  VprCadastrandoChequeAvulso := true;
  VprDBaixa := TRBDBaixaCR.Cria;
  Grade.ADados := VprDBaixa.Cheques;
  Grade.CarregaGrade;
  EValParcela.AValor := VprDBaixa.ValorPago;
  EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);
  showmodal;
  FunContasAReceber.GravaDCheques(VprDBaixa.Cheques);
  result := VprAcao;
end;

{******************************************************************************}
procedure TFChequesOO.BGravarClick(Sender: TObject);
var
  VpfValoresOk : Boolean;
begin
  VpfValoresOk := true;
  if not VprCadastrandoChequeAvulso then
    if EValParcela.AValor <> EValCheques.AValor then
      VpfValoresOk := confirmacao('VALORES DIFERENTES!!!'#13'O Valor da parcela é diferente da somatória dos cheques. Tem certeza que deseja continuar?');
  if VpfValoresOk then
  begin
    VprAcao := true;
    Close;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFChequesOO.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCheque := TRBDCheque(VprDBaixa.Cheques.Items[VpaLinha-1]);
  if VprDCheque.CodBanco <> 0 then
    Grade.Cells[1,VpaLinha] := IntToStr(VprDCheque.CodBanco)
  else
    Grade.Cells[1,VpaLinha] := '';
  if VprDCheque.CodFormaPagamento <> 0 then
    Grade.Cells[2,VpaLinha] := IntToStr(VprDCheque.CodFormaPagamento)
  else
    Grade.Cells[2,VpaLinha] := '';
  Grade.Cells[3,VpaLinha] := VprDCheque.NomFormaPagamento;
  Grade.Cells[4,VpaLinha] := FormatFloat(varia.MascaraValor,VprDCheque.ValCheque);
  Grade.Cells[5,VpaLinha] := VprDCheque.NomEmitente;
  if VprDCheque.NumCheque <> 0 then
    Grade.cells[6,VpaLinha] := IntToStr(VprDCheque.NumCheque)
  else
    Grade.cells[6,VpaLinha] := '';
  if VprDCheque.DatVencimento > MontaData(1,1,1900) then
    Grade.Cells[7,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDCheque.DatVencimento)
  else
    Grade.Cells[7,VpaLinha] := '';
  Grade.cells[8,VpaLinha] := VprDCheque.NumContaCaixa;
  Grade.cells[9,VpaLinha] := VprDCheque.NomContaCaixa;
end;

{******************************************************************************}
procedure TFChequesOO.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ExisteFormaPagamento then
  begin
    aviso('FORMA DE PAGAMENTO INVÁLIDA!!!'#13'A forma de pagamento digitada não é valida ou não foi preechida.');
    Vpavalidos := false;
    Grade.Col := 2;
  end
  else
    if Grade.Cells[4,Grade.ALinha] = '' then
    begin
      aviso('VALOR NÃO PREENCHIDO!!!'#13'É necessário preencher o valor.');
      Vpavalidos := false;
      Grade.Col := 4;
    end
    else
      if not ExisteContaCorrente  then
      begin
        aviso('CONTA CAIXA INVALIDA!!!'#13'A conta caixa digitada não é válida ou não foi preenchida.');
        Vpavalidos := false;
        Grade.Col := 8;
      end;
  if VpaValidos then
  begin
    CarDChequeClasse;
    if VprDCheque.DatVencimento <= MontaData(1,1,1900) then
    begin
      aviso('VENCIMENTO INVÁLIDO!!!'#13'A data de vencimento preenchida é inválida.');
      Vpavalidos := false;
      Grade.Col := 7;
    end
    else
      if VprDCheque.ValCheque = 0  then
      begin
        aviso('VALOR INVÁLIDO!!!'#13'O valor preenchido é inválido.');
        Vpavalidos := false;
        Grade.Col := 4;
      end
  end;
  if VpaValidos then
  begin
    if (VprDCheque.TipFormaPagamento = 'C') or (VprDCheque.TipFormaPagamento = 'R')then //cheque, cheque de terceiro
    begin
      if VprDCheque.CodBanco = 0 then
      begin
        aviso('CÓDIGO DO BANCO NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo do banco quando a forma de pagamento é cheque.');
        Grade.Col := 1;
        VpaValidos := false;
      end
      else
        if VprDCheque.NomEmitente = '' then
        begin
          aviso('NOME DO EMITENTE NÃO PREENCHIDO!!!'#13'É necessário preencher o nome do emitente quando a forma de pagamento é cheque.');
          Grade.Col := 5;
          VpaValidos := false;
        end
        else
          if VprDCheque.NumCheque = 0 then
          begin
            aviso('NÚMERO DO CHEQUE NÃO PREENCHIDO!!!'#13'É necessário preencher o numero do cheque quando a forma de pagamento é cheque.');
            Grade.Col := 6;
            VpaValidos := false;
          end
    end;
  end;

  if VpaValidos then
    EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);
end;

{******************************************************************************}
procedure TFChequesOO.GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: String);
begin
  case acol of
    1 : Value := '000;0; ';
    2 : Value := '000000;0; ';
    6 : Value := '000000000;0; ';
    7 : Value := FPrincipal.CorFoco.AMascaraData;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case  Key of
    114 :
        begin
          case Grade.Col of
            1 : EBanco.AAbreLocalizacao;
            2 : EFormaPagamento.AAbreLocalizacao;
            8 : EContaCaixa.AAbreLocalizacao;
          end;
        end;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  case Grade.Col of
    3,9 : key := #0;
  end;
  if (key = '.') and  (Grade.col in [4]) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFChequesOO.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDBaixa.Cheques.Count > 0 then
  begin
    VprDCheque := TRBDCheque(VprDBaixa.Cheques.Items[VpaLinhaAtual -1]);
    VprCodFormaPagamentoAnterior := VprDCheque.CodFormaPagamento;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.GradeNovaLinha(Sender: TObject);
begin
  VprDCheque := VprDBaixa.AddCheque;
  VprDCheque.TipCheque := 'C';
  EContaCaixa.Text := VprDBaixa.NumContaCaixa;
  EContaCaixa.Atualiza;
  VprDCheque.CodFormaPagamento := VprDBaixa.CodFormaPAgamento;
  EFormaPagamento.AInteiro := VprDBaixa.CodFormaPAgamento;
  EFormaPagamento.Atualiza;
  if not VprCadastrandoChequeAvulso then
    VprDCheque.ValCheque := VprDBaixa.ValorPago - EValCheques.AValor;
  VprDCheque.DatVencimento := VprDBaixa.DatPagamento;

  EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);
end;

{******************************************************************************}
procedure TFChequesOO.EFormaPagamentoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[2,Grade.ALinha] := EFormaPagamento.Text;
    Grade.cells[3,grade.ALinha] := Retorno1;
    VprDCheque.TipFormaPagamento := Retorno2;
    VprDCheque.CodFormaPagamento := EFormaPagamento.AInteiro;
    VprDCheque.NomFormaPagamento := Retorno1;
    VprCodFormaPagamentoAnterior := VprDCheque.CodFormaPagamento;
    if VprDCheque.TipFormaPagamento = 'C' then
    begin
      VprDCheque.NomEmitente := VprNomCliente;
      Grade.Cells[5,Grade.ALinha] := VprNomCliente;
    end;
  end
  else
  begin
    Grade.Cells[2,Grade.ALinha] := '';
    Grade.Cells[3,Grade.ALinha] := '';
    VprDCheque.CodFormaPagamento :=0;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        2 :if not ExisteFormaPagamento then
           begin
             if not EFormaPagamento.AAbreLocalizacao then
             begin
               Grade.Cells[2,Grade.ALinha] := '';
               abort;
             end;
           end;
        8 :if not ExisteContaCorrente then
           begin
             if not EContaCaixa.AAbreLocalizacao then
              begin
                Grade.Cells[8,Grade.ALinha]:='';
                abort;
              end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFChequesOO.GradeDepoisExclusao(Sender: TObject);
begin
  EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);
end;

{******************************************************************************}
procedure TFChequesOO.EFormaPagamentoChange(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.showmodal;
  FFormasPagamento.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFChequesOO.EContaCaixaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[8,Grade.ALinha] := EContaCaixa.Text;
    Grade.cells[9,grade.ALinha] := Retorno1;
    VprDCheque.NumContaCaixa := EContaCaixa.Text;
    VprDCheque.NomContaCaixa := Retorno1;
    VprDCheque.TipContaCaixa := Retorno2;
  end
  else
  begin
    Grade.Cells[8,Grade.ALinha] := '';
    Grade.Cells[9,Grade.ALinha] := '';
    VprDCheque.NumContaCaixa :='';
  end;

end;

{******************************************************************************}
procedure TFChequesOO.EBancoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  Grade.Cells[1,Grade.ALinha] := VpaColunas[0].AValorRetorno;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFChequesOO]);
end.
