unit FilterFirBPWin;


{$ifdef FPC}
  {$MODE delphi}{$H+}
{$endif}
interface

uses
  Classes, SysUtils,
  {$ifdef FPC}
  LResources,
  {$endif}
  Forms, Controls, Graphics, Dialogs,
  FilterFirWin, UType,Fourier,Filter;

type


  { TFilterFirBPWin }

  TFilterFirBPWin = class(TFilterFIRWin)
  private
    { Private declarations }
     FWC1: TAS_Sample;
     FWC2: TAS_Sample;
     function CalcFilterCoef(nValue:integer): TAS_Sample;

  protected
    { Protected declarations }
     procedure SetupFilter(); Override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent);override;
    destructor Destroy; override;

    function  CalcFreqResp(): Boolean;
    function  GetFreqCut1() : TFreqType;
    procedure SetFreqCut1(const InputValue: TFreqType);
    function  GetFreqCut2() : TFreqType;
    procedure SetFreqCut2(const InputValue: TFreqType);

  published
    { Published declarations }
     property SampleRate;
     property FreqCut1 : TFreqType read GetFreqCut1 write SetFreqCut1;
     property FreqCut2 : TFreqType read GetFreqCut2 write SetFreqCut2;
     property Order;

  end;

procedure Register;

implementation

{$ifNdef FPC}
{$endif}

 uses ASWinRectangular;

function TFilterFIRBPWin.CalcFilterCoef(nValue:integer): TAS_Sample;
var
 M,z:Double;

begin
    M := Order/2;
    z:= nValue-M;

    if (nValue <> M)then result:= (sin(FWC2*z)- sin(FWC1*z))/(pi*z)
                    else result:= (FWC2-FWC1)/pi;

end;

procedure TFilterFirBPWin.SetupFilter();
var
  n : Integer;
  EndCount : Integer;

Begin
  SetLength(FFFR,0);
  SetLength(FFFR, trunc(SampleRate / 2) + 1);

  EndCount := Order-1;

  FWC1:=(2*pi*FreqCut1)/SampleRate;
  FWC2:=(2*pi*FreqCut2)/SampleRate;
  //Calculando Coeficientes
   for n:=0 to EndCount do
    Begin
      FCB[EndCount-n] := CalcFilterCoef(n);
    end;

  //Multiplicar coheficientes por ventana
  if assigned(WindowsType)
  then Begin
         for n:=0 to EndCount do
          Begin
            FCB[n] := FCB[n] * WindowsType.W[n];
          end;
       end;

  //Calculando Respuesta de Freq. del filtro.
  CalcFreqResp();
end;


constructor TFilterFirBPWin.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   Filter:= FilterFilter; //PassAll;

   FreqCutCount := 2;
   FreqCut1:= 2500;
   FreqCut2:=6000;
   SampleRate:= 20000;
   SetupFilter();
   Reset;
end;

destructor TFilterFirBPWin.Destroy;
begin
  inherited Destroy;
end;

function TFilterFirBPWin.CalcFreqResp: Boolean;
var
  FFT1 : TFFT;
  WgtWinRect : TWinRectangular;
  i : Integer;
begin

  FFT1 := TFFT.Create(nil);
  WgtWinRect := TWinRectangular.create(nil);
  try
      FFT1.SpectrumSize:=Order;
      WgtWinRect.Order:= Order;

      FFT1.WgtWin := WgtWinRect;

      FFT1.Clear;

      for i:= 0 to (Order-1)  do
       begin
        FFT1.RealSpec[i]:= FCB[i];
       end;

      FFT1.Transform;

      for i:=1 to FFT1.SpectrumSize div 2 do
        Begin
         FFFR[i-1] := FFT1.Magnitude[i] * (FFT1.SpectrumSize div 2);
        end;


  finally
       WgtWinRect.Free;
       FFT1.Free;
  end;

end;


function TFilterFirBPWin.GetFreqCut1: TFreqType;
begin
   result := FreqCut[1];
end;

procedure TFilterFirBPWin.SetFreqCut1(const InputValue: TFreqType);
begin
  FreqCut[1]:=InputValue;
  SetupFilter();
end;

function TFilterFirBPWin.GetFreqCut2: TFreqType;
begin
     result := FreqCut[2];
end;

procedure TFilterFirBPWin.SetFreqCut2(const InputValue: TFreqType);
begin
    FreqCut[2]:=InputValue;
  SetupFilter();
end;

procedure Register;
begin
  RegisterComponents('LazFiltersFIR',[TFilterFirBPWin]);
end;

initialization
{$ifdef FPC}
{$I FilterFirBPWin.lrs}
{$endif}

end.
