program avaliador;

uses
  System.StartUpCopy,
  FMX.Forms,
  unitPrincipal in 'unitPrincipal.pas' {frmPrincipal},
  unitDM in 'unitDM.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
