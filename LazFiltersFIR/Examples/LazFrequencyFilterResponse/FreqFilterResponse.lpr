program FreqFilterResponse;

{$MODE delphi}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, memdslaz, frmMain, lazfilterspkg, UConst;

{$R FreqFilterResponse.res}

begin
  Application.Title:='FrequencyFilterResponse';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

