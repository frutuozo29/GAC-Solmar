unit ufMapPlanoContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Vcl.ExtCtrls, Vcl.StdCtrls,
  cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, System.UITypes,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox;

type
  TfMapPlanoContas = class(TfFormBase)
    pnTop: TPanel;
    Label2: TLabel;
    lbl: TLabel;
    gpMapeamento: TGridPanel;
    gridMapPlanoConta: TcxGrid;
    tvMapPlanoConta: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    GridPanel1: TGridPanel;
    edtMapPlanoConta: TEdit;
    edtMapContas: TEdit;
    dsMapPlanoConta: TDataSource;
    tvMapPlanoContaSELECIONADO: TcxGridDBColumn;
    tvMapPlanoContaCONTA: TcxGridDBColumn;
    tvMapPlanoContaNOME: TcxGridDBColumn;
    gridMapContas: TcxGrid;
    tvContas: TcxGridDBTableView;
    cxGridLevel4: TcxGridLevel;
    dsContas: TDataSource;
    tvContasSELECIONADO: TcxGridDBColumn;
    tvContasCODIGO: TcxGridDBColumn;
    tvContasNOME: TcxGridDBColumn;
    Label5: TLabel;
    gridMapeados: TcxGrid;
    tvMapeados: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    dsMapeados: TDataSource;
    tvMapeadosSELECIONADO: TcxGridDBColumn;
    tvMapeadosCONTA: TcxGridDBColumn;
    tvMapeadosNOME: TcxGridDBColumn;
    tvMapeadosCODIGO_AC: TcxGridDBColumn;
    btnDesfazerMapeamento: TButton;
    btnMapear: TButton;
    Label3: TLabel;
    lblEmpContabil: TLabel;
    Button1: TButton;
    Label1: TLabel;
    tvMapeadosCONTA_AC: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure tvMapPlanoContaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtMapPlanoContaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMapPlanoContaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtMapContasKeyPress(Sender: TObject; var Key: Char);
    procedure tvContasKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtMapContasKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMapearClick(Sender: TObject);
    procedure btnDesfazerMapeamentoClick(Sender: TObject);
    procedure tvMapeadosKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure edtMapPlanoContaEnter(Sender: TObject);
    procedure edtMapPlanoContaExit(Sender: TObject);
    procedure edtMapContasEnter(Sender: TObject);
    procedure edtMapContasExit(Sender: TObject);
    procedure tvMapPlanoContaCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure tvContasCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure tvMapeadosCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    FSelecionadoPlanoContas: Integer;
    FSelecionadoContas: Integer;
    { Private declarations }
    property SelecionadoPlanoContas: Integer read FSelecionadoPlanoContas write FSelecionadoPlanoContas;
    property SelecionadoContas: Integer read FSelecionadoContas write FSelecionadoContas;
    procedure PesquisarNaGrid(grid: TcxGridDBTableView; Pesquisa: TEdit);
    procedure Selecionado(DataSet: TDataSet; var Count: Integer; IgnorarQtde: Boolean = False);
    procedure MapearContas;
    procedure LimpaEdits;
  public
    { Public declarations }
  end;

var
  fMapPlanoContas: TfMapPlanoContas;

const
  csPsq = 'DIGITE AQUI PARA PESQUISAR';
  csTxtPlanoContas = '[DIGITE PARA FILTRAR UMA CONTA DO PLANO DE CONTAS]';
  csTxtContaFortes = '[DIGITE PARA FILTRAR UMA CONTA DO FORTES CONTÁBIL]';

implementation

{$R *.dfm}

uses uDMConexao, uDMMapeamento;

procedure TfMapPlanoContas.tvContasCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  if ACellViewInfo.Item.DataBinding.FilterFieldName = 'SELECIONADO' then
    Selecionado(DMMapeamento.QueryContas, FSelecionadoContas);
end;

procedure TfMapPlanoContas.tvContasKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #32 then
    Selecionado(DMMapeamento.QueryContas, FSelecionadoContas);

  if key = #13 then
    btnMapear.SetFocus;
end;

procedure TfMapPlanoContas.btnDesfazerMapeamentoClick(Sender: TObject);
begin
  inherited;
  DMMapeamento.DesfazerMapeamento;
  LimpaEdits;
end;

procedure TfMapPlanoContas.btnMapearClick(Sender: TObject);
begin
  inherited;
  MapearContas;
end;

