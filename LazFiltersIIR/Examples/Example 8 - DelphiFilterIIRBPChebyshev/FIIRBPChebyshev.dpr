program FIIRBPChebyshev;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter Band Pass Chebyshev';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
