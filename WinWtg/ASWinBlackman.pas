unit ASWinBlackman;

{$ifdef FPC}
  {$MODE delphi}{$H+}
{$endif}

interface

uses
  Classes, SysUtils,
  {$ifdef FPC}
  LResources,
  {$endif}
  //Forms, Controls, Graphics, Dialogs,
  ASWinBase;


type

  { TCustomWinBlackman }

  TCustomWinBlackman = class(TWinBase)
  private
    { Private declarations }
    FA1 : double;       {  coheficientes de Blackman }
    FA2 : double;
    FA3 : double;
    function GetA1: double;
    procedure SetA1(AValue: double);
    function GetA2: double;
    procedure SetA2(AValue: double);
    function GetA3: double;
    procedure SetA3(AValue: double);
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

  published
    { Published declarations }
  end;

type

  TWinBlackman = class(TCustomWinBlackman)

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }

    property  A1;
    property  A2;
    property  A3;
    property  Order;
    property  Gain;

  end;

procedure Register;

implementation

 {$ifNdef FPC}
{$endif}

 //******************************************************************************
{ TWinBlackman}
//******************************************************************************
constructor TWinBlackman.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinBlackman.Destroy;
begin
  inherited Destroy;
end;

//******************************************************************************
{ TCustomWinBlackman }
//******************************************************************************

function TCustomWinBlackman.GetA1: double;
begin
    result := FA1;
end;

procedure TCustomWinBlackman.SetA1(AValue: double);
begin
   FA1:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomWinBlackman.GetA2: double;
begin
     result := FA2;
end;

procedure TCustomWinBlackman.SetA2(AValue: double);
begin
   FA2:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomWinBlackman.GetA3: double;
begin
     result := FA3;
end;

procedure TCustomWinBlackman.SetA3(AValue: double);
begin
    FA3:= AValue;
   if Order > 0 then CalcCoheff();
end;

constructor TCustomWinBlackman.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FA1 := 0.42659;
  FA2 := 0.49656;
  FA3 := 0.076848;
end;

destructor TCustomWinBlackman.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinBlackman.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;

Begin
  result := true;
 try
    OrderHalf := Order div 2;
    for i:= 0 to OrderHalf do
     begin
      W[i]   := A1-A2*cos(2*pi*i/(Order-1))+A3*cos(4*pi*i/(Order-1));

      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;
 end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinBlackman]);
end;

initialization
{$ifdef FPC}
 {$I ASWinBlackman.lrs}
{$endif}

end.

