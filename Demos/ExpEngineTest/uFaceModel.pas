unit uFaceModel;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects;

type
  TFrame1 = class(TFrame)
    Circle1: TCircle;
    xLeftEye: TCircle;
    xLeftPupil: TCircle;
    xLeftBrow: TRectangle;
    xRightBrow: TRectangle;
    Pie1: TPie;
    xMouth: TArc;
    xRightEye: TCircle;
    xRightPupil: TCircle;
    ScaledLayout1: TScaledLayout;
  private
    FBlink: Boolean;
    FRightWink: Boolean;
    FClench: Boolean;
    FRaiseBrow: Boolean;
    FLookLeft: Boolean;
    FLookRight: Boolean;
    FLeftSmirk: Boolean;
    FSmile: Boolean;
    FFurrowBrow: Boolean;
    FLaugh: Boolean;
    FRightSmirk: Boolean;
    FLeftWink: Boolean;
    procedure SetBlink(const Value: Boolean);
    procedure SetClench(const Value: Boolean);
    procedure SetFurrowBrow(const Value: Boolean);
    procedure SetLaugh(const Value: Boolean);
    procedure SetLeftSmirk(const Value: Boolean);
    procedure SetLeftWink(const Value: Boolean);
    procedure SetLookLeft(const Value: Boolean);
    procedure SetLookRight(const Value: Boolean);
    procedure SetRaiseBrow(const Value: Boolean);
    procedure SetRightSmirk(const Value: Boolean);
    procedure SetRightWink(const Value: Boolean);
    procedure SetSmile(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    property Blink: Boolean read FBlink write SetBlink;
    property RightWink: Boolean read FRightWink write SetRightWink;
    property LeftWink: Boolean read FLeftWink write SetLeftWink;
    property LookLeft: Boolean read FLookLeft write SetLookLeft;
    property LookRight: Boolean read FLookRight write SetLookRight;
    property RaiseBrow: Boolean read FRaiseBrow write SetRaiseBrow;
    property FurrowBrow: Boolean read FFurrowBrow write SetFurrowBrow;
    property Smile: Boolean read FSmile write SetSmile;
    property RightSmirk: Boolean read FRightSmirk write SetRightSmirk;
    property LeftSmirk: Boolean read FLeftSmirk write SetLeftSmirk;
    property Clench: Boolean read FClench write SetClench;
    property Laugh: Boolean read FLaugh write SetLaugh;
  end;

implementation

{$R *.fmx}

{ TFrame1 }



{ TFrame1 }

procedure TFrame1.SetBlink(const Value: Boolean);
begin
  FBlink := Value;
  RightWink := Value;
  LeftWink := Value;
end;

procedure TFrame1.SetClench(const Value: Boolean);
begin
  FClench := Value;
end;

procedure TFrame1.SetFurrowBrow(const Value: Boolean);
begin
  FFurrowBrow := Value;
end;

procedure TFrame1.SetLaugh(const Value: Boolean);
begin
  FLaugh := Value;
end;

procedure TFrame1.SetLeftSmirk(const Value: Boolean);
begin
  FLeftSmirk := Value;
end;

procedure TFrame1.SetLeftWink(const Value: Boolean);
begin
  FLeftWink := Value;
end;

procedure TFrame1.SetLookLeft(const Value: Boolean);
begin
  FLookLeft := Value;
end;

procedure TFrame1.SetLookRight(const Value: Boolean);
begin
  FLookRight := Value;
end;

procedure TFrame1.SetRaiseBrow(const Value: Boolean);
begin
  FRaiseBrow := Value;
end;

procedure TFrame1.SetRightSmirk(const Value: Boolean);
begin
  FRightSmirk := Value;
end;

procedure TFrame1.SetRightWink(const Value: Boolean);
begin
  FRightWink := Value;
end;

procedure TFrame1.SetSmile(const Value: Boolean);
begin
  FSmile := Value;
end;

end.
