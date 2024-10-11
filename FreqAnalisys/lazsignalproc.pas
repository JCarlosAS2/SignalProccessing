{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit lazsignalproc;

interface

uses
  Cepstrum, Fourier, Msg, UTBaseFreqAnalisys, Wavelet, udct, UDCTF, UDCT_1, 
  UDCT_2, UDCT_3, UDCT_4, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('Cepstrum', @Cepstrum.Register);
  RegisterUnit('Fourier', @Fourier.Register);
  RegisterUnit('Wavelet', @Wavelet.Register);
  RegisterUnit('udct', @udct.Register);
  RegisterUnit('UDCTF', @UDCTF.Register);
  RegisterUnit('UDCT_1', @UDCT_1.Register);
  RegisterUnit('UDCT_2', @UDCT_2.Register);
  RegisterUnit('UDCT_3', @UDCT_3.Register);
  RegisterUnit('UDCT_4', @UDCT_4.Register);
end;

initialization
  RegisterPackage('lazsignalproc', @Register);
end.
