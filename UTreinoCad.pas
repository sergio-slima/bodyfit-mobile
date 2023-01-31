unit UTreinoCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TFrmTreinoCad = class(TForm)
    LytToobar: TLayout;
    LblTitulo: TLabel;
    ImgFechar: TImage;
    Layout1: TLayout;
    Label7: TLabel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    RtgConcluir: TRectangle;
    BtnConcluir: TSpeedButton;
    LbxExercicios: TListBox;
    procedure FormShow(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
  private
    procedure AddExercicios(id_exercicio: integer; titulo, subtitulo: String; ind_concluido: Boolean);
    procedure CarregarExercicios;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTreinoCad: TFrmTreinoCad;

implementation

{$R *.fmx}

uses UFrameFichaExercicio;

procedure TFrmTreinoCad.AddExercicios(id_exercicio: integer; titulo,
  subtitulo: String; ind_concluido: Boolean);
var
  item: TListBoxItem;
  frame: TFrameFichaExercicio;
begin
  item := TListBoxItem.Create(LbxExercicios);
  item.Selectable := false;
  item.Text := '';
  item.Width := Trunc(LbxExercicios.Width * 0.85);
  item.Tag := id_exercicio;

  // Frame...
  frame := TFrameFichaExercicio.Create(item);
  frame.LblTitulo.Text := titulo;
  frame.LblSubTitulo.Text := subtitulo;

  item.AddObject(frame);

  LbxExercicios.AddObject(item);
end;

procedure TFrmTreinoCad.CarregarExercicios;
begin
  AddExercicios(1, 'Cardio (esteira ou bike)', '15 minutos', false);
  AddExercicios(2, 'Prancha isométrica', '3x 15 a 20', false);
  AddExercicios(3, 'Lombar máquina', '3x 15 a 20', false);
  AddExercicios(4, 'Supino', '3x 15 a 20', false);
  AddExercicios(5, 'Remada', '3x 15 a 20', false);
end;

procedure TFrmTreinoCad.FormShow(Sender: TObject);
begin
  CarregarExercicios;
end;

procedure TFrmTreinoCad.ImgFecharClick(Sender: TObject);
begin
  Close;
end;

end.
