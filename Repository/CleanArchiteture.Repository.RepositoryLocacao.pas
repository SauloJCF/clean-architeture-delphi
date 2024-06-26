unit CleanArchiteture.Repository.RepositoryLocacao;

interface

uses
  System.SysUtils,
  System.DateUtils,
  System.Generics.Collections,
  CleanArchiteture.Repository.ConfiguracaoDB,
  CleanArchiteture.Core.Ports.IRepositoryLocacao,

  CleanArchiteture.Core.Models.Locacao,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.Models.Cliente,

  CleanArchiteture.Core.DTO.DTOLocacao,
  CleanArchiteture.Core.DTO.DTOVeiculo,
  CleanArchiteture.Core.DTO.DTOCliente,

  CleanArchiteture.Core.Utils.Utils,

  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Core.Ports.IRepositoryVeiculo;

type

  TRepositoryLocacao = class(TInterfacedObject, IRepositoryLocacao)
  private
    FLista: TList<TLocacao>;
    FConfiguracaoDB: TConfiguracaoDB;
    FRepositoryCliente: IRepositoryCliente;
    FRepositoryVeiculo: IRepositoryVeiculo;
    FListaClientes: TList<TCliente>;
    FListaVeiculos: TList<TVeiculo>;

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
const
  SQL_LOCACAO =
    'UPDATE LOCACAO SET ID_CLIENTE = %d, DATA_DEVOLUCAO = %s, TOTAL = %s WHERE (ID = %d);';
  SQL_LOCACAO_VEICULOS =
    'UPDATE LOCACAO_VEICULOS SET ID_VEICULO = %d WHERE ID_LOCACAO = %d;';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL_LOCACAO, [Locacao.Cliente.Id,
    Locacao.DataDevolucao.Format('dd.MM.yyyy').QuotedString,
    Locacao.Total.ToString.Replace('.', '').Replace(',', '.').Replace('R$', '').QuotedString,
    Locacao.Id]);

  FConfiguracaoDB.ExecSQL(SQLFormatado);

  if Locacao.Veiculo.Id <> Locacao.VeiculoAtual.Id then
  begin
    SQLFormatado := Format(SQL_LOCACAO_VEICULOS,
      [Locacao.Veiculo.Id, Locacao.Id]);

    FConfiguracaoDB.ExecSQL(SQLFormatado);
  end;
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
    Locacao.CalcularTotal.ToString.Replace('.', '').Replace(',', '.').Replace('R$',
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
      Locacao.Veiculo.Valor.ToString.Replace('.', '').Replace(',', '.').Replace('R$',
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
  FILTRO_DATA_LOCACAO = 'AND L.DATA_LOCACAO = %s ';
  FILTRO_DATA_DEVOLUCAO = 'AND L.DATA_DEVOLUCAO = %s ';
var
  _DtoCliente: DTOCliente;
  _DtoVeiculo: DTOVeiculo;
  BuilderSQL: TStringBuilder;
  SQLFormatado: String;
  Locacao: TLocacao;
begin
  BuilderSQL := TStringBuilder.Create;
  BuilderSQL.Append(SQL_BASE);
  if DTO.Id > 0 then
  begin
    BuilderSQL.AppendFormat(FILTRO_ID, [DTO.Id]);
  end
  else
  begin
    if DTO.IdCliente > 0 then
    begin
      BuilderSQL.AppendFormat(FILTRO_ID_CLIENTE, [DTO.IdCliente]);
    end;

    if DTO.DataLocacao <> StrToDate('30/12/1899') then
    begin
      BuilderSQL.AppendFormat(FILTRO_DATA_LOCACAO,
        [QuotedStr(FormatDateTime('dd.MM.yyyy', DTO.DataLocacao))]);
    end;

    if DTO.DataDevolucao <> StrToDate('30/12/1899') then
    begin
      BuilderSQL.AppendFormat(FILTRO_DATA_DEVOLUCAO,
        [QuotedStr(FormatDateTime('dd.MM.yyyy', DTO.DataDevolucao))]);
    end;
  end;

  SQLFormatado := BuilderSQL.ToString;

  if FConfiguracaoDB.Consulta(SQLFormatado) then
  begin
    FLista.Clear;

    with FConfiguracaoDB do
    begin
      Query.First;
      while not Query.Eof do
      begin
        Locacao := TLocacao.Create;
        Locacao.Id := Query.FieldByName('ID').AsInteger;
        Locacao.DataLocacao := Query.FieldByName('DATA_LOCACAO').AsDateTime;
        Locacao.DataDevolucao := Query.FieldByName('DATA_DEVOLUCAO').AsDateTime;
        Locacao.Total := Query.FieldByName('TOTAL').AsCurrency;

        _DtoCliente.Id := Query.FieldByName('ID_CLIENTE').AsInteger;

        FListaClientes := FRepositoryCliente.Consultar(_DtoCliente);

        if FListaClientes.Count > 0 then
        begin
          Locacao.Cliente := FListaClientes.First;
        end;

        _DtoVeiculo.Id := Query.FieldByName('ID_VEICULO').AsInteger;

        FListaVeiculos := FRepositoryVeiculo.Consultar(_DtoVeiculo);

        if FListaVeiculos.Count > 0 then
        begin
          Locacao.Veiculo := FListaVeiculos.First;

          Locacao.VeiculoAtual := Locacao.Veiculo;
        end;

        FLista.Add(Locacao);

        Query.Next;
      end;
    end;
  end;

  Result := FLista;
end;

constructor TRepositoryLocacao.Create(const RepositoryCliente
  : IRepositoryCliente; const RepositoryVeiculo: IRepositoryVeiculo);
begin
  FLista := TList<TLocacao>.Create;
  FConfiguracaoDB := TConfiguracaoDB.Create;

  FRepositoryCliente := RepositoryCliente;
  FRepositoryVeiculo := RepositoryVeiculo;

  FListaClientes := TList<TCliente>.Create;
  FListaVeiculos := TList<TVeiculo>.Create;
end;

destructor TRepositoryLocacao.Destroy;
var
  Locacao: TObject;
begin
  if Assigned(FLista) then
    FreeAndNil(FLista);

  if Assigned(FConfiguracaoDB) then
    FreeAndNil(FConfiguracaoDB);

  inherited;
end;

procedure TRepositoryLocacao.Excluir(const Codigo: Integer);
const
  SQL_LOCACAO = 'DELETE FROM LOCACAO WHERE ID = %d;';
  SQL_LOCACAO_VEICULOS = 'DELETE FROM LOCACAO_VEICULOS WHERE ID_LOCACAO = %d;';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL_LOCACAO, [Codigo]);
  FConfiguracaoDB.ExecSQL(SQLFormatado);

  SQLFormatado := Format(SQL_LOCACAO_VEICULOS, [Codigo]);
  FConfiguracaoDB.ExecSQL(SQLFormatado);
end;

procedure TRepositoryLocacao.SetLista(const Value: TList<TLocacao>);
begin
  FLista := Value;
end;

end.
