unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ADODB, DB, Grids, DBGrids, ExtCtrls, DBCtrls, clipbrd,
  Menus,comobj;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    Panel5: TPanel;
    Splitter3: TSplitter;
    Panel6: TPanel;  
    Label1: TLabel;
    ListBox1: TListBox;
    DBNavigator1: TDBNavigator;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    Label3: TLabel;
    DBNavigator2: TDBNavigator;
    DBGrid2: TDBGrid;
    SaveDialog1: TSaveDialog;
    OpenDialogAccess: TOpenDialog;
    OpenDialogExcel: TOpenDialog;
    ADOTableExcel: TADOTable;
    ADOTableAccess: TADOTable;
    DataSource1: TDataSource;
    ADOConn1: TADOConnection;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    OpenAccessFile: TMenuItem;
    MDAVVersion1: TMenuItem;
    Save1: TMenuItem;
    ExcelFile1: TMenuItem;
    ExcelFileQuerycontent1: TMenuItem;
    Show1: TMenuItem;
    ableDefinitions1: TMenuItem;
    Exce1: TMenuItem;
    SQLcode1: TMenuItem;
    Filtermenu: TMenuItem;
    FilterTableData: TMenuItem;
    Exit1: TMenuItem;
    ADOQuery1: TADOQuery;
    DataSource2: TDataSource;
    Util1: TMenuItem;
    CreateanAccessDatabaseFileMDB1: TMenuItem;
    CompactRepairAccessFile1: TMenuItem;
    DDLAddRemIdxAccesstable1: TMenuItem;
    ADOCommand: TADOCommand;
    Label6: TLabel;
    CloseDatabase1: TMenuItem;
    FilterSQLData: TMenuItem;
    Samples1: TMenuItem;
    PopupMenufont: TPopupMenu;
    SelFont1: TMenuItem;
    FontDialog1: TFontDialog;
    CompacRepairDB1: TMenuItem;
    ConnectAccessTable21: TMenuItem;
    OpenExcelFile1: TMenuItem;
    ADOConnExcel: TADOConnection;
    ADOConn2: TADOConnection;
    procedure ListBox1Click(Sender: TObject);
    procedure ShowtableDef;
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ExcelFile1Click(Sender: TObject);
    procedure ExcelFileQuerycontent1Click(Sender: TObject);
    procedure OpenAccessFileClick(Sender: TObject);
    procedure TableDefinitions1Click(Sender: TObject);
    procedure ExecSQLCode(Sender: TObject);
    procedure FilterTableDataClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FilterSQLDataClick(Sender: TObject);
    procedure OpenExcelSheets1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MDAVVersion1Click(Sender: TObject);
    procedure CreateanAccessDatabaseFileMDB1Click(Sender: TObject);
    procedure CompactRepairAccessFile1Click(Sender: TObject);
    procedure DDLAddRemIdxAccesstable1Click(Sender: TObject);
    procedure CloseDatabase1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Samples1Click(Sender: TObject);
    procedure SelFont1Click(Sender: TObject);
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ConnectAccessTable21Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  BlobFieldName : shortstring;
implementation
// ATTENTION
// ADOTABLE FOR EXCEL FILES MUST SET TABLEDIRECT=TRUE
uses Unit2, Unit3, UnitExcel, UnitBlob, UnitDDLsamples;

{$R *.dfm}
var
 tablemode : integer=-1; //0=accesstable  1=Excel sheet 

procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid);
var i : integer;
begin
  for i := 0 to DBGrid.Columns.Count-1 do
  if DBgrid.Columns[i].Width>200 then DBgrid.Columns[i].Width:=200;
end; (*FixDBGridColumnsWidth*)

procedure TForm5.OpenExcelSheets1Click(Sender: TObject);
var s : string;
begin
 if opendialogexcel.Execute=false then exit;
 adoconnexcel.Connected:=false;
 s:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+opendialogexcel.FileName+
    ';Extended Properties=Excel 8.0;Persist Security Info=False';
 adoconnexcel.ConnectionString:=s;
 adoconnexcel.Connected:=true; Tablemode:=1;
 adoconnexcel.GetTableNames(listbox1.items);
 datasource1.DataSet:=ADOTableExcel;
