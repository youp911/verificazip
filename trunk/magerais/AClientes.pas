unit AClientes;
{          Autor: Rafael Budag
    Data Criação: 25/03/1999;
          Função: Cadastrar uma nova transportadora
  Data Alteração: 25/03/1999;
    Alterado por:
Motivo alteração:
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  BotaoCadastro, StdCtrls, Buttons, DBKeyViolation, Grids, DBGrids, Tabela,
  Mask, Menus, UnSistema, UnContrato, DBCtrls, UnDadosLocaliza, DBClient, UnDados, UnClientes;

type
  TFClientes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DataCadCliente: TDataSource;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoConsultar1: TBotaoConsultar;
    BFechar: TBitBtn;
    DBGridColor1: TGridIndice;
    PanelColor3: TPanelColor;
    CadClientes: TSQL;
    CadClientesI_COD_CLI: TFMTBCDField;
    CadClientesC_NOM_CLI: TWideStringField;
    CadClientesC_CID_CLI: TWideStringField;
    CadClientesC_TIP_CAD: TWideStringField;
    Label1: TLabel;
    CadClientesC_FO1_CLI: TWideStringField;
    CadClientesC_FON_FAX: TWideStringField;
    BContratos: TBitBtn;
    ENomCliente: TEditColor;
    ECodCliente: TEditColor;
    Label2: TLabel;
    ENomFantasia: TEditColor;
    Label3: TLabel;
    CadClientesC_NOM_FAN: TWideStringField;
    BitBtn2: TBitBtn;
    ETelefone: TMaskEditColor;
    Label13: TLabel;
    BCotacoes: TBitBtn;
    BCobrancas: TBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    NovaCotao1: TMenuItem;
    MTeleMarketing: TMenuItem;
    BBrindes: TBitBtn;
    BProdutos: TBitBtn;
    Label4: TLabel;
    ECNPJ: TMaskEditColor;
    N2: TMenuItem;
    MChamado: TMenuItem;
    Label5: TLabel;
    ECidade: TEditColor;
    Label6: TLabel;
    EBairro: TEditColor;
    BChamados: TBitBtn;
    N3: TMenuItem;
    ProcessarFaturamentoPosterior1: TMenuItem;
    BContatos: TBitBtn;
    BReserva: TBitBtn;
    CCliente: TCheckBox;
    CFornecedor: TCheckBox;
    CProspect: TCheckBox;
    N4: TMenuItem;
    NovaProposta1: TMenuItem;
    N5: TMenuItem;
    Visitas1: TMenuItem;
    Label11: TLabel;
    EVendedor: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    LNomVendedor: TLabel;
    Localiza: TConsultaPadrao;
    N6: TMenuItem;
    CrditoCliente1: TMenuItem;
    Filhos1: TMenuItem;
    N7: TMenuItem;
    BPropostas: TBitBtn;
    EUF: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label7: TLabel;
    N8: TMenuItem;
    ImprimirEnvelope1: TMenuItem;
    ImprimirEnvelopeCobrana1: TMenuItem;
    ImprimirEnvelopeEntrega1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure cliClick(Sender: TObject);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure BBAjudaClick(Sender: TObject);
    procedure BotaoConsultar1AntesAtividade(Sender: TObject);
    procedure ENomClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGridColor1DblClick(Sender: TObject);
    procedure BCotacoesClick(Sender: TObject);
    procedure BCobrancasClick(Sender: TObject);
    procedure BContratosClick(Sender: TObject);
    procedure NovaCotao1Click(Sender: TObject);
    procedure MTeleMarketingClick(Sender: TObject);
    procedure BBrindesClick(Sender: TObject);
    procedure BProdutosClick(Sender: TObject);
    procedure ENomClienteExit(Sender: TObject);
    procedure ENomFantasiaExit(Sender: TObject);
    procedure ECNPJExit(Sender: TObject);
    procedure MChamadoClick(Sender: TObject);
    procedure BChamadosClick(Sender: TObject);
    procedure ProcessarFaturamentoPosterior1Click(Sender: TObject);
    procedure BContatosClick(Sender: TObject);
    procedure BReservaClick(Sender: TObject);
    procedure NovaProposta1Click(Sender: TObject);
    procedure Visitas1Click(Sender: TObject);
    procedure ECidadeExit(Sender: TObject);
    procedure CrditoCliente1Click(Sender: TObject);
    procedure Filhos1Click(Sender: TObject);
    procedure BPropostasClick(Sender: TObject);
    procedure ImprimirEnvelope1Click(Sender: TObject);
    procedure ImprimirEnvelopeCobrana1Click(Sender: TObject);
    procedure ImprimirEnvelopeEntrega1Click(Sender: TObject);
  private
    VprOrdem,
    VprNomCliente,
    VprNomFantasia : string;
    VprDCliente : TRBDCliente;
    FunContratos : TRBFuncoesContrato;
    procedure AtualizaConsulta(VpaPosicionar : Boolean = false);
    procedure Adicionafiltros(VpaSelect : Tstrings);
    procedure ConfiguraPermissaoUsuario;
  public
  end;

var
  FClientes: TFClientes;

implementation

uses APrincipal, ANovoCliente, constantes, Funsql,
  FunString, ACotacao, ANovaCobranca, FunObjeto,
  AContratosCliente, ANovaCotacao, ANovoTeleMarketing, ABrindesCliente,
  AProdutosCliente, AParentesCliente, ANovoChamadoTecnico,
  AChamadosTecnicos, fundata, Constmsg, AContatosCliente, AProdutosReserva,
  ANovaProposta, ANovoAgendamento, ACreditoCliente, APropostasCliente, dmRave;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }

