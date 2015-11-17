unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.IBDef, FireDAC.Phys.IB, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageXML, FireDAC.Stan.StorageBin;

type
  TDMConexao = class(TDataModule)
    FDConnAC: TFDConnection;
    FDConnGAC: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
  private
    FEmpresaAC: String;
    FCodigoEmpresaAC: String;
    { Private declarations }
  public
    { Public declarations }
    function GetEmpresaAC: String;
    property CodigoEmpresaAC: String read FCodigoEmpresaAC write FCodigoEmpresaAC;
    property EmpresaAC: String read FEmpresaAC write FEmpresaAC;
    procedure ConectarBancos;
    procedure ConectaAC;
    procedure ConectaGAC;
    function VerificaConexaoAC: Boolean;
    function PrecisaAtualizar(out Msg: String): Boolean;
  end;

var
  DMConexao: TDMConexao;

const VersaoAplicacao = 2;
      AtualizarBanco = 'Banco de dados desatualizado.'+#13+'É necessario atualizar o banco de dados para seguir trabalhando!';
      AtualizarAplicacao = 'A versão do banco de dados é superior a versão da aplicação.'+#13+'A atualização da aplicação é necessaria para seguir trabalhando.';

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uFuncoesIni, uInterfaceQuery;

{$R *.dfm}

{ TDMConexao }

procedure TDMConexao.ConectaAC;
begin
  // Carregando dados da conexão do AC a partir do arquivo .ini
  FDConnAC.Params.Values['User_Name'] := TFuncoesIni.LerIni('BANCO_AC','User_Name');
  FDConnAC.Params.Values['Password'] := TFuncoesIni.LerIni('BANCO_AC','Pass');
  FDConnAC.Params.Values['Database'] := TFuncoesIni.LerIni('BANCO_AC','Database');
  try
    FDConnAC.Connected := True;
  Except
  end;
end;

procedure TDMConexao.ConectaGAC;
begin
  // Carregando dados da conexão do GAC a partir do arquivo .ini
  FDConnGAC.Params.Values['User_Name'] := TFuncoesIni.LerIni('BANCO_GAC','User_Name');
  FDConnGAC.Params.Values['Password'] := TFuncoesIni.LerIni('BANCO_GAC','Pass');
  FDConnGAC.Params.Values['Database'] := TFuncoesIni.LerIni('BANCO_GAC','Database');
  try
    FDConnGAC.Connected := True;
  Except
  end;
end;

procedure TDMConexao.ConectarBancos;
begin
  ConectaAC;
  ConectaGAC;
end;

function TDMConexao.GetEmpresaAC: String;
begin
  Result := CodigoEmpresaAC +' - '+ EmpresaAC;
end;

function TDMConexao.PrecisaAtualizar(out Msg: String): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := AutoQuery.NewQuery('Select VERSAO_BANCO from info');
  QUery.Open;
  // Se a versão do banco for menor que da aplicação.
  if Query.Fields[0].AsInteger < VersaoAplicacao then
  begin
    Result := True;
    Msg := AtualizarBanco;
  end
  else if VersaoAplicacao < Query.Fields[0].AsInteger then
  begin
    Result := True;
    Msg := AtualizarAplicacao;
  end;
end;

function TDMConexao.VerificaConexaoAC: Boolean;
begin
  Result := FDConnAC.Connected;
end;

end.
