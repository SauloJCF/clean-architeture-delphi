unit CleanArchiteture.Core.UseCases.UseCaseCliente;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.DTO.DTOCliente,
  CleanArchiteture.Core.Ports.IUseCaseCliente,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Utils.Utils,
  CleanArchiteture.Core.Exceptions.Exceptions;

type
  TUseCaseCliente = class(TInterfacedObject, IUseCaseCliente)
  private
    FRepository: IRepositoryCliente;
    FLista: TList<TCliente>;
    FListaGenerica: TList<TObject>;

    procedure ValidarId(const Id: Integer);
    procedure SetLista(const Value: TList<TCliente>);
    procedure SetListaGenerica(const Value: TList<TObject>);
  public
    function Cadastrar(const Cliente: TCliente): TResponse;
    function Alterar(const Cliente: TCliente): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const DTO: DTOCliente): TResponse;

    constructor Create(const RepositoryCliente: IRepositoryCliente);
    destructor Destroy; Override;

    property Lista: TList<TCliente> read FLista write SetLista;
    property ListaGenerica: TList<TObject> read FListaGenerica
      write SetListaGenerica;
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
    Response.Message := RetornarMsgResponse.ALTERADO_COM_SUCESSO;
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
    Response.Message := RetornarMsgResponse.CADASTRADO_COM_SUCESSO;
    Response.Data := nil;
  except
    on E: Exception do
    begin
      Response := TratarException(E);
    end;
  end;
  Result := Response;
end;

function TUseCaseCliente.Consultar(const DTO: DTOCliente): TResponse;
var
  Response: TResponse;
begin
  try
    FLista.Clear;
    FLista := FRepository.Consultar(DTO);

    if FLista.Count > 0 then
    begin
      Response.Success := True;
      Response.ErrorCode := 0;
      Response.Message := RetornarMsgResponse.
        CONSULTA_REALIZADA_COM_SUCESSO;
      Response.Data := ListaClienteParaListaGenerica(FLista);
    end
    else
    begin
      Response.Success := True;
      Response.ErrorCode := 0;
      Response.Message := RetornarMsgResponse.CONSULTA_SEM_RETORNO;
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
    Response.Message := RetornarMsgResponse.DELETADO_COM_SUCESSO;
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
  FLista := TList<TCliente>.Create;
  FListaGenerica := TList<TObject>.Create;
end;

destructor TUseCaseCliente.Destroy;
var
  Cliente: TObject;
begin
  if Assigned(FListaGenerica) then
    FreeAndNil(FListaGenerica);

  inherited;
end;

procedure TUseCaseCliente.SetLista(const Value: TList<TCliente>);
begin
  FLista := Value;
end;

procedure TUseCaseCliente.SetListaGenerica(const Value: TList<TObject>);
begin
  FListaGenerica := Value;
end;

end.