end;

procedure TForm5.OpenAccessFileClick(Sender: TObject);
{$DEFINE NOACCESSEXITS} //assume the PC does not have MSACCESS installed
(*  THIS IS IF YOU HAVE MSACCESS ALREAY INSTALLED ON THE PC
//this driveer causes exception when app is run IN IDE
const c ='Provider=MSDASQL.1;Persist Security Info=False;Extended Properties='+
         '"DSN=MS Access Database;DBQ=xxxx;'+
         'DefaultDir=yyyy;DriverId=25;FIL=MS Access;'+
         'MaxBufferSize=2048;PageTimeout=5;UID=admin;"';
*)
{$IFDEF  NOACCESSEXITS}
//THIS DRIVER THAT INTENDED FOR PC'S THAT DONT HAVE MSACESS HAS NO DELPHI IDE EXCEPTION PROBLEM
const c1='Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
'Data Source=xxxx;Mode=Share Deny None;Extended Properties="";'+
'Jet OLEDB:System database="";Jet OLEDB:Registry Path="";'+
'Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;'+
'Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;'+
'Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Password="";'+
'Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False;'+
'Jet OLEDB:Don'+#39+'t Copy Locale on Compact=False;'+
'Jet OLEDB:Compact Without Replica Repair=False;'+
'Jet OLEDB:SFP=False';

C ='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=xxxx;Persist Security Info=False';
{$ELSE}
const c ='Provider=MSDASQL.1;Persist Security Info=False;Extended Properties='+
         '"DSN=MS Access Database;DBQ=xxxx;'+
         'DefaultDir=yyyy;DriverId=25;FIL=MS Access;'+
         'MaxBufferSize=2048;PageTimeout=5;UID=admin;"';

{$ENDIF}

var s,t : string;
begin adoconn1.Connected:=false;
 if opendialogaccess.Execute=false then exit;  tablemode:=0;
 t:=opendialogaccess.FileName;
 listbox1.Clear;

 s:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=';
 s:=s+t+';Persist Security Info=True';
 caption:='MS ACCESS Data Read/Write/Create Table Utility '+t;
 adoconn1.ConnectionString:=s;
 adoconn1.Connected:=true;
 listbox1.Clear;
 adoconn1.GetTableNames(listbox1.items);
 datasource1.DataSet:=ADOTableAccess

end;

procedure TForm5.ListBox1Click(Sender: TObject);
var i : integer; s : shortstring;
    adotable : TadoTable;
begin
    if tablemode=0 then adotable:=adotableaccess else adotable:=adotableexcel;
    i:=listbox1.ItemIndex; if i=-1 then exit;
    s:=listbox1.Items[i];
    try
    adotable.Active:=false; adotable.TableName:=s;
    form3.DBMemodata.DataSource:=nil; form3.DBNavigator1.DataSource:=datasource1;
    adotable.Filtered:=false;
    screen.Cursor:=crHourGlass;
    Adotable.Active:=true;
    screen.Cursor:=crDefault;
    FixDBGridColumnsWidth(dbgrid1);
    label2.Caption:='Total Records ='+inttostr(adotable.RecordCount);
    except

    end;
end;

