unit ASWinFlatTop;

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

   {TCustomFlatTop}

  TCustomFlatTop = class(TWinBase)
  private
    { Private declarations }
    FA1 : double;       {  coheficientes de FlatTop }
    FA2 : double;
    FA3 : double;
    FA4 : double;
    FA5 : double;

    function GetA1: double;
    procedure SetA1(AValue: double);
    function GetA2: double;
    procedure SetA2(AValue: double);
    function GetA3: double;
    procedure SetA3(AValue: double);
    function GetA4: double;
    procedure SetA4(AValue: double);
    function GetA5: double;
    procedure SetA5(AValue: double);
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
    property A5: double  read GetA5 write SetA5;

  published
    { Published declarations }
  end;

  type

      {TWinFlatTop}

  TWinFlatTop = class(TCustomFlatTop)
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
    property  A5;
    property  Order;
    property  Gain;
  end;

procedure Register;

implementation

{$ifNdef FPC}
{$endif}

{ TWinFlatTop }

constructor TWinFlatTop.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinFlatTop.Destroy;
begin
  inherited Destroy;
end;

{ TCustomFlatTop }

function TCustomFlatTop.GetA1: double;
begin
  result := FA1;
end;

procedure TCustomFlatTop.SetA1(AValue: double);
begin
   FA1:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomFlatTop.GetA2: double;
begin
   result := FA2;
end;

procedure TCustomFlatTop.SetA2(AValue: double);
begin
   FA2:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomFlatTop.GetA3: double;
begin
   result := FA3;
end;

procedure TCustomFlatTop.SetA3(AValue: double);
begin
   FA3:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomFlatTop.GetA4: double;
begin
  result := FA4;
end;

procedure TCustomFlatTop.SetA4(AValue: double);
begin
  FA4:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomFlatTop.GetA5: double;
begin
 result := FA5;
end;

procedure TCustomFlatTop.SetA5(AValue: double);
begin
   FA5:= AValue;
   if Order > 0 then CalcCoheff();
end;

constructor TCustomFlatTop.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FA1 := 1;
  FA2 := 1.93;
  FA3 := 1.29;
  FA4 := 0.388;
  FA5 := 0.032;
end;

destructor TCustomFlatTop.Destroy;
begin
  inherited Destroy;
end;

function TCustomFlatTop.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;

Begin
  result := true;
 try
    OrderHalf := Order div 2;
    for i:= 0 to OrderHalf do
     begin
      W[i]   := (A1-A2*cos(2*pi*i/(Order-1))+A3*cos(4*pi*i/(Order-1))-A4*cos(6*pi*i/(Order-1))+A5*cos(8*pi*i/(Order-1)));
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;
 end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinFlatTop]);
end;

initialization
{$ifdef FPC}
 {$I ASWinFlatTop.lrs}
{$endif}

end.
