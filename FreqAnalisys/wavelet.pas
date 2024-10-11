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

unit Wavelet;

{$ifdef FPC}
 {$MODE delphi}{$H+}
{$endif}

interface

uses
  Classes, SysUtils,
  {$ifdef FPC}
   LResources,
  {$endif}
  Forms, Controls, Graphics,UTBaseFreqAnalisys, Msg, Vertices, Face;

type
  Tdata  = TDataFreqAnalizeType;
  TPdata = ^TDataFreqAnalizeType;

  TArrayData= array [0..0] of Tdata;
  PArrayData= ^TArrayData;


  ELoCompError = class(Exception);
  TWavelet = class(TBaseFreqAnalisys)
  private
     function GetOld(): integer;
     function GetEven(): integer;
     procedure SetOld (ndata: integer);
     procedure SetEven (ndata: integer);


     { Private declarations }
  protected
    { Protected declarations }
  public
      old: integer;
      even:integer;
     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
     procedure Transform;
     procedure WaveletAnalyzeStep(N:Integer; xin :PArrayData; peven :Real;  podd:Real; xout:PArrayData  );
     procedure WaveletAnalyze(N:longInt; xin:PArrayData; peven:Real; podd :Real; yout:PArrayData);
     function saveFileObj(filename: String; count:integer; vertices: array of TVertices): Boolean;
  published

  end;

procedure Register;

implementation
procedure TWavelet.Transform();
Begin
 WaveletAnalyze(SpectrumSize,FData,0,0,FData);
end;

procedure TWavelet.WaveletAnalyzeStep(N:Integer; xin :PArrayData; peven :Real;  podd:Real; xout:PArrayData  );
var
   norm:real;
   h:array[0..100] of real;
   counter: Integer;
   g:array[0..100] of real;
   yhigh:TPdata ;
   ylow:TPdata ;
   i:Integer;
   o: Integer;

begin

	// yhigh[k] = sum_n(x[n]*g[2k-n])
	// ylow[k]  = sum_n(x[n]*h[2k-n])

	// This example matrix multiplication shows what is going on

	// [yl0] = [h3 h2 h1 h0            ][x0]
	// [yl1] = [      h3 h2 h1 h0      ][x1]
	// [yl2] = [            h3 h2 h1 h0][x2]
	// [yl3] = [h1 h0             h3 h2][x3]
	// [yh0] = [g3 g2 g1 g0            ][x4]
	// [yh1] = [      g3 g2 g1 g0      ][x5]
	// [yh2] = [            g3 g2 g1 g0][x6]
	// [yh3] = [g1 g0             g3 g2][x7]

	// Initialize the scaling function and wavelet function and
	// normalize so that the integral of the scaling function is 2/sqrt(2).
	// This normalization is done so that the energy of the wavelet
	// function is equal on each step.
	 norm := 1.0/1.4142135623730951;
	 h[0] := peven*norm;
         h[1] :=(1-podd)*norm;
         h[2] := (1-peven)*norm;
         h[3]:=podd*norm;
	 g[0] := h[3];
         g[1] := -h[2];
         g[2] := h[1];
         g[3] := -h[0];


        yhigh:= @xout[N div 2];

 	ylow  := @xout[0];

	if N > 2  then

	begin

        i:=0;
        o:=0;

        while i< N-3 DO
                        begin


			//yhigh[o] :=xin^[i+0]*g[3] + xin^[i+1]*g[2] + xin^[i+2]*g[1] + xin^[i+3]*g[0];
			//ylow[o]  := xin^[i+0]*h[3] + xin^[i+1]*h[2] + xin^[i+2]*h[1] + xin^[i+3]*h[0];
                         i := i+ 2;
                         o:=o+1;

                         end;


		// The last one uses wrap around to not loose information
		//*yhigh[o] = xin[i+0]*g[3] + xin[i+1]*g[2] + xin[0]*g[1] + xin[1]*g[0];
		//ylow[o]  = xin[i+0]*h[3] + xin[i+1]*h[2] + xin[0]*h[1] + xin[1]*h[0]; */

	                 begin

		// Use wrap around to not loose information
		//yhigh [o]:= xin^[0]*g[3] + xin^[1]*g[2] + xin^[0]*g[1] + xin^[1]*g[0];
		//ylow [o] := xin^[0]*h[3] + xin^[1]*h[2] + xin^[0]*h[1] + xin^[1]*h[0];

        end;
        end;
end;

   procedure TWavelet.WaveletAnalyze(N:longInt; xin:PArrayData;  peven:Real; podd :Real; yout:PArrayData);
 var
	// xtmp1 : array  [0..2000] of real ;
         xtmp1:^TArrayData;
         xtmp2:^TArrayData;

        // xtmp1 :PDouble;
         //xtmp2 : PDouble;
	 //xtmp2 : array  [0..2000] of real;

	xswap:^TArrayData;
        i:Integer;
        c:Integer;
  //      FLine: TLineSeries;
        p:Real;
begin

        Getmem(xtmp1, N*sizeof(real));
        Getmem(xtmp2, N*sizeof(real));
        try



	// Copy input to temporary buffer
	for i := 0 to N do
	begin
 	       xtmp1^[i] := xin^[i];

	end;
	while( n > 1 ) do

	begin
	// Analyze signal
		WaveletAnalyzeStep(n, xtmp1, peven, podd, xtmp2);



		// Copy wavelet coefficients to output

		for  i := n div 2 to n do

			yout^[i] := xtmp2^[i];

		xswap := xtmp2; xtmp2 := xtmp1; xtmp1 := xswap;

		n := n div 2;


	end;


        finally
          Freemem(xtmp1,0);
          Freemem(xtmp2,0);

        end;
// Copy the last low frequency coefficient to output
	yout^[0] := xtmp1^[0];
end;


constructor TWavelet.Create(AOwner: TComponent);
begin
inherited Create (AOwner);

end;


destructor TWavelet.Destroy;
begin
 inherited Destroy;
end;


 function TWavelet.GetEven(): integer;
 begin
   Result:= even;
 end;

  function TWavelet.GetOld(): integer;
 begin
   Result:= old;
 end;
  procedure TWavelet.SetOld (ndata: integer);
  begin
    old:=ndata;
  end;

  procedure TWavelet.SetEven (ndata: integer);
  begin
   even :=ndata;
  end;
   function TWavelet.saveFileObj(filename: String; count:integer; vertices: array of TVertices): Boolean;

   var
  t1: Integer;
  t2: Integer;
  t3: Integer;
  t4: Integer;
  a: Integer;// cant de vertices
  b: Integer;// cant de faces
  i: Integer;// contador
  j: Integer;// contador

  header: String;
  Strvertice: String;
  Strface: String;
  Strnormales: String;
  StrCRLF: String;

  faces: array of TFace;
  face: TFace;

  fileStream : TFileStream;

begin
  a:= 0;
  b:= 0;
  StrCRLF:=#13#10;
  header:= '####'+StrCRLF+'# OBJ File Generated by wavelet' + StrCRLF + '####'+ StrCRLF + StrCRLF;
  Strnormales:= 'vn 1 1 1' + StrCRLF;


 //create file and write file header
 fileStream := TFileStream.Create(filename, fmCreate);
 fileStream.Write(PChar(header)^, Length(header));

 //escribir los vertices
 for i:=0 to count-1 do
 begin
  Strvertice:= 'v '+ FloatToStr(vertices[i].getx()) + ' ' + FloatToStr(vertices[i].gety()) + ' ' + FloatToStr(vertices[i].getz()) + StrCRLF;
  fileStream.Write(PChar(Strvertice)^, Length(Strvertice));
 end;

 //escribir las normales
 fileStream.Write(PChar(Strnormales)^, Length(Strnormales));

  //cerrar fichero
  fileStream.Destroy;

 Result:=true;

 end;

procedure Register;
begin
  RegisterComponents('LazSignalProc',[TWavelet]);
end;

initialization
{$I wavelet.lrs}

end.


