unit ASWinGauss;

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

  { TCustomWinGauss }

  TCustomWinGauss = class(TWinBase)
  private
    { Private declarations }
     FGA1 : double;  //=3.0;   //Width of Gaussian window
     function GetGA1: Double;
     procedure SetGA1(AValue: Double);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcCoheff(): Boolean; override;

    property GA1: Double  read GetGA1 write SetGA1;
  published
    { Published declarations }

  end;

  { TWinGauss }

  TWinGauss = class(TCustomWinGauss)
    public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    published
    { Published declarations }
    property GA1;
    property Order;
    property Gain;
  end;

procedure Register;

implementation

{$ifNdef FPC}
{$endif}


//******************************************************************************
{ TWinGauss }
//******************************************************************************

constructor TWinGauss.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
end;

destructor TWinGauss.Destroy;
begin
  inherited Destroy;
end;

//******************************************************************************
{ TCustomWinGauss }
//******************************************************************************

function TCustomWinGauss.GetGA1: Double;
begin
  result := FGA1;
end;

procedure TCustomWinGauss.SetGA1(AValue: Double);
begin
  FGA1:= AValue;
  if Order > 0 then CalcCoheff();

end;

constructor TCustomWinGauss.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FGA1 := 3.0;
end;

destructor TCustomWinGauss.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinGauss.CalcCoheff: Boolean;
var
  i : Integer;
begin
  result := true;
  try
    for i:= 0 to ((Order-1) div 2) do
     begin
      W[i]   := exp(-0.5*sqr(GA1 *(i-Order/2)/Order*2));
      W[Order - i -1] := W[i];
     end;
  except Begin
           result := false;
         End;
  end;

end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinGauss]);
end;

initialization
{$ifdef FPC}
 {$I ASWinGauss.lrs}
{$endif}
end.
