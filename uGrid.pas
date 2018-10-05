unit uGrid;

interface

uses System.Rtti, FMX.Grid, generics.collections, uImpressao;

  type
    TGridList = class
      private
        FGrid : TGrid;
        FList : TList<TImpressao>;
      protected
      public
        class procedure populaGrid(const Grid : TGrid; const List : TList<TImpressao>);
      published
    end;

implementation

uses System.SysUtils;

{ TGridList }

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

  procedure refreshGrid;
  begin
    Grid.RowCount:= 0;
    Grid.RowCount:= List.Count;
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
      'R': List.Items[i].processaImpressao(AcRunning); //running
      'T': List.Items[i].processaImpressao(AcRestart); //paused
    end;
  end;

  refreshGrid;

end;

end.
