object fHTMLSendMail: TfHTMLSendMail
  Left = 0
  Top = 0
  Caption = 'HTML Send Mail'
  ClientHeight = 1477
  ClientWidth = 1166
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object sbMain: TStatusBar
    Left = 0
    Top = 1458
    Width = 1166
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 1441
    ExplicitWidth = 1160
  end
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 1166
    Height = 1458
    ActivePage = tsSettings
    Align = alClient
    TabOrder = 0
    object tsSettings: TTabSheet
      Caption = 'Settings'
      object gpControl: TGridPanel
        Left = 0
        Top = 0
        Width = 1158
        Height = 1428
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
            Control = spConnection_1
            Row = 0
          end
          item
            Column = 1
            Control = StackPanel4
            Row = 1
          end
          item
            Column = 0
            Control = StackPanel5
            Row = 2
          end
          item
            Column = 1
            Control = StackPanel6
            Row = 2
          end
          item
            Column = 1
            Control = spButtons
            Row = 4
          end
          item
            Column = 1
            Control = spServerParams
            Row = 0
          end
          item
            Column = 0
            Control = spemp1
            Row = 1
          end
          item
            Column = 0
            ColumnSpan = 2
            Control = meMessages
            Row = 3
          end>
        RowCollection = <
          item
            Value = 33.333333333333340000
          end
          item
            SizeStyle = ssAbsolute
            Value = 100.000000000000000000
          end
          item
            Value = 33.333333333333340000
          end
          item
            Value = 33.333333333333340000
          end
          item
            SizeStyle = ssAbsolute
            Value = 55.000000000000000000
          end
          item
            SizeStyle = ssAuto
          end>
        TabOrder = 0
        DesignSize = (
          1158
          1428)
        object spConnection_1: TStackPanel
          Left = 1
          Top = 1
          Width = 578
          Height = 424
          Align = alClient
          ControlCollection = <
            item
              Control = leServerHostName
              HorizontalPositioning = sphpFill
              VerticalPositioning = spvpTop
            end
            item
              Control = leServerPort
              HorizontalPositioning = sphpFill
              VerticalPositioning = spvpTop
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
            end
            item
              Control = ComboBox1
            end
            item
              Control = ComboBox2
            end>
          HorizontalPositioning = sphpFill
          TabOrder = 0
          object leServerHostName: TLabeledEdit
            AlignWithMargins = True
            Left = 4
            Top = 21
            Width = 570
            Height = 23
            Margins.Top = 20
            Align = alTop
            EditLabel.Width = 98
            EditLabel.Height = 15
            EditLabel.Caption = 'Server Host Name:'
            TabOrder = 0
            Text = ''
          end
          object leServerPort: TLabeledEdit
            AlignWithMargins = True
            Left = 4
            Top = 69
            Width = 570
            Height = 23
            Margins.Top = 20
            Align = alTop
            EditLabel.Width = 57
            EditLabel.Height = 15
            EditLabel.Caption = 'Server Port'
            TabOrder = 1
            Text = ''
          end
          object leServerLoginName: TLabeledEdit
            AlignWithMargins = True
            Left = 4
            Top = 117
            Width = 570
            Height = 23
            Margins.Top = 20
            Align = alTop
            EditLabel.Width = 103
            EditLabel.Height = 15
            EditLabel.Margins.Top = 20
            EditLabel.Caption = 'Server Login Name:'
            TabOrder = 2
            Text = ''
          end
          object leServerLoginPassword: TLabeledEdit
            AlignWithMargins = True
            Left = 4
            Top = 165
            Width = 570
            Height = 23
            Margins.Top = 20
            Align = alTop
            EditLabel.Width = 121
            EditLabel.Height = 15
            EditLabel.Caption = 'Server Login Password:'
            TabOrder = 3
            Text = ''
          end
          object ComboBox1: TComboBox
            Left = 1
            Top = 193
            Width = 576
            Height = 23
            TabOrder = 4
          end
          object ComboBox2: TComboBox
            Left = 1
            Top = 218
            Width = 576
            Height = 23
            TabOrder = 5
          end
        end
        object StackPanel4: TStackPanel
          Left = 775
          Top = 425
          Anchors = []
          ControlCollection = <>
          TabOrder = 1
        end
        object StackPanel5: TStackPanel
          Left = 197
          Top = 636
          Anchors = []
          ControlCollection = <>
          TabOrder = 2
        end
        object StackPanel6: TStackPanel
          Left = 775
          Top = 636
          Anchors = []
          ControlCollection = <>
          TabOrder = 3
        end
        object spButtons: TStackPanel
          Left = 579
          Top = 1372
          Width = 578
          Height = 55
          Align = alClient
          ControlCollection = <
            item
              Control = btSendMail
              HorizontalPositioning = sphpFill
              VerticalPositioning = spvpTop
            end>
          HorizontalPositioning = sphpCenter
          TabOrder = 4
          object btSendMail: TButton
            AlignWithMargins = True
            Left = 16
            Top = 16
            Width = 546
            Height = 25
            Margins.Left = 15
            Margins.Top = 15
            Margins.Right = 15
            Margins.Bottom = 15
            Align = alTop
            Caption = 'Send Mail'
            TabOrder = 0
            OnClick = btSendMailClick
          end
        end
        object spServerParams: TStackPanel
          Left = 579
          Top = 1
          Width = 578
          Height = 424
          Align = alClient
          Anchors = []
          ControlCollection = <
            item
              Control = ListView1
            end>
          HorizontalPositioning = sphpFill
          Spacing = 20
          TabOrder = 5
          object ListView1: TListView
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 570
            Height = 368
            Checkboxes = True
            Columns = <
              item
                AutoSize = True
                Caption = 'Requests'
              end>
            Groups = <
              item
                Header = 'SMTP Command Library Enumereation'
                GroupID = 0
                State = [lgsNormal, lgsCollapsible]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
              end>
            TileColumns = <
              item
                Order = 1
              end>
            Items.ItemData = {
              05840000000300000000000000FFFFFFFFFFFFFFFF0000000000000000000000
              0009430061007000740069006F006E002000310000000000FFFFFFFFFFFFFFFF
              00000000000000000000000009430061007000740069006F006E002000320000
              000000FFFFFFFFFFFFFFFF000000000000000000000000094300610070007400
              69006F006E0020003200}
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object spemp1: TStackPanel
          Left = 1
          Top = 425
          Width = 578
          Height = 100
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
          TabOrder = 6
          object leMailFrom: TLabeledEdit
            AlignWithMargins = True
            Left = 4
            Top = 16
            Width = 570
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
            Width = 570
            Height = 23
            Align = alTop
            EditLabel.Width = 42
            EditLabel.Height = 15
            EditLabel.Caption = 'Mail To:'
            TabOrder = 1
            Text = 'Milan@VyDevSoft.com'
          end
        end
        object meMessages: TMemo
          Left = 1
          Top = 948
          Width = 1156
          Height = 424
          Align = alClient
          Lines.Strings = (
            'meMessages')
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 7
        end
      end
    end
    object tsMessage: TTabSheet
      Caption = 'Message'
      ImageIndex = 1
      object gpMessage: TGridPanel
        Left = 0
        Top = 0
        Width = 1158
        Height = 1428
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
            Control = pnHTMLText
            Row = 0
          end
          item
            Column = 1
            Control = pnPlainText
            Row = 0
          end>
        RowCollection = <
          item
            Value = 100.000000000000000000
          end>
        TabOrder = 0
        object pnHTMLText: TPanel
          Left = 1
          Top = 1
          Width = 578
          Height = 1426
          Align = alClient
          Caption = 'Panel2'
          TabOrder = 0
          object Label1: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 570
            Height = 15
            Align = alTop
            Caption = 'HTML Text'
            ExplicitWidth = 57
          end
          object meHTMLText: TMemo
            AlignWithMargins = True
            Left = 4
            Top = 25
            Width = 570
            Height = 1397
            Align = alClient
            Lines.Strings = (
              '<h1>HTM Test Message</h1>'
              
                '<p>This is a test me'#223'age to determine the correct way to handle ' +
                'the ICS SMTP components.'#169'</p>'
              '<p>No reply is expected or nece'#223'ary.</p>'
              '<p>It'#39's a warm 78'#176'C in Chicago.</p>'
              '<p>Milan</p>')
            TabOrder = 0
            ExplicitWidth = 567
            ExplicitHeight = 1380
          end
        end
        object pnPlainText: TPanel
          Left = 579
          Top = 1
          Width = 578
          Height = 1426
          Align = alClient
          ParentColor = True
          TabOrder = 1
          ExplicitLeft = 576
          ExplicitWidth = 575
          ExplicitHeight = 1409
          object Label2: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 570
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
            Width = 570
            Height = 1397
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
            ExplicitWidth = 567
            ExplicitHeight = 1380
          end
        end
      end
    end
  end
  object vuMain: TVersionUtility
    AppName = 'HTMSendMail'
    Left = 48
    Top = 1024
  end
end
