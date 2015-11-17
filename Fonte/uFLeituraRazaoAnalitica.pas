unit uFLeituraRazaoAnalitica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Vcl.ExtDlgs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.UITypes;

type
  TfLeituraRazaoAnalitica = class(TfFormBase)
    Panel1: TPanel;
    btnSair: TButton;
    btnLogErros: TButton;
    btnExcluirImportacao: TButton;
    btnNovaImportacao: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    PageControl: TPageControl;
    tsConsulta: TTabSheet;
    Panel2: TPanel;
    gridImportacao: TDBGrid;
    dsRazao: TDataSource;
    OpenTextFile: TOpenTextFileDialog;
    procedure btnNovaImportacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirImportacaoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLeituraRazaoAnalitica: TfLeituraRazaoAnalitica;

implementation

{$R *.dfm}

uses uDMRazaoAnalitica, uFuncoes, uDMConexao;

procedure TfLeituraRazaoAnalitica.btnExcluirImportacaoClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja desfazer a importação?', mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if not DMRazaoAnalitica.QueryImportacao.IsEmpty then
    begin
      DMRazaoAnalitica.QueryImportacao.Delete;
      DMRazaoAnalitica.QueryImportacao.Refresh;
    end;
  end;
end;

procedure TfLeituraRazaoAnalitica.btnNovaImportacaoClick(Sender: TObject);
var
  cod: Integer;
  desc: string;
begin
  inherited;
  if OpenTextFile.Execute then
  begin
    if OpenTextFile.FileName <> '' then
    begin
      if InputQuery('Gerador Arquivo Contábil','Digite uma descrição:',desc) then
      begin
        cod := TFuncoes.GetCodigoImportacao('R', desc);
        if cod <> 0 then
          DMRazaoAnalitica.ImportarRazao(cod, OpenTextFile.FileName);
      end;
    end;
  end;
  dsRazao.DataSet.Refresh;
end;

procedure TfLeituraRazaoAnalitica.btnSairClick(Sender: TObject);
begin
  inherited;
  CLose;
end;

procedure TfLeituraRazaoAnalitica.FormShow(Sender: TObject);
begin
  inherited;
  if DMConexao.VerificaConexaoAC then
  begin
    if DMRazaoAnalitica.QueryImportacao.Active then
    begin
      DMRazaoAnalitica.QueryImportacao.Close;
      DMRazaoAnalitica.QueryImportacao.Open;
    end
    else
      DMRazaoAnalitica.QueryImportacao.Open;
  end;
end;

end.
