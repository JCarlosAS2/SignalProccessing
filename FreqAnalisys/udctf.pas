unit UDCTF;

{$mode objfpc}
 {$O+}


interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, Fourier,UTBaseFreqAnalisys;

type

  { TDCTF }

  TDCTF = class(TFFT)
  private
     { Private declarations }
  protected
    { Protected declarations }
  public
       procedure SetNumData(ndata: longint);override;
       constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
      procedure Transform;
   //    function GetMagnitude(ix: integer): TDataFreqAnalizeType;override;
 end;

procedure Register;


implementation
uses MSG;
  {$R-}
constructor TDCTF.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
end;

destructor TDCTF.Destroy;
begin
  inherited Destroy;
end;
procedure TDCTF.SetNumData(ndata: longint);
var
  sz, i, cntbit: integer;
  DBG: longint;

begin
  inherited SetNumData(2 * ndata);
  (*  DBG := ndata;
  if (FData <> nil) then
  begin
    sz := ndata;
    cntbit := 0;                           { check that size equals 2^n }
    for i := 1 to 24 do
    begin
      if (sz and $0001) = $0001 then
        Inc(cntBit);
      sz := sz shr 1;
    end;
    if cntbit <> 1 then
      raise ELocompError.Create(powerof2);
    FreeMem(FData, 2 * FNumData * SizeOf(TDataFreqAnalizeType));
    FNumData := 2* ndata;
    GetMem(FData, 2 * FNumData * SizeOf(TDataFreqAnalizeType));
    if (FData = nil) then
      raise ELocompError.Create(notmemory);
    fillchar(FData^, 2 * FNumData * SizeOf(TDataFreqAnalizeType), 0);
    MaxValuesValid := False;
    if Assigned(FWgtWin) then
      FWgtWin.Order := SpectrumSize;
  end; *)

end;

  {
function TDCTF.GetMagnitude(ix: integer): TDataFreqAnalizeType;
begin
    Result:= TArray1D(FData^)[ix];
end;       }
procedure TDCTF.Transform;
var
   au2, au, au1 ,a: double ;
  y,t,r,mo, m,i:Integer;
begin
       {    m:=FNumData div 2;
          a:=FNumData;
          for i:=1 to(FNumData div 2)do
          begin

           if (i >= 1) and (i<= m)
              then  TArray1D(FData^)[i]:=TArray1D(FData^)[i];
          end;
          for i:= m  to (FNumData)do
          begin
           //m:=2*FNumData;
            if (i >= m) and (i<= (FNumData-1))
               then  TArray1D(FData^)[i]:=TArray1D(FData^)[(2*FNumData)-1-i] ;
          end; }

  //***********************************************
 { r :=0;
  mo:=SpectrumSize div 2;
      for i:= 1 to  mo  div 2 do
      Begin
      au:= RealSpec[i];
        au2:=mo - i +1;
         RealSpec[mo- i +1] := RealSpec[i];
         au1 :=RealSpec[mo - i +1];

    {  RealSpec[i]:= RealSpec[i];

          if (i>=(mo div 2)) then  begin
        y:=i;
         t:=y;
        while (y<= (mo-1)) do

          begin
         RealSpec[y+1]:= t;
          // r:=t-1;
          // t:=r;
           t:=t-1;
           y:=y+1;
         end;
     end;  }
      ENd;  }
  {  mo:=FNumData div 2;
      for i:= 1 to  mo div 2   do
      begin
      au:= RealSpec[i];
      RealSpec[mo - i +1]:=au;

      end;  }
  //***************************************

    {mo:=SpectrumSize div 2 ;
      for i:= 1 to  ((mo div 2) -2) do
     begin
        au2:= RealSpec[i+1];
      RealSpec[(mo - i -1)]:= RealSpec[i+1];
       au := RealSpec[(mo - i -1)];
      end;     }

      //**************************************

      mo:=SpectrumSize div 2 ;
      for i:= 1 to  ((mo div 2)-1) do
     begin
        au2:= RealSpec[i];
      RealSpec[(mo - i +1)]:= RealSpec[i];
       au := RealSpec[(mo - i +1)];
      end;

      inherited Transform;




end;





procedure Register;
begin
  RegisterComponents('LazSignalProc',[TDCTF]);
end;

initialization
{$I Fourier.lrs}

end.

