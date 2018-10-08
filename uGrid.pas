unit uGrid;

interface

uses System.Rtti, FMX.Grid, generics.collections, uImpressao, FMX.Types;

  type

    TGridList = class
      private
        FGrid : TGrid;
        FList : TList<TImpressao>;
      protected
      public
        class procedure setStado(Index : Integer; Action : tAction; const List : TList<TImpressao>);
        class procedure clearDocsImpressos(const List : TList<TImpressao>; Item : Integer);
        class procedure refrehGrid(const Grid : TGrid; const List : TList<TImpressao>);
        class procedure populaGrid(const Grid : TGrid; const List : TList<TImpressao>);
        class procedure processaImpressao(Grid : TGrid; List : TList<TImpressao>; Action : tAction; Item : Integer);
        class procedure processaImpressaoAll(Grid : TGrid; List : TList<TImpressao>; Action : tAction);
        class procedure imprDocList(i : Integer; List : TList<TImpressao>);
      published
    end;

implementation

uses System.SysUtils, uDocumentos, FMX.Dialogs;

class procedure TGridList.refrehGrid(const Grid : TGrid; const List : TList<TImpressao>);
begin
  Grid.RowCount:= 0;
  Grid.RowCount:= List.Count;
end;

class procedure TGridList.setStado(Index: Integer; Action: tAction;
  const List: TList<TImpressao>);
begin
  case Action of
    AcRunning: List.Items[Index].Status:= 'R';
    AcRestart: List.Items[Index].Status:= 'T';
    AcStop   : List.Items[Index].Status:= 'S';
  end;
end;

class procedure TGridList.populaGrid(const Grid : TGrid; const List : TList<TImpressao>);
  var i : integer;
  procedure createColumn(Name: String; Header: String; width : integer);
   var col : TColumn;
  begin
    col := TColumn.Create(Nil);
    col.Name   := 'cl'+ Name;
    col.Header := Header;
    col.Width  := width;
    Grid.AddObject(col);
  end;
begin
  with Grid do
  begin
    if Grid.ColumnCount = 0 then
    begin
      createColumn('clcodigo','Código', 50);
      createColumn('clnome','Nome', 120);
      createColumn('cltempoimpress', 'Tempo', 50);
      createColumn('cldatacria', 'Data Criação', 130);
      createColumn('clstatusimpres','Status', 50);
      createColumn('clletraimpressa', 'Letra', 40);
      createColumn('cldocfila','Docs. fila', 200);
      createColumn('cldocimpres', 'Docs. impressos', 200);
    end;
  end;
  refrehGrid(Grid, List);
end;

class procedure TGridList.imprDocList(i : Integer; List : TList<TImpressao>);
var y, z : integer;
    letra : Char;
    docu : TDocumento;
begin
  if (List.Items[i].getQtdeDocsFila > 0) then
  begin
    for y := 0 to List.Items[i].DocsFila.Count-1 do
    begin
      docu := TDocumento.Create;
      List.Items[i].DocsImpresso.Add(docu);
      for z := 0 to List.Items[i].DocsFila[y].Letras.Count-1 do
      begin
        letra := List.Items[i].DocsFila.Items[y].getLetras(z);
        List.Items[i].DocsImpresso.Items[y].addLetra(letra);
        List.Items[i].LetraAtual := letra;
        sleep(List.Items[i].Tempo);
      end;
    end;
  end;
end;

class procedure TGridList.processaImpressao(
  Grid : TGrid;
  List : TList<TImpressao>;
  Action : tAction;
  Item : Integer);
begin
  try
    clearDocsImpressos(List, Item);
    case Action of
      AcRunning:
        begin
          imprDocList(Item, List);
          setStado(Item, AcStop, List);
        end;
      AcRestart:
        begin
          setStado(Item, AcRestart, List);
          imprDocList(Item, List);
          setStado(Item, AcStop, List);
        end;
    end;
  finally
  end;
end;

class procedure TGridList.processaImpressaoAll(
  Grid : TGrid;
  List : TList<TImpressao>;
  Action : tAction);
var i : Integer;
begin
  for i := 0 to List.Count-1 do
    processaImpressao(Grid, List, Action, i);
end;

class procedure TGridList.clearDocsImpressos(const List : TList<TImpressao>; Item : Integer);
var y : integer;
begin
  if (List.Items[Item].getQtdeDocsFila > 0) then
    List.Items[Item].DocsImpresso.Clear;
end;

end.
