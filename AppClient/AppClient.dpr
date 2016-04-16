program AppClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmClient in 'uFrmClient.pas' {frmClient},
  uCC in 'uCC.pas',
  uCM in 'uCM.pas' {CM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmClient, frmClient);
  Application.CreateForm(TCM, CM);
  Application.Run;
end.
