unit uDMImportacao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDMImportacao = class(TDataModule)
    QueryHistorico: TFDQuery;
    QueryHistoricoHISTORICO: TStringField;
    QueryLancamentos: TFDQuery;
    QueryLancamentosCODIGO_AC: TStringField;
    QueryLancamentosNUMERO_LANCAMENTO: TStringField;
    QueryLancamentosDATA: TDateField;
    QueryLancamentosHISTORICO: TStringField;
    QueryLancamentosDOCUMENTO: TStringField;
    QueryLancamentosVALOR_DEBITO: TBCDField;
    QueryLancamentosVALOR_CREDITO: TBCDField;
    QueryLancamentosCODIGO_HISTORICO: TStringField;
    QueryHistoricoCODIGO_HISTORICO: TStringField;
  private
    { Private declarations }
    FCodigo: Integer;
    function getData(aTipo: String): String;
    function TrataData(aData: TDateTime): String;
    function GetCampoConta(aCampo, aConta: String): String;
    function TrocaVirgPPto(Valor: string): String;
    function GetValorTotalLancamento(const aLancamento: String): Double;
    function AnalisaLancamento(aCod, aLan: String): Boolean;
  public
    { Public declarations }
    procedure Importar(aDir: String; aCod: Integer);
  end;

var
  DMImportacao: TDMImportacao;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses uDMConexao, uFuncoes, uInterfaceQuery, uFImportacao;

{$R *.dfm}
{ TDMImportacao }

function TDMImportacao.AnalisaLancamento(aCod, aLan: String): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := AutoQuery.NewQuery('select count(LAN.NUMERO_LANCAMENTO) '+
                            ' from LANCAMENTOS LAN '+
                            ' inner join PLANODECONTAS PDC on LAN.CONTA_PLANOCONTAS = PDC.CONTA '+
                            ' where PDC.CODIGO_AC is not null and '+
                            '       LAN.CODIGO_IMPORTACAO = :COD and '+
                            '       LAN.NUMERO_LANCAMENTO = :LAN');
  Qry.ParamByName('COD').AsString := aCod;
  Qry.ParamByName('LAN').AsString := aLan;
  Qry.Open;
  Result := Qry.Fields[0].AsInteger >= 2;
end;

function TDMImportacao.GetCampoConta(aCampo, aConta: String): String;
var
  Qry: TFDQuery;
begin
  Qry := AutoQuery.NewQuery('select ' + aCampo +
    ' from CON where emp_codigo = :emp and codigo = :con');
  Qry.Connection := DMConexao.FDConnAC;
  Qry.ParamByName('emp').AsString := DMConexao.CodigoEmpresaAC;
  Qry.ParamByName('con').AsString := aConta;
  Qry.Open;
  Result := Qry.Fields[0].AsString;
end;

function TDMImportacao.getData(aTipo: String): String;
var
  Qry: TFDQuery;
begin
  Qry := AutoQuery.NewQuery('select ' + aTipo +
    '(LAN.DATA) from PLANODECONTAS PDC ' +
    ' inner join LANCAMENTOS LAN on LAN.CONTA_PLANOCONTAS = PDC.CONTA ' +
    ' where PDC.CODIGO_AC is not null and LAN.CODIGO_IMPORTACAO = '+IntToStr(FCodigo));
  Qry.Open;
  Result := TrataData(Qry.Fields[0].AsDateTime);
end;

function TDMImportacao.GetValorTotalLancamento(const aLancamento: String): Double;
var
  Query: TFDQuery;
begin
  try
    Query := AutoQuery.NewQuery('select (sum(VALOR_CREDITO) + sum(VALOR_DEBITO)) / 2 from LANCAMENTOS where NUMERO_LANCAMENTO = '+ aLancamento);
    Query.Open;
    Result := Query.Fields[0].AsFloat;
  except
    raise Exception.Create('Ocorreu um erro na busca do valor do lançamento.');
  end;
end;

