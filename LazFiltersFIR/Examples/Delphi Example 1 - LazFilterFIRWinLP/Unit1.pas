unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, StdCtrls, ComCtrls, Spin,
  Series, ASWinBlackman, ASWinBlackmanHarris, ASWinBlackmanNuttall,
  ASWinBohman, ASWinCos2, ASWinFlatTop, ASWinGauss, ASWinHamming,
  ASWinHanning, ASWinKaiser, ASWinLanczos, ASWinNuttall, ASWinParzen,
  ASWinRectangular, ASWinTriangle, ASWinBase, ASWinTukey;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    Bevel1: TBevel;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    Chart1: TChart;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    rbSin: TRadioButton;
    rbSquare: TRadioButton;
    rbTriangle: TRadioButton;
    SpinEditFreq: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    lFreq1: TLabel;
    lAmp: TLabel;
    lSampleRate: TLabel;
    Label4: TLabel;
    CBoxWin: TComboBox;
    SpinEdit1: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    lWin: TLabel;
    lOrden: TLabel;
    lFreqCurt: TLabel;
    lGain: TLabel;
    btnClose: TButton;
    Series1: TFastLineSeries;
    Series2: TLineSeries;
    WinTukey1: TWinTukey;
    WinTriangle1: TWinTriangle;
    WinRectangular1: TWinRectangular;
    WinParzen1: TWinParzen;
    WinNuttall1: TWinNuttall;
    WinLanczos1: TWinLanczos;
    WinKaiser1: TWinKaiser;
    WinHanning1: TWinHanning;
    WinHamming1: TWinHamming;
    WinGauss1: TWinGauss;
    WinFlatTop1: TWinFlatTop;
    WinCos21: TWinCos2;
    WinBohman1: TWinBohman;
    WinBlackmanNuttall1: TWinBlackmanNuttall;
    WinBlackmanHarris1: TWinBlackmanHarris;
    WinBlackman1: TWinBlackman;
    Timer1: TTimer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
