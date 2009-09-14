unit AProdutosFornecedores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, BotaoCadastro, StdCtrls, Buttons, Componentes1,
  ExtCtrls, PainelGradiente, Localizacao, Db, DBTables, ComCtrls,
  DBKeyViolation;

type
  TFProdutosFornecedores = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    PanelColor3: TPanelColor;
    Grade: TGridIndice;
    data1: TCalendario;
    Data2: TCalendario;
    RadioGroup1: TRadioGroup;
    PanelColor4: TPanelColor;
    Label1: TLabel;
    ELProduto: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    PFornecedor: TPanelColor;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    EFornecedor: TEditLocaliza;
    Label6: TLabel;
    MovForPro: TQuery;
    DataMovForPro: TDataSource;
    BitBtn1: TBitBtn;
    CUltCompra: TCheckBox;
    CValorQdade: TCheckBox;
    Label24: TLabel;
    EditLocaliza5: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label25: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ELProdutoSelect(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure GradeOrdem(Ordem: String);
    procedure BitBtn1Click(Sender: TObject);
    procedure CUltCompraClick(Sender: TObject);
    procedure EditLocaliza5Select(Sender: TObject);
    procedure EditLocaliza5Retorno(Retorno1, Retorno2: String);
  private
    OrderBy : string;
    ProdutoAtual, FornecedorAtual : string;
    procedure AtualizaConsulta;
    { Private declarations }
  public
    Procedure CarregaProduto( SequencialProduto : String );
  end;

var
  FProdutosFornecedores: TFProdutosFornecedores;

implementation

uses APrincipal, Constantes, FunSql, ConstMsg, ANovoCliente, fundata,
  APontoPedido, FunSistema, Funobjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProdutosFornecedores.FormCreate(Sender: TObject);
begin
  EditLocaliza5.Text := IntToStr(varia.CodigoEmpFil);
  EditLocaliza5.atualiza;
  data1.DateTime := DecMes(date,3);
  Data2.DateTime := date;
  ELProduto.AInfo.CampoCodigo := Varia.CodigoProduto;  // caso codigo pro ou codigo de barras
  OrderBy := ' Order by mov.d_dat_com ';
  grade.Columns[1].Visible := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProdutosFornecedores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações do Localiza
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************Carrega a Select para localizar e Validar o produto**************}
procedure TFProdutosFornecedores.ELProdutoSelect(Sender: TObject);
begin
  ELProduto.ASelectValida.add(' Select Pro.C_Cod_Pro, pro.C_Nom_Pro, pro.C_Cod_Uni, ' +
                              ' pro.I_SEQ_PRO, mov.C_COD_BAR ' +
                              ' From cadprodutos  pro, ' +
                              ' MovQdadeProduto  mov ' +
                              ' Where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                              ' and ' + varia.CodigoProduto + ' = ''@''' +
                              ' and C_KIT_PRO = ''P'' ' +
                              ' and pro.I_seq_pro = Mov.I_seq_pro ' +
                              ' and mov.I_Emp_Fil = ' + IntTostr(varia.CodigoEmpFil));

  ELProduto.ASelectLocaliza.add(' Select pro.C_Cod_Pro, pro.C_Nom_Pro, pro.C_Cod_Uni, ' +
                                ' pro.I_SEQ_PRO, mov.C_COD_BAR ' +
                                ' from cadprodutos  pro, ' +
                                ' MovQdadeProduto  mov ' +
                                ' Where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                ' and c_nom_pro like ''@%''' +
                                ' and C_KIT_PRO = ''P'' ' +
                                ' and pro.I_seq_pro = Mov.I_seq_pro ' +
                                ' and mov.I_Emp_Fil = ' + IntTostr(varia.CodigoEmpFil) +
                                ' order by c_nom_pro asc');

end;



{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Acoes do Fornecedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFProdutosFornecedores.AtualizaConsulta;
begin

end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFProdutosFornecedores.BFecharClick(Sender: TObject);
begin
   Close;
end;

{************* quando altera entre produto ou fornecedor no radioGroup ******* }
procedure TFProdutosFornecedores.RadioGroup1Click(Sender: TObject);
var
  VpaFornec, VpaProduto : string;
begin
  VpaFornec := '0';
  VpaProduto := '0';
  if RadioGroup1.ItemIndex = 0 then
  begin
   PFornecedor.Visible := false;
   if ProdutoAtual <> '' then
     VpaProduto := ProdutoAtual;
  end
  else
  begin
   PFornecedor.Visible := true;
   EFornecedor.SetFocus;
   EFornecedor.Atualiza;
   if FornecedorAtual <> '' then
     VpaFornec := FornecedorAtual;
  end;
end;

{ ************* no retorno da escolha de um fornecedor ********************** }
procedure TFProdutosFornecedores.EFornecedorRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    if PFornecedor.Visible then
    begin
      FornecedorAtual := Retorno1;
    end
    else
    begin
      ProdutoAtual := Retorno1;
    end;
  end;
end;


{ ************* retorno do order by escolhido no grid ************************ }
procedure TFProdutosFornecedores.GradeOrdem(Ordem: String);
begin
  OrderBy := Ordem
end;

{ ************ chamada externa para carregar o produto *********************** }
Procedure TFProdutosFornecedores.CarregaProduto( SequencialProduto : String );
begin
  RadioGroup1.ItemIndex := 0;
  ELProduto.Text := '';
end;

{************* chamada da tela de Ponto de Pedido ************************** }
procedure TFProdutosFornecedores.BitBtn1Click(Sender: TObject);
begin
  if not VerificaFormCriado( 'TFPontoPedido') then
      FPontoPedido := TFPontoPedido.criarMDI(application, varia.CT_AreaX, varia.CT_AreaY, FPrincipal.VerificaPermisao('FPontoPedido'));
    FPontoPedido.BringToFront;
end;

{ * Modifica o enabled dos checkBox, apenas pode escolher uma das opcoes ***** }
procedure TFProdutosFornecedores.CUltCompraClick(Sender: TObject);
begin
if CValorQdade.Focused then
  CUltCompra.Enabled := not CValorQdade.Checked;
if CUltCompra.Focused then
  CValorQdade.Enabled := not CUltCompra.Checked;
RadioGroup1Click(sender);
end;


procedure TFProdutosFornecedores.EditLocaliza5Select(Sender: TObject);
begin
  EditLocaliza5.ASelectLocaliza.Text := ' Select * from CadFiliais ' +
                                        ' where I_COD_EMP = ' +  IntToStr(varia.CodigoEmpresa) +
                                        ' and c_nom_fan like ''@%''';

  EditLocaliza5.ASelectValida.Text := 'Select * from CadFiliais where I_EMP_FIL = @% '
end;

procedure TFProdutosFornecedores.EditLocaliza5Retorno(Retorno1,
  Retorno2: String);
begin
  RadioGroup1Click(nil);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFProdutosFornecedores]);
end.
