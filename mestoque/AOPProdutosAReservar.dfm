�
 TFOPPRODUTOSARESERVAR 0�  TPF0TFOPProdutosAReservarFOPProdutosAReservarLeft� ToplCaptionProdutos a ReservarClientHeightQClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoOwnerFormCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top Width�Height)AlignalTop	AlignmenttaLeftJustifyCaption   Produtos a Reservar    Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top(Width�Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorFormExplicitLeft� ExplicitTopExplicitWidth�  TBitBtnBFecharLeft�TopWidthdHeightCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBFecharClick   TGridIndiceGridIndice1Left Top)Width�Height� AlignalClientColorclInfoBk
DataSourceDataProdutos
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldName	CODFILIALTitle.CaptionFlWidth'Visible	 Expanded	FieldNameSEQORDEMTitle.CaptionOPWidthHVisible	 Expanded	FieldName	SEQFRACAOTitle.Caption   FraçãoVisible	 Expanded	FieldName	C_NOM_CLITitle.CaptionClienteVisible	 Expanded	FieldNameQTDARESERVARTitle.CaptionQtd a ReservarVisible	    TRBSQLProdutos
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQL.StringsTselect FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO, FRA.SEQCONSUMO, FRA.QTDARESERVAR,CLI.C_NOM_CLI@from FRACAOOPCONSUMO FRA, ORDEMPRODUCAOCORPO OP, CADCLIENTES CLIwhere FRA.SEQPRODUTO = 1104905and FRA.INDBAIXADO = 'N'AND FRA.CODFILIAL = OP.EMPFILAND FRA.SEQORDEM = OP.SEQORDAND OP.CODCLI = CLI.I_COD_CLI ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.StringsTselect FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO, FRA.SEQCONSUMO, FRA.QTDARESERVAR,CLI.C_NOM_CLI@from FRACAOOPCONSUMO FRA, ORDEMPRODUCAOCORPO OP, CADCLIENTES CLIwhere FRA.SEQPRODUTO = 1104905and FRA.INDBAIXADO = 'N'AND FRA.CODFILIAL = OP.EMPFILAND FRA.SEQORDEM = OP.SEQORDAND OP.CODCLI = CLI.I_COD_CLI Leftp TFMTBCDFieldProdutosCODFILIAL	FieldName	CODFILIALRequired		Precision
Size   TFMTBCDFieldProdutosSEQORDEM	FieldNameSEQORDEMRequired		Precision
Size   TFMTBCDFieldProdutosSEQFRACAO	FieldName	SEQFRACAORequired		Precision
Size   TFMTBCDFieldProdutosSEQCONSUMO	FieldName
SEQCONSUMORequired		Precision
Size   TFMTBCDFieldProdutosQTDARESERVAR	FieldNameQTDARESERVAR	PrecisionSize  TWideStringFieldProdutosC_NOM_CLI	FieldName	C_NOM_CLISize2   TDataSourceDataProdutosDataSetProdutosLeft�    