unit UBasura2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  FilterIIRPBChebyshev,
  FilterIIRPBandButterworth,
  FilterIIRPBandChebyshev,
  FilterIIRPAButterworth,
  FilterIIRSBand, FilterIIRPBandBessel,
  FilterIIRSBandBessel,
  FilterIIRSBandButterworth,
  FilterIIRSBandChebyshev;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  kk,kk2,kk3, kk4 : TFilterIIRSBandChebyshev;
begin
  kk:= TFilterIIRSBandChebyshev.create(nil);
 // kk2:= TFilterIIRSBandBessel.create(nil);


  //kk.free;
  //kk2.free;
end;

end.

