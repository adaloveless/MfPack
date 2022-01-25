program DuckingCaptureSample;

uses
{$IFDEF MadExcept}
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
{$ENDIF}
  Vcl.Forms,
  IddDialogChat in 'IddDialogChat.pas' {Form1},
  ChatTransport in 'ChatTransport.pas',
  WasapiChat in 'WasapiChat.pas',
  WaveChat in 'WaveChat.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