procedure TFClientes.FormCreate(Sender: TObject);
begin
  FunContratos := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  VprDCliente := TRBDCliente.cria;
  ConfiguraPermissaoUsuario;
  VprNomCliente := '';
  VprNomFantasia := '';
  Vprordem := 'order by i_cod_cli';
  AtualizaConsulta;
  CCliente.OnClick(self);
  if not ConfigModulos.TeleMarketing then
    MTeleMarketing.Visible := false;
  if not ConfigModulos.OrdemServico then
    BChamados.Visible := false;
  if not config.ControlarBrinde then
    BBrindes.Visible := false;
end;

procedure TFClientes.ImprimirEnvelope1Click(Sender: TObject);
begin
  if CadClientesI_cod_CLI.AsInteger <> 0 then
  begin
    VprDCliente.free;
    VprDCliente := TRBDCliente.cria;
    VprDCliente.CodCliente := CadClientesI_cod_CLI.AsInteger;
    FunClientes.CarDCliente(VprDCliente);
    if VprDCliente.DesEnderecoEntrega <> '' then
      if not confirmacao('Esse cliente possui endereço de ENTREGA. Deseja realmente imprimir o endereço padrão?') then
        exit;
    if VprDCliente.DesEnderecoCobranca <> '' then
      if not confirmacao('Esse cliente possui endereço de COBRANÇA. Deseja realmente imprimir o endereço padrão?') then
        exit;
    dtRave := TdtRave.create(self);
    dtRave.ImprimeEnvelope(VprDCliente);
    dtRave.free;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFClientes.ImprimirEnvelopeCobrana1Click(Sender: TObject);
begin
  if CadClientesI_cod_CLI.AsInteger <> 0 then
  begin
    VprDCliente.free;
    VprDCliente := TRBDCliente.cria;
    VprDCliente.CodCliente := CadClientesI_cod_CLI.AsInteger;
    FunClientes.CarDCliente(VprDCliente);
    dtRave := TdtRave.create(self);
    dtRave.ImprimeEnvelopeCobranca(VprDCliente);
    dtRave.free;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFClientes.ImprimirEnvelopeEntrega1Click(Sender: TObject);
