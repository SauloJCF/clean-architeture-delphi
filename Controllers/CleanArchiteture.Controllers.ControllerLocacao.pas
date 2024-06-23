unit CleanArchiteture.Controllers.ControllerLocacao;

interface

uses
  System.SysUtils,
  CleanArchiteture.Core.Models.Locacao,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.DTO.DTOLocacao,
  CleanArchiteture.Core.DTO.DTOCliente,
  CleanArchiteture.Core.DTO.DTOVeiculo,
  CleanArchiteture.Core.Ports.IRepositoryLocacao,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Core.Ports.IRepositoryVeiculo,
  CleanArchiteture.Core.Ports.IUseCaseLocacao,
  CleanArchiteture.Core.Ports.IUseCaseCliente,
  CleanArchiteture.Core.Ports.IUseCaseVeiculo,
  CleanArchiteture.Core.UseCases.UseCaseLocacao,
  CleanArchiteture.Core.UseCases.UseCaseCliente,
  CleanArchiteture.Core.UseCases.UseCaseVeiculo,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Utils.Utils,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Presenters.IPresenter;

const
  MSG_ERRO_ATUALIZAR_STATUS_VEICULO = 'Erro ao atualizar status veículo!';
  DATA_VAZIA = '30/12/1899';
  MSG_ID_VEICULO_INVALIDO = 'Id do veículo inválido!';
  MSG_ID_CLIENTE_INVALIDO = 'Id do cliente inválido!';
  MSG_ID_LOCACAO_INVALIDO = 'Id da locação inválido!';

type
  TControllerLocacao = class
  private
    FUseCaseCliente: IUseCaseCliente;
    FUseCaseLocacao: IUseCaseLocacao;
    FUseCaseVeiculo: IUseCaseVeiculo;
    FPresenter: IPresenter;

    procedure SetUseCaseCliente(const Value: IUseCaseCliente);
    procedure SetUseCaseLocacao(const Value: IUseCaseLocacao);
    procedure SetUseCaseVeiculo(const Value: IUseCaseVeiculo);
    procedure SetPresenter(const Value: IPresenter);

  public
    function Cadastrar(const IdCliente, IdVeiculo: integer): string;
    function Alterar(const IdLocacao, IdCliente, IdVeiculo: integer;
      const DataDevolucao: TDateTime): String;
    function Deletar(const IdLocacao: integer): String;
    function Consultar(const IdLocacao, IdCliente: integer;
      const DataLocacao, DataDevolucao: TDateTime): string;

    constructor Create(const RepositoryLocacao: IRepositoryLocacao;
      const RepositoryCliente: IRepositoryCliente;
      const RepositoryVeiculo: IRepositoryVeiculo; const Presenter: IPresenter);
    destructor Destroy; override;

    property UseCaseLocacao: IUseCaseLocacao read FUseCaseLocacao
      write SetUseCaseLocacao;
    property UseCaseCliente: IUseCaseCliente read FUseCaseCliente
      write SetUseCaseCliente;
    property UseCaseVeiculo: IUseCaseVeiculo read FUseCaseVeiculo
      write SetUseCaseVeiculo;
    property Presenter: IPresenter read FPresenter write SetPresenter;
  end;

implementation

{ TControllerLocacao }

function TControllerLocacao.Alterar(const IdLocacao, IdCliente,
  IdVeiculo: integer; const DataDevolucao: TDateTime): String;
var
  Response, ResponseVeiculo: TResponse;
  Cliente: TCliente;
  Veiculo: TVeiculo;
  Locacao: TLocacao;
  _DTOCliente: DTOCliente;
  _DTOVeiculo: DTOVeiculo;
  _DTOLocacao: DTOLocacao;
