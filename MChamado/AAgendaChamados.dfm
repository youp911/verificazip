�
 TFAGENDACHAMADOS 0�  TPF0TFAgendaChamadosFAgendaChamadosLeftNTopRCaptionAgenda ChamadosClientHeight�ClientWidth3Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoOwnerFormCenterWindowStatewsMaximizedOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top Width3Height)AlignalTop	AlignmenttaLeftJustifyCaption   Agenda Chamados   Font.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1LeftYTop)Width� Height�AlignalRightColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TMonthCalendar
EDatInicioLeftTopWidth� Height� AlignalTopDate (�'D�M�@TabOrder OnClickEDatInicioClick  TMonthCalendarEDatFimLeftTop� Width� Height� AlignalTopDate (�'D�M�@TabOrderOnClickEDatInicioClick  TPanelColorPanelColor2LeftTop�Width� HeightAlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBFecharLeft�TopWidth� HeightCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBFecharClick   TGridIndice
GLembretesLeftTopWidth� Height� AlignalBottomColor��� 
DataSourceDataLEMBRETECORPO
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFont	PopupMenuPAgendaReadOnly	TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style OnDrawColumnCellGLembretesDrawColumnCell
OnDblClickLerlembrete1ClickAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldName	DESTITULOTitle.AlignmenttaCenterTitle.Caption	LembretesTitle.ColorclYellowWidth,Visible	     TPanelColor	PChamadosLeft Top)WidthYHeight�AlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm  	TSQLQueryAuxMaxBlobSize�Params SQLConnectionFPrincipal.BaseDados  	TSQLQueryTecnicosMaxBlobSize�Params SQLConnectionFPrincipal.BaseDadosLeft0  	TSQLQueryCadastroMaxBlobSize�Params SQLConnectionFPrincipal.BaseDadosLeftXTop	  
TPopupMenu	PopupMenuLeft`Top 	TMenuItemConsultarChamado1CaptionConsultar ChamadoOnClickConsultarChamado1Click  	TMenuItemN1Caption-  	TMenuItemSalvarConfiguraesGrade1Caption   Salvar Configurações GradeOnClickSalvarConfiguraesGrade1Click   
TPopupMenuPAgendaLeft;Top� 	TMenuItemNovoLembrete1CaptionNovo lembreteOnClickNovoLembrete1Click  	TMenuItemAlterarlembrete1CaptionAlterar lembreteOnClickAlterarlembrete1Click  	TMenuItemN2Caption-  	TMenuItemLerlembrete1CaptionLer lembreteOnClickLerlembrete1Click  	TMenuItemN3Caption-  	TMenuItemVerificarleituras1CaptionVerificar leiturasOnClickVerificarleituras1Click   TSQLLEMBRETECORPO
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.StringsXSELECT LBC.SEQLEMBRETE, To_Char(LBC.DATAGENDA)||' - '||DESTITULO DESTITULO, LBI.INDLIDO +  FROM LEMBRETECORPO LBC, LEMBRETEITEM LBI EWHERE   LBC.SEQLEMBRETE = LBI.SEQLEMBRETE (+)  AND LBI.CODUSUARIO = 2 AND (LBC.INDTODOS = 'S'      =  OR EXISTS(SELECT * FROM LEMBRETEUSUARIO LBU                l  WHERE LBU.SEQLEMBRETE = LBC.SEQLEMBRETE                AND LBU.CODUSUARIO = 2)      OR LBC.CODUSUARIO = 2)� AND (LBC.DATAGENDA IS NULL  OR LBC.DATAGENDA between to_date('26/03/2010','DD/MM/YYYY') and to_date('26/03/2010','DD/MM/YYYY')) Left� Top  TDataSourceDataLEMBRETECORPODataSetLEMBRETECORPOLeft� Top   