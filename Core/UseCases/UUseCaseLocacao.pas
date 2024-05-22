unit UUseCaseLocacao;

interface

uses
  System.SysUtils,
  UEnums,
  UExceptions,
  UResponse,
  ULocacao,
  UDTOLocacao,
  UUtils,
  UIUseCaseLocacao;

type

  TUseCaseLocacao = class(TInterfacedObject, IUseCaseLocacao)
  private
    procedure ValidarId(const Id: Integer);
  public
    function Cadastrar(const Locacao: TLocacao): TResponse;
    function Alterar(const Locacao: TLocacao): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DTOLocacao): TResponse;
  end;

implementation

{ TUseCaseLocacao }

function TUseCaseLocacao.Alterar(const Locacao: TLocacao): TResponse;
var
  Response: TResponse;
begin
  try
    Locacao.ValidarRegrasNegocio;

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

function TUseCaseLocacao.Cadastrar(const Locacao: TLocacao): TResponse;
var
  Response: TResponse;
begin
  try
    Locacao.ValidarRegrasNegocio;

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

function TUseCaseLocacao.Consultar(const Dto: DTOLocacao): TResponse;
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

function TUseCaseLocacao.Deletar(const Id: Integer): TResponse;
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

procedure TUseCaseLocacao.ValidarId(const Id: Integer);
begin
  if Id <= 0 then
    ExceptionIdInvalido;
end;

end.
