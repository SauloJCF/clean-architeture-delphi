unit CleanArchiteture.Applications.LocacaoConsole.MenuPrincipal;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.DateUtils,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Core.Ports.IRepositoryVeiculo,
  CleanArchiteture.Core.Ports.IRepositoryLocacao,
  CleanArchiteture.Repository.RepositoryCliente,
  CleanArchiteture.Repository.RepositoryVeiculo,
  CleanArchiteture.Repository.RepositoryLocacao,
  CleanArchiteture.Controllers.ControllerCliente,
  CleanArchiteture.Controllers.ControllerVeiculo,
  CleanArchiteture.Controllers.ControllerLocacao,
  CleanArchiteture.Presenters.IPresenter,
  CleanArchiteture.Presenters.PresenterStr;

var
  FControllerCliente: TControllerCliente;
  FControllerVeiculo: TControllerVeiculo;
  FControllerLocacao: TControllerLocacao;

  FRepositoryCliente: IRepositoryCliente;
  FRepositoryVeiculo: IRepositoryVeiculo;
  FRepositoryLocacao: IRepositoryLocacao;

  FPresenter: IPresenter;

procedure InjecaoDependencia;

procedure Destroy;

procedure Menu;

// Módulo de Clientes

procedure MenuCliente;

procedure CadastrarCliente;

procedure AlterarCliente;

procedure ExcluirCliente;

procedure ConsultarCliente;

// Módulo de Veículos

procedure MenuVeiculo;

procedure CadastrarVeiculo;

procedure AlterarVeiculo;

procedure ExcluirVeiculo;

procedure ConsultarVeiculo;

// Módulo de Locação

procedure MenuLocacao;

procedure CadastrarLocacao;

procedure AlterarLocacao;

procedure ExcluirLocacao;

procedure ConsultarLocacao;

procedure Clear;

function Modulos: String;

implementation

procedure Menu;
var
  Codigo: Integer;
  Modulo: String;
begin
  Clear;

  Writeln('Menu Principal');
  Writeln;
  Modulo := '1 - Clientes' + #13#10 + '2 - Veículos' + #13#10 +
    '3 - Locações' + #13#10;
  Writeln(Modulo);
  write(Output, 'Opção:');
  readln(Input, Codigo);

  case Codigo of
    1:
      MenuCliente;
    2:
      MenuVeiculo;
    3:
      MenuLocacao;
  end;
end;

procedure InjecaoDependencia;
begin
  FRepositoryCliente := TRepositoryCliente.Create;
  FRepositoryVeiculo := TRepositoryVeiculo.Create;
  FRepositoryLocacao := TRepositoryLocacao.Create(FRepositoryCliente,
    FRepositoryVeiculo);

  FPresenter := TPresenterStr.Create;

  FControllerCliente := TControllerCliente.Create(FRepositoryCliente,
    FPresenter);
  FControllerVeiculo := TControllerVeiculo.Create(FRepositoryVeiculo,
    FPresenter);
  FControllerLocacao := TControllerLocacao.Create(FRepositoryLocacao,
    FRepositoryCliente, FRepositoryVeiculo, FPresenter);

end;

procedure MenuCliente;
var
  Codigo: Integer;
begin
  Clear;

  Writeln('Menu Clientes');
  Writeln;
  Writeln(Modulos);
  write(Output, 'Opção:');
  readln(Input, Codigo);

  case Codigo of
    1:
      CadastrarCliente;
    2:
      AlterarCliente;
    3:
      ExcluirCliente;
    4:
      ConsultarCliente;
    5:
      Menu
  else
    Writeln('Opção Inválida!');
  end;
end;

procedure CadastrarCliente;
var
  Nome, Documento, Cep, Logradouro, Numero, Complemento, Bairro, Cidade, Uf,
    Telefone, Response: string;
