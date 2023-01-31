unit UExercicio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.WebBrowser;

type
  TFrmExercicio = class(TForm)
    LytToobar: TLayout;
    LblTitulo: TLabel;
    ImgFechar: TImage;
    WebBrowser1: TWebBrowser;
    Label7: TLabel;
    procedure ImgFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExercicio: TFrmExercicio;

implementation

{$R *.fmx}

procedure TFrmExercicio.ImgFecharClick(Sender: TObject);
begin
  CLose;
end;

end.
