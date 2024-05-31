unit StudentDlg;

interface

uses
  DmStudent, System.RegularExpressions, System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzRadChk,
  YcButton, RzPanel, RzRadGrp, YcGroup, Vcl.StdCtrls, Vcl.Mask, DBCtrlsEh,
  YcEdit, RzLabel, YcLabel, RzButton, Vcl.ExtCtrls, YcPanel, YcDTPicker, YcCombo,
  StudentUnit, Data.DB, MemDS, DBAccess, Uni;

type
  // ����ѧ����Ϣ�Ի�����
  TTfrmStudentDlg = class(TForm)
    YcPanel1: TYcPanel; // ���
    YcLabelId: TYcLabel; // ѧ�ű�ǩ
    YcEdtId: TYcEdit; // ѧ�ű༭��
    YcLabelName: TYcLabel; // ������ǩ
    YcEdtName: TYcEdit; // �����༭��
    YcCheckGroupSex: TYcCheckGroup; // �Ա��ѡ����
    YcRadioButtonM: TYcRadioButton; // ���Ե�ѡ��ť
    YcRadioButtonW: TYcRadioButton; // Ů�Ե�ѡ��ť
    YcDateTimePickerBirth: TYcDateTimePicker; // ��������ѡ����
    YcLabelBirth: TYcLabel; // �������ڱ�ǩ
    YcEdtIdNo: TYcEdit; // ����֤�ű༭��
    YcLabelIdNo: TYcLabel; // ����֤�ű�ǩ
    YcComboBoxNPlace: TYcComboBox; // ����ѡ���
    YcLabelNPlace: TYcLabel; // �����ǩ
    YcEdtTeleNum: TYcEdit; // ��ϵ�绰�༭��
    YcLabelTeleNum: TYcLabel; // ��ϵ�绰��ǩ
    YcComboBoxParentType: TYcComboBox; // ��ĸ����ѡ���
    YcLabelParentType: TYcLabel; // ��ĸ���ͱ�ǩ
    YcEdtParentName: TYcEdit; // ��ĸ�����༭��
    YcLabelParentName: TYcLabel; // ��ĸ������ǩ
    YcEdtParentTeleNum: TYcEdit; // ��ĸ�绰�༭��
    YcLabelParentTeleNum: TYcLabel; // ��ĸ�绰��ǩ
    PanelBtn: TPanel; // ��ť���
    YcBitBtnCon: TYcBitBtn; // ȷ�ϰ�ť
    YcBitBtnCan: TYcBitBtn; // ȡ����ť
    procedure FormCreate(Sender: TObject);
    procedure InitNPlace();
    procedure InitParentType();
    procedure YcBitBtnConClick(Sender: TObject);
    procedure YcBitBtnCanClick(Sender: TObject);
    procedure SaveStudentInfo(IsNew: Boolean);
    procedure ValidateInputs;
    procedure ClearForm;
  private
  public
  end;

var
  TfrmStudentDlg: TTfrmStudentDlg;
  AddOrUpdate: Boolean; // ��ʶ�Ƿ�����������

implementation

{$R *.dfm}

var
  SQLCode: string;

// ��ʼ������ѡ���
procedure TTfrmStudentDlg.InitNPlace();
begin
  YcComboBoxNPlace.Items.Add('�Ϸ�');
  YcComboBoxNPlace.Items.Add('�ߺ�');
  YcComboBoxNPlace.Items.Add('����');
end;

// ��ʼ����ĸ����ѡ���
procedure TTfrmStudentDlg.InitParentType;
begin
  YcComboBoxParentType.Items.Add('��');
  YcComboBoxParentType.Items.Add('ĸ');
end;

// ��֤�û��������Ϣ
procedure TTfrmStudentDlg.ValidateInputs;
var
  IdNoRegex, TeleNumRegex: TRegEx;
begin
  // �����������Ƿ�Ϸ�
  if (YcDateTimePickerBirth.Date <= EncodeDate(1980, 1, 1)) or (YcDateTimePickerBirth.Date >= EncodeDate(2010, 1, 1)) then
  begin
    raise Exception.Create('��������Ӧ�� 1980.1.1 �� 2010.1.1 ֮��');
  end;

  // ʹ���������ʽ��֤����֤�Ÿ�ʽ
  IdNoRegex := TRegEx.Create('^[1-9]\d{5}(18|19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dXx]$');
  if not IdNoRegex.IsMatch(Trim(YcEdtIdNo.Text)) then
  begin
    raise Exception.Create('����֤�Ÿ�ʽ����ȷ');
  end;

  // ʹ���������ʽ��֤�绰�����ʽ
  TeleNumRegex := TRegEx.Create('^(1[3-9]\d{9})|((0\d{2,3}-?)?\d{7,8})$');
  if not TeleNumRegex.IsMatch(Trim(YcEdtTeleNum.Text)) then
  begin
    raise Exception.Create('��ϵ�绰��ʽ����ȷ');
  end;
  if not TeleNumRegex.IsMatch(Trim(YcEdtParentTeleNum.Text)) then
  begin
    raise Exception.Create('��ĸ�ĵ绰�����ʽ����ȷ');
  end;
