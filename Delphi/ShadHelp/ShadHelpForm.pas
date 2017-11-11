unit ShadHelpForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ShellApi;

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
    lblErrMsg: TLabel;
    procedure btnDismissClick(Sender: TObject);
    procedure btnInstructionsClick(Sender: TObject);
    procedure lblContributeClick(Sender: TObject);
    procedure lblwwwClick(Sender: TObject);
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
      lblErrMsg.Caption := E.ClassName + ': ' + E.Message;
  end;
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
