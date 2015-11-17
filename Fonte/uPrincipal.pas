unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.UITypes, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ToolWin,
  Vcl.ComCtrls, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus, Vcl.ImgList, ShellApi;

type
  TfPrincipal = class(TForm)
    pnEmpresaFortes: TPanel;
    lblEmpresaAC: TLabel;
    ActnManager: TActionManager;
    acLeituraPlanoContas: TAction;
    acLeituraRazaoAnalitico: TAction;
    acGerarArquivo: TAction;
    acMapeamentoPlanoContas: TAction;
    acConexao: TAction;
    acEmpresa: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionToolBar1: TActionToolBar;
    acSair: TAction;
    ImageList: TImageList;
    StatusBar1: TStatusBar;
    Timer: TTimer;
    acConvArquivo: TAction;
    acMapeamento: TAction;
    procedure acLeituraPlanoContasExecute(Sender: TObject);
    procedure acLeituraRazaoAnaliticoExecute(Sender: TObject);
    procedure acMapeamentoPlanoContasExecute(Sender: TObject);
    procedure acConexaoExecute(Sender: TObject);
    procedure acEmpresaExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acConvArquivoExecute(Sender: TObject);
    procedure acMapeamentoExecute(Sender: TObject);
    procedure acGerarArquivoExecute(Sender: TObject);
  private
    { Private declarations }
    function VerificarEmpresa: Boolean;
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.dfm}

uses uConexaoBD, uDMConexao, uFSelEmpresa, uFLeituraPlanoContas, uFImportacao, uDMPlanodeContas, uFuncoesIni,
  ufAtualizaBancoDados, uFLeituraRazaoAnalitica, ufMapPlanoContas, uGeracaoArquivo;

procedure TfPrincipal.acConexaoExecute(Sender: TObject);
begin
  if fConexaoBD = nil  then
  begin
    fConexaoBD := TfConexaoBD.Create(Self);
    fConexaoBD.ShowModal;
  end
  else
    fConexaoBD.ShowModal;

  if DMConexao.CodigoEmpresaAC <> '' then
    lblEmpresaAC.Caption := 'Empresa Fortes Contábil: '+ DMConexao.GetEmpresaAC
  else
    lblEmpresaAC.Caption := 'Empresa Fortes Contábil: Nenhuma empresa selecionada.';
end;

procedure TfPrincipal.acConvArquivoExecute(Sender: TObject);
begin
  if MessageDlg('Para Conversão do arquivo para o Layout de conversão do sistema é necessario acessar '+
                'o site www.zamzar.com e informar um email. Deseja acessar agora?',mtConfirmation,[mbYes, mbNo],0) = mrYes then
    ShellExecute(Handle,'open','http://www.zamzar.com/',nil,nil,SW_SHOWNORMAL);
end;

procedure TfPrincipal.acEmpresaExecute(Sender: TObject);
var
  Empresa: String;
begin
  if DMConexao.VerificaConexaoAC then
  begin
    Empresa := TfSelEmpresa.Inicializa;
    if Empresa <> ' - ' then
      lblEmpresaAC.Caption := 'Empresa Fortes Contábil: '+ Empresa
    else
      lblEmpresaAC.Caption := 'Empresa Fortes Contábil: Nenhuma empresa selecionada.';
  end
  else
    ShowMessage('Não conectado com Banco de dados Fortes Contábil');
end;

procedure TfPrincipal.acGerarArquivoExecute(Sender: TObject);
begin
  if fGeracaoArquivo = nil then
  begin
    fGeracaoArquivo := TfGeracaoArquivo.Create(Self);
    fGeracaoArquivo.Show;
  end
  else
    fGeracaoArquivo.Show;
end;

procedure TfPrincipal.acLeituraPlanoContasExecute(Sender: TObject);
begin
  if not VerificarEmpresa then
    Exit;

  if fLeituraPlanoContas = nil then
  begin
    fLeituraPlanoContas := TfLeituraPlanoContas.Create(Self);
    fLeituraPlanoContas.Show;
  end
  else
    fLeituraPlanoContas.Show;
