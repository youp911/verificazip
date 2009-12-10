unit UnNotasFiscaisFor;
{Verificado
-.edit;
}
interface

uses
    Db, DBTables, classes, sysUtils, painelGradiente, localizacao, UnArgox, UnZebra,
    Componentes1, UnProdutos, UnDados, UnDadosCR, UnContasAPagar, UnDadosProduto,
    SQLExpr, tabela;
// calculos
type
  TCalculosNFFor = class
  private
    calcula : TSQLQuery;
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); virtual;
    destructor destroy; override;
end;

// localizacao
Type
  TLocalizaNFFor = class(TCalculosNFFor)
  public
    procedure LocalizaCadNotaFiscal(Tabela : TDataSet; SequencialNota : Integer );
    procedure LocalizaMovNotaFiscal(Tabela : TDataSet; SequencialNota : Integer );
    procedure LocalizaProdutoMovNota(Tabela : TDataSet; SequencialNota, SequencialProduto : Integer );
    procedure LocalizaNatureza( Tabela : TDataSet; CodNatureza : Integer );
    procedure LocalizaProdutoCodigos(Tabela : TDataSet; Codigos : string);
    procedure LocalizaMovNatureza(Tabela : TDataSet; Codnat : string );
  end;

// funcoes
type
  TFuncoesNFFor = class(TLocalizaNFFor)
  private
    Natureza,
    Tabela : TSqlQuery;
    NotCadastro : TSQL;
    DataBase : TSQLConnection;
    UnProduto : TFuncoesProduto;
    function RSeqNotaDisponivel(VpaEmpFil : String) : Integer;
    function GravaDItemNotaFor(VpaDNotaFor : TRBDNotaFiscalFor) : String;
    procedure CarDItemNotaFor(VpaDNotaFor : TRBDNotaFiscalFor);
    function AtualizaProdutoFornecedor(VpaDNotaFor : TRBDNotaFiscalFor):String;
    function RProdutoNota(VpaDNota: TRBDNotaFiscalFor; VpaDProdutoPedido: TRBDProdutoPedidoCompra): TRBDNotaFiscalForItem;
    function ExtornaVinculoPedidoNotaFiscalItem(VpaCodFilial, VpaSeqNota: Integer): String;
    function AdicionaProdutoDevolucao(VpaNotas : TList;VpaDNotafor : TRBDNotaFiscalFor):string;
  public
    Localiza: TConsultaPadrao;
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection ); override;
    destructor Destroy; override;
    function VerificaItemNotaRepetido( SequencialNota, SequencialProduto : Integer ) : Boolean;
    procedure LocalizaCadastrar(Sender: TObject);
    function LocalizaProduto( var codigoProduto, ClaFis, Unidade, SequencialProduto : string; LocalizarF3 : Boolean;
                             corForm : TCorForm; CorFoco : TCorFoco; PainelGra : TCorPainelGra) : Boolean;
    procedure CalculaNota(VpaDNotaFor : TRBDNotaFiscalFor );
    function ExisteProduto(VpaCodProduto : String;VpaDItemNota : TRBDNotaFiscalForItem):Boolean;
    procedure DeletaNotaFiscalFor( SequencialNota : Integer );
    procedure EstornaEstoqueFiscal(VpaDNota : TRBDNotaFiscalFor);
    procedure EstornaNotaEntrada( VpaCodFilial, VpaSeqNota : integer );
    procedure CarDNaturezaOperacao(VpaDNotaFor : TRBDNotaFiscalFor;VpaSeqNatureza : Integer);overload;
    procedure CarDNaturezaOperacao(VpaDNotaFor : TRBDNotaFiscalFor);overload;
    procedure CarDNotaFor(VpaDNotaFor : TRBDNotaFiscalFor);
    function GravaDNotaFor(VpaDNotaFor : TRBDNotaFiscalFor) : String;
    function GeraNotaDevolucao(VpaNotas : TList;VpaDNotaFor : TRBDNotaFiscalFor) : string;
    function BaixaProdutosEstoque(VpaDNotaFor : TRBDNotaFiscalFor) :String;
    procedure BaixaEstoqueFiscal(VpaDNotafor : TRBDNotaFiscalFor);
    function GeraContasaPagar(VpaDNotaFor : TRBDNotaFiscalFor) :String;
    function RValICMSFornecedor(VpaSigEstado : String) : Double;
    function ValidaMedicamentoControlado(VpaDNotaFor : TRBDNotaFiscalFor; VpaDItemNota : TRBDNotaFiscalForItem):Boolean;
    function PreparaEtiqueta(VpaDNotaFor : TRBDNotaFiscalFor;VpaPosInicial : Integer):string;
    function ImprimeEtiquetaNota(VpaDNotaFor : TRBDNotaFiscalFor):string;
    procedure PreencheProdutosNotaPedido(VpaListaPedidos: TList; VpaDNota: TRBDNotaFiscalFor);
  end;

implementation

uses constMsg, constantes, funSql, funstring, fundata, funnumeros, AItensNatureza,
      FunObjeto, ANovoProdutoPro;


