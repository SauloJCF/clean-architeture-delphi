unit UResponse;

interface

uses
  System.Generics.Collections;

type
  TResponse = record
    Success: Boolean;
    ErrorCode: Integer;
    Message: String;
    Data: TList<TObject>;
  end;

implementation

end.
