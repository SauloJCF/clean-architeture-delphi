unit CleanArchiteture.Controllers.ControllerVeiculo;

interface

uses
  System.SysUtils,
  CleanArchiteture.Core.Ports.IRepositoryVeiculo,
  CleanArchiteture.Core.Ports.IUseCaseVeiculo,
  CleanArchiteture.Core.UseCases.UseCaseVeiculo,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.DTO.DTOVeiculo,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Utils.Utils;

type

  TControllerVeiculo = class
  private
    FUseCase: IUseCaseVeiculo;
    procedure SetUseCase(const Value: IUseCaseVeiculo);
  public
    function Cadastrar(const Nome, Placa: string; const Valor: Double): String;
    function Alterar(const Id: Integer; const Nome, Placa, Status: string; const
        Valor: Double): String;
    function Deletar(const Id: Integer): string;
    function Consultar(const Id: Integer; const Nome, Placa: string): string;

    constructor Create(const Repository: IRepositoryVeiculo);
    destructor Destroy; override;

    property UseCase: IUseCaseVeiculo read FUseCase write SetUseCase;
  end;

implementation

{ TControllerVeiculo }

function TControllerVeiculo.Alterar(const Id: Integer;
  const Nome, Placa, Status: string; const Valor: Double): String;
var
  Veiculo: TVeiculo;
  Response: TResponse;
  DTO: DTOVeiculo;
begin
  DTO.Id := Id;
  DTO.Nome := EmptyStr;
  DTO.Placa := EmptyStr;

  Response := FUseCase.Consultar(DTO);

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO) then
  begin
    Veiculo := TVeiculo(Response.Data.First);

    if not Nome.IsEmpty then
      Veiculo.Nome := Nome;
    if not Placa.IsEmpty then
      Veiculo.Placa := Placa;
    if not Status.IsEmpty then
      Veiculo.Status := ConverterStrStatus(Status);
    if Valor > 0 then
      Veiculo.Valor := Valor;

    Response := FUseCase.Alterar(Veiculo);

    if Response.Success and
      (Response.Message = RetornarMsgResponse.ALTERADO_COM_SUCESSO) then
      Result := 'Alterado com sucesso!'
    else
      Result := 'Erro ao alterar!';
  end;
end;

function TControllerVeiculo.Cadastrar(const Nome, Placa: string;
  const Valor: Double): String;
var
  Veiculo: TVeiculo;
  Response: TResponse;
begin
  Veiculo := TVeiculo.Create;
  Veiculo.Nome := Nome;
  Veiculo.Placa := Placa;
  Veiculo.Valor := Valor;
  Veiculo.Status := Disponivel;

  Response := FUseCase.Cadastrar(Veiculo);

  Veiculo.Free;

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CADASTRADO_COM_SUCESSO) then
    Result := 'Cadastrado com sucesso!'
  else
    Result := 'Erro ao cadastrar!';

end;

function TControllerVeiculo.Consultar(const Id: Integer;
  const Nome, Placa: string): string;
var
  Response: TResponse;
  DTO: DTOVeiculo;
begin
  DTO.Id := Id;
  DTO.Nome := Nome;
  DTO.Placa := Placa;

  Response := FUseCase.Consultar(DTO);

  if Response.Success then
    Result := Response.Message
  else
    Result := 'Erro ao consultar!';
end;

constructor TControllerVeiculo.Create(const Repository: IRepositoryVeiculo);
begin
  FUseCase := TUseCaseVeiculo.Create(Repository);
end;

function TControllerVeiculo.Deletar(const Id: Integer): string;
var
  Response: TResponse;
begin
  Response := FUseCase.Deletar(Id);

  if Response.Success and
    (Response.Message = RetornarMsgResponse.DELETADO_COM_SUCESSO) then
    Result := 'Excluído com sucesso!'
  else
    Result := 'Erro ao excluir!';
end;

destructor TControllerVeiculo.Destroy;
begin

  inherited;
end;

procedure TControllerVeiculo.SetUseCase(const Value: IUseCaseVeiculo);
begin
  FUseCase := Value;
end;

end.
