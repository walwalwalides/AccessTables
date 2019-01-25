unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, DBCtrls, ExtCtrls, ComCtrls;

type
  TForm3 = class(TForm)
    MainMenu1: TMainMenu;
    Exit1: TMenuItem;
    DBNavigator1: TDBNavigator;
    Save1: TMenuItem;
    Load1: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Label1: TLabel;
    dbmemodata: TDBMemo;
    procedure Exit1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses UnitMain;


{$R *.dfm}

procedure TForm3.Exit1Click(Sender: TObject);
begin
 close
end;

procedure TForm3.Save1Click(Sender: TObject);
begin
 if savedialog.Execute=false then exit;
 dbmemodata.Lines.SaveToFile(savedialog.filename);
end;

procedure TForm3.Load1Click(Sender: TObject);
begin
 if opendialog.Execute=false then exit;
 dbmemodata.Lines.LoadFromFile(opendialog.filename);
end;

procedure TForm3.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
var i : integer;
begin
 i:=length(dbmemodata.Lines.Text);
 label1.Caption:='Memo Size= '+inttostr(i)+' Bytes';
end;

end.
