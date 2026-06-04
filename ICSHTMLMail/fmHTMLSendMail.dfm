object fHTMLSendMail: TfHTMLSendMail
  Left = 0
  Top = 0
  Caption = 'HTML Send Mail'
  ClientHeight = 1136
  ClientWidth = 1166
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object svMain: TSplitView
    Left = 0
    Top = 0
    Width = 300
    Height = 1136
    CloseStyle = svcCompact
    Color = clGradientActiveCaption
    OpenedWidth = 300
    Placement = svpLeft
    TabOrder = 0
    OnDblClick = svMainDblClick
    ExplicitHeight = 1119
    object Button1: TButton
      AlignWithMargins = True
      Left = 15
      Top = 15
      Width = 270
      Height = 25
      Margins.Left = 15
      Margins.Top = 15
      Margins.Right = 15
      Margins.Bottom = 15
      Align = alTop
      Caption = 'Send Mail'
      TabOrder = 0
      OnClick = Button1Click
    end
    object StatusBar1: TStatusBar
      Left = 0
      Top = 1117
      Width = 300
      Height = 19
      Panels = <>
      ExplicitTop = 1100
    end
  end
  object pnMaian: TPanel
    Left = 300
    Top = 0
    Width = 866
    Height = 1136
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitWidth = 860
    ExplicitHeight = 1119
    object GPMain: TGridPanel
      Left = 1
      Top = 1
      Width = 864
      Height = 1115
      Align = alClient
      ColumnCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = spemp1
          Row = 0
        end
        item
          Column = 0
          ColumnSpan = 2
          Control = pnHTMLText
          Row = 1
        end
        item
          Column = 0
          ColumnSpan = 2
          Control = pnPlainText
          Row = 2
        end
        item
          Column = 0
          ColumnSpan = 2
          Control = meMessages
          Row = 3
        end
        item
          Column = 1
          Control = gpInternals
          Row = 0
        end>
      RowCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 200.000000000000000000
        end
        item
          Value = 33.333333333333340000
        end
        item
          Value = 33.333333333333340000
        end
        item
          Value = 33.333333333333340000
        end
        item
          SizeStyle = ssAuto
        end>
      TabOrder = 0
      ExplicitWidth = 858
      ExplicitHeight = 1098
      object spemp1: TStackPanel
        Left = 1
        Top = 1
        Width = 431
        Align = alClient
        ControlCollection = <
          item
            Control = leMailFrom
            HorizontalPositioning = sphpFill
            VerticalPositioning = spvpTop
          end
          item
            Control = leMailTo
            HorizontalPositioning = sphpFill
            VerticalPositioning = spvpTop
          end>
        Spacing = 20
        TabOrder = 0
        ExplicitWidth = 428
        object leMailFrom: TLabeledEdit
          AlignWithMargins = True
          Left = 4
          Top = 16
          Width = 423
          Height = 23
          Margins.Top = 15
          Align = alTop
          EditLabel.Width = 57
          EditLabel.Height = 15
          EditLabel.Caption = 'Mail From:'
          TabOrder = 0
          Text = 'Milan@Lionwood.com'
        end
        object leMailTo: TLabeledEdit
          AlignWithMargins = True
          Left = 4
          Top = 65
          Width = 423
          Height = 23
          Align = alTop
          EditLabel.Width = 42
          EditLabel.Height = 15
          EditLabel.Caption = 'Mail To:'
          TabOrder = 1
          Text = 'Milan@VyDevSoft.com'
        end
      end
      object pnHTMLText: TPanel
        Left = 1
        Top = 201
        Width = 862
        Height = 304
        Align = alClient
        Caption = 'Panel2'
        TabOrder = 1
        ExplicitWidth = 856
        ExplicitHeight = 299
        object Label1: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 854
          Height = 15
          Align = alTop
          Caption = 'HTML Text'
          ExplicitWidth = 57
        end
        object meHTMLText: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 25
          Width = 854
          Height = 275
          Align = alClient
          Lines.Strings = (
            '<h1>HTM Test Message</h1>'
            
              '<p>This is a test me'#223'age to determine the correct way to handle ' +
              'the ICS SMTP components.'#169'</p>'
            '<p>No reply is expected or nece'#223'ary.</p>'
            '<p>It'#39's a warm 78'#176'C in Chicago.</p>'
            '<p>Milan</p>')
          TabOrder = 0
          ExplicitWidth = 848
          ExplicitHeight = 270
        end
      end
      object pnPlainText: TPanel
        Left = 1
        Top = 505
        Width = 862
        Height = 305
        Align = alClient
        ParentColor = True
        TabOrder = 2
        ExplicitTop = 500
        ExplicitWidth = 856
        ExplicitHeight = 298
        object Label2: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 854
          Height = 15
          Align = alTop
          Caption = 'Plain Text'
          Color = clBtnFace
          ParentColor = False
          ExplicitWidth = 50
        end
        object mePlainText: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 25
          Width = 854
          Height = 276
          Align = alClient
          Lines.Strings = (
            'Plain Text Message'
            ''
            
              'This is a test me'#223'age to determine the correct way to handle the' +
              ' ICS SMTP components.'
            'No reply is expected or necessary.'
            ''
            'See '#167'5.5 for the '#8474'uick view of details.'
            'Milan'
            '')
          TabOrder = 0
          ExplicitWidth = 848
          ExplicitHeight = 269
        end
      end
      object meMessages: TMemo
        Left = 1
        Top = 810
        Width = 862
        Height = 304
        Align = alClient
        Lines.Strings = (
          'meMessages')
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 3
        ExplicitTop = 798
        ExplicitWidth = 856
        ExplicitHeight = 299
      end
      object gpInternals: TGridPanel
        Left = 432
        Top = 1
        Width = 431
        Height = 200
        Align = alClient
        ColumnCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 1
            Control = spServerParams
            Row = 0
          end>
        RowCollection = <
          item
            Value = 100.000000000000000000
          end>
        TabOrder = 4
        ExplicitLeft = 429
        ExplicitWidth = 428
        object spServerParams: TStackPanel
          Left = 215
          Top = 1
          Width = 215
          Height = 198
          Align = alClient
          Anchors = []
          ControlCollection = <
            item
              Control = leServerHostName
              HorizontalPositioning = sphpFill
              VerticalPositioning = spvpTop
            end
            item
              Control = leServerPort
              HorizontalPositioning = sphpFill
              VerticalPositioning = spvpBottom
            end
            item
              Control = leServerLoginName
              HorizontalPositioning = sphpFill
              VerticalPositioning = spvpTop
            end
            item
              Control = leServerLoginPassword
              HorizontalPositioning = sphpFill
              VerticalPositioning = spvpTop
            end>
          Spacing = 20
          TabOrder = 0
          ExplicitLeft = 214
          ExplicitWidth = 213
          object leServerHostName: TLabeledEdit
            AlignWithMargins = True
            Left = 4
            Top = 16
            Width = 207
            Height = 23
            Margins.Top = 15
            EditLabel.Width = 98
            EditLabel.Height = 15
            EditLabel.Caption = 'Server Host Name:'
            TabOrder = 0
            Text = ''
          end
          object leServerPort: TLabeledEdit
            AlignWithMargins = True
            Left = 4
            Top = 65
            Width = 207
            Height = 23
            EditLabel.Width = 57
            EditLabel.Height = 15
            EditLabel.Caption = 'Server Port'
            TabOrder = 1
            Text = ''
          end
          object leServerLoginName: TLabeledEdit
            AlignWithMargins = True
            Left = 4
            Top = 114
            Width = 207
            Height = 23
            Align = alTop
            EditLabel.Width = 103
            EditLabel.Height = 15
            EditLabel.Caption = 'Server Login Name:'
            TabOrder = 2
            Text = ''
          end
          object leServerLoginPassword: TLabeledEdit
            AlignWithMargins = True
            Left = 4
            Top = 163
            Width = 207
            Height = 23
            Align = alTop
            EditLabel.Width = 121
            EditLabel.Height = 15
            EditLabel.Caption = 'Server Login Password:'
            TabOrder = 3
            Text = ''
          end
        end
      end
    end
    object sbMain: TStatusBar
      Left = 1
      Top = 1116
      Width = 864
      Height = 19
      Anchors = []
      Panels = <>
      SimplePanel = True
      ExplicitTop = 1099
      ExplicitWidth = 858
    end
  end
  object shscMain: TSslHtmlSmtpCli
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
    SslContext = SslContext1
    OnSslVerifyPeer = shscMainSslVerifyPeer
    HtmlCharSet = 'utf-8'
    HtmlConvertToCharset = True
    SslCertVerMethod = CertVerNone
    SslAllowSelfSign = False
    Left = 61
    Top = 1041
  end
  object SslContext1: TSslContext
    SslVerifyPeer = True
    SslVerifyDepth = 9
    SslVerifyFlags = []
    SslVerifyFlagsValue = 0
    SslCheckHostFlags = []
    SslCheckHostFlagsValue = 0
    SslSecLevel = sslSecLevel112bits
    SslOptions = [sslOpt_NO_SSLv2]
    SslOptions2 = []
    SslVerifyPeerModes = [SslVerifyMode_PEER]
    SslVerifyPeerModesValue = 1
    SslSessionCacheModes = [sslSESS_CACHE_CLIENT]
    SslCipherList = 'ALL'
    SslCipherList13 = 
      'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_' +
      'GCM_SHA256'
    SslVersionMethod = sslTLS_V1_2_CLIENT
    SslMinVersion = sslVerTLS1_2
    SslMaxVersion = sslVerMax
    SslECDHMethod = sslECDHAuto
    SslCryptoGroups = 'P-256:X25519:P-384:P-512'
    SslCliSecurity = sslCliSecIgnore
    SslOcspStatus = False
    UseSharedCAStore = True
    CliCertTypes = []
    SrvCertTypes = [CertTypeX509]
    SslSessionTimeout = 300000
    SslSessionCacheSize = 20480
    AutoEnableBuiltinEngines = False
    Left = 162
    Top = 1040
  end
end