begin
  Clear;
  Writeln('Cadastro de Clientes');

  Writeln;

  Write('Nome: ');
  readln(Input, Nome);

  Write('Documento: ');
  readln(Input, Documento);

  Write('Cep: ');
  readln(Input, Cep);

  Write('Logradouro: ');
  readln(Input, Logradouro);

  Write('Número: ');
  readln(Input, Numero);

  Write('Complemento: ');
  readln(Input, Complemento);

  Write('Bairro: ');
  readln(Input, Bairro);

  Write('Cidade: ');
  readln(Input, Cidade);

  Write('Uf: ');
  readln(Input, Uf);

  Write('Telefone: ');
  readln(Input, Telefone);

  Writeln;

  Writeln('Resultado');

  Writeln;

  Response := FControllerCliente.Cadastrar(Nome, Documento, Cep, Logradouro,
    Numero, Complemento, Bairro, Cidade, Uf, Telefone);

  Writeln(Response);

  readln;
  Menu;
end;

procedure AlterarCliente;
var
  Id: Integer;
  Nome, Documento, Cep, Logradouro, Numero, Complemento, Bairro, Cidade, Uf,
    Telefone, Response: string;
begin
  Clear;
  Writeln('Alterar Clientes');

  Writeln;

  Write('ID: ');
  readln(Input, Id);

  Write('Nome: ');
  readln(Input, Nome);

  Write('Documento: ');
  readln(Input, Documento);

  Write('Cep: ');
  readln(Input, Cep);

  Write('Logradouro: ');
  readln(Input, Logradouro);

  Write('Número: ');
  readln(Input, Numero);

  Write('Complemento: ');
  readln(Input, Complemento);

  Write('Bairro: ');
  readln(Input, Bairro);

  Write('Cidade: ');
  readln(Input, Cidade);

  Write('Uf: ');
  readln(Input, Uf);

  Write('Telefone: ');
  readln(Input, Telefone);

  Writeln;

  Writeln('Resultado');

  Writeln;

  Response := FControllerCliente.Alterar(Id, Nome, Documento, Cep, Logradouro,
    Numero, Complemento, Bairro, Cidade, Uf, Telefone);

  Writeln(Response);

  readln;
  Menu;
end;

procedure ExcluirCliente;
var
  Id: Integer;
  Response: String;
begin
  Clear;
  Writeln('Excluir Clientes');
  Writeln;

  Write('ID: ');
  readln(Input, Id);

  Writeln;

  Writeln('Resultado');

  Writeln;

  Response := FControllerCliente.Deletar(Id);

  Writeln(Response);

  readln;
  Menu;
end;

procedure ConsultarCliente;
var
  Id: Integer;
  Nome, Documento, Response: String;
begin
  Clear;
  Writeln('Consulta de Clientes');

  Write('ID: ');
  readln(Input, Id);

  Write('Nome: ');
  readln(Input, Nome);

  Write('Documento: ');
  readln(Input, Documento);

  Writeln;

  Writeln('Resultado');

  Writeln;

  Response := FControllerCliente.Consultar(Id, Nome, Documento);

  Writeln(Response);

  readln;
  Menu;
end;

procedure MenuVeiculo;
var
  Codigo: Integer;
begin
  Clear;

  Writeln('Menu Veículos');
  Writeln;
  Writeln(Modulos);
  write(Output, 'Opção:');
  readln(Input, Codigo);

  case Codigo of
    1:
      CadastrarVeiculo;
    2:
      AlterarVeiculo;
    3:
      ExcluirVeiculo;
    4:
      ConsultarVeiculo;
    5:
      Menu
  else
    Writeln('Opção Inválida!');
  end;
end;

procedure CadastrarVeiculo;
var
  Nome, Placa, Response: string;
  Valor: Double;
