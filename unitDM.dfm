object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 167
  Width = 192
  object conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Left = 40
    Top = 32
  end
  object qry: TFDQuery
    Connection = conn
    Left = 112
    Top = 32
  end
end
