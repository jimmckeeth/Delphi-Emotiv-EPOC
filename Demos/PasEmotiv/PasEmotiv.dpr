program PasEmotiv;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainForm in 'MainForm.pas' {Form16};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm16, Form16);
  Application.Run;
end.
