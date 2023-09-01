unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WinSpool, Buttons, Grids, ExtCtrls, StdCtrls, ComCtrls;

type
  JOB_INFO_1_ARRAY = array of JOB_INFO_1;
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    Panel1: TPanel;
    Memo1: TMemo;
    Label2: TLabel;
    StatusBar1: TStatusBar;
    ComboBox1: TComboBox;
    Panel2: TPanel;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Select(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  conf_f : TextFile;
  c_pos : integer;

implementation

{$R *.dfm}

function GetSpoolerJobs(sPrinterName: string): JOB_INFO_1_ARRAY;
var
i: Integer;
hPrinter: THandle;
bResult: Boolean;
cbBuf: DWORD;
pcbNeeded: DWORD;
pcReturned: DWORD;
aJobs: array[0..99] of JOB_INFO_1;
begin
cbBuf := 1000;
bResult := OpenPrinter(PChar(sPrinterName), hPrinter, nil);
if not bResult then
begin
//   ShowMessage('Error opening the printer');
   form1.caption := 'PrinterMon 1.0 - Error opening the printer';
   exit;
end;
bResult := EnumJobs(hPrinter, 0, Length(aJobs), 1, @aJobs, cbBuf, pcbNeeded,
   pcReturned);
if not bResult then
begin
//   ShowMessage('Error Getting Jobs information');
   form1.caption := 'PrinterMon 1.0 - Error Getting Jobs information';
   exit;
end

else form1.caption := 'PrinterMon 1.0';

ClosePrinter(hPrinter);
for i := 0 to pcReturned - 1 do
begin
   if aJobs[i].pDocument <> nil then
   begin
     SetLength(Result, Length(Result) + 1);
     Result[Length(Result) - 1] := aJobs[i];
   end;
end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
lastp : string;
i, ii: Integer;
aJobs: JOB_INFO_1_ARRAY;
begin

lastp := StringGrid1.Cells[1, 1];

for i := 1 to StringGrid1.RowCount - 1 do                 // i := 0 заменил на i := 1
   for ii := 1 to StringGrid1.ColCount - 1 do             // ii := 0 заменил на i := 1
     StringGrid1.Cells[ii, i] := '';                      //i поменял на ii
//aJobs := GetSpoolerJobs('\\Piol-pc\Sharp AR-M317 PCL 6');
//aJobs := GetSpoolerJobs('\\RIO4\WorkCentre M123');
aJobs := GetSpoolerJobs(ComboBox1.Text);
for i := 1 to Length(aJobs) - 1 do
begin
   StringGrid1.Cells[0, i] := floattostr(aJobs[i].Position);
   StringGrid1.Cells[1, i] := aJobs[i].pDocument;
   StringGrid1.Cells[2, i] := floattostr(aJobs[i].TotalPages);
   StringGrid1.Cells[3, i] := aJobs[i].pPrinterName;
   StringGrid1.Cells[4, i] := aJobs[i].pMachineName;
   StringGrid1.Cells[5, i] := aJobs[i].pUserName;
   StringGrid1.Cells[6, i] := IntToStr(aJobs[i].Status);
   case aJobs[i].Status of
     JOB_STATUS_PAUSED: StringGrid1.Cells[6, i] := 'JOB_STATUS_PAUSED';
     JOB_STATUS_ERROR: StringGrid1.Cells[6, i] := 'JOB_STATUS_ERROR';
     JOB_STATUS_DELETING: StringGrid1.Cells[6, i] := 'JOB_STATUS_DELETING';
     JOB_STATUS_SPOOLING: StringGrid1.Cells[6, i] := 'JOB_STATUS_SPOOLING';
     JOB_STATUS_PRINTING: StringGrid1.Cells[6, i] := 'JOB_STATUS_PRINTING';
     JOB_STATUS_OFFLINE: StringGrid1.Cells[6, i] := 'JOB_STATUS_OFFLINE';
     JOB_STATUS_PAPEROUT: StringGrid1.Cells[6, i] := 'JOB_STATUS_PAPEROUT';
     JOB_STATUS_PRINTED: StringGrid1.Cells[6, i] := 'JOB_STATUS_PRINTED';
     JOB_STATUS_DELETED: StringGrid1.Cells[6, i] := 'JOB_STATUS_DELETED';
     JOB_STATUS_BLOCKED_DEVQ: StringGrid1.Cells[6, i] :=
       'JOB_STATUS_BLOCKED_DEVQ';
     JOB_STATUS_USER_INTERVENTION: StringGrid1.Cells[6, i] :=
       'JOB_STATUS_USER_INTERVENTION';
     JOB_STATUS_RESTART: StringGrid1.Cells[6, i] := 'JOB_STATUS_RESTART';
     JOB_POSITION_UNSPECIFIED: StringGrid1.Cells[6, i] :=
       'JOB_POSITION_UNSPECIFIED';
   else
     StringGrid1.Cells[6, i] := 'Unknown status...';
   end;
end;

StringGrid1.Refresh;

if StringGrid1.Cells[1, 1] <> lastp then
  begin
  memo1.Lines.Add(lastp);
  lastp := StringGrid1.Cells[1, 1];
  end;

Memo1.Text := StringReplace(Memo1.Text, #13#10#13#10, #13#10, [rfReplaceAll]);
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
   if FileExists('config.txt') then
       begin
       AssignFile(conf_f, 'config.txt');
       Reset(conf_f);
       Read(conf_f, c_pos);
       end else caption := 'PrinterMon 1.0 - нет файла конфигурации';

ComboBox1.Items.LoadFromFile('name.txt');
ComboBox1.ItemIndex := c_pos;
CloseFile(conf_f);

StringGrid1.ColWidths[0] := 30;
StringGrid1.ColWidths[1] := 400;
StringGrid1.ColWidths[2] := 30;
StringGrid1.ColWidths[3] := 150;
StringGrid1.ColWidths[4] := 50;
StringGrid1.ColWidths[5] := 50;
StringGrid1.ColWidths[6] := 200;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
   StringGrid1.Cells[0, 0] := '№';
   StringGrid1.Cells[1, 0] := 'Имя файла';
   StringGrid1.Cells[2, 0] := 'стр.';
   StringGrid1.Cells[3, 0] := 'Принтер';
   StringGrid1.Cells[4, 0] := 'Машина';
   StringGrid1.Cells[5, 0] := 'Польз.';
   StringGrid1.Cells[6, 0] := 'Статус задания';
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin

   if FileExists('config.txt') then
       begin
       AssignFile(conf_f, 'config.txt');
       Rewrite(conf_f);
       Write(conf_f, ComboBox1.ItemIndex);
       CloseFile(conf_f);
       end

//   Write(conf_f, ComboBox1.ItemIndex);
//   CloseFile(conf_f);
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
memo1.Clear;
end;

end.
