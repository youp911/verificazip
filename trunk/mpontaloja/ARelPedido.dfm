object FRelPedido: TFRelPedido
  Left = 229
  Top = -21
  Caption = 'FRelPedido'
  ClientHeight = 716
  ClientWidth = 577
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 577
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    AConfiguracoes = FPrincipal.CorPainelGra
  end
  object PanelColor1: TPanelColor
    Left = 0
    Top = 41
    Width = 577
    Height = 634
    Align = alClient
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    AUsarCorForm = False
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 1
      Width = 575
      Height = 632
      VertScrollBar.Position = 324
      Align = alClient
      TabOrder = 0
      object PFilial: TPanelColor
        Left = 0
        Top = -296
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label24: TLabel
          Left = 89
          Top = 6
          Width = 34
          Height = 16
          Alignment = taRightJustify
          Caption = 'Filial :'
        end
        object SpeedButton5: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LFilial: TLabel
          Left = 227
          Top = 6
          Width = 168
          Height = 16
          Caption = '                                                        '
        end
        object EFilial: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LFilial
          ABotao = SpeedButton5
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'select * from CadFiliais where I_EMP_FIL = @')
          ASelectLocaliza.Strings = (
            'Select * from CADFILIAIS'
            'Where C_NOM_FAN like '#39'@%'#39)
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_EMP_FIL'
          AInfo.CampoNome = 'C_NOM_FAN'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = 'Localiza Filial'
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PCliente: TPanelColor
        Left = 0
        Top = -156
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object LTextoCliente: TLabel
          Left = 76
          Top = 6
          Width = 47
          Height = 16
          Alignment = taRightJustify
          Caption = 'Cliente :'
        end
        object SpeedButton1: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LCliente: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '                   '
        end
        object ECliente: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LCliente
          ABotao = SpeedButton1
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CadClientes '
            'Where I_Cod_cli = @')
          ASelectLocaliza.Strings = (
            'Select * from CadClientes '
            'Where C_Nom_Cli like '#39'@%'#39
            'order by c_Nom_Cli ')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_Cod_cli'
          AInfo.CampoNome = 'C_Nom_Cli'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Cliente   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PCidade: TPanelColor
        Left = 0
        Top = -16
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label2: TLabel
          Left = 73
          Top = 6
          Width = 50
          Height = 16
          Alignment = taRightJustify
          Caption = 'Cidade :'
        end
        object SpeedButton2: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LCidade: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '                   '
        end
        object ECidade: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LCidade
          ABotao = SpeedButton2
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'select * from CAD_CIDADES'
            'Where COD_CIDADE = @')
          ASelectLocaliza.Strings = (
            'select * from CAD_CIDADES'
            'Where DES_CIDADE like '#39'@%'#39
            'order by DES_CIDADE')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'COD_CIDADE'
          AInfo.CampoNome = 'DES_CIDADE'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Cidade   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PEstado: TPanelColor
        Left = 0
        Top = 12
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label4: TLabel
          Left = 74
          Top = 6
          Width = 49
          Height = 16
          Alignment = taRightJustify
          Caption = 'Estado :'
        end
        object SpeedButton3: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object Label5: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '                   '
        end
        object EEstado: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = Label5
          ABotao = SpeedButton3
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'select * from CAD_ESTADOS'
            'Where COD_ESTADO = '#39'@'#39)
          ASelectLocaliza.Strings = (
            'select * from CAD_ESTADOS'
            'Where DES_ESTADO like '#39'@%'#39
            'order by DES_ESTADO')
          APermitirVazio = True
          AInfo.CampoCodigo = 'COD_ESTADO'
          AInfo.CampoNome = 'DES_ESTADO'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Estado   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PCondPgto: TPanelColor
        Left = 0
        Top = 96
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label6: TLabel
          Left = 25
          Top = 6
          Width = 98
          Height = 16
          Alignment = taRightJustify
          Caption = 'Condi'#231#227'o Pgto. :'
        end
        object SpeedButton4: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LCondPgto: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '                   '
        end
        object ECondPgto: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LCondPgto
          ABotao = SpeedButton4
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'select * from CADCONDICOESPAGTO'
            'Where I_COD_PAG = @')
          ASelectLocaliza.Strings = (
            'select * from CADCONDICOESPAGTO'
            'Where C_NOM_PAG like '#39'@%'#39
            'order by C_NOM_PAG')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_COD_PAG'
          AInfo.CampoNome = 'C_NOM_PAG'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Cond. de Pagamento   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PPeriodo: TPanelColor
        Left = 0
        Top = 488
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object LPeriodo: TLabel
          Left = 50
          Top = 6
          Width = 73
          Height = 16
          Alignment = taRightJustify
          Caption = 'Per'#237'odo de :'
        end
        object Label9: TLabel
          Left = 229
          Top = 6
          Width = 19
          Height = 16
          Caption = 'at'#233
        end
        object CDataIni: TCalendario
          Left = 129
          Top = 2
          Width = 96
          Height = 24
          Date = 38118.701628009300000000
          Time = 38118.701628009300000000
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACorFoco = FPrincipal.CorFoco
        end
        object CDataFim: TCalendario
          Left = 253
          Top = 2
          Width = 96
          Height = 24
          Date = 38118.701628009300000000
          Time = 38118.701628009300000000
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object PTipoCotacao: TPanelColor
        Left = 0
        Top = 180
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label3: TLabel
          Left = 35
          Top = 6
          Width = 88
          Height = 16
          Alignment = taRightJustify
          Caption = 'Tipo Cota'#231#227'o :'
        end
        object SpeedButton6: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LTipoCotacao: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '            '
        end
        object ETipoCotacao: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LTipoCotacao
          ABotao = SpeedButton6
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CADTIPOORCAMENTO'
            'Where I_COD_TIP = @')
          ASelectLocaliza.Strings = (
            'Select * from CADTIPOORCAMENTO'
            'Where C_NOM_TIP LIKE '#39'@%'#39
            'order by C_NOM_TIP ')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_COD_TIP'
          AInfo.CampoNome = 'C_NOM_TIP'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Tipo Cota'#231#227'o   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PVendedor: TPanelColor
        Left = 0
        Top = -44
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label11: TLabel
          Left = 57
          Top = 6
          Width = 66
          Height = 16
          Alignment = taRightJustify
          Caption = 'Vendedor :'
        end
        object SpeedButton7: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LVendedor: TLabel
          Left = 227
          Top = 6
          Width = 57
          Height = 16
          Caption = '                   '
        end
        object EVendedor: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LVendedor
          ABotao = SpeedButton7
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CadVendedores'
            'Where I_Cod_Ven = @'
            'and C_IND_ATI = '#39'S'#39
            '')
          ASelectLocaliza.Strings = (
            'Select * from CadVendedores'
            'Where C_Nom_Ven like '#39'@%'#39
            'and C_IND_ATI = '#39'S'#39
            'order by c_Nom_Ven')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_Cod_Ven'
          AInfo.CampoNome = 'C_Nom_Ven'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Vendedor   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PSituacao: TPanelColor
        Left = 0
        Top = 460
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label7: TLabel
          Left = 64
          Top = 6
          Width = 59
          Height = 16
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o :'
        end
        object RFlagSituacao: TRadioGroup
          Left = 129
          Top = -6
          Width = 382
          Height = 34
          Columns = 3
          ItemIndex = 2
          Items.Strings = (
            '&Abertos'
            '&Entregue'
            '&Todos')
          TabOrder = 0
        end
      end
      object PDataFinal: TPanelColor
        Left = 0
        Top = 516
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object LDataFinal: TLabel
          Left = 56
          Top = 6
          Width = 67
          Height = 16
          Alignment = taRightJustify
          Caption = 'Data Final :'
        end
        object CDataFinal: TCalendario
          Left = 129
          Top = 2
          Width = 96
          Height = 24
          Date = 38118.701628009300000000
          Time = 38118.701628009300000000
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACorFoco = FPrincipal.CorFoco
        end
      end
      object PSitCliente: TPanelColor
        Left = 0
        Top = 124
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label8: TLabel
          Left = 20
          Top = 6
          Width = 103
          Height = 16
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o Cliente :'
        end
        object SpeedButton8: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LSituacaoCliente: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '            '
        end
        object ESituacaoCliente: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LSituacaoCliente
          ABotao = SpeedButton8
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CADSITUACOESCLIENTES'
            'Where I_COD_SIT = @')
          ASelectLocaliza.Strings = (
            'Select * from CADSITUACOESCLIENTES'
            'Where C_NOM_SIT LIKE '#39'@%'#39
            'order by C_NOM_SIT ')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_COD_SIT'
          AInfo.CampoNome = 'C_NOM_SIT'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Descri'#231#227'o'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Situa'#231#227'o Cliente  '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PEmpresa: TPanelColor
        Left = 0
        Top = -324
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label10: TLabel
          Left = 62
          Top = 6
          Width = 61
          Height = 16
          Alignment = taRightJustify
          Caption = 'Empresa :'
        end
        object SpeedButton9: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LEmpresa: TLabel
          Left = 227
          Top = 6
          Width = 168
          Height = 16
          Caption = '                                                        '
        end
        object ECodEmpresa: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LEmpresa
          ABotao = SpeedButton9
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'select * from CadEMPRESAS where I_COD_EMP = @')
          ASelectLocaliza.Strings = (
            'Select * from CADEMPRESAS'
            'Where C_NOM_EMP like '#39'@%'#39)
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_COD_EMP'
          AInfo.CampoNome = 'C_NOM_EMP'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Empresa   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PTabelaPreco: TPanelColor
        Left = 0
        Top = -268
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label13: TLabel
          Left = 34
          Top = 6
          Width = 89
          Height = 16
          Alignment = taRightJustify
          Caption = 'Tabela Pre'#231'o :'
        end
        object SpeedButton10: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LNomTabelaPreco: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '                   '
        end
        object ECodTabelaPreco: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LNomTabelaPreco
          ABotao = SpeedButton10
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CadClientes '
            'Where I_Cod_cli = @')
          ASelectLocaliza.Strings = (
            'Select * from CadClientes '
            'Where C_Nom_Cli like '#39'@%'#39
            'order by c_Nom_Cli ')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_COD_TAB'
          AInfo.CampoNome = 'C_NOM_TAB'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Tabela Pre'#231'o   '
          ADarFocoDepoisdoLocaliza = True
          OnSelect = ECodTabelaPrecoSelect
        end
      end
      object PProduto: TPanelColor
        Left = 0
        Top = -212
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label14: TLabel
          Left = 69
          Top = 6
          Width = 53
          Height = 16
          Alignment = taRightJustify
          Caption = 'Produto :'
        end
        object SpeedButton11: TSpeedButton
          Left = 227
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LProduto: TLabel
          Left = 255
          Top = 6
          Width = 42
          Height = 16
          Caption = '              '
        end
        object EProduto: TEditLocaliza
          Left = 129
          Top = 2
          Width = 96
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LProduto
          ABotao = SpeedButton11
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          APermitirVazio = True
          AInfo.CampoCodigo = 'C_COD_PRO'
          AInfo.CampoNome = 'C_NOM_PRO'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '  Localiza Produto   '
          AInfo.Cadastrar = True
          AInfo.RetornoExtra1 = 'I_SEQ_PRO'
          ADarFocoDepoisdoLocaliza = True
          OnSelect = EProdutoSelect
          OnRetorno = EProdutoRetorno
        end
      end
      object PBanco: TPanelColor
        Left = 0
        Top = -128
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label15: TLabel
          Left = 78
          Top = 6
          Width = 45
          Height = 16
          Alignment = taRightJustify
          Caption = 'Banco :'
        end
        object SpeedButton12: TSpeedButton
          Left = 198
          Top = 3
          Width = 28
          Height = 24
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LBanco: TLabel
          Left = 227
          Top = 10
          Width = 145
          Height = 16
          AutoSize = False
        end
        object EBanco: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LBanco
          ABotao = SpeedButton12
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from cadbancos '
            'where  I_COD_BAN = '#39'@'#39)
          ASelectLocaliza.Strings = (
            'Select * from cadbancos'
            'where  c_nom_BAN  like '#39'@%'#39)
          APermitirVazio = True
          AInfo.CampoCodigo = 'I_COD_BAN'
          AInfo.CampoNome = 'c_nom_ban'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 10
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '  Bancos  '
          AInfo.Cadastrar = True
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PUsuario: TPanelColor
        Left = 0
        Top = 40
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label16: TLabel
          Left = 70
          Top = 6
          Width = 53
          Height = 16
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio :'
        end
        object SpeedButton13: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LNomUsuario: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '                   '
        end
        object ECodUsuario: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LNomUsuario
          ABotao = SpeedButton13
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'select * from CADUSUARIOS'
            'Where I_COD_USU = @')
          ASelectLocaliza.Strings = (
            'select * from CADUSUARIOS'
            'Where C_NOM_USU like '#39'@%'#39
            'order by C_NOM_USU')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_COD_USU'
          AInfo.CampoNome = 'C_NOM_USU'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Usu'#225'rio   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PFormaPagamento: TPanelColor
        Left = 0
        Top = 68
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label17: TLabel
          Left = 5
          Top = 6
          Width = 118
          Height = 16
          Alignment = taRightJustify
          Caption = 'Forma Pagamento :'
        end
        object SpeedButton14: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LFormaPagamento: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '                   '
        end
        object EFormaPagamento: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LFormaPagamento
          ABotao = SpeedButton14
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'select * from CADFORMASPAGAMENTO'
            'Where I_COD_FRM = @')
          ASelectLocaliza.Strings = (
            'select * from CADFORMASPAGAMENTO'
            'Where C_NOM_FRM like '#39'@%'#39
            'order by C_NOM_FRM')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_COD_FRM'
          AInfo.CampoNome = 'C_NOM_FRM'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Forma de Pagamento   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PClassificacaoProduto: TPanelColor
        Left = 0
        Top = -240
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label12: TLabel
          Left = 1
          Top = 6
          Width = 122
          Height = 16
          Alignment = taRightJustify
          Caption = 'Classifica'#231#227'o Prod. :'
        end
        object SpeedButton15: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
          OnClick = SpeedButton15Click
        end
        object LNomClassificacao: TLabel
          Left = 227
          Top = 6
          Width = 168
          Height = 16
          Caption = '                                                        '
        end
        object ECodClassifcacao: TEditColor
          Left = 128
          Top = 1
          Width = 69
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnExit = ECodClassifcacaoExit
          OnKeyDown = ECodClassifcacaoKeyDown
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
        end
      end
      object PQtdVias: TPanelColor
        Left = 0
        Top = 600
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        AUsarCorForm = False
        object Label18: TLabel
          Left = 17
          Top = 6
          Width = 106
          Height = 16
          Alignment = taRightJustify
          Caption = 'Quantidade Vias :'
        end
        object EQtdVias: TSpinEditColor
          Left = 128
          Top = 0
          Width = 98
          Height = 26
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
          ACorFoco = FPrincipal.CorFoco
        end
      end
      object PEstagio: TPanelColor
        Left = 0
        Top = 348
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label19: TLabel
          Left = 71
          Top = 6
          Width = 52
          Height = 16
          Alignment = taRightJustify
          Caption = 'Est'#225'gio :'
        end
        object SpeedButton16: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LEstagio: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '            '
        end
        object ECodEstagio: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LEstagio
          ABotao = SpeedButton16
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from ESTAGIOPRODUCAO'
            'Where CODEST = @'
            '')
          ASelectLocaliza.Strings = (
            'Select * from ESTAGIOPRODUCAO'
            'Where NOMEST like '#39'@%'#39
            'order by NOMEST')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'CODEST'
          AInfo.CampoNome = 'NOMEST'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '  Localiza Estagio   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PTransportadora: TPanelColor
        Left = 0
        Top = 152
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label20: TLabel
          Left = 23
          Top = 6
          Width = 100
          Height = 16
          Alignment = taRightJustify
          Caption = 'Transportadora :'
        end
        object SpeedButton17: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LTransportadora: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '            '
        end
        object ETransportadora: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LTransportadora
          ABotao = SpeedButton17
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CADTRANSPORTADORAS'
            'Where I_COD_TRA = @')
          ASelectLocaliza.Strings = (
            'Select * from CADTRANSPORTADORAS'
            'WHERE C_NOM_TRA LIKE '#39'@%'#39
            'order by C_NOM_TRA')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_COD_TRA'
          AInfo.CampoNome = 'C_NOM_TRA'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Descri'#231#227'o'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Transportadora  '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PFundoPerdido: TPanelColor
        Left = 0
        Top = 572
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object CFundoPerdido: TCheckBox
          Left = 128
          Top = 5
          Width = 225
          Height = 17
          Caption = 'Mostrar Fundo Perdido'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
      end
      object PTipoContrato: TPanelColor
        Left = 0
        Top = -100
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label21: TLabel
          Left = 36
          Top = 6
          Width = 87
          Height = 16
          Alignment = taRightJustify
          Caption = 'Tipo Contrato :'
        end
        object SpeedButton18: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LNomTipoContrato: TLabel
          Left = 227
          Top = 6
          Width = 57
          Height = 16
          Caption = '                   '
        end
        object ECodTipoContrato: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LNomTipoContrato
          ABotao = SpeedButton18
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'SELECT * FROM TIPOCONTRATO'
            'Where CODTIPOCONTRATO = @')
          ASelectLocaliza.Strings = (
            'select * from TIPOCONTRATO'
            'Where NOMTIPOCONTRATO LIKE '#39'@%'#39
            'order by NOMTIPOCONTRATO')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'CODTIPOCONTRATO'
          AInfo.CampoNome = 'NOMTIPOCONTRATO'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Tipo Contrato   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PPreposto: TPanelColor
        Left = 0
        Top = -72
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 23
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label22: TLabel
          Left = 24
          Top = 6
          Width = 99
          Height = 16
          Alignment = taRightJustify
          Caption = 'Vend. Preposto :'
        end
        object SpeedButton19: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LPreposto: TLabel
          Left = 227
          Top = 6
          Width = 57
          Height = 16
          Caption = '                   '
        end
        object EPreposto: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LPreposto
          ABotao = SpeedButton19
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CadVendedores'
            'Where I_Cod_Ven = @'
            'and C_IND_ATI = '#39'S'#39
            '')
          ASelectLocaliza.Strings = (
            'Select * from CadVendedores'
            'Where C_Nom_Ven like '#39'@%'#39
            'and C_IND_ATI = '#39'S'#39
            'order by c_Nom_Ven')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_Cod_Ven'
          AInfo.CampoNome = 'C_Nom_Ven'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Vendedor   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PTecnico: TPanelColor
        Left = 0
        Top = 320
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 24
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object LTituloTecnico: TLabel
          Left = 68
          Top = 6
          Width = 55
          Height = 16
          Alignment = taRightJustify
          Caption = 'T'#233'cnico :'
        end
        object SpeedButton20: TSpeedButton
          Left = 198
          Top = 3
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LTecnico: TLabel
          Left = 228
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '                   '
        end
        object ETecnico: TEditLocaliza
          Left = 129
          Top = 3
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LTecnico
          ABotao = SpeedButton20
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from TECNICO '
            'Where CODTECNICO = @')
          ASelectLocaliza.Strings = (
            'Select * from TECNICO'
            'Where NOMTECNICO like '#39'@%'#39
            'order by NOMTECNICO')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'CODTECNICO'
          AInfo.CampoNome = 'NOMTECNICO'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza T'#233'cnico   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object POperacaoEstoque: TPanelColor
        Left = 0
        Top = 292
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label25: TLabel
          Left = 3
          Top = 6
          Width = 120
          Height = 16
          Alignment = taRightJustify
          Caption = 'Opera'#231#227'o Estoque :'
        end
        object SpeedButton21: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LOperacaoEstoque: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '            '
        end
        object EOperacaoEstoque: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LOperacaoEstoque
          ABotao = SpeedButton21
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CADOPERACAOESTOQUE'
            'Where I_COD_OPE = @')
          ASelectLocaliza.Strings = (
            'Select * from CADOPERACAOESTOQUE'
            'Where C_NOM_OPE LIKE '#39'@%'#39
            'order by C_NOM_OPE ')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_COD_OPE'
          AInfo.CampoNome = 'C_NOM_OPE'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Descri'#231#227'o'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Opera'#231#227'o Estoque  '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PCor: TPanelColor
        Left = 0
        Top = 264
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 26
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label27: TLabel
          Left = 96
          Top = 6
          Width = 27
          Height = 16
          Alignment = taRightJustify
          Caption = 'Cor :'
        end
        object SpeedButton22: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LCor: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '            '
        end
        object ECodCor: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LCor
          ABotao = SpeedButton22
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from COR'
            'Where COD_COR = @')
          ASelectLocaliza.Strings = (
            'Select * from COR'
            'Where NOM_COR LIKE '#39'@%'#39
            'order by NOM_COR ')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'COD_COR'
          AInfo.CampoNome = 'NOM_COR'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Descri'#231#227'o'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Cor  '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PCotacaoCancelada: TPanelColor
        Left = 0
        Top = 432
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 27
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label26: TLabel
          Left = 64
          Top = 6
          Width = 59
          Height = 16
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o :'
        end
        object ESituacaoCotacao: TComboBoxColor
          Left = 128
          Top = 1
          Width = 97
          Height = 24
          Style = csDropDownList
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          TabOrder = 0
          Items.Strings = (
            'Todos'
            'Canceladas'
            'N'#227'o Canceladas')
          ACampoObrigatorio = False
          ACorFoco = FPrincipal.CorFoco
        end
      end
      object PClienteMaster: TPanelColor
        Left = 0
        Top = -184
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 28
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label28: TLabel
          Left = 32
          Top = 6
          Width = 91
          Height = 16
          Alignment = taRightJustify
          Caption = 'Cliente Master :'
        end
        object SpeedButton23: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LClienteMaster: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '                   '
        end
        object EClienteMaster: TEditLocaliza
          Left = 129
          Top = 2
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LClienteMaster
          ABotao = SpeedButton23
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CadClientes '
            'Where I_Cod_cli = @')
          ASelectLocaliza.Strings = (
            'Select * from CadClientes '
            'Where C_Nom_Cli like '#39'@%'#39
            'order by c_Nom_Cli ')
          APermitirVazio = True
          ASomenteNumeros = True
          AInfo.CampoCodigo = 'I_Cod_cli'
          AInfo.CampoNome = 'C_Nom_Cli'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Cliente   '
          ADarFocoDepoisdoLocaliza = True
        end
      end
      object PCentroCusto: TPanelColor
        Left = 0
        Top = 236
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 29
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label29: TLabel
          Left = 22
          Top = 6
          Width = 101
          Height = 16
          Alignment = taRightJustify
          Caption = 'Centro de Custo :'
        end
        object SpeedButton24: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LCentroCusto: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '            '
        end
        object ECentroCusto: TRBEditLocaliza
          Left = 128
          Top = 1
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LCentroCusto
          ABotao = SpeedButton24
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select CODCENTRO,NOMCENTRO '
            ' from CENTROCUSTO '
            ' Where CODCENTRO = @')
          ASelectLocaliza.Strings = (
            'Select CODCENTRO,NOMCENTRO '
            ' from CENTROCUSTO ')
          APermitirVazio = True
          AColunas = <
            item
              ATituloColuna = 'C'#243'digo'
              ATamanhoColuna = 8
              ACampoFiltro = False
              ANomeCampo = 'CODCENTRO'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end
            item
              ATituloColuna = 'Descri'#231#227'o'
              ATamanhoColuna = 40
              ACampoFiltro = True
              ANomeCampo = 'NOMCENTRO'
              AMostrarNaGrade = True
              AOrdemInicial = True
            end>
          ALocalizaPadrao = lpCentroCusto
          ATituloFormulario = '   Localiza Centro de Custo   '
        end
      end
      object PNumerico1: TPanelColor
        Left = 0
        Top = 376
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 30
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object LNumerico1: TLabel
          Left = 64
          Top = 6
          Width = 59
          Height = 16
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o :'
        end
        object ENumerico1: Tnumerico
          Left = 129
          Top = 2
          Width = 92
          Height = 24
          ACampoObrigatorio = False
          ACorFoco = FPrincipal.CorFoco
          ANaoUsarCorNegativo = False
          Color = clInfoBk
          AMascara = ' 0;- ,0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
      object PTipoPeriodo: TPanelColor
        Left = 0
        Top = 404
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 31
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label1: TLabel
          Left = 46
          Top = 6
          Width = 77
          Height = 16
          Alignment = taRightJustify
          Caption = 'Per'#237'odo por :'
        end
        object ETipoPeriodo: TComboBoxColor
          Left = 128
          Top = 1
          Width = 221
          Height = 24
          Style = csDropDownList
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'Data Emiss'#227'o'
          Items.Strings = (
            'Data Emiss'#227'o'
            'Data Vencimento')
          ACampoObrigatorio = False
          ACorFoco = FPrincipal.CorFoco
        end
      end
      object PProjeto: TPanelColor
        Left = 0
        Top = 208
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 32
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object Label23: TLabel
          Left = 74
          Top = 6
          Width = 49
          Height = 16
          Alignment = taRightJustify
          Caption = 'Projeto :'
        end
        object SpeedButton25: TSpeedButton
          Left = 198
          Top = 2
          Width = 26
          Height = 25
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000CE0E0000D80E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F3333337F3333377F8FFF8F773
            333337333333373F3333078F8F8F870333337F333333337F333307FFF8FFF703
            33337F333333337F3333078F8F8F8703333373F333333373333377F8FFF8F773
            333337F3333337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
        end
        object LProjeto: TLabel
          Left = 227
          Top = 6
          Width = 249
          Height = 16
          AutoSize = False
          Caption = '            '
        end
        object EProjeto: TRBEditLocaliza
          Left = 128
          Top = 1
          Width = 68
          Height = 24
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AInteiro = 0
          ATexto = LProjeto
          ABotao = SpeedButton25
          ADataBase = FPrincipal.BaseDados
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select CODPROJETO, NOMPROJETO '
            ' from PROJETO '
            ' Where CODPROJETO = @')
          ASelectLocaliza.Strings = (
            'Select CODPROJETO, NOMPROJETO '
            ' from PROJETO ')
          APermitirVazio = True
          AColunas = <
            item
              ATituloColuna = 'C'#243'digo'
              ATamanhoColuna = 8
              ACampoFiltro = False
              ANomeCampo = 'CODPROJETO'
              AMostrarNaGrade = True
              AOrdemInicial = False
            end
            item
              ATituloColuna = 'Nome'
              ATamanhoColuna = 30
              ACampoFiltro = True
              ANomeCampo = 'NOMPROJETO'
              AMostrarNaGrade = True
              AOrdemInicial = True
            end>
          ALocalizaPadrao = lpProjeto
          ATituloFormulario = '   Localiza Projeto   '
        end
      end
      object PCheckBox1: TPanelColor
        Left = 0
        Top = 544
        Width = 554
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 33
        AUsarCorForm = False
        ACorForm = FPrincipal.CorForm
        object CheckBox1: TCheckBox
          Left = 128
          Top = 5
          Width = 417
          Height = 17
          Caption = 'Mostrar Fundo Perdido'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
      end
    end
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 675
    Width = 577
    Height = 41
    Align = alBottom
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    AUsarCorForm = False
    ACorForm = FPrincipal.CorForm
    object BMostrarConta: TSpeedButton
      Left = 213
      Top = 6
      Width = 26
      Height = 27
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880F9F9F07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F0091100F
        77037F3737333737FF7F08090919110907037F737F3333737F7F0F0F0999910F
        07037F737F3333737F7F0F090F99190908037F737FF33373737F0F7F00FF900F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80F9F9F08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      NumGlyphs = 2
      Visible = False
      OnClick = BMostrarContaClick
    end
    object BFechar: TBitBtn
      Left = 469
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Fechar'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = BFecharClick
    end
    object BImprimir: TBitBtn
      Tag = 10
      Left = 6
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Imprimir'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = BImprimirClick
    end
    object BitBtn1: TBitBtn
      Left = 110
      Top = 5
      Width = 100
      Height = 30
      Caption = '&PDF'
      DoubleBuffered = True
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 2
      OnClick = BImprimirClick
    end
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 12
  end
  object Aux: TQuery
    DatabaseName = 'BaseDados'
    Left = 176
  end
end
