unit UPerfilSenha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmPerfilSenha = class(TForm)
    LytToobar: TLayout;
    LblTitulo: TLabel;
    ImgFechar: TImage;
    Rectangle1: TRectangle;
    Edit1: TEdit;
    Edit2: TEdit;
    RtgBtnSalvar: TRectangle;
    BtnSalvar: TSpeedButton;
    procedure ImgFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPerfilSenha: TFrmPerfilSenha;

implementation

{$R *.fmx}

procedure TFrmPerfilSenha.ImgFecharClick(Sender: TObject);
begin
  Close;
end;

end.
