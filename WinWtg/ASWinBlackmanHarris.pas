unit ASWinBlackmanHarris;

{$ifdef FPC}
  {$MODE delphi}{$H+}
{$endif}

interface

uses
  Classes, SysUtils,
  {$ifdef FPC}
  LResources,
  {$endif}
 // Forms, Controls, Graphics, Dialogs,
  ASWinBase;

type

    {TCustomBlackmanHarris}

  TCustomBlackmanHarris= class(TWinBase)
  private
    { Private declarations }
    FA1 : double;       {  coheficientes de BlackmanHarris }
    FA2 : double;
    FA3 : double;
    FA4 : double;

    function GetA1: double;
    procedure SetA1(AValue: double);
    function GetA2: double;
    procedure SetA2(AValue: double);
    function GetA3: double;
    procedure SetA3(AValue: double);
    function GetA4: double;
    procedure SetA4(AValue: double);

  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcCoheff(): Boolean; override;

    property A1: double  read GetA1 write SetA1;
    property A2: double  read GetA2 write SetA2;
    property A3: double  read GetA3 write SetA3;
    property A4: double  read GetA4 write SetA4;

  published
    { Published declarations }
  end;

  type

   {TWinBlackmanHarris}

  TWinBlackmanHarris = class(TCustomBlackmanHarris)
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }

    property  A1;
    property  A2;
    property  A3;
    property  A4;
    property  Order;
    property  Gain;
  end;

procedure Register;

implementation

{$ifNdef FPC}
{$endif}

{ TWinBlackmanHarris }

constructor TWinBlackmanHarris.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinBlackmanHarris.Destroy;
begin
  inherited Destroy;
end;

{ TCustomBlackmanHarris }

function TCustomBlackmanHarris.GetA1: double;
begin
    result := FA1;
end;

procedure TCustomBlackmanHarris.SetA1(AValue: double);
begin
   FA1:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomBlackmanHarris.GetA2: double;
begin
    result := FA2;
end;

procedure TCustomBlackmanHarris.SetA2(AValue: double);
begin
   FA2:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomBlackmanHarris.GetA3: double;
begin
    result := FA3;
end;

procedure TCustomBlackmanHarris.SetA3(AValue: double);
begin
   FA3:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomBlackmanHarris.GetA4: double;
begin
    result := FA4;
end;

procedure TCustomBlackmanHarris.SetA4(AValue: double);
begin
   FA4:= AValue;
   if Order > 0 then CalcCoheff();
end;

constructor TCustomBlackmanHarris.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FA1 := 0.35875;
  FA2 := 0.48829;
  FA3 := 0.14128;
  FA4 := 0.01168;
end;

destructor TCustomBlackmanHarris.Destroy;
begin
  inherited Destroy;
end;

function TCustomBlackmanHarris.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;

Begin
  result := true;
 try
    OrderHalf := Order div 2;
    for i:= 0 to OrderHalf do
     begin
      W[i]   := A1-A2*cos(2*pi*i/(Order-1))+A3*cos(4*pi*i/(Order-1))+A4*cos(6*pi*i/(Order-1));
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;
 end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinBlackmanHarris]);
end;

initialization
{$ifdef FPC}
 {$I ASWinBlackmanHarris.lrs}
{$endif}

end.
