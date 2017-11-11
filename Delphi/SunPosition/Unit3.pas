unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellApi, Vcl.ExtCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    lblContribute: TLabel;
    lblWebLink: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblContributeClick(Sender: TObject);
    procedure lblWebLinkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm3.Button1Click(Sender: TObject);
begin
  form3.Close;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  label1.Caption := Unit1.Version;
end;

procedure TForm3.Label8Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'https://www.esrl.noaa.gov/gmd/grad/solcalc/azel.html',nil,nil, SW_SHOWNORMAL) ;
end;

procedure TForm3.lblContributeClick(Sender: TObject);
begin
  ShellExecute(self.WindowHandle,'open','www.dhsoftware.com.au/contribute.htm',nil,nil, SW_SHOWNORMAL);
end;

procedure TForm3.lblWebLinkClick(Sender: TObject);
begin
  ShellExecute(self.WindowHandle,'open','www.dhsoftware.com.au',nil,nil, SW_SHOWNORMAL);
end;

end.
