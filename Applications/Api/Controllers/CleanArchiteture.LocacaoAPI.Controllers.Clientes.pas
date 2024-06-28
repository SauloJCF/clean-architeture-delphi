unit CleanArchiteture.LocacaoAPI.Controllers.Clientes;

interface

uses
  Horse,
  System.JSON,
  System.SysUtils,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Utils.Utils,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Controllers.ControllerCliente,
  CleanArchiteture.Presenters.IPresenter,
  CleanArchiteture.Presenters.PresenterJSON,
  CleanArchiteture.Repository.RepositoryCliente,
  CleanArchiteture.LocacaoAPI.Controllers.Consts;

procedure InjecaoDependencia;
procedure Destroy;

procedure PostCliente(Req: THorseRequest; Res: THorseResponse);
procedure PutCliente(Req: THorseRequest; Res: THorseResponse);
procedure DeleteCliente(Req: THorseRequest; Res: THorseResponse);
procedure GetClientes(Req: THorseRequest; Res: THorseResponse);

var
  FControllerCliente: TControllerCliente;
  FRepositoryCliente: IRepositoryCliente;
  FPresenter: IPresenter;

implementation

procedure InjecaoDependencia;
begin
  FPresenter := TPresenterJSON.Create;
  FRepositoryCliente := TRepositoryCliente.Create;
  FControllerCliente := TControllerCliente.Create(FRepositoryCliente,
    FPresenter);
end;

procedure PostCliente(Req: THorseRequest; Res: THorseResponse);
var
  Body: TJsonObject;
  Sucesso: Boolean;
  JsonValue: TJsonValue;
  Status, ErrorCode: Integer;
  Mensagem, Nome, Documento, Cep, Logradouro, Numero, Complemento, Bairro,
    Cidade, Uf, Telefone, Response: string;
begin
  InjecaoDependencia;

  Status := HTTP_STATUS_SUCESSO;

  Body := Req.Body<TJsonObject>;

  Nome := Body.GetValue<string>('nome');
  Documento := Body.GetValue<string>('documento');
  Cep := Body.GetValue<string>('cep');
  Logradouro := Body.GetValue<string>('logradouro');
  Numero := Body.GetValue<string>('numero');
  Complemento := Body.GetValue<string>('complemento');
  Bairro := Body.GetValue<string>('bairro');
  Cidade := Body.GetValue<string>('cidade');
  Uf := Body.GetValue<string>('uf');
  Telefone := Body.GetValue<string>('telefone');

  Response := FControllerCliente.Cadastrar(Nome, Documento, Cep, Logradouro,
    Numero, Complemento, Bairro, Cidade, Uf, Telefone);

  JsonValue := ConverterStrJSONParaObjectJson(Response);

  Mensagem := JsonValue.GetValue<string>('Message');
  Sucesso := JsonValue.GetValue<Boolean>('Success');
  ErrorCode := JsonValue.GetValue<Integer>('ErrorCode');

  if Mensagem = RetornarMsgResponse.CADASTRADO_COM_SUCESSO then
  begin
    Status := HTTP_STATUS_CRIACAO;
  end;

  if ErrorCode > ZERO then
  begin
    Status := HTTP_STATUS_ENTIDADE_IMPROCESSAVEL;
  end;

  if ErrorCode = RetornarErrorsCode.ERRO_BANCO_DADOS then
  begin
    Status := HTTP_STATUS_ERRO_INTERNO_SERVIDOR;
  end;

  Res.Send(Response).Status(Status);

  Destroy;
end;

procedure PutCliente(Req: THorseRequest; Res: THorseResponse);
var
  Body: TJsonObject;
  Sucesso: Boolean;
  JsonValue: TJsonValue;
  Status, ErrorCode: Integer;
  Id, Mensagem, Nome, Documento, Cep, Logradouro, Numero, Complemento, Bairro,
    Cidade, Uf, Telefone, Response: string;
