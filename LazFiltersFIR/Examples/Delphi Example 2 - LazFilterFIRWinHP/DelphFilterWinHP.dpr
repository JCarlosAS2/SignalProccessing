program DelphFilterWinHP;

uses
  Forms,
  FilterFirHP in 'FilterFirHP.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
