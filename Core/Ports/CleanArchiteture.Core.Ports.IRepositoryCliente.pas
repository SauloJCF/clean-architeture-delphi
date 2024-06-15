unit CleanArchiteture.Core.Ports.IRepositoryCliente;

interface

uses
  System.Generics.Collections,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.DTO.DTOCliente;

type

  IRepositoryCliente = interface
    ['{93A85824-B126-4EAE-B6AE-B0C70284426F}']
    procedure Cadastrar(const Cliente: TCliente);
    procedure Alterar(const Cliente: TCliente);
    procedure Excluir(const Codigo: Integer);
    function Consultar(const DTO: DTOCliente): TList<TCliente>;
  end;

implementation

end.
