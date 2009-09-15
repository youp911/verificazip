Unit UnNFe;
{Verificado
-.edit;
}
Interface

Uses Classes, SqlExpr, ACBrNFe, forms, pcnConversao,ComCtrls,ACBrNFeDANFEClass, ACBrNFeDANFERave,
  UnDadosProduto,pcnNFe, SysUtils, UnDados;

//classe funcoes
Type TRBFuncoesNFe = class
  private
    VprStatusBar : TStatusBar;
    Aux : TSQLQuery;
    procedure AtualizaStatus(VpaStatus : TStatusBar;VpaTexto : String);
    procedure HigienizaPais(VpaErros : TStrings;VpaStatus : TStatusBar);
    procedure HigienizarCidades(VpaErros : TStrings;VpaStatus : TStatusBar);
    procedure HigienizarClientes(VpaErros,VpaCorrigidos : TStrings;VpaStatus : TStatusBar);
    function VerificacoesEmitente : String;
    function VerificacoesDestinatario(VpaDCliente : TRBDCliente):string;
    procedure CarDNotaNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDEmitenteNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDDestinatarioNfe(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente;VpaDNFe : TNFe);
    procedure CarDProdutoNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDServicosNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDTotalNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDTransporteNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarFaturas(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
    procedure CarDObservacoesNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
  public
    NFe : TACBrNFe;
    Danfe : TACBrNFeDANFERave;
    constructor cria(VpaBaseDados : TSQLConnection );
    destructor destroy;override;
    procedure MostraStatusOperacao(VpaObjeto : TObject);
    function VerificaStatusServico(VpaBarraStatus : TStatusBar) : String;
    function RUF(VpaCodFiscalMunicipio : String):String;
    function EmiteNota(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente;VpaBarraStatus : TStatusBar):string;
    function ImprimeDanfe(VpaDNota : TRBDNotaFiscal):String;
    function EnviaEmailDanfe(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente):String;
    function CancelaNFE(VpaDNota : TRBDNotaFiscal;VpaMotivo : String):string;
    procedure HigienizarCadastros(VpaErros, VpaCorrigidos : TStrings;VpaStatus : TStatusBar);
end;



implementation

Uses FunSql, Constantes, funString, Constmsg, UnNotaFiscal, UnClientes, FunValida, FunNumeros;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesNFe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesNFe.cria(VpaBaseDados : TSQLConnection );
begin
  inherited create;
  Aux := TSQLQuery.Create(nil);
  Aux.SQLConnection := VpaBaseDados;
  NFe := TACBrNFe.Create(Application);
  NFe.OnStatusChange := MostraStatusOperacao;
  if config.EmiteNFe then
  begin
    NFe.Configuracoes.Certificados.NumeroSerie := varia.CertificadoNFE;
    NFe.Configuracoes.Geral.Salvar := true;
    NFe.Configuracoes.Geral.PathSalvar := Varia.PathVersoes+'\NFe';
//    NFe.Configuracoes.Geral.FormaEmissao

    NFe.Configuracoes.WebServices.UF := Varia.UFSefazNFE;
    if config.NFEHomologacao then
      Nfe.Configuracoes.WebServices.Ambiente := taHomologacao
    else
      Nfe.Configuracoes.WebServices.Ambiente := taProducao;
    NFe.Configuracoes.WebServices.Visualizar := true;

  end;
end;

{******************************************************************************}
destructor TRBFuncoesNFe.destroy;
begin
  NFE.free;
  inherited;
end;

{******************************************************************************}
function TRBFuncoesNFe.VerificacoesEmitente : String;
begin
  result := '';
  if Varia.CodIBGEMunicipio = 0  then
    result := 'CODIGO IBGE MUNICIPIO EMITENTE NÃO PREENCHIDO!!!'#13'É necessário importar os municipios com o codigo o IBGE, em seguida altere a filial entre e saia do campo cidade.';
end;

function TRBFuncoesNFe.VerificacoesDestinatario(VpaDCliente : TRBDCliente):string;
begin
  result := '';
  if VpaDCliente.CodIBGECidade = 0  then
    result := 'CODIGO IBGE MUNICIPIO DESTINATARIO NÃO PREENCHIDO!!!'#13'É necessário importar os municipios com o codigo o IBGE, em seguida altere o cliente entre e saia do campo cidade.';
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDNotaNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
begin
  VpaDNFe.infNFe.ID := InttoStr(VpaDNota.NumNota);
  VpaDNFe.Ide.natOp     := FunNotaFiscal.RNomNaturezaOperacao(VpaDNota.CodNatureza,VpaDNota.SeqItemNatureza);
  VpaDNFe.Ide.nNF       := VpaDNota.NumNota;
  VpaDNFe.Ide.cNF       := VpaDNota.NumNota;
  VpaDNFe.Ide.modelo    := 55;
  VpaDNFe.Ide.serie     := StrToInt(VpaDNota.DesSerie);
  VpaDNFe.ide.dEmi      := VpaDNota.DatEmissao;
  VpaDNFe.Ide.dSaiEnt   := VpaDNota.DatSaida;
  VpaDNFe.Ide.dSaiEnt   := VpaDNota.DatSaida;
  if config.NFEHomologacao then
    VpaDNFe.Ide.tpAmb     := taHomologacao
  else
    VpaDNFe.Ide.tpAmb     := taProducao;

  if VpaDNota.DesTipoNota = 'E' then
    VpaDNFe.Ide.tpNF      := tnEntrada
  else
    VpaDNFe.Ide.tpNF      := tnSaida;
  if VpaDNota.CodCondicaoPagamento = Varia.CondPagtoVista then
    VpaDNFe.Ide.indPag    := ipVista
  else
    VpaDNFe.Ide.indPag    := ipPrazo;
  VpaDNFe.Ide.verProc   := '1.0.0.0';
  VpaDNFe.Ide.cUF       := StrToInt(copy(IntToStr(varia.CodIBGEMunicipio),1,2));
  VpaDNFe.Ide.cMunFG    := Varia.CodIBGEMunicipio;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDEmitenteNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
begin
  VpaDNFe.Emit.CNPJCPF           := varia.CNPJFilial;
  VpaDNFe.Emit.xNome             := varia.RazaoSocialFilial;
  VpaDNFe.Emit.xFant             := varia.NomeFilial;
  VpaDNFe.Emit.EnderEmit.xLgr    := Varia.EnderecoFilial;
//    VpaDNFe.Emit.EnderEmit.nro     := edtEmitNumero.Text;
//    VpaDNFe.Emit.EnderEmit.xCpl    := edtEmitComp.Text;
  VpaDNFe.Emit.EnderEmit.xBairro := varia.BairroFilial;
  VpaDNFe.Emit.EnderEmit.cMun    := varia.CodIBGEMunicipio;
  VpaDNFe.Emit.EnderEmit.xMun    := varia.CidadeFilial;
  VpaDNFe.Emit.EnderEmit.UF      := varia.UFFilial;
  VpaDNFe.Emit.EnderEmit.CEP     := StrToInt(Deletachars(varia.CepFilial,'-'));
  VpaDNFe.Emit.enderEmit.cPais   := 1058;
  VpaDNFe.Emit.enderEmit.xPais   := 'BRASIL';
  VpaDNFe.Emit.EnderEmit.fone := DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(varia.FoneFilial,'-'),')'),'('),'*'),'0');
  VpaDNFe.Emit.IE                := Deletachars(Deletachars(Deletachars(varia.IEFilial,'.'),'/'),'-');
  VpaDNFe.Emit.IM                := Varia.InscricaoMunicipal;
  VpaDNFe.Emit.CNAE              := VARIA.CodCNAE;

