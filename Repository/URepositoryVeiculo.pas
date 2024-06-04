unit URepositoryVeiculo;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  UConfiguracaoDB,
  UIRepositoryVeiculo,
  UVeiculo,
  UDTOVeiculo,
  UUtils;

type

  TRepositoryVeiculo = class(TInterfacedObject, IRepositoryVeiculo)
  private
    FLista: TList<TVeiculo>;
    FConfiguracaoDB: TConfiguracaoDB;

    procedure SetLista(const Value: TList<TVeiculo>);
  published
    procedure Cadastrar(const Veiculo: TVeiculo);
    procedure Alterar(const Veiculo: TVeiculo);
    procedure Excluir(const Codigo: Integer);
    function Consultar(const DTO: DTOVeiculo): TList<TVeiculo>;

    property Lista: TList<TVeiculo> read FLista write SetLista;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRepositoryVeiculo }

procedure TRepositoryVeiculo.Alterar(const Veiculo: TVeiculo);
begin

end;

procedure TRepositoryVeiculo.Cadastrar(const Veiculo: TVeiculo);
const
  SQL = 'INSERT INTO VEICULOS (NOME, VALOR, PLACA, STATUS) VALUES (%s, %s, %s, %s);';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL, [Veiculo.Nome.QuotedString,
    Veiculo.Placa.QuotedString, Veiculo.Valor.ToString.Replace(',', '.').QuotedString, ConverterStatusStr(Veiculo.Status).QuotedString]);

  FConfiguracaoDB.ExecSQL(SQLFormatado);
end;

function TRepositoryVeiculo.Consultar(const DTO: DTOVeiculo): TList<TVeiculo>;
begin

end;

constructor TRepositoryVeiculo.Create;
begin
  FLista := TList<TVeiculo>.Create;
  FConfiguracaoDB := TConfiguracaoDB.Create;
end;

destructor TRepositoryVeiculo.Destroy;
var
  Veiculo: TObject;
begin
  if Assigned(FLista) then
  begin
    for Veiculo in FLista do
    begin
      Veiculo.Free;
    end;

    FreeAndNil(FLista);
  end;

  if Assigned(FConfiguracaoDB) then
    FreeAndNil(FConfiguracaoDB);
  inherited;
end;

procedure TRepositoryVeiculo.Excluir(const Codigo: Integer);
begin

end;

procedure TRepositoryVeiculo.SetLista(const Value: TList<TVeiculo>);
begin

end;

end.
