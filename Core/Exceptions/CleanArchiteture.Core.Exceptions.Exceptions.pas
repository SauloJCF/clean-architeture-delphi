unit CleanArchiteture.Core.Exceptions.Exceptions;

interface

uses System.SysUtils;

type
  EExceptionIdInvalido = class(Exception);

  EExceptionNome = class(Exception);
  EExceptionMinimoNome = class(Exception);
  EExceptionDocumento = class(Exception);
  EExceptionMinimoDocumento = class(Exception);
  EExceptionTelefone = class(Exception);
  EExceptionMinimoTelefone = class(Exception);

  EExceptionMinimoNomeVeiculo = class(Exception);
  EExceptionPlacaVeiculo = class(Exception);
  EExceptionMinimoPlacaVeiculo = class(Exception);
  EExceptionValorVeiculo = class(Exception);

  EExceptionLocacaoVeiculo = class(Exception);
  EExceptionLocacaoCliente = class(Exception);
  EExceptionLocacaoVeiculoAlugado = class(Exception);

  EExceptionDatabase = class(Exception);

procedure ExceptionIdInvalido;

procedure ExceptionNome;
procedure ExceptionMinimoNome;
procedure ExceptionDocumento;
procedure ExceptionMinimoDocumento;
procedure ExceptionTelefone;
procedure ExceptionMinimoTelefone;

procedure ExceptionMinimoNomeVeiculo;
procedure ExceptionPlacaVeiculo;
procedure ExceptionMinimoPlacaVeiculo;
procedure ExceptionValorVeiculo;

procedure ExceptionLocacaoVeiculo;
procedure ExceptionLocacaoCliente;
procedure ExceptionLocacaoVeiculoAlugado;

procedure ExceptionDatabase(const Message: string);

implementation

procedure ExceptionIdInvalido;
begin
  raise EExceptionNome.Create('Id informado inválido!');
end;

procedure ExceptionNome;
begin
  raise EExceptionNome.Create('Nome deve ser informado!');
end;

procedure ExceptionMinimoNome;
begin
  raise EExceptionMinimoNome.Create('Nome deve conter no mínimo 4 caracteres!');
end;

procedure ExceptionDocumento;
begin
  raise EExceptionDocumento.Create('Documento deve ser informado!');
end;

procedure ExceptionMinimoDocumento;
begin
  raise EExceptionMinimoDocumento.Create
    ('Nome deve conter no mínimo 4 caracteres!');
end;

procedure ExceptionTelefone;
begin
  raise EExceptionTelefone.Create('Telefone deve ser informado!');
end;

procedure ExceptionMinimoTelefone;
begin
  raise EExceptionMinimoTelefone.Create
    ('Telefone deve conter no mínimo 8 caracteres!');
end;

procedure ExceptionMinimoNomeVeiculo;
begin
  raise EExceptionMinimoNome.Create('Nome deve conter no mínimo 3 caracteres!');
end;

procedure ExceptionPlacaVeiculo;
begin
  raise EExceptionPlacaVeiculo.Create('Placa deve ser informada!');
end;

procedure ExceptionMinimoPlacaVeiculo;
begin
  raise EExceptionMinimoNomeVeiculo.Create
    ('Placa deve conter no mínimo 6 caracteres!');
end;

procedure ExceptionValorVeiculo;
begin
  raise EExceptionValorVeiculo.Create('Valor deve ser maior que zero!');
end;

procedure ExceptionLocacaoVeiculo;
begin
  raise EExceptionLocacaoVeiculo.Create('Veículo não informado!');
end;

procedure ExceptionLocacaoCliente;
begin
  raise EExceptionLocacaoCliente.Create('Cliente não informado!');
end;

procedure ExceptionLocacaoVeiculoAlugado;
begin
  raise EExceptionLocacaoVeiculoAlugado.Create('Veículo já consta como alugado!');
end;

procedure ExceptionDatabase(const Message: string);
begin
  raise EExceptionDatabase.Create(Message);
end;

end.
