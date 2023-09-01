object Form1: TForm1
  Left = 405
  Top = 259
  Width = 960
  Height = 551
  Caption = 'PrinterMon 1.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 33
    Width = 944
    Height = 238
    Align = alTop
    ColCount = 7
    FixedCols = 0
    RowCount = 20
    TabOrder = 0
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 944
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 75
      Height = 13
      Caption = #1048#1084#1103' '#1087#1088#1080#1085#1090#1077#1088#1072':'
    end
    object ComboBox1: TComboBox
      Left = 96
      Top = 6
      Width = 369
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnSelect = ComboBox1Select
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 294
    Width = 944
    Height = 200
    Align = alClient
    BevelOuter = bvSpace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 494
    Width = 944
    Height = 19
    Panels = <>
  end
  object Panel2: TPanel
    Left = 0
    Top = 271
    Width = 944
    Height = 23
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 5
      Width = 119
      Height = 13
      Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103':'
    end
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 1080
    Top = 272
  end
end
