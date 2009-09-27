unit ABaixaConsumoProduto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Grids,
  CGrades, UnDadosProduto, Localizacao, UnOrdemProducao, UnDados, UnArgox,Constantes,
  DBKeyViolation;

type
  TFBaixaConsumoProduto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    ECor: TEditLocaliza;
    Localiza: TConsultaPadrao;
    PanelColor3: TPanelColor;
    Label2: TLabel;
    SFilial: TSpeedButton;
    Label3: TLabel;
    Label1: TLabel;
    SOP: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    SFracao: TSpeedButton;
    Label6: TLabel;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    PanelColor4: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    PanelColor5: TPanelColor;
    CMarcarTodos: TCheckBox;
    Label9: TLabel;
    SpeedButton5: TSpeedButton;
    Label10: TLabel;
    Label14: TLabel;
    SIdEstagio: TSpeedButton;
    Label15: TLabel;
    EEstagio: TEditLocaliza;
    EIDEstagio: TEditLocaliza;
    PanelColor6: TPanelColor;
    Grade: TRBStringGridColor;
    PanelColor7: TPanelColor;
    Label7: TLabel;
    PanelColor8: TPanelColor;
    GOrdemCorte: TRBStringGridColor;
    PanelColor9: TPanelColor;
    Label8: TLabel;
    ECorOC: TEditLocaliza;
    BOrcamentoCompra: TBitBtn;
    EQtdFracao: TEditColor;
    Label11: TLabel;
    BEtiqueta: TBitBtn;
    Label12: TLabel;
    SpeedButton6: TSpeedButton;
    Label13: TLabel;
    EUsuario: TEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BFecharClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure GradeCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure CMarcarTodosClick(Sender: TObject);
    procedure GradeGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure EFracaoRetorno(Retorno1, Retorno2: String);
    procedure EIDEstagioSelect(Sender: TObject);
    procedure GOrdemCorteCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GOrdemCorteCellClick(Button: TMouseButton;
      Shift: TShiftState; VpaColuna, VpaLinha: Integer);
    procedure GOrdemCorteDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GOrdemCorteGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GOrdemCorteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorOCRetorno(Retorno1, Retorno2: String);
    procedure GOrdemCorteMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GOrdemCorteNovaLinha(Sender: TObject);
    procedure GOrdemCorteSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BOrcamentoCompraClick(Sender: TObject);
    procedure EOrdemProducaoRetorno(Retorno1, Retorno2: String);
    procedure BEtiquetaClick(Sender: TObject);
    procedure EUsuarioChange(Sender: TObject);
  private
    VprSeqOrdem,
    VprSeqFracao,
    VprCodFilial: Integer;
    VprProdutoAnterior,
    VprProdutoAnteriorOC: String;
    VprOperacao : TRBDOperacaoCadastro;
    VprAcao: Boolean;
    VprDBaixaConsumo,
    VprDBaixaOrdemCorte: TRBDConsumoFracaoOP;
    VprBaixas,
    VprBaixaOrdemCorte: TList;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure CarTitulosGrade;
    function ExisteProduto: Boolean;
    function ExisteProdutoOC: Boolean;
    function ExisteCor: Boolean;
    function LocalizaProduto: Boolean;
    function LocalizaProdutoOrdemCorte: Boolean;
    procedure CarProdutosOrcamentoCompras(VpaProdutos, VpaConsumos : TList);
    procedure GeraOrcamentoCompra;
    procedure CarDClasse;
    procedure CarDClasseOrdemCorte;
    procedure MarcaTodos;
    procedure CarDConsumo;
    function AlteraEstagioFracao : string;
    procedure ImprimeEtiqueta;
  public
    function BaixaConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer): Boolean;
  end;

var
  FBaixaConsumoProduto: TFBaixaConsumoProduto;

implementation
uses
  APrincipal, FunString, ConstMsg, UnProdutos, FunObjeto, ALocalizaProdutos,
  ANovaSolicitacaoCompra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaConsumoProduto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  VprDBaixaConsumo:= TRBDConsumoFracaoOP.Cria;
  VprBaixas:= TList.Create;
  VprBaixaOrdemCorte := TList.Create;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
  Grade.ADados:= VprBaixas;
  GOrdemCorte.ADados := VprBaixaOrdemCorte;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaConsumoProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprBaixas);
  VprBaixas.Free;
  FreeTObjectsList(VprBaixaOrdemCorte);
  VprBaixaOrdemCorte.free;
  FunOrdemProducao.free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFBaixaConsumoProduto.CarTitulosGrade;
