program FIIRHPChebyshev;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter Higth Pass Chebyshev';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
