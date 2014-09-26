unit PowerDisplay;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  IPPeerServer, System.Tether.Manager, System.Tether.AppProfile, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Platform
  {$IFDEF ANDROID}
  , Androidapi.JNI.PowerManager
  {$ENDIF}
  ;

type
  TForm17 = class(TForm)
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    pbPower: TProgressBar;
    lbCommand: TLabel;
    StyleBook1: TStyleBook;
    Layout1: TLayout;
    Label2: TLabel;
    {$IFDEF ANDROID}
    fWakeLock: JWakeLock;
    {$ENDIF}
    procedure TetheringAppProfile1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function HandleAppEvent(AAppEvent: TApplicationEvent;
      AContext: TObject): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form17: TForm17;

implementation

{$R *.fmx}
{$R *.GGlass.fmx ANDROID}

procedure TForm17.FormCreate(Sender: TObject);
var
  aFMXApplicationEventService: IFMXApplicationEventService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(aFMXApplicationEventService)) then
    aFMXApplicationEventService.SetApplicationEventHandler(HandleAppEvent);
end;

procedure TForm17.TetheringAppProfile1ResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
var
  power: Integer;
begin
  power := StrToInt(AResource.Value.AsString);
  pbPower.Value := power;
  if Power > 0 then
    lbCommand.Text := AResource.Hint
  else
    lbCommand.Text := '';
end;

procedure TForm17.FormDestroy(Sender: TObject);
begin
  {$IFDEF ANDROID}
  ReleaseWakeLock(fWakeLock);
  {$ENDIF}
end;

function TForm17.HandleAppEvent(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
  {$IFDEF ANDROID}
  case AAppEvent of
    TApplicationEvent.FinishedLaunching: AcquireWakeLock(fWakeLock);
    TApplicationEvent.BecameActive: AcquireWakeLock(fWakeLock);
    TApplicationEvent.WillBecomeInactive: ReleaseWakeLock(fWakeLock);
    TApplicationEvent.EnteredBackground: ReleaseWakeLock(fWakeLock);
    TApplicationEvent.WillBecomeForeground: AcquireWakeLock(fWakeLock);
    TApplicationEvent.WillTerminate: ;
    TApplicationEvent.LowMemory: ;
    TApplicationEvent.TimeChange: ;
    TApplicationEvent.OpenURL: ;
  end;
  {$ENDIF}
end;

end.
