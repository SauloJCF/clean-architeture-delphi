unit UUseCaseLocacao;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  UEnums,
  UExceptions,
  UResponse,
  ULocacao,
  UDTOLocacao,
  UUtils,
  UIUseCaseLocacao,
  UIRepositoryLocacao;

type

  TUseCaseLocacao = class(TInterfacedObject, IUseCaseLocacao)
  private
    FLista: TList<TLocacao>;
    FListaGenerica: TList<TObject>;
    FRepository: IRepositoryLocacao;

    procedure ValidarId(const Id: Integer);
    procedure SetLista(const Value: TList<TLocacao>);
    procedure SetListaGenerica(const Value: TList<TObject>);
  public
    function Cadastrar(const Locacao: TLocacao): TResponse;
    function Alterar(const Locacao: TLocacao): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DTOLocacao): TResponse;

    constructor Create(const RepositoryLocacao: IRepositoryLocacao);
    destructor Destroy; Override;

    property Lista: TList<TLocacao> read FLista write SetLista;
    property ListaGenerica: TList<TObject> read FListaGenerica
      write SetListaGenerica;
  end;

implementation

{ TUseCaseLocacao }

function TUseCaseLocacao.Alterar(const Locacao: TLocacao): TResponse;
var
  Response: TResponse;
begin
  try
    Locacao.ValidarRegrasNegocio;

    FRepository.Alterar(Locacao);

    Response.Success := True;
    Response.ErrorCode := 0;
    Response.Message := UEnums.RetornarMsgResponse.ALTERADO_COM_SUCESSO;
    Response.Data := nil;
  except
    on E: Exception do
    begin
      Response := TratarException(E);
    end;
  end;
  Result := Response;
end;

function TUseCaseLocacao.Cadastrar(const Locacao: TLocacao): TResponse;
var
  Response: TResponse;
begin
  try
    Locacao.ValidarRegrasNegocio;

    Locacao.DataLocacao := Now;

    FRepository.Cadastrar(Locacao);

    Response.Success := True;
    Response.ErrorCode := 0;
    Response.Message := UEnums.RetornarMsgResponse.CADASTRADO_COM_SUCESSO;
    Response.Data := nil;
  except
    on E: Exception do
    begin
      Response := TratarException(E);
    end;
  end;
  Result := Response;
end;

function TUseCaseLocacao.Consultar(const Dto: DTOLocacao): TResponse;
var
  Response: TResponse;
begin
  try
    FLista.Clear;
    FLista := FRepository.Consultar(Dto);

    if FLista.Count > 0 then
    begin
      Response.Success := True;
      Response.ErrorCode := 0;
      Response.Message := UEnums.RetornarMsgResponse.
        CONSULTA_REALIZADA_COM_SUCESSO;
      Response.Data := ListaLocacaoParaListaGenerica(FLista);
    end
    else
    begin
      Response.Success := True;
      Response.ErrorCode := 0;
      Response.Message := UEnums.RetornarMsgResponse.CONSULTA_SEM_RETORNO;
      Response.Data := nil;
    end;
  except
    on E: Exception do
    begin
      Response := TratarException(E);
    end;
  end;
  Result := Response;
end;

constructor TUseCaseLocacao.Create(const RepositoryLocacao: IRepositoryLocacao);
begin
  FRepository := RepositoryLocacao;
  FLista := TList<TLocacao>.Create;
  FListaGenerica := TList<TObject>.Create;
end;

function TUseCaseLocacao.Deletar(const Id: Integer): TResponse;
var
  Response: TResponse;
begin
  try
    ValidarId(Id);

    FRepository.Excluir(Id);

    Response.Success := True;
    Response.ErrorCode := 0;
    Response.Message := UEnums.RetornarMsgResponse.DELETADO_COM_SUCESSO;
    Response.Data := nil;
  except
    on E: Exception do
    begin
      Response := TratarException(E);
    end;
  end;
  Result := Response;
end;

destructor TUseCaseLocacao.Destroy;
var
  Locacao: TObject;
begin
  if Assigned(FListaGenerica) then
    FreeAndNil(FListaGenerica);

  inherited;
end;

procedure TUseCaseLocacao.SetLista(const Value: TList<TLocacao>);
begin
  FLista := Value;
end;

procedure TUseCaseLocacao.SetListaGenerica(const Value: TList<TObject>);
begin
  FListaGenerica := Value;
end;

procedure TUseCaseLocacao.ValidarId(const Id: Integer);
begin
  if Id <= 0 then
    ExceptionIdInvalido;
end;

end.
