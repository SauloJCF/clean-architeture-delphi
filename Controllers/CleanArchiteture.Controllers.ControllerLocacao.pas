unit CleanArchiteture.Controllers.ControllerLocacao;

interface

uses
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
  CleanArchiteture.Core.Responses.Response;

type
  TControllerLocacao = class
  private
    FUseCaseCliente: IUseCaseCliente;
    FUseCaseLocacao: IUseCaseLocacao;
    FUseCaseVeiculo: IUseCaseVeiculo;

    procedure SetUseCaseCliente(const Value: IUseCaseCliente);
    procedure SetUseCaseLocacao(const Value: IUseCaseLocacao);
    procedure SetUseCaseVeiculo(const Value: IUseCaseVeiculo);

  public
    function Cadastrar(const IdCliente, IdVeiculo: integer): string;
    function Alterar(const IdLocacao, IdCliente, IdVeiculo: integer;
      const DataDevolucao: TDateTime): String;
    function Deletar(const IdLocacao: integer): String;
    function Consultar(const IdLocaco: integer;
      const DataDevolucao: TDateTime): string;

    constructor Create(const RepositoryLocacao: IRepositoryLocacao;
      const RepositoryCliente: IRepositoryCliente;
      const RepositoryVeiculo: IRepositoryVeiculo);
    destructor Destroy; override;

    property UseCaseLocacao: IUseCaseLocacao read FUseCaseLocacao
      write SetUseCaseLocacao;
    property UseCaseCliente: IUseCaseCliente read FUseCaseCliente
      write SetUseCaseCliente;
    property UseCaseVeiculo: IUseCaseVeiculo read FUseCaseVeiculo
      write SetUseCaseVeiculo;
  end;

implementation

{ TControllerLocacao }

function TControllerLocacao.Alterar(const IdLocacao, IdCliente,
  IdVeiculo: integer; const DataDevolucao: TDateTime): String;
var
  Response: TResponse;
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
    Exit('Id da locação inválido!');
  end;

  Locacao := TLocacao(Response.Data.First);

  if IdCliente > 0 then
  begin
    _DTOCliente.Id := IdCliente;
    Response := FUseCaseCliente.Consultar(_DTOCliente);

    if Response.Success and
      (Response.Message = RetornarMsgResponse.CONSULTA_SEM_RETORNO) then
    begin
      Exit('Id do cliente inválido!');
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
      Exit('Id do veículo inválido!');
    end;

    Veiculo := TVeiculo(Response.Data.First);

    Locacao.Veiculo := Veiculo;
  end;
  Locacao.DataDevolucao := DataDevolucao;

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
    Exit('Id do cliente inválido!');
  end;

  Cliente := TCliente(Response.Data.First);

  _DTOVeiculo.Id := IdVeiculo;

  Response := FUseCaseVeiculo.Consultar(_DTOVeiculo);

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CONSULTA_SEM_RETORNO) then
  begin
    Exit('Id do veículo inválido!');
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

    if ResponseVeiculo.Success then
      Result := 'Cadastrado com sucesso!'
    else
      Result := 'Erro ao alterar status do veículo!';
  end
  else
    Result := 'Erro ao cadastrar!';
end;

function TControllerLocacao.Consultar(const IdLocaco: integer;
  const DataDevolucao: TDateTime): string;
begin

end;

constructor TControllerLocacao.Create(const RepositoryLocacao
  : IRepositoryLocacao; const RepositoryCliente: IRepositoryCliente;
  const RepositoryVeiculo: IRepositoryVeiculo);
begin
  FUseCaseLocacao := TUseCaseLocacao.Create(RepositoryLocacao);
  FUseCaseCliente := TUseCaseCliente.Create(RepositoryCliente);
  FUseCaseVeiculo := TUseCaseVeiculo.Create(RepositoryVeiculo);
end;

function TControllerLocacao.Deletar(const IdLocacao: integer): String;
begin

end;

destructor TControllerLocacao.Destroy;
begin

  inherited;
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