begin
  Grade.Cells[2,0]:= 'A Baixar';
  Grade.Cells[3,0]:= 'UM';
  Grade.Cells[4,0]:= 'Qtd Produto';
  Grade.Cells[5,0]:= 'Baixado';
  Grade.Cells[6,0]:= 'Qtd Unitário';
  Grade.Cells[7,0]:= 'Código';
  Grade.Cells[8,0]:= 'Produto';
  Grade.Cells[9,0]:= 'Código';
  Grade.Cells[10,0]:= 'Cor';
  Grade.Cells[11,0]:= 'Código';
  Grade.Cells[12,0]:= 'Faca';
  Grade.Cells[13,0]:= 'Observações';

  GOrdemCorte.Cells[2,0]:= 'A Baixar';
  GOrdemCorte.Cells[3,0]:= 'UM';
  GOrdemCorte.Cells[4,0]:= 'Qtd Produto';
  GOrdemCorte.Cells[5,0]:= 'Baixado';
  GOrdemCorte.Cells[6,0]:= 'Qtd Unitário';
  GOrdemCorte.Cells[7,0]:= 'Código';
  GOrdemCorte.Cells[8,0]:= 'Produto';
  GOrdemCorte.Cells[9,0]:= 'Código';
  GOrdemCorte.Cells[10,0]:= 'Cor';
  GOrdemCorte.Cells[11,0]:= 'Código';
  GOrdemCorte.Cells[12,0]:= 'Faca';
  GOrdemCorte.Cells[13,0]:= 'Observações';

end;

{******************************************************************************}
function TFBaixaConsumoProduto.ExisteProduto : Boolean;
begin
  Result:= False;
  if Grade.Cells[7,Grade.ALinha] <> '' then
  begin
    if Grade.Cells[7,Grade.ALinha] = VprProdutoAnterior then
      Result:= True
    else
    begin
      VprDBaixaConsumo.CodProduto:= Grade.Cells[7,Grade.ALinha];
      Result:= FunProdutos.ExisteProduto(VprDBaixaConsumo.CodProduto,VprDBaixaConsumo.SeqProduto,VprDBaixaConsumo.NomProduto,VprDBaixaConsumo.DesUM);
      if Result then
      begin
        VprDBaixaConsumo.UnidadesParentes.Free;
        VprDBaixaConsumo.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDBaixaConsumo.DesUM);

        Grade.Cells[3,Grade.ALinha]:= VprDBaixaConsumo.DesUM;
        Grade.Cells[7,Grade.ALinha]:= VprDBaixaConsumo.CodProduto;
        Grade.Cells[8,Grade.ALinha]:= VprDBaixaConsumo.NomProduto;
      end;
    end;
  end
end;

{******************************************************************************}
function TFBaixaConsumoProduto.ExisteProdutoOC: Boolean;
begin
  Result:= False;
  if GOrdemCorte.Cells[7,GOrdemCorte.ALinha] <> '' then
  begin
    if GOrdemCorte.Cells[7,GOrdemCorte.ALinha] = VprProdutoAnteriorOC then
      Result:= True
    else
    begin
      VprDBaixaOrdemCorte.CodProduto:= GOrdemCorte.Cells[7,GOrdemCorte.ALinha];
      Result:= FunProdutos.ExisteProduto(VprDBaixaOrdemCorte.CodProduto,VprDBaixaOrdemCorte.SeqProduto,VprDBaixaOrdemCorte.NomProduto,VprDBaixaOrdemCorte.DesUM);
      if Result then
      begin
        VprDBaixaOrdemCorte.UnidadesParentes.Free;
        VprDBaixaOrdemCorte.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDBaixaOrdemCorte.DesUM);

        GOrdemCorte.Cells[3,GOrdemCorte.ALinha]:= VprDBaixaOrdemCorte.DesUM;
        GOrdemCorte.Cells[7,GOrdemCorte.ALinha]:= VprDBaixaOrdemCorte.CodProduto;
        GOrdemCorte.Cells[8,GOrdemCorte.ALinha]:= VprDBaixaOrdemCorte.NomProduto;
      end;
    end;
  end
end;

{******************************************************************************}
function TFBaixaConsumoProduto.ExisteCor: Boolean;
begin
  Result:= True;
  if Grade.Cells[9,Grade.Alinha] <> '' then
  begin
    Result:= FunProdutos.ExisteCor(Grade.Cells[9,Grade.ALinha],VprDBaixaConsumo.NomCor);
    if Result then
    begin
      Grade.Cells[10,Grade.ALinha]:= VprDBaixaConsumo.NomCor;
    end;
  end;
