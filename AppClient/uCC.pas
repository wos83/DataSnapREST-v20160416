//
// Created by the DataSnap proxy generator.
// 16/04/16 18:26:20
//

unit uCC;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TSMClient = class(TDSAdminRestClient)
  private
    FFDConnBeforeConnectCommand: TDSRestCommand;
    FDataModuleCreateCommand: TDSRestCommand;
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FGetEmployeeAllCommand: TDSRestCommand;
    FGetEmployeeAllCommand_Cache: TDSRestCommand;
    FGetEmployeeId_DataCommand: TDSRestCommand;
    FGetEmployeeId_DataCommand_Cache: TDSRestCommand;
    FGetEmployeeId_BoolCommand: TDSRestCommand;
    FSetEmployeeCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure FDConnBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function GetEmployeeAll(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetEmployeeAll_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetEmployeeId_Data(AId: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetEmployeeId_Data_Cache(AId: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetEmployeeId_Bool(AId: Integer; var AMessage: string; const ARequestFilter: string = ''): Boolean;
    function SetEmployee(AEmpNo: Integer; AFullName: string; const ARequestFilter: string = ''): Boolean;
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TSM_FDConnBeforeConnect: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TSM_DataModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TSM_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TSM_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TSM_GetEmployeeAll: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TSM_GetEmployeeAll_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSM_GetEmployeeId_Data: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TSM_GetEmployeeId_Data_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TSM_GetEmployeeId_Bool: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'AId'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'AMessage'; Direction: 3; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TSM_SetEmployee: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'AEmpNo'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'AFullName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

procedure TSMClient.FDConnBeforeConnect(Sender: TObject);
begin
  if FFDConnBeforeConnectCommand = nil then
  begin
    FFDConnBeforeConnectCommand := FConnection.CreateCommand;
    FFDConnBeforeConnectCommand.RequestType := 'POST';
    FFDConnBeforeConnectCommand.Text := 'TSM."FDConnBeforeConnect"';
    FFDConnBeforeConnectCommand.Prepare(TSM_FDConnBeforeConnect);
  end;
  if not Assigned(Sender) then
    FFDConnBeforeConnectCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FFDConnBeforeConnectCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FFDConnBeforeConnectCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FFDConnBeforeConnectCommand.Execute;
end;

procedure TSMClient.DataModuleCreate(Sender: TObject);
begin
  if FDataModuleCreateCommand = nil then
  begin
    FDataModuleCreateCommand := FConnection.CreateCommand;
    FDataModuleCreateCommand.RequestType := 'POST';
    FDataModuleCreateCommand.Text := 'TSM."DataModuleCreate"';
    FDataModuleCreateCommand.Prepare(TSM_DataModuleCreate);
  end;
  if not Assigned(Sender) then
    FDataModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleCreateCommand.Execute;
end;

function TSMClient.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TSM.EchoString';
    FEchoStringCommand.Prepare(TSM_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TSMClient.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TSM.ReverseString';
    FReverseStringCommand.Prepare(TSM_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TSMClient.GetEmployeeAll(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetEmployeeAllCommand = nil then
  begin
    FGetEmployeeAllCommand := FConnection.CreateCommand;
    FGetEmployeeAllCommand.RequestType := 'GET';
    FGetEmployeeAllCommand.Text := 'TSM.GetEmployeeAll';
    FGetEmployeeAllCommand.Prepare(TSM_GetEmployeeAll);
  end;
  FGetEmployeeAllCommand.Execute(ARequestFilter);
  if not FGetEmployeeAllCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetEmployeeAllCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEmployeeAllCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEmployeeAllCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TSMClient.GetEmployeeAll_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetEmployeeAllCommand_Cache = nil then
  begin
    FGetEmployeeAllCommand_Cache := FConnection.CreateCommand;
    FGetEmployeeAllCommand_Cache.RequestType := 'GET';
    FGetEmployeeAllCommand_Cache.Text := 'TSM.GetEmployeeAll';
    FGetEmployeeAllCommand_Cache.Prepare(TSM_GetEmployeeAll_Cache);
  end;
  FGetEmployeeAllCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetEmployeeAllCommand_Cache.Parameters[0].Value.GetString);
end;

function TSMClient.GetEmployeeId_Data(AId: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetEmployeeId_DataCommand = nil then
  begin
    FGetEmployeeId_DataCommand := FConnection.CreateCommand;
    FGetEmployeeId_DataCommand.RequestType := 'GET';
    FGetEmployeeId_DataCommand.Text := 'TSM.GetEmployeeId_Data';
    FGetEmployeeId_DataCommand.Prepare(TSM_GetEmployeeId_Data);
  end;
  FGetEmployeeId_DataCommand.Parameters[0].Value.SetInt32(AId);
  FGetEmployeeId_DataCommand.Execute(ARequestFilter);
  if not FGetEmployeeId_DataCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetEmployeeId_DataCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEmployeeId_DataCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEmployeeId_DataCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TSMClient.GetEmployeeId_Data_Cache(AId: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetEmployeeId_DataCommand_Cache = nil then
  begin
    FGetEmployeeId_DataCommand_Cache := FConnection.CreateCommand;
    FGetEmployeeId_DataCommand_Cache.RequestType := 'GET';
    FGetEmployeeId_DataCommand_Cache.Text := 'TSM.GetEmployeeId_Data';
    FGetEmployeeId_DataCommand_Cache.Prepare(TSM_GetEmployeeId_Data_Cache);
  end;
  FGetEmployeeId_DataCommand_Cache.Parameters[0].Value.SetInt32(AId);
  FGetEmployeeId_DataCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetEmployeeId_DataCommand_Cache.Parameters[1].Value.GetString);
end;

function TSMClient.GetEmployeeId_Bool(AId: Integer; var AMessage: string; const ARequestFilter: string): Boolean;
begin
  if FGetEmployeeId_BoolCommand = nil then
  begin
    FGetEmployeeId_BoolCommand := FConnection.CreateCommand;
    FGetEmployeeId_BoolCommand.RequestType := 'GET';
    FGetEmployeeId_BoolCommand.Text := 'TSM.GetEmployeeId_Bool';
    FGetEmployeeId_BoolCommand.Prepare(TSM_GetEmployeeId_Bool);
  end;
  FGetEmployeeId_BoolCommand.Parameters[0].Value.SetInt32(AId);
  FGetEmployeeId_BoolCommand.Parameters[1].Value.SetWideString(AMessage);
  FGetEmployeeId_BoolCommand.Execute(ARequestFilter);
  AMessage := FGetEmployeeId_BoolCommand.Parameters[1].Value.GetWideString;
  Result := FGetEmployeeId_BoolCommand.Parameters[2].Value.GetBoolean;
end;

function TSMClient.SetEmployee(AEmpNo: Integer; AFullName: string; const ARequestFilter: string): Boolean;
begin
  if FSetEmployeeCommand = nil then
  begin
    FSetEmployeeCommand := FConnection.CreateCommand;
    FSetEmployeeCommand.RequestType := 'GET';
    FSetEmployeeCommand.Text := 'TSM.SetEmployee';
    FSetEmployeeCommand.Prepare(TSM_SetEmployee);
  end;
  FSetEmployeeCommand.Parameters[0].Value.SetInt32(AEmpNo);
  FSetEmployeeCommand.Parameters[1].Value.SetWideString(AFullName);
  FSetEmployeeCommand.Execute(ARequestFilter);
  Result := FSetEmployeeCommand.Parameters[2].Value.GetBoolean;
end;

constructor TSMClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TSMClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TSMClient.Destroy;
begin
  FFDConnBeforeConnectCommand.DisposeOf;
  FDataModuleCreateCommand.DisposeOf;
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FGetEmployeeAllCommand.DisposeOf;
  FGetEmployeeAllCommand_Cache.DisposeOf;
  FGetEmployeeId_DataCommand.DisposeOf;
  FGetEmployeeId_DataCommand_Cache.DisposeOf;
  FGetEmployeeId_BoolCommand.DisposeOf;
  FSetEmployeeCommand.DisposeOf;
  inherited;
end;

end.

