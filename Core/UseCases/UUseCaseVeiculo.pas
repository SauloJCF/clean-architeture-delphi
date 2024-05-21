unit UUseCaseVeiculo;

interface

uses
  System.SysUtils,

  UEnums,
  UVeiculo,
  UUtils,
  UResponse,
  UDTOVeiculo,
  UIUseCaseVeiculo,
  UExceptions;

type
  TUseCaseVeiculo = class(TInterfacedObject, IUseCaseVeiculo)
  private
    procedure ValidarId(const Id: Integer);
  public
    function Cadastrar(const Veiculo: TVeiculo): TResponse;
    function Alterar(const Veiculo: TVeiculo): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DTOVeiculo): TResponse;
  end;

implementation

{ TUseCaseVeiculo }

function TUseCaseVeiculo.Alterar(const Veiculo: TVeiculo): TResponse;
var
  Response: TResponse;
begin
  try
    Veiculo.ValidarRegrasNegocio;

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

function TUseCaseVeiculo.Deletar(const Id: Integer): TResponse;
var
  Response: TResponse;
begin
  try
    ValidarId(Id);
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

procedure TUseCaseVeiculo.ValidarId(const Id: Integer);
begin
  if Id <= 0 then
    ExceptionIdInvalido;
end;

end.
