object TfrmStudentList: TTfrmStudentList
  Left = 439
  Top = 123
  BorderWidth = 1
  Caption = #23398#29983#31995#32479
  ClientHeight = 559
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object YcGrid1: TYcGrid
    Left = 368
    Top = 24
    Width = 433
    Height = 385
    DataSource = DataModule1.UniDataSource
    DynProps = <>
    FooterParams.HorzLines = False
    GridLineParams.ColorScheme = glcsClassicEh
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    IndicatorOptions = []
    IndicatorParams.FillStyle = cfstThemedEh
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghEnterAsTab, dghRowHighlight, dghDialogFind, dghColumnResize, dghColumnMove]
    SelectionDrawParams.DrawFocusFrame = True
    SelectionDrawParams.DrawFocusFrameStored = True
    SortLocal = True
    TabOrder = 0
    TitleParams.MultiTitle = True
    TitleParams.FillStyle = cfstThemedEh
    YcMenuItem.Strings = (
      #26597#25214'(&C)'
      '-'
      'Excel'#23548#20986'(&X)'
      '-'
      #21015#23646#24615'(&L)')
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object YcPanelCond: TYcPanel
    Left = 136
    Top = 24
    Width = 233
    Height = 385
    Caption = #26597#35810#26465#20214
    Color = clWhite
    GradientColorStart = clBtnFace
    TabOrder = 1
    object YcLabeId: TYcLabel
      Left = 16
      Top = 32
      Width = 39
      Height = 13
      Caption = #23398#21495#65306
    end
    object YcLabelName: TYcLabel
      Left = 16
      Top = 56
      Width = 39
      Height = 13
      Caption = #22995#21517#65306
    end
    object YcLabelBirth: TYcLabel
      Left = 8
      Top = 120
      Width = 65
      Height = 13
      Caption = #20986#29983#26085#26399#65306
    end
    object YcLabelIdNo: TYcLabel
      Left = 8
      Top = 144
      Width = 65
      Height = 13
      Caption = #36523#20221#35777#21495#65306
    end
    object YcLabeNPlace: TYcLabel
      Left = 8
      Top = 168
      Width = 39
      Height = 13
      Caption = #31821#36143#65306
    end
    object YcLabelParentType: TYcLabel
      Left = 8
      Top = 224
      Width = 65
      Height = 13
      Caption = #29238#27597#31867#22411#65306
    end
    object YcLabelTeleNum: TYcLabel
      Left = 8
      Top = 200
      Width = 65
      Height = 13
      Caption = #32852#31995#30005#35805#65306
    end
    object YcLabelParentName: TYcLabel
      Left = 8
      Top = 248
      Width = 65
      Height = 13
      Caption = #29238#27597#22995#21517#65306
    end
    object YcLabelParentTeleNum: TYcLabel
      Left = 8
      Top = 272
      Width = 65
      Height = 13
      Caption = #29238#27597#30005#35805#65306
    end
    object YcLabelCT: TYcLabel
      Left = 8
      Top = 304
      Width = 65
      Height = 13
      Caption = #21019#24314#26102#38388#65306
    end
    object YcLabelLT: TYcLabel
      Left = 8
      Top = 328
      Width = 65
      Height = 13
      Caption = #26356#26032#26102#38388#65306
    end
    object YcEdtId: TYcEdit
      Left = 72
      Top = 32
      Width = 145
      Height = 21
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      TabOrder = 1
      Visible = True
      YcNumeric = True
    end
    object YcBitBtnSel: TYcBitBtn
      Left = 96
      Top = 392
      Width = 65
      Height = 17
      Caption = #26597#35810'(&F)'
      TabOrder = 2
    end
    object YcEdtName: TYcEdit
      Left = 72
      Top = 56
      Width = 145
      Height = 21
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      TabOrder = 3
      Visible = True
    end
    object YcDateTimePickerBirth: TYcDateTimePicker
      Left = 72
      Top = 120
      Width = 145
      Height = 21
      Ctl3D = True
      DataField = ''
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      ParentCtl3D = False
      TabOrder = 4
      Visible = True
      Epoch = 1950
      UpdateRec = False
      YcDispFormat = 'YYYY-mm-dd HH:MM:SS'
    end
    object YcEdtIdNo: TYcEdit
      Left = 72
      Top = 144
      Width = 145
      Height = 21
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      TabOrder = 5
      Visible = True
    end
    object YcBitBtnSe: TYcBitBtn
      Left = 144
      Top = 352
      Caption = #26597#35810#65288'&F'#65289
      TabOrder = 6
      OnClick = YcBitBtnSeClick
      OnKeyDown = YcBitBtnSeKeyDown
    end
    object YcComboBoxParentType: TYcComboBox
      Left = 72
      Top = 224
      Width = 145
      Height = 21
      DynProps = <>
      EditButtons = <>
      TabOrder = 7
      Text = #35831#36873#25321#29238#27597#31867#22411
      Visible = True
    end
    object YcEdtTeleNum: TYcEdit
      Left = 72
      Top = 200
      Width = 145
      Height = 21
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      TabOrder = 8
      Visible = True
      YcNumeric = True
    end
    object YcEdtParentName: TYcEdit
      Left = 72
      Top = 248
      Width = 145
      Height = 21
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      TabOrder = 9
      Visible = True
    end
    object YcEdtParentTeleNum: TYcEdit
      Left = 72
      Top = 272
      Width = 145
      Height = 21
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      TabOrder = 10
      Visible = True
      YcNumeric = True
    end
    object YcDateTimePickerCTB: TYcDateTimePicker
      Left = 72
      Top = 304
      Width = 73
      Height = 21
      Ctl3D = True
      DataField = ''
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      ParentCtl3D = False
      TabOrder = 11
      Visible = True
      DateFormat = dfLong
      Epoch = 1950
      UpdateRec = False
      YcDispFormat = 'YYYY-MM-DD HH:NN:SS'
    end
    object YcDateTimePickerCTE: TYcDateTimePicker
      Left = 144
      Top = 304
      Width = 73
      Height = 21
      Ctl3D = True
      DataField = ''
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      ParentCtl3D = False
      TabOrder = 12
      Visible = True
      Epoch = 1950
      UpdateRec = False
      YcDispFormat = 'YYYY-MM-DD HH:NN:SS'
    end
    object YcDateTimePickerLTB: TYcDateTimePicker
      Left = 72
      Top = 328
      Width = 73
      Height = 21
      Ctl3D = True
      DataField = ''
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      ParentCtl3D = False
      TabOrder = 13
      Visible = True
      Epoch = 1950
      UpdateRec = False
      YcDispFormat = 'YYYY-MM-DD HH:NN:SS'
    end
    object YcDateTimePickeLTE: TYcDateTimePicker
      Left = 144
      Top = 328
      Width = 73
      Height = 21
      Ctl3D = True
      DataField = ''
      DynProps = <>
      EditButtons = <>
      EmptyDataInfo.Font.Charset = DEFAULT_CHARSET
      EmptyDataInfo.Font.Color = clSilver
      EmptyDataInfo.Font.Height = -12
      EmptyDataInfo.Font.Name = #23435#20307
      EmptyDataInfo.Font.Style = []
      EmptyDataInfo.ParentFont = False
      ParentCtl3D = False
      TabOrder = 14
      Visible = True
      Epoch = 1950
      UpdateRec = False
      YcDispFormat = 'YYYY-MM-DD HH:NN:SS'
    end
  end
  object YcRadioGroupSex: TYcRadioGroup
    Left = 144
    Top = 104
    Width = 209
    Height = 33
    BorderColor = clWhite
    Caption = #24615#21035#65306
    Color = clWhite
    FlatColor = clWhite
    GradientColorStop = clWhite
    ItemFrameColor = clWhite
    TextHighlightColor = clWhite
    TextShadowColor = clWhite
    ReadOnlyColor = clWhite
    TabOrder = 2
    object YcRadioButtonM: TYcRadioButton
      Left = 48
      Top = 16
      Width = 32
      Height = 15
      Caption = #30007
      TabOrder = 0
    end
    object YcRadioButtonW: TYcRadioButton
      Left = 136
      Top = 16
      Width = 32
      Height = 15
      Caption = #22899
      TabOrder = 1
    end
  end
  object YcComboBoxNPlace: TYcComboBox
    Left = 208
    Top = 192
    Width = 145
    Height = 21
    DynProps = <>
    EditButtons = <>
    TabOrder = 3
    Text = #35831#36873#25321#31821#36143
    Visible = True
  end
  object PanelBtn: TPanel
    Left = 136
    Top = 408
    Width = 665
    Height = 73
    BorderWidth = 2
    BorderStyle = bsSingle
    Color = clWhite
    ParentBackground = False
    TabOrder = 4
    object YcBitBtnAdd: TYcBitBtn
      Left = 40
      Top = 16
      Width = 57
      Height = 25
      Caption = #22686#21152
      TabOrder = 0
      OnClick = YcBitBtnAddClick
    end
    object YcBitBtnUpd: TYcBitBtn
      Left = 136
      Top = 16
      Width = 65
      Height = 25
      Caption = #20462#25913
      TabOrder = 1
      OnClick = YcBitBtnUpdClick
    end
    object YcBitBtnDel: TYcBitBtn
      Left = 224
      Top = 16
      Width = 65
      Caption = #21024#38500
      Color = clRed
      TabOrder = 2
      OnClick = YcBitBtnDelClick
    end
    object YcBitBtnPrint: TYcBitBtn
      Left = 320
      Top = 16
      Width = 65
      Height = 25
      Caption = #25171#21360
      TabOrder = 3
      OnClick = YcBitBtnPrintClick
    end
    object YcBitBtnQuit: TYcBitBtn
      Left = 488
      Top = 8
      Height = 33
      Caption = #36864#20986
      TabOrder = 4
      OnClick = YcBitBtnQuitClick
    end
  end
  object frxReport: TfrxReport
    Version = '5.1.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #39044#35774
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45435.735593020840000000
    ReportOptions.LastChange = 45435.762099479170000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 8
    Top = 168
    Datasets = <
      item
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxReport.Child2
        PrintChildIfInvisible = True
        StartNewPage = True
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 257.008040000000000000
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
        Filter = 
          '<frxDBDataset."ID"><frxDBDataset."NAME"><frxDBDataset."SEX"><frx' +
          'DBDataset."BIRTHDAY"><frxDBDataset."ID_NO"><frxDBDataset."NATIVE' +
          '_PLACE"><frxDBDataset."CONTACT_NUMBER"><frxDBDataset."PARENT_TYP' +
          'E"><frxDBDataset."PARENT_NAME"><frxDBDataset."PARENT_NUMBER"><fr' +
          'xDBDataset."CREATE_TIME"><frxDBDataset."LAST_TIME">'
        KeepChild = True
        RowCount = 10
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 491.338900000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 642.520100000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 536.693260000000000000
        Width = 718.110700000000000000
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 64.252010000000000000
        Width = 718.110700000000000000
      end
    end
    object DialogPage1: TfrxDialogPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Height = 200.000000000000000000
      ClientHeight = 161.000000000000000000
      Left = 327.000000000000000000
      Top = 132.000000000000000000
      Width = 300.000000000000000000
      ClientWidth = 284.000000000000000000
    end
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'NAME=NAME'
      'SEX=SEX'
      'BIRTHDAY=BIRTHDAY'
      'ID_NO=ID_NO'
      'NATIVE_PLACE=NATIVE_PLACE'
      'CONTACT_NUMBER=CONTACT_NUMBER'
      'PARENT_TYPE=PARENT_TYPE'
      'PARENT_NAME=PARENT_NAME'
      'PARENT_NUMBER=PARENT_NUMBER'
      'CREATE_TIME=CREATE_TIME'
      'LAST_TIME=LAST_TIME')
    DataSet = DataModule1.UniQuery
    BCDToCurrency = False
    Top = 120
  end
end