begin
  if CadClientesI_cod_CLI.AsInteger <> 0 then
  begin
    VprDCliente.free;
    VprDCliente := TRBDCliente.cria;
    VprDCliente.CodCliente := CadClientesI_cod_CLI.AsInteger;
    FunClientes.CarDCliente(VprDCliente);
    dtRave := TdtRave.create(self);
    dtRave.ImprimeEnvelopeEntrega(VprDCliente);
    dtRave.free;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadClientes.close;
   FunContratos.free;
   VprDCliente.free;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************************Fecha o formulario conrrente*************************}
procedure TFClientes.BFecharClick(Sender: TObject);
begin
   Close;
end;

{*****************************Procura o cliente********************************}
procedure TFClientes.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                 ' Where I_COD_CLI = '+CadClientesI_COD_CLI.AsString);
   
end;

{***************Cria o formluario pra cadastrar novos registros****************}
procedure TFClientes.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
end;

{*************Chama a tela de novos registros e atualiza a tabela**************}
procedure TFClientes.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  if FNovoCliente.CadClientes.State = dsinsert then
  begin
    FNovoCliente.CProspect.Checked:= CProspect.Checked;
    FNovoCliente.CCliente.Checked:= CCliente.Checked;
    FNovoCliente.CFornecedor.Checked:= CFornecedor.Checked;
  end;
  FNovoCliente.ShowModal;
  AtualizaConsulta(true);
end;

{*********************Mostra o registro que será excluido**********************}
procedure TFClientes.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
   FNovoCliente.show;
end;

{***********Fecha o Formulario de novos registros e atualiza a tabela**********}
procedure TFClientes.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
   FNovoCliente.Close;
   AtualizaConsulta(true);
end;

