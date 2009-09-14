object FCompactador: TFCompactador
  Left = 192
  Top = 103
  Caption = 'Por favor, Aguarde!'
  ClientHeight = 90
  ClientWidth = 337
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object Gauge1: TGauge
    Left = 8
    Top = 25
    Width = 321
    Height = 41
    Progress = 0
  end
  object Label1: TLabel
    Left = 8
    Top = 4
    Width = 321
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Aguarde enquanto o sistema compacta o backup.'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 41
    Height = 16
    Caption = 'Label2'
  end
end
