unit uFImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfImportacao = class(TfFormBase)
    ProgressBar: TProgressBar;
    lblTitulo: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetTituloImportacao(const Value: String);
    procedure Inicializa(aMax: Integer);
    procedure NextProgress;
  end;

var
  fImportacao: TfImportacao;

implementation

{$R *.dfm}

{ TfImportacao }

procedure TfImportacao.Inicializa(aMax: Integer);
begin
  ProgressBar.Position := 0;
  ProgressBar.Max := aMax;
  Application.ProcessMessages;
end;

procedure TfImportacao.NextProgress;
begin
  ProgressBar.Position := ProgressBar.Position + ProgressBar.Step;
  Application.ProcessMessages;
end;

procedure TfImportacao.SetTituloImportacao(const Value: String);
begin
  lblTitulo.Caption := Value;
end;

end.
