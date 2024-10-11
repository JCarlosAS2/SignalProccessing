unit Unit_Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, Menus, ComCtrls, Fourier, Cepstrum, TAGraph, TASeries,
  UTBaseFreqAnalisys, Wavelet, ASWinRectangular, ASWinGauss, ASWinTriangle,
  ASWinBlackman, ASWinHamming, ASWinCos2;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtnReset: TBitBtn;
    BitBtnClose: TBitBtn;
    CBoxWind: TComboBox;
    Cepstrum1: TCepstrum;
    Chart1: TChart;
    Chart2: TChart;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    SBFreq1: TScrollBar;
    ScrollBar1: TScrollBar;
    WinBlackman1: TWinBlackman;
    WinCos2_1: TWinCos2;
    WinGauss1: TWinGauss;
    WinHamming1: TWinHamming;
    WinRectangular1: TWinRectangular;
    WinTriangle1: TWinTriangle;
    procedure BitBtnCloseClick(Sender: TObject);
    procedure BitBtnResetClick(Sender: TObject);
    procedure CBoxWindChange(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure GroupBox4Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure SBFreq1Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    //procedure Expand(peven:Integer; pOld:Integer);
  private
    { private declarations }
    procedure StartFFT;
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  StartFFT;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Cepstrum1.Clear;
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
  StartFFT;
end;

procedure TForm1.GroupBox4Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin

end;

procedure TForm1.SBFreq1Change(Sender: TObject);
begin
  StartFFT;
end;

procedure TForm1.BitBtnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.BitBtnResetClick(Sender: TObject);
begin
  ScrollBar1.Position:= 50;
  SBFreq1.Position:= 50;
end;

procedure TForm1.CBoxWindChange(Sender: TObject);
begin
  case CBoxWind.ItemIndex of
    0 : Cepstrum1.WgtWin := WinRectangular1;// fwRectangle;
    1 : Cepstrum1.WgtWin := WinTriangle1;
    2 : Cepstrum1.WgtWin := WinGauss1;
    3 : Cepstrum1.WgtWin := WinBlackman1;
    4 : Cepstrum1.WgtWin := WinCos2_1;
    5 : Cepstrum1.WgtWin := WinHamming1
   else Begin
         MessageDlg('Opción no implementada aún', mtInformation, [mbOK],0);
         exit;
        end; //Del else begin
   end; // del case

   StartFFT;
end;



procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  end;

{******************************************************************************}


procedure TForm1.StartFFT;
var
  i, j      : integer;
  y, z      : double;
  Line: TLineSeries;
  Line1: TLineSeries;
  kk : Integer;
begin
  Line:= TLineSeries.Create(Nil);
  Line.SeriesColor:= clBlue;
  Chart1.ClearSeries;

  Line1:= TLineSeries.Create(Nil);
  Line1.SeriesColor:= clRed;
  Chart2.ClearSeries;

 // kk :=Cepstrum1.SpectrumSize;

  Cepstrum1.ClearImag;
  //FFT1.SpectrumSize := 1024;
  for i:=1 to Cepstrum1.SpectrumSize do
     begin
       y := 10*(sin(0.01*i*(100-SbFreq1.Position))+sin(0.075*i)+cos(0.5*i)+
          0.06*(random(100-ScrollBar1.Position)-0.5*(100-ScrollBar1.Position)));

          {otras señales inventadas por mi}
       //y:= 15*(sin(0.03*i*(100-SBFreq1.Position))+cos(0.048*i)+cos(0.7*i)+
       //     0.01*(Random(100-ScrollBar1.Position)-0.8*(100-ScrollBar1.Position)));

       //y:= 30*(cos(0.08*i*(100-SBFreq1.Position))+cos(0.035*i)+cos(0.3*i)+
       //     0.09*(Random(100-ScrollBar1.Position)-0.2*(100-ScrollBar1.Position)));

        Cepstrum1.RealSpec[i] := y;           { real value }
        Line.AddXY(i, y);
     end;
  Cepstrum1.Cepstrum;
  for j:=1 to Cepstrum1.SpectrumSize do
     begin
      z:= Cepstrum1.RealSpec[j];
      Line1.AddXY(j, z);
     end;

  Chart1.AddSeries(Line);
Chart2.AddSeries(Line1);
end;
{*******************************************************************************}

{$R *.lfm}

end.