{*********** consulta clientes ********************************************** }
procedure TFClientes.BotaoConsultar1AntesAtividade(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(Application,'',true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********Chama a rotina para atualizar o tipo de cadastro mostrado**********}
procedure TFClientes.cliClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFClientes.AtualizaConsulta(VpaPosicionar : Boolean = false);
var
  VpfPosicao : TBookmark;
begin
  if VpaPosicionar then
    VpfPosicao := CadClientes.GetBookmark;
  cadclientes.close;
  CadClientes.sql.clear;
  cadclientes.sql.add('Select * from CadClientes ' +
                      'Where I_COD_CLI = I_COD_CLI ');
  adicionaFiltros(Cadclientes.sql);
  CadClientes.sql.add(VprOrdem);
  GravaEstatisticaConsulta(Nil,cADClientes,varia.CodigoUsuario,Self.name,NomeModulo,config.UtilizarPercentualConsulta);
  Cadclientes.open;
  DBGridColor1.ALinhaSQLOrderBy := cadclientes.sql.count -1;
  if VpaPosicionar then
    try
      CadClientes.GotoBookmark(Vpfposicao);
      cadclientes.freebookmark(vpfposicao);
    except
    end;
  VprNomCliente :=  ENomCliente.text;
  VprNomFantasia := ENomFantasia.Text;
end;

{******************************************************************************}
procedure TFClientes.Adicionafiltros(VpaSelect : Tstrings);
var
  VpfLinha : String;
begin
  if ECodCliente.Text <> '' then
    VpaSelect.Add('and I_COD_CLI = '+ECodCliente.Text)
  else
  begin
    if ENomCliente.Text <> '' then
      VpaSelect.add(' AND C_Nom_Cli like '''+ENomCliente.text+'%''');

    if CCliente.Checked or CFornecedor.Checked  or CProspect.Checked then
    begin
      VpaSelect.add(' and (');
      if CCliente.Checked then
        VpfLinha := 'or C_IND_CLI = ''S''';
      if CFornecedor.Checked then
        VpfLinha := VpfLinha +'or C_IND_FOR = ''S''';
      if CProspect.Checked then
        VpfLinha := VpfLinha +'or C_IND_PRC = ''S''';
      vpflinha := copy(Vpflinha,3,length(Vpflinha)-2);
      VpaSelect.add(vpflinha +')');
    end;

    if ENomFantasia.text <> '' then
      VpaSelect.Add('and C_NOM_FAN LIKE '''+ENomFantasia.Text+'%''');
    if ECidade.Text <> '' then
      VpaSelect.Add('and C_CID_CLI LIKE '''+ECidade.Text+'%''');
    if EUF.Text <> '' then
      VpaSelect.Add('and C_EST_CLI = '''+EUF.Text+'''');
    if EBairro.Text <> '' then
      VpaSelect.Add('and C_BAI_CLI LIKE '''+EBairro.Text+'%''');

    if DeletaChars(DeletaChars(DeletaChars(DeletaChars(ECNPJ.Text,'.'),'-'),'/'),' ') <> '' then
    begin
      VpaSelect.add(' and C_CGC_CLI = '''+ECNPJ.text+'''');
    end;

    if EVendedor.AInteiro <> 0 then
      VpaSelect.Add('and I_COD_VEN = '+ EVendedor.Text);

    if DeletaChars(DeletaChars(DeletaChars(DeletaChars(ETelefone.Text,'('),')'),'-'),' ') <> '' then
      VpaSelect.Add(' and( C_FO1_CLI LIKE '''+ETelefone.Text+'%''or '+
                    ' C_FO2_CLI LIKE '''+ETelefone.Text+'%''or '+
                    ' C_FO3_CLI LIKE '''+ETelefone.Text+'%''or '+
                    ' C_FON_FAX LIKE '''+ETelefone.Text+'%'')');
  end;
  if (puSomenteClientesdoVendedor in varia.PermissoesUsuario) then
    VpaSelect.Add('and I_COD_VEN in '+varia.CodigosVendedores);
end;

{******************************************************************************}
procedure TFClientes.ConfiguraPermissaoUsuario;
begin
  if (puCRSomenteCadastraProspect in varia.PermissoesUsuario) then
  begin
    AlterarVisibleDet([BotaoAlterar1,BotaoExcluir1,BCotacoes,BCobrancas,BChamados,BContratos],false);
    AlterarEnabledDet([CCliente,CProspect,CFornecedor],false);
    CProspect.Checked := true;
    CCliente.Checked := false;
  end;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFClientes.DBGridColor1Ordem(Ordem: String);
begin
  VprOrdem := ordem;
end;

{******************************************************************************}
procedure TFClientes.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFClientes.ENomClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    13 : cliClick(CCliente);
  end;
end;

{******************************************************************************}
procedure TFClientes.BitBtn2Click(Sender: TObject);
begin
  ETelefone.Clear;
  cliClick(self);
end;

{******************************************************************************}
procedure TFClientes.DBGridColor1DblClick(Sender: TObject);
begin
  BotaoConsultar1.Click;
end;

procedure TFClientes.BCotacoesClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FCotacao := TFCotacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCotacao'));
    FCotacao.ConsultaCotacoesCliente(CadClientesI_COD_CLI.AsInteger);
    FCotacao.free;
  end;
end;

procedure TFClientes.BCobrancasClick(Sender: TObject);
begin
  FNovaCobranca := TFNovaCobranca.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCobranca'));
  FNovaCobranca.CobrancaCliente(CadClientesI_COD_CLI.AsInteger);
  FNovaCobranca.free;
end;


{******************************************************************************}
procedure TFClientes.BContratosClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FContratosCliente := tFContratosCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FContratosCliente'));
    FContratosCliente.ContratosCliente(CadClientesI_COD_CLI.AsInteger);
    FContratosCliente.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.NovaCotao1Click(Sender: TObject);
begin
  FNovaCotacao := TFNovaCotacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCotacao'));
  FNovaCotacao.NovaCotacaoCliente(CadClientesI_COD_CLI.AsInteger);
  FNovaCotacao.free;
end;

{******************************************************************************}
procedure TFClientes.MTeleMarketingClick(Sender: TObject);
begin
  if not CadClientes.Eof then
  begin
    FNovoTeleMarketing := TFNovoTeleMarketing.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoTeleMarketing'));
    FNovoTeleMarketing.TeleMarketingCliente(CadClientesI_COD_CLI.AsInteger);
    FNovoTeleMarketing.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.BBrindesClick(Sender: TObject);
begin
  FBrindesCliente := TFBrindesCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FBrindesCliente'));
  FBrindesCliente.BrindesCliente(CadClientesI_COD_CLI.AsInteger);
  FBrindesCliente.free;
end;

procedure TFClientes.BProdutosClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FProdutosCliente := TFProdutosCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProdutosCliente'));
    FProdutosCliente.CadastraProdutos(CadClientesI_COD_CLI.AsInteger);
    FProdutosCliente.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.ENomClienteExit(Sender: TObject);
begin
  if VprNomCliente <> ENomCliente.Text then
  begin
     AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFClientes.ENomFantasiaExit(Sender: TObject);
begin
  if VprNomFantasia <> ENomFantasia.Text then
  begin
     AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFClientes.ECNPJExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFClientes.MChamadoClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('TFNovoChamado'));
    FNovoChamado.NovoChamadoCliente(CadClientesI_COD_CLI.AsInteger);
    FNovoChamado.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.BChamadosClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FChamadoTecnico := TFChamadoTecnico.CriarSDI(self,'',FPrincipal.VerificaPermisao('FChamadoTecnico'));
    FChamadoTecnico.ConsultaChamadosCliente(CadClientesI_COD_CLI.AsInteger);
    FChamadoTecnico.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.ProcessarFaturamentoPosterior1Click(Sender: TObject);
