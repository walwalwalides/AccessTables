unit FormColumns;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm4 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    ListBox2: TListBox;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses unitmain;

{$R *.dfm}

procedure TForm4.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if key in['0'..'9',^C,^V,^H] then else key:=#0
end;

procedure TForm4.ListBox1Click(Sender: TObject);
var i : integer; s : string[10];
begin
 i:=listbox1.ItemIndex; if i=-1 then exit;
 s:=listbox1.Items[i];
 Edit1.Text:=s
end;

procedure TForm4.ListBox2Click(Sender: TObject);
var i : integer; s : string[10];
begin
 i:=listbox2.ItemIndex; if i=-1 then exit;
 s:=listbox2.Items[i];
 Edit2.Text:=s
end;

procedure TForm4.Button1Click(Sender: TObject);
var i,value : integer; s : string[4];
begin
  s:=Edit1.Text; if s='' then exit;
  val(s,value,i); if i>0 then exit;
  i:=listbox1.ItemIndex; if i=-1 then exit;
  listbox1.Items[i]:=s;
  form5.DBGrid1.Columns[i].Width:=value
end;

procedure TForm4.Button2Click(Sender: TObject);
var i,value : integer; s : string[4];
begin
  s:=Edit2.Text; if s='' then exit;
  val(s,value,i); if i>0 then exit;
  i:=listbox2.ItemIndex; if i=-1 then exit;
  listbox2.Items[i]:=s;
  form5.DBGrid2.Columns[i].Width:=value
end;

end.
