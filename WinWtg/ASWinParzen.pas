unit ASWinParzen;

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
  ASWinBase,math;

type

    {TCustomWinParzen}

  TCustomWinParzen = class(TWinBase)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcCoheff(): Boolean; override;
    function Parzen(avalue:double):double;

  published
    { Published declarations }
  end;

  type

      {TWinParzen}

  TWinParzen = class(TCustomWinParzen)
  Public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }
    property Order;
    property Gain;
  end;

procedure Register;

implementation

{$ifNdef FPC}
{$endif}

{ TWinParzen }

constructor TWinParzen.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinParzen.Destroy;
begin
  inherited Destroy;
end;

{ TCustomWinParzen }

constructor TCustomWinParzen.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCustomWinParzen.Destroy;
begin
  inherited Destroy;
end;


function TCustomWinParzen.Parzen(avalue: double): double;
var
  pParzen:double;

begin

     if (avalue >= 0) and (avalue <= Order/4) then
     pParzen:= 1-6*(sqr(avalue /(Order/2))*(1-(avalue/(Order/2))))
     else
     if (avalue > Order/4) and (avalue <= Order/2)then
     pParzen:=2 * power(1-(avalue/(Order/2)),3);

     Result:=1-pParzen;

end;


function TCustomWinParzen.CalcCoheff: Boolean;
var
  i,OrderHalf  : Integer;
begin
    result := true;
  try
    OrderHalf := Order div 2;
   for i:= 0 to OrderHalf do
     begin
      W[i]   := Parzen(i);
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;
end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinParzen]);
end;

initialization
{$ifdef FPC}
 {$I ASWinParzen.lrs}
{$endif}

end.