var
  Vpflabel : TLabel;
  VpfLanOrcamento : Integer;
  VpfResultado : String;
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    Vpflabel := TLabel.Create(nil);
    VpfResultado := FunContratos.ProcessaFaturamentoPosterior(nil,Vpflabel,DecMes(date,6),Date,CadClientesI_COD_CLI.AsInteger,VpfLanOrcamento,nil,true);
    VpfLabel.free;
    if vpfresultado <> '' then
      aviso(vpfresultado);
  end;
end;

{******************************************************************************}
procedure TFClientes.BContatosClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FContatosCliente:= TFContatosCliente.CriarSDI(Application,'',True);
    FContatosCliente.CadastraContatos(CadClientesI_COD_CLI.AsInteger);
    FContatosCliente.Free;
  end;
end;

{******************************************************************************}
procedure TFClientes.BReservaClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FProdutosReserva:= TFProdutosReserva.CriarSDI(Application,'',True);
    FProdutosReserva.ProdutosReserva(CadClientesI_COD_CLI.AsInteger);
    FProdutosReserva.Free;
  end;
end;

{******************************************************************************}
procedure TFClientes.NovaProposta1Click(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    FNovaProposta.NovaPropostaCliente(CadClientesI_COD_CLI.asinteger);
    FNovaProposta.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.Visitas1Click(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FNovoAgedamento := tFNovoAgedamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoAgedamento'));
    FNovoAgedamento.NovaAgendaCliente(CadClientesI_Cod_Cli.AsInteger);
    FNovoAgedamento.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.ECidadeExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFClientes.CrditoCliente1Click(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FCreditoCliente := TFCreditoCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCreditoCliente'));
    FCreditoCliente.CreditoCliente(CadClientesI_COD_CLI.AsInteger);
    FCreditoCliente.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.Filhos1Click(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FParentesClientes := TFParentesClientes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FParentesClientes'));
    FParentesClientes.ParentesClientes(CadClientesI_COD_CLI.asInteger);
    FParentesClientes.free;
  end;
end;

procedure TFClientes.BPropostasClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FPropostasCliente := TFPropostasCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPropostasCliente'));
    FPropostasCliente.ConsultaPropostas(CadClientesI_COD_CLI.AsInteger);
    FPropostasCliente.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFClientes]);
end.
