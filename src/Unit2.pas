unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Menus;

type
  TForm2 = class(TForm)
    StringGrid1: TStringGrid;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    SaveasText1: TMenuItem;
    Exit1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure SaveasText1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation


{$R *.dfm}

procedure TForm2.SaveasText1Click(Sender: TObject);
var i,j : integer; f : textfile; s: string;
begin
 if savedialog1.Execute=false then exit;
 assignfile(f,savedialog1.FileName); rewrite(f);
 with stringgrid1 do for i:=0 to rowcount-1 do
 begin s:='';
  for j:=0 to colcount-1 do s:=s+cells[j,i]+#9;
  setlength(s,length(s)-1);
  writeln(f,s)
 end;
 closefile(f)
end;

procedure TForm2.Exit1Click(Sender: TObject);
begin
 close
end;

end.
