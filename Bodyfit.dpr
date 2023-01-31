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
  UPerfilSenha in 'UPerfilSenha.pas' {FrmPerfilSenha};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.
