unit uDocumentos;

interface

uses Classes, generics.collections;

  type
    TDocumento = class
      private
        FCodigoFila : Integer;
        FLetras     : TList<Char>;
      protected
      public
        constructor Create;
        destructor Destroy;
        property CodigoFila : Integer read FCodigoFila write FCodigoFila;
        property Letras : TList<Char> read FLetras;
        procedure addLetra(const aLetra : Char);
        procedure delLetra(Index : Integer);
        function getLetras(Index : Integer) : Char;
      published
    end;

implementation

procedure TDocumento.addLetra(const aLetra: Char);
begin
  if FLetras = nil then
    FLetras := TList<Char>.Create;
  FLetras.Add(aLetra);
end;

constructor TDocumento.Create;
begin
  inherited
end;

procedure TDocumento.delLetra(Index: Integer);
begin
  if FLetras <> nil then
    FLetras.Delete(Index);
end;

destructor TDocumento.Destroy;
begin
  inherited Destroy;
end;

function TDocumento.getLetras(Index : Integer) : Char;
var i : integer;
begin
  if FLetras <> nil then
    result := FLetras.Items[Index];
end;

end.
