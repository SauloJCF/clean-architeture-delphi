unit UUseCaseVeiculo;

interface

uses
  UVeiculo,
  UResponse,
  UDTOVeiculo,
  UIUseCaseVeiculo;

type
TUseCaseVeiculo = class(TInterfacedObject, IUseCaseVeiculo)
    ['{3295A721-44EF-4A61-AFB1-1BB94507E3E3}']

    function Cadastrar(const Veiculo: TVeiculo): TResponse;
    function Alterar(const Veiculo: TVeiculo): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DTOVeiculo): TResponse;
  end;

implementation

{ TUseCaseVeiculo }

function TUseCaseVeiculo.Alterar(const Veiculo: TVeiculo): TResponse;
begin

end;

function TUseCaseVeiculo.Cadastrar(const Veiculo: TVeiculo): TResponse;
begin

end;

function TUseCaseVeiculo.Consultar(const Dto: DTOVeiculo): TResponse;
begin

end;

function TUseCaseVeiculo.Deletar(const Id: Integer): TResponse;
begin

end;

end.
