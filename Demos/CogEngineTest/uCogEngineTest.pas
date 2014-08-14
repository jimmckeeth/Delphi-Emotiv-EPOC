unit uCogEngineTest;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox,

  Emotiv.EDK.Core, Emotiv.EDK.EmoState, Emotiv.EDK.ErrorCodes;

type
  TForm4 = class(TForm)
    Timer1: TTimer;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    lbCogActions: TListBox;
    cbActions: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure lbCogActionsChangeCheck(Sender: TObject);
  private
    { Private declarations }
    eEvent: Pointer;
    eState: Pointer;
    eProfile: Pointer;
    userID: word;
    procedure GetEvent;
    procedure Log(msg: String);
    procedure HandleCogEvent;
    procedure HandleCogAction();
    procedure PopulateCogActionList;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

const
  CogActions: Array [0..13] of EE_CognitivAction_t =
    (COG_NEUTRAL, COG_PUSH, COG_PULL, COG_LIFT, COG_DROP, COG_LEFT, COG_RIGHT,
      COG_ROTATE_LEFT, COG_ROTATE_RIGHT, COG_ROTATE_CLOCKWISE,
      COG_ROTATE_COUNTER_CLOCKWISE, COG_ROTATE_FORWARDS, COG_ROTATE_REVERSE,
      COG_DISAPPEAR);

function CognitivActionToStr(action: EE_CognitivAction_t): string;
begin
  case action of
    COG_NEUTRAL: exit('Neutral');
    COG_PUSH: exit('Push');
    COG_PULL: exit('Pull');
    COG_LIFT: exit('Lift');
    COG_DROP: exit('Drop');
    COG_LEFT: exit('Left');
    COG_RIGHT: exit('Right');
    COG_ROTATE_LEFT: exit('Rotate Left');
    COG_ROTATE_RIGHT: exit('Rotate Right');
    COG_ROTATE_CLOCKWISE: exit('Rotate Clockwise');
    COG_ROTATE_COUNTER_CLOCKWISE: exit('Rotate Counter Clockwise');
    COG_ROTATE_FORWARDS: exit('Rotate Forwards');
    COG_ROTATE_REVERSE: exit('Rotate Reverse');
    COG_DISAPPEAR: exit('Disappear');
  end;
end;


procedure TForm4.Button2Click(Sender: TObject);
begin
  Log('Train ' + cbActions.Selected.Text);
  RaiseEdkError(EE_CognitivSetTrainingAction(0, CogActions[cbActions.ItemIndex]));
  RaiseEdkError(EE_CognitivSetTrainingControl(0, COG_START));
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  RaiseEdkError(EE_CognitivSetActiveActions(0, Word(COG_PUSH)));
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  userID := 65535;
  //RaiseEdkError(EE_EngineRemoteConnect(PAnsiChar(AnsiString('127.0.0.1')),1726,PAnsiChar(AnsiString('Emotiv Systems-5'))));
  RaiseEdkError(EE_EngineConnect(PAnsiChar(AnsiString('Emotiv Systems-5'))));

  eEvent := EE_EmoEngineEventCreate();
  eState := EE_EmoStateCreate();
  EE_GetBaseProfile(eProfile);

  PopulateCogActionList;
end;

procedure TForm4.PopulateCogActionList;
var
  I: Integer;
begin
  lbCogActions.Clear;
  cbActions.Clear;
  for I := 0 to 13 do
  begin
    cbActions.Items.Add(CognitivActionToStr(CogActions[I]));
    if I > 0 then
      lbCogActions.Items.Add(CognitivActionToStr(CogActions[I]));
  end;
  cbActions.ItemIndex := 0;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
  GetEvent;
end;

procedure TForm4.Log(msg: String);
begin
  ListBox1.Items.Add(msg);
end;

procedure TForm4.HandleCogEvent;
var
  cogEvent: EE_CognitivEvent_t;
begin
  cogEvent := EE_CognitivEventGetType(eEvent);
  case cogEvent of
    EE_CognitivNoEvent: Log('Cog: NoEvent');
    EE_CognitivTrainingStarted: Log('Cog: TrainingStarted');
    EE_CognitivTrainingSucceeded:
    begin
      Log('Cog: TrainingSucceeded');
      RaiseEdkError(EE_CognitivSetTrainingControl(0, COG_ACCEPT));
    end;
    EE_CognitivTrainingFailed: Log('Cog: TrainingFailed');
    EE_CognitivTrainingCompleted: Log('Cog: TrainingCompleted');
    EE_CognitivTrainingDataErased: Log('Cog: TrainingDataErased');
    EE_CognitivTrainingRejected: Log('Cog: TrainingRejected');
    EE_CognitivTrainingReset: Log('Cog: TrainingReset');
    EE_CognitivAutoSamplingNeutralCompleted: Log('Cog: AutoSamplingNeutralCompleted');
    EE_CognitivSignatureUpdated: Log('Cog: SignatureUpdated');
  end;
end;

procedure TForm4.lbCogActionsChangeCheck(Sender: TObject);
var
  count: Integer;
  I: Integer;
begin
  count := 0;
  for I := 0 to lbCogActions.Count - 1 do
  begin
    if lbCogActions.ListItems[I].IsChecked then
      Inc(count);
  end;
  if count > 4 then
    lbCogActions.Selected.IsChecked := False;
end;

procedure TForm4.HandleCogAction();
var
  power: Single;
  cogAction: EE_CognitivAction_t;
begin
  cogAction := ES_CognitivGetCurrentAction(eState);
  power := ES_CognitivGetCurrentActionPower(eState);
  case cogAction of
    //COG_NEUTRAL: Log('Neutral');
    COG_PUSH: Log('Push ' + FloatToStr(power));
    COG_PULL: Log('Pull ' + FloatToStr(power));
    COG_LIFT: Log('Lift ' + FloatToStr(power));
    COG_DROP: Log('Drop ' + FloatToStr(power));
    COG_LEFT: Log('Left ' + FloatToStr(power));
    COG_RIGHT: Log('Right ' + FloatToStr(power));
    COG_ROTATE_LEFT: Log('Rotate_left ' + FloatToStr(power));
    COG_ROTATE_RIGHT: Log('Rotate_right ' + FloatToStr(power));
    COG_ROTATE_CLOCKWISE: Log('Rotate_clockwise ' + FloatToStr(power));
    COG_ROTATE_COUNTER_CLOCKWISE: Log('Rotate_counter_clockwise ' + FloatToStr(power));
    COG_ROTATE_FORWARDS: Log('Rotate_forwards ' + FloatToStr(power));
    COG_ROTATE_REVERSE: Log('Rotate_reverse ' + FloatToStr(power));
    COG_DISAPPEAR: Log('Disappear ' + FloatToStr(power));
  end;
end;

procedure TForm4.GetEvent;
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
      EE_CognitivEvent: HandleCogEvent;
      EE_ExpressivEvent: Log('ExpressivEvent');
      EE_InternalStateChanged: Log('InternalStateChanged');
      EE_AllEvent: Log('AllEvent');
      EE_EmoStateUpdated:
      begin
        RaiseEdkError(EE_EmoEngineEventGetEmoState(eEvent, eState));
        HandleCogAction;
      end;
    end;
  end
  else if state <> EDK_NO_EVENT then
    RaiseEdkError(state);
end;


end.
