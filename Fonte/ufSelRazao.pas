unit ufSelRazao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDMConexao, uFormBase, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfSelRazao = class(TfFormBase)
    grid: TDBGrid;
    pnSel: TPanel;
    btnSelecionar: TButton;
    QryRazao: TFDQuery;
    dsRazao: TDataSource;
    QryRazaoCODIGO: TIntegerField;
    QryRazaoDESCRICAO: TStringField;
    QryRazaoDATA: TSQLTimeStampField;
    procedure btnSelecionarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FCodigo: Integer;
    class function Inicializa(): Integer;
  end;

var
  fSelRazao: TfSelRazao;

implementation

{$R *.dfm}

{ TfSelRazao }

procedure TfSelRazao.btnSelecionarClick(Sender: TObject);
begin
  inherited;
  FCodigo := QryRazaoCODIGO.AsInteger;
  Close;
end;

class function TfSelRazao.Inicializa: Integer;
begin
  try
    fSelRazao := TfSelRazao.Create(Application);
    fSelRazao.QryRazao.Open();
    fSelRazao.ShowModal;
    Result := fSelRazao.FCodigo;
  finally
    FreeAndNil(fSelRazao);
  end;
end;

end.
