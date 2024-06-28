unit CleanArchiteture.LocacaoAPI.Controllers.Locacoes;

interface

uses
  Horse,
  System.JSON,
  System.SysUtils,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Utils.Utils,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Core.Ports.IRepositoryVeiculo,
  CleanArchiteture.Core.Ports.IRepositoryLocacao,
  CleanArchiteture.Controllers.ControllerLocacao,
  CleanArchiteture.Presenters.IPresenter,
  CleanArchiteture.Presenters.PresenterJSON,
  CleanArchiteture.Repository.RepositoryCliente,
  CleanArchiteture.Repository.RepositoryVeiculo,
  CleanArchiteture.Repository.RepositoryLocacao,
  CleanArchiteture.LocacaoAPI.Controllers.Consts;

procedure InjecaoDependencia;
procedure Destroy;

procedure PostLocacao(Req: THorseRequest; Res: THorseResponse);

implementation

var
  FRepositoryCliente: IRepositoryCliente;
  FRepositoryVeiculo: IRepositoryVeiculo;
  FRepositoryLocacao: IRepositoryLocacao;
  FPresenter: IPresenter;
  FControllerLocacao: TControllerLocacao;

procedure InjecaoDependencia;
begin
  FRepositoryCliente := TRepositoryCliente.Create;
  FRepositoryVeiculo := TRepositoryVeiculo.Create;
  FRepositoryLocacao := TRepositoryLocacao.Create(FRepositoryCliente,
    FRepositoryVeiculo);
  FPresenter := TPresenterJSON.Create;
  FControllerLocacao := TControllerLocacao.Create(FRepositoryLocacao,
    FRepositoryCliente, FRepositoryVeiculo, FPresenter);
end;

procedure Destroy;
begin
  FControllerLocacao.Free;
end;

procedure PostLocacao(Req: THorseRequest; Res: THorseResponse);
var
  Body: TJsonObject;
  Sucesso: Boolean;
  JsonValue: TJsonValue;
  IdCliente, IdVeiculo, Status, ErrorCode: Integer;
  Mensagem, Response: string;
begin
  InjecaoDependencia;

  Status := HTTP_STATUS_SUCESSO;

  Body := Req.Body<TJsonObject>;

  IdCliente := Body.GetValue<Integer>('idCliente');
  IdVeiculo := Body.GetValue<Integer>('idVeiculo');

  Response := FControllerLocacao.Cadastrar(IdCliente, IdVeiculo);

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

end.
