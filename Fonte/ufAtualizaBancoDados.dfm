inherited fAtualizaBancoDados: TfAtualizaBancoDados
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Atualiza Banco de Dados'
  ClientHeight = 168
  ClientWidth = 481
  ExplicitWidth = 487
  ExplicitHeight = 196
  PixelsPerInch = 96
  TextHeight = 13
  object pnAvisos: TPanel
    Left = 0
    Top = 0
    Width = 481
    Height = 110
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 691
    object GroupBox1: TGroupBox
      Left = 3
      Top = 5
      Width = 471
      Height = 100
      Caption = 'Novas Atualiza'#231#245'es'
      TabOrder = 0
      object mmAtualizacoes: TMemo
        Left = 2
        Top = 15
        Width = 467
        Height = 83
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 104
        ExplicitTop = 8
        ExplicitWidth = 185
        ExplicitHeight = 89
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 127
    Width = 481
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 136
    ExplicitWidth = 185
    object btnAtualizar: TButton
      Left = 322
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Atualizar'
      TabOrder = 0
      OnClick = btnAtualizarClick
    end
    object btnFechar: TButton
      Left = 399
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
  end
  object Progress: TProgressBar
    Left = 0
    Top = 110
    Width = 481
    Height = 17
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 168
    ExplicitTop = 80
    ExplicitWidth = 150
  end
end
