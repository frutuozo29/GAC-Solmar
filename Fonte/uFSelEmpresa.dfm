inherited fSelEmpresa: TfSelEmpresa
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Selecione a Empresa Cont'#225'bil'
  ClientHeight = 277
  ClientWidth = 443
  OnShow = FormShow
  ExplicitWidth = 449
  ExplicitHeight = 305
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 239
    Width = 443
    Height = 38
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 362
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Selecionar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 287
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object gridEmpresa: TDBGrid
    Left = 0
    Top = 0
    Width = 443
    Height = 239
    Align = alClient
    DataSource = dsEmpresa
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = gridEmpresaDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Empresa'
        Width = 361
        Visible = True
      end>
  end
  object dsEmpresa: TDataSource
    DataSet = cdsEmpresa
    Left = 216
    Top = 65528
  end
  object cdsEmpresa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEmpresa'
    Left = 192
    Top = 65528
    object cdsEmpresaCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 4
    end
    object cdsEmpresaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 15
    end
  end
  object QueryEmpresa: TFDQuery
    Connection = DMConexao.FDConnAC
    SQL.Strings = (
      'Select CODIGO, NOME from EMP')
    Left = 168
    Top = 65528
    object QueryEmpresaCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 4
    end
    object QueryEmpresaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 15
    end
  end
  object dspEmpresa: TDataSetProvider
    DataSet = QueryEmpresa
    Options = [poAutoRefresh, poAllowCommandText, poUseQuoteChar]
    Left = 240
    Top = 65528
  end
end