procedure TForm5.ShowtableDef;
(*
TFieldType = (ftUnknown, ftString, ftSmallint, ftInteger, ftWord,
    ftBoolean, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,
    ftBytes, ftVarBytes, ftAutoInc, ftBlob, ftMemo, ftGraphic, ftFmtMemo,
    ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor, ftFixedChar, ftWideString,
    ftLargeint, ftADT, ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob,
    ftVariant, ftInterface, ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd);
*)
var s: string; i,j,k,c,m : integer; t,p : string[30];
begin
 s:='';
 c:=dbgrid1.DataSource.DataSet.FieldCount;
 //c:=table.FieldCount;
 with Form2.StringGrid1 do
 begin
       rowcount:=c+1; if c=0 then c:=1;
       cells[0,0]:='Field name';
       cells[1,0]:='(Data type)'; cells[2,0]:='Size';
       m:=dbgrid1.DataSource.DataSet.FieldCount-1;
 for i:=0 to m do
 begin j:=ord(dbgrid1.DataSource.DataSet.FieldDefs.Items[i].datatype);
       k:=dbgrid1.DataSource.DataSet.FieldDefs.Items[i].size;
       t:=dbgrid1.DataSource.DataSet.Fields[i].fieldname;
       case  j of
        ord(ftstring) : p:='String';
        ord(ftinteger): p:='Integer';
        ord(ftdate)   : p:='Date';
        ord(ftfloat)  : p:='Float';
        ORD(ftbcd)    : p:='BCD';
        ord(ftsmallint):p:='Small Integer';
        ord(ftword)    :p:='Word';
        ord(ftbytes)   :p:='Byte(s)';
        ord(ftBlob)    :p:='BLOB';
        ord(ftMemo)    :p:='Memo';
        ord(ftGraphic) :p:='Bitmap';
        ord(ftDateTime):p:='DateTime';
        ord(ftTime)    :p:='Time' ;
        ord(ftFixedChar	):  p:='Fixed char' ;
        ord(ftWideString): p:='Wide string' ;
        ord(ftAutoInc) : p:='Auto inc' ;
        ord(ftBoolean): p:='Boolean'
        else p:='unknow data type '+inttostr(ord(j))
      end;
       p:=p+'('+inttostr(j)+')';
      cells[0,i+1]:=t; cells[1,i+1]:=p; cells[2,i+1]:=inttostr(k)
 end;
 end;

end;

procedure TForm5.DBGrid2TitleClick(Column: TColumn);
var s : string[10]; j,i : integer; t: shortstring; label next;
begin
 i:=Column.index;
 j:=ord(dbgrid2.DataSource.DataSet.FieldDefs.Items[i].datatype);
 t:=dbgrid2.DataSource.DataSet.Fields[i].fieldname;
 if j =ord(ftmemo) then goto Next;
 if checkbox1.Checked then s:='' else s:=' DESC';
 if adoquery1.Active then adoquery1.Sort:=column.Title.Caption+s;
 Exit;
 Next:
 if checkbox2.Checked then
 begin
 if j=ord(ftMemo)
     then with form3 do
     begin dbmemodata.DataSource:=datasource2;
           dbmemodata.DataField:=t;
           show
     end
 end;
end;

procedure TForm5.DBGrid1TitleClick(Column: TColumn);
var s : string[10]; j,i : integer; t: shortstring; label next, next1;
var  adotable : Tadotable;
begin
 i:=Column.index;
 j:=ord(dbgrid1.DataSource.DataSet.FieldDefs.Items[i].datatype);
 t:=dbgrid1.DataSource.DataSet.Fields[i].fieldname;
 if j =ord(ftmemo) then goto Next;
 if j=ord(ftBlob) then goto Next1;
 if checkbox1.Checked then s:='' else s:=' DESC';
 if tablemode=0 then adotable:=adotableaccess else adotable:=adotableexcel;
 if adotable.Active then
 adotable.Sort:=column.Title.Caption+s;
 exit;
 Next:
 if checkbox2.Checked then
 begin
   with form3 do
   begin dbmemodata.DataSource:=datasource1;  DBNavigator1.DataSource:=datasource1;
       dbmemodata.DataField:=t; i:=length(dbmemodata.Lines.Text);
       label1.Caption:='Memo Size= '+inttostr(i)+' Bytes';
       show; exit
   end
 end;
 Next1:
 if checkbox2.Checked then
 with FormBlob do
 begin blobfieldname:=t;
      i:=TBlobField(datasource1.DataSet.fieldbyname(t)).BlobSize;
      label1.Caption:='Blob Size='+inttostr(i)+' Bytes';
    show
 end;
end;

