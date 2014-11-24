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
    procedure FormShow(Sender: TObject);
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

{$ifdef Android}
uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.Helpers,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net.Wifi;

function GetIpAddress: String;
var
  WifiManagerObj: JObject;
  WifiManager: JWifiManager;
  WifiInfo: JWifiInfo;
  ip: Integer;
begin
  WifiManagerObj := SharedActivityContext.getSystemService(TJContext.JavaClass.WIFI_SERVICE);
  WifiManager := TJWifiManager.Wrap((WifiManagerObj as ILocalObject).GetObjectID);
  WifiInfo := WifiManager.getConnectionInfo();
  ip := WifiInfo.getIpAddress and $FFFFFFFF;

  result := Format('%d.%d.%d.%d',
    [(IP) and $FF,
     (IP shr 8) and $FF,
     (IP shr 16) and $FF,
     (IP shr 24) and $FF]);

 end;
{$ELSE}
function GetIpAddress: String;
begin
  result := 'unknown';
end;
{$ENDIF}

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

procedure TForm17.FormShow(Sender: TObject);
begin
  lbCommand.Text := GetIpAddress;
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
  Result := False;
end;

end.
