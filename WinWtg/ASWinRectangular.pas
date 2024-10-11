unit ASWinRectangular;

{$ifdef FPC}
  {$MODE delphi}{$H+}
{$endif}

interface

uses
  Classes, SysUtils,
  {$ifdef FPC}
  LResources,
  {$endif}
//  Forms, Controls, Graphics, Dialogs,
  ASWinBase;

type

  { TCustomWinRectangular }

  TCustomWinRectangular = class(TWinBase)
  private
    { Private declarations }
    FRA1 : Double;
    function GetRA1: double;
    procedure SetRA1(AValue: double);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcCoheff(): Boolean; override;

    property RA1: double  read GetRA1 write SetRA1;
  published
    { Published declarations }

  end;


  { TWinRectangular }

  TWinRectangular = class(TCustomWinRectangular)
  published
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { Published declarations }
   property RA1;
   property Order;
   property Gain;

  end;

procedure Register;

implementation

 {$ifNdef FPC}
{$endif}

//******************************************************************************
{ TWinRectangular }
//******************************************************************************
constructor TWinRectangular.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinRectangular.Destroy;
begin
  inherited Destroy;
end;

//******************************************************************************
{ TCustomWinRectangular }
//******************************************************************************
constructor TCustomWinRectangular.Create(AOwner: TComponent);
begin
   inherited create(AOwner);
   FRA1:=1;
end;

function TCustomWinRectangular.GetRA1: double;
begin
  result := FRA1;
end;

procedure TCustomWinRectangular.SetRA1(AValue: double);
begin
  FRA1 := AValue;
  if Order > 0 then CalcCoheff();
end;

destructor TCustomWinRectangular.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinRectangular.CalcCoheff: Boolean;
var
  i : Integer;
begin
    result := true;
  try
    for i:= 0 to ((Order-1) div 2) do
     begin
      W[i]   := FRA1;
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;
end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinRectangular]);
end;

initialization
{$ifdef FPC}
 {$I ASWinRectangular.lrs}
{$endif}

end.
