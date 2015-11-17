unit uGeracaoArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Vcl.StdCtrls, Vcl.ExtCtrls, FileCtrl,
  System.UITypes;

type
  TfGeracaoArquivo = class(TfFormBase)
    Panel1: TPanel;
    dirListBox: TDirectoryListBox;
    pnArquivo: TPanel;
    lblNomeArquivo: TLabel;
    lblNome: TLabel;
    edtNome: TEdit;
    btnGerar: TButton;
    Label1: TLabel;
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fGeracaoArquivo: TfGeracaoArquivo;

implementation

{$R *.dfm}

uses uDMImportacao;

procedure TfGeracaoArquivo.btnGerarClick(Sender: TObject);
begin
  inherited;
  try
    DMImportacao.Importar(lblNomeArquivo.Caption+'\'+edtNome.Text+'.CT');
    MessageDlg('Arquivo gerado com sucesso em: '+ lblNomeArquivo.Caption, mtInformation, [mbOK], 0);
  except
    raise Exception.Create('Ocorreu um erro na geração do arquivo!');
  end;
end;

end.
