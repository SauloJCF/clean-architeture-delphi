unit UUtils;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  UResponse,
  UExceptions,
  UEnums,
  UCliente;

function TratarException(const E: Exception): TResponse;

function ListaClienteParaListaObject(const ListaClientes: TObjectList<TCliente>)
  : TObjectList<TObject>;

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

function ListaClienteParaListaObject(const ListaClientes: TObjectList<TCliente>)
  : TObjectList<TObject>;
var
  Cliente: TCliente;
begin
  Result := TObjectList<TObject>.Create;

  if ListaClientes.Count > 0 then
  begin
    for Cliente in ListaClientes do
    begin
      Result.Add(Cliente);
    end;
  end;
end;

end.
