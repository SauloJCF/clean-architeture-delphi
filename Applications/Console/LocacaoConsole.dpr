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
  UVeiculo in '..\..\Core\Models\UVeiculo.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Menu;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
