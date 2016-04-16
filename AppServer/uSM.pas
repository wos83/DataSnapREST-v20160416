unit uSM;

interface

uses
   Data.DB,
   Data.FireDACJSONConsts,
   Data.FireDACJSONReflect,
   Datasnap.DSAuth,
   Datasnap.DSProviderDataModuleAdapter,
   Datasnap.DSServer,
   FireDAC.Comp.Client,
   FireDAC.Comp.DataSet,
   FireDAC.Comp.UI,
   FireDAC.DApt,
   FireDAC.DApt.Intf,
   FireDAC.DatS,
   FireDAC.Phys,
   FireDAC.Phys.FB,
   FireDAC.Phys.FBDef,
   FireDAC.Phys.IBBase,
   FireDAC.Phys.Intf,
   FireDAC.Stan.Async,
   FireDAC.Stan.Def,
   FireDAC.Stan.Error,
   FireDAC.Stan.Intf,
   FireDAC.Stan.Option,
   FireDAC.Stan.Param,
   FireDAC.Stan.Pool,
   FireDAC.Stan.StorageBin,
   FireDAC.Stan.StorageJSON,
   FireDAC.Stan.StorageXML,
   FireDAC.UI.Intf,
   FireDAC.VCLUI.Wait,
   FMX.Dialogs,
   System.Classes,
   System.Json,
   System.StrUtils,
   System.SysUtils;

type
   {$METHODINFO ON}
   TSM = class(TDataModule)

      FDConn: TFDConnection;
      FDGUIxWaitCursor: TFDGUIxWaitCursor;
      FDPhysFBDriverLink: TFDPhysFBDriverLink;
      FDQry: TFDQuery;
      FDStanStorageBinLink: TFDStanStorageBinLink;
      FDStanStorageJSONLink: TFDStanStorageJSONLink;
      FDStanStorageXMLLink: TFDStanStorageXMLLink;

      procedure FDConnBeforeConnect(Sender: TObject);
      procedure DataModuleCreate(Sender: TObject);

   private
      { Private declarations }

   public
      function EchoString(const Value: string): string;
      function ReverseString(const Value: string): string;

      function GetEmployeeAll: TFDJSONDataSets;

      function GetEmployeeId_Data(AId: integer): TFDJSONDataSets;
      function GetEmployeeId_Bool(AId: integer; var AMessage: string): Boolean;

      function SetEmployee(AEmpNo: integer; AFullName: string): Boolean;

      { Public declarations }
   end;
   {$METHODINFO OFF}

const
   _SQL_EMPLOYEE_ALL = //
      'SELECT EMP_NO, FULL_NAME, SALARY FROM EMPLOYEE';

   _SQL_EMPLOYEE_ID = _SQL_EMPLOYEE_ALL + sLineBreak + //
      'WHERE EMP_NO = :EMP_NO';

implementation

{ %CLASSGROUP 'FMX.Controls.TControl' }

{$R *.dfm}

function TSM.EchoString(const Value: string): string;
begin
   Result := Value;
end;

function TSM.ReverseString(const Value: string): string;
begin
   Result := System.StrUtils.ReverseString(Value);
end;

function TSM.SetEmployee(AEmpNo: integer; AFullName: string): Boolean;
begin
   FDQry.Close;
   FDQry.SQL.Text := //
      'INSERT INTO EMPLOYEE (' + //
      'EMP_NO' + //
      ', FIRST_NAME' + //
      ', LAST_NAME' + //
      ', PHONE_EXT' + //
      ', HIRE_DATE' + //
      ', DEPT_NO' + //
      ', JOB_CODE' + //
      ', JOB_GRADE' + //
      ', JOB_COUNTRY' + //
      ', SALARY' + //
      ') VALUES (' + //
      IntToStr(AEmpNo) + //
      ', ' + QuotedStr(AFullName) + //
      ', ' + QuotedStr(AFullName) + //
      ', ''250''' + //
      ', ''28-DEC-1988 00:00:00''' + //
      ', ''600''' + //
      ', ''VP''' + //
      ', 2' + //
      ', ''USA''' + //
      ', 99999)';
   try
      FDQry.ExecSQL;
      Result := True;
   except
      On E: Exception do
      begin
         ShowMessage(E.Message);
         Result := False;
      end;
   end;
end;

procedure TSM.FDConnBeforeConnect(Sender: TObject);
begin
   FDPhysFBDriverLink.VendorLib := ExtractFilePath(ParamStr(0)) + 'fbclient.dll';

   FDConn.Params.Values['Database'] := ExtractFilePath(ParamStr(0)) + 'EMPLOYEE.FDB';
   FDConn.Params.Values['UserName'] := 'sysdba';
   FDConn.Params.Values['Password'] := 'masterkey';
end;

procedure TSM.DataModuleCreate(Sender: TObject);
begin
   FDConn.Close;

   try
      FDConn.Open;
   except
      on E: Exception do
      begin
         ShowMessage(E.Message);
      end;
   end;
end;

function TSM.GetEmployeeAll: TFDJSONDataSets;
begin
   FDQry.Close;
   FDQry.Open(_SQL_EMPLOYEE_ALL);

   {$IFDEF DEBUG}
   if not FDQry.IsEmpty then
   begin
      FDQry.SaveToFile('Server-GetEmployeeAll.json', sfJSON);
      FDQry.SaveToFile('Server-GetEmployeeAll.xml', sfXML);
   end;
   {$ENDIF}
   //
   Result := TFDJSONDataSets.Create;
   TFDJSONDataSetsWriter.ListAdd(Result, EmptyStr, FDQry);
end;

function TSM.GetEmployeeId_Data(AId: integer): TFDJSONDataSets;
begin
   FDQry.Close;
   FDQry.SQL.Text := _SQL_EMPLOYEE_ID;

   // FDQry.Params[0].Value := AId; {Outra Forma de Usar}
   // FDQry.Params[0].AsInteger := AId;
   // FDQry.Params[0].ParamType := TParamType.ptInput;
   // FDQry.Params[0].DataType := TFieldType.ftInteger;

   FDQry.Params.ParamValues['EMP_NO'] := AId;
   FDQry.Open;

   {$IFDEF DEBUG}
   if not FDQry.IsEmpty then
   begin
      FDQry.SaveToFile('Server-GetEmployeeId.json', sfJSON);
      FDQry.SaveToFile('Server-GetEmployeeId.xml', sfXML);
   end;
   {$ENDIF}
   //
   Result := TFDJSONDataSets.Create;
   TFDJSONDataSetsWriter.ListAdd(Result, _SQL_EMPLOYEE_ID, FDQry);
end;

function TSM.GetEmployeeId_Bool(AId: integer; var AMessage: string): Boolean;
var
   i: integer;
begin
   Result := False;
   AMessage := 'Not result';

   FDQry.Close;
   FDQry.SQL.Text := _SQL_EMPLOYEE_ID;
   FDQry.Params.ParamValues['EMP_NO'] := AId;
   FDQry.Open;

   if not FDQry.IsEmpty then
   begin
      Result := True;

      AMessage := EmptyStr;
      FDQry.First;

      while not FDQry.Eof do
      begin
         for i := 0 to FDQry.Fields.Count - 1 do
         begin
            AMessage := AMessage + sLineBreak + FDQry.Fields[i].AsString;
         end;
         FDQry.Next;
      end;

      FDQry.SaveToFile('Server-GetEmployeeId.json', sfJSON);
      FDQry.SaveToFile('Server-GetEmployeeId.xml', sfXML);
   end;
end;

end.
