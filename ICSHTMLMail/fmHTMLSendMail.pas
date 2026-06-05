unit fmHTMLSendMail;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Buttons,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  Vcl.WinXPanels,
  System.Generics.Collections,
  OverbyteIcsTypes,
  OverbyteIcsSslBase,
  Vcl.Mask,
  OverbyteIcsWndControl,
  OverbyteIcsSmtpProt,
  pAuxEtc,
  Vcl.ComCtrls;

type
  TfHTMLSendMail = class(TForm, ILogMsg)
    svMain: TSplitView;
    pnMaian: TPanel;
    shscMain: TSslHtmlSmtpCli;
    leMailFrom: TLabeledEdit;
    GPMain: TGridPanel;
    spemp1: TStackPanel;
    pnHTMLText: TPanel;
    Label1: TLabel;
    meHTMLText: TMemo;
    leMailTo: TLabeledEdit;
    pnPlainText: TPanel;
    Label2: TLabel;
    mePlainText: TMemo;
    Button1: TButton;
    SslContext1: TSslContext;
    meMessages: TMemo;
    leServerHostName: TLabeledEdit;
    leServerPort: TLabeledEdit;
    spServerParams: TStackPanel;
    leServerLoginName: TLabeledEdit;
    leServerLoginPassword: TLabeledEdit;
    gpInternals: TGridPanel;
    StatusBar1: TStatusBar;
    sbMain: TStatusBar;
    procedure sbDrawerClick(Sender: TObject);
    procedure svMainDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure shscMainRequestDone(Sender: TObject; RqType: TSmtpRequest;
      ErrorCode: Word);
    procedure shscMainSslVerifyPeer(Sender: TObject; var Ok: Integer;
      Cert: TX509Base);
    procedure FormCreate(Sender: TObject);
    procedure shscMainBeforeOutStreamFree(Sender: TObject);
    procedure shscMainSessionConnected(Sender: TObject; ErrCode: Word);

  private
    { Private declarations }
    FEhloCount: Integer;
    procedure SetEhloCount(const Value: Integer);
    property EhloCount: Integer read FEhloCount write SetEhloCount;
    function ApplyServerParams: boolean;

  public
    { Public declarations }

    { Interface logging Methods. Note the next four lines enables the handling of
      the Logging overload via a remapping of interface methods. The utilizing
      code must choose the correct overload by distinct name which is then
      remapped to the overloads via the function equivalences. }

    function LogMsg(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec): boolean; overload;
    function LogMsg(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec; var ANewLines: TStringList): boolean; overload;
    { Remap to the correct overload.  }
    function ILogMsg.LogMsg = LogMsg;
    function ILogMsg.LogMsgLines = LogMsg;
  end;

var
  fHTMLSendMail: TfHTMLSendMail;

implementation

uses
  dmHTMLSendMail;

{$R *.dfm}

{ Retrieve the server parameter values from their respective edic controls. For each:
  apply it to the SMTP Client Sendmail Object. Finally, build a server parameter record
  and invoke the server parameter save routine to make the setting persistent.
}

function TfHTMLSendMail.ApplyServerParams: boolean;
begin
  { Set the component properties. }

  with shscMain do
  begin
    Host := leServerHostName.Text;
    Port := leServerPort.Text;
    Username := leServerLoginName.Text;
    Password := leServerLoginPassword.Text;
  end;

  { Update the inifile values. }

  if dHTMLSendMail.SaveServerParams(RServerConnection.Create(     // create the record
    leServerHostName.Text,                                        // populate the
    leServerPort.Text,                                            // server parameter values
    leServerLoginName.Text,                                       // invoke the
    leServerLoginPassword.Text)) then                             // inifile update routine
  begin
    LogMsg(emsInfo, 'Server parameters successfuly saved.', []);  // log success
    Result := True;
  end
  else
  begin
    LogMsg(emsError, 'Server parameters save unsuccessful.', []); // log failure
    Result := False;
  end;
end;

{ Send one email message using the parameters entered. }

procedure TfHTMLSendMail.Button1Click(Sender: TObject);
begin
  meMessages.Lines.Clear;                                         // clear the message display
  if shscMain.Connected then                                      // make sure
    shscMain.Quit;                                                // we aren't connected

  if ApplyServerParams then
  begin
    shscMain.HtmlText.Assign(meHTMLText.Lines);                   // set the email message HTML
    shscMain.MailMessage.Assign(mePlainText.Lines);               // set the email plain text
    shscMain.Connect;                                             // connect launches the entire sending activity
  end;

end;

{ Some setup housekeeping. }

procedure TfHTMLSendMail.FormCreate(Sender: TObject);
var
  LServerConnection: RServerConnection;                           // Server Connection Parameters
