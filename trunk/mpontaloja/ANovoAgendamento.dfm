�
 TFNOVOAGEDAMENTO 07'  TPF0TFNovoAgedamentoFNovoAgedamentoLeft� Top� CaptionAgendamentoClientHeight�ClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top Width�Height)AlignalTop	AlignmenttaLeftJustifyCaption   Agendamento   Font.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGraExplicitTop  TPanelColorPanelColor1Left Top)Width�Height:AlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel1LeftTopWidth]Height	AlignmenttaRightJustifyCaptionData Cadastro :  TLabelLabel2LeftLTop#Width/Height	AlignmenttaRightJustifyCaption	Cliente :  TLabelLabel3LeftXTop� Width#Height	AlignmenttaRightJustifyCaptionData :  TLabelLabel5Left#Top� WidthXHeight	AlignmenttaRightJustifyCaption   Observações :  TLabelLabel6Left5Top� WidthFHeight	AlignmenttaRightJustifyCaptionHora Inicio :  TLabelLabel7LeftTop� Width=HeightCaption
Hora Fim :  TSpeedButtonBClienteLeft� TopWidthHeight
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�337�33w����s3373337?33����33333333����33333333����33s�333s33w����s337�337�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TLabelLabel10Left� Top#Width<HeightCaption                      TLabelLabel11LeftTop?WidthzHeight	AlignmenttaRightJustifyCaptionTipo Agendamento :  TSpeedButtonSpeedButton2Left� Top;WidthHeight
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�337�33w����s3373337?33����33333333����33333333����33s�333s33w����s337�337�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TLabelLabel12Left� Top?Width<HeightCaption                      TLabelLabel13LeftFTopZWidth5Height	AlignmenttaRightJustifyCaption
   Usuário :  TSpeedButtonBUsuarioLeft� TopVWidthHeight
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�337�33w����s3373337?33����33333333����33333333����33s�333s33w����s337�337�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TLabelLabel14Left� TopZWidth<HeightCaption                      
TEditColorEDatCadastroLeft� TopWidthyHeightColorclInfoBkEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder ACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro   TEditLocalizaEClienteLeft� TopWidthYHeightColor�� Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnChangeEClienteChangeACampoObrigatorio	AIgnorarCorACorFocoFPrincipal.CorFocoAInteiro ATextoLabel10ABotaoBCliente	ADataBaseFPrincipal.BaseDadosACorFormFPrincipal.CorFormACorPainelGraFPrincipal.CorPainelGra	ALocalizaConsultaPadrao1ASelectValida.StringsSelect * from CADCLIENTESWhere I_COD_CLI = @and (c_ind_cli = 'S'or c_ind_prc = 'S') ASelectLocaliza.StringsSelect * from CADCLIENTES Where C_NOM_CLI Like '@%'and (c_ind_cli = 'S'or c_ind_prc = 'S') APermitirVazio	ASomenteNumeros	AInfo.CampoCodigo	I_COD_CLIAInfo.CampoNome	C_NOM_CLIAInfo.Nome1   CódigoAInfo.Nome2NomeAInfo.Tamanho1AInfo.Tamanho2(AInfo.Tamanho3 AInfo.TituloForm   Localiza Cliente   AInfo.Cadastrar	ADarFocoDepoisdoLocaliza	  TEditLocalizaETipoAgendamentoLeft� Top;WidthYHeightColor�� Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnChangeEClienteChangeACampoObrigatorio	AIgnorarCorACorFocoFPrincipal.CorFocoAInteiro ATextoLabel12ABotaoSpeedButton2	ADataBaseFPrincipal.BaseDadosACorFormFPrincipal.CorFormACorPainelGraFPrincipal.CorPainelGra	ALocalizaConsultaPadrao1ASelectValida.StringsSelect * from TIPOAGENDAMENTOWhere CODTIPOAGENDAMENTO = @ ASelectLocaliza.StringsSelect * from TIPOAGENDAMENTO"Where NOMTIPOAGENDAMENTO Like '@%'order by NOMTIPOAGENDAMENTO APermitirVazio	ASomenteNumeros	AInfo.CampoCodigoCODTIPOAGENDAMENTOAInfo.CampoNomeNOMTIPOAGENDAMENTOAInfo.Nome1   CódigoAInfo.Nome2   DescriçãoAInfo.Tamanho1AInfo.Tamanho2(AInfo.Tamanho3 AInfo.TituloForm   Localiza Tipo Agendamento  AInfo.Cadastrar	ADarFocoDepoisdoLocaliza	OnCadastrarETipoAgendamentoCadastrar  TCalendarioEDatAgendamentoLeft� Top� WidthyHeightDate �\�A� �@Time �\�A� �@ColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACorFocoFPrincipal.CorFoco  TEditLocalizaEUsuarioLeft� TopVWidthYHeightColor�� Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnChangeEClienteChangeACampoObrigatorio	AIgnorarCorACorFocoFPrincipal.CorFocoAInteiro ATextoLabel14ABotaoBUsuario	ADataBaseFPrincipal.BaseDadosACorFormFPrincipal.CorFormACorPainelGraFPrincipal.CorPainelGra	ALocalizaConsultaPadrao1ASelectValida.StringsSelect * from CADUSUARIOSWhere I_COD_USU =  @ ASelectLocaliza.StringsSelect * from CADUSUARIOSWhere C_NOM_USU like '@%'and C_USU_ATI = 'S'order by c_nom_usu APermitirVazio	ASomenteNumeros	AInfo.CampoCodigo	I_COD_USUAInfo.CampoNome	C_NOM_USUAInfo.Nome1   CódigoAInfo.Nome2NomeAInfo.Tamanho1AInfo.Tamanho2(AInfo.Tamanho3 AInfo.TituloForm      Localiza Usuário  ADarFocoDepoisdoLocaliza	OnCadastrarETipoAgendamentoCadastrar  TMaskEditColor
EHorInicioLeft� Top� WidthyHeightColorclInfoBkEditMask
!90:00;1;_Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 	MaxLength
ParentFontTabOrderText  :  OnExitEHorInicioExitACampoObrigatorioACorFocoFPrincipal.CorFoco  TMaskEditColorEHorFimLeftXTop� WidthyHeightColorclInfoBkEditMask
!90:00;1;_Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 	MaxLength
ParentFontTabOrderText  :  ACampoObrigatorioACorFocoFPrincipal.CorFoco  
TMemoColorEObservacoesLeft� Top� Width�HeightqColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioACorFocoFPrincipal.CorFoco  TRadioButton
CRealizadoLeftToprWidthqHeightCaption	RealizadoTabOrder  TRadioButton
CARealizarLeft� ToprWidthqHeightCaption   À RealizarChecked	TabOrder	TabStop	   TPanelColorPanelColor2Left TopcWidth�Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBGravarLeft� TopWidthdHeightCaption&GravarDoubleBuffered	
Glyph.Data
�  �  BM�      v   (   $            h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  333333333333�33333  334C33333338�33333  33B$3333333�8�3333  34""C33333833�3333  3B""$33333�338�333  4"*""C3338�8�3�333  2"��"C3338�3�333  :*3:"$3338�38�8�33  3�33�"C333�33�3�33  3333:"$3333338�8�3  33333�"C333333�3�3  33333:"$3333338�8�  333333�"C333333�3�  333333:"C3333338�  3333333�#3333333��  3333333:3333333383  333333333333333333  	NumGlyphsParentDoubleBufferedTabOrder OnClickBGravarClick  TBitBtn	BCancelarLeftHTopWidthdHeightCaption	&CancelarDoubleBuffered	
Glyph.Data
�  �  BM�      v   (   $            h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  33�33333333?333333  39�33�3333��33?33  3939�338�3?��3  39��338�8��3�3  33�338�3��38�  339�333�3833�3  333�33338�33?�3  3331�33333�33833  3339�333338�3�33  333��33333833�33  33933333�33�33  33����333838�8�3  33�39333�3��3�3  33933�333��38�8�  33333393338�33���  3333333333333338�3  333333333333333333  	NumGlyphsParentDoubleBufferedTabOrderOnClickBCancelarClick  TBitBtnBFecharLeftTopWidthdHeightCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrderOnClickBFecharClick   TConsultaPadraoConsultaPadrao1
ACadastrarAAlterarLeftTop  TValidaGravacaoValidaGravacao1AComponentePanelColor1ABotaoGravarBGravarLeft(Top	   