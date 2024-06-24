unit CleanArchiteture.Applications.LocacaoAPI.Server;

interface

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson;

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

  // Rotas Veiculos

  // Rotas Locacao

  THorse.Listen(PORTA);
end;

end.