unit Unit_Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, Fourier, ASWinRectangular, TAGraph, TASeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    BButReset: TBitBtn;
    BButTriangle: TBitBtn;
    BButHalfSine: TBitBtn;
    BButSaw: TBitBtn;
    BButSquare: TBitBtn;
    BitBtn_Close: TBitBtn;
    Chart1: TChart;
    FFT1: TFFT;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ScrollBar1: TScrollBar;
    ScrollBar11: TScrollBar;
    ScrollBar12: TScrollBar;
    ScrollBar13: TScrollBar;
    ScrollBar14: TScrollBar;
    ScrollBar15: TScrollBar;
    ScrollBar16: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    ScrollBar5: TScrollBar;
    ScrollBar6: TScrollBar;
    ScrollBar7: TScrollBar;
    ScrollBar8: TScrollBar;
    ScrollBar10: TScrollBar;
    WinRectangular1: TWinRectangular;
    procedure BButHalfSineClick(Sender: TObject);
    procedure BButResetClick(Sender: TObject);
    procedure BButSawClick(Sender: TObject);
    procedure BButSquareClick(Sender: TObject);
    procedure BButTriangleClick(Sender: TObject);
    procedure BitBtn_CloseClick(Sender: TObject);
    procedure ScrollBar8Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

var
  UpDateSignal : boolean;

{$R *.lfm}

{ TForm1 }

procedure TForm1.ScrollBar8Change(Sender: TObject);
var
  i: integer;
  Line1: TLineSeries;
begin
  FFT1.Clear;
  FFT1.RealSpec[1] := -ScrollBar1.Position/100*FFT1.SpectrumSize;
  FFT1.RealSpec[2] := -ScrollBar2.Position/100*FFT1.SpectrumSize;
  FFT1.RealSpec[3] := -ScrollBar3.Position/100*FFT1.SpectrumSize;
  FFT1.RealSpec[4] := -ScrollBar4.Position/100*FFT1.SpectrumSize;
  FFT1.RealSpec[5] := -ScrollBar5.Position/100*FFT1.SpectrumSize;
  FFT1.RealSpec[6] := -ScrollBar6.Position/100*FFT1.SpectrumSize;
  FFT1.RealSpec[7] := -ScrollBar7.Position/100*FFT1.SpectrumSize;
  FFT1.RealSpec[8] := -ScrollBar8.Position/100*FFT1.SpectrumSize;

  FFT1.ImagSpec[2] := -ScrollBar10.Position/100*FFT1.SpectrumSize;
  FFT1.ImagSpec[3] := -ScrollBar11.Position/100*FFT1.SpectrumSize;
  FFT1.ImagSpec[4] := -ScrollBar12.Position/100*FFT1.SpectrumSize;
  FFT1.ImagSpec[5] := -ScrollBar13.Position/100*FFT1.SpectrumSize;
  FFT1.ImagSpec[6] := -ScrollBar14.Position/100*FFT1.SpectrumSize;
  FFT1.ImagSpec[7] := -ScrollBar15.Position/100*FFT1.SpectrumSize;
  FFT1.ImagSpec[8] := -ScrollBar16.Position/100*FFT1.SpectrumSize;
  if UpdateSignal then
    begin
      FFT1.InverseTransform;
      Line1:= TLineSeries.Create(Nil);

      Chart1.ClearSeries;

      Line1.SeriesColor:= clBlue;


      for i:=1 to 256 do
         // Line1.AddXY(i,FFT1.RealSpec[1 + (i-1) mod 256]);
          Line1.AddXY(i,FFT1.RealSpec[i]);
            for i:=1 to 256 do
         // Line1.AddXY(i,FFT1.RealSpec[1 + (i-1) mod 256]);
          Line1.AddXY(i+256,FFT1.RealSpec[i]);
       Chart1.AddSeries(Line1);
    end;
end;

procedure TForm1.BButResetClick(Sender: TObject);
begin
  UpdateSignal := False;
ScrollBar1.Position := 0;
ScrollBar2.Position := 0;
ScrollBar3.Position := 0;
ScrollBar4.Position := 0;
ScrollBar5.Position := 0;
ScrollBar6.Position := 0;
ScrollBar7.Position := 0;
ScrollBar8.Position := 0;
ScrollBar10.Position := 0;
ScrollBar11.Position := 0;
ScrollBar12.Position := 0;
ScrollBar13.Position := 0;
ScrollBar14.Position := 0;
ScrollBar15.Position := 0;
ScrollBar16.Position := 0;
UpdateSignal := True;
Scrollbar8Change (Sender);
end;

procedure TForm1.BButHalfSineClick(Sender: TObject);
begin
  UpdateSignal := false;
ScrollBar1.Position := -32;
ScrollBar2.Position := -50;
ScrollBar3.Position := -21;
ScrollBar4.Position := 0;
ScrollBar5.Position := 4;
ScrollBar6.Position := 0;
ScrollBar7.Position := -2;
ScrollBar8.Position := 0;
ScrollBar10.Position := 0;
ScrollBar11.Position := 0;
ScrollBar12.Position := 0;
ScrollBar13.Position := 0;
ScrollBar14.Position := 0;
ScrollBar15.Position := 0;
ScrollBar16.Position := 0;
UpdateSignal := true;
Scrollbar8Change (Sender);
end;

procedure TForm1.BButSawClick(Sender: TObject);
begin
  UpdateSignal := false;
ScrollBar1.Position := 0;
ScrollBar2.Position := 0;
ScrollBar3.Position := 0;
ScrollBar4.Position := 0;
ScrollBar5.Position := 0;
ScrollBar6.Position := 0;
ScrollBar7.Position := 0;
ScrollBar8.Position := 0;
ScrollBar10.Position := -64;
ScrollBar11.Position := -32;
ScrollBar12.Position := -21;
ScrollBar13.Position := -16;
ScrollBar14.Position := -13;
ScrollBar15.Position := -11;
ScrollBar16.Position := -9;
UpdateSignal := true;
Scrollbar8Change (Sender);
end;

procedure TForm1.BButSquareClick(Sender: TObject);
begin
  UpdateSignal := false;
ScrollBar1.Position := 0;
ScrollBar2.Position := -100;
ScrollBar3.Position := 0;
ScrollBar4.Position := 33;
ScrollBar5.Position := 0;
ScrollBar6.Position := -20;
ScrollBar7.Position := 0;
ScrollBar8.Position := 16;
ScrollBar10.Position := 0;
ScrollBar11.Position := 0;
ScrollBar12.Position := 0;
ScrollBar13.Position := 0;
ScrollBar14.Position := 0;
ScrollBar15.Position := 0;
ScrollBar16.Position := 0;
UpdateSignal := true;
Scrollbar8Change (Sender);
end;

procedure TForm1.BButTriangleClick(Sender: TObject);
begin
  UpdateSignal := False;
ScrollBar1.Position := 0;
ScrollBar2.Position := 0;
ScrollBar3.Position := 0;
ScrollBar4.Position := 0;
ScrollBar5.Position := 0;
ScrollBar6.Position := 0;
ScrollBar7.Position := 0;
ScrollBar8.Position := 0;
ScrollBar10.Position := -81;
ScrollBar11.Position := 0;
ScrollBar12.Position := 9;
ScrollBar13.Position := 0;
ScrollBar14.Position := -3;
ScrollBar15.Position := 0;
ScrollBar16.Position := 2;
UpdateSignal := True;
Scrollbar8Change (Sender);
end;

procedure TForm1.BitBtn_CloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

