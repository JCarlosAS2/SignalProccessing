unit wavelet_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, Wavelet, TAGraph, UTBaseFreqAnalisys, Cepstrum, TASeries;

type

  { Tform2 }

  Tform2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Cepstrum1: TCepstrum;
    Chart1: TChart;
    Chart2: TChart;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Wavelet1: TWavelet;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Expand(peven:Integer; pOld:Integer);
    procedure GroupBox4Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  form2: Tform2;

implementation

{$R *.lfm}

{ Tform2 }

procedure Tform2.FormCreate(Sender: TObject);
begin
end;


 procedure Tform2.Expand(peven:Integer; pOld:Integer);
     var
  Line: TLineSeries;
  Line1: TLineSeries;
  i:integer;
  size:longint;
  a:real ;
  d:real;
  data:PDouble;
  n:integer;
 begin
   Line:=TLineSeries.Create(Chart1);
   Line1:=TLineSeries.Create(Chart2);
   Line.SeriesColor:= clBlue;
   Line1.SeriesColor:=clBlue;
   Chart1.ClearSeries;
   a := 0;
   d := 0.01;

   size:=Wavelet1.SpectrumSize;

    for  n:=0 to size do begin

                      Array1D(Wavelet1.FData^)[n]  := sin(a);//EL ARREGLO ORIGNAL
                        a := a + d;
			d := d+ 0.005;
                       Line.Add(Array1D(Wavelet1.FData^)[n], '', clGreen);
                       Chart1.AddSeries(Line);
               end ;

          Wavelet1.WaveletAnalyze(size,Wavelet1.FData,peven,pOld,Wavelet1.FData);

              for  n:=0 to size do
		begin

                        Line1.Add(Array1D(Wavelet1.FData^)[n], '', clGreen);
                       Chart2.AddSeries(Line1);
		end;

   end;

 procedure Tform2.GroupBox4Click(Sender: TObject);
 begin

 end;


procedure Tform2.ComboBox1Change(Sender: TObject);
var
  c, b  : integer;
begin

  if ComboBox1.ItemIndex=0 then
  begin

     //c:=StrToInt(Edit1.Text);
     //b:=StrToInt(Edit2.Text);
     b:=Wavelet1.Modificar_Even;
     c:=Wavelet1.Modificar_Old;
    Expand(b,c);
    end;
  end;

procedure Tform2.BitBtn1Click(Sender: TObject);
begin

end;

procedure Tform2.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

end.

