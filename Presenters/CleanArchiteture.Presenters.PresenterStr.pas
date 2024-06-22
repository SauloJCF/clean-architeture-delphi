unit CleanArchiteture.Presenters.PresenterStr;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Presenters.IPresenter;

type

  TPresenterStr = class(TInterfacedObject, IPresenter)

    function ConverterReponse(const Response: TResponse): string;
    function ConverterCliente(const Cliente: TCliente): string;
    function ConverterLista(const Lista: TList<TObject>): string;
  end;

implementation

{ TPresenterStr }

function TPresenterStr.ConverterCliente(const Cliente: TCliente): string;
var
  ClienteStr: string;
begin
  ClienteStr := 'Id: ' + IntToStr(Cliente.Id) + #13#10 +
  'Nome: ' + Cliente.Nome + #13#10 +
  'Documento: ' + Cliente.Documento + #13#10 +
  'Cep: ' + Cliente.Cep + #13#10 +
  'Logradouro: ' + Cliente.Logradouro + #13#10 +
  'Numero: ' + Cliente.Numero + #13#10 +
  'Complemento: ' + Cliente.Complemento + #13#10 +
  'Bairro: ' + Cliente.Bairro + #13#10 +
  'Cidade: ' + Cliente.Cidade + #13#10 +
  'UF: ' + Cliente.UF + #13#10 +
  'Telefone: ' + Cliente.Telefone + #13#10;

  Result := ClienteStr;
end;

function TPresenterStr.ConverterLista(const Lista: TList<TObject>): string;
var
  ListaStr: String;
  Objeto: TObject;
  I: Integer;
begin
  if Assigned(Lista) and not(Lista.count > 0) then
  begin
    for I := 0 to Lista.count do
    begin

      Objeto := Lista[I];
      if Objeto is TCliente then
        ListaStr := ListaStr + ConverterCliente(TCliente(Objeto)) + #13#10;
    end;
  end;

  Result := ListaStr;
end;

function TPresenterStr.ConverterReponse(const Response: TResponse): string;
var
  ResponseStr, Success: string;
begin
  if Response.Success then
    Success := 'true'
  else
    Success := 'false';

  ResponseStr := 'Success: ' + Success + #13#10 + 'ErrorCode: ' +
    IntToStr(Response.ErrorCode) + #13#10 + 'Message: ' + Response.Message +
    #13#10 + 'Data: ' + ConverterLista(Response.Data);

  Result := ResponseStr;
end;

end.
