unit ASWinNuttall;

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

     {TCustomWinNuttall}

  TCustomWinNuttall = class(TWinBase)
  private
    { Private declarations }
    FA0 : Double;           {  coheficientes de Nuttall }
    FA1 : Double;
    FA2 : Double;
    FA3 : Double;
    function GetA0: double;
    procedure SetA0(AValue: double);
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

    property A0: double  read GetA0 write SetA0;
    property A1: double  read GetA1 write SetA1;
    property A2: double  read GetA2 write SetA2;
    property A3: double  read GetA3 write SetA3;

  published
    { Published declarations }
  end;


  type

        {TWinNuttall}

    TWinNuttall = class(TCustomWinNuttall)
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }

    property  A0;
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

{ TWinNuttall }

constructor TWinNuttall.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinNuttall.Destroy;
begin
  inherited Destroy;
end;

{ TCustomWinNuttall }

function TCustomWinNuttall.GetA0: double;
begin
    result := FA0;
end;

procedure TCustomWinNuttall.SetA0(AValue: double);
begin
   FA0:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomWinNuttall.GetA1: double;
begin
   result := FA1;
end;

procedure TCustomWinNuttall.SetA1(AValue: double);
begin
   FA1:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomWinNuttall.GetA2: double;
begin
   result := FA2;
end;

procedure TCustomWinNuttall.SetA2(AValue: double);
begin
    FA2:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomWinNuttall.GetA3: double;
begin
    result := FA3;
end;

procedure TCustomWinNuttall.SetA3(AValue: double);
begin
   FA3:= AValue;
   if Order > 0 then CalcCoheff();
end;

constructor TCustomWinNuttall.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FA0 := 0.355768;
  FA1 := 0.487396;
  FA2 := 0.144232;
  FA3 := 0.012604;
end;

destructor TCustomWinNuttall.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinNuttall.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;

Begin
  result := true;
 try
    OrderHalf := Order div 2;
    for i:= 0 to OrderHalf do
     begin
      W[i]   := A0-A1*cos(2*pi*i/(Order-1))+A2*cos(4*pi*i/(Order-1))-A3*cos(6*pi*i/(Order-1));

      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;
 end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinNuttall]);
end;

initialization
{$ifdef FPC}
 {$I ASWinNuttall.lrs}
{$endif}

end.
