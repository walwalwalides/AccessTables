unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ADODB, DB, Grids, DBGrids, ExtCtrls, DBCtrls, clipbrd,
  Menus,comobj;

type
  TForm1 = class(TForm)
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOConn: TADOConnection;
    ADOTableAccess: TADOTable;
    ADOQuery1: TADOQuery;
    ListBox1: TListBox;
    Label1: TLabel;
    OpenDialogAccess: TOpenDialog;
    Label2: TLabel;
    Memo1: TMemo;
    DBNavigator2: TDBNavigator;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    CheckBox2: TCheckBox;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    Save1: TMenuItem;
    ExcelFile1: TMenuItem;
    SaveDialog1: TSaveDialog;
    ExcelFileQuerycontent1: TMenuItem;
    File1: TMenuItem;
    OpenAccessFile: TMenuItem;
    Show1: TMenuItem;
    ableDefinitions1: TMenuItem;
    Exce1: TMenuItem;
    SQLcode1: TMenuItem;
    Filtermenu: TMenuItem;
    ableData1: TMenuItem;
    SQLData1: TMenuItem;
    Exit1: TMenuItem;
    Label5: TLabel;
    Edit1: TEdit;
    Columns1: TMenuItem;
    ableTOP1: TMenuItem;
    QueryBottom1: TMenuItem;
    OpenExcelSheets1: TMenuItem;
    ADOTableExcel: TADOTable;
    OpenDialogExcel: TOpenDialog;
    MDAVVersion1: TMenuItem;
    procedure ListBox1Click(Sender: TObject);
    procedure ShowtableDef;
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ExcelFile1Click(Sender: TObject);
    procedure ExcelFileQuerycontent1Click(Sender: TObject);
    procedure OpenAccessFileClick(Sender: TObject);
    procedure ableDefinitions1Click(Sender: TObject);
    procedure SQLcode1Click(Sender: TObject);
    procedure ableData1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SQLData1Click(Sender: TObject);
    procedure ableTOP1Click(Sender: TObject);
    procedure QueryBottom1Click(Sender: TObject);
    procedure OpenExcelSheets1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MDAVVersion1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
// ATTENTION
// ADOTABLE FOR EXCEL FILES MUST SET TABLEDIRECT=TRUE
uses Unit2, Unit3, UnitExcel, FormColumns;

{$R *.dfm}
const tablemode : integer=-1; //0=accesstable  1=Excel sheet
procedure FixDBGridColumnsWidth(const DBGrid: TDBGrid);
var
  i : integer;
  TotWidth : integer;
  VarWidth : integer;
  ResizableColumnCount : integer;
  AColumn : TColumn;
begin
  //total width of all columns before resize
  TotWidth := 0;
  //how to divide any extra space in the grid
  VarWidth := 0;
  //how many columns need to be auto-resized
  ResizableColumnCount := 0;

  for i := 0 to -1 + DBGrid.Columns.Count do
  begin
    TotWidth := TotWidth + DBGrid.Columns[i].Width;
    if DBGrid.Columns[i].Field.Tag <> 0 then
      Inc(ResizableColumnCount);
  end;

  //add 1px for the column separator line
  if dgColLines in DBGrid.Options then
    TotWidth := TotWidth + DBGrid.Columns.Count;

  //add indicator column width
  if dgIndicator in DBGrid.Options then
    TotWidth := TotWidth + IndicatorWidth;

  //width vale "left"
  VarWidth :=  DBGrid.ClientWidth - TotWidth;

  //Equally distribute VarWidth
  //to all auto-resizable columns
  if ResizableColumnCount > 0 then
    VarWidth := varWidth div ResizableColumnCount;

  for i := 0 to -1 + DBGrid.Columns.Count do
  begin
    AColumn := DBGrid.Columns[i];
    if AColumn.Field.Tag <> 0 then
    begin
      AColumn.Width := AColumn.Width + VarWidth;
      if AColumn.Width < AColumn.Field.Tag then
        AColumn.Width := AColumn.Field.Tag;
    end;
  end;
end; (*FixDBGridColumnsWidth*)

procedure TForm1.OpenExcelSheets1Click(Sender: TObject);
var s : string;
begin
 if opendialogexcel.Execute=false then exit;
 adoconn.Connected:=false;
 s:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+opendialogexcel.FileName+
    ';Extended Properties=Excel 8.0;Persist Security Info=False';
 adoconn.ConnectionString:=s;
 adoconn.Connected:=true; Tablemode:=1;
 adoconn.GetTableNames(listbox1.items);
 datasource1.DataSet:=ADOTableExcel;

end;

procedure TForm1.OpenAccessFileClick(Sender: TObject);
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

var s,t : string; i,j : integer;
begin adoconn.Connected:=false;
 if opendialogaccess.Execute=false then exit; s:=c; tablemode:=0;
 t:=opendialogaccess.FileName;
 i:=pos('xxxx',s); delete(s,i,4); insert(t,s,i);

 listbox1.Clear;
 {$IFDEF  NOACCESSEXITS}
 {$ELSE}
 adoconn.DefaultDatabase:=t; //an extra step if MSAccess is installed on pc
 i:=pos('yyyy',s); delete(s,i,4); insert(t,s,i);
 {$ENDIF}
// clipboard.AsText:=s;
 adoconn.ConnectionString:=s;
 adoconn.Connected:=true;
 adoconn.GetTableNames(listbox1.items);
 datasource1.DataSet:=ADOTableAccess
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var i,j : integer; s : shortstring;
    adotable : TadoTable;
