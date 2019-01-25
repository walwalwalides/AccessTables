unit UnitBlob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, DB, Buttons;

type
  TFormBlob = class(TForm)
    Label1: TLabel;
    btnsaveBlob: TButton;
    Button2: TButton;
    btnEraseBlobData: TButton;
    DBNavigator1: TDBNavigator;
    btnlddatafromFile: TButton;
    BitBtn1: TBitBtn;
    procedure btnlddatafromFileClick(Sender: TObject);
    procedure btnsaveBlobClick(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure btnEraseBlobDataClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBlob: TFormBlob;

implementation

uses Unit2, Unit3, UnitMain;

{$R *.dfm}

procedure TFormBlob.btnlddatafromFileClick(Sender: TObject);
var i : integer;
begin
with form3 do
 begin if Opendialog.Execute=false then exit;
    TBlobField(form5.datasource1.DataSet.fieldbyname(BlobFieldName)).LoadFromFile(opendialog.FileName);
    form5.datasource1.DataSet.Post;
    i:=TBlobField(form5.datasource1.DataSet.fieldbyname(BlobFieldName)).BlobSize;
    label1.Caption:='Blob Size='+inttostr(i)+' Bytes';
 end
end;

procedure TFormBlob.btnsaveBlobClick(Sender: TObject);
var i : integer;
begin
with form3 do
 begin if Savedialog.Execute=false then exit;
    TBlobField(form5.datasource1.DataSet.fieldbyname(BlobFieldName)).SaveToFile(savedialog.FileName);
    i:=TBlobField(form5.datasource1.DataSet.fieldbyname(BlobFieldName)).BlobSize;
    label1.Caption:='Blob Size='+inttostr(i)+' Bytes';
 end
end;

procedure TFormBlob.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
var i : integer;
begin
 if button in[nbfirst,nbprior,nbnext,nblast] then
 begin
    i:=TBlobField(form5.datasource1.DataSet.fieldbyname(BlobFieldName)).BlobSize;
    label1.Caption:='Blob Size='+inttostr(i)+' Bytes'
 end    
end;

procedure TFormBlob.btnEraseBlobDataClick(Sender: TObject);
begin
  with form5.datasource1.DataSet do
  begin Edit;
   TBlobField(fieldbyname(BlobFieldName)).Clear;
   post
  end
end;

end.
