unit UExceptions;

interface

uses System.SysUtils;

type
  EExceptionNome = class(Exception);
  EExceptionMinimoNome = class(Exception);
  EExceptionDocumento = class(Exception);
  EExceptionMinimoDocumento = class(Exception);
  EExceptionTelefone = class(Exception);
  EExceptionMinimoTelefone = class(Exception);

procedure ExceptionNome;
procedure ExceptionMinimoNome;
procedure ExceptionDocumento;
procedure ExceptionMinimoDocumento;
procedure ExceptionTelefone;
procedure ExceptionMinimoTelefone;

implementation

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

end.
