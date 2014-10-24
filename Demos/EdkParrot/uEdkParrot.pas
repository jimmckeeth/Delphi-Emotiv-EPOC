unit uEdkParrot;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox,

  System.Tether.Manager, System.Tether.AppProfile, FMX.Objects, FMX.TabControl,
  FMX.Ani, IPPeerClient, IPPeerServer,

  api.parrot.ardrone,

  Emotiv.Epoc, Emotiv.EDK.Core, Emotiv.EDK.EmoState, Emotiv.EDK.ErrorCodes,
  uStatusFrame;

type
  TForm4 = class(TForm)
    EventAcquisitionTimer: TTimer;
    lbLog: TListBox;
    btnTrain: TButton;
    btnListen: TButton;
    lbCogActions: TListBox;
    cbActions: TComboBox;
    switchDrone: TSwitch;
    btnLand: TButton;
    btnUp: TButton;
    btnDown: TButton;
    btnLeft: TButton;
    btnRight: TButton;
    btnForward: TButton;
    btnBack: TButton;
    btnCW: TButton;
    btnCCW: TButton;
    btnHover: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    pbAct1: TProgressBar;
    pbAct2: TProgressBar;
    pbAct3: TProgressBar;
    pbAct4: TProgressBar;
    lblAct1: TLabel;
    lblAct2: TLabel;
    lblAct3: TLabel;
    lblAct4: TLabel;
    pbTraining: TProgressBar;
    animateTraining: TFloatAnimation;
    StyleBook1: TStyleBook;
    switchCooper: TSwitch;
    Label2: TLabel;
    CooperTetheringProfile: TTetheringAppProfile;
    TetheringManager: TTetheringManager;
    Drone: TARDrone;
    btnEmergency: TSpeedButton;
    Image1: TImage;
    btnLaunch: TSpeedButton;
    Image2: TImage;
    btnFlatTrim: TSpeedButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Layout1: TLayout;
    lblLog: TLabel;
    DroneSendTimer: TTimer;
    Button1: TButton;
    DisplayPowerThetheringProfile: TTetheringAppProfile;
    Image3: TImage;
    Label3: TLabel;
    Button2: TButton;
    statusTimer: TTimer;
    Label10: TLabel;
    lblUptime: TLabel;
    lblWireless: TLabel;
    pbBattery: TProgressBar;
    Label20: TLabel;
    Status: TStatus;
    Layout2: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure EventAcquisitionTimerTimer(Sender: TObject);
    procedure btnTrainClick(Sender: TObject);
    procedure btnListenClick(Sender: TObject);
    procedure lbCogActionsChangeCheck(Sender: TObject);
    procedure switchDroneSwitch(Sender: TObject);
    procedure btnLandClick(Sender: TObject);
    procedure btnCWClick(Sender: TObject);
    procedure btnCCWClick(Sender: TObject);
    procedure btnHoverClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure TetheringManagerEndAutoConnect(Sender: TObject);
    procedure TetheringManagerPairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure TetheringManagerPairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure btnEmergencyClick(Sender: TObject);
    procedure btnFlatTrimClick(Sender: TObject);
    procedure btnLaunchClick(Sender: TObject);
    procedure cbActionsEnter(Sender: TObject);
    procedure DroneConnect(Sender: TObject);
    procedure DroneDisconnect(Sender: TObject);
    procedure btnCWMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnUpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnUpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnDownMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnForwardMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnCCWMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnLeftMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnRightMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnBackMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure DroneSendTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure animateTrainingProcess(Sender: TObject);
    procedure switchCooperSwitch(Sender: TObject);
    procedure animateTrainingFinish(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure pbTrainingMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure pbTrainingMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure pbTrainingMouseLeave(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure statusTimerTimer(Sender: TObject);
  private
    { Private declarations }
    eEvent: Pointer;
    eState: Pointer;
    eProfile: Pointer;
    userID: word;
    cogpower: Single;
    FSustain: TDroneMovement;
    FLastPower: Integer;
    procedure GetEvent;
    procedure Log(msg: String);
    procedure HandleCogEvent;
    procedure HandleCogAction();
    procedure PopulateCogActionList;
    procedure DisplayPower(cogAction: EE_CognitivAction_t; power: Single);
    procedure CogDrone(cogAction: EE_CognitivAction_t; power: Single);
    procedure CogTether(cogAction: EE_CognitivAction_t; power: Single);
    procedure RunRemoteAction(action: string);
    procedure SetSustain(const Value: TDroneMovement);

    property sustain: TDroneMovement read FSustain write SetSustain;
    procedure SendPower(APower: Single);

  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

uses System.Rtti, System.Generics.Collections, System.DateUtils;

procedure TForm4.animateTrainingFinish(Sender: TObject);
begin
  SendPower(0);
end;

procedure TForm4.animateTrainingProcess(Sender: TObject);
begin
  SendPower(pbTraining.Value);
end;

procedure TForm4.btnBackClick(Sender: TObject);
begin
  if switchCooper.IsChecked then
    RunRemoteAction('actBackward');
  if switchDrone.IsChecked then
    drone.MoveBackward;
end;

procedure TForm4.btnBackMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  sustain := TDroneMovement.MoveBackward;
end;

procedure TForm4.btnCCWClick(Sender: TObject);
begin
  if switchCooper.IsChecked then
    RunRemoteAction('actForwardRight');
  if switchDrone.IsChecked then
    drone.RotateCCW;
end;

procedure TForm4.btnCCWMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  sustain := TDroneMovement.RotateCCW;
end;

procedure TForm4.btnCWClick(Sender: TObject);
begin
  if switchCooper.IsChecked then
    RunRemoteAction('actForwardLeft');
  if switchDrone.IsChecked then
    drone.RotateCW;
end;

procedure TForm4.btnCWMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  caption := '';
  sustain := TDroneMovement.RotateCW;
end;

procedure TForm4.btnDownClick(Sender: TObject);
begin
  if switchCooper.IsChecked then
    RunRemoteAction('actBackward');
  if switchDrone.IsChecked then
    drone.MoveDown;
end;

procedure TForm4.btnDownMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  sustain := TDroneMovement.MoveDown;
end;

procedure TForm4.btnFlatTrimClick(Sender: TObject);
begin
  if switchDrone.IsChecked then
    Drone.FlatTrims;
end;

procedure TForm4.btnForwardClick(Sender: TObject);
begin
  if switchDrone.IsChecked then
    drone.MoveForward;
  if switchCooper.IsChecked then
    RunRemoteAction('actForward');
end;

procedure TForm4.btnForwardMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  sustain := TDroneMovement.MoveForward;
end;

procedure TForm4.btnLeftClick(Sender: TObject);
begin
  if switchCooper.IsChecked then
    RunRemoteAction('actLeft');
  if switchDrone.IsChecked then
    drone.MoveLeft;
end;

procedure TForm4.btnLeftMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  sustain := TDroneMovement.MoveLeft;
end;

procedure TForm4.btnRightClick(Sender: TObject);
begin
  if switchCooper.IsChecked then
    RunRemoteAction('actRight');
  if switchDrone.IsChecked then
    drone.MoveRight;
end;

procedure TForm4.btnRightMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  sustain := TDroneMovement.MoveRight;
end;

procedure TForm4.btnUpClick(Sender: TObject);
begin
  if switchCooper.IsChecked then
    RunRemoteAction('actForward');
  if switchDrone.IsChecked then
    drone.MoveUp;
end;

procedure TForm4.btnUpMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  sustain := TDroneMovement.MoveUp;
end;

procedure TForm4.btnUpMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  sustain := TDroneMovement.Hover;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  Drone.AnimateLEDs(TLEDAnimation.SnakeGreenRed, 8, 1);
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  if TetheringManager.RemoteManagers.Count > 0 then
  begin
    pbTraining.Visible := True;
    animateTraining.Start;
  end;
  TetheringManager.AutoConnect();
end;

procedure TForm4.cbActionsEnter(Sender: TObject);
var
  selected: String;
  I: Integer;
begin
  if assigned(cbActions.Selected) then
    selected := cbActions.Selected.Text;

  cbActions.Clear;

  cbActions.Items.Add(CognitivActionToStr(COG_NEUTRAL));
  for I := 0 to lbCogActions.Items.Count-1 do
  begin
    if lbCogActions.ListItems[I].IsChecked then
      cbActions.Items.Add(lbCogActions.ListItems[I].Text);
  end;

  if cbActions.Items.IndexOf(selected) > -1 then
    cbActions.ItemIndex := cbActions.Items.IndexOf(selected)
  else
    cbActions.ItemIndex := 0;
end;

procedure TForm4.btnLandClick(Sender: TObject);
begin
  if switchCooper.IsChecked then
    RunRemoteAction('actAllStop');
  if switchDrone.IsChecked then
  begin
    drone.Land;
  end;
end;

procedure TForm4.btnLaunchClick(Sender: TObject);
begin
  if switchDrone.IsChecked then
  begin
    Drone.FlatTrims;
    Drone.Takeoff;
  end;
end;

procedure TForm4.btnTrainClick(Sender: TObject);
var
  act: EE_CognitivAction_t;
begin
  act := StrToCognitiveAction(cbActions.Selected.Text);
  Log('Train ' + CognitivActionToStr(act));
  RaiseEdkError(EE_CognitivSetTrainingAction(0, act));
  RaiseEdkError(EE_CognitivSetTrainingControl(0, COG_START));
end;

procedure TForm4.btnListenClick(Sender: TObject);
var
  mask: Word;
  I: Integer;
  count: Integer;
begin
  mask := 0;
  count := 0;
  for I := 0 to lbCogActions.Count - 1 do
    if lbCogActions.ListItems[i].IsChecked then
    begin
      mask := mask or word(CogActions[i+1]);
      Inc(count);
      case count of
        1:
        begin
          lblAct1.Text := lbCogActions.ListItems[I].Text;
          lblAct1.Enabled := True;
          pbAct1.Enabled := True;
        end;
        2:
        begin
          lblAct2.Text := lbCogActions.ListItems[I].Text;
          lblAct2.Enabled := True;
          pbAct2.Enabled := True;
        end;
        3:
        begin
          lblAct3.Text := lbCogActions.ListItems[I].Text;
          lblAct3.Enabled := True;
          pbAct3.Enabled := True;
        end;
        4:
        begin
          lblAct4.Text := lbCogActions.ListItems[I].Text;
          lblAct4.Enabled := True;
          pbAct4.Enabled := True;
        end;
      end;

    end;
  RaiseEdkError(EE_CognitivSetActiveActions(0, mask));
  btnListen.Enabled := False;
end;

procedure TForm4.btnHoverClick(Sender: TObject);
begin
  sustain := TDroneMovement.Hover;
  if switchDrone.IsChecked then
    drone.Hover;
  if switchCooper.IsChecked then
    RunRemoteAction('actAllStop');
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if switchDrone.IsChecked then
  begin
    Drone.Land;
    Drone.Disconnect;
  end;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  cogpower := 0;

  lblAct4.Text := '';
  lblAct3.Text := '';
  lblAct2.Text := '';
  lblAct1.Text := '';

  userID := 65535;
  //RaiseEdkError(EE_EngineRemoteConnect(PAnsiChar(AnsiString('127.0.0.1')),1726,PAnsiChar(AnsiString('Emotiv Systems-5'))));
  RaiseEdkError(EE_EngineConnect(PAnsiChar(AnsiString('Emotiv Systems-5'))));

  eEvent := EE_EmoEngineEventCreate();
  eState := EE_EmoStateCreate();
  EE_GetBaseProfile(eProfile);

  PopulateCogActionList;

  sustain := TDroneMovement.Hover;
end;

procedure TForm4.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  case UpCase(KeyChar) of
    'T' : Drone.Takeoff;
    'W' : sustain := TDroneMovement.MoveForward;
    'A' : sustain := TDroneMovement.MoveLeft;
    'S' : sustain := TDroneMovement.MoveBackward;
    'D' : sustain := TDroneMovement.MoveRight;
    'Q' : sustain := TDroneMovement.RotateCCW;
    'E' : sustain := TDroneMovement.RotateCW;
    'R' : sustain := TDroneMovement.MoveUp;
    'F' : sustain := TDroneMovement.MoveDown;
    'Z' : begin
            Drone.Land;
            Log('Land');
          end;
    else
      sustain := TDroneMovement.Hover;
    end;
end;

procedure TForm4.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  sustain := TDroneMovement.Hover;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  pbTraining.Visible := False;
end;

procedure TForm4.PopulateCogActionList;
var
  I: Integer;
begin
  lbCogActions.Clear;
  cbActions.Clear;
  for I := low(CogActions) to high(CogActions) do
  begin
    cbActions.Items.Add(CognitivActionToStr(CogActions[I]));
    if I > 0 then
      lbCogActions.Items.Add(CognitivActionToStr(CogActions[I]));
  end;
  cbActions.ItemIndex := 0;
end;

procedure TForm4.switchDroneSwitch(Sender: TObject);
begin
  if switchDrone.IsChecked then
  begin
    drone.Connect;
    drone.Emergency;
    drone.FlatTrims;
    drone.UnlimitedAltitude;
  end
  else
  begin
    drone.Land;
    drone.Disconnect;
  end;
end;

procedure TForm4.switchCooperSwitch(Sender: TObject);
begin
  TetheringManager.AutoConnect();
end;

procedure TForm4.TetheringManagerEndAutoConnect(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to TetheringManager.RemoteProfiles.Count - 1 do
  begin
    Log('Tethered to: ' + TetheringManager.RemoteProfiles[I].ProfileGroup);
  end;
end;

procedure TForm4.TetheringManagerPairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  Log('Paired from Local');
end;

procedure TForm4.TetheringManagerPairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  Log('Paired from Remote');
end;

function Channel2Str(const Chan: EE_InputChannels_t): String;
begin
  case chan of
    EE_CHAN_CMS: result := 'P3';
    EE_CHAN_DRL: result := 'P4';
    EE_CHAN_FP1: result := 'FP1';
    EE_CHAN_AF3: result := 'AF3';
    EE_CHAN_F7: result := 'F7';
    EE_CHAN_F3: result := 'F3';
    EE_CHAN_FC5: result := 'FC5';
    EE_CHAN_T7: result := 'T7';
    EE_CHAN_P7: result := 'P7';
    EE_CHAN_O1: result := 'O1';
    EE_CHAN_O2: result := 'O2';
    EE_CHAN_P8: result := 'P8';
    EE_CHAN_T8: result := 'T8';
    EE_CHAN_FC6: result := 'FC6';
    EE_CHAN_F4: result := 'F4';
    EE_CHAN_F8: result := 'F8';
    EE_CHAN_AF4: result := 'AF4';
    EE_CHAN_FP2: result := 'FP2';
  else
    raise Exception.Create('Invalud value of EE_InputChannels_t.');
  end;
end;

function Quality2Color(const Qual: EE_EEG_ContactQuality_t): TAlphaColor;
begin
  case Qual of
    EEG_CQ_NO_SIGNAL: result := TAlphaColorRec.White;
    EEG_CQ_VERY_BAD: result := TAlphaColorRec.Red;
    EEG_CQ_POOR: result := TAlphaColorRec.Orange;
    EEG_CQ_FAIR: result := TAlphaColorRec.Yellow;
    EEG_CQ_GOOD: result := TAlphaColorRec.Chartreuse;
  else
    result := TAlphaColorRec.Blue;
  end;

end;

procedure TForm4.statusTimerTimer(Sender: TObject);
var
  contactQuality: EE_EEG_ContactQuality_t;
  loc: EE_InputChannels_t;
  chan: TCircle;
  seconds: Integer;
  uptime: TDateTime;
  wireless: EE_SignalStrength_t;
  chrgLvl, chrgMax: Integer;
begin
  // Uptime
  Seconds := Trunc(ES_GetTimeFromStart(eState));
  uptime := IncSecond(0, seconds);
  if (seconds > 0) then
    lblUptime.Text := FormatDateTime('hh:mm:ss', uptime)
  else
    lblUptime.Text := 'Unknown';

  wireless := ES_GetWirelessSignalStatus(eState);
  case wireless of
    NO_SIGNAL: lblWireless.Text := 'No signal';
    BAD_SIGNAL: lblWireless.Text := 'Bad signal';
    GOOD_SIGNAL: lblWireless.Text := 'Good signal';
  end;

  ES_GetBatteryChargeLevel(eState, @chrgLvl, @chrgMax);
  pbBattery.Max := chrgMax;
  pbBattery.Value := chrgLvl;

  // Sensors
  for loc := EE_CHAN_CMS to EE_CHAN_FP2 do
  begin
    contactQuality := ES_GetContactQuality(eState, Integer(loc));
    chan := status.FindComponent('Chan'+Channel2Str(loc)) as TCircle;
    if Assigned(chan) then
    begin
      chan.Fill.Color := Quality2Color(contactQuality);
    end
  end;
end;

procedure TForm4.EventAcquisitionTimerTimer(Sender: TObject);
begin
  GetEvent;
end;

procedure TForm4.Log(msg: String);
begin
  if not Assigned(lbLog) then exit;

  if (lbLog.Items.Count > 0) and (lbLog.Items[0] = msg) then
  else
    lbLog.Items.Insert(0, msg);
end;

procedure TForm4.pbTrainingMouseLeave(Sender: TObject);
begin
  SendPower(0);
end;

procedure TForm4.pbTrainingMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if ssLeft in Shift then
    SendPower((x / pbTraining.Width)*100);
end;

procedure TForm4.pbTrainingMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  SendPower(0);
end;

procedure TForm4.HandleCogEvent;
var
  cogEvent: EE_CognitivEvent_t;
begin
  cogEvent := EE_CognitivEventGetType(eEvent);
  case cogEvent of
    EE_CognitivNoEvent: Log('Cog: NoEvent');
    EE_CognitivTrainingStarted:
    begin
      Log('Cog: TrainingStarted');
      pbTraining.Visible := True;
      animateTraining.Start;
    end;
    EE_CognitivTrainingSucceeded:
    begin
      Log('Cog: TrainingSucceeded');
      animateTraining.Stop;
      pbTraining.Visible := False;
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
  btnListen.Enabled := True;
  pbAct1.Enabled := False;
  pbAct2.Enabled := False;
  pbAct3.Enabled := False;
  pbAct4.Enabled := False;

  count := 0;
  for I := 0 to lbCogActions.Count - 1 do
  begin
    if lbCogActions.ListItems[I].IsChecked then
    begin
      Inc(count);
      case count of
        1: lblAct1.Text := lbCogActions.ListItems[I].Text;
        2: lblAct2.Text := lbCogActions.ListItems[I].Text;
        3: lblAct3.Text := lbCogActions.ListItems[I].Text;
        4: lblAct4.Text := lbCogActions.ListItems[I].Text;
      end;
    end;
  end;
  if count > 4 then
    lbCogActions.Selected.IsChecked := False;
  if count <= 3 then lblAct4.Text := '';
  if count <= 2 then lblAct3.Text := '';
  if count <= 1 then lblAct2.Text := '';
end;

procedure TForm4.DisplayPower(cogAction: EE_CognitivAction_t; power: Single);
var
  actionName: String;
begin
  actionName := CognitivActionToStr(cogAction);
  pbAct1.Value := 0;
  pbAct2.Value := 0;
  pbAct3.Value := 0;
  pbAct4.Value := 0;
  if lblAct1.Text = actionName then
  begin
    pbAct1.Value := power;
  end;
  if lblAct2.Text = actionName then
  begin
    pbAct2.Value := power;
  end;
  if lblAct3.Text = actionName then
  begin
    pbAct3.Value := power;
  end;
  if lblAct4.Text = actionName then
  begin
    pbAct4.Value := power;
  end;


  if not pbTraining.Visible then
  begin
    SendPower(power * 100);
  end;
end;

procedure TForm4.DroneConnect(Sender: TObject);
begin
  Log('Parrot Connect');
end;

procedure TForm4.DroneDisconnect(Sender: TObject);
begin
  Log('Parrot Disconnect');
end;

procedure TForm4.DroneSendTimerTimer(Sender: TObject);
begin
  if switchDrone.IsChecked then
  begin
    if (cogpower <= 0) then
    begin
      case sustain of
        TDroneMovement.Hover: Drone.Hover;
        TDroneMovement.MoveUp: Drone.MoveUp;
        TDroneMovement.MoveDown: Drone.MoveDown;
        TDroneMovement.MoveLeft: Drone.MoveLeft;
        TDroneMovement.MoveRight: Drone.MoveRight;
        TDroneMovement.MoveForward: Drone.MoveForward;
        TDroneMovement.MoveBackward: Drone.MoveBackward;
        TDroneMovement.RotateCW: Drone.RotateCW;
        TDroneMovement.RotateCCW: Drone.RotateCCW;
      end;
      Caption := 'Current command: ' + TValue.From(sustain).ToString;
    end
    else
      Caption := 'Cognitive ' + IntToStr(trunc(CogPower * 100)) + '%';
  end;
end;

procedure TForm4.RunRemoteAction(action: string);
var
  I: Integer;
  acts: TList<TRemoteAction>;
begin
  for I := 0 to TetheringManager.RemoteProfiles.Count - 1 do
  begin
    acts := CooperTetheringProfile.GetRemoteProfileActions(TetheringManager.RemoteProfiles[I]);
    if acts.Count > 0 then
    begin
      CooperTetheringProfile.RunRemoteAction(
        TetheringManager.RemoteProfiles[I],
        action);
    end;
  end;
end;

procedure TForm4.SetSustain(const Value: TDroneMovement);
begin
  FSustain := Value;
end;

procedure TForm4.SendPower(APower: Single);
var
  I: Integer;
  Power: Integer;
begin
  Power := Trunc(APower);
  if Power <> FLastPower then
  begin
    for I := 0 to TetheringManager.RemoteProfiles.Count - 1 do
    begin
      DisplayPowerThetheringProfile.SendString(
        TetheringManager.RemoteProfiles[I],
        cbActions.Selected.Text,
        Power.ToString);
    end;
    FLastPower := power;
  end;
end;

procedure TForm4.btnEmergencyClick(Sender: TObject);
begin
  if switchDrone.IsChecked then
    Drone.Emergency;
end;

procedure TForm4.CogTether(cogAction: EE_CognitivAction_t; power: Single);
begin
  case cogAction of
    COG_NEUTRAL: RunRemoteAction('actAllStop');
    COG_PUSH: RunRemoteAction('actForward');
    COG_PULL: RunRemoteAction('actBackward');
    COG_LIFT: RunRemoteAction('actForward');
    COG_DROP: RunRemoteAction('actBackward');
    COG_LEFT: RunRemoteAction('actLeft');
    COG_RIGHT: RunRemoteAction('actRight');
    COG_ROTATE_LEFT: RunRemoteAction('actForwardLeft');
    COG_ROTATE_RIGHT: RunRemoteAction('actForwardRight');
    COG_ROTATE_CLOCKWISE: RunRemoteAction('actForwardLeft');
    COG_ROTATE_COUNTER_CLOCKWISE: RunRemoteAction('actForwardRight');
    COG_ROTATE_FORWARDS: RunRemoteAction('actForward');
    COG_ROTATE_REVERSE: RunRemoteAction('actBackward');
    COG_DISAPPEAR: RunRemoteAction('actAllStop');
  end;
end;

procedure TForm4.CogDrone(cogAction: EE_CognitivAction_t; power: Single);
begin
  cogpower := power;
  case cogAction of
    COG_NEUTRAL:
    begin
      Drone.Hover;
      cogpower := 0;
    end;
    COG_PUSH:
      Drone.MoveForward(power);
    COG_PULL:
      Drone.MoveBackward(power);
    COG_LIFT:
      Drone.MoveUp(power);
    COG_DROP:
      Drone.MoveDown(power);
    COG_LEFT:
      Drone.MoveLeft(power);
    COG_RIGHT:
      Drone.MoveRight(power);
    COG_ROTATE_LEFT:
      Drone.RotateCCW(power);
    COG_ROTATE_RIGHT:
      Drone.RotateCW(power);
    COG_ROTATE_CLOCKWISE:
      Drone.RotateCW(power);
    COG_ROTATE_COUNTER_CLOCKWISE:
      Drone.RotateCCW(power);
    COG_ROTATE_FORWARDS:
      Drone.MoveForward(power);
    COG_ROTATE_REVERSE:
      Drone.MoveBackward(power);
    COG_DISAPPEAR:
    begin
      Drone.Land;
      cogpower := 0;
    end;
  end;
end;

procedure TForm4.HandleCogAction();
var
  power: Single;
  cogAction: EE_CognitivAction_t;
begin
  cogAction := ES_CognitivGetCurrentAction(eState);
  power := ES_CognitivGetCurrentActionPower(eState);

  DisplayPower(cogAction, power);

  if switchCooper.IsChecked then
    CogTether(cogAction, power);

  if switchDrone.IsChecked then
    CogDrone(cogAction, power);
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
    if (eventType <> EE_EmulatorError) then
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
