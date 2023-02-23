unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  Loading, Session;

type
  TFrmPrincipal = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    ImgPerfil: TImage;
    Layout2: TLayout;
    RtgDashTreino: TRectangle;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Layout3: TLayout;
    Image2: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Layout4: TLayout;
    Image3: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Rectangle6: TRectangle;
    Label8: TLabel;
    Image4: TImage;
    Label9: TLabel;
    LbxTreinos: TListBox;
    procedure FormShow(Sender: TObject);
    procedure LbxTreinosItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure ImgPerfilClick(Sender: TObject);
  private
    procedure CarregarTreinos;
    procedure AddTreino(id_treino: integer; titulo, subtitulo: String);
    procedure SincronizarTreinos;
    procedure ThreadSincronizarTerminate(Sender: TObject);
    procedure MontarDashboard;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UFrameTreinos, UTreinoDetalhe, UPerfil, UDM;

procedure TFrmPrincipal.AddTreino(id_treino: integer; titulo,
  subtitulo: String);
var
  item: TListBoxItem;
  frame: TFrameTreino;
begin
  item := TListBoxItem.Create(LbxTreinos);
  item.Selectable := false;
  item.Text := '';
  item.Height := 90;
  item.Tag := id_treino;

  // Frame...
  frame := TFrameTreino.Create(item);
  frame.LblTitulo.Text := titulo;
  frame.LblSubTitulo.Text := subtitulo;

  item.AddObject(frame);

  LbxTreinos.AddObject(item);
end;

procedure TFrmPrincipal.CarregarTreinos;
begin
  AddTreino(1, 'Segunda-feira', 'Abdômen e Pernas');
  AddTreino(2, 'Terça-feira', 'Tríceps, Abdômen e Pernas');
  AddTreino(3, 'Quarat-feira', 'Lombar e Abdômen');
  AddTreino(4, 'Quinta-feira', 'Bíceps, Abdômen e Pernas');
  AddTreino(5, 'Sexta-feira', 'Abdômen e Pernas');
  AddTreino(6, 'Sábado', 'Peito e Pernas');
  AddTreino(7, 'Domingo', 'Costas e Pernas');
end;

procedure TFrmPrincipal.MontarDashboard;
begin
  //montar
end;

procedure TFrmPrincipal.ThreadSincronizarTerminate(Sender: TObject);
begin
  TLoading.Hide;

  MontarDashboard;
end;

procedure TFrmPrincipal.SincronizarTreinos;
var
  t: TThread;
begin
  TLoading.ShowF(FrmPrincipal, '');

  t := TThread.CreateAnonymousThread(procedure
  begin
    DM.ListarTreinoExercicioOnline(TSession.ID_USUARIO);

    with DM.TabTreino do
    begin
      if recordcount > 0 then
        DM.ExcluirTreinoExercicio;

      while not eof do
      begin
        DM.InserirTreinoExercicio(FieldByName('id_treino').AsInteger,
                                  FieldByName('treino').AsString,
                                  FieldByName('descr_treino').AsString,
                                  FieldByName('dia_semana').AsInteger,
                                  FieldByName('id_exercicio').AsInteger,
                                  FieldByName('exercicio').AsString,
                                  FieldByName('descr_exercicio').AsString,
                                  FieldByName('duracao').AsString,
                                  FieldByName('url_video').AsString);
        Next;
      end;
    end;
  end);

  t.onTerminate := ThreadSincronizarTerminate;
  t.Start;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  SincronizarTreinos;
end;

procedure TFrmPrincipal.ImgPerfilClick(Sender: TObject);
begin
  if not Assigned(FrmPerfil) then
    Application.CreateForm(TFrmPerfil, FrmPerfil);

  FrmPerfil.Show;
end;

procedure TFrmPrincipal.LbxTreinosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  if not Assigned(FrmTreinoDetalhe) then
    Application.CreateForm(TFrmTreinoDetalhe, FrmTreinoDetalhe);

  FrmTreinoDetalhe.Show;
end;

end.
