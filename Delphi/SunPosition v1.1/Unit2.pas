unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    TreeView1: TTreeView;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

VAR
  initialised : boolean;

procedure AddDirectories(theNode: tTreeNode; cPath: string);
var
  sr: TSearchRec;
  FileAttrs: Integer;
  theNewNode : tTreeNode;
begin
   FileAttrs := faDirectory;     // Only care about directories
   if FindFirst(cPath+'\*.*', FileAttrs, sr) = 0 then
    begin
      repeat
        if  ((sr.Attr and FileAttrs) = sr.Attr) and (copy(sr.Name,1,1) <> '.')
        then
        begin
            theNewNode := Form2.TreeView1.Items.AddChild(theNode,sr.name);
            AddDirectories(theNewNode,cPath+'\'+sr.Name);
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
end;
procedure TForm2.FormActivate(Sender: TObject);
var
  theRootNode : tTreeNode;
  theNode : tTreeNode;
  DriveLetter : Char;
begin
  if not initialised then begin
    Treeview1.Visible := false;
    theRootNode := Form2.TreeView1.Items.AddFirst(nil,'Computer');
    For DriveLetter := 'A' To 'Z' Do
      begin
        If GetDriveType(PChar(DriveLetter + ':\')) IN [DRIVE_FIXED, DRIVE_REMOVABLE, DRIVE_REMOTE] Then
        begin
          theNode := Form2.TreeView1.Items.AddChild(theRootNode, DriveLetter + ':');
          AddDirectories (theNode, DriveLetter + ':\');
        end;
    end;
  end;
  initialised := true;
  Treeview1.visible := true;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
initialised := false;
end;

procedure TForm2.FormPaint(Sender: TObject);
var
  theRootNode : tTreeNode;
  theNode : tTreeNode;
  DriveLetter : Char;
begin
{  if not initialised then begin
    theRootNode := Form2.TreeView1.Items.AddFirst(nil,'Computer');
    For DriveLetter := 'A' To 'Z' Do
      begin
        If GetDriveType(PChar(DriveLetter + ':\')) IN [DRIVE_FIXED, DRIVE_REMOVABLE, DRIVE_REMOTE] Then
        begin
          theNode := Form2.TreeView1.Items.AddChild(theRootNode, DriveLetter + ':');
          AddDirectories (theNode, DriveLetter + ':\');
        end;
    end;
  end;
  initialised := true;
  Treeview1.visible := true;        }
end;

procedure TForm2.FormShow(Sender: TObject);
var
  theRootNode : tTreeNode;
  theNode : tTreeNode;
  DriveLetter : Char;
begin

end;

end.