end;

{******************************************************************************}
function TFBaixaConsumoProduto.LocalizaProduto: Boolean;
var
  VpfClaFiscal : String;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDBaixaConsumo.SeqProduto,VprDBaixaConsumo.CodProduto,VprDBaixaConsumo.NomProduto,VprDBaixaConsumo.DesUM,VpfClaFiscal);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprDBaixaConsumo.UnidadesParentes.Free;
    VprDBaixaConsumo.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDBaixaConsumo.DesUM);
    VprProdutoAnterior:= VprDBaixaConsumo.CodProduto;
    Grade.Cells[3,Grade.ALinha]:= VprDBaixaConsumo.DesUM;
    Grade.Cells[7,Grade.ALinha]:= VprDBaixaConsumo.CodProduto;
    Grade.Cells[8,Grade.ALinha]:= VprDBaixaConsumo.NomProduto;
  end;
end;

{******************************************************************************}
function TFBaixaConsumoProduto.LocalizaProdutoOrdemCorte: Boolean;
var
  VpfClaFiscal : String;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDBaixaOrdemCorte.SeqProduto,VprDBaixaOrdemCorte.CodProduto,VprDBaixaOrdemCorte.NomProduto,VprDBaixaOrdemCorte.DesUM,VpfClaFiscal);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprDBaixaOrdemCorte.UnidadesParentes.Free;
    VprDBaixaOrdemCorte.UnidadesParentes:= FunProdutos.RUnidadesParentes(VprDBaixaOrdemCorte.DesUM);
    VprProdutoAnteriorOC:= VprDBaixaOrdemCorte.CodProduto;
    GOrdemCorte.Cells[3,GOrdemCorte.ALinha]:= VprDBaixaOrdemCorte.DesUM;
    GOrdemCorte.Cells[7,GOrdemCorte.ALinha]:= VprDBaixaOrdemCorte.CodProduto;
    GOrdemCorte.Cells[8,GOrdemCorte.ALinha]:= VprDBaixaOrdemCorte.NomProduto;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.CarProdutosOrcamentoCompras(VpaProdutos, VpaConsumos : TList);
var
  VpfLaco : Integer;
  VpfDProdutoBaixa : TRBDConsumoFracaoOP;
  VpfDProdutoOrcamento : TRBDSolicitacaoCompraItem;
begin
  for VpfLaco := 0 to VpaConsumos.Count - 1 do
  begin
    VpfDProdutoBaixa := TRBDConsumoFracaoOP(VpaConsumos.Items[VpfLaco]);
    if VpfDProdutoBaixa.QtdABaixar <> 0 then
    begin
      VpfDProdutoOrcamento := TRBDSolicitacaoCompraItem.Cria;
      VpaProdutos.add(VpfDProdutoOrcamento);
      VpfDProdutoOrcamento.SeqProduto := VpfDProdutoBaixa.SeqProduto;
      VpfDProdutoOrcamento.CodCor := VpfDProdutoBaixa.CodCor;
      VpfDProdutoOrcamento.CodProduto := VpfDProdutoBaixa.CodProduto;
      VpfDProdutoOrcamento.NomProduto := VpfDProdutoBaixa.NomProduto;
      VpfDProdutoOrcamento.NomCor := VpfDProdutoBaixa.NomCor;
      VpfDProdutoOrcamento.DesUM := VpfDProdutoBaixa.DesUM;
      VpfDProdutoOrcamento.UMOriginal := VpfDProdutoBaixa.DesUM;
      VpfDProdutoOrcamento.IndComprado := false;
      VpfDProdutoOrcamento.UnidadesParentes := FunProdutos.RUnidadesParentes(VpfDProdutoOrcamento.DesUM);
      VpfDProdutoOrcamento.QtdProduto := VpfDProdutoBaixa.QtdABaixar;
      VpfDProdutoOrcamento.QtdAprovado := VpfDProdutoBaixa.QtdABaixar;
    end;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GeraOrcamentoCompra;
var
  VpfProdutosOrcamento : TList;
