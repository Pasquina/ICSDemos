unit pAuxEtc;

{ Implements helper classes for various ICS enumerations.
  Defines records with constructors for convenient and efficient passing of
    component properties between methods.
  Defines any needed Interfaces that might be required for archetectural reasons.
  Author: Milan Vydareny
  Permission granted for commercial and private use.
  Attribution appreciated, but not required.
}

interface

uses OverbyteIcsTypes,
  System.Classes;

type

  EReqTypes = set of TSMTPRequest;                              // sometimes a set of enumerations can be useful
  SReqType = type string;                                       // avoids a clash with existing string helpers

  EMsgSeverity = (emsInfo, emsWarn, emsError, emsCatastrophic); // message level severity
  EMsgSeveritys = set of EMsgSeverity;                          // tdhe set of all message severities
  SMsgSeverity = type string;                                   // for display message severity avoiding a clash with string helpers

  TReqTypeHelper = record helper for TSMTPRequest               // convert Request Type enumeration to a string
  public
    function ToString: SReqType;                                // quite simple really
  end;

  TReqTypeStringHelper = record helper for SReqType             // the reverse of ToString
  public
    function ToReqType: TSMTPRequest;                           // convert the string to the enum
  end;

  TMsgSeverityHelper = record helper for EMsgSeverity           // convert the message severity to a string
    function ToString: SMsgSeverity;                            // make the message severity readable
  end;

  TMsgSeverityStringHelper = record helper for SMsgSeverity     // the reverse of ToString
    function ToMsgSeverity: EMsgSeverity;                       // convert the string to the enumeration
  end;

  { Record used to pass server parameter information. }

  RServerConnection = record
    ServerHostName: string;                                     // SMTP Server FQDN
    ServerPort: string;                                         // SMTP Server Host (May be Symbolic or numeric)
    ServerLoginName: string;                                    // SMTP Server Login Name
    ServerLoginPassword: string;                                // SMTP Server Login Password
    constructor Create(const AServerHostName: string; AServerPort: string; const AServerLoginName: string; AServerLoginPassword: string);
  end;

  { Interface used to centralize the logging of the system. }

  ILogMsg = interface
    ['{FB78C070-A55D-443C-9DF5-C0D7265F2AEB}']
    function LogMsg(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec): boolean;
    function LogMsgLines(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec; var ANewLines: TStringList): boolean;
  end;

implementation

uses
  System.SysUtils;

const

  { Constants determine the results of the ToString conversion. }

  SReqTypes:
    array [TSMTPRequest] of SReqType = (
    'Connect', 'Helo', 'MailFrom', 'Vrfy', 'RcptTo', 'Data', 'Quit', 'Rset',
    'Open', 'Mail', 'Ehlo', 'Auth', 'StartTls',
    'CalcMsgSize', 'MailFromSIZE', 'ToFile', 'Custom');

  SMsgSeveritys: array [EMsgSeverity] of SMsgSeverity = (
    'Information', 'Warning', 'Error', 'Catastrophy');

  { TReqTypeHelper }

  { Convert the Request Type enumeration to a readable string. }

function TReqTypeHelper.ToString: SReqType;
begin
  Result := SReqTypes[Self];                                                                 // return the appropriate string
end;

{ TReqTypeStringHelper }

{ Convert the readable string to the correspnding enumeration. Case doesn't count. }

function TReqTypeStringHelper.ToReqType: TSMTPRequest;
var
  LSMTPRequest: TSMTPRequest;                                                                // loop variable
begin
  for LSMTPRequest := Low(TSMTPRequest) to High(TSMTPRequest) do                             // loop through the string mnemonics
    if SameText(Self, SReqTypes[LSMTPRequest]) then                                          // test for a case insensitive match
      Exit(LSMTPRequest);                                                                    // return the enumeration if found
  Raise ERangeError.CreateFmt('"%s" is not a recognizable SMTP operation.', [Self]);         // not found
end;

{ TMsgSeverityHelper }

{ Convert the Message Severity enumeration to a readable string. }

function TMsgSeverityHelper.ToString: SMsgSeverity;
begin
  Result := SMsgSeveritys[Self];                                                             // return the readable message severity
end;

{ TMsgSeverityStringHelper }

{ Convert the readable Message Severity string to the correspnding enumeration. Case doesn't count. }

function TMsgSeverityStringHelper.ToMsgSeverity: EMsgSeverity;
var
  LMsgSeverity: EMsgSeverity;                                                                // looper
begin
  for LMsgSeverity := Low(EMsgSeverity) to High(EMsgSeverity) do                             // loop through the Message Level mnemonics
    if SameText(Self, SMsgSeveritys[LMsgSeverity]) then                                      // test for a case insensitive match
      Exit(LMsgSeverity);                                                                    // return the enumeration if found
  Raise ERangeError.CreateFmt('"%s" is not a recognizable Message Severity level.', [Self]); // not found
end;

{ RServerConnection }

{ Server Parameter Record constructor also provides all necessary information. }

constructor RServerConnection.Create(const AServerHostName: string;
  AServerPort: string; const AServerLoginName: string; AServerLoginPassword: string);
begin
  ServerHostName := AServerHostName;                                                         // SMTP Server Host Name
  ServerPort := AServerPort;                                                                 // SMTP Server Port
  ServerLoginName := AServerLoginName;                                                       // SMTP Server Login Username
  ServerLoginPassword := AServerLoginPassword;                                               // SMTP Server Login Password
end;

end.
