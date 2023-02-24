unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  Loading, Session, System.DateUtils;

type
  TFrmPrincipal = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    LblNome: TLabel;
    ImgPerfil: TImage;
    Layout2: TLayout;
    RtgDashTreino: TRectangle;
    RtgFundoTreino: TRectangle;
    RtgBarraTreino: TRectangle;
    Layout3: TLayout;
    Image2: TImage;
    Label3: TLabel;
    LblQtdTreino: TLabel;
    Rectangle3: TRectangle;
    RtgFundoPontos: TRectangle;
    RtgBarraPontos: TRectangle;
    Layout4: TLayout;
    Image3: TImage;
    Label5: TLabel;
    LblPontos: TLabel;
    Label7: TLabel;
    RtgSugestao: TRectangle;
    LblSugestao: TLabel;
    ImgSugestao: TImage;
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
    procedure MontarBarraProgresso;
    procedure MontarTreinoSugerido;
    procedure ThreadDashboardTerminate(Sender: TObject);
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
  LbxTreinos.Items.Clear;
  DM.ListarTreinos;

  with DM.QryconsTreino do
  begin
    while not eof do
    begin
      AddTreino(FieldByName('id_treino').AsInteger,
                FieldByName('treino').AsString,
                FieldByName('descr_treino').AsString);
      Next;
    end;
  end;
end;

procedure TFrmPrincipal.MontarBarraProgresso;
var
  porc: double;
begin
  porc := LblQtdTreino.Text.ToInteger / DaysInMonth(now);
  RtgBarraTreino.Width := RtgFundoTreino.Width * porc;

  porc := LblPontos.Text.ToInteger / 1000;
  RtgBarraPontos.Width := RtgFundoPontos.Width * porc;
end;

procedure TFrmPrincipal.MontarTreinoSugerido;
begin
  if DM.QryConsEstatistica.RecordCount = 0 then
  begin
    LblSugestao.Text := 'Nenhuma sugestão';
    ImgSugestao.Visible := False;
    RtgSugestao.Tag := 0;
  end else
  begin
    LblSugestao.Text := DM.QryConsEstatistica.FieldByName('descr_treino').AsString;
    ImgSugestao.Visible := True;
    RtgSugestao.Tag := DM.QryConsEstatistica.FieldByName('id_treino').AsInteger;
  end;
end;

procedure TFrmPrincipal.ThreadDashboardTerminate(Sender: TObject);
begin
  TLoading.Hide;
  CarregarTreinos;
end;

procedure TFrmPrincipal.MontarDashboard;
var
  t: TThread;
begin
  TLoading.ShowF(FrmPrincipal, '');

  t:= TThread.CreateAnonymousThread(procedure
  var
    qtd_treino, pontos: integer;
  begin
    qtd_treino := DM.TreinosMes(now);
    pontos := DM.Pontuacao();
    DM.TreinoSugerido(now);

    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      LblQtdTreino.Text := qtd_treino.ToString;
      LblPontos.Text := pontos.ToString;

      MontarBarraProgresso;
      MontarTreinoSugerido;
    end);
  end);
  t.OnTerminate := ThreadDashboardTerminate;
  t.Start;
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
  LblNome.Text := TSession.NOME;
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