end;

{******************************************************************************}
procedure TRBFuncoesNFe.AtualizaStatus(VpaStatus: TStatusBar; VpaTexto: String);
begin
  VpaStatus.Panels[0].Text := VpaTexto;
  VpaStatus.Refresh;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDDestinatarioNfe(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente; VpaDNFe : TNFe);
begin
  VpaDNFe.Dest.CNPJCPF           := VpaDCliente.CGC_CPF;
  VpaDNFe.Dest.xNome             := VpaDCliente.NomCliente;
  VpaDNFe.Dest.EnderDest.xLgr    := VpaDCliente.DesEndereco;
  VpaDNFe.Dest.EnderDest.nro     := VpaDCliente.NumEndereco;
  VpaDNFe.Dest.EnderDest.xCpl    := VpaDCliente.DesComplementoEndereco;
  VpaDNFe.Dest.EnderDest.xBairro := VpaDCliente.DesBairro;
  if VpaDCliente.TipoPessoa = 'E' then
  begin
    VpaDNFe.Dest.EnderDest.cMun    := 9999999;
    VpaDNFe.Dest.EnderDest.xMun    := 'EXTERIOR';
    VpaDNFe.Dest.EnderDest.UF      := 'EX';
  end
  else
  begin
    VpaDNFe.Dest.EnderDest.cMun    := VpaDCliente.CodIBGECidade;
    VpaDNFe.Dest.EnderDest.xMun    := VpaDCliente.DesCidade;
    VpaDNFe.Dest.EnderDest.UF      := VpaDCliente.DesUF;
    VpaDNFe.Dest.EnderDest.CEP     := strToInt(DeletaChars(VpaDCliente.CepCliente,'-'));
  end;
  VpaDNFe.Dest.EnderDest.cPais   := VpaDCliente.CodPais;
  VpaDNFe.Dest.EnderDest.xPais   := FunClientes.RNomPais(VpaDCliente.CodPais);

  VpaDNFe.Dest.EnderDest.Fone    := DeletaCharE(DeletaChars(DeletaChars(DeletaChars(DeletaChars(VpaDCliente.DesFone1,'-'),')'),'('),'*'),'0');
  VpaDNFe.Dest.IE                := Deletachars(Deletachars(Deletachars(VpaDCliente.InscricaoEstadual,'.'),'/'),'-');;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDProdutoNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
