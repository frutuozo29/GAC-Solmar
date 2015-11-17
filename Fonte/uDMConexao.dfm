object DMConexao: TDMConexao
  OldCreateOrder = False
  Height = 270
  Width = 428
  object FDConnAC: TFDConnection
    Params.Strings = (
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDConnGAC: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 88
    Top = 80
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 160
    Top = 16
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 296
    Top = 80
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 304
    Top = 16
  end
  object FDStanStorageXMLLink1: TFDStanStorageXMLLink
    Left = 56
    Top = 200
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 64
    Top = 144
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 200
    Top = 120
  end
end
