program AgendaSisCorp;

uses
  Forms,
  SysUtils,
  Dialogs,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  Abertura in '..\MaGerais\Abertura.pas' {FAbertura},
  Constantes in '..\MConfiguracoesSistema\Constantes.pas',
  UnAtualizacao in '..\MaGerais\UnAtualizacao.pas',
  AMenssagemAtualizando in 'AMenssagemAtualizando.pas' {FMensagemAtualizando},
  UnSistema in '..\magerais\UnSistema.pas',
  AAgendamentos in '..\mpontaloja\AAgendamentos.pas' {FAgendamentos},
  UnClientes in '..\magerais\UnClientes.pas',
  UnDados in '..\magerais\UnDados.pas',
  UnProdutos in '..\mestoque\UnProdutos.pas',
  UnMoedas in '..\mconfiguracoessistema\unmoedas.pas',
  UnCodigoBarra in '..\mconfiguracoessistema\uncodigobarra.pas',
  UnClassificacao in '..\mestoque\unclassificacao.pas',
  UnSumarizaEstoque in '..\mestoque\UnSumarizaEstoque.pas',
  UnDadosProduto in '..\mestoque\UnDadosProduto.pas',
  ANovoAgendamento in '..\mpontaloja\ANovoAgendamento.pas' {FNovoAgedamento},
  ATipoAgendamento in '..\mpontaloja\ATipoAgendamento.pas' {FTipoAgendamento},
  ANovoTeleMarketing in '..\mpontaloja\ANovoTeleMarketing.pas' {FNovoTeleMarketing},
  UnTeleMarketing in '..\mpontaloja\UnTeleMarketing.pas',
  UnContrato in '..\mpontaloja\UnContrato.pas',
  UnCotacao in '..\mpontaloja\UnCotacao.pas',
  UnContasAReceber in '..\mfinanceiro\UnContasAReceber.pas',
  UnComissoes in '..\mfinanceiro\UnComissoes.pas',
  UnDadosCR in '..\mfinanceiro\UnDadosCR.pas',
  UnClassesImprimir in '..\magerais\UnClassesImprimir.pas',
  AMostraParReceberOO in '..\mfinanceiro\AMostraParReceberOO.pas' {FMostraParReceberOO},
  AContas in '..\mfinanceiro\AContas.pas' {FContas},
  ABancos in '..\mfinanceiro\abancos.pas' {FBancos},
  ANovaConta in '..\mfinanceiro\ANovaConta.pas' {FNovaConta},
  ANovoCliente in '..\magerais\ANovoCliente.pas' {FNovoCliente},
  AClientes in '..\magerais\AClientes.pas' {FClientes},
  ACotacao in '..\mpontaloja\ACotacao.pas' {FCotacao},
  UnImpressao in '..\magerais\UnImpressao.pas',
  UnNotaFiscal in '..\mfaturamento\UnNotaFiscal.pas',
  UnContasAPagar in '..\mfinanceiro\UnContasAPagar.pas',
  AMostraCheque in '..\magerais\amostracheque.pas' {FMostraCheque},
  UnImpressaoBoleto in '..\magerais\UnImpressaoBoleto.pas',
  UnOrdemProducao in '..\mestoque\UnOrdemProducao.pas',
  UnComandosImpCheque in '..\magerais\UnComandosImpCheque.pas',
  ALocalizaProdutos in '..\mfaturamento\ALocalizaProdutos.pas' {FlocalizaProduto},
  AProdutosKit in '..\mestoque\AProdutosKit.pas' {FProdutosKit},
  AProdutos in '..\mestoque\AProdutos.pas' {Fprodutos},
  ANovaClassificacao in '..\mestoque\ANovaClassificacao.pas' {FNovaClassificacao},
  AImpProduto in '..\mestoque\AImpProduto.pas' {FImpProduto},
  AMontaKit in '..\mestoque\AMontaKit.pas' {FMontaKit},
  ALocalizaClassificacao in '..\mestoque\alocalizaclassificacao.pas' {FLocalizaClassificacao},
  ACores in '..\mestoque\ACores.pas' {FCores},
  ATipoFundo in '..\mestoque\ATipoFundo.pas' {FTipoFundo},
  ATipoEmenda in '..\mestoque\ATipoEmenda.pas' {FTipoEmenda},
  AMaquinas in '..\mestoque\AMaquinas.pas' {FMaquinas},
  AEstagioProducao in '..\mestoque\AEstagioProducao.pas' {FEstagioProducao},
  ATipoEstagioProducao in '..\mestoque\ATipoEstagioProducao.pas' {FTipoEstagioProducao},
  ATipoCorte in '..\mestoque\ATipoCorte.pas' {FTipoCorte},
  UnCrystal in '..\magerais\UnCrystal.pas',
  ANovaCotacao in '..\mpontaloja\ANovaCotacao.pas' {FNovaCotacao},
  ANovoVendedor in '..\magerais\ANovoVendedor.pas' {FNovoVendedor},
  AVendedores in '..\magerais\AVendedores.pas' {FVendedores},
  AConsultaRuas in '..\magerais\AConsultaRuas.pas' {FConsultaRuas},
  ACadCidades in '..\magerais\ACadCidades.pas' {FCidades},
  ACadEstados in '..\magerais\ACadEstados.pas' {FCadEstados},
  ACadPaises in '..\magerais\ACadPaises.pas' {FCadPaises},
  ACondicoesPgtos in '..\mfinanceiro\ACondicoesPgtos.pas' {FCondicoesPagamentos},
  AConsultaCondicaoPgto in '..\magerais\AConsultaCondicaoPgto.pas' {FConsultaCondicaoPgto},
  AFormasPagamento in '..\mfinanceiro\AFormasPagamento.pas' {FFormasPagamento},
  ANovoServico in '..\mestoque\ANovoServico.pas' {FNovoServico},
  UnServicos in '..\mestoque\unservicos.pas',
  ALocalizaServico in '..\mfaturamento\ALocalizaServico.pas' {FlocalizaServico},
  AImpCotacao in '..\mpontaloja\AImpCotacao.pas' {FImpOrcamento},
  UnVendedor in '..\magerais\UnVendedor.pas',
  ANovaTransportadora in '..\magerais\ANovaTransportadora.pas' {FNovaTransportadora},
  ATransportadoras in '..\magerais\atransportadoras.pas' {FTransportadoras},
  ATipoCotacao in '..\mpontaloja\ATipoCotacao.pas' {FTipoCotacao},
  AOperacoesEstoques in '..\mestoque\aoperacoesestoques.pas' {FOperacoesEstoques},
  APlanoConta in '..\mfinanceiro\APlanoConta.pas' {FPlanoConta},
  ANovoPlanoConta in '..\mfinanceiro\ANovoPlanoConta.pas' {FNovoPlanoConta},
  AEmbalagem in '..\mpontaloja\AEmbalagem.pas' {FEmbalagem},
  AProdutoReferencia in '..\mpontaloja\AProdutoReferencia.pas' {FReferenciaProduto},
  AProdutosDevolvidos in '..\mpontaloja\AProdutosDevolvidos.pas' {FProdutosDevolvidos},
  AMostraObservacaoCliente in '..\mpontaloja\AMostraObservacaoCliente.pas' {FMostraObservacaoCliente},
  ANovaNotaFiscaisFor in '..\mestoque\ANovaNotaFiscaisFor.pas' {FNovaNotaFiscaisFor},
  UnNotasFiscaisFor in '..\mestoque\UnNotasFiscaisFor.pas',
  AItensNatureza in '..\mfaturamento\AItensNatureza.pas' {FItensNatureza},
  ANovaNatureza in '..\mfaturamento\ANovaNatureza.pas' {FNovaNatureza},
  ANaturezas in '..\mfaturamento\ANaturezas.pas' {FNaturezas},
  AMovNatureza in '..\mfaturamento\amovnatureza.pas' {FMovNatureza},
  ANovoTecnico in '..\mpontaloja\ANovoTecnico.pas' {FNovoTecnico},
  ATecnicos in '..\mpontaloja\ATecnicos.pas' {FTecnicos},
  ANovoECF in '..\mpontaloja\ANovoECF.pas' {FNovoECF},
  UnECF in '..\mpontaloja\UnECF.pas',
  UnBematech in '..\mpontaloja\UnBematech.pas',
  UnDaruma in '..\mpontaloja\UnDaruma.pas',
  AFormaPagamentoECF in '..\mpontaloja\AFormaPagamentoECF.pas' {FFormaPagamentoECF},
  ABrindesCliente in '..\mpontaloja\ABrindesCliente.pas' {FBrindesCliente},
  ANovaNotaFiscalNota in '..\mfaturamento\ANovaNotaFiscalNota.pas' {FNovaNotaFiscalNota},
  AObservacoesNota in '..\mfaturamento\aobservacoesnota.pas' {FObservacoesNota},
  AImprimeEtiqueta in '..\mpontaloja\AImprimeEtiqueta.pas' {FImprimiEtiqueta},
  UnImpressaoEtiquetaCotacao in '..\mpontaloja\UnImpressaoEtiquetaCotacao.pas',
  AGeraOP in '..\mpontaloja\AGeraOP.pas' {FGerarOP},
  ANovaOrdemProducaoCadarco in '..\mestoque\ANovaOrdemProducaoCadarco.pas' {FNovaOrdemProducaoCadarco},
  AImpOrdemProducao in '..\mestoque\AImpOrdemProducao.pas' {FImpOrdemProducao},
  AGeraEstagiosOP in '..\mpontaloja\AGeraEstagiosOP.pas' {FGeraEstagiosOP},
  ABaixaParcialCotacao in '..\mpontaloja\ABaixaParcialCotacao.pas' {FBaixaParcialCotacao},
  AConsultaBaixaParcial in '..\mpontaloja\AConsultaBaixaParcial.pas' {FConsultaBaixaParcial},
  AOrdensProducaoCadarco in '..\mestoque\AOrdensProducaoCadarco.pas' {FOrdensProducaoCadarco},
  AAlteraVendedorCotacao in '..\mpontaloja\AAlteraVendedorCotacao.pas' {FAlteraVendedorCotacao},
  ANovaCobranca in '..\mfinanceiro\ANovaCobranca.pas' {FNovaCobranca},
  AHistoricoLigacao in '..\mfinanceiro\AHistoricoLigacao.pas' {FHistoricoLigacao},
  ACobrancas in '..\mfinanceiro\ACobrancas.pas' {FCobrancas},
  AMotivoInadimplencia in '..\mfinanceiro\AMotivoInadimplencia.pas' {FMotivoInadimplencia},
  AContratosCliente in '..\mpontaloja\AContratosCliente.pas' {FContratosCliente},
  ANovoContratoCliente in '..\mpontaloja\ANovoContratoCliente.pas' {FNovoContratoCliente},
  ATipoContrato in '..\mpontaloja\ATipoContrato.pas' {FTipoContrato},
  ATeleMarketings in '..\mpontaloja\ATeleMarketings.pas' {FTeleMarketings},
  AProdutosCliente in '..\mpontaloja\AProdutosCliente.pas' {FProdutosCliente},
  ADonoProduto in '..\mpontaloja\ADonoProduto.pas' {FDonoProduto},
  AProfissoes in '..\magerais\aprofissoes.pas' {FProfissoes},
  ASituacoesClientes in '..\magerais\asituacoesclientes.pas' {FSituacoesClientes},
  ARegiaoVenda in '..\magerais\ARegiaoVenda.pas' {FRegiaoVenda},
  ARamoAtividade in '..\mpontaloja\ARamoAtividade.pas' {FRamoAtividade},
  AAcondicionamento in '..\mpontaloja\AAcondicionamento.pas' {FAcondicionamento},
  AGeraFracaoOP in '..\mpontaloja\AGeraFracaoOP.pas' {FGeraFracaoOP},
  ANovaOrdemProducaoGenerica in '..\mestoque\ANovaOrdemProducaoGenerica.pas' {FNovaOrdemProducaoGenerica},
  AOrdemProducaoGenerica in '..\mestoque\AOrdemProducaoGenerica.pas' {FOrdemProducaoGenerica},
  AParentesCliente in '..\mpontaloja\AParentesCliente.pas' {FParentesClientes},
  ANovoChamadoTecnico in '..\MChamado\ANovoChamadoTecnico.pas' {FNovoChamado},
  UnChamado in '..\MChamado\UnChamado.pas',
  AAlteraEstagioAgendamento in '..\mpontaloja\AAlteraEstagioAgendamento.pas' {FAlteraEstagioAgendamento},
  AAlteraEstagioCotacao in '..\mpontaloja\AAlteraEstagioCotacao.pas' {FAlteraEstagioCotacao},
  AAlteraEstagioChamado in '..\mpontaloja\AAlteraEstagioChamado.pas' {FAlteraEstagioChamado},
  AHistoricoECobranca in '..\mfinanceiro\AHistoricoECobranca.pas' {FHistoricoECobranca},
  ALocalizaProdutoContrato in '..\MChamado\ALocalizaProdutoContrato.pas' {FLocalizaProdutoContrato},
  AAgendaChamados in '..\MChamado\AAgendaChamados.pas' {FAgendaChamados},
  AHoraAgendaChamado in '..\MChamado\AHoraAgendaChamado.pas' {FHoraAgendaChamado},
  AChamadosTecnicos in '..\MChamado\AChamadosTecnicos.pas' {FChamadoTecnico},
  AEfetuarPesquisaSatisfacao in '..\MChamado\AEfetuarPesquisaSatisfacao.pas' {FEfetuarPesquisaSatisfacao},
  UnPesquisaSatisfacao in '..\MChamado\UnPesquisaSatisfacao.pas',
  AMedico in '..\mpontaloja\AMedico.pas' {FMedico},
  AContatosCliente in '..\mpontaloja\AContatosCliente.pas' {FContatosCliente},
  AProdutosReserva in '..\mpontaloja\AProdutosReserva.pas' {FProdutosReserva},
  UnVersoes in '..\magerais\UnVersoes.pas',
  UnProspect in '..\mcrm\UnProspect.pas',
  UnAmostra in '..\mcrm\UnAmostra.pas',
  UnCaixa in '..\mcaixa\UnCaixa.pas',
  AMostraParPagarOO in '..\mfinanceiro\AMostraParPagarOO.pas' {FMostraParPagarOO},
  AChequesCP in '..\mfinanceiro\AChequesCP.pas' {FChequesCP},
  AConsultacheques in '..\mfinanceiro\AConsultacheques.pas' {FConsultaCheques},
  AContasAPagar in '..\mfinanceiro\AContasAPagar.pas' {FContasaPagar},
  UnDespesas in '..\mfinanceiro\undespesas.pas',
  ANovoContasaPagar in '..\mfinanceiro\ANovoContasaPagar.pas' {FNovoContasAPagar},
  ADespesas in '..\mfinanceiro\adespesas.pas' {FDespesas},
  ACentroCusto in '..\mfinanceiro\ACentroCusto.pas' {FCentroCusto},
  AGeraDespesasFixas in '..\mfinanceiro\ageradespesasfixas.pas' {FGeraDespesasFixas},
  AImprimeCP in '..\mfinanceiro\AImprimeCP.pas' {FImprimeCP},
  AGraficosContasaPagar in '..\mfinanceiro\AGraficosContasaPagar.pas' {FGraficosCP},
  AMovComissoes in '..\mfinanceiro\AMovComissoes.pas' {FMovComissoes},
  ANovaComissao in '..\mfinanceiro\anovacomissao.pas' {FNovaComissao},
  AManutencaoCP in '..\mfinanceiro\AManutencaoCP.pas' {FManutencaoCP},
  ABaixaContasaPagarOO in '..\mfinanceiro\ABaixaContasaPagarOO.pas' {FBaixaContasaPagarOO},
  UnArgox in '..\magerais\UnArgox.pas',
  ANovoProdutoPro in '..\mestoque\ANovoProdutoPro.pas' {FNovoProdutoPro},
  ANovaMaquina in '..\mestoque\ANovaMaquina.pas' {FNovaMaquina},
  ABaixaContasAReceberOO in '..\mfinanceiro\ABaixaContasAReceberOO.pas' {FBaixaContasaReceberOO},
  AChequesOO in '..\mfinanceiro\AChequesOO.pas' {FChequesOO},
  AContasAReceber in '..\mfinanceiro\AContasAReceber.pas' {FContasaReceber},
  ANovoContasaReceber in '..\mfinanceiro\ANovoContasaReceber.pas' {FNovoContasAReceber},
  AGraficosContasaReceber in '..\mfinanceiro\agraficoscontasareceber.pas' {FGraficosCR},
  AImprimeCR in '..\mfinanceiro\AImprimeCR.pas' {FImprimeCR},
  AManutencaoCR in '..\mfinanceiro\AManutencaoCR.pas' {FManutencaoCR},
  AConsolidarCR in '..\mfinanceiro\AConsolidarCR.pas' {FConsolidarCR},
  AContasAConsolidarCR in '..\mfinanceiro\AContasAConsolidarCR.pas' {FContasAConsolidarCR},
  ATamanhos in '..\mpontaloja\ATamanhos.pas' {FTamanhos},
  AVisualizaLogReceber in '..\mfinanceiro\AVisualizaLogReceber.pas' {FVisualizaLogReceber},
  AGerarFracaoOPMaquinasCorte in '..\mpontaloja\AGerarFracaoOPMaquinasCorte.pas' {FGerarFracaoOPMaquinasCorte},
  ABaixaConsumoProduto in '..\mestoque\ABaixaConsumoProduto.pas' {FBaixaConsumoProduto},
  UnSolicitacaoCompra in '..\mestoque\UnSolicitacaoCompra.pas',
  APedidosCompraAberto in '..\mestoque\APedidosCompraAberto.pas' {FPedidosCompraAberto},
  UnPedidoCompra in '..\mestoque\UnPedidoCompra.pas',
  ANovoPedidoCompra in '..\mestoque\ANovoPedidoCompra.pas' {FNovoPedidoCompra},
  ACompradores in '..\mestoque\ACompradores.pas' {FCompradores},
  ASolicitacaoCompras in '..\mestoque\ASolicitacaoCompras.pas' {FSolicitacaoCompra},
  APedidosPendentesFaturar in '..\mpontaloja\APedidosPendentesFaturar.pas' {FPedidosPendentesFaturar},
  AAlteraEstagioOrcamento in '..\mestoque\AAlteraEstagioOrcamento.pas' {FAlteraEstagioOrcamentoCompra},
  APedidoCompra in '..\mestoque\APedidoCompra.pas' {FPedidoCompra},
  AAlteraEstagioPedidoCompra in '..\mestoque\AAlteraEstagioPedidoCompra.pas' {FAlteraEstagioPedidoCompra},
  ANovoLembrete in '..\mpontaloja\ANovoLembrete.pas' {FNovoLembrete},
  UnLembrete in '..\mpontaloja\UnLembrete.pas',
  ASelecionarUsuarios in '..\mpontaloja\ASelecionarUsuarios.pas' {FSelecionarUsuarios},
  AVerificaLeituraLembrete in '..\MChamado\AVerificaLeituraLembrete.pas' {FVerificaLeituraLembrete},
  AProdutosOrcados in '..\MChamado\AProdutosOrcados.pas' {FProdutosOrcados},
  ATipoChamado in '..\MChamado\ATipoChamado.pas' {FTipoChamado},
  ANovoEmailContasAReceber in '..\mfinanceiro\ANovoEmailContasAReceber.pas' {FNovoEmailContasAReceber},
  ANovaProposta in '..\mcrm\ANovaProposta.pas' {FNovaProposta},
  UnProposta in '..\mcrm\UnProposta.pas',
  ANovoProspect in '..\mcrm\ANovoProspect.pas' {FNovoProspect},
  AProspects in '..\mcrm\AProspects.pas' {FProspects},
  ANovaAgendaProspect in '..\mcrm\ANovaAgendaProspect.pas' {FNovaAgendaProspect},
  APropostas in '..\mcrm\APropostas.pas' {FPropostas},
  ANovoTelemarketingProspect in '..\mcrm\ANovoTelemarketingProspect.pas' {FNovoTelemarketingProspect},
  AProdutosProspect in '..\mcrm\AProdutosProspect.pas' {FProdutosProspect},
  AContatosProspect in '..\mcrm\AContatosProspect.pas' {FContatosProspect},
  AAlteraEstagioProposta in '..\mcrm\AAlteraEstagioProposta.pas' {FAlteraEstagioProposta},
  AMeioDivulgacao in '..\mcrm\AMeioDivulgacao.pas' {FMeioDivulgacao},
  AConcorrentes in '..\mcrm\AConcorrentes.pas' {FConcorrentes},
  ANovoConcorrente in '..\mcrm\ANovoConcorrente.pas' {FNovoConcorrente},
  AMotivoVenda in '..\mcrm\AMotivoVenda.pas' {FMotivoVenda},
  ASetores in '..\mcrm\ASetores.pas' {FSetores},
  ANovoSetor in '..\mcrm\ANovoSetor.pas' {FNovoSetor},
  AComissaoClassificacaoVendedor in '..\mestoque\AComissaoClassificacaoVendedor.pas' {FComissaoClassificacaoVendedor},
  UnZebra in '..\magerais\UnZebra.pas',
  AMontaKitBastidor in '..\mestoque\AMontaKitBastidor.pas' {FMontaKitBastidor},
  ACompensaCheque in '..\mfinanceiro\ACompensaCheque.pas' {FCompensaCheque},
  ANovaSolicitacaoCompra in '..\mestoque\ANovaSolicitacaoCompra.pas' {FNovaSolicitacaoCompras},
  APropostasCliente in '..\mcrm\APropostasCliente.pas' {FPropostasCliente},
  ATipoProposta in '..\mcrm\ATipoProposta.pas' {FTipoProposta},
  ABaixaProdutosChamado in '..\MChamado\ABaixaProdutosChamado.pas' {FBaixaProdutosChamado},
  AConsultaChamadoParcial in '..\MChamado\AConsultaChamadoParcial.pas' {FConsultaChamadoParcial},
  ARelOrdemSerra in '..\mestoque\ARelOrdemSerra.pas' {FRelOrdemSerra},
  AAlteraEstagioFracaoOP in '..\mestoque\AAlteraEstagioFracaoOP.pas' {FAlteraEstagioFracaoOP},
  ACreditoCliente in '..\mfinanceiro\ACreditoCliente.pas' {FCreditoCliente},
  unEMarketing in '..\mpontaloja\unEMarketing.pas',
  ASolicitacaoCompraProdutosPendentes in '..\mestoque\ASolicitacaoCompraProdutosPendentes.pas' {FSolicitacaoCompraProdutosPendentes},
  ANovoOrcamentoCompra in '..\mestoque\ANovoOrcamentoCompra.pas' {FNovoOrcamentoCompra},
  UnOrcamentoCompra in '..\mestoque\UnOrcamentoCompra.pas',
  AHorarioTrabalho in '..\mestoque\AHorarioTrabalho.pas' {FHorarioTrabalho},
  AFaixaEtaria in '..\mpontaloja\AFaixaEtaria.pas' {FFaixaEtaria},
  AMarcas in '..\mpontaloja\AMarcas.pas' {FMarca};

{$R *.RES}
var
  ParametroBase, ParametroNomeSistema : String;

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  varia.ParametroBase := ParamStr(1);

  if ParamCount < 1 then
  begin
    varia.ParametroBase := 'SisCorp';
  end;


  ParametroNomeSistema := 'SisCorp - ' + ParametroBase;
  Fprincipal.VplParametroBaseDados := ParametroBase;

  if FPrincipal.AbreBaseDados(varia.ParametroBase) then  // caso naum abra a base de dados
  begin
    FAbertura := TFAbertura.create(application);
    if (ParamStr(2) <> '') and (ParamStr(3) <> '') then    // caso a senha e ususario venham como parametro
    begin
      if FAbertura.VerificaSenha(Uppercase(ParamStr(2)),Uppercase(ParamStr(3)), ParamStr(4), ParamStr(5)) then // verifica a senha
         FAbertura.close
      else
         FAbertura.ShowModal;
      end
      else
        FAbertura.ShowModal;

      if Varia.StatusAbertura = 'CANCELADO' then
        FPrincipal.close
      else
        Application.Run;
    end
    else
    FPrincipal.close;

end.
