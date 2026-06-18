object dHTMLSendMail: TdHTMLSendMail
  OnDestroy = DataModuleDestroy
  Height = 1080
  Width = 1440
  PixelsPerInch = 144
  object vuMain: TVersionUtility
    AppName = 'HTMSendMail'
    Left = 416
    Top = 88
  end
  object shscMain: TSslHtmlSmtpCli
    Tag = 0
    ShareMode = smtpShareDenyWrite
    LocalAddr = '0.0.0.0'
    LocalAddr6 = '::'
    Port = '465'
    AuthType = smtpAuthAutoSelect
    ConfirmReceipt = False
    FromName = 'Milan@VyDevSoft.com'
    RcptName.Strings = (
      'Milan@Lionwood.com')
    HdrSubject = 'Roses Are '#8477'ed and Violets Are '#3647'lue'
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
    OnRequestDone = shscMainRequestDone
    OnSessionConnected = shscMainSessionConnected
    OnBeforeOutStreamFree = shscMainBeforeOutStreamFree
    XMailer = 'ICS SMTP Component V%VER%'
    ProxyType = smtpNoProxy
    ProxyHttpAuthType = htatDetect
    SocketFamily = sfIPv4
    SocketErrs = wsErrTech
    WSDebugOptions = [wsdlogHdr]
    Timeout = 60
    SslType = smtpTlsImplicit
    SslContext = scMain
    OnSslVerifyPeer = shscMainSslVerifyPeer
    HtmlCharSet = 'utf-8'
    HtmlConvertToCharset = True
    SslCertVerMethod = CertVerNone
    SslAllowSelfSign = False
    Left = 96
    Top = 88
  end
  object NoName: TSslContext
    SslVerifyPeer = True
    SslVerifyDepth = 9
    SslVerifyFlags = []
    SslVerifyFlagsValue = 0
    SslCheckHostFlags = []
    SslCheckHostFlagsValue = 0
    SslSecLevel = sslSecLevel112bits
    SslOptions = []
    SslOptions2 = [sslOpt2_NO_RENEGOTIATION, sslOpt2_NO_SESSION_RESUMPTION_ON_RENEGOTIATION]
    SslVerifyPeerModes = [SslVerifyMode_PEER]
    SslVerifyPeerModesValue = 1
    SslSessionCacheModes = []
    SslCipherList = 'ALL:!ADH:RC4+RSA:+SSLv2:@STRENGTH'
    SslCipherList13 = 
      'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_' +
      'GCM_SHA256'
    SslVersionMethod = sslBestVer
    SslMinVersion = sslVerTLS1_2
    SslMaxVersion = sslVerMax
    SslECDHMethod = sslECDHNone
    SslCryptoGroups = 'X25519MLKEM768:P-256:X25519:P-384:P-521'
    SslCliSecurity = sslCliSecIgnore
    SslOcspStatus = False
    UseSharedCAStore = True
    CliCertTypes = []
    SrvCertTypes = [CertTypeX509]
    SslSessionTimeout = 300000
    SslSessionCacheSize = 20480
    AutoEnableBuiltinEngines = False
    Left = 424
    Top = 192
  end
  object scMain: TSslContext
    SslVerifyPeer = True
    SslVerifyDepth = 9
    SslVerifyFlags = []
    SslVerifyFlagsValue = 0
    SslCheckHostFlags = []
    SslCheckHostFlagsValue = 0
    SslSecLevel = sslSecLevel80bits
    SslOptions = []
    SslOptions2 = [sslOpt2_NO_RENEGOTIATION, sslOpt2_NO_SESSION_RESUMPTION_ON_RENEGOTIATION]
    SslVerifyPeerModes = [SslVerifyMode_PEER]
    SslVerifyPeerModesValue = 1
    SslSessionCacheModes = []
    SslCipherList = 'ALL:!ADH:RC4+RSA:+SSLv2:@STRENGTH'
    SslCipherList13 = 
      'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_' +
      'GCM_SHA256'
    SslVersionMethod = sslBestVer
    SslMinVersion = sslVerSSL3
    SslMaxVersion = sslVerMax
    SslECDHMethod = sslECDHNone
    SslCryptoGroups = 'P-256:X25519:P-384:P-521'
    SslCliSecurity = sslCliSecIgnore
    SslOcspStatus = False
    UseSharedCAStore = True
    CliCertTypes = []
    SrvCertTypes = []
    SslSessionTimeout = 0
    SslSessionCacheSize = 20480
    AutoEnableBuiltinEngines = False
    Left = 96
    Top = 184
  end
end
