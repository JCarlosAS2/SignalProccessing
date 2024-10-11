program FIIRLPButterworth;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter Low Pass Butterworth';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
