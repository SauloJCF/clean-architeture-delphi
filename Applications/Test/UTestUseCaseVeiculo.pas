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
  UUtils,
  UIRepositoryVeiculo,
  URepositoryVeiculo;

type

  [TestFixture]
  TTestUseCaseVeiculo = class
  private
    FRepositoryVeiculo: IRepositoryVeiculo;

  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure CadastrarVeiculo;

    [Test]
    procedure AlterarVeiculo;

    [Test]
    procedure ValidarNomeVeiculo;

    [Test]
    procedure ValidarPlacaVeiculo;

    [Test]
    procedure ValidarValorVeiculo;

    [Test]
    procedure ConsultaVeiculo;

    [Test]
    procedure ExcluirVeiculo;
  end;

implementation

var
  UseCaseVeiculo: IUseCaseVeiculo;
  Veiculo: TVeiculo;

procedure TTestUseCaseVeiculo.Setup;
begin
  Veiculo := TVeiculo.Create;

  FRepositoryVeiculo := TRepositoryVeiculo.Create;

  UseCaseVeiculo := TUseCaseVeiculo.Create(FRepositoryVeiculo);
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
  Veiculo.Status := Disponivel;

  Response := UseCaseVeiculo.Alterar(Veiculo);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.ALTERADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseVeiculo.CadastrarVeiculo;
var
  Response: TResponse;
begin
  Veiculo.Id := 2;
  Veiculo.Nome := 'Ciclano Deltrano';
  Veiculo.Placa := '654321';
  Veiculo.Valor := 15.0;
  Veiculo.Status := Alugado;

  Response := UseCaseVeiculo.Cadastrar(Veiculo);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CADASTRADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseVeiculo.ConsultaVeiculo;
var
  Response: TResponse;
  Dto: DTOVeiculo;
begin
  Dto.Id := 2;
  Response := UseCaseVeiculo.Consultar(Dto);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO,
    Response.Message);
end;

procedure TTestUseCaseVeiculo.ExcluirVeiculo;
var
  Response: TResponse;
begin
  Response := UseCaseVeiculo.Deletar(1);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.DELETADO_COM_SUCESSO, Response.Message);
end;

initialization

TDUnitX.RegisterTestFixture(TTestUseCaseVeiculo);

end.
