program Financeiro;


uses
  Forms,
  sysutils,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  AFormasPagamento in 'AFormasPagamento.pas' {FFormasPagamento},
  ABancos in 'ABancos.pas' {FBancos},
  ANovaConta in 'ANovaConta.pas' {FNovaConta},
  ADespesas in 'ADespesas.pas' {FDespesas},
  AGeraDespesasFixas in 'AGeraDespesasFixas.pas' {FGeraDespesasFixas},
  ANovoContasaPagar in 'ANovoContasaPagar.pas' {FNovoContasAPagar},
  AContasAPagar in 'AContasAPagar.pas' {FContasaPagar},
  AContasFixas in 'AContasFixas.pas' {FContasFixas},
  AImprimeCP in 'AImprimeCP.pas' {FImprimeCP},
  AGraficosContasaPagar in 'AGraficosContasaPagar.pas' {FGraficosCP},
  AMovComissoes in 'AMovComissoes.pas' {FMovComissoes},
  ACondicoesPgtos in 'ACondicoesPgtos.pas' {FCondicoesPagamentos},
  AContasAReceber in 'AContasAReceber.pas' {FContasaReceber},
  ANovoContasaReceber in 'ANovoContasaReceber.pas' {FNovoContasAReceber},
  AGraficosContasaReceber in 'AGraficosContasaReceber.pas' {FGraficosCR},
  AImprimeCR in 'AImprimeCR.pas' {FImprimeCR},
  AGraficosFluxo in 'AGraficosFluxo.pas' {FGraficoFluxo},
  ARelContasaReceber in 'ARelContasaReceber.pas' {FRelContasaReceber},
  ARelFaturamento in 'ARelFaturamento.pas' {FRelFaturamento},
  AManutencaoCR in 'AManutencaoCR.pas' {FManutencaoCR},
  AManutencaoCP in 'AManutencaoCP.pas' {FManutencaoCP},
  UnComissoes in 'UnComissoes.pas',
  UnContasAPagar in 'UnContasAPagar.pas',
  UnContasAReceber in 'UnContasAReceber.pas',
  Abertura in '..\MaGerais\Abertura.pas' {FAbertura},
  AAlterarSenha in '..\MaGerais\AAlterarSenha.pas' {FAlteraSenha},
  AAlterarFilialUso in '..\MaGerais\AAlterarFilialUso.pas' {FAlterarFilialUso},
  ASituacoesClientes in '..\MaGerais\ASituacoesClientes.pas' {FSituacoesClientes},
  AClientes in '..\MaGerais\AClientes.pas' {FClientes},
  AEventos in '..\MaGerais\AEventos.pas' {FEventos},
  ANovoCliente in '..\MaGerais\ANovoCliente.pas' {FNovoCliente},
  AProfissoes in '..\MaGerais\AProfissoes.pas' {FProfissoes},
  AVendedores in '..\MaGerais\AVendedores.pas' {FVendedores},
  ANovoVendedor in '..\MaGerais\ANovoVendedor.pas' {FNovoVendedor},
  ASobre in '..\MaGerais\ASobre.pas' {FSobre},
  Constantes in '..\MConfiguracoesSistema\Constantes.pas',
  UnRegistro in '..\MConfiguraModulos\UnRegistro.pas',
  AConsultaRuas in '..\MaGerais\AConsultaRuas.pas' {FConsultaRuas},
  ACadCidades in '..\MaGerais\ACadCidades.pas' {FCidades},
  ACadEstados in '..\MaGerais\ACadEstados.pas' {FCadEstados},
  ACadLogradouro in '..\MaGerais\ACadLogradouro.pas' {FCadLogradouros},
  ACadPaises in '..\MaGerais\ACadPaises.pas' {FCadPaises},
  ANovoPlanoConta in 'ANovoPlanoConta.pas' {FNovoPlanoConta},
  APlanoConta in 'APlanoConta.pas' {FPlanoConta},
  UnDespesas in 'UnDespesas.pas',
  AConsultaDespesas in 'AConsultaDespesas.pas' {FConsultaDespesas},
  AConsultaTitulosDespesas in 'AConsultaTitulosDespesas.pas' {FConsultaTitulosDespesas},
  AAvaliacaoReceber in 'AAvaliacaoReceber.pas' {FAvaliacaoReceber},
  AImprimeAvaliacao in 'AImprimeAvaliacao.pas' {FImprimeAvaliacao},
  AImprimeTextoAvaliacao in 'AImprimeTextoAvaliacao.pas' {FImprimeTextoAvaliacao},
  CadFormularios in '..\MConfiguracoesSistema\CadFormularios.pas' {FCadFormularios},
  AMostraNotaPromissoria in '..\MaGerais\AMostraNotaPromissoria.pas' {FMostraNotaPromissoria},
  AMostraCarne in '..\MaGerais\AMostraCarne.pas' {FMostraCarne},
  AMostraCheque in '..\MaGerais\AMostraCheque.pas' {FMostraCheque},
  AMostraBoleto in '..\MaGerais\AMostraBoleto.pas' {FMostraBoleto},
  UnImpressao in '..\MaGerais\UnImpressao.pas',
  AImprimeCheque in 'AImprimeCheque.pas' {FImprimeCheque},
  AVisualizaFluxo in 'AVisualizaFluxo.pas' {FVisualizaFluxo},
  UnFluxo in 'UnFluxo.pas',
  AMostraDuplicata in '..\MaGerais\AMostraDuplicata.pas' {FMostraDuplicata},
  AMostraRecibo in '..\MaGerais\AMostraRecibo.pas' {FMostraRecibo},
  AImpBordero in 'AImpBordero.pas' {FImpBordero},
  AImprimeCarne in 'AImprimeCarne.pas' {FImprimeCarne},
  AImprimeDuplicata in 'AImprimeDuplicata.pas' {FImprimeDuplicata},
  AImprimeBoleto in 'AImprimeBoleto.pas' {FImprimeBoleto},
  AImprimeMovBancario in 'AImprimeMovBancario.pas' {FImprimeMovBancario},
  UnClassesImprimir in '..\MaGerais\UnClassesImprimir.pas',
  AConsultaValoresFornecedor in 'AConsultaValoresFornecedor.pas' {FConsultaValoresFornecedor},
  AImprimeValoresFornecedor in 'AImprimeValoresFornecedor.pas' {FImprimeValoresFornecedor},
  AImprimePlanoContas in 'AImprimePlanoContas.pas' {FImprimePlanoContas},
  UnNotaFiscal in '..\MFaturamento\UnNotaFiscal.pas',
  UnProdutos in '..\MEstoque\UnProdutos.pas',
  UnSumarizaEstoque in '..\MEstoque\UnSumarizaEstoque.pas',
  UnCodigoBarra in '..\MConfiguracoesSistema\UnCodigoBarra.pas',
  UnClassificacao in '..\MEstoque\UnClassificacao.pas',
  UnMoedas in '..\MConfiguracoesSistema\UnMoedas.pas',
  ANovaNatureza in '..\MFaturamento\ANovaNatureza.pas' {FNovaNatureza},
  ANaturezas in '..\MFaturamento\ANaturezas.pas' {FNaturezas},
  AOperacoesEstoques in '..\MEstoque\AOperacoesEstoques.pas' {FOperacoesEstoques},
  ALocalizaProdutos in '..\MFaturamento\ALocalizaProdutos.pas' {FlocalizaProduto},
  AProdutosKit in '..\MEstoque\AProdutosKit.pas' {FProdutosKit},
  AProdutos in '..\MEstoque\AProdutos.pas' {Fprodutos},
  ANovaClassificacao in '..\MEstoque\ANovaClassificacao.pas' {FNovaClassificacao},
  AMontaKit in '..\MEstoque\AMontaKit.pas' {FMontaKit},
  ALocalizaClassificacao in '..\MEstoque\ALocalizaClassificacao.pas' {FLocalizaClassificacao},
  AConsultaCondicaoPgto in '..\MaGerais\AConsultaCondicaoPgto.pas' {FConsultaCondicaoPgto},
  AObservacoesNota in '..\MFaturamento\AObservacoesNota.pas' {FObservacoesNota},
  ANovoServico in '..\MEstoque\ANovoServico.pas' {FNovoServico},
  UnServicos in '..\MEstoque\UnServicos.pas',
  UnNotasFiscaisFor in '..\MEstoque\UnNotasFiscaisFor.pas',
  ANovaTransportadora in '..\MaGerais\ANovaTransportadora.pas' {FNovaTransportadora},
  ATransportadoras in '..\MaGerais\ATransportadoras.pas' {FTransportadoras},
  AMostraEnvelope in '..\MaGerais\AMostraEnvelope.pas' {FMostraEnvelope},
  UnCotacao in '..\MPontaLoja\UnCotacao.pas',
  UnAtualizacao in '..\MaGerais\UnAtualizacao.pas',
  AConsultaReceitaDespesa in 'AConsultaReceitaDespesa.pas' {FConsultaReceitaDespesa},
  UnPrincipal in '..\MaGerais\UnPrincipal.pas',
  ARegiaoVenda in '..\MaGerais\ARegiaoVenda.pas' {FRegiaoVenda},
  AMovNatureza in '..\MFaturamento\AMovNatureza.pas' {FMovNatureza},
  AItensNatureza in '..\MFaturamento\AItensNatureza.pas' {FItensNatureza},
  AMostraNroNSU in 'AMostraNroNSU.pas' {FMostraNroNSU},
  ABackup in '..\MaGerais\ABackup.pas' {FBackup},
  UnComandosImpCheque in '..\MaGerais\UnComandosImpCheque.pas',
  ARelClientesemAberto in 'ARelClientesemAberto.pas' {FRelClienteEmAberto},
  AImpCliente in '..\mfaturamento\AImpCliente.pas' {FImpCliente},
  AImpProduto in '..\mestoque\AImpProduto.pas' {FImpProduto},
  ATipoFundo in '..\mestoque\ATipoFundo.pas' {FTipoFundo},
  UnDados in '..\magerais\UnDados.pas',
  ATipoEmenda in '..\mestoque\ATipoEmenda.pas' {FTipoEmenda},
  AMaquinas in '..\mestoque\AMaquinas.pas' {FMaquinas},
  ACores in '..\mestoque\ACores.pas' {FCores},
  UnClientes in '..\magerais\UnClientes.pas',
  UnSistema in '..\magerais\UnSistema.pas',
  AConsolidarCR in 'AConsolidarCR.pas' {FConsolidarCR},
  ARamoAtividade in '..\mpontaloja\ARamoAtividade.pas' {FRamoAtividade},
  AContasAConsolidarCR in 'AContasAConsolidarCR.pas' {FContasAConsolidarCR},
  UnImpressaoBoleto in '..\magerais\UnImpressaoBoleto.pas',
  UnImpressaoRelatorio in '..\magerais\UnImpressaoRelatorio.pas',
  ARelPedido in '..\mpontaloja\ARelPedido.pas' {FRelPedido},
  UnDadosCR in 'UnDadosCR.pas',
  AMostraParReceberOO in 'AMostraParReceberOO.pas' {FMostraParReceberOO},
  UnDadosProduto in '..\mestoque\UnDadosProduto.pas',
  ANovaNotaFiscalNota in '..\mfaturamento\ANovaNotaFiscalNota.pas' {FNovaNotaFiscalNota},
  AMostraObservacaoCliente in '..\mpontaloja\AMostraObservacaoCliente.pas' {FMostraObservacaoCliente},
  AValidaSerieSistema in '..\..\modulos\AValidaSerieSistema.pas' {FValidaSerieSistema},
  ANovaNotaFiscaisFor in '..\mestoque\ANovaNotaFiscaisFor.pas' {FNovaNotaFiscaisFor},
  UnOrdemProducao in '..\mestoque\UnOrdemProducao.pas',
  AEstagioProducao in '..\mestoque\AEstagioProducao.pas' {FEstagioProducao},
  ATipoEstagioProducao in '..\mestoque\ATipoEstagioProducao.pas' {FTipoEstagioProducao},
  ACotacao in '..\mpontaloja\ACotacao.pas' {FCotacao},
  UnCrystal in '..\magerais\UnCrystal.pas',
  ANovaCotacao in '..\mpontaloja\ANovaCotacao.pas' {FNovaCotacao},
  alocalizaservico in '..\mfaturamento\alocalizaservico.pas' {FlocalizaServico},
  AImpCotacao in '..\mpontaloja\AImpCotacao.pas' {FImpOrcamento},
  UnVendedor in '..\magerais\UnVendedor.pas',
  ATipoCotacao in '..\mpontaloja\ATipoCotacao.pas' {FTipoCotacao},
  AEmbalagem in '..\mpontaloja\AEmbalagem.pas' {FEmbalagem},
  AProdutoReferencia in '..\mpontaloja\AProdutoReferencia.pas' {FReferenciaProduto},
  AProdutosDevolvidos in '..\mpontaloja\AProdutosDevolvidos.pas' {FProdutosDevolvidos},
  AImprimeEtiqueta in '..\mpontaloja\AImprimeEtiqueta.pas' {FImprimiEtiqueta},
  UnImpressaoEtiquetaCotacao in '..\mpontaloja\UnImpressaoEtiquetaCotacao.pas',
  AGeraOP in '..\mpontaloja\AGeraOP.pas' {FGerarOP},
  AGeraEstagiosOP in '..\mpontaloja\AGeraEstagiosOP.pas' {FGeraEstagiosOP},
  ABaixaParcialCotacao in '..\mpontaloja\ABaixaParcialCotacao.pas' {FBaixaParcialCotacao},
  AConsultaBaixaParcial in '..\mpontaloja\AConsultaBaixaParcial.pas' {FConsultaBaixaParcial},
  ANovoECF in '..\mpontaloja\ANovoECF.pas' {FNovoECF},
  UnECF in '..\mpontaloja\UnECF.pas',
  UnBematech in '..\mpontaloja\UnBematech.pas',
  AFormaPagamentoECF in '..\mpontaloja\AFormaPagamentoECF.pas' {FFormaPagamentoECF},
  ANovaOrdemProducaoCadarco in '..\mestoque\ANovaOrdemProducaoCadarco.pas' {FNovaOrdemProducaoCadarco},
  AImpOrdemProducao in '..\mestoque\AImpOrdemProducao.pas' {FImpOrdemProducao},
  AOrdensProducaoCadarco in '..\mestoque\AOrdensProducaoCadarco.pas' {FOrdensProducaoCadarco},
  ARemessas in 'ARemessas.pas' {FRemessas},
  UnRemessa in 'UnRemessa.pas',
  ARetornos in 'ARetornos.pas' {FRetornos},
  UnRetorno in 'UnRetorno.pas',
  AHistoricoLigacao in 'AHistoricoLigacao.pas' {FHistoricoLigacao},
  ANovoTecnico in '..\mpontaloja\ANovoTecnico.pas' {FNovoTecnico},
  ATecnicos in '..\mpontaloja\ATecnicos.pas' {FTecnicos},
  ANovaCobranca in 'ANovaCobranca.pas' {FNovaCobranca},
  ACobrancas in 'ACobrancas.pas' {FCobrancas},
  ATipoCorte in '..\mestoque\ATipoCorte.pas' {FTipoCorte},
  ABaixaCotacaoPaga in 'ABaixaCotacaoPaga.pas' {FBaixaCotacaoPaga},
  AVisualizaLogReceber in 'AVisualizaLogReceber.pas' {FVisualizaLogReceber},
  AMotivoInadimplencia in 'AMotivoInadimplencia.pas' {FMotivoInadimplencia},
  AContas in 'AContas.pas' {FContas},
  ANovoContratoCliente in '..\mpontaloja\ANovoContratoCliente.pas' {FNovoContratoCliente},
  UnContrato in '..\mpontaloja\UnContrato.pas',
  ATipoContrato in '..\mpontaloja\ATipoContrato.pas' {FTipoContrato},
  AContratosCliente in '..\mpontaloja\AContratosCliente.pas' {FContratosCliente},
  AAlteraVendedorCotacao in '..\mpontaloja\AAlteraVendedorCotacao.pas' {FAlteraVendedorCotacao},
  ABrindesCliente in '..\mpontaloja\ABrindesCliente.pas' {FBrindesCliente},
  ANovoTeleMarketing in '..\mpontaloja\ANovoTeleMarketing.pas' {FNovoTeleMarketing},
  UnTeleMarketing in '..\mpontaloja\UnTeleMarketing.pas',
  AIndicadorInadimplencia in 'AIndicadorInadimplencia.pas' {FIndicadorInadimplencia},
  ATeleMarketings in '..\mpontaloja\ATeleMarketings.pas' {FTeleMarketings},
  AProdutosCliente in '..\mpontaloja\AProdutosCliente.pas' {FProdutosCliente},
  ATipoAgendamento in '..\mpontaloja\ATipoAgendamento.pas' {FTipoAgendamento},
  ANovoAgendamento in '..\mpontaloja\ANovoAgendamento.pas' {FNovoAgedamento},
  UnDaruma in '..\mpontaloja\UnDaruma.pas',
  ADonoProduto in '..\mpontaloja\ADonoProduto.pas' {FDonoProduto},
  AAcondicionamento in '..\mpontaloja\AAcondicionamento.pas' {FAcondicionamento},
  AGeraFracaoOP in '..\mpontaloja\AGeraFracaoOP.pas' {FGeraFracaoOP},
  AParentesCliente in '..\mpontaloja\AParentesCliente.pas' {FParentesClientes},
  ANovoChamadoTecnico in '..\MChamado\ANovoChamadoTecnico.pas' {FNovoChamado},
  UnChamado in '..\MChamado\UnChamado.pas',
  ANovaOrdemProducaoGenerica in '..\mestoque\ANovaOrdemProducaoGenerica.pas' {FNovaOrdemProducaoGenerica},
  AOrdemProducaoGenerica in '..\mestoque\AOrdemProducaoGenerica.pas' {FOrdemProducaoGenerica},
  AAlteraEstagioCotacao in '..\mpontaloja\AAlteraEstagioCotacao.pas' {FAlteraEstagioCotacao},
  AAlteraEstagioChamado in '..\mpontaloja\AAlteraEstagioChamado.pas' {FAlteraEstagioChamado},
  AEmailContasAReceber in 'AEmailContasAReceber.pas' {FEmailContasaReceber},
  ANovoEmailContasAReceber in 'ANovoEmailContasAReceber.pas' {FNovoEmailContasAReceber},
  AHistoricoECobranca in 'AHistoricoECobranca.pas' {FHistoricoECobranca},
  ALocalizaProdutoContrato in '..\MChamado\ALocalizaProdutoContrato.pas' {FLocalizaProdutoContrato},
  AChamadosTecnicos in '..\MChamado\AChamadosTecnicos.pas' {FChamadoTecnico},
  AHoraAgendaChamado in '..\MChamado\AHoraAgendaChamado.pas' {FHoraAgendaChamado},
  AAgendaChamados in '..\MChamado\AAgendaChamados.pas' {FAgendaChamados},
  AEfetuarPesquisaSatisfacao in '..\MChamado\AEfetuarPesquisaSatisfacao.pas' {FEfetuarPesquisaSatisfacao},
  UnPesquisaSatisfacao in '..\MChamado\UnPesquisaSatisfacao.pas',
  APrazoMedio in 'APrazoMedio.pas' {FPrazoMedio},
  ACentroCusto in 'ACentroCusto.pas' {FCentroCusto},
  AMedico in '..\mpontaloja\AMedico.pas' {FMedico},
  AClientesBloqueados in 'AClientesBloqueados.pas' {FClientesBloqueados},
  AGraficoAnaliseFaturamento in '..\mpontaloja\AGraficoAnaliseFaturamento.pas' {FGraficoAnaliseFaturamento},
  AContatosCliente in '..\mpontaloja\AContatosCliente.pas' {FContatosCliente},
  AConsultacheques in 'AConsultacheques.pas' {FConsultaCheques},
  AProdutosReserva in '..\mpontaloja\AProdutosReserva.pas' {FProdutosReserva},
  UnArgox in '..\magerais\UnArgox.pas',
  AChequesCP in 'AChequesCP.pas' {FChequesCP},
  ANovaMaquina in '..\mestoque\ANovaMaquina.pas' {FNovaMaquina},
  APedidosPendentesFaturar in '..\mpontaloja\APedidosPendentesFaturar.pas' {FPedidosPendentesFaturar},
  UnProposta in '..\mcrm\UnProposta.pas',
  UnProspect in '..\mcrm\UnProspect.pas',
  ATamanhos in '..\mpontaloja\ATamanhos.pas' {FTamanhos},
  AComissaoClassificacaoVendedor in '..\mestoque\AComissaoClassificacaoVendedor.pas' {FComissaoClassificacaoVendedor},
  AProdutosOrcados in '..\MChamado\AProdutosOrcados.pas' {FProdutosOrcados},
  UnVersoes in '..\magerais\UnVersoes.pas',
  ANovoConcorrente in '..\mcrm\ANovoConcorrente.pas' {FNovoConcorrente},
  AConcorrentes in '..\mcrm\AConcorrentes.pas' {FConcorrentes},
  ABaixaContasAReceberOO in 'ABaixaContasAReceberOO.pas' {FBaixaContasaReceberOO},
  ANovoProspect in '..\mcrm\ANovoProspect.pas' {FNovoProspect},
  AProspects in '..\mcrm\AProspects.pas' {FProspects},
  AContatosProspect in '..\mcrm\AContatosProspect.pas' {FContatosProspect},
  AMeioDivulgacao in '..\mcrm\AMeioDivulgacao.pas' {FMeioDivulgacao},
  AMotivoVenda in '..\mcrm\AMotivoVenda.pas' {FMotivoVenda},
  ANovaProposta in '..\mcrm\ANovaProposta.pas' {FNovaProposta},
  ANovaAgendaProspect in '..\mcrm\ANovaAgendaProspect.pas' {FNovaAgendaProspect},
  APropostas in '..\mcrm\APropostas.pas' {FPropostas},
  ANovoTelemarketingProspect in '..\mcrm\ANovoTelemarketingProspect.pas' {FNovoTelemarketingProspect},
  AProdutosProspect in '..\mcrm\AProdutosProspect.pas' {FProdutosProspect},
  AAlteraEstagioProposta in '..\mcrm\AAlteraEstagioProposta.pas' {FAlteraEstagioProposta},
  UnAmostra in '..\mcrm\UnAmostra.pas',
  ANovoPedidoCompra in '..\mestoque\ANovoPedidoCompra.pas' {FNovoPedidoCompra},
  UnPedidoCompra in '..\mestoque\UnPedidoCompra.pas',
  UnSolicitacaoCompra in '..\mestoque\UnSolicitacaoCompra.pas',
  APedidosCompraAberto in '..\mestoque\APedidosCompraAberto.pas' {FPedidosCompraAberto},
  ACompradores in '..\mestoque\ACompradores.pas' {FCompradores},
  ANovoProdutoPro in '..\mestoque\ANovoProdutoPro.pas' {FNovoProdutoPro},
  AChequesOO in 'AChequesOO.pas' {FChequesOO},
  ABaixaContasaPagarOO in 'ABaixaContasaPagarOO.pas' {FBaixaContasaPagarOO},
  UnLembrete in '..\mpontaloja\UnLembrete.pas',
  ANovoLembrete in '..\mpontaloja\ANovoLembrete.pas' {FNovoLembrete},
  ASelecionarUsuarios in '..\mpontaloja\ASelecionarUsuarios.pas' {FSelecionarUsuarios},
  AVerificaLeituraLembrete in '..\MChamado\AVerificaLeituraLembrete.pas' {FVerificaLeituraLembrete},
  UnCaixa in '..\mcaixa\UnCaixa.pas',
  AGerarFracaoOPMaquinasCorte in '..\mpontaloja\AGerarFracaoOPMaquinasCorte.pas' {FGerarFracaoOPMaquinasCorte},
  ATipoChamado in '..\MChamado\ATipoChamado.pas' {FTipoChamado},
  ASetores in '..\mcrm\ASetores.pas' {FSetores},
  ABaixaConsumoProduto in '..\mestoque\ABaixaConsumoProduto.pas' {FBaixaConsumoProduto},
  AAlteraEstagioPedidoCompra in '..\mestoque\AAlteraEstagioPedidoCompra.pas' {FAlteraEstagioPedidoCompra},
  ANovoSetor in '..\mcrm\ANovoSetor.pas' {FNovoSetor},
  AMostraParPagarOO in 'AMostraParPagarOO.pas' {FMostraParPagarOO},
  ASolicitacaoCompras in '..\mestoque\ASolicitacaoCompras.pas' {FOrcamentoCompra},
  ANovaSolicitacaoCompra in '..\mestoque\ANovaSolicitacaoCompra.pas' {FNovaSolicitacaoCompras},
  AAlteraEstagioOrcamento in '..\mestoque\AAlteraEstagioOrcamento.pas' {FAlteraEstagioOrcamentoCompra},
  ASolicitacaoCompraProdutosPendentes in '..\mestoque\ASolicitacaoCompraProdutosPendentes.pas' {FOrcamentoCompraProdutosPendentes},
  APedidoCompra in '..\mestoque\APedidoCompra.pas' {FPedidoCompra},
  ATipoProposta in '..\mcrm\ATipoProposta.pas' {FTipoProposta},
  UnZebra in '..\magerais\UnZebra.pas',
  ACompensaCheque in 'ACompensaCheque.pas' {FCompensaCheque},
  APropostasCliente in '..\mcrm\APropostasCliente.pas' {FPropostasCliente},
  ARelOrdemSerra in '..\mestoque\ARelOrdemSerra.pas' {FRelOrdemSerra},
  AMontaKitBastidor in '..\mestoque\AMontaKitBastidor.pas' {FMontaKitBastidor},
  ABaixaProdutosChamado in '..\MChamado\ABaixaProdutosChamado.pas' {FBaixaProdutosChamado},
  ACreditoCliente in 'ACreditoCliente.pas' {FCreditoCliente},
  AConsultaChamadoParcial in '..\MChamado\AConsultaChamadoParcial.pas' {FConsultaChamadoParcial},
  AAlteraEstagioFracaoOP in '..\mestoque\AAlteraEstagioFracaoOP.pas' {FAlteraEstagioFracaoOP},
  AFluxoCaixa in 'AFluxoCaixa.pas' {FFluxoCaixa},
  UnFluxoCaixa in 'UnFluxoCaixa.pas',
  ANovoOrcamentoCompra in '..\mestoque\ANovoOrcamentoCompra.pas' {FNovoOrcamentoCompra},
  UnOrcamentoCompra in '..\mestoque\UnOrcamentoCompra.pas',
  AHorarioTrabalho in '..\mestoque\AHorarioTrabalho.pas' {FHorarioTrabalho},
  unEMarketing in '..\mpontaloja\unEMarketing.pas',
  AFaixaEtaria in '..\mpontaloja\AFaixaEtaria.pas' {FFaixaEtaria},
  AMarcas in '..\mpontaloja\AMarcas.pas' {FMarca},
  AAlteraEstagioAgendamento in '..\mpontaloja\AAlteraEstagioAgendamento.pas' {FAlteraEstagioAgendamento},
  AAgendamentos in '..\mpontaloja\AAgendamentos.pas' {FAgendamentos},
  AMetasVendedor in '..\mpontaloja\AMetasVendedor.pas' {FMetasVendedor},
  ADER in 'ADER.pas' {FDER},
  UnDER in 'UnDER.pas',
  AConsultaLogSeparacaoConsumo in '..\mestoque\AConsultaLogSeparacaoConsumo.pas' {FConsultaLogSeparacaoConsumo},
  dmRave in '..\magerais\dmRave.pas' {dtRave: TDSServerModule},
  UnRave in '..\magerais\UnRave.pas',
  UnNFe in '..\mfaturamento\UnNFe.pas',
  ANovaComposicao in '..\mestoque\ANovaComposicao.pas' {FNovaComposicao},
  AComposicoes in '..\mestoque\AComposicoes.pas' {FComposicoes},
  UnCondicaoPagamento in 'UnCondicaoPagamento.pas',
  ANovaCondicaoPagamento in '..\mpontaloja\ANovaCondicaoPagamento.pas' {FNovaCondicaoPagamento},
  ACondicaoPagamento in '..\mpontaloja\ACondicaoPagamento.pas' {FCondicaoPagamento},
  AProjetos in 'AProjetos.pas' {FProjetos};

{$R *.RES}
begin
  Application.Initialize;
  Application.HelpFile := '';
  Application.CreateForm(TFPrincipal, FPrincipal);
  if ParamCount = 0 then  // verifica se a parametros da base de dados
    varia.ParametroBase := 'SisCorp'
  else
    varia.ParametroBase := ParamStr(1);

  if FPrincipal.AbreBaseDados(varia.ParametroBase) then  // caso naum abra a base de dados
  begin
    FAbertura := TFAbertura.create(application);
    if Sistema.ValidaSerieSistema then
    begin
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
  end;
end.
