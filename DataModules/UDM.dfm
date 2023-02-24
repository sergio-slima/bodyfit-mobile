object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 309
  Width = 264
  object Conn: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
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
    Left = 176
    Top = 40
  end
  object QryUsuario: TFDQuery
    Connection = Conn
    Left = 40
    Top = 88
  end
  object TabTreino: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 176
    Top = 96
  end
  object QryTreinoExercicio: TFDQuery
    Connection = Conn
    Left = 40
    Top = 144
  end
  object QryConsEstatistica: TFDQuery
    Connection = Conn
    Left = 40
    Top = 200
  end
  object QryConsTreino: TFDQuery
    Connection = Conn
    Left = 40
    Top = 256
  end
end
