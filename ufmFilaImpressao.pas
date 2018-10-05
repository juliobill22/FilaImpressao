unit ufmFilaImpressao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, generics.collections, uImpressao,
  System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid;

type
  TForm1 = class(TForm)
    btnCadImpressao: TButton;
    Button1: TButton;
    Grid1: TGrid;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    labelautoria: TLabel;
    procedure btnCadImpressaoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    FListImpressao : TList<TImpressao>;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses ufmCadFilaImpressao, uGrid, ufmCadLetras;

procedure TForm1.btnCadImpressaoClick(Sender: TObject);
begin
  Form2 := TForm2.Create(Application, FListImpressao);
  Form2.ShowModal;
  TGridList.populaGrid(Grid1, FListImpressao);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form3 := TForm3.Create(Application, FListImpressao);
  Form3.ShowModal;
  TGridList.populaGrid(Grid1, FListImpressao);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Grid1.RowCount > 0 then
  begin
    if Grid1.Selected < 0 then
      ShowMessage('Selecione a impressão que será parada!')
    else
    begin
      if (FListImpressao.Items[Grid1.Selected].DocsFila.Count <> 0) then
        FListImpressao.Items[Grid1.Selected].Status := 'P'
      else
        ShowMessage('Nenhuma letra com documento cadastrada!');
    end;
  end;
  TGridList.populaGrid(Grid1, FListImpressao);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if Grid1.RowCount > 0 then
  begin
    if Grid1.Selected < 0 then
      ShowMessage('Selecione a impressão que serão excluídos os documentos!')
    else
    begin
      if (MessageDlg('Deseja excluir os documentos da impressão ''' + FListImpressao.Items[Grid1.Selected].Nome + '''', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes) then
      begin
        FListImpressao.Items[Grid1.Selected].delDocsFila;
        FListImpressao.Items[Grid1.Selected].delDocsImpresso;
        FListImpressao.Items[Grid1.Selected].LetraAtual := #0;
        FListImpressao.Items[Grid1.Selected].Status := Char('R');
      end;
    end;
  end;
  TGridList.populaGrid(Grid1, FListImpressao);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if Grid1.RowCount > 0 then
  begin
    if Grid1.Selected < 0 then
      ShowMessage('Selecione a impressão que será reiniciada!')
    else
    begin
      if (FListImpressao.Items[Grid1.Selected].DocsFila.Count <> 0) then
      begin
        FListImpressao.Items[Grid1.Selected].Status := 'T';
      end
      else
        ShowMessage('Nenhuma letra com documento cadastrada!');
    end;
  end;
  TGridList.populaGrid(Grid1, FListImpressao);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if Grid1.RowCount > 0 then
  begin
    if Grid1.Selected < 0 then
      ShowMessage('Selecione a impressão que será excluída!')
    else
    begin
      if (MessageDlg('Deseja excluir a impressão ''' + FListImpressao.Items[Grid1.Selected].Nome + '''', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes) then
        FListImpressao.Delete(Grid1.Selected);
    end;
  end;
  TGridList.populaGrid(Grid1, FListImpressao);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  TGridList.populaGrid(Grid1, FListImpressao);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FListImpressao := TList<TImpressao>.Create();
  TGridList.populaGrid(Grid1, FListImpressao);
end;

procedure TForm1.Grid1GetValue(Sender: TObject; const ACol, ARow: Integer;
  var Value: TValue);
begin
  if ARow < FListImpressao.Count then
  begin
    if ACol = 0 then
      Value := FListImpressao.Items[ARow].Codigo
    else if ACol = 1 then
      Value := FListImpressao.Items[ARow].Nome
    else if ACol = 2 then
      Value := FListImpressao.Items[ARow].Tempo
    else if ACol = 3 then
      Value := FormatDateTime('dd/mm/yyyy hh:mm:ss', FListImpressao.Items[ARow].DataCriacao)
    else if ACol = 4 then
    begin
      case FListImpressao.Items[ARow].Status of
        'P' : Value := 'Parado';
        'R' : Value := 'Iniciado';
      end;
    end
    else if ACol = 5 then
      Value := FListImpressao.Items[ARow].LetraAtual
    else if ACol = 6 then
      Value := FListImpressao.Items[ARow].getDocsFila
    else if ACol = 7 then
      Value := FListImpressao.Items[ARow].getDocsImpresso;
  end;
end;

end.
