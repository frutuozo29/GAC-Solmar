unit uFuncoes;

interface

uses System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Datasnap.DBClient,
  Datasnap.Provider, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DSConnect;

type

  TFuncoes = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class function Padl(s: string; n: integer): string;
    class function Padr(s: string; n: integer): string;
    class function IsNumeric(s: String): Boolean;
    class function RemovePontos(s: String): String;
    class function TryStrToInt(s: String): integer;
    class function NumeroDeLinhasTXT(lcPath: String): integer;
    class function GetCodigoImportacao(Origem, Descricao: String): integer;
    class function GetMaxCodigo(aCampo, aTabela: String): integer;
    class function RemoveVirgula(s: String): String;
    class function RetornaFloatdaString(s: String): Double;
    class function TrocarCaracteres(Old, New, aFonte: String): String;
  end;

implementation

uses uInterfaceQuery;

class function TFuncoes.IsNumeric(s: String): Boolean;
begin
  Result := True;
  Try
    StrToInt(s);
  Except
    Result := False;
  end;
end;

class function TFuncoes.NumeroDeLinhasTXT(lcPath: String): integer;
var
  aList: TStringList;
begin
  if FileExists(lcPath) then
  begin
    aList := TStringList.Create;
    try
      aList.LoadFromFile(lcPath);
      Result := aList.Count;
    finally
      FreeAndNil(aList);
    end;
  end
  else
    Result := 0;
end;

class function TFuncoes.RemoveVirgula(s: String): String;
begin
  Result := StringReplace(s, ',', '', [rfReplaceAll])
end;

class function TFuncoes.RetornaFloatdaString(s: String): Double;
var
  valor: String;
begin
  valor := Trim(s);
  valor := TFuncoes.RemovePontos(valor);
  // valor := TrocarCaracteres(',','.',valor);
  TryStrToFloat(valor, Result);
end;

class function TFuncoes.RemovePontos(s: String): String;
begin
  Result := StringReplace(s, '.', '', [rfReplaceAll]);
end;

class function TFuncoes.TrocarCaracteres(Old, New, aFonte: String): String;
begin
  Result := StringReplace(aFonte, Old, New, [rfReplaceAll, rfIgnoreCase]);
end;

class function TFuncoes.TryStrToInt(s: String): integer;
begin
  try
    Result := StrToInt(s);
  except
    Result := -1;
  end;
end;

class function TFuncoes.GetCodigoImportacao(Origem, Descricao: String): integer;
var
  Query: TFDQuery;
  cod: integer;
begin
  try
    cod := GetMaxCodigo('codigo', 'importacoes');
    Query := AutoQuery.NewQuery
      ('insert into IMPORTACOES (CODIGO, DESCRICAO, DATA, ORIGEM) values (:Codigo, :Descricao, :Data, :Origem) ');
    Query.ParamByName('Codigo').AsInteger := cod;
    Query.ParamByName('Descricao').AsString := Descricao;
    Query.ParamByName('Data').AsDateTime := Now;
    Query.ParamByName('Origem').AsString := Origem;
    Query.ExecSQL;
    Result := cod;
  except
    Result := 0;
  end;
end;

class function TFuncoes.GetMaxCodigo(aCampo, aTabela: String): integer;
var
  Query: TFDQuery;
begin
  Query := AutoQuery.NewQuery('select coalesce(max(' + aCampo + '),0) + 1 from '
    + aTabela);
  Query.Open;
  Result := Query.Fields[0].AsInteger;
end;

class function TFuncoes.Padl(s: string; n: integer): string;
begin
  Result := Format('%-' + IntToStr(n) + '.' + IntToStr(n) + 's', [s]);
end;

class function TFuncoes.Padr(s: string; n: integer): string;
begin
  Result := Format('%' + IntToStr(n) + '.' + IntToStr(n) + 's', [s]);
end;

end.
