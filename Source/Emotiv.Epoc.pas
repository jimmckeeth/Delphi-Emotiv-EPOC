unit Emotiv.Epoc;

interface

uses
  System.SysUtils, System.Classes, Emotiv.EDK.Core, Emotiv.EDK.EmoState, Emotiv.EDK.ErrorCodes;

type
  TTrainingSucceededEvent = procedure(Sender: TObject; var AReject: Boolean) of object;

  TEmotivEpoc = class(TComponent)
  private
    { Private declarations }
    eEvent: Pointer;
    eState: Pointer;
    eProfile: Pointer;
    userID: Word;

    fTimer: TThread;
    fCognitivTrainingStarted: TNotifyEvent;
    fCognitivTrainingRejected: TNotifyEvent;
    fCognitivAutoSamplingNeutralCompleted: TNotifyEvent;
    fCognitivTrainingCompleted: TNotifyEvent;
    fCognitivTrainingFailed: TNotifyEvent;
    fCognitivTrainingDataErased: TNotifyEvent;
    fCognitivSignatureUpdated: TNotifyEvent;
    fCognitivTrainingSucceeded: TTrainingSucceededEvent;
    fUserAdded: TNotifyEvent;
    fUserRemoved: TNotifyEvent;
    fProfileEvent: TNotifyEvent;
    procedure GetEvent;
    procedure HandleCogAction;
    procedure HandleCogEvent;
    procedure Log(aMsg: String);
  protected
    { Protected declarations }

    procedure AcceptTraining;
  public
    property OnCognitivTrainingStarted: TNotifyEvent read fCognitivTrainingStarted write fCognitivTrainingStarted;
    property OnCognitivTrainingSucceeded: TTrainingSucceededEvent read fCognitivTrainingSucceeded write fCognitivTrainingSucceeded;
    property OnCognitivTrainingFailed: TNotifyEvent read fCognitivTrainingFailed write fCognitivTrainingFailed;
    property OnCognitivTrainingCompleted: TNotifyEvent read fCognitivTrainingCompleted write fCognitivTrainingCompleted;
    property OnCognitivTrainingDataErased: TNotifyEvent read fCognitivTrainingDataErased write fCognitivTrainingDataErased;
    property OnCognitivTrainingRejected: TNotifyEvent read fCognitivTrainingRejected write fCognitivTrainingRejected;
    property OnCognitivAutoSamplingNeutralCompleted: TNotifyEvent read fCognitivAutoSamplingNeutralCompleted write fCognitivAutoSamplingNeutralCompleted;
    property OnCognitivSignatureUpdated: TNotifyEvent read fCognitivSignatureUpdated write fCognitivSignatureUpdated;

    property OnUserAdded: TNotifyEvent read fUserAdded write fUserAdded;
    property OnUserRemoved: TNotifyEvent read fUserRemoved write fUserRemoved;
    property OnProfileEvent: TNotifyEvent read fProfileEvent write fProfileEvent;



    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }

  published
    { Published declarations }
  end;

const
  CogActions: Array [0..13] of EE_CognitivAction_t =
    (COG_NEUTRAL, COG_PUSH, COG_PULL, COG_LIFT, COG_DROP, COG_LEFT, COG_RIGHT,
      COG_ROTATE_LEFT, COG_ROTATE_RIGHT, COG_ROTATE_CLOCKWISE,
      COG_ROTATE_COUNTER_CLOCKWISE, COG_ROTATE_FORWARDS, COG_ROTATE_REVERSE,
      COG_DISAPPEAR);

function CognitivActionToStr(action: EE_CognitivAction_t): string;
function StrToCognitiveAction(action: String): EE_CognitivAction_t;

procedure Register;

implementation

uses Windows;

procedure Register;
begin
  RegisterComponents('Samples', [TEmotivEpoc]);
end;

type
  TTimerThread = class(TThread)
  private
    FTickEvent: THandle;
    FEventMethod: TThreadMethod;
  protected
    procedure Execute; override;
  public
    constructor Create(EventMethod: TThreadMethod);
    destructor Destroy; override;
    procedure FinishThreadExecution;
  end;

const
  CogActionStrs: Array [0..13] of String =
    ('Neutral', 'Push', 'Pull', 'Lift', 'Drop', 'Left', 'Right',
     'Rotate Left', 'Rotate Right', 'Rotate Clockwise',
     'Rotate Counter Clockwise', 'Rotate Forwards', 'Rotate Reverse',
     'Disappear');

