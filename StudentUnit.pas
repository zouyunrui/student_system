unit StudentUnit;

interface

uses
  SysUtils, Classes;

type
  TStudent = class
  private
    FID: string;               // ѧ�ţ�����
    FName: string;             // ����
    FSex: string;              // �Ա� ����/Ů��
    FBirthday: TDate;          // ��������
    FIDNo: string;             // ���֤��
    FNativePlace: string;      // ����
    FContactNumber: string;    // ��ϵ�绰
    FParentType: Integer;      // ��ĸ����
    FParentName: string;       // ��ĸ����
    FParentNumber: string;     // ��ĸ�绰
    FCreateTime: TDateTime;    // ����ʱ��
    FLastTime: TDateTime;      // ����޸�ʱ��
  public
    constructor Create(
      FID, FName, FSex: string;
      FBirthday: TDate;
      FIDNo, FNativePlace, FContactNumber: string;
      FParentType: Integer;
      FParentName, FParentNumber: string;
      FCreateTime, FLastTime: TDateTime
    );

    property ID: string read FID write FID;
    property Name: string read FName write FName;
    property Sex: string read FSex write FSex;
    property Birthday: TDate read FBirthday write FBirthday;
    property IDNo: string read FIDNo write FIDNo;
    property NativePlace: string read FNativePlace write FNativePlace;
    property ContactNumber: string read FContactNumber write FContactNumber;
    property ParentType: Integer read FParentType write FParentType;
    property ParentName: string read FParentName write FParentName;
    property ParentNumber: string read FParentNumber write FParentNumber;
    property CreateTime: TDateTime read FCreateTime write FCreateTime;
    property LastTime: TDateTime read FLastTime write FLastTime;
  end;

implementation

constructor TStudent.Create(
  FID, FName, FSex: string;
  FBirthday: TDate;
  FIDNo, FNativePlace, FContactNumber: string;
  FParentType: Integer;
  FParentName, FParentNumber: string;
  FCreateTime, FLastTime: TDateTime
);
begin
 Self. FID := FID;
  Self.FName := FName;
  Self.FSex := FSex;
  Self.FBirthday := FBirthday;
  Self.FIDNo := FIDNo;
  Self.FNativePlace := FNativePlace;
  Self.FContactNumber := FContactNumber;
  Self.FParentType := FParentType;
  Self.FParentName := FParentName;
  Self.FParentNumber := FParentNumber;
  self.FCreateTime := FCreateTime;
 self. FLastTime := FLastTime;
end;

end.

