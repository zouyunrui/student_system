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
  // 定义学生列表窗体类
  TTfrmStudentList = class(TForm)
    YcGrid1: TYcGrid; // Oracle 提供程序
    YcPanelCond: TYcPanel; // 条件面板
    YcLabeId: TYcLabel; // 学号标签
    YcEdtId: TYcEdit; // 学号编辑框
    YcLabelName: TYcLabel; // 姓名标签
    YcEdtName: TYcEdit; // 姓名编辑框
    YcRadioGroupSex: TYcRadioGroup; // 性别单选组
    YcRadioButtonM: TYcRadioButton; // 男性单选按钮
    YcRadioButtonW: TYcRadioButton; // 女性单选按钮
    YcLabelBirth: TYcLabel; // 出生日期标签
    YcDateTimePickerBirth: TYcDateTimePicker; // 出生日期选择器
    YcLabelIdNo: TYcLabel; // 身份证号标签
    YcEdtIdNo: TYcEdit; // 身份证号编辑框
    YcComboBoxNPlace: TYcComboBox; // 数据库连接组件
    YcLabeNPlace: TYcLabel; // 籍贯标签
    YcComboBoxParentType: TYcComboBox; // 父母类型选择框
    YcLabelParentType: TYcLabel; // 父母类型标签
    YcLabelTeleNum: TYcLabel; // 联系电话标签
    YcEdtTeleNum: TYcEdit; // 联系电话编辑框
    YcLabelParentName: TYcLabel; // 父母姓名标签
    YcEdtParentName: TYcEdit; // 父母姓名编辑框
    YcLabelParentTeleNum: TYcLabel; // 父母电话标签
    YcEdtParentTeleNum: TYcEdit; // 父母电话编辑框
    PanelBtn: TPanel; // 按钮面板
    YcBitBtnAdd: TYcBitBtn; // 添加按钮
    YcBitBtnUpd: TYcBitBtn; // 更新按钮
    YcBitBtnDel: TYcBitBtn; // 删除按钮
    YcBitBtnPrint: TYcBitBtn; // 打印按钮
    YcBitBtnQuit: TYcBitBtn; // 退出按钮
    YcDateTimePickerCTB: TYcDateTimePicker; // 创建时间开始选择器
    YcDateTimePickerCTE: TYcDateTimePicker; // 创建时间结束选择器
    YcLabelCT: TYcLabel; // 创建时间标签
    YcDateTimePickerLTB: TYcDateTimePicker; // 最后修改时间开始选择器
    YcDateTimePickeLTE: TYcDateTimePicker; // 最后修改时间结束选择器
    YcLabelLT: TYcLabel; // 最后修改时间标签
    frxReport: TfrxReport;  //打印报表控件
    frxDBDataset: TfrxDBDataset; // 报表数据控件

    // 事件处理程序声明
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
  SQLCode: string; // SQL 查询代码
  Sex: string;

implementation

{$R *.dfm}

// 初始化籍贯选择框

procedure TTfrmStudentList.InitNPlace();
begin
  YcComboBoxNPlace.Items.Add('合肥');
  YcComboBoxNPlace.Items.Add('芜湖');
  YcComboBoxNPlace.Items.Add('安庆');
end;

// 初始化父母类型选择框
procedure TTfrmStudentList.InitParentType();
begin
  YcComboBoxParentType.Items.Add('父');
  YcComboBoxParentType.Items.Add('母');
end;

