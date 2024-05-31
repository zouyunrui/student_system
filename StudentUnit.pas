unit StudentUnit;

interface

uses
  SysUtils, Classes;

type
  TStudent = class
  private
    FID: string;               // 学号，主键
    FName: string;             // 姓名
    FSex: string;              // 性别 （男/女）
    FBirthday: TDate;          // 出生日期
    FIDNo: string;             // 身份证号
    FNativePlace: string;      // 籍贯
    FContactNumber: string;    // 联系电话
    FParentType: Integer;      // 父母类型
    FParentName: string;       // 父母姓名
    FParentNumber: string;     // 父母电话
    FCreateTime: TDateTime;    // 创建时间
    FLastTime: TDateTime;      // 最后修改时间
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