var
  VpfDProduto : TRBDNotaFiscalProduto;
  VpfLaco : Integer;
begin
  for Vpflaco := 0 to VpaDNota.Produtos.Count - 1 do
  begin
    VpfDProduto :=  TRBDNotaFiscalProduto(VpaDNota.Produtos.Items[VpfLaco]);
    with VpaDNFe.Det.Add do
    begin
      if VpfDProduto.DesOrdemCompra <> '' then
        infAdProd     := 'OC= '+VpfDProduto.DesOrdemCompra;
      if VpfDProduto.DesRefCliente <> '' then
        infAdProd     :=  infAdProd +'  REFERENCIA CLIENTE='+VpfDProduto.DesRefCliente;
      with Prod do
      begin
        nItem    := VpfLaco+1;
        cProd    := VpfDProduto.CodProduto;
        xProd    := VpfDProduto.NomProduto;
        if VpfDProduto.DesCor <> '' then
          xProd := xProd +' - '+VpfDProduto.DesCor;
        if (config.numeroserieproduto) and (VpfDProduto.DesRefCliente <> '') then
          xProd := xProd +' - NS='+ VpfDProduto.DesRefCliente;

        NCM      := DeletaChars(DeletaChars(DeletaChars(VpfDProduto.CodClassificacaoFiscal,'.'),','),' ');
        CFOP     := VpaDNota.CodNatureza;
        uCom     := VpfDProduto.UM;
        qCom     := VpfDProduto.QtdProduto;
        vProd    := ArredondaDecimais(VpfDProduto.ValTotal,2);
        vUnCom   := VpfDProduto.ValUnitario;
        uTrib    := VpfDProduto.UM;
        qTrib    := VpfDProduto.QtdProduto;
        vUnTrib  := VpfDProduto.ValUnitario;
      end;
      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          case VpfDProduto.NumOrigemProduto of
            0 : orig        := oeNacional;
            1 : orig        := oeEstrangeiraImportacaoDireta;
            2 : orig        := oeEstrangeiraAdquiridaBrasil;
          end;
          ICMS.modBC  := dbiValorOperacao;
          ICMS.vBC    := ArredondaDecimais(VpfDProduto.ValTotal,2);
          ICMS.pICMS  := VpfDProduto.PerICMS;
          ICMS.vICMS  := ArredondaDecimais((VpfDProduto.ValTotal * VpfDProduto.PerICMS)/100,2);
        end;
        IPI.CST := ipi00;
        if VpfDProduto.PerIPI <> 0 then
        begin
          IPI.vBC := ArredondaDecimais(VpfDProduto.ValTotal,2);
          IPI.vIPI := VpfDProduto.ValIPI;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDServicosNfe(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
var
  VpfDServico : TRBDNotaFiscalServico;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDNota.Servicos.Count - 1 do
  begin
    VpfDServico := TRBDNotaFiscalServico(VpaDNota.Servicos.Items[VpfLaco]);
    with VpaDNFe.Det.Add do
    begin
      with Prod do
      begin
        nItem    := VpaDNota.Produtos.Count+ VpfLaco+1;
        cProd    := inttoStr(VpfDServico.CodServico);
        xProd    := VpfDServico.NomServico;
        if VpfDServico.DesAdicional <> '' then
          xProd := xProd +' - '+VpfDServico.DesAdicional;

        CFOP     := VpaDNota.CodNatureza;
        uCom     := 'SE';
        qCom     := VpfDServico.QtdServico;
        vProd    := VpfDServico.ValTotal;
        vUnCom   := VpfDServico.ValUnitario;
        uTrib    := 'SE';
        qTrib    := VpfDServico.QtdServico;
        vUnTrib  := VpfDServico.ValUnitario;
      end;
      with Imposto do
      begin
        with ICMS do
        begin
          ISSQN.vBC := VpfDServico.ValTotal;
          ISSQN.vAliq := VpfDServico.PerISSQN;
          ISSQN.vISSQN :=(VpfDServico.ValTotal*VpfDServico.PerISSQN)/100;
          ISSQN.cMunFG := Varia.CodIBGEMunicipio;
          ISSQN.cListServ := VpfDServico.CodFiscal;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDTotalNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
begin
  with VpaDNFe.Total.ICMSTot do
  begin
    vBC   := VpaDNota.ValBaseICMS;
    vICMS := VpaDNota.ValICMS;
    vProd := VpaDNota.ValTotalProdutos;//+ VpaDNota.ValTotalServicos;
    vFrete := VpaDNota.ValFrete;
    vSeg :=  VpaDNota.ValSeguro;
    vOutro := VpaDNota.ValOutrasDepesesas;
    if VpaDNota.ValDesconto < 0  then
      vOutro := vOutro + (VpaDNota.ValDesconto *-1)
    else
      if VpaDNota.ValDesconto > 0  then
        vDesc := VpaDNota.ValDesconto;
    if VpaDNota.PerDesconto < 0  then
      vOutro := vOutro + (((vProd * VpaDNota.PerDesconto)/100) *-1)
    else
      if VpaDNota.PerDesconto > 0  then
        vDesc := (vProd * VpaDNota.PerDesconto)/100;
    vIPI := VpaDNota.ValTotalIPI;
    vNF := VpaDNota.ValTotal;
  end;
  with VpaDNFe.Total.ISSQNtot do
  begin
    vServ := VpaDNota.ValTotalServicos;
    vBC := VpaDNota.ValTotalServicos;
    vISS := VpaDNota.ValIssqn;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDTransporteNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
var
  VpfDTransportadora : TRBDTransportadora;
begin
  if VpaDNota.CodTipoFrete = 1 then
    VpaDNFe.Transp.modFrete := mfContaEmitente
  else
    VpaDNFe.Transp.modFrete := mfContaDestinatario;

  if VpaDNota.CodTransportadora <> 0  then
  begin
    VpfDTransportadora := TRBDTransportadora.Create;
    FunNotaFiscal.CarDTransportadora(VpfDTransportadora,VpaDNota.CodTransportadora);

    with VpaDNFe.Transp.Transporta do
    begin
      CNPJCPF := VpfDTransportadora.CGC_CPF;
      xNome := VpfDTransportadora.Nome;
      IE := VpfDTransportadora.InscricaoEstadual;
      xEnder := VpfDTransportadora.Endereco+','+VpfDTransportadora.NroEndereco;
      xMun := VpfDTransportadora.Cidade;
      UF := VpfDTransportadora.UF;
    end;
    VpfDTransportadora.free;
    VpaDNFe.Transp.veicTransp.placa := DeletaChars(VpaDNota.DesPlacaVeiculo,' ');
    VpaDNFe.Transp.veicTransp.UF := VpaDNota.DesUFPlacaVeiculo;
    with VpaDNFe.Transp.Vol.Add do
    begin
      qVol := VpaDNota.QtdEmbalagem;
      esp :=  VpaDNota.DesEspecie;
      marca := VpaDNota.DesMarcaEmbalagem;
      nVol := VpaDNota.NumEmbalagem;
      pesoL := VpaDNota.PesLiquido;
      pesoB := VpaDNota.PesBruto;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarFaturas(VpaDNota: TRBDNotaFiscal; VpaDNFe: TNFe);
var
  VpfLaco : Integer;
  VpfDFatura : TRBDImpressaoFaturaNotaFiscal;
begin
//  VpaDNFe.Cobr.Fat.nFat := IntToStr(VpaDNota.NumNota);
//  VpaDNFe.Cobr.Fat.vOrig := VpaDNota.ValTotal;
//  VpaDNFe.Cobr.Fat.vLiq := VpaDNota.ValTotal;
  FunNotaFiscal.CarFaturasImpressaoNotaFiscal(VpaDNota,1);
  for VpfLaco := 0 to VpaDNota.Faturas.Count - 1 do
  begin
    VpfDFatura := TRBDImpressaoFaturaNotaFiscal(VpaDNota.Faturas.Items[Vpflaco]);
    with VpaDNFe.Cobr.Dup.Add do
    begin
      nDup := VpfDFatura.Numero1;
      dVenc := VpfDFatura.DatVencimento1;
      vDup := VpfDFatura.Valor1;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.CarDObservacoesNota(VpaDNota : TRBDNotaFiscal;VpaDNFe : TNFe);
begin
  with VpaDNFe.InfAdic do
  begin
    infCpl := VpaDNota.DesDadosAdicionaisImpressao.Text;
    if VpaDNota.DesObservacao.Count > 0 then
      infCpl := infCpl+#13+VpaDNota.DesObservacao.Text;
  end;
  VpaDNFe.compra.xPed := VpaDNota.DesOrdemCompra;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.MostraStatusOperacao(VpaObjeto : TObject);
begin
  if VprStatusBar <> nil then
  begin
    case NFe.Status of
      stIdle :
      begin
        VprStatusBar.Panels[0].Text := '';
      end;
      stNFeStatusServico :
      begin
        VprStatusBar.Panels[0].Text := 'Verificando Status do servico...';
      end;
{      stNFeRecepcao :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Enviando dados da NFe...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNfeRetRecepcao :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Recebendo dados da NFe...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNfeConsulta :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Consultando NFe...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNfeCancelamento :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Enviando cancelamento de NFe...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNfeInutilizacao :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNFeRecibo :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stNFeCadastro :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Consultando Cadastro...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
      stEmail :
      begin
        if ( frmStatus = nil ) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Enviando Email...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;}
    end;
    VprStatusBar.Refresh;
  end;
end;

{******************************************************************************}
function TRBFuncoesNFe.RUF(VpaCodFiscalMunicipio: String): String;
var
  VpfCodigoEstado : String;
begin
  result := '';
  VpfCodigoEstado := copy(VpaCodFiscalMunicipio,1,2);
  if VpfCodigoEstado = '11' then
    result := 'RO'
  else
    if VpfCodigoEstado = '12' then
      result := 'AC'
    else
    if VpfCodigoEstado = '13' then
      result := 'AM'
    else
    if VpfCodigoEstado = '14' then
      result := 'RR'
    else
    if VpfCodigoEstado = '15' then
      result := 'PA'
    else
    if VpfCodigoEstado = '16' then
      result := 'AP'
    else
    if VpfCodigoEstado = '17' then
      result := 'TO'
    else
    if VpfCodigoEstado = '21' then
      result := 'MA'
    else
    if VpfCodigoEstado = '22' then
      result := 'PI'
    else
    if VpfCodigoEstado = '23' then
      result := 'CE'
    else
    if VpfCodigoEstado = '24' then
      result := 'RN'
    else
    if VpfCodigoEstado = '25' then
      result := 'PB'
    else
    if VpfCodigoEstado = '26' then
      result := 'PE'
    else
    if VpfCodigoEstado = '27' then
      result := 'AL'
    else
    if VpfCodigoEstado = '28' then
      result := 'SE'
    else
    if VpfCodigoEstado = '29' then
      result := 'BA'
    else
    if VpfCodigoEstado = '31' then
      result := 'MG'
    else
    if VpfCodigoEstado = '32' then
      result := 'ES'
    else
    if VpfCodigoEstado = '33' then
      result := 'RJ'
    else
    if VpfCodigoEstado = '35' then
      result := 'SP'
    else
    if VpfCodigoEstado = '41' then
      result := 'PR'
    else
    if VpfCodigoEstado = '42' then
      result := 'SC'
    else
    if VpfCodigoEstado = '43' then
      result := 'RS'
    else
    if VpfCodigoEstado = '50' then
      result := 'MS'
    else
    if VpfCodigoEstado = '51' then
      result := 'MT'
    else
    if VpfCodigoEstado = '52' then
      result := 'GO'
    else
    if VpfCodigoEstado = '53' then
      result := 'DF';
end;

{******************************************************************************}
function TRBFuncoesNFe.VerificaStatusServico(VpaBarraStatus : TStatusBar): String;
var
  VpfVisualizar : Boolean;
begin
  VprStatusBar := VpaBarraStatus;
  VpfVisualizar := NFe.Configuracoes.WebServices.Visualizar;
  NFe.Configuracoes.WebServices.Visualizar := true;
  NFe.WebServices.StatusServico.Executar;
  result := UTF8Encode(NFe.WebServices.StatusServico.RetWS);
  NFe.Configuracoes.WebServices.Visualizar := VpfVisualizar;
end;

{******************************************************************************}
function TRBFuncoesNFe.EmiteNota(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente;VpaBarraStatus : TStatusBar):string;
var
  VpfDNFe : TNFe;
  VpfVisualizar : Boolean;
begin
  VpfVisualizar := NFe.Configuracoes.WebServices.Visualizar;
  NFe.Configuracoes.WebServices.Visualizar := false;
  VprStatusBar := VpaBarraStatus;
  result := VerificacoesEmitente;
  if result = '' then
    result :=  VerificacoesDestinatario(VpaDCliente);
  if result = '' then
  begin
    NFe.NotasFiscais.Clear;
    VpfDNFe := NFe.NotasFiscais.Add.NFe;

    CarDNotaNfe(VpaDNota,VpfDNFe);
    CarDEmitenteNfe(VpaDNota,VpfDNFe);
    CarDDestinatarioNfe(VpaDNota,VpaDCliente,VpfDNFe);
    CarDProdutoNfe(VpaDNota,VpfDNFe);
    CarDServicosNfe(VpaDNota,VpfDNFe);
    CarDTotalNota(VpaDNota,VpfDNFe);
    CarDTransporteNota(VpaDNota,VpfDNFe);
    FunNotaFiscal.CarObservacaoNotaFiscal(VpaDNota,VpaDCliente);
    CarFaturas(VpaDNota,VpfDNFe);
    CarDObservacoesNota(VpaDNota,VpfDNFe);

    nfe.DANFE := nil;
    NFe.Enviar(0);
    VpaDNota.NumReciboNFE := nfe.WebServices.Retorno.Recibo;
    VpaDNota.NumProtocoloNFE := nfe.WebServices.Retorno.Protocolo;
    VpaDNota.CodMotivoNFE := IntTostr(nfe.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].cStat);
    VpaDNota.DesMotivoNFE := nfe.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].xMotivo;
    VpaDNota.DesChaveNFE := nfe.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].chNFe;

    NFe.DANFE := Danfe;

    Aviso('Protocolo da nfe : '+nfe.WebServices.Retorno.Protocolo);
    aviso('Recibo da nfe : '+ nfe.WebServices.Retorno.Recibo);
  end;
  NFe.Configuracoes.WebServices.Visualizar := VpfVisualizar