procedure TDMImportacao.Importar(aDir: String; aCod: Integer);
var
  Arquivo: TStringList;
  valorGeral: Double;
  progress:TfImportacao;

  procedure CriarHeader;
  var
    linha: String;
  begin
    Insert('07AC        AC        ' + DMConexao.CodigoEmpresaAC + getData('min')
      + getData('max') + 'Importacao', linha, 0);
    Arquivo.Add(linha);
  end;

  procedure AtualizaCodigoHistorico(aCod, aHist: String);
  var
    Qry: TFDQuery;
  begin
    Qry := AutoQuery.NewQuery('update lancamentos set codigo_historico = :cod where historico = :hist and codigo_historico is null');
    Qry.ParamByName('cod').AsString := aCod;
    Qry.ParamByName('hist').AsString := aHist;
    Qry.ExecSQL;
  end;

  function GetUltimoCodigoHistorico: Integer;
  var
    Qry: TFDQuery;
    sql: String;
  begin
    sql := 'select distinct MAX(CAST(LAN.CODIGO_HISTORICO as Integer)) as CODIGO_HISTORICO '+
           ' from LANCAMENTOS LAN                                                          '+
           ' inner join PLANODECONTAS PDC on LAN.CONTA_PLANOCONTAS = PDC.CONTA             '+
           ' where PDC.CODIGO_AC is not null                                               '+
           ' order by CODIGO_HISTORICO                                                     ';
    Qry := AutoQuery.NewQuery(sql);
    Qry.Open;
    Result := Qry.Fields[0].AsInteger + 1;
  end;

  procedure Historico;
  var
    linha: String;
    codigo: Integer;
  begin
    codigo := GetUltimoCodigoHistorico;
    QueryHistorico.Close;
    QueryHistorico.Open;
    QueryHistorico.First;
    progress.Inicializa(QueryHistorico.RecordCount);
    progress.SetTituloImportacao('Exportando Históricos...');

    while not(QueryHistorico.Eof) do
    begin
      linha := EmptyStr;
      Insert('1', linha, 1); { Registro de Dados }
      Insert('0010', linha, 2); { Identificador do Registro }
      if QueryHistoricoCODIGO_HISTORICO.IsNull then
      begin
        Insert(TFuncoes.Padr(codigo.ToString, 10), linha, 6); { Código do Histórico }
        AtualizaCodigoHistorico(codigo.ToString,QueryHistoricoHISTORICO.AsString);
        Inc(codigo);
      end
      else
        Insert(TFuncoes.Padr(QueryHistoricoCODIGO_HISTORICO.AsString, 10), linha, 6); { Código do Histórico }
      Insert(Copy(QueryHistoricoHISTORICO.AsString, 0, 40), linha, 16); { Descrição do Histórico }
      Arquivo.Add(linha);
      QueryHistorico.Next;
      progress.NextProgress;
    end;
  end;

  procedure Lancamentos;
  var
    linha, lan: String;

    procedure InserirMestre;
    begin
      linha := EmptyStr;
      Insert('1', linha, 1); { Registro de Dados }
      Insert('0040', linha, 2); { Identificador do Registro }
      Insert(TrataData(QueryLancamentosDATA.AsDateTime), linha, 6); { Data do Fato Contábil }
      Insert(TFuncoes.Padl(QueryLancamentosNUMERO_LANCAMENTO.AsString, 10), linha, 14); { Sequencial do Lançamento na Data }
      Insert(TFuncoes.Padl('', 10), linha, 24); { Número de Arquivo }
      Insert(TFuncoes.Padl('', 10), linha, 34); { Número do Lote }
      Insert(TFuncoes.Padl(TrocaVirgPPto(FormatFloat('0.00',GetValorTotalLancamento(QueryLancamentosNUMERO_LANCAMENTO.AsString))), 15), linha, 44); { Valor Total Movimentado }
      Insert(TFuncoes.Padl(QueryLancamentosCODIGO_HISTORICO.AsString, 10), linha, 59);
      Insert(TFuncoes.Padl('', 40), linha, 69);
      Arquivo.Add(linha);
      valorGeral := valorGeral + GetValorTotalLancamento(QueryLancamentosNUMERO_LANCAMENTO.AsString);
    end;

  begin
    QueryLancamentos.Close;
    QueryLancamentos.ParamByName('LAN').AsInteger := FCodigo;
    QueryLancamentos.Open;

    progress.Inicializa(QueryLancamentos.RecordCount);
    progress.SetTituloImportacao('Exportando Lançamentos...');

    while not(QueryLancamentos.Eof) do
    begin
      if AnalisaLancamento(FCodigo.ToString, QueryLancamentosNUMERO_LANCAMENTO.AsString) then
      begin
        if lan <> QueryLancamentosNUMERO_LANCAMENTO.AsString then
        begin
          lan := QueryLancamentosNUMERO_LANCAMENTO.AsString;
          InserirMestre;
        end;
        linha := EmptyStr;
        Insert('1', linha, 1); { Registro de Dados }
        Insert('0050', linha, 2); { Identificador do Registro }
        if QueryLancamentosVALOR_CREDITO.AsFloat > 0 then
          Insert('C', linha, 6) { Crédito ou Debito }
        else
          Insert('D', linha, 6); { Crédito ou Debito }
        Insert(TFuncoes.Padl('', 10), linha, 7); { Sequencial }
        Insert(TFuncoes.Padl(QueryLancamentosCODIGO_AC.AsString, 15), linha, 17); { Número da Conta }
        Insert(TFuncoes.Padl(GetCampoConta('EST_CODIGO', QueryLancamentosCODIGO_AC.AsString), 4), linha, 32); { Estabelecimento }
        Insert(TFuncoes.Padl(GetCampoConta('CRS_CODIGO', QueryLancamentosCODIGO_AC.AsString), 15), linha, 36); { Centro de Resultado }
        Insert(TFuncoes.Padl(QueryLancamentosCODIGO_HISTORICO.AsString, 10), linha, 51); { Código do Histórico }
        Insert(TFuncoes.Padl('', 40), linha, 61); { }
        if QueryLancamentosVALOR_CREDITO.AsFloat > 0 then
          Insert(TFuncoes.Padl(TrocaVirgPPto(FormatFloat('0.00', QueryLancamentosVALOR_CREDITO.AsFloat)), 15), linha, 101) { Crédito }
        else
          Insert(TFuncoes.Padl(TrocaVirgPPto(FormatFloat('0.00', QueryLancamentosVALOR_DEBITO.AsFloat)), 15), linha, 101); { Debito }
        Insert(TFuncoes.Padl(QueryLancamentosDOCUMENTO.AsString, 20), linha, 116); { Número do Documento }
        Arquivo.Add(linha);
      end;
      QueryLancamentos.Next;
      progress.NextProgress;
    end;

  end;

  procedure Trailer;
  var
    linha: String;
  begin
    Insert('9', linha, 1); { Registro de Dados }
    Insert(TFuncoes.Padl(IntToStr(Arquivo.Count + 1), 10), linha, 2); { Quantidade de Linhas }
    Insert(TrocaVirgPPto(FormatFloat('0.00', valorGeral)), linha, 12); { Registro de Dados }
    Arquivo.Add(linha);
  end;

begin
  try
    FCodigo := aCod;
    Arquivo := TStringList.Create;
    progress := TfImportacao.Create(Self);
    progress.Show;
    CriarHeader;
    Historico;
    Lancamentos;
    Trailer;
    Arquivo.SaveToFile(aDir);
  finally
    FreeAndNil(Arquivo);
    FreeAndNil(progress);
  end;
end;

function TDMImportacao.TrataData(aData: TDateTime): String;
var
  year, month, day: word;
  dia, mes, ano: string;
begin
  DecodeDate(aData, year, month, day);
  dia := IntToStr(day);
  mes := IntToStr(month);
  ano := IntToStr(year);
  dia := FormatFloat('00', StrToFloat(dia));
  mes := FormatFloat('00', StrToFloat(mes));
  ano := FormatFloat('0000', StrToFloat(ano));
  Result := ano + mes + dia;
end;

function TDMImportacao.TrocaVirgPPto(Valor: string): String;
var
  i: Integer;
begin
  if Valor <> '' then
  begin
    for i := 0 to Length(Valor) do
    begin
      if Valor[i] = ',' then
        Valor[i] := '.';
    end;
  end;
  Result := Valor;
end;

end.
