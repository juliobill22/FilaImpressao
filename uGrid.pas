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
        class procedure refrehGrid(const Grid : TGrid; const List : TList<TImpressao>);
        class procedure populaGrid(const Grid : TGrid; const List : TList<TImpressao>);
        class procedure processaImpressao(
          Grid : TGrid;
          List : TList<TImpressao>;
          Action : tAction);
      published
    end;

implementation

uses System.SysUtils, uDocumentos, FMX.Dialogs;

class procedure TGridList.refrehGrid(const Grid : TGrid; const List : TList<TImpressao>);
begin
  Grid.RowCount:= 0;
  Grid.RowCount:= List.Count;
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

  for i := 0 to List.Count-1 do
  begin
    case List.Items[i].Status of
      'R': processaImpressao(Grid, List, AcRunning); //running
      'T': processaImpressao(Grid, List, AcRestart); //paused
    end;
  end;

  refrehGrid(Grid, List);

end;

class procedure TGridList.processaImpressao(
  Grid : TGrid;
  List : TList<TImpressao>;
  Action : tAction);

var i, y, z : integer;
    letra : Char;
    docu : TDocumento;

    procedure clearDocsImpressos;
    var i, y : integer;
    begin
      for i := 0 to List.Count-1 do
      begin
        if (List.Items[i].getQtdeDocsFila > 0) then
        begin
          for y := 0 to List.Items[i].DocsFila.Count-1 do
            List.Items[i].DocsImpresso.Clear;
        end;
      end;
    end;

    procedure setStado(Index : Integer; ac : tAction);
    begin
      case Action of
        AcRunning: List.Items[Index].Status := 'P';
        AcRestart: List.Items[Index].Status := 'R';
      end;
    end;

begin
  try
    clearDocsImpressos;
    case Action of
      AcRunning:
        begin
          for i := 0 to List.Count-1 do
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
                end;
              end;
            end;
            setStado(i, AcRunning);
          end;
        end;

      AcRestart:
        begin
          for i := 0 to List.Count-1 do
          begin
            setStado(i, AcRestart);
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
                end;
              end;
            end;
            setStado(i, AcRunning);
          end;
        end;
    end;
  finally
  end;
end;

end.