procedure TfMapPlanoContas.Button1Click(Sender: TObject);
begin
  inherited;
  if MessageDlg('Mapear as Contas do Plano de Contas que tem o mesmo Código das Contas do Fortes Contábil. Deseja prosseguir?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    DMMapeamento.MapearAutomaticamente
  else
    edtMapPlanoConta.SetFocus;
end;

procedure TfMapPlanoContas.edtMapContasEnter(Sender: TObject);
begin
  inherited;
  if edtMapContas.Text = csTxtContaFortes then
    edtMapContas.Text := EmptyStr;
end;

procedure TfMapPlanoContas.edtMapContasExit(Sender: TObject);
begin
  inherited;
  if edtMapContas.Text = EmptyStr then
    edtMapContas.Text := csTxtContaFortes;
end;

procedure TfMapPlanoContas.edtMapContasKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
    gridMapContas.SetFocus;
end;

procedure TfMapPlanoContas.edtMapContasKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  PesquisarNaGrid(tvContas, edtMapContas);
end;

procedure TfMapPlanoContas.edtMapPlanoContaEnter(Sender: TObject);
begin
  inherited;
  if edtMapPlanoConta.Text = csTxtPlanoContas then
    edtMapPlanoConta.Text := EmptyStr;
end;

procedure TfMapPlanoContas.edtMapPlanoContaExit(Sender: TObject);
begin
  inherited;
  if edtMapPlanoConta.Text = EmptyStr then
    edtMapPlanoConta.Text := csTxtPlanoContas;
end;

procedure TfMapPlanoContas.edtMapPlanoContaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    gridMapPlanoConta.SetFocus;
end;

procedure TfMapPlanoContas.edtMapPlanoContaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  PesquisarNaGrid(tvMapPlanoConta, edtMapPlanoConta);
end;

procedure TfMapPlanoContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if DMMapeamento.QueryPlanoContas.Active then
    DMMapeamento.QueryPlanoContas.Close;
end;

procedure TfMapPlanoContas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) then
    if (Key = 13) Then
      MapearContas;
end;

procedure TfMapPlanoContas.FormShow(Sender: TObject);
begin
  inherited;
  lblEmpContabil.Caption := DMConexao.GetEmpresaAC;
  DMMapeamento.AbrirMapeamento;
  SelecionadoPlanoContas := 0;
  SelecionadoContas := 0;
  edtMapPlanoConta.Text := csTxtPlanoContas;
  edtMapContas.Text := csTxtContaFortes;
  edtMapPlanoConta.SetFocus;
end;

procedure TfMapPlanoContas.LimpaEdits;
begin
  edtMapPlanoConta.Text := csTxtPlanoContas;
  edtMapContas.Text := csTxtContaFortes;
end;

procedure TfMapPlanoContas.MapearContas;
begin
  DMMapeamento.Mapear;
  LimpaEdits;
  SelecionadoPlanoContas := 0;
  SelecionadoContas := 0;
  tvMapPlanoConta.DataController.Filter.Root.Clear;
  tvMapPlanoConta.DataController.Filter.Active := False;
  tvContas.DataController.Filter.Root.Clear;
  tvContas.DataController.Filter.Active := False;
  edtMapPlanoConta.SetFocus;
end;

procedure TfMapPlanoContas.PesquisarNaGrid(grid: TcxGridDBTableView;
  Pesquisa: TEdit);
var
  AItemList: TcxFilterCriteriaItemList;
  i: Integer;
begin
  if (Pesquisa.Text <> '') then
  begin
    grid.DataController.Filter.Options := grid.DataController.Filter.Options +
      [fcoCaseInsensitive];
    grid.DataController.Filter.BeginUpdate;
    try
      grid.DataController.Filter.Root.Clear;
      for i := 0 to grid.ColumnCount - 1 do
      begin
        if grid.Columns[i].Visible = True then
        begin
          grid.DataController.Filter.Root.BoolOperatorKind := fboOr;
          AItemList := grid.DataController.Filter.Root.AddItemList(fboOr);
          AItemList.AddItem(grid.Columns[i], foLike, '%' + Pesquisa.Text + '%','%' + Pesquisa.Text + '%');
        end;
      end;
    finally
      grid.DataController.Filter.EndUpdate;
      grid.DataController.Filter.DataController.Filter.Active := True;
    end;
  end
  else
    grid.DataController.Filter.Active := False;
end;

procedure TfMapPlanoContas.tvMapeadosCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  i: Integer;
begin
  inherited;
  if ACellViewInfo.Item.DataBinding.FilterFieldName = 'SELECIONADO' then
    Selecionado(DMMapeamento.QueryMapeados, i, True);
end;

procedure TfMapPlanoContas.tvMapeadosKeyPress(Sender: TObject; var Key: Char);
var
  i: integer;
begin
  inherited;
  if Key = #32 then
    Selecionado(DMMapeamento.QueryMapeados, i, True);
end;

procedure TfMapPlanoContas.tvMapPlanoContaCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  if ACellViewInfo.Item.DataBinding.FilterFieldName = 'SELECIONADO' then
    Selecionado(DMMapeamento.QueryPlanoContas, FSelecionadoPlanoContas);
end;

procedure TfMapPlanoContas.tvMapPlanoContaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #32 then
    Selecionado(DMMapeamento.QueryPlanoContas, FSelecionadoPlanoContas);

  if key = #13 then
    edtMapContas.SetFocus;
end;

procedure TfMapPlanoContas.Selecionado(DataSet: TDataSet; var Count: Integer; IgnorarQtde: Boolean = False);
var
  i: Integer;
begin
  if DataSet.FieldByName('selecionado').AsInteger = 0 then
    i := 1
  else
    i := 0;

  if (Count = 1) and (i = 1) and (not IgnorarQtde) then
  begin
    MessageDlg('Não é possível selecionar dois registros de uma vez!', mtinformation, [mbOK], 0);
    Exit;
  end;

  if DataSet.State = dsEdit then
    DataSet.Post;
  DataSet.Edit;
  DataSet.FieldByName('selecionado').AsInteger := i;
  DataSet.Post;
  DataSet.Next;
  Count := i;
end;

end.
