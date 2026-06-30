unit dmHTMLSendMail;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  pVersionUtility,
  pAuxEtc,
  pInterfaces,
  OverbyteIcsTypes,
  OverbyteIcsSslBase,
  OverbyteIcsWndControl,
  OverbyteIcsSmtpProt;

type
  TdHTMLSendMail = class(TDataModule)
    shscMain: TSslHtmlSmtpCli;
    scMain: TSslContext;
    NoName: TSslContext;
    procedure shscMainBeforeOutStreamFree(Sender: TObject);
    procedure shscMainRequestDone(Sender: TObject; RqType: TSmtpRequest;
      ErrorCode: Word);
    procedure shscMainSessionConnected(Sender: TObject; ErrCode: Word);
    procedure shscMainSslVerifyPeer(Sender: TObject; var Ok: Integer;
      Cert: TX509Base);

  private
    { Private declarations }
    FLogMsg: ILogMsg;
    FStartTLSSent: boolean;
    procedure SetLogMsg(const Value: ILogMsg);
    procedure SetStartTLSSent(const Value: boolean);
    property LogMsg: ILogMsg read FLogMsg write SetLogMsg;
    property StartTLSSent: boolean read FStartTLSSent write SetStartTLSSent;
    function ApplyServerParams(const AServerConnection: RServerConnection): boolean;
    function ApplyMIMEContent(const AHTMLText: TStrings; const APlainText: TStrings): boolean;

  public
    { Public declarations }
    procedure Initialize(const ALogMsg: ILogMsg; const AOpenSSL_Lib_Path: string = '');
    function SendMail(const [ref] AServerConnection: RServerConnection; const AHTMLText: TStrings; const APlainText: TStrings): boolean;
  end;

var
  dHTMLSendMail: TdHTMLSendMail;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


uses
  System.IOUtils;

{$R *.dfm}

{ TdHTMLSendMail }

{ Apply the MIME text elements to the SslHtmlSmtpCli properties. }

function TdHTMLSendMail.ApplyMIMEContent(const AHTMLText,
  APlainText: TStrings): boolean;
begin
  with shscMain do
  begin
    HtmlText.Assign(AHTMLText);   // the HTML format
    PlainText.Assign(APlainText); // the plain text format
  end;
end;

{ Apply the server parameter values to the SslHtmlSmtpCli properties. }

function TdHTMLSendMail.ApplyServerParams(
  const AServerConnection: RServerConnection): boolean;
begin

  { Set the component properties. }

  with shscMain do
  begin
    Host := AServerConnection.ServerHostName;                              // host
    Port := AServerConnection.ServerPort;                                  // Port
    Username := AServerConnection.ServerLoginName;                         // server login name
    Password := AServerConnection.ServerLoginPassword;                     // server login passwoird
  end;

  Result := True;                                                          // never fails
end;

procedure TdHTMLSendMail.Initialize(const ALogMsg: ILogMsg; const AOpenSSL_Lib_Path: string = '');
begin
  LogMsg := ALogMsg;                                                       // save logging callback address
  GSSL_DLL_DIR := '';                                                      // start with an empty path
  if Trim(AOpenSSL_Lib_Path) <> '' then                                    // test for non-zero length spec
    GSSL_DLL_DIR := IncludeTrailingPathDelimiter(Trim(AOpenSSL_Lib_Path)); // attach the trailing delimiter (required by ICS code)
  LogMsg.LogMsg(emsInfo, 'OpenSSL Path is %s.', [GSSL_DLL_DIR]);           // log the OpenSSL library path
  LogMsg.LogMsg(emsInfo, 'Initialization completed.', []);                 // log initialization event
end;

procedure TdHTMLSendMail.SetStartTLSSent(const Value: boolean);
begin
  FStartTLSSent := Value;
end;

{ Accept user specified parameters and mail text; send the mail message. }

function TdHTMLSendMail.SendMail(const [ref] AServerConnection: RServerConnection;
  const AHTMLText, APlainText: TStrings): boolean;
begin
  Result := False;
  StartTLSSent := False;                                         // Initialize the StartTLS State
  if shscMain.Connected then                                     // test existing connection
    shscMain.Quit;                                               // close connection if found
  ApplyServerParams(AServerConnection);                          // apply the parameters to the TSslHtmlSmtp component
  ApplyMIMEContent(AHTMLText, APlainText);                       // apply the MIME content to the email body
  shscMain.Connect;                                              // connect launches the entire sending activity
  LogMsg.LogMsg(emsInfo, 'OpenSSL Path is %s.', [GSSL_DLL_DIR]); // log the OpenSSL library path
  Result := True;
