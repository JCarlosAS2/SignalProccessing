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
unit Face;

{$mode objfpc}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs;

type
  TFace = class(TObject)
  private
    at1: Integer;
    at2: Integer;
    at3: Integer;
    at4: Integer;

 public
 constructor Create();
 procedure setValor(new1, new2, new3, new4: Integer);
 function get1():Integer;
 function get2():Integer;
 function get3():Integer;
 function get4():Integer;

end;

implementation
constructor TFace.Create();
begin

  at1:= 0;
  at2:= 0;
  at3:= 0;
  at4:= 0;

end;
procedure TFace.setValor(new1, new2, new3, new4: Integer);
begin

   at1:= new1;
   at2:= new2;
   at3:= new3;
   at4:= new4;

end;
function TFace.get1():Integer;
begin

  Result := at1;

end;
function TFace.get2():Integer;
begin

  Result := at2;

end;
function TFace.get3():Integer;
begin

  Result := at3;

end;
function TFace.get4():Integer;
 begin

  Result := at4;

 end;
end.
