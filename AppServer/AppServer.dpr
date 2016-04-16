program AppServer;
{$APPTYPE GUI}

{$R *.dres}

uses
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uFrmServer in 'uFrmServer.pas' {frmServer},
  uSM in 'uSM.pas' {SM: TDataModule},
  uSC in 'uSC.pas' {SC: TDataModule},
  uWM in 'uWM.pas' {WM: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmServer, frmServer);
  Application.Run;
end.
