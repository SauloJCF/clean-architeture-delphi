unit UVeiculo;

interface

uses
  UEnums;

type
  TVeiculo = class
  private
    FValor: Currency;
    FId: Integer;
    FStatus: Status;
    FPlaca: String;
    FNome: String;
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetPlaca(const Value: String);
    procedure SetStatus(const Value: Status);
    procedure SetValor(const Value: Currency);
  published
    property Id: Integer read FId write SetId;
    property Nome: String read FNome write SetNome;
    property Placa: String read FPlaca write SetPlaca;
    property Valor: Currency read FValor write SetValor;
    property Status: Status read FStatus write SetStatus;
  end;

implementation

{ TVeiculo }

procedure TVeiculo.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TVeiculo.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TVeiculo.SetPlaca(const Value: String);
begin
  FPlaca := Value;
end;

procedure TVeiculo.SetStatus(const Value: Status);
begin
  FStatus := Value;
end;

procedure TVeiculo.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
