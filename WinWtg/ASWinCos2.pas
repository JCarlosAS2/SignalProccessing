unit ASWinCos2;

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

  { TCustomWinCos2 }

  TCustomWinCos2 = class(TWinBase)
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

  { TWinCos2 }

  TWinCos2 = class(TCustomWinCos2)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
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

//******************************************************************************
{ TCustomWinCos2 }
//******************************************************************************
constructor TCustomWinCos2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCustomWinCos2.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinCos2.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;

Begin
  result := true;
  try
    OrderHalf := Order div 2;
    for i:= 0 to OrderHalf do
     begin
      W[i]   := sqr(cos(pi*(i-Order/2)/Order));
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
   end;

end;
//******************************************************************************

//******************************************************************************
{ TWinCos2 }
//******************************************************************************
constructor TWinCos2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinCos2.Destroy;
begin
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinCos2]);
end;

initialization
{$ifdef FPC}
 {$I ASWinCos2.lrs}
{$endif}
end.
