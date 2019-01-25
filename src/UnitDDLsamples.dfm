object frmDDLsamples: TfrmDDLsamples
  Left = 526
  Top = 314
  Width = 726
  Height = 525
  Caption = 'MSACCESS DDL Examples'
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
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 718
    Height = 498
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'create table'
      'ADOCommand.CommandText :='
      '  '#39'CREATE TABLE NameList '#39' +'
      '  '#39' ( '#39' +'
      '  '#39' IDKey     TEXT(10)  PRIMARY KEY, '#39' +'
      '  '#39' NameLast  TEXT(24)  NOT NULL, '#39' +'
      '  '#39' NameFirst TEXT(20)  NOT NULL, '#39' +'
      '  '#39' NameMiddleInitial TEXT(1), '#39' +'
      '  '#39' Notes     MEMO, '#39' +'
      '  '#39' Picture   LongBinary, '#39' +'
      '  '#39' BirthDate DATE '#39' +'
      '  '#39' )'#39';'
      ''
      '  drop Table'
      'ADOCommand.CommandText :='
      '  '#39'DROP TABLE NameList'#39';'
      ''
      '  Create Index'
      '  ADOCommand.CommandText :='
      '  '#39'CREATE UNIQUE INDEX NameIndex ON NameList '#39' +'
      '  '#39'( '#39' +'
      '  '#39' NameLast ASC, '#39' +'
      '  '#39' NameFirst ASC '#39' +'
      '  '#39')'#39';'
      ''
      '  Drop Index'
      '  ADOCommand.CommandText :='
      '  '#39'DROP INDEX NameIndex ON NameList'#39';'
      ''
      
        'from http://coding.derkeiler.com/Archive/Delphi/borland.public.d' +
        'elphi.database.ado/2004-01/0270.html'
      ''
      '      ADOCommand.CommandText :='
      '        '#39'CREATE TABLE ROAMINGDATA '#39' +'
      '        '#39' ( '#39' +'
      '        '#39' UID CHAR(20) PRIMARY KEY, '#39' +'
      '        '#39' ACCOUNT_NUMBER INTEGER NOT NULL, '#39' +'
      '        '#39' MEMBER_NUMBER INTEGER NOT NULL, '#39' +'
      '        '#39' FIRST_LAST CHAR(100), '#39' +'
      '        '#39' FIRST_INIT_LAST_NAME CHAR(50), '#39' +'
      '        '#39' HOME_PHONE CHAR(12), '#39' +'
      '        '#39' HOME_PHONE_STRIPPED CHAR(7), '#39' +'
      '        '#39' WORK_PHONE CHAR(12), '#39' +'
      '        '#39' WORK_PHONE_STRIPPED CHAR(7), '#39' +'
      '        '#39' MEMBERSHIP_TYPE CHAR(50), '#39' +'
      '        '#39' ADDRESS_1 CHAR(100), '#39' +'
      '        '#39' HOME_CLUB CHAR(3), '#39' +'
      '        '#39' ALLOW_ENTRY BIT, '#39' + // Boolean'
      '        '#39' ACCESS_MESSAGE MEMO, '#39' +'
      '        '#39' ACCESS_COLOR INTEGER, '#39' +'
      '        '#39' ACCESS_FONT_COLOR INTEGER, '#39' +'
      '        '#39' BARCODE CHAR(12) '#39' +'
      '        '#39' )'#39';'
      '      ADOCommand.Execute;'
      ''
      'AUTO INCREMENT WITH PRIMARY KEY'
      'CREATE TABLE NameList'
      ' ('
      ' IDKey   COUNTER PRIMARY KEY ,'
      ' NameLast  TEXT(24)  NOT NULL,'
      ' NameFirst TEXT(20)  NOT NULL,'
      ' NameMiddleInitial TEXT(1),'
      ' Notes     MEMO,'
      ' Picture   LongBinary,'
      ' BirthDate DATE'
      '   );'
      'ADOCommand.Execute;'
      ''
      'CREATE TABLE OMID'
      ' ('
      ' ID COUNTER,'
      ' AGE DATE,'
      ' BIRTHDATE DATETIME,'
      ' WAGE DECIMAL(19,4),'
      ' SALARY FLOAT,'
      ' SALARIED YESNO'
      ')'
      'ADOCommand.Execute;'
      ''
      '      // Create indices'
      
        '      ADOCommand.CommandText := '#39'CREATE INDEX IDX_ACCOUNT_NUMBER' +
        ' ON'
      'ROAMINGDATA (ACCOUNT_NUMBER)'#39';'
      '      ADOCommand.Execute;'
      ''
      
        '      ADOCommand.CommandText := '#39'CREATE INDEX IDX_MEMBER_NUMBER ' +
        'ON'
      'ROAMINGDATA (MEMBER_NUMBER)'#39';'
      '      ADOCommand.Execute;'
      ''
      
        '      ADOCommand.CommandText := '#39'CREATE INDEX IDX_FIRST_INIT_LAS' +
        'T_NAME ON'
      'ROAMINGDATA (FIRST_INIT_LAST_NAME)'#39';'
      '      ADOCommand.Execute;'
      ''
      
        '      ADOCommand.CommandText := '#39'CREATE INDEX IDX_HOME_PHONE_STR' +
        'IPPED ON'
      'ROAMINGDATA (HOME_PHONE_STRIPPED)'#39';'
      '      ADOCommand.Execute;'
      ''
      
        '      ADOCommand.CommandText := '#39'CREATE INDEX IDX_WORK_PHONE_STR' +
        'IPPED ON'
      'ROAMINGDATA (WORK_PHONE_STRIPPED)'#39';'
      '      ADOCommand.Execute;'
      ''
      
        '      ADOCommand.CommandText := '#39'CREATE INDEX IDX_BARCODE ON ROA' +
        'MINGDATA'
      '(BARCODE)'#39';'
      ''
      
        'ALTER TABLE employee DROP LAST_NAME, DROP FIRST_NAME, ADD FULL_N' +
        'AME TEXT(30)'
      '*)')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
end
