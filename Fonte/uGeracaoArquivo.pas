unit uGeracaoArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.FileCtrl,
  System.UITypes, ufSelRazao;

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

//uses uDMImportacao;

procedure TfGeracaoArquivo.btnGerarClick(Sender: TObject);
var
  Codigo: Integer;
  Caminho: String;
begin
  inherited;
  try
    Codigo := TfSelRazao.Inicializa;
    if Codigo < 0 then
    begin
      ShowMessage('É necessario selecionar um arquivo para geração.');
      Exit;
    end;
    Caminho := lblNomeArquivo.Caption+'\'+edtNome.Text+'.CT';
    DMImportacao.Importar(Caminho, Codigo);
    MessageDlg('Arquivo gerado com sucesso em: '+ lblNomeArquivo.Caption, mtInformation, [mbOK], 0);
  except
    raise Exception.Create('Ocorreu um erro na geração do arquivo!');
  end;
end;

end.
