�
 TFAMOSTRASPENDENTES 0m  TPF0TFAmostrasPendentesFAmostrasPendentesLeft+Top� CaptionAmostras PendentesClientHeight�ClientWidthColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoOwnerFormCenterWindowStatewsMaximizedOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top WidthHeight)AlignalTop	AlignmenttaLeftJustifyCaption   Amostras Pendentes   Font.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)WidthHeight�AlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TGridIndiceGridIndice1LeftTopWidthHeightxAlignalClientColorclInfoBk
DataSourceDataAmostras
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFont	PopupMenu
PopupMenu1TabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldName
CODAMOSTRATitle.Caption   CódigoVisible	 Expanded	FieldName
NOMAMOSTRATitle.CaptionNomeVisible	 Expanded	FieldNameDepartamentoWidthVisible	 Expanded	FieldName
QTDAMOSTRATitle.CaptionQtd AmostraVisible	 Expanded	FieldName
DATAMOSTRATitle.Caption   Data EmissãoVisible	 Expanded	FieldNameDATENTREGACLIENTETitle.Caption   Previsão EntregaVisible	 Expanded	FieldName	C_NOM_VENTitle.CaptionVendedorVisible	 Expanded	FieldName	C_NOM_CLITitle.CaptionClienteVisible	    TPanelColorPanelColor3LeftTopWidthHeightAlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel1LeftTopWidth\Height	AlignmenttaRightJustifyCaptionDepartamento :  TComboBoxColorEDepartamentoLeftpTopWidthHeightStylecsDropDownListColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ItemHeight
ParentFontTabOrder OnClickEDepartamentoClickItems.StringsDesenvolvimento   Ficha TécnicaAmostrasTodos ACampoObrigatorioACorFocoFPrincipal.CorFoco    TPanelColorPanelColor2Left Top�WidthHeight)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBFecharLeft�TopWidthdHeightCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBFecharClick   TSQLAmostras
Aggregates PacketRecordsParams ProviderNameInternalProviderOnCalcFieldsAmostrasCalcFieldsASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.Strings>SELECT CODAMOSTRA, NOMAMOSTRA, DATAMOSTRA, DATENTREGACLIENTE, %AMO.QTDAMOSTRA,  AMO.DESDEPARTAMENTO,VEN.C_NOM_VEN, CLI.C_NOM_CLI    4FROM AMOSTRA AMO, CADVENDEDORES VEN, CADCLIENTES CLIWHERE AMO.DATENTREGA IS NULLAND AMO.TIPAMOSTRA = 'I'$AND AMO.CODVENDEDOR = VEN.I_COD_VEN "AND AMO.CODCLIENTE = CLI.I_COD_CLI  TFMTBCDFieldAmostrasCODAMOSTRA	FieldName
CODAMOSTRAOriginBASEDADOS.AMOSTRA.CODAMOSTRA  TWideStringFieldAmostrasNOMAMOSTRA	FieldName
NOMAMOSTRAOriginBASEDADOS.AMOSTRA.NOMAMOSTRASize2  TSQLTimeStampFieldAmostrasDATAMOSTRA	FieldName
DATAMOSTRAOriginBASEDADOS.AMOSTRA.DATAMOSTRA  TSQLTimeStampFieldAmostrasDATENTREGACLIENTE	FieldNameDATENTREGACLIENTEOrigin#BASEDADOS.AMOSTRA.DATENTREGACLIENTE  TWideStringFieldAmostrasC_NOM_VEN	FieldName	C_NOM_VENOrigin!BASEDADOS.CADVENDEDORES.C_NOM_VENSize2  TWideStringFieldAmostrasC_NOM_CLI	FieldName	C_NOM_CLIOriginBASEDADOS.CADCLIENTES.C_NOM_CLISize2  TFMTBCDFieldAmostrasQTDAMOSTRA	FieldName
QTDAMOSTRAOriginBASEDADOS.AMOSTRA.QTDAMOSTRA  TWideStringFieldAmostrasDepartamento	FieldKindfkCalculated	FieldNameDepartamento
Calculated	  TWideStringFieldAmostrasDESDEPARTAMENTO	FieldNameDESDEPARTAMENTOOrigin!BASEDADOS.AMOSTRA.DESDEPARTAMENTOSize   TDataSourceDataAmostrasDataSetAmostrasLeft   
TPopupMenu
PopupMenu1Left� Topy 	TMenuItemMConsultaAmostraCaptionConsulta Amostras RealizadasOnClickMConsultaAmostraClick  	TMenuItemN1Caption-  	TMenuItemMConcluiAmostraCaptionConclui AmostraOnClickMConcluiAmostraClick    