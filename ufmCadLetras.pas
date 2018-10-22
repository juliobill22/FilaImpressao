unit ufmCadLetras;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, generics.collections,
  uImpressao, FMX.StdCtrls, FMX.ListBox, FMX.Controls.Presentation, FMX.Objects,
  uDocumentos;
type
  TForm3 = class(TForm)
    chkA: TCheckBox;
    chkB: TCheckBox;
    chkC: TCheckBox;
    chkD: TCheckBox;
    chkE: TCheckBox;
    chkF: TCheckBox;
    chkG: TCheckBox;
    chkH: TCheckBox;
    chkI: TCheckBox;
    chkJ: TCheckBox;
    chkL: TCheckBox;
    chkM: TCheckBox;
    chkN: TCheckBox;
    chkO: TCheckBox;
    chkP: TCheckBox;
    chkQ: TCheckBox;
    chkR: TCheckBox;
    chkS: TCheckBox;
    chkT: TCheckBox;
    chkU: TCheckBox;
    chkV: TCheckBox;
    chkX: TCheckBox;
    chkW: TCheckBox;
    chkY: TCheckBox;
    chkZ: TCheckBox;
    btnGravar: TButton;
    ComboBox1: TComboBox;
    cbImpressoraFila: TLabel;
    Line1: TLine;
    chkK: TCheckBox;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure addChecks(vDocumento : TDocumento);
    procedure clearChecks;
  private
    FListImpressao : TList<TImpressao>;
  public
    constructor Create(AOwner: TComponent; const pListImpressao: TList<TImpressao>);
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.btnGravarClick(Sender: TObject);
var vDocumento : TDocumento;
    i : Integer;
    itemSelected : Integer;
begin
  if ComboBox1.Count > 0 then
  begin
    itemSelected := ComboBox1.Selected.Index;

    vDocumento:= TDocumento.Create;
    vDocumento.CodigoFila := itemSelected;

    addChecks(vDocumento);

    vDocumento.CodigoFila := FListImpressao.Items[itemSelected].getQtdeDocsFila + 1;
    FListImpressao.Items[ComboBox1.Selected.Index].addDocsFila(vDocumento);
    FListImpressao.Items[ComboBox1.Selected.Index].Status := 'R';

    for I := 0 to FListImpressao.Count-1 do
      FListImpressao.Items[i].ItemSelec:= 0;

    FListImpressao.Items[ComboBox1.Selected.Index].ItemSelec := itemSelected;

    clearChecks;

    ShowMessage('O documento '+ IntToStr(vDocumento.CodigoFila) +
                ' foi enviado pra fila de impressão [' + FListImpressao.Items[ComboBox1.Selected.Index].Nome + ']');

  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Close;
end;

constructor TForm3.Create(AOwner: TComponent; const pListImpressao: TList<TImpressao>);
begin
  inherited Create(AOwner);
  FListImpressao := pListImpressao;
end;

procedure TForm3.FormShow(Sender: TObject);
var i : Integer;
begin
  for i := 0 to FListImpressao.Count-1 do
  begin
    ComboBox1.Items.AddObject(
        IntToStr(FListImpressao.Items[i].Codigo) + ' - ' +
        FListImpressao.Items[i].Nome
      , Tobject(Integer(i)));
  end;
end;

procedure TForm3.addChecks(vDocumento : TDocumento);
begin
  if chkA.Data.AsBoolean then
    vDocumento.addLetra('A');
  if chkB.Data.AsBoolean then
    vDocumento.addLetra('B');
  if chkC.Data.AsBoolean then
    vDocumento.addLetra('C');
  if chkD.Data.AsBoolean then
    vDocumento.addLetra('D');
  if chkE.Data.AsBoolean then
    vDocumento.addLetra('E');
  if chkF.Data.AsBoolean then
    vDocumento.addLetra('F');
  if chkG.Data.AsBoolean then
    vDocumento.addLetra('G');
  if chkH.Data.AsBoolean then
    vDocumento.addLetra('H');
  if chkI.Data.AsBoolean then
    vDocumento.addLetra('I');
  if chkJ.Data.AsBoolean then
    vDocumento.addLetra('J');
  if chkL.Data.AsBoolean then
    vDocumento.addLetra('L');
  if chkM.Data.AsBoolean then
    vDocumento.addLetra('M');
  if chkN.Data.AsBoolean then
    vDocumento.addLetra('N');
  if chkO.Data.AsBoolean then
    vDocumento.addLetra('O');
  if chkP.Data.AsBoolean then
    vDocumento.addLetra('P');
  if chkQ.Data.AsBoolean then
    vDocumento.addLetra('Q');
  if chkR.Data.AsBoolean then
    vDocumento.addLetra('R');
  if chkS.Data.AsBoolean then
    vDocumento.addLetra('S');
  if chkT.Data.AsBoolean then
    vDocumento.addLetra('T');
  if chkU.Data.AsBoolean then
    vDocumento.addLetra('U');
  if chkV.Data.AsBoolean then
    vDocumento.addLetra('V');
  if chkX.Data.AsBoolean then
    vDocumento.addLetra('X');
  if chkZ.Data.AsBoolean then
    vDocumento.addLetra('Z');
  if chkW.Data.AsBoolean then
    vDocumento.addLetra('W');
  if chkY.Data.AsBoolean then
    vDocumento.addLetra('Y');
  if chkK.Data.AsBoolean then
    vDocumento.addLetra('K');
  if chkZ.Data.AsBoolean then
    vDocumento.addLetra('Z');
end;

procedure TForm3.clearChecks;
begin
  chkA.Data:= False;
  chkB.Data:= False;
  chkC.Data:= False;
  chkD.Data:= False;
  chkE.Data:= False;
  chkF.Data:= False;
  chkG.Data:= False;
  chkH.Data:= False;
  chkI.Data:= False;
  chkJ.Data:= False;
  chkL.Data:= False;
  chkM.Data:= False;
  chkN.Data:= False;
  chkO.Data:= False;
  chkP.Data:= False;
  chkQ.Data:= False;
  chkR.Data:= False;
  chkS.Data:= False;
  chkT.Data:= False;
  chkU.Data:= False;
  chkV.Data:= False;
  chkX.Data:= False;
  chkZ.Data:= False;
  chkW.Data:= False;
  chkY.Data:= False;
  chkK.Data:= False;
  chkZ.Data:= False;
end;


end.
