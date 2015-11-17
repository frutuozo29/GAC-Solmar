unit uDMMapeamento;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDMMapeamento = class(TDataModule)
    QueryPlanoContas: TFDQuery;
    QueryPlanoContasCONTA: TStringField;
    QueryPlanoContasNOME: TStringField;
    QueryPlanoContasSELECIONADO: TIntegerField;
    QueryContas: TFDQuery;
    QueryPlanoContasCODIGO_AC: TStringField;
    QueryContasSELECIONADO: TIntegerField;
    QueryContasCODIGO: TStringField;
    QueryContasNOME: TStringField;
    QueryMapeados: TFDQuery;
    QueryMapeadosSELECIONADO: TIntegerField;
    QueryMapeadosCONTA: TStringField;
    QueryMapeadosNOME: TStringField;
    QueryMapeadosCODIGO_AC: TStringField;
    QueryContasIMPORTADO: TIntegerField;
    QueryMapeadosCONTA_AC: TStringField;
    procedure QueryContasAfterRefresh(DataSet: TDataSet);
    procedure QueryMapeadosCONTA_ACGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    function GetDescricaoContaAC(aConta: String): String;
    procedure SetarCodigoPlanoContas(aCodigo: String);
    procedure SetarContaImportada(aImportado: Integer);
    { Private declarations }
  public
    { Public declarations }
    procedure AbrirPlanoContas;
    procedure AbrirContas;
    procedure AbrirMapeados;
    procedure AbrirMapeamento;
    procedure Mapear;
    procedure MapearAutomaticamente;
    procedure DesfazerMapeamento;
  end;

var
  DMMapeamento: TDMMapeamento;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDMConexao, System.Variants, uInterfaceQuery;

const csImportado = 1;
      csNaoImportado = 0;

{$R *.dfm}

{ TDMMapeamento }

procedure TDMMapeamento.AbrirContas;
begin
  QueryContas.Close;
  QueryContas.ParamByName('emp_codigo').AsString := DMConexao.CodigoEmpresaAC;
  QueryContas.Open;
end;

procedure TDMMapeamento.AbrirMapeados;
begin
  QueryMapeados.Close;
  QueryMapeados.Open;
  QueryMapeados.First;
  QueryMapeados.DisableControls;
  while not QueryMapeados.Eof do
  begin
    if QueryContas.Active then
    begin
      if QueryContas.Locate('codigo',QueryMapeadosCODIGO_AC.AsString,[loCaseInsensitive, loPartialKey]) then
      begin
        QueryContas.Edit;
        QueryContasIMPORTADO.AsInteger := csImportado;
        QueryContas.Post;
//        SetarNomeConta(QueryContasNOME.AsString);
      end;
    end;
    QueryMapeados.Next;
  end;
  QueryMapeados.First;
  QueryMapeados.EnableControls;
end;

procedure TDMMapeamento.AbrirMapeamento;
begin
  AbrirPlanoContas;
  AbrirContas;
  AbrirMapeados;
end;

procedure TDMMapeamento.SetarCodigoPlanoContas(aCodigo: String);
begin
  QueryPlanoContas.Edit;
  QueryPlanoContasCODIGO_AC.AsString := aCodigo;
  QueryPlanoContas.Post;
end;

procedure TDMMapeamento.SetarContaImportada(aImportado: Integer);
begin
  QueryContas.Edit;
  QueryContasIMPORTADO.AsInteger := csImportado;
  QueryContas.Post;
end;

procedure TDMMapeamento.Mapear;

  procedure RefreshDataSets;
  begin
    QueryPlanoContas.Refresh;
    QueryContas.Refresh;
    QueryMapeados.Refresh;
  end;

begin
  if QueryPlanoContas.State = dsEdit then
    QueryPlanoContas.Post;

  if QueryPlanoContas.Locate('selecionado',1,[loCaseInsensitive, loPartialKey]) then
  begin
    if QueryContas.Locate('selecionado',1,[loCaseInsensitive, loPartialKey]) then
    begin
      SetarCodigoPlanoContas(QueryContasCODIGO.AsString);
      SetarContaImportada(csImportado);
      RefreshDataSets;
    end;
  end;
end;

procedure TDMMapeamento.MapearAutomaticamente;
begin
  if QueryPlanoContas.State = dsEdit then
    QueryPlanoContas.Post;

  if QueryContas.State = dsEdit then
    QueryContas.Post;

  QueryPlanoContas.First;
  while not QueryPlanoContas.Eof do
  begin
    if QueryContas.Locate('codigo', QueryPlanoContasCONTA.AsString, [loCaseInsensitive, loPartialKey]) then
    begin
      QueryPlanoContas.Edit;
      QueryPlanoContasCODIGO_AC.AsString := QueryContasCODIGO.AsString;
      QueryPlanoContas.Post;
    end;
    QueryPlanoContas.Next;
  end;
  QueryPlanoContas.Refresh;
  QueryMapeados.Refresh;
end;

procedure TDMMapeamento.QueryContasAfterRefresh(DataSet: TDataSet);
begin
  AbrirMapeados;
end;

procedure TDMMapeamento.QueryMapeadosCONTA_ACGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := GetDescricaoContaAC(QueryMapeadosCODIGO_AC.AsString);
end;

procedure TDMMapeamento.AbrirPlanoContas;
begin
  QueryPlanoContas.Close;
  QueryPlanoContas.Open;
end;

procedure TDMMapeamento.DesfazerMapeamento;
begin
  if QueryPlanoContas.State = dsEdit then
    QueryPlanoContas.Post;

  QueryMapeados.First;
  while not QueryMapeados.Eof do
  begin
    if QueryMapeadosSELECIONADO.AsInteger = 1 then
    begin
      if QueryContas.Locate('codigo',QueryMapeadosCODIGO_AC.AsString, [loCaseInsensitive, loPartialKey]) then
        SetarContaImportada(csNaoImportado);

      QueryMapeados.Edit;
      QueryMapeadosCODIGO_AC.AsVariant := Null;
      QueryMapeados.Post;
    end;
    QueryMapeados.Next;
  end;
  QueryPlanoContas.Refresh;
  QueryContas.Refresh;
  QueryMapeados.Refresh;
end;

function TDMMapeamento.GetDescricaoContaAC(aConta: String): String;
var
  Qry: TFDQuery;
begin
  Qry := AutoQuery.Query;
  Qry.Connection := DMConexao.FDConnAC;
  Qry.Open('select con.nome from con where con.emp_codigo = '+QuotedStr(DMConexao.CodigoEmpresaAC)+' and con.codigo = '+QuotedStr(aConta));
  Result := Qry.Fields[0].AsString;
end;

end.
