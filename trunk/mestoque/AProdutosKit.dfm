�
 TFPRODUTOSKIT 0�  TPF0TFProdutosKitFProdutosKitLeft5TopkHelpContext�BorderIconsbiSystemMenu CaptionProdutos do KitClientHeightlClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPanelColorPanelColor1Left Top Width�Height"AlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder AUsarCorFormACorFormFPrincipal.CorForm TLabel3DLabel3D1LeftTopWidth�Height AlignalClient	AlignmenttaCenterCaptionProdutos do KitColorclWindowFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentColor
ParentFontTransparent	ACorMoveclBlackExplicitLeft ExplicitTop   TPanelColorPanelColor2Left Top"Width�Height!AlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel1LeftTopWidthHeightCaptionKit :  TSpeedButtonSpeedButton1Left� TopWidthHeight
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�337�33w����s3373337?33����33333333����33333333����33s�333s33w����s337�337�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TLabelLabel2Left� TopWidth9HeightCaption              Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabelLabel3Left�Top Width� Height	AlignmenttaRightJustifyCaptionQuantidade em Estoque :  TLabelLabel4LeftTop WidthKHeightCaption                           TEditLocalizaKitLeft(TopWidthYHeightColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder ACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro ATextoLabel2ABotaoSpeedButton1	ADataBaseFPrincipal.BaseDadosACorFormFPrincipal.CorFormACorPainelGraFPrincipal.CorPainelGra	ALocalizaLocalizaAPermitirVazio	AInfo.CampoCodigo	C_Cod_ProAInfo.CampoNome	C_Nom_proAInfo.Nome1   CódigoAInfo.Nome2NomeAInfo.Tamanho1AInfo.Tamanho2(AInfo.Tamanho3 AInfo.TituloForm   Localiza Kit   AInfo.RetornoExtra1	C_Cod_ProADarFocoDepoisdoLocaliza	OnSelect	KitSelect	OnRetorno
KitRetorno  TDBGridColorDBGridColor1LeftTop(Width�Height� HelpContext%ColorclInfoBk
DataSource
DataMovKit
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoColumnsExpanded	FieldNameCodigoTitle.Caption   CódigoWidthlVisible	 Expanded	FieldName	C_Nom_ProTitle.CaptionNomeWidth Visible	 	AlignmenttaCenterExpanded	FieldNameQtdKitTitle.CaptionQtd KitWidthDVisible	 	AlignmenttaCenterExpanded	FieldName	C_cod_UniTitle.CaptionUnWidthVisible	 Expanded	FieldName	N_qtd_ProTitle.CaptionQtd EstoqueVisible	 	AlignmenttaRightJustifyExpanded	FieldName
ValorVendaTitle.CaptionValor VendaWidthoVisible	    	TnumericoQtdKitLeft�Top� WidthIHeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkAMascara0;-0Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontReadOnly	TabOrder   TPanelColorPanelColor3Left TopCWidth�Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBFecharLeft�TopWidthrHeightHelpContextCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBFecharClick   TConsultaPadraoLocaliza
ACadastrarAAlterarLeft�   TQueryMovKitDatabaseName	BaseDadosSQL.StringsSelect Pro.c_cod_pro Codigo W                  , pro.C_Nom_Pro, pro.C_cod_Uni, mov.N_qtd_Pro, kit.n_qtd_pro QtdKit, S                   tab.c_cif_moe + ' ' + cast(Tab.N_VLR_VEN as char) as ValorVenda ;                   from MovKit as kit, CadProdutos as Pro, >                   MovQdadeProduto as mov, MovTabelaPreco Tab ,                   Where  Kit.I_pro_kit = 255                   and kit.i_seq_pro = Pro.i_seq_pro 5                   and Mov.I_seq_pro =* pro.I_seq_pro  TStringFieldMovKitCodigo	FieldNameCodigo  TStringFieldMovKitC_Nom_Pro	FieldName	C_Nom_ProSize2  TStringFieldMovKitC_cod_Uni	FieldName	C_cod_UniSize  TFloatFieldMovKitN_qtd_Pro	FieldName	N_qtd_ProDisplayFormat###,###,##0.00  TFloatFieldMovKitQtdKit	FieldNameQtdKitDisplayFormat###,###,##0.00  TStringFieldMovKitValorVenda	FieldName
ValorVendaSize   TDataSource
DataMovKitDataSetMovKitLeft  TQueryAuxDatabaseName	BaseDadosLeft8   