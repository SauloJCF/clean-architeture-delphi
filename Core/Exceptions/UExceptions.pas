unit UExceptions;

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

implementation

procedure ExceptionIdInvalido;
begin
  raise EExceptionNome.Create('Id informado inv�lido!');
end;

procedure ExceptionNome;
begin
  raise EExceptionNome.Create('Nome deve ser informado!');
end;

procedure ExceptionMinimoNome;
begin
  raise EExceptionMinimoNome.Create('Nome deve conter no m�nimo 4 caracteres!');
end;

procedure ExceptionDocumento;
begin
  raise EExceptionDocumento.Create('Documento deve ser informado!');
end;

procedure ExceptionMinimoDocumento;
begin
  raise EExceptionMinimoDocumento.Create
    ('Nome deve conter no m�nimo 4 caracteres!');
end;

procedure ExceptionTelefone;
begin
  raise EExceptionTelefone.Create('Telefone deve ser informado!');
end;

procedure ExceptionMinimoTelefone;
begin
  raise EExceptionMinimoTelefone.Create
    ('Telefone deve conter no m�nimo 8 caracteres!');
end;

procedure ExceptionMinimoNomeVeiculo;
begin
  raise EExceptionMinimoNome.Create('Nome deve conter no m�nimo 3 caracteres!');
end;

procedure ExceptionPlacaVeiculo;
begin
  raise EExceptionPlacaVeiculo.Create('Placa deve ser informada!');
end;

procedure ExceptionMinimoPlacaVeiculo;
begin
  raise EExceptionMinimoNomeVeiculo.Create
    ('Placa deve conter no m�nimo 6 caracteres!');
end;

procedure ExceptionValorVeiculo;
begin
  raise EExceptionValorVeiculo.Create('Valor deve ser maior que zero!');
end;

end.
