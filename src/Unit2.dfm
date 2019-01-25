object Form2: TForm2
  Left = 471
  Top = 232
  Width = 355
  Height = 326
  Caption = 'Table Definitions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 347
    Height = 280
    Align = alClient
    ColCount = 3
    DefaultColWidth = 120
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goThumbTracking]
    TabOrder = 0
    ColWidths = (
      120
      120
      89)
  end
  object MainMenu1: TMainMenu
    Left = 128
    Top = 140
    object File1: TMenuItem
      Caption = 'File'
      object SaveasText1: TMenuItem
        Caption = 'Save as Text'
        OnClick = SaveasText1Click
      end
    end
    object Exit1: TMenuItem
      Caption = 'E&xit'
      OnClick = Exit1Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'TXT'
    Filter = 'Ascci Text file|*.Txt'
    Left = 156
    Top = 84
  end
end
