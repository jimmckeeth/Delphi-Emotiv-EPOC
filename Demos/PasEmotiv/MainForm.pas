unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  Emotiv.Epoc, Emotiv.EDK.Core, Emotiv.EDK.EmoState, Emotiv.EDK.ErrorCodes,
  FMX.StdCtrls;

type
  TForm16 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    epoc: TEmotivEpoc;
  public
    { Public declarations }

    procedure CogTrainStart(Sender: TObject);
  end;

var
  Form16: TForm16;

implementation

{$R *.fmx}

procedure TForm16.Button1Click(Sender: TObject);
begin
  epoc.Listen(Word(EE_CognitivAction_t.COG_NEUTRAL) or word(EE_CognitivAction_t.COG_PUSH));
  epoc.Train(EE_CognitivAction_t.COG_NEUTRAL);
end;

procedure TForm16.CogTrainStart(Sender: TObject);
begin
  ShowMessage('Cog Train Start');
end;

procedure TForm16.FormCreate(Sender: TObject);
begin
  Epoc := TEmotivEpoc.Create(self);
  epoc.OnCognitivTrainingStarted := CogTrainStart;

end;

end.
