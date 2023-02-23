unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,

  DataSet.Serialize.Config,
  System.IOUtils,
  System.DateUtils,
  RESTRequest4D,
  System.JSON, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.DApt;

type
  TDM = class(TDataModule)
    Conn: TFDConnection;
    TabUsuario: TFDMemTable;
    QryUsuario: TFDQuery;
    TabTreino: TFDMemTable;
    QryTreinoExercicio: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure ConnAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    procedure LoginOnline(email, senha: String);
    procedure CriarContaOnline(nome, email, senha: String);
    procedure InserirUsuario(id_usuario: integer; nome, email: String);
    procedure ListarTreinoExercicioOnline(id_usuario: integer);
    procedure ExcluirTreinoExercicio;
    procedure InserirTreinoExercicio(id_treino: integer; treino,
                                     descr_treino: string; dia_semana, id_exercicio: integer; exercicio,
                                     descr_exercicio, duracao, url_video: string);
    { Public declarations }
  end;

var
  DM: TDM;

const
  BASE_URL = 'http://localhost:3000';

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.ConnAfterConnect(Sender: TObject);
begin
  // Tabela de Usuarios
  Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_USUARIO (' +
                 'ID_USUARIO    INTEGER NOT NULL PRIMARY KEY, ' +
                 'NOME          VARCHAR (100), ' +
                 'EMAIL         VARCHAR (100), ' +
                 'PONTOS        INTEGER);'
               );
  // Tabela de treinos e exercicios recebidos do server
  Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_TREINO_EXERCICIO ( ' +
                 'ID_TREINO_EXERCICIO INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                 'ID_TREINO           INTEGER, ' +
                 'TREINO              VARCHAR(100), ' +
                 'DESC_TREINO         VARCHAR(100), ' +
                 'DIA_SEMANA          INTEGER, ' +
                 'ID_EXERCICIO        INTEGER, ' +
                 'EXERCICIO           VARCHAR(100), ' +
                 'DESCR_EXERCICIO     VARCHAR(1000), ' +
                 'DURACAO             VARCHAR(100), ' +
                 'URL_VIDEO           VARCHAR(1000));'
                );
   // Tabela de Usuarios
  Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_ATIVIDADE_HISTORICO (' +
                 'ID_HISTORICO    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                 'ID_TREINO       INTEGER, ' +
                 'DT_ATIVIDADE    DATETIME);'
               );
   // Tabela de Usuarios
  Conn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_ATIVIDADE (' +
                 'ID_ATIVIDADE     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                 'ID_TREINO        INTEGER, ' +
                 'ID_EXERCICIO     INTEGER, ' +
                 'EXERCICIO        VARCHAR (100), ' +
                 'DURACAO          VARCHAR (100), ' +
                 'IND_CONCLUIDO    CHAR(1));'
               );


end;

procedure TDM.ConnBeforeConnect(Sender: TObject);
begin
  Conn.DriverName := 'SQLite';

  {$IFDEF MSWINDOWS}
  Conn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\banco.db';
  {$ELSE}
  Conn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
  {$ENDIF}
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

  Conn.Connected := True;
end;

procedure TDM.LoginOnline(email, senha: String);
var
  resp: IResponse;
  json: TJSONObject;
begin
  TabUsuario.FieldDefs.Clear;

  try
    json := TJSONObject.Create;
    json.AddPair('email',email);
    json.AddPair('senha',senha);

    resp := TRequest.New.BaseURL(BASE_URL)
            .Resource('usuarios/login')
            .AddBody(json.ToJSON)
            .BasicAuthentication('Sergio','123')
            .Accept('application/json')
            .DAtaSetAdapter(TabUsuario)
            .Post;

    if resp.StatusCode <> 200 then
      raise Exception.Create(resp.Content);

  finally
    json.DisposeOf;
  end;
end;

procedure TDM.CriarContaOnline(nome, email, senha: String);
var
  resp: IResponse;
  json: TJSONObject;
begin
  TabUsuario.FieldDefs.Clear;

  try
    json := TJSONObject.Create;
    json.AddPair('nome',nome);
    json.AddPair('email',email);
    json.AddPair('senha',senha);

    resp := TRequest.New.BaseURL(BASE_URL)
            .Resource('usuarios/registro')
            .AddBody(json.ToJSON)
            .BasicAuthentication('Sergio','123')
            .Accept('application/json')
            .DAtaSetAdapter(TabUsuario)
            .Post;

    if resp.StatusCode <> 201 then
      raise Exception.Create(resp.Content);

  finally
    json.DisposeOf;
  end;
end;

procedure TDM.InserirUsuario(id_usuario: integer; nome, email: String);
begin
  with QryUsuario do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Delete from tab_usuario where id_usuario <> :id_usuario');
    ParamByName('id_usuario').Value := id_usuario;
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('select * from tab_usuario');
    Open;

    if RecordCount = 0 then
    begin
      Close;
      SQL.Clear;
      SQL.Add('Insert into tab_usuario(id_usuario,nome,email,pontos)');
      SQL.Add('Values(:id_usuario,:nome,:email,0)');
      ParamByName('id_usuario').Value := id_usuario;
      ParamByName('nome').Value := nome;
      ParamByName('email').Value := email;
      ExecSQL;
    end else
    begin
      Close;
      SQL.Clear;
      SQL.Add('Update tab_usuario set nome = :nome, email = :email');
      ParamByName('nome').Value := nome;
      ParamByName('email').Value := email;
      ExecSQL;
    end;
  end;
end;

procedure TDM.ListarTreinoExercicioOnline(id_usuario: integer);
var
  resp: IResponse;
begin
  TabTreino.FieldDefs.Clear;

  resp := TRequest.New.BaseURL(BASE_URL)
          .Resource('treinos')
          .AddParam('id_usuario', id_usuario)
          .BasicAuthentication('Sergio','123')
          .Accept('application/json')
          .DataSetAdapter(TabTreino)
          .Get;

  if resp.StatusCode <> 200 then
    raise Exception.Create(resp.Content);
end;

procedure TDM.ExcluirTreinoExercicio;
begin
  Conn.ExecSQL('delete from tab_treino_exercicio');
end;

procedure TDM.InserirTreinoExercicio(id_treino: integer; treino, descr_treino: string;
                                     dia_semana, id_exercicio: integer; exercicio,
                                     descr_exercicio, duracao, url_video: string);
begin
  with QryTreinoExercicio do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into tab_treino_exercicio(id_treino, treino, descr_treino,');
    SQL.Add('dia_semana, id_exercicio, exercicio, descr_exercicio, duracao, url_video)');
    SQL.Add('values(:id_treino, :treino, :descr_treino, :dia_semana');
    SQL.Add(':id_exercicio, :exercicio, descr_exercicio, duracao, url_video');
    ParamByName('id_treino').Value := id_treino;
    ParamByName('treino').Value := treino;
    ParamByName('descr_treino').Value := descr_treino;
    ParamByName('dia_semana').Value := dia_semana;
    ParamByName('id_exercicio').Value := id_exercicio;
    ParamByName('exercicio').Value := exercicio;
    ParamByName('descr_exercicio').Value := descr_exercicio;
    ParamByName('duracao').Value := duracao;
    ParamByName('url_video').Value := url_video;
  end;
end;

end.
