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
  CleanArchiteture.Core.Utils.Utils,
  CleanArchiteture.Presenters.IPresenter;

type

  TControllerVeiculo = class
  private
    FUseCase: IUseCaseVeiculo;
    FPresenter: IPresenter;
    procedure SetUseCase(const Value: IUseCaseVeiculo);
    procedure SetPresenter(const Value: IPresenter);
  public
    function Cadastrar(const Nome, Placa: string; const Valor: Double): String;
    function Alterar(const Id: Integer; const Nome, Placa, Status: string;
      const Valor: Double): String;
    function Deletar(const Id: Integer): string;
    function Consultar(const Id: Integer; const Nome, Placa: string): string;

    constructor Create(const Repository: IRepositoryVeiculo;
      const Presenter: IPresenter);
    destructor Destroy; override;

    property UseCase: IUseCaseVeiculo read FUseCase write SetUseCase;
    property Presenter: IPresenter read FPresenter write SetPresenter;
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

    Result := FPresenter.ConverterReponse(Response);
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

  Result := FPresenter.ConverterReponse(Response);
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

  Result := FPresenter.ConverterReponse(Response);
end;

constructor TControllerVeiculo.Create(const Repository: IRepositoryVeiculo;
  const Presenter: IPresenter);
begin
  FUseCase := TUseCaseVeiculo.Create(Repository);
  FPresenter := Presenter;
end;

function TControllerVeiculo.Deletar(const Id: Integer): string;
var
  Response: TResponse;
begin
  Response := FUseCase.Deletar(Id);

  Result := FPresenter.ConverterReponse(Response);
end;

destructor TControllerVeiculo.Destroy;
begin

  inherited;
end;

procedure TControllerVeiculo.SetPresenter(const Value: IPresenter);
begin
  FPresenter := Value;
end;

procedure TControllerVeiculo.SetUseCase(const Value: IUseCaseVeiculo);
begin
  FUseCase := Value;
end;

end.
