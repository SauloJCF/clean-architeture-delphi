unit CleanArchiteture.Core.UseCases.TestUseCaseLocacao;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,

  CleanArchiteture.Core.Models.Locacao,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Utils.Utils,
  CleanArchiteture.Core.Ports.IUseCaseLocacao,
  CleanArchiteture.Core.Ports.IUseCaseCliente,
  CleanArchiteture.Core.Ports.IUseCaseVeiculo,
  CleanArchiteture.Core.UseCases.UseCaseLocacao,
  CleanArchiteture.Core.UseCases.UseCaseCliente,
  CleanArchiteture.Core.UseCases.UseCaseVeiculo,
  CleanArchiteture.Core.DTO.DTOLocacao,
  CleanArchiteture.Core.DTO.DTOCliente,
  CleanArchiteture.Core.DTO.DTOVeiculo,
  CleanArchiteture.Core.Ports.IRepositoryLocacao,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Core.Ports.IRepositoryVeiculo,
  CleanArchiteture.Repository.RepositoryLocacao,
  CleanArchiteture.Repository.RepositoryCliente,
  CleanArchiteture.Repository.RepositoryVeiculo;

type

  [TestFixture]
  TTestUseCaseLocacao = class
  private
    FRepositoryLocacao: IRepositoryLocacao;
    FRepositoryCliente: IRepositoryCliente;
    FRepositoryVeiculo: IRepositoryVeiculo;

    FCliente: TCliente;
    FVeiculo: TVeiculo;
    FLocacao: TLocacao;

    FUseCaseLocacao: IUseCaseLocacao;
    FUseCaseCliente: IUseCaseCliente;
    FUseCaseVeiculo: IUseCaseVeiculo;

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
    procedure DevolverVeiculoLocacao;

    [Test]
    procedure ConsultaLocacao;

    [Test]
    procedure ExcluirCliente;
  end;

implementation

procedure TTestUseCaseLocacao.DevolverVeiculoLocacao;
var
  Response: TResponse;
  _dtoLocacao: DTOLocacao;
begin
  _dtoLocacao.Id := 2;
  _dtoLocacao.ClienteId := 0;

  Response := FUseCaseLocacao.Consultar(_dtoLocacao);

  if (Response.Success) and
    (Response.Message = RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO) then
  begin
    FLocacao := TLocacao(Response.Data.First);
  end;

  FLocacao.DataDevolucao := FLocacao.DataLocacao + 3;

  Response := FUseCaseLocacao.Alterar(FLocacao);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.ALTERADO_COM_SUCESSO, Response.Message);
end;

procedure TTestUseCaseLocacao.CadastrarLocacao;
var
  Response: TResponse;
  _DtoCliente: DTOCliente;
  _DtoVeiculo: DTOVeiculo;
begin
  _DtoCliente.Id := 0;
  _DtoCliente.Documento := '123456';
  Response := FUseCaseCliente.Consultar(_DtoCliente);

  if (Response.Success) and
    (Response.Message = RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO) then
  begin
    FCliente := TCliente(Response.Data.First);
  end;

  _DtoVeiculo.Id := 0;
  _DtoVeiculo.Placa := '654321';

  Response := FUseCaseVeiculo.Consultar(_DtoVeiculo);

  if (Response.Success) and
    (Response.Message = RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO) then
  begin
    FVeiculo := TVeiculo(Response.Data.First);
  end;

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
  Dto: DTOLocacao;
begin
  Dto.Id := 4;
  Response := FUseCaseLocacao.Consultar(Dto);

  Assert.IsTrue(Response.Success);
  Assert.AreEqual(RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO,
    Response.Message);
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

  FRepositoryCliente := TRepositoryCliente.Create;
  FRepositoryVeiculo := TRepositoryVeiculo.Create;

  FRepositoryLocacao := TRepositoryLocacao.Create(FRepositoryCliente,
    FRepositoryVeiculo);

  FUseCaseLocacao := TUseCaseLocacao.Create(FRepositoryLocacao);
  FUseCaseCliente := TUseCaseCliente.Create(FRepositoryCliente);
  FUseCaseVeiculo := TUseCaseVeiculo.Create(FRepositoryVeiculo);
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
