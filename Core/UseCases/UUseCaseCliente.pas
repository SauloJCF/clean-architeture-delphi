unit UUseCaseCliente;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  UCliente,
  UResponse,
  UDTOCliente,
  UIUseCaseCliente,
  UIRepositoryCliente,
  UEnums,
  UUtils,
  UExceptions;

type
  TUseCaseCliente = class(TInterfacedObject, IUseCaseCliente)
  private
    FRepository: IRepositoryCliente;
    FLista: TObjectList<TCliente>;
    FListaObject: TObjectList<TObject>;

    procedure ValidarId(const Id: Integer);
    procedure SetLista(const Value: TObjectList<TCliente>);
    procedure SetListaObject(const Value: TObjectList<TObject>);
  public
    function Cadastrar(const Cliente: TCliente): TResponse;
    function Alterar(const Cliente: TCliente): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DtoCliente): TResponse;

    constructor Create(const RepositoryCliente: IRepositoryCliente);
    destructor Destroy; Override;

    property Lista: TObjectList<TCliente> read FLista write SetLista;
    property ListaObject: TObjectList<TObject> read FListaObject
      write SetListaObject;
  end;

implementation

{ TUseCaseCliente }

function TUseCaseCliente.Alterar(const Cliente: TCliente): TResponse;
var
  Response: TResponse;
begin
  try
    Cliente.ValidarRegrasNegocio;

    FRepository.Alterar(Cliente);

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

function TUseCaseCliente.Cadastrar(const Cliente: TCliente): TResponse;
var
  Response: TResponse;
begin
  try
    Cliente.ValidarRegrasNegocio;

    FRepository.Cadastrar(Cliente);

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

function TUseCaseCliente.Consultar(const Dto: DtoCliente): TResponse;
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
      Response.Data := ListaClienteParaListaObject(FLista);
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

function TUseCaseCliente.Deletar(const Id: Integer): TResponse;
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

procedure TUseCaseCliente.ValidarId(const Id: Integer);
begin
  if Id <= 0 then
    ExceptionIdInvalido;
end;

constructor TUseCaseCliente.Create(const RepositoryCliente: IRepositoryCliente);
begin
  FRepository := RepositoryCliente;
  FLista := TObjectList<TCliente>.Create;
  FListaObject := TObjectList<TObject>.Create;
end;

destructor TUseCaseCliente.Destroy;
begin
  FLista.Free;
  FListaObject.Free;
  inherited;
end;

procedure TUseCaseCliente.SetLista(const Value: TObjectList<TCliente>);
begin
  FLista := Value;
end;

procedure TUseCaseCliente.SetListaObject(const Value: TObjectList<TObject>);
begin
  FListaObject := Value;
end;

end.
