object DMImportacao: TDMImportacao
  OldCreateOrder = False
  Height = 264
  Width = 423
  object QueryHistorico: TFDQuery
    Connection = DMConexao.FDConnGAC
    FetchOptions.AssignedValues = [evMode, evItems, evRowsetSize, evCache, evRecordCountMode, evUnidirectional, evCursorKind, evAutoFetchAll]
    FetchOptions.CursorKind = ckForwardOnly
    FetchOptions.Unidirectional = True
    FetchOptions.RowsetSize = 1000
    FetchOptions.AutoFetchAll = afDisable
    FetchOptions.RecordCountMode = cmTotal
    FetchOptions.Items = [fiDetails]
    FetchOptions.Cache = [fiDetails]
    SQL.Strings = (
      'select distinct LAN.HISTORICO, LAN.CODIGO_HISTORICO'
      'from LANCAMENTOS LAN'
      
        'inner join PLANODECONTAS PDC on LAN.CONTA_PLANOCONTAS = PDC.CONT' +
        'A'
      'where PDC.CODIGO_AC is not null and LAN.CODIGO_IMPORTACAO = :LAN')
    Left = 88
    Top = 80
    ParamData = <
      item
        Name = 'LAN'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QueryHistoricoHISTORICO: TStringField
      FieldName = 'HISTORICO'
      Origin = 'HISTORICO'
      Size = 2000
    end
    object QueryHistoricoCODIGO_HISTORICO: TStringField
      FieldName = 'CODIGO_HISTORICO'
      Size = 10
    end
  end
  object QueryLancamentos: TFDQuery
    Connection = DMConexao.FDConnGAC
    FetchOptions.AssignedValues = [evMode, evItems, evRowsetSize, evCache, evRecordCountMode, evUnidirectional, evCursorKind]
    FetchOptions.CursorKind = ckForwardOnly
    FetchOptions.Unidirectional = True
    FetchOptions.RowsetSize = 1000
    FetchOptions.RecordCountMode = cmTotal
    FetchOptions.Items = [fiBlobs, fiDetails]
    SQL.Strings = (
      
        'select PDC.CODIGO_AC, LAN.NUMERO_LANCAMENTO, LAN.DATA, LAN.HISTO' +
        'RICO, LAN.DOCUMENTO, LAN.VALOR_DEBITO,'
      '       LAN.VALOR_CREDITO, LAN.CODIGO_HISTORICO'
      'from PLANODECONTAS PDC'
      'inner join LANCAMENTOS LAN on LAN.CONTA_PLANOCONTAS = PDC.CONTA'
      'where PDC.CODIGO_AC is not null and '
      '      ((LAN.VALOR_DEBITO > 0) or (LAN.VALOR_CREDITO > 0)) and'
      '      LAN.CODIGO_IMPORTACAO = :LAN'
      
        'ORDER BY LAN.DATA, LAN.NUMERO_LANCAMENTO, LAN.VALOR_DEBITO, LAN.' +
        'VALOR_CREDITO')
    Left = 240
    Top = 80
    ParamData = <
      item
        Name = 'LAN'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QueryLancamentosCODIGO_AC: TStringField
      FieldName = 'CODIGO_AC'
      Origin = 'CODIGO_AC'
      Size = 15
    end
    object QueryLancamentosNUMERO_LANCAMENTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NUMERO_LANCAMENTO'
      Origin = 'NUMERO_LANCAMENTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
    object QueryLancamentosDATA: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DATA'
      Origin = '"DATA"'
      ProviderFlags = []
      ReadOnly = True
    end
    object QueryLancamentosHISTORICO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'HISTORICO'
      Origin = 'HISTORICO'
      ProviderFlags = []
      ReadOnly = True
      Size = 2000
    end
    object QueryLancamentosDOCUMENTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DOCUMENTO'
      Origin = 'DOCUMENTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 2000
    end
    object QueryLancamentosVALOR_DEBITO: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR_DEBITO'
      Origin = 'VALOR_DEBITO'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
    end
    object QueryLancamentosVALOR_CREDITO: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR_CREDITO'
      Origin = 'VALOR_CREDITO'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
    end
    object QueryLancamentosCODIGO_HISTORICO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODIGO_HISTORICO'
      Origin = 'CODIGO_HISTORICO'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
  end
  object QryAtualizaHistorico: TFDQuery
    Connection = DMConexao.FDConnGAC
    SQL.Strings = (
      
        'update lancamentos set codigo_historico = :cod where historico =' +
        ' :hist and CODIGO_IMPORTACAO = :imp and codigo_historico is null')
    Left = 88
    Top = 152
    ParamData = <
      item
        Name = 'COD'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'HIST'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'IMP'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
