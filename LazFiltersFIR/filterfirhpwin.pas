unit FilterFirHPWin;


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


  { TFilterFIRLPWin }

  TFilterFIRHPWin = class(TFilterFIRWin)
  private
    { Private declarations }
     FWC: TAS_Sample;
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

  published
    { Published declarations }
     property SampleRate;
     property FreqCut1 : TFreqType read GetFreqCut1 write SetFreqCut1;
     property Order;

  end;

procedure Register;

implementation

{$ifNdef FPC}
{$endif}

 uses ASWinRectangular;

function TFilterFIRHPWin.CalcFilterCoef(nValue:integer): TAS_Sample;
var
M,z,pi1:Double;
tmp1,tmp2:TAS_Sample;
begin
   M := Order/2;
   z:= nValue-M;

   if (nValue <> M) then tmp1:= sin(FWc*z)/(pi*z)
                    else tmp1:= (FWc/pi);

   if (nValue <> M) then tmp2:= sin(Pi*z)/(pi*z)
                    else tmp2:= 1;

   Result:=tmp1-tmp2;

end;

procedure TFilterFIRHPWin.SetupFilter();
var
   ord,n : Integer;
  EndCount : Integer;

Begin
  SetLength(FFFR,0);
  SetLength(FFFR, trunc(SampleRate / 2) + 1);
  ord:=Order;
  EndCount := Order-1;

  FWc:=(2*pi*FreqCut1)/SampleRate;

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


constructor TFilterFIRHPWin.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   Filter:= FilterFilter; //PassAll;

   FreqCutCount := 1;
   FreqCut1:= 2500;
   SampleRate:= 20000;
   SetupFilter();
   Reset;
end;

destructor TFilterFIRHPWin.Destroy;
begin
  inherited Destroy;
end;

function TFilterFIRHPWin.CalcFreqResp: Boolean;
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


function TFilterFIRHPWin.GetFreqCut1: TFreqType;
begin
   result := FreqCut[1];
end;

procedure TFilterFIRHPWin.SetFreqCut1(const InputValue: TFreqType);
begin
  FreqCut[1]:=InputValue;
  SetupFilter();
end;

procedure Register;
begin
  RegisterComponents('LazFiltersFIR',[TFilterFIRHPWin]);
end;

initialization
{$ifdef FPC}
{$I FilterFirHPWin.lrs}
{$endif}

end.
