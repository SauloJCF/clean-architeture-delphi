unit CleanArchiteture.Applications.LocacaoConsole.MenuPrincipal;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.DateUtils,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.Models.Locacao,
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

// M�dulo de Clientes

procedure MenuCliente;

procedure CadastrarCliente;

procedure AlterarCliente;

procedure ExcluirCliente;

procedure ConsultarCliente;

// M�dulo de Ve�culos

procedure MenuVeiculo;

procedure CadastrarVeiculo;

procedure AlterarVeiculo;

procedure ExcluirVeiculo;

procedure ConsultarVeiculo;

// M�dulo de Loca��o

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
  Modulo := '1 - Clientes' + #13#10 + '2 - Ve�culos' + #13#10 +
    '3 - Loca��es' + #13#10;
  Writeln(Modulo);
  write(Output, 'Op��o:');
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
  write(Output, 'Op��o:');
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
    Writeln('Op��o Inv�lida!');
  end;
end;

procedure CadastrarCliente;
begin
  Clear;
  Writeln('Cadastro de Clientes');
  readln;
  Menu;
end;

procedure AlterarCliente;
begin
  Clear;
  Writeln('Alterar Clientes');
  readln;
  Menu;
end;

procedure ExcluirCliente;
begin
  Clear;
  Writeln('Excluir Clientes');
  readln;
  Menu;
end;

procedure ConsultarCliente;
begin
  Clear;
  Writeln('Consulta de Clientes');
  readln;
  Menu;
end;

procedure MenuVeiculo;
var
  Codigo: Integer;
begin
  Clear;

  Writeln('Menu Ve�culos');
  Writeln;
  Writeln(Modulos);
  write(Output, 'Op��o:');
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
    Writeln('Op��o Inv�lida!');
  end;
end;

procedure CadastrarVeiculo;
begin
  Clear;
  Writeln('Cadastro de Ve�culos');
  readln;
  Menu;
end;

procedure AlterarVeiculo;
begin
  Clear;
  Writeln('Alterar Ve�culos');
  readln;
  Menu;
end;

procedure ExcluirVeiculo;
begin
  Clear;
  Writeln('Excluir Ve�culos');
  readln;
  Menu;
end;

procedure ConsultarVeiculo;
begin
  Clear;
  Writeln('Consulta de Ve�culos');
  readln;
  Menu;
end;

procedure MenuLocacao;
var
  Codigo: Integer;
begin
  Clear;

  Writeln('Menu Loca��o');
  Writeln;
  Writeln(Modulos);
  write(Output, 'Op��o:');
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
    Writeln('Op��o Inv�lida!');
  end;
end;

procedure CadastrarLocacao;
begin
  Clear;
  Writeln('Cadastro de Loca��o');
  readln;
  Menu;
end;

procedure AlterarLocacao;
begin
  Clear;
  Writeln('Alterar Loca��o');
  readln;
  Menu;
end;

procedure ExcluirLocacao;
begin
  Clear;
  Writeln('Excluir Loca��o');
  readln;
  Menu;
end;

procedure ConsultarLocacao;
begin
  Clear;
  Writeln('Consulta de Loca��o');
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
    #13#10 + '4 - Consultar' + #13#10 + '5 - Consultar' + #13#10;
end;

procedure Destroy;
begin
  FControllerCliente.Free;
  FControllerVeiculo.Free;
  FControllerLocacao.Free;
end;

end.
