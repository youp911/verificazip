�
 TFVISUALIZALOGRECEBER 0�  TPF0TFVisualizaLogReceberFVisualizaLogReceberLeftXTop`CaptionVisualiza Log ReceberClientHeightrClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top Width�Height)AlignalTop	AlignmenttaLeftJustifyCaption   Visualiza Log ReceberFont.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGraExplicitTop  TPanelColorPanelColor1Left Top)Width�HeightAlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm  TPanelColorPanelColor2Left TopIWidth�Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBFecharLeft(TopWidthdHeightCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBFecharClick   TPanelColorPanelColor3Left Top9Width�HeightAlignalClientCaptionPanelColor3ColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TGridIndiceGridIndice1LeftTopWidth�Height� AlignalClientColorclInfoBk
DataSourceDataLog
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgConfirmDeletedgCancelOnExit 
ParentFontTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldNameSEQLOGTitle.CaptionSeq.Width$Visible	 Expanded	FieldNameDATLOGTitle.CaptionDataWidth� Visible	 Expanded	FieldNameDESLOGTitle.Caption   FunçãoWidthzVisible	 Expanded	FieldName	C_NOM_USUTitle.Caption   UsuárioWidth� Visible	 Expanded	FieldName	DESMODULOTitle.Caption   MóduloWidthhVisible	 Expanded	FieldNameNOMCOMPUTADORTitle.Caption
ComputadorVisible	    TDBMemoColorDBMemoColor1LeftTop� Width�HeightoAlignalBottomColorclInfoBk	DataFieldDESINFORMACOES
DataSourceDataLogFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioACorFocoFPrincipal.CorFoco   TSQLLog
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.Strings9select LOG.SEQLOG, LOG.DATLOG, LOG.DESLOG, LOG.DESMODULO,5 LOG.NOMCOMPUTADOR, LOG.DESINFORMACOES, USU.C_NOM_USU    +from LOGCONTASARECEBER LOG, CADUSUARIOS USU$Where LOG.CODUSUARIO = USU.I_COD_USU LeftTop TFMTBCDField	LogSEQLOG	FieldNameSEQLOGOrigin"BASEDADOS.LOGCONTASARECEBER.SEQLOG  TSQLTimeStampField	LogDATLOG	FieldNameDATLOGOrigin"BASEDADOS.LOGCONTASARECEBER.DATLOG  TWideStringField	LogDESLOG	FieldNameDESLOGOrigin"BASEDADOS.LOGCONTASARECEBER.DESLOGSize  TWideStringFieldLogDESMODULO	FieldName	DESMODULOOrigin%BASEDADOS.LOGCONTASARECEBER.DESMODULO  TWideStringFieldLogNOMCOMPUTADOR	FieldNameNOMCOMPUTADOROrigin)BASEDADOS.LOGCONTASARECEBER.NOMCOMPUTADOR  TWideStringFieldLogDESINFORMACOES	FieldNameDESINFORMACOESOrigin*BASEDADOS.LOGCONTASARECEBER.DESINFORMACOESSize  TWideStringFieldLogC_NOM_USU	FieldName	C_NOM_USUOriginBASEDADOS.CADUSUARIOS.C_NOM_USUSize<   TDataSourceDataLogDataSetLogLeft0Top   