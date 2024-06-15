unit CleanArchiteture.Controllers.ControllerLocacao;

interface

uses
  CleanArchiteture.Core.Models.Locacao,
  CleanArchiteture.Core.Models.Cliente,
  CleanArchiteture.Core.Models.Veiculo,
  CleanArchiteture.Core.DTO.DTOLocacao,
  CleanArchiteture.Core.DTO.DTOCliente,
  CleanArchiteture.Core.DTO.DTOVeiculo,
  CleanArchiteture.Core.Ports.IRepositoryLocacao,
  CleanArchiteture.Core.Ports.IRepositoryCliente,
  CleanArchiteture.Core.Ports.IRepositoryVeiculo,
  CleanArchiteture.Core.Ports.IUseCaseLocacao,
  CleanArchiteture.Core.Ports.IUseCaseCliente,
  CleanArchiteture.Core.Ports.IUseCaseVeiculo,
  CleanArchiteture.Core.UseCases.UseCaseLocacao,
  CleanArchiteture.Core.UseCases.UseCaseCliente,
  CleanArchiteture.Core.UseCases.UseCaseVeiculo,
  CleanArchiteture.Core.Enums.Enums,
  CleanArchiteture.Core.Utils.Utils;

type
  TControllerLocacao = class
  private
    FUseCaseCliente: IUseCaseCliente;
    FUseCaseLocacao: IUseCaseLocacao;
    FUseCaseVeiculo: IUseCaseVeiculo;

    procedure SetUseCaseCliente(const Value: IUseCaseCliente);
    procedure SetUseCaseLocacao(const Value: IUseCaseLocacao);
    procedure SetUseCaseVeiculo(const Value: IUseCaseVeiculo);

  public
    function Cadastrar(const IdCliente, IdVeiculo: integer): string;
    function Alterar(const IdLocacao, IdCliente, IdVeiculo: integer;
      const DataDevolucao: TDateTime): String;
    function Deletar(const IdLocacao: integer): String;
    function Consultar(const IdLocaco: integer;
      const DataDevolucao: TDateTime): string;

    constructor Create(const RepositoryLocacao: IRepositoryLocacao;
      const RepositoryCliente: IRepositoryCliente;
      const RepositoryVeiculo: IRepositoryVeiculo);
    destructor Destroy; override;

    property UseCaseLocacao: IUseCaseLocacao read FUseCaseLocacao
      write SetUseCaseLocacao;
    property UseCaseCliente: IUseCaseCliente read FUseCaseCliente
      write SetUseCaseCliente;
    property UseCaseVeiculo: IUseCaseVeiculo read FUseCaseVeiculo
      write SetUseCaseVeiculo;
  end;

implementation

{ TControllerLocacao }

function TControllerLocacao.Alterar(const IdLocacao, IdCliente,
  IdVeiculo: integer; const DataDevolucao: TDateTime): String;
begin

end;

function TControllerLocacao.Cadastrar(const IdCliente,
  IdVeiculo: integer): string;
begin

end;

function TControllerLocacao.Consultar(const IdLocaco: integer;
  const DataDevolucao: TDateTime): string;
begin

end;

constructor TControllerLocacao.Create(const RepositoryLocacao
  : IRepositoryLocacao; const RepositoryCliente: IRepositoryCliente;
  const RepositoryVeiculo: IRepositoryVeiculo);
begin
  FUseCaseLocacao := TUseCaseLocacao.Create(RepositoryLocacao);
  FUseCaseCliente := TUseCaseCliente.Create(RepositoryCliente);
  FUseCaseVeiculo := TUseCaseVeiculo.Create(RepositoryVeiculo);
end;

function TControllerLocacao.Deletar(const IdLocacao: integer): String;
begin

end;

destructor TControllerLocacao.Destroy;
begin

  inherited;
end;

procedure TControllerLocacao.SetUseCaseCliente(const Value: IUseCaseCliente);
begin
  FUseCaseCliente := Value;
end;

procedure TControllerLocacao.SetUseCaseLocacao(const Value: IUseCaseLocacao);
begin
  FUseCaseLocacao := Value;
end;

procedure TControllerLocacao.SetUseCaseVeiculo(const Value: IUseCaseVeiculo);
begin
  FUseCaseVeiculo := Value;
end;

end.
