{*********************************************************}
{                                                         }
{         AntillaSoft Signal Processing Component         }
{                Frequency Analysis Components            }
{                                                         }
{*********************************************************}

{*********************************************************}
{    Copyright (c) 2005-2012 AntillaSoft                  }
{                                                         }
{ License Agreement:                                      }
{                                                         }
{ This library is distributed AS IS, with the hope that   }
{ it will be useful, but WITHOUT ANY WARRANTY; without    }
{ even the implied warranty of MERCHANTABILITY or FITNESS }
{ FOR A PARTICULAR PURPOSE.                               }
{                                                         }
{ Please read the file License.txt before use this        }
{ Component.                                              }
{                                                         }
{ The project web site is located on:                     }
{   http://www.antillasoft.com                            }
{                                                         }
{                          AntillaSoft Development Group. }
{*********************************************************}
unit Cepstrum;



{$ifdef FPC}
  {$MODE delphi}{$H+}
{$endif}

interface

uses
   {$ifdef FPC}
  LResources,
  {$endif} Classes, SysUtils, Fourier;


type
TCepstrum = class (TFFT)
    public

       constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
       procedure Transform;
       procedure Cepstrum;

 end;

procedure Register;


implementation

constructor TCepstrum.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
end;

destructor TCepstrum.Destroy;
begin
  inherited Destroy;
end;

procedure TCepstrum.Transform;
begin
  inherited Transform;
end;

procedure TCepstrum.Cepstrum;
var
  i, n: integer;

begin
  n:= SpectrumSize; {pot. de 2, con minValue = 4, maxValue = 16 millones de ptos}  
  Transform;
  ClearImag; {pongo a cero la parte imaginaria}
  for i:= 1 to n do
    begin
         if (RealSpec[i]> 0) then
        RealSpec[i]:= ln(RealSpec[i]);
    end;
  InverseTransform;
end;


procedure Register;
begin
  RegisterComponents('LazSignalProc',[TCepstrum]);
end;

initialization

{$ifdef FPC}
 {$I TCepstrum.lrs}
{$endif}

end.