function CognitivActionToStr(action: EE_CognitivAction_t): string;
var
  idx: Integer;
begin
  for idx := low(CogActions) to high(CogActions) do
    if CogActions[idx] = action then
      exit(CogActionStrs[idx]);
  raise Exception.Create('Unspecified action');
end;

function StrToCognitiveAction(action: String): EE_CognitivAction_t;
var
  idx: Integer;
begin
  for idx := low(CogActions) to high(CogActions) do
    if CogActionStrs[idx] = action then
      exit(CogActions[idx]);
  raise Exception.Create('Unspecified action');
end;

{ TTimerThread }

constructor TTimerThread.Create(EventMethod: TThreadMethod);
begin
  FreeOnTerminate := True;
  FTickEvent := CreateEvent(nil, True, False, nil);
  FEventMethod := EventMethod;
end;

destructor TTimerThread.Destroy;
begin
  CloseHandle(FTickEvent);
  inherited;
end;

procedure TTimerThread.Execute;
begin
  while not Terminated do
  begin
    if WaitForSingleObject(FTickEvent, 10) = WAIT_TIMEOUT then
    begin
      Synchronize(FEventMethod);
    end;
  end;
end;

procedure TTimerThread.FinishThreadExecution;
begin
  Terminate;
  SetEvent(FTickEvent);
end;

{ TComponent1 }

procedure TEmotivEpoc.AcceptTraining;
begin
  RaiseEdkError(EE_CognitivSetTrainingControl(0, COG_ACCEPT));
end;

constructor TEmotivEpoc.Create(AOwner: TComponent);
begin
  inherited;

  if not (csDesigning in ComponentState) then
  begin
    userID := 65535;
    //RaiseEdkError(EE_EngineRemoteConnect(PAnsiChar(AnsiString('127.0.0.1')),1726,PAnsiChar(AnsiString('Emotiv Systems-5'))));
    RaiseEdkError(EE_EngineConnect(PAnsiChar(AnsiString('Emotiv Systems-5'))));

    eEvent := EE_EmoEngineEventCreate();
    eState := EE_EmoStateCreate();
    EE_GetBaseProfile(eProfile);
  end;
end;

destructor TEmotivEpoc.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    EE_EmoStateFree(eState);
    EE_EmoEngineEventFree(eEvent);
    EE_EngineDisconnect;
  end;

  inherited;
end;

procedure TEmotivEpoc.GetEvent;
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
      EE_UnknownEvent:
      begin
        Log('UnknownEvent');
        RaiseEdkError(EDK_UNKNOWN_ERROR);
      end;
      EE_EmulatorError:
      begin
        Log('EmulatorError');
        raise EEmotivEdkError.Create('The call to EE_EmoEngineEventGetType returned an Emulator Error.');
      end;
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

procedure TEmotivEpoc.HandleCogEvent;
var
  cogEvent: EE_CognitivEvent_t;
  reject: Boolean;
begin
  cogEvent := EE_CognitivEventGetType(eEvent);
  case cogEvent of
    EE_CognitivNoEvent: Log('Cog: NoEvent');
    EE_CognitivTrainingStarted:
    begin
      Log('Cog: TrainingStarted');
      if Assigned(fCognitivTrainingStarted) then
        fCognitivTrainingStarted(self);
      //pbTraining.Visible := True;
      //animateTraining.Start;
    end;
    EE_CognitivTrainingSucceeded:
    begin
      Log('Cog: TrainingSucceeded');
      if Assigned(fCognitivTrainingSucceeded) then
        fCognitivTrainingSucceeded(self, reject);
      if not reject then
        AcceptTraining;

      //animateTraining.Stop;
      //pbTraining.Visible := False;
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

procedure TEmotivEpoc.Log(aMsg: String);
begin

end;

procedure TEmotivEpoc.HandleCogAction();
var
  power: Single;
  cogAction: EE_CognitivAction_t;
begin
  cogAction := ES_CognitivGetCurrentAction(eState);
  power := ES_CognitivGetCurrentActionPower(eState);

 { DisplayPower(cogAction, power);

  if switchTether.IsChecked then
    CogTether(cogAction);

  if switchDrone.IsChecked then
    CogDrone(cogAction, power);  }
end;





end.
