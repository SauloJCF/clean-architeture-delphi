unit CleanArchiteture.Core.Models.Cliente;

interface

uses
  System.SysUtils,
  CleanArchiteture.Core.Exceptions.Exceptions;

type

  TCliente = class
  private
    FLogradouro: String;
    FBairro: String;
    FUF: String;
    FCep: String;
    FDocumento: String;
    FId: Integer;
    FNumero: String;
    FComplemento: String;
    FNome: String;
    FCidade: String;
    FTelefone: String;
    procedure SetBairro(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetDocumento(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetLogradouro(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetUF(const Value: String);

  published
    property Id: Integer read FId write SetId;
    property Nome: String read FNome write SetNome;
    property Documento: String read FDocumento write SetDocumento;
    property Cep: String read FCep write SetCep;
    property Logradouro: String read FLogradouro write SetLogradouro;
    property Numero: String read FNumero write SetNumero;
    property Complemento: String read FComplemento write SetComplemento;
    property Bairro: String read FBairro write SetBairro;
    property Cidade: String read FCidade write SetCidade;
    property UF: String read FUF write SetUF;
    property Telefone: String read FTelefone write SetTelefone;

    procedure ValidarRegrasNegocio;
  end;

implementation

{ TCliente }

procedure TCliente.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TCliente.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TCliente.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TCliente.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TCliente.SetDocumento(const Value: String);
begin
  FDocumento := Value;
end;

procedure TCliente.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TCliente.SetLogradouro(const Value: String);
begin
  FLogradouro := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TCliente.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

procedure TCliente.SetUF(const Value: String);
begin
  FUF := Value;
end;

procedure TCliente.ValidarRegrasNegocio;
begin
  if Trim(FNome).IsEmpty then
  begin
    ExceptionNome;
  end;

  if Length(FNome) <= 4 then
  begin
    ExceptionMinimoNome;
  end;

  if Trim(FDocumento).IsEmpty then
  begin
    ExceptionDocumento;
  end;

  if Length(FDocumento) <= 4 then
  begin
    ExceptionMinimoDocumento;
  end;

  if Trim(FTelefone).IsEmpty then
  begin
    ExceptionTelefone;
  end;

  if Length(FTelefone) <= 8 then
  begin
    ExceptionMinimoTelefone;
  end;
end;

end.
