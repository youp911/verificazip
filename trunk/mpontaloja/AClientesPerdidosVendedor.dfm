�
 TFCLIENTESPERDIDOSVENEDOR 0�  TPF0TFClientesPerdidosVenedorFClientesPerdidosVenedorLeftTop� CaptionClientes Perdidos VendedorClientHeight�ClientWidthkColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoOwnerFormCenterWindowStatewsMaximizedOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top WidthkHeight)AlignalTop	AlignmenttaLeftJustifyCaption    Clientes Perdidos Vendedor   Font.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)WidthkHeight)AlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel1LeftTopWidthIHeightCaption   Período de :  TLabelLabel2Left� TopWidthHeightCaption   até :  TCalendarioEDatInicialLeftXTopWidthaHeightDate ��� U��@Time ��� U��@ColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder 	OnCloseUpEDatInicialCloseUpOnExitEDatInicialCloseUpACorFocoFPrincipal.CorFoco  TCalendario	EDatFinalLeft� TopWidthaHeightDate ���#U��@Time ���#U��@ColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder	OnCloseUpEDatInicialCloseUpOnExitEDatInicialCloseUpACorFocoFPrincipal.CorFoco   TPanelColorPanelColor2Left TopmWidthkHeight)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtn
BCadastrarLeftTopWidthdHeightCaption
&CadastrarDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333�33;3�3333�;�w{�w{�7����s3�    33wwwwww330����337�333330����337��?�330����337�sws330����3?����?��������ww�wssw;������7w��?�ww30��  337�swws330���3337��7�330��3337�sw�330�� ;�337��w7�3�  3�33www3w�;�3;�3;�7s37s37s�33;333;s3373337	NumGlyphsParentDoubleBufferedTabOrder OnClickBCadastrarClick  TBitBtnBFecharLeft�TopWidthdHeightCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrderOnClickBFecharClick  TBitBtnBImpVendedoresLeft� TopWidthiHeightCaption&VendedoresDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 0      ?��������������wwwwwww�������wwwwwww        ���������������wwwwwww�������wwwwwww�������wwwwww        wwwwwww30����337���?330� 337�wss330����337��?�330�  337�swws330���3337��73330��3337�ss3330�� 33337��w33330  33337wws333	NumGlyphsParentDoubleBufferedTabOrderOnClickBImpVendedoresClick  TBitBtnBImpClientesLeft TopWidthdHeightCaption	&ClientesDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 0      ?��������������wwwwwww�������wwwwwww        ���������������wwwwwww�������wwwwwww�������wwwwww        wwwwwww30����337���?330� 337�wss330����337��?�330�  337�swws330���3337��73330��3337�ss3330�� 33337��w33330  33337wws333	NumGlyphsParentDoubleBufferedTabOrderOnClickBImpClientesClick   TGridIndiceGridIndice1Left TopRWidthkHeightAlignalClientColorclInfoBk
DataSourceDataClientePerdido
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldName
SEQPERDIDOTitle.Caption
SequencialVisible	 Expanded	FieldName
DATPERDIDOTitle.CaptionDataVisible	 Expanded	FieldNameQTDDIATitle.CaptionQtd Dias s/ PedidoVisible	 Expanded	FieldName	C_NOM_VENTitle.CaptionVendedor DestinoWidth� Visible	 Expanded	FieldName	C_NOM_USUTitle.Caption   UsuárioWidth� Visible	    TSQLClientePerdido
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.Strings3Select PER.SEQPERDIDO,  PER.DATPERDIDO, PER.QTDDIA,  USU.C_NOM_USU,  VEN.C_NOM_VEN    1FROM CLIENTEPERDIDOVENDEDOR PER, CADUSUARIOS USU,         CADVENDEDORES VEN$Where USU.I_COD_USU = PER.CODUSUARIO*and VEN.I_COD_VEN = PER.CODVENDEDORDESTINO LeftxTop TFMTBCDFieldClientePerdidoSEQPERDIDO	FieldName
SEQPERDIDOOrigin+BASEDADOS.CLIENTEPERDIDOVENDEDOR.SEQPERDIDO  TSQLTimeStampFieldClientePerdidoDATPERDIDO	FieldName
DATPERDIDOOrigin+BASEDADOS.CLIENTEPERDIDOVENDEDOR.DATPERDIDO  TFMTBCDFieldClientePerdidoQTDDIA	FieldNameQTDDIAOrigin'BASEDADOS.CLIENTEPERDIDOVENDEDOR.QTDDIA  TWideStringFieldClientePerdidoC_NOM_USU	FieldName	C_NOM_USUOriginBASEDADOS.CADUSUARIOS.C_NOM_USUSize<  TWideStringFieldClientePerdidoC_NOM_VEN	FieldName	C_NOM_VENOrigin!BASEDADOS.CADVENDEDORES.C_NOM_VENSize2   TDataSourceDataClientePerdidoDataSetClientePerdidoLeft�Top   