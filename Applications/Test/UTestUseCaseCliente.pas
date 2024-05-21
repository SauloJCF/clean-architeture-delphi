unit UTestUseCaseCliente;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  UUseCaseCliente,
  UEnums,
  UResponse,
  UCliente,
  UIUseCaseCliente,
  UDTOCliente,
  UUtils;

type

  [TestFixture]
  TTestUseCaseCliente = class
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
  end;

implementation

var
  UseCaseCliente: IUseCaseCliente;
  Cliente: TCliente;

procedure TTestUseCaseCliente.Setup;
begin
  Cliente := TCliente.Create;
  UseCaseCliente := TUseCaseCliente.Create;
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
  Assert.AreEqual(RetornarErrorsCode.DOCUMENTO_NAO_INFORMADO, Response.ErrorCode);
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
  Cliente.Telefone := '(33) 3277-7777';

  Response := UseCaseCliente.Alterar(Cliente);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.ALTERADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseCliente.CadastrarCliente;
var
  Response: TResponse;
begin
  Cliente.Nome := 'Fulano de Tal';
  Cliente.Documento := '123456';
  Cliente.Telefone := '(33) 3277-7777';

  Response := UseCaseCliente.Cadastrar(Cliente);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CADASTRADO_COM_SUCESSO, Response.Message);
end;

initialization

TDUnitX.RegisterTestFixture(TTestUseCaseCliente);

end.
