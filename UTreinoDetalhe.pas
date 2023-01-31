unit UTreinoDetalhe;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TFrmTreinoDetalhe = class(TForm)
    LytToobar: TLayout;
    LblTitulo: TLabel;
    ImgFechar: TImage;
    Label7: TLabel;
    LbxExercicios: TListBox;
    RtgBtnLogin: TRectangle;
    BtnIniciar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure ImgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnIniciarClick(Sender: TObject);
    procedure LbxExerciciosItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    procedure AddExercicios(id_exercicio: integer; titulo, subtitulo: String);
    procedure CarregarExercicios;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTreinoDetalhe: TFrmTreinoDetalhe;

implementation

{$R *.fmx}

uses UFrameTreinos, UTreinoCad, UExercicio;

procedure TFrmTreinoDetalhe.AddExercicios(id_exercicio: integer; titulo,
  subtitulo: String);
var
  item: TListBoxItem;
  frame: TFrameTreino;
begin
  item := TListBoxItem.Create(LbxExercicios);
  item.Selectable := false;
  item.Text := '';
  item.Height := 90;
  item.Tag := id_exercicio;

  // Frame...
  frame := TFrameTreino.Create(item);
  frame.LblTitulo.Text := titulo;
  frame.LblSubTitulo.Text := subtitulo;

  item.AddObject(frame);

  LbxExercicios.AddObject(item);
end;

procedure TFrmTreinoDetalhe.BtnIniciarClick(Sender: TObject);
begin
  if not Assigned(FrmTreinoCad) then
    Application.CreateForm(TFrmTreinoCad, FrmTreinoCad);

  FrmTreinoCad.Show;
end;

procedure TFrmTreinoDetalhe.CarregarExercicios;
begin
  AddExercicios(1, 'Cardio (esteira ou bike)', '15 minutos');
  AddExercicios(2, 'Prancha isométrica', '3x 15 a 20');
  AddExercicios(3, 'Lombar máquina', '3x 15 a 20');
  AddExercicios(4, 'Supino', '3x 15 a 20');
  AddExercicios(5, 'Remada', '3x 15 a 20');
end;

procedure TFrmTreinoDetalhe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= TCloseAction.caFree;
  FrmTreinoDetalhe:= nil;
end;

procedure TFrmTreinoDetalhe.FormShow(Sender: TObject);
begin
  CarregarExercicios;
end;

procedure TFrmTreinoDetalhe.ImgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmTreinoDetalhe.LbxExerciciosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  if not Assigned(FrmExercicio) then
    Application.CreateForm(TFrmExercicio, FrmExercicio);

  FrmExercicio.Show;
end;

end.
