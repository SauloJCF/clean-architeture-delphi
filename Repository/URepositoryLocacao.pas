unit URepositoryLocacao;

interface

uses
  System.SysUtils,
  System.DateUtils,
  System.Generics.Collections,
  UConfiguracaoDB,
  UIRepositoryLocacao,
  ULocacao, UVeiculo, UCliente,
  UDTOLocacao, UDTOVeiculo, UDTOCliente,
  UUtils,
  UIRepositoryCliente, UIRepositoryVeiculo;

type

  TRepositoryLocacao = class(TInterfacedObject, IRepositoryLocacao)
  private
    FLista: TList<TLocacao>;
    FConfiguracaoDB: TConfiguracaoDB;

    procedure SetLista(const Value: TList<TLocacao>);
  published
    procedure Cadastrar(const Locacao: TLocacao);
    procedure Alterar(const Locacao: TLocacao);
    procedure Excluir(const Codigo: Integer);
    function Consultar(const DTO: DTOLocacao): TList<TLocacao>;

    property Lista: TList<TLocacao> read FLista write SetLista;

    constructor Create(const RepositoryCliente: IRepositoryCliente;
      const RepositoryVeiculo: IRepositoryVeiculo);
    destructor Destroy; override;
  end;

implementation

{ TRepositoryLocacao }

procedure TRepositoryLocacao.Alterar(const Locacao: TLocacao);
begin

end;

procedure TRepositoryLocacao.Cadastrar(const Locacao: TLocacao);
const
  SQL_INSERT_LOCACAO =
    'INSERT INTO LOCACAO (ID_CLIENTE, DATA_LOCACAO, DATA_DEVOLUCAO, TOTAL, HASH) VALUES (%s, %s, %s, %s, %s);';
  SQL_CONSULTA = 'SELECT ID FROM LOCACAO WHERE HASH = %s;';
  SQL_INSERT_LOCACAO_VEICULOS =
    'INSERT INTO LOCACAO_VEICULOS (ID_LOCACAO, ID_VEICULO, VALOR) VALUES (%s, %s, %s);';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL_INSERT_LOCACAO,
    [Locacao.Cliente.Id.ToString.QuotedString,
    Locacao.DataLocacao.Format('dd.MM.yyyy').QuotedString,
    Locacao.DataDevolucao.Format('dd.MM.yyyy').QuotedString,
    Locacao.CalcularTotal.ToString.Replace(',', '.').Replace('R$',
    '').QuotedString, Locacao.Hash.QuotedString]);

  FConfiguracaoDB.ExecSQL(SQLFormatado);

  SQLFormatado := Format(SQL_CONSULTA, [Locacao.Hash.QuotedString]);

  if FConfiguracaoDB.Consulta(SQLFormatado) then
  begin
    FConfiguracaoDB.Query.First;
    Locacao.Id := FConfiguracaoDB.Query.FieldByName('ID').AsInteger;

    SQLFormatado := Format(SQL_INSERT_LOCACAO_VEICULOS,
      [Locacao.Id.ToString.QuotedString,
      Locacao.Veiculo.Id.ToString.QuotedString,
      Locacao.Veiculo.Valor.ToString.Replace(',', '.').Replace('R$',
      '').QuotedString]);

    FConfiguracaoDB.ExecSQL(SQLFormatado);
  end;
end;

function TRepositoryLocacao.Consultar(const DTO: DTOLocacao): TList<TLocacao>;
const
  SQL_BASE = 'SELECT L.*, LV.* FROM LOCACAO L ' +
    'INNER JOIN LOCACAO_VEICULOS LV ON (L.ID = LV.ID_LOCACAO) ' +
    'WHERE 1 = 1 ';
  FILTRO_ID = 'AND L.ID = %d ';
  FILTRO_ID_CLIENTE = 'AND L.ID_CLIENTE = %d';
  FILTRO_PLACA = 'AND L.DATA = %s ';
var
  _DtoCliente: DTOCliente;
  _DtoVeiculo: DTOVeiculo;
  BuilderSQL: TStringBuilder;
  SQLFormatado: String;
begin
  BuilderSQL := TStringBuilder.Create;
  BuilderSQL.Append(SQL_BASE);
  if DTO.Id > 0 then
  begin
    BuilderSQL.AppendFormat(FILTRO_ID, [DTO.Id]);
  end
  else
  begin
    if DTO.ClienteId > 0 then
    begin
      BuilderSQL.AppendFormat(FILTRO_ID_CLIENTE, [DTO.ClienteId]);
    end;

    if DTO.DataLocacao <> StrToDate('30/12/1899') then
    begin
      BuilderSQL.AppendFormat(FILTRO_PLACA,
        [QuotedStr(DateToStr(DTO.DataLocacao))]);
    end;

    if DTO.DataDevolucao <> StrToDate('30/12/1899') then
    begin
      BuilderSQL.AppendFormat(FILTRO_PLACA,
        [QuotedStr(DateToStr(DTO.DataDevolucao))]);
    end;
  end;

end;

constructor TRepositoryLocacao.Create(const RepositoryCliente
  : IRepositoryCliente; const RepositoryVeiculo: IRepositoryVeiculo);
begin
  FLista := TList<TLocacao>.Create;
  FConfiguracaoDB := TConfiguracaoDB.Create;
end;

destructor TRepositoryLocacao.Destroy;
var
  Locacao: TObject;
begin
  if Assigned(FLista) then
  begin
    for Locacao in FLista do
    begin
      Locacao.Free;
    end;

    FreeAndNil(FLista);
  end;

  if Assigned(FConfiguracaoDB) then
    FreeAndNil(FConfiguracaoDB);
  inherited;
end;

procedure TRepositoryLocacao.Excluir(const Codigo: Integer);
begin

end;

procedure TRepositoryLocacao.SetLista(const Value: TList<TLocacao>);
begin
  FLista := Value;
end;

end.
