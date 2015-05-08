unit uStatusFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation;

type
  TStatus = class(TFrame)
    StatusFrame: TScaledLayout;
    Arc1: TArc;
    chanFP1: TCircle;
    labelFP1: TLabel;
    ChanF3: TCircle;
    Label4: TLabel;
    ChanF4: TCircle;
    Label5: TLabel;
    chanFP2: TCircle;
    Label11: TLabel;
    chanFC5: TCircle;
    Label8: TLabel;
    chanF7: TCircle;
    Label6: TLabel;
    chanT7: TCircle;
    Label18: TLabel;
    chanP3: TCircle;
    Label14: TLabel;
    chanP7: TCircle;
    Label16: TLabel;
    chanO1: TCircle;
    Label12: TLabel;
    chanO2: TCircle;
    Label13: TLabel;
    chanP8: TCircle;
    Label17: TLabel;
    chanP4: TCircle;
    Label15: TLabel;
    chanT8: TCircle;
    Label19: TLabel;
    ChanFC6: TCircle;
    Label9: TLabel;
    ChanF8: TCircle;
    Label7: TLabel;
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    Line4: TLine;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
