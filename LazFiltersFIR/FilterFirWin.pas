unit FilterFIRWin;

{$ifdef FPC}
 {$MODE delphi}{$H+}
{$endif}

interface

uses
  Classes, SysUtils,
  {$ifdef FPC}
   LResources,
  {$endif}
  FilterFir,ASWinBase, UType;

type

  { TFilterFirWin }
  TFilterFIRWin = class(TFilterFIR)
  private

  protected

    FWindowsType:TWinBase;
    procedure SetWindowsType(avalue:TWinBase);
  public

    procedure SetOrder(Avalue: FilterOrder); Override;
    function GetFrequencyResponse(parFreqValue: TFreqType): TFreqType; Override;
  published

     property WindowsType: TWinBase  read FWindowsType write SetWindowsType default nil;

  end;

implementation

{ TFilterFirWin }

procedure TFilterFirWin.SetOrder(Avalue: FilterOrder);
begin
  if Order=AValue then Exit;

  if Assigned(WindowsType) then WindowsType.Order:=Avalue;

  inherited SetOrder(Avalue);
end;

function TFilterFIRWin.GetFrequencyResponse(parFreqValue: TFreqType): TFreqType;
var
   FreqIndex : LongInt;
   NextPower2ToNFromOrder : Integer;
begin

  NextPower2ToNFromOrder := 1;

  While NextPower2ToNFromOrder < Order  do   //if Size <> 2^n  calculate the next 2^n value
    NextPower2ToNFromOrder := 2 * NextPower2ToNFromOrder;

  FreqIndex :=  Trunc((parFreqValue * NextPower2ToNFromOrder) / SampleRate);
  // FreqIndex :=  Trunc(parFreqValue);
  result := Gain * (FFFR[FreqIndex]);

end;

procedure TFilterFirWin.SetWindowsType(avalue: TWinBase);
var
  i:integer;
begin
  if FWindowsType=AValue then Exit;
  FWindowsType:=AValue;
  i:=Order;
  avalue.Order:=i;

end;



end.

