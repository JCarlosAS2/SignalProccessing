program BasurasDelphiOriginal;

uses
  Forms,
  BasuraDelphiOriginal in 'BasuraDelphiOriginal.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
