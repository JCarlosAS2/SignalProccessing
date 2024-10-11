unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, memds, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Spin, TAGraph, TASeries,
  TATransformations, TADbSource, TALegendPanel, types, Math, UConst,
  FilterIIRBSBessel, FilterIIRLPButterworth, FilterFirLPWin, FilterFirBSWin,
  FilterFirHPWin, FilterFirBPWin,FilterFIRWin, Filter, ASWinGauss, ASWinRectangular, ASWinTriangle,
  ASWinBlackman, ASWinHamming, ASWinCos2, ASWinHanning, ASWinLanczos,
  ASWinTukey, ASWinKaiser, ASWinBlackmanHarris, ASWinFlatTop, ASWinBohman,
  ASWinNuttall, ASWinBlackmanNuttall, ASWinParzen, TACustomSeries;


type
   TSignalForm = (sfSine, sfSquare, sfTriangle);
  { TForm1 }

  TForm1 = class(TForm)
    BtnClose: TButton;
    Chart1: TChart;
    CBoxWin: TComboBox;
    WinBlackmanHarris1: TWinBlackmanHarris;
    Window:TFilterFIRWin;
    FilterFIRLPWin1: TFilterFIRLPWin;
    FilterPropertiesBox: TGroupBox;
    FloatSpinEditAmp1: TFloatSpinEdit;
    FloatSpinEditFreq1: TFloatSpinEdit;
    FloatSpinEditFreqCut1: TFloatSpinEdit;
    FloatSpinEditGain: TFloatSpinEdit;
    FloatSpinEditSampleRate: TFloatSpinEdit;
    GeneratorBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabWindows: TLabel;
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
    WinBlackman1: TWinBlackman;
    WinBlackmanNuttall1: TWinBlackmanNuttall;
    WinBohman1: TWinBohman;
    WinCos2_1: TWinCos2;
    WinFlatTop1: TWinFlatTop;
    WinGauss1: TWinGauss;
    WinHamming1: TWinHamming;
    WinHanning1: TWinHanning;
    WinKaiser1: TWinKaiser;
    WinLanczos1: TWinLanczos;
    WinNuttall1: TWinNuttall;
    WinParzen1: TWinParzen;
    WinRectangular1: TWinRectangular;
    WinTriangle1: TWinTriangle;
    WinTukey1: TWinTukey;
    procedure BtnCloseClick(Sender: TObject);
    procedure CBoxWinChange(Sender: TObject);
    procedure FloatSpinEditAmpChange(Sender: TObject);
    procedure FloatSpinEditFreqChange(Sender: TObject);
    procedure FloatSpinEditFreqCut1Change(Sender: TObject);
    procedure FloatSpinEditGainChange(Sender: TObject);
    procedure FloatSpinEditSampleRateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbSourceClick(Sender: TObject);
    procedure SpinEditOrderChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

    SignalForm: TSignalForm;
    SignalAmp1, SignalFreq1 : Double;
    Salto, PointCount2 : Integer;
    GenericFilter:TFilter;

  public


  end; 

var
  Form1: TForm1; 

implementation

uses UOperator,UType;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i,item: Integer;
begin

  Application.Title:= 'Filter Low Pass Windows FIR Example';


  // Setup parameters

  rbSourceClick(nil);
  FloatSpinEditSampleRateChange(nil);
  FloatSpinEditGainChange(nil);
  FloatSpinEditFreqCut1Change(nil);
  FloatSpinEditFreqChange(nil);
  FloatSpinEditAmpChange(nil);
  SpinEditOrderChange(nil);


  Timer1.Enabled:= true;
  PointCount2 := 0;
  Salto := 0;
  FilterFIRLPWin1.Order:=50;

end;


procedure TForm1.FloatSpinEditGainChange(Sender: TObject);
begin
  FilterFIRLPWin1.Gain:= FloatSpinEditGain.Value;
end;

procedure TForm1.FloatSpinEditSampleRateChange(Sender: TObject);
begin
  Timer1.Enabled:=false;
  FilterFIRLPWin1.SampleRate:=FloatSpinEditSampleRate.Value;
  Series1.Clear;
  Series2.Clear;
  Timer1.Enabled:=true;
end;

procedure TForm1.FloatSpinEditFreqCut1Change(Sender: TObject);
begin
    FilterFIRLPWin1.FreqCut1:= FloatSpinEditFreqCut1.Value;
