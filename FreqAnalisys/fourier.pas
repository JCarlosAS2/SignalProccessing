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
unit Fourier;

{$O+}
{$F+}


{--------------------------------------------------------------------}
interface
{--------------------------------------------------------------------}

uses
  {$ifdef FPC}
  LResources,
  {$endif}
   classes, UTBaseFreqAnalisys;

type
  
  TFFT = class (TBaseFreqAnalisys)
    private
      procedure DoFFT (isign: integer);
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Transform;
      procedure InverseTransform;
      function  FreqOfLine (ix: integer; SampleTime: double): double;
      published
      property  size: longint read FNumData write SetNumData;

    end;


procedure Register;

{--------------------------------------------------------------------}
implementation
{--------------------------------------------------------------------}

uses
  sysutils, MSG;

{$R-}

constructor TFFT.Create(AOwner: TComponent);
begin
   inherited Create (AOwner);
end;

destructor TFFT.Destroy;
begin
   inherited Destroy;
end;

(*********************************************************)
function TFFT.FreqOfLine (ix: integer; SampleTime: double): double;
(*********************************************************)

begin
if (ix < 1) or (ix > (FNumData div 2))
  then FreqOfLine := 0
  else FreqOfLine := ix/SampleTime/FNumData;
end;

(*********************************************************)
procedure TFFT.DoFFT (isign: integer);
(*********************************************************
 the core of this routine is based on a work of Danielson
 and Lanczos, dated back to 1942 (FFT with decimation in
 time)
 *********************************************************)

var
  ii,jj,mmax,m,j,i  : integer;
  step          : integer;
  wr,wpr,wpi,wi : double;
  phi           : double;
  auxr, auxi    : double;

begin
j := 1;
for ii:= 1 to FNumData do         { shuffle data according to bit reversal }
  begin
  i := 2*ii-1;
  if (j > i) then
    begin
    auxr := TArray1D(FData^)[j];
    TArray1D(FData^)[j] := TArray1D(FData^)[i];
    TArray1D(FData^)[i] := auxr;
    auxr := TArray1D(FData^)[j+1];
    TArray1D(FData^)[j+1] := TArray1D(FData^)[i+1];
    TArray1D(FData^)[i+1] := auxr;
    end;
  m := FNumData;
  while ((m>=2) and (j>m)) do
    begin
    j := j-m;
    m := m div 2;
    end;
  j := j+m;
  end;

mmax := 2;                           { now take the 1-point transforms and }
while 2*FNumData > mmax do             { successively combine them to length FNumData }
  begin
  step := 2*mmax;
  phi := 2*Pi*isign/mmax;
  wpr := -2.0*sqr(sin(0.5*phi));
  wpi := sin(phi);
  wr := 1.0;
  wi := 0.0;
  for ii:=1 to (mmax div 2) do
    begin
    m := 2*ii-1;
    for jj:=0 to ((2*FNumData-m) div step) do
      begin
      i := m+jj*step;
      j := i+mmax;
      auxr := wr*TArray1D(FData^)[j]-wi*TArray1D(FData^)[j+1];
      auxi := wr*TArray1D(FData^)[j+1]+wi*TArray1D(FData^)[j];
      TArray1D(FData^)[j] := TArray1D(FData^)[i]-auxr;
      TArray1D(FData^)[j+1] := TArray1D(FData^)[i+1]-auxi;
      TArray1D(FData^)[i] := TArray1D(FData^)[i]+auxr;
      TArray1D(FData^)[i+1] := TArray1D(FData^)[i+1]+auxi;
      end;
    auxr := wr;
    wr := wr*wpr-wi*wpi+wr;
    wi := wi*wpr+auxr*wpi+wi;
    end;
  mmax := step;
  end;
if isign < 0 then
  for i:=1 to FNumData do         { scale the result for inverse FFT }
    begin
    TArray1D(FData^)[2*i-1] := TArray1D(FData^)[2*i-1]/FNumData;
    TArray1D(FData^)[2*i] := TArray1D(FData^)[2*i]/FNumData;
    end;
MaxValuesValid := False;
end;

(*********************************************************)
procedure TFFT.Transform;
(*********************************************************
  see: R.J. Higgins, Digital Signal Processing in VLSI,
       Analog Devices, Norwood 1990, page 139
 *********************************************************)
var
  i : integer;

begin
 if FWgtWin= nil then raise NoWeightingWindowSpecified.Create (NoWgtWinSpecified);

 for i:=1 to FNumData do
  begin
   TArray1D(FData^)[2*i-1] := TArray1D(FData^)[2*i-1]* FWgtWin.W[i-1];
   TArray1D(FData^)[2*i]   := TArray1D(FData^)[2*i]*  FWgtWin.W[i-1];
  end;

 DoFFT (1);
end;

(*********************************************************)
procedure TFFT.InverseTransform;
(*********************************************************)

begin
DoFFT (-1);
end;


procedure Register;
begin
  RegisterComponents('LazSignalProc',[TFFT]);
end;


initialization

{$ifdef FPC}
  {$I Fourier.lrs}
{$endif}
end.