begin
  VpfProdutosOrcamento := TList.create;
  CarProdutosOrcamentoCompras(VpfProdutosOrcamento,VprBaixaOrdemCorte);
  CarProdutosOrcamentoCompras(VpfProdutosOrcamento,VprBaixas);
  FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
  if FNovaSolicitacaoCompras.NovoOrcamentoConsumo(EFilial.AInteiro,EOrdemProducao.AInteiro,EFracao.AInteiro,VpfProdutosOrcamento) then
  begin
    CMarcarTodos.Checked := false;
    MarcaTodos;
  end;
  FNovaSolicitacaoCompras.free;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDBaixaConsumo:= TRBDConsumoFracaoOP(VprBaixas.Items[VpaLinha-1]);
  if VprDBaixaConsumo.QtdaBaixar <> 0 then
    Grade.Cells[2,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaConsumo.QtdaBaixar)
  else
    Grade.Cells[2,VpaLinha]:= '';

  Grade.Cells[3,VpaLinha]:= VprDBaixaConsumo.DesUM;
  Grade.Cells[4,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaConsumo.QtdProduto);
  if VprDBaixaConsumo.QtdBaixado <> 0 then
    Grade.Cells[5,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaConsumo.QtdBaixado)
  else
    Grade.Cells[5,VpaLinha]:= '';
  if UPPERCASE(VprDBaixaConsumo.DesUMUnitario) = 'CM' then
    Grade.Cells[6,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaConsumo.QtdUnitario)+'cm'
  else
    Grade.Cells[6,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaConsumo.QtdUnitario);
  Grade.Cells[7,VpaLinha]:= VprDBaixaConsumo.CodProduto;
  Grade.Cells[8,VpaLinha]:= VprDBaixaConsumo.NomProduto;
  if VprDBaixaConsumo.CodCor <> 0 then
    Grade.Cells[9,VpaLinha]:= IntToStr(VprDBaixaConsumo.CodCor)
  else
    Grade.Cells[9,VpaLinha]:= '';
  Grade.Cells[10,VpaLinha]:= VprDBaixaConsumo.NomCor;
  if VprDBaixaConsumo.CodFaca <> 0 then
    Grade.Cells[11,VpaLinha]:= IntToStr(VprDBaixaConsumo.CodFaca)
  else
    Grade.Cells[11,VpaLinha]:= '';
  Grade.Cells[12,VpaLinha]:= VprDBaixaConsumo.NomFaca;
  Grade.Cells[13,VpaLinha]:= VprDBaixaConsumo.DesObservacao;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if Grade.Cells[4,Grade.ALinha] = '' then
  begin
    aviso('QUANTIDADE PRODUTO NÃO PREENCHIDA!!!'#13'É necessário preencher este campo.');
    VpaValidos:= False;
    Grade.Col:= 4;
  end
  else
    if not ExisteProduto then
    begin
      aviso('PRODUTO INVALIDO!!!'#13'Produto não cadastrado.');
      VpaValidos:= False;
      Grade.Col:= 7;
    end
    else
      if not ExisteCor then
      begin
        aviso('COR INVALIDA!!!'#13'Cor não cadastrada.');
        VpaValidos:= False;
        Grade.Col:= 9;
      end;
  if VpaValidos then
  begin
    CarDClasse;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.CarDClasse;
begin
  if Grade.Cells[2,Grade.ALinha] <> '' then
    VprDBaixaConsumo.QtdABaixar:= StrToFloat(DeletaChars(Grade.Cells[2,Grade.ALinha],'.'))
  else
    VprDBaixaConsumo.QtdABaixar:= 0;
  VprDBaixaConsumo.DesUM:= Grade.Cells[3,Grade.ALinha];
  if Grade.Cells[4,Grade.ALinha] <> '' then
    VprDBaixaConsumo.QtdProduto:= StrToFloat(DeletaChars(Grade.Cells[4,Grade.ALinha],'.'))
  else
    VprDBaixaConsumo.QtdProduto:= 0;
  if Grade.Cells[5,Grade.ALinha] <> '' then
    VprDBaixaConsumo.QtdBaixado:= StrToFloat(DeletaChars(Grade.Cells[5,Grade.ALinha],'.'))
  else
    VprDBaixaConsumo.QtdBaixado:= 0;
  VprDBaixaConsumo.CodProduto:= Grade.Cells[7,Grade.ALinha];
  VprDBaixaConsumo.NomProduto:= Grade.Cells[8,Grade.ALinha];
  if Grade.Cells[9,Grade.ALinha] <> '' then
    VprDBaixaConsumo.CodCor:= StrToInt(Grade.Cells[9,Grade.ALinha])
  else
    VprDBaixaConsumo.CodCor:= 0;
  VprDBaixaConsumo.NomCor:= Grade.Cells[10,Grade.ALinha];
  VprDBaixaConsumo.CodFilial:= VprCodFilial;
  VprDBaixaConsumo.SeqOrdem:= VprSeqOrdem;
  VprDBaixaConsumo.SeqFracao:= VprSeqFracao;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.CarDClasseOrdemCorte;
begin
  if GOrdemCorte.Cells[2,GOrdemCorte.ALinha] <> '' then
    VprDBaixaOrdemCorte.QtdABaixar:= StrToFloat(DeletaChars(GOrdemCorte.Cells[2,GOrdemCorte.ALinha],'.'))
  else
    VprDBaixaOrdemCorte.QtdABaixar:= 0;
  VprDBaixaOrdemCorte.DesUM:= GOrdemCorte.Cells[3,GOrdemCorte.ALinha];
  if GOrdemCorte.Cells[4,GOrdemCorte.ALinha] <> '' then
    VprDBaixaOrdemCorte.QtdProduto:= StrToFloat(DeletaChars(GOrdemCorte.Cells[4,GOrdemCorte.ALinha],'.'))
  else
    VprDBaixaOrdemCorte.QtdProduto:= 0;
  if GOrdemCorte.Cells[5,GOrdemCorte.ALinha] <> '' then
    VprDBaixaOrdemCorte.QtdBaixado:= StrToFloat(DeletaChars(GOrdemCorte.Cells[5,GOrdemCorte.ALinha],'.'))
  else
    VprDBaixaOrdemCorte.QtdBaixado:= 0;
  VprDBaixaOrdemCorte.CodProduto:= GOrdemCorte.Cells[7,GOrdemCorte.ALinha];
  VprDBaixaOrdemCorte.NomProduto:= GOrdemCorte.Cells[8,GOrdemCorte.ALinha];
  if GOrdemCorte.Cells[9,GOrdemCorte.ALinha] <> '' then
    VprDBaixaOrdemCorte.CodCor:= StrToInt(GOrdemCorte.Cells[9,GOrdemCorte.ALinha])
  else
    VprDBaixaOrdemCorte.CodCor:= 0;
  VprDBaixaOrdemCorte.NomCor:= GOrdemCorte.Cells[10,GOrdemCorte.ALinha];
  VprDBaixaOrdemCorte.CodFilial:= VprCodFilial;
  VprDBaixaOrdemCorte.SeqOrdem:= VprSeqOrdem;
  VprDBaixaOrdemCorte.SeqFracao:= VprSeqFracao;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.MarcaTodos;
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VprBaixaOrdemCorte.Count - 1 do
  begin
    if CMarcarTodos.Checked then
    begin
      TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpfLaco]).QtdABaixar := TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpfLaco]).QtdProduto - TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpfLaco]).QtdBaixado;
      GOrdemCorte.Cells[1,VpfLaco+1] := '1';
    end
    else
    begin
      TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpfLaco]).QtdABaixar := 0;
      GOrdemCorte.Cells[1,VpfLaco+1] := '0';
    end;
  end;
  GOrdemCorte.CarregaGrade;
  for VpfLaco := 0 to VprBaixas.Count - 1 do
  begin
    if CMarcarTodos.Checked then
    begin
      TRBDConsumoFracaoOP(VprBaixas.Items[VpfLaco]).QtdABaixar := TRBDConsumoFracaoOP(VprBaixas.Items[VpfLaco]).QtdProduto - TRBDConsumoFracaoOP(VprBaixas.Items[VpfLaco]).QtdBaixado;
      Grade.Cells[1,VpfLaco+1] := '1';
    end
    else
    begin
      TRBDConsumoFracaoOP(VprBaixas.Items[VpfLaco]).QtdABaixar := 0;
      Grade.Cells[1,VpfLaco+1] := '0';
    end;
  end;
  Grade.CarregaGrade;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.CarDConsumo;
