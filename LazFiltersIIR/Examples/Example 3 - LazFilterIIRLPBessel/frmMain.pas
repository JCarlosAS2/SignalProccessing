unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, memds, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Spin, TAGraph, TASeries,
  TATransformations, TADbSource, TALegendPanel,
  FilterIIRLPBessel, Math, types, TACustomSeries;


type
   TSignalForm = (sfSine, sfSquare, sfTriangle);
  { TForm1 }

  TForm1 = class(TForm)
    Chart1: TChart;
    FilterIIRLPBessel1: TFilterIIRLPBessel;
    FilterPropertiesBox: TGroupBox;
    FloatSpinEditAmp1: TFloatSpinEdit;
    FloatSpinEditAmp2: TFloatSpinEdit;
    FloatSpinEditFreq1: TFloatSpinEdit;
    FloatSpinEditFreq2: TFloatSpinEdit;
    FloatSpinEditFreqCut1: TFloatSpinEdit;
    FloatSpinEditGain: TFloatSpinEdit;
    FloatSpinEditSampleRate: TFloatSpinEdit;
    GeneratorBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    lAmp2: TLabel;
    lFilterFreq11: TLabel;
    lFreq2: TLabel;
    rbSin: TRadioButton;
    rbSquare: TRadioButton;
    rbTriangle: TRadioButton;
    Series2: TLineSeries;
    Series1: TLineSeries;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    SpinEditOrder: TSpinEdit;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure FloatSpinEditAmpChange(Sender: TObject);
    procedure FloatSpinEditFreqChange(Sender: TObject);
    procedure FloatSpinEditFreqCut1Change(Sender: TObject);
    procedure FloatSpinEditGainChange(Sender: TObject);
    procedure FloatSpinEditSampleRateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbSourceClick(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure SpinEditOrderChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

    SignalForm: TSignalForm;
    SignalAmp1, SignalFreq1 : Double;
    Salto, PointCount2 : Integer;
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

  Application.Title:= 'Filter Low Pass Bessel Example';


  // Setup parameters

  rbSourceClick(nil);
  FloatSpinEditGainChange(nil);
  FloatSpinEditFreqCut1Change(nil);
  FloatSpinEditFreqChange(nil);
  FloatSpinEditAmpChange(nil);
  SpinEditOrderChange(nil);

  Timer1.Enabled:= true;
  PointCount2 := 0;
  Salto := 0;

end;

procedure TForm1.FloatSpinEditGainChange(Sender: TObject);
begin
  FilterIIRLPBessel1.Gain:= FloatSpinEditGain.Value;
end;

procedure TForm1.FloatSpinEditSampleRateChange(Sender: TObject);
begin
  Timer1.Enabled:=false;
  FilterIIRLPBessel1.SampleRate:=FloatSpinEditSampleRate.Value;
  Series1.Clear;
  Series2.Clear;
  Timer1.Enabled:=true;
end;

procedure TForm1.FloatSpinEditFreqCut1Change(Sender: TObject);
begin
    FilterIIRLPBessel1.FreqCut1:= FloatSpinEditFreqCut1.Value;
end;

procedure TForm1.FloatSpinEditFreqChange(Sender: TObject);
begin
    SignalFreq1:= FloatSpinEditFreq1.Value;

end;

procedure TForm1.FloatSpinEditAmpChange(Sender: TObject);
begin
  SignalAmp1:= FloatSpinEditAmp1.Value;

end;


procedure TForm1.rbSourceClick(Sender: TObject);
begin
  if rbSin.Checked then SignalForm:= sfSine else
  if rbSquare.Checked then SignalForm:= sfSquare else
  if rbTriangle.Checked then SignalForm:= sfTriangle;
end;

procedure TForm1.ScrollBox1Click(Sender: TObject);
begin

end;


procedure TForm1.SpinEditOrderChange(Sender: TObject);
begin
   FilterIIRLPBessel1.Order:= SpinEditOrder.Value;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
const
  cMsInDay = 24 * 3600000;
  cScaleRange = 1 / cMsInDay;
var
  I: Integer;
  T: Double;
  V: TAS_Sample ;

 function Sine: TAS_Sample ;
  begin
     Result:= SignalAmp1 * Sin(2 * PI * SignalFreq1 * T);
  end;

  function Triangle: TAS_Sample ;
  var
    R1 : TAS_Sample;
  begin
    R1:= Frac(SignalFreq1 * T) * 4;

    if R1 <= 2 then R1:= -SignalAmp1 * (1 - R1)
    else R1:= SignalAmp1 * (3 - R1);


    result := R1;
(*
    if Result <= 2 then Result:= -SignalAmp * (1 - Result)
    else Result:= SignalAmp * (3 - Result); *)
  end;

  function Rectangle: TAS_Sample ;
  var
    R1: TAS_Sample;
  begin
 (*   Result:= Frac(SignalFreq * T) - 0.5;
    if Result < 0.0 then Result:= -SignalAmp else Result:= SignalAmp;
    *)
   R1:= Frac(SignalFreq1 * T) - 0.5;
    if R1 < 0.0 then R1:= -SignalAmp1 else R1:= SignalAmp1;

   result := R1;
 end;
begin
  for I:= 1 to 5 do
  begin
    T:= Timer1.Tag / FilterIIRLPBessel1.SampleRate;

    case SignalForm of
      sfSine: V:= Sine;
      sfSquare: V:= Rectangle;
      sfTriangle: V:= Triangle;
    else V:= 0;
    end;

    T:= T / cMsInDay;
    if T >= Chart1.Extent.XMax then
    begin
     Chart1.Extent.XMin := Chart1.Extent.XMax;
     Chart1.Extent.XMax := Chart1.Extent.XMax + 1E-8;
    end;

    if T < Chart1.Extent.XMin then
    begin
     Chart1.Extent.XMin := T;
     Chart1.Extent.XMax := Chart1.Extent.XMin + 1E-8;
    end;

    Timer1.Enabled:=false;
    Series1.AddXY(T, V, '', clRed);
    Series2.AddXY(T, FilterIIRLPBessel1.Filter(V), '', clRed);
    Timer1.Tag:= Timer1.Tag + 1;
    Timer1.Enabled:=true;


  end;
end;



end.

