unit ASolicitacaoCompraProdutosPendentes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  UnSolicitacaoCompra, UnDados, UnProdutos, Grids, CGrades, ExtCtrls,
  Componentes1, PainelGradiente, StdCtrls, Buttons, ConstMsg, Menus;

type
  TFSolicitacaoCompraProdutosPendentes = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BFechar: TBitBtn;
    BGerarPedido: TBitBtn;
    PopupMenu1: TPopupMenu;
    ConsultaOrcamentoCompra1: TMenuItem;
    BGeraOrcamentoCompra: TBitBtn;
    PanelColor2: TPanelColor;
    EDescricaoTecnica: TMemoColor;
    Grade: TRBStringGridColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BGerarPedidoClick(Sender: TObject);
    procedure ConsultaOrcamentoCompra1Click(Sender: TObject);
    procedure BGeraOrcamentoCompraClick(Sender: TObject);
  private
    VprAcao: Boolean;
    VprListaOrcamentos: TList;
    VprProdutosPendentes: TList;
    VprProdutosFinalizados: TList;
    VprDProdutoPendente: TRBDProdutoPendenteCompra;
    FunSolicitacao: TRBFunSolicitacaoCompra;
    procedure ConfiguraPermissaoUsuario;
    procedure CarTitulosGrade;
    procedure VerificacoesFinais;
    procedure ConsultaOrcamentos;
  public
    function CarregarProdutosPendentes: Boolean;
  end;

var
  FSolicitacaoCompraProdutosPendentes: TFSolicitacaoCompraProdutosPendentes;

implementation

uses
  Constantes, FunObjeto, APrincipal, ANovoPedidoCompra, FunNumeros,
  APedidosCompraAberto, ANovaSolicitacaoCompra, ANovoOrcamentoCompra;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFSolicitacaoCompraProdutosPendentes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  VprListaOrcamentos:= TList.Create;
  VprProdutosPendentes:= TList.Create;
  VprProdutosFinalizados:= TList.Create;
  FunSolicitacao := TRBFunSolicitacaoCompra.Cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;

  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFSolicitacaoCompraProdutosPendentes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VerificacoesFinais;

  FunSolicitacao.Free;

  FreeTObjectsList(VprProdutosPendentes);
  VprProdutosPendentes.Free;

  FreeTObjectsList(VprListaOrcamentos);
  VprListaOrcamentos.Free;

  FreeTObjectsList(VprProdutosFinalizados);
  VprProdutosFinalizados.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFSolicitacaoCompraProdutosPendentes.CarregarProdutosPendentes: Boolean;
begin
  FunSolicitacao.CarregarListaOrcamentos(Varia.CodigoEmpFil, Varia.EstagioOrcamentoCompraAprovado,VprListaOrcamentos);
  FunSolicitacao.AgruparProdutosPendentes(VprListaOrcamentos,VprProdutosPendentes);

  Grade.ADados:= VprProdutosPendentes;
  Grade.CarregaGrade;

  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.ConfiguraPermissaoUsuario;