begin
  FunProdutos.CarDBaixaConsumoProduto(VprCodFilial, EOrdemProducao.AInteiro, EFracao.AInteiro,false, VprBaixas);
  FunProdutos.CarDBaixaConsumoProduto(VprCodFilial,EOrdemProducao.AInteiro,EFracao.ainteiro,true,VprBaixaOrdemCorte);
  Grade.CarregaGrade;
  GOrdemCorte.CarregaGrade;
end;

{******************************************************************************}
function TFBaixaConsumoProduto.AlteraEstagioFracao : String;
var
  VpfDEstagio : TRBDEstagioFracaoOPReal;
begin
  result := '';
  if EEstagio.AInteiro <> 0 then
  begin
    VpfDEstagio := TRBDEstagioFracaoOPReal.cria;
    with VpfDEstagio do
    begin
      CodFilial := EFilial.AInteiro;
      SeqOrdem := EOrdemProducao.AInteiro;
      SeqFracao := EFracao.AInteiro;
      SeqEstagio := EIDEstagio.AInteiro;
      CodEstagio := EEstagio.AInteiro;
      CodUsuario := Varia.CodigoUsuario;
      CodUsuarioLogado := varia.CodigoUsuario;
    end;
    Result := FunOrdemProducao.AlteraEstagioFracaoOP(VpfDEstagio);
    if Result = '' then
    begin
      if VpfDEstagio.SeqEstagio <> 0 then
        Result := FunOrdemProducao.ConcluiEstagioFracao(VpfDEstagio);
    end;
    VpfDEstagio.free;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.ImprimeEtiqueta;
