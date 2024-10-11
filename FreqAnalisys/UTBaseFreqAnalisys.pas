{*********************************************************}
{                                                         }
{         AntillaSoft Signal Processing Component         }
{                Frequency Analysis Components            }
{                                                         }
{*********************************************************}

{*********************************************************}
{    Copyright (c) 2005-2012 AntillaSoft                  }
{                                                         }
{ License Agreement:                                      }
{                                                         }
{ This library is distributed AS IS, with the hope that   }
{ it will be useful, but WITHOUT ANY WARRANTY; without    }
{ even the implied warranty of MERCHANTABILITY or FITNESS }
{ FOR A PARTICULAR PURPOSE.                               }
{                                                         }
{ Please read the file License.txt before use this        }
{ Component.                                              }
{                                                         }
{ The project web site is located on:                     }
{   http://www.antillasoft.com                            }
{                                                         }
{                          AntillaSoft Development Group. }
{*********************************************************}
unit UTBaseFreqAnalisys;

{$ifdef FPC}
 {$MODE delphi}{$H+}
{$endif}

interface

uses
  Classes, SysUtils, Msg
  ,ASWinBase
  ;

type

  TDataFreqAnalizeType = Double;

  const
  defFFTSize = 1024;
  MaxDouble   : extended = 1.7e308;

type
  TArray1D  = array[1..1] of TDataFreqAnalizeType;
  ELoCompError = class(Exception);
  NoWeightingWindowSpecified = class(Exception);


  { TBaseFreqAnalisys }

  TBaseFreqAnalisys = class (TComponent)
  private
      FMaxReal       : TDataFreqAnalizeType;
      FMaxImag       : TDataFreqAnalizeType;
      FMinReal       : TDataFreqAnalizeType;
      FMinImag       : TDataFreqAnalizeType;
      FMaxPower      : TDataFreqAnalizeType;
      FMaxMagni      : TDataFreqAnalizeType;
      function  GetRealVal(ix: integer): TDataFreqAnalizeType;
      function  GetRealWav (ix: integer): TDataFreqAnalizeType;
    //  procedure SetRealVal (ix: integer; v: TDataFreqAnalizeType);
      procedure SetRealWav (ix: integer; v: TDataFreqAnalizeType);
      function  GetImagVal(ix: integer): TDataFreqAnalizeType;
      procedure SetImagVal (ix: integer; v: TDataFreqAnalizeType);
      function  GetPowerSpec (ix: integer): TDataFreqAnalizeType;
    //  function  GetMagnitude (ix: integer): TDataFreqAnalizeType;
      function  GetFSerSin (n: integer): TDataFreqAnalizeType;
      function  GetFSerCos (n: integer): TDataFreqAnalizeType;
      function  GetPhase (ix: integer): TDataFreqAnalizeType;
      function  GetMaxPower: TDataFreqAnalizeType;
      function  GetMaxMagni: TDataFreqAnalizeType;
      function  GetMaxReal: TDataFreqAnalizeType;
      function  GetMaxImag: TDataFreqAnalizeType;
      function  GetMinReal: TDataFreqAnalizeType;
      function  GetMinImag: TDataFreqAnalizeType;
      procedure CalcMaxValues;
    protected
      function GetMagnitude(ix: integer): TDataFreqAnalizeType;virtual;
      procedure SetRealVal(ix: integer; v: TDataFreqAnalizeType);virtual;
    public
      FNumData       : longint;      { size of data array, must be 2^n }
      FData          : pointer;
      FWgtWin        : TWinBase;  //TFastFourierWgtWin;
      MaxValuesValid : boolean;


      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      property  RealSpec[ix: integer]: TDataFreqAnalizeType read GetRealVal write SetRealVal;
      property  ImagSpec[ix: integer]: TDataFreqAnalizeType read GetImagVal write SetImagVal;
      property  RealWavel[ix:integer] : TDataFreqAnalizeType read GetRealWav write SetRealWav;
      procedure Clear;
      procedure ClearWav;
      procedure ClearImag;
      procedure ClearReal;
      procedure Transform; virtual; abstract;
      procedure InverseTransform;virtual; abstract;
      property  PowerSpec[ix: integer]: TDataFreqAnalizeType read GetPowerSpec;
      function  RMS (FirstIx, LastIx: integer): TDataFreqAnalizeType;
      property  Magnitude[ix: integer]: TDataFreqAnalizeType read GetMagnitude;
      property  FourSerSinCoeff[n: integer]: TDataFreqAnalizeType read GetFSerSin;
      property  FourSerCosCoeff[n: integer]: TDataFreqAnalizeType read GetFSerCos;
      property  Phase[ix: integer]: TDataFreqAnalizeType read GetPhase;
      property  PowerMax: TDataFreqAnalizeType read GetMaxPower;
      property  MagniMax: TDataFreqAnalizeType read GetMaxMagni;
      property  RealMax: TDataFreqAnalizeType read GetMaxReal;
      property  ImagMax: TDataFreqAnalizeType read GetMaxImag;
      property  RealMin: TDataFreqAnalizeType read GetMinReal;
      property  ImagMin: TDataFreqAnalizeType read GetMinImag;
      property  DataBuffer: pointer read FData;
      procedure SetNumData(ndata: longint);Virtual;
      procedure SetWgtWin (AValue: TWinBase);//(ww: TFastFourierWgtWin);


    published
      property  SpectrumSize: longint read FNumData write SetNumData;
      property WgtWin: TWinBase  read FWgtWin write SetWgtWin default nil;

  end;

implementation


constructor TBaseFreqAnalisys.Create(AOwner: TComponent);
var
  sz, i  : integer;
  cntBit : integer;

begin
inherited Create (AOwner);

MaxValuesValid := False;
sz := DefFFTsize;
cntbit := 0;                           { check that size equals 2^n }
for i:=1 to 16 do
  begin
  if (sz and $0001) = $0001 then
    inc (cntBit);
  sz := sz shr 1;
  end;
if cntbit <> 1 then  raise ELocompError.Create (powerof2);
FNumData := defFFTSize;
GetMem (FData, 2*FNumData*SizeOf(TDataFreqAnalizeType));
if (FData = NIL) then  raise ELocompError.Create (notmemory);
fillchar (FData^, 2*FNumData*SizeOf(TDataFreqAnalizeType), 0);
FWgtWin := nil; //fwRectangle;
end;


destructor TBaseFreqAnalisys.Destroy;
begin
if FData <> NIL then
  //FreeMem (FData, 2*FNumData*SizeOf(FNumData));
  try

   {$ifdef FPC}
    FreeMem (FData, MemSize(FData)); //Usando Lazarus
   {$ELSE}
    FreeMem (FData); //Usando Delphi
   {$endif}
  except Begin
           //Por ahora no hacer nada.
           //For now no do it any thing.
           FData := FData;
         end;
  end;


FData := NIL;
inherited Destroy;
end;

function TBaseFreqAnalisys.GetRealVal (ix: integer): TDataFreqAnalizeType;
begin
if (FData <> NIL) and
   (ix >= 1) and (ix <= FNumData)
  then GetRealVal := TArray1D(FData^)[2*ix-1]
  else GetRealVal := 0;
end;

function TBaseFreqAnalisys.GetRealWav (ix: integer): TDataFreqAnalizeType;
begin
if (FData <> NIL) and
   (ix >= 0) and (ix <= FNumData)
  then GetRealWav := TArray1D(FData^)[ix]
  else GetRealWav := 0;
end;

function TBaseFreqAnalisys.GetImagVal (ix: integer): TDataFreqAnalizeType;
begin
if (FData <> NIL) and
   (ix >= 1) and (ix <= FNumData)
  then GetImagVal := TArray1D(FData^)[2*ix]
  else GetImagVal := 0;
end;

procedure TBaseFreqAnalisys.SetRealVal (ix: integer; v: TDataFreqAnalizeType);
begin
if (FData <> NIL) and
   (ix >= 1) and (ix <= FNumData) then
  begin
  TArray1D(FData^)[2*ix-1] := v;
  MaxValuesValid := False;
  end;
end;

procedure TBaseFreqAnalisys.SetRealWav (ix: integer; v: TDataFreqAnalizeType);
begin
if (FData <> NIL) and
   (ix >= 0) and (ix <= FNumData) then
  begin
  TArray1D(FData^)[ix] := v;
  end;
end;

procedure TBaseFreqAnalisys.SetImagVal (ix: integer; v: TDataFreqAnalizeType);
begin
if (FData <> NIL) and
   (ix >= 1) and (ix <= FNumData) then
  begin
  TArray1D(FData^)[2*ix] := v;
  MaxValuesValid := False;
  end;
end;

procedure TBaseFreqAnalisys.SetWgtWin(AValue: TWinBase); //(ww: TFastFourierWgtWin);
begin
if FWgtWin = Avalue then exit;
if (FData <> NIL)
   then Begin
         FWgtWin := AValue;
         FWgtWin.Order:=SpectrumSize;
   end;

end;

procedure TBaseFreqAnalisys.SetNumData (ndata: longint);
var
  sz, i, j, cntbit : integer;
  DBG, i2ToN : LongInt;

begin
DBG := ndata;
if (FData <> NIL) then
  begin
  sz := ndata;
  cntbit := 0;                           { check that size equals 2^n }
  for i:=1 to 24 do
    begin
    if (sz and $0001) = $0001 then
      inc (cntBit);
    sz := sz shr 1;
    end;
  if cntbit <> 1
     then Begin
            //raise ELocompError.Create (powerof2);
            i2ToN := 1;
            While i2ToN < nData  do   //if Size <> 2^n  calculate the next 2^n value
              i2ToN := 2 * i2ToN;

              nData := i2ToN;       // nData = Next  2^n  after nData
         end;


  FreeMem (FData, 2*FNumData*SizeOf(TDataFreqAnalizeType));
  FNumData := ndata;
  GetMem (FData, 2*FNumData*SizeOf(TDataFreqAnalizeType));
  if (FData = NIL) then
    raise ELocompError.Create (notmemory);
  fillchar (FData^, 2*FNumData*SizeOf(TDataFreqAnalizeType),0);
  MaxValuesValid := False;
  if Assigned(FWgtWin) then FWgtWin.Order:=SpectrumSize;
  end;
end;

function TBaseFreqAnalisys.GetPowerSpec (ix: integer): TDataFreqAnalizeType;
var
  reslt : TDataFreqAnalizeType;

begin
reslt := 0;
if (FData <> NIL) and
   (ix >= 0) and (ix <= (FNumData div 2)) then
  begin
  if ix = 0
    then reslt := (sqr(TArray1D(FData^)[2*ix+1]) +
                   sqr(TArray1D(FData^)[2*ix+2]))
    else reslt := (sqr(TArray1D(FData^)[2*ix+1]) +
                   sqr(TArray1D(FData^)[2*ix+2]) +
                   sqr(TArray1D(FData^)[2*(FNumData-ix+1)-1]) +
                   sqr(TArray1D(FData^)[2*(FNumData-ix+1)]));
  end;
GetPowerSpec := reslt/FNumData;
end;

function TBaseFreqAnalisys.GetMaxPower: TDataFreqAnalizeType;
begin
if not MaxValuesValid then
  begin
  CalcMaxValues;
  MaxValuesValid := true;
  end;
GetMaxPower := FMaxPower
end;

function TBaseFreqAnalisys.RMS (FirstIx, LastIx: integer): TDataFreqAnalizeType;
var
  sum    : TDataFreqAnalizeType;
  idummy : integer;
  i      : integer;

begin
if FirstIx < 0 then
  FirstIx := 0;
if FirstIx > (FNumData div 2) then
  FirstIx := FNumData div 2;
if LastIx < 0 then
  LastIx := 0;
if LastIx > (FNumData div 2) then
  LastIx := FNumData div 2;
if LastIx < FirstIx then
  begin
  idummy := LastIx;
  LastIx := FirstIx;
  FirstIx := idummy;
  end;
sum := 0;
for i:=FirstIx to LastIx do
  begin
  if i = 0
    then sum := sum + sqr(TArray1D(FData^)[2*i+1]) + sqr(TArray1D(FData^)[2*i+2])
    else sum := sum + sqr(TArray1D(FData^)[2*i+1]) +
                      sqr(TArray1D(FData^)[2*i+2]) +
                      sqr(TArray1D(FData^)[2*(FNumData-i+1)-1]) +
                      sqr(TArray1D(FData^)[2*(FNumData-i+1)]);
  end;
RMS := sqrt(sum)/FNumData;
end;

function TBaseFreqAnalisys.GetMaxMagni: TDataFreqAnalizeType;
begin
if not MaxValuesValid then
  begin
  CalcMaxValues;
  MaxValuesValid := true;
  end;
GetMaxMagni := FMaxMagni;
end;

function TBaseFreqAnalisys.GetMagnitude (ix: integer): TDataFreqAnalizeType;
var
  reslt : TDataFreqAnalizeType;

begin
reslt := 0;
if (FData <> NIL) then
  begin
  if ix = 0
    then reslt := sqrt(sqr(TArray1D(FData^)[1])+sqr(TArray1D(FData^)[ix+2])) { mag[0] = a0 }
    else begin
         if (ix >= 1) and (ix <= (FNumData div 2)) then
           reslt := sqrt(sqr(TArray1D(FData^)[2*ix+1] + TArray1D(FData^)[2*(FNumData-ix+1)-1])+
                         sqr(TArray1D(FData^)[2*ix+2] - TArray1D(FData^)[2*(FNumData-ix+1)]));
         end;
  end;
GetMagnitude := reslt/FNumData;
end;

function TBaseFreqAnalisys.GetFSerSin (n: integer): TDataFreqAnalizeType;
var
  reslt : TDataFreqAnalizeType;

begin
reslt := 0;
if (FData <> NIL) then
  begin
  inc (n);
  if (n >= 2) and (n <= (FNumData div 2)+1) then
    reslt := (TArray1D(FData^)[2*n] - TArray1D(FData^)[2*(FNumData-n+2)]);
  end;
GetFSerSin := reslt/FNumData;
end;

function TBaseFreqAnalisys.GetFSerCos (n: integer): TDataFreqAnalizeType;
var
  reslt : TDataFreqAnalizeType;

begin
reslt := 0;
if (FData <> NIL) then
  begin
  inc (n);
  if n = 1
    then reslt := TArray1D(FData^)[1]
    else begin
         if (n >= 2) and (n <= (FNumData div 2)+1) then
           reslt := TArray1D(FData^)[2*n-1] + TArray1D(FData^)[2*(FNumData-n+2)-1];
         end;
  end;
GetFSerCos := reslt/FNumData;
end;

function TBaseFreqAnalisys.GetPhase (ix: integer): TDataFreqAnalizeType;
const
  PiH  = 1.570796326794896619231;

var
  reslt : TDataFreqAnalizeType;

begin
reslt := 0;
if (FData <> NIL) and (ix >= 1) and (ix <= (FNumData div 2)) then
  begin
  if (TArray1D(FData^)[2*ix+1] <> 0)   { phase = arctan(im/real) }
    then reslt := arctan((TArray1D(FData^)[2*ix+2])/(TArray1D(FData^)[2*ix+1]))
    else if (TArray1D(FData^)[2*ix+2] > 0)
           then reslt := PiH
           else reslt := -PiH;
  end;
GetPhase := reslt;
end;

function TBaseFreqAnalisys.GetMaxReal: TDataFreqAnalizeType;
begin
if not MaxValuesValid then
  begin
  CalcMaxValues;
  MaxValuesValid := true;
  end;
GetMaxReal := FMaxReal;
end;

function TBaseFreqAnalisys.GetMaxImag: TDataFreqAnalizeType;
begin
if not MaxValuesValid then
  begin
  CalcMaxValues;
  MaxValuesValid := true;
  end;
GetMaxImag := FMaxImag;
end;

function TBaseFreqAnalisys.GetMinReal: TDataFreqAnalizeType;
begin
if not MaxValuesValid then
  begin
  CalcMaxValues;
  MaxValuesValid := true;
  end;
GetMinReal := FMinReal;
end;

function TBaseFreqAnalisys.GetMinImag: TDataFreqAnalizeType;
begin
if not MaxValuesValid then
  begin
  CalcMaxValues;
  MaxValuesValid := true;
  end;
GetMinImag := FMinImag;
end;

procedure TBaseFreqAnalisys.Clear;
var
  i : integer;

begin
for i:=1 to FNumData do
  begin
  TArray1D(FData^)[2*i-1] := 0;
  TArray1D(FData^)[2*i] := 0;
  end;
MaxValuesValid := False;
end;

procedure TBaseFreqAnalisys.ClearWav;
var
  i : integer;

begin
for i:=0 to FNumData do
  begin
  TArray1D(FData^)[i] := 0;
  end;
MaxValuesValid := False;
end;






procedure TBaseFreqAnalisys.CalcMaxValues;
var
  i   : integer;
  pw  : TDataFreqAnalizeType;
  mag : TDataFreqAnalizeType;

begin
FMaxPower := 0;
FMaxMagni := 0;
FMaxReal := -MaxDouble;
FMaxImag := -MaxDouble;
FMinReal := MaxDouble;
FMinImag := MaxDouble;
for i:=1 to FNumData do
  begin
  if TArray1D(FData^)[2*i] > FMaxImag then
    FMaxImag := TArray1D(FData^)[2*i];
  if TArray1D(FData^)[2*i-1] > FMaxReal then
    FMaxReal := TArray1D(FData^)[2*i-1];
  if TArray1D(FData^)[2*i] < FMinImag then
    FMinImag := TArray1D(FData^)[2*i];
  if TArray1D(FData^)[2*i-1] < FMinReal then
    FMinReal := TArray1D(FData^)[2*i-1];
  end;

FMaxPower := 0;
for i:=2 to (FNumData div 2) do
  begin
  pw := sqr(TArray1D(FData^)[2*i-1]) +
        sqr(TArray1D(FData^)[2*i]) +
        sqr(TArray1D(FData^)[2*(FNumData-i+2)-1]) +
        sqr(TArray1D(FData^)[2*(FNumData-i+2)]);
  if pw > FMaxPower then
    FMaxPower := pw;
  end;
FMaxPower := FMaxPower/FNumData;

FMaxMagni := 0;
for i:=2 to (FNumData div 2) + 1 do
  begin
  mag := sqrt(sqr(TArray1D(FData^)[2*i-1] + TArray1D(FData^)[2*(FNumData-i+2)-1])+
              sqr(TArray1D(FData^)[2*i] - TArray1D(FData^)[2*(FNumData-i+2)]));
  if mag > FMaxMagni then
    FMaxMagni := mag;
  end;
FMaxMagni := FMaxMagni / FNumData;
end;

procedure TBaseFreqAnalisys.ClearReal;
var
  i : integer;

begin
for i:=1 to FNumData do
  TArray1D(FData^)[2*i-1] := 0;
MaxValuesValid := False;
end;

procedure TBaseFreqAnalisys.ClearImag;
var
  i : integer;

begin
for i:=1 to FNumData do
  TArray1D(FData^)[2*i] := 0;
MaxValuesValid := False;
end;


end.

