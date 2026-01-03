unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  frxClass, frxPreview, System.Win.Registry, Winapi.ShlObj, frxBarcode,
  Vcl.ExtCtrls, frxDesgn, UITypes;

type
  Tmain = class(TForm)
    frxReport1: TfrxReport;
    OpenDialog1: TOpenDialog;
    frxDesigner1: TfrxDesigner;
    procedure FormCreate(Sender: TObject);
  private
    procedure OpenFP3(const AFileName: string);

    { Private declarations }
  public
   procedure OpenFromCommandLine;
    { Public declarations }
  end;

var
  main: Tmain;

implementation

{$R *.dfm}

const WM_OPENFP3 = WM_APP + 1;

procedure RegisterFP3Association;
const
  Ext   = '.fp3';
  ProgId = 'LiseEd.FastReportFP3Viewer';
var
  R: TRegistry;
  ExePath: string;
begin
  ExePath := ParamStr(0);

  R := TRegistry.Create(KEY_WRITE);
  try
    R.RootKey := HKEY_CURRENT_USER;

    // .fp3 -> ProgId
    if R.OpenKey('\Software\Classes\' + Ext, True) then
    begin
      R.WriteString('', ProgId);
      R.CloseKey;
    end;

    // ProgId -> open command
    if R.OpenKey('\Software\Classes\' + ProgId + '\shell\open\command', True) then
    begin
      R.WriteString('', '"' + ExePath + '" "%1"');
      R.CloseKey;
    end;

    // Иконка (необязательно)
    if R.OpenKey('\Software\Classes\' + ProgId + '\DefaultIcon', True) then
    begin
      R.WriteString('', '"' + ExePath + '",0');
      R.CloseKey;
    end;
  finally
    R.Free;
  end;

  // Сообщить проводнику об изменении ассоциаций
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure Tmain.FormCreate(Sender: TObject);
begin
  Visible := False;
  OpenDialog1.Filter := 'FastReport preview (*.fp3)|*.fp3|All files (*.*)|*.*';
end;


procedure Tmain.OpenFP3(const AFileName: string);
begin
  frxReport1.PreviewPages.LoadFromFile(AFileName);
  frxReport1.ShowPreparedReport;                   // пользователь посмотрел и закрыл окно
  Application.Terminate;                           // после закрытия preview выходим
end;


procedure Tmain.OpenFromCommandLine;
var
  FN: string;
begin
  if ParamCount >= 1 then
  begin
    FN := ParamStr(1);
    if FileExists(FN) then
      OpenFP3(FN)
    else
      MessageDlg('Файл не найден: ' + FN, mtError, [mbOK], 0);
    Exit;
  end;

  if OpenDialog1.Execute then
    OpenFP3(OpenDialog1.FileName)
  else
    Application.Terminate; // если пользователь отменил выбор файла
end;

end.
