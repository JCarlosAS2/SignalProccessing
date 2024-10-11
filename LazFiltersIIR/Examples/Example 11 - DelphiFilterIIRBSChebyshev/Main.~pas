
unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, Buttons, TeEngine, Series, TeeProcs, Chart,
  Menus, Math, 
  Filter, FilterIIR, UType, Spin, FilterIIRBS, FilterIIRBSChebyshev;

type
  TSignalForm = (sfSine, sfSquare, sfTriangle);

  TfmMain = class(TForm)
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Bevel2: TBevel;
    Timer1: TTimer;
    ScrollBox1: TScrollBox;
    GeneratorBox: TGroupBox;
    lFreq1: TLabel;
    lAmp1: TLabel;
    rbSin: TRadioButton;
    rbSquare: TRadioButton;
    rbTriangle: TRadioButton;
    Panel1: TPanel;
    Chart1: TChart;
    Series1: TFastLineSeries;
    FilterPropertiesBox: TGroupBox;
    lFilterFreq11: TLabel;
    Label1: TLabel;
    Series2: TLineSeries;
    SpinEditOder: TSpinEdit;
    SpinEditFreqCut1: TSpinEdit;
    SpinEditFreq: TSpinEdit;
    SpinEditAmp: TSpinEdit;
    ChebyshevPropertiesBox6: TGroupBox;
    Label4: TLabel;
    tbFilterRipple: TTrackBar;
    edtFilterRipple: TEdit;
    SpinEditFreqCut2: TSpinEdit;
    SpinEditGain: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    SpinEditSampleRate: TSpinEdit;
    Label5: TLabel;
    FilterIIRBSChebyshev1: TFilterIIRBSChebyshev;
    procedure rbSourceClick(Sender: TObject);

    procedure tbFilterRippleChange(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

    procedure Panel1Resize(Sender: TObject);
    procedure SpinEditOderChange(Sender: TObject);
    procedure SpinEditFreqCut1Change(Sender: TObject);
    procedure SpinEditFreqChange(Sender: TObject);
    procedure SpinEditAmpChange(Sender: TObject);
    procedure SpinEditFreqCut2Change(Sender: TObject);
    procedure SpinEditGainChange(Sender: TObject);
    procedure SpinEditSampleRateChange(Sender: TObject);

  private
    SignalForm: TSignalForm;
    SignalAmp, SignalFreq: Integer;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Application.Title:= ' ' + Caption;

  // Setup parameters

  rbSourceClick(nil);

  tbFilterRippleChange(nil);

  SpinEditGainChange(nil);
  SpinEditFreqCut1Change(nil);
  SpinEditFreqCut2Change(nil);
  SpinEditFreqChange(nil);
  SpinEditAmpChange(nil);
  SpinEditOderChange(nil);

  Chart1.BottomAxis.Maximum:= 0;

  Timer1.Enabled:= true;
end;

procedure TfmMain.rbSourceClick(Sender: TObject);
begin
  if rbSin.Checked then SignalForm:= sfSine else
  if rbSquare.Checked then SignalForm:= sfSquare else
  if rbTriangle.Checked then SignalForm:= sfTriangle;
end;

procedure TfmMain.tbFilterRippleChange(Sender: TObject);
var S: String;
begin
  FilterIIRBSChebyshev1.Ripple:= tbFilterRipple.Position / 10;
  Str(FilterIIRBSChebyshev1.Ripple:4:1, S);
  edtFilterRipple.Text:= S + ' dB';
end;

procedure TfmMain.Timer1Timer(Sender: TObject);
const
  cMsInDay = 24 * 3600000;
  cScaleRange = 1 / cMsInDay;
  MiPi=3.1415926535897931;
var
  I: Integer;
  T: Double;
  V: TAS_Sample ;

  function Sine: TAS_Sample ;
  var
  kk : Double;
  begin
     Result:= SignalAmp * Sin(2 * MIPI * SignalFreq * T);
  end;

  function Triangle: TAS_Sample ;
  begin
    Result:= Frac(SignalFreq * T) * 4;
    if Result <= 2 then Result:= -SignalAmp * (1 - Result)
    else Result:= SignalAmp * (3 - Result);
  end;

  function Rectangle: TAS_Sample ;
  begin
    Result:= Frac(SignalFreq * T) - 0.5;
    if Result < 0.0 then Result:= -SignalAmp else Result:= SignalAmp;
  end;
begin
  for I:= 1 to 5 do
  begin
    T:= Timer1.Tag / FilterIIRBSChebyshev1.SampleRate;

    case SignalForm of
      sfSine: V:= Sine;
      sfSquare: V:= Rectangle;
      sfTriangle: V:= Triangle;
    else V:= 0;
    end;

    T:= T / cMsInDay;
    if T >= Chart1.BottomAxis.Maximum then
    begin
      Chart1.BottomAxis.SetMinMax(
        Chart1.BottomAxis.Maximum, Chart1.BottomAxis.Maximum + cScaleRange);
     end;

    Series1.AddXY(T, V, '', clRed);
    Series2.AddXY(T, FilterIIRBSChebyshev1.Filter(V), '', clRed);
    Timer1.Tag:= Timer1.Tag + 1;
  end;
end;


procedure TfmMain.Panel1Resize(Sender: TObject);
begin
  Chart1.Height:= Panel1.Height div 2;
end;


procedure TfmMain.SpinEditOderChange(Sender: TObject);
begin
  FilterIIRBSChebyshev1.Order:= SpinEditOder.Value;
end;

procedure TfmMain.SpinEditFreqCut1Change(Sender: TObject);
begin
  FilterIIRBSChebyshev1.FreqCut1:= SpinEditFreqCut1.Value;
end;

procedure TfmMain.SpinEditFreqChange(Sender: TObject);
begin
  SignalFreq:= SpinEditFreq.Value;
end;

procedure TfmMain.SpinEditAmpChange(Sender: TObject);
begin
  SignalAmp:= SpinEditAmp.Value;
end;

procedure TfmMain.SpinEditFreqCut2Change(Sender: TObject);
begin
   FilterIIRBSChebyshev1.FreqCut2:= SpinEditFreqCut2.Value;
end;

procedure TfmMain.SpinEditGainChange(Sender: TObject);
begin
   FilterIIRBSChebyshev1.Gain:= SpinEditGain.Value;
end;

procedure TfmMain.SpinEditSampleRateChange(Sender: TObject);
begin
  Timer1.Enabled:=false;
  FilterIIRBSChebyshev1.SampleRate:=SpinEditSampleRate.Value;
  Series1.Clear;
  Series2.Clear;
  Timer1.Enabled:=true;
end;

end.
