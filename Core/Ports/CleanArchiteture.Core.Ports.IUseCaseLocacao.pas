unit CleanArchiteture.Core.Ports.IUseCaseLocacao;

interface

uses
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Models.Locacao,
  CleanArchiteture.Core.DTO.DTOLocacao;

type
  IUseCaseLocacao = interface
    ['{09B90C73-A007-4767-8530-125B7EBF460D}']

    function Cadastrar(const Locacao: TLocacao): TResponse;
    function Alterar(const Locacao: TLocacao): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DTOLocacao): TResponse;
  end;

implementation

end.
