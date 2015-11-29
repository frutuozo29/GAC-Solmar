unit uConexaoBD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client, System.UITypes, Vcl.Imaging.jpeg, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL;

type
  TfConexaoBD = class(TfFormBase)
    pnTop: TPanel;
    imgDataBase: TImage;
    Label1: TLabel;
    pnFortesContabil: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    edtCaminhoAC: TEdit;
    edtUserAC: TEdit;
    edtSenhaAC: TEdit;
    Label3: TLabel;
    OpenDialog: TOpenDialog;
    Label4: TLabel;
    Label5: TLabel;
    btnConectarAC: TButton;
    SpeedButton1: TSpeedButton;
    cbUserPassDefault: TCheckBox;
    FDConn: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    Label6: TLabel;
    Label7: TLabel;
    edtCaminhoGAC: TEdit;
    Label8: TLabel;
    edtUserGAC: TEdit;
    edtSenhaGAC: TEdit;
    cbUserPassGACDefault: TCheckBox;
    btnConectarGAC: TButton;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    ImgGAC: TImage;
    ImgAC: TImage;
    gridEmpresa: TDBGrid;
    QueryEmpresa: TFDQuery;
    QueryEmpresaCODIGO: TStringField;
    QueryEmpresaNOME: TStringField;
    dsEmpresa: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    cbSQLServer: TCheckBox;
    edtserver: TEdit;
    Label10: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure cbUserPassDefaultClick(Sender: TObject);
    procedure btnConectarACClick(Sender: TObject);
    procedure btnConectarGACClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbUserPassGACDefaultClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Status;
    function TestarConexao(User, Pass, DataBase: String; EhSQLServer: Boolean; Server: String = 'localhost'): Boolean;
    procedure CarregaConfigBD;
  public
    { Public declarations }
  end;

var
  fConexaoBD: TfConexaoBD;

implementation

uses uConst, uFuncoesIni, uDMConexao;

{$R *.dfm}

procedure TfConexaoBD.btnConectarACClick(Sender: TObject);
begin
  inherited;
  if not DMConexao.FDConnAC.Connected then
  begin
    if TestarConexao(edtUserAC.Text, edtSenhaAC.Text, edtCaminhoAC.Text, cbSQLServer.Checked, edtserver.Text) then
    begin
      TFuncoesIni.GravarIni('BANCO_AC', 'User_Name', edtUserAC.Text);
      TFuncoesIni.GravarIni('BANCO_AC', 'Pass', edtSenhaAC.Text);
      TFuncoesIni.GravarIni('BANCO_AC', 'Database', edtCaminhoAC.Text);
      TFuncoesIni.GravarIni('BANCO_AC', 'Server', edtServer.Text);
      if cbSQLServer.Checked then
        TFuncoesIni.GravarIni('BANCO_AC', 'DriveName', 'MSSQL')
      else
        TFuncoesIni.GravarIni('BANCO_AC', 'DriveName', 'FB');
      DMConexao.ConectaAC;
      QueryEmpresa.Open;
    end;
  end
  else
  begin
    DMConexao.FDConnAC.Connected := False;
    QueryEmpresa.Close;
    DMConexao.CodigoEmpresaAC := EmptyStr;
    DMConexao.EmpresaAC := EmptyStr;
    TFuncoesIni.GravarIni('BANCO_AC', 'User_Name', EmptyStr);
    TFuncoesIni.GravarIni('BANCO_AC', 'Pass', EmptyStr);
    TFuncoesIni.GravarIni('BANCO_AC', 'Database', EmptyStr);
  end;
  Status;
end;

procedure TfConexaoBD.btnConectarGACClick(Sender: TObject);
begin
  inherited;
  if not DMConexao.FDConnGAC.Connected then
  begin
    if TestarConexao(edtUserGAC.Text, edtSenhaGAC.Text, edtCaminhoGAC.Text, False) then
    begin
      TFuncoesIni.GravarIni('BANCO_GAC', 'User_Name', edtUserGAC.Text);
      TFuncoesIni.GravarIni('BANCO_GAC', 'Pass', edtSenhaGAC.Text);
      TFuncoesIni.GravarIni('BANCO_GAC', 'Database', edtCaminhoGAC.Text);
      DMConexao.ConectaGAC;
    end;
  end
  else
  begin
    TFuncoesIni.GravarIni('BANCO_GAC', 'User_Name', EmptyStr);
    TFuncoesIni.GravarIni('BANCO_GAC', 'Pass', EmptyStr);
    TFuncoesIni.GravarIni('BANCO_GAC', 'Database', EmptyStr);
    DMConexao.FDConnGAC.Connected := False;
  end;
  Status;
end;

