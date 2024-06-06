unit URepositoryLocacao;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  UConfiguracaoDB,
  UIRepositoryLocacao,
  ULocacao,
  UDTOLocacao,
  UUtils;

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

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TRepositoryLocacao }

procedure TRepositoryLocacao.Alterar(const Locacao: TLocacao);
begin

end;

procedure TRepositoryLocacao.Cadastrar(const Locacao: TLocacao);
begin

end;

function TRepositoryLocacao.Consultar(const DTO: DTOLocacao): TList<TLocacao>;
begin

end;

constructor TRepositoryLocacao.Create;
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

end;

end.
