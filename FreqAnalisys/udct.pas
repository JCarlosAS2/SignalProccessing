unit udct;

{$mode objfpc}

interface

uses
  LResources, Classes, UTBaseFreqAnalisys;

type

  { TDCT }

  TDCT = class(TBaseFreqAnalisys)
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

constructor TDCT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TDCT.Destroy;
begin
  inherited Destroy;
end;

(*********************************************************)
function TDCT.FreqOfLine(ix: integer; SampleTime: double): double;
  (*********************************************************)

begin
  if (ix < 1) or (ix > (FNumData div 2)) then
    FreqOfLine := 0
  else
    FreqOfLine := ix / SampleTime / FNumData;
end;

procedure TDCT.SetRealVal(ix: integer; v: TDataFreqAnalizeType);
begin
   if (FData <> nil) and (ix >= 1) and (ix <= FNumData) then
  begin
    TArray1D(FData^)[ix ] := v;
    MaxValuesValid := False;

end;

   end;




function TDCT.GetMagnitude(ix: integer): TDataFreqAnalizeType;
begin
    Result:= TArray1D(FData^)[ix];
end;

(*********************************************************)
procedure TDCT.DoDCT(isign: integer);
(*********************************************************
 the core of this routine is based on a work of Danielson
 and Lanczos, dated back to 1942 (FFT with decimation in
 time)
 *********************************************************)


var

  arrTMP : array of Double;
  b,a,long,f,m,i,k,n:Integer;
  aux3,mult2,aux1 , mult,cos1,aux,valorpi,suma,x,cosres:Double;
  begin
             m:=FNumData;
             suma:=0;
           //  try
             SetLength(arrTMP, FNumData + 1);

        if isign = 1 then
              begin
                    for i:=1 to ( FNumData  )do
                         begin
                         aux:= TArray1D(FData^)[i];
                         arrTMP[i] :=aux;
                         end ;

                     for k:=1 to (FNumData ) do
                           begin
                               for n:=1 to (FNumData ) do
                                   begin
                                         a:=k-1;
                                         b:= (2*n)-1;
                                         f:=b*a;
                                         valorpi:= pi*f;
                                         long:=2*m;
                                         cos1:= valorpi/long;
                                         cosres:= cos(cos1);
                                         x:=arrTMP[n];
                                         mult := x*cosres;
                                         suma:=suma + mult;
                                   end;

                              if (k =1) then  begin
                                              aux1:=   1/(sqRt(m));
                                              TArray1D (FData^)[k] := aux1* suma;
                                              suma:=0;
                                              end
                              else   if (k <> 1) then    begin
                                                         aux1:= sqrt(2)/sqrt(m);
                                                         TArray1D (FData^)[k]:= aux1* suma;
                                                         suma:=0;
                                                         end;
                     end;
              end
        else
            begin
                 for i:=1 to ( FNumData + 1)do
                     begin
                      aux:= TArray1D(FData^)[i];
                      arrTMP[i] :=aux;
                      end ;

                 for k:=1 to (FNumData) do
                    begin
                            for n:=1 to (FNumData) do
                              begin
                                    a:=k-1;
                                    b:= (2*n)-1;
                                    f:=b*a;
                                    valorpi:= pi*f;
                                    long:=2*m;
                                    cos1:= valorpi/long;
                                    cosres:= cos(cos1);
                                    x:=arrTMP[n];
                                    mult := x*cosres;
                                    suma:=suma + mult;
                              end;

                            if (k =1) then  begin
                                            aux1:=   1/(sqRt(m));
                                            TArray1D (FData^)[k] := aux1* suma;
                                            suma:=0;
                                            end
                            else
                            if (k <> 1) then begin
                                             aux1:= sqrt(2)/sqrt(m);
                                             TArray1D (FData^)[k]:= aux1* suma;
                                             suma:=0;
                                             end;
                    end;

                 for i:=1 to ( FNumData )do
                     begin
                     aux3:= TArray1D(FData^)[i];
                     arrTMP[i] :=aux3;
                     end ;
                 for n:=1 to (FNumData) do
                     begin
                               for k:=1 to (FNumData) do
                                 begin
                                        a:=k-1;
                                        b:= ((2*n)-1);
                                        f:=b*a;
                                        valorpi:= pi*f;
                                        long:=2*m;
                                        cos1:= valorpi/long;
                                        cosres:= cos(cos1);
                                        x:=arrTMP[k];
                                        mult := x*cosres;

                                         if k = 1 then   aux1:= (1/(sqRt(m)))
                                        else aux1:= (sqrt(2))/(sqrt(m));
                                        mult2:= mult*aux1;
                                        suma:=suma + mult2;
                                 end;
                            TArray1D (FData^)[n] :=  suma;
                            suma:=0;
                     end;
            end;
     SetLength(arrTMP,0);


  end;


{procedure TDCT.SetNumData(AValue: longint);
begin
  if FNumData=AValue then Exit;
  FNumData:=AValue;
end;  }

(*********************************************************)
procedure TDCT.Transform;
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
procedure TDCT.InverseTransform;
(*********************************************************)

begin
  DoDCT(-1);
end;


procedure Register;
begin
  RegisterComponents('LazSignalProc', [TDCT]);
end;


initialization
{$I Fourier.lrs}

end.
end.
