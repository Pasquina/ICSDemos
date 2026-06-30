unit pInterfaces;

{ Interfaces defined separately in an attempt to avoid circular unit references.
  All Interfaces should be defined here or in additional interface units.
}

interface

uses
  System.Classes,
  pAuxEtc;

type

  { Interface used to centralize the logging of the system. }

  ILogMsg = interface
    ['{FB78C070-A55D-443C-9DF5-C0D7265F2AEB}']
    function LogMsg(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec): boolean;
    function LogMsgLines(const AMsgSeverity: EMsgSeverity; const AMessage: String; const AParams: array of TVarRec; var ANewLines: TStringList): boolean;
  end;

  { Interface used to invoke and manage Inifile Manager }

  IIniFileMgr = interface
    ['{FA4F6512-5448-43A2-9488-455C0DD85D05}']
    function GetServerParams: RServerConnection;    // obtain server parameters from inifile and return as record entries
    function SaveServerParams(const AServerConnection: RServerConnection;
      const AForceWrite: boolean = False): boolean; // accept record with server entries and write back to inifile
  end;


implementation

end.
