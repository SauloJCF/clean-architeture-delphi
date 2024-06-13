unit URepositoryCliente;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  UConfiguracaoDB,
  UCliente,
  UDTOCliente,
  UIRepositoryCliente;

type
  TRepositoryCliente = class(TInterfacedObject, IRepositoryCliente)
  private
    FLista: TList<TCliente>;
    FConfiguracaoDB: TConfiguracaoDB;

    procedure SetLista(const Value: TList<TCliente>);
  published
    procedure Cadastrar(const Cliente: TCliente);
    procedure Alterar(const Cliente: TCliente);
    procedure Excluir(const Codigo: Integer);
    function Consultar(const DTO: DTOCliente): TList<TCliente>;

    property Lista: TList<TCliente> read FLista write SetLista;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRepositoryCliente }

procedure TRepositoryCliente.Alterar(const Cliente: TCliente);
const
  SQL = 'UPDATE CLIENTES SET NOME = %s, DOCUMENTO = %s, CEP = %s, LOGRADOURO = %s, COMPLEMENTO = %s, NUMERO = %s, BAIRRO = %s, CIDADE = %s, UF = %s, TELEFONE = %s WHERE (ID = %d);';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL, [Cliente.Nome.QuotedString,
    Cliente.Documento.QuotedString, Cliente.Cep.QuotedString,
    Cliente.Logradouro.QuotedString, Cliente.Complemento.QuotedString,
    Cliente.Numero.QuotedString, Cliente.Bairro.QuotedString,
    Cliente.Cidade.QuotedString, Cliente.UF.QuotedString,
    Cliente.Telefone.QuotedString, Cliente.Id]);

  FConfiguracaoDB.ExecSQL(SQLFormatado);
end;

procedure TRepositoryCliente.Cadastrar(const Cliente: TCliente);
const
  SQL = 'INSERT INTO CLIENTES (NOME, DOCUMENTO, CEP, LOGRADOURO, COMPLEMENTO, NUMERO, BAIRRO, CIDADE, UF, TELEFONE) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL, [Cliente.Nome.QuotedString,
    Cliente.Documento.QuotedString, Cliente.Cep.QuotedString,
    Cliente.Logradouro.QuotedString, Cliente.Complemento.QuotedString,
    Cliente.Numero.QuotedString, Cliente.Bairro.QuotedString,
    Cliente.Cidade.QuotedString, Cliente.UF.QuotedString,
    Cliente.Telefone.QuotedString]);

  FConfiguracaoDB.ExecSQL(SQLFormatado);
end;

function TRepositoryCliente.Consultar(const DTO: DTOCliente): TList<TCliente>;
const
  SQL_BASE = 'SELECT * FROM CLIENTES WHERE 1 = 1';
  FILTRO_ID = 'AND ID = %d';
  FILTRO_NOME = 'AND NOME LIKE %s';
  FILTRO_DOCUMENTO = 'AND DOCUMENTO LIKE %s';
var
  BuilderSQL: TStringBuilder;
  SQLFormatado: String;
  Cliente: TCliente;
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

      if Trim(DTO.Documento) <> EmptyStr then
      begin
        BuilderSQL.AppendFormat(FILTRO_DOCUMENTO,
          [QuotedStr('%' + DTO.Documento + '%')]);
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
          Cliente := TCliente.Create;
          Cliente.Id := Query.FieldByName('ID').AsInteger;
          Cliente.Nome := Query.FieldByName('NOME').AsString;
          Cliente.Documento := Query.FieldByName('DOCUMENTO').AsString;
          Cliente.Cep := Query.FieldByName('CEP').AsString;
          Cliente.Logradouro := Query.FieldByName('LOGRADOURO').AsString;
          Cliente.Numero := Query.FieldByName('NUMERO').AsString;
          Cliente.Complemento := Query.FieldByName('COMPLEMENTO').AsString;
          Cliente.Bairro := Query.FieldByName('BAIRRO').AsString;
          Cliente.Cidade := Query.FieldByName('CIDADE').AsString;
          Cliente.UF := Query.FieldByName('UF').AsString;
          Cliente.Telefone := Query.FieldByName('TELEFONE').AsString;

          FLista.Add(Cliente);

          Query.Next;
        end;
      end;
    end;

    Result := FLista;
  finally
    BuilderSQL.Free;
  end;
end;

procedure TRepositoryCliente.Excluir(const Codigo: Integer);
const
  SQL = 'DELETE FROM CLIENTES WHERE ID = %d;';
var
  SQLFormatado: String;
begin
  SQLFormatado := Format(SQL, [Codigo]);
  FConfiguracaoDB.ExecSQL(SQLFormatado);
end;

procedure TRepositoryCliente.SetLista(const Value: TList<TCliente>);
begin
  FLista := Value;
end;

constructor TRepositoryCliente.Create;
begin
  FLista := TList<TCliente>.Create;
  FConfiguracaoDB := TConfiguracaoDB.Create;
end;

destructor TRepositoryCliente.Destroy;
var
  Cliente: TObject;
begin
  if Assigned(FLista) then
  begin
//    for Cliente in FLista do
//    begin
//      FreeAndNil(Cliente);
//    end;

    FreeAndNil(FLista);
  end;

  if Assigned(FConfiguracaoDB) then
    FreeAndNil(FConfiguracaoDB);
  inherited;
end;

end.
