unit StudentList;

interface

uses
  DmStudent, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, DBAccess, Uni, UniProvider,
  OracleUniProvider, MemDS, GridsEh, DBAxisGridsEh, DBGridEh, DBCtrlsEh,
  ToolCtrlsEh, DBGridEhGrouping, DynVarsEh, YcGrid, YcDBGrid, YcPanel, RzPanel,
  YcLabel, RzLabel, YcEdit, RzButton, YcButton, RzRadGrp, YcGroup, RzRadChk,
  YcDTPicker, YcCombo, YcLookup, StudentDlg, DBGridEhToolCtrls, frxClass,
  frxDBSet, frxExportPDF;

type
  // ����ѧ���б�������
  TTfrmStudentList = class(TForm)
    YcGrid1: TYcGrid; // Oracle �ṩ����
    YcPanelCond: TYcPanel; // �������
    YcLabeId: TYcLabel; // ѧ�ű�ǩ
    YcEdtId: TYcEdit; // ѧ�ű༭��
    YcLabelName: TYcLabel; // ������ǩ
    YcEdtName: TYcEdit; // �����༭��
    YcRadioGroupSex: TYcRadioGroup; // �Ա�ѡ��
    YcRadioButtonM: TYcRadioButton; // ���Ե�ѡ��ť
    YcRadioButtonW: TYcRadioButton; // Ů�Ե�ѡ��ť
    YcLabelBirth: TYcLabel; // �������ڱ�ǩ
    YcDateTimePickerBirth: TYcDateTimePicker; // ��������ѡ����
    YcLabelIdNo: TYcLabel; // ����֤�ű�ǩ
    YcEdtIdNo: TYcEdit; // ����֤�ű༭��
    YcComboBoxNPlace: TYcComboBox; // ���ݿ��������
    YcLabeNPlace: TYcLabel; // �����ǩ
    YcComboBoxParentType: TYcComboBox; // ��ĸ����ѡ���
    YcLabelParentType: TYcLabel; // ��ĸ���ͱ�ǩ
    YcLabelTeleNum: TYcLabel; // ��ϵ�绰��ǩ
    YcEdtTeleNum: TYcEdit; // ��ϵ�绰�༭��
    YcLabelParentName: TYcLabel; // ��ĸ������ǩ
    YcEdtParentName: TYcEdit; // ��ĸ�����༭��
    YcLabelParentTeleNum: TYcLabel; // ��ĸ�绰��ǩ
    YcEdtParentTeleNum: TYcEdit; // ��ĸ�绰�༭��
    PanelBtn: TPanel; // ��ť���
    YcBitBtnAdd: TYcBitBtn; // ���Ӱ�ť
    YcBitBtnUpd: TYcBitBtn; // ���°�ť
    YcBitBtnDel: TYcBitBtn; // ɾ����ť
    YcBitBtnPrint: TYcBitBtn; // ��ӡ��ť
    YcBitBtnQuit: TYcBitBtn; // �˳���ť
    YcDateTimePickerCTB: TYcDateTimePicker; // ����ʱ�俪ʼѡ����
    YcDateTimePickerCTE: TYcDateTimePicker; // ����ʱ�����ѡ����
    YcLabelCT: TYcLabel; // ����ʱ���ǩ
    YcDateTimePickerLTB: TYcDateTimePicker; // ����޸�ʱ�俪ʼѡ����
    YcDateTimePickeLTE: TYcDateTimePicker; // ����޸�ʱ�����ѡ����
    YcLabelLT: TYcLabel; // ����޸�ʱ���ǩ
    frxReport: TfrxReport;  //��ӡ�����ؼ�
    frxDBDataset: TfrxDBDataset; // �������ݿؼ�

    // �¼�������������
    procedure FormCreate(Sender: TObject);
    procedure InitNPlace();
    procedure InitParentType();
    procedure InitRowName();
    procedure YcBitBtnSeClick(Sender: TObject);
    procedure YcBitBtnAddClick(Sender: TObject);
    procedure YcBitBtnUpdClick(Sender: TObject);
    procedure YcBitBtnSeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure YcBitBtnDelClick(Sender: TObject);
    procedure YcBitBtnQuitClick(Sender: TObject);
    procedure YcBitBtnPrintClick(Sender: TObject);
    procedure EchoStudentInfo;
    procedure DisableEditControls;
    procedure EableEditControls;
    procedure ClearCondition;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TfrmStudentList: TTfrmStudentList;
  SQLCode: string; // SQL ��ѯ����
  Sex: string;

implementation

{$R *.dfm}

// ��ʼ������ѡ���

procedure TTfrmStudentList.InitNPlace();
begin
  YcComboBoxNPlace.Items.Add('�Ϸ�');
  YcComboBoxNPlace.Items.Add('�ߺ�');
  YcComboBoxNPlace.Items.Add('����');
