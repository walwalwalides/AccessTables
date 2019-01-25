object Form1: TForm1
  Left = 455
  Top = 115
  Width = 848
  Height = 628
  Caption = 'MSACCESS data Read/Write utility'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    840
    582)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 4
    Width = 75
    Height = 13
    Caption = 'Table Names'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 572
    Top = 12
    Width = 67
    Height = 13
    Caption = 'Total Records'
  end
  object Label3: TLabel
    Left = 631
    Top = 325
    Width = 97
    Height = 26
    Caption = 'Click on Col headers'#13#10'for sorting'
  end
  object Label4: TLabel
    Left = 240
    Top = 323
    Width = 18
    Height = 16
    Caption = 'Tot'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 3
    Top = 348
    Width = 29
    Height = 16
    Caption = 'Filter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DBNavigator1: TDBNavigator
    Left = 192
    Top = 4
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 166
    Top = 32
    Width = 671
    Height = 285
    Anchors = [akLeft, akTop, akRight]
    Color = 10930928
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
  end
  object ListBox1: TListBox
    Left = 4
    Top = 20
    Width = 161
    Height = 297
    Color = 10930928
    ItemHeight = 13
    TabOrder = 2
    OnClick = ListBox1Click
  end
  object Memo1: TMemo
    Left = 4
    Top = 372
    Width = 349
    Height = 200
    Anchors = [akLeft, akTop, akBottom]
    Color = clMoneyGreen
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object DBNavigator2: TDBNavigator
    Left = 417
    Top = 328
    Width = 210
    Height = 25
    DataSource = DataSource2
    TabOrder = 4
  end
  object DBGrid2: TDBGrid
    Left = 360
    Top = 356
    Width = 473
    Height = 216
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clMoneyGreen
    DataSource = DataSource2
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = DBGrid2TitleClick
  end
  object CheckBox1: TCheckBox
    Left = 6
    Top = 319
    Width = 79
    Height = 17
    Caption = 'ASC Order'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object CheckBox2: TCheckBox
    Left = 104
    Top = 320
    Width = 109
    Height = 17
    Caption = 'Show Memo data'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object Edit1: TEdit
    Left = 35
    Top = 344
    Width = 319
    Height = 21
    TabOrder = 8
  end
  object DataSource1: TDataSource
    DataSet = ADOTableAccess
    Left = 436
    Top = 108
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 532
    Top = 152
  end
  object ADOTableAccess: TADOTable
    Connection = ADOConn
    CursorType = ctStatic
    TableName = 'Location'
    Left = 436
    Top = 168
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 532
    Top = 440
  end
  object OpenDialogAccess: TOpenDialog
    DefaultExt = 'MDB'
    Filter = 'Access database files|*.MDB'
    Left = 56
    Top = 196
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery1
    Left = 620
    Top = 436
  end
  object MainMenu1: TMainMenu
    Left = 528
    Top = 224
    object File1: TMenuItem
      Caption = '&File'
      object OpenAccessFile: TMenuItem
        Caption = '&Open Access Tables'
        OnClick = OpenAccessFileClick
      end
      object OpenExcelSheets1: TMenuItem
        Caption = 'Open Excel Sheets'
        OnClick = OpenExcelSheets1Click
      end
      object MDAVVersion1: TMenuItem
        Caption = 'MDAC Version '
        OnClick = MDAVVersion1Click
      end
    end
    object Save1: TMenuItem
      Caption = 'Save'
      object ExcelFile1: TMenuItem
        Caption = 'Excel File(Table content)'
        OnClick = ExcelFile1Click
      end
      object ExcelFileQuerycontent1: TMenuItem
        Caption = 'Excel File(Query content)'
        OnClick = ExcelFileQuerycontent1Click
      end
    end
    object Show1: TMenuItem
      Caption = 'Show'
      object ableDefinitions1: TMenuItem
        Caption = 'Table Definitions'
        OnClick = ableDefinitions1Click
      end
    end
    object Exce1: TMenuItem
      Caption = 'Exec'
      object SQLcode1: TMenuItem
        Caption = 'SQL code'
        OnClick = SQLcode1Click
      end
    end
    object Filtermenu: TMenuItem
      Caption = 'Filter'
      object ableData1: TMenuItem
        Caption = 'Table Data'
        OnClick = ableData1Click
      end
      object SQLData1: TMenuItem
        Caption = 'SQL Data'
        OnClick = SQLData1Click
      end
    end
    object Columns1: TMenuItem
      Caption = 'Columns'
      object ableTOP1: TMenuItem
        Caption = 'Table(TOP)'
        OnClick = ableTOP1Click
      end
      object QueryBottom1: TMenuItem
        Caption = 'Query(Bottom)'
        OnClick = QueryBottom1Click
      end
    end
    object Exit1: TMenuItem
      Caption = 'E&xit'
      OnClick = Exit1Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'XLS'
    Filter = 'MS Excel Files|*.XLS'
    Left = 60
    Top = 112
  end
  object ADOTableExcel: TADOTable
    Connection = ADOConn
    TableDirect = True
    Left = 340
    Top = 224
  end
  object OpenDialogExcel: TOpenDialog
    DefaultExt = 'XLS'
    Filter = 'MS Excel  files|*.XLS'
    Left = 56
    Top = 252
  end
end
