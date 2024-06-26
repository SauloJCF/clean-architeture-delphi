unit CleanArchiteture.LocacaoAPI.Routes.Clientes;

interface

uses
  Horse,
  CleanArchiteture.LocacaoAPI.Controllers.Clientes;

procedure RouteCliente;

implementation

procedure RouteCliente;
begin
  THorse.Post('/api/cliente', PostCliente);
  THorse.Put('/api/cliente/:id', PutCliente);
end;

end.
