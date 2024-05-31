program StudentProject;

uses
  Vcl.Forms,
  StudentList in 'StudentList.pas' {TfrmStudentList},
  StudentDlg in 'StudentDlg.pas' {TfrmStudentDlg},
  DmStudent in 'DmStudent.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TTfrmStudentList, TfrmStudentList);
  Application.CreateForm(TTfrmStudentDlg, TfrmStudentDlg);
  Application.Run;
end.

