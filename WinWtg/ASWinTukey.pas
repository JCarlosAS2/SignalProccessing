unit ASWinTukey;

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
     {TCustomWinTukey}

  TCustomWinTukey = class(TWinBase)
  private
    { Private declarations }
      FA1 : double;
      function GetA1: double;
      procedure SetA1(AValue: double);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Tukey(Avalue:double):double;
    function CalcCoheff(): Boolean; override;
    property A1: double  read GetA1 write SetA1;
  published
    { Published declarations }
  end;

  type
     {TWinTukey}

  TWinTukey = class(TCustomWinTukey)
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

{ TWinTukey }

constructor TWinTukey.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinTukey.Destroy;
begin
  inherited Destroy;
end;

{ TCustomWinTukey }

constructor TCustomWinTukey.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
   FA1:=0.5;
end;

function TCustomWinTukey.GetA1: double;
begin
   result := FA1;
end;

procedure TCustomWinTukey.SetA1(AValue: double);
begin
  FA1 := AValue;
  if Order > 0 then CalcCoheff();
end;

destructor TCustomWinTukey.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinTukey.Tukey(Avalue:double):double;
var
ptukey:double;
i, OrderHalf : Integer;
begin
  OrderHalf := Order div 2;

     if (Avalue>=0) and (Avalue < A1*OrderHalf) then
      ptukey:=0.5*(1+cos(pi*(((2*Avalue)/(Order*A1))-1)));

     if (Avalue>= A1*OrderHalf) and (Avalue < Order*(1-(A1/2))) then
      ptukey:=1;

     if (Avalue >= Order*(1-(A1/2))) and (Avalue < Order) then
     ptukey:=0.5*(1+cos(pi*(((2*Avalue)/(Order*A1))-(2/A1)+1)));

     result:=ptukey;

end;


function TCustomWinTukey.CalcCoheff: Boolean;
var
i, OrderHalf : Integer;
begin
  result := true;
  try
    OrderHalf := Order div 2;
   for i:= 0 to ((Order-1) div 2) do
    begin
    W[i]   := Tukey(i);
    W[Order - i-1] := W[i];
    end;
  except Begin
           result := false;
         End;
  end;
end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinTukey]);
end;

initialization
{$ifdef FPC}
 {$I ASWinTukey.lrs}
{$endif}

end.
