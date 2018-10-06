program ShadHelp;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Shadow};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TShadow, Shadow);
  Application.Run;
end.
