inherited fSelRazao: TfSelRazao
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Selecione a Raz'#227'o para gerar o arquivo.'
  ClientHeight = 399
  ClientWidth = 451
  ExplicitWidth = 457
  ExplicitHeight = 428
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TDBGrid
    Left = 0
    Top = 0
    Width = 451
    Height = 358
    Align = alClient
    DataSource = dsRazao
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
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Width = 266
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA'
        Width = 89
        Visible = True
      end>
  end
  object pnSel: TPanel
    Left = 0
    Top = 358
    Width = 451
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 136
    ExplicitTop = 192
    ExplicitWidth = 185
    object btnSelecionar: TButton
      Left = 371
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Selecionar'
      TabOrder = 0
      OnClick = btnSelecionarClick
    end
  end
  object QryRazao: TFDQuery
    Connection = DMConexao.FDConnGAC
    SQL.Strings = (
      
        'select codigo, descricao, data from importacoes where origem = '#39 +
        'R'#39)
    Left = 216
    Top = 200
    object QryRazaoCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryRazaoDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 60
    end
    object QryRazaoDATA: TSQLTimeStampField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
  end
  object dsRazao: TDataSource
    DataSet = QryRazao
    Left = 112
    Top = 152
  end
end
