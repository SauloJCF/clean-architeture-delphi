unit CleanArchiteture.LocacaoAPI.Server;

interface

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  CleanArchiteture.LocacaoAPI.Routes.Clientes,
  CleanArchiteture.LocacaoAPI.Routes.Veiculos,
  CleanArchiteture.LocacaoAPI.Routes.Locacoes;

procedure Start;

implementation

procedure Start;
const
  PORTA = 3000;
begin
  THorse.Use(Jhonson);

  // localhost:3000/api

  Writeln('Listando na porta: ' + IntToStr(PORTA));

  THorse.Get('/api/ping',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('pong na porta: ' + IntToStr(PORTA));
      try

        Writeln('Respondeu na porta: ' + IntToStr(PORTA));
      except
      end;
    end);

  // Rotas Clientes

  RouteCliente;

  // Rotas Veiculos

  RouteVeiculo;

  // Rotas Locacao

  RouteLocacao;

  THorse.Listen(PORTA);
end;

end.
