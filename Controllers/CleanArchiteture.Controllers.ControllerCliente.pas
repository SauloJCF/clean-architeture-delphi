unit CleanArchiteture.Controllers.ControllerCliente;

interface

uses
  System.SysUtils,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Core.Ports.IUseCaseCliente,
  CleanArchiteture.Core.UseCases.UseCaseCliente,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.DTO.DTOCliente,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Presenters.IPresenter;

type

  TControllerCliente = class
  private
    FUseCase: IUseCaseCliente;
    FPresenter: IPresenter;
    procedure SetUseCase(const Value: IUseCaseCliente);
    procedure SetPresenter(const Value: IPresenter);
  public
    constructor Create(const Repository: IRepositoryCliente;
      const Presenter: IPresenter);
    destructor Destroy; Override;

    function Cadastrar(const Nome, Documento, Cep, Logradouro, Numero,
      Complemento, Bairro, Cidade, Uf, Telefone: string): string;

    function Alterar(const Id: Integer; const Nome, Documento, Cep, Logradouro,
      Numero, Complemento, Bairro, Cidade, Uf, Telefone: string): string;

    function Deletar(const Id: Integer): string;

    function Consultar(const Id: Integer;
      const Nome, Documento: string): string;

    property UseCase: IUseCaseCliente read FUseCase write SetUseCase;
    property Presenter: IPresenter read FPresenter write SetPresenter;
  end;

implementation

{ TControllerCliente }

function TControllerCliente.Alterar(const Id: Integer;
  const Nome, Documento, Cep, Logradouro, Numero, Complemento, Bairro, Cidade,
  Uf, Telefone: string): string;
var
  Cliente: TCliente;
  Response: TResponse;
  DTO: DTOCliente;
begin
  DTO.Id := Id;
  DTO.Nome := EmptyStr;
  DTO.Documento := EmptyStr;

  Response := FUseCase.Consultar(DTO);

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO) then
  begin
    Cliente := TCliente(Response.Data.First);

    if not Nome.IsEmpty then
      Cliente.Nome := Nome;

    if not Documento.IsEmpty then
      Cliente.Documento := Documento;

    if not Cep.IsEmpty then
      Cliente.Cep := Cep;

    if not Logradouro.IsEmpty then
      Cliente.Logradouro := Logradouro;

    if not Numero.IsEmpty then
      Cliente.Numero := Numero;

    if not Complemento.IsEmpty then
      Cliente.Complemento := Complemento;

    if not Bairro.IsEmpty then
      Cliente.Bairro := Bairro;

    if not Cidade.IsEmpty then
      Cliente.Cidade := Cidade;

    if not Uf.IsEmpty then
      Cliente.Uf := Uf;

    if not Telefone.IsEmpty then
      Cliente.Telefone := Telefone;

    Response := FUseCase.Alterar(Cliente);

    Result := FPresenter.ConverterReponse(Response);
  end;
end;

function TControllerCliente.Cadastrar(const Nome, Documento, Cep, Logradouro,
  Numero, Complemento, Bairro, Cidade, Uf, Telefone: string): string;
var
  Cliente: TCliente;
  Response: TResponse;
begin
  Cliente := TCliente.Create;
  Cliente.Nome := Nome;
  Cliente.Documento := Documento;
  Cliente.Cep := Cep;
  Cliente.Logradouro := Logradouro;
  Cliente.Numero := Numero;
  Cliente.Complemento := Complemento;
  Cliente.Bairro := Bairro;
  Cliente.Cidade := Cidade;
  Cliente.Uf := Uf;
  Cliente.Telefone := Telefone;

  Response := FUseCase.Cadastrar(Cliente);

  Cliente.Free;

  Result := FPresenter.ConverterReponse(Response);
end;

function TControllerCliente.Consultar(const Id: Integer;
  const Nome, Documento: string): string;
var
  Response: TResponse;
  DTO: DTOCliente;
begin
  DTO.Id := Id;
  DTO.Nome := Nome;
  DTO.Documento := Documento;

  Response := FUseCase.Consultar(DTO);

  Result := FPresenter.ConverterReponse(Response);
end;

constructor TControllerCliente.Create(const Repository: IRepositoryCliente;
  const Presenter: IPresenter);
begin
  FUseCase := TUseCaseCliente.Create(Repository);
  FPresenter := Presenter;
end;

function TControllerCliente.Deletar(const Id: Integer): string;
var
  Response: TResponse;
begin
  Response := FUseCase.Deletar(Id);

  Result := FPresenter.ConverterReponse(Response);
end;

destructor TControllerCliente.Destroy;
begin

  inherited;
end;

procedure TControllerCliente.SetPresenter(const Value: IPresenter);
begin
  FPresenter := Value;
end;

procedure TControllerCliente.SetUseCase(const Value: IUseCaseCliente);
begin
  FUseCase := Value;
end;

end.
