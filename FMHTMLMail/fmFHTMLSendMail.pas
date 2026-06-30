unit fmFHTMLSendMail;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  pInterfaces,
  pIniMgr,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.ListBox,
  pAuxEtc,
  FMX.Layouts,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.Memo.Types,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Memo,
  pVersionUtility,
  FMX.StdCtrls,
  FMX.Edit, FMX.TabControl;

type
  TfHTMLSendMail = class(TForm, ILogMsg)
    ListView1: TListView;
    GridPanelLayout1: TGridPanelLayout;
    ComboBox1: TComboBox;
    ListBox1: TListBox;
    meMessages: TMemo;
    vuMain: TVersionUtility;
    sbMain: TStatusBar;
    sbSimpleText: TLabel;
    layParamsConnenct: TLayout;
    lbServerPort: TLabel;
    edServerHostName: TEdit;
    edServerLoginPassword: TEdit;
    Label1: TLabel;
    edServerLoginName: TEdit;
    Label2: TLabel;
    edServerPort: TEdit;
    Label3: TLabel;
    tcMain: TTabControl;
    tiSettings: TTabItem;
    tiMessage: TTabItem;
    gpMessage: TGridPanelLayout;
    vsPlainText: TVertScrollBox;
    lbPlainText: TLabel;
    mePlainText: TMemo;
    vsHTMLText: TVertScrollBox;
    lbHTMLText: TLabel;
    meHTMLText: TMemo;
    btSendMail: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btSendMailClick(Sender: TObject);

  private
    { Private declarations }
    FIniFileMgr: IIniFileMgr;
    procedure SetIniFileMgr(const Value: IIniFileMgr);
    property IniFileMgr: IIniFileMgr read FIniFileMgr write SetIniFileMgr;

  public

    { Public declarations }

    { Interface logging Methods. Note the next four lines enables the handling of
      the Logging overload via a remapping of interface methods. The utilizing
      code must choose the correct overload by distinct name which is then
      remapped to the overloads via the function equivalences. }

    function LogMsg(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec): boolean; overload;
    function LogMsg(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec; var ANewLines: TStringList): boolean; overload;
    { Remap to the correct overload. }
    function ILogMsg.LogMsg = LogMsg;
    function ILogMsg.LogMsgLines = LogMsg;
  end;

var
  fHTMLSendMail: TfHTMLSendMail;

implementation

{$R *.fmx}


uses dmHTMLSendMail;

{ Send one email message using the parameters entered. }

procedure TfHTMLSendMail.btSendMailClick(Sender: TObject);
var
  LServerConnection: RServerConnection;                 // Server Connection Parameters
begin
  LServerConnection.Create(edServerHostName.Text,       // build the connection parameters record
    edServerPort.Text,
    edServerLoginName.Text,
    edServerLoginPassword.Text);
  IniFileMgr.SaveServerParams(LServerConnection, True); // save the server parameters used in this call
  if dHTMLSendMail.SendMail(LServerConnection,          // invoke the SendMail action
    meHTMLText.Lines,
    mePlainText.Lines) then
    LogMsg(emsInfo, 'Send Mail completed successfully', [])
  else
    LogMsg(emsError, 'Send Email completed with errors.', []);
end;

procedure TfHTMLSendMail.FormCreate(Sender: TObject);
var
  LServerConnection: RServerConnection;                           // Server Connection Parameters
  LAppParameters: TFileName;                                      // Application parameters ini file FQDN
  LOpenSSL_Lib_Path: string;                                      // Open SSL Library Path from command line parameter
begin
  meMessages.Lines.Clear;                                         // clear the box

  { process command line parameters }

  { Extracts the target directory command line parameters that contains the OpenSSL libraries and sets
    the GLOBAL variable GSSL_DLL_DIR.

    Warning: GSSL_DLL_DIR is defined in OverbyteIcsTypes.pas and MUST NOT be redefined here. Declaring
    it as a global variable here actually results in a different variable and you'll end up in
    either variable or .dll hell. }

  FindCmdLineSwitch('OpenSSL_Lib_Path', LOpenSSL_Lib_Path, True); // see if a parameter is available
  dHTMLSendMail.Initialize(Self, LOpenSSL_Lib_Path);              // initialize SendMail Logic; set OpenSSL path

  { Process Application Parameters, Etc. }

  Self.Caption := vuMain.AppTitleBar;                             // populate the application title bar
  LAppParameters := vuMain.AppParameters;                         // obtain the application parameter FQDN
  sbSimpleText.Text := LAppParameters;                            // display application parameter FQDN
  IniFileMgr := TIniFileMgr.Create(Self, LAppParameters);         // prepare the application parameters meminifile

  { Retrieve Server Connection Parameters }

  LServerConnection := IniFileMgr.GetServerParams;                // request parameters for server connection
  with LServerConnection do                                       // move the parameters
  begin                                                           // from the request record
    edServerHostName.Text := ServerHostName;                      // to the individual
    edServerPort.Text := ServerPort;                              // controls
    edServerLoginName.Text := ServerLoginName;                    // on the
    edServerLoginPassword.Text := ServerLoginPassword;            // form
  end;

  LoadList.Load<SMsgSeverity>(ComboBox1.Items, SMsgSeveritys);
  LoadList.Load<SReqType>(ListBox1.Items, SReqTypes);
  LoadList.Load<SReqType>(ListView1, SReqTypes);

end;

{ Local Message Logging uses memo box to display messages in a uniform format.
  This overload adds a simple one line message to the memo box. }

function TfHTMLSendMail.LogMsg(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec): boolean;
begin
  meMessages.Lines.Add(Format('%s - %s',             // format and insert the message
    [AMsgSeverity.ToString, Format(AMessage, AParams)]));
end;

{ Overloaded message functions. Both add a message line. One adds new lines to the
  end of the memo box as well. }

function TfHTMLSendMail.LogMsg(const AMsgSeverity: EMsgSeverity;
  const AMessage: String; const AParams: array of TVarRec;
  var ANewLines: TStringList): boolean;
begin
  Result := LogMsg(AMsgSeverity, AMessage, AParams); // format and insert the message
  meMessages.Lines.AddStrings(ANewLines);            // append the new lines to the end of the memo box
end;

procedure TfHTMLSendMail.SetIniFileMgr(const Value: IIniFileMgr);
begin
  FIniFileMgr := Value;
end;

end.
