unit DmStudent;

interface

uses
  System.SysUtils, System.Classes, UniProvider, OracleUniProvider, Data.DB,
  DBAccess, Uni, MemDS;

type
  TDataModule1 = class(TDataModule)
    UniQuery: TUniQuery;
    UniConnection: TUniConnection;
    UniDataSource: TUniDataSource;
    OracleUniProvider: TOracleUniProvider;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
