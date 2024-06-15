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
  CleanArchiteture.Core.Enums.Enums;

type

  TControllerCliente = class
  private
    FUseCase: IUseCaseCliente;
    procedure SetUseCase(const Value: IUseCaseCliente);
  published
    constructor Create(const Repository: IRepositoryCliente);
    destructor Destroy; Override;

    function Cadastrar(const Nome, Documento, Cep, Logradouro, Numero,
      Complemento, Bairro, Cidade, Uf, Telefone: string): string;

    function Alterar(const Id: Integer; const Nome, Documento, Cep, Logradouro,
      Numero, Complemento, Bairro, Cidade, Uf, Telefone: string): string;

    function Deletar(const Id: Integer): string;

    function Consultar(const Id: Integer;
      const Nome, Documento: string): string;

    property UseCase: IUseCaseCliente read FUseCase write SetUseCase;
  end;

implementation

{ TControllerCliente }

function TControllerCliente.Alterar(const Id: Integer;
  const Nome, Documento, Cep, Logradouro, Numero, Complemento, Bairro, Cidade,
  Uf, Telefone: string): string;
var
  Cliente: TCliente;
  Response: TResponse;
  _dtoCliente: DTOCliente;
begin
  _dtoCliente.Id := Id;
  _dtoCliente.Nome := EmptyStr;
  _dtoCliente.Documento := EmptyStr;

  Response := FUseCase.Consultar(_dtoCliente);

  if Response.Success and
    (Response.Message = RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO) then
  begin
    Cliente := TCliente(Response.Data.First);
  end;

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

  if Response.Success then
    Result := 'Cadastrado com sucesso!'
  else
    Result := 'Erro ao cadastrar!';
end;

function TControllerCliente.Consultar(const Id: Integer;
  const Nome, Documento: string): string;
begin

end;

constructor TControllerCliente.Create(const Repository: IRepositoryCliente);
begin
  FUseCase := TUseCaseCliente.Create(Repository);
end;

function TControllerCliente.Deletar(const Id: Integer): string;
begin

end;

destructor TControllerCliente.Destroy;
begin

  inherited;
end;

procedure TControllerCliente.SetUseCase(const Value: IUseCaseCliente);
begin
  FUseCase := Value;
end;

end.