begin
  _DTOLocacao.Id := IdLocacao;

  Response := FUseCaseLocacao.Consultar(_DTOLocacao);

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CONSULTA_SEM_RETORNO) then
  begin
    Response.Message := MSG_ID_LOCACAO_INVALIDO;
    Response.ErrorCode := RetornarErrorsCode.ID_INVALIDO;
    Exit(FPresenter.ConverterReponse(Response));
  end;

  Locacao := TLocacao(Response.Data.First);

  if IdCliente > 0 then
  begin
    _DTOCliente.Id := IdCliente;
    Response := FUseCaseCliente.Consultar(_DTOCliente);

    if Response.Success and
      (Response.Message = RetornarMsgResponse.CONSULTA_SEM_RETORNO) then
    begin
      Response.Message := MSG_ID_CLIENTE_INVALIDO;
      Response.ErrorCode := RetornarErrorsCode.ID_INVALIDO;
      Exit(FPresenter.ConverterReponse(Response));
    end;

    Cliente := TCliente(Response.Data.First);

    Locacao.Cliente := Cliente;
  end;

  if IdVeiculo > 0 then
  begin
    _DTOVeiculo.Id := IdVeiculo;

    Response := FUseCaseVeiculo.Consultar(_DTOVeiculo);

    if Response.Success and
      (Response.Message = RetornarMsgResponse.CONSULTA_SEM_RETORNO) then
    begin
      Response.Message := MSG_ID_VEICULO_INVALIDO;
      Response.ErrorCode := RetornarErrorsCode.ID_INVALIDO;
      Exit(FPresenter.ConverterReponse(Response));
    end;

    Veiculo := TVeiculo(Response.Data.First);

    Locacao.Veiculo := Veiculo;
  end;

  if DataDevolucao <> StrToDate(DATA_VAZIA) then
    Locacao.DataDevolucao := DataDevolucao;

  Response := FUseCaseLocacao.Alterar(Locacao);

  if Response.Success then
  begin
    if Locacao.Veiculo.Id <> Locacao.VeiculoAtual.Id then
    begin
      Locacao.VeiculoAtual.Status := Disponivel;
      ResponseVeiculo := FUseCaseVeiculo.Alterar(Locacao.VeiculoAtual);

      if not ResponseVeiculo.Success and
        not(ResponseVeiculo.Message = RetornarMsgResponse.ALTERADO_COM_SUCESSO)
      then
      begin
        ResponseVeiculo.Message := MSG_ERRO_ATUALIZAR_STATUS_VEICULO;
        ResponseVeiculo.ErrorCode := RetornarErrorsCode.ERRO_BANCO_DADOS;
        Exit(FPresenter.ConverterReponse(ResponseVeiculo));
      end;

      Locacao.Veiculo.Status := Alugado;
      ResponseVeiculo := FUseCaseVeiculo.Alterar(Locacao.Veiculo);

      if not ResponseVeiculo.Success and
        not(ResponseVeiculo.Message = RetornarMsgResponse.ALTERADO_COM_SUCESSO)
      then
      begin
        ResponseVeiculo.Message := MSG_ERRO_ATUALIZAR_STATUS_VEICULO;
        ResponseVeiculo.ErrorCode := RetornarErrorsCode.ERRO_BANCO_DADOS;
        Exit(FPresenter.ConverterReponse(ResponseVeiculo));
      end;
    end;
  end;

  Result := FPresenter.ConverterReponse(Response);
end;

function TControllerLocacao.Cadastrar(const IdCliente,
  IdVeiculo: integer): string;
var
  Response, ResponseVeiculo: TResponse;
  Cliente: TCliente;
  Veiculo: TVeiculo;
  Locacao: TLocacao;
  _DTOCliente: DTOCliente;
  _DTOVeiculo: DTOVeiculo;
