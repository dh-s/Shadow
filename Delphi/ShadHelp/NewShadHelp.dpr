program NewShadHelp;

uses
  Vcl.Forms,
  Unit1 in 'C:\Users\David\Documents\Embarcadero\Studio\Projects\Unit1.pas' {Shadow};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TShadow, Shadow);
  Application.Run;
end.
