unit ASWinBohman;

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

    {TCustomWinBohman}

  TCustomWinBohman = class(TWinBase)
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

        {TWinBohman}

  TWinBohman = class(TCustomWinBohman)
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

{ TWinBohman }

constructor TWinBohman.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinBohman.Destroy;
begin
  inherited Destroy;
end;

{ TCustomWinBohman }

constructor TCustomWinBohman.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCustomWinBohman.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinBohman.CalcCoheff: Boolean;
var
 i, OrderHalf : Integer;
 N1Div2, ModnMinusN1Div2, A : Double;
Begin
  result := true;
 try
    //OrderHalf := Order div 2;
   N1Div2 := (Order -1) / 2;

   for i:= 0 to Order - 1 do
     begin
       ModnMinusN1Div2:= abs(i - N1Div2);
       A:= (ModnMinusN1Div2 / N1Div2);
       W[i]   := (1-A) * Cos(Pi*A) + (1/Pi) * sin(Pi*A);
      //W[i]   := ((1-(abs(i-(Order/2)))/(Order)/2)*cos(pi*(abs(i-(Order/2)))/(Order)/2)+(1/pi)*sin(pi*(abs(i-(Order/2)))/(Order)/2));
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;
 end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinBohman]);
end;

initialization
{$ifdef FPC}
 {$I ASWinBohman.lrs}
{$endif}

end.
