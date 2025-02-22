object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Example TSWebDriver4Delphi'
  ClientHeight = 500
  ClientWidth = 934
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 327
    Height = 15
    Caption = 'C:\chromedriver>chromedriver.exe --port=9515 kell elind'#237'tani'
  end
  object MemLog: TMemo
    AlignWithMargins = True
    Left = 5
    Top = 300
    Width = 924
    Height = 195
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'JetBrains Mono'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnNavigateTo: TButton
    Left = 496
    Top = 66
    Width = 120
    Height = 25
    Caption = 'Navigate To'
    TabOrder = 1
    OnClick = btnNavigateToClick
  end
  object btnExecuteScript: TButton
    Left = 671
    Top = 96
    Width = 120
    Height = 25
    Caption = 'Execute Script'
    TabOrder = 2
    OnClick = btnExecuteScriptClick
  end
  object btnExample4: TButton
    Left = 640
    Top = 29
    Width = 89
    Height = 25
    Caption = 'Mercado Livre'
    TabOrder = 3
    OnClick = btnExample4Click
  end
  object btnExample5: TButton
    Left = 648
    Top = 5
    Width = 75
    Height = 25
    Caption = 'Example 5'
    TabOrder = 4
    OnClick = btnExample5Click
  end
  object btnExample1: TButton
    Left = 551
    Top = 5
    Width = 75
    Height = 25
    Caption = 'Example 1'
    TabOrder = 5
    OnClick = btnExample1Click
  end
  object btnExample2: TButton
    Left = 541
    Top = 29
    Width = 75
    Height = 25
    Caption = 'Example 2'
    TabOrder = 6
    OnClick = btnExample2Click
  end
  object btnPbs: TButton
    Left = 8
    Top = 35
    Width = 251
    Height = 25
    Caption = 'login pbs'
    TabOrder = 7
    OnClick = btnPbsClick
  end
  object Button1: TButton
    Left = 640
    Top = 52
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 8
    OnClick = Button1Click
  end
  object MyBitBtn1: TMyBitBtn
    Left = 18
    Top = 75
    Width = 245
    Height = 25
    Caption = 'Keres pbs'
    TabOrder = 9
    DisabledDuringClick = True
  end
  object pbsEdit: TEdit
    Left = 279
    Top = 76
    Width = 121
    Height = 23
    TabOrder = 10
    Text = 'pbsEdit'
  end
end