end;

{******************************************************************************}
function TRBFuncoesNFe.ImprimeDanfe(VpaDNota: TRBDNotaFiscal): String;
begin
  result := '';
  Danfe := TACBrNFeDANFERave.Create(Application);
  Danfe.RavFile :=Varia.PathRelatorios+'\NotaFiscalEletronica.rav';
  NFe.DANFE := Danfe;
  if config.NFEDanfeRetrato then
    NFE.DANFE.TipoDANFE := tiRetrato
  else
    NFE.DANFE.TipoDANFE := tiPaisagem;
//  NFe.DANFE.Logo := varia.PathVersoes+'\'+inttoStr(varia.CodigoEmpFil)+'.bmp';

  NFe.NotasFiscais.Clear;
  NFe.NotasFiscais.LoadFromFile(Varia.PathVersoes+'\nfe\'+VpaDNota.DesChaveNFE+'-nfe.xml');
  NFe.DANFE.ProtocoloNFe := VpaDNota.NumProtocoloNFE;
  NFe.DANFE.Sistema := ' Eficácia Sistemas e Consultoria - www.eficaciaconsultoria.com.br';
  NFe.DANFE.Site := lowerCAse(varia.SiteFilial);
  NFe.DANFE.Usuario := varia.NomeUsuario;
  NFe.DANFE.Email := lowerCAse(varia.EMailFilial);
  NFe.NotasFiscais.Imprimir;
  NFe.DANFE := nil;
  Danfe.FREE;
end;

{******************************************************************************}
function TRBFuncoesNFe.EnviaEmailDanfe(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente):String;
var
  VpfTextoEmail : TStringList;
begin
  Result := '';
  if VpaDCliente.DesEmail = '' then
    result := 'E-MAIL DO CLIENTE NÃO PREENCHIDO!!!!'#13'É necessário preencher o e-mail do cliente.';
  if result = '' then
  begin
    Danfe := TACBrNFeDANFERave.Create(Application);
    Danfe.RavFile :=Varia.PathRelatorios+'\NotaFiscalEletronica.rav';
    NFe.DANFE := Danfe;
    if config.NFEDanfeRetrato then
      NFE.DANFE.TipoDANFE := tiRetrato
    else
      NFE.DANFE.TipoDANFE := tiPaisagem;
    NFe.DANFE.Logo := varia.PathVersoes+'\'+inttoStr(varia.CodigoEmpFil)+'.bmp';

    VpfTextoEmail :=  TStringList.create;
    NFe.NotasFiscais.LoadFromFile(Varia.PathVersoes+'\nfe\'+VpaDNota.DesChaveNFE+'-nfe.xml');
    NFe.DANFE.PathPDF := Varia.PathVersoes+'\nfe\';
    Nfe.NotasFiscais.Items[0].EnviarEmail(Varia.ServidorSMTP, '25',varia.UsuarioSMTP, Varia.SenhaEmail, varia.EmailComercial, VpaDCliente.DesEmail, 'Segue anexo NF-e '+IntToStr(VpaDNota.NumNota)+ ' - '+varia.NomeFilial,
                                         VpfTextoEmail,false);
    VpfTextoEmail.free;
    NFe.DANFE := nil;
    Danfe.FREE;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.HigienizaPais(VpaErros: TStrings;VpaStatus: TStatusBar);
begin
  AtualizaStatus(VpaStatus,'Verificando codigos dos paises');
  AdicionaSQLAbreTabela(Aux,'Select * from CAD_PAISES');
  while not aux.eof do
  begin
    AtualizaStatus(VpaStatus,'Verificando o país "'+Aux.FieldByName('DES_PAIS').AsString+'"');
    if Aux.FieldByName('COD_IBGE').AsInteger = 0 then
      VpaErros.Insert(0,'Cadastro do país "'+Aux.FieldByName('DES_PAIS').AsString+'" inválido, falto o codigo do IBGE' );
    Aux.next;
  end;
  aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.HigienizarCidades(VpaErros : TStrings;VpaStatus : TStatusBar);
begin
  AtualizaStatus(VpaStatus,'Verificando cidades');
  AdicionaSQLAbreTabela(Aux,'Select * from CAD_CIDADES');
  while not aux.eof do
  begin
    AtualizaStatus(VpaStatus,'Verificando a cidade "'+Aux.FieldByName('DES_CIDADE').AsString+'"');
    if Aux.FieldByName('COD_FISCAL').AsInteger = 0 then
      VpaErros.Insert(0,'Cadastro da cidade "'+Aux.FieldByName('DES_CIDADE').AsString+'" inválido, falto o codigo do IBGE' );
    Aux.next;
  end;
  aux.close;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.HigienizarClientes(VpaErros, VpaCorrigidos: TStrings; VpaStatus: TStatusBar);
Var
  VpfCodCidade, VpfCodPais : Integer;
begin
  AtualizaStatus(VpaStatus,'Verificando clientes');
  AdicionaSQLAbreTabela(Aux,'Select * from CADCLIENTES '+
                            ' Where C_IND_CLI = ''S''');
  while not aux.eof do
  begin
    AtualizaStatus(VpaStatus,'Verificando o cliente "'+Aux.FieldByName('C_NOM_CLI').AsString+'"');
    if Aux.FieldByName('I_COD_IBG').AsInteger = 0 then
    begin
      VpfCodCidade := FunClientes.RCodCidade(Aux.FieldByName('C_CID_CLI').AsString,Aux.FieldByName('C_EST_CLI').AsString);
      if VpfCodCidade <> 0 then
      begin
        FunClientes.AtualizaCodCidadeCliente(Aux.FieldByName('I_COD_CLI').AsInteger,VpfCodCidade);
        VpaCorrigidos.Insert(0,'Atualizado o cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'", codigo IBGE do município' );
      end
      else
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o codigo IBGE do município' );
    end;
    if Aux.FieldByName('I_COD_PAI').AsInteger = 0 then
    begin
      VpfCodPais := FunClientes.RCodPais(Aux.FieldByName('C_EST_CLI').AsString);
      if VpfCodPais <> 0 then
      begin
        FunClientes.AtualizaCodPaisCliente(Aux.FieldByName('I_COD_CLI').AsInteger,VpfCodPais);
        VpaCorrigidos.Insert(0,'Atualizado o cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'", codigo IBGE do pais' );
      end
      else
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o codigo IBGE do pais' );
    end;
    if Aux.FieldByName('C_END_CLI').AsString = '' then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o endereço' );
    if Aux.FieldByName('I_NUM_END').AsInteger = 0 then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o número do endereço' );
    if Aux.FieldByName('C_BAI_CLI').AsString = '' then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, falta o bairro ' );
    if Aux.FieldByName('C_TIP_PES').AsString = 'F' then
    begin
      if not VerificaCPF(Aux.FieldByName('C_CPF_CLI').AsString) then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, CPF Inválido ou não preenchido' );
    end;
    if Aux.FieldByName('C_TIP_PES').AsString = 'J' then
    begin
      if not VerificaCGC(Aux.FieldByName('C_CGC_CLI').AsString) then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, CNPJ Inválido ou não preenchido' );
      if not VerificarIncricaoEstadual(Aux.FieldByName('C_INS_CLI').AsString,Aux.FieldByName('C_EST_CLI').AsString,false,true) then
        VpaErros.Insert(0,'Cadastro do cliente "'+Aux.FieldByName('I_COD_CLI').AsString+'-'+COPY(Aux.FieldByName('C_NOM_CLI').AsString,1,30)+'" inválido, I.E. Inválido ou não preenchido' );
    end;

    Aux.next;
  end;
  aux.close;
end;

{******************************************************************************}
function TRBFuncoesNFe.CancelaNFE(VpaDNota: TRBDNotaFiscal;VpaMotivo : String):string;
begin
  result := '';
  NFe.NotasFiscais.Clear;
  NFe.NotasFiscais.LoadFromFile(Varia.PathVersoes+'\nfe\'+VpaDNota.DesChaveNFE+'-nfe.xml');
  NFe.Configuracoes.Certificados.NumeroSerie := varia.CertificadoNFE;
  NFe.Configuracoes.Geral.Salvar := false;
//    NFe.Configuracoes.Geral.FormaEmissao
  NFe.Configuracoes.WebServices.UF := Varia.UFSefazNFE;
  if config.NFEHomologacao then
    Nfe.Configuracoes.WebServices.Ambiente := taHomologacao
  else
    Nfe.Configuracoes.WebServices.Ambiente := taProducao;

  NFe.Cancelamento(VpaMotivo);
  if NFe.WebServices.Cancelamento.cStat = 101 then
    VpaDNota.NumProtocoloCancelamentoNFE := NFe.WebServices.Cancelamento.Protocolo
  else
    result := NFe.WebServices.Cancelamento.xMotivo;
end;

{******************************************************************************}
procedure TRBFuncoesNFe.HigienizarCadastros(VpaErros, VpaCorrigidos: TStrings;VpaStatus: TStatusBar);
begin
  VpaErros.clear;
  VpaCorrigidos.clear;
  HigienizaPais(VpaErros,VpaStatus);
  HigienizarCidades(VpaErros,VpaStatus);
  HigienizarClientes(VpaErros,VpaCorrigidos,VpaStatus);
end;

end.
