unit CleanArchiteture.Core.DTO.DTOLocacao;

interface

type

  DTOLocacao = record
    Id: Integer;
    IdCliente: Integer;
    DataLocacao: TDateTime;
    DataDevolucao: TDateTime;
    Status: String;
  end;

implementation

end.
