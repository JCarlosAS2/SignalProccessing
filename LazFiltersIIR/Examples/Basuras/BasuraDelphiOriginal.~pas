unit BasuraDelphiOriginal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Filter, FilterIIR, FilterIIRSBand,
   FilterIIRSBandBessel,
   FilterIIRSBandChebyshev, dspIIRFilters;

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
  // KK:TdspIIRFilter;
    kk,kk2,kk3, kk4 : TFilterIIRSBandChebyshev;

begin

  //KK:= dspIIRFilter1.Create(nil);
  
  (*
    TdspIIRFilterKind = (fkButterworth, fkChebyshev, fkBessel);
  TdspIIRFilterResponse = (ftLowpass, ftHighpass, ftBandpass, ftBandstop);
  *)
  kk:= TFilterIIRSBandChebyshev.create(nil);

  //kk2:= TFilterIIRSBandBessel.create(nil);



end;

end.
