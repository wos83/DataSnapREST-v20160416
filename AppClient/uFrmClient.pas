unit uFrmClient;

interface

uses
   Data.Bind.Components,
   Data.Bind.DBScope,
   Data.Bind.EngExt,
   Data.Bind.Grid,
   Data.DB,
   Data.FireDACJSONConsts,
   Data.FireDACJSONReflect,
   FMX.Bind.DBEngExt,
   FMX.Bind.Editors,
   FMX.Bind.Grid,
   FMX.Controls,
   FMX.Controls.Presentation,
   FMX.Dialogs,
   FMX.Forms,
   FMX.Graphics,
   FMX.Grid,
   FMX.Layouts,
   FMX.StdCtrls,
   FMX.Types,
   System.Bindings.Outputs,
   System.Classes,
   System.Rtti,
   System.SysUtils,
   System.Types,
   System.UITypes,
   System.Variants,
   uCM;

type
   TfrmClient = class(TForm)
      tlbClient: TToolBar;
      lblClient: TLabel;
      grdClient: TGrid;
      bsFDMemTableEmployee: TBindSourceDB;
      blFDMemTableEmployee: TBindingsList;
      lnkFDMemTableEmployee: TLinkGridToDataSource;
      btnOn: TButton;
    btnInsert: TButton;
      procedure btnOnClick(Sender: TObject);
      procedure btnInsertClick(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   frmClient: TfrmClient;

implementation

{$R *.fmx}

procedure TfrmClient.btnOnClick(Sender: TObject);
var
   FDJSONDataSets: TFDJSONDataSets;
begin
   FDJSONDataSets := CM.SMClient.GetEmployeeAll;

   if CM.FDMemTableEmployee.Active then
      CM.FDMemTableEmployee.EmptyDataSet;

   CM.FDMemTableEmployee.Close;
   CM.FDMemTableEmployee.AppendData( //
      TFDJSONDataSetsReader.GetListValue(FDJSONDataSets, 0));
end;

procedure TfrmClient.btnInsertClick(Sender: TObject);
var
   bEmployeeInsert: Boolean;
begin
   bEmployeeInsert := CM.SMClient.SetEmployee(301, 'Desenv');

   if bEmployeeInsert then
      ShowMessage('Inseriu com sucesso.')
   else
      ShowMessage('Problemas ao inserir registro!');
end;

end.
