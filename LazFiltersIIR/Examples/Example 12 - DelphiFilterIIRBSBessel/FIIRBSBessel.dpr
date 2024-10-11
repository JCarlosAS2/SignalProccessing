program FIIRBSBessel;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter Band Stop Bessel';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
