unit CleanArchiteture.Presenters.IPresenter;

interface

uses
  System.Generics.Collections,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.Models.Locacao;

type
  IPresenter = interface
    ['{AE5268BB-4508-47EF-8D09-3D8113E2E768}']

    function ConverterReponse(const Response: TResponse): string;
    function ConverterCliente(const Cliente: TCliente): string;
    function ConverterVeiculo(const Veiculo: TVeiculo): string;
    function ConverterLocacao(const Locacao: TLocacao): string;
    function ConverterLista(const Lista: TList<TObject>): string;
  end;

implementation

end.
