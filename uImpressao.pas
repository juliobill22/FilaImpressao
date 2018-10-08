unit uImpressao;

interface

uses Classes, generics.collections, uDocumentos, FMX.Grid;

  type

    tAction = (AcRunning, AcRestart, AcStop);

    TImpressao = class
     private
        FCodigo      : Integer;
        FNome        : String;
        FTempo       : Integer;
        FDataCriacao : TDateTime;
        FStatus      : Char;
        FLetraAtual  : Char;
        FDocsFila    : TList<TDocumento>;
        FDocsImpresso: TList<TDocumento>;
        FItemSelec   : Integer;
      protected
      public
        constructor Create;
        Destructor Destroy; override;
        property Codigo : Integer read FCodigo write FCodigo;
        property Nome : String read FNome write FNome;
        property Tempo : Integer read FTempo write FTempo;
        property DataCriacao : TDateTime read FDataCriacao write FDataCriacao;
        property Status : Char read FStatus write FStatus;
        property LetraAtual : Char read FLetraAtual write FLetraAtual;
        property DocsFila : TList<TDocumento> read FDocsFila;
        property DocsImpresso : TList<TDocumento> read FDocsImpresso;
        property ItemSelec : Integer read FItemSelec write FItemSelec;
        procedure addDocsFila(const aDocumento : TDocumento);
        procedure delDocsFila;
        function getDocsFila : String;
        function getQtdeDocsFila : Integer;
        function getQtdeDocsImpresso : Integer;
        procedure addDocsImpresso(const aDocumento : TDocumento);
        procedure delDocsImpresso;
        function getDocsImpresso : String;
        function getListDocsFila: TList<TDocumento>;
        function getListDocsImpresso : TList<TDocumento>;
        function getDocImpresso(Index : Integer) : TDocumento;
        function getDocFila(Index : Integer) : TDocumento;
      published
    end;

implementation

uses SysUtils, FMX.Dialogs;

constructor TImpressao.Create;
begin
  inherited Create;
  if (self.FDocsFila = nil) then
    self.FDocsFila := TList<TDocumento>.Create;
  if (self.FDocsImpresso = nil) then
    self.FDocsImpresso := TList<TDocumento>.Create;
end;

procedure TImpressao.addDocsFila(const aDocumento: TDocumento);
begin
  if (self.FDocsFila = nil) then
    self.FDocsFila := TList<TDocumento>.Create;
  self.FDocsFila.add(aDocumento);
end;

procedure TImpressao.addDocsImpresso(const aDocumento: TDocumento);
begin
  if (FDocsImpresso = nil) then
    FDocsImpresso := TList<TDocumento>.Create;
  FDocsImpresso.add(aDocumento);
end;

function TImpressao.getQtdeDocsFila : Integer;
begin
  if (self.FDocsFila <> nil) then
    result := self.FDocsFila.Count
  else
    result := 0;
end;

function TImpressao.getQtdeDocsImpresso : Integer;
begin
  if (self.FDocsImpresso <> nil) then
    result := self.FDocsImpresso.Count
  else
    result := 0;
end;

function TImpressao.getDocFila(Index: Integer): TDocumento;
begin
  result := FDocsFila.Items[Index];
end;

function TImpressao.getDocImpresso(Index: Integer): TDocumento;
begin
  result := FDocsImpresso.Items[Index];
end;

function TImpressao.getDocsFila : String;
var i, y : integer;
begin
  if (self.FDocsFila <> nil) then
  begin
    for i := 0 to self.FDocsFila.Count-1 do
    begin
      result :=
        result +
          ' Doc: ' + IntToStr(self.FDocsFila.Items[i].CodigoFila) + ' Letras: ';
      for y := 0 to self.FDocsFila.Items[i].Letras.Count-1 do
        result :=
          result +
            self.FDocsFila.Items[i].Letras[y] + ';';
    end;
  end;
end;

function TImpressao.getListDocsFila: TList<TDocumento>;
begin
  if (self.FDocsFila = nil) then
    self.FDocsFila := TList<TDocumento>.Create;
  result := self.FDocsFila;
end;

function TImpressao.getListDocsImpresso: TList<TDocumento>;
begin
  if (self.FDocsImpresso = nil) then
    self.FDocsImpresso := TList<TDocumento>.Create;
  result := self.FDocsImpresso;
end;

function TImpressao.getDocsImpresso : String;
var i, y : integer;
begin
  if (self.FDocsImpresso <> nil) then
  begin
    for i := 0 to self.FDocsImpresso.Count-1 do
    begin
      result :=
        result +
          ' Doc: ' + IntToStr(self.FDocsImpresso.Items[i].CodigoFila) + ' Letras: ';
      for y := 0 to self.FDocsImpresso.Items[i].Letras.Count-1 do
        result :=
          result +
            self.FDocsImpresso.Items[i].Letras[y] + ';';
    end;
  end;
end;

procedure TImpressao.delDocsFila;
begin
  FreeAndNil(FDocsFila);
  FDocsFila := TList<TDocumento>.Create;
end;

procedure TImpressao.delDocsImpresso;
begin
  FreeAndNil(FDocsImpresso);
  FDocsImpresso := TList<TDocumento>.Create;
end;

destructor TImpressao.Destroy;
begin
  inherited;
end;

end.
