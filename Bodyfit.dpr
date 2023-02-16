program Bodyfit;

uses
  System.StartUpCopy,
  FMX.Forms,
  ULogin in 'ULogin.pas' {FrmLogin},
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UFrameTreinos in 'Frames\UFrameTreinos.pas' {FrameTreino: TFrame},
  UTreinoDetalhe in 'UTreinoDetalhe.pas' {FrmTreinoDetalhe},
  UTreinoCad in 'UTreinoCad.pas' {FrmTreinoCad},
  UFrameFichaExercicio in 'Frames\UFrameFichaExercicio.pas' {FrameFichaExercicio: TFrame},
  UExercicio in 'UExercicio.pas' {FrmExercicio},
  UPerfil in 'UPerfil.pas' {FrmPerfil},
  UPerfilCad in 'UPerfilCad.pas' {FrmPerfilCad},
  UPerfilSenha in 'UPerfilSenha.pas' {FrmPerfilSenha},
  UDM in 'DataModules\UDM.pas' {DM: TDataModule},
  Loading in 'Units\Loading.pas',
  Session in 'Units\Session.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.
