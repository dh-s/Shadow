program ShadHelp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, ShellApi, Windows;

var
  helpfilename : PWideChar;

begin
  try
    helpfilename := PWideChar(ExtractFilePath(ParamStr(0)) + 'ShadowInstructions.pdf');
    ShellExecute(0, 'open', helpfilename,nil,nil, SW_SHOWNORMAL) ;
   except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
