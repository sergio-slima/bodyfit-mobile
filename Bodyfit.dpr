program Bodyfit;

uses
  System.StartUpCopy,
  FMX.Forms,
  ULogin in 'ULogin.pas' {FrmLogin},
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UFrameTreinos in 'Frames\UFrameTreinos.pas' {FrameTreino: TFrame},
  UTreinoDetalhe in 'UTreinoDetalhe.pas' {FrmTreinoDetalhe};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmTreinoDetalhe, FrmTreinoDetalhe);
  Application.Run;
end.
