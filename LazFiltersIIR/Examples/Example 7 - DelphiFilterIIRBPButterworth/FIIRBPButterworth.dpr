program FIIRBPButterworth;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter Band Pass Butterworth';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