end;

procedure TdHTMLSendMail.SetLogMsg(const Value: ILogMsg);
begin
  FLogMsg := Value;
end;

{ Add the MIME message lines to the message box as a debugging tool. }

procedure TdHTMLSendMail.shscMainBeforeOutStreamFree(Sender: TObject);
var
  LStreamLines: TStringList;                  // conversion work area
begin
  LStreamLines := TStringList.Create;         // create the work area
  try
    with TSslHtmlSmtpCli(Sender) do           // always reference the event source
    begin
      OutStream.Position := 0;                // start from the beginning
      LStreamLines.LoadFromStream(OutStream); // create lines from the stream
      LogMsg.LogMsgLines(emsInfo,             // separator message
        'Generated MIME message follows =================', [], LStreamLines);
    end;
  finally
    LStreamLines.Free;                        // done, go home
  end;
end;

{ Display the status after each operation. }

procedure TdHTMLSendMail.shscMainRequestDone(Sender: TObject;
  RqType: TSmtpRequest; ErrorCode: Word);
begin

  { Quit if an unexpected error is encountered.
    Initiate next request in the conversation. }

  if (ErrorCode <> 0) then                                   // test for error
  begin
    LogMsg.LogMsg(emsError, 'Request %s completed. Completion code: %u; %s.', [RqType.ToString, ErrorCode, shscMain.ErrorMessage]);
    shscMain.Quit;                                           // terminate any outstanding operations
    Exit;                                                    // immediate exit
  end
  else
    LogMsg.LogMsg(emsInfo, 'Request %s completed. Completion code: %u; %s.', [RqType.ToString, ErrorCode, shscMain.ErrorMessage]);

  { After each operation, select the appropriate operation to continue sending. }

  case RqType of                                             // determine sequence by testing the request type
    smtpConnect:                                             // following a successful connect
      begin
        if shscMain.AuthType = smtpAuthNone then             // AuthNone requires a different salutation
          shscMain.Helo                                      // no authorization (must be accepted by server)
        else
          shscMain.Ehlo;                                     // begin authorization processing
      end;
    smtpHelo:
      shscMain.MailFrom;                                     // after a successful Helo, jump right in to MailFrom
    smtpEhlo:
      if shscMain.SslType = smtpTlsExplicit then             // with explicit TLS the client must ask to start TLS
      begin
        if StartTLSSent then                                 // test StartTLS already sent
          shscMain.Auth                                      // if sent continue with Auth
        else
        begin                                                // not sent
          shscMain.StartTls;                                 // Issue StartTLS
          StartTLSSent := True;                              // Only StartTLS one time
        end;
      end
      else                                                   // the request was Implicit TLS
        shscMain.Auth;                                       // so just go on to authorization
    smtpStartTls:                                            // the result of explicit TLS is to start it
      shscMain.Ehlo;                                         // re-issue the Ehlo command following the StartTLS
    smtpAuth:                                                // finally authenticated and authorized
      shscMain.MailFrom;                                     // continue with the MailFrom
    smtpMailFrom:                                            // MailFrom success
      shscMain.RcptTo;                                       // keep going with RcptTo
    smtpRcptTo:                                              // ReptTo is OK
      shscMain.Data;                                         // Now it's time for real data
    smtpData:                                                // at long last, all done
      shscMain.Quit;                                         // so let's quite and get on with things
    smtpQuit:                                                // a successful quit
      LogMsg.LogMsg(emsInfo, 'Completed', []);               // log it and we're done
  end;
end;

{ Create the memory stream for logging the email content.
  Note that the existing code only logs the RFC MIME content; it does not contain
  the envelope commands, which are handled by a different object. }

procedure TdHTMLSendMail.shscMainSessionConnected(Sender: TObject;
  ErrCode: Word);
begin
  TSslHtmlSmtpCli(Sender).OutStream := TMemoryStream.Create; // create the filestream for logging content
end;

{ Logs the peer verification and certificate chain for examination. }

procedure TdHTMLSendMail.shscMainSslVerifyPeer(Sender: TObject; var Ok: Integer;
  Cert: TX509Base);
begin
  LogMsg.LogMsg(emsInfo, 'Verify Peer: OK = %u, Certificate: %s', [Ok, Cert.CertMainInfo]);
end;

end.
