object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 206
  Width = 253
  object UniQuery: TUniQuery
    Connection = UniConnection
    SQL.Strings = (
      'select * from Student')
    Left = 112
    Top = 80
  end
  object UniConnection: TUniConnection
    ProviderName = 'Oracle'
    Username = 'system'
    Server = '192.168.0.91:1521/orcl'
    Connected = True
    Left = 40
    Top = 64
    EncryptedPassword = 'CEFFCDFFCCFFCBFFCAFFC9FF'
  end
  object UniDataSource: TUniDataSource
    DataSet = UniQuery
    Left = 80
    Top = 32
  end
  object OracleUniProvider: TOracleUniProvider
    Left = 152
    Top = 40
  end
end
