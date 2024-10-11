unit ASWinBase;

{$ifdef FPC}
  {$MODE delphi}{$H+}
{$endif}

interface

uses
  Classes, SysUtils
  {$ifdef FPC}
  ,LResources
  {$endif}
 // Forms, Controls, Graphics, Dialogs
  ;

 resourcestring
   IndexOverflowErrorMsg ='Overflow index in  Weighting Windows access.';
type
  TAS_Sample = Extended;
  TWinBuffer = array of TAS_Sample;
  TFIROrder  = Integer;

  IndexOverflowError = class(Exception);


  { TWinBase }
   TWinBase = class(TComponent)
  private
    { Private declarations }

    function GetOrder: TFIROrder;
    function GetW(Index: Integer): TAS_Sample;
    procedure SetOrder(AValue: TFIROrder);
    procedure SetW(Index: Integer; AValue: TAS_Sample);

  protected
    { Protected declarations }
    FW :  TWinBuffer;
    FOrder : TFIROrder;
    FGain:Double;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CalcCoheff(): Boolean; virtual; abstract;
    property W[Index: Integer]: TAS_Sample read GetW write SetW;
    property Order: TFIROrder read GetOrder write SetOrder;
    property Gain: Double read FGain write FGain;
  published
    { Published declarations }
  end;


implementation

{$ifNdef FPC}
{$endif}

{ TWinBase }

//******************************************************************************
//Set and Gets
//******************************************************************************
function TWinBase.GetW(Index: Integer): TAS_Sample;
begin
  if (Index >= 0) and (Index < Order) then result:= Gain*FW[Index]
   else  raise IndexOverflowError.Create (IndexOverflowErrorMsg);
end;

procedure TWinBase.SetW(Index: Integer; AValue: TAS_Sample);
var
  i:integer;
begin
  i:= Index;
  if (Index >= 0) and (Index <= Order) then begin
   FW[Index] := AValue ;

  end
  else  raise IndexOverflowError.Create(IndexOverflowErrorMsg);
end;

function TWinBase.GetOrder: TFIROrder;
begin
  result := FOrder;
end;

procedure TWinBase.SetOrder(AValue: TFIROrder);
var
  i : Integer;
begin
 SetLength(FW,0);
 SetLength(FW, AValue);
 FOrder := AValue;

 if Order > 0 then CalcCoheff();

 //  if Order < 0 then CalcCoheff();
end;
//**************** End Get and Set *********************************************


//******************************************************************************
// Cosntructor and Destructor
//******************************************************************************
constructor TWinBase.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FOrder := 0;
  FGain:=1;
end;

destructor TWinBase.Destroy;
begin
  SetLength(FW,0);
  inherited Destroy;
end;

//************* End Get and Set ************************************************

initialization
{$ifdef FPC}
{$endif}
end.
