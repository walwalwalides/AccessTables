object Form4: TForm4
  Left = 271
  Top = 169
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Column adjustment for Table & Query DbGrids'
  ClientHeight = 327
  ClientWidth = 213
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 3
    Width = 67
    Height = 26
    Caption = 'Table DbGrid '#13#10'column widths'
  end
  object Label2: TLabel
    Left = 116
    Top = 2
    Width = 67
    Height = 26
    Caption = 'Query DbGrid '#13#10'column widths'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 32
    Width = 75
    Height = 229
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 268
    Width = 74
    Height = 21
    Color = clLime
    MaxLength = 4
    TabOrder = 1
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 115
    Top = 267
    Width = 76
    Height = 21
    Color = clLime
    MaxLength = 4
    TabOrder = 2
    OnKeyPress = Edit1KeyPress
  end
  object ListBox2: TListBox
    Left = 115
    Top = 29
    Width = 77
    Height = 232
    ItemHeight = 13
    TabOrder = 3
    OnClick = ListBox2Click
  end
  object Button1: TButton
    Left = 16
    Top = 292
    Width = 45
    Height = 21
    Caption = 'Set'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 133
    Top = 291
    Width = 44
    Height = 21
    Caption = 'Set'
    TabOrder = 5
    OnClick = Button2Click
  end
end
