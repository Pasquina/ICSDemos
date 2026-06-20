unit pIniMgr;

{ Initialization manager.
  1. Handles a MemInifile on behalf of an invoker
  2. Retrieves and returns application information from the Inifile via a record def
  3. Accepts and saves application information to the Inifile via a record def
  4. Performes Open and CLose operations
}

interface

uses
  System.SysUtils,
  System.IniFiles,
  pAuxEtc;

type
  TIniFileMgr = class(TInterfacedObject, IIniFileMgr)
  private
    FProgIni: TMemIniFile;
    FLogMsg: ILogMsg;
    procedure SetLogMsg(const Value: ILogMsg);
    property LogMsg: ILogMsg read FLogMsg write SetLogMsg;
    procedure SetProgIni(const Value: TMemIniFile);
    property ProgIni: TMemIniFile read FProgIni write SetProgIni;

  protected
  public
    constructor Create(const ALogMsg: ILogMsg; const AMemIniFQDN: TFilename);
    destructor Destroy; override;
    function GetServerParams: RServerConnection;
    function SaveServerParams(const AServerConnection: RServerConnection; const AForceWrite: boolean = False): boolean;
  end;

implementation

{ TIniFileMgr }

constructor TIniFileMgr.Create(const ALogMsg: ILogMsg;
  const AMemIniFQDN: TFilename);
begin
  LogMsg := ALogMsg;                                            // save logging callback address
  ForceDirectories(ExtractFileDir(AMemIniFQDN));                // make sure the path exists
  ProgIni := TMemIniFile.Create(AMemIniFQDN);                   // open the parameters
  ProgIni.AutoSave := True;                                     // automatic save before destruction
  LogMsg.LogMsg(emsInfo, 'MemIniFIle creation completed.', []); // log initialization event
end;

destructor TIniFileMgr.Destroy;
begin
  ProgIni.Free;                                        // release ini file and automtically save it
end;

{ Returns a record that contains the Server Parameters stored in the ini file. }

function TIniFileMgr.GetServerParams: RServerConnection;
begin

  { Return the Server Parameter Record values. }

  Result := RServerConnection.Create(ProgIni.ReadString('Server', 'ServerHostName', 'Server Host Name'),
    ProgIni.ReadString('Server', 'ServerPort', 'Server Port'),
    ProgIni.ReadString('Server', 'ServerLoginName', 'Server Login Name'),
    ProgIni.ReadString('Server', 'ServerLoginPassword', 'Server Login Password'));
end;

{ Writes the Server Parameter Values into the memini file }

function TIniFileMgr.SaveServerParams(
  const AServerConnection: RServerConnection;
  const AForceWrite: boolean): boolean;
begin

  Result := True;

  try
    with AServerConnection do
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

procedure TIniFileMgr.SetLogMsg(const Value: ILogMsg);
begin
  FLogMsg := Value;
end;

procedure TIniFileMgr.SetProgIni(const Value: TMemIniFile);
begin
  FProgIni := Value;
end;

end.