var
  VpfLaco : Integer;
begin

end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    9: Value:= '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    case Grade.AColuna of
      7: LocalizaProduto;
      9: ECor.AAbreLocalizacao;
    end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.ECorRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[9,Grade.ALinha]:= Retorno1;
    Grade.Cells[10,Grade.ALinha]:= Retorno2;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Grade.AColuna of
    2, 4: if Key = '.' then
            Key:= DecimalSeparator;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprBaixas.Count > 0 then
  begin
    VprDBaixaConsumo:= TRBDConsumoFracaoOP(VprBaixas.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior:= VprDBaixaConsumo.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeNovaLinha(Sender: TObject);
begin
  VprDBaixaConsumo:= TRBDConsumoFracaoOP.Cria;
  VprBaixas.Add(VprDBaixaConsumo);
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        7: if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               Grade.Cells[7,Grade.ALinha]:= '';
               Abort;
             end;
           end;
        9: if not ExisteCor then
           begin
             if not ECor.AAbreLocalizacao then
             begin
               Grade.Cells[9,Grade.ALinha]:= '';
               Abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
function TFBaixaConsumoProduto.BaixaConsumoProduto(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao: Integer): Boolean;
begin
  VprOperacao := ocConsulta;
  VprSeqOrdem:= VpaSeqOrdem;
  VprSeqFracao:= VpaSeqFracao;
  VprCodFilial:= VpaCodFilial;
  EFilial.AInteiro := VpaCodFilial;
  EFilial.Atualiza;
  EUsuario.AInteiro := Varia.CodigoUsuario;
  EUsuario.Atualiza;
  EOrdemProducao.AInteiro := VpaSeqOrdem;
  EOrdemProducao.Atualiza;
  EFracao.AInteiro := VpaSeqFracao;
  EFracao.Atualiza;
  CarDConsumo;
  VprOperacao := ocEdicao;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= FunProdutos.GravaBaixaConsumoProduto1(VprCodFilial,VprSeqOrdem,EFracao.AInteiro, EUsuario.AInteiro,false,VprBaixas);
  if VpfResultado = '' then
  begin
    VpfResultado := FunProdutos.GravaBaixaConsumoProduto1(VprCodFilial,VprSeqOrdem,EFracao.AInteiro,EUsuario.AInteiro,true,VprBaixaOrdemCorte);
    if VpfResultado = '' then
    begin
      AlteraEstagioFracao;
      VprAcao:= True;
      Close;
    end;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.EOrdemProducaoSelect(Sender: TObject);
begin
  EOrdemProducao.ASelectLocaliza.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND CLI.C_NOM_CLI like ''@%''';
  EOrdemProducao.ASelectValida.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI From ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND ORD.SEQORD = @';
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VpaColuna = 1) then
  begin
    if (Grade.Cells[1,VpaLinha] = '0')or (Grade.Cells[1,VpaLinha] = '') then
    begin
      Grade.Cells[1,VpaLinha] := '1';
      TRBDConsumoFracaoOP(VprBaixas.Items[VpaLinha-1]).QtdABaixar := TRBDConsumoFracaoOP(VprBaixas.Items[VpaLinha-1]).QtdProduto - TRBDConsumoFracaoOP(VprBaixas.Items[VpaLinha-1]).QtdBaixado;
      Grade.Cells[2,VpaLinha]:= FormatFloat(Varia.MascaraQtd,TRBDConsumoFracaoOP(VprBaixas.Items[VpaLinha-1]).QtdABaixar);
    end
    else
    begin
      TRBDConsumoFracaoOP(VprBaixas.Items[VpaLinha-1]).QtdABaixar := 0;
      Grade.Cells[1,VpaLinha] := '0';
      Grade.Cells[2,VpaLinha]:= '';
    end;
  end;

end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.CMarcarTodosClick(Sender: TObject);
begin
  MarcaTodos;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GradeGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
Var
  VpfDBaixa : TRBDConsumoFracaoOP;
begin
  if (ACol > 0) and (ARow > 0) and (VprBaixas <> nil) then
  begin
    if VprBaixas.Count > 0  then
    begin
     VpfDBaixa := TRBDConsumoFracaoOP(VprBaixas.Items[Arow - 1]);
     if VpfDBaixa.IndMaterialExtra then
       ABrush.Color := clRed
     else
      if VpfDBaixa.IndBaixado then
        ABrush.Color := clGray;
    end;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.EFracaoRetorno(Retorno1, Retorno2: String);
begin
  EQtdFracao.Text := retorno1;
  if (VprOperacao in [ocInsercao,ocEdicao]) then
    CarDConsumo;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.EIDEstagioSelect(Sender: TObject);
begin
  EIDEstagio.ASelectValida.Text := 'Select FRA.SEQESTAGIO, PRO.DESESTAGIO, PRO.QTDPRODUCAOHORA, FRA.QTDPRODUZIDO '+
                                  ' from FRACAOOPESTAGIO FRA, PRODUTOESTAGIO PRO '+
                                  ' Where FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro)+
                                  ' AND FRA.SEQFRACAO = '+ IntToStr(EFracao.AInteiro)+
                                  ' AND FRA.SEQESTAGIO = @'+
                                  ' AND PRO.SEQPRODUTO = FRA.SEQPRODUTO '+
                                  ' AND PRO.SEQESTAGIO = FRA.SEQESTAGIO';
  EIDEstagio.ASelectLocaliza.Text := 'Select FRA.SEQESTAGIO, PRO.DESESTAGIO, PRO.QTDPRODUCAOHORA, FRA.QTDPRODUZIDO '+
                                  ' from FRACAOOPESTAGIO FRA, PRODUTOESTAGIO PRO '+
                                  ' Where FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro)+
                                  ' AND FRA.SEQFRACAO = '+ IntToStr(EFracao.AInteiro)+
                                  ' AND PRO.DESESTAGIO LIKE ''@%'''+
                                  ' AND PRO.SEQPRODUTO = FRA.SEQPRODUTO '+
                                  ' AND PRO.SEQESTAGIO = FRA.SEQESTAGIO';
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GOrdemCorteCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDBaixaOrdemCorte:= TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpaLinha-1]);
  if VprDBaixaOrdemCorte.QtdaBaixar <> 0 then
    GOrdemCorte.Cells[2,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaOrdemCorte.QtdaBaixar)
  else
    GOrdemCorte.Cells[2,VpaLinha]:= '';

  GOrdemCorte.Cells[3,VpaLinha]:= VprDBaixaOrdemCorte.DesUM;
  GOrdemCorte.Cells[4,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaOrdemCorte.QtdProduto);
  if VprDBaixaOrdemCorte.QtdBaixado <> 0 then
    GOrdemCorte.Cells[5,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaOrdemCorte.QtdBaixado)
  else
    GOrdemCorte.Cells[5,VpaLinha]:= '';
  GOrdemCorte.Cells[6,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDBaixaOrdemCorte.QtdUnitario);
  GOrdemCorte.Cells[7,VpaLinha]:= VprDBaixaOrdemCorte.CodProduto;
  GOrdemCorte.Cells[8,VpaLinha]:= VprDBaixaOrdemCorte.NomProduto;
  if VprDBaixaOrdemCorte.CodCor <> 0 then
    GOrdemCorte.Cells[9,VpaLinha]:= IntToStr(VprDBaixaOrdemCorte.CodCor)
  else
    GOrdemCorte.Cells[9,VpaLinha]:= '';
  GOrdemCorte.Cells[10,VpaLinha]:= VprDBaixaOrdemCorte.NomCor;
  if VprDBaixaOrdemCorte.CodFaca <> 0 then
    GOrdemCorte.Cells[11,VpaLinha]:= IntToStr(VprDBaixaOrdemCorte.CodFaca)
  else
    GOrdemCorte.Cells[11,VpaLinha]:= '';
  GOrdemCorte.Cells[12,VpaLinha]:= VprDBaixaOrdemCorte.NomFaca;
  GOrdemCorte.Cells[13,VpaLinha]:= VprDBaixaOrdemCorte.DesObservacao;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GOrdemCorteCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VpaColuna = 1) then
  begin
    if (GOrdemCorte.Cells[1,VpaLinha] = '0')or (GOrdemCorte.Cells[1,VpaLinha] = '') then
    begin
      GOrdemCorte.Cells[1,VpaLinha] := '1';
      TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpaLinha-1]).QtdABaixar := TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpaLinha-1]).QtdProduto - TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpaLinha-1]).QtdBaixado;
      GOrdemCorte.Cells[2,VpaLinha]:= FormatFloat(Varia.MascaraQtd,TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpaLinha-1]).QtdABaixar);
    end
    else
    begin
      TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpaLinha-1]).QtdABaixar := 0;
      GOrdemCorte.Cells[1,VpaLinha] := '0';
      GOrdemCorte.Cells[2,VpaLinha]:= '';
    end;
  end;
