unit ASWinHanning;

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

  { TCustomWinHanning }

  TCustomWinHanning = class(TWinBase)
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

  { TWinHanning }

  TWinHanning = class(TCustomWinHanning)
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


{ TWinHanning }

constructor TWinHanning.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinHanning.Destroy;
begin
  inherited Destroy;
end;

{ TCustomWinHanning }
constructor TCustomWinHanning.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FA1 := 0.5;
end;

destructor TCustomWinHanning.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinHanning.GetA1: double;
begin
   result := FA1;
end;

procedure TCustomWinHanning.SetA1(AValue: double);
begin
    FA1:= AValue;
    if Order > 0 then CalcCoheff();
end;

function TCustomWinHanning.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;

Begin
  result := true;
  try
    OrderHalf := Order div 2;
    for i:= 0 to OrderHalf do
     begin
      W[i]   := A1-(A1 *(cos(2*pi*i / (Order-1))));  // HNAlpha+(1-HNAlpha)*cos(2*pi*(i-Order/2)/Order);

      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;

end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinHanning]);
end;

initialization
{$ifdef FPC}
 {$I ASWinHanning.lrs}
{$endif}

end.