begin
  _DTOCliente.Id := IdCliente;

  Response := FUseCaseCliente.Consultar(_DTOCliente);

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CONSULTA_SEM_RETORNO) then
  begin
    Response.Message := MSG_ID_CLIENTE_INVALIDO;
    Response.ErrorCode := RetornarErrorsCode.ID_INVALIDO;
    Exit(FPresenter.ConverterReponse(Response));
  end;

  Cliente := TCliente(Response.Data.First);

  _DTOVeiculo.Id := IdVeiculo;

  Response := FUseCaseVeiculo.Consultar(_DTOVeiculo);

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CONSULTA_SEM_RETORNO) then
  begin
    Response.Message := MSG_ID_VEICULO_INVALIDO;
    Response.ErrorCode := RetornarErrorsCode.ID_INVALIDO;
    Exit(FPresenter.ConverterReponse(Response));
  end;

  Veiculo := TVeiculo(Response.Data.First);

  Locacao := TLocacao.Create;

  Locacao.Cliente := Cliente;
  Locacao.Veiculo := Veiculo;

  Response := FUseCaseLocacao.Cadastrar(Locacao);

  Locacao.Free;

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CADASTRADO_COM_SUCESSO) then
  begin
    Veiculo.Status := Alugado;

    ResponseVeiculo := FUseCaseVeiculo.Alterar(Veiculo);

    if not ResponseVeiculo.Success and
      not(ResponseVeiculo.Message = RetornarMsgResponse.ALTERADO_COM_SUCESSO)
    then
    begin
      ResponseVeiculo.Message := MSG_ERRO_ATUALIZAR_STATUS_VEICULO;
      ResponseVeiculo.ErrorCode := RetornarErrorsCode.ERRO_BANCO_DADOS;
      Exit(FPresenter.ConverterReponse(ResponseVeiculo));
    end;
  end;

  Result := FPresenter.ConverterReponse(Response);
end;

function TControllerLocacao.Consultar(const IdLocacao, IdCliente: integer;
  const DataLocacao, DataDevolucao: TDateTime): string;
var
  Response: TResponse;
  DTO: DTOLocacao;
begin
  DTO.Id := IdLocacao;
  DTO.ClienteId := IdCliente;
  DTO.DataLocacao := DataLocacao;
  DTO.DataDevolucao := DataDevolucao;

  Response := FUseCaseLocacao.Consultar(DTO);

  Result := FPresenter.ConverterReponse(Response);
end;

constructor TControllerLocacao.Create(const RepositoryLocacao
  : IRepositoryLocacao; const RepositoryCliente: IRepositoryCliente;
  const RepositoryVeiculo: IRepositoryVeiculo; const Presenter: IPresenter);
begin
  FUseCaseLocacao := TUseCaseLocacao.Create(RepositoryLocacao);
  FUseCaseCliente := TUseCaseCliente.Create(RepositoryCliente);
  FUseCaseVeiculo := TUseCaseVeiculo.Create(RepositoryVeiculo);
  FPresenter := Presenter;
end;

function TControllerLocacao.Deletar(const IdLocacao: integer): String;
var
  Response: TResponse;
  _DTOLocacao: DTOLocacao;
begin
  _DTOLocacao.Id := IdLocacao;

  Response := FUseCaseLocacao.Consultar(_DTOLocacao);

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CONSULTA_SEM_RETORNO) then
  begin
    Response.Message := MSG_ID_LOCACAO_INVALIDO;
    Response.ErrorCode := RetornarErrorsCode.ID_INVALIDO;
    Exit(FPresenter.ConverterReponse(Response));
  end;

  Response := FUseCaseLocacao.Deletar(IdLocacao);

  Result := FPresenter.ConverterReponse(Response);
end;

destructor TControllerLocacao.Destroy;
begin

  inherited;
end;

procedure TControllerLocacao.SetPresenter(const Value: IPresenter);
begin
  FPresenter := Value;
end;

procedure TControllerLocacao.SetUseCaseCliente(const Value: IUseCaseCliente);
begin
  FUseCaseCliente := Value;
end;

procedure TControllerLocacao.SetUseCaseLocacao(const Value: IUseCaseLocacao);
begin
  FUseCaseLocacao := Value;
end;

procedure TControllerLocacao.SetUseCaseVeiculo(const Value: IUseCaseVeiculo);
begin
  FUseCaseVeiculo := Value;
end;

end.
