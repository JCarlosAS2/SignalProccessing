unit ASCircBuffer;

{$ifdef FPC}
 {$MODE delphi}{$H+}
{$endif}

interface

uses
  Classes, SysUtils;

resourcestring
  NotValidCountValueErrorMsg = 'Count must be > 0';
  NotValidIndexValueErrorMsg = 'Not Valid Index Value';

type
    TDataType      = Extended;
    TArrayDataType = array of TDataType;
    TGainType      = Extended;

  IndexOverflowError = class(Exception);

  { TCircBuffer }
  TCircBuffer = class
    private
      function  GetCount(): Integer;
      function  GetItems(Index: Integer): TDataType;
      procedure SetCount(ACountValue: Integer);
      procedure SetItems(Index: Integer; AValue: TDataType);

      procedure SetValues(Index: Integer; AValue: TDataType);
      function  GetValues(Index: Integer): TDataType;

    protected
      FCount      : Integer;
      FMarkInit   : Integer;
      FDataValues : TArrayDataType;


    public
      constructor Create(parOrderValue: Integer);
      destructor Destroy; override;

      procedure AddValue(parValue:TDataType);
      procedure AddValueInvert(parValue:TDataType);
      procedure ResetAllValues(parValue:TDataType);
      function  Sum():TDataType;


      property Count: Integer    read FCount    write SetCount;
      property MarkInit: Integer read FMarkInit write FMarkInit;

      property Values[Index: Integer]: TDataType read GetValues write SetValues;
      property Items[Index: Integer]: TDataType read GetItems write SetItems;

    end;

implementation

{ TCircBuffer }

//*************** Constructor and Destructor ***********************************
constructor TCircBuffer.Create(parOrderValue: Integer);
begin
  if parOrderValue < 1 then Begin
                             raise IndexOverflowError.Create(NotValidCountValueErrorMsg);
                             exit;
                            end;
  inherited Create;
  FCount:= parOrderValue;
  SetLength(FDataValues, parOrderValue);
  ResetAllValues(0);
  MarkInit := 0;
end;

destructor TCircBuffer.Destroy;
begin
  SetLength(FDataValues, 0);
  inherited Destroy;
end;
//*************** Constructor and Destructor ENDs*******************************


//***************** Get and Sets ***********************************************

function TCircBuffer.GetCount(): Integer;
begin
  Result := FCount;
end;


procedure TCircBuffer.SetCount(ACountValue: Integer);
begin
   if ACountValue < 1 then Begin
                         raise IndexOverflowError.Create(NotValidCountValueErrorMsg);
                         exit;
                       end;
   FCount:= ACountValue;
   SetLength(FDataValues, 0);
   SetLength(FDataValues, ACountValue);
   ResetAllValues(0);
   MarkInit := 0;
end;

function TCircBuffer.GetItems(Index: Integer): TDataType;
begin
    if (Index < 0)   or
     (Index > Count -1)
        then Begin
                raise IndexOverflowError.Create(NotValidIndexValueErrorMsg);
                exit;
             end;
  result := FDataValues[Index];
end;

procedure TCircBuffer.SetItems(Index: Integer; AValue: TDataType);
begin
  if (Index < 0)   or
     (Index > Count -1)
        then Begin
                raise IndexOverflowError.Create(NotValidIndexValueErrorMsg);
                exit;
             end;

  FDataValues[Index] := AValue;

end;

procedure TCircBuffer.SetValues(Index: Integer; AValue: TDataType);
var
  auxIndex : Integer;
begin
  if (Index < 0)   or
     (Index > Count -1)
        then Begin
                raise IndexOverflowError.Create(NotValidIndexValueErrorMsg);
                exit;
             end;
  auxIndex := (Index + MarkINit) Mod Count;
  FDataValues[auxIndex] := AValue;
end;

function TCircBuffer.GetValues(Index: Integer): TDataType;
var
  auxIndex : Integer;
begin
  if (Index < 0)   or
     (Index > Count -1)
        then Begin
                raise IndexOverflowError.Create(NotValidIndexValueErrorMsg);
                exit;
             end;
  auxIndex := (Index + MarkInit) Mod Count;
  result := FDataValues[auxIndex];

end;
//***************** Get and Sets Ends *******************************************


procedure TCircBuffer.AddValue(parValue: TDataType);
begin
  FDataValues[MarkInit] := parValue;
  MarkInit:= (MarkInit + 1) Mod Count;
end;

procedure TCircBuffer.AddValueInvert(parValue: TDataType);
begin
  if MarkInit = 0 then MarkInit := Count -1
                  else MarkInit := MarkInit -1;

  FDataValues[MarkInit] := parValue;
end;

procedure TCircBuffer.ResetAllValues(parValue: TDataType);
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    Begin
      FDataValues[i] := parValue;
    end;
  FMarkInit:=0;
end;

function TCircBuffer.Sum: TDataType;
var
  i : Integer;
begin
  result := 0;
  for i := 0 to Count - 1 do
    Begin
      result := result + FDataValues[i];
    end;
end;

end.

