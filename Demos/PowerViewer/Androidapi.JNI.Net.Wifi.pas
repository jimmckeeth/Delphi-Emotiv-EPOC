{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{   Android API: package "android.net.wifi" for XE6     }
{                                                       }
{ Copyright(c) 2014 Andrey Yefimov. (28.04.2014)        }
{ Contact: delphifmandroid.blogspot.ru                  }
{ Special thanks to Yaroslav Brovin (Embarcadero).      }
{*******************************************************}

unit Androidapi.JNI.Net.Wifi;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes;

type
  {Class forward declarations}
  JScanResult = interface; //android.net.wifi.ScanResult
  JWifiConfiguration = interface; //android.net.wifi.WifiConfiguration
  JWifiConfigurationAuthAlgorithm = interface; //android.net.wifi.WifiConfiguration.AuthAlgorithm
  JWifiConfigurationGroupCipher = interface; //android.net.wifi.WifiConfiguration.GroupCipher
  JWifiConfigurationKeyMgmt = interface; //android.net.wifi.WifiConfiguration.KeyMgmt
  JWifiConfigurationPairwiseCipher = interface; //android.net.wifi.WifiConfiguration.PairwiseCipher
  JWifiConfigurationProtocol = interface; //android.net.wifi.WifiConfiguration.Protocol
  JWifiConfigurationStatus = interface; //android.net.wifi.WifiConfiguration.Status
  JWifiInfo = interface; //android.net.wifi.WifiInfo
  JWifiManager = interface; //android.net.wifi.WifiManager
  JWifiManagerMulticastLock = interface; //android.net.wifi.WifiManager.MulticastLock
  JWifiManagerWifiLock = interface; //android.net.wifi.WifiManager.WifiLock
  JSupplicantState = interface; //android.net.wifi.SupplicantState


JScanResultClass = interface(JObjectClass)
['{5AEBB13C-C013-47CB-B120-F3D1FCFF9BE8}']
end;

[JavaSignature('android/net/wifi/ScanResult')]
JScanResult = interface(JObject)
['{1D32FC9E-D6EB-4F1F-9760-1E90D971D602}']
  {Property Methods}
  function _GetBSSID: JString;
  procedure _SetBSSID(Value: JString);
  function _GetSSID: JString;
  procedure _SetSSID(Value: JString);
  function _Getcapabilities: JString;
  procedure _Setcapabilities(Value: JString);
  function _Getfrequency: Integer;
  procedure _Setfrequency(Value: Integer);
  function _Getlevel: Integer;
  procedure _Setlevel(Value: Integer);
  {Methods}
  function toString: JString; cdecl;
  {Properties}
  property BSSID: JString read _GetBSSID write _SetBSSID;
  property SSID: JString read _GetSSID write _SetSSID;
  property capabilities: JString read _Getcapabilities write _Setcapabilities;
  property frequency: Integer read _Getfrequency write _Setfrequency;
  property level: Integer read _Getlevel write _Setlevel;
end;
TJScanResult = class(TJavaGenericImport<JScanResultClass, JScanResult>) end;

JWifiConfigurationClass = interface(JObjectClass)
['{7C986A3D-A1CF-4F27-86DB-BF067F3A1519}']
  {Methods}
  function init: JWifiConfiguration; cdecl; overload;
end;

[JavaSignature('android/net/wifi/WifiConfiguration')]
JWifiConfiguration = interface(JObject)
['{8F911FA8-4F7D-4819-A477-8B2B1A9BA842}']
  {Property Methods}
  //not all
  function _GetBSSID: JString;
  procedure _SetBSSID(Value: JString);
  function _GetSSID: JString;
  procedure _SetSSID(Value: JString);
  function _GethiddenSSID: Boolean;
  procedure _SethiddenSSID(Value: Boolean);
  function _GetnetworkId: Integer;
  procedure _SetnetworkId(Value: Integer);
  function _GetpreSharedKey: JString;
  procedure _SetpreSharedKey(Value: JString);
  function _Getpriority: Integer;
  procedure _Setpriority(Value: Integer);
  function _Getstatus: Integer;
  procedure _Setstatus(Value: Integer);
  function _GetwepKeys: TJavaObjectArray<JString>;
  procedure _SetwepKeys(Value: TJavaObjectArray<JString>);
  function _GetwepTxKeyIndex: Integer;
  procedure _SetwepTxKeyIndex(Value: Integer);
  {Methods}
  function toString: JString; cdecl;
  {Properties}
  property BSSID: JString read _GetBSSID write _SetBSSID;
  property SSID: JString read _GetSSID write _SetSSID;
  property hiddenSSID: Boolean read _GethiddenSSID write _SethiddenSSID;
  property networkId: Integer read _GetnetworkId write _SetnetworkId;
  property preSharedKey: JString read _GetpreSharedKey write _SetpreSharedKey;
  property priority: Integer read _Getpriority write _Setpriority;
  property status: Integer read _Getstatus write _Setstatus;
  property wepKeys: TJavaObjectArray<JString> read _GetwepKeys write _SetwepKeys;
  property wepTxKeyIndex: Integer read _GetwepTxKeyIndex write _SetwepTxKeyIndex;
end;
TJWifiConfiguration = class(TJavaGenericImport<JWifiConfigurationClass, JWifiConfiguration>) end;

JWifiConfigurationAuthAlgorithmClass = interface(JObjectClass)
['{215B95A2-5A70-475F-9235-767501988613}']
  {Property Methods}
  function _GetLEAP: Integer;
  function _GetOPEN: Integer;
  function _GetSHARED: Integer;
  function _GetvarName: JString;
  function _GetStrings: TJavaObjectArray<JString>;
  {Properties}
  property LEAP: Integer read _GetLEAP;
  property OPEN: Integer read _GetOPEN;
  property SHARED: Integer read _GetSHARED;
  property varName: JString read _GetvarName;
  property strings: TJavaObjectArray<JString> read _GetStrings;
end;

[JavaSignature('android/net/wifi/WifiConfiguration$AuthAlgorithm')]
JWifiConfigurationAuthAlgorithm = interface(JObject)
['{D5A213AD-E489-42FE-81FC-4BF2591A2581}']
  {Methods}
end;
TJWifiConfigurationAuthAlgorithm = class(TJavaGenericImport<JWifiConfigurationAuthAlgorithmClass, JWifiConfigurationAuthAlgorithm>) end;

JWifiConfigurationGroupCipherClass = interface(JObjectClass)
['{1E7B0993-BFFD-4BA8-A8BF-2C9B93F2982C}']
  {Property Methods}
  function _GetCCMP: Integer;
  function _GetTKIP: Integer;
  function _GetWEP104: Integer;
  function _GetWEP40: Integer;
  function _GetvarName: JString;
  function _GetStrings: TJavaObjectArray<JString>;
  {Properties}
  property CCMP: Integer read _GetCCMP;
  property TKIP: Integer read _GetTKIP;
  property WEP104: Integer read _GetWEP104;
  property WEP40: Integer read _GetWEP40;
  property varName: JString read _GetvarName;
  property strings: TJavaObjectArray<JString> read _GetStrings;
end;

[JavaSignature('android/net/wifi/WifiConfiguration$GroupCipher')]
JWifiConfigurationGroupCipher = interface(JObject)
['{D3FE4453-0A47-4A53-9364-61C736F1F3BE}']
  {Methods}
end;
TJWifiConfigurationGroupCipher = class(TJavaGenericImport<JWifiConfigurationGroupCipherClass, JWifiConfigurationGroupCipher>) end;

JWifiConfigurationKeyMgmtClass = interface(JObjectClass)
['{46349CF3-AF0C-4DD4-A117-A4DEA4A1FC21}']
  {Property Methods}
  function _GetIEEE8021X: Integer;
  function _GetNONE: Integer;
  function _GetWPA_EAP: Integer;
  function _GetWPA_PSK: Integer;
  function _GetvarName: JString;
  function _GetStrings: TJavaObjectArray<JString>;
  {Properties}
  property IEEE8021X: Integer read _GetIEEE8021X;
  property NONE: Integer read _GetNONE;
  property WPA_EAP: Integer read _GetWPA_EAP;
  property WPA_PSK: Integer read _GetWPA_PSK;
  property varName: JString read _GetvarName;
  property strings: TJavaObjectArray<JString> read _GetStrings;
end;

[JavaSignature('android/net/wifi/WifiConfiguration$KeyMgmt')]
JWifiConfigurationKeyMgmt = interface(JObject)
['{B33C6029-277D-47C9-9465-86D2E8C01A59}']
  {Methods}
end;
TJWifiConfigurationKeyMgmt = class(TJavaGenericImport<JWifiConfigurationKeyMgmtClass, JWifiConfigurationKeyMgmt>) end;

JWifiConfigurationPairwiseCipherClass = interface(JObjectClass)
['{0817D2D9-BD87-46BE-82A4-883A61D4381F}']
  {Property Methods}
  function _GetCCMP: Integer;
  function _GetNONE: Integer;
  function _GetTKIP: Integer;
  function _GetvarName: JString;
  function _GetStrings: TJavaObjectArray<JString>;
  {Properties}
  property CCMP: Integer read _GetCCMP;
  property NONE: Integer read _GetNONE;
  property TKIP: Integer read _GetTKIP;
  property varName: JString read _GetvarName;
  property strings: TJavaObjectArray<JString> read _GetStrings;
end;

[JavaSignature('android/net/wifi/WifiConfiguration$PairwiseCipher')]
JWifiConfigurationPairwiseCipher = interface(JObject)
['{F7326A76-992E-44E3-AD15-14A2D2DA00A1}']
  {Methods}
end;
TJWifiConfigurationPairwiseCipher = class(TJavaGenericImport<JWifiConfigurationPairwiseCipherClass, JWifiConfigurationPairwiseCipher>) end;

JWifiConfigurationProtocolClass = interface(JObjectClass)
['{6112F757-C8D1-4F34-A97B-C6B1F82B6FC6}']
  {Property Methods}
  function _GetRSN: Integer;
  function _GetWPA: Integer;
  function _GetvarName: JString;
  function _GetStrings: TJavaObjectArray<JString>;
  {Properties}
  property RSN: Integer read _GetRSN;
  property WPA: Integer read _GetWPA;
  property varName: JString read _GetvarName;
  property strings: TJavaObjectArray<JString> read _GetStrings;
end;

[JavaSignature('android/net/wifi/WifiConfiguration$Protocol')]
JWifiConfigurationProtocol = interface(JObject)
['{17AE3BB2-D6A1-432C-A78A-8E75D7A66207}']
  {Methods}
end;
TJWifiConfigurationProtocol = class(TJavaGenericImport<JWifiConfigurationProtocolClass, JWifiConfigurationProtocol>) end;

JWifiConfigurationStatusClass = interface(JObjectClass)
['{ADE52A99-B548-4BC3-94C6-B80BE0391B93}']
  {Property Methods}
  function _GetCURRENT: Integer;
  function _GetDISABLED: Integer;
  function _GetENABLED: Integer;
  function _GetStrings: TJavaObjectArray<JString>;
  {Properties}
  property CURRENT: Integer read _GetCURRENT;
  property DISABLED: Integer read _GetDISABLED;
  property ENABLED: Integer read _GetENABLED;
  property strings: TJavaObjectArray<JString> read _GetStrings;
end;

[JavaSignature('android/net/wifi/WifiConfiguration$Status')]
JWifiConfigurationStatus = interface(JObject)
['{95BC78F2-51A2-4927-815F-1C49D1394CDA}']
  {Methods}
end;
TJWifiConfigurationStatus = class(TJavaGenericImport<JWifiConfigurationStatusClass, JWifiConfigurationStatus>) end;

JWifiInfoClass = interface(JObjectClass)
['{E34882C5-CD5D-469C-9020-513FC1C4E48A}']
  {Property Methods}
  function _GetLINK_SPEED_UNITS: JString;
  {Methods}
  //getDetailedStateOf(SupplicantState suppState): NetworkInfo.DetailedState; cdecl;
  {Properties}
  property LINK_SPEED_UNITS: JString read _GetLINK_SPEED_UNITS;
end;

[JavaSignature('android/net/wifi/WifiInfo')]
JWifiInfo = interface(JObject)
['{6E31D165-FE5E-49EF-BE9D-61A93C7A8EAB}']
  {Methods}
  function getBSSID: JString; cdecl;
  function getHiddenSSID: Boolean; cdecl;
  function getIpAddress: Integer; cdecl;
  function getLinkSpeed: Integer; cdecl;
  function getMacAddress: JString; cdecl;
  function getNetworkId: Integer; cdecl;
  function getRssi: Integer; cdecl;
  function getSSID: JString; cdecl;
  function getSupplicantState: JSupplicantState; cdecl;
  function toString: JString; cdecl;
end;
TJWifiInfo = class(TJavaGenericImport<JWifiInfoClass, JWifiInfo>) end;

JWifiManagerClass = interface(JObjectClass)
['{03F05192-9999-43A4-9F7C-CE345486E4B6}']
  {Property Methods}
  function _GetACTION_PICK_WIFI_NETWORK: JString;
  function _GetERROR_AUTHENTICATING: Integer;
  function _GetEXTRA_BSSID: JString;
  function _GetEXTRA_NETWORK_INFO: JString;
  function _GetEXTRA_NEW_RSSI: JString;
  function _GetEXTRA_NEW_STATE: JString;
  function _GetEXTRA_PREVIOUS_WIFI_STATE: JString;
  function _GetEXTRA_SUPPLICANT_CONNECTED: JString;
  function _GetEXTRA_SUPPLICANT_ERROR: JString;
  function _GetEXTRA_WIFI_STATE: JString;
  function _GetNETWORK_IDS_CHANGED_ACTION: JString;
  function _GetNETWORK_STATE_CHANGED_ACTION: JString;
  function _GetRSSI_CHANGED_ACTION: JString;
  function _GetSCAN_RESULTS_AVAILABLE_ACTION: JString;
  function _GetSUPPLICANT_CONNECTION_CHANGE_ACTION: JString;
  function _GetSUPPLICANT_STATE_CHANGED_ACTION: JString;
  function _GetWIFI_MODE_FULL: Integer;
  function _GetWIFI_MODE_SCAN_ONLY: Integer;
  function _GetWIFI_STATE_CHANGED_ACTION: JString;
  function _GetWIFI_STATE_DISABLED: Integer;
  function _GetWIFI_STATE_DISABLING: Integer;
  function _GetWIFI_STATE_ENABLED: Integer;
  function _GetWIFI_STATE_ENABLING: Integer;
  function _GetWIFI_STATE_UNKNOWN: Integer;
  {Methods}
  function calculateSignalLevel(rssi: Integer; numLevels: Integer): Integer; cdecl;
  function compareSignalLevel(rssiA: Integer; rssiB: Integer): Integer; cdecl;
  {Properties}
  property ACTION_PICK_WIFI_NETWORK: JString read _GetACTION_PICK_WIFI_NETWORK;
  property ERROR_AUTHENTICATING: Integer read _GetERROR_AUTHENTICATING;
  property EXTRA_BSSID: JString read _GetEXTRA_BSSID;
  property EXTRA_NETWORK_INFO: JString read _GetEXTRA_NETWORK_INFO;
  property EXTRA_NEW_RSSI: JString read _GetEXTRA_NEW_RSSI;
  property EXTRA_NEW_STATE: JString read _GetEXTRA_NEW_STATE;
  property EXTRA_PREVIOUS_WIFI_STATE: JString read _GetEXTRA_PREVIOUS_WIFI_STATE;
  property EXTRA_SUPPLICANT_CONNECTED: JString read _GetEXTRA_SUPPLICANT_CONNECTED;
  property EXTRA_SUPPLICANT_ERROR: JString read _GetEXTRA_SUPPLICANT_ERROR;
  property EXTRA_WIFI_STATE: JString read _GetEXTRA_WIFI_STATE;
  property NETWORK_IDS_CHANGED_ACTION: JString read _GetNETWORK_IDS_CHANGED_ACTION;
  property NETWORK_STATE_CHANGED_ACTION: JString read _GetNETWORK_STATE_CHANGED_ACTION;
  property RSSI_CHANGED_ACTION: JString read _GetRSSI_CHANGED_ACTION;
  property SCAN_RESULTS_AVAILABLE_ACTION: JString read _GetSCAN_RESULTS_AVAILABLE_ACTION;
  property SUPPLICANT_CONNECTION_CHANGE_ACTION: JString read _GetSUPPLICANT_CONNECTION_CHANGE_ACTION;
  property SUPPLICANT_STATE_CHANGED_ACTION: JString read _GetSUPPLICANT_STATE_CHANGED_ACTION;
  property WIFI_MODE_FULL: Integer read _GetWIFI_MODE_FULL;
  property WIFI_MODE_SCAN_ONLY: Integer read _GetWIFI_MODE_SCAN_ONLY;
  property WIFI_STATE_CHANGED_ACTION: JString read _GetWIFI_STATE_CHANGED_ACTION;
  property WIFI_STATE_DISABLED: Integer read _GetWIFI_STATE_DISABLED;
  property WIFI_STATE_DISABLING: Integer read _GetWIFI_STATE_DISABLING;
  property WIFI_STATE_ENABLED: Integer read _GetWIFI_STATE_ENABLED;
  property WIFI_STATE_ENABLING: Integer read _GetWIFI_STATE_ENABLING;
  property WIFI_STATE_UNKNOWN: Integer read _GetWIFI_STATE_UNKNOWN;
end;

[JavaSignature('android/net/wifi/WifiManager')]
JWifiManager = interface(JObject)
['{56987130-3FBC-47FC-BAE4-743D32F41D1B}']
  {Methods}
  function addNetwork(config: JWifiConfiguration): Integer; cdecl;
  function createMulticastLock(tag: JString): JWifiManagerMulticastLock; cdecl;
  function createWifiLock(tag: JString): JWifiManagerWifiLock; cdecl; overload;
  function createWifiLock(lockType: Integer; tag: JString): JWifiManagerWifiLock; cdecl; overload;
  function disableNetwork(netId: Integer): Boolean; cdecl;
  function disconnect: Boolean; cdecl;
  function enableNetwork(netId: Integer; disableOthers: Boolean): Boolean; cdecl;
  function getConfiguredNetworks: JList; cdecl;
  function getConnectionInfo: JWifiInfo; cdecl;
  //function getDhcpInfo: JDhcpInfo; cdecl; // Не реализовано
  function getScanResults: JList; cdecl;
  function getWifiState: Integer; cdecl;
  function isWifiEnabled: Boolean; cdecl;
  function pingSupplicant: Boolean; cdecl;
  function reassociate: Boolean; cdecl;
  function reconnect: Boolean; cdecl;
  function removeNetwork(netId: Integer): Boolean; cdecl;
  function saveConfiguration: Boolean; cdecl;
  function setWifiEnabled(enabled: Boolean): Boolean; cdecl;
  function startScan: Boolean; cdecl;
  function updateNetwork(config: JWifiConfiguration): Integer; cdecl;
end;
TJWifiManager = class(TJavaGenericImport<JWifiManagerClass, JWifiManager>) end;

JWifiManagerMulticastLockClass = interface(JObjectClass)
['{AB7FF97A-DB1B-49D0-B9C4-DB71120C0E91}']
end;

[JavaSignature('android/net/wifi/WifiManager$MulticastLock')]
JWifiManagerMulticastLock = interface(JObject)
['{94091B6F-B3D2-4D9B-A121-67FF909B9952}']
  {Methods}
	procedure acquire; cdecl;
	function isHeld: Boolean; cdecl;
	procedure release; cdecl;
	procedure setReferenceCounted(refCounted: Boolean); cdecl;
  function toString: JString; cdecl;
end;
TJWifiManagerMulticastLock = class(TJavaGenericImport<JWifiManagerMulticastLockClass, JWifiManagerMulticastLock>) end;

JWifiManagerWifiLockClass = interface(JObjectClass)
['{09DB2A5C-6589-46FC-A20F-370A7DC60A2D}']
end;

[JavaSignature('android/net/wifi/WifiManager$WifiLock')]
JWifiManagerWifiLock = interface(JObject)
['{A20C2352-4E56-43A5-9219-82CC45F65D9B}']
  {Methods}
	procedure acquire; cdecl;
	function isHeld: Boolean; cdecl;
	procedure release; cdecl;
	procedure setReferenceCounted(refCounted: Boolean); cdecl;
	//procedure setWorkSource(Landroid/os/WorkSource;); cdecl;
  function toString: JString; cdecl;
end;
TJWifiManagerWifiLock = class(TJavaGenericImport<JWifiManagerWifiLockClass, JWifiManagerWifiLock>) end;

JSupplicantStateClass = interface(JEnumClass)
['{5EE27CFE-964F-44B8-9C03-71B5B0A93063}']
  {Property Methods}
  function _GetASSOCIATED: JSupplicantState;
  function _GetASSOCIATING: JSupplicantState;
  function _GetAUTHENTICATING: JSupplicantState;
  function _GetCOMPLETED: JSupplicantState;
  function _GetDISCONNECTED: JSupplicantState;
  function _GetDORMANT: JSupplicantState;
  function _GetFOUR_WAY_HANDSHAKE: JSupplicantState;
  function _GetGROUP_HANDSHAKE: JSupplicantState;
  function _GetINACTIVE: JSupplicantState;
  function _GetINTERFACE_DISABLED: JSupplicantState;
  function _GetINVALID: JSupplicantState;
  function _GetSCANNING: JSupplicantState;
  function _GetUNINITIALIZED: JSupplicantState;
  {Methods}
  function isValidState(state: JSupplicantState): Boolean; cdecl;
  function valueOf(name: JString): JSupplicantState; cdecl;
  function values: TJavaObjectArray<JSupplicantState>; cdecl;
  {Properties}
  property ASSOCIATED: JSupplicantState read _GetASSOCIATED;
  property ASSOCIATING: JSupplicantState read _GetASSOCIATING;
  property AUTHENTICATING: JSupplicantState read _GetAUTHENTICATING;
  property COMPLETED: JSupplicantState read _GetCOMPLETED;
  property DISCONNECTED: JSupplicantState read _GetDISCONNECTED;
  property DORMANT: JSupplicantState read _GetDORMANT;
  property FOUR_WAY_HANDSHAKE: JSupplicantState read _GetFOUR_WAY_HANDSHAKE;
  property GROUP_HANDSHAKE: JSupplicantState read _GetGROUP_HANDSHAKE;
  property INACTIVE: JSupplicantState read _GetINACTIVE;
  property INTERFACE_DISABLED: JSupplicantState read _GetINTERFACE_DISABLED;
  property INVALID: JSupplicantState read _GetINVALID;
  property SCANNING: JSupplicantState read _GetSCANNING;
  property UNINITIALIZED: JSupplicantState read _GetUNINITIALIZED;
end;

[JavaSignature('android/net/wifi/SupplicantState')]
JSupplicantState = interface(JEnum)
['{E38578E3-F539-44BF-B181-CC349009E6F1}']
end;
TJSupplicantState = class(TJavaGenericImport<JSupplicantStateClass, JSupplicantState>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JScanResult', TypeInfo(Androidapi.JNI.Net.Wifi.JScanResult));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiConfiguration', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiConfiguration));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiConfigurationAuthAlgorithm', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiConfigurationAuthAlgorithm));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiConfigurationGroupCipher', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiConfigurationGroupCipher));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiConfigurationKeyMgmt', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiConfigurationKeyMgmt));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiConfigurationPairwiseCipher', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiConfigurationPairwiseCipher));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiConfigurationProtocol', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiConfigurationProtocol));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiConfigurationStatus', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiConfigurationStatus));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiInfo', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiManager', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiManager));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiManagerMulticastLock', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiManagerMulticastLock));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JWifiManagerWifiLock', TypeInfo(Androidapi.JNI.Net.Wifi.JWifiManagerWifiLock));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Wifi.JSupplicantState', TypeInfo(Androidapi.JNI.Net.Wifi.JSupplicantState));
end;

initialization
  RegisterTypes;
end.
