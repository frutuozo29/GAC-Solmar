object DMRazaoAnalitica: TDMRazaoAnalitica
  OldCreateOrder = False
  Height = 285
  Width = 439
  object QueryRazaoAnalitica: TFDQuery
    Connection = DMConexao.FDConnGAC
    SQL.Strings = (
      
        'select CODIGO, CODIGO_IMPORTACAO, NUMERO_LANCAMENTO, COnta_PLANO' +
        'CONTAS, DATA, HISTORICO, DOCUMENTO, VALOR_DEBITO,'
      '       VALOR_CREDITO'
      'from LANCAMENTOS')
    Left = 56
    Top = 24
    object QueryRazaoAnaliticaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QueryRazaoAnaliticaCODIGO_IMPORTACAO: TIntegerField
      FieldName = 'CODIGO_IMPORTACAO'
      Origin = 'CODIGO_IMPORTACAO'
    end
    object QueryRazaoAnaliticaNUMERO_LANCAMENTO: TStringField
      FieldName = 'NUMERO_LANCAMENTO'
      Origin = 'NUMERO_LANCAMENTO'
      Size = 200
    end
    object QueryRazaoAnaliticaDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object QueryRazaoAnaliticaHISTORICO: TStringField
      FieldName = 'HISTORICO'
      Origin = 'HISTORICO'
      Size = 2000
    end
    object QueryRazaoAnaliticaDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
      Origin = 'DOCUMENTO'
      Size = 2000
    end
    object QueryRazaoAnaliticaVALOR_DEBITO: TBCDField
      FieldName = 'VALOR_DEBITO'
      Origin = 'VALOR_DEBITO'
      Precision = 18
    end
    object QueryRazaoAnaliticaVALOR_CREDITO: TBCDField
      FieldName = 'VALOR_CREDITO'
      Origin = 'VALOR_CREDITO'
      Precision = 18
    end
    object QueryRazaoAnaliticaCONTA_PLANOCONTAS: TStringField
      FieldName = 'CONTA_PLANOCONTAS'
      Origin = 'CONTA_PLANOCONTAS'
      Size = 15
    end
  end
  object QueryImportacao: TFDQuery
    Connection = DMConexao.FDConnGAC
    SQL.Strings = (
      'Select * '
      'from importacoes'
      'where origem = '#39'R'#39)
    Left = 56
    Top = 104
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
end
