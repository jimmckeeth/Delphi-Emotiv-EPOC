program EdkParrot;

uses
  FMX.Forms,
  uEdkParrot in 'uEdkParrot.pas' {Form4},
  Emotiv.EDK.Core in '..\..\..\Source\Emotiv.EDK.Core.pas',
  Emotiv.EDK.EmoState in '..\..\..\Source\Emotiv.EDK.EmoState.pas',
  Emotiv.EDK.ErrorCodes in '..\..\..\Source\Emotiv.EDK.ErrorCodes.pas',
  Emotiv.Epoc in '..\..\..\Source\Emotiv.Epoc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
