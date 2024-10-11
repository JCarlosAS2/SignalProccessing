unit  unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, Spin, Fourier, TAGraph, TASeries, Cepstrum,
  TATransformations, UTBaseFreqAnalisys, TAChartListbox, ASWinBase, ASWinCos2,
  ASWinTriangle, ASWinGauss, ASWinRectangular, ASWinBlackman, ASWinHamming,
  ASWinHanning, ASWinLanczos, ASWintukey, ASWinKaiser, ASWinBlackmanHarris,
  ASWinFlatTop, ASWinParzen, ASWinNuttall, ASWinBlackmanNuttall, ASWinBohman,
  ASWinPrueba;

type

  { TForm1 }
  ArrayWin = array[0..15] of TWinBase;

  TForm1 = class(TForm)
    BitBtn_Close: TButton;
    Button1: TButton;
    CBoxWind: TComboBox;
    Chart1: TChart;
    Chart2: TChart;
    FFT1: TFFT;
    fcsp1: TFloatSpinEdit;
    fcsp2: TFloatSpinEdit;
    fmsp: TFloatSpinEdit;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    LBfc1: TLabel;
    LBfm: TLabel;
    LBfc: TLabel;
    seorden: TSpinEdit;
    WinBlackman1: TWinBlackman;
    WinBlackmanHarris1: TWinBlackmanHarris;
    WinCos2_1: TWinCos2;
    WinFlatTop1: TWinFlatTop;
    WinGauss1: TWinGauss;
    WinHamming1: TWinHamming;
    WinHanning1: TWinHanning;
    WinKaiser1: TWinKaiser;
    WinLanczos1: TWinLanczos;
    WinPrueba1: TWinPrueba;
    WinRectangular1: TWinRectangular;
    WinTriangle1: TWinTriangle;
    WinTukey1: TWinTukey;
    procedure BitBtn_CloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBoxWinChange(Sender: TObject);
    procedure CBoxWindChange(Sender: TObject);
    procedure fcsp1Change(Sender: TObject);
    procedure fmspChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GroupBox3Click(Sender: TObject);
    procedure seordenChange(Sender: TObject);
    procedure formDeActivate(sender: TObject);
    procedure seordenKeyPress(Sender: TObject; var Key: char);

  private
    { private declarations }
   procedure startFFT;
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{$R *.lfm}

{ TForm1 }
var
  UpDateSignal : boolean;

procedure TForm1.FormCreate(Sender: TObject);
begin
     FFT1.Clear;
end;

procedure TForm1.formDeActivate(sender: TObject);
begin

   startFFT;

end;

procedure TForm1.seordenKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TForm1.GroupBox3Click(Sender: TObject);
begin

end;

procedure TForm1.seordenChange(Sender: TObject);
begin
  WinPrueba1.Order:=seorden.Value;
  WinHamming1.Order:=seOrden.Value;
end;


procedure TForm1.CBoxWinChange(Sender: TObject);

begin

end;

procedure TForm1.CBoxWindChange(Sender: TObject);
var
  i:Integer;
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
    12: FFT1.WgtWin := WinPrueba1;
    else Begin
         MessageDlg('Opción no implementada aún', mtInformation, [mbOK],0);
         exit;
        end; //Del else begin
   end; // del case

 startFFT;
end;


procedure TForm1.fcsp1Change(Sender: TObject);
begin
 { WinPrueba1.Order:=fcsp1.Value;
  WinPrueba1.Order:=fcsp2.Value;
  WinHamming1.Order:=fmsp.Value; }
end;


procedure TForm1.fmspChange(Sender: TObject);
begin
  {WinPrueba1.Order:=fcsp1.Value;
  WinPrueba1.Order:=fcsp2.Value;
  WinHamming1.Order:=fmsp.Value; }
end;

procedure TForm1.startFFT;
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
  Line1:TLineSeries;
  Line2:TLineSeries;
  Line3:TLineSeries;
  fc1,fm,fc2,Wc1, Wc2 , W: Double;


begin
  { FFT1.Clear;

   Line1:=TLineSeries.Create(nil);
         Chart1.ClearSeries;
         Line1.SeriesColor:=clBlue;

        for i:=1 to WinPrueba1.Order-1 do
        Line1.AddXY(i,WinPrueba1.W[i]);
        Chart1.AddSeries(Line1);



         Line2:=TLineSeries.Create(nil);
         Chart2.ClearSeries;
         Line2.SeriesColor:=clBlue;

        for i:=1 to WinPrueba1.Order-1 do
        Line2.AddXY(i, WinPrueba1.W[i]*WinHamming1.W[i]);
        Chart2.AddSeries(Line2); }

  FFT1.Clear;
       fc1:=fcsp1.Value;
       fm:=fmsp.Value;
       fc2:=fcsp2.Value;
       //fm2:=fmesp2.Value;
       Wc1:=2*pi*fc1/fm;
       Wc2:=2*pi*fc2/fm;
       WinPrueba1.CalcCoheffPasaBajo(Wc1);
       //FilterFirLPWin1.CalcCoheffPasaBajo(Wc1);

   Line1:=TLineSeries.Create(nil);
         Chart1.ClearSeries;
         Line1.SeriesColor:=clBlue;

        for i:=1 to WinPrueba1.Order-1 do
        Line1.AddXY(i,WinPrueba1.W[i]);
        Chart1.AddSeries(Line1);


        for i:=0 to WinPrueba1.Order-1 do
        FFT1.RealSpec[i]:=WinPrueba1.W[i]*WinHamming1.W[i];// WinPrueba1.W[i];




         //FFT1.InverseTransform;
         FFT1.Transform;

         Line2:=TLineSeries.Create(nil);
         Line3:=TLineSeries.Create(nil);

         Chart2.ClearSeries;
         Line2.SeriesColor:=clBlue;
         Line3.SeriesColor:=clRed;

        for i:=1 to FFT1.SpectrumSize div 2 do
         Begin
         // Line3.AddXY(i,FFT1.Magnitude[i] * 250000);
          Line3.AddXY(FFT1.FreqOfLine(i,1/fmsp.Value),
                      FFT1.Magnitude[i] * 250000);
          Line2.AddXY(FFT1.FreqOfLine(i,1/fmsp.Value),FFT1.Phase[i]);
         end;

        Chart2.AddSeries(Line2);
        Chart2.AddSeries(Line3);

   end;


procedure TForm1.BitBtn_CloseClick(Sender: TObject);
begin
  Application.Terminate;
end;



end.