procedure TForm5.ExcelFile1Click(Sender: TObject);
var XL : TDataSetToExcel;
begin
  if savedialog1.Execute=false then exit;
  adotableaccess.DISABLECONTROLS;
  XL := TDataSetToExcel.Create(adotableaccess,savedialog1.FileName);
  XL.WriteFile(0);
  adotableaccess.ENABLECONTROLS;
  XL.Free;
end;

procedure TForm5.ExcelFileQuerycontent1Click(Sender: TObject);
var XL : TDataSetToExcel;
begin
  if savedialog1.Execute=false then exit;
  adoquery1.DISABLECONTROLS;
  XL := TDataSetToExcel.Create(adoquery1,savedialog1.FileName);
  XL.WriteFile(0);
  adoquery1.ENABLECONTROLS;
  XL.Free;
end;


procedure TForm5.TableDefinitions1Click(Sender: TObject);
begin ShowtableDef;
 Form2.Show
end;

procedure TForm5.ExecSQLCode(Sender: TObject);
var s : string;
begin s:=trim(memo1.Lines.Text);
   if s='' then
   begin showmessage('NO SQL statements exists');
         exit;
   end;
 with adoquery1 do
 begin active:=false;
   if listbox1.Items.Count=0 then
   begin showmessage('No Tables(s) exits');
         exit
   end;
   sql.Text:=s;
   form3.DBMemodata.DataSource:=nil;
   form3.DBNavigator1.DataSource:=datasource2; filtered:=false;
   screen.Cursor:=crHourGlass;
   active:=true;
   screen.Cursor:=crDefault;
   label4.Caption:='Total rec ='+inttostr(adoquery1.RecordCount);
   FixDBGridColumnsWidth(dbgrid2);
 end
end;

procedure TForm5.FilterTableDataClick(Sender: TObject);
var s : string;
begin adotableaccess.Filtered:=true; s:=trim(Edit1.Text);
 adotableaccess.Filtered:=s<>'';
 adotableaccess.Filter:=s; refresh;
 label2.Caption:='Total Records= '+inttostr(adotableaccess.RecordCount);
end;

procedure TForm5.Exit1Click(Sender: TObject);
begin
 close
end;

procedure TForm5.FilterSQLDataClick(Sender: TObject);
var s : string;
begin
 with ADOquery1 do
 begin filtered:=false;
 s:=trim(Edit1.Text);
 Filter:=s;
 Filtered:=s<>'';
 refresh;
 label4.Caption:='Total Records= '+inttostr(RecordCount);
 end;
end;

procedure TForm5.FormShow(Sender: TObject);
const c ='Provider=MSDASQL.1;Persist Security Info=False;Extended Properties='+
         '"DSN=MS Access Database;DBQ=xxxx;'+
         'DefaultDir=yyyy;DriverId=25;FIL=MS Access;'+
         'MaxBufferSize=2048;PageTimeout=5;UID=admin;"';
var s,t,p : string;
begin
 t:=uppercase(trim(paramstr(1)));
 if pos('.MDB',t)>0 then
 begin

 if (pos(':',t)=0)and(pos('\\',t)=0) then
 begin p:=extractfiledir(paramstr(0)); if p[length(p)]<>'\' then p:=p+'\';
       t:=p+t;
 end;
 caption:=caption+' '+t;
 adoconn1.Connected:=false;
 s:=c; tablemode:=0;
 s:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=';
 s:=s+t+';Persist Security Info=True';
 //i:=pos('xxxx',s); delete(s,i,4); insert(t,s,i);

 listbox1.Clear;

 adoconn1.ConnectionString:=s;
 adoconn1.Connected:=true;
 adoconn1.GetTableNames(listbox1.items);
 datasource1.DataSet:=ADOTableAccess

 end
end;

procedure TForm5.MDAVVersion1Click(Sender: TObject);
var  ADO: OLEVariant;
begin  ADO := CreateOLEObject('adodb.connection');
       showmessage('MDAC Version is '+ado.version)
end;

function CreateAccessDatabase(FileName: string): string;
var
  cat: OLEVariant;
