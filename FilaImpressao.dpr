program FilaImpressao;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufmFilaImpressao in 'ufmFilaImpressao.pas' {Form1},
  uImpressao in 'uImpressao.pas',
  uDocumentos in 'uDocumentos.pas',
  ufmCadFilaImpressao in 'ufmCadFilaImpressao.pas' {Form2},
  uGrid in 'uGrid.pas',
  ufmCadLetras in 'ufmCadLetras.pas' {Form3},
  uThread in 'uThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