begin
  if not config.EstoquePorCor then
  begin
    Grade.ColWidths[4] := -1;
    Grade.ColWidths[5] := -1;
    Grade.ColWidths[3] := RetornaInteiro(Grade.ColWidths[3] *1.9);
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.CarTitulosGrade;
begin
  Grade.Cells[2,0]:= 'Código';
  Grade.Cells[3,0]:= 'Produto';
  Grade.Cells[4,0]:= 'Código';
  Grade.Cells[5,0]:= 'Cor';
  Grade.Cells[6,0]:= 'Qtd Utilizada';
  Grade.Cells[7,0]:= 'Qtd Aprovada';
  Grade.Cells[8,0]:= 'UM';
  Grade.Cells[9,0]:= 'Data Aprovação';
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.GradeCellClick(
  Button: TMouseButton; Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VprProdutosPendentes.Count > 0) then
  begin
    if Grade.Cells[1,VpaLinha] = '0' then
    begin
      Grade.Cells[1,VpaLinha]:= '1';
      TRBDProdutoPendenteCompra(VprProdutosPendentes.Items[VpaLinha - 1]).IndMarcado:= True;
    end
    else
    begin
      TRBDProdutoPendenteCompra(VprProdutosPendentes.Items[VpaLinha - 1]).IndMarcado:= False;
      Grade.Cells[1,VpaLinha]:= '0';
    end;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.GradeCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDProdutoPendente:= TRBDProdutoPendenteCompra(VprProdutosPendentes.Items[VpaLinha-1]);
  if VprDProdutoPendente.IndMarcado then
    Grade.Cells[1,VpaLinha]:= '1'
  else
    Grade.Cells[1,VpaLinha]:= '0';
  Grade.Cells[2,VpaLinha]:= VprDProdutoPendente.CodProduto;
  Grade.Cells[3,VpaLinha]:= VprDProdutoPendente.NomProduto;
  if VprDProdutoPendente.CodCor <> 0 then
    Grade.Cells[4,VpaLinha]:= IntToStr(VprDProdutoPendente.CodCor)
  else
    Grade.Cells[4,VpaLinha]:= '';
  Grade.Cells[5,VpaLinha]:= VprDProdutoPendente.NomCor;
  if VprDProdutoPendente.QtdUtilizada <> 0 then
    Grade.Cells[6,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPendente.QtdUtilizada - VprDProdutoPendente.QtdComprada )
  else
    Grade.Cells[6,VpaLinha]:= '';
  if VprDProdutoPendente.QtdAprovada <> 0 then
    Grade.Cells[7,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPendente.QtdAprovada - VprDProdutoPendente.QtdComprada)
  else
    Grade.Cells[7,VpaLinha]:= '';
  Grade.Cells[8,VpaLinha]:= VprDProdutoPendente.DesUM;
  Grade.Cells[9,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDProdutoPendente.DatAprovacao);
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.GradeMudouLinha(
  Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprProdutosPendentes.Count > 0 then
  begin
    VprDProdutoPendente:= TRBDProdutoPendenteCompra(VprProdutosPendentes.Items[VpaLinhaAtual-1]);
    EDescricaoTecnica.Lines.Text := VprDProdutoPendente.DesTecnica;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.BGerarPedidoClick(Sender: TObject);
var
  VpfProdutosPedido, VpfFracoesOP : TList;
begin
  VpfProdutosPedido:= TList.Create;
  VpfFracoesOP :=  TList.Create;

  FunSolicitacao.CarProdutosSelecionados(VprProdutosPendentes,VpfProdutosPedido,VprProdutosFinalizados,VpfFracoesOP,false);

  if VpfProdutosPedido.Count > 0 then
  begin
    FNovoPedidoCompra:= TFNovoPedidoCompra.criarSDI(Application,'',True);
    if FNovoPedidoCompra.NovoPedidoProdutosPendentes(VpfProdutosPedido,VpfFracoesOP,VprProdutosPendentes,VprProdutosFinalizados) then
    begin
      VprAcao:= True;
      Grade.CarregaGrade;
    end;
    FNovoPedidoCompra.Free;
  end;
  FreeTObjectsList(VpfProdutosPedido);
  VpfFracoesOP.free;
  VpfProdutosPedido.Free;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.VerificacoesFinais;
var
  VpfResultado: String;
begin
  VpfResultado:= FunSolicitacao.GravaVinculoPedidoOrcamento(VprProdutosFinalizados);
  if VpfResultado = '' then
  begin
    VpfResultado:= FunSolicitacao.AtualizarEstagioOrcamentosFinalizados(VprProdutosFinalizados);
    if VpfResultado = '' then
      VpfResultado := FunSolicitacao.AtualizarQtdCompradaProdutosPendentes(VprProdutosPendentes);
  end;


  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.ConsultaOrcamentos;
var
  VpfLaco : Integer;
  VpfDSolicitacaoCompra : TRBDSolicitacaoCompraCorpo;
begin
  for VpfLaco := 0 to VprDProdutoPendente.OrcamentosCompra.Count - 1 do
  begin
    VpfDSolicitacaoCompra := TRBDSolicitacaoCompraCorpo(VprDProdutoPendente.OrcamentosCompra.Items[VpfLaco]);
    FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
    FNovaSolicitacaoCompras.Consultar(VpfDSolicitacaoCompra.CodFilial,VpfDSolicitacaoCompra.SeqSolicitacao);
    FNovaSolicitacaoCompras.free;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.ConsultaOrcamentoCompra1Click(
  Sender: TObject);
begin
  if VprProdutosPendentes.Count > 0 then
  begin
    ConsultaOrcamentos;
  end

end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.BGeraOrcamentoCompraClick(
  Sender: TObject);
var
  VpfProdutosPedido, VpfFracoesOP : TList;
begin
  VpfProdutosPedido:= TList.Create;
  VpfFracoesOP :=  TList.Create;

  FunSolicitacao.CarProdutosSelecionados(VprProdutosPendentes,VpfProdutosPedido,VprProdutosFinalizados,VpfFracoesOP,true);

  if VpfProdutosPedido.Count > 0 then
  begin
    FNovoOrcamentoCompra:= TFNovoOrcamentoCompra.criarSDI(Application,'',True);
    if FNovoOrcamentoCompra.NovoOrcamentoProdutosPendentes(VpfProdutosPedido,VpfFracoesOP,VprProdutosPendentes,VprProdutosFinalizados) then
    begin
      VprAcao:= True;
      Grade.CarregaGrade;
    end;
    FNovoOrcamentoCompra.Free;
  end;
  FreeTObjectsList(VpfProdutosPedido);
  VpfFracoesOP.free;
  VpfProdutosPedido.Free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFSolicitacaoCompraProdutosPendentes]);
end.