begin
    if tablemode=0 then adotable:=adotableaccess else adotable:=adotableexcel;
    i:=listbox1.ItemIndex; if i=-1 then exit;
    s:=listbox1.Items[i];
    try
    adotable.Active:=false; adotable.TableName:=s;
    adotable.Filtered:=false; Adotable.Active:=true;
    FixDBGridColumnsWidth(dbgrid1);
    label2.Caption:='Total Records ='+inttostr(adotable.RecordCount);
    ShowtableDef;
    except

    end;
end;

procedure TForm1.ShowtableDef;
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
       cells[1,0]:='Data type'; cells[2,0]:='Size';
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

procedure TForm1.DBGrid2TitleClick(Column: TColumn);
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
     begin dbmemo1.DataSource:=datasource2;
           dbmemo1.DataField:=t;
           show
     end
 end;
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
var s : string[10]; j,i : integer; t: shortstring; label next;
var  adotable : Tadotable;
begin
 i:=Column.index;
 j:=ord(dbgrid1.DataSource.DataSet.FieldDefs.Items[i].datatype);
 t:=dbgrid1.DataSource.DataSet.Fields[i].fieldname;
 if j =ord(ftmemo) then goto Next;
 if checkbox1.Checked then s:='' else s:=' DESC';
 if tablemode=0 then adotable:=adotableaccess else adotable:=adotableexcel;
 if adotable.Active then
 adotable.Sort:=column.Title.Caption+s;
 exit;
 Next:
 if checkbox2.Checked then
 begin
 if j=ord(ftMemo)
     then with form3 do
     begin dbmemo1.DataSource:=datasource1;
           dbmemo1.DataField:=t;
           show
     end
 end;
end;

procedure TForm1.ExcelFile1Click(Sender: TObject);
var XL : TDataSetToExcel;
begin
  if savedialog1.Execute=false then exit;
  adotableaccess.DISABLECONTROLS;
  XL := TDataSetToExcel.Create(adotableaccess,savedialog1.FileName);
  XL.WriteFile(0);
  adotableaccess.ENABLECONTROLS;
  XL.Free;
end;

procedure TForm1.ExcelFileQuerycontent1Click(Sender: TObject);
var XL : TDataSetToExcel;
begin
  if savedialog1.Execute=false then exit;
  adoquery1.DISABLECONTROLS;
  XL := TDataSetToExcel.Create(adoquery1,savedialog1.FileName);
  XL.WriteFile(0);
  adoquery1.ENABLECONTROLS;
  XL.Free;
end;


procedure TForm1.ableDefinitions1Click(Sender: TObject);
begin
 Form2.Show
end;

procedure TForm1.SQLcode1Click(Sender: TObject);
begin
 with adoquery1 do
 begin active:=false;
   sql.Text:=memo1.Lines.Text;
   active:=true; label4.Caption:='Total rec ='+inttostr(adoquery1.RecordCount)
 end;

end;

procedure TForm1.ableData1Click(Sender: TObject);
var s : string;
begin adotableaccess.Filtered:=true; s:=trim(Edit1.Text);
 adotableaccess.Filtered:=s<>'';
 adotableaccess.Filter:=s; refresh;
 label2.Caption:='Total Records= '+inttostr(adotableaccess.RecordCount);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
 close
end;

procedure TForm1.SQLData1Click(Sender: TObject);
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

procedure TForm1.ableTOP1Click(Sender: TObject);
var i : integer;
begin
 if dbgrid1.DataSource.DataSet.Active=false then exit;
// if adoTableaccess.Active=false then exit;
 form4.Show;
 with form4 do
 begin listbox1.Items.Clear;
    for i:=0 to dbgrid1.Columns.Count-1 do
    listbox1.Items.Add(inttostr(dbgrid1.Columns[i].Width))
 end
end;

procedure TForm1.QueryBottom1Click(Sender: TObject);
var i : integer;
begin
 if adoquery1.Active=false then exit;
 form4.Show;
 with form4 do
 begin listbox2.Items.Clear;
    for i:=0 to dbgrid2.Columns.Count-1 do
    listbox2.Items.Add(inttostr(dbgrid2.Columns[i].Width))
 end
end;

procedure TForm1.FormShow(Sender: TObject);
const c ='Provider=MSDASQL.1;Persist Security Info=False;Extended Properties='+
         '"DSN=MS Access Database;DBQ=xxxx;'+
         'DefaultDir=yyyy;DriverId=25;FIL=MS Access;'+
         'MaxBufferSize=2048;PageTimeout=5;UID=admin;"';
var s,t,p : string; i,j : integer;
begin
 t:=uppercase(trim(paramstr(1)));
 if pos('.MDB',t)>0 then
 begin

 if (pos(':',t)=0)and(pos('\\',t)=0) then
 begin p:=extractfiledir(paramstr(0));
       t:=p+t;
 end;
 caption:=caption+' '+t;
 adoconn.Connected:=false;
 s:=c; tablemode:=0;
 i:=pos('xxxx',s); delete(s,i,4); insert(t,s,i);

 listbox1.Clear;

 adoconn.ConnectionString:=s;
 adoconn.Connected:=true;
 adoconn.GetTableNames(listbox1.items);
 datasource1.DataSet:=ADOTableAccess
 
 end
end;

procedure TForm1.MDAVVersion1Click(Sender: TObject);
var  ADO: OLEVariant; 
begin  ADO := CreateOLEObject('adodb.connection');
       showmessage('MDAC Version is '+ado.version)
end;

end.
