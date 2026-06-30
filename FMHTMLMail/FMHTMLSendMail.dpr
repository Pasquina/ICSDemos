program FMHTMLSendMail;

uses
  System.StartUpCopy,
  FMX.Forms,
  fmFHTMLSendMail in 'fmFHTMLSendMail.pas' {fHTMLSendMail},
  pAuxEtc in '..\Common\pAuxEtc.pas',
  pIniMgr in '..\Common\pIniMgr.pas',
  pInterfaces in '..\Common\pInterfaces.pas',
  dmHTMLSendMail in '..\Common\dmHTMLSendMail.pas' {dHTMLSendMail: TDataModule};

{$R *.res}

begin

{$IFDEF DEBUG}
  System.ReportMemoryLeaksOnShutdown := True;
{$ENDIF}

  Application.Initialize;
  Application.CreateForm(TdHTMLSendMail, dHTMLSendMail);
  Application.CreateForm(TfHTMLSendMail, fHTMLSendMail);
  Application.Run;
end.
