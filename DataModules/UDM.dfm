object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 309
  Width = 264
  object Conn: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = ConnAfterConnect
    BeforeConnect = ConnBeforeConnect
    Left = 32
    Top = 24
  end
  object TabUsuario: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 96
  end
  object QryUsuario: TFDQuery
    Connection = Conn
    Left = 136
    Top = 104
  end
end
