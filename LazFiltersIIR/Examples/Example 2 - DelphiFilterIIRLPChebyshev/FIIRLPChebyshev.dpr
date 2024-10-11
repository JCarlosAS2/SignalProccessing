program FIIRLPChebyshev;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter Low Pass Chebyshev';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
