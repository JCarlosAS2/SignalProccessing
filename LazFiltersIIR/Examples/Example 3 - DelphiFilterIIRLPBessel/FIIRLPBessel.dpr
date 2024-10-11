program FIIRLPBessel;

uses
  Forms,
  Main in 'Main.pas' {fmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Filter Low Pass Bessel';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
