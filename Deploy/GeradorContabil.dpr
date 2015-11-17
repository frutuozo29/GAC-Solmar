program GeradorContabil;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uPrincipal in '..\Fonte\uPrincipal.pas' {fPrincipal},
  uFormBase in '..\Fonte\uFormBase.pas' {fFormBase},
  uConexaoBD in '..\Fonte\uConexaoBD.pas' {fConexaoBD},
  uConst in '..\Fonte\uConst.pas',
  uFuncoesIni in '..\Fonte\uFuncoesIni.pas',
  uDMConexao in '..\Fonte\uDMConexao.pas' {DMConexao: TDataModule},
  uFSelEmpresa in '..\Fonte\uFSelEmpresa.pas' {fSelEmpresa},
  uFLeituraPlanoContas in '..\Fonte\uFLeituraPlanoContas.pas' {fLeituraPlanoContas},
  uDMPlanodeContas in '..\Fonte\uDMPlanodeContas.pas' {DMPlanodeContas: TDataModule},
  uFImportacao in '..\Fonte\uFImportacao.pas' {fImportacao},
  uInterfaceQuery in '..\Fonte\uInterfaceQuery.pas',
  ufAtualizaBancoDados in '..\Fonte\ufAtualizaBancoDados.pas' {fAtualizaBancoDados},
  uFLeituraRazaoAnalitica in '..\Fonte\uFLeituraRazaoAnalitica.pas' {fLeituraRazaoAnalitica},
  uDMRazaoAnalitica in '..\Fonte\uDMRazaoAnalitica.pas' {DMRazaoAnalitica: TDataModule},
  uFuncoes in '..\Fonte\uFuncoes.pas',
  ufMapPlanoContas in '..\Fonte\ufMapPlanoContas.pas' {fMapPlanoContas},
  uDMMapeamento in '..\Fonte\uDMMapeamento.pas' {DMMapeamento: TDataModule},
  uGeracaoArquivo in '..\Fonte\uGeracaoArquivo.pas' {fGeracaoArquivo},
  uDMImportacao in '..\Fonte\uDMImportacao.pas' {DMImportacao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Emerald Light Slate');
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TDMPlanodeContas, DMPlanodeContas);
  Application.CreateForm(TDMRazaoAnalitica, DMRazaoAnalitica);
  Application.CreateForm(TDMMapeamento, DMMapeamento);
  Application.CreateForm(TDMImportacao, DMImportacao);
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.
