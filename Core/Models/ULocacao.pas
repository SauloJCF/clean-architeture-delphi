unit ULocacao;

interface

uses
  System.DateUtils,
  System.SysUtils,
  UEnums,
  UCliente,
  UVeiculo,
  UExceptions;

type
  TLocacao = class
  private
    FValor: Currency;
    FCliente: TCliente;
    FDataLocacao: TDateTime;
    FId: Integer;
    FDataDevolucao: TDateTime;
    FVeiculo: TVeiculo;
    procedure SetCliente(const Value: TCliente);
    procedure SetDataDevolucao(const Value: TDateTime);
    procedure SetDataLocacao(const Value: TDateTime);
    procedure SetId(const Value: Integer);
    procedure SetValor(const Value: Currency);
    procedure SetVeiculo(const Value: TVeiculo);

  published
    property Id: Integer read FId write SetId;
    property Cliente: TCliente read FCliente write SetCliente;
    property Veiculo: TVeiculo read FVeiculo write SetVeiculo;
    property DataLocacao: TDateTime read FDataLocacao write SetDataLocacao;
    property DataDevolucao: TDateTime read FDataDevolucao
      write SetDataDevolucao;
    property Valor: Currency read FValor write SetValor;

    procedure ValidarRegrasNegocio;

    function CalcularTotal: Currency;
  end;

implementation

{ TLocacao }

function TLocacao.CalcularTotal: Currency;
var
  Total: Currency;
  QtdDias: Integer;
begin
  Total := 0;
  QtdDias := 1;

  if ((FDataLocacao <> StrToDate('30/12/1899')) and
    (FDataDevolucao <> StrToDate('30/12/1899'))) then
  begin
    QtdDias := DaysBetween(FDataLocacao, FDataDevolucao);

    if QtdDias <= 0 then
      QtdDias := 1;
  end;

  Total := QtdDias * FVeiculo.Valor;

  Result := Total;
end;

procedure TLocacao.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TLocacao.SetDataDevolucao(const Value: TDateTime);
begin
  FDataDevolucao := Value;
end;

procedure TLocacao.SetDataLocacao(const Value: TDateTime);
begin
  FDataLocacao := Value;
end;

procedure TLocacao.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TLocacao.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TLocacao.SetVeiculo(const Value: TVeiculo);
begin
  FVeiculo := Value;
end;

procedure TLocacao.ValidarRegrasNegocio;
begin
  if FCliente = nil then
    ExceptionLocacaoCliente;
  if FVeiculo = nil then
    ExceptionLocacaoVeiculo;
  if FVeiculo.Status = Alugado then
    ExceptionLocacaoVeiculoAlugado;
end;

end.
