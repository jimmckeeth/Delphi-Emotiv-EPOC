program ExpEngineTest;



uses
  FMX.Forms,
  uExpEngineTest in 'uExpEngineTest.pas' {Form3},
  uFaceModel in 'uFaceModel.pas' {Frame1: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
