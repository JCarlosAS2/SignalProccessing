unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Series, TeEngine, TeeProcs, Chart, StdCtrls, Spin,
  ASWinTukey, ASWinTriangle, ASWinRectangular, ASWinParzen,
  ASWinNuttall, ASWinLanczos, ASWinKaiser, ASWinHanning, ASWinHamming,
  ASWinGauss, ASWinFlatTop, ASWinCos2, ASWinBohman, ASWinBlackmanNuttall,
  ASWinBlackmanHarris, ASWinBase, ASWinBlackman;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Chart1: TChart;
    Bevel1: TBevel;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    btClear: TButton;
    BtnClose: TButton;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Series7: TLineSeries;
    Series8: TLineSeries;
    Series9: TLineSeries;
    Series10: TLineSeries;
    Series11: TLineSeries;
    Series12: TLineSeries;
    Series13: TLineSeries;
    Series14: TLineSeries;
    Series15: TLineSeries;
    Series16: TLineSeries;
    ComboBox1: TComboBox;
    spOrder: TSpinEdit;
    WinBlackman1: TWinBlackman;
    WinBlackmanHarris1: TWinBlackmanHarris;
    WinBlackmanNuttall1: TWinBlackmanNuttall;
    WinBohman1: TWinBohman;
    WinCos21: TWinCos2;
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

    procedure ComboBox1Change(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);

 private
    { private declarations }
       WinBase: TWinBase;
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{$R *.dfm}

 { TForm1 }
type
  TDataType = Real;  //quitar esta linea y ....
  TWinBuffer = array of TDataType; //Cambiar el nombre de  "TDataType" por el tipo de dato que la china definio para las muestras de la señal.

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  i, Order : Integer;
  y : Double;
begin

   TLineSeries(Chart1.SeriesList.Items[ComboBox1.ItemIndex ]).Clear;
   Order := spOrder.Value;

   case ComboBox1.ItemIndex of
    0 : WinBase := WinRectangular1;
    1 : WinBase := WinTriangle1;
    2 : WinBase := WinGauss1;
    3 : WinBase := WinBlackman1;
    4 : WinBase := WinCos21;
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
        TLineSeries(Chart1.SeriesList.Items[ComboBox1.ItemIndex ]).AddXY(i, y, '', clBlue);
      end;

end;

procedure TForm1.btClearClick(Sender: TObject);
var
  i : Integer;
begin
   For i:= 0 to Chart1.SeriesList.Count - 1 do
     TLineSeries(Chart1.SeriesList.Items[i]).Clear;
end;

procedure TForm1.BtnCloseClick(Sender: TObject);
begin
     Application.Terminate;
end;

end.
