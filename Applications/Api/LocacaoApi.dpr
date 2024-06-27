program LocacaoApi;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  CleanArchiteture.LocacaoAPI.Server in 'CleanArchiteture.LocacaoAPI.Server.pas',
  CleanArchiteture.LocacaoAPI.Controllers.Clientes in 'Controllers\CleanArchiteture.LocacaoAPI.Controllers.Clientes.pas',
  CleanArchiteture.Controllers.ControllerCliente in '..\..\Controllers\CleanArchiteture.Controllers.ControllerCliente.pas',
  CleanArchiteture.Controllers.ControllerLocacao in '..\..\Controllers\CleanArchiteture.Controllers.ControllerLocacao.pas',
  CleanArchiteture.Controllers.ControllerVeiculo in '..\..\Controllers\CleanArchiteture.Controllers.ControllerVeiculo.pas',
  CleanArchiteture.Core.Enums.Enums in '..\..\Core\Enums\CleanArchiteture.Core.Enums.Enums.pas',
  CleanArchiteture.Core.Exceptions.Exceptions in '..\..\Core\Exceptions\CleanArchiteture.Core.Exceptions.Exceptions.pas',
  CleanArchiteture.Core.Models.Cliente in '..\..\Core\Models\CleanArchiteture.Core.Models.Cliente.pas',
  CleanArchiteture.Core.Models.Locacao in '..\..\Core\Models\CleanArchiteture.Core.Models.Locacao.pas',
  CleanArchiteture.Core.Models.Veiculo in '..\..\Core\Models\CleanArchiteture.Core.Models.Veiculo.pas',
  CleanArchiteture.Core.Ports.IRepositoryCliente in '..\..\Core\Ports\CleanArchiteture.Core.Ports.IRepositoryCliente.pas',
  CleanArchiteture.Core.Ports.IRepositoryLocacao in '..\..\Core\Ports\CleanArchiteture.Core.Ports.IRepositoryLocacao.pas',
  CleanArchiteture.Core.Ports.IRepositoryVeiculo in '..\..\Core\Ports\CleanArchiteture.Core.Ports.IRepositoryVeiculo.pas',
  CleanArchiteture.Core.Ports.IUseCaseCliente in '..\..\Core\Ports\CleanArchiteture.Core.Ports.IUseCaseCliente.pas',
  CleanArchiteture.Core.Ports.IUseCaseLocacao in '..\..\Core\Ports\CleanArchiteture.Core.Ports.IUseCaseLocacao.pas',
  CleanArchiteture.Core.Ports.IUseCaseVeiculo in '..\..\Core\Ports\CleanArchiteture.Core.Ports.IUseCaseVeiculo.pas',
  CleanArchiteture.Core.Responses.Response in '..\..\Core\Responses\CleanArchiteture.Core.Responses.Response.pas',
  CleanArchiteture.Core.UseCases.UseCaseCliente in '..\..\Core\UseCases\CleanArchiteture.Core.UseCases.UseCaseCliente.pas',
  CleanArchiteture.Core.UseCases.UseCaseLocacao in '..\..\Core\UseCases\CleanArchiteture.Core.UseCases.UseCaseLocacao.pas',
  CleanArchiteture.Core.UseCases.UseCaseVeiculo in '..\..\Core\UseCases\CleanArchiteture.Core.UseCases.UseCaseVeiculo.pas',
  CleanArchiteture.Core.Utils.Utils in '..\..\Core\Utils\CleanArchiteture.Core.Utils.Utils.pas',
  CleanArchiteture.Presenters.IPresenter in '..\..\Presenters\CleanArchiteture.Presenters.IPresenter.pas',
  CleanArchiteture.Presenters.PresenterJSON in '..\..\Presenters\CleanArchiteture.Presenters.PresenterJSON.pas',
  CleanArchiteture.Repository.ConfiguracaoDB in '..\..\Repository\CleanArchiteture.Repository.ConfiguracaoDB.pas',
  CleanArchiteture.Repository.RepositoryCliente in '..\..\Repository\CleanArchiteture.Repository.RepositoryCliente.pas',
  CleanArchiteture.Repository.RepositoryLocacao in '..\..\Repository\CleanArchiteture.Repository.RepositoryLocacao.pas',
  CleanArchiteture.Repository.RepositoryVeiculo in '..\..\Repository\CleanArchiteture.Repository.RepositoryVeiculo.pas',
  CleanArchiteture.Core.DTO.DTOCliente in '..\..\Core\DTO\CleanArchiteture.Core.DTO.DTOCliente.pas',
  CleanArchiteture.Core.DTO.DTOLocacao in '..\..\Core\DTO\CleanArchiteture.Core.DTO.DTOLocacao.pas',
  CleanArchiteture.Core.DTO.DTOVeiculo in '..\..\Core\DTO\CleanArchiteture.Core.DTO.DTOVeiculo.pas',
  CleanArchiteture.LocacaoAPI.Routes.Clientes in 'Routes\CleanArchiteture.LocacaoAPI.Routes.Clientes.pas',
  CleanArchiteture.LocacaoAPI.Controllers.Veiculos in 'Controllers\CleanArchiteture.LocacaoAPI.Controllers.Veiculos.pas',
  CleanArchiteture.LocacaoAPI.Controllers.Consts in 'Controllers\CleanArchiteture.LocacaoAPI.Controllers.Consts.pas',
  CleanArchiteture.LocacaoAPI.Routes.Veiculos in 'Routes\CleanArchiteture.LocacaoAPI.Routes.Veiculos.pas';

begin
  try
    Start;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
