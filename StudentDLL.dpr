library StudentDLL;

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  DBAccess,
  Uni,
  UniProvider,
  OracleUniProvider,
  MemDS,
  Vcl.Dialogs,
  YcGrid,
  YcDBGrid;

{$R *.res}

var
  UniConnection: TUniConnection;
  UniQuery: TUniQuery;

procedure InitializeConnection; stdcall;
begin
  UniConnection := TUniConnection.Create(nil);
  UniConnection.ProviderName := 'Oracle';
  UniConnection.Server := '192.168.0.91:1521/orcl';
  UniConnection.Username := 'system';
  UniConnection.Password := '123456';
  UniConnection.Connect;

  UniQuery := TUniQuery.Create(nil);
  UniQuery.Connection := UniConnection;
end;

procedure FinalizeConnection; stdcall;
begin
  if Assigned(UniQuery) then
  begin
    UniQuery.Free;
    UniQuery := nil;
  end;

  if Assigned(UniConnection) then
  begin
    UniConnection.Disconnect;
    UniConnection.Free;
    UniConnection := nil;
  end;

end;

procedure AddStudent(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber: string; Birthday:TDateTime); stdcall;
begin
InitializeConnection();
  try
    UniQuery.Connection := UniConnection;
    UniQuery.SQL.Text := 'INSERT INTO Student (id, name, sex, birthday, id_no, native_place, contact_number, parent_type, parent_name, parent_number, create_time, last_time)'+
    'VALUES (:id, :name, :sex,TO_DATE(:birthday, ''YYYY-MM-DD''), :id_no, :native_place, :contact_number, :parent_type, :parent_name, :parent_number, SYSDATE, SYSDATE)';
    UniQuery.ParamByName('id').AsInteger  := StrToInt(Id);
    UniQuery.ParamByName('name').AsString := Name;
    UniQuery.ParamByName('sex').AsString := Sex;
    UniQuery.ParamByName('birthday').AsString := FormatDateTime('YYYY-MM-DD', Birthday);
    UniQuery.ParamByName('id_no').AsString := IdNo;
    UniQuery.ParamByName('native_place').AsString := NativePlace;
    UniQuery.ParamByName('contact_number').AsString := ContactNumber;
    UniQuery.ParamByName('parent_type').AsInteger  := StrToInt(ParentType);
    UniQuery.ParamByName('parent_name').AsString := ParentName;
    UniQuery.ParamByName('parent_number').AsString := ParentNumber;
    UniQuery.ExecSQL;
    ShowMessage(UniQuery.SQL.Text);
  finally
    UniQuery.Free;
  end;
end;


procedure UpdateStudent(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber: string; Birthday:TDateTime); stdcall;
begin
 InitializeConnection();
  try
    UniQuery.Connection := UniConnection;
    UniQuery.SQL.Text := 'UPDATE Student SET name = :name, sex = :sex, birthday = TO_DATE(:birthday, ''YYYY-MM-DD''), ' + 'native_place = :native_place, contact_number = :contact_number, parent_type = :parent_type, ' + 'parent_name = :parent_name, parent_number = :parent_number, last_time = SYSDATE ' + 'WHERE id = :Id AND id_no = :id_no';
    UniQuery.ParamByName('id').AsInteger  := StrToInt(Id);
    UniQuery.ParamByName('name').AsString := Name;
    UniQuery.ParamByName('sex').AsString := Sex;
    UniQuery.ParamByName('birthday').AsString := FormatDateTime('YYYY-MM-DD', Birthday);
    UniQuery.ParamByName('id_no').AsString := IdNo;
    UniQuery.ParamByName('native_place').AsString := NativePlace;
    UniQuery.ParamByName('contact_number').AsString := ContactNumber;
    UniQuery.ParamByName('parent_type').AsInteger  := StrToInt(ParentType);
    UniQuery.ParamByName('parent_name').AsString := ParentName;
    UniQuery.ParamByName('parent_number').AsString := ParentNumber;
    UniQuery.ExecSQL;
  finally
    UniQuery.Free;
  end;
end;

procedure DeleteStudent(Id: string); stdcall;
begin
  InitializeConnection();
  try
    UniQuery.Connection := UniConnection;
    UniQuery.SQL.Text := 'DELETE FROM Student WHERE id = :id';
    UniQuery.ParamByName('id').AsString := Id;
    UniQuery.ExecSQL;
  finally
    UniQuery.Free;
  end;
end;

function QueryStudent(Id, Name, Sex, IdNo, NativePlace, ContactNumber, ParentType, ParentName, ParentNumber: string; Birthday, CreateTimeB, CreateTimeE, LastTimeB, LastTimeE: TDateTime): string; stdcall;
begin
  InitializeConnection();
  try
    UniQuery.Connection := UniConnection;
    UniQuery.SQL.Text := 'SELECT * FROM Student WHERE 1=1';

    if Id <> '' then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND id = ' + QuotedStr(Id);
    end;

    if Name <> '' then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND name LIKE ' + QuotedStr(Trim('%' + Name + '%'));
    end;

    if Sex <> '' then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND sex = ' + QuotedStr(Sex);
    end;

    if Birthday <> 0 then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND birthday = TO_DATE(''' + FormatDateTime('YYYY-MM-DD', Birthday) + ''', ''YYYY-MM-DD'')';
    end;

    if IdNo <> '' then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND id_no = ' + QuotedStr(IdNo);
    end;

    if NativePlace <> '' then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND native_place = ' + QuotedStr(NativePlace);
    end;

    if ContactNumber <> '' then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND contact_number = ' + QuotedStr(ContactNumber);
    end;

    if ParentType <> '' then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND parent_type = ' + ParentType;
    end;

    if ParentName <> '' then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND parent_name LIKE ' +QuotedStr(Trim('%' + ParentName + '%'));
    end;

    if ParentNumber <> '' then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' AND parent_number = ' + QuotedStr(ParentNumber);
    end;

    if (CreateTimeB <> 0) and (CreateTimeE <> 0) then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' and create_time between TO_DATE(' + QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS', CreateTimeB)) + ', ''YYYY-MM-DD HH24:MI:SS'') and TO_DATE(' + QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS', CreateTimeE)) + ', ''YYYY-MM-DD HH24:MI:SS'')';
    end;

    if (LastTimeB <> 0) and (LastTimeE <> 0) then
    begin
      UniQuery.SQL.Text := UniQuery.SQL.Text + ' and last_time between TO_DATE(' + QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS', LastTimeB)) + ', ''YYYY-MM-DD HH24:MI:SS'') and TO_DATE(' + QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS', LastTimeE)) + ', ''YYYY-MM-DD HH24:MI:SS'')';

    end;
    // ������ɵĲ�ѯ������ڵ���
    ShowMessage(UniQuery.SQL.Text);
    // ִ�в�ѯ
    Result := UniQuery.SQL.Text;

    // ����ѯ���������


  finally
    UniQuery.Free;
  end;
end;

exports
  InitializeConnection,
  FinalizeConnection,
  AddStudent,
  UpdateStudent,
  DeleteStudent,
  QueryStudent;

begin
end.
