unit uFSelEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.Provider, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.DB, Datasnap.DBClient, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Menus;

type
  TfSelEmpresa = class(TfFormBase)
    dsEmpresa: TDataSource;
    cdsEmpresa: TClientDataSet;
    QueryEmpresa: TFDQuery;
    dspEmpresa: TDataSetProvider;
    QueryEmpresaCODIGO: TStringField;
    QueryEmpresaNOME: TStringField;
    cdsEmpresaCODIGO: TStringField;
    cdsEmpresaNOME: TStringField;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    gridEmpresa: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure gridEmpresaDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure Selecionar;
  public
    { Public declarations }
    class function Inicializa: String;
  end;

var
  fSelEmpresa: TfSelEmpresa;

implementation

{$R *.dfm}

uses uDMConexao;

procedure TfSelEmpresa.Button1Click(Sender: TObject);
begin
  inherited;
  Selecionar;
end;

procedure TfSelEmpresa.Button2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfSelEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  if DMConexao.VerificaConexaoAC then
    if not cdsEmpresa.Active then
      cdsEmpresa.Open;
end;

procedure TfSelEmpresa.gridEmpresaDblClick(Sender: TObject);
begin
  inherited;
  Selecionar;
end;

class function TfSelEmpresa.Inicializa: String;
begin
  fSelEmpresa := TfSelEmpresa.Create(Application);
  try
    fSelEmpresa.ShowModal;
    Result := DMConexao.CodigoEmpresaAC + ' - ' + DMConexao.EmpresaAC;
  finally
    FreeAndNil(fSelEmpresa);
  end;
end;

procedure TfSelEmpresa.Selecionar;
begin
  DMConexao.EmpresaAC := cdsEmpresaNOME.AsString;
  DMConexao.CodigoEmpresaAC := cdsEmpresaCODIGO.AsString;
  Close;
end;

end.
