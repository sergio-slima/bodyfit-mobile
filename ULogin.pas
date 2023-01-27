unit ULogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TFrmLogin = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    TabControl: TTabControl;
    TabLogin: TTabItem;
    TabConta: TTabItem;
    RtgLogin: TRectangle;
    Rectangle1: TRectangle;
    Edit1: TEdit;
    Edit2: TEdit;
    RtgBtnLogin: TRectangle;
    BtnLogin: TSpeedButton;
    Label1: TLabel;
    RtgConta: TRectangle;
    Rectangle3: TRectangle;
    Edit3: TEdit;
    Edit4: TEdit;
    Rectangle4: TRectangle;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Edit5: TEdit;
    procedure BtnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses UPrincipal;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
begin
  if not Assigned(FrmPrincipal) then
    Application.CreateForm(TFrmPrincipal, FrmPrincipal);

  Application.MainForm:= FrmPrincipal;
  FrmPrincipal.Show;
  FrmLogin.Close;
end;

end.
