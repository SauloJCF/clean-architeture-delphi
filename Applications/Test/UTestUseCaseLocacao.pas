unit UTestUseCaseLocacao;

interface

uses
  System.SysUtils,

  DUnitX.TestFramework,

  ULocacao,
  UVeiculo,
  UCliente,
  UEnums,
  UResponse,
  UUtils,
  UIUseCaseLocacao,
  UUseCaseLocacao,
  UDTOLocacao;

type

  [TestFixture]
  TTestUseCaseLocacao = class
  private
    FCliente: TCliente;
    FVeiculo: TVeiculo;
    FLocacao: TLocacao;

    FUseCaseLocacao: IUseCaseLocacao;

  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure CadastrarLocacao;

    [Test]
    procedure ValidarClienteInformado;

    [Test]
    procedure ValidarVeiculoInformado;

    [Test]
    procedure ValidarVeiculoAlugado;

    [Test]
    procedure AlterarLocacao;

    [Test]
    procedure ConsultaLocacao;

    [Test]
    procedure ExcluirCliente;
  end;

implementation

procedure TTestUseCaseLocacao.AlterarLocacao;
var
  Response: TResponse;
begin
  FCliente.Nome := 'Ciclano Beltrano';
  FCliente.Documento := '87654321';
  FCliente.Telefone := '99999999';

  FVeiculo.Nome := 'Gol Bola';
  FVeiculo.Placa := '7654321';
  FVeiculo.Valor := 200;
  FVeiculo.Status := Disponivel;

  FLocacao.Cliente := FCliente;
  FLocacao.Veiculo := FVeiculo;
  FLocacao.DataLocacao := StrToDate('29/06/2024');

  Response := FUseCaseLocacao.Alterar(FLocacao);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.ALTERADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseLocacao.CadastrarLocacao;
var
  Response: TResponse;
begin
  FCliente.Nome := 'Fulano de Tal';
  FCliente.Documento := '12345678';
  FCliente.Telefone := '3334219878';

  FVeiculo.Nome := 'Fiat Uno';
  FVeiculo.Placa := '1234567';
  FVeiculo.Valor := 100;
  FVeiculo.Status := Disponivel;

  FLocacao.Cliente := FCliente;
  FLocacao.Veiculo := FVeiculo;
  FLocacao.DataLocacao := StrToDate('22/04/2024');

  Response := FUseCaseLocacao.Cadastrar(FLocacao);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CADASTRADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseLocacao.ConsultaLocacao;
var
  Response: TResponse;
  Dto: DToLocacao;
begin
  Dto.Id := 4;
  Response := FUseCaseLocacao.Consultar(Dto);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseLocacao.ExcluirCliente;
var
  Response: TResponse;
begin
  Response := FUseCaseLocacao.Deletar(1);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.DELETADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseLocacao.Setup;
begin
  FCliente := TCliente.Create;
  FVeiculo := TVeiculo.Create;
  FLocacao := TLocacao.Create;
  FUseCaseLocacao := TUseCaseLocacao.Create;
end;

procedure TTestUseCaseLocacao.TearDown;
begin
  FCliente.Free;
  FVeiculo.Free;
  FLocacao.Free;
end;

procedure TTestUseCaseLocacao.ValidarClienteInformado;
var
  Response: TResponse;
begin
  FVeiculo.Nome := 'Fiat Uno';
  FVeiculo.Placa := '1234567';
  FVeiculo.Valor := 100;
  FVeiculo.Status := Disponivel;

  FLocacao.Cliente := nil;
  FLocacao.Veiculo := FVeiculo;
  FLocacao.DataLocacao := StrToDate('22/04/2024');

  Response := FUseCaseLocacao.Cadastrar(FLocacao);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CLIENTE_NAO_INFORMADO, Response.Message);
end;

procedure TTestUseCaseLocacao.ValidarVeiculoAlugado;
var
  Response: TResponse;
begin
  FCliente.Nome := 'Fulano de Tal';
  FCliente.Documento := '12345678';
  FCliente.Telefone := '3334219878';

  FVeiculo.Nome := 'Fiat Uno';
  FVeiculo.Placa := '1234567';
  FVeiculo.Valor := 100;
  FVeiculo.Status := Alugado;

  FLocacao.Cliente := FCliente;
  FLocacao.Veiculo := FVeiculo;
  FLocacao.DataLocacao := StrToDate('22/04/2024');

  Response := FUseCaseLocacao.Cadastrar(FLocacao);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.VEICULO_ALUGADO, Response.Message);
end;

procedure TTestUseCaseLocacao.ValidarVeiculoInformado;
var
  Response: TResponse;
begin
  FCliente.Nome := 'Fulano de Tal';
  FCliente.Documento := '12345678';
  FCliente.Telefone := '3334219878';

  FLocacao.Cliente := FCliente;
  FLocacao.Veiculo := nil;
  FLocacao.DataLocacao := StrToDate('22/04/2024');

  Response := FUseCaseLocacao.Cadastrar(FLocacao);

  Assert.IsFalse(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.VEICULO_NAO_INFORMADO, Response.Message);
end;

initialization

TDUnitX.RegisterTestFixture(TTestUseCaseLocacao);

end.
