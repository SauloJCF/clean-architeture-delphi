unit UControllerCliente;

interface

uses
  UIRepositoryCliente,
  UIUseCaseCliente,
  UUseCaseCliente,
  UResponse,
  UDTOCliente,
  UCliente,
  UEnums;

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
  _dtoCliente: DtoCliente;
begin
  _dtoCliente.Id := Id;

  Response := FUseCase.Consultar(_dtoCliente);

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
