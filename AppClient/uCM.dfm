object CM: TCM
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSRestConn: TDSRestConnection
    Host = 'localhost'
    Port = 8080
    LoginPrompt = False
    Left = 64
    Top = 16
    UniqueId = '{452E6977-5859-423A-87D0-1921D4049709}'
  end
  object FDMemTableEmployee: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 64
    Top = 64
    object FDMemTableEmployeeEMP_NO: TSmallintField
      DisplayLabel = 'Id'
      FieldName = 'EMP_NO'
      Origin = 'EMP_NO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      DisplayFormat = '0000'
    end
    object FDMemTableEmployeeFULL_NAME: TStringField
      DisplayLabel = 'Full Name'
      FieldName = 'FULL_NAME'
      Origin = 'FULL_NAME'
      Size = 37
    end
    object FDMemTableEmployeeSALARY: TBCDField
      DisplayLabel = 'Salary (USD)'
      FieldName = 'SALARY'
      Origin = 'SALARY'
      Required = True
      DisplayFormat = 'US$ #,##0.00'
      currency = True
      Precision = 18
      Size = 2
    end
  end
end
