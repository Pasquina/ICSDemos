program VCLHTMLSendMail;

uses
  Vcl.Forms,
  fmHTMLSendMail in 'fmHTMLSendMail.pas' {fHTMLSendMail},
  Vcl.Themes,
  Vcl.Styles,
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
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Slate Classico');
  Application.CreateForm(TdHTMLSendMail, dHTMLSendMail);
  Application.CreateForm(TfHTMLSendMail, fHTMLSendMail);
  Application.Run;
end.
