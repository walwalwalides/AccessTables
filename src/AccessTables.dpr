program AccessTables;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  UnitMain in 'UnitMain.pas' {Form5},
  UnitBlob in 'UnitBlob.pas' {FormBlob},
  UnitDDLsamples in 'UnitDDLsamples.pas' {frmDDLsamples};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TFormBlob, FormBlob);
  Application.CreateForm(TfrmDDLsamples, frmDDLsamples);
  Application.Run;
end.
