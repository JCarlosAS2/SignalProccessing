program FIIRHPBessel;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter Higth Pass Bessel';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
