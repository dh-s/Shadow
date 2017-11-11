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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 15
    Width = 256
    Height = 16
    Caption = 'Sun Position Calculator      version 1.0.1'
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
    Width = 383
    Height = 13
    Caption = 
      'This program and the accompaying DataCAD macro are free software' +
      ' and come'
  end
  object Label4: TLabel
    Left = 16
    Top = 87
    Width = 400
    Height = 13
    Caption = 
      'WITHOUT ANY WARRANTY; you may distribute them in accordance with' +
      ' the license'
  end
  object Label5: TLabel
    Left = 16
    Top = 102
    Width = 371
    Height = 13
    Caption = 
      'conditions contained in the accompanying ShadowInstructions.pdf ' +
      'document.'
  end
  object Label6: TLabel
    Left = 16
    Top = 130
    Width = 403
    Height = 13
    Caption = 
      'You are under no obligation to make any payment at all for this ' +
      'free software, but if'
  end
  object Label7: TLabel
    Left = 16
    Top = 145
    Width = 402
    Height = 13
    Caption = 
      'you find it useful a contribution towards the cost of its develo' +
      'pment and distribution'
  end
  object Label8: TLabel
    Left = 16
    Top = 160
    Width = 107
    Height = 13
    Caption = 'would be appreciated.'
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
    object lblContribute: TLabel
      Left = 16
      Top = 192
      Width = 109
      Height = 14
      Cursor = crHandPoint
      Hint = 'www.dhsoftware.com.au/contribute.htm'
      Caption = 'Make a Contribution'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lblContributeClick
      OnDblClick = lblContributeClick
    end
    object lblWebLink: TLabel
      Left = 296
      Top = 37
      Width = 122
      Height = 13
      Cursor = crHandPoint
      Alignment = taRightJustify
      Caption = 'www.dhsoftware.com.au'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lblWebLinkClick
      OnDblClick = lblWebLinkClick
    end
    object Button1: TButton
      Left = 343
      Top = 183
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
