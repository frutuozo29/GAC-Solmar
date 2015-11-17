inherited fMapPlanoContas: TfMapPlanoContas
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Mapeamento Plano de Contas'
  ClientHeight = 524
  ClientWidth = 934
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  ExplicitTop = -91
  ExplicitWidth = 940
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 934
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      934
      54)
    object Label2: TLabel
      Left = 5
      Top = 3
      Width = 121
      Height = 13
      Caption = 'Empresa Cont'#225'bil Fortes:'
    end
    object lbl: TLabel
      Left = 113
      Top = 39
      Width = 130
      Height = 13
      Caption = 'Contas do Plano de Contas'
    end
    object Label5: TLabel
      Left = 691
      Top = 39
      Width = 125
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Contas do Fortes Cont'#225'bil'
      ExplicitLeft = 443
    end
    object lblEmpContabil: TLabel
      Left = 129
      Top = 3
      Width = 3
      Height = 13
    end
    object Label1: TLabel
      Left = 325
      Top = 3
      Width = 291
      Height = 13
      Alignment = taCenter
      Anchors = [akTop]
      Caption = 'Utilize Barra de Espa'#231'o para selecionar os registros nas Grids'
    end
    object Button1: TButton
      Left = 736
      Top = 0
      Width = 198
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Executar Mapeamento Autom'#225'tico'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object gpMapeamento: TGridPanel
    Left = 0
    Top = 54
    Width = 934
    Height = 470
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = gridMapPlanoConta
        Row = 0
      end
      item
        Column = 0
        ColumnSpan = 2
        Control = GridPanel1
        Row = 1
      end
      item
        Column = 1
        Control = gridMapContas
        Row = 0
      end
      item
        Column = 0
        ColumnSpan = 2
        Control = gridMapeados
        Row = 2
      end
      item
        Column = 1
        Control = btnDesfazerMapeamento
        Row = 3
      end
      item
        Column = 0
        Control = btnMapear
        Row = 3
      end>
    RowCollection = <
      item
        Value = 50.004440552804690000
      end
      item
        SizeStyle = ssAbsolute
        Value = 25.000000000000000000
      end
      item
        Value = 49.995559447195320000
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 1
    object gridMapPlanoConta: TcxGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 461
      Height = 204
      Align = alClient
      TabOrder = 0
      object tvMapPlanoConta: TcxGridDBTableView
        OnKeyPress = tvMapPlanoContaKeyPress
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Visible = fvNever
        OnCellClick = tvMapPlanoContaCellClick
        DataController.DataSource = dsMapPlanoConta
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object tvMapPlanoContaSELECIONADO: TcxGridDBColumn
          DataBinding.FieldName = 'SELECIONADO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taCenter
          Properties.AllowGrayed = True
          Properties.DisplayGrayed = 'False'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Width = 20
          IsCaptionAssigned = True
        end
        object tvMapPlanoContaCONTA: TcxGridDBColumn
          Caption = 'Conta'
          DataBinding.FieldName = 'CONTA'
        end
        object tvMapPlanoContaNOME: TcxGridDBColumn
          Caption = 'Desci'#231#227'o'
          DataBinding.FieldName = 'NOME'
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = tvMapPlanoConta
      end
    end
    object GridPanel1: TGridPanel
      Left = 0
      Top = 210
      Width = 934
      Height = 25
      Align = alClient
      ColumnCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 150.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = edtMapPlanoConta
          Row = 0
        end
        item
          Column = 2
          Control = edtMapContas
          Row = 0
        end
        item
          Column = 1
          Control = Label3
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 1
      DesignSize = (
        934
        25)
      object edtMapPlanoConta: TEdit
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 385
        Height = 17
        Align = alClient
        TabOrder = 0
        OnEnter = edtMapPlanoContaEnter
        OnExit = edtMapPlanoContaExit
        OnKeyPress = edtMapPlanoContaKeyPress
        OnKeyUp = edtMapPlanoContaKeyUp
        ExplicitHeight = 21
      end
      object edtMapContas: TEdit
        AlignWithMargins = True
        Left = 545
        Top = 4
        Width = 385
        Height = 17
        Align = alClient
        TabOrder = 1
        OnEnter = edtMapContasEnter
        OnExit = edtMapContasExit
        OnKeyPress = edtMapContasKeyPress
        OnKeyUp = edtMapContasKeyUp
        ExplicitHeight = 21
      end
      object Label3: TLabel
        Left = 424
        Top = 6
        Width = 86
        Height = 13
        Anchors = []
        Caption = 'Contas Mapeadas'
        ExplicitLeft = 301
      end
    end
    object gridMapContas: TcxGrid
      AlignWithMargins = True
      Left = 470
      Top = 3
      Width = 461
      Height = 204
      Align = alClient
      TabOrder = 2
      object tvContas: TcxGridDBTableView
        OnKeyPress = tvContasKeyPress
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Visible = fvNever
        OnCellClick = tvContasCellClick
        DataController.DataSource = dsContas
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvContasSELECIONADO: TcxGridDBColumn
          DataBinding.FieldName = 'SELECIONADO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Width = 20
          IsCaptionAssigned = True
        end
        object tvContasCODIGO: TcxGridDBColumn
          Caption = 'Conta'
          DataBinding.FieldName = 'CODIGO'
        end
        object tvContasNOME: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'NOME'
        end
      end
      object cxGridLevel4: TcxGridLevel
        GridView = tvContas
      end
    end
    object gridMapeados: TcxGrid
      AlignWithMargins = True
      Left = 3
      Top = 238
      Width = 928
      Height = 203
      Align = alClient
      TabOrder = 3
      object tvMapeados: TcxGridDBTableView
        OnKeyPress = tvMapeadosKeyPress
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = tvMapeadosCellClick
        DataController.DataSource = dsMapeados
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvMapeadosSELECIONADO: TcxGridDBColumn
          DataBinding.FieldName = 'SELECIONADO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Width = 20
          IsCaptionAssigned = True
        end
        object tvMapeadosCONTA: TcxGridDBColumn
          Caption = 'Conta do Plano de Contas'
          DataBinding.FieldName = 'CONTA'
          MinWidth = 90
          Width = 90
        end
        object tvMapeadosNOME: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'NOME'
          MinWidth = 215
          Width = 215
        end
        object tvMapeadosCODIGO_AC: TcxGridDBColumn
          Caption = 'Conta no Fortes Cont'#225'bil'
          DataBinding.FieldName = 'CODIGO_AC'
          MinWidth = 90
          Width = 90
        end
        object tvMapeadosCONTA_AC: TcxGridDBColumn
          Caption = 'Descri'#231#227'o Conta Fortes Cont'#225'bil'
          DataBinding.FieldName = 'CONTA_AC'
          MinWidth = 215
          Width = 215
        end
      end
      object cxGridLevel2: TcxGridLevel
        GridView = tvMapeados
      end
    end
    object btnDesfazerMapeamento: TButton
      Left = 467
      Top = 444
      Width = 467
      Height = 25
      Align = alClient
      Caption = 'Desfazer Mapeamento'
      TabOrder = 4
      OnClick = btnDesfazerMapeamentoClick
    end
    object btnMapear: TButton
      Left = 0
      Top = 444
      Width = 467
      Height = 25
      Align = alClient
      Caption = 'Mapear ( Ctrl + Enter )'
      TabOrder = 5
      OnClick = btnMapearClick
    end
  end
  object dsMapPlanoConta: TDataSource
    DataSet = DMMapeamento.QueryPlanoContas
    Left = 328
    Top = 16
  end
  object dsContas: TDataSource
    DataSet = DMMapeamento.QueryContas
    Left = 368
    Top = 8
  end
  object dsMapeados: TDataSource
    DataSet = DMMapeamento.QueryMapeados
    Left = 304
    Top = 280
  end
end
