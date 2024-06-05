unit UUseCaseVeiculo;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  UEnums,
  UVeiculo,
  UUtils,
  UResponse,
  UDTOVeiculo,
  UIUseCaseVeiculo,
  UExceptions,
  UIRepositoryVeiculo;

type
  TUseCaseVeiculo = class(TInterfacedObject, IUseCaseVeiculo)
  private
    FRepository: IRepositoryVeiculo;
    FLista: TList<TVeiculo>;
    FListaGenerica: TList<TObject>;

    procedure ValidarId(const Id: Integer);
    procedure SetLista(const Value: TList<TVeiculo>);
    procedure SetListaGenerica(const Value: TList<TObject>);
  public
    function Cadastrar(const Veiculo: TVeiculo): TResponse;
    function Alterar(const Veiculo: TVeiculo): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DTOVeiculo): TResponse;

    property Lista: TList<TVeiculo> read FLista write SetLista;
    property ListaGenerica: TList<TObject> read FListaGenerica
      write SetListaGenerica;

    constructor Create(const RepositoryCliente: IRepositoryVeiculo);
    destructor Destroy; Override;
  end;

implementation

{ TUseCaseVeiculo }

function TUseCaseVeiculo.Alterar(const Veiculo: TVeiculo): TResponse;
var
  Response: TResponse;
begin
  try
    Veiculo.ValidarRegrasNegocio;

    FRepository.Alterar(Veiculo);

    Response.Success := True;
    Response.ErrorCode := 0;
    Response.Message := UEnums.RetornarMsgResponse.ALTERADO_COM_SUCESSO;
    Response.Data := nil;
  except
    on E: Exception do
    begin
      Response := TratarException(E);
    end;
  end;
  Result := Response;
end;

function TUseCaseVeiculo.Cadastrar(const Veiculo: TVeiculo): TResponse;
var
  Response: TResponse;
begin
  try
    Veiculo.ValidarRegrasNegocio;

    FRepository.Cadastrar(Veiculo);

    Response.Success := True;
    Response.ErrorCode := 0;
    Response.Message := UEnums.RetornarMsgResponse.CADASTRADO_COM_SUCESSO;
    Response.Data := nil;
  except
    on E: Exception do
    begin
      Response := TratarException(E);
    end;
  end;
  Result := Response;
end;

function TUseCaseVeiculo.Consultar(const Dto: DTOVeiculo): TResponse;
var
  Response: TResponse;
begin
  try
    FLista.Clear;
    FLista := FRepository.Consultar(Dto);

    if FLista.Count > 0 then
    begin
      Response.Success := True;
      Response.ErrorCode := 0;
      Response.Message := UEnums.RetornarMsgResponse.
        CONSULTA_REALIZADA_COM_SUCESSO;
      Response.Data := ListaVeiculoParaListaGenerica(FLista);
    end
    else
    begin
      Response.Success := True;
      Response.ErrorCode := 0;
      Response.Message := UEnums.RetornarMsgResponse.CONSULTA_SEM_RETORNO;
      Response.Data := nil;
    end;
  except
    on E: Exception do
    begin
      Response := TratarException(E);
    end;
  end;
  Result := Response;
end;

constructor TUseCaseVeiculo.Create(const RepositoryCliente: IRepositoryVeiculo);
begin
  FRepository := RepositoryCliente;
  FLista := TList<TVeiculo>.Create;
  FListaGenerica := TList<TObject>.Create;
end;

function TUseCaseVeiculo.Deletar(const Id: Integer): TResponse;
var
  Response: TResponse;
begin
  try
    ValidarId(Id);
    FRepository.Excluir(Id);
    Response.Success := True;
    Response.ErrorCode := 0;
    Response.Message := UEnums.RetornarMsgResponse.DELETADO_COM_SUCESSO;
    Response.Data := nil;
  except
    on E: Exception do
    begin
      Response := TratarException(E);
    end;
  end;
  Result := Response;
end;

destructor TUseCaseVeiculo.Destroy;
var
  Veiculo: TObject;
begin
  if Assigned(FListaGenerica) then
  begin
    for Veiculo in FListaGenerica do
    begin
      Veiculo.Free;
    end;

    FreeAndNil(FListaGenerica);
  end;
  inherited;
end;

procedure TUseCaseVeiculo.SetLista(const Value: TList<TVeiculo>);
begin
  FLista := Value;
end;

procedure TUseCaseVeiculo.SetListaGenerica(const Value: TList<TObject>);
begin
  FListaGenerica := Value;
end;

procedure TUseCaseVeiculo.ValidarId(const Id: Integer);
begin
  if Id <= 0 then
    ExceptionIdInvalido;
end;

end.
