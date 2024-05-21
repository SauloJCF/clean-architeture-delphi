unit UIUseCaseCliente;

interface

uses
  UCliente, UResponse, UDTOCliente;

type

  IUseCaseCliente = interface
    ['{9C679D6A-7D8D-41A3-AEC5-2A8EB7F83CB0}']

    function Cadastrar(const Cliente: TCliente): TResponse;
    function Alterar(const Cliente: TCliente): TResponse;
    function Deletar(const Id: Integer): TResponse;
    function Consultar(const Dto: DTOCliente): TResponse;
  end;

implementation

end.
