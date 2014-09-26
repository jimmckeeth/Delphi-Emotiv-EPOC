program PowerViewer;

uses
  System.StartUpCopy,
  FMX.Forms,
  PowerDisplay in 'PowerDisplay.pas' {Form17}
  {$IFDEF ANDROID}, Androidapi.JNI.PowerManager in 'Androidapi.JNI.PowerManager.pas'  {$ENDIF}
;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm17, Form17);
  Application.Run;
end.