end;

// ��ʼ����ĸ����ѡ���
procedure TTfrmStudentList.InitParentType();
begin
  YcComboBoxParentType.Items.Add('��');
  YcComboBoxParentType.Items.Add('ĸ');
end;

// ��ʼ��������
procedure TTfrmStudentList.InitRowName;
begin
  DataModule1.UniQuery.FieldByName('id').DisplayLabel := 'ѧ��';
  DataModule1.UniQuery.FieldByName('name').DisplayLabel := '����';
  DataModule1.UniQuery.FieldByName('sex').DisplayLabel := '�Ա�';
  DataModule1.UniQuery.FieldByName('birthday').DisplayLabel := '��������';
  DataModule1.UniQuery.FieldByName('id_no').DisplayLabel := '����֤��';
  DataModule1.UniQuery.FieldByName('native_place').DisplayLabel := '����';
  DataModule1.UniQuery.FieldByName('contact_number').DisplayLabel := '��ϵ�绰';
  DataModule1.UniQuery.FieldByName('parent_type').DisplayLabel := '��ĸ����';
  DataModule1.UniQuery.FieldByName('parent_name').DisplayLabel := '��ĸ����';
  DataModule1.UniQuery.FieldByName('parent_number').DisplayLabel := '��ĸ�绰';
  DataModule1.UniQuery.FieldByName('create_time').DisplayLabel := '����ʱ��';
  DataModule1.UniQuery.FieldByName('last_time').DisplayLabel := '����޸�ʱ��';
end;

// ���崴���¼�����
procedure TTfrmStudentList.FormCreate(Sender: TObject);
begin
  DataModule1.UniQuery.Open; // �򿪲�ѯ
  InitNPlace(); // ��ʼ������ѡ���
  InitParentType(); // ��ʼ����ĸ����ѡ���
  InitRowName(); // ��ʼ��������
end;

// ���Ӱ�ť����¼�����
procedure TTfrmStudentList.YcBitBtnAddClick(Sender: TObject);
begin
  AddOrUpdate := True; // ����Ϊ���Ӳ���
  TfrmStudentDlg.ClearForm; //ˢ�´���
  EableEditControls; // ���ñ༭�ؼ�
  TfrmStudentDlg.Caption := '����ѧ��'; // ���öԻ������
  TfrmStudentDlg.ShowModal; // ��ʾ�Ի���
end;

procedure TTfrmStudentList.YcBitBtnDelClick(Sender: TObject);
var
  delete: procedure(Id: PAnsiChar); stdcall;
  StudentId: string;
  DLLHandle: HMODULE;
