unit CleanArchiteture.Core.Ports.IUseCaseVeiculo;

interface

uses
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.DTO.DTOVeiculo;

type
  IUseCaseVeiculo = interface
    ['{3295A721-44EF-4A61-AFB1-1BB94507E3E3}']

    function Cadastrar(const Veiculo: TVeiculo): TResponse;
    function Alterar(const Veiculo: TVeiculo): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DTOVeiculo): TResponse;
  end;

implementation

end.
