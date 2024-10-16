unit ASWinLanczos;

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

  { TCustomWinLanczos }

  TCustomWinLanczos = class(TWinBase)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcCoheff(): Boolean; override;
  published
    { Published declarations }
  end;

  type

  { TWinLanczos }

  TWinLanczos = class(TCustomWinLanczos)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcCoheff(): Boolean; override;
  published
    { Published declarations }
     property  Order;
     property Gain;
  end;
procedure Register;

implementation

 {$ifNdef FPC}
{$endif}

{ TWinLanczos }

constructor TWinLanczos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinLanczos.Destroy;
begin
  inherited Destroy;
end;

function TWinLanczos.CalcCoheff: Boolean;
begin
  Result:=inherited CalcCoheff;
end;

{ TCustomWinLanczos }

constructor TCustomWinLanczos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCustomWinLanczos.Destroy;
begin
  inherited Destroy;
end;

function sinc(Avalue:double):double;
begin
  if avalue = 0 then result:=1
                else result:= sin(pi* Avalue)/(pi* Avalue);
end;

function TCustomWinLanczos.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;
 x: double;

Begin
  result := true;
  try

    OrderHalf := Order div 2;
    for i:= 0 to ((Order-1) div 2) do
     begin
      x:=((2*i)/(Order-1))-1;
      W[i] :=sinc(x);
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
end;
end;

 procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinLanczos]);
end;

initialization
{$ifdef FPC}
 {$I ASWinLanczos.lrs}
{$endif}

end.
