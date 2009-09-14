object FPrincipal: TFPrincipal
  Left = 192
  Top = 114
  Caption = 'FPrincipal'
  ClientHeight = 318
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BaseDados: TSQLConnection
    ConnectionName = 'BASEDADOSORA'
    DriverName = 'Oracle'
    GetDriverFunc = 'getSQLDriverORACLE'
    LibraryName = 'dbxora.dll'
    LoginPrompt = False
    Params.Strings = (
      'drivername=Oracle'
      'Database=SisCorp'
      'user_name=system'
      'password=1298'
      'rowsetsize=20'
      'blobsize=-1'
      'localecode=0000'
      'oracle transisolation=ReadCommited'
      'os authentication=False'
      'multiple transaction=False'
      'trim char=False'
      'decimal separator=,')
    VendorLib = 'oci.dll'
    Left = 40
    Top = 24
  end
end
