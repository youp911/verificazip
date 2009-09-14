unit AImprimeEtiquetaBarra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Tabela, QuickRpt, ExtCtrls, Geradores, UnImpressao,
  Qrctrls, StdCtrls, Buttons, DBClient;

type
  TFImprimeEtiquetaBarra = class(TFormularioPermissao)
    Pagina: TQuickRepNovo;
    Etiqueta: TQRBand;
    CAD_DOC: TSQL;
    CAD_DOCN_ALT_ETI: TFloatField;
    CAD_DOCN_ESP_VER: TFloatField;
    CAD_DOCN_ESP_HOR: TFloatField;
    CAD_DOCN_MAR_SUP: TFloatField;
    CAD_DOCN_MAR_INF: TFloatField;
    CAD_DOCN_LIN_ETI: TFloatField;
    CAD_DOCI_TAM_BAR: TFloatField;
    CAD_DOCI_NRO_DOC: TIntegerField;
    CAD_DOCC_NOM_DOC: TStringField;
    CAD_DOCC_TIP_DOC: TStringField;
    CAD_DOCD_DAT_DOC: TDateField;
    CAD_DOCN_COM_ETI: TFloatField;
    CAD_DOCN_COL_ETI: TFloatField;
    CAD_DOCN_MAR_ESQ: TFloatField;
    CAD_DOCI_ALT_BAR: TIntegerField;
    CAD_DOCI_COD_BAR: TIntegerField;
    MOV_DOC: TQuery;
    MOV_DOCI_NRO_DOC: TIntegerField;
    MOV_DOCI_MOV_SEQ: TIntegerField;
    MOV_DOCN_POS_HOR: TFloatField;
    MOV_DOCN_POS_VER: TFloatField;
    MOV_DOCC_FLA_IMP: TStringField;
    MOV_DOCC_DES_CAM: TStringField;
    MOV_DOCC_DIR_ESQ: TStringField;
    MOV_DOCI_TAM_CAM: TIntegerField;
    MOV_DOCC_FLA_NEG: TStringField;
    MOV_DOCC_FLA_ITA: TStringField;
    MOV_DOCC_FLA_CND: TStringField;
    MOV_DOCC_FLA_RED: TStringField;
    QValor: TQRDBText;
    QNome: TQRDBText;
    QData: TQRDBText;
    Produtos: TQuery;
    Aux: TQuery;
    CAD_DOCN_MAR_DIR: TFloatField;
    CAD_DOCC_IMP_COD: TStringField;
    ProdutosNomeProduto: TStringField;
    ProdutosC_cod_bar: TStringField;
    ProdutosValorVenda: TFloatField;
    ProdutosData: TDateTimeField;
    ProdutosValorCusto: TFloatField;
    QCusto: TQRDBText;
    CAD_DOCN_DIV_CUS: TFloatField;
    CAD_DOCC_CRI_DAT: TStringField;
    ProdutosData_Cri: TStringField;
    BOK: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOKClick(Sender: TObject);
  private
    IMP : TFuncoesImpressao;
    procedure ConfiguraComponent( Comp : TWinControl ) ;
    procedure ConfiguraDocumento( NroDocumento : Integer; TipoBarra : Integer );  //  tipo da barra  0 = EAN_8;    1 = EAN_13;    2 = CODE128_A;    3 = CODE128_B;    4 = CODE128_C;

    procedure CriaProdutos( QtdProdutos, PosInicial, SeqPro : Integer );
    procedure AbreTabelaProdutos( SeqPro : Integer );
  public
    procedure ImprimeBarra(NroDocumento, QtdEtiqueta, PosInicial, TipoBarra, SeqPro : Integer );  //  tipo da barra  0 = EAN_8;    1 = EAN_13;    2 = CODE128_A;    3 = CODE128_B;    4 = CODE128_C;
    procedure VisualizaBarra(NroDocumento, TipoBarra, SeqPro : Integer );
  end;

var
  FImprimeEtiquetaBarra: TFImprimeEtiquetaBarra;

implementation

uses APrincipal, funsql, constantes, funstring, constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeEtiquetaBarra.FormCreate(Sender: TObject);
begin
  IMP := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeEtiquetaBarra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IMP.Free;
  Action := CaFree;
end;

{*************** configura os componentes ********************************** }
procedure TFImprimeEtiquetaBarra.ConfiguraComponent( Comp : TWinControl ) ;
var
  AtributoFonte : TFontStyles;
