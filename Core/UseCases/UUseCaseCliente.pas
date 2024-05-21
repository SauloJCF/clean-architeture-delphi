unit UUseCaseCliente;

interface

uses
  System.SysUtils,

  UCliente,
  UResponse,
  UDTOCliente,
  UIUseCaseCliente,
  UEnums,
  UUtils;

type
  TUseCaseCliente = class(TInterfacedObject, IUseCaseCliente)
  private
  public
    function Cadastrar(const Cliente: TCliente): TResponse;
    function Alterar(const Cliente: TCliente): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DtoCliente): TResponse;
  end;

implementation

{ TUseCaseCliente }

function TUseCaseCliente.Alterar(const Cliente: TCliente): TResponse;
var
  Response: TResponse;
begin
  try
    Cliente.ValidarRegrasNegocio;

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
    Response.Success := True;
    Response.ErrorCode := 0;
    Response.Message := UEnums.RetornarMsgResponse.
      CONSULTA_REALIZADA_COM_SUCESSO;
    Response.Data := nil;
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

end.
