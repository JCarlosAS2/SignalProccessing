unit UMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListBox, UTBaseFreqAnalisys, Fourier,
  ASWinBlackman, ASWinHamming, ASWinCos2, ASWinLanczos, ASWinKaiser,
  ASWinFlatTop, ASWinBlackmanHarris, ASWinTukey, ASWinHanning, ASWinGauss,
  ASWinRectangular, ASWinBase, ASWinTriangle, FMXTee.Engine, FMXTee.Procs,
  FMXTee.Chart, FMXTee.Series, ASWinBlackmanNuttall, ASWinBohman, ASWinNuttall,
  ASWinParzen;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    Label2: TLabel;
    SBFreq1: TScrollBar;
    GroupBox2: TGroupBox;
    CBoxWind: TComboBox;
    FFT1: TFFT;
    WinTriangle1: TWinTriangle;
    WinRectangular1: TWinRectangular;
    WinGauss1: TWinGauss;
    WinHanning1: TWinHanning;
    WinTukey1: TWinTukey;
    WinBlackmanHarris1: TWinBlackmanHarris;
    WinFlatTop1: TWinFlatTop;
    WinKaiser1: TWinKaiser;
    WinLanczos1: TWinLanczos;
    WinCos2_1: TWinCos2;
    WinHamming1: TWinHamming;
    WinBlackman1: TWinBlackman;
    Chart1: TChart;
    Chart2: TChart;
    gbRGSpecType: TGroupBox;
    RGSpecType: TComboBox;
    WinParzen1: TWinParzen;
    WinNuttall1: TWinNuttall;
    WinBohman1: TWinBohman;
    WinBlackmanNuttall1: TWinBlackmanNuttall;
    procedure ScrollBar1Change(Sender: TObject);
    procedure CBoxWindChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RGSpecTypeChange(Sender: TObject);
    procedure SBFreq1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure StartFFT;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.CBoxWindChange(Sender: TObject);
begin
case CBoxWind.ItemIndex of
    0 : FFT1.WgtWin := WinRectangular1;// fwRectangle;
    1 : FFT1.WgtWin := WinTriangle1;
    2 : FFT1.WgtWin := WinGauss1;
    3 : FFT1.WgtWin := WinBlackman1;
    4 : FFT1.WgtWin := WinCos2_1;
    5 : FFT1.WgtWin := WinHamming1;
    6 : FFT1.WgtWin := WinHanning1;
    7 : FFT1.WgtWin := WinKaiser1;
    8 : FFT1.WgtWin := WinLanczos1;
    9 : FFT1.WgtWin := WinTukey1;
    10: FFT1.WgtWin := WinBlackManHarris1;
    11: FFT1.WgtWin := WinFlatTop1;
    12: FFT1.WgtWin := WinParzen1;
    13: FFT1.WgtWin := WinNuttall1;
    14: FFT1.WgtWin := WinBohman1;
    15: FFT1.WgtWin := WinBlackmanNuttall1;

    else Begin
          ShowMessage('Opci�n no implementada a�n');
          exit;
        end; //Del else begin
   end; // del case

  StartFFT;
end;

procedure TForm1.RGSpecTypeChange(Sender: TObject);
begin
 StartFFT;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FFT1.Clear;
end;

procedure TForm1.SBFreq1Change(Sender: TObject);
begin
  StartFFT;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
   StartFFT;
end;

procedure TForm1.StartFFT;

//const
 (* ChartYRanges : array[0..6,1..2] of Double =
                      ((0,10),       { Magnitude }
                       (0,50000),   { PowerSpec }
                       (-2,2),      { Phase }
                       (-10,10),    { FourSerCosCoeff }
                       (-10,10),    { FourSerSinCoeff }
                       (-2000,2000),{ RealSpec }
                       (-2000,2000) { ImagSpec }
                       );
   *)
var
  i,r    : integer;
  y      : double;
  Line1: TFastLineSeries;
  Line2: TFastLineSeries;


begin
Line1:= TFastLineSeries.Create(Nil);
Line1.SeriesColor:= TAlphaColorRec.Blue;

Chart1.ClearChart;



FFT1.ClearImag;

for i:=1 to FFT1.SpectrumSize do
  begin
    r := trunc((100-ScrollBar1.Value));
    y := 100*(sin(0.01*i*(100-SbFreq1.Value))  +
         0.05*(random (r)-0.05*(100-ScrollBar1.Value)));

    FFT1.RealSpec[i] := y;
    Line1.AddXY(i, y);
  end;

Chart1.AddSeries(Line1);

FFT1.Transform;
//FFT1.InverseTransform;

Line2:= TFastLineSeries.Create(Nil);
Line2.SeriesColor:= TAlphaColorRec.Red;
//Line2.Marks.Style :=smsLabelValue;
Chart2.ClearChart;



//case RGSpecType.ItemIndex of
//  0 : GroupBox3.Caption:= 'Magnitude Spectrum';
//  1 : GroupBox3.Caption:= 'Power Spectrum';
//  2 : GroupBox3.Caption:= 'Phase Angle';
//  3 : GroupBox3.Caption:= 'Cosine Terms';
//  4 : GroupBox3.Caption:= 'Sine Terms';
//  5 : GroupBox3.Caption:= 'Real Part of Complex Spectrum';
//  6 : GroupBox3.Caption:= 'Imaginary Part of Complex Spectrum';
//end;


//Line2.AddXY(FFT1.FreqOfLine(1,0.001),0);
Line2.AddXY(1,0);
y := 0;
//for i:=1 to (FFT1.SpectrumSize) do
  for i:=1 to (FFT1.SpectrumSize div 2) do
  begin
     case RGSpecType.ItemIndex of
        0 : y := FFT1.Magnitude[i];
        1 : y := FFT1.PowerSpec[i];
        2 : y := FFT1.Phase[i];
        3 : y := FFT1.FourSerCosCoeff[i];
        4 : y := FFT1.FourSerSinCoeff[i];
        5 : y := FFT1.RealSpec[i+1];
        6 : y := FFT1.ImagSpec[i+1];
     end;

    // Line2.AddXY(FFT1.FreqOfLine(i,0.001),y);
     Line2.AddXY(i,y);

  end;

  Chart2.AddSeries(Line2);
end;

end.