begin

   Comp.Visible := MOV_DOCC_FLA_IMP.AsString = 'S';
   Comp.Enabled := MOV_DOCC_FLA_IMP.AsString = 'S';
   Comp.Top := trunc(MOV_DOCN_POS_VER.AsInteger *3.1);
   Comp.Left := trunc(MOV_DOCN_POS_HOR.AsInteger*3.1);

   // caso TQRDBText
   if ( Comp is TQRDBText ) then
   begin
     AtributoFonte := [];
     if MOV_DOCC_FLA_NEG.AsString = 'S' then
       AtributoFonte := [ fsBold ];
     if MOV_DOCC_FLA_ITA.AsString = 'S' then
       AtributoFonte := AtributoFonte + [ fsItalic ];
     ( Comp as TQRDBText ).Font.Style := AtributoFonte;
     ( Comp as TQRDBText ).Font.Size := MOV_DOCI_TAM_CAM.AsInteger;

     ( Comp as TQRDBText ).Size.Width := Etiqueta.Size.Width - ( Comp as TQRDBText ).Size.Left - 2;
   end;
end;

{******************* configura o documento ********************************** }
procedure TFImprimeEtiquetaBarra.ConfiguraDocumento( NroDocumento : Integer; TipoBarra : Integer );
begin
{  // abre tabela do documento etiqueta
  IMP.LocalizaCab(CAD_DOC, NroDocumento);
  IMP.LocalizaItems(MOV_DOC, NroDocumento);

  // tamanho pagina
  pagina.Page.Width := CAD_DOCN_MAR_ESQ.AsFloat + CAD_DOCN_MAR_DIR.AsFloat +
                       ( CAD_DOCN_COL_ETI.AsFloat * CAD_DOCN_COM_ETI.AsFloat ) +
                       ( ( CAD_DOCN_COL_ETI.AsFloat - 1 ) * CAD_DOCN_ESP_VER.AsFloat);

  pagina.Page.Length := CAD_DOCN_MAR_SUP.AsFloat +  CAD_DOCN_MAR_INF.AsFloat +
                        ( CAD_DOCN_LIN_ETI.AsFloat * CAD_DOCN_ALT_ETI.AsFloat ) +
                        ((CAD_DOCN_LIN_ETI.AsFloat - 1  ) * CAD_DOCN_ESP_HOR.AsFloat) ;

  // magens da pagina
  Pagina.Page.TopMargin :=  CAD_DOCN_MAR_SUP.AsFloat;
  Pagina.page.LeftMargin := CAD_DOCN_MAR_ESQ.AsFloat;
  Pagina.page.RightMargin := CAD_DOCN_MAR_DIR.AsFloat;
  Pagina.Page.BottomMargin := CAD_DOCN_MAR_INF.AsFloat;


  // tamanho etiqueta
  Etiqueta.Size.Height := CAD_DOCN_ALT_ETI.AsFloat + CAD_DOCN_ESP_HOR.AsFloat;
  Etiqueta.Size.Width := CAD_DOCN_COM_ETI.AsFloat;

  // espacos da etique/ quantidade
  pagina.Page.Columns := CAD_DOCN_COL_ETI.AsInteger;
  pagina.Page.ColumnSpace := CAD_DOCN_ESP_VER.AsFloat;

  // nome, preco, data
  MOV_DOC.First;
  while not MOV_DOC.Eof do
  begin
    case MOV_DOCI_MOV_SEQ.AsInteger of
      1 : Begin
            ConfiguraComponent(Barra);
            Barra.Bar_HumanReadable := CAD_DOCC_IMP_COD.AsString = 'S';

          end;
      2 : ConfiguraComponent(QNome);
      3 : ConfiguraComponent(QValor);
      4 : ConfiguraComponent(QData);
      5 : ConfiguraComponent(QCusto);
    end;
    MOV_DOC.Next;
  end;

 // tamanho da barra
  case CAD_DOCI_TAM_BAR.AsInteger of
    0 : barra.Bar_ModuleWidth := SC0;
    1 : barra.Bar_ModuleWidth := SC1;
    2 : barra.Bar_ModuleWidth := SC2;
    3 : barra.Bar_ModuleWidth := SC3;
    4 : barra.Bar_ModuleWidth := SC4;
    5 : barra.Bar_ModuleWidth := SC5;
    6 : barra.Bar_ModuleWidth := SC6;
    7 : barra.Bar_ModuleWidth := SC7;
    8 : barra.Bar_ModuleWidth := SC8;
    9 : barra.Bar_ModuleWidth := SC9;
  end;

  // tipo da barra
  case TipoBarra of
    0 :  barra.Bar_CodeType := EAN_8;
    1 :  barra.Bar_CodeType := EAN_13;
    2 :  barra.Bar_CodeType := CODE128_A;
    3 :  barra.Bar_CodeType := CODE128_B;
    4 :  barra.Bar_CodeType := CODE128_C;
  end;

  // altura da barra
  if CAD_DOCI_ALT_BAR.AsInteger <> 0 then
    Barra.Bar_HeightPercent := CAD_DOCI_ALT_BAR.AsInteger;
 }
