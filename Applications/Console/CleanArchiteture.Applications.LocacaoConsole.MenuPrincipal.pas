unit CleanArchiteture.Applications.LocacaoConsole.MenuPrincipal;

interface

uses
  Winapi.Windows, System.SysUtils;

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
begin
  Clear;
  Writeln('Cadastro de Veículos');
  readln;
  Menu;
end;

procedure AlterarVeiculo;
begin
  Clear;
  Writeln('Alterar Veículos');
  readln;
  Menu;
end;

procedure ExcluirVeiculo;
begin
  Clear;
  Writeln('Excluir Veículos');
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
    #13#10 + '4 - Consultar' + #13#10 + '5 - Consultar' + #13#10;
end;

end.