begin
  meMessages.Lines.Clear;                                         // clear the box
  sbMain.SimpleText := dHTMLSendMail.Initialize(Self);            // initialize and obtain the inifile FQDN for display
  LServerConnection := dHTMLSendMail.GetServerParams;             // request parameters for server connection
  with LServerConnection do                                       // move the parameters
  begin                                                           // from the request record
    leServerHostName.Text := ServerHostName;                      // to the individual
    leServerPort.Text := ServerPort;                              // controls
    leServerLoginName.Text := ServerLoginName;                    // on the
    leServerLoginPassword.Text := ServerLoginPassword;            // form
  end;
end;

{ Overloaded message functions. Both add a message line. One adds new lines to the
  end of the memo box as well.  }

function TfHTMLSendMail.LogMsg(const AMsgSeverity: EMsgSeverity;
  const AMessage: String; const AParams: array of TVarRec;
  var ANewLines: TStringList): boolean;
begin
  Result := LogMsg(AMsgSeverity, AMessage, AParams);    // format and insert the message
  meMessages.Lines.AddStrings(ANewLines);                                               // append the new lines to the end of the memo box
end;

{ Local Message Logging uses memo box to display messages in a uniform format.
  This overload adds a simple one line message to the memo box.  }

function TfHTMLSendMail.LogMsg(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec): boolean;
begin
  meMessages.Lines.Add(Format('%s - %s',                          // format and insert the message
    [AMsgSeverity.ToString, Format(AMessage, AParams)]));
end;

procedure TfHTMLSendMail.sbDrawerClick(Sender: TObject);
begin
  svMain.Opened := not svMain.Opened;                             // toggle the split view open and closed
end;

procedure TfHTMLSendMail.SetEhloCount(const Value: Integer);
begin
  FEhloCount := Value;
end;

{ Add the MIME message lines to the message box as a debugging tool. }

procedure TfHTMLSendMail.shscMainBeforeOutStreamFree(Sender: TObject);
var
  LStreamLines: TStringList;                                                   // conversion work area
begin
  LStreamLines := TStringList.Create;                                          // create the work area
  try
    with TSslHtmlSmtpCli(Sender) do                                            // always reference the event source
    begin
      LogMsg(emsInfo, 'Generated MIME message follows =================', []); // separator message
      OutStream.Position := 0;                                                 // start from the beginning
      LStreamLines.LoadFromStream(OutStream);                                  // create lines from the stream
      meMessages.Lines.AddStrings(LStreamLines);                               // add the lines to the memo
    end;
  finally
    LStreamLines.Free;                                                         // done, go home
  end;
end;

{ Display the status after each operation. }

procedure TfHTMLSendMail.shscMainRequestDone(Sender: TObject;
  RqType: TSmtpRequest; ErrorCode: Word);
begin

  { Quit if an unexpected error is encountered.
    Initiate next request in the conversation. }

  if (ErrorCode <> 0) then                                   // test for error
  begin
    LogMsg(emsError, 'Request %s completed. Completion code: %u; %s.', [RqType.ToString, ErrorCode, shscMain.ErrorMessage]);
    shscMain.Quit;                                           // terminate any outstanding operations
    Exit;                                                    // immediate exit
  end
  else
    LogMsg(emsInfo, 'Request %s completed. Completion code: %u; %s.', [RqType.ToString, ErrorCode, shscMain.ErrorMessage]);

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
        Inc(FEhloCount);                                     // the count is assumed to start at zero
        if FEhloCount = 1 then                               // the first time causes the request for TLS to be sent
          shscMain.StartTls                                  // explicit TLS request
        else if FEhloCount > 1 then                          // subsequently, a successful StartTLS resumes the processing
          shscMain.Auth;                                     // continue on to authorization
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
      ShowMessage('Completed');                              // log it and we're done
  end;
end;

{ Create the memory stream for logging the email content.
  Note that the existing code only logs the RFC MIME content; it does not contain
  the envelope commands, which are handled by a different object. }

procedure TfHTMLSendMail.shscMainSessionConnected(Sender: TObject;
  ErrCode: Word);
begin
  TSslHtmlSmtpCli(Sender).OutStream := TMemoryStream.Create; // create the filestream for logging content
end;

{ Logs the peer verification and certificate chain for examination. }

procedure TfHTMLSendMail.shscMainSslVerifyPeer(Sender: TObject; var Ok: Integer;
  Cert: TX509Base);
begin
  LogMsg(emsInfo, 'Verify Peer: OK = %u, Certificate: %s', [Ok, Cert.CertMainInfo]);
end;

procedure TfHTMLSendMail.svMainDblClick(Sender: TObject);
begin
  svMain.Opened := NOT svMain.Opened; // toggle the split view  open and closed
end;

end.