procedure TfConexaoBD.Button1Click(Sender: TObject);
begin
  inherited;
  if QueryEmpresa.Active then
  begin
    DMConexao.EmpresaAC := QueryEmpresaNOME.AsString;
    DMConexao.CodigoEmpresaAC := QueryEmpresaCODIGO.AsString;
    TFuncoesIni.GravarIni('Empresa','Codigo', QueryEmpresaCODIGO.AsString);
    TFuncoesIni.GravarIni('Empresa','Nome', QueryEmpresaNOME.AsString);
    TFuncoesIni.GravarIni('Empresa','Banco_AC', DMConexao.FDConnAC.Params.Values['Database']);
    Close;
  end;
end;

procedure TfConexaoBD.Button2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfConexaoBD.CarregaConfigBD;
begin
  // Carregando dados da conexão do AC a partir do arquivo .ini
  cbUserPassDefault.Checked := False;
  edtCaminhoAC.Text := TFuncoesIni.LerIni('BANCO_AC', 'Database');
  edtUserAC.Text := TFuncoesIni.LerIni('BANCO_AC', 'User_Name');
  edtSenhaAC.Text := TFuncoesIni.LerIni('BANCO_AC', 'Pass');
  edtserver.Text := TFuncoesIni.LerIni('BANCO_AC', 'Server');
  if TFuncoesIni.LerIni('BANCO_AC', 'DriveName') = 'MSSQL' then
    cbSQLServer.Checked := True
  else
    cbSQLServer.Checked := False;


  // Carregando dados da conexão do GAC a partir do arquivo .ini
  edtCaminhoGAC.Text := TFuncoesIni.LerIni('BANCO_GAC', 'Database');
  edtUserGAC.Text := TFuncoesIni.LerIni('BANCO_GAC', 'User_Name');
  edtSenhaGAC.Text := TFuncoesIni.LerIni('BANCO_GAC', 'Pass');
  Status;
end;

procedure TfConexaoBD.cbUserPassDefaultClick(Sender: TObject);
begin
  inherited;
  if cbUserPassDefault.Checked then
  begin
    edtUserAC.Text := USER_FIREBIRD;
    edtSenhaAC.Text := PASS_FIREBIRD;
  end
  else
  begin
    edtUserAC.Text := EmptyStr;
    edtSenhaAC.Text := EmptyStr;
  end;
//  edtUserAC.Enabled := not edtUserAC.Enabled;
//  edtSenhaAC.Enabled := not edtSenhaAC.Enabled;
end;

procedure TfConexaoBD.cbUserPassGACDefaultClick(Sender: TObject);
begin
  inherited;
  if cbUserPassGACDefault.Checked then
  begin
    edtUserGAC.Text := USER_FIREBIRD;
    edtSenhaGAC.Text := PASS_FIREBIRD;
  end
  else
  begin
    edtUserGAC.Text := EmptyStr;
    edtSenhaGAC.Text := EmptyStr;
  end;
  edtUserGAC.Enabled := not edtUserGAC.Enabled;
  edtSenhaGAC.Enabled := not edtSenhaGAC.Enabled;
end;

procedure TfConexaoBD.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists('GeradorContabil.ini') then
    CarregaConfigBD;
  if DMConexao.FDConnAC.Connected then
    if not QueryEmpresa.Active then
      QueryEmpresa.Open;
  Status;
end;

procedure TfConexaoBD.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
  begin
    edtCaminhoAC.Text := OpenDialog.FileName;
  end;
end;

procedure TfConexaoBD.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
  begin
    edtCaminhoGAC.Text := OpenDialog.FileName;
  end;
end;

procedure TfConexaoBD.Status;
begin
  if DMConexao.FDConnAC.Connected then
  begin
    ImgAC.Visible := True;
    btnConectarAC.Caption := 'Desconecta AC';
  end
  else
  begin
    ImgAC.Visible := False;
    btnConectarAC.Caption := 'Conecta AC';
  end;

  if DMConexao.FDConnGAC.Connected then
  begin
    ImgGAC.Visible := True;
    btnConectarGAC.Caption := 'Desconecta Gerador';
  end
  else
  begin
    ImgGAC.Visible := False;
    btnConectarGAC.Caption := 'Conecta Gerador';
  end;
end;

function TfConexaoBD.TestarConexao(User, Pass, DataBase: String; EhSQLServer: Boolean;
  Server: String = 'localhost'): Boolean;
begin
  FDConn.Params.Values['User_Name'] := User;
  FDConn.Params.Values['Password']  := Pass;
  FDConn.Params.Values['Database']  := DataBase;
  FDConn.Params.Values['Server'] := Server;
  if EhSQLServer then
    FDConn.DriverName := 'MSSQL'
  else
  begin
    FDConn.DriverName := 'FB';
    FDConn.Params.Values['Server'] := EmptyStr;
  end;
  try
    FDConn.Connected := True;
    FDConn.Connected := False;
    result := True;
    MessageDlg('Configuração realizada com Sucesso !', mtInformation,
      [mbOK], 0);
  Except
    result := False;
    MessageDlg('Falha na Configuração !', mtInformation, [mbOK], 0);
  end;
end;

end.
