unit unitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  Tdm = class(TDataModule)
    conn: TFDConnection;
    qry: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  with conn do
    begin
      Params.Values['DriverID'] := 'SQLite';

      {$IFDEF MSWINDOWS}
      Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\db\bdvotacao.db';
      {$ELSE}
      Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'bdvotacao.db';
      {$ENDIF}

      try
        Connected := true;
        except on e:exception do
          raise Exception.Create('Erro de conexão com banco: '+e.Message);
      end;
    end;
end;

end.