begin
  Clear;
  Writeln('Cadastro de Veículos');

  Writeln;

  Write('Nome: ');
  readln(Input, Nome);

  Write('Placa: ');
  readln(Input, Placa);

  Write('Valor: ');
  readln(Input, Valor);

  Writeln;

  Writeln('Resultado');

  Writeln;

  Response := FControllerVeiculo.Cadastrar(Nome, Placa, Valor);

  Writeln(Response);

  readln;
  Menu;
end;

procedure AlterarVeiculo;
var
  Nome, Placa, Status, Response: string;
  Valor: Double;
  Id: Integer;
begin
  Clear;
  Writeln('Alterar Veículos');
  Writeln;

  Write('ID: ');
  readln(Input, Id);

  Write('Nome: ');
  readln(Input, Nome);

  Write('Placa: ');
  readln(Input, Placa);

  Write('Status: ');
  readln(Input, Status);

  Write('Valor: ');
  readln(Input, Valor);

  Writeln;

  Writeln('Resultado');

  Writeln;

  Response := FControllerVeiculo.Alterar(Id, Nome, Placa, Status, Valor);

  Writeln(Response);

  readln;
  Menu;
end;

procedure ExcluirVeiculo;
var
  Id: Integer;
  Response: String;
begin
  Clear;
  Writeln('Excluir Veículos');
  Writeln;

  Writeln('Resultado');

  Writeln;

  Write('ID: ');
  readln(Input, Id);

  Writeln;

  Response := FControllerVeiculo.Deletar(Id);

  Writeln(Response);

  readln;
  Menu;
end;

procedure ConsultarVeiculo;
begin
  Clear;
  Writeln('Consulta de Veículos');
  readln;
  Menu;
end;

procedure MenuLocacao;
var
  Codigo: Integer;
begin
  Clear;

  Writeln('Menu Locação');
  Writeln;
  Writeln(Modulos);
  write(Output, 'Opção:');
  readln(Input, Codigo);

  case Codigo of
    1:
      CadastrarLocacao;
    2:
      AlterarLocacao;
    3:
      ExcluirLocacao;
    4:
      ConsultarLocacao;
    5:
      Menu
  else
    Writeln('Opção Inválida!');
  end;
end;

procedure CadastrarLocacao;
begin
  Clear;
  Writeln('Cadastro de Locação');
  readln;
  Menu;
end;

procedure AlterarLocacao;
begin
  Clear;
  Writeln('Alterar Locação');
  readln;
  Menu;
end;

procedure ExcluirLocacao;
begin
  Clear;
  Writeln('Excluir Locação');
  readln;
  Menu;
end;

procedure ConsultarLocacao;
begin
  Clear;
  Writeln('Consulta de Locação');
  readln;
  Menu;
end;

procedure Clear;
var
  stdout: THandle;
  csbi: TConsoleScreenBufferInfo;
  ConsoleSize: DWORD;
  NumWritten: DWORD;
  Origin: TCoord;
begin
  stdout := GetStdHandle(STD_OUTPUT_HANDLE);
  Win32Check(stdout <> INVALID_HANDLE_VALUE);
  Win32Check(GetConsoleScreenBufferInfo(stdout, csbi));
  ConsoleSize := csbi.dwSize.X * csbi.dwSize.Y;
  Origin.X := 0;
  Origin.Y := 0;
  Win32Check(FillConsoleOutputCharacter(stdout, ' ', ConsoleSize, Origin,
    NumWritten));
  Win32Check(FillConsoleOutputAttribute(stdout, csbi.wAttributes, ConsoleSize,
    Origin, NumWritten));
  Win32Check(SetConsoleCursorPosition(stdout, Origin));
end;

function Modulos: String;
begin
  Result := '1 - Cadastrar' + #13#10 + '2 - Alterar' + #13#10 + '3 - Excluir' +
    #13#10 + '4 - Consultar' + #13#10 + '5 - Voltar' + #13#10;
end;

procedure Destroy;
begin
  FControllerCliente.Free;
  FControllerVeiculo.Free;
  FControllerLocacao.Free;
end;

end.
