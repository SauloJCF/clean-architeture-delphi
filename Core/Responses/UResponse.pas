unit UResponse;

interface

uses
  System.Generics.Collections;

type
  TResponse = record
    Success: Boolean;
    ErrorCode: Integer;
    Message: String;
    Data: TObjectList<TObject>;
  end;

implementation

end.
