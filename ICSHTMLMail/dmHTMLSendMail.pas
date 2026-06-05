unit dmHTMLSendMail;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  pVersionUtility,
  pAuxEtc,
  OverbyteIcsTypes,
  OverbyteIcsSslBase,
  OverbyteIcsWndControl,
  OverbyteIcsSmtpProt;

type
  TdHTMLSendMail = class(TDataModule)
    vuMain: TVersionUtility;
    shscMain: TSslHtmlSmtpCli;
    SslHtmlSmtpCli1: TSslHtmlSmtpCli;
    procedure DataModuleDestroy(Sender: TObject);
    procedure shscMainAfterFileOpen(Sender: TObject; Idx: Integer;
      FileName: string; E: Exception; var Action: TSmtpAfterOpenFileAction);
    procedure shscMainBeforeOutStreamFree(Sender: TObject);

  private
    { Private declarations }
    FProgIni: TMemIniFile;
    FLogMsg: ILogMsg;
    procedure SetProgIni(const Value: TMemIniFile);
    procedure SetLogMsg(const Value: ILogMsg);
    property ProgIni: TMemIniFile read FProgIni write SetProgIni;
    property LogMsg: ILogMsg read FLogMsg write SetLogMsg;

  public
    { Public declarations }
    function Initialize(const ALogMsg: ILogMsg): string;
    function GetServerParams: RServerConnection;
    function SaveServerParams(const ServerConnection: RServerConnection; const AForceWrite: boolean = False): boolean;
  end;

var
  dHTMLSendMail: TdHTMLSendMail;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


uses
  System.IOUtils;

{$R *.dfm}

{ TdHTMLSendMail }

procedure TdHTMLSendMail.DataModuleDestroy(Sender: TObject);
begin
  ProgIni.Free; // release ini file and automtically save it
end;

{ Returns a record that contains the Server Parameters stored in the ini file. }

function TdHTMLSendMail.GetServerParams: RServerConnection;
begin
  Result := RServerConnection.Create(ProgIni.ReadString('Server', 'ServerHostName', 'Server Host Name'),
    ProgIni.ReadString('Server', 'ServerPort', 'Server Port'),
    ProgIni.ReadString('Server', 'ServerLoginName', 'Server Login Name'),
    ProgIni.ReadString('Server', 'ServerLoginPassword', 'Server Login Password'));
end;

function TdHTMLSendMail.Initialize(const ALogMsg: ILogMsg): string;
begin
  LogMsg := ALogMsg;                                                      // save logging callback address
  Result := vuMain.AppParameters;                                         // obtain the application parameter FQDN
  ForceDirectories(ExtractFileDir(Result));                               // make sure the path exists
  ProgIni := TMemIniFile.Create(Result);                                  // open the parameters
  ProgIni.AutoSave := True;                                               // automatic save before destruction
  ProgIni.WriteString('TestSection', 'SomeValue', 'Here is the string.'); // testing only; remove later
  LogMsg.LogMsg(emsInfo, 'Initialization completed.', []);                // log initialization event
end;

{ Writes the Server Parameter Values into the memini file }

function TdHTMLSendMail.SaveServerParams(
  const ServerConnection: RServerConnection; const AForceWrite: boolean = False): boolean;
begin

  Result := True;

  try
    with ServerConnection do
    begin
      ProgIni.WriteString('Server', 'ServerHostName', ServerHostName);           // update the
      ProgIni.WriteString('Server', 'ServerPort', ServerPort);                   // memini file
      ProgIni.WriteString('Server', 'ServerLoginName', ServerLoginName);         // with the
      ProgIni.WriteString('Server', 'ServerLoginPassword', ServerLoginPassword); // current server parameter values
    end;
    if AForceWrite then                                                          // test the write file request
      ProgIni.UpdateFile;                                                        // requested: write the file
  except
    on E: Exception do                                                           // not expecting any but just in case
    begin
      LogMsg.LogMsg(emsError, E.Message, []);                                    // display the message
      Result := False;                                                           // no success
    end;
  end;
end;

procedure TdHTMLSendMail.SetLogMsg(const Value: ILogMsg);
begin
  FLogMsg := Value;
end;

procedure TdHTMLSendMail.SetProgIni(const Value: TMemIniFile);
begin
  FProgIni := Value;
end;

procedure TdHTMLSendMail.shscMainAfterFileOpen(Sender: TObject; Idx: Integer;
  FileName: string; E: Exception; var Action: TSmtpAfterOpenFileAction);
begin

end;

{ Add the MIME message lines to the message box as a debugging tool. }

procedure TdHTMLSendMail.shscMainBeforeOutStreamFree(Sender: TObject);
var
  LStreamLines: TStringList;                                                                             // conversion work area
begin
  LStreamLines := TStringList.Create;                                                                    // create the work area
  try
    with TSslHtmlSmtpCli(Sender) do                                                                      // always reference the event source
    begin
      OutStream.Position := 0;                                                                           // start from the beginning
      LStreamLines.LoadFromStream(OutStream);                                                            // create lines from the stream
      LogMsg.LogMsgLines(emsInfo, 'Generated MIME message follows =================', [], LStreamLines); // separator message
    end;
  finally
    LStreamLines.Free;                                                                                   // done, go home
  end;
end;

end.
