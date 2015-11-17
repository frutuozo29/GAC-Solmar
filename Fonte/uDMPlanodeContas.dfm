object DMPlanodeContas: TDMPlanodeContas
  OldCreateOrder = False
  Height = 297
  Width = 465
  object QueryPlanoDeContas: TFDQuery
    Connection = DMConexao.FDConnGAC
    SQL.Strings = (
      
        'select codigo, codigo_importacao, conta, nome, reduzido, patrimo' +
        'nial, resumir, natureza, estabelecimento, centro_resultado, empr' +
        'esa_ac, codigo_ac'
      'from planodecontas')
    Left = 56
    Top = 24
    object QueryPlanoDeContasCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QueryPlanoDeContasCODIGO_IMPORTACAO: TIntegerField
      FieldName = 'CODIGO_IMPORTACAO'
      Origin = 'CODIGO_IMPORTACAO'
    end
    object QueryPlanoDeContasCONTA: TStringField
      FieldName = 'CONTA'
      Origin = 'CONTA'
      Size = 15
    end
    object QueryPlanoDeContasNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object QueryPlanoDeContasREDUZIDO: TIntegerField
      FieldName = 'REDUZIDO'
      Origin = 'REDUZIDO'
    end
    object QueryPlanoDeContasPATRIMONIAL: TStringField
      FieldName = 'PATRIMONIAL'
      Origin = 'PATRIMONIAL'
      FixedChar = True
      Size = 1
    end
    object QueryPlanoDeContasRESUMIR: TStringField
      FieldName = 'RESUMIR'
      Origin = 'RESUMIR'
      FixedChar = True
      Size = 1
    end
    object QueryPlanoDeContasNATUREZA: TStringField
      FieldName = 'NATUREZA'
      Origin = 'NATUREZA'
      FixedChar = True
      Size = 1
    end
    object QueryPlanoDeContasESTABELECIMENTO: TStringField
      FieldName = 'ESTABELECIMENTO'
      Origin = 'ESTABELECIMENTO'
      Size = 4
    end
    object QueryPlanoDeContasCENTRO_RESULTADO: TStringField
      FieldName = 'CENTRO_RESULTADO'
      Origin = 'CENTRO_RESULTADO'
      Size = 15
    end
    object QueryPlanoDeContasEMPRESA_AC: TStringField
      FieldName = 'EMPRESA_AC'
      Origin = 'EMPRESA_AC'
      Size = 4
    end
    object QueryPlanoDeContasCODIGO_AC: TStringField
      FieldName = 'CODIGO_AC'
      Origin = 'CODIGO_AC'
      Size = 15
    end
  end
  object dspPlanodeContas: TDataSetProvider
    DataSet = QueryPlanoDeContas
    Options = [poAutoRefresh, poUseQuoteChar]
    Left = 160
    Top = 24
  end
  object cdsPlanoDeContas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPlanodeContas'
    Left = 264
    Top = 24
    object cdsPlanoDeContasCODIGO: TIntegerField
      FieldName = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsPlanoDeContasCODIGO_IMPORTACAO: TIntegerField
      FieldName = 'CODIGO_IMPORTACAO'
    end
    object cdsPlanoDeContasCONTA: TStringField
      FieldName = 'CONTA'
      Size = 15
    end
    object cdsPlanoDeContasNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsPlanoDeContasREDUZIDO: TIntegerField
      FieldName = 'REDUZIDO'
    end
    object cdsPlanoDeContasPATRIMONIAL: TStringField
      FieldName = 'PATRIMONIAL'
      FixedChar = True
      Size = 1
    end
    object cdsPlanoDeContasRESUMIR: TStringField
      FieldName = 'RESUMIR'
      FixedChar = True
      Size = 1
    end
    object cdsPlanoDeContasNATUREZA: TStringField
      FieldName = 'NATUREZA'
      FixedChar = True
      Size = 1
    end
    object cdsPlanoDeContasESTABELECIMENTO: TStringField
      FieldName = 'ESTABELECIMENTO'
      Size = 4
    end
    object cdsPlanoDeContasCENTRO_RESULTADO: TStringField
      FieldName = 'CENTRO_RESULTADO'
      Size = 15
    end
    object cdsPlanoDeContasEMPRESA_AC: TStringField
      FieldName = 'EMPRESA_AC'
      Size = 4
    end
    object cdsPlanoDeContasCODIGO_AC: TStringField
      FieldName = 'CODIGO_AC'
      Size = 15
    end
  end
  object QueryImportacao: TFDQuery
    Connection = DMConexao.FDConnGAC
    SQL.Strings = (
      'Select * '
      'from importacoes'
      'where origem = '#39'P'#39)
    Left = 48
    Top = 128
    object QueryImportacaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QueryImportacaoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 60
    end
    object QueryImportacaoDATA: TSQLTimeStampField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object QueryImportacaoSTATUS: TStringField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      FixedChar = True
      Size = 1
    end
  end
  object dspImportacao: TDataSetProvider
    DataSet = QueryImportacao
    Left = 144
    Top = 128
  end
  object cdsImportacao: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspImportacao'
    Left = 232
    Top = 128
    object cdsImportacaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsImportacaoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 60
    end
    object cdsImportacaoDATA: TSQLTimeStampField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object cdsImportacaoSTATUS: TStringField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      FixedChar = True
      Size = 1
    end
  end
end