begin
  InjecaoDependencia;

  Id := Req.Params['id'];

  if Id.IsEmpty then
    Id := ZERO_STR;

  Status := HTTP_STATUS_SUCESSO;

  Body := Req.Body<TJsonObject>;

  Nome := Body.GetValue<string>('nome');
  Documento := Body.GetValue<string>('documento');
  Cep := Body.GetValue<string>('cep');
  Logradouro := Body.GetValue<string>('logradouro');
  Numero := Body.GetValue<string>('numero');
  Complemento := Body.GetValue<string>('complemento');
  Bairro := Body.GetValue<string>('bairro');
  Cidade := Body.GetValue<string>('cidade');
  Uf := Body.GetValue<string>('uf');
  Telefone := Body.GetValue<string>('telefone');

  Response := FControllerCliente.Alterar(StrToInt(Id), Nome, Documento, Cep,
    Logradouro, Numero, Complemento, Bairro, Cidade, Uf, Telefone);

  JsonValue := ConverterStrJSONParaObjectJson(Response);

  Mensagem := JsonValue.GetValue<string>('Message');
  Sucesso := JsonValue.GetValue<Boolean>('Success');
  ErrorCode := JsonValue.GetValue<Integer>('ErrorCode');

  if Mensagem = RetornarMsgResponse.ALTERADO_COM_SUCESSO then
  begin
    Status := HTTP_STATUS_SUCESSO;
  end;

  if ErrorCode > ZERO then
  begin
    Status := HTTP_STATUS_ENTIDADE_IMPROCESSAVEL;
  end;

  if ErrorCode = RetornarErrorsCode.ERRO_BANCO_DADOS then
  begin
    Status := HTTP_STATUS_ERRO_INTERNO_SERVIDOR;
  end;

  Res.Send(Response).Status(Status);

  Destroy;

end;

procedure DeleteCliente(Req: THorseRequest; Res: THorseResponse);
var
  Id, Response, Mensagem: String;
  Sucesso: Boolean;
  JsonValue: TJsonValue;
  Status, ErrorCode: Integer;
begin
  InjecaoDependencia;

  Id := Req.Params['id'];

  if Id.IsEmpty then
    Id := ZERO_STR;

  Status := HTTP_STATUS_SUCESSO;

  Response := FControllerCliente.Deletar(StrToInt(Id));

  JsonValue := ConverterStrJSONParaObjectJson(Response);

  Mensagem := JsonValue.GetValue<string>('Message');
  Sucesso := JsonValue.GetValue<Boolean>('Success');
  ErrorCode := JsonValue.GetValue<Integer>('ErrorCode');

  if Mensagem = RetornarMsgResponse.DELETADO_COM_SUCESSO then
  begin
    Status := HTTP_STATUS_SUCESSO;
  end;

  if ErrorCode > ZERO then
  begin
    Status := HTTP_STATUS_ENTIDADE_IMPROCESSAVEL;
  end;

  if ErrorCode = RetornarErrorsCode.ERRO_BANCO_DADOS then
  begin
    Status := HTTP_STATUS_ERRO_INTERNO_SERVIDOR;
  end;

  Res.Send(Response).Status(Status);

  Destroy;
end;

procedure GetClientes(Req: THorseRequest; Res: THorseResponse);
var
  Mensagem, Response, Id, Nome, Documento: string;
  Status, ErrorCode: Integer;
  Sucesso: Boolean;
  JsonValue: TJsonValue;
begin
  InjecaoDependencia;

  Status := HTTP_STATUS_SUCESSO;

  Id := Req.Query['id'];
  Nome := Req.Query['nome'];
  Documento := Req.Query['documento'];

  if Id.IsEmpty then
    Id := ZERO_STR;

  Response := FControllerCliente.Consultar(StrToInt(Id), Nome, Documento);

  JsonValue := ConverterStrJSONParaObjectJson(Response);

  Mensagem := JsonValue.GetValue<string>('Message');
  Sucesso := JsonValue.GetValue<Boolean>('Success');
  ErrorCode := JsonValue.GetValue<Integer>('ErrorCode');

  if Mensagem = RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO then
  begin
    Status := HTTP_STATUS_SUCESSO;
  end;

  if ErrorCode > ZERO then
  begin
    Status := HTTP_STATUS_ENTIDADE_IMPROCESSAVEL;
  end;

  if ErrorCode = RetornarErrorsCode.ERRO_BANCO_DADOS then
  begin
    Status := HTTP_STATUS_ERRO_INTERNO_SERVIDOR;
  end;

  Res.Send(Response).Status(Status);

  Destroy;
end;

procedure Destroy;
begin
  FControllerCliente.Free;
end;

end.
