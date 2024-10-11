unit BasuraDelphi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Filter, FilterIIR, FilterIIRSBand,
   FilterIIRSBandBessel,
   FilterIIRSBandButterworth, dspIIRFilters;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  kk,kk2,kk3, kk4 : TFilterIIRSBandButterworth;
  F: TdspIIRFilter;
begin
  F:= TdspIIRFilter.Create(nil);
  F.Kind := fkChebyshev;
  F.Response := ftBandstop;


  (*
    TdspIIRFilterKind = (fkButterworth, fkChebyshev, fkBessel);
  TdspIIRFilterResponse = (ftLowpass, ftHighpass, ftBandpass, ftBandstop);
  *)
  //kk:= TFilterIIRSBandButterworth.create(nil);
  //kk2:= TFilterIIRSBandBessel.create(nil);


  //kk.free;
  //kk2.free;

end;

end.
 