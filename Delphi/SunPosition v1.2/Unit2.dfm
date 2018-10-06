object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 382
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 128
    Top = 343
    Width = 100
    Height = 25
    Caption = 'Building Folder List...'
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 329
    Height = 337
    Indent = 19
    TabOrder = 0
    Visible = False
  end
  object Button1: TButton
    Left = 244
    Top = 349
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 163
    Top = 349
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
  end
end
