unit uDMRazaoAnalitica;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDMRazaoAnalitica = class(TDataModule)
    QueryRazaoAnalitica: TFDQuery;
    QueryImportacao: TFDQuery;
    QueryImportacaoCODIGO: TIntegerField;
    QueryImportacaoDESCRICAO: TStringField;
    QueryImportacaoDATA: TSQLTimeStampField;
    QueryImportacaoSTATUS: TStringField;
    QueryRazaoAnaliticaCODIGO: TIntegerField;
    QueryRazaoAnaliticaCODIGO_IMPORTACAO: TIntegerField;
    QueryRazaoAnaliticaNUMERO_LANCAMENTO: TStringField;
    QueryRazaoAnaliticaDATA: TDateField;
    QueryRazaoAnaliticaHISTORICO: TStringField;
    QueryRazaoAnaliticaDOCUMENTO: TStringField;
    QueryRazaoAnaliticaVALOR_DEBITO: TBCDField;
    QueryRazaoAnaliticaVALOR_CREDITO: TBCDField;
    QueryRazaoAnaliticaCONTA_PLANOCONTAS: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ImportarRazao(aCod: Integer; aFile: String);
  end;

var
  DMRazaoAnalitica: TDMRazaoAnalitica;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uFImportacao, uFuncoes, uInterfaceQuery, uDMConexao;

{$R *.dfm}

{ TDMRazaoAnalitica }

procedure TDMRazaoAnalitica.ImportarRazao(aCod: Integer; aFile: String);
var
  Arquivo: TextFile;
  Linha, Conta: String;
  Seq, QtdeLinhas: Integer;
  Erros: TStringList;
  progress: TfImportacao;


  function LinhaValida(Linha: String): Boolean;
  begin
    Result := TFuncoes.IsNumeric(Trim(TFuncoes.RemovePontos(Copy(Linha, 0, 6))));
  end;

  procedure AtualizaStatus(s: Char; Codigo_Importacao: Integer);
  var
    Query: TFDQuery;
  begin
    Query := AutoQuery.NewQuery('update importacoes set status = '+QuotedStr(s)+' where codigo ='+IntToStr(Codigo_Importacao));
    Query.ExecSQL;
  end;

  procedure TrataErros(ListaErros: TStringList; Codigo_Importacao: Integer);
  var
    Query: TFDQuery;
    Seq: Integer;
  begin
    if ListaErros.Text <> '' then
    begin
      Seq := TFuncoes.GetMaxCodigo('codigo','log');
      Query:= AutoQuery.NewQuery('Insert into log(codigo, codigo_importacao, log) values(:codigo, :codigo_importacao, :log)');
      Query.ParamByName('codigo').AsInteger := Seq;
      Query.ParamByName('codigo_importacao').AsInteger := Codigo_Importacao;
      Query.ParamByName('log').AsMemo := AnsiString(ListaErros.Text);
      Query.ExecSQL;
    end;
  end;

begin
  try
    // Crio o StringList que recebera o LOG de erros
    Erros := TStringList.Create;
    // Quantidade de linhas do arquivo
    QtdeLinhas := TFuncoes.NumeroDeLinhasTXT(aFile);
    // Cria��o do Progresso da Importa��o
    progress := TfImportacao.Create(Self);
    progress.Inicializa(QtdeLinhas);
    progress.Show;
    progress.SetTituloImportacao('Importando arquivo de Raz�o Anal�tica...');
    // Associando arquivo l�gico ao arquivo f�sico.
    AssignFile(Arquivo, aFile);
    // Preparando para leitura e posicionando o ponteiro no come�o do arquivo
    Reset(Arquivo);
    // Abrindo a Query da Importa��o
    if not QueryRazaoAnalitica.Active then
      QueryRazaoAnalitica.Open;
    // Pegando o �ltimo c�digo na Tabela de Plano de Contas
    Seq := TFuncoes.GetMaxCodigo(' codigo ', ' LANCAMENTOS ');
    // Inicia um la�o em todas as linhas do arquivo
    while not Eof(Arquivo) do
    begin
      Readln(Arquivo, Linha);
      // Verifica se � uma linha v�lida para importa��o
      if TFuncoes.IsNumeric(Trim(TFuncoes.RemovePontos((Copy(linha, 8, 13))))) then
        Conta := Trim(TFuncoes.RemovePontos((Copy(linha, 8, 13))));

      if LinhaValida(Linha) then
      begin
        QueryRazaoAnalitica.Append;
        QueryRazaoAnaliticaCODIGO.AsInteger := Seq;
        QueryRazaoAnaliticaCODIGO_IMPORTACAO.AsInteger := aCod;
        QueryRazaoAnaliticaNUMERO_LANCAMENTO.AsString := Trim(TFuncoes.RemovePontos(Copy(Linha, 0, 7)));
        QueryRazaoAnaliticaCONTA_PLANOCONTAS.AsString := Conta;
        QueryRazaoAnaliticaDATA.AsDateTime := Now;//TFuncoes.TryStrToInt(Trim(TFuncoes.RemovePontos(Copy(Linha, 56, 5))));
        QueryRazaoAnaliticaHISTORICO.AsString := Copy(linha, 20, 36);
        QueryRazaoAnaliticaDOCUMENTO.AsString := Trim( Copy(linha, 56, 12) );
        QueryRazaoAnaliticaVALOR_DEBITO.AsFloat := TFuncoes.RetornaFloatdaString(Copy(linha, 84, 15));
        QueryRazaoAnaliticaVALOR_CREDITO.AsFloat := TFuncoes.RetornaFloatdaString(Copy(linha, 100, 14));
        try
          QueryRazaoAnalitica.Post;
          Inc(Seq);
        except
          On E : Exception Do
          Erros.Add('Linha: '+linha+'. Mensagem: '+E.Message);
        end;
      end;
      progress.NextProgress;
    end;
  finally
    if Erros.Text <> '' then
    begin
      AtualizaStatus('E',aCod);
      TrataErros(Erros, aCod);
    end
    else
      AtualizaStatus('C',aCod);
    FreeAndNil(Erros);
    FreeAndNil(progress);
    CloseFile(Arquivo);
  end;
end;

end.
