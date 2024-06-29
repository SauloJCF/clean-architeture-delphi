unit CleanArchiteture.LocacaoAPI.Routes.Locacoes;

interface

uses
  Horse,
  CleanArchiteture.LocacaoAPI.Controllers.Locacoes;

procedure RouteLocacao;

implementation

procedure RouteLocacao;
begin
  THorse.Post('/api/locacao', PostLocacao);
  THorse.Put('/api/locacao/:id', PutLocacao);
  THorse.Delete('/api/locacao/:id', DeleteLocacao);
  THorse.Get('/api/locacoes', GetLocacoes);
end;

end.
