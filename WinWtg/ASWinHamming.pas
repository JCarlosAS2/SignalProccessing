unit ASWinHamming;

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

  { TCustomWinHamming }

  TCustomWinHamming = class(TWinBase)
  private
    { Private declarations }
    FA1 : Double;
    function GetA1: double;
    procedure SetA1(AValue: double);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcCoheff(): Boolean; override;

    property A1: double  read GetA1 write SetA1;
  published
    { Published declarations }
  end;

  { TWinHamming }

  TWinHamming = class(TCustomWinHamming)
  published
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { Published declarations }
   property A1;
   property Order;
   property Gain;

  end;
procedure Register;

implementation

 {$ifNdef FPC}
{$endif}

{ TWinHamming }

constructor TWinHamming.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinHamming.Destroy;
begin
  inherited Destroy;
end;

{ TCustomWinHamming }
constructor TCustomWinHamming.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
   FA1 := 0.543478261;
end;

destructor TCustomWinHamming.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinHamming.GetA1: double;
begin
   result := FA1;
end;

procedure TCustomWinHamming.SetA1(AValue: double);
begin
     FA1 := AValue;
    if Order > 0 then CalcCoheff();
end;

function TCustomWinHamming.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;

Begin
  result := true;
  try
    OrderHalf := Order div 2;
    for i:= 0 to OrderHalf do
     begin
      W[i]   := A1-(1-A1) *(cos(2*pi*i / (Order-1)));
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;

end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinHamming]);
end;

initialization
{$ifdef FPC}
 {$I ASWinHamming.lrs}
{$endif}

end.
