unit ASWinPrueba;

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

  { TCustomWinPrueba }

  TCustomWinPrueba = class(TWinBase)
  private

    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CalcCoheff(): Boolean; override;
    //function CalcCoheffPasaAlto: Boolean;
    //function CalcCoheffPasaBajo: Boolean;
    //function CalcCoheffPasaBanda(Wc1, Wc2: Double): Boolean;
  published
    { Published declarations }
  end;

  type

  { TWinPrueba }

  TWinPrueba = class(TCustomWinPrueba)
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
    property  Order;
    property Gain;
  end;
procedure Register;
 {var
 fm,fc1,fc2:Double;}
implementation

{$ifNdef FPC}
  {$R *.dcr}
{$endif}

{ TWinPrueba }

constructor TWinPrueba.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWinPrueba.Destroy;
begin
  inherited Destroy;
end;

{ TCustomWinPrueba }

constructor TCustomWinPrueba.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCustomWinPrueba.Destroy;
begin
  inherited Destroy;
end;

function TCustomWinPrueba.CalcCoheff(): Boolean;
var
i, OrderHalf : Integer;
M,Wc1,z:double;
begin
  result := true;
  try
 //OrderHalf := Order div 2;
     M := (Order -1)/2;
   for i:= 0 to (Order-1)  do
    begin
    Wc1:=pi/4;
    z:= i-M;
    if (i <> M)then
     W[i]:= sin(Wc1*z)/(pi*z)
    else
      W[i]:= (Wc1/pi);
     W[Order - i-1] := W[i];
    end;
  except Begin
           result := false;
         End;
  end;
end;

{function TCustomWinPrueba.CalcCoheffPasaAlto: Boolean;
var
i, OrderHalf : Integer;
M,Wc1,z:double;
begin
  result := true;
  try
 //OrderHalf := Order div 2;
     M := (Order -1)/2;
   for i:= 0 to (Order-1)  do
    begin
    Wc1:=pi/4;
    z:= i-M;
    if (i = M)then
     W[i]:=  1-(Wc1/pi)
    else
      W[i]:= -(sin(Wc1*z)/(pi*z));
     W[Order - i-1] := W[i];
    end;
  except Begin
           result := false;
         End;
  end;
end;
function TCustomWinPrueba.CalcCoheffPasaBajo: Boolean;
var
i, OrderHalf : Integer;
M,Wc,z:double;
begin
  result := true;
  try
 //OrderHalf := Order div 2;
     M := (Order -1)/2;
   for i:= 0 to (Order-1)  do
    begin
    Wc1:=pi/4;
    z:= i-M;
    if (i <> M)then
     W[i]:= sin(Wc1*z)/(pi*z)
    else
      W[i]:= (Wc1/pi);
     W[Order - i-1] := W[i];
    end;
  except Begin
           result := false;
         End;
  end;
end;

{function TCustomWinPrueba.CalcCoheffPasaBanda(Wc1, Wc2: Double): Boolean;
var
i, OrderHalf : Integer;
M,z:double;
begin
  result := true;
  try
 //OrderHalf := Order div 2;
     M := (Order -1)/2;
   for i:= 0 to (Order-1)  do
    begin
    Wc2:=pi/2;
    Wc1:=pi/8;
    z:= i-M;
    if (i <> M)then
     W[i]:=(sin(Wc2*z)/(pi*z))- (sin(Wc1*z)/(pi*z))
   else
    W[i]:= Wc2-Wc1/pi;
     W[Order - i-1] := W[i];
    end;
  except Begin
           result := false;
         End;
  end;
end;

{function TCustomWinPrueba.CalcCoheff: Boolean;
var
i, OrderHalf : Integer;
M,Wc2,Wc1,z:double;
begin
  result := true;
  try
 //OrderHalf := Order div 2;
     M := (Order -1)/2;
   for i:= 0 to (Order-1)  do
    begin
    Wc2:=pi/8;
    Wc1:=pi/4;
    z:= i-M;
    if (i <> M)then
     W[i]:=(sin(Wc1*z)/(pi*z))- (sin(Wc2*z)/(pi*z))
   else
    W[i]:= 1-(Wc2-Wc1/pi);
     W[Order - i-1] := W[i];
    end;
  except Begin
           result := false;
         End;
  end;
end; }

procedure Register;
begin
  RegisterComponents('LazWinWtg',[TWinPrueba]);
end;

initialization
{$ifdef FPC}
{$endif}
end.
