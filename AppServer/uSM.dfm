object SM: TSM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 276
  Width = 355
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 64
    Top = 8
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 56
  end
  object FDConn: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      
        'Database=C:\TREINAMENTO\DelphiDataSnap\REST\Example_DataSnapREST' +
        '_FireDAC_2\Binary\EMPLOYEE.FDB'
      'DriverID=FB'
      'PageSize=16384')
    LoginPrompt = False
    BeforeConnect = FDConnBeforeConnect
    Left = 200
    Top = 8
  end
  object FDQry: TFDQuery
    Connection = FDConn
    Left = 200
    Top = 56
  end
  object FDStanStorageJSONLink: TFDStanStorageJSONLink
    Left = 64
    Top = 112
  end
  object FDStanStorageXMLLink: TFDStanStorageXMLLink
    Left = 64
    Top = 160
  end
  object FDStanStorageBinLink: TFDStanStorageBinLink
    Left = 64
    Top = 208
  end
end
