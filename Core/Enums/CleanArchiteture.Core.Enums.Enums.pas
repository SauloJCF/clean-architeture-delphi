unit CleanArchiteture.Core.Enums.Enums;

interface

type
  Status = (Disponivel, Alugado);

  TErrosCode = record
    NOME_NAO_INFORMADO, NOME_INVALIDO, DOCUMENTO_NAO_INFORMADO,
      DOCUMENTO_INVALIDO, TELEFONE_NAO_INFORMADO, TELEFONE_INVALIDO,
      ID_INVALIDO, PLACA_NAO_INFORMADA, PLACA_INVALIDA, VALOR_INVALIDO,
      VEICULO_NAO_INFORMADO, CLIENTE_NAO_INFORMADO, VEICULO_ALUGADO,
      ERRO_BANCO_DADOS: Integer;
  end;

  TMsgResponse = record
    CADASTRADO_COM_SUCESSO, ALTERADO_COM_SUCESSO, DELETADO_COM_SUCESSO,
      CONSULTA_REALIZADA_COM_SUCESSO, CONSULTA_SEM_RETORNO,
      VEICULO_NAO_INFORMADO, CLIENTE_NAO_INFORMADO, VEICULO_ALUGADO: string;
  end;

function RetornarMsgResponse: TMsgResponse;
function RetornarErrorsCode: TErrosCode;

implementation

function RetornarMsgResponse: TMsgResponse;
begin
  Result.CADASTRADO_COM_SUCESSO := 'Cadastrado com sucesso!';
  Result.ALTERADO_COM_SUCESSO := 'Alterado com sucesso!';
  Result.DELETADO_COM_SUCESSO := 'Deletado com sucesso!';
  Result.CONSULTA_REALIZADA_COM_SUCESSO := 'Consulta realizada com sucesso!';
  Result.CONSULTA_SEM_RETORNO := 'Consulta sem retorno!';
  Result.VEICULO_NAO_INFORMADO := 'Veículo não informado!';
  Result.CLIENTE_NAO_INFORMADO := 'Cliente não informado!';
  Result.VEICULO_ALUGADO := 'Veículo alugado!';
end;

function RetornarErrorsCode: TErrosCode;
begin
  Result.NOME_NAO_INFORMADO := 100;
  Result.NOME_INVALIDO := 101;
  Result.DOCUMENTO_NAO_INFORMADO := 102;
  Result.DOCUMENTO_INVALIDO := 103;
  Result.TELEFONE_NAO_INFORMADO := 104;
  Result.TELEFONE_INVALIDO := 105;
  Result.ID_INVALIDO := 106;
  Result.PLACA_NAO_INFORMADA := 107;
  Result.PLACA_INVALIDA := 108;
  Result.VALOR_INVALIDO := 109;
  Result.VEICULO_NAO_INFORMADO := 110;
  Result.CLIENTE_NAO_INFORMADO := 111;
  Result.VEICULO_ALUGADO := 112;
  Result.ERRO_BANCO_DADOS := 113;
end;

end.
