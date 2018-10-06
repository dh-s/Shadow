unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ShellApi;

CONST
  Version = 'v1.1.07';

type
  TShadow = class(TForm)
    Shape1: TShape;
    Panel1: TPanel;
    lblwww: TLabel;
    lblCopyright: TLabel;
    lblShadow: TLabel;
    lblVersion: TLabel;
    lblContribute: TLabel;
    btnInstructions: TButton;
    mCopyright: TMemo;
    btnDismiss: TButton;
    lblErr: TLabel;
    procedure btnDismissClick(Sender: TObject);
    procedure btnInstructionsClick(Sender: TObject);
    procedure lblContributeClick(Sender: TObject);
    procedure lblwwwClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Shadow: TShadow;

implementation

{$R *.dfm}

procedure TShadow.btnDismissClick(Sender: TObject);
begin
  Shadow.Close;
end;

procedure TShadow.btnInstructionsClick(Sender: TObject);
var
  helpfilename : PWideChar;
begin
  try
    helpfilename := PWideChar(ExtractFilePath(ParamStr(0)) + 'ShadowInstructions.pdf');
    ShellExecute(0, 'open', helpfilename,nil,nil, SW_SHOWNORMAL) ;
    Shadow.Close;
   except
    on E: Exception do
      lblErr.Caption := E.ClassName + ': ' + E.Message;
  end;
end;

procedure TShadow.FormCreate(Sender: TObject);
begin
  if ParamCount > 0 then
    lblVersion.Caption := paramstr(1)
  else
    lblVersion.Caption := Version;
end;

procedure TShadow.lblContributeClick(Sender: TObject);
begin
  ShellExecute(self.WindowHandle,'open','www.dhsoftware.com.au/contribute.htm',nil,nil, SW_SHOWNORMAL);
end;

procedure TShadow.lblwwwClick(Sender: TObject);
begin
ShellExecute(self.WindowHandle,'open','www.dhsoftware.com.au',nil,nil, SW_SHOWNORMAL);
end;

end.
