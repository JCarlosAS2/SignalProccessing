unit ASWinKaiser;

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
  ASWinBase,math;

type

   {TCustomWinKaiser}

  TCustomWinKaiser = class(TWinBase)
  private
    { Private declarations }
  FRipple:Double;
  FTW:Double;
  function GetRipple: double;
  procedure SetRipple(AValue: double);
  function GetTW: double;
  procedure SetTW(AValue: double);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CalcCoheff(): Boolean; override;
    function CalcParametrosKaiser():double;
    function Io(x:double): Double;
    function Calcfactorial(Avalue : integer) : int64;//QWord;

    property Ripple: double  read GetRipple write SetRipple;
    property TW: double  read GetTW write SetTW;
  published
    { Published declarations }
  end;


  type

       {TWinKaiser}

  TWinKaiser = class(TCustomWinKaiser)

  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
    { Published declarations }

    property Order;
    property Ripple;
    property TW;
    property Gain;

  end;
procedure Register;

implementation

{$ifNdef FPC}
{$endif}

{ TWinKaiser }

constructor TWinKaiser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinKaiser.Destroy;
begin
  inherited Destroy;
end;

{ TCustomWinKaiser }

function TCustomWinKaiser.GetRipple: double;
begin
   result := FRipple;
end;

procedure TCustomWinKaiser.SetRipple(AValue: double);
begin
   FRipple:= AValue;
   if Order > 0 then CalcCoheff();
end;

function TCustomWinKaiser.GetTW: double;
begin
    result := FTW;
end;

procedure TCustomWinKaiser.SetTW(AValue: double);
begin
   FTW:= AValue;
   if Order > 0 then CalcCoheff();
end;

constructor TCustomWinKaiser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCustomWinKaiser.Destroy;
begin
  inherited Destroy;
end;
function TCustomWinKaiser.Calcfactorial(Avalue: integer): int64;
var
 numero,cota:Int64;
 contador:integer;
begin

  contador:=1;
  numero:=1;
  cota:=Avalue;
  repeat
    numero:=numero*contador;
    contador:=contador+1;
  until  contador>cota;

  Result:=numero;

end;

function TCustomWinKaiser.CalcParametrosKaiser(): double;
var
pBeta :Double;
 windowLength,Aa,M: integer;

begin

  Aa:=40;



 windowLength := M + 1;


 if Aa <= 21 then
 pBeta:= 0.0;
 if (Aa > 21) and (Aa < 50) then
 pBeta := 0.5842 * power(Aa-21,0.4) + 0.07886 * (Aa-21);
 if Aa >= 50 then
 pBeta := 0.1102 * (Aa-8.7);

 result:=pBeta;

end;


function TCustomWinKaiser.Io(x: double): Double; //arreglarlo
var
   i,resultado,CalFac : integer;
   x_2,num,num1: Double;
   fact:int64;
 begin

 x_2 := x/2;
 num1 := 1;
 CalFac :=1;
 resultado := 1;

 for i:=1 to 20 do
 begin
 num := num1 * x_2 * x_2;
 fact := CalFac * Calcfactorial(CalFac);
 //resultado += num / (fact * fact);

 result:=resultado + num / (fact * fact);
 end;
 end;

function TCustomWinKaiser.CalcCoheff: Boolean;
var

 i, OrderHalf : Integer;
 x,x1,beta,Alpha:double;
Begin
  result := true;
  try
    beta:=CalcParametrosKaiser();
    Alpha:=2;
    OrderHalf := Order div 2;
    for i:= 0 to ((Order-1) div 2) do
     begin

      x:=((pi*Alpha)*(1-(sqr((2*i)/(Order-1)-1))));
      x1:=pi*Alpha;
      W[i] := Io(x)/Io(x1);
      W[Order - i-1] := W[i];
     end;
  except Begin
           result := false;
         End;
   end;
end;

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinKaiser]);
end;

initialization
{$ifdef FPC}
 {$I ASWinKaiser.lrs}
{$endif}

end.

