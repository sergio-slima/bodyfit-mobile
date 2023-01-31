unit UPerfilCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit;

type
  TFrmPerfilCad = class(TForm)
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
  FrmPerfilCad: TFrmPerfilCad;

implementation

{$R *.fmx}

procedure TFrmPerfilCad.ImgFecharClick(Sender: TObject);
begin
  Close;
end;

end.
