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
    FTotal: Currency;
    FCliente: TCliente;
    FDataLocacao: TDateTime;
    FId: Integer;
    FDataDevolucao: TDateTime;
    FVeiculo: TVeiculo;
    FVeiculoAtual: TVeiculo;

    FHash: String;
    procedure SetCliente(const Value: TCliente);
    procedure SetDataDevolucao(const Value: TDateTime);
    procedure SetDataLocacao(const Value: TDateTime);
    procedure SetId(const Value: Integer);
    procedure SetTotal(const Value: Currency);
    procedure SetVeiculo(const Value: TVeiculo);
    procedure SetHash(const Value: String);
    procedure SetVeiculoAtual(const Value: TVeiculo);

  public
    property Id: Integer read FId write SetId;
    property Cliente: TCliente read FCliente write SetCliente;
    property Veiculo: TVeiculo read FVeiculo write SetVeiculo;
    property VeiculoAtual: TVeiculo read FVeiculoAtual write SetVeiculoAtual;
    property DataLocacao: TDateTime read FDataLocacao write SetDataLocacao;
    property DataDevolucao: TDateTime read FDataDevolucao
      write SetDataDevolucao;
    property Total: Currency read FTotal write SetTotal;
    property Hash: String read FHash write SetHash;

    procedure ValidarRegrasNegocio;

    function CalcularTotal: Currency;

    constructor Create;
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

constructor TLocacao.Create;
begin
  FHash := IntToStr(Self.GetHashCode);
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

procedure TLocacao.SetHash(const Value: String);
begin
  FHash := Value;
end;

procedure TLocacao.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TLocacao.SetTotal(const Value: Currency);
begin
  FTotal := Value;
end;

procedure TLocacao.SetVeiculo(const Value: TVeiculo);
begin
  FVeiculo := Value;
end;

procedure TLocacao.SetVeiculoAtual(const Value: TVeiculo);
begin
  FVeiculoAtual := Value;
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
