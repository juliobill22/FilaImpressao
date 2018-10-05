unit uImpressao;

interface

uses Classes, generics.collections, uDocumentos;

  type
    tAction = (AcRunning, AcRestart);

    TImpressao = class
     strict private
        FCodigo      : Integer;
        FNome        : String;
        FTempo       : Integer;
        FDataCriacao : TDateTime;
        FStatus      : Char;
        FLetraAtual  : Char;
        FDocsFila    : TList<TDocumento>;
        FDocsImpresso: TList<TDocumento>;
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
        procedure addDocsFila(const aDocumento : TDocumento);
        procedure delDocsFila;
        function getDocsFila : String;
        function getQtdeDocsFila : Integer;
        procedure addDocsImpresso(const aDocumento : TDocumento);
        procedure delDocsImpresso;
        function getDocsImpresso : String;
        procedure processaImpressao(Action : tAction);
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
  self.FDocsFila.add(aDocumento);
end;

procedure TImpressao.addDocsImpresso(const aDocumento: TDocumento);
begin
  self.FDocsImpresso.add(aDocumento);
end;

function TImpressao.getQtdeDocsFila : Integer;
begin
  if (self.FDocsFila <> nil) then
    result := self.FDocsFila.Count
  else
    result := 0;
end;

procedure TImpressao.processaImpressao(Action : tAction);
var i, y : integer;
begin
  if (Action = AcRunning) then
  begin
    for i := 0 to FDocsFila.Count-1 do
    begin
      FDocsImpresso.Add(FDocsFila.Items[i]);
      for y := 0 to FDocsFila[i].Letras.Count-1 do
      begin
        FDocsImpresso.Items[i].addLetra(FDocsFila.Items[i].Letras[y]);
        FLetraAtual:= FDocsFila.Items[i].Letras[y];
        sleep(FTempo);
      end;
    end;
    FStatus := 'P';
  end
  else if (Action = AcRestart) then
  begin
    for i := 0 to FDocsImpresso.Count-1 do
    begin
      FDocsImpresso.Delete(i);
      FLetraAtual:= FDocsFila.Items[i].Letras[0];
      sleep(FTempo);
    end;
    FStatus := 'R';
  end;
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
var i : integer;
begin
  FreeAndNil(self.FDocsFila);
end;

procedure TImpressao.delDocsImpresso;
begin
  FreeAndNil(self.FDocsImpresso);
end;

destructor TImpressao.Destroy;
begin
  inherited;
end;

end.
