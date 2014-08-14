unit uExpEngineTest;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Objects,
  Emotiv.EDK.Core, Emotiv.EDK.EmoState, Emotiv.EDK.ErrorCodes;


type
  TForm3 = class(TForm)
    ListBox1: TListBox;
    upperLog: TListBox;
    lowerLog: TListBox;
    eyeLog: TListBox;
    Timer1: TTimer;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    eEvent: Pointer;
    eState: Pointer;
    eProfile: Pointer;
    userID: word;
    procedure GetEvent;
    procedure Log(msg: String);
    procedure GetExpressive(EmoState: pointer);
  public
    { Public declarations }

  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.FormCreate(Sender: TObject);
begin
  userID := 0;
  //RaiseEdkError(EE_EngineRemoteConnect(PAnsiChar(AnsiString('127.0.0.1')),1726,PAnsiChar(AnsiString('Emotiv Systems-5'))));
  RaiseEdkError(EE_EngineConnect(PAnsiChar(AnsiString('Emotiv Systems-5'))));

  eEvent := EE_EmoEngineEventCreate();
  eState := EE_EmoStateCreate();
  //EE_GetBaseProfile(eProfile);
  GetEvent;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  RaiseEdkError(EE_EngineDisconnect);
end;

procedure TForm3.Log(msg: String);
begin
  ListBox1.Items.Add(msg);
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin

  GetEvent;
end;

procedure TForm3.GetEvent;
var
  state: Integer;
  eventType: EE_Event_t;
begin
  state := EE_EngineGetNextEvent(eEvent);
  if state = EDK_OK then
  begin
    eventType := EE_EmoEngineEventGetType(eEvent);
    RaiseEdkError(EE_EmoEngineEventGetUserId(eEvent, @userId));
    case eventType of
      EE_UnknownEvent: Log('UnknownEvent');
      EE_EmulatorError: Log('EmulatorError');
      EE_ReservedEvent: Log('ReservedEvent');
      EE_UserAdded: Log('UserAdded');
      EE_UserRemoved: Log('UserRemoved');
      EE_ProfileEvent: Log('ProfileEvent');
      EE_CognitivEvent: Log('CognitivEvent');
      EE_ExpressivEvent: Log('ExpressivEvent');
      EE_InternalStateChanged: Log('InternalStateChanged');
      EE_AllEvent: Log('AllEvent');
      EE_EmoStateUpdated:
      begin
        RaiseEdkError(EE_EmoEngineEventGetEmoState(eEvent, eState));
        GetExpressive(eState);
      end;
    end;
  end
  else if state <> EDK_NO_EVENT then
    RaiseEdkError(state);
end;

function ExpressiveString(expressive: TExpressivAlgo): string;
begin
  case expressive of
    EXP_NEUTRAL: Result := 'Neutral';
    EXP_BLINK: Result := 'Blink';
    EXP_WINK_LEFT: Result := 'Wink Left';
    EXP_WINK_RIGHT: Result := 'Wink Right';
    EXP_HORIEYE: Result := 'Horizontal Eyes';
    EXP_EYEBROW: Result := 'Eye Brows';
    EXP_FURROW: Result := 'Furrow';
    EXP_SMILE: Result := 'Smile';
    EXP_CLENCH: Result := 'Clench';
    EXP_LAUGH: Result := 'Laugh';
    EXP_SMIRK_LEFT: Result := 'Left Smirk';
    EXP_SMIRK_RIGHT: Result := 'Right Smirk';
  else
    Result := IntToStr(Integer(expressive));
  end;
end;

procedure TForm3.GetExpressive(EmoState: pointer);
var
  faceType: TExpressivAlgo;
  facePower: Single;
  s: string;
begin
  faceType := ES_ExpressivGetUpperFaceAction(EmoState);
  facePower := ES_ExpressivGetUpperFaceActionPower(EmoState);
  s := ExpressiveString(faceType);
  if (s = '0') or (facePower = 0) then
    s := '';
  if (upperLog.Items[0] <> s) then
    upperLog.Items.Insert(0, s);

  faceType := ES_ExpressivGetLowerFaceAction(EmoState);
  facePower := ES_ExpressivGetLowerFaceActionPower(EmoState);
  s := ExpressiveString(faceType);
  if (s = '0') or (facePower = 0) then
    s := '';
  if (lowerLog.Items[0] <> s) then
    lowerLog.Items.Insert(0, s);

  s := '';
  if ES_ExpressivIsBlink(EmoState) = 1 then s := 'Blink' else
  if ES_ExpressivIsLeftWink(EmoState) = 1 then s := 'Left Wink' else
  if ES_ExpressivIsRightWink(EmoState) = 1 then s := 'Right Wink' else
  if ES_ExpressivIsEyesOpen(EmoState) = 1 then s := 'Open' else
  if ES_ExpressivIsLookingUp(EmoState) = 1 then s := 'Look Up' else
  if ES_ExpressivIsLookingLeft(EmoState) = 1 then s := 'Look Left' else
  if ES_ExpressivIsLookingRight(EmoState) = 1 then s := 'Look Right' else
  if ES_ExpressivIsLookingDown(EmoState) = 1 then s := 'Look Down';
  if (eyeLog.Items[0] <> s) then
    eyeLog.Items.Insert(0, s);
end;

end.
