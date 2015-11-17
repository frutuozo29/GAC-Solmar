inherited fGeracaoArquivo: TfGeracaoArquivo
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerar Arquivo de Importa'#231#227'o Fortes Cont'#225'bil'
  ClientHeight = 411
  ClientWidth = 493
  ExplicitWidth = 499
  ExplicitHeight = 439
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 345
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object dirListBox: TDirectoryListBox
      Left = 0
      Top = 0
      Width = 493
      Height = 345
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = True
      DirLabel = lblNomeArquivo
      ParentCtl3D = False
      TabOrder = 0
    end
  end
  object pnArquivo: TPanel
    Left = 0
    Top = 345
    Width = 493
    Height = 66
    Align = alClient
    TabOrder = 1
    object lblNomeArquivo: TLabel
      Left = 100
      Top = 6
      Width = 108
      Height = 13
      Caption = 'C:\Windows\system32'
    end
    object lblNome: TLabel
      Left = 5
      Top = 26
      Width = 90
      Height = 13
      Caption = 'Descri'#231#227'o Arquivo:'
    end
    object Label1: TLabel
      Left = 5
      Top = 6
      Width = 91
      Height = 13
      Caption = 'Salvar Arquivo Em:'
    end
    object edtNome: TEdit
      Left = 5
      Top = 39
      Width = 380
      Height = 21
      TabOrder = 0
    end
    object btnGerar: TButton
      Left = 387
      Top = 39
      Width = 102
      Height = 25
      Caption = 'Gerar'
      TabOrder = 1
      OnClick = btnGerarClick
    end
  end
end
