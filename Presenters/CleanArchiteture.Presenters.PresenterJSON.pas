unit CleanArchiteture.Presenters.PresenterJSON;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  CleanArchiteture.Core.Responses.Response,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.Models.Locacao,
  CleanArchiteture.Presenters.IPresenter,
  CleanArchiteture.Core.Utils.Utils;

type

  TPresenterJSON = class(TInterfacedObject, IPresenter)

    function ConverterReponse(const Response: TResponse): string;
    function ConverterCliente(const Cliente: TCliente): string;
    function ConverterVeiculo(const Veiculo: TVeiculo): string;
    function ConverterLocacao(const Locacao: TLocacao): string;
    function ConverterLista(const Lista: TList<TObject>): string;
  end;

implementation

{ TPresenterJSON }

function TPresenterJSON.ConverterCliente(const Cliente: TCliente): string;
var
  ClienteStr: string;
begin
  ClienteStr := '{' + '"Id:" ' + IntToStr(Cliente.Id) + ',' + #13#10 +
    '"Nome": ' + AnsiQuotedStr(Cliente.Nome.DeQuotedString, '"') + ',' + #13#10
    + '"Documento": ' + AnsiQuotedStr(Cliente.Documento, '"') + ',' + #13#10 +
    '"Cep": ' + AnsiQuotedStr(Cliente.Cep, '"') + ',' + #13#10 +
    '"Logradouro": ' + AnsiQuotedStr(Cliente.Logradouro, '"') + ',' + #13#10 +
    '"Numero": ' + AnsiQuotedStr(Cliente.Numero, '"') + ',' + #13#10 +
    '"Complemento": ' + AnsiQuotedStr(Cliente.Complemento, '"') + ',' + #13#10 +
    '"Bairro": ' + AnsiQuotedStr(Cliente.Bairro, '"') + ',' + #13#10 +
    '"Cidade": ' + AnsiQuotedStr(Cliente.Cidade, '"') + ',' + #13#10 + '"UF": '
    + AnsiQuotedStr(Cliente.UF, '"') + ',' + #13#10 + '"Telefone": ' +
    AnsiQuotedStr(Cliente.Telefone, '"') + '}';

  Result := ClienteStr;
end;

function TPresenterJSON.ConverterLista(const Lista: TList<TObject>): string;
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
        ListaStr := ListaStr + ConverterCliente(TCliente(Objeto)) + ',' + #13#10;
      if Objeto is TVeiculo then
        ListaStr := ListaStr + ConverterVeiculo(TVeiculo(Objeto)) + ',' + #13#10;
      if Objeto is TLocacao then
        ListaStr := ListaStr + ConverterLocacao(TLocacao(Objeto)) + ',' + #13#10;
    end;
  end;

  Result := '[' + ListaStr + ']';
end;

function TPresenterJSON.ConverterLocacao(const Locacao: TLocacao): string;
var
  LocacaoJSON: String;
begin
  LocacaoJSON := '{' + '"Id:" ' + IntToStr(Locacao.Id) + ',' + #13#10 +
    '"Cliente": ' + ConverterCliente(Locacao.Cliente) + ',' + #13#10 +
    '"Veiculo": ' + ConverterVeiculo(Locacao.Veiculo) + ',' + #13#10 +
    '"DataLocacao": ' + FormatDateTime('yyyy-MM-dd hh:mm:ss',
    Locacao.DataLocacao) + ',' + #13#10 + '"DataDevolucao": ' +
    FormatDateTime('yyyy-MM-dd hh:mm:ss', Locacao.DataDevolucao) + ',' + #13#10
    + '"Total": ' + AnsiQuotedStr(Locacao.Total.ToString.Replace(',', '.')
    .Replace('R$', ''), '"') + '}';

  Result := LocacaoJSON;
end;

function TPresenterJSON.ConverterReponse(const Response: TResponse): string;
var
  ResponseStr, Success: string;
begin
  if Response.Success then
    Success := 'true'
  else
    Success := 'false';

  ResponseStr := '{' + '"Success": ' + AnsiQuotedStr(Success, '"') + ',' +
    #13#10 + '"ErrorCode": ' + IntToStr(Response.ErrorCode) + ',' + #13#10 +
    '"Message": ' + AnsiQuotedStr(Response.Message, '"') + ',' + #13#10 +
    '"Data": ' + ConverterLista(Response.Data) + '}';

  Result := ResponseStr;
end;

function TPresenterJSON.ConverterVeiculo(const Veiculo: TVeiculo): string;
var
  VeiculoJSON: String;
begin
  VeiculoJSON := '{' + '"Id:" ' + IntToStr(Veiculo.Id) + ',' + #13#10 +
    '"Nome": ' + AnsiQuotedStr(Veiculo.Nome.DeQuotedString, '"') + ',' + #13#10
    + '"Placa": ' + AnsiQuotedStr(Veiculo.Placa, '"') + ',' + #13#10 +
    '"Valor": ' + AnsiQuotedStr(Veiculo.Valor.ToString.Replace(',', '.')
    .Replace('R$', ''), '"') + ',' + #13#10 + '"Status": ' +
    AnsiQuotedStr(ConverterStatusStr(Veiculo.Status), '"') + '}';

  Result := VeiculoJSON;
end;

end.
