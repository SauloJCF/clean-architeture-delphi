unit UIRepositoryLocacao;

interface

uses
  System.Generics.Collections,
  ULocacao,
  UDTOLocacao;

type

  IRepositoryVeiculo = interface
    ['{C60AA142-FAE4-4B5A-A2B2-6140B411C696}']
    procedure Cadastrar(const Locacao: TLocacao);
    procedure Alterar(const Locacao: TLocacao);
    procedure Excluir(const Codigo: Integer);
    function Consultar(const DTO: DTOLocacao): TList<TLocacao>;
  end;

implementation

end.
