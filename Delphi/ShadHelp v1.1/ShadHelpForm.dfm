object Shadow: TShadow
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Shadow'
  ClientHeight = 281
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 16
    Top = 222
    Width = 730
    Height = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 781
    Height = 281
    Align = alClient
    BorderStyle = bsSingle
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 293
    object lblwww: TLabel
      Left = 591
      Top = 8
      Width = 144
      Height = 16
      Cursor = crHandPoint
      Alignment = taRightJustify
      Caption = 'www.dhsoftware.com.au'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lblwwwClick
    end
    object lblCopyright: TLabel
      Left = 15
      Top = 26
      Width = 159
      Height = 13
      Caption = 'Copyright David Henderson 2017'
    end
    object lblShadow: TLabel
      Left = 15
      Top = 8
      Width = 95
      Height = 16
      Caption = 'Shadow Macro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVersion: TLabel
      Left = 127
      Top = 8
      Width = 42
      Height = 16
      Caption = 'v1.1.01'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblContribute: TLabel
      Left = 15
      Top = 234
      Width = 232
      Height = 26
      Cursor = crHandPoint
      Caption = 
        'Contribute towards the deveopment of this and other DataCAD macr' +
        'os'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      WordWrap = True
      OnClick = lblContributeClick
    end
    object lblErrMsg: TLabel
      Left = 16
      Top = 200
      Width = 745
      Height = 34
      Caption = 'lblErrMsg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnInstructions: TButton
      Left = 456
      Top = 240
      Width = 147
      Height = 25
      Caption = 'Show Instruction Manual'
      TabOrder = 0
      OnClick = btnInstructionsClick
    end
    object mCopyright: TMemo
      Left = 14
      Top = 47
      Width = 728
      Height = 169
      BorderStyle = bsNone
      Lines.Strings = (
        
          'This software is distributed free of charge and WITHOUT WARRANTY' +
          '. You may distribute it to others provided that you distribute t' +
          'he complete '
        
          'unaltered installation file provided by me at the dhsoftware.com' +
          '.au web site, and that you do so free of charge (This includes n' +
          'ot  charging for '
        
          'distribution media and not charging for any accompanying softwar' +
          'e that is on the same media or contained in the same download or' +
          ' distribution file). '
        
          'If you wish to make any charge at all you need to obtain specifi' +
          'c permission from me.'
        ''
        
          'Whilst it is free (or because of this) I would like and expect t' +
          'hat if you can think of any improvements or spot any bugs (or ev' +
          'en spelling or formatting '
        
          'errors in the documentation) that you would let me know.  Your f' +
          'eedback will help with future development of the macro.'
        ''
        
          'Whilst the source code of the macro is available for download, i' +
          't is not '#39'open source'#39'. You must not make changes and then make ' +
          'a competing product '
        
          'available to others. You can make changes for your own (or your ' +
          'company'#39's) use, however in general I would prefer that you let m' +
          'e know of your '
        
          'requirements so that I can consider including them in a future r' +
          'elease of my software. If in doubt please contact me.')
      TabOrder = 1
    end
  end
  object btnDismiss: TButton
    Left = 669
    Top = 242
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Dismiss'
    Default = True
    TabOrder = 1
    OnClick = btnDismissClick
  end
end
