program FastReportViewer;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {main};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := False;  
  Application.CreateForm(Tmain, main);
  main.OpenFromCommandLine;           
  Application.Run;
end.
