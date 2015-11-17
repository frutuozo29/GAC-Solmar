inherited fLeituraRazaoAnalitica: TfLeituraRazaoAnalitica
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Leitura Raz'#227'o Anal'#237'tica'
  ClientHeight = 405
  ClientWidth = 779
  OnShow = FormShow
  ExplicitWidth = 785
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 649
    Top = 0
    Width = 130
    Height = 405
    Align = alRight
    TabOrder = 0
    object btnSair: TButton
      Left = 1
      Top = 76
      Width = 128
      Height = 25
      Align = alTop
      Caption = 'Sair'
      TabOrder = 0
      OnClick = btnSairClick
    end
    object btnLogErros: TButton
      Left = 1
      Top = 51
      Width = 128
      Height = 25
      Align = alTop
      Caption = 'Log de Erros'
      TabOrder = 1
    end
    object btnExcluirImportacao: TButton
      Left = 1
      Top = 26
      Width = 128
      Height = 25
      Align = alTop
      Caption = 'Desfazer Importa'#231#227'o'
      TabOrder = 2
      OnClick = btnExcluirImportacaoClick
    end
    object btnNovaImportacao: TButton
      Left = 1
      Top = 1
      Width = 128
      Height = 25
      Align = alTop
      Caption = 'Nova Importa'#231#227'o'
      TabOrder = 3
      OnClick = btnNovaImportacaoClick
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 105
      Width = 128
      Height = 56
      Caption = 'Status Importa'#231#227'o'
      TabOrder = 4
      object Label1: TLabel
        Left = 4
        Top = 18
        Width = 121
        Height = 13
        Caption = 'C - Importa'#231#227'o Concluida'
      end
      object Label2: TLabel
        Left = 4
        Top = 37
        Width = 114
        Height = 13
        Caption = 'E - Erros na Importa'#231#227'o'
      end
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 649
    Height = 405
    ActivePage = tsConsulta
    Align = alClient
    TabOrder = 1
    object tsConsulta: TTabSheet
      Caption = 'Consulta'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 641
        Height = 395
        Align = alClient
        TabOrder = 0
        object gridImportacao: TDBGrid
          Left = 1
          Top = 1
          Width = 639
          Height = 393
          Align = alClient
          DataSource = dsRazao
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CODIGO'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 361
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA'
              Title.Caption = 'Data'
              Width = 137
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STATUS'
              Title.Caption = 'Status'
              Width = 51
              Visible = True
            end>
        end
      end
    end
  end
  object dsRazao: TDataSource
    DataSet = DMRazaoAnalitica.QueryImportacao
    Left = 504
    Top = 152
  end
  object OpenTextFile: TOpenTextFileDialog
    DefaultExt = 'txt'
    Left = 496
    Top = 56
  end
end
