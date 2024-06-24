program LocacaoApi;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  CleanArchiteture.Applications.LocacaoApi.Server
    in 'CleanArchiteture.Applications.LocacaoAPI.Server.pas';

begin
  try
    Start;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
