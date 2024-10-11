unit UDCT_1;

{$mode objfpc}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,UTBaseFreqAnalisys;


type

  { TDCT }

  TDCT_1 = class(TBaseFreqAnalisys)
  private

   // FNumData: longint;
    procedure DoDCT(isign: integer);
    //
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Transform;override;
    procedure InverseTransform;override;
    function  FreqOfLine(ix: integer; SampleTime: double): double;
    procedure SetRealVal(ix: integer; v: TDataFreqAnalizeType);override;
    function  GetMagnitude(ix: integer): TDataFreqAnalizeType;override;
  published
    property size: longint read FNumData write SetNumData;
  end;

procedure Register;

implementation

uses   MSG, math;

{$R-}

constructor TDCT_1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TDCT_1.Destroy;
begin
  inherited Destroy;
end;

(*********************************************************)
function TDCT_1.FreqOfLine(ix: integer; SampleTime: double): double;
  (*********************************************************)

begin
  if (ix < 1) or (ix > (FNumData div 2)) then
    FreqOfLine := 0
  else
    FreqOfLine := ix / SampleTime / FNumData;
end;

procedure TDCT_1.SetRealVal(ix: integer; v: TDataFreqAnalizeType);
begin
   if (FData <> nil) and (ix >= 1) and (ix <= FNumData) then
  begin
    TArray1D(FData^)[ix ] := v;
    MaxValuesValid := False;

end;

   end;




function TDCT_1.GetMagnitude(ix: integer): TDataFreqAnalizeType;
begin
    Result:= TArray1D(FData^)[ix];
end;

(*********************************************************)
procedure TDCT_1.DoDCT(isign: integer);
(*********************************************************
 the core of this routine is based on a work of Danielson
 and Lanczos, dated back to 1942 (FFT with decimation in
 time)
 *********************************************************)

    var

  arrTMP : array of Double;
  i,j,k,m: Integer;

  pow:Extended;
  m1,summult1,x,aux,mult3,summult,y,y1,mult2,cosres,valorpi, mult, suma:Double;
    begin

     m:=FNumData-1;
     suma:=0;
       m1:=0;
            // try
             SetLength(arrTMP, FNumData );

       // if isign = 1 then
           //   begin
                    for i:=1 to ( FNumData )do
                         begin
                         aux:= TArray1D(FData^)[i];
                         arrTMP[i] :=aux;
                         end ;

                        for j:=1 to (FNumData ) do
                           begin
                               for k:=1 to (FNumData -2) do
                                   begin

                                        valorpi:=pi;
                                        m1:=(valorpi/m);
                                        mult:=m1*(j-1)*k;
                                         cosres:= cos(mult);
                                         x:=arrTMP[k];
                                        mult2 := x*cosres;
                                        suma:=suma + mult2;
                                   end;
                                 y:= arrTMP[1];
                                 y1:=arrTMP[FNumData];
                                 pow:=power((-1),(j-1));
                                 mult3:= pow*y1;
                                 summult:= mult3 + y;
                                 summult1:= 0.5 * summult;
                                 TArray1D (FData^)[j] := summult1+suma;
                                 suma:=0;
                           end;


                SetLength(arrTMP,0)


 end;


{procedure TDCT.SetNumData(AValue: longint);
begin
  if FNumData=AValue then Exit;
  FNumData:=AValue;
end;  }

(*********************************************************)
procedure TDCT_1.Transform;
(*********************************************************
  see: R.J. Higgins, Digital Signal Processing in VLSI,
       Analog Devices, Norwood 1990, page 139
 *********************************************************)
var
  i: integer;

begin
  if FWgtWin = nil then
    raise NoWeightingWindowSpecified.Create(NoWgtWinSpecified);

  for i := 1 to FNumData do
  begin
    TArray1D(FData^)[2 * i - 1] := TArray1D(FData^)[2 * i - 1] * FWgtWin.W[i - 1];
    TArray1D(FData^)[2 * i] := TArray1D(FData^)[2 * i] * FWgtWin.W[i - 1];
  end;

  DoDCT(1);
end;

(*********************************************************)
procedure TDCT_1.InverseTransform;
(*********************************************************)

begin
  DoDCT(-1);
end;


procedure Register;
begin
  RegisterComponents('LazSignalProc', [TDCT_1]);
end;


initialization
{$I Fourier.lrs}

end.



implementation

procedure Register;
begin
  RegisterComponents('LazSignalProc',[TDCT_1]);
end;

end.
