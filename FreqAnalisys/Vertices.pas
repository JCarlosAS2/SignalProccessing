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
unit Vertices;

{$mode objfpc}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs;

type
  TVertices = class(TObject)
  private
    x: double;
    y: double;
    z: double;

 public
 constructor Create();
 procedure setValor(newx, newy, newz: double);
 function getx():double;
 function gety():double;
 function getz():double;

end;

implementation
constructor TVertices.Create();
begin

   x:= 0;
   y:= 0;
   z:= 0;

end;
 procedure  TVertices.setValor(newx, newy, newz: double);
 begin

    x:= newx;
    y:= newy;
    z:= newz;

 end;
 function TVertices.getx():double;
 begin

   Result := x;

 end;
 function TVertices.gety():double;
 begin

   Result := y;

 end;
 function TVertices.getz():double;
 begin

   Result := z;

 end;

end.