end;

procedure TForm1.FloatSpinEditFreqChange(Sender: TObject);
begin
    SignalFreq1:= FloatSpinEditFreq1.Value;

end;

procedure TForm1.FloatSpinEditAmpChange(Sender: TObject);
begin
  SignalAmp1:= FloatSpinEditAmp1.Value;

end;

procedure TForm1.BtnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;


procedure TForm1.CBoxWinChange(Sender: TObject);
begin

   case CBoxWin.ItemIndex of
    0 : FilterFIRLPWin1.WindowsType := WinBlackman1;
    1 : FilterFIRLPWin1.WindowsType := WinTriangle1;
    2 : FilterFIRLPWin1.WindowsType := WinBlackmanHarris1;
    3 : FilterFIRLPWin1.WindowsType := WinNuttall1;
    4 : FilterFIRLPWin1.WindowsType := WinCos2_1;
    5 : FilterFIRLPWin1.WindowsType := WinHamming1;
    6 : FilterFIRLPWin1.WindowsType := WinHanning1;
    7 : FilterFIRLPWin1.WindowsType := WinKaiser1;
    8 : FilterFIRLPWin1.WindowsType := WinLanczos1;
    9 : FilterFIRLPWin1.WindowsType := WinTukey1;
   10 : FilterFIRLPWin1.WindowsType := WinGauss1;
   11 : FilterFIRLPWin1.WindowsType := WinFlatTop1;
   12 : FilterFIRLPWin1.WindowsType := WinBohman1;
   13 : FilterFIRLPWin1.WindowsType := WinBlackmanNuttall1;
   14 : FilterFIRLPWin1.WindowsType := WinParzen1;
   15 : FilterFIRLPWin1.WindowsType := WinRectangular1;

    else Begin
         MessageDlg('No Valid Windows Type', mtInformation, [mbOK],0);

         exit;
        end; //Del else begin
    end; // del case
   FilterFIRLPWin1.SetupFilter();
 end;


procedure TForm1.rbSourceClick(Sender: TObject);
begin
  if rbSin.Checked then SignalForm:= sfSine else
  if rbSquare.Checked then SignalForm:= sfSquare else
  if rbTriangle.Checked then SignalForm:= sfTriangle;
end;

procedure TForm1.SpinEditOrderChange(Sender: TObject);
begin
   Timer1.Enabled:=false;
   FilterFIRLPWin1.Order:= SpinEditOrder.Value;
   SpinEditOrder.Value := FilterFIRLPWin1.Order; //Verificando visualmente el valor que realmente tomo la propiedad orden del filtro
   Timer1.Enabled := true;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
const
  cMsInDay = 24 * 3600000;
  cScaleRange = 1 / cMsInDay;

var
  I: Integer;
  T: Double;
  V: TAS_Sample;
  item:Integer;


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

    result := R1 ;
(*
    if Result <= 2 then Result:= -SignalAmp * (1 - Result)
    else Result:= SignalAmp * (3 - Result); *)
  end;

  function Rectangle: TAS_Sample ;
  var
    R1 : TAS_Sample;
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
    T:= Timer1.Tag / FilterFIRLPWin1.SampleRate;


    case SignalForm of
      sfSine: V:= Sine;
      sfSquare: V:= Rectangle;
      sfTriangle: V:= Triangle;
    else V:= 0;
    end;

    T:= T / cMsInDay;
    if T >= Chart1.Extent.XMax then
    begin
      Series1.AddXY(0,0, '', clRed);
      Series2.AddXY(0,0, '', clblue);
      T:= 0;
      Series1.Clear;
      Series2.clear;
      Timer1.Tag := 0

    end;

    if T < Chart1.Extent.XMin then
    begin
     T:= 0;
     Series1.AddXY(0,0, '', clRed);
     Series2.AddXY(0,0, '', clblue);
     Series1.Clear;
     Series2.clear;
     Timer1.Tag := 0;
    end;

    Timer1.Enabled:=false;
    Series1.AddXY(T, V, '', clRed);
    Series2.AddXY(T, FilterFIRLPWin1.Filter(V), '', clblue);
    Timer1.Tag:= Timer1.Tag + 1;
    Timer1.Enabled:=true;


  end;
end;


end.

