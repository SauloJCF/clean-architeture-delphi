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
    FUseCaseVeiculo: IUseCaseVeiculo;
    FVeiculo: TVeiculo;

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

procedure TTestUseCaseVeiculo.Setup;
begin
  FVeiculo := TVeiculo.Create;

  FRepositoryVeiculo := TRepositoryVeiculo.Create;

  FUseCaseVeiculo := TUseCaseVeiculo.Create(FRepositoryVeiculo);
end;

procedure TTestUseCaseVeiculo.TearDown;
begin
  FVeiculo.Free;
end;

procedure TTestUseCaseVeiculo.ValidarPlacaVeiculo;
var
  Response: TResponse;
begin
  FVeiculo.Nome := 'Fulano de Tal';
  FVeiculo.Placa := EmptyStr;
  FVeiculo.Valor := 10.0;

  Response := FUseCaseVeiculo.Alterar(FVeiculo);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.PLACA_NAO_INFORMADA, Response.ErrorCode);
end;

procedure TTestUseCaseVeiculo.ValidarValorVeiculo;
var
  Response: TResponse;
begin
  FVeiculo.Nome := 'Fulano de Tal';
  FVeiculo.Placa := '123456';
  FVeiculo.Valor := 0.0;

  Response := FUseCaseVeiculo.Alterar(FVeiculo);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.VALOR_INVALIDO, Response.ErrorCode);
end;

procedure TTestUseCaseVeiculo.ValidarNomeVeiculo;
var
  Response: TResponse;
begin
  FVeiculo.Nome := EmptyStr;
  FVeiculo.Placa := '123456';
  FVeiculo.Valor := 10.0;

  Response := FUseCaseVeiculo.Alterar(FVeiculo);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarErrorsCode.NOME_NAO_INFORMADO, Response.ErrorCode);
end;

procedure TTestUseCaseVeiculo.AlterarVeiculo;
var
  Response: TResponse;
begin
  FVeiculo.Nome := 'Fulano de Tal';
  FVeiculo.Placa := '123456';
  FVeiculo.Valor := 10.0;
  FVeiculo.Status := Disponivel;

  Response := FUseCaseVeiculo.Alterar(FVeiculo);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.ALTERADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseVeiculo.CadastrarVeiculo;
var
  Response: TResponse;
begin
  FVeiculo.Id := 2;
  FVeiculo.Nome := 'Ciclano Deltrano';
  FVeiculo.Placa := '654321';
  FVeiculo.Valor := 15.0;
  FVeiculo.Status := Alugado;

  Response := FUseCaseVeiculo.Cadastrar(FVeiculo);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CADASTRADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseVeiculo.ConsultaVeiculo;
var
  Response: TResponse;
  Dto: DTOVeiculo;
begin
  Dto.Id := 2;
  Response := FUseCaseVeiculo.Consultar(Dto);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO,
    Response.Message);
end;

procedure TTestUseCaseVeiculo.ExcluirVeiculo;
var
  Response: TResponse;
begin
  Response := FUseCaseVeiculo.Deletar(1);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.DELETADO_COM_SUCESSO, Response.Message);
end;

initialization

TDUnitX.RegisterTestFixture(TTestUseCaseVeiculo);

end.
