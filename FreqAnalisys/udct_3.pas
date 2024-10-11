unit UDCT_3;

{$mode objfpc}


interface

uses
  LResources, Classes, UTBaseFreqAnalisys;

type

  { TDCT }

  TDCT_3 = class(TBaseFreqAnalisys)
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

uses  SysUtils, MSG, math;

{$R-}

constructor  TDCT_3.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor  TDCT_3.Destroy;
begin
  inherited Destroy;
end;

(*********************************************************)
function  TDCT_3.FreqOfLine(ix: integer; SampleTime: double): double;
  (*********************************************************)

begin
  if (ix < 1) or (ix > (FNumData div 2)) then
    FreqOfLine := 0
  else
    FreqOfLine := ix / SampleTime / FNumData;
end;

procedure  TDCT_3.SetRealVal(ix: integer; v: TDataFreqAnalizeType);
begin
   if (FData <> nil) and (ix >= 1) and (ix <= FNumData) then
  begin
    TArray1D(FData^)[ix ] := v;
    MaxValuesValid := False;

end;

   end;




function  TDCT_3.GetMagnitude(ix: integer): TDataFreqAnalizeType;
begin
    Result:= TArray1D(FData^)[ix];
end;

(*********************************************************)
procedure  TDCT_3.DoDCT(isign: integer);
(*********************************************************
 the core of this routine is based on a work of Danielson
 and Lanczos, dated back to 1942 (FFT with decimation in
 time)
 *********************************************************)

 var
   arrTMP : array of Double;
   m,b,i,j,k:Integer;
  aux3, t,x, aux2,a ,aux1 , mult,cos1,aux,valorpi,suma,cosres:Double;
   begin
         m:=FNumData;
             suma:=0;
           //  try
           SetLength(arrTMP, FNumData + 1);

      if isign = 1 then
              begin

                  for i:=1 to ( FNumData  )do
                         begin
                         aux3:= TArray1D(FData^)[i];
                         arrTMP[i] :=aux3;
                         end ;
                     for j:=0 to (FNumData-1 ) do
                           begin

                               for k:=1 to (FNumData ) do
                                   begin

                                         valorpi:= pi/ m;
                                          a:= j+ 0.5;
                                          cos1:= valorpi*(k-1)*a;
                                          cosres:= cos(cos1);
                                          x:=arrTMP[k];
                                          mult := x*cosres;
                                          suma:=suma + mult;

                                  end;
                                  aux2 :=  arrTMP[1];
                                  t:=0.5* aux2;
                                  TArray1D(FData^)[j+1]:= t+ suma ;
                                  suma:=0;
                          end;



   SetLength(arrTMP,0)
   end;


  end;


{procedure  TDCT_3.SetNumData(AValue: longint);
begin
  if FNumData=AValue then Exit;
  FNumData:=AValue;
end;  }

(*********************************************************)
procedure  TDCT_3.Transform;
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
procedure  TDCT_3.InverseTransform;
(*********************************************************)

begin
  DoDCT(-1);
end;


procedure Register;
begin
  RegisterComponents('LazSignalProc', [ TDCT_3]);
end;


initialization
{$I Fourier.lrs}

end.
end.
