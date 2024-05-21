unit UTestUseCaseVeiculo;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  UUseCaseVeiculo,
  UEnums,
  UResponse,
  UVeiculo,
  UIUseCaseVeiculo,
  UDTOVeiculo,
  UUtils;

type

  [TestFixture]
  TTestUseCaseVeiculo = class
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure CadastrarCliente;

    [Test]
    procedure AlterarVeiculo;

    [Test]
    procedure ValidarNomeVeiculo;

    [Test]
    procedure ValidarPlacaVeiculo;

    [Test]
    procedure ValidarValorVeiculo;
  end;

implementation

var
  UseCaseVeiculo: IUseCaseVeiculo;
  Veiculo: TVeiculo;

procedure TTestUseCaseVeiculo.Setup;
begin
  Veiculo := TVeiculo.Create;
  UseCaseVeiculo := TUseCaseVeiculo.Create;
end;

procedure TTestUseCaseVeiculo.TearDown;
begin
  Veiculo.Free;
end;

procedure TTestUseCaseVeiculo.ValidarPlacaVeiculo;
var
  Response: TResponse;
begin
  Veiculo.Nome := 'Fulano de Tal';
  Veiculo.Placa := EmptyStr;
  Veiculo.Valor := 10.0;

  Response := UseCaseVeiculo.Alterar(Veiculo);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.PLACA_NAO_INFORMADA, Response.ErrorCode);
end;

procedure TTestUseCaseVeiculo.ValidarValorVeiculo;
var
  Response: TResponse;
begin
  Veiculo.Nome := 'Fulano de Tal';
  Veiculo.Placa := '123456';
  Veiculo.Valor := 0.0;

  Response := UseCaseVeiculo.Alterar(Veiculo);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.VALOR_INVALIDO, Response.ErrorCode);
end;

procedure TTestUseCaseVeiculo.ValidarNomeVeiculo;
var
  Response: TResponse;
begin
  Veiculo.Nome := EmptyStr;
  Veiculo.Placa := '123456';
  Veiculo.Valor := 10.0;

  Response := UseCaseVeiculo.Alterar(Veiculo);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.NOME_NAO_INFORMADO, Response.ErrorCode);
end;

procedure TTestUseCaseVeiculo.AlterarVeiculo;
var
  Response: TResponse;
begin
  Veiculo.Nome := 'Fulano de Tal';
  Veiculo.Placa := '123456';
  Veiculo.Valor := 10.0;

  Response := UseCaseVeiculo.Alterar(Veiculo);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.ALTERADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseVeiculo.CadastrarCliente;
var
  Response: TResponse;
begin
  Veiculo.Nome := 'Fulano de Tal';
  Veiculo.Placa := '123456';
  Veiculo.Valor := 10.0;

  Response := UseCaseVeiculo.Cadastrar(Veiculo);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CADASTRADO_COM_SUCESSO, Response.Message);
end;

initialization

TDUnitX.RegisterTestFixture(TTestUseCaseVeiculo);

end.
