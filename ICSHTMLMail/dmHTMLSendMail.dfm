object dHTMLSendMail: TdHTMLSendMail
  OnDestroy = DataModuleDestroy
  Height = 1080
  Width = 1440
  PixelsPerInch = 144
  object vuMain: TVersionUtility
    AppName = 'HTMSendMail'
    Left = 880
    Top = 544
  end
  object shscMain: TSslHtmlSmtpCli
    Tag = 0
    ShareMode = smtpShareDenyWrite
    LocalAddr = '0.0.0.0'
    LocalAddr6 = '::'
    Port = '465'
    AuthType = smtpAuthAutoSelect
    ConfirmReceipt = False
    HdrPriority = smtpPriorityNone
    CharSet = 'utf-8'
    ConvertToCharset = True
    WrapMsgMaxLineLen = 76
    SendMode = smtpCopyToStream
    DefaultEncoding = smtpEncQuotedPrintable
    Allow8bitChars = False
    FoldHeaders = False
    WrapMessageText = False
    ContentType = smtpHtml
    OwnHeaders = False
    OnBeforeOutStreamFree = shscMainBeforeOutStreamFree
    XMailer = 'ICS SMTP Component V%VER%'
    ProxyType = smtpNoProxy
    ProxyHttpAuthType = htatDetect
    OnAfterFileOpen = shscMainAfterFileOpen
    SocketFamily = sfIPv4
    SocketErrs = wsErrTech
    WSDebugOptions = [wsdlogHdr]
    Timeout = 60
    SslType = smtpTlsImplicit
    HtmlCharSet = 'utf-8'
    HtmlConvertToCharset = True
    SslCertVerMethod = CertVerNone
    SslAllowSelfSign = False
    Left = 104
    Top = 88
  end
  object SslHtmlSmtpCli1: TSslHtmlSmtpCli
    Tag = 0
    ShareMode = smtpShareDenyWrite
    LocalAddr = '0.0.0.0'
    LocalAddr6 = '::'
    Port = '465'
    AuthType = smtpAuthAutoSelect
    ConfirmReceipt = False
    RcptName.Strings = (
      'Milan@Lionwood.com')
    HdrSubject = 'Testing yet another SendMail 78'#176'F Implementation'#169
    HdrPriority = smtpPriorityNone
    CharSet = 'utf-8'
    ConvertToCharset = True
    WrapMsgMaxLineLen = 76
    SendMode = smtpCopyToStream
    DefaultEncoding = smtpEncQuotedPrintable
    Allow8bitChars = False
    FoldHeaders = False
    WrapMessageText = False
    ContentType = smtpHtml
    OwnHeaders = False
    XMailer = 'ICS SMTP Component V%VER%'
    ProxyType = smtpNoProxy
    ProxyHttpAuthType = htatDetect
    SocketFamily = sfIPv4
    SocketErrs = wsErrTech
    WSDebugOptions = [wsdlogHdr]
    Timeout = 60
    SslType = smtpTlsImplicit
    HtmlCharSet = 'utf-8'
    HtmlConvertToCharset = True
    SslCertVerMethod = CertVerNone
    SslAllowSelfSign = False
    Left = 365
    Top = 122
  end
end
