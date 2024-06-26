unit CleanArchiteture.LocacaoAPI.Controllers.Clientes;

interface

uses
  Horse,
  System.JSON,
  System.SysUtils,
  CleanArchiteture.Core.Ports.IUseCaseCliente,
  CleanArchiteture.Core.UseCases.UseCaseCliente,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.DTO.DTOCliente,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Utils.Utils,
  CleanArchiteture.Controllers.ControllerCliente,
  CleanArchiteture.Presenters.IPresenter,
  CleanArchiteture.Presenters.PresenterJSON,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Repository.RepositoryCliente;

const
  HTTP_STATUS_SUCESSO = 200;
  HTTP_STATUS_ERRO_INTERNO_SERVIDOR = 500;
  ZERO = 0;
  HTTP_STATUS_ENTIDADE_IMPROCESSAVEL = 422;
  HTTP_STATUS_CRIACAO = 201;

procedure InjecaoDependencia;
procedure Destroy;

procedure PostCliente(Req: THorseRequest; Res: THorseResponse);
procedure PutCliente(Req: THorseRequest; Res: THorseResponse);

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

  Id := req.Params['id'];

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

  Response := FControllerCliente.Alterar(StrToInt(Id), Nome, Documento, Cep, Logradouro,
    Numero, Complemento, Bairro, Cidade, Uf, Telefone);

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

procedure Destroy;
begin
  FControllerCliente.Free;
end;

end.