unit UDTOLocacao;

interface

type

  DTOLocacao = class
    Id: Integer;
    ClienteId: Integer;
    DataLocacao: TDateTime;
    DataDevolucao: TDateTime;
    Status: String;
  end;

implementation

end.
