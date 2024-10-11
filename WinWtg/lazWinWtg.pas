{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit LazWinWtg;

interface

uses
  ASWinBase, ASWinRectangular, ASWinTriangle, ASWinBlackman, ASWinHamming, 
  ASWinCos2, ASWinHanning, ASWinLanczos, ASWinTukey, ASWinKaiser, 
  ASWinBlackmanHarris, ASWinBohman, ASWinNuttall, ASWinGauss, 
  ASWinBlackmanNuttall, ASWinFlattop, ASWinParzen, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ASWinRectangular', @ASWinRectangular.Register);
  RegisterUnit('ASWinTriangle', @ASWinTriangle.Register);
  RegisterUnit('ASWinBlackman', @ASWinBlackman.Register);
  RegisterUnit('ASWinHamming', @ASWinHamming.Register);
  RegisterUnit('ASWinCos2', @ASWinCos2.Register);
  RegisterUnit('ASWinHanning', @ASWinHanning.Register);
  RegisterUnit('ASWinLanczos', @ASWinLanczos.Register);
  RegisterUnit('ASWinTukey', @ASWinTukey.Register);
  RegisterUnit('ASWinKaiser', @ASWinKaiser.Register);
  RegisterUnit('ASWinBlackmanHarris', @ASWinBlackmanHarris.Register);
  RegisterUnit('ASWinBohman', @ASWinBohman.Register);
  RegisterUnit('ASWinNuttall', @ASWinNuttall.Register);
  RegisterUnit('ASWinGauss', @ASWinGauss.Register);
  RegisterUnit('ASWinBlackmanNuttall', @ASWinBlackmanNuttall.Register);
  RegisterUnit('ASWinFlattop', @ASWinFlattop.Register);
  RegisterUnit('ASWinParzen', @ASWinParzen.Register);
end;

initialization
  RegisterPackage('LazWinWtg', @Register);
end.
