unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, memds, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Spin, TAGraph, TASeries, Filter,
  TATransformations, TADbSource, TAFuncSeries, FilterIIRBSChebyshev,
  FilterIIRHPChebyshev, FilterIIRLPChebyshev, FilterIIRBPChebyshev,
  FilterIIRLPButterworth, FilterIIRLPBessel, FilterIIRHPBessel,
  FilterIIRHPButterworth, FilterIIRBPBessel, FilterIIRBPButterworth,
  FilterIIRBSBessel, FilterIIRBSButterworth, FilterFirLPWin, FilterFirHPWin,
  FilterFirBPWin, FilterFirBSWin, FilterFIRWin, ASWinRectangular, ASWinHamming,
  ASWinTriangle, ASWinGauss, ASWinCos2, fourier, ASWinBlackman, ASWinHanning,
  ASWinKaiser, ASWinLanczos, ASWinTukey, ASWinBlackmanHarris, ASWinFlatTop,
  ASWinBohman, ASWinNuttall, ASWinBlackmanNuttall, ASWinParzen, types, Math;


type
   TSignalForm = (sfSine, sfSquare, sfTriangle);
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    BtnClose: TButton;
    Chart1: TChart;
    cbDBScale: TCheckBox;
    CBoxWin: TComboBox;

    lbWindowsFilterType: TLabel;
    seRipple: TSpinEdit;
    WinBlackman1: TWinBlackman;
    WinBlackmanHarris1: TWinBlackmanHarris;
    WinBlackmanNuttall1: TWinBlackmanNuttall;
    WinBohman1: TWinBohman;
    WinCos2_1: TWinCos2;
    Windows:TFFT;
    FilterFirBPWin1: TFilterFirBPWin;
    FilterFirBSWin1: TFilterFirBSWin;
    FilterFirHPWin1: TFilterFirHPWin;
    FilterFIRLPWin1: TFilterFIRLPWin;
    Series1: TLineSeries;
    FilterIIRBPBessel1: TFilterIIRBPBessel;
    FilterIIRBPButterworth1: TFilterIIRBPButterworth;
    FilterIIRBPChebyshev1: TFilterIIRBPChebyshev;
    FilterIIRBSBessel1: TFilterIIRBSBessel;
    FilterIIRBSButterworth1: TFilterIIRBSButterworth;
    FilterIIRBSChebyshev1: TFilterIIRBSChebyshev;
    FilterIIRHPBessel1: TFilterIIRHPBessel;
    FilterIIRHPButterworth1: TFilterIIRHPButterworth;
    FilterIIRHPChebyshev1: TFilterIIRHPChebyshev;
    FilterIIRLPBessel1: TFilterIIRLPBessel;
    FilterIIRLPButterworth1: TFilterIIRLPButterworth;
    FilterIIRLPChebyshev1: TFilterIIRLPChebyshev;
    FloatSpinEditFreqCut2: TFloatSpinEdit;
    FloatSpinEditSampleRate: TFloatSpinEdit;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    lbRipple: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    rgFilterType: TRadioGroup;
    rgFilterResponse: TRadioGroup;
    FloatSpinEditGain: TFloatSpinEdit;
    FloatSpinEditFreqCut1: TFloatSpinEdit;
    FilterPropertiesBox: TGroupBox;
    Label1: TLabel;
    lFilterFreq11: TLabel;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    seStartFreq: TSpinEdit;
    seStopFreq: TSpinEdit;
    seRes: TSpinEdit;
    SpinEditOrder: TSpinEdit;
    Gain: TStaticText;
    StatusBar1: TStatusBar;
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

    procedure Button1Click(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure CBoxWinChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgFilterTypeClick(Sender: TObject);
    procedure rgFilterTypeSelectionChanged(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure ConfigFilterTypeAndResponse();
    procedure SpinEditOrderChange(Sender: TObject);

  private

    SignalForm: TSignalForm;

    Salto, PointCount2 : Integer;

    GenericFilter : TFilter;
  public


  end; 

var
  Form1: TForm1; 

implementation

uses UOperator, UType;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  Application.Title:= 'Frequency Filter Response' ;
 end;

procedure TForm1.rgFilterTypeClick(Sender: TObject);
begin

end;


procedure TForm1.rgFilterTypeSelectionChanged(Sender: TObject);
begin
  //case chebyshev filter
  seRipple.Visible  := rgFilterType.ItemIndex=2;
  lbRipple.Visible  := rgFilterType.ItemIndex=2;

  //case FIR filter
  CBoxWin.visible             := rgFilterType.ItemIndex=3;
  lbWindowsFilterType.visible := rgFilterType.ItemIndex=3;


end;


procedure TForm1.Button1Click(Sender: TObject);
var
  I: Integer;
  Start, Stop, NumSteps: Integer;
  Amp, Delta : TAS_Sample;
  Frequency : TFreqType;
  item : Integer;
Begin
  ConfigFilterTypeAndResponse;

  GenericFilter.SampleRate := FloatSpinEditSampleRate.Value;
  GenericFilter.Gain       := FloatSpinEditGain.Value;
  GenericFilter.Order      := SpinEditOrder.Value;
  SpinEditOrder.Value      := GenericFilter.Order;

  if GenericFilter.ClassParent=TFilterFIRWin //If not
         then Begin
                item := CBoxWin.ItemIndex;
                case item of
                  0 : TFilterFIRWin(GenericFilter).WindowsType := WinRectangular1;
                  1 : TFilterFIRWin(GenericFilter).WindowsType := WinTriangle1;
                  2 : TFilterFIRWin(GenericFilter).WindowsType := WinGauss1;
                  3 : TFilterFIRWin(GenericFilter).WindowsType := WinBlackman1;
                  4 : TFilterFIRWin(GenericFilter).WindowsType := WinCos2_1;
                  5 : TFilterFIRWin(GenericFilter).WindowsType := WinHamming1;
                  6 : TFilterFIRWin(GenericFilter).WindowsType := WinHanning1;
                  7 : TFilterFIRWin(GenericFilter).WindowsType := WinKaiser1;
                  8 : TFilterFIRWin(GenericFilter).WindowsType := WinLanczos1;
                  9 : TFilterFIRWin(GenericFilter).WindowsType := WinTukey1;
                 10 : TFilterFIRWin(GenericFilter).WindowsType := WinBlackmanHarris1;
                 11 : TFilterFIRWin(GenericFilter).WindowsType := WinFlatTop1;
                 12 : TFilterFIRWin(GenericFilter).WindowsType := WinBohman1;
                 13 : TFilterFIRWin(GenericFilter).WindowsType := WinNuttall1;
                 14 : TFilterFIRWin(GenericFilter).WindowsType := WinBlackmanNuttall1;
                 15 : TFilterFIRWin(GenericFilter).WindowsType := WinParzen1;


                 else Begin
                       MessageDlg('No Valid Windows Type', mtInformation, [mbOK],0);
                       exit;
                      end; //Del else begin
                 end; // del case
               end;

  GenericFilter.SetupFilter();


  Start:= seStartFreq.value;
  Stop:=  Min(seStopFreq.Value, Round(GenericFilter.SampleRate / 2));

  NumSteps:= seRes.Value;

  Delta:= (Stop - Start) / numSteps;
  Series1.Clear;
  for I:= 0 to NumSteps - 1 do
  begin
    Frequency:= Start + Delta * I;
    Amp:= GenericFilter.GetFrequencyResponse(Frequency);

    if Amp < 1e-10 then Amp:= 1e-10;
    if cbDBScale.Checked then  Series1.AddXY(Frequency, log10(Amp)*20)   //DB scale
                         else  Series1.AddXY(Frequency, Amp);            //Normal scale
  end;


end;

procedure TForm1.BtnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;


procedure TForm1.CBoxWinChange(Sender: TObject);
 var
   item : Integer;
begin

end;


procedure TForm1.ConfigFilterTypeAndResponse();
var
  FilterType, FilterResponse : Integer;

begin
   FilterResponse:= rgFilterResponse.ItemIndex;
   FilterType    := rgFilterType.ItemIndex;

   case FilterResponse of
     0: Begin  //LowPass

        case FilterType of

          0: Begin  //Besel
                GenericFilter := FilterIIRLPBessel1;
             end;
          1: Begin  //Botterworth
                GenericFilter := FilterIIRLPButterworth1;
             end;
          2: Begin  //Chebyshev
                GenericFilter := FilterIIRLPChebyshev1;
                TFilterIIRLPChebyshev(GenericFilter).Ripple:=seRipple.Value;
             end;
          3: Begin  //FIR
               GenericFilter := FilterFIRLPWin1;
             end;

         end; //FilterType
       end;   //LowPass

     1: Begin  //HigPass
       case FilterType of
         0: Begin  //Besel
                GenericFilter := FilterIIRHPBessel1;
            end;
         1: Begin  //Botterworth
                GenericFilter := FilterIIRHPButterworth1;
            end;
         2: Begin  //Chebyshev
                GenericFilter := FilterIIRHPChebyshev1;
                TFilterIIRHPChebyshev(GenericFilter).Ripple:=seRipple.Value;
            end;
         3: Begin  //FIR
               GenericFilter := FilterFirHPWin1;
             end;

        end; //FilterType
       end;  //HigPass

     2: Begin //BandPass
         case FilterType of
          0: Begin  //Besel
                GenericFilter := FilterIIRBPBessel1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
             end;
          1: Begin  //Botterworth
                GenericFilter := FilterIIRBPButterworth1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
             end;
          2: Begin  //Chebyshev
                GenericFilter := FilterIIRBPChebyshev1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
                 TFilterIIRBPChebyshev(GenericFilter).Ripple:=seRipple.Value;
             end;
          3: Begin  //FIR
               GenericFilter := FilterFirBPWin1;
               GenericFilter.FreqCut[2]:= FloatSpinEditFreqCut2.Value;
             end;

         end; //FilterType
       end;   //BandPass

     3: Begin //BandStop
         case FilterType of
          0: Begin  //Besel
                GenericFilter := FilterIIRBSBessel1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
             end;
          1: Begin  //Botterworth
                GenericFilter := FilterIIRBSButterworth1;
                GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
             end;
          2: Begin  //Chebyshev
               GenericFilter := FilterIIRBSChebyshev1;
                GenericFilter.FreqCut[1] := FloatSpinEditFreqCut1.Value;
               GenericFilter.FreqCut[2] := FloatSpinEditFreqCut2.Value;
               TFilterIIRBSChebyshev(GenericFilter).Ripple:=seRipple.Value;
             end;
          3: Begin  //FIR
               GenericFilter := FilterFirBSWin1;
               GenericFilter.FreqCut[2]:= FloatSpinEditFreqCut2.Value;
             end;

         end; //FilterType
       end;  //StopPass
   end; //Case externo

   GenericFilter.FreqCut[1] := FloatSpinEditFreqCut1.Value;


end;

procedure TForm1.SpinEditOrderChange(Sender: TObject);
begin

end;


procedure TForm1.ScrollBox1Click(Sender: TObject);
begin
  //No borrar   Not Delete
end;


end.

