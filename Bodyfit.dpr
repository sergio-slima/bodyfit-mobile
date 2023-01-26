program Bodyfit;

uses
  System.StartUpCopy,
  FMX.Forms,
  ULogin in 'ULogin.pas' {FrmBodyfit};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmBodyfit, FrmBodyfit);
  Application.Run;
end.
