unit uInterfaceQuery;

interface

uses FireDAC.Comp.Client;

type
  IAutoQuery = interface
    function GetQuery: TFDQuery;
    function NewQuery(const SQL: string): TFDQuery;
    property Query: TFDQuery read GetQuery;
  end;

type
  TAutoQueryBase = class(TInterfacedObject, IAutoQuery)
  private
    fQuery: TFDQuery;
  public
    function GetQuery: TFDQuery;
    function NewQuery(const SQL: string): TFDQuery;
    destructor Destroy; override;
  end;

function AutoQuery: IAutoQuery;
function NewQuery(const SQL: string = ''): TFDQuery;

implementation

uses uDMConexao;

function AutoQuery: IAutoQuery;
begin
  Result := TAutoQueryBase.Create;
end;

function NewQuery(const SQL: string = ''): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  try
    Result.Connection := DMConexao.FDConnGAC;
    Result.SQL.Text := SQL;
  except
    Result.Free;
    raise;
  end;
end;

function TAutoQueryBase.GetQuery: TFDQuery;
begin
  if fQuery = nil then
  begin
    fQuery := TFDQuery.Create(nil);
    fQuery.Connection := DMConexao.FDConnGAC;
  end;
  Result := fQuery;
end;

destructor TAutoQueryBase.Destroy;
begin
  if Assigned(fQuery) then
    fQuery.Free;
end;

function TAutoQueryBase.NewQuery(const SQL: string): TFDQuery;
begin
  GetQuery.SQL.Text := SQL;
  Result := GetQuery;
end;

end.
