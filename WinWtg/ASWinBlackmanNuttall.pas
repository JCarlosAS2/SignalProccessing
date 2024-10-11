unit ASWinBlackmanNuttall;

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
      {TCustomWinBlackmanNuttall}

  TCustomWinBlackmanNuttall = class(TWinBase)
  private
    { Private declarations }
    FBNA0 : double;
    FBNA1 : double;       {  coheficientes de BlackmanNuttall }
    FBNA2 : double;
    FBNA3 : double;
    function GetBNA0: double;
    procedure SetBNA0(AValue: double);
    function GetBNA1: double;
    procedure SetBNA1(AValue: double);
    function GetBNA2: double;
    procedure SetBNA2(AValue: double);
    function GetBNA3: double;
    procedure SetBNA3(AValue: double);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcCoheff(): Boolean; override;

    property BNA0: double  read GetBNA1 write SetBNA0;
    property BNA1: double  read GetBNA1 write SetBNA1;
    property BNA2: double  read GetBNA2 write SetBNA2;
    property BNA3: double  read GetBNA3 write SetBNA3;
  published
    { Published declarations }
  end;


  type
       {TWinBlackmanNuttall}

  TWinBlackmanNuttall = class(TCustomWinBlackmanNuttall)
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }

    property  BNA0;
    property  BNA1;
    property  BNA2;
    property  BNA3;
    property  Order;
    property  Gain;
  end;

procedure Register;

implementation

{$ifNdef FPC}
{$endif}

{ TWinBlackmanNuttall }

constructor TWinBlackmanNuttall.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinBlackmanNuttall.Destroy;
begin
  inherited Destroy;
end;

{ TCustomWinBlackmanNuttall }

function TCustomWinBlackmanNuttall.GetBNA0: double;
begin
   Result:=FBNA0;
end;

procedure TCustomWinBlackmanNuttall.SetBNA0(AValue: double);
begin
  FBNA0:=AValue;
  if Order > 0 then CalcCoheff();
end;

function TCustomWinBlackmanNuttall.GetBNA1: double;
begin
  Result:=FBNA1;
end;

procedure TCustomWinBlackmanNuttall.SetBNA1(AValue: double);
begin
   FBNA1:=AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomWinBlackmanNuttall.GetBNA2: double;
begin
   Result:=FBNA2;
end;

procedure TCustomWinBlackmanNuttall.SetBNA2(AValue: double);
begin
  FBNA2:=AValue;
  if Order > 0 then CalcCoheff();
end;

function TCustomWinBlackmanNuttall.GetBNA3: double;
begin
  Result:=FBNA3;

end;

procedure TCustomWinBlackmanNuttall.SetBNA3(AValue: double);
begin
   FBNA3:=AValue;
   if Order > 0 then CalcCoheff();
end;

constructor TCustomWinBlackmanNuttall.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBNA0:=0.3635819;
  FBNA1:=0.4891775;
  FBNA2:=0.1365995;
  FBNA3:=0.0106411;
end;

destructor TCustomWinBlackmanNuttall.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinBlackmanNuttall.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;

Begin
  result := true;
 try
    OrderHalf := Order div 2;
    for i:= 0 to OrderHalf do
     begin

      W[i]   := FBNA0-FBNA1*cos(2*pi*i/(Order-1))+FBNA2*cos(4*pi*i/(Order-1))-FBNA3*cos(6*pi*i/(Order-1));
      W[Order - i-1] := W[i];

     end;
  except Begin
           result := false;
         End;
  end;
 end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinBlackmanNuttall]);
end;

initialization
{$ifdef FPC}
 {$I ASWinBlackmanNuttall.lrs}
{$endif}

end.
