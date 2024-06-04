unit UIRepositoryVeiculo;

interface

uses
  System.Generics.Collections,
  UVeiculo,
  UDTOVeiculo;

type

  IRepositoryVeiculo = interface
    ['{C60AA142-FAE4-4B5A-A2B2-6140B411C696}']
    procedure Cadastrar(const Veiculo: TVeiculo);
    procedure Alterar(const Veiculo: TVeiculo);
    procedure Excluir(const Codigo: Integer);
    function Consultar(const DTO: DTOVeiculo): TList<TVeiculo>;
  end;

implementation

end.
