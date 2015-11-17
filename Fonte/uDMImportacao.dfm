object DMImportacao: TDMImportacao
  OldCreateOrder = False
  Height = 264
  Width = 423
  object QueryHistorico: TFDQuery
    Connection = DMConexao.FDConnGAC
    FetchOptions.AssignedValues = [evMode, evItems, evRowsetSize, evCache, evRecordCountMode]
    FetchOptions.RowsetSize = 1000
    FetchOptions.RecordCountMode = cmTotal
    SQL.Strings = (
      'select distinct LAN.HISTORICO'
      'from LANCAMENTOS LAN'
      
        'inner join PLANODECONTAS PDC on LAN.CONTA_PLANOCONTAS = PDC.CONT' +
        'A'
      'where PDC.CODIGO_AC is not null')
    Left = 88
    Top = 80
    object QueryHistoricoHISTORICO: TStringField
      FieldName = 'HISTORICO'
      Origin = 'HISTORICO'
      Size = 2000
    end
  end
  object QueryLancamentos: TFDQuery
    Connection = DMConexao.FDConnGAC
    FetchOptions.AssignedValues = [evMode, evItems, evRowsetSize, evCache, evRecordCountMode]
    FetchOptions.RowsetSize = 1000
    FetchOptions.RecordCountMode = cmTotal
    SQL.Strings = (
      
        'select PDC.CODIGO_AC, LAN.NUMERO_LANCAMENTO, LAN.DATA, LAN.HISTO' +
        'RICO, LAN.DOCUMENTO, LAN.VALOR_DEBITO,'
      '       LAN.VALOR_CREDITO, LAN.CODIGO_HISTORICO'
      'from PLANODECONTAS PDC'
      'inner join LANCAMENTOS LAN on LAN.CONTA_PLANOCONTAS = PDC.CONTA'
      'where PDC.CODIGO_AC is not null'
      
        'ORDER BY LAN.DATA, LAN.NUMERO_LANCAMENTO, LAN.VALOR_DEBITO, LAN.' +
        'VALOR_CREDITO')
    Left = 240
    Top = 80
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
end
