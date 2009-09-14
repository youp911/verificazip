object FNovaAmostra: TFNovaAmostra
  Left = 58
  Top = 46
  ActiveControl = ECodigo
  Caption = 'Amostra'
  ClientHeight = 416
  ClientWidth = 618
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PainelGradiente1: TPainelGradiente
    Left = 0
    Top = 0
    Width = 618
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Amostra   '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    AConfiguracoes = FPrincipal.CorPainelGra
  end
  object PanelColor2: TPanelColor
    Left = 0
    Top = 375
    Width = 618
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
    object BotaoGravar1: TBotaoGravar
      Left = 264
      Top = 5
      Width = 100
      Height = 30
      Hint = 'Gravar|Grava no registro'
      Caption = '&Gravar'
      DoubleBuffered = True
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = BotaoGravar1Click
      AFecharAposOperacao = False
    end
    object BotaoCancelar1: TBotaoCancelar
      Left = 363
      Top = 5
      Width = 100
      Height = 30
      Hint = 'Cancelar|Cancela opera'#231#227'o atual'
      Caption = '&Cancelar'
      DoubleBuffered = True
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 2
      AFecharAposOperacao = True
    end
    object BFechar: TBitBtn
      Left = 640
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
      TabOrder = 3
      OnClick = BFecharClick
    end
    object BCadastrar: TBitBtn
      Left = 16
      Top = 5
      Width = 100
      Height = 30
      Caption = '&Cadastrar'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000CE0E0000D80E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F3FF3FFF7F333330FEEFEEEF07333337F77377737F333330FFFFFFFF
        07333FF7F3FFFF3F7FFFBBB0FEEEEFEF0BB37777F7777373777F3BB0FFFFFFFF
        0BBB3777F3FF3FFF77773330FEEF000003333337F773777773333330FFFF0FF0
        33333337F3FF7F37F3333330FE8F0F0B33333337F7737F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = BCadastrarClick
    end
    object BConcluir: TBitBtn
      Left = 480
      Top = 5
      Width = 137
      Height = 30
      Caption = '&Concluir Amostra'
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0000377777777777777703030303030303037F7F7F7F7F7F7F7F000000000000
        00007777777777777777933393303933337073F37F37F73F3377393393303393
        379037FF7F37F37FF777379793303379793037777337F3777737339933303339
        93303377F3F7F3F77F3733993930393993303377F737F7377FF7399993303399
        999037777337F377777793993330333393307377FF37F3337FF7333993303333
        993033377F37F33377F7333993303333993033377337F3337737333333303333
        33303FFFFFF7FFFFFFF700000000000000007777777777777777030303030303
        03037F7F7F7F7F7F7F7F00000000000000007777777777777777}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = BConcluirClick
    end
    object BConsumo: TBitBtn
      Left = 144
      Top = 5
      Width = 100
      Height = 30
      Caption = 'Co&nsumo'
      DoubleBuffered = True
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000
        1F7C1F7C1F7C1F7CE03DEF3D00001F7C1F7C1F7C1F7C1F7C1F7C0000007CE07F
        00001F7C1F7C1F7CE07FE03DEF3D00001F7C1F7C1F7C1F7C0000007CE07F007C
        007C00001F7C1F7C1F7CE07FE03DEF3D00001F7C1F7C0000007CE07F007C007C
        00001F7C1F7C1F7C1F7C1F7CE07FE03DEF3D00000000003CE07F007C007C0000
        1F7C1F7C1F7C1F7C1F7C1F7C1F7CE07FE03D0000003C007CE07F007C00001F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE07FE03DE07F003CE07F00001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FE07F00001F7C1F7C1F7C
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FE07FE03DEF3D00001F7C0000
        EF3D00001F7C1F7C1F7C1F7C1F7C0000FF7F1F7C1F7CE07FE03DEF3D0000EF3D
        1F7C00001F7C1F7C1F7C00000000FF7F1F7C1F7C1F7C1F7CE07FEF3DEF3DEF3D
        1F7C1F7C1F7C1F7C00001F7CFF7F1F7C1F7C1F7C1F7C1F7C0000EF3DEF3DEF3D
        1F7C1F7C1F7C1F7CEF3D1F7CFF7F1F7C1F7C1F7C1F7C1F7CEF3D1F7C1F7C1F7C
        1F7C1F7C1F7C1F7CFF7F00001F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentDoubleBuffered = False
      TabOrder = 5
      OnClick = BConsumoClick
    end
  end
  object PanelColor1: TPanelColor
    Left = 0
    Top = 41
    Width = 618
    Height = 334
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
    ACorForm = FPrincipal.CorForm
    object Paginas: TPageControl
      Left = 1
      Top = 1
      Width = 616
      Height = 332
      ActivePage = PAmostra
      Align = alClient
      TabOrder = 0
      object PAmostra: TTabSheet
        Caption = 'Amostra'
        object Label1: TLabel
          Left = 100
          Top = 7
          Width = 50
          Height = 16
          Alignment = taRightJustify
          Caption = 'C'#243'digo :'
        end
        object Label2: TLabel
          Left = 107
          Top = 62
          Width = 43
          Height = 16
          Alignment = taRightJustify
          Caption = 'Nome :'
        end
        object Label3: TLabel
          Left = 63
          Top = 125
          Width = 88
          Height = 16
          Alignment = taRightJustify
          Caption = 'Data Amostra :'
        end
        object Label4: TLabel
          Left = 481
          Top = 150
          Width = 85
          Height = 16
          Alignment = taRightJustify
          Caption = 'Data Entrega :'
        end
        object Label5: TLabel
          Left = 4
          Top = 150
          Width = 148
          Height = 16
          Alignment = taRightJustify
          Caption = 'Data Entrega Solicitada :'
        end
        object Label6: TLabel
          Left = 511
          Top = 176
          Width = 57
          Height = 16
          Alignment = taRightJustify
          Caption = 'Cole'#231#227'o :'
        end
        object Label7: TLabel
          Left = 51
          Top = 176
          Width = 99
          Height = 16
          Alignment = taRightJustify
          Caption = 'Desenvolvedor :'
        end
        object Label8: TLabel
          Left = 90
          Top = 202
          Width = 60
          Height = 16
          Alignment = taRightJustify
          Caption = 'Prospect :'
        end
        object Label9: TLabel
          Left = 95
          Top = 277
          Width = 55
          Height = 16
          Alignment = taRightJustify
          Caption = 'Imagem :'
        end
        object Label10: TLabel
          Left = 51
          Top = 303
          Width = 99
          Height = 16
          Alignment = taRightJustify
          Caption = 'Imagem Cliente :'
        end
        object Label13: TLabel
          Left = 69
          Top = 250
          Width = 81
          Height = 16
          Alignment = taRightJustify
          Caption = 'Valor Venda :'
        end
        object SpeedButton1: TSpeedButton
          Left = 216
          Top = 172
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
        object Label14: TLabel
          Left = 248
          Top = 176
          Width = 81
          Height = 16
          Caption = '                           '
        end
        object SpeedButton2: TSpeedButton
          Left = 632
          Top = 172
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
        object Label15: TLabel
          Left = 664
          Top = 176
          Width = 81
          Height = 16
          Caption = '                           '
        end
        object SpeedButton3: TSpeedButton
          Left = 216
          Top = 198
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
        object Label16: TLabel
          Left = 248
          Top = 202
          Width = 81
          Height = 16
          Caption = '                           '
        end
        object Label17: TLabel
          Left = 502
          Top = 202
          Width = 66
          Height = 16
          Alignment = taRightJustify
          Caption = 'Vendedor :'
        end
        object SpeedButton4: TSpeedButton
          Left = 632
          Top = 198
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
        object Label18: TLabel
          Left = 664
          Top = 202
          Width = 81
          Height = 16
          Caption = '                           '
        end
        object Label11: TLabel
          Left = 493
          Top = 250
          Width = 75
          Height = 16
          Alignment = taRightJustify
          Caption = 'Valor Custo :'
        end
        object Label12: TLabel
          Left = 463
          Top = 125
          Width = 105
          Height = 16
          Alignment = taRightJustify
          Caption = 'Data Aprova'#231#227'o :'
        end
        object Label19: TLabel
          Left = 14
          Top = 329
          Width = 136
          Height = 16
          Alignment = taRightJustify
          Caption = 'C'#243'd. Requis. Amostra :'
        end
        object SpeedButton5: TSpeedButton
          Left = 216
          Top = 325
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
        object Label20: TLabel
          Left = 248
          Top = 329
          Width = 81
          Height = 16
          Caption = '                           '
        end
        object Label21: TLabel
          Left = 62
          Top = 413
          Width = 88
          Height = 16
          Alignment = taRightJustify
          Caption = 'Observa'#231#245'es :'
        end
        object Label22: TLabel
          Left = 439
          Top = 227
          Width = 129
          Height = 16
          Alignment = taRightJustify
          Caption = 'Quantidade Amostra :'
        end
        object Label23: TLabel
          Left = 468
          Top = 329
          Width = 100
          Height = 16
          Alignment = taRightJustify
          Caption = 'C'#243'digo Produto :'
        end
        object Label24: TLabel
          Left = 59
          Top = 95
          Width = 92
          Height = 16
          Alignment = taRightJustify
          Caption = 'Departamento :'
        end
        object Label25: TLabel
          Left = 28
          Top = 37
          Width = 122
          Height = 16
          Alignment = taRightJustify
          Caption = 'Classifica'#231#227'o Prod. :'
        end
        object SpeedButton15: TSpeedButton
          Left = 239
          Top = 32
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
          Left = 270
          Top = 36
          Width = 168
          Height = 16
          Caption = '                                                        '
        end
        object ECodigo: TDBKeyViolation
          Left = 156
          Top = 3
          Width = 81
          Height = 24
          Color = 11661566
          DataField = 'CODAMOSTRA'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = ECodigoChange
          ACampoObrigatorio = True
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
          ADataBase = FPrincipal.BaseDados
          ATabela = 'AMOSTRA'
        end
        object DBEditColor1: TDBEditColor
          Left = 156
          Top = 58
          Width = 501
          Height = 24
          Color = 11661566
          DataField = 'NOMAMOSTRA'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = ECodigoChange
          ACampoObrigatorio = True
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
        end
        object DBEditColor2: TDBEditColor
          Left = 156
          Top = 121
          Width = 133
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'DATAMOSTRA'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = True
          AIgnorarTipoLetra = False
        end
        object EDatEntrega: TDBEditColor
          Left = 572
          Top = 146
          Width = 85
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'DATENTREGA'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = True
          AIgnorarTipoLetra = False
        end
        object DBEditColor4: TDBEditColor
          Left = 156
          Top = 146
          Width = 81
          Height = 24
          Color = clInfoBk
          DataField = 'DATENTREGACLIENTE'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = True
          AIgnorarTipoLetra = False
        end
        object DBEditLocaliza1: TDBEditLocaliza
          Left = 572
          Top = 172
          Width = 58
          Height = 24
          Color = 11661566
          DataField = 'CODCOLECAO'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnChange = ECodigoChange
          ACampoObrigatorio = True
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
          ATexto = Label15
          ABotao = SpeedButton2
          ADataBase = FPrincipal.BaseDados
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from COLECAO'
            'Where CODCOLECAO = @')
          ASelectLocaliza.Strings = (
            'Select * from COLECAO'
            'Where NOMCOLECAO LIKE '#39'@%'#39
            'order by NOMCOLECAO')
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          APermitirVazio = True
          AInfo.CampoCodigo = 'CODCOLECAO'
          AInfo.CampoNome = 'NOMCOLECAO'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Cole'#231#227'o   '
          AInfo.Cadastrar = True
          OnCadastrar = DBEditLocaliza1Cadastrar
        end
        object DBEditLocaliza2: TDBEditLocaliza
          Left = 156
          Top = 172
          Width = 58
          Height = 24
          Color = 11661566
          DataField = 'CODDESENVOLVEDOR'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          OnChange = ECodigoChange
          ACampoObrigatorio = True
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
          ATexto = Label14
          ABotao = SpeedButton1
          ADataBase = FPrincipal.BaseDados
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from DESENVOLVEDOR'
            'Where CODDESENVOLVEDOR = @')
          ASelectLocaliza.Strings = (
            'Select * from DESENVOLVEDOR'
            'Where NOMDESENVOLVEDOR Like '#39'@%'#39' '
            'order by NOMDESENVOLVEDOR')
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          APermitirVazio = True
          AInfo.CampoCodigo = 'CODDESENVOLVEDOR'
          AInfo.CampoNome = 'NOMDESENVOLVEDOR'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Desenvolvedor   '
          AInfo.Cadastrar = True
          OnCadastrar = DBEditLocaliza2Cadastrar
        end
        object DBEditLocaliza3: TDBEditLocaliza
          Left = 156
          Top = 198
          Width = 58
          Height = 24
          Color = 11661566
          DataField = 'CODCLIENTE'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          OnChange = ECodigoChange
          ACampoObrigatorio = True
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
          ATexto = Label16
          ABotao = SpeedButton3
          ADataBase = FPrincipal.BaseDados
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CADCLIENTES'
            'Where I_COD_CLI = @ '
            'and (C_IND_PRC = '#39'S'#39' OR'
            ' C_IND_CLI = '#39'S'#39')'
            '')
          ASelectLocaliza.Strings = (
            'Select * from CADCLIENTES'
            'Where C_NOM_CLI Like '#39'@%'#39' '
            'and (C_IND_PRC = '#39'S'#39' OR'
            ' C_IND_CLI = '#39'S'#39')'
            'order by C_NOM_CLI')
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          APermitirVazio = True
          AInfo.CampoCodigo = 'I_COD_CLI'
          AInfo.CampoNome = 'C_NOM_CLI'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Prospect   '
          AInfo.Cadastrar = True
          OnCadastrar = DBEditLocaliza3Cadastrar
        end
        object DBEditLocaliza4: TDBEditLocaliza
          Left = 572
          Top = 198
          Width = 58
          Height = 24
          Color = 11661566
          DataField = 'CODVENDEDOR'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          OnChange = ECodigoChange
          ACampoObrigatorio = True
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
          ATexto = Label18
          ABotao = SpeedButton4
          ADataBase = FPrincipal.BaseDados
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from CADVENDEDORES'
            'Where I_COD_VEN = @')
          ASelectLocaliza.Strings = (
            'Select * from CADVENDEDORES'
            'Where C_NOM_VEN Like '#39'@%'#39' '
            'order by C_NOM_VEN')
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          APermitirVazio = True
          AInfo.CampoCodigo = 'I_COD_VEN'
          AInfo.CampoNome = 'C_NOM_VEN'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Vendedor   '
        end
        object CCopia: TDBCheckBox
          Left = 156
          Top = 224
          Width = 68
          Height = 17
          Caption = 'C'#243'pia'
          DataField = 'INDCOPIA'
          DataSource = DataAmostra
          TabOrder = 13
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBEditColor5: TDBEditColor
          Left = 156
          Top = 247
          Width = 81
          Height = 24
          Color = clInfoBk
          DataField = 'VALVENDA'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
        end
        object DBEditColor6: TDBEditColor
          Left = 572
          Top = 247
          Width = 85
          Height = 24
          Color = clInfoBk
          DataField = 'VALCUSTO'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
        end
        object DBEditColor7: TDBEditColor
          Left = 156
          Top = 273
          Width = 457
          Height = 24
          Color = clInfoBk
          DataField = 'DESIMAGEM'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 18
          OnChange = ECodigoChange
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
        end
        object DBEditColor8: TDBEditColor
          Left = 156
          Top = 299
          Width = 457
          Height = 24
          Color = clInfoBk
          DataField = 'DESIMAGEMCLIENTE'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 19
          OnChange = ECodigoChange
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
        end
        object EDatAprovacao: TDBEditColor
          Left = 572
          Top = 121
          Width = 85
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'DATAPROVACAO'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = True
          AIgnorarTipoLetra = False
        end
        object ETipoAmostra: TDBRadioGroup
          Left = 288
          Top = -8
          Width = 369
          Height = 37
          Columns = 2
          DataField = 'TIPAMOSTRA'
          DataSource = DataAmostra
          Items.Strings = (
            'Amostra Realizada'
            'Requisi'#231#227'o de Amostra')
          ParentBackground = True
          TabOrder = 1
          Values.Strings = (
            'D'
            'I')
          OnChange = ETipoAmostraChange
          OnClick = ETipoAmostraChange
        end
        object EAmostraIndefinida: TDBEditLocaliza
          Left = 156
          Top = 325
          Width = 58
          Height = 24
          Color = clInfoBk
          DataField = 'CODAMOSTRAINDEFINIDA'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
          OnChange = ECodigoChange
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
          ATexto = Label20
          ABotao = SpeedButton5
          ADataBase = FPrincipal.BaseDados
          ALocaliza = Localiza
          ASelectValida.Strings = (
            'Select * from AMOSTRA'
            'Where CODAMOSTRA= @')
          ASelectLocaliza.Strings = (
            'Select * from AMOSTRA'
            'Where NOMAMOSTRA LIKE '#39'@%'#39
            'order by NOMAMOSTRA')
          ACorForm = FPrincipal.CorForm
          ACorPainelGra = FPrincipal.CorPainelGra
          APermitirVazio = True
          AInfo.CampoCodigo = 'CODAMOSTRA'
          AInfo.CampoNome = 'NOMAMOSTRA'
          AInfo.Nome1 = 'C'#243'digo'
          AInfo.Nome2 = 'Nome'
          AInfo.Tamanho1 = 8
          AInfo.Tamanho2 = 40
          AInfo.Tamanho3 = 0
          AInfo.TituloForm = '   Localiza Amostra Indefinida   '
          AInfo.Cadastrar = True
          OnCadastrar = DBEditLocaliza2Cadastrar
        end
        object DBMemoColor1: TDBMemoColor
          Left = 155
          Top = 351
          Width = 505
          Height = 138
          Color = clInfoBk
          DataField = 'DESOBSERVACAO'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
          ACampoObrigatorio = False
          ACorFoco = FPrincipal.CorFoco
        end
        object DBEditColor3: TDBEditColor
          Left = 572
          Top = 223
          Width = 85
          Height = 24
          Color = clInfoBk
          DataField = 'QTDAMOSTRA'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
        end
        object DBEditColor9: TDBEditColor
          Left = 572
          Top = 325
          Width = 85
          Height = 24
          Color = clInfoBk
          DataField = 'CODPRODUTO'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
          ACampoObrigatorio = False
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
        end
        object BFoto: TBitBtn
          Left = 616
          Top = 272
          Width = 41
          Height = 27
          HelpContext = 27
          DoubleBuffered = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
            BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
            BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
            BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
            BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
            EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
            EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
            EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
            EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
          NumGlyphs = 2
          ParentDoubleBuffered = False
          TabOrder = 23
          OnClick = BFotoClick
        end
        object BitBtn1: TBitBtn
          Left = 616
          Top = 298
          Width = 41
          Height = 27
          HelpContext = 27
          DoubleBuffered = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
            BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
            BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
            BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
            BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
            EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
            EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
            EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
            EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
          NumGlyphs = 2
          ParentDoubleBuffered = False
          TabOrder = 24
        end
        object DBCheckBox1: TDBCheckBox
          Left = 237
          Top = 224
          Width = 97
          Height = 17
          Caption = 'Altera'#231#227'o'
          DataField = 'INDALTERACAO'
          DataSource = DataAmostra
          TabOrder = 14
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object DBRadioGroup1: TDBRadioGroup
          Left = 156
          Top = 82
          Width = 501
          Height = 36
          Columns = 3
          DataField = 'DESDEPARTAMENTO'
          DataSource = DataAmostra
          Items.Strings = (
            'Desenvolvimento'
            'Ficha Tecnica'
            'Amostra')
          ParentBackground = True
          TabOrder = 4
          Values.Strings = (
            'D'
            'F'
            'A')
          OnChange = ETipoAmostraChange
          OnClick = ETipoAmostraChange
        end
        object ECodClassificacao: TDBEditColor
          Left = 156
          Top = 32
          Width = 81
          Height = 24
          Color = 11661566
          DataField = 'CODCLASSIFICACAO'
          DataSource = DataAmostra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnExit = ECodClassifcacaoExit
          OnKeyDown = ECodClassifcacaoKeyDown
          ACampoObrigatorio = True
          AIgnorarCor = False
          ACorFoco = FPrincipal.CorFoco
          AFormatoData = False
          AIgnorarTipoLetra = False
        end
      end
    end
  end
  object Amostra: TRBSQL
    Aggregates = <>
    PacketRecords = 2
    Params = <>
    ProviderName = 'InternalProvider'
    AfterInsert = AmostraAfterInsert
    AfterEdit = AmostraAfterEdit
    BeforePost = AmostraBeforePost
    AfterPost = AmostraAfterPost
    AfterCancel = AmostraAfterCancel
    AfterScroll = AmostraAfterScroll
    AFecharFormulario = BFechar
    AGravar = BotaoGravar1
    ACancelar = BotaoCancelar1
    AAlterar = FAmostras.BotaoAlterar1
    AExcluir = FAmostras.BotaoExcluir1
    AConsultar = FAmostras.BotaoConsultar1
    ACadastrar = FAmostras.BotaoCadastrar1
    ASQlConnection = FPrincipal.BaseDados
    ASqlQuery.MaxBlobSize = -1
    ASqlQuery.Params = <>
    ASqlQuery.SQLConnection = FPrincipal.BaseDados
    SQL.Strings = (
      'Select * from  AMOSTRA')
    Left = 16
    Top = 8
    object AmostraCODAMOSTRA: TFMTBCDField
      FieldName = 'CODAMOSTRA'
      Origin = 'BASEDADOS.AMOSTRA.CODAMOSTRA'
    end
    object AmostraNOMAMOSTRA: TWideStringField
      FieldName = 'NOMAMOSTRA'
      Origin = 'BASEDADOS.AMOSTRA.NOMAMOSTRA'
      Size = 50
    end
    object AmostraDATAMOSTRA: TSQLTimeStampField
      FieldName = 'DATAMOSTRA'
      Origin = 'BASEDADOS.AMOSTRA.DATAMOSTRA'
    end
    object AmostraDATENTREGA: TSQLTimeStampField
      FieldName = 'DATENTREGA'
      Origin = 'BASEDADOS.AMOSTRA.DATENTREGA'
    end
    object AmostraDATENTREGACLIENTE: TSQLTimeStampField
      FieldName = 'DATENTREGACLIENTE'
      Origin = 'BASEDADOS.AMOSTRA.DATENTREGACLIENTE'
    end
    object AmostraCODCOLECAO: TFMTBCDField
      FieldName = 'CODCOLECAO'
      Origin = 'BASEDADOS.AMOSTRA.CODCOLECAO'
    end
    object AmostraCODDESENVOLVEDOR: TFMTBCDField
      FieldName = 'CODDESENVOLVEDOR'
      Origin = 'BASEDADOS.AMOSTRA.CODDESENVOLVEDOR'
    end
    object AmostraCODPROSPECT: TFMTBCDField
      FieldName = 'CODPROSPECT'
      Origin = 'BASEDADOS.AMOSTRA.CODPROSPECT'
    end
    object AmostraDESIMAGEM: TWideStringField
      FieldName = 'DESIMAGEM'
      Origin = 'BASEDADOS.AMOSTRA.DESIMAGEM'
      Size = 100
    end
    object AmostraDESIMAGEMCLIENTE: TWideStringField
      FieldName = 'DESIMAGEMCLIENTE'
      Origin = 'BASEDADOS.AMOSTRA.DESIMAGEMCLIENTE'
      Size = 100
    end
    object AmostraINDCOPIA: TWideStringField
      FieldName = 'INDCOPIA'
      Origin = 'BASEDADOS.AMOSTRA.INDCOPIA'
      Size = 1
    end
    object AmostraVALCUSTO: TFMTBCDField
      FieldName = 'VALCUSTO'
      Origin = 'BASEDADOS.AMOSTRA.VALCUSTO'
      currency = True
    end
    object AmostraVALVENDA: TFMTBCDField
      FieldName = 'VALVENDA'
      Origin = 'BASEDADOS.AMOSTRA.VALVENDA'
      currency = True
    end
    object AmostraDATAPROVACAO: TSQLTimeStampField
      FieldName = 'DATAPROVACAO'
      Origin = 'BASEDADOS.AMOSTRA.DATAPROVACAO'
    end
    object AmostraCODVENDEDOR: TFMTBCDField
      FieldName = 'CODVENDEDOR'
      Origin = 'BASEDADOS.AMOSTRA.CODVENDEDOR'
    end
    object AmostraTIPAMOSTRA: TWideStringField
      FieldName = 'TIPAMOSTRA'
      Origin = 'BASEDADOS.AMOSTRA.TIPAMOSTRA'
      Size = 1
    end
    object AmostraCODAMOSTRAINDEFINIDA: TFMTBCDField
      FieldName = 'CODAMOSTRAINDEFINIDA'
      Origin = 'BASEDADOS.AMOSTRA.CODAMOSTRAINDEFINIDA'
    end
    object AmostraDESOBSERVACAO: TWideStringField
      FieldName = 'DESOBSERVACAO'
      Origin = 'BASEDADOS.AMOSTRA.DESOBSERVACAO'
      Size = 1
    end
    object AmostraQTDAMOSTRA: TFMTBCDField
      FieldName = 'QTDAMOSTRA'
      Origin = 'BASEDADOS.AMOSTRA.QTDAMOSTRA'
    end
    object AmostraCODPRODUTO: TWideStringField
      FieldName = 'CODPRODUTO'
      Origin = 'BASEDADOS.AMOSTRA.CODPRODUTO'
    end
    object AmostraQTDPREVISAOCOMPRA: TFMTBCDField
      FieldName = 'QTDPREVISAOCOMPRA'
      Origin = 'BASEDADOS.AMOSTRA.QTDPREVISAOCOMPRA'
    end
    object AmostraINDALTERACAO: TWideStringField
      FieldName = 'INDALTERACAO'
      Origin = 'BASEDADOS.AMOSTRA.INDALTERACAO'
      Size = 1
    end
    object AmostraCODCLIENTE: TFMTBCDField
      FieldName = 'CODCLIENTE'
      Origin = 'BASEDADOS.AMOSTRA.CODCLIENTE'
    end
    object AmostraDESDEPARTAMENTO: TWideStringField
      FieldName = 'DESDEPARTAMENTO'
      Origin = 'BASEDADOS.AMOSTRA.DESDEPARTAMENTO'
      Size = 1
    end
    object AmostraCODCLASSIFICACAO: TWideStringField
      FieldName = 'CODCLASSIFICACAO'
      Origin = 'BASEDADOS.AMOSTRA.CODCLASSIFICACAO'
      Size = 15
    end
  end
  object DataAmostra: TDataSource
    AutoEdit = False
    DataSet = Amostra
    Left = 69
    Top = 5
  end
  object Localiza: TConsultaPadrao
    ACadastrar = False
    AAlterar = False
    Left = 112
  end
  object ValidaGravacao1: TValidaGravacao
    AComponente = PanelColor1
    ABotaoGravar = BotaoGravar1
    Left = 232
    Top = 8
  end
  object EditorImagem1: TEditorImagem
    Left = 326
    Top = 3
  end
end
