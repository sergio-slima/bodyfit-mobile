unit UPerfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFrmPerfil = class(TForm)
    LytToobar: TLayout;
    LblTitulo: TLabel;
    ImgFechar: TImage;
    RtgPerfil: TRectangle;
    Label8: TLabel;
    Image4: TImage;
    Image1: TImage;
    RtgDesconectar: TRectangle;
    Label1: TLabel;
    Image2: TImage;
    Image3: TImage;
    RtgSenha: TRectangle;
    Label2: TLabel;
    Image5: TImage;
    Image6: TImage;
    Label7: TLabel;
    procedure ImgFecharClick(Sender: TObject);
    procedure RtgPerfilClick(Sender: TObject);
    procedure RtgSenhaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPerfil: TFrmPerfil;

implementation

{$R *.fmx}

uses UPerfilCad, UPerfilSenha;

procedure TFrmPerfil.ImgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPerfil.RtgPerfilClick(Sender: TObject);
begin
  if not Assigned(FrmPerfilCad) then
    Application.CreateForm(TFrmPerfilCad, FrmPerfilCad);

  FrmPerfilCad.Show;
end;

procedure TFrmPerfil.RtgSenhaClick(Sender: TObject);
begin
  if not Assigned(FrmPerfilSenha) then
    Application.CreateForm(TFrmPerfilSenha, FrmPerfilSenha);

  FrmPerfilSenha.Show;
end;

end.