begin
  Result := '';
  try
    cat := CreateOleObject('ADOX.Catalog');
    cat.Create('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + FileName + ';');
    cat := NULL;
  except
    on e: Exception do Result := e.message;
  end;
end;

procedure TForm5.CreateanAccessDatabaseFileMDB1Click(Sender: TObject);
var s,t : string;
begin if opendialogaccess.Execute=false then exit;
 s:=trim(opendialogaccess.FileName); t:=s;
 if s<>'' then
 begin if fileexists(s) then deletefile(s);
       CreateAccessDatabase(s);
       s:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+t+
       ';Persist Security Info=False';
       Adoconn1.ConnectionString:=s
 end
end;

function CompactAndRepair(DB: string; var gain : integer): Boolean; {DB = Path to Access Database}
var v: OLEvariant; f : file of byte; i,j : integer;
begin
  assignfile(f,db); reset(f); i:=filesize(f); closefile(f);
  Result := True;
  try
    v := CreateOLEObject('JRO.JetEngine');
    try
      V.CompactDatabase('Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+DB,
                        'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+DB+'x;Jet OLEDB:Engine Type=5');
      DeleteFile(DB);
      RenameFile(DB+'x',DB);
      assignfile(f,db); reset(f); j:=filesize(f); gain:=i-j; closefile(f);
    finally
      V := Unassigned;
    end;
  except
    Result := False;
  end;
end;


procedure TForm5.CompactRepairAccessFile1Click(Sender: TObject);
var  gain : integer;
begin if opendialogaccess.Execute=false then exit;
     if CompactAndRepair(opendialogaccess.FileName,gain) then
     showmessage('Successfull operation'+#13#10+inttostr(gain)+' Bytes reduced')
     else showmessage('Operation Failed')
end;

procedure TForm5.DDLAddRemIdxAccesstable1Click(Sender: TObject);
var s : string;
begin s:=trim(memo1.Lines.Text);
   if s='' then
   begin showmessage('NO SQL statements exists');
         exit;
   end;
 if adoconn1.Connected=false then
 begin showmessage('No database connection');
       exit
 end;
 AdoCommand.CommandText:=s;
 AdoCommand.Execute; ADOCONN1.Connected:=false;
 adoconn1.Connected:=true;
 adoconn1.GetTableNames(listbox1.items);
 datasource1.DataSet:=ADOTableAccess
end;

procedure TForm5.CloseDatabase1Click(Sender: TObject);
begin
 adoconn1.Connected:=false; listbox1.Items.Clear;
 adoconn2.Connected:=false; adoconnexcel.Connected:=false;
end;

procedure TForm5.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if (DbGrid1.DataSource.DataSet.RecNo mod 2) = 0 then
    dbgrid1.Canvas.Brush.Color := clskyblue; //or any color
    dbgrid1.DefaultDrawColumnCell(rect, datacol, column, state);
end;

procedure TForm5.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if (DbGrid2.DataSource.DataSet.RecNo mod 2) = 0 then
    dbgrid2.Canvas.Brush.Color := clskyblue; //or any color
    dbgrid2.DefaultDrawColumnCell(rect, datacol, column, state);
end;

procedure TForm5.Samples1Click(Sender: TObject);
begin
 frmDDLsamples.Show
end;

procedure TForm5.SelFont1Click(Sender: TObject);
begin
 if fontdialog1.Execute =false then exit;
 memo1.Font:=fontdialog1.Font
end;

procedure TForm5.Memo1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if screen.Cursor=crHourGlass then
 screen.Cursor:=crDefault
end;

procedure TForm5.ConnectAccessTable21Click(Sender: TObject);
var s,t : string;
begin adoconn2.Connected:=false;
 if opendialogaccess.Execute=false then exit;  tablemode:=0;
 t:=opendialogaccess.FileName;

 s:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=';
 s:=s+t+';Persist Security Info=True';
 adoconn2.ConnectionString:=s;
 adoconn2.Connected:=true;
end;
end.
(* Examples of Command text for ADOCommand component
create table
ADOCommand.CommandText :=
  'CREATE TABLE NameList ' +
  ' ( ' +
  ' IDKey     TEXT(10)  PRIMARY KEY, ' +
  ' NameLast  TEXT(24)  NOT NULL, ' +
  ' NameFirst TEXT(20)  NOT NULL, ' +
  ' NameMiddleInitial TEXT(1), ' +
  ' Notes     MEMO, ' +
  ' Picture   LongBinary, ' +
  ' BirthDate DATE ' +
  ' )';

  drop Table
ADOCommand.CommandText :=
  'DROP TABLE NameList';

  Create Index
  ADOCommand.CommandText :=
  'CREATE UNIQUE INDEX NameIndex ON NameList ' +
  '( ' +
  ' NameLast ASC, ' +
  ' NameFirst ASC ' +
  ')';

  Drop Index
  ADOCommand.CommandText :=
  'DROP INDEX NameIndex ON NameList';

from http://coding.derkeiler.com/Archive/Delphi/borland.public.delphi.database.ado/2004-01/0270.html

      ADOCommand.CommandText :=
        'CREATE TABLE ROAMINGDATA ' +
        ' ( ' +
        ' UID CHAR(20) PRIMARY KEY, ' +
        ' ACCOUNT_NUMBER INTEGER NOT NULL, ' +
        ' MEMBER_NUMBER INTEGER NOT NULL, ' +
        ' FIRST_LAST CHAR(100), ' +
        ' FIRST_INIT_LAST_NAME CHAR(50), ' +
        ' HOME_PHONE CHAR(12), ' +
        ' HOME_PHONE_STRIPPED CHAR(7), ' +
        ' WORK_PHONE CHAR(12), ' +
        ' WORK_PHONE_STRIPPED CHAR(7), ' +
        ' MEMBERSHIP_TYPE CHAR(50), ' +
        ' ADDRESS_1 CHAR(100), ' +
        ' HOME_CLUB CHAR(3), ' +
        ' ALLOW_ENTRY BIT, ' + // Boolean
        ' ACCESS_MESSAGE MEMO, ' +
        ' ACCESS_COLOR INTEGER, ' +
        ' ACCESS_FONT_COLOR INTEGER, ' +
        ' BARCODE CHAR(12) ' +
        ' )';
      ADOCommand.Execute;

CREATE TABLE NameList
 (
 IDKey   COUNTER,
 NameLast  TEXT(24)  NOT NULL,
 NameFirst TEXT(20)  NOT NULL,
 NameMiddleInitial TEXT(1),
 Notes     MEMO,
 Picture   LongBinary,
 BirthDate DATE
   );
ADOCommand.Execute;

CREATE TABLE OMID
 (
 ID COUNTER,
 AGE DATE,
 BIRTHDATE DATETIME,
 WAGE DECIMAL(19,4),
 SALARY FLOAT,
 SALARIED YESNO
)
ADOCommand.Execute;

      // Create indices
      ADOCommand.CommandText := 'CREATE INDEX IDX_ACCOUNT_NUMBER ON
ROAMINGDATA (ACCOUNT_NUMBER)';
      ADOCommand.Execute;

      ADOCommand.CommandText := 'CREATE INDEX IDX_MEMBER_NUMBER ON
ROAMINGDATA (MEMBER_NUMBER)';
      ADOCommand.Execute;

      ADOCommand.CommandText := 'CREATE INDEX IDX_FIRST_INIT_LAST_NAME ON
ROAMINGDATA (FIRST_INIT_LAST_NAME)';
      ADOCommand.Execute;

      ADOCommand.CommandText := 'CREATE INDEX IDX_HOME_PHONE_STRIPPED ON
ROAMINGDATA (HOME_PHONE_STRIPPED)';
      ADOCommand.Execute;

      ADOCommand.CommandText := 'CREATE INDEX IDX_WORK_PHONE_STRIPPED ON
ROAMINGDATA (WORK_PHONE_STRIPPED)';
      ADOCommand.Execute;

      ADOCommand.CommandText := 'CREATE INDEX IDX_BARCODE ON ROAMINGDATA
(BARCODE)';

ALTER TABLE employee DROP LAST_NAME, DROP FIRST_NAME, ADD FULL_NAME TEXT(30)
*)
