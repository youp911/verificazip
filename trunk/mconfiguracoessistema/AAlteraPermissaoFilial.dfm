�
 TFALTERAPERMISSAOFILIAL 0<  TPF0TFAlteraPermissaoFilialFAlteraPermissaoFilialLeft� TopCaptionFAlteraPermissaoFilialClientHeight� ClientWidth-Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoOwnerFormCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top Width-Height)AlignalTop	AlignmenttaLeftJustifyCaption"      Permissão de Acesso a Filial  Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)Width-Height� AlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel1Left3TopWidth_HeightCaption   Sem permissão  TSpeedButtonDesativaLeftTop@WidthHeightHint0   Retira da Atividade|Retirar usuário da ativiadeCaption>OnClickDesativaClick  TLabelLabel2LeftTopWidth_HeightCaption   Com permissão  TSpeedButtonAtivaLeftTopXWidthHeightHint1   Coloca em Atividade|Colocar usuário em  ativiadeCaption<OnClick
AtivaClick  TDBGridColorDBGridColor1Left3Top Width� HeightyColorclInfoBk
DataSourceDataSemPermissao
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgColumnResizedgTabsdgRowSelectdgAlwaysShowSelectiondgCancelOnExit 
ParentFontTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoColumnsExpanded	FieldNameFILIALVisible	    TDBGridColorDBGridColor2LeftTop WidthHeightxColorclInfoBk
DataSourceDataComPermissao
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgColumnResize
dgColLinesdgTabsdgRowSelectdgAlwaysShowSelection 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoColumnsExpanded	FieldNameFILIALVisible	     TPanelColorPanelColor2Left Top� Width-Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBitBtn1Left�TopWidthdHeightHint%   Fechar|Fechar Atividade dos UsuáriosCancel	Caption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBitBtn1Click   TSQLComPermissao
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.Strings5Select I_EMP_FIL, I_EMP_FIL || '-'|| C_NOM_FIL FILIALFROM CADFILIAIS FIL5Where not exists(SELECT * FROM SEMPERMISSAOFILIAL SEMWHERE SEM.CODUSUARIO = 11"AND SEM.CODFILIAL = FIL.I_EMP_FIL) LeftTop  TDataSourceDataComPermissaoDataSetComPermissaoLeft0Top  TSQLSemPermissao
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.Strings5Select I_EMP_FIL, I_EMP_FIL || '-'|| C_NOM_FIL FILIALFROM CADFILIAIS FIL1Where exists(SELECT * FROM SEMPERMISSAOFILIAL SEMWHERE SEM.CODUSUARIO = 11"AND SEM.CODFILIAL = FIL.I_EMP_FIL) Left� Top  TDataSourceDataSemPermissaoDataSetSemPermissaoLeft� Top  	TSQLQueryAuxMaxBlobSize�Params SQLConnectionFPrincipal.BaseDadosLeft Top   