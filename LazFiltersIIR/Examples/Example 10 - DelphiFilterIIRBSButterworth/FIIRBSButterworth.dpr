program FIIRBSButterworth;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter  Stop Band  Butterworth';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