// 初始化表列名
procedure TTfrmStudentList.InitRowName;
begin
  DataModule1.UniQuery.FieldByName('id').DisplayLabel := '学号';
  DataModule1.UniQuery.FieldByName('name').DisplayLabel := '姓名';
  DataModule1.UniQuery.FieldByName('sex').DisplayLabel := '性别';
  DataModule1.UniQuery.FieldByName('birthday').DisplayLabel := '出生日期';
  DataModule1.UniQuery.FieldByName('id_no').DisplayLabel := '身份证号';
  DataModule1.UniQuery.FieldByName('native_place').DisplayLabel := '籍贯';
  DataModule1.UniQuery.FieldByName('contact_number').DisplayLabel := '联系电话';
  DataModule1.UniQuery.FieldByName('parent_type').DisplayLabel := '父母类型';
  DataModule1.UniQuery.FieldByName('parent_name').DisplayLabel := '父母姓名';
  DataModule1.UniQuery.FieldByName('parent_number').DisplayLabel := '父母电话';
  DataModule1.UniQuery.FieldByName('create_time').DisplayLabel := '创建时间';
  DataModule1.UniQuery.FieldByName('last_time').DisplayLabel := '最后修改时间';
end;

// 窗体创建事件处理
procedure TTfrmStudentList.FormCreate(Sender: TObject);
begin
  DataModule1.UniQuery.Open; // 打开查询
  InitNPlace(); // 初始化籍贯选择框
  InitParentType(); // 初始化父母类型选择框
  InitRowName(); // 初始化表列名
end;

// 添加按钮点击事件处理
procedure TTfrmStudentList.YcBitBtnAddClick(Sender: TObject);
begin
  AddOrUpdate := True; // 设置为添加操作
  TfrmStudentDlg.ClearForm; //刷新窗口
  EableEditControls; // 启用编辑控件
  TfrmStudentDlg.Caption := '新增学生'; // 设置对话框标题
  TfrmStudentDlg.ShowModal; // 显示对话框
end;

procedure TTfrmStudentList.YcBitBtnDelClick(Sender: TObject);
var
  delete: procedure(Id: PAnsiChar); stdcall;
  StudentId: string;
  DLLHandle: HMODULE;
