unit uThread;

interface

uses
  System.Classes, FMX.Grid, generics.collections, uImpressao;

type
  TThreadListaImpressao = class(TThread)
  private
    FGrid : TGrid;
    FList : TList<TImpressao>;
    FAction : tAction;
    FItem : Integer;
  protected
  public
    procedure Execute; override;
    property Grid  : TGrid read FGrid write FGrid;
    property List  : TList<TImpressao> read FList write FList;
    property Action: tAction read FAction write FAction;
    property Item  : Integer read FItem  write FItem;
  end;

implementation

uses uGrid;

procedure TThreadListaImpressao.Execute;
begin
  TGridList.processaImpressao(FGrid, Flist, FAction, FItem);
end;

end.
