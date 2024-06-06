unit UIRepositoryLocacao;

interface

uses
  System.Generics.Collections,
  ULocacao,
  UDTOLocacao;

type

  IRepositoryLocacao = interface
    ['{9CCB368B-20E3-44C3-A78A-29DBE4552D31}']
    procedure Cadastrar(const Locacao: TLocacao);
    procedure Alterar(const Locacao: TLocacao);
    procedure Excluir(const Codigo: Integer);
    function Consultar(const DTO: DTOLocacao): TList<TLocacao>;
  end;

implementation

end.
