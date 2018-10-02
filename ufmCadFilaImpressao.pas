unit ufmCadFilaImpressao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, generics.collections, uImpressao,
  FMX.Objects, uThread;

type
  TForm2 = class(TForm)
    Código: TLabel;
    Nome: TLabel;
    Velocidade: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtVelocidade: TEdit;
    btnGravar: TButton;
    btnFechar: TButton;
    Line1: TLine;
    procedure btnGravarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FListImpressao : TList<TImpressao>;
    FListThread : Tlist<TThread>;
  public
    constructor Create(AOwner: TComponent;
      const pListImpressao: TList<TImpressao>;
      const pListThread : Tlist<TThread>);
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.btnFecharClick(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.btnGravarClick(Sender: TObject);
var vImpressao : TImpressao;
    vThread    : TImpressaoInThread;
begin
  if (edtCodigo.Text = '') then
  begin
    ShowMessage('Informe o código!');
    edtCodigo.SetFocus;
  end
  else if (edtNome.Text = '') then
  begin
    ShowMessage('Informe o Nome!');
    edtNome.SetFocus;
  end
  else if (edtVelocidade.Text = '') then
  begin
    ShowMessage('Informe a velocidade!');
    edtVelocidade.SetFocus;
  end
  else
  begin
    vImpressao := TImpressao.Create;
    vImpressao.Codigo := StrToInt(edtCodigo.Text);
    vImpressao.Nome   := edtNome.Text;
    vImpressao.Tempo  := StrToInt(edtVelocidade.Text);
    vImpressao.DataCriacao := Now;
    vImpressao.Status := 'R';
    edtCodigo.Text    := '';
    edtNome.Text      := '';
    edtVelocidade.Text:= '';
    edtCodigo.SetFocus;
    FListImpressao.Add(vImpressao);

    vThread     := TImpressaoInThread.Create(false);
    FListThread := Tlist<TThread>.Create;
    FListThread.Add(vThread);

    ShowMessage('A impressão '+ edtNome.Text + ' foi gerada com sucesso!')

  end;
end;

Constructor TForm2.Create(AOwner: TComponent;
  const pListImpressao: TList<TImpressao>;
  const pListThread : Tlist<TThread>);
var vImpressao : TImpressao;
begin
  inherited Create(AOwner);
  FListImpressao := pListImpressao;
  FListThread := pListThread;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  edtCodigo.SetFocus;
end;

end.
