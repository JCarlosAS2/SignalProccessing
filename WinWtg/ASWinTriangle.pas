unit ASWinTriangle;

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

  { TCustomWinTriangle }

  TCustomWinTriangle = class(TWinBase)
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

  { TWinTriangle }

  TWinTriangle = class(TCustomWinTriangle)
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Published declarations }

    property Order;
    property Gain;

  end;

procedure Register;

implementation

{$ifNdef FPC}
{$endif}

//******************************************************************************
{ TWinTriangle }
//******************************************************************************
constructor TWinTriangle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinTriangle.Destroy;
begin
  inherited Destroy;
end;

//******************************************************************************
{ TCustomWinTriangle }
//******************************************************************************
constructor TCustomWinTriangle.Create(AOwner: TComponent);
begin
     inherited create(AOwner);
end;

destructor TCustomWinTriangle.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinTriangle.CalcCoheff: Boolean;
var
  i  : Integer;
begin
    result := true;
  try
    for i:= 0 to ((Order-1) div 2) do
     begin
      W[i]   := (2*i) / (Order -1);
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;
end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinTriangle]);
end;

initialization
{$ifdef FPC}
 {$I ASWinTriangle.lrs}
{$endif}

end.
