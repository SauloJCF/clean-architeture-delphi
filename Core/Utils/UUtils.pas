unit UUtils;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  TypInfo,
  UResponse,
  UExceptions,
  UEnums,
  UCliente,
  UVeiculo;

function TratarException(const E: Exception): TResponse;

function ListaClienteParaListaGenerica(const ListaClientes: TList<TCliente>)
  : TList<TObject>;

function ListaVeiculoParaListaGenerica(const ListaVeiculos: TList<TVeiculo>):
    TList<TObject>;

function ConverterStatusStr(const Value: Status): string;

function ConverterStrStatus(const Value: string): Status;

implementation

function TratarException(const E: Exception): TResponse;
var
  Response: TResponse;
begin
  Response.Success := False;
  Response.Message := E.Message;
  Response.Data := Nil;

  if E.ClassType = EExceptionDatabase then
    Response.ErrorCode := RetornarErrorsCode.ERRO_BANCO_DADOS;
  if E.ClassType = EExceptionNome then
    Response.ErrorCode := RetornarErrorsCode.NOME_NAO_INFORMADO;
  if E.ClassType = EExceptionMinimoNome then
    Response.ErrorCode := RetornarErrorsCode.NOME_INVALIDO;
  if E.ClassType = EExceptionDocumento then
    Response.ErrorCode := RetornarErrorsCode.DOCUMENTO_NAO_INFORMADO;
  if E.ClassType = EExceptionMinimoDocumento then
    Response.ErrorCode := RetornarErrorsCode.DOCUMENTO_INVALIDO;
  if E.ClassType = EExceptionTelefone then
    Response.ErrorCode := RetornarErrorsCode.TELEFONE_NAO_INFORMADO;
  if E.ClassType = EExceptionMinimoTelefone then
    Response.ErrorCode := RetornarErrorsCode.TELEFONE_INVALIDO;
  if E.ClassType = EExceptionMinimoNomeVeiculo then
    Response.ErrorCode := RetornarErrorsCode.NOME_INVALIDO;
  if E.ClassType = EExceptionPlacaVeiculo then
    Response.ErrorCode := RetornarErrorsCode.PLACA_NAO_INFORMADA;
  if E.ClassType = EExceptionMinimoPlacaVeiculo then
    Response.ErrorCode := RetornarErrorsCode.PLACA_INVALIDA;
  if E.ClassType = EExceptionValorVeiculo then
    Response.ErrorCode := RetornarErrorsCode.VALOR_INVALIDO;
  if E.ClassType = EExceptionLocacaoVeiculo then
    Response.ErrorCode := RetornarErrorsCode.VEICULO_NAO_INFORMADO;
  if E.ClassType = EExceptionLocacaoCliente then
    Response.ErrorCode := RetornarErrorsCode.CLIENTE_NAO_INFORMADO;
  if E.ClassType = EExceptionLocacaoVeiculoAlugado then
    Response.ErrorCode := RetornarErrorsCode.VEICULO_ALUGADO;
  Result := Response;
end;

function ListaClienteParaListaGenerica(const ListaClientes: TList<TCliente>)
  : TList<TObject>;
var
  Cliente: TCliente;
begin
  Result := TList<TObject>.Create;

  if ListaClientes.Count > 0 then
  begin
    for Cliente in ListaClientes do
    begin
      Result.Add(Cliente);
    end;
  end;
end;

function ListaVeiculoParaListaGenerica(const ListaVeiculos: TList<TVeiculo>)
  : TList<TObject>;
var
  Veiculo: TVeiculo;
begin
  Result := TList<TObject>.Create;

  if ListaVeiculos.Count > 0 then
  begin
    for Veiculo in ListaVeiculos do
    begin
      Result.Add(Veiculo);
    end;
  end;
end;

function ConverterStatusStr(const Value: Status): string;
begin
  Result := GetEnumName(TypeInfo(Status), integer(Value));
end;

function ConverterStrStatus(const Value: string): Status;
begin
  Result := Status(GetEnumValue(TypeInfo(Status), Value));
end;

end.
