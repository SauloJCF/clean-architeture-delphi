unit ULocacao;

interface

uses UCliente, UVeiculo;

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
  end;

implementation

{ TLocacao }

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

end.
