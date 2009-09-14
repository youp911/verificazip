unit AImprimeEtiqueta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ComCtrls, Componentes1, ExtCtrls, PainelGradiente, Mask, numericos, UnClientes,
  StdCtrls, Grids, CGrades, Buttons, UnDados, UnImpressaoEtiquetaCotacao, UnDadosProduto, UnCrystal,Clipbrd;

type
  TFImprimiEtiqueta = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PageControl1: TPageControl;
    PModelo1: TTabSheet;
    BFechar: TBitBtn;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    GCores: TRBStringGridColor;
    ECliente: TEditColor;
    Label1: TLabel;
    Label2: TLabel;
    EOrdemCompra: TEditColor;
    EEtiquetaInicial: Tnumerico;
    Label3: TLabel;
    Label4: TLabel;
    EQtdEtiquetas: Tnumerico;
    BImprimir: TBitBtn;
    CVisualizar: TCheckBox;
    BEtiPequena: TBitBtn;
    GProdutos: TRBStringGridColor;
    BComposicao: TBitBtn;
    BPeqHering: TBitBtn;
    BCaixa: TBitBtn;
    BEndereco: TBitBtn;
    BAmostra: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GCoresCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GCoresMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GCoresDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure GCoresKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosDepoisExclusao(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BEtiPequenaClick(Sender: TObject);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure BComposicaoClick(Sender: TObject);
    procedure BPeqHeringClick(Sender: TObject);
    procedure BCaixaClick(Sender: TObject);
    procedure BEnderecoClick(Sender: TObject);
    procedure BAmostraClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    VprCodCliente : Integer;
    VprCotacoes : TList;
    VprDModelo1 : TRBDEtiModelo1;
    VprDEtiProduto : TRBDEtiProduto;
    VprDEtiCor : TRBDEtiCor;
    FunEtiCotacao : TRBDFunEtiCotacao;
    procedure CarregaTitulosGrades;
    procedure CarEtiModelo1;
    procedure CarDCliente;
    procedure CarDModelo1;
  public
    { Public declarations }
    procedure ImprimeEtiquetas(VpaCotacoes : TList);
  end;

var
  FImprimiEtiqueta: TFImprimiEtiqueta;

implementation

uses APrincipal, FunObjeto, ConstMsg, AImpCotacao, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimiEtiqueta.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunEtiCotacao := TRBDFunEtiCotacao.cria;
  VprDModelo1 := TRBDEtiModelo1.cria;
  GProdutos.ADados := VprDModelo1.Produtos;
  CarregaTitulosGrades;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimiEtiqueta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunEtiCotacao.free;
  VprDModelo1.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImprimiEtiqueta.CarregaTitulosGrades;
begin
  GProdutos.Cells[1,0] := 'Produto';
  GProdutos.Cells[2,0] := 'Qtd Embalagem';
  GProdutos.Cells[3,0] := 'Composição';

  GCores.Cells[1,0] := 'Cor';
  GCores.Cells[2,0] := 'Qtd Cotação';
  GCores.Cells[3,0] := 'Qtd Etiqueta';
  GCores.Cells[4,0] := 'UM';
  GCores.Cells[5,0] := 'Qtd Embalagem';
  GCores.Cells[6,0] := 'Referência Cliente';
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.CarEtiModelo1;
begin
  FunEtiCotacao.CarEtiModelo1(VprDModelo1.Produtos,VprCotacoes);
  if VprCotacoes.Count > 0 then
  begin
    VprDModelo1.OrdemCompra := trbdorcamento(VprCotacoes.Items[0]).OrdemCompra;
    VprDModelo1.DesDestino := trbdorcamento(VprCotacoes.Items[0]).desobservacao.Text;
  end;
  GProdutos.CarregaGrade;
  VprDModelo1.QtdEtiquetas := FunEtiCotacao.RQtdEtiquetaModelo1(VprDModelo1);
  EQtdEtiquetas.AsInteger := VprDModelo1.QtdEtiquetas;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.CarDCliente;
Var
  VpfDCotacao : TRBDOrcamento;
begin
  if VprCotacoes.Count > 0 then
  begin
    VpfDCotacao := TRBDOrcamento(VprCotacoes.Items[0]);
    ECliente.Text := FunClientes.RNomCliente(IntToStr(VpfDCotacao.CodCliente));
    VprCodCliente := VpfDCotacao.CodCliente;
    EOrdemCompra.Text := VpfDCotacao.OrdemCompra;
  end;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.CarDModelo1;
begin
  with VprDModelo1 do
  begin
    NomCliente := ECliente.text;
    OrdemCompra := EOrdemCompra.Text;
    QtdEtiquetas := EQtdEtiquetas.AsInteger;
    EtiInicial := EEtiquetaInicial.AsInteger;
  end;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.ImprimeEtiquetas(VpaCotacoes : TList);
begin
  VprCotacoes := VpaCotacoes;
  if VprCotacoes.Count > 0 then
  begin
    CarDCliente;
    CarEtiModelo1;
    Showmodal;
  end
  else
    close;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDEtiProduto := TRBDEtiProduto(VprDModelo1.Produtos.Items[VpaLinha -1]);
  GProdutos.Cells[1,VpaLinha] := VprDEtiProduto.NomProduto;
  GProdutos.Cells[2,VpaLinha] := FloatToStr(VprDEtiProduto.QtdEmbalagem);
  GProdutos.Cells[4,VpaLinha] := VprDEtiProduto.DesComposicao;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  VprDEtiProduto := TRBDEtiProduto(VprDModelo1.Produtos.Items[VpaLinhaAtual -1]);
  GCores.ADados := VprDEtiProduto.Cores;
  GCores.CarregaGrade;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.GCoresCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  if VprDEtiProduto.Cores.Count > 0 then
  begin
    VprDEtiCor := TRBDEtiCor(VprDEtiProduto.Cores.Items[VpaLinha-1]);
    GCores.Cells[1,VpaLinha] := VprDEtiCor.NomCor;
    GCores.Cells[2,VpaLinha] := FloatToStr(VprDEtiCor.QtdCotacao);
    GCores.Cells[3,VpaLinha] := FloatToStr(VprDEtiCor.QtdEtiqueta);
    GCores.Cells[4,VpaLinha] := VprDEtiCor.UM;
    GCores.Cells[5,VpaLinha] := FloatToStr(VprDEtiCor.QtdEmbalagem);
    GCores.Cells[6,VpaLinha] := VprDEtiCor.DesReferenciaCliente;
  end;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.GCoresMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDEtiProduto.Cores.Count > 0 then
  begin
    VprDEtiCor := TRBDEtiCor(VprDEtiProduto.Cores.Items[VpaLinhaAtual - 1]);
  end;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.GCoresDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  try
    VprDEtiCor.QtdEtiqueta := StrToFloat(GCores.Cells[3,GCores.Alinha]);
    VprDEtiCor.DesReferenciaCliente := GCores.Cells[6,GCores.ALinha];
  except
    Aviso('QUANTIDADE DA ETIQUETA INVÁLIDA!!!'#13'A quantidade digitada da etiqueta não é um valor válido');
    VpaValidos := false;
  end;
  if GCores.Cells[5,GCores.ALinha] <> '' then
  begin
    try
      VprDEtiCor.QtdEmbalagem := StrToFloat(GCores.Cells[5,GCores.Alinha]);
    except
      Aviso('QUANTIDADE DA EMBALAGEM INVÁLIDA!!!'#13'A quantidade digitada da embalagem não é um valor válido');
      VpaValidos := false;
    end;
  end;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = PModelo1 then
    CarEtiModelo1;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.GCoresKeyPress(Sender: TObject; var Key: Char);
begin
  if key = '.' then
    key := ',';
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.GProdutosDepoisExclusao(Sender: TObject);
begin
  VprDModelo1.QtdEtiquetas := FunEtiCotacao.RQtdEtiquetaModelo1(VprDModelo1);
  EQtdEtiquetas.AsInteger := VprDModelo1.QtdEtiquetas;

end;

{******************************************************************************}
procedure TFImprimiEtiqueta.BImprimirClick(Sender: TObject);
begin
  CarDModelo1;
  FImpOrcamento := TFImpOrcamento.Create(application);
  FImpOrcamento.ImpEtiquetaModelo1(VprDModelo1,CVisualizar.Checked);
  FImpOrcamento.free;
end;

procedure TFImprimiEtiqueta.BEtiPequenaClick(Sender: TObject);
begin
  CarDModelo1;
  FunEtiCotacao.CarEtiPequenas(VprDModelo1,true);
  FImpOrcamento := TFImpOrcamento.Create(application);
  FImpOrcamento.ImpEtiquetaPequena(VprDModelo1,CVisualizar.Checked);
  FImpOrcamento.free;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  VprDEtiProduto.NomProduto := GProdutos.Cells[1,GPRodutos.ALinha];
  VprDEtiProduto.DesComposicao := GProdutos.Cells[3,GPRodutos.ALinha];
  try
    VprDEtiProduto.QtdEmbalagem := StrToFloat(GProdutos.Cells[2,GProdutos.ALinha]);
    if VprDEtiProduto.QtdEmbalagem <> VprDEtiProduto.QtdEmbalagemAnterior then
    begin
      VprDEtiProduto.QtdEmbalagemAnterior := VprDEtiProduto.QtdEmbalagem;
      FunEtiCotacao.AlteraQtdEmbalagemCores(VprDEtiProduto);
      GCores.CarregaGrade;
    end;
  except
    Aviso('QUANTIDADE DA EMBALAGEM INVÁLIDA!!!'#13'A quantidade digitada da embalagem não é um valor válido');
    VpaValidos := false;
  end;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.BComposicaoClick(Sender: TObject);
begin
  CarDModelo1;
  FunEtiCotacao.CarEtiPequenas(VprDModelo1,true);
  FImpOrcamento := TFImpOrcamento.Create(application);
  FImpOrcamento.ImpEtiquetaComposicao(VprDModelo1,CVisualizar.Checked);
  FImpOrcamento.free;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.BPeqHeringClick(Sender: TObject);
begin
  CarDModelo1;
  FunEtiCotacao.CarEtiPequenas(VprDModelo1,true);
  FImpOrcamento := TFImpOrcamento.Create(application);
  FImpOrcamento.ImpEtiquetaPeqRefCliente(VprDModelo1,CVisualizar.Checked);
  FImpOrcamento.free;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.BCaixaClick(Sender: TObject);
begin
  CarDModelo1;
  FunEtiCotacao.CarEtiPequenas(VprDModelo1,false);
  FImpOrcamento := TFImpOrcamento.Create(application);
  FImpOrcamento.ImpEtiquetaCaixa(VprDModelo1,CVisualizar.Checked);
  FImpOrcamento.free;
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.BEnderecoClick(Sender: TObject);
begin
  if CVisualizar.Checked then
    FunCrystal.ImprimeRelatorio(Varia.PathRelatorios + '\Clientes\XX_Endereco.rpt',[InttoStr(TRBDOrcamento(VprCotacoes.Items[0]).CodCliente) ])
  else
    FunCrystal.ImprimeRelatorioDiretoImpressora(Varia.ImpressoraRelatorio, Varia.PathRelatorios + '\Clientes\XX_Endereco.rpt',[InttoStr(TRBDOrcamento(VprCotacoes.Items[0]).CodCliente) ]);
end;

{******************************************************************************}
procedure TFImprimiEtiqueta.BAmostraClick(Sender: TObject);
begin
  CarDModelo1;
  FunEtiCotacao.CarEtiPequenas(VprDModelo1,true);
  FImpOrcamento := TFImpOrcamento.Create(application);
  FImpOrcamento.ImpEtiquetaAmostra(VprDModelo1,CVisualizar.Checked);
  FImpOrcamento.free;
end;

procedure TFImprimiEtiqueta.BitBtn1Click(Sender: TObject);
var
  VpfDClientes : TRBDCliente;
begin
  VpfDClientes := TRBDCliente.cria;
  VpfDClientes.CodCliente := VprCodCliente;
  FunClientes.CarDCliente(VpfDClientes);
  Clipboard.AsTExt := VpfDClientes.NomCliente+#13+VpfDClientes.DesEndereco+','+VpfDClientes.NumEndereco+' - '+VpfDClientes.DesComplementoEndereco+#13+
                      'Bairro : '+VpfDClientes.DesBairro+ '  -  '+VpfDClientes.DesCidade+'/'+VpfDClientes.DesUF+#13+
                      'CEP : '+VpfDClientes.CepCliente;
  VpfDClientes.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImprimiEtiqueta]);
end.
