unit ULogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls,
  Loading, Session;

type
  TFrmLogin = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    TabControl: TTabControl;
    TabLogin: TTabItem;
    TabConta: TTabItem;
    RtgLogin: TRectangle;
    Rectangle1: TRectangle;
    EdtEmail: TEdit;
    EdtSenha: TEdit;
    RtgBtnLogin: TRectangle;
    BtnLogin: TSpeedButton;
    LblConta: TLabel;
    RtgConta: TRectangle;
    Rectangle3: TRectangle;
    EdtContaNome: TEdit;
    EdtContaSenha: TEdit;
    Rectangle4: TRectangle;
    BtnCriarConta: TSpeedButton;
    LblLogin: TLabel;
    EdtContaEmail: TEdit;
    procedure BtnLoginClick(Sender: TObject);
    procedure BtnCriarContaClick(Sender: TObject);
    procedure LblContaClick(Sender: TObject);
    procedure LblLoginClick(Sender: TObject);
  private
    procedure AbrirPrincipal;
    procedure ThreadLoginTerminate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses UPrincipal, UDM;

procedure TFrmLogin.ThreadLoginTerminate(Sender: TObject);
begin
  TLoading.Hide;
  if Sender is TThread then
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage(Exception(TThread(sender).FatalException).Message);
      Exit;
    end;
  AbrirPrincipal;
end;

procedure TFrmLogin.AbrirPrincipal;
begin
  if not Assigned(FrmPrincipal) then
    Application.CreateForm(TFrmPrincipal, FrmPrincipal);

  Application.MainForm:= FrmPrincipal;
  FrmPrincipal.Show;
  FrmLogin.Close;
end;

procedure TFrmLogin.BtnCriarContaClick(Sender: TObject);
var
  t: TThread;
begin
  TLoading.ShowF(FrmLogin, '');

  t := TThread.CreateAnonymousThread(procedure
  begin
    DM.CriarContaOnline(EdtcontaNome.Text, EdtContaEmail.Text, EdtContaSenha.Text);

    with DM.TabUsuario do
    begin
      DM.InserirUsuario(FieldByName('id_usuario').AsInteger,
                        FieldByName('nome').AsString,
                        FieldByName('email').AsString);

      TSession.ID_USUARIO := FieldByName('id_usuario').AsInteger;
      TSession.NOME := FieldByName('nome').AsString;
      TSession.EMAIL := FieldByName('email').AsString;
    end;
  end);

  t.onTerminate := ThreadLoginTerminate;
  t.Start;
end;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
var
  t: TThread;
begin
  TLoading.ShowF(FrmLogin, '');

  t := TThread.CreateAnonymousThread(procedure
  begin
    DM.LoginOnline(EdtEmail.Text, EdtSenha.Text);

    with DM.TabUsuario do
    begin
      DM.InserirUsuario(FieldByName('id_usuario').AsInteger,
                        FieldByName('nome').AsString,
                        FieldByName('email').AsString);

      TSession.ID_USUARIO := FieldByName('id_usuario').AsInteger;
      TSession.NOME := FieldByName('nome').AsString;
      TSession.EMAIL := FieldByName('email').AsString;
    end;
  end);

  t.onTerminate := ThreadLoginTerminate;
  t.Start;
end;

procedure TFrmLogin.LblContaClick(Sender: TObject);
begin
  TabControl.GotoVisibleTab(1);
end;

procedure TFrmLogin.LblLoginClick(Sender: TObject);
begin
  TabControl.GotoVisibleTab(0);
end;

end.
