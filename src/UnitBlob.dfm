object FormBlob: TFormBlob
  Left = 744
  Top = 256
  Width = 299
  Height = 205
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Binary Data(BLOB)'
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
    Left = 8
    Top = 38
    Width = 106
    Height = 16
    Caption = 'Blob Size(Bytes)='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnsaveBlob: TButton
    Left = 5
    Top = 58
    Width = 170
    Height = 21
    Cursor = crHandPoint
    Caption = 'Save BLOB Data to File'
    TabOrder = 0
    OnClick = btnsaveBlobClick
  end
  object Button2: TButton
    Left = 5
    Top = 78
    Width = 170
    Height = 21
    Cursor = crHandPoint
    Caption = 'Save BLOB Data && Show'
    TabOrder = 1
  end
  object btnEraseBlobData: TButton
    Left = 5
    Top = 98
    Width = 170
    Height = 21
    Cursor = crHandPoint
    Caption = 'Erase BLOB Data'
    TabOrder = 2
    OnClick = btnEraseBlobDataClick
  end
  object DBNavigator1: TDBNavigator
    Left = 4
    Top = 4
    Width = 234
    Height = 25
    DataSource = Form5.DataSource1
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel, nbRefresh]
    TabOrder = 3
    OnClick = DBNavigator1Click
  end
  object btnlddatafromFile: TButton
    Left = 5
    Top = 118
    Width = 170
    Height = 21
    Cursor = crHandPoint
    Caption = 'Load BLOB Data from File'
    TabOrder = 4
    OnClick = btnlddatafromFileClick
  end
  object BitBtn1: TBitBtn
    Left = 188
    Top = 80
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkClose
  end
end