{#############################################################################
                        TCalculo Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TCalculosNFFor.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  calcula := TSQLQuery.Create(aowner);
  calcula.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosNFFor.destroy;
begin
  calcula.Destroy;
  inherited;
end;

{#############################################################################
                        TLocaliza Produtos
#############################################################################  }

{ ***************** localiza o Cabecalho de uma nota fiscal ****************** }
procedure TLocalizaNFFor.LocalizaCadNotaFiscal(Tabela : TDataSet; SequencialNota : Integer );
begin
  AdicionaSQLAbreTabela(tabela,' Select * from CadNotaFiscaisFor where ' +
                               ' I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                               ' and I_SEQ_NOT = ' + IntToStr(sequencialNota) );
end;

{ ***************** localiza o Movimento de uma nota fiscal ****************** }
procedure TLocalizaNFFor.LocalizaMovNotaFiscal(Tabela : TDataSet; SequencialNota : Integer );
begin
  AdicionaSQLAbreTabela(tabela,' Select * from dba.MovNotasFiscaisFor where ' +
                               ' I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                               ' and i_seq_not = ' + IntToStr(SequencialNota) );
end;

procedure TLocalizaNFFor.LocalizaProdutoMovNota(Tabela : TDataSet; SequencialNota, SequencialProduto : Integer );
begin
AdicionaSQLAbreTabela(tabela,'Select * from MovNotasFiscaisFor where ' +
                             ' I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                             ' and i_seq_not = ' + IntToStr(SequencialNota) +
                             ' and I_SEQ_PRO = ' + IntToStr(SequencialProduto) );
end;

{******************************************************************************}
procedure TLocalizaNFFor.LocalizaNatureza(Tabela : TDataSet; CodNatureza : Integer );
begin
  AdicionaSQLAbreTabela(Tabela,' Select * from CadNatureza ' +
                               ' Where c_Cod_Nat = ''' + IntTostr(CodNatureza) + '''' );
end;

{******************************************************************************}
procedure TLocalizaNFFor.LocalizaProdutoCodigos(Tabela : TDataSet; Codigos : string);
begin
  AdicionaSQLAbreTabela(tabela, 'Select * from cadProdutos ' +
                               ' Where i_seq_pro in ( ' + codigos + ')' +
                               ' and I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) );
end;

{******************************************************************************}
procedure TLocalizaNFFor.LocalizaMovNatureza(Tabela : TDataSet; Codnat : string );
begin
  AdicionaSQLAbreTabela(TABELA,' Select * from MovNatureza ' +
                                     ' Where C_Cod_Nat = ''' + Codnat + '''' +
                                     ' and c_ent_sai = ''E'' ');
end;

{#############################################################################
                        TFuncoes Produtos
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesNFFor.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited;
  DataBase := VpaBaseDados;
  Natureza := TSQLQuery.Create(aowner);
  Natureza.SQLConnection := VpaBaseDados;
  Tabela := TSQLQuery.Create(aowner);
  Tabela.SqlConnection := vpaBaseDados;
  NotCadastro := TSQL.Create(aowner);
  NotCadastro.ASQLConnection := VpaBaseDados;
  Localiza := TConsultaPadrao.Create(aowner);
  UnProduto := TFuncoesProduto.criar(aowner,VpaBaseDados);
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesNFFor.Destroy;
begin
  localiza.Free;
  UnProduto.Free;
  Tabela.Close;
  Tabela.free;
  NotCadastro.Close;
  NotCadastro.free;
  Natureza.close;
  Natureza.free;
  inherited;
end;

{******************************************************************************}
function TFuncoesNFFor.RSeqNotaDisponivel(VpaEmpFil : String) : Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MAX(I_SEQ_NOT) ULTIMO from CADNOTAFISCAISFOR ' +
                               ' Where I_EMP_FIL = '+ VpaEmpFil);
  result := Tabela.FieldByName('ULTIMO').AsInteger + 1;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesNFFor.GravaDItemNotaFor(VpaDNotaFor : TRBDNotaFiscalFor) : String;
var
  VpfLaco : Integer;
  VpfDItemNota : TRBDNotaFiscalForItem;
begin
  result := '';
  ExecutaComandoSql(Tabela,'DELETE FROM MOVNOTASFISCAISFOR '+
                           ' Where I_EMP_FIL = '+ IntTostr(VpaDNotaFor.CodFilial)+
                           ' and I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota));
  AdicionaSQLAbreTabela(NotCadastro,'Select * from MOVNOTASFISCAISFOR'+
                                    ' Where I_EMP_FIL = 0  AND I_SEQ_NOT = 0 AND I_SEQ_MOV = 0 ');
  for VpfLaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
    NotCadastro.Insert;
    NotCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDNotaFor.CodFilial;
    NotCadastro.FieldByName('I_SEQ_NOT').AsInteger := VpaDNotaFor.SeqNota;
    NotCadastro.FieldByName('I_SEQ_MOV').AsInteger := VpfLaco + 1;
    NotCadastro.FieldByName('C_COD_UNI').AsString := VpfDItemNota.UM;
    NotCadastro.FieldByName('I_SEQ_PRO').AsInteger := VpfDItemNota.SeqProduto;
    NotCadastro.FieldByName('C_COD_NAT').AsString := VpaDNotaFor.CodNatureza;
    NotCadastro.FieldByName('I_ITE_NAT').AsInteger := VpaDNotaFor.SeqNatureza;
    NotCadastro.FieldByName('N_QTD_PRO').AsFloat := VpfDItemNota.QtdProduto;
    NotCadastro.FieldByName('N_VLR_PRO').AsFloat := VpfDItemNota.ValUnitario;
    NotCadastro.FieldByName('N_PER_ICM').AsFloat := VpfDItemNota.PerICMS;
    NotCadastro.FieldByName('N_PER_IPI').AsFloat := VpfDItemNota.PerIPI;
    NotCadastro.FieldByName('N_TOT_PRO').AsFloat := VpfDItemNota.ValTotal;
    NotCadastro.FieldByName('C_CLA_FIS').AsString := VpfDItemNota.CodClassificacaoFiscal;
    NotCadastro.FieldByName('C_COD_CST').AsString := VpfDItemNota.CodCST;
    NotCadastro.FieldByName('C_COD_PRO').AsString := VpfDItemNota.CodProduto;
    NotCadastro.FieldByName('C_NUM_SER').AsString := VpfDItemNota.DesNumSerie;
    if config.PermiteAlteraNomeProdutonaNotaEntrada then
      NotCadastro.FieldByName('C_NOM_PRO').AsString := VpfDItemNota.NomProduto;;
    NotCadastro.FieldByName('C_NOM_COR').AsString := VpfDItemNota.DesCor;
    if VpfDItemNota.CodCor <> 0 then
      NotCadastro.FieldByName('I_COD_COR').AsInteger := VpfDItemNota.CodCor
    else
      NotCadastro.FieldByName('I_COD_COR').Clear;
    if VpfDItemNota.CodTamanho <> 0 then
      NotCadastro.FieldByName('I_COD_TAM').AsInteger := VpfDItemNota.CodTamanho
    else
      NotCadastro.FieldByName('I_COD_TAM').Clear;

    NotCadastro.FieldByName('D_ULT_ALT').AsDateTime := now;
    if VpfDItemNota.DesReferenciaFornecedor <> '' then
      NotCadastro.FieldByName('C_REF_FOR').AsString := VpfDItemNota.DesReferenciaFornecedor
    else
      NotCadastro.FieldByName('C_REF_FOR').Clear;
    NotCadastro.Post;
    Result := NotCadastro.AMensagemErroGravacao;
    if NotCadastro.AErronaGravacao then
      exit;
    if VpfDItemNota.ValVenda <> VpfDItemNota.ValNovoVenda then
    begin
      result := FunProdutos.AlteraValorVendaProduto(VpfDItemNota.SeqProduto,VpfDItemNota.CodTamanho,VpfDItemNota.ValNovoVenda);
      if result <> '' then
        exit;
    end;
  end;
  NotCadastro.close;
end;

{******************************************************************************}
procedure TFuncoesNFFor.CarDItemNotaFor(VpaDNotaFor : TRBDNotaFiscalFor);
var
  VpfDItemNota : TRBDNotaFiscalForItem;
begin
  AdicionaSQLAbreTabela(Tabela,'Select MOV.I_SEQ_PRO, MOV.I_COD_COR, MOV.I_ITE_NAT, MOV.C_COD_NAT, MOV.C_NUM_SER, '+
                               ' MOV.C_COD_UNI, MOV.N_QTD_PRO, MOV.N_VLR_PRO, MOV.N_TOT_PRO, MOV.N_PER_IPI, ' +
                               ' MOV.N_PER_ICM,MOV.C_CLA_FIS, MOV.C_COD_CST, MOV.C_NOM_COR, MOV.C_REF_FOR, '+
                               ' MOV.C_NOM_PRO NOMPRODUTONOTA, MOV.I_COD_TAM, '+
                               ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UNIORIGINAL, '+
                               ' TAM.NOMTAMANHO '+
                               ' from MOVNOTASFISCAISFOR MOV, CADPRODUTOS PRO, TAMANHO TAM'+
                               ' Where MOV.I_EMP_FIL = '+ IntToStr(VpaDNotaFor.CodFilial)+
                               ' and MOV.I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota)+
                               ' and MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                               ' and '+SQLTextoRightJoin('MOV.I_COD_TAM','TAM.CODTAMANHO')+
                               ' order by I_SEQ_MOV');
  While not Tabela.Eof do
  begin
    VpfDItemNota := VpaDNotaFor.AddNotaItem;
    VpfDItemNota.SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
    VpfDItemNota.CodCor := Tabela.FieldByName('I_COD_COR').AsInteger;
    VpfDItemNota.SeqNatureza := Tabela.FieldByName('I_ITE_NAT').AsInteger;
    VpfDItemNota.CodProduto := Tabela.FieldByName('C_COD_PRO').AsString;
    VpfDItemNota.CodNatureza := Tabela.FieldByName('C_COD_NAT').AsString;
    VpfDItemNota.CodClassificacaoFiscal := Tabela.FieldByName('C_CLA_FIS').AsString;
    VpfDItemNota.CodCST := Tabela.FieldByName('C_COD_CST').AsString;
    if config.PermiteAlteraNomeProdutonaNotaEntrada then
      VpfDItemNota.NomProduto := Tabela.FieldByName('NOMPRODUTONOTA').AsString
    else
      VpfDItemNota.NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
    VpfDItemNota.DesCor := Tabela.FieldByName('C_NOM_COR').AsString;
    VpfDItemNota.CodTamanho := Tabela.FieldByName('I_COD_TAM').AsInteger;
    VpfDItemNota.DesTamanho := Tabela.FieldByName('NOMTAMANHO').AsString;
    VpfDItemNota.UM := Tabela.FieldByName('C_COD_UNI').AsString;
    VpfDItemNota.UMAnterior := Tabela.FieldByName('C_COD_UNI').AsString;
    VpfDItemNota.UMOriginal := Tabela.FieldByName('UNIORIGINAL').AsString;
    VpfDItemNota.UnidadeParentes := FunProdutos.ValidaUnidade.UnidadesParentes(VpfDItemNota.UMOriginal);
    VpfDItemNota.QtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat;
    VpfDItemNota.ValUnitario := Tabela.FieldByName('N_VLR_PRO').AsFloat;
    VpfDItemNota.ValTotal := Tabela.FieldByName('N_TOT_PRO').AsFloat;
    VpfDItemNota.PerIPI := Tabela.FieldByName('N_PER_IPI').AsFloat;
    VpfDItemNota.PerICMS := Tabela.FieldByName('N_PER_ICM').AsFloat;
    VpfDItemNota.QtdProduto := Tabela.FieldByName('N_QTD_PRO').AsFloat;
    VpfDItemNota.ValVenda := FunProdutos.ValorDeVenda(VpfDItemNota.SeqProduto,varia.TabelaPreco,Tabela.FieldByName('I_COD_TAM').AsInteger);
    VpfDItemNota.ValReVenda := VpfDItemNota.ValVenda;
    VpfDItemNota.ValNovoVenda := VpfDItemNota.ValVenda;
    VpfDItemNota.DesNumSerie := Tabela.FieldByName('C_NUM_SER').AsString;
    VpfDItemNota.DesReferenciaFornecedor := Tabela.FieldByName('C_REF_FOR').AsString;
    VpfDItemNota.QtdEtiquetas := ArredondaPraMaior(VpfDItemNota.QtdProduto);
    Tabela.Next;
  end;
  Tabela.close;
end;

{******************************************************************************}
function TFuncoesNFFor.AtualizaProdutoFornecedor(VpaDNotaFor : TRBDNotaFiscalFor):String;
var
  VpfLaco : Integer;
  VpfDItem : TRBDNotaFiscalForItem;
begin
  result := '';
  for VpfLaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItem := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
    AdicionaSQLAbreTabela(NotCadastro,'Select * from PRODUTOFORNECEDOR '+
                                      ' Where SEQPRODUTO = '+IntToStr(VpfDItem.SeqProduto)+
                                      ' and CODCLIENTE = '+IntToStr(VpaDNotaFor.CodFornecedor)+
                                      ' and CODCOR = ' +IntToStr(VpfDItem.CodCor));
    if NotCadastro.Eof then
    begin
      NotCadastro.Insert;
      NotCadastro.FieldByname('SEQPRODUTO').AsInteger := VpfDItem.SeqProduto;
      NotCadastro.FieldByname('CODCLIENTE').AsInteger := VpaDNotaFor.CodFornecedor;
      NotCadastro.FieldByname('CODCOR').AsInteger := VpfDItem.CodCor;
    end
    else
      NotCadastro.edit;

    if (NotCadastro.FieldByname('DESREFERENCIA').AsString = '') and (VpfDItem.DesReferenciaFornecedor <> '') then
      NotCadastro.FieldByname('DESREFERENCIA').AsString := VpfDItem.DesReferenciaFornecedor;

    NotCadastro.FieldByname('DATULTIMACOMPRA').AsDateTime := now;
    NotCadastro.FieldByname('VALUNITARIO').AsFloat := VpfDItem.ValUnitario;
    NotCadastro.FieldByname('PERIPI').AsFloat := VpfDItem.PerIPI;
    NotCadastro.post;
    Result := NotCadastro.AMensagemErroGravacao;
    if NotCadastro.AErronaGravacao then
      break;
  end;
  NotCadastro.close;
end;

{*********** verifica produto repetido na nota ****************************** }
function TFuncoesNFFor.VerificaItemNotaRepetido( SequencialNota, SequencialProduto : Integer ) : Boolean;
begin
  result := false;
  if not config.PermiteItemNFEntradaDuplicado then
  begin
    LocalizaProdutoMovNota(tabela,SequencialNota, SequencialProduto);

    if not tabela.EOF then
    begin
      result := true;
      Aviso(CT_ProdutoNotaRepetido);
    end;
  end;
end;

{************* cadastra novo produto ************************************** }
procedure TFuncoesNFFor.LocalizaCadastrar(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(nil,'',true);
  FNovoProdutoPro.NovoProduto('');
  FNovoProdutoPro.free;
end;

{***************************localiza codigo de produto*************************}
function TFuncoesNFFor.LocalizaProduto( var codigoProduto, ClaFis, Unidade, SequencialProduto : string; LocalizarF3 : Boolean;
                                       corForm : TCorForm; CorFoco : TCorFoco; PainelGra : TCorPainelGra) : Boolean;
begin
result := true;

Localiza.OnCadastrar := LocalizaCadastrar;
SequencialProduto := '0';

  if (codigoProduto <> '') and ( not LocalizarF3 ) then
  begin
     FechaTabela(tabela);
     LimpaSQLTabela(tabela);
     AdicionaSQLTabela(tabela,
                 ' select Pro.C_Cod_Pro, pro.C_Nom_Pro, pro.C_Cod_Uni, ' +
                 ' pro.I_SEQ_PRO, mov.C_COD_BAR, pro.c_cla_fis ' +
                 ' from CadProdutos as Pro,  MovQdadeProduto as mov ' +
                 ' where I_COD_EMP = ' + InttoStr(varia.CodigoEmpresa) +
                 ' and C_Kit_Pro = ''P''' +
                 ' and ' + varia.CodigoProduto + ' = ''' +
                 codigoProduto + ''''+
                 ' and pro.I_seq_pro = Mov.I_seq_pro ' +
                 ' and mov.I_Emp_Fil = ' + IntTostr(varia.CodigoEmpFil) );
    AbreTabela(tabela);
  end;


  if (tabela.EOF) or (codigoProduto = '') or (LocalizarF3)  then
  begin
    Localiza.info.DataBase := DataBase;
    Localiza.info.ComandoSQL := ' Select Pro.C_Cod_Pro, pro.C_Nom_Pro, pro.C_Cod_Uni, ' +
                                ' pro.I_SEQ_PRO, mov.C_COD_BAR, pro.c_cla_fis ' +
                                ' from CadProdutos as pro, MovQdadeProduto as mov ' +
                                ' where pro.I_COD_EMP = ' + InttoStr(varia.CodigoEmpresa)+
                                ' and pro.c_nom_Pro like ''@%'''+
                                ' and C_Kit_Pro = ''P'' '+
                                ' and pro.I_seq_pro = Mov.I_seq_pro ' +
                                ' and mov.I_Emp_Fil = ' + IntTostr(varia.CodigoEmpFil) +
                                ' Order by C_Nom_Pro';
    Localiza.info.caracterProcura := '@';
    Localiza.info.ValorInicializacao := '';
    Localiza.info.CamposMostrados[0] := Varia.CodigoProduto;
    Localiza.info.CamposMostrados[1] := 'c_nom_pro';
    Localiza.info.CamposMostrados[2] := '';
    Localiza.info.DescricaoCampos[0] := 'codigo';
    Localiza.info.DescricaoCampos[1] := 'Descrição';
    Localiza.info.DescricaoCampos[2] := '';
    Localiza.info.TamanhoCampos[0] := 8;
    Localiza.info.TamanhoCampos[1] := 40;
    Localiza.info.TamanhoCampos[2] := 0;
    Localiza.info.CamposRetorno[0] := 'i_seq_pro';
    Localiza.info.CamposRetorno[1] := 'c_cod_uni';
    Localiza.info.CamposRetorno[2] := 'C_cla_fis';
    Localiza.info.CamposRetorno[3] := Varia.CodigoProduto;
    Localiza.info.SomenteNumeros := false;
    Localiza.info.CorFoco := CorFoco;
    Localiza.info.CorForm := CorForm;
    Localiza.info.CorPainelGra := PainelGra;
    Localiza.info.TituloForm := '   Localizar Produto  ';
    Localiza.ACadastrar := true;

    result := Localiza.execute;

    if result then
    begin
       SequencialProduto := Localiza.retorno[0];
       Unidade := Localiza.retorno[1];
       ClaFis := Localiza.retorno[2];
       codigoProduto := Localiza.retorno[3];
    end
  end
  else
  begin
     SequencialProduto := tabela.FieldByName('I_SEQ_PRO').AsString;
     unidade := tabela.FieldByName('C_COD_UNI').AsString;
     ClaFis := tabela.FieldByName('C_Cla_Fis').AsString;
     codigoProduto := tabela.FieldByName(varia.CodigoProduto).AsString;
  end;
end;

{**************************Calcula o valor da nota*****************************}
procedure TFuncoesNFFor.CalculaNota(VpaDNotaFor : TRBDNotaFiscalFor);
var
  VpfTotFrete, VpfValICMS, VpfValIPI : double;
  descontoFormato : string;
  Sinal : string;
  VpfLaco : Integer;
  VpfDItemNota : TRBDNotaFiscalForItem;
begin
  VpaDNotaFor.ValTotalProdutos := 0;
  VpaDNotaFor.ValICMS := 0;
  VpaDNotaFor.ValIPI := 0;
  VpaDNotaFor.ValDescontoCalculado := 0;

  for VpfLaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[Vpflaco]);
    VpaDNotaFor.ValTotalProdutos := VpaDNotaFor.ValTotalProdutos + VpfDItemNota.ValTotal;
    VpfValICMS := ((VpfDItemNota.ValTotal * VpfDItemNota.PerICMS)/100);
    VpfValICMS := VpfValICMS - ((VpfValICMS * VpaDNotaFor.PerDesconto)*100);
    VpaDNotaFor.ValICMS := VpaDNotaFor.ValICMS + VpfValICMS;
    VpfValIPI := ((VpfDItemNota.ValTotal * VpfDItemNota.PerIPI)/100);
    VpfValIPI := VpfValIPI - ((VpfValIPI * VpaDNotaFor.PerDesconto)*100);
    VpaDNotaFor.ValIPI := VpaDNotaFor.ValIPI + VpfValIPI;
  end;
  VpfTotFrete := 0;
  if VpaDNotaFor.IndFreteEmitente then
    VpfTotFrete := VpaDNotaFor.ValFrete + VpaDNotaFor.ValSeguro;

  VpaDNotaFor.ValTotal := VpaDNotaFor.ValTotalProdutos + VpfTotFrete + VpaDNotaFor.ValIPI + VpaDNotaFor.ValOutrasDespesas + VpaDNotaFor.ValICMSSubstituicao;
  if VpaDNotaFor.ValDesconto <> 0 then
    VpaDNotaFor.ValDescontoCalculado := VpaDNotaFor.ValDesconto
  else
    if VpaDNotaFor.Perdesconto <> 0 then
      VpaDNotaFor.ValDescontoCalculado := ((VpaDNotaFor.ValTotal * VpaDNotaFor.PerDesconto)/100);
  VpaDNotaFor.ValTotal := VpaDNotaFor.ValTotal - VpaDNotaFor.ValDescontoCalculado
end;

{******************************************************************************}
function TFuncoesNFFor.ExisteProduto(VpaCodProduto : String;VpaDItemNota : TRBDNotaFiscalForItem):Boolean;
begin
  result := false;
  if VpaCodProduto <> '' then
  begin
    AdicionaSQLAbreTabela(Tabela,'Select pro.I_Seq_Pro, '+varia.CodigoProduto +
                                  ', Pro.C_Cod_Uni, Pro.C_Kit_Pro, PRO.C_FLA_PRO,PRO.C_NOM_PRO, '+
                                  ' PRO.C_CLA_FIS, PRO.I_PRI_ATI, C_REG_MSM, PRE.N_VLR_VEN, PRE.N_VLR_REV  ' +
                                  ' from CADPRODUTOS PRO, MOVQDADEPRODUTO Qtd, MOVTABELAPRECO PRE ' +
                                  ' Where '+Varia.CodigoProduto +' = ''' + VpaCodProduto +''''+
                                  ' and Qtd.I_Emp_Fil =  ' + IntTostr(Varia.CodigoEmpFil)+
                                  ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                                  ' and PRE.I_COD_EMP = '+ IntToStr(varia.CodigoEmpresa)+
                                  ' and PRE.I_COD_TAB = '+ IntTostr(varia.TabelaPreco)+
                                  ' and PRE.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                  ' AND PRE.I_COD_MOE = '+ IntTostr(varia.MoedaBase)+
                                  ' and PRE.I_COD_CLI = 0'+
                                  ' and Pro.c_ven_avu = ''S''');

    result := not Tabela.Eof;
    if result then
    begin
      with VpaDItemNota do
      begin
        UMOriginal := Tabela.FieldByName('C_Cod_Uni').Asstring;
        UM := Tabela.FieldByName('C_Cod_Uni').Asstring;
        UMAnterior := UM;
        CodProduto := Tabela.FieldByName(Varia.CodigoProduto).Asstring;
        QtdProduto := 1;
        SeqProduto := Tabela.FieldByName('I_SEQ_PRO').AsInteger;
        NomProduto := Tabela.FieldByName('C_NOM_PRO').AsString;
        CodClassificacaoFiscal := Tabela.FieldByName('C_CLA_FIS').AsString;
        ValVenda := Tabela.FieldByName('N_VLR_VEN').AsFloat;
        ValRevenda := Tabela.FieldByName('N_VLR_REV').AsFloat;
        ValNovoVenda := ValVenda;
        DesRegistroMSM := Tabela.FieldByname('C_REG_MSM').AsString;
        CodPrincipioAtivo := Tabela.FieldByName('I_PRI_ATI').AsInteger;
        if config.Farmacia then
          IndMedicamentoControlado := FunProdutos.PrincipioAtivoControlado(CodPrincipioAtivo);
      end;
    end;
    Tabela.close;
  end;
end;

{ ******************** Deleta Nota fiscal *********************************** }
procedure TFuncoesNFFor.DeletaNotaFiscalFor( SequencialNota : Integer );
begin
  ExecutaComandoSql(tabela,' Delete MovNotasFiscaisFor ' +
                           ' where i_emp_fil = ' + IntToStr(varia.CodigoEmpFil) +
                           ' and i_seq_not = ' + IntToStr(SequencialNota));
  ExecutaComandoSql(tabela,' Delete MovNotasFiscaisFor ' +
                           ' where i_emp_fil = ' + IntToStr(varia.CodigoEmpFil) +
                           ' and i_seq_not = ' + IntToStr(SequencialNota));
  ExecutaComandoSql(Tabela,' Delete CadNotaFiscaisFor ' +
                           ' where i_emp_fil = ' + IntToStr(varia.CodigoEmpFil) +
                           ' and i_seq_not = ' + IntToStr(SequencialNota) );
end;


{******************************************************************************}
procedure TFuncoesNFFor.EstornaEstoqueFiscal(VpaDNota : TRBDNotaFiscalFor);
var
  VpfLaco : Integer;
  VpfDItem : TRBDNotaFiscalForItem;
begin
  if VpaDNota.NumNota <> 1 then
  begin
    for VpfLaco := 0 to VpaDNota.ItensNota.Count - 1 do
    begin
      VpfDItem := TRBDNotaFiscalForItem(VpaDNota.ItensNota.Items[Vpflaco]);
      FunProdutos.BaixaEstoqueFiscal(VpaDNota.CodFilial,VpfDItem.SeqProduto,VpfDItem.CodCor,VpfDItem.CodTamanho, VpfDItem.QtdProduto,
                                     VpfDItem.UM,VpfDItem.UMOriginal,'S');
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesNFFor.EstornaNotaEntrada(VpaCodFilial, VpaSeqNota : integer );
var
  VpfDNota : TRBDNotaFiscalFor;
  VpfDProdutoNota : TRBDNotaFiscalForItem;
  VpfLaco,VpfSeqBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  VpfDNota := TRBDNotaFiscalFor.cria;
  VpfDNota.CodFilial := VpaCodFilial;
  VpfDNota.SeqNota := VpaSeqNota;
  CarDNotaFor(VpfDNota);
  if VpfDNota.DNaturezaOperacao.IndBaixarEstoque then
  begin
    for VpfLaco := 0 to VpfDNota.ItensNota.Count - 1 do
    begin
      VpfDProdutoNota := TRBDNotaFiscalForItem(VpfDNota.ItensNota.Items[VpfLaco]);
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,0,VpfDNota.CodFilial,VpfDProdutoNota.SeqProduto);
      FunProdutos.BaixaProdutoEstoque( VpfDProduto,VpfDNota.CodFilial,varia.OperacaoEstoqueEstornoSaida,
                                         VpfDNota.SeqNota, VpfDNota.NumNota,0,varia.MoedaBase,VpfDProdutoNota.CodCor,VpfDProdutoNota.CodTamanho,
                                         Date, VpfDProdutoNota.QtdProduto,
                                         VpfDProdutoNota.ValTotal, VpfDProdutoNota.UM ,
                                         VpfDProdutoNota.DesNumSerie,true,VpfSeqBarra);
      VpfDProduto.free;
    end;
  end;
  EstornaEstoqueFiscal(VpfDNota);
  ExtornaVinculoPedidoNotaFiscalItem(VpaCodfilial,VpaSeqNota);
  VpfDNota.free;

  DeletaNotaFiscalFor( VpaSeqNota );
end;

{******************************************************************************}
function TFuncoesNFFor.ExtornaVinculoPedidoNotaFiscalItem(VpaCodFilial, VpaSeqNota: Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM PEDIDOCOMPRANOTAFISCALITEM'+
                               ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                               ' AND SEQNOTA = '+IntToStr(VpaSeqNota));
  while not Tabela.Eof do
  begin
    NotCadastro.sql.clear;
    NotCadastro.sql.add('SELECT * FROM PEDIDOCOMPRAITEM'+
                                      ' WHERE SEQPEDIDO = '+Tabela.FieldByName('SEQPEDIDO').AsString+
                                      ' AND SEQPRODUTO = '+Tabela.FieldByName('SEQPRODUTO').AsString);
    if Tabela.FieldByName('CODCOR').AsInteger <> 0 then
      Tabela.sql.add(' AND CODCOR = '+Tabela.FieldByName('CODCOR').AsString);
    Tabela.open;
    if not NotCadastro.Eof then
    begin
      NotCadastro.Edit;
      NotCadastro.FieldByName('QTDBAIXADO').AsFloat:= NotCadastro.FieldByName('QTDBAIXADO').AsFloat-Tabela.FieldByName('QTDPRODUTO').AsFloat;
      NotCadastro.Post;
      Result := NotCadastro.AMensagemErroGravacao;
      NotCadastro.Close;
    end;
    if Result = '' then
      Tabela.Next
    else
      Tabela.Last;
  end;
  try
    ExecutaComandoSql(Tabela,'DELETE FROM PEDIDOCOMPRANOTAFISCALITEM'+
                             ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND SEQNOTA = '+IntToStr(VpaSeqNota));
    ExecutaComandoSql(Tabela,'DELETE FROM PEDIDOCOMPRANOTAFISCAL'+
                             ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                             ' AND SEQNOTA = '+IntToStr(VpaSeqNota));
  except
    on E:Exception do
      Result:= 'ERRO AO ATUALIZAR A QUANTIDADE RECEBIDA DO PEDIDO DE COMPRA'#13+E.Message;
  end;
  Tabela.Close;
  NotCadastro.Close;
end;

{******************************************************************************}
function TFuncoesNFFor.AdicionaProdutoDevolucao(VpaNotas : TList;VpaDNotafor : TRBDNotaFiscalFor):string;
var
  VpfLacoNota, VpfLacoProduto : Integer;
  VpfDNota : TRBDNotaFiscal;
  VpfDProNotaFor : TRBDNotaFiscalForItem;
  VpfDProNota : TRBDNotaFiscalProduto;
begin
  result := '';
  for VpfLacoNota := 0 to VpaNotas.Count -1 do
  begin
    VpfDNota := TRBDNotaFiscal(VpaNotas.Items[VpfLacoNota]);
    for VpfLacoProduto := 0 to VpfDNota.Produtos.Count - 1 do
    begin
      VpfDProNota := TRBDNotaFiscalProduto(VpfDNota.Produtos.Items[VpfLacoProduto]);
      VpfDProNotaFor := VpaDNotafor.AddNotaItem;
      ExisteProduto(VpfDProNota.CodProduto,VpfDProNotaFor);
      VpfDProNotaFor.SeqProduto := VpfDProNota.SeqProduto;
      VpfDProNotaFor.CodCor := VpfDProNota.CodCor;
      VpfDProNotaFor.UM := VpfDProNota.UM;
      VpfDProNotaFor.UnidadeParentes := FunProdutos.RUnidadesParentes(VpfDProNotaFor.UM);
      VpfDProNotaFor.DesNumSerie := VpfDProNota.DesRefCliente;
      VpfDProNotaFor.QtdProduto := VpfDProNota.QtdProduto;
      VpfDProNotaFor.ValUnitario := VpfDProNota.ValUnitario;
      VpfDProNotaFor.ValTotal := VpfDProNota.ValTotal;
      VpfDProNotaFor.PerICMS := VpfDProNota.PerICMS;
      VpfDProNotaFor.PerIPI := VpfDProNota.PerIPI;
    end;
  end;
end;

{******************************************************************************}
procedure TFuncoesNFFor.CarDNaturezaOperacao(VpaDNotaFor : TRBDNotaFiscalFor;VpaSeqNatureza : Integer);
begin

  AdicionaSQLAbreTabela(Natureza,' Select * from MovNatureza ' +
                               ' Where C_Cod_Nat = ''' + VpaDNotaFor.CodNatureza + '''' +
                               ' and c_ent_sai = ''E'' '+
                               ' and I_SEQ_MOV = '+ IntToStr(VpaSeqNatureza));
  VpaDNotaFor.SeqNatureza := Natureza.fieldByName('I_SEQ_MOV').AsInteger;
  VpaDNotaFor.DNaturezaOperacao.NomOperacaoEstoque := Natureza.FieldByName('C_NOM_MOV').AsString;
  VpaDNotaFor.DNaturezaOperacao.CodPlanoContas := Natureza.FieldByName('C_CLA_PLA').AsString;
  VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque := Natureza.FieldByName('I_COD_OPE').AsInteger;
  VpaDNotaFor.DNaturezaOperacao.IndFinanceiro := (Natureza.FieldByName('C_GER_FIN').AsString = 'S');
  VpaDNotaFor.DNaturezaOperacao.IndBaixarEstoque := (Natureza.FieldByName('C_BAI_EST').AsString = 'S');
  VpaDNotaFor.DNaturezaOperacao.IndCalcularICMS := (Natureza.FieldByName('C_CAL_ICM').AsString = 'S');
  VpaDNotaFor.DNaturezaOperacao.TipOperacaoEstoque := Natureza.FieldByName('C_ENT_SAI').AsString;
  Natureza.close;
  if VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque <> 0 then
    VpaDNotaFor.DNaturezaOperacao.FuncaoOperacaoEstoque := FunProdutos.RFuncaoOperacaoEstoque(IntToStr(VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque))
  else
    VpaDNotaFor.DNaturezaOperacao.FuncaoOperacaoEstoque := '';
  Natureza.Close;
end;

{******************************************************************************}
procedure TFuncoesNFFor.CarDNaturezaOperacao(VpaDNotaFor : TRBDNotaFiscalFor);
Var
  VpfQtd : Integer;
begin
  AdicionaSQLAbreTabela(NotCadastro,'Select COUNT(I_SEQ_MOV) QTD from MovNatureza ' +
                               ' Where C_Cod_Nat = ''' + VpaDNotaFor.CodNatureza + '''' +
                               ' and c_ent_sai = ''E'' ');
  VpfQtd := NotCadastro.FieldByName('QTD').AsInteger;
  AdicionaSQLAbreTabela(NotCadastro,' Select * from MovNatureza ' +
                               ' Where C_Cod_Nat = ''' + VpaDNotaFor.CodNatureza + '''' +
                               ' and c_ent_sai = ''E'' ');
  if VpfQtd > 1 then
  begin
    FItensNatureza := TFItensNatureza.CriarSDI(nil, '', true);
    FItensNatureza.PosicionaNatureza(NotCadastro);
    FItensNatureza.free;
  end;
  CarDNaturezaOperacao(VpaDNotaFor,NotCadastro.FieldByName('I_SEQ_MOV').AsInteger);
  NotCadastro.Close;
end;

procedure TFuncoesNFFor.CarDNotaFor(VpaDNotaFor : TRBDNotaFiscalFor);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADNOTAFISCAISFOR '+
                               ' Where I_EMP_FIL = '+ IntToStr(VpaDNotaFor.CodFilial)+
                               ' and I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota));

  VpaDNotaFor.CodFornecedor := Tabela.FieldByName('I_COD_CLI').AsInteger;
  VpaDNotaFor.NumNota := Tabela.FieldByName('I_NRO_NOT').AsInteger;
  VpaDNotaFor.CodTransportadora := Tabela.FieldByName('I_COD_TRA').AsInteger;
  VpaDNotaFor.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
  VpaDNotaFor.DatRecebimento := Tabela.FieldByName('D_DAT_REC').AsDateTime;
  VpaDNotaFor.DesObservacao := Tabela.FieldByName('L_OBS_NOT').AsString;
  VpaDNotaFor.IndFreteEmitente := Tabela.FieldByName('I_TIP_FRE').AsInteger = 1;
  VpaDNotaFor.ValTotal := Tabela.FieldByName('N_BAS_CAL').AsFloat;
  VpaDNotaFor.ValICMS := Tabela.FieldByName('N_VLR_ICM').AsFloat;
  VpaDNotaFor.ValICMSSubstituicao := Tabela.FieldByName('N_VLR_SUB').AsFloat;
  VpaDNotaFor.ValBaseICMSSubstituicao := Tabela.FieldByName('N_BAS_SUB').AsFloat;
  VpaDNotaFor.ValTotalProdutos := Tabela.FieldByName('N_TOT_PRO').AsFloat;
  VpaDNotaFor.ValFrete := Tabela.FieldByName('N_VLR_FRE').AsFloat;
  VpaDNotaFor.ValSeguro := Tabela.FieldByName('N_VLR_SEG').AsFloat;
  VpaDNotaFor.ValOutrasDespesas := Tabela.FieldByName('N_OUT_DES').AsFloat;
  VpaDNotaFor.ValIPI := Tabela.FieldByName('N_TOT_IPI').AsFloat;
  VpaDNotaFor.ValTotal := Tabela.FieldByName('N_TOT_NOT').AsFloat;
  VpaDNotaFor.SerNota := Tabela.FieldByName('C_SER_NOT').AsString;
  VpaDNotaFor.ValDesconto :=  Tabela.FieldByName('N_VLR_DES').AsFloat;
  VpaDNotaFor.ValDescontoCalculado :=  Tabela.FieldByName('N_VLR_DEC').AsFloat;
  VpaDNotaFor.PerDesconto := Tabela.FieldByName('N_PER_DES').AsFloat;
  VpaDNotaFor.CodNatureza := Tabela.FieldByName('C_COD_NAT').AsString;
  VpaDNotaFor.SeqNatureza := Tabela.FieldByName('I_SEQ_NAT').AsInteger;
  CarDNaturezaOperacao(VpaDNotaFor,VpaDNotaFor.SeqNatureza);
  VpaDNotaFor.DNaturezaOperacao.CodPlanoContas := Tabela.FieldByName('C_CLA_PLA').AsString;
  VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque := Tabela.FieldByName('I_COD_OPE').AsInteger;
  VpaDNotaFor.CodFormaPagamento := Tabela.FieldByName('I_COD_FRM').AsInteger;
  VpaDNotaFor.CodCondicaoPagamento := Tabela.FieldByName('I_COD_PAG').AsInteger;
  VpaDNotaFor.IndNotaDevolucao :=(Tabela.FieldByName('C_IND_DEV').AsString = 'S');
  VpaDNotaFor.CodVendedor := Tabela.FieldByName('I_COD_VEN').AsInteger;
  VpaDNotaFor.PerComissao := Tabela.FieldByName('N_PER_COM').AsFloat;
  VpaDNotaFor.CodModeloDocumento := Tabela.FieldByName('C_MOD_DOC').AsString;
  Tabela.close;
  CarDItemNotaFor(VpaDNotaFor);
end;

{******************************************************************************}
function TFuncoesNFFor.GravaDNotaFor(VpaDNotaFor : TRBDNotaFiscalFor) : String;
begin
  result := '';
  if VpaDNotaFor.SeqNota <> 0 then
  begin
    AdicionaSQLAbreTabela(NotCadastro,'Select * from CADNOTAFISCAISFOR'+
                                      ' Where I_EMP_FIL = '+IntTostr(VpaDNotaFor.CodFilial)+
                                      ' and I_SEQ_NOT = '+ IntToStr(VpaDNotaFor.SeqNota));
    NotCadastro.edit;
  end
  else
  begin
    AdicionaSQLAbreTabela(NotCadastro,'Select * from CADNOTAFISCAISFOR '+
                                      ' Where I_EMP_FIL = 0 AND I_SEQ_NOT = 0');
    NotCadastro.Insert;
  end;
  NotCadastro.FieldByName('I_EMP_FIL').AsInteger := VpaDNotaFor.CodFilial;
  NotCadastro.FieldByName('I_COD_CLI').AsInteger := VpaDNotaFor.CodFornecedor;
  NotCadastro.FieldByName('I_NRO_NOT').AsInteger := VpaDNotaFor.NumNota;
  if VpaDNotaFor.CodTransportadora <> 0 then
    NotCadastro.FieldByName('I_COD_TRA').AsInteger := VpaDNotaFor.CodTransportadora
  else
    NotCadastro.FieldByName('I_COD_TRA').clear;
  NotCadastro.FieldByName('D_DAT_EMI').AsDateTime := VpaDNotaFor.DatEmissao;
  NotCadastro.FieldByName('D_DAT_SAI').AsDateTime := VpaDNotaFor.DatEmissao;
  NotCadastro.FieldByName('D_DAT_REC').AsDateTime := VpaDNotaFor.DatRecebimento;
  NotCadastro.FieldByName('L_OBS_NOT').AsString := VpaDNotaFor.DesObservacao;
  if VpaDNotaFor.IndFreteEmitente then
    NotCadastro.FieldByName('I_TIP_FRE').AsInteger := 1
  else
    NotCadastro.FieldByName('I_TIP_FRE').AsInteger := 2;
  NotCadastro.FieldByName('N_BAS_CAL').AsFloat := VpaDNotaFor.ValTotal;
  NotCadastro.FieldByName('N_VLR_ICM').AsFloat := VpaDNotaFor.ValICMS;
  NotCadastro.FieldByName('N_TOT_PRO').AsFloat := VpaDNotaFor.ValTotalProdutos;
  NotCadastro.FieldByName('N_VLR_FRE').AsFloat := VpaDNotaFor.ValFrete;
  NotCadastro.FieldByName('N_VLR_SEG').AsFloat := VpaDNotaFor.ValSeguro;
  NotCadastro.FieldByName('N_OUT_DES').AsFloat := VpaDNotaFor.ValOutrasDespesas;
  NotCadastro.FieldByName('N_BAS_SUB').AsFloat := VpaDNotaFor.ValBaseICMSSubstituicao;
  NotCadastro.FieldByName('N_VLR_SUB').AsFloat := VpaDNotaFor.ValICMSSubstituicao;
  NotCadastro.FieldByName('N_TOT_IPI').AsFloat := VpaDNotaFor.ValIPI;
  NotCadastro.FieldByName('N_TOT_NOT').AsFloat := VpaDNotaFor.ValTotal;
  NotCadastro.FieldByName('C_SER_NOT').AsString := VpaDNotaFor.SerNota;
  NotCadastro.FieldByName('C_COD_NAT').AsString := VpaDNotaFor.CodNatureza;
  NotCadastro.FieldByName('I_SEQ_NAT').AsInteger := VpaDNotaFor.SeqNatureza;
  NotCadastro.FieldByName('N_VLR_DES').AsFloat := VpaDNotaFor.ValDesconto;
  NotCadastro.FieldByName('N_VLR_DEC').AsFloat := VpaDNotaFor.ValDescontoCalculado;
  NotCadastro.FieldByName('N_PER_DES').AsFloat := VpaDNotaFor.PerDesconto;
  NotCadastro.FieldByName('I_COD_PAG').AsInteger := VpaDNotaFor.CodCondicaoPagamento;
  if VpaDNotaFor.DNaturezaOperacao.CodPlanoContas <> '' then
    NotCadastro.FieldByName('C_CLA_PLA').AsString :=  VpaDNotaFor.DNaturezaOperacao.CodPlanoContas
  else
    NotCadastro.FieldByName('C_CLA_PLA').Clear;
  if VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque <> 0 then
    NotCadastro.FieldByName('I_COD_OPE').AsInteger :=  VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque
  else
    NotCadastro.FieldByName('I_COD_OPE').Clear;
  if VpaDNotaFor.CodFormaPagamento <> 0 then
    NotCadastro.FieldByName('I_COD_FRM').AsInteger := VpaDNotaFor.CodFormaPagamento
  else
    NotCadastro.FieldByName('I_COD_FRM').Clear;
  if VpaDNotaFor.IndNotaDevolucao  then
    NotCadastro.FieldByName('C_IND_DEV').AsString := 'S'
  else
    NotCadastro.FieldByName('C_IND_DEV').AsString := 'N';
  if VpaDNotaFor.CodVendedor <> 0 then
    NotCadastro.FieldByName('I_COD_VEN').AsInteger := VpaDNotaFor.CodVendedor
  else
    NotCadastro.FieldByName('I_COD_VEN').Clear;
  NotCadastro.FieldByName('N_PER_COM').AsFloat := VpaDNotaFor.PerComissao;
  NotCadastro.FieldByName('D_ULT_ALT').AsDateTime := now;

  if VpaDNotaFor.SeqNota = 0 then
    VpaDNotaFor.SeqNota := RSeqNotaDisponivel(IntToStr(VpaDNotaFor.CodFilial));

  NotCadastro.FieldByName('I_SEQ_NOT').AsInteger := VpaDNotaFor.SeqNota;
  NotCadastro.post;
  Result := NotCadastro.AMensagemErroGravacao;
  if result = '' then
  begin
    result := GravaDItemNotaFor(VpaDNotaFor);
    if result = '' then
    begin
      result := AtualizaProdutoFornecedor(VpaDNotaFor);
    end;
  end;
  NotCadastro.close;
end;

{******************************************************************************}
function TFuncoesNFFor.GeraNotaDevolucao(VpaNotas : TList;VpaDNotaFor : TRBDNotaFiscalFor) : string;
var
  VpfDNotaFiscal : TRBDNotaFiscal;
begin
  result := '';
  VpfDNotaFiscal := TRBDNotaFiscal(VpaNotas.Items[0]);
  VpaDNotaFor.CodFornecedor := VpfDNotaFiscal.CodCliente;
  VpaDNotaFor.CodTransportadora := VpfDNotaFiscal.CodTransportadora;
  VpaDNotaFor.DatEmissao := Date;
  VpaDNotaFor.CodVendedor := VpfDNotaFiscal.CodVendedor;
  VpaDNotaFor.PerComissao := VpfDNotaFiscal.PerComissao;

  AdicionaProdutoDevolucao(VpaNotas,VpaDNotaFor);
end;

{******************************************************************************}
function TFuncoesNFFor.BaixaProdutosEstoque(VpaDNotaFor : TRBDNotaFiscalFor) :String;
var
  VpfLaco,VpfSeqEstoqueBarra : Integer;
  VpfValDescontoNota : Double;
  VpfDItemNota : TRBDNotaFiscalForItem;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  if VpaDNotaFor.DNaturezaOperacao.IndBaixarEstoque then
  begin
    for VpfLaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
    begin
      VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
      FunProdutos.AtualizaValorCusto(VpfDItemNota.SeqProduto,VpaDNotaFor.CodFilial,varia.MoedaBase,
                                     VpfDItemNota.UMOriginal,VpfDItemNota.um,VpaDNotaFor.DNaturezaOperacao.FuncaoOperacaoEstoque,
                                     VpfDItemNota.CodCor,VpfDItemNota.CodTamanho,VpfDItemNota.QtdProduto,VpfDItemNota.ValUnitario,VpaDNotaFor.ValTotal,VpaDNotaFor.ValFrete,
                                     VpfDItemNota.PerICMS,VpfDItemNota.PerIPI,VpaDNotaFor.ValDescontoCalculado,VpaDNotaFor.IndFreteEmitente);
      VpfDProduto := TRBDProduto.Cria;
      FunProdutos.CarDProduto(VpfDProduto,0,VpaDNotaFor.CodFilial,VpfDItemNota.SeqProduto);
      FunProdutos.BaixaProdutoEstoque( VpfDProduto, VpaDNotaFor.CodFilial, VpaDNotaFor.DNaturezaOperacao.CodOperacaoEstoque,
                                       VpaDNotaFor.SeqNota, VpaDNotaFor.NumNota,0,varia.MoedaBase,VpfDItemNota.CodCor,VpfDItemNota.CodTamanho,
                                       Date, VpfDItemNota.QtdProduto,
                                       VpfDItemNota.ValTotal, VpfDItemNota.UM ,
                                       VpfDItemNota.DesNumSerie,true,VpfSeqEstoqueBarra);
      VpfDProduto.free;
    end;
  end;
  if result = '' then
    BaixaEstoqueFiscal(VpaDNotaFor);
end;

{******************************************************************************}
procedure TFuncoesNFFor.BaixaEstoqueFiscal(VpaDNotafor : TRBDNotaFiscalFor);
var
  VpfLaco : Integer;
  VpfDItem : TRBDNotaFiscalForItem;
begin
  if  VpaDNotafor.NumNota <> 1 then
  begin
    for VpfLaco := 0 to VpaDNotafor.ItensNota.Count - 1 do
    begin
      VpfDItem := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[vpfLaco]);
      FunProdutos.BaixaEstoqueFiscal(VpaDNotafor.CodFilial, VpfDItem.SeqProduto,VpfDItem.CodCor,VpfDItem.CodTamanho, VpfDItem.QtdProduto,VpfDItem.UM,VpfDItem.UMOriginal,'E');
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.GeraContasaPagar(VpaDNotaFor : TRBDNotaFiscalFor) :String;
var
  VpfDadoCP : TRBDContasaPagar;
begin
  result := '';
  if ConfigModulos.ContasAPagar then
  begin
    if (VpaDNotaFor.DNaturezaOperacao.IndFinanceiro) Then
    begin
      VpfDadoCP := TRBDContasaPagar.Cria;
      VpfDadoCP.CodFilial := VpaDNotaFor.CodFilial;
      VpfDadoCP.NumNota := VpaDNotaFor.NumNota;
      VpfDadoCP.SeqNota := VpaDNotaFor.SeqNota;
      VpfDadoCP.CodFornecedor := VpaDNotaFor.CodFornecedor;
      VpfDadoCP.CodFormaPagamento :=  VpaDNotaFor.CodFormaPagamento;
      VpfDadoCP.CodMoeda := varia.MoedaBase;
      VpfDadoCP.CodUsuario := varia.CodigoUsuario;
      VpfDadoCP.DatEmissao := VpaDNotaFor.DatEmissao;
      VpfDadoCP.CodPlanoConta := VpaDNotaFor.DNaturezaOperacao.CodPlanoContas;
      VpfDadoCP.DesPathFoto := '';
      VpfDadoCP.CodCondicaoPagamento := VpaDNotaFor.CodCondicaoPagamento;
      VpfDadoCP.PerDescontoAcrescimo := 0;
      VpfDadoCP.IndMostrarParcelas := true;
      VpfDadoCP.DesTipFormaPagamento := VpaDNotaFor.TipFormaPagamento;
      VpfDadoCP.IndBaixarConta := FunContasAPagar.FlagBaixarContaFormaPagamento(VpaDNotaFor.CodFormaPagamento);
      result := FunContasAPagar.CriaContaPagar( VpfDadoCP,nil);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.RValICMSFornecedor(VpaSigEstado : String) : Double;
var
  VpfEstado : String;
begin
  if VpaSigEstado = '' then
  begin
    erro('ICMS INTER-ESTADUAL NÃO CADASTRADO!!!!Não existe cadastrado o ICMS Inter-Estadual para o estado "'+VpaSigEstado+'".');
    VpfEstado := Varia.EstadoPadrao;
  end
  else
    VpfEstado := VpaSigEstado;

  AdicionaSQLAbreTabela(Tabela,'Select * from CADICMSESTADOS '+
                            ' Where C_COD_EST = '''+ VpfEstado+''''+
                            ' and I_COD_EMP = ' +IntToStr(Varia.CodigoEmpresa));
  result := Tabela.FieldByName('N_ICM_EXT').AsFloat;
  Tabela.Close;
end;

{******************************************************************************}
function TFuncoesNFFor.ValidaMedicamentoControlado(VpaDNotaFor : TRBDNotaFiscalFor; VpaDItemNota : TRBDNotaFiscalForItem):Boolean;
begin
  result := true;
  if VpaDItemNota.IndMedicamentoControlado then
  begin
    if VpaDItemNota.DesRegistroMSM = '' then
    begin
      aviso('REGISTRO DO MSM NÃO PREENCHIDO!!!'#13'Antes de comprar um produto controlado é necessário preencher no cadastro do produto o registro do MSM.');
      result := false;
    end;
    if result then
    begin
      if VpaDNotaFor.CGC_CPFFornecedor = '' then
      begin
        aviso('CNPJ FORNECEDOR NÃO PREENCHIDO!!!'#13'Antes de comprar um produto controlado é necessário preencher o CNPJ do fornecedor no cadastro de fornecedores.');
        result := false;
      end;
      if result then
      begin
        if VpaDNotaFor.CodFornecedor = 0 then
        begin
          aviso('FORNECEDOR NÃO PREENCHIDO!!!'#13'Antes de comprar um produto controlado é necessário preencher o fornecedor.');
          result := false;
        end;
        if result then
        begin
          if VpaDItemNota.CodPrincipioAtivo = 0 then
          begin
            result := false;
            aviso('PRINCIPIO ATIVO NÃO PREENCHIDO!!!'#13'É necessário preencher o principio ativo do medicamento.');
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.PreparaEtiqueta(VpaDNotaFor : TRBDNotaFiscalFor;VpaPosInicial : Integer):string;
Var
  VpfSequencial, Vpflaco, VpfLacoQtd : Integer;
  VpfDItemNota : TRBDNotaFiscalForItem;
begin
  result := '';
  VpfSequencial := 0;
  ExecutaComandoSql(Tabela,'Delete from ETIQUETAPRODUTO');
  AdicionaSQLAbreTabela(NotCadastro,'Select * from ETIQUETAPRODUTO');
  for vpfLaco := 1 to VpaPosInicial - 1 do
  begin
    inc(VpfSequencial);
    NotCadastro.Insert;
    NotCadastro.FieldByname('SEQETIQUETA').AsInteger := VpfSequencial;
    NotCadastro.FieldByname('INDIMPRIMIR').AsString := 'N';
    NotCadastro.Post;
  end;

  for vpflaco := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLaco]);
    if VpfDItemNota.QtdEtiquetas > 0  then
    begin
      for VpfLacoQtd := 1 to RetornaInteiro(VpfDItemNota.QtdEtiquetas) do
      begin
        inc(VpfSequencial);
        NotCadastro.insert;
        NotCadastro.FieldByname('SEQETIQUETA').AsInteger := VpfSequencial;
        NotCadastro.FieldByname('CODPRODUTO').AsString := VpfDItemNota.CodProduto;
        NotCadastro.FieldByname('NOMPRODUTO').AsString := VpfDItemNota.NomProduto;
        NotCadastro.FieldByname('CODTAMANHO').AsInteger := VpfDItemNota.CodTamanho;
        NotCadastro.FieldByname('NOMTAMANHO').AsString := VpfDItemNota.DesTamanho;
        NotCadastro.FieldByname('INDIMPRIMIR').AsString := 'S';
        NotCadastro.post;
        Result := NotCadastro.AMensagemErroGravacao;
        if NotCadastro.AErronaGravacao then
          exit;
      end;
    end;
  end;
  NotCadastro.close;
end;


{******************************************************************************}
function TFuncoesNFFor.ImprimeEtiquetaNota(VpaDNotaFor : TRBDNotaFiscalFor):string;
var
  VpfEtiquetas : TList;
  VpfDEtiquetas : TRBDEtiquetaProduto;
  VpfLacoNota : Integer;
  VpfDItemNota : TRBDNotaFiscalForItem;
  VpfDProduto : TRBDProduto;
  VpfFunArgox : TRBFuncoesArgox;
  VpfFunZebra : TRBFuncoesZebra;
begin
  VpfEtiquetas := TList.create;
  VpfFunArgox := nil;
  for VpfLacoNota := 0 to VpaDNotaFor.ItensNota.Count - 1 do
  begin
    VpfDItemNota := TRBDNotaFiscalForItem(VpaDNotaFor.ItensNota.Items[VpfLacoNota]);
    if VpfDItemNota.QtdEtiquetas > 0 then
    begin
      VpfDEtiquetas := TRBDEtiquetaProduto.cria;
      VpfEtiquetas.Add(VpfDEtiquetas);
      VpfDProduto := TRBDProduto.cria;
      VpfDProduto.CodEmpresa := varia.CodigoEmpresa;
      VpfDProduto.CodEmpFil := varia.CodigoEmpFil;
      VpfDProduto.SeqProduto := VpfDItemNota.SeqProduto;
      FunProdutos.CarDProduto(VpfDProduto);
      VpfDEtiquetas.Produto := VpfDProduto;
      VpfDEtiquetas.CodCor := VpfDItemNota.CodCor;
      VpfDEtiquetas.NomCor := VpfDItemNota.DesCor;
      VpfDEtiquetas.QtdEtiquetas := VpfDItemNota.QtdEtiquetas;
      VpfDEtiquetas.NumPedido := VpaDNotaFor.NumNota;
    end;
  end;
  if VpfEtiquetas.Count > 0 then
  begin
    if varia.ModeloEtiquetaNotaEntrada in [2,3,4] then
      VpfFunArgox := TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica)
    else
      if varia.ModeloEtiquetaNotaEntrada in [6] then
        VpfFunZebra := TRBFuncoesZebra.cria(Varia.PortaComunicacaoImpTermica,176,lzEPL)
      else
        if varia.ModeloEtiquetaNotaEntrada in [7] then
          VpfFunZebra := TRBFuncoesZebra.cria(Varia.PortaComunicacaoImpTermica,176,lzZPL);
    case varia.ModeloEtiquetaNotaEntrada of
      2: VpfFunArgox.ImprimeEtiquetaProduto50X25(VpfEtiquetas);
      3: VpfFunArgox.ImprimeEtiquetaKairosTexto(VpfEtiquetas);
      4: VpfFunArgox.ImprimeEtiquetaProduto54X28(VpfEtiquetas);
      6: VpfFunZebra.ImprimeEtiquetaProduto33X22(VpfEtiquetas);
      7: VpfFunZebra.ImprimeEtiquetaProduto33X57(VpfEtiquetas);
    end;
    if VpfFunArgox <> nil then
      VpfFunArgox.free;
    if VpfFunZebra <> nil then
      VpfFunZebra.free;
  end;
  FreeTObjectsList(VpfEtiquetas);
  VpfEtiquetas.free;
end;

{******************************************************************************}
procedure TFuncoesNFFor.PreencheProdutosNotaPedido(VpaListaPedidos: TList; VpaDNota: TRBDNotaFiscalFor);
var
  VpfLacoPedidos,
  VpfLacoProdutosPedido: Integer;
  VpfDPedidoCompraCorpo: TRBDPedidoCompraCorpo;
  VpfDProdutoPedido: TRBDProdutoPedidoCompra;
  VpfDNotaItem: TRBDNotaFiscalForItem;
begin
  for VpfLacoPedidos:= 0 to VpaListaPedidos.Count-1 do
  begin
    VpfDPedidoCompraCorpo:= TRBDPedidoCompraCorpo(VpaListaPedidos.Items[VpfLacoPedidos]);
    if VpfLacoPedidos = 0 then
    begin
      VpaDNota.PerDesconto := VpfDPedidoCompraCorpo.PerDesconto;
      VpaDNota.ValDesconto := VpfDPedidoCompraCorpo.ValDesconto;
    end;
    for VpfLacoProdutosPedido:= 0 to VpfDPedidoCompraCorpo.Produtos.Count-1 do
    begin
      VpfDProdutoPedido:= TRBDProdutoPedidoCompra(VpfDPedidoCompraCorpo.Produtos.Items[VpfLacoProdutosPedido]);
      if (VpfDProdutoPedido.QtdProduto-VpfDProdutoPedido.QtdBaixado) > 0 then
      begin
        VpfDNotaItem:= RProdutoNota(VpaDNota, VpfDProdutoPedido);
        if VpfDNotaItem = nil then
        begin
          VpfDNotaItem:= VpaDNota.AddNotaItem;

          VpfDNotaItem.SeqProduto:= VpfDProdutoPedido.SeqProduto;
          VpfDNotaItem.CodCor:= VpfDProdutoPedido.CodCor;
          VpfDNotaItem.CodProduto:= VpfDProdutoPedido.CodProduto;
          VpfDNotaItem.NomProduto:= VpfDProdutoPedido.NomProduto;
          VpfDNotaItem.DesCor:= VpfDProdutoPedido.NomCor;
          VpfDNotaItem.UM:= VpfDProdutoPedido.DesUM;
          VpfDNotaItem.UMOriginal:= VpfDProdutoPedido.DesUM;
          VpfDNotaItem.UnidadeParentes.Free;
          VpfDNotaItem.UnidadeParentes:= FunProdutos.RUnidadesParentes(VpfDNotaItem.UMOriginal);
          VpfDNotaItem.DesReferenciaFornecedor:= VpfDProdutoPedido.DesReferenciaFornecedor;
          VpfDNotaItem.ValUnitario:= VpfDProdutoPedido.ValUnitario;
          VpfDNotaItem.QtdProduto := 0;
          VpfDNotaItem.PerIPI := VpfDProdutoPedido.PerIPI;
          VpfDNotaItem.ValNovoVenda :=  FunProdutos.ValorDeVenda(VpfDProdutoPedido.SeqProduto,varia.TabelaPreco,VpfDProdutoPedido.CodTamanho);
        end;
        // fazer o calculo de quanto eu posso utilizar de acordo com o QTDBAIXADO
        // este campo já está sendo carregado na rotina de carregar o pedido
        VpfDNotaItem.QtdProduto:= VpfDNotaItem.QtdProduto + (VpfDProdutoPedido.QtdProduto-VpfDProdutoPedido.QtdBaixado);
        VpfDNotaItem.QtdEtiquetas := RetornaInteiro(VpfDNotaItem.QtdProduto);
      end;
    end;
  end;
end;

{******************************************************************************}
function TFuncoesNFFor.RProdutoNota(VpaDNota: TRBDNotaFiscalFor; VpaDProdutoPedido: TRBDProdutoPedidoCompra): TRBDNotaFiscalForItem;
var
  VpfLaco: Integer;
  VpfDNotaItem: TRBDNotaFiscalForItem;
begin
  Result:= nil;
  for VpfLaco:= 0 to VpaDNota.ItensNota.Count-1 do
  begin
    VpfDNotaItem:= TRBDNotaFiscalForItem(VpaDNota.ItensNota.Items[VpfLaco]);
    if (VpaDProdutoPedido.SeqProduto = VpfDNotaItem.SeqProduto) and
       (VpaDProdutoPedido.CodCor = VpfDNotaItem.CodCor) then
    begin
      Result:= VpfDNotaItem;
      Break;
    end;
  end;
end;

end.

