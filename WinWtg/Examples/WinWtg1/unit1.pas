unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TALegendPanel, TAFuncSeries,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Spin, ExtCtrls,
  ASWinRectangular, ASWinTriangle, ASWinGauss, ASWinHamming,
  ASWinBlackman, ASWinCos2, ASWinHanning, ASWinLanczos, ASWinTukey, ASWinKaiser,
  ASWinBlackmanHarris, ASWinFlatTop, ASWinBohman, ASWinNuttall,
  ASWinBlackmanNuttall, ASWinParzen, ASWinBase;

type

  { TForm1 }

  TForm1 = class(TForm)
    btClear: TButton;
    btClose: TButton;
    BtnClose: TButton;
    Chart1: TChart;
    BlackmanHarrisSeries: TLineSeries;
    BohmanSeries: TLineSeries;
    BlackmanNuttallSeries: TLineSeries;
    Label1: TLabel;
    lbOrden: TLabel;
    ParzenSeries: TLineSeries;
    NuttallSeries: TLineSeries;
    FlatTopSeries: TLineSeries;
    ChartLegendPanel1: TChartLegendPanel;
    spOrder: TSpinEdit;
    TriangularSerie: TLineSeries;
    GaussSerie: TLineSeries;
    BlackManSerie: TLineSeries;
    Cos2Serie: TLineSeries;
    HammingSerie: TLineSeries;
    HanningSerie: TLineSeries;
    KaisserSerie: TLineSeries;
    LanczosSeries: TLineSeries;
    TukeySeries: TLineSeries;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lbOrder: TLabel;
    RectangularSerie: TLineSeries;
    WinBlackman1: TWinBlackman;
    WinBlackmanHarris1: TWinBlackmanHarris;
    WinBlackmanNuttall1: TWinBlackmanNuttall;
    WinBohman1: TWinBohman;
    WinCos2_1: TWinCos2;
    WinFlatTop1: TWinFlatTop;
    WinFlatTop2: TWinFlatTop;
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
    procedure btClearClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);

  private
    { private declarations }
    WinBase : TWinBase;
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{$R *.lfm}

{ TForm1 }
type
  TDataType = Real;  //quitar esta linea y ....
  TWinBuffer = array of TDataType; //Cambiar el nombre de  "TDataType" por el tipo de dato que la china definio para las muestras de la señal.


procedure TForm1.ComboBox1Change(Sender: TObject);
var
  i, Order : Integer;
  y : Double;
begin

   TLineSeries(Chart1.Series.Items[ComboBox1.ItemIndex ]).Clear;
   Order := spOrder.Value;



   case ComboBox1.ItemIndex of
    0 : WinBase := WinRectangular1;
    1 : WinBase := WinTriangle1;
    2 : WinBase := WinGauss1;
    3 : WinBase := WinBlackman1;
    4 : WinBase := WinCos2_1;
    5 : WinBase := WinHamming1;
    6 : WinBase := WinHanning1;
    7 : WinBase := WinKaiser1;
    8 : WinBase := WinLanczos1;
    9 : WinBase := WinTukey1;
   10 : WinBase := WinBlackmanHarris1;
   11 : WinBase := WinFlatTop1;
   12 : WinBase := WinBohman1;
   13 : WinBase := WinNuttall1;
   14 : WinBase := WinBlackmanNuttall1;
   15 : WinBase := WinParzen1;

   else Begin
         MessageDlg('Opción no implementada aún', mtInformation, [mbOK],0);
         exit;
        end; //Del else begin
   end; // del case

    WinBase.Order := Order;
   //Visualizando grafico
   for i := 0 to  Order-1  do
      Begin
        y:= WinBase.W[i];
        TLineSeries(Chart1.Series.Items[ComboBox1.ItemIndex ]).AddXY(i, y, '', clBlue);
      end;

end;

procedure TForm1.btClearClick(Sender: TObject);
var
  i : Integer;
begin
   For i:= 0 to Chart1.Series.Count - 1 do
     TLineSeries(Chart1.Series.Items[i]).Clear;
end;

procedure TForm1.BtnCloseClick(Sender: TObject);
begin
     Application.Terminate;
end;


end.

