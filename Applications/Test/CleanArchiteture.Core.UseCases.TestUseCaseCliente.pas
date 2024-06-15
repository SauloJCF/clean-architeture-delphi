unit CleanArchiteture.Core.UseCases.TestUseCaseCliente;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  CleanArchiteture.Core.UseCases.UseCaseCliente,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Utils.Utils,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Ports.IUseCaseCliente,
  CleanArchiteture.Core.DTO.DTOCliente,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Repository.RepositoryCliente;

type

  [TestFixture]
  TTestUseCaseCliente = class
  private
    FRepositoryCliente: IRepositoryCliente;

    FUseCaseCliente: IUseCaseCliente;
    FCliente: TCliente;

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

procedure TTestUseCaseCliente.Setup;
begin
  FCliente := TCliente.Create;

  FRepositoryCliente := TRepositoryCliente.Create;

  FUseCaseCliente := TUseCaseCliente.Create(FRepositoryCliente);
end;

procedure TTestUseCaseCliente.TearDown;
begin
  FCliente.Free;
end;

procedure TTestUseCaseCliente.ValiadarDocumentoCliente;
var
  Response: TResponse;
begin
  FCliente.Nome := 'Fulano de Tal';
  FCliente.Documento := EmptyStr;
  FCliente.Telefone := '(33) 3277-7777';

  Response := FUseCaseCliente.Alterar(FCliente);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.DOCUMENTO_NAO_INFORMADO,
    Response.ErrorCode);
end;

procedure TTestUseCaseCliente.ValiadarNomeCliente;
var
  Response: TResponse;
begin
  FCliente.Nome := EmptyStr;
  FCliente.Documento := '123456';
  FCliente.Telefone := '(33) 3277-7777';

  Response := FUseCaseCliente.Alterar(FCliente);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.NOME_NAO_INFORMADO, Response.ErrorCode);
end;

procedure TTestUseCaseCliente.AlterarCliente;
var
  Response: TResponse;
begin
  FCliente.Nome := 'Fulano de Tal';
  FCliente.Documento := '123456';
  FCliente.Telefone := '3332777777';
  FCliente.Cep := '56740000';
  FCliente.Logradouro := 'Rua dos Loucos';
  FCliente.Numero := '0';
  FCliente.Complemento := 'Casa';
  FCliente.Bairro := 'Centro';
  FCliente.Cidade := 'Guanhães';
  FCliente.UF := 'MG';
  FCliente.Id := 1;

  Response := FUseCaseCliente.Alterar(FCliente);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.ALTERADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseCliente.CadastrarCliente;
var
  Response: TResponse;
begin
  FCliente.Id := 1;
  FCliente.Nome := 'Fulano de Tal';
  FCliente.Documento := '123456';
  FCliente.Telefone := '3332777777';
  FCliente.Cep := '56740000';
  FCliente.Logradouro := 'Rua dos Loucos';
  FCliente.Numero := '0';
  FCliente.Complemento := 'Casa';
  FCliente.Bairro := 'Centro';
  FCliente.Cidade := 'Guanhães';
  FCliente.UF := 'MG';

  Response := FUseCaseCliente.Cadastrar(FCliente);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CADASTRADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseCliente.ConsultaCliente;
var
  Response: TResponse;
  Dto: DToCliente;
begin
  Dto.Id := 4;
  Response := FUseCaseCliente.Consultar(Dto);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO,
    Response.Message);
end;

procedure TTestUseCaseCliente.ExcluirCliente;
var
  Response: TResponse;
begin
  Response := FUseCaseCliente.Deletar(1);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.DELETADO_COM_SUCESSO, Response.Message);
end;

initialization

TDUnitX.RegisterTestFixture(TTestUseCaseCliente);

end.
