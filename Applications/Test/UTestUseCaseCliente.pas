unit UTestUseCaseCliente;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  UUseCaseCliente,
  UEnums,
  UUtils,
  UResponse,
  UCliente,
  UIUseCaseCliente,
  UDTOCliente,
  UIRepositoryCliente,
  URepositoryCliente;

type

  [TestFixture]
  TTestUseCaseCliente = class
  private
    FRepositoryCliente: IRepositoryCliente;

  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure CadastrarCliente;

    [Test]
    procedure AlterarCliente;

    [Test]
    procedure ValiadarNomeCliente;

    [Test]
    procedure ValiadarDocumentoCliente;

    [Test]
    procedure ConsultaCliente;

    [Test]
    procedure ExcluirCliente;
  end;

implementation

var
  UseCaseCliente: IUseCaseCliente;
  Cliente: TCliente;

procedure TTestUseCaseCliente.Setup;
begin
  Cliente := TCliente.Create;

  FRepositoryCliente := TRepositoryCliente.Create;

  UseCaseCliente := TUseCaseCliente.Create(FRepositoryCliente);
end;

procedure TTestUseCaseCliente.TearDown;
begin
  Cliente.Free;
end;

procedure TTestUseCaseCliente.ValiadarDocumentoCliente;
var
  Response: TResponse;
begin
  Cliente.Nome := 'Fulano de Tal';
  Cliente.Documento := EmptyStr;
  Cliente.Telefone := '(33) 3277-7777';

  Response := UseCaseCliente.Alterar(Cliente);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.DOCUMENTO_NAO_INFORMADO,
    Response.ErrorCode);
end;

procedure TTestUseCaseCliente.ValiadarNomeCliente;
var
  Response: TResponse;
begin
  Cliente.Nome := EmptyStr;
  Cliente.Documento := '123456';
  Cliente.Telefone := '(33) 3277-7777';

  Response := UseCaseCliente.Alterar(Cliente);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.NOME_NAO_INFORMADO, Response.ErrorCode);
end;

procedure TTestUseCaseCliente.AlterarCliente;
var
  Response: TResponse;
begin
  Cliente.Nome := 'Fulano de Tal';
  Cliente.Documento := '123456';
  Cliente.Telefone := '3332777777';
  Cliente.Cep := '56740000';
  Cliente.Logradouro := 'Rua dos Loucos';
  Cliente.Numero := '0';
  Cliente.Complemento := 'Casa';
  Cliente.Bairro := 'Centro';
  Cliente.Cidade := 'Guanhães';
  Cliente.UF := 'MG';
  Cliente.Id := 1;

  Response := UseCaseCliente.Alterar(Cliente);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.ALTERADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseCliente.CadastrarCliente;
var
  Response: TResponse;
begin
  Cliente.Id := 1;
  Cliente.Nome := 'Fulano de Tal';
  Cliente.Documento := '123456';
  Cliente.Telefone := '3332777777';
  Cliente.Cep := '56740000';
  Cliente.Logradouro := 'Rua dos Loucos';
  Cliente.Numero := '0';
  Cliente.Complemento := 'Casa';
  Cliente.Bairro := 'Centro';
  Cliente.Cidade := 'Guanhães';
  Cliente.UF := 'MG';

  Response := UseCaseCliente.Cadastrar(Cliente);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CADASTRADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseCliente.ConsultaCliente;
var
  Response: TResponse;
  Dto: DToCliente;
begin
  Dto.Id := 4;
  Response := UseCaseCliente.Consultar(Dto);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseCliente.ExcluirCliente;
var
  Response: TResponse;
begin
  Response := UseCaseCliente.Deletar(1);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.DELETADO_COM_SUCESSO, Response.Message);
end;

initialization

TDUnitX.RegisterTestFixture(TTestUseCaseCliente);

end.
