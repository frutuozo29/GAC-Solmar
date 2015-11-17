unit ufAtualizaBancoDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  iwSystem, System.IniFiles;

type
  TfAtualizaBancoDados = class(TfFormBase)
    pnAvisos: TPanel;
    GroupBox1: TGroupBox;
    mmAtualizacoes: TMemo;
    Panel1: TPanel;
    btnAtualizar: TButton;
    btnFechar: TButton;
    Progress: TProgressBar;
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    function AtualizarBanco: Boolean;
    procedure AtualizaVersaoBanco;
    function ExecutaComando(aSql: String): Boolean;
    { Private declarations }
  public
    { Public declarations }
    _VersaoAplicacao: Integer;
    _Result: Boolean;
    class function Inicializa(VersaoAplicacao: Integer): Boolean;
  end;

var
  fAtualizaBancoDados: TfAtualizaBancoDados;

implementation

uses
  FireDAC.Comp.Client, uInterfaceQuery, uDMConexao;

{$R *.dfm}

{ TfAtualizaBancoDados }

procedure TfAtualizaBancoDados.AtualizaVersaoBanco;
var
  Query: TFDQuery;
begin
  Query := AutoQuery.NewQuery('Update info set VERSAO_BANCO = '+IntToStr(_VersaoAplicacao)+', VERSAO_APLICACAO = '+IntToStr(_VersaoAplicacao));
  Query.ExecSQL;
end;

procedure TfAtualizaBancoDados.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  _Result := AtualizarBanco;
  Close;
end;

procedure TfAtualizaBancoDados.btnFecharClick(Sender: TObject);
begin
  inherited;
  _Result := False;
  Close;
end;

function TfAtualizaBancoDados.ExecutaComando(aSql: String): Boolean;
var
  Query: TFDQuery;
begin
  try
    Query := AutoQuery.NewQuery(aSql);
    Query.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

class function TfAtualizaBancoDados.Inicializa(VersaoAplicacao: Integer): Boolean;
begin
  fAtualizaBancoDados := TfAtualizaBancoDados.Create(Application);
  try
    with fAtualizaBancoDados do
    begin
      _VersaoAplicacao := VersaoAplicacao;
      ShowModal;
      Result := _Result;
    end;
  finally
    FreeAndNil(fAtualizaBancoDados);
  end;
end;

function TfAtualizaBancoDados.AtualizarBanco: Boolean;
var
  Arquivo: String;
  oScripts: TStringList;
  i: Integer;
  PodeExecutar: Boolean;
begin
  Result := True;
  PodeExecutar := False;
  Arquivo := gsAppPath + gsAppName + '.database';
  try
    oScripts := TStringList.Create;
    if FileExists(Arquivo) then
      oScripts.LoadFromFile(Arquivo);
    if oScripts.Text <> EmptyStr then
      try
        DMConexao.FDConnGAC.StartTransaction;
        Progress.Max := oScripts.Count;
        for i := 0 to oScripts.Count -1 do
        begin
          if oScripts[i] = '['+IntToStr(_VersaoAplicacao)+']' then
            PodeExecutar := True;

          if PodeExecutar and (oScripts[i] <> '['+IntToStr(_VersaoAplicacao)+']') then
            ExecutaComando(oScripts[i]);
          Progress.Position := Progress.Position + 1;
          Application.ProcessMessages;
        end;
        AtualizaVersaoBanco;
        DMConexao.FDConnGAC.Commit;
        Result := True;
      except
        DMConexao.FDConnGAC.Rollback;
        Result := False;
      end;
  finally
    FreeAndNil(oScripts);
  end;
end;

end.
