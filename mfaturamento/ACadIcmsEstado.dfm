�
 TFCADICMSESTADO 0�1  TPF0TFCadIcmsEstadoFCadIcmsEstadoLeft~Top6HintCadastro e consulta de icmsHelpContextzBorderIconsbiSystemMenu CaptionICMSClientHeight�ClientWidthColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top WidthHeight)AlignalTop	AlignmenttaLeftJustifyCaption
   ICMS   Font.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)Width�Height�AlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel1LeftvTop!Width1Height	AlignmenttaRightJustifyCaptionEstado :  TLabelLabel2LeftNTopUWidthXHeight	AlignmenttaRightJustifyCaptionInter-Estadual :  TLabelLabel4LeftITop;Width^Height	AlignmenttaRightJustifyCaptionICMS Estadual :  TBevelBevel1Left Top� Width�Height
Shape	bsTopLine  TLabelLabel3LeftTop� WidthHeightCaptionNome para consulta :  TLabelLabel10LefthTopWidth=Height	AlignmenttaRightJustifyCaption	Empresa :  TSpeedButtonSpeedButton9Left� TopWidthHeight
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�337�33w����s3373337?33����33333333����33333333����33s�333s33w����s337�337�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TLabelLabel12LeftTopWidth� HeightCaption8                                                          TLabelLabel5LeftTopoWidth� Height	AlignmenttaRightJustifyCaption   Redução Base Calculo :  TDBComboBoxUFDBComboBoxUF1Left� TopWidth1HeightColor�� 	DataField	C_COD_EST
DataSourceDataCadIcmsEstadoFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnChangeDBComboBoxUF1ChangeACampoObrigatorio	ACorFocoFPrincipal.CorFoco  TDBEditColorDBEditColor1Left� TopQWidthaHeightColor�� 	DataField	N_ICM_EXT
DataSourceDataCadIcmsEstadoFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnChangeDBComboBoxUF1ChangeACampoObrigatorio	AIgnorarCorACorFocoFPrincipal.CorFocoAFormatoDataAIgnorarTipoLetra  TDBEditColorDBEditColor3Left� Top7WidthaHeightColor�� 	DataField	N_ICM_INT
DataSourceDataCadIcmsEstadoFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnChangeDBComboBoxUF1ChangeACampoObrigatorio	AIgnorarCorACorFocoFPrincipal.CorFocoAFormatoDataAIgnorarTipoLetra  TDBGridColorDBGridColor1LeftTop� WidthoHeight� HelpContext%ColorclInfoBk
DataSourceDataCadIcmsEstadoDrawingStyle
gdsClassic
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoColumns	AlignmenttaCenterExpanded	FieldName	C_COD_ESTTitle.CaptionEstadoWidth:Visible	 	AlignmenttaCenterExpanded	FieldName	N_ICM_INTTitle.CaptionInter-EstadualWidth^Visible	 	AlignmenttaCenterExpanded	FieldName	N_ICM_EXTTitle.CaptionInternaWidthhVisible	 Expanded	FieldName	N_RED_ICMTitle.Caption   % ReduçãoVisible	    TLocalizaEditConsultaLeftTop� WidthoHeightHelpContext$ColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro ATabelaCadIcmsEstadoASelect.Strings Select * from dba.CadIcmsestadosWhere C_Cod_est like '@%' AOrdemorder by c_Cod_est  TDBEditLocalizaECodEmpresaLeft� TopWidthDHeightColor�� 	DataField	I_COD_EMP
DataSourceDataCadIcmsEstadoFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontReadOnly	TabOrder ACampoObrigatorio	AIgnorarCorACorFocoFPrincipal.CorFocoAFormatoDataAIgnorarTipoLetraATextoLabel12ABotaoSpeedButton9	ADataBaseFPrincipal.BaseDados	ALocalizaConsultaPadrao1ASelectValida.Strings-select * from CadEMPRESAS where I_COD_EMP = @ ASelectLocaliza.StringsSelect * from CADEMPRESASWhere C_NOM_EMP like '@%' ACorFormFPrincipal.CorFormAPermitirVazio	AInfo.CampoCodigo	I_COD_EMPAInfo.CampoNome	C_NOM_EMPAInfo.Nome1   CódigoAInfo.Nome2NomeAInfo.Tamanho1AInfo.Tamanho2(AInfo.Tamanho3 AInfo.TituloForm   Localiza Empresa     TDBEditColorDBEditColor2Left� TopkWidthaHeightColorclInfoBk	DataField	N_RED_ICM
DataSourceDataCadIcmsEstadoFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnChangeDBComboBoxUF1ChangeACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoDataAIgnorarTipoLetra  TDBCheckBoxDBCheckBox1Left� Top� Width� HeightCaption#   Convenio Substituição Tributária	DataField	C_SUB_TRI
DataSourceDataCadIcmsEstadoTabOrderValueCheckedTrueValueUncheckedFalse   TPanelColorPanelColor2Left�Top)WidthxHeight�AlignalRightColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBotaoGravarBotaoGravar1Left
Top� WidthdHeightHintGravar|Grava no registroHelpContextCaption&GravarDoubleBuffered	Enabled
Glyph.Data
�  �  BM�      v   (   $            h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  333333333333�33333  334C33333338�33333  33B$3333333�8�3333  34""C33333833�3333  3B""$33333�338�333  4"*""C3338�8�3�333  2"��"C3338�3�333  :*3:"$3338�38�8�33  3�33�"C333�33�3�33  3333:"$3333338�8�3  33333�"C333333�3�3  33333:"$3333338�8�  333333�"C333333�3�  333333:"C3333338�  3333333�#3333333��  3333333:3333333383  333333333333333333  	NumGlyphsParentDoubleBufferedTabOrderAFecharAposOperacao  TBotaoCadastrarBotaoCadastrar1Left
TopPWidthdHeightHintIncluir|Incluir novo registroHelpContextCaption
&CadastrarDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333�33;3�3333�;�w{�w{�7����s3�    33wwwwww330����337�333330����337��?�330����337�sws330����3?����?��������ww�wssw;������7w��?�ww30��  337�swws330���3337��7�330��3337�sw�330�� ;�337��w7�3�  3�33www3w�;�3;�3;�7s37s37s�33;333;s3373337	NumGlyphsParentDoubleBufferedTabOrder   TMoveBasicoMoveBasico1Left
TopWidthdHeightHelpContextAProximoCaption AProximoBitmap.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 33333333?�333333Ds333333w��33333tDs333337w?�33334DDs33337?w?�3333DDDs3333s�w?�333tDDDs3337�3w?�334DDDDs337?33w?�33DDDDDs?����w���������wwwwww3w33�����333s33?w33<����3337�3?w333<���333373?w3333���33333s?w3333<��333337�w33333<�3333337w333333�3333333w3333333AAnteriorCaption AAnteriorBitmap.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 333333333333333�3333337D333333�s333337DG33333�w�33337DDC3333�s733337DDD3333�s3s3337DDDG333�s37�337DDDDC33�s337337DDDDD337�������������s7wwwwws3�����337s�33s�333�����337s�37�3333����3337s�7?33333���33337s�s�33333���33337s��333333��333337w�3333333�3333337scaptionMoveBasico1  TBotaoAlterarBotaoAlterar1Left
TopmWidthdHeightHint#Alterar|Altera registro selecionadoHelpContextCaption&AlterarDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� P    UUUWwwww_UU����UUUUU_�_���   UUUwwuw��𿿰_UW��Ww�� ��u�WwUUw����Wu��Uw�  ��WWwwUUw�����Uu����w��   �UWwwwUw�� �� UUuw��w��� UUUWWwuU���UU���uu�U ����UUw�����_UPppppUW����u�PppppP�UWWWWWWwUUUuuuuuUuU	NumGlyphsParentDoubleBufferedTabOrderAFocoDBEditColor3  TBotaoExcluirBotaoExcluir1Left
Top� WidthdHeightHint"Excluir|Exclui registro seleciondoHelpContextCaption&ExcluirDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� P  UUUWwwuU�U    UPUUwwwwU�UU U PUUUw�wWUUU UPUUUUw�W_�UUPP UUUW�uw�UUU PPUUUw�Ww�UUU	�UUU�uwww�UPU	��UW_wwwu�PP��0UWu�wwW_U PU	UwWUwuuuUUUUP��0UU_UWWWWUUUU3UUuUUuuUUUUUUP��UU�UUW_UUPUUUU�UWUUUUu�UUUUUUP�UUUUUUW_UUUUUUUUUUUUUUu	NumGlyphsParentDoubleBufferedTabOrderATextoExcluirCadIcmsEstadoC_COD_EST  TBotaoCancelarBotaoCancelar1Left
TopWidthdHeightHint!   Cancelar|Cancela operação atualHelpContextCancel	Caption	&CancelarDoubleBuffered	Enabled
Glyph.Data
�  �  BM�      v   (   $            h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  33�33333333?333333  39�33�3333��33?33  3939�338�3?��3  39��338�8��3�3  33�338�3��38�  339�333�3833�3  333�33338�33?�3  3331�33333�33833  3339�333338�3�33  333��33333833�33  33933333�33�33  33����333838�8�3  33�39333�3��3�3  33933�333��38�8�  33333393338�33���  3333333333333338�3  333333333333333333  	NumGlyphsParentDoubleBufferedTabOrderAFecharAposOperacao  TBitBtnBFecharLeft
Top�WidthdHeightHelpContextCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrderOnClickBFecharClick   TDataSourceDataCadIcmsEstadoAutoEditDataSetCadIcmsEstadoLeft.Top  TSQLCadIcmsEstado
Aggregates Params ProviderNameInternalProvider	AfterOpenCadIcmsEstadoAfterOpenAfterInsertCadIcmsEstadoAfterInsert
BeforePostCadIcmsEstadoBeforePost	AfterPostCadIcmsEstadoAfterPostAfterScrollCadIcmsEstadoAfterScroll
ABarraMoveMoveBasico1AGravarBotaoGravar1	ACancelarBotaoCancelar1AAlterarBotaoAlterar1AExcluirBotaoExcluir1
ACadastrarBotaoCadastrar1ASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQL.StringsSelect * from CadIcmsestados ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.StringsSelect * from CadIcmsestados Left TWideStringFieldCadIcmsEstadoC_COD_EST	FieldName	C_COD_ESTOriginCADICMSESTADOS.C_COD_ESTSize  TFMTBCDFieldCadIcmsEstadoN_ICM_INT	FieldName	N_ICM_INTOriginCADICMSESTADOS.N_ICM_INTDisplayFormat
#,##0.00 %
EditFormat#,##0.00  TFMTBCDFieldCadIcmsEstadoN_ICM_EXT	FieldName	N_ICM_EXTOriginCADICMSESTADOS.N_ICM_EXTDisplayFormat
#,##0.00 %
EditFormat#,##0.00  TSQLTimeStampFieldCadIcmsEstadoD_ULT_ALT	FieldName	D_ULT_ALTOriginCADICMSESTADOS.D_ULT_ALT  TFMTBCDFieldCadIcmsEstadoI_COD_EMP	FieldName	I_COD_EMPOrigin"BASEDADOS.CADICMSESTADOS.I_COD_EMP  TFMTBCDFieldCadIcmsEstadoN_RED_ICM	FieldName	N_RED_ICMDisplayFormat#,##0.00	PrecisionSize  TWideStringFieldCadIcmsEstadoC_SUB_TRI	FieldName	C_SUB_TRI	FixedChar	Size   TValidaGravacaoValidaGravacao1AComponentePanelColor1ABotaoGravarBotaoGravar1LeftP  TConsultaPadraoConsultaPadrao1
ACadastrarAAlterarLeft� Top   