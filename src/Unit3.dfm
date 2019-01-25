object Form3: TForm3
  Left = 666
  Top = 329
  Width = 461
  Height = 409
  Caption = 'Memo content'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    453
    363)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 212
    Top = 8
    Width = 52
    Height = 13
    Caption = 'Memo Size'
  end
  object DBNavigator1: TDBNavigator
    Left = 1
    Top = 1
    Width = 198
    Height = 25
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
    TabOrder = 0
    OnClick = DBNavigator1Click
  end
  object dbmemodata: TDBMemo
    Left = 4
    Top = 28
    Width = 449
    Height = 333
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 64
    Top = 20
    object Exit1: TMenuItem
      Caption = 'E&xit'
      OnClick = Exit1Click
    end
    object Save1: TMenuItem
      Caption = '&SaveToFile'
      OnClick = Save1Click
    end
    object Load1: TMenuItem
      Caption = '&LoadFromFile'
      OnClick = Load1Click
    end
  end
  object SaveDialog: TSaveDialog
    Left = 56
    Top = 80
  end
  object OpenDialog: TOpenDialog
    Left = 148
    Top = 76
  end
end
