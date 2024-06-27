unit CleanArchiteture.LocacaoAPI.Controllers.Veiculos;

interface

uses
  Horse,
  System.JSON,
  System.SysUtils,
  CleanArchiteture.Controllers.ControllerVeiculo,
  CleanArchiteture.Core.Ports.IRepositoryVeiculo,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Utils.Utils,
  CleanArchiteture.Repository.RepositoryVeiculo,
  CleanArchiteture.Presenters.IPresenter,
  CleanArchiteture.Presenters.PresenterJSON,
  CleanArchiteture.LocacaoAPI.Controllers.Consts;

procedure InjecaoDependecia;
procedure Destroy;

procedure PostVeiculo(Req: THorseRequest; Res: THorseResponse);
procedure PutVeiculo(Req: THorseRequest; Res: THorseResponse);

implementation

var
  FRepositoryVeiculo: IRepositoryVeiculo;
  FPresenter: IPresenter;
  FControllerVeiculo: TControllerVeiculo;

procedure InjecaoDependecia;
begin
  FRepositoryVeiculo := TRepositoryVeiculo.Create;
  FPresenter := TPresenterJSON.Create;
  FControllerVeiculo := TControllerVeiculo.Create(FRepositoryVeiculo,
    FPresenter);
end;

procedure Destroy;
begin
  FControllerVeiculo.Free;
end;

procedure PostVeiculo(Req: THorseRequest; Res: THorseResponse);
var
  Nome, Placa, Mensagem, Response: String;
  Valor: Currency;
  ErrorCode, Status: Integer;
  Body: TJsonObject;
  JsonValue: TJsonValue;
  Sucesso: Boolean;
begin
  InjecaoDependecia;

  Status := HTTP_STATUS_SUCESSO;

  Body := Req.Body<TJsonObject>;

  Nome := Body.GetValue<string>('nome');
  Placa := Body.GetValue<string>('placa');
  Valor := Body.GetValue<Currency>('valor');

  Response := FControllerVeiculo.Cadastrar(Nome, Placa, Valor);

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


procedure PutVeiculo(Req: THorseRequest; Res: THorseResponse);
var
  Id, Nome, Placa, Mensagem, StatusVeiculo, Response: String;
  ErrorCode, Status: Integer;
  Valor: Currency;
  Body: TJsonObject;
  JsonValue: TJsonValue;
  Sucesso: Boolean;
begin
  InjecaoDependecia;

  Status := HTTP_STATUS_SUCESSO;

  Id := Req.Params['id'];

  if Id.IsEmpty then
    Id := ZERO_STR;

  Body := Req.Body<TJsonObject>;

  Nome := Body.GetValue<string>('nome');
  Placa := Body.GetValue<string>('placa');
  StatusVeiculo := Body.GetValue<string>('status');
  Valor := Body.GetValue<Double>('valor');

  Response := FControllerVeiculo.Alterar(StrToInt(Id), Nome, Placa, StatusVeiculo, Valor);

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

end.