end;

procedure TFBaixaConsumoProduto.GOrdemCorteDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if GOrdemCorte.Cells[4,GOrdemCorte.ALinha] = '' then
  begin
    aviso('QUANTIDADE PRODUTO NÃO PREENCHIDA!!!'#13'É necessário preencher este campo.');
    VpaValidos:= False;
    GOrdemCorte.Col:= 4;
  end
  else
    if not ExisteProduto then
    begin
      aviso('PRODUTO INVALIDO!!!'#13'Produto não cadastrado.');
      VpaValidos:= False;
      GOrdemCorte.Col:= 7;
    end
    else
      if not ExisteCor then
      begin
        aviso('COR INVALIDA!!!'#13'Cor não cadastrada.');
        VpaValidos:= False;
        GOrdemCorte.Col:= 9;
      end;
  if VpaValidos then
  begin
    CarDClasseOrdemCorte;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GOrdemCorteGetCellColor(Sender: TObject;
  ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush;
  AFont: TFont);
Var
  VpfDBaixa : TRBDConsumoFracaoOP;
begin
  if (ACol > 0) and (ARow > 0) and (VprBaixaOrdemCorte <> nil) then
  begin
    if VprBaixaOrdemCorte.Count > 0  then
    begin
     VpfDBaixa := TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[Arow - 1]);
     if VpfDBaixa.IndMaterialExtra then
       ABrush.Color := clred
     else
       if VpfDBaixa.IndBaixado then
         ABrush.Color := clGray;
    end;
  end;
end;

procedure TFBaixaConsumoProduto.GOrdemCorteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    case Grade.AColuna of
      7: LocalizaProdutoOrdemCorte;
      9: ECorOC.AAbreLocalizacao;
    end;
end;

procedure TFBaixaConsumoProduto.ECorOCRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    GOrdemCorte.Cells[9,GOrdemCorte.ALinha]:= Retorno1;
    GOrdemCorte.Cells[10,GOrdemCorte.ALinha]:= Retorno2;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GOrdemCorteMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprBaixaOrdemCorte.Count > 0 then
  begin
    VprDBaixaOrdemCorte:= TRBDConsumoFracaoOP(VprBaixaOrdemCorte.Items[VpaLinhaAtual-1]);
    VprProdutoAnteriorOC:= VprDBaixaOrdemCorte.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GOrdemCorteNovaLinha(Sender: TObject);
begin
  VprDBaixaOrdemCorte:= TRBDConsumoFracaoOP.Cria;
  VprBaixaOrdemCorte.Add(VprDBaixaOrdemCorte);
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.GOrdemCorteSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if GOrdemCorte.AEstadoGrade in [egInsercao,EgEdicao] then
    if GOrdemCorte.AColuna <> ACol then
    begin
      case GOrdemCorte.AColuna of
        7: if not ExisteProduto then
           begin
             if not LocalizaProduto then
             begin
               GOrdemCorte.Cells[7,GOrdemCorte.ALinha]:= '';
               Abort;
             end;
           end;
        9: if not ExisteCor then
           begin
             if not ECor.AAbreLocalizacao then
             begin
               GOrdemCorte.Cells[9,GOrdemCorte.ALinha]:= '';
               Abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.BOrcamentoCompraClick(Sender: TObject);
begin
  GeraOrcamentoCompra;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.EOrdemProducaoRetorno(Retorno1,
  Retorno2: String);
begin
  if (VprOperacao in [ocInsercao,ocEdicao]) then
    CarDConsumo;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.BEtiquetaClick(Sender: TObject);
var
  VpfFunArgox : TRBFuncoesArgox;
begin
  VpfFunArgox := TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica);
  VpfFunArgox.ImprimeEtiquetaSeparacao(VprBaixas);
  VpfFunArgox.free;
end;

{******************************************************************************}
procedure TFBaixaConsumoProduto.EUsuarioChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFBaixaConsumoProduto]);
end.