end;

// ��ձ�������
procedure TTfrmStudentDlg.ClearForm;
begin
  YcEdtId.Clear;
  YcEdtName.Clear;
  YcRadioButtonM.Checked := False;
  YcRadioButtonW.Checked := False;
  YcDateTimePickerBirth.Clear;
  YcEdtIdNo.Clear;
  YcComboBoxNPlace.ItemIndex := -1;
  YcEdtTeleNum.Clear;
  YcComboBoxParentType.ItemIndex := -1;
  YcEdtParentName.Clear;
  YcEdtParentTeleNum.Clear;
end;

// ����ѧ����Ϣ
procedure TTfrmStudentDlg.SaveStudentInfo(IsNew: Boolean);
var
  addOrUpdate: procedure(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber: string; Birthday:TDateTime); stdcall;
  DLLHandle: HMODULE;
  Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber: string;
  Birthday: TDateTime;
begin
  ValidateInputs;

  Id := Trim(YcEdtId.Text);
  Name := Trim(YcEdtName.Text);

  if YcRadioButtonM.Checked then
    Sex := YcRadioButtonM.Caption
  else if YcRadioButtonW.Checked then
    Sex := YcRadioButtonW.Caption
  else
    Sex := '';

  Birthday := YcDateTimePickerBirth.Date;

  IdNo := Trim(YcEdtIdNo.Text);

  if YcComboBoxNPlace.ItemIndex >= 0 then
    NativePlace := YcComboBoxNPlace.Items[YcComboBoxNPlace.ItemIndex]
  else
    NativePlace := '';

  ContactNumber := Trim(YcEdtTeleNum.Text);

  if YcComboBoxParentType.ItemIndex >= 0 then
    ParentType := IntToStr(YcComboBoxParentType.ItemIndex + 1)
  else
    ParentType := '';

  ParentName := Trim(YcEdtParentName.Text);
  ParentNumber := Trim(YcEdtParentTeleNum.Text);

  // ���� DLL �ļ�
  DLLHandle := LoadLibrary('StudentDLL.dll');
  if DLLHandle <> 0 then
  begin
    try
      if IsNew then
        @addOrUpdate := GetProcAddress(DLLHandle, 'AddStudent')
      else
        @addOrUpdate := GetProcAddress(DLLHandle, 'UpdateStudent');

      // ����ɹ������˺����������֮
      if Assigned(addOrUpdate) then
      begin
        addOrUpdate(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber, Birthday);
        ClearForm;

         if IsNew then
          ShowMessage('����ѧ����Ϣ�ɹ�')
        else
          ShowMessage('�޸�ѧ����Ϣ�ɹ�');
      end
      else
      begin
        if IsNew then
          ShowMessage('AddStudent ����δ�ҵ�')
        else
          ShowMessage('UpdateStudent ����δ�ҵ�');
      end;
    finally
      FreeLibrary(DLLHandle);
    end;
  end
  else
    ShowMessage('�޷����� StudentDLL.dll');
end;

// ȷ�ϰ�ť����¼���������
procedure TTfrmStudentDlg.YcBitBtnConClick(Sender: TObject);
begin
  if (Trim(YcEdtId.Text) <> '') and (Trim(YcEdtIdNo.Text) <> '') and (Trim(YcEdtName.Text) <> '') and (YcRadioButtonM.Checked or YcRadioButtonW.Checked) and (YcDateTimePickerBirth.Date <> 0) and (YcComboBoxNPlace.ItemIndex >= 0) and (Trim(YcEdtTeleNum.Text) <> '') and (YcComboBoxParentType.ItemIndex >= 0) and (Trim(YcEdtParentName.Text) <> '') and (Trim(YcEdtParentTeleNum.Text) <> '') then
  begin
    SaveStudentInfo(AddOrUpdate);
  end
  else
  begin
    ShowMessage('ÿһ�����ݶ�����Ϊ��');
  end;

  DataModule1.UniQuery.SQL.Text := 'select * from Student';
  DataModule1.UniQuery.Open;
end;

// ȡ����ť����¼���������
procedure TTfrmStudentDlg.YcBitBtnCanClick(Sender: TObject);
begin
  Close;
end;

// ���崴���¼���������
procedure TTfrmStudentDlg.FormCreate(Sender: TObject);
const
  WS_MAXIMIZEBOX = $00010000;
var
  Style: LongInt;
begin
  // ��ȡ��ǰ������ʽ
  Style := GetWindowLong(Handle, GWL_STYLE);
  // �Ƴ���󻯰�ť����ʽ
  Style := Style and (not WS_MAXIMIZEBOX);
  // �����µĴ�����ʽ
  SetWindowLong(Handle, GWL_STYLE, Style);
  // ��ʼ������ѡ���
  InitNPlace();
  // ��ʼ����ĸ����ѡ���
  InitParentType();
end;

end.
