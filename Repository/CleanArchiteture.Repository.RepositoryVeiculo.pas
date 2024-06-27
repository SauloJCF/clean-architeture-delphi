unit CleanArchiteture.Repository.RepositoryVeiculo;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  CleanArchiteture.Repository.ConfiguracaoDB,
  CleanArchiteture.Core.Ports.IRepositoryVeiculo,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.DTO.DTOVeiculo,
  CleanArchiteture.Core.Utils.Utils;

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
const
  SQL = 'UPDATE VEICULOS SET NOME = %s, PLACA = %s, VALOR = %s, STATUS = %s WHERE (ID = %d);';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL, [Veiculo.Nome.QuotedString,
    Veiculo.Placa.QuotedString, Veiculo.Valor.ToString.Replace('.', '').Replace('R$', '').Replace(',',
    '.').QuotedString, ConverterStatusStr(Veiculo.Status).QuotedString,
    Veiculo.Id]);

  FConfiguracaoDB.ExecSQL(SQLFormatado);
end;

procedure TRepositoryVeiculo.Cadastrar(const Veiculo: TVeiculo);
const
  SQL = 'INSERT INTO VEICULOS (NOME, VALOR, PLACA, STATUS) VALUES (%s, %s, %s, %s);';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL, [Veiculo.Nome.QuotedString,
    Veiculo.Valor.ToString.Replace('R$', '').Replace('.', '').Replace(',', '.').QuotedString,
    Veiculo.Placa.QuotedString, ConverterStatusStr(Veiculo.Status)
    .QuotedString]);

  FConfiguracaoDB.ExecSQL(SQLFormatado);
end;

function TRepositoryVeiculo.Consultar(const DTO: DTOVeiculo): TList<TVeiculo>;
const
  SQL_BASE = 'SELECT * FROM VEICULOS WHERE 1 = 1 ';
  FILTRO_ID = 'AND ID = %d';
  FILTRO_NOME = 'AND NOME LIKE %s';
  FILTRO_PLACA = 'AND PLACA = %s';
var
  BuilderSQL: TStringBuilder;
  SQLFormatado: String;
  Veiculo: TVeiculo;
begin
  try
    BuilderSQL := TStringBuilder.Create;
    BuilderSQL.Append(SQL_BASE);

    if DTO.Id > 0 then
    begin
      BuilderSQL.AppendFormat(FILTRO_ID, [DTO.Id]);
    end
    else
    begin
      if Trim(DTO.Nome) <> EmptyStr then
      begin
        BuilderSQL.AppendFormat(FILTRO_NOME, [QuotedStr('%' + DTO.Nome + '%')]);
      end;

      if Trim(DTO.Placa) <> EmptyStr then
      begin
        BuilderSQL.AppendFormat(FILTRO_PLACA, [QuotedStr(DTO.Placa)]);
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
          Veiculo := TVeiculo.Create;
          Veiculo.Id := Query.FieldByName('ID').AsInteger;
          Veiculo.Nome := Query.FieldByName('NOME').AsString;
          Veiculo.Placa := Query.FieldByName('PLACA').AsString;
          Veiculo.Valor := Query.FieldByName('VALOR').AsCurrency;
          Veiculo.Status := ConverterStrStatus(Query.FieldByName('STATUS')
            .AsString);

          FLista.Add(Veiculo);

          Query.Next;
        end;
      end;
    end;

    Result := FLista;
  finally
    BuilderSQL.Free;
  end;

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
    FreeAndNil(FLista);

  if Assigned(FConfiguracaoDB) then
    FreeAndNil(FConfiguracaoDB);
  inherited;
end;

procedure TRepositoryVeiculo.Excluir(const Codigo: Integer);
const
  SQL = 'DELETE FROM VEICULOS WHERE ID = %d;';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL, [Codigo]);
  FConfiguracaoDB.ExecSQL(SQLFormatado);
end;

procedure TRepositoryVeiculo.SetLista(const Value: TList<TVeiculo>);
begin
  FLista := Value;
end;

end.