end;

{************* cria a tabela temporaria conforme qtd produtos **************** }
procedure TFImprimeEtiquetaBarra.CriaProdutos( QtdProdutos, PosInicial, SeqPro  : Integer );
var
  laco : Integer;
begin
  LimpaSQLTabela(Aux);
  AdicionaSQLTabela(Aux, ' DELETE TEMPORARIABARRA ' );
  Aux.ExecSQL;

  for laco := 1 to PosInicial -1 do
  begin
    LimpaSQLTabela(Aux);
    AdicionaSQLTabela(Aux, ' INSERT INTO TEMPORARIABARRA ( I_SEQ_PRO ) ' +
                                ' VALUES ( 0 ) ');
    Aux.ExecSQL;
  end;

  for laco := 1 to QtdProdutos do
  begin
    LimpaSQLTabela(Aux);
    AdicionaSQLTabela(Aux, ' INSERT INTO TEMPORARIABARRA ( I_SEQ_PRO ) ' +
                                ' VALUES ( ' + IntToStr(seqPro) + ' ) ');
    Aux.ExecSQL;
  end;

end;

{************* abre a tabela de produtos ************************************ }
procedure TFImprimeEtiquetaBarra.AbreTabelaProdutos( SeqPro : Integer );
var
  Custo : string;
begin
  if CAD_DOCN_DIV_CUS.AsCurrency <> 0 then
    custo := ' ( mov.n_vlr_com / ' + SubstituiStr(CAD_DOCN_DIV_CUS.AsString,',','.')  + ' )' +  ' ValorCusto, '
  else
    Custo := ' mov.n_vlr_com ValorCusto,';

  LimpaSQLTabela(Produtos);
  AdicionaSQLTabela(Produtos,
                              ' select pro.c_nom_pro NomeProduto, mov.C_cod_bar, '+
                              ' tab.n_vlr_ven ValorVenda, ' +  custo  +
                              ' IFNULL(pro.i_seq_pro, pro.i_seq_pro, TODAY (*))  Data, ' +
                              ' IFNULL(pro.i_seq_pro, cast(pro.i_seq_pro as char), Upper(Left(PRO.C_NOM_PRO,1)) || MONTH(Today(*)) || ''-'' || '+
                              ' RigHT(YEAR(TODAY(*)),1) || ''/'' ||DAY(Today(*))) Data_Cri' +
                              ' from ' +
                              ' TEMPORARIABARRA Temp, cadprodutos  pro, MovQdadeProduto  mov, ' +
                              ' MovTabelaPreco  Tab ' +
                              ' where pro. i_seq_pro = ' + IntToStr(SeqPro)  +
                              ' and  pro.i_cod_emp =  ' +  InttoStr(Varia.CodigoEmpresa)  +
                              ' and temp.i_seq_pro *= pro.i_seq_pro ' +
                              ' and temp.i_seq_pro *= mov.i_seq_pro ' +
                              ' and mov.i_emp_fil =  ' + IntToStr(varia.CodigoEmpFil)  +
                              ' and temp.I_seq_pro *= tab.i_seq_pro ' +
                              ' and Tab.I_cod_tab =  ' + IntToStr(Varia.TabelaPreco)  +
                              ' and tab.i_cod_emp = ' + InttoStr(Varia.CodigoEmpresa) +
                              ' and TAB.I_COD_CLI = 0 '+
                              ' order by Temp.i_seq_pro');
   AbreTabela(Produtos);

end;

{***************** imprime o codigo de barra de um produto ******************* }
procedure TFImprimeEtiquetaBarra.ImprimeBarra(NroDocumento, QtdEtiqueta, PosInicial, TipoBarra, SeqPro : Integer );
begin
 ConfiguraDocumento(NroDocumento, TipoBarra);
 CriaProdutos(QtdEtiqueta,PosInicial, SeqPro );
 if CAD_DOCC_CRI_DAT.AsString = 'S' then
   QData.DataField :=  'Data_Cri';

 AbreTabelaProdutos( SeqPro );
end;

{****************** visualiza a etiqueta do produto ************************** }
procedure TFImprimeEtiquetaBarra.VisualizaBarra( NroDocumento, TipoBarra, SeqPro : Integer );
begin
 ConfiguraDocumento(NroDocumento, TipoBarra);
 if not Produtos.Active then
   CriaProdutos(1,0,seqpro);
 AbreTabelaProdutos( SeqPro );
end;

{************* fecha o formulario ******************************************* }
procedure TFImprimeEtiquetaBarra.BOKClick(Sender: TObject);
begin
  self.close;
end;

Initialization
 RegisterClasses([TFImprimeEtiquetaBarra]);
end.
