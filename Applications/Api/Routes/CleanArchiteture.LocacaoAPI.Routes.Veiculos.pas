unit CleanArchiteture.LocacaoAPI.Routes.Veiculos;

interface

uses
  Horse,
  CleanArchiteture.LocacaoAPI.Controllers.Veiculos;

procedure RouteVeiculo;

implementation

procedure RouteVeiculo;
begin
  THorse.Post('/api/veiculo', PostVeiculo);
  THorse.Put('/api/veiculo/:id', PutVeiculo);
  THorse.Delete('/api/veiculo/:id', DeleteVeiculo);
end;

end.
