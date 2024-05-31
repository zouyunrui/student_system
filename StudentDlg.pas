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
  // 定义学生信息对话框类
  TTfrmStudentDlg = class(TForm)
    YcPanel1: TYcPanel; // 面板
    YcLabelId: TYcLabel; // 学号标签
    YcEdtId: TYcEdit; // 学号编辑框
    YcLabelName: TYcLabel; // 姓名标签
    YcEdtName: TYcEdit; // 姓名编辑框
    YcCheckGroupSex: TYcCheckGroup; // 性别多选框组
    YcRadioButtonM: TYcRadioButton; // 男性单选按钮
    YcRadioButtonW: TYcRadioButton; // 女性单选按钮
    YcDateTimePickerBirth: TYcDateTimePicker; // 出生日期选择器
    YcLabelBirth: TYcLabel; // 出生日期标签
    YcEdtIdNo: TYcEdit; // 身份证号编辑框
    YcLabelIdNo: TYcLabel; // 身份证号标签
    YcComboBoxNPlace: TYcComboBox; // 籍贯选择框
    YcLabelNPlace: TYcLabel; // 籍贯标签
    YcEdtTeleNum: TYcEdit; // 联系电话编辑框
    YcLabelTeleNum: TYcLabel; // 联系电话标签
    YcComboBoxParentType: TYcComboBox; // 父母类型选择框
    YcLabelParentType: TYcLabel; // 父母类型标签
    YcEdtParentName: TYcEdit; // 父母姓名编辑框
    YcLabelParentName: TYcLabel; // 父母姓名标签
    YcEdtParentTeleNum: TYcEdit; // 父母电话编辑框
    YcLabelParentTeleNum: TYcLabel; // 父母电话标签
    PanelBtn: TPanel; // 按钮面板
    YcBitBtnCon: TYcBitBtn; // 确认按钮
    YcBitBtnCan: TYcBitBtn; // 取消按钮
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
  AddOrUpdate: Boolean; // 标识是否是新增操作

implementation

{$R *.dfm}

var
  SQLCode: string;

// 初始化籍贯选择框
procedure TTfrmStudentDlg.InitNPlace();
begin
  YcComboBoxNPlace.Items.Add('合肥');
  YcComboBoxNPlace.Items.Add('芜湖');
  YcComboBoxNPlace.Items.Add('安庆');
end;

// 初始化父母类型选择框
procedure TTfrmStudentDlg.InitParentType;
begin
  YcComboBoxParentType.Items.Add('父');
  YcComboBoxParentType.Items.Add('母');
end;

// 验证用户输入的信息
procedure TTfrmStudentDlg.ValidateInputs;
var
  IdNoRegex, TeleNumRegex: TRegEx;
begin
  // 检查出生日期是否合法
  if (YcDateTimePickerBirth.Date <= EncodeDate(1980, 1, 1)) or (YcDateTimePickerBirth.Date >= EncodeDate(2010, 1, 1)) then
  begin
    raise Exception.Create('出生日期应在 1980.1.1 和 2010.1.1 之间');
  end;

  // 使用正则表达式验证身份证号格式
  IdNoRegex := TRegEx.Create('^[1-9]\d{5}(18|19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dXx]$');
  if not IdNoRegex.IsMatch(Trim(YcEdtIdNo.Text)) then
  begin
    raise Exception.Create('身份证号格式不正确');
  end;

  // 使用正则表达式验证电话号码格式
  TeleNumRegex := TRegEx.Create('^(1[3-9]\d{9})|((0\d{2,3}-?)?\d{7,8})$');
  if not TeleNumRegex.IsMatch(Trim(YcEdtTeleNum.Text)) then
  begin
    raise Exception.Create('联系电话格式不正确');
  end;
  if not TeleNumRegex.IsMatch(Trim(YcEdtParentTeleNum.Text)) then
  begin
    raise Exception.Create('父母的电话号码格式不正确');
  end;
end;

// 清空表单内容
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

// 保存学生信息
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

  // 加载 DLL 文件
  DLLHandle := LoadLibrary('StudentDLL.dll');
  if DLLHandle <> 0 then
  begin
    try
      if IsNew then
        @addOrUpdate := GetProcAddress(DLLHandle, 'AddStudent')
      else
        @addOrUpdate := GetProcAddress(DLLHandle, 'UpdateStudent');

      // 如果成功加载了函数，则调用之
      if Assigned(addOrUpdate) then
      begin
        addOrUpdate(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber, Birthday);
        ClearForm;

         if IsNew then
          ShowMessage('新增学生信息成功')
        else
          ShowMessage('修改学生信息成功');
      end
      else
      begin
        if IsNew then
          ShowMessage('AddStudent 函数未找到')
        else
          ShowMessage('UpdateStudent 函数未找到');
      end;
    finally
      FreeLibrary(DLLHandle);
    end;
  end
  else
    ShowMessage('无法加载 StudentDLL.dll');
end;

// 确认按钮点击事件处理程序
procedure TTfrmStudentDlg.YcBitBtnConClick(Sender: TObject);
begin
  if (Trim(YcEdtId.Text) <> '') and (Trim(YcEdtIdNo.Text) <> '') and (Trim(YcEdtName.Text) <> '') and (YcRadioButtonM.Checked or YcRadioButtonW.Checked) and (YcDateTimePickerBirth.Date <> 0) and (YcComboBoxNPlace.ItemIndex >= 0) and (Trim(YcEdtTeleNum.Text) <> '') and (YcComboBoxParentType.ItemIndex >= 0) and (Trim(YcEdtParentName.Text) <> '') and (Trim(YcEdtParentTeleNum.Text) <> '') then
  begin
    SaveStudentInfo(AddOrUpdate);
  end
  else
  begin
    ShowMessage('每一条数据都不能为空');
  end;

  DataModule1.UniQuery.SQL.Text := 'select * from Student';
  DataModule1.UniQuery.Open;
end;

// 取消按钮点击事件处理程序
procedure TTfrmStudentDlg.YcBitBtnCanClick(Sender: TObject);
begin
  Close;
end;

// 窗体创建事件处理程序
procedure TTfrmStudentDlg.FormCreate(Sender: TObject);
const
  WS_MAXIMIZEBOX = $00010000;
var
  Style: LongInt;
begin
  // 获取当前窗口样式
  Style := GetWindowLong(Handle, GWL_STYLE);
  // 移除最大化按钮的样式
  Style := Style and (not WS_MAXIMIZEBOX);
  // 设置新的窗口样式
  SetWindowLong(Handle, GWL_STYLE, Style);
  // 初始化籍贯选择框
  InitNPlace();
  // 初始化父母类型选择框
  InitParentType();
end;

end.

