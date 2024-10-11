unit Unit_Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, Fourier, TAGraph, TASeries, UTBaseFreqAnalisys, Cepstrum,
  ASWinTriangle, ASWinGauss, ASWinRectangular, ASWinBlackman, ASWinHamming,
  ASWinCos2, ASWinHanning, ASWinLanczos, ASWinTukey, ASWinKaiser,
  ASWinBlackmanHarris, ASWinFlatTop, TAChartUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtnClose: TBitBtn;
    Chart1: TChart;
    Chart2: TChart;
    CBoxWind: TComboBox;
    FFT1: TFFT;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    RGSpecType: TRadioGroup;
    SBFreq1: TScrollBar;
    ScrollBar1: TScrollBar;
    WinBlackman1: TWinBlackman;
    WinBlackmanHarris1: TWinBlackmanHarris;
    WinCos2_1: TWinCos2;
    WinFlatTop1: TWinFlatTop;
    WinGauss1: TWinGauss;
    WinHamming1: TWinHamming;
    WinHanning1: TWinHanning;
    WinKaiser1: TWinKaiser;
    WinLanczos1: TWinLanczos;
    WinRectangular1: TWinRectangular;
    WinTriangle1: TWinTriangle;
    WinTukey1: TWinTukey;
    procedure BitBtnCloseClick(Sender: TObject);

    procedure CBoxWindChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure GroupBox4Click(Sender: TObject);
    procedure RGSpecTypeClick(Sender: TObject);
    procedure SBFreq1Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { private declarations }
    procedure StartFFT;
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

procedure TForm1.FormCreate(Sender: TObject);
begin
  FFT1.Clear;
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
   StartFFT;
end;

procedure TForm1.GroupBox4Click(Sender: TObject);
begin

end;

procedure TForm1.RGSpecTypeClick(Sender: TObject);
begin
   StartFFT;
end;

procedure TForm1.SBFreq1Change(Sender: TObject);
begin
  StartFFT;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  StartFFT;
end;

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
    else Begin
         MessageDlg('Opción no implementada aún', mtInformation, [mbOK],0);
         exit;
        end; //Del else begin
   end; // del case

  StartFFT;
end;



procedure TForm1.BitBtnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

(**************************************************************)
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
  i      : integer;
  y      : double;
  Line1: TLineSeries;
  Line2: TLineSeries;


begin
Line1:= TLineSeries.Create(Nil);
Line1.SeriesColor:= clBlue;

Chart1.ClearSeries;



FFT1.ClearImag;

for i:=1 to FFT1.SpectrumSize do
  begin
    y := 100*(sin(0.01*i*(100-SbFreq1.Position))  +
         0.05*(random(100-ScrollBar1.Position)-0.05*(100-ScrollBar1.Position)));

    FFT1.RealSpec[i] := y;
    Line1.AddXY(i, y);
  end;

Chart1.AddSeries(Line1);

FFT1.Transform;
//FFT1.InverseTransform;

Line2:= TLineSeries.Create(Nil);
Line2.SeriesColor:= clRed;
//Line2.Marks.Style :=smsLabelValue;
Chart2.ClearSeries;



case RGSpecType.ItemIndex of
  0 : GroupBox3.Caption:= 'Magnitude Spectrum';
  1 : GroupBox3.Caption:= 'Power Spectrum';
  2 : GroupBox3.Caption:= 'Phase Angle';
  3 : GroupBox3.Caption:= 'Cosine Terms';
  4 : GroupBox3.Caption:= 'Sine Terms';
  5 : GroupBox3.Caption:= 'Real Part of Complex Spectrum';
  6 : GroupBox3.Caption:= 'Imaginary Part of Complex Spectrum';
end;


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

{******************************************************************************}




{$R *.lfm}

end.

