�
 TFCONDICOESPAGAMENTOS 0�b  TPF0TFCondicoesPagamentosFCondicoesPagamentosLeft!TopDHint.   Cadastro e consulta de condição de pagamentoHelpContext�BorderIconsbiSystemMenu Caption   Condições PagamentosClientHeight�ClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPanelColorPanelColor1Left Top)WidthhHeight�AlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorForm TBevelBevel1LeftTop(WidthYHeight�   TBevelBevel4LeftTopWidthYHeight�   TGridIndiceDBGridColor1LeftTopPWidthIHeight� HelpContext%ColorclInfoBk
DataSourceDataCondicoesPagamentos
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicator
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFontTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style 
OnDblClickDBGridColor1DblClickACorFocoFPrincipal.CorFocoAListaIndice.Strings01 AListaCAmpos.Strings	i_cod_pag	c_nom_pag AindiceInicial ALinhaSQLOrderByOnOrdemDBGridColor1OrdemColumnsExpanded	FieldName	I_COD_PAGTitle.Caption   Código  [>]Visible	 Expanded	FieldName	C_NOM_PAGTitle.Caption   Descrição  [+]WidthXVisible	 Expanded	FieldName	I_QTD_PARTitle.CaptionQda ParWidth7Visible	 Expanded	FieldName	D_VAL_CONTitle.CaptionData validadeVisible	    TDBGridColorDBGridColor2LeftTopWidthIHeight� HelpContext%ColorclInfoBk
DataSourceDatamovCondicoes
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoColumnsExpanded	FieldName	I_NRO_PARTitle.CaptionNro ParcelaVisible	 Expanded	FieldName	I_NUM_DIATitle.Caption
Qdade DiasVisible	 Expanded	FieldName	C_CRE_DEBTitle.CaptionCre/DebVisible	 Expanded	FieldName	D_DAT_FIXTitle.Caption	Data FixaWidthNVisible	 Expanded	FieldName	I_DIA_FIXTitle.CaptionDia FixoVisible	 Expanded	FieldName	N_PER_PAGTitle.CaptionPerc. PagamentoVisible	 Expanded	FieldName	N_PER_CONTitle.CaptionPerc. JurosVisible	    	TCheckBox	CheckBox1LeftTopWidth� HeightCaptionMostrar apenas com validade TabOrderOnClickCheckBox1Click  TLocalizaEditconsultaLeftTop0WidthIHeightHelpContext$ColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro ATabelaCadCondicoesPagamentosASelect.Strings9Select * from CADCONDICOESPAGTO Where C_Nom_Pag like '@%' AOrdemorder by i_cod_pag   TPanelColorPainelLeftTop0WidthYHeight�HelpContext�
BevelWidthCaptionPainelFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderVisibleAUsarCorForm TBevelBevel2Left Top WidthHeightIShapebsFrame  	TNotebookwizardLeft(Top(Width	Height9TabOrder OnPageChangedwizardPageChanged TPage Left Top CaptionC1 TLabelLabel1Left(Top@Width2Height	AlignmenttaRightJustifyCaption	   Código :  TLabelLabel2Left+Top\Width� Height	AlignmenttaRightJustifyCaption&   Descrição da condição de pagamento  TLabelLabel5LeftJTop� Width� Height/	AlignmenttaRightJustifyAutoSizeCaptionK   Quantidade de pagamentos, incluindo a entrada.Deverá possuir no mínimo 1.WordWrap	  TLabel3DLabel3D4LeftxTopWidth Height	AlignmenttaCenterCaption   Condição de PagamentoColorclWindowFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentColor
ParentFontTransparent	ACorMoveclRed  TLabelLabel3Left� TopWidth� HeightAutoSizeCaption   Condição válida até o dia: WordWrap	  TLabelLabel18Left6Top� Width� HeightAutoSizeCaption+   Imprimir Crediário no Cupom Fiscal (S/N)? VisibleWordWrap	  TLabelLabel19LeftTopDWidthcHeight	AlignmenttaRightJustifyCaption   Índice Bancário :  TDBEditColorDBEditColor1Left(TopoWidth�HeightHelpContext�ColorclInfoBk	DataField	C_NOM_PAG
DataSourceDataCondicoesPagamentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData  TDBEditColorDBEditColor4Left8Top� WidthyHeightColorclInfoBk	DataField	I_QTD_PAR
DataSourceDataCondicoesPagamentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnExitDBEditColor4ExitACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData  TDBEditColorDBEditColor6Left6TopWidthyHeightHelpContext�ColorclInfoBk	DataField	D_VAL_CON
DataSourceDataCondicoesPagamentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData  TDBGridColorGradeLeft(Top� Width�Height^HelpContext�ColorclInfoBk
DataSourceDatamovCondicoes
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style VisibleACorFocoFPrincipal.CorFocoColumnsExpanded	FieldName	I_NRO_PARReadOnly	Title.Caption
Nro. parc.Width]Visible	 Expanded	FieldName	I_NUM_DIATitle.Caption	Qdt. DiasWidthnVisible	 Expanded	FieldName	C_CRE_DEBTitle.CaptionC/DWidthNVisible	 Expanded	FieldName	N_PER_CONTitle.Caption
PercentualWidthqVisible	    TDBEditColorDBEditColor5Left6Top� WidthHeightHelpContext�CharCaseecUpperCaseColorclInfoBk	DataField	C_GER_CRE
DataSourceDataCondicoesPagamentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderVisibleOnExitDBEditColor2Exit
OnKeyPressDBEditColor2KeyPressACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData  TDBEditColorDBEditColor7Left�Top@WidthaHeightHelpContext�ColorclInfoBk	DataField	N_IND_REA
DataSourceDataCondicoesPagamentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData  TDBFilialColorDBFilialColor1Left`Top;WidthaHeightColorclInfoBk	DataField	I_COD_PAG
DataSourceDataCondicoesPagamentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder ACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData
ACodFilial    TPage Left Top CaptionC2 TLabelLabel7LeftXTop`WidthIHeight9AutoSizeCaptionj   Quantidade de dias de carência que o cliente tem para pagar uma parcela vencida,  isento  de juros e moraWordWrap	  TLabel3DLabel3D1Left� TopWidth� Height	AlignmenttaCenterCaptionItem OptativoColorclWindowFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentColor
ParentFontTransparent	ACorMoveclRed  TLabelLabel6LeftXTop� Width� HeightAutoSizeCaption+   Imprimir Crediário no Cupom Fiscal (S/N)? WordWrap	  TDBEditColorDBEditColor2LeftXTop� WidthHeightCharCaseecUpperCaseColorclInfoBk	DataField	C_GER_CRE
DataSourceDataCondicoesPagamentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnExitDBEditColor2Exit
OnKeyPressDBEditColor2KeyPressACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData  TDBEditColorDBEditColor3Left� Top� WidthAHeightColorclInfoBk	DataField	I_DIA_CAR
DataSourceDataCondicoesPagamentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder OnExitDBEditColor3ExitACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData   TPage Left Top CaptionC3 TLabelLabel8Left� Top� Width*HeightCaption	   Índice :  TLabel3DLabel3D3Left� TopWidthHHeight	AlignmenttaCenterCaption   ÍndiceColorclWindowFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentColor
ParentFontTransparent	ACorMoveclRed  TLabelLabel20LeftpTophWidthYHeightIAutoSizeCaption�   Preencha este campo caso você utilize um índice multiplicado no valor total da nota para gerar as parcelas. Muito utilizado por bancos e financeiras.WordWrap	  TDBEditNumericoDBEditNumerico1Left� Top� WidthQHeightColorclInfoBk	DataField	N_IND_REA
DataSourceDataCondicoesPagamentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder OnExitDBEditColor3ExitACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData   TPage Left Top CaptionM1 TLabelLabel9Left Top4WidthhHeightCaption   Parcela Número :Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabelLabel10LeftTopXWidth� HeightQAutoSizeCaptioni   Quantidade de dias para o vencimento desta parcela. A Quantidade será adicionada ao vencimento anterior.WordWrap	  TLabelLabel11Left� TopXWidth� HeightQAutoSizeCaption^   Um dia determinado para o vencimento deste pagamento. Ex: Vencimento todo dia 10 de cada mês.WordWrap	  TLabelLabel12LeftpTopXWidth� HeightQAutoSizeCaptionAUma data fixa para este vencimento. Ex: Vencimento dia 12/12/1999WordWrap	  TLabel3DLabel3D5Left@TopWidth�Height	AlignmenttaCenterCaptionData de Vencimento das ParcelasColorclWindowFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentColor
ParentFontTransparent	ACorMoveclRed  TDBTextNroparLeft� Top0Width:HeightAutoSize		DataField	I_NRO_PAR
DataSourceDatamovCondicoesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabelLabel16Left� Top� Width� HeightIAutoSizeCaption   Utilizar o dia da venda para gerar a data da parcela do proximo mês. Ex: Data de venda 10/10/2005  Data da parcela 10/11/2005.WordWrap	  TDBEditColornumLeftTop� WidthyHeightColorclInfoBk	DataField	I_NUM_DIA
DataSourceDatamovCondicoesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder OnChange	numChangeOnExitnumExitACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData  TDBEditColordiasLeft� Top� WidthyHeightColorclInfoBk	DataField	I_DIA_FIX
DataSourceDatamovCondicoesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnChange
diasChangeOnExitdiasExitACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData  TDBEditColordatLeftpTop� WidthyHeightColorclInfoBk	DataField	D_DAT_FIX
DataSourceDatamovCondicoesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnChange	datChangeACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData  	TCheckBoxmesmodiaLeft� Top� WidthHeightTabOrderOnClickmesmodiaClick  
TMemoColordatasLeftTop� WidthyHeightAColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style Lines.Strings	Exemplo : 
ParentFontTabOrderACampoObrigatorioACorFocoFPrincipal.CorFoco  TBitBtnBitBtn3LeftTopWidthyHeightCaption&TestarDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� UUUUUUUUUUUUUUUUUUUUUUUUUUU�UUUUUUYUUUUUUW�UUUUU��UUUUUUww�UUUUU��UUUUUUww�UUUUY��UUUUWwwUUUU���UUUUwww�UUW���UUUWwuww�UUyUY�UUUwuUWw�UUUUUY�UUUUUWwUUUUUU�UUUUUUw�UUUUUY�UUUUUUWw�UUUUUUyUUUUUUw�UUUUUW�UUUUUUWw�UUUUUUY�UUUUUUWwUUUUUUUUUUUUUUUU	NumGlyphsParentDoubleBufferedTabOrderOnClickBitBtn3Click   TPage Left Top CaptionM2 TLabelLabel15Left(ToppWidth� Height1AutoSizeCaption%Percentual  sobre o valor da parcela:WordWrap	  TLabelLabel14Left(Top� Width� HeightQAutoSizeCaption<   O percentual acima é de acréscimo ou desconto na parcela ?WordWrap	  TLabel3DLabel3D6Left� TopWidth� Height	AlignmenttaCenterCaptionPercentuaisColorclWindowFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentColor
ParentFontTransparent	ACorMoveclRed  TLabelLabel17Left(TopDWidthhHeightCaption   Parcela Número :  TDBTextDBText2Left� Top@WidthHHeightAutoSize		DataField	I_NRO_PAR
DataSourceDatamovCondicoesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TDBRadioGroupCreDebLeft� Top� Width� Height9Columns	DataField	C_CRE_DEB
DataSourceDatamovCondicoesItems.Strings
   AcréscimoDesconto ParentBackground	TabOrderValues.StringsCD   TDBEditNumericoDBEditNumerico2Left� TopoWidthyHeightColorclInfoBk	DataField	N_PER_CON
DataSourceDatamovCondicoesFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder ACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAFormatoData   TPage Left Top CaptionM3 TLabelLabel13LeftTop8Width�Height1AutoSizeCaptiongPercentual a ser cobrado do valor total para esta parcela. Ex: primeiro pagamento 50% e nos demais 25%.WordWrap	  TLabel3DLabel3D7Left� TopWidth� Height	AlignmenttaCenterCaptionPercentuaisColorclWindowFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentColor
ParentFontTransparent	ACorMoveclRed  TStringGrid
StringGridLeft� TophWidth� Height� ColCountDefaultColWidthd	FixedCols OptionsgoFixedVertLinegoFixedHorzLine
goVertLine
goHorzLinegoRangeSelect	goEditing TabOrder 
OnKeyPressStringGridKeyPressOnSelectCellStringGridSelectCellOnSetEditTextStringGridSetEditText    TPanelColorPanelColor4LeftTop�WidthOHeight)AlignalBottom
BevelOuterbvNoneFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorForm TBitBtnBVoltarLeft� TopWidthdHeightCaption&VoltarDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333333333333333333333�3333330 333����w330  0 �337ww7w�33�� � 33�3w�w33 ��� 33ws37�w30����� 3���37�w0  ��� 7wws37�w������ s����7�w0   �� 7wwws7�w333�   333s�www3330 3333337w3333333333333333333333333333333333333333333333333333333333333333333	NumGlyphsParentDoubleBufferedTabOrder OnClickBVoltarClick  TBitBtnBAvancaLeftTopWidthdHeightHelpContext-Caption	   &AvançarDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 333333333333333333333333?�333333 333333w�?��33   33wwws�3  ���33ww33��3 �� 33w37w?3 ���3w33�� ��  w37wws �����w3���� �   w�wwws   ��333www?�333333 333333ws3333333333333333333333333333333333333333333333333333333333333333333LayoutblGlyphRight	NumGlyphsParentDoubleBufferedTabOrderOnClickBAvancaClick  TBitBtnBitBtn4Left�TopWidthdHeightHelpContextCancel	Caption	&CancelarDoubleBuffered	
Glyph.Data
�  �  BM�      v   (   $            h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  33�33333333?333333  39�33�3333��33?33  3939�338�3?��3  39��338�8��3�3  33�338�3��38�  339�333�3833�3  333�33338�33?�3  3331�33333�33833  3339�333338�3�33  333��33333833�33  33933333�33�33  33����333838�8�3  33�39333�3��3�3  33933�333��38�8�  33333393338�33���  3333333333333338�3  333333333333333333  	NumGlyphsParentDoubleBufferedTabOrderOnClickBitBtn4Click    TPainelGradientePainelGradiente1Left Top Width�Height)AlignalTop	AlignmenttaLeftJustifyCaption      Condições PagamentosFont.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor2LefthTop)WidthuHeight�HelpContext�AlignalRightColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorForm TMoveBasicoMoveBasico1Left
TopWidthdHeightHelpContextAProximoCaption AProximoBitmap.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 33333333?�333333Ds333333w��33333tDs333337w?�33334DDs33337?w?�3333DDDs3333s�w?�333tDDDs3337�3w?�334DDDDs337?33w?�33DDDDDs?����w���������wwwwww3w33�����333s33?w33<����3337�3?w333<���333373?w3333���33333s?w3333<��333337�w33333<�3333337w333333�3333333w3333333AAnteriorCaption AAnteriorBitmap.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 333333333333333�3333337D333333�s333337DG33333�w�33337DDC3333�s733337DDD3333�s3s3337DDDG333�s37�337DDDDC33�s337337DDDDD337�������������s7wwwwws3�����337s�33s�333�����337s�37�3333����3337s�7?33333���33337s�s�33333���33337s��333333��333337w�3333333�3333337scaptionMoveBasico1  TBotaoCadastrarBotaoCadastrar1Left
TopXWidthdHeightHintIncluir|Incluir novo registroHelpContextCaption
&CadastrarDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333�33;3�3333�;�w{�w{�7����s3�    33wwwwww330����337�333330����337��?�330����337�sws330����3?����?��������ww�wssw;������7w��?�ww30��  337�swws330���3337��7�330��3337�sw�330�� ;�337��w7�3�  3�33www3w�;�3;�3;�7s37s37s�33;333;s3373337	NumGlyphsParentDoubleBufferedTabOrderOnDepoisAtividadeBotaoCadastrar1DepoisAtividadeAFocoDBEditColor1  TBotaoAlterarBotaoAlterar1Left
TopuWidthdHeightHint#Alterar|Altera registro selecionadoHelpContextCaption&AlterarDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� P    UUUWwwww_UU����UUUUU_�_���   UUUwwuw��𿿰_UW��Ww�� ��u�WwUUw����Wu��Uw�  ��WWwwUUw�����Uu����w��   �UWwwwUw�� �� UUuw��w��� UUUWWwuU���UU���uu�U ����UUw�����_UPppppUW����u�PppppP�UWWWWWWwUUUuuuuuUuU	NumGlyphsParentDoubleBufferedTabOrderOnAntesAtividadeBotaoAlterar1AntesAtividade  TBotaoExcluirBotaoExcluir1Left
Top� WidthdHeightHint"Excluir|Exclui registro seleciondoHelpContextCaption&ExcluirDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� P  UUUWwwuU�U    UPUUwwwwU�UU U PUUUw�wWUUU UPUUUUw�W_�UUPP UUUW�uw�UUU PPUUUw�Ww�UUU	�UUU�uwww�UPU	��UW_wwwu�PP��0UWu�wwW_U PU	UwWUwuuuUUUUP��0UU_UWWWWUUUU3UUuUUuuUUUUUUP��UU�UUW_UUPUUUU�UWUUUUu�UUUUUUP�UUUUUUW_UUUUUUUUUUUUUUu	NumGlyphsParentDoubleBufferedTabOrderATextoExcluirCadCondicoesPagamentosC_NOM_PAG  TBitBtnBFecharLeft
ToptWidthdHeightHelpContextCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrderOnClickBFecharClick   TDataSourceDataCondicoesPagamentosAutoEditDataSetCadCondicoesPagamentosLeft*Top  TConsultaPadraoLocaliza
ACadastrarAAlterarLeft�Top  TSQLMovCondicoes
Aggregates IndexFieldNames	I_COD_PAGMasterFields	I_COD_PAGMasterSourceDataCondicoesPagamentosParams ProviderNameInternalProviderBeforeInsertMovCondicoesBeforeInsert
BeforePostMovCondicoesBeforePostASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQL.StringsSelect * from MOVCONDICAOPAGTO ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.StringsSelect * from MOVCONDICAOPAGTO Left� TFMTBCDFieldMovCondicoesI_COD_PAG	FieldName	I_COD_PAGRequired	  TFMTBCDFieldMovCondicoesI_NRO_PAR	FieldName	I_NRO_PARRequired	  TFMTBCDFieldMovCondicoesI_NUM_DIA	FieldName	I_NUM_DIA  TWideStringFieldMovCondicoesC_CRE_DEB	FieldName	C_CRE_DEB	OnSetTextMovCondicoesC_CRE_DEBSetTextSize  TSQLTimeStampFieldMovCondicoesD_DAT_FIX	FieldName	D_DAT_FIXEditMask!99\/99\/0000;1;   TFMTBCDFieldMovCondicoesI_DIA_FIX	FieldName	I_DIA_FIX  TFMTBCDFieldMovCondicoesN_PER_PAG	FieldName	N_PER_PAGDisplayFormat###,##0.0000  TFMTBCDFieldMovCondicoesN_PER_CON	FieldName	N_PER_CONDisplayFormat
###,##0.00  TFMTBCDFieldMovCondicoesN_PER_COM	FieldName	N_PER_COM  TFMTBCDFieldMovCondicoesI_TIP_COM	FieldName	I_TIP_COM  TSQLTimeStampFieldMovCondicoesD_ULT_ALT	FieldName	D_ULT_ALT   TDataSourceDatamovCondicoesDataSetMovCondicoesLeft�  TCriaParcelasReceberRec	ADataBaseFPrincipal.BaseDadosAInfo.MovConCaracterDebPer AInfo.MovConCaracterCrePer Left�  TSQLCadCondicoesPagamentos
Aggregates Params ProviderNameInternalProviderAfterInsert!CadCondicoesPagamentosAfterInsert	AfterEditCadCondicoesPagamentosAfterEdit
BeforePost CadCondicoesPagamentosBeforePost	AfterPostCadCondicoesPagamentosAfterPostAfterCancelCadCondicoesPagamentosAfterPost
ABarraMoveMoveBasico1AAlterarBotaoAlterar1AExcluirBotaoExcluir1
ACadastrarBotaoCadastrar1ASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.Stringsselect * from CADCONDICOESPAGTOorder by i_cod_pag Left�Top TFMTBCDFieldCadCondicoesPagamentosI_COD_PAG	FieldName	I_COD_PAGOriginCADCONDICOESPAGTO.I_COD_PAG  TWideStringFieldCadCondicoesPagamentosC_NOM_PAG	FieldName	C_NOM_PAGOriginCADCONDICOESPAGTO.C_NOM_PAGSize2  TFMTBCDFieldCadCondicoesPagamentosI_QTD_PAR	FieldName	I_QTD_PAROriginCADCONDICOESPAGTO.I_QTD_PAR  TFMTBCDFieldCadCondicoesPagamentosI_PRA_MED	FieldName	I_PRA_MEDOriginCADCONDICOESPAGTO.I_PRA_MED  TSQLTimeStampFieldCadCondicoesPagamentosD_VAL_CON	FieldName	D_VAL_CONOriginCADCONDICOESPAGTO.D_VAL_CON  TFMTBCDFieldCadCondicoesPagamentosN_IND_REA	FieldName	N_IND_REAOriginCADCONDICOESPAGTO.N_IND_REA  TFMTBCDFieldCadCondicoesPagamentosN_PER_DES	FieldName	N_PER_DESOriginCADCONDICOESPAGTO.N_PER_DES  TFMTBCDFieldCadCondicoesPagamentosI_DIA_CAR	FieldName	I_DIA_CAROriginCADCONDICOESPAGTO.I_DIA_CAR  TFMTBCDFieldCadCondicoesPagamentosN_PER_CON	FieldName	N_PER_CONOriginCADCONDICOESPAGTO.N_PER_CON  TWideStringFieldCadCondicoesPagamentosC_GER_CRE	FieldName	C_GER_CREOriginCADCONDICOESPAGTO.C_GER_CRESize  TSQLTimeStampFieldCadCondicoesPagamentosD_ULT_ALT	FieldName	D_ULT_ALTOriginCADCONDICOESPAGTO.D_ULT_ALT  TFMTBCDFieldCadCondicoesPagamentosI_COD_USU	FieldName	I_COD_USUOrigin%BASEDADOS.CADCONDICOESPAGTO.I_COD_USU    