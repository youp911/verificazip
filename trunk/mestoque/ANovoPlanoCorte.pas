unit ANovoPlanoCorte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, UnDadosProduto,
  StdCtrls, Localizacao, Mask, numericos, Buttons, UnOrdemProducao;

type
  TFNovoPlanoCorte = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TRBStringGridColor;
    Localiza: TConsultaPadrao;
    Label7: TLabel;
    Label15: TLabel;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    EPlanoCorte: Tnumerico;
    EFilial: TEditLocaliza;
    EDatEmissao: TEditColor;
    Label1: TLabel;
    BAdicionar: TBitBtn;
    BCancelar: TBitBtn;
    BGravar: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    ENumCNC: Tnumerico;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BAdicionarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure BGravarClick(Sender: TObject);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BCancelarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure GradeAntesExclusao(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDPlanoCorte : TRBDPlanoCorteCorpo;
    VprDItemPlanoCorte : TRBDPlanoCorteItem;
    procedure CarTitulosGrade;
    procedure InicilizaTela;
    procedure CarDTela;
    procedure EstadoBotoes(VpaEstado : Boolean);
    function DadosValidos : String;
    procedure CarDClasse;
    procedure CancelaPlanoCorte;
  public
    { Public declarations }
    function NovoPlanoCorte : Boolean;
  end;

var
  FNovoPlanoCorte: TFNovoPlanoCorte;

implementation

uses APrincipal, FunObjeto, Constantes, ConstMsg, ALocalizaFracaoOP;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoPlanoCorte.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTitulosGrade;
  VprDPlanoCorte := TRBDPlanoCorteCorpo.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoPlanoCorte.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDPlanoCorte.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoPlanoCorte.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'ID';
  Grade.Cells[2,0] := 'Quantidade';
  Grade.Cells[3,0] := 'Código';
  Grade.Cells[4,0] := 'Produto';

end;

{******************************************************************************}
procedure TFNovoPlanoCorte.InicilizaTela;
begin
  LimpaComponentes(PanelColor1,0);
  VprDPlanoCorte.free;
  VprDPlanoCorte := TRBDPlanoCorteCorpo.cria;
  Grade.ADados := VprDPlanoCorte.Itens;
  Grade.CarregaGrade;
  with VprDPlanoCorte do
  begin
    CodFilial := varia.CodigoEmpFil;
    DatEmissao := now;
    SeqPlanoCorte := 0;
    CodUsuario := varia.CodigoUsuario;
  end;
  CarDTela;
  ActiveControl := ENumCNC;
  EstadoBotoes(true);
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.CarDTela;
begin
  EFilial.AInteiro := VprDPlanoCorte.CodFilial;
  EFilial.Atualiza;
  EPlanoCorte.AsInteger := VprDPlanoCorte.SeqPlanoCorte;
  EDatEmissao.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS', VprDPlanoCorte.DatEmissao);
  ENumCNC.AsInteger := VprDPlanoCorte.NumCNC;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.EstadoBotoes(VpaEstado : Boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BAdicionar.Enabled := VpaEstado;
  BImprimir.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
function TFNovoPlanoCorte.DadosValidos : String;
var
  VpfLaco : Integer;
  VpfDItemPlanoCorte : TRBDPlanoCorteItem;
begin
  result := '';
  if VprDPlanoCorte.Itens.Count = 0 then
    result := 'NENHUM PRODUTO FOI ADICIONADO!!!'#13+'É necessário adicionar pelo menos 1 produto';
  if result = '' then
  begin
    for VpfLaco := 0 to VprDPlanoCorte.Itens.Count - 1 do
    begin
      VpfDItemPlanoCorte := TRBDPlanoCorteItem(VprDPlanoCorte.Itens[VpfLaco]);
      if VpfDItemPlanoCorte.SeqIdentificacao = 0 then
      begin
        result := 'IDENTIFICAÇÃO NÃO PREENCHIDA!!!'#13'É necessário preencher a identificação de todos os produtos.';
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.CarDClasse;
begin
  VprDPlanoCorte.NumCNC := ENumCNC.AsInteger;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.CancelaPlanoCorte;
begin
  FunOrdemProducao.ExtornaPlanoCortecomImpresso(VprDPlanoCorte);
end;

{******************************************************************************}
function TFNovoPlanoCorte.NovoPlanoCorte : Boolean;
begin
  InicilizaTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BAdicionarClick(Sender: TObject);
begin
  FLocalizaFracaoOP := TFLocalizaFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FLocalizaFracaoOP'));
  FLocalizaFracaoOP.LocalizaFracao(VprDPlanoCorte);
  FLocalizaFracaoOP.free;
  Grade.CarregaGrade;
  Grade.Row := 1;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItemPlanoCorte := TRBDPlanoCorteItem(VprDPlanoCorte.Itens[VpaLinha-1]);
  if VprDItemPlanoCorte.SeqIdentificacao <> 0 then
    Grade.Cells[1,VpaLinha]:= IntToStr(VprDItemPlanoCorte.SeqIdentificacao)
  else
    Grade.Cells[1,VpaLinha]:= '';
  if VprDItemPlanoCorte.QtdProduto <> 0 then
    Grade.Cells[2,VpaLinha]:= IntToStr(VprDItemPlanoCorte.QtdProduto)
  else
    Grade.Cells[2,VpaLinha]:= '';
  Grade.Cells[3,VpaLinha]:= VprDItemPlanoCorte.CodProduto;
  Grade.Cells[4,VpaLinha]:= VprDItemPlanoCorte.NomProduto;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
  begin
    CarDClasse;
    VpfResultado := FunOrdemProducao.GravaDPlanoCorte(VprDPlanoCorte);
  end;
  if VpfResultado = '' then
  begin
    EstadoBotoes(false);
    EPlanoCorte.AsInteger := VprDPlanoCorte.SeqPlanoCorte;
    VprAcao := true;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if VprDPlanoCorte.Itens.Count > 0 then
  begin
    if Grade.Cells[1,Grade.ALinha] <> '' then
      VprDItemPlanoCorte.SeqIdentificacao := StrToInt(Grade.Cells[1,Grade.ALinha])
    else
      VprDItemPlanoCorte.SeqIdentificacao := 0;
  end;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDPlanoCorte.Itens.Count > 0 then
  begin
    VprDItemPlanoCorte:= TRBDPlanoCorteItem(VprDPlanoCorte.Itens[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BCancelarClick(Sender: TObject);
begin
  CancelaPlanoCorte;
  close;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.BImprimirClick(Sender: TObject);
begin
  FunOrdemProducao.ImprimeEtiquetasPlanoCorte(VprDPlanoCorte);
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.GradeAntesExclusao(Sender: TObject);
var
  VpfDPlanoItem : TRBDPlanoCorteItem;
  VpfDFracao : TRBDPlanoCorteFracao;
  VpfLaco : Integer;
begin
  VpfDPlanoItem := TRBDPlanoCorteItem(VprDPlanoCorte.Itens[Grade.ALinha -1]);
  for VpfLaco := 0 to VpfDPlanoItem.Fracoes.Count - 1 do
  begin
    VpfDFracao := TRBDPlanoCorteFracao(VpfDPlanoItem.Fracoes[VpfLaco]);
    FunOrdemProducao.SetaPlanoCorteGerado(VpfDFracao.CodFilial,VpfDFracao.SeqOrdem,VpfDFracao.SeqFracao,false);
  end;
end;

{******************************************************************************}
procedure TFNovoPlanoCorte.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := true;
  if not VprAcao then
    BCancelar.Click; 
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoPlanoCorte]);
end.
