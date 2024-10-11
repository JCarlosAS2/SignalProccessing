unit FilterFIR;

{$ifdef FPC}
 {$MODE delphi}{$H+}
{$endif}

interface

uses
  Classes, SysUtils,
  {$ifdef FPC}
   LResources,
  {$endif}
  ASCircBuffer, Filter, UType;

 type

  TSamplesArray        = array of TAS_Sample;
  TCoefficientsBuffer  = TCircBuffer;  //TSamplesArray; JCarlos
  TInputValues         = TCircBuffer;  //TSamplesArray; JCarlos

  { TFilterFIR }

  TFilterFIR = class(TFilter)
    private
      function GetFCB(Index: Integer): TAS_Sample;
      function GetInputValues(Index: Integer): TAS_Sample;
      procedure SetFCB(Index: Integer; AValue: TAS_Sample);
      procedure SetInputValues(Index: Integer; AValue: TAS_Sample);

    protected
     FFCB          : TCoefficientsBuffer; //Filter CoefficientsBuffer
     FInputValues  : TInputValues;  //Input Samples Buffer
     FFFR          :  TSamplesArray;   //Frecuency Filter Response
     function CalcFilterCoef(nValue:integer): TAS_Sample; virtual; abstract;

    public
      constructor Create(AOwner: TComponent);override;
      Destructor  Destroy();override;

      procedure Reset(); Override;
      function FilterFilter(InputValue: TAS_Sample): TAS_Sample;Override;
      procedure SetOrder(AOrder: FilterOrder); Override;

      property FCB[Index: Integer]: TAS_Sample read GetFCB write SetFCB;
      property InputValues[Index: Integer]: TAS_Sample read GetInputValues write SetInputValues;

    published
 end;

implementation


{ TFilterFir }

//************************* Get and Set ****************************************
function TFilterFIR.GetFCB(Index: Integer): TAS_Sample;
begin
  if (Index >= 0) and (Index < Order) then result:= FFCB.Values[Index]
   else  raise IndexOverflowError.Create (IndexOverflowErrorMsg);

end;

function TFilterFIR.GetInputValues(Index: Integer): TAS_Sample;
begin
   if (Index >= 0) and (Index < Order) then result:= FInputValues.Values[Index]
   else  raise IndexOverflowError.Create (IndexOverflowErrorMsg);
end;
 //-------------------------------------
procedure TFilterFIR.SetFCB(Index: Integer; AValue: TAS_Sample);
var
  i:integer;
begin
  i:= Index;
  if (Index >= 0) and (Index <= Order) then begin
   FFCB.Values[Index] := AValue ;

  end
  else  raise IndexOverflowError.Create(IndexOverflowErrorMsg);

end;

procedure TFilterFIR.SetInputValues(Index: Integer; AValue: TAS_Sample);
var
  i:integer;
begin
  i:= Index;
  if (Index >= 0) and (Index <= Order)
     then begin FInputValues.Values[Index] := AValue ;

  end
  else  raise IndexOverflowError.Create(IndexOverflowErrorMsg);

end;

//************************* Get and Set ****************************************


//************************* Constructor and Destructor *************************
constructor TFilterFir.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFCB          := TCircBuffer.Create(1); //JCarlos
  FInputValues  := TCircBuffer.Create(1); //JCarlos

end;

destructor TFilterFIR.Destroy;
begin

  FFCB.Free;           //JCarlos
  FInputValues.Free;   //JCarlos
  SetLength(FFFR,0);
  FFFR:=Nil;
  FFCB:=nil;
  FInputValues:=nil;

  inherited Destroy;
end;

//************************* Constructor and Destructor *************************


procedure TFilterFIR.Reset;     //JCarlos
var
  i : Integer;
begin
  if (Assigned(FInputValues))
      then Begin
              FInputValues.ResetAllValues(0);
            end;

  if (Assigned(FFCB))
      then Begin
              FFCB.ResetAllValues(0);
           end;

// Poner aqui el codigo que pueda faltar para hacer reset al filtro.
end;


function  TFilterFIR.FilterFilter(InputValue: TAS_Sample): TAS_Sample;
var
  i : Integer;
  Suma, FCBtmp, InputValuetmp: TAS_Sample;
Begin
 FInputValues.AddValue(InputValue);

 Suma := 0;
 for i:= 0 to Order -1 do
 Begin
   FCBtmp :=  FCB[i];
   InputValuetmp := InputValues[i];
   Suma := Suma + FCB[i] * InputValues[i];
 end;

 result := Suma;
end;

procedure TFilterFIR.SetOrder(AOrder: FilterOrder);

begin
  FFCB.Count:=AOrder;
  FInputValues.Count:=AOrder;

  inherited SetOrder(AOrder);

end;

end.

