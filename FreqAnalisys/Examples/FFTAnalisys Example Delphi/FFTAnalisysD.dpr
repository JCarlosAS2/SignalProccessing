program FFTAnalisysD;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMain in 'UMain.pas' {Form1},
  UTBaseFreqAnalisys in '..\..\UTBaseFreqAnalisys.pas',
  fourier in '..\..\fourier.pas',
  Msg in '..\..\Msg.pas',
  ASWinBase in '..\..\..\WinWtg\ASWinBase.pas',
  ASWinBlackman in '..\..\..\WinWtg\ASWinBlackman.pas',
  ASWinBlackmanHarris in '..\..\..\WinWtg\ASWinBlackmanHarris.pas',
  ASWinBlackmanNuttall in '..\..\..\WinWtg\ASWinBlackmanNuttall.pas',
  ASWinBohman in '..\..\..\WinWtg\ASWinBohman.pas',
  ASWinCos2 in '..\..\..\WinWtg\ASWinCos2.pas',
  ASWinFlattop in '..\..\..\WinWtg\ASWinFlattop.pas',
  ASWinGauss in '..\..\..\WinWtg\ASWinGauss.pas',
  ASWinHamming in '..\..\..\WinWtg\ASWinHamming.pas',
  ASWinHanning in '..\..\..\WinWtg\ASWinHanning.pas',
  ASWinKaiser in '..\..\..\WinWtg\ASWinKaiser.pas',
  ASWinLanczos in '..\..\..\WinWtg\ASWinLanczos.pas',
  ASWinNuttall in '..\..\..\WinWtg\ASWinNuttall.pas',
  ASWinParzen in '..\..\..\WinWtg\ASWinParzen.pas',
  ASWinRectangular in '..\..\..\WinWtg\ASWinRectangular.pas',
  ASWinTriangle in '..\..\..\WinWtg\ASWinTriangle.pas',
  ASWinTukey in '..\..\..\WinWtg\ASWinTukey.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
