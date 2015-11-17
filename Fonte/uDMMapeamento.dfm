object DMMapeamento: TDMMapeamento
  OldCreateOrder = False
  Height = 298
  Width = 519
  object QueryPlanoContas: TFDQuery
    Connection = DMConexao.FDConnGAC
    SQL.Strings = (
      'select 0 as Selecionado, Conta, Nome, Codigo_AC '
      'from planodecontas'
      'where Codigo_AC is null')
    Left = 72
    Top = 32
    object QueryPlanoContasSELECIONADO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'SELECIONADO'
      Origin = 'SELECIONADO'
      ProviderFlags = []
    end
    object QueryPlanoContasCONTA: TStringField
      FieldName = 'CONTA'
      Origin = 'CONTA'
      Size = 15
    end
    object QueryPlanoContasNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object QueryPlanoContasCODIGO_AC: TStringField
      FieldName = 'CODIGO_AC'
      Origin = 'CODIGO_AC'
      Visible = False
      Size = 15
    end
  end
  object QueryContas: TFDQuery
    AfterRefresh = QueryContasAfterRefresh
    Filtered = True
    Filter = 'IMPORTADO <> 1'
    Connection = DMConexao.FDConnAC
    SQL.Strings = (
      'select 0 as Selecionado, codigo, nome, 0 as Importado '
      'from con'
      'where emp_codigo = :emp_codigo'
      'order by codigo')
    Left = 184
    Top = 40
    ParamData = <
      item
        Name = 'EMP_CODIGO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object QueryContasSELECIONADO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'SELECIONADO'
      Origin = 'SELECIONADO'
      ProviderFlags = []
    end
    object QueryContasCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 15
    end
    object QueryContasNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 60
    end
    object QueryContasIMPORTADO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'IMPORTADO'
      Origin = 'IMPORTADO'
      ProviderFlags = []
    end
  end
  object QueryMapeados: TFDQuery
    Connection = DMConexao.FDConnGAC
    SQL.Strings = (
      
        'select 0 as selecionado, conta, nome, codigo_ac, lpad('#39#39',200) as' +
        ' conta_ac '
      'from planodecontas'
      'where codigo_ac is not null')
    Left = 72
    Top = 104
    object QueryMapeadosSELECIONADO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'SELECIONADO'
      Origin = 'SELECIONADO'
      ProviderFlags = []
    end
    object QueryMapeadosCONTA: TStringField
      FieldName = 'CONTA'
      Origin = 'CONTA'
      Size = 15
    end
    object QueryMapeadosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object QueryMapeadosCODIGO_AC: TStringField
      FieldName = 'CODIGO_AC'
      Origin = 'CODIGO_AC'
      Size = 15
    end
    object QueryMapeadosCONTA_AC: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CONTA_AC'
      Origin = 'CONTA_AC'
      ProviderFlags = []
      OnGetText = QueryMapeadosCONTA_ACGetText
      Size = 32765
    end
  end
end
