program LocacaoConsole;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  UMenuPrincipal in 'UMenuPrincipal.pas',
  UCliente in '..\..\Core\Models\UCliente.pas',
  UIUseCaseCliente in '..\..\Core\Ports\UIUseCaseCliente.pas',
  UResponse in '..\..\Core\Responses\UResponse.pas',
  UDTOCliente in '..\..\Core\DTO\UDTOCliente.pas',
  UUseCaseCliente in '..\..\Core\UseCases\UUseCaseCliente.pas',
  UEnums in '..\..\Core\Enums\UEnums.pas',
  UExceptions in '..\..\Core\Exceptions\UExceptions.pas',
  UUtils in '..\..\Core\Utils\UUtils.pas',
  UVeiculo in '..\..\Core\Models\UVeiculo.pas',
  UIUseCaseVeiculo in '..\..\Core\Ports\UIUseCaseVeiculo.pas',
  UDTOVeiculo in '..\..\Core\DTO\UDTOVeiculo.pas',
  UUseCaseVeiculo in '..\..\Core\UseCases\UUseCaseVeiculo.pas',
  ULocacao in '..\..\Core\Models\ULocacao.pas',
  UIUseCaseLocacao in '..\..\Core\Ports\UIUseCaseLocacao.pas',
  UDTOLocacao in '..\..\Core\DTO\UDTOLocacao.pas',
  UUseCaseLocacao in '..\..\Core\UseCases\UUseCaseLocacao.pas',
  UIRepositoryCliente in '..\..\Core\Ports\UIRepositoryCliente.pas',
  UConfiguracaoDB in '..\..\Repository\UConfiguracaoDB.pas',
  URepositoryCliente in '..\..\Repository\URepositoryCliente.pas',
  UIRepositoryVeiculo in '..\..\Core\Ports\UIRepositoryVeiculo.pas',
  URepositoryVeiculo in '..\..\Repository\URepositoryVeiculo.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Menu;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
