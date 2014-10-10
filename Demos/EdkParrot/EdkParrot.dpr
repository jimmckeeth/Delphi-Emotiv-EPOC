program EdkParrot;

uses
  FMX.Forms,
  uEdkParrot in 'uEdkParrot.pas' {Form4},
  uStatusFrame in 'uStatusFrame.pas' {Status: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
