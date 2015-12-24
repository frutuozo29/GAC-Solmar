unit uDMPlanodeContas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Datasnap.DBClient,
  Datasnap.Provider, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DSConnect;

type
  TDMPlanodeContas = class(TDataModule)
    QueryPlanoDeContas: TFDQuery;
    dspPlanodeContas: TDataSetProvider;
    cdsPlanoDeContas: TClientDataSet;
    cdsPlanoDeContasCODIGO: TIntegerField;
    cdsPlanoDeContasCODIGO_IMPORTACAO: TIntegerField;
    cdsPlanoDeContasCONTA: TStringField;
    cdsPlanoDeContasNOME: TStringField;
    cdsPlanoDeContasREDUZIDO: TIntegerField;
    cdsPlanoDeContasPATRIMONIAL: TStringField;
    cdsPlanoDeContasRESUMIR: TStringField;
    cdsPlanoDeContasNATUREZA: TStringField;
    cdsPlanoDeContasESTABELECIMENTO: TStringField;
    cdsPlanoDeContasCENTRO_RESULTADO: TStringField;
    cdsPlanoDeContasEMPRESA_AC: TStringField;
    cdsPlanoDeContasCODIGO_AC: TStringField;
    QueryPlanoDeContasCODIGO: TIntegerField;
    QueryPlanoDeContasCODIGO_IMPORTACAO: TIntegerField;
    QueryPlanoDeContasCONTA: TStringField;
    QueryPlanoDeContasNOME: TStringField;
    QueryPlanoDeContasREDUZIDO: TIntegerField;
    QueryPlanoDeContasPATRIMONIAL: TStringField;
    QueryPlanoDeContasRESUMIR: TStringField;
    QueryPlanoDeContasNATUREZA: TStringField;
    QueryPlanoDeContasESTABELECIMENTO: TStringField;
    QueryPlanoDeContasCENTRO_RESULTADO: TStringField;
    QueryPlanoDeContasEMPRESA_AC: TStringField;
    QueryPlanoDeContasCODIGO_AC: TStringField;
    QueryImportacao: TFDQuery;
    QueryImportacaoCODIGO: TIntegerField;
    QueryImportacaoDESCRICAO: TStringField;
    QueryImportacaoDATA: TSQLTimeStampField;
    QueryImportacaoSTATUS: TStringField;
    dspImportacao: TDataSetProvider;
    cdsImportacao: TClientDataSet;
    cdsImportacaoCODIGO: TIntegerField;
    cdsImportacaoDESCRICAO: TStringField;
    cdsImportacaoDATA: TSQLTimeStampField;
    cdsImportacaoSTATUS: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ImportarPlanoDeContas(aCod: Integer; aFile: String);
  end;

var
  DMPlanodeContas: TDMPlanodeContas;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses uDMConexao, uInterfaceQuery, uFImportacao, uFuncoes;

{$R *.dfm}
{ TDMPlanodeContas }

procedure TDMPlanodeContas.ImportarPlanoDeContas(aCod: Integer; aFile: String);
var
  Arquivo: TextFile;
  Linha: String;
  Seq, QtdeLinhas: Integer;
  Erros: TStringList;
  progress: TfImportacao;


  function LinhaValida(Linha: String): Boolean;
  begin
    Result := TFuncoes.IsNumeric(Trim(TFuncoes.RemovePontos(Copy(Linha, 0, 11))));
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
    // Criação do Progresso da Importação
    progress := TfImportacao.Create(Self);
    progress.Inicializa(QtdeLinhas);
    progress.Show;
    progress.SetTituloImportacao('Importando arquivo de Plano de Contas...');
    // Associando arquivo lógico ao arquivo físico.
    AssignFile(Arquivo, aFile);
    // Preparando para leitura e posicionando o ponteiro no começo do arquivo
    Reset(Arquivo);
    // Abrindo a Query da Importação
    if not QueryPlanoDeContas.Active then
      QueryPlanoDeContas.Open;
    // Pegando o último código na Tabela de Plano de Contas
    Seq := TFuncoes.GetMaxCodigo(' codigo ', ' PLANODECONTAS ');
    // Inicia um laço em todas as linhas do arquivo
    while not Eof(Arquivo) do
    begin
      Readln(Arquivo, Linha);
      // Verifica se é uma linha válida para importação
      if LinhaValida(Linha) then
      begin
        QueryPlanoDeContas.Append;
        QueryPlanoDeContasCODIGO.AsInteger := Seq;
        QueryPlanoDeContasCODIGO_IMPORTACAO.AsInteger := aCod;
        QueryPlanoDeContasCONTA.AsString := Trim(TFuncoes.RemovePontos(Copy(Linha, 0, 11)));
        QueryPlanoDeContasNOME.AsString := Copy(Linha, 18, 36);
        if TFuncoes.TryStrToInt(Trim(TFuncoes.RemovePontos(Copy(Linha, 56, 5)))) <> -1 then
          QueryPlanoDeContasREDUZIDO.AsInteger := TFuncoes.TryStrToInt(Trim(TFuncoes.RemovePontos(Copy(Linha, 56, 5))));
        QueryPlanoDeContasEMPRESA_AC.AsString := DMConexao.CodigoEmpresaAC;
        try
          QueryPlanoDeContas.Post;
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

