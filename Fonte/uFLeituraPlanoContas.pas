unit uFLeituraPlanoContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Data.DB,
  Vcl.ComCtrls, Vcl.ExtDlgs, System.UITypes, Datasnap.DBClient;

type
  TfLeituraPlanoContas = class(TfFormBase)
    Panel1: TPanel;
    btnSair: TButton;
    btnLogErros: TButton;
    btnExcluirImportacao: TButton;
    btnNovaImportacao: TButton;
    dsPlanoDeContas: TDataSource;
    PageControl: TPageControl;
    tsConsulta: TTabSheet;
    Panel2: TPanel;
    gridImportacao: TDBGrid;
    OpenTextFile: TOpenTextFileDialog;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovaImportacaoClick(Sender: TObject);
    procedure btnExcluirImportacaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLeituraPlanoContas: TfLeituraPlanoContas;

implementation

{$R *.dfm}

uses uDMPlanodeContas, uDMConexao, uFuncoes, uFImportacao;

procedure TfLeituraPlanoContas.btnExcluirImportacaoClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja desfazer a importação?', mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    if not DMPlanodeContas.QueryImportacao.IsEmpty then
    begin
      DMPlanodeContas.QueryImportacao.Delete;
      DMPlanodeContas.QueryImportacao.Refresh;
    end;
  end;
end;

procedure TfLeituraPlanoContas.btnNovaImportacaoClick(Sender: TObject);
var
  cod: Integer;
  desc: String;
begin
  inherited;
  if OpenTextFile.Execute then
  begin
    if OpenTextFile.FileName <> '' then
    begin
      if InputQuery('Gerador Arquivo Contábil','Digite uma descrição:',desc) then
      begin
        cod := TFuncoes.GetCodigoImportacao('P', desc);
        if cod <> 0 then
          DMPlanodeContas.ImportarPlanoDeContas(cod, OpenTextFile.FileName);
      end;
    end;
  end;
  dsPlanoDeContas.DataSet.Refresh;
end;

procedure TfLeituraPlanoContas.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfLeituraPlanoContas.FormShow(Sender: TObject);
begin
  inherited;
  if DMConexao.VerificaConexaoAC then
  begin
    if DMPlanodeContas.QueryImportacao.Active then
    begin
      DMPlanodeContas.QueryImportacao.Close;
      DMPlanodeContas.QueryImportacao.Open;
    end
    else
      DMPlanodeContas.QueryImportacao.Open;
  end;
end;

end.