begin
  DLLHandle := LoadLibrary('StudentDLL.dll'); // ���� DLL �ļ�
  if DLLHandle <> 0 then
  begin
    try
      @delete := GetProcAddress(DLLHandle, 'DeleteStudent');
      if Assigned(delete) then
      begin
        if not YcGrid1.DataSource.DataSet.IsEmpty then
        begin
          StudentId := YcGrid1.DataSource.DataSet.FieldByName('id').AsString;
          if MessageDlg('ɾ�������ݲ��ܻظ����Ƿ������', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          begin
            delete(PAnsiChar(StudentId));
            YcBitBtnSeClick(Sender); // ˢ�� Grid ����
            ShowMessage('ɾ���ɹ�');
          end;
        end
        else
          ShowMessage('��ǰ���ݼ�Ϊ��ʱ����ɾ��');
      end
      else
        ShowMessage('DeleteStudent ����δ�ҵ�');
    finally
      FreeLibrary(DLLHandle);
    end;
  end
  else
    ShowMessage('�޷����� StudentDLL.dll');
end;



// ��ӡ��ť����¼�����
procedure TTfrmStudentList.YcBitBtnPrintClick(Sender: TObject);
begin
 // ���ر���ģ���ļ�
  try
    frxReport.LoadFromFile('my.fr3');
  except
    on E: Exception do
    begin
      ShowMessage('�޷����ر���ģ���ļ�: ' + E.Message);
      Exit;
    end;
  end;

  // �������ݼ�
  frxDBDataset.DataSet := DataModule1.UniQuery;

  // ��ʾ����Ԥ������
  try
    frxReport.ShowReport();
  except
    on E: Exception do
    begin
      ShowMessage('�޷���ʾ����: ' + E.Message);
    end;
  end;
end;

// �˳���ť����¼�����

procedure TTfrmStudentList.YcBitBtnQuitClick(Sender: TObject);
begin
  TfrmStudentList.Close; // �رմ���
end;

// ���°�ť����¼�����
procedure TTfrmStudentList.YcBitBtnUpdClick(Sender: TObject);
begin
  AddOrUpdate := False; // ����Ϊ���²���
  TfrmStudentDlg.Caption := '�޸�ѧ��'; // ���öԻ������
  EchoStudentInfo; //����ѧ����Ϣ
  DisableEditControls; // ���ñ༭�ؼ�
  TfrmStudentDlg.ShowModal; // ��ʾ�Ի���

end;

procedure TTfrmStudentList.DisableEditControls;
begin
  // ���ñ༭�ؼ�
  TfrmStudentDlg.YcEdtId.Enabled := False;
  TfrmStudentDlg.YcEdtIdNo.Enabled := False;
end;

procedure TTfrmStudentList.EableEditControls;
begin
  // ���ñ༭�ؼ�
  TfrmStudentDlg.YcEdtId.Enabled := True;
  TfrmStudentDlg.YcEdtIdNo.Enabled := True;
end;
 //����ѧ����Ϣ

procedure TTfrmStudentList.EchoStudentInfo;
var
  StudentId: string;
  SelectSex: string;
  NativePlace: string;
  ParentType: Integer;
begin
   // ����Ƿ�ѡ��һ��
  if not YcGrid1.DataSource.DataSet.IsEmpty then
  begin
    // ��ȡѡ�е�ѧ�� ID
    StudentId := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('id').AsString;
     //��ѡ�е�ѧ��������ʾ����
    TfrmStudentDlg.YcEdtId.Text := StudentId;
    TfrmStudentDlg.YcEdtName.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('name').AsString;

    SelectSex := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('sex').AsString;
    if SelectSex = '��' then
      TfrmStudentDlg.YcRadioButtonM.Checked := True
    else
      TfrmStudentDlg.YcRadioButtonW.Checked := True;
    TfrmStudentDlg.YcDateTimePickerBirth.Date := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('birthday').AsDateTime;
    TfrmStudentDlg.YcEdtIdNo.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('id_no').AsString;
    NativePlace := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('native_place').AsString;
       // ���Ҽ���ֵ����Ͽ��е�����
    TfrmStudentDlg.YcComboBoxNPlace.ItemIndex := YcComboBoxNPlace.Items.IndexOf(NativePlace);
    TfrmStudentDlg.YcEdtTeleNum.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('contact_number').AsString;
    ParentType := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('parent_type').AsInteger;
    TfrmStudentDlg.YcComboBoxParentType.ItemIndex := ParentType - 1;
    TfrmStudentDlg.YcEdtParentName.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('parent_name').AsString;
    TfrmStudentDlg.YcEdtParentTeleNum.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('parent_number').AsString;
  end;

end;
// ��ѯ��ť����¼�����

procedure TTfrmStudentList.YcBitBtnSeClick(Sender: TObject);
var
  query: function(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber: string;
    Birthday, CreateTimeB, CreateTimeE, LastTimeB, LastTimeE: TDateTime):string; stdcall;
  DLLHandle: HMODULE;
  Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber: string;
  Birthday, CreateTimeB, CreateTimeE, LastTimeB, LastTimeE: TDateTime;
begin
  // ��ȡ��ѯ����
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

  CreateTimeB := YcDateTimePickerCTB.Date;
  CreateTimeE := YcDateTimePickerCTE.Date;
  LastTimeB := YcDateTimePickerLTB.Date;
  LastTimeE := YcDateTimePickeLTE.Date;

  // ���� DLL �ļ�
  DLLHandle := LoadLibrary('StudentDLL.dll');
  if DLLHandle <> 0 then
  begin
    try
      @query := GetProcAddress(DLLHandle, 'QueryStudent');
      // ����ɹ������˺����������֮
      if Assigned(query) then
      begin
      SQLCode:= query(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber,
          Birthday, CreateTimeB, CreateTimeE, LastTimeB, LastTimeE);
        DmStudent.DataModule1.UniQuery.SQL.Text:= SQLCode;
        ShowMessage(SQLCode);
        DmStudent.DataModule1.UniQuery.Open;
      end
      else
        ShowMessage('QueryStudent ����δ�ҵ�');
    finally
      FreeLibrary(DLLHandle);
    end;
  end
  else
    ShowMessage('�޷����� StudentDLL.dll');

  InitRowName(); // ��ʼ��������
  ClearCondition; // �����ѯ����
end;



procedure TTfrmStudentList.ClearCondition;
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
  YcDateTimePickerCTB.Clear;
  YcDateTimePickerCTE.Clear;
  YcDateTimePickerLTB.Clear;
  YcDateTimePickeLTE.Clear;
end;
// ��ѯ��ť�����¼�����

procedure TTfrmStudentList.YcBitBtnSeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   // ����Ƿ����� F ��
  if Key = Ord('F') then
  begin
    // ������ѯ��ť����¼�
    YcBitBtnSeClick(Sender);
  end;
end;


end.