end;

procedure TfPrincipal.acLeituraRazaoAnaliticoExecute(Sender: TObject);
begin
  if not VerificarEmpresa then
    Exit;

  if fLeituraRazaoAnalitica = nil then
  begin
    fLeituraRazaoAnalitica := TfLeituraRazaoAnalitica.Create(Self);
    fLeituraRazaoAnalitica.Show;
  end
  else
    fLeituraRazaoAnalitica.Show;
end;

procedure TfPrincipal.acMapeamentoExecute(Sender: TObject);
begin
  if fMapPlanoContas = nil then
  begin
    fMapPlanoContas := TfMapPlanoContas.Create(Self);
    fMapPlanoContas.Show;
  end
  else
    fMapPlanoContas.Show;
end;

procedure TfPrincipal.acMapeamentoPlanoContasExecute(Sender: TObject);
begin
 //
end;

procedure TfPrincipal.acSairExecute(Sender: TObject);
begin
  if MessageDlg('Fechar Sistema?',mtconfirmation,[mbYes, mbNo],0) = mrYes then
    Close;
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
var
  Msg: String;
  PrecisaAtualizar: Boolean;
begin
  Statusbar1.Panels[0].Text := ' '+formatdatetime ('dddd", "dd" de "mmmm" de "yyyy',now);

  if not FileExists('GeradorContabil.ini') then
    MessageBox(0,'O Arquivo de Configurações do banco de dados não foi localizado.'+#13+
                 'Favor realizar uma nova configuração no Menu - Configurações - Conexão.', 'Informação', MB_ICONASTERISK + MB_OK + MB_DEFBUTTON1)
  else
  begin
    DMConexao.ConectarBancos;
    if DMConexao.FDConnAC.Connected then
    begin
      if TFuncoesIni.LerIni('Empresa','Banco_AC') = TFuncoesIni.LerIni('BANCO_AC','Database') then
      begin
        DMConexao.CodigoEmpresaAC := TFuncoesIni.LerIni('Empresa','Codigo');
        DMConexao.EmpresaAC := TFuncoesIni.LerIni('Empresa','Nome');
        if (DMConexao.CodigoEmpresaAC <> EmptyStr) and (DMConexao.EmpresaAC <> EmptyStr) then
          lblEmpresaAC.Caption := 'Empresa Fortes Contábil: '+ DMConexao.CodigoEmpresaAC+' - '+DMConexao.EmpresaAC;
      end;
    end;
    if DMConexao.FDConnGAC.Connected then
    begin
      PrecisaAtualizar := DMConexao.PrecisaAtualizar(Msg);
      if PrecisaAtualizar then
      begin

        if Msg = AtualizarBanco then
        begin
          MessageBox(0, AtualizarBanco , 'Informação', MB_ICONASTERISK + MB_OK + MB_DEFBUTTON1);
          if not TfAtualizaBancoDados.Inicializa(VersaoAplicacao) then
          begin
            ShowMessage('Não foi possível atualizar o Banco, contate o suporte.');
            Application.Terminate;
          end;
        end
        else if Msg = AtualizarAplicacao then
        begin
          MessageBox(0, AtualizarAplicacao , 'Informação', MB_ICONASTERISK + MB_OK + MB_DEFBUTTON1);
          Application.Terminate;
        end;
      end;
    end;
  end;
end;

procedure TfPrincipal.TimerTimer(Sender: TObject);
begin
  statusbar1.Panels[1].Text := ' '+formatdatetime ('hh:mm:ss',now);
end;

function TfPrincipal.VerificarEmpresa: Boolean;
begin
  Result := True;
  if DMConexao.CodigoEmpresaAC = '' then
  begin
    MessageBox(0,'Nenhuma empresa selecionada.'+#13+
    'Selecione a empresa no Menu - Configurações - Empresa Fortes Contábil', 'Informação', MB_ICONASTERISK + MB_OK + MB_DEFBUTTON1);
    Result := False;
  end;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;
end.
