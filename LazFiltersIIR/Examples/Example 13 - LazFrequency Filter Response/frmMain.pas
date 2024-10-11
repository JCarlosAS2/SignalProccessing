unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, memds, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Spin, TAGraph, TASeries, Filter,
  TATransformations, TADbSource, TAFuncSeries, FilterIIRBSChebyshev,
  FilterIIRHPChebyshev, FilterIIRLPChebyshev, FilterIIRBPChebyshev,
  FilterIIRLPButterworth, FilterIIRLPBessel, FilterIIRHPBessel,
  FilterIIRHPButterworth, FilterIIRBPBessel, FilterIIRBPButterworth,
  FilterIIRBSBessel, FilterIIRBSButterworth, types, Math;


type
   TSignalForm = (sfSine, sfSquare, sfTriangle);
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    FilterIIRBPBessel1: TFilterIIRBPBessel;
    FilterIIRBPButterworth1: TFilterIIRBPButterworth;
    FilterIIRBPChebyshev1: TFilterIIRBPChebyshev;
    FilterIIRBSBessel1: TFilterIIRBSBessel;
    FilterIIRBSButterworth1: TFilterIIRBSButterworth;
    FilterIIRBSChebyshev1: TFilterIIRBSChebyshev;
    FilterIIRHPBessel1: TFilterIIRHPBessel;
    FilterIIRHPButterworth1: TFilterIIRHPButterworth;
    FilterIIRHPChebyshev1: TFilterIIRHPChebyshev;
    FilterIIRLPBessel1: TFilterIIRLPBessel;
    FilterIIRLPButterworth1: TFilterIIRLPButterworth;
    FilterIIRLPChebyshev1: TFilterIIRLPChebyshev;
    FloatSpinEditFreqCut2: TFloatSpinEdit;
    FloatSpinEditSampleRate: TFloatSpinEdit;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    rgFilterType: TRadioGroup;
    rgFilterResponse: TRadioGroup;
    FloatSpinEditGain: TFloatSpinEdit;
    FloatSpinEditFreqCut1: TFloatSpinEdit;
    FilterPropertiesBox: TGroupBox;
    Label1: TLabel;
    lFilterFreq11: TLabel;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    seRipple: TSpinEdit;
    seStartFreq: TSpinEdit;
    seStopFreq: TSpinEdit;
    seRes: TSpinEdit;
    SpinEditOrder: TSpinEdit;
    Splitter1: TSplitter;
    Gain: TStaticText;
    StatusBar1: TStatusBar;

    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);

    procedure ConfigFilterTypeAndResponse();

  private

    SignalForm: TSignalForm;

    Salto, PointCount2 : Integer;

    GenericFilter : TFilter;
  public


  end; 

var
  Form1: TForm1; 

implementation

uses UOperator, UType;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i : Integer;
begin

  Application.Title:= 'Frequency Filter Response' ;

  // Setup parameters

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  I: Integer;
  Start, Stop, NumSteps: Integer;
  Amp, Delta : TAS_Sample;
  Frequency : TFreqType;
Begin
  ConfigFilterTypeAndResponse;
  GenericFilter.SampleRate := FloatSpinEditSampleRate.Value;
  GenericFilter.Gain       := FloatSpinEditGain.Value;
  GenericFilter.Order      := SpinEditOrder.Value;
  GenericFilter.SetupFilter();

  Start:= seStartFreq.value;
  Stop:=  Min(seStopFreq.Value, Round(GenericFilter.SampleRate / 2));

  NumSteps:= seRes.Value;
  if NumSteps <= 0 then
  begin
    ShowMessage('Please specify non zero resolution');
    Exit;
  end;

  Delta:= (Stop - Start) / numSteps;
  Series1.Clear;
  for I:= 0 to NumSteps - 1 do
  begin
    Frequency:= Start + Delta * I;
    Amp:= GenericFilter.GetFrequencyResponse(Frequency);
    if Amp < 1e-10 then Amp:= 1e-10;
    Series1.AddXY(Frequency, log10(Amp)*20);
  end;


end;

procedure TForm1.ConfigFilterTypeAndResponse();
var
  FilterType, FilterResponse : Integer;

begin
   FilterResponse:= rgFilterResponse.ItemIndex;
   FilterType    := rgFilterType.ItemIndex;

   case FilterResponse of
     0: Begin  //LowPass
        case FilterType of
          0: Begin  //Besel
                GenericFilter := FilterIIRLPBessel1;
             end;
          1: Begin  //Botterworth
                GenericFilter := FilterIIRLPButterworth1;
             end;
          2: Begin  //Chebyshev
                GenericFilter := FilterIIRLPChebyshev1;
                TFilterIIRLPChebyshev(GenericFilter).Ripple:=seRipple.Value;
             end;

         end; //FilterType
       end;   //LowPass

     1: Begin  //HigPass
       case FilterType of
         0: Begin  //Besel
                GenericFilter := FilterIIRHPBessel1;
            end;
         1: Begin  //Botterworth
                GenericFilter := FilterIIRHPButterworth1;
            end;
         2: Begin  //Chebyshev
                GenericFilter := FilterIIRHPChebyshev1;
                TFilterIIRHPChebyshev(GenericFilter).Ripple:=seRipple.Value;
            end;

        end; //FilterType
       end;  //HigPass

     2: Begin //BandPass
         case FilterType of
          0: Begin  //Besel
                GenericFilter := FilterIIRBPBessel1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
             end;
          1: Begin  //Botterworth
                GenericFilter := FilterIIRBPButterworth1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
             end;
          2: Begin  //Chebyshev
                GenericFilter := FilterIIRBPChebyshev1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
                 TFilterIIRBPChebyshev(GenericFilter).Ripple:=seRipple.Value;
             end;

         end; //FilterType
       end;   //BandPass

     3: Begin //BandStop
         case FilterType of
          0: Begin  //Besel
                GenericFilter := FilterIIRBSBessel1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
             end;
          1: Begin  //Botterworth
                GenericFilter := FilterIIRBSButterworth1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
             end;
          2: Begin  //Chebyshev
               GenericFilter := FilterIIRBSChebyshev1;
                GenericFilter.FreqCut[1] := FloatSpinEditFreqCut1.Value;
               GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
               TFilterIIRBSChebyshev(GenericFilter).Ripple:=seRipple.Value;
             end;

         end; //FilterType
       end;  //StopPass
   end; //Case externo

   GenericFilter.FreqCut[1] := FloatSpinEditFreqCut1.Value;


end;


procedure TForm1.ScrollBox1Click(Sender: TObject);
begin
  //No borrar   Not Delete
end;


end.

