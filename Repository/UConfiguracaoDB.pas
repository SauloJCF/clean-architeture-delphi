unit UConfiguracaoDB;

interface

uses
  System.SysUtils,
  IniFiles,
  Firedac.Comp.Client,
  Firedac.Phys.FB,
  UExceptions;

type

  TConfiguracaoDB = class
  private
    FConnection: TFDConnection;
    FDPhsysFBDDriverLink: TFDPhysFBDriverLink;
    FQuery: TFDQuery;
    procedure SetQuery(const Value: TFDQuery);
  published
    function Conexao: TFDConnection;
    procedure ExecSQL(const SQL: String);
    function Consulta(const SQL: String): Boolean;
    property Query: TFDQuery read FQuery write SetQuery;

    constructor Create;
    Destructor Destroy; override;
  end;

implementation

{ TConfiguracaoDB }

function TConfiguracaoDB.Conexao: TFDConnection;
begin
  Result := FConnection;
end;

function TConfiguracaoDB.Consulta(const SQL: String): Boolean;
begin
  Result := False;

  try
    FQuery.SQL.Clear;
    FQuery.SQL.Add(SQL);
    FQuery.Open();
    Result := not FQuery.IsEmpty;
  except
    on E: Exception do
    begin
      ExceptionDatabase(E.Message);
    end;
  end;
end;

constructor TConfiguracaoDB.Create;
var
  Diretorio, Server, User, Database, Password, Driver: String;
  ArquivoIni: TIniFile;
begin
  Diretorio := ExtractFileDir(GetCurrentDir);
  ArquivoIni := TIniFile.Create(Diretorio + '/configuracao.ini');
  Driver := 'FB';
  Server := ArquivoIni.ReadString('conexao', 'server', EmptyStr);
  Database := ArquivoIni.ReadString('conexao', 'database', EmptyStr);
  User := ArquivoIni.ReadString('conexao', 'user', EmptyStr);
  Password := ArquivoIni.ReadString('conexao', 'password', EmptyStr);

  try
    FConnection := TFDConnection(nil);

    FDPhsysFBDDriverLink := TFDPhysFBDriverLink.Create(nil);
    FConnection.LoginPrompt := False;
    FConnection.Params.Clear;
    FConnection.Params.Add('DriverID=' + Driver);
    FConnection.Params.Add('Server=' + Server);
    FConnection.Params.Add('Database=' + Database);
    FConnection.Params.Add('User=' + User);
    FConnection.Params.Add('Password=' + Password);

    FConnection.Open();

    FQuery := TFDQuery.Create(nil);
    FQuery.Connection := FConnection;

  except
    on E: Exception do
    begin
      FConnection.Free;
      FDPhsysFBDDriverLink.Free;
      FQuery.Free;

      ExceptionDatabase(E.Message);
    end;
  end;
end;

destructor TConfiguracaoDB.Destroy;
begin
  FConnection.Free;
  FDPhsysFBDDriverLink.Free;
  FQuery.Free;

  inherited;
end;

procedure TConfiguracaoDB.ExecSQL(const SQL: String);
begin

  try
    FQuery.SQL.Clear;
    FQuery.SQL.Add(SQL);
    FQuery.ExecSQL();
  except
    on E: Exception do
    begin
      ExceptionDatabase(E.Message);
    end;
  end;
end;

procedure TConfiguracaoDB.SetQuery(const Value: TFDQuery);
begin
  FQuery := Value;
end;

end.
