program FIIRBSChebyshev;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter Band Stop Chebyshev';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
