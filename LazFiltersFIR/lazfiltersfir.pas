{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit LazFiltersFIR;

interface

uses
  FilterFirWin, FilterFIR, FilterFirLPWin, FilterFirHPWin, FilterFirBPWin, 
  FilterFirBSWin, ASCircBuffer, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('FilterFirLPWin', @FilterFirLPWin.Register);
  RegisterUnit('FilterFirHPWin', @FilterFirHPWin.Register);
  RegisterUnit('FilterFirBPWin', @FilterFirBPWin.Register);
  RegisterUnit('FilterFirBSWin', @FilterFirBSWin.Register);
end;

initialization
  RegisterPackage('LazFiltersFIR', @Register);
end.
