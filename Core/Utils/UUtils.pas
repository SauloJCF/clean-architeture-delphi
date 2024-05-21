unit UUtils;

interface

uses
  System.SysUtils,
  UResponse,
  UExceptions,
  UEnums;

function TratarException(const E: Exception): TResponse;

implementation

function TratarException(const E: Exception): TResponse;
var
  Response: TResponse;
begin
  Response.Success := False;
  Response.Message := E.Message;
  Response.Data := Nil;

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

  Result := Response;
end;

end.
