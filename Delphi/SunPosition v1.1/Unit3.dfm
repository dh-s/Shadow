object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form3'
  ClientHeight = 227
  ClientWidth = 436
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 15
    Width = 264
    Height = 16
    Caption = 'Sun Position Calculator      version 1.1.06'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 37
    Width = 162
    Height = 13
    Caption = 'Copyright 2017  David Henderson'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 72
    Width = 360
    Height = 13
    Caption = 
      'This program and the accompaying CAD macro are free software and' +
      ' come'
  end
  object Label4: TLabel
    Left = 16
    Top = 87
    Width = 413
    Height = 13
    Caption = 
      'WITHOUT ANY WARRANTY; you may distribute or modify them in accor' +
      'dance with the'
  end
  object Label5: TLabel
    Left = 16
    Top = 102
    Width = 406
    Height = 13
    Caption = 
      'license conditions contained in the accompanying ShadowInstructi' +
      'ons.pdf document.'
  end
  object Label6: TLabel
    Left = 16
    Top = 136
    Width = 410
    Height = 13
    Caption = 
      'Acknowledgement is made that much of the calculation logic conta' +
      'ined in this program'
  end
  object Label7: TLabel
    Left = 16
    Top = 151
    Width = 395
    Height = 13
    Caption = 
      'is based on the calculations used by the NOAA Solar Position Cal' +
      'culator located at '
  end
  object Label8: TLabel
    Left = 16
    Top = 166
    Width = 264
    Height = 13
    Caption = 'https://www.esrl.noaa.gov/gmd/grad/solcalc/azel.html'
    OnClick = Label8Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 436
    Height = 227
    Align = alClient
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object lblwww: TLabel
      Left = 300
      Top = 36
      Width = 122
      Height = 13
      Caption = 'www.dhsoftware.com.au'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = lblwwwClick
    end
    object Button1: TButton
      Left = 343
      Top = 176
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Close'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
