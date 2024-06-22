unit CleanArchiteture.Presenters.IPresenter;

interface

uses
  System.Generics.Collections,
  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Models.Cliente;

type
  IPresenter = interface
    ['{AE5268BB-4508-47EF-8D09-3D8113E2E768}']

    function ConverterReponse(const Response: TResponse): string;
    function ConverterCliente(const Cliente: TCliente): string;
    function ConverterLista(const Lista: TList<TObject>): string;
  end;

implementation

end.