begin
  DLLHandle := LoadLibrary('StudentDLL.dll'); // 加载 DLL 文件
  if DLLHandle <> 0 then
  begin
    try
      @delete := GetProcAddress(DLLHandle, 'DeleteStudent');
      if Assigned(delete) then
      begin
        if not YcGrid1.DataSource.DataSet.IsEmpty then
        begin
          StudentId := YcGrid1.DataSource.DataSet.FieldByName('id').AsString;
          if MessageDlg('删除后数据不能回复，是否继续？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          begin
            delete(PAnsiChar(StudentId));
            YcBitBtnSeClick(Sender); // 刷新 Grid 数据
            ShowMessage('删除成功');
          end;
        end
        else
          ShowMessage('当前数据集为空时不能删除');
      end
      else
        ShowMessage('DeleteStudent 函数未找到');
    finally
      FreeLibrary(DLLHandle);
    end;
  end
  else
    ShowMessage('无法加载 StudentDLL.dll');
end;



// 打印按钮点击事件处理
procedure TTfrmStudentList.YcBitBtnPrintClick(Sender: TObject);
begin
 // 加载报表模板文件
  try
    frxReport.LoadFromFile('my.fr3');
  except
    on E: Exception do
    begin
      ShowMessage('无法加载报表模板文件: ' + E.Message);
      Exit;
    end;
  end;

  // 连接数据集
  frxDBDataset.DataSet := DataModule1.UniQuery;

  // 显示报表预览窗口
  try
    frxReport.ShowReport();
  except
    on E: Exception do
    begin
      ShowMessage('无法显示报表: ' + E.Message);
    end;
  end;
end;

// 退出按钮点击事件处理

procedure TTfrmStudentList.YcBitBtnQuitClick(Sender: TObject);
begin
  TfrmStudentList.Close; // 关闭窗体
end;

// 更新按钮点击事件处理
procedure TTfrmStudentList.YcBitBtnUpdClick(Sender: TObject);
begin
  AddOrUpdate := False; // 设置为更新操作
  TfrmStudentDlg.Caption := '修改学生'; // 设置对话框标题
  EchoStudentInfo; //回显学生信息
  DisableEditControls; // 禁用编辑控件
  TfrmStudentDlg.ShowModal; // 显示对话框

end;

procedure TTfrmStudentList.DisableEditControls;
begin
  // 禁用编辑控件
  TfrmStudentDlg.YcEdtId.Enabled := False;
  TfrmStudentDlg.YcEdtIdNo.Enabled := False;
end;

procedure TTfrmStudentList.EableEditControls;
begin
  // 启用编辑控件
  TfrmStudentDlg.YcEdtId.Enabled := True;
  TfrmStudentDlg.YcEdtIdNo.Enabled := True;
end;
 //回显学生信息

procedure TTfrmStudentList.EchoStudentInfo;
var
  StudentId: string;
  SelectSex: string;
  NativePlace: string;
  ParentType: Integer;
begin
   // 检查是否选中一行
  if not YcGrid1.DataSource.DataSet.IsEmpty then
  begin
    // 获取选中的学生 ID
    StudentId := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('id').AsString;
     //把选中的学生数据显示出来
    TfrmStudentDlg.YcEdtId.Text := StudentId;
    TfrmStudentDlg.YcEdtName.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('name').AsString;

    SelectSex := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('sex').AsString;
    if SelectSex = '男' then
      TfrmStudentDlg.YcRadioButtonM.Checked := True
    else
      TfrmStudentDlg.YcRadioButtonW.Checked := True;
    TfrmStudentDlg.YcDateTimePickerBirth.Date := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('birthday').AsDateTime;
    TfrmStudentDlg.YcEdtIdNo.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('id_no').AsString;
    NativePlace := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('native_place').AsString;
       // 查找籍贯值在组合框中的索引
    TfrmStudentDlg.YcComboBoxNPlace.ItemIndex := YcComboBoxNPlace.Items.IndexOf(NativePlace);
    TfrmStudentDlg.YcEdtTeleNum.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('contact_number').AsString;
    ParentType := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('parent_type').AsInteger;
    TfrmStudentDlg.YcComboBoxParentType.ItemIndex := ParentType - 1;
    TfrmStudentDlg.YcEdtParentName.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('parent_name').AsString;
    TfrmStudentDlg.YcEdtParentTeleNum.Text := TfrmStudentList.YcGrid1.DataSource.DataSet.FieldByName('parent_number').AsString;
  end;

end;
// 查询按钮点击事件处理

procedure TTfrmStudentList.YcBitBtnSeClick(Sender: TObject);
var
  query: function(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber: string;
    Birthday, CreateTimeB, CreateTimeE, LastTimeB, LastTimeE: TDateTime):string; stdcall;
  DLLHandle: HMODULE;
  Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber: string;
  Birthday, CreateTimeB, CreateTimeE, LastTimeB, LastTimeE: TDateTime;
begin
  // 获取查询条件
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

  // 加载 DLL 文件
  DLLHandle := LoadLibrary('StudentDLL.dll');
  if DLLHandle <> 0 then
  begin
    try
      @query := GetProcAddress(DLLHandle, 'QueryStudent');
      // 如果成功加载了函数，则调用之
      if Assigned(query) then
      begin
      SQLCode:= query(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber,
          Birthday, CreateTimeB, CreateTimeE, LastTimeB, LastTimeE);
        DmStudent.DataModule1.UniQuery.SQL.Text:= SQLCode;
        ShowMessage(SQLCode);
        DmStudent.DataModule1.UniQuery.Open;
      end
      else
        ShowMessage('QueryStudent 函数未找到');
    finally
      FreeLibrary(DLLHandle);
    end;
  end
  else
    ShowMessage('无法加载 StudentDLL.dll');

  InitRowName(); // 初始化表列名
  ClearCondition; // 清除查询条件
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
// 查询按钮按键事件处理

procedure TTfrmStudentList.YcBitBtnSeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   // 检查是否按下了 F 键
  if Key = Ord('F') then
  begin
    // 触发查询按钮点击事件
    YcBitBtnSeClick(Sender);
  end;
end;


end.

