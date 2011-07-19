program EstoqueCusto;

uses
  Forms,
  sysutils,
  RpDefine,
  FunString,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  Constantes in '..\MConfiguracoesSistema\Constantes.pas',
  ASobre in '..\MaGerais\ASobre.pas' {FSobre},
  Abertura in '..\MaGerais\Abertura.pas' {FAbertura},
  AAlterarSenha in '..\MaGerais\AAlterarSenha.pas' {FAlteraSenha},
  AAlterarFilialUso in '..\MaGerais\AAlterarFilialUso.pas' {FAlterarFilialUso},
  UnRegistro in '..\MConfiguraModulos\UnRegistro.pas',
  AUnidade in 'AUnidade.pas' {FUnidades},
  AFormacaoPreco in 'AFormacaoPreco.pas' {FFormacaoPreco},
  AMontaKit in 'AMontaKit.pas' {FMontaKit},
  ANovaClassificacao in 'ANovaClassificacao.pas' {FNovaClassificacao},
  AOperacoesEstoques in 'AOperacoesEstoques.pas' {FOperacoesEstoques},
  AProdutos in 'AProdutos.pas' {Fprodutos},
  AProdutosKit in 'AProdutosKit.pas' {FProdutosKit},
  AAcertoEstoque in 'AAcertoEstoque.pas' {FAcertoEstoque},
  AClientes in '..\MaGerais\AClientes.pas' {FClientes},
  ANovoCliente in '..\MaGerais\ANovoCliente.pas' {FNovoCliente},
  AProfissoes in '..\MaGerais\AProfissoes.pas' {FProfissoes},
  ASituacoesClientes in '..\MaGerais\ASituacoesClientes.pas' {FSituacoesClientes},
  AConsultaRuas in '..\MaGerais\AConsultaRuas.pas' {FConsultaRuas},
  ACadCidades in '..\MaGerais\ACadCidades.pas' {FCidades},
  ACadPaises in '..\MaGerais\ACadPaises.pas' {FCadPaises},
  ACadEstados in '..\MaGerais\ACadEstados.pas' {FCadEstados},
  AEventos in '..\MaGerais\AEventos.pas' {FEventos},
  AExtornoEntrada in 'AExtornoEntrada.pas' {FExtornoEntrada},
  ANaturezas in '..\MFaturamento\ANaturezas.pas' {FNaturezas},
  ANovaNatureza in '..\MFaturamento\ANovaNatureza.pas' {FNovaNatureza},
  UnProdutos in 'UnProdutos.pas',
  UnCodigoBarra in '..\MConfiguracoesSistema\UnCodigoBarra.pas',
  AEstornoAcertoEstoque in 'AEstornoAcertoEstoque.pas' {FEstornoAcertoEstoque},
  AAdicionaProdFilial in 'AAdicionaProdFilial.pas' {FAdicionaProdFilial},
  ATabelaPreco in 'ATabelaPreco.pas' {FTabelaPreco},
  APlanoConta in '..\MFinanceiro\APlanoConta.pas' {FPlanoConta},
  ANovoPlanoConta in '..\MFinanceiro\ANovoPlanoConta.pas' {FNovoPlanoConta},
  ACadIcmsEstado in '..\MFaturamento\ACadIcmsEstado.pas' {FCadIcmsEstado},
  UnNotasFiscaisFor in 'UnNotasFiscaisFor.pas',
  AEstoqueProdutos in 'AEstoqueProdutos.pas' {FEstoqueProdutos},
  APontoPedido in 'APontoPedido.pas' {FPontoPedido},
  CadFormularios in '..\MConfiguracoesSistema\CadFormularios.pas' {FCadFormularios},
  UnSumarizaEstoque in 'UnSumarizaEstoque.pas',
  ALocalizaClassificacao in 'ALocalizaClassificacao.pas' {FLocalizaClassificacao},
  UnClassificacao in 'UnClassificacao.pas',
  AServicos in 'AServicos.pas' {FServicos},
  ANovoServico in 'ANovoServico.pas' {FNovoServico},
  UnImpressao in '..\MaGerais\UnImpressao.pas',
  UnClassesImprimir in '..\MaGerais\UnClassesImprimir.pas',
  AFormacaoPrecoServico in 'AFormacaoPrecoServico.pas' {FFormacaoPrecoServico},
  UnServicos in 'UnServicos.pas',
  UnContasAPagar in '..\MFinanceiro\UnContasAPagar.pas',
  UnComissoes in '..\MFinanceiro\UnComissoes.pas',
  AFormasPagamento in '..\MFinanceiro\AFormasPagamento.pas' {FFormasPagamento},
  UnMoedas in '..\MConfiguracoesSistema\UnMoedas.pas',
  ALocalizaProdutos in '..\MFaturamento\ALocalizaProdutos.pas' {FlocalizaProduto},
  ADetalhesEstoque in 'ADetalhesEstoque.pas' {FDetalhesEstoque},
  UnAtualizacao in '..\MaGerais\UnAtualizacao.pas',
  ABancos in '..\MFinanceiro\ABancos.pas' {FBancos},
  AEstoqueClassificacaoAtual in 'AEstoqueClassificacaoAtual.pas' {FEstoqueClassificacaoAtual},
  AEstoqueProdutosAtual in 'AEstoqueProdutosAtual.pas' {FEstoqueProdutosAtual},
  UnNotaFiscal in '..\MFaturamento\UnNotaFiscal.pas',
  UnContasAReceber in '..\MFinanceiro\UnContasAReceber.pas',
  UnCotacao in '..\MPontaLoja\UnCotacao.pas',
  AConsultaCondicaoPgto in '..\MaGerais\AConsultaCondicaoPgto.pas' {FConsultaCondicaoPgto},
  AObservacoesNota in '..\MFaturamento\AObservacoesNota.pas' {FObservacoesNota},
  AContas in '..\MFinanceiro\AContas.pas' {FContas},
  AAtividadeProduto in 'AAtividadeProduto.pas' {FAtividadeProduto},
  UnPrincipal in '..\MaGerais\UnPrincipal.pas',
  AEstoqueProdutosPreco in 'AEstoqueProdutosPreco.pas' {FEstoqueProdutosPreco},
  ARegiaoVenda in '..\MaGerais\ARegiaoVenda.pas' {FRegiaoVenda},
  AFechamentoEstoque in 'AFechamentoEstoque.pas' {FFechamentoEstoque},
  AQdadeProdutosInconsistente in 'AQdadeProdutosInconsistente.pas' {FQdadeProdutosInconsistente},
  AItensNatureza in '..\MFaturamento\AItensNatureza.pas' {FItensNatureza},
  AMovNatureza in '..\MFaturamento\AMovNatureza.pas' {FMovNatureza},
  UnComandosImpCheque in '..\MaGerais\UnComandosImpCheque.pas',
  AInventario in 'AInventario.pas' {FInventario},
  UnInventario in 'UnInventario.pas',
  UnSistema in '..\magerais\UnSistema.pas',
  ANovoVendedor in '..\magerais\ANovoVendedor.pas' {FNovoVendedor},
  AVendedores in '..\magerais\AVendedores.pas' {FVendedores},
  AMaquinas in 'AMaquinas.pas' {FMaquinas},
  ANovaOrdemProducao in 'ANovaOrdemProducao.pas' {FNovaOrdemProducao},
  UnDados in '..\magerais\UnDados.pas',
  UnOrdemProducao in 'UnOrdemProducao.pas',
  AOrdemProducao in 'AOrdemProducao.pas' {FOrdemProducao},
  ATipoEstagioProducao in 'ATipoEstagioProducao.pas' {FTipoEstagioProducao},
  AEstagioProducao in 'AEstagioProducao.pas' {FEstagioProducao},
  AAlteraEstagioProducao in 'AAlteraEstagioProducao.pas' {FAlteraEstagioProducao},
  ATipoEmenda in 'ATipoEmenda.pas' {FTipoEmenda},
  AMostraParReceberOO in '..\mfinanceiro\AMostraParReceberOO.pas' {FMostraParReceberOO},
  UnClientes in '..\magerais\UnClientes.pas',
  ARamoAtividade in '..\mpontaloja\ARamoAtividade.pas' {FRamoAtividade},
  AAlterarMaquina in 'AAlterarMaquina.pas' {FAlterarMaquina},
  ARelPedido in '..\mpontaloja\ARelPedido.pas' {FRelPedido},
  UnImpressaoRelatorio in '..\magerais\UnImpressaoRelatorio.pas',
  ANovaColetaOrdemProducao in 'ANovaColetaOrdemProducao.pas' {FNovaColetaOrdemProducao},
  AAdicionaColetaOPRomaneio in 'AAdicionaColetaOPRomaneio.pas' {FAdicionaColetaOPRomaneio},
  ARomaneios in 'ARomaneios.pas' {FRomaneios},
  ACores in 'ACores.pas' {FCores},
  ANovaNotaFiscaisFor in 'ANovaNotaFiscaisFor.pas' {FNovaNotaFiscaisFor},
  UnDadosCR in '..\mfinanceiro\UnDadosCR.pas',
  ANovoInventario in 'ANovoInventario.pas' {FNovoInventario},
  UnDadosProduto in 'UnDadosProduto.pas',
  AMotivoReprogramacao in 'AMotivoReprogramacao.pas' {FMotivoReprogramacao},
  ANovaRevisaoExterna in 'ANovaRevisaoExterna.pas' {FNovaRevisaoExterna},
  ARevisaoExterna in 'ARevisaoExterna.pas' {FRevisaoExterna},
  ANovaNotaFiscalNota in '..\mfaturamento\ANovaNotaFiscalNota.pas' {FNovaNotaFiscalNota},
  AMostraObservacaoCliente in '..\mpontaloja\AMostraObservacaoCliente.pas' {FMostraObservacaoCliente},
  ATipoCorte in 'ATipoCorte.pas' {FTipoCorte},
  AReprocessaEstoque in 'AReprocessaEstoque.pas' {FReprocessaEstoque},
  AValidaSerieSistema in '..\..\lib fun\AValidaSerieSistema.pas' {FValidaSerieSistema},
  AMostraEstoqueProdutoCor in 'AMostraEstoqueProdutoCor.pas' {FMostraEstoqueProdutoCor},
  ACalendarioBase in 'ACalendarioBase.pas' {FCalendarioBase},
  AHorarioTrabalho in 'AHorarioTrabalho.pas' {FHorarioTrabalho},
  ACelulaTrabalho in 'ACelulaTrabalho.pas' {FCelulaTrabalho},
  AEstagioCelulaTrabalho in 'AEstagioCelulaTrabalho.pas' {FEstagioCelulaTrabalho},
  AHorarioCelulaTrabalho in 'AHorarioCelulaTrabalho.pas' {FHorarioCelulaTrabalho},
  ACalendarioCelulaTrabalho in 'ACalendarioCelulaTrabalho.pas' {FCalendarioCelulaTrabalho},
  ACotacao in '..\mpontaloja\ACotacao.pas' {FCotacao},
  UnCrystal in '..\magerais\UnCrystal.pas',
  ANovaCotacao in '..\mpontaloja\ANovaCotacao.pas' {FNovaCotacao},
  alocalizaservico in '..\mfaturamento\alocalizaservico.pas' {FlocalizaServico},
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
  AFormaPagamentoECF in '..\mpontaloja\AFormaPagamentoECF.pas' {FFormaPagamentoECF},
  AOrdensProducaoCadarco in 'AOrdensProducaoCadarco.pas' {FOrdensProducaoCadarco},
  ANovaOrdemProducaoCadarco in 'ANovaOrdemProducaoCadarco.pas' {FNovaOrdemProducaoCadarco},
  ANovoTecnico in '..\mpontaloja\ANovoTecnico.pas' {FNovoTecnico},
  ATecnicos in '..\mpontaloja\ATecnicos.pas' {FTecnicos},
  ANovaCobranca in '..\mfinanceiro\ANovaCobranca.pas' {FNovaCobranca},
  AHistoricoLigacao in '..\mfinanceiro\AHistoricoLigacao.pas' {FHistoricoLigacao},
  ACobrancas in '..\mfinanceiro\ACobrancas.pas' {FCobrancas},
  AMotivoInadimplencia in '..\mfinanceiro\AMotivoInadimplencia.pas' {FMotivoInadimplencia},
  UnImpressaoBoleto in '..\magerais\UnImpressaoBoleto.pas',
  ANovoContratoCliente in '..\mpontaloja\ANovoContratoCliente.pas' {FNovoContratoCliente},
  UnContrato in '..\mpontaloja\UnContrato.pas',
  ATipoContrato in '..\mpontaloja\ATipoContrato.pas' {FTipoContrato},
  ANovaConta in '..\mfinanceiro\ANovaConta.pas' {FNovaConta},
  AContratosCliente in '..\mpontaloja\AContratosCliente.pas' {FContratosCliente},
  ANovoTeleMarketing in '..\mpontaloja\ANovoTeleMarketing.pas' {FNovoTeleMarketing},
  UnTeleMarketing in '..\mpontaloja\UnTeleMarketing.pas',
  ABrindesCliente in '..\mpontaloja\ABrindesCliente.pas' {FBrindesCliente},
  AAlteraVendedorCotacao in '..\mpontaloja\AAlteraVendedorCotacao.pas' {FAlteraVendedorCotacao},
  ATeleMarketings in '..\mpontaloja\ATeleMarketings.pas' {FTeleMarketings},
  AProdutosCliente in '..\mpontaloja\AProdutosCliente.pas' {FProdutosCliente},
  AAtualizaPrecoFarmacia in 'AAtualizaPrecoFarmacia.pas' {FAtualizaPrecoFarmacia},
  ATipoAgendamento in '..\mpontaloja\ATipoAgendamento.pas' {FTipoAgendamento},
  ANovoAgendamento in '..\mpontaloja\ANovoAgendamento.pas' {FNovoAgedamento},
  UnDaruma in '..\mpontaloja\UnDaruma.pas',
  ADonoProduto in '..\mpontaloja\ADonoProduto.pas' {FDonoProduto},
  AAcondicionamento in '..\mpontaloja\AAcondicionamento.pas' {FAcondicionamento},
  AGeraFracaoOP in '..\mpontaloja\AGeraFracaoOP.pas' {FGeraFracaoOP},
  AParentesCliente in '..\mpontaloja\AParentesCliente.pas' {FParentesClientes},
  ANovoChamadoTecnico in '..\MChamado\ANovoChamadoTecnico.pas' {FNovoChamado},
  UnChamado in '..\MChamado\UnChamado.pas',
  AFacas in 'AFacas.pas' {FFacas},
  AOrdemProducaoGenerica in 'AOrdemProducaoGenerica.pas' {FOrdemProducaoGenerica},
  UnImprimeConsumoMateriaPrimaOP in 'UnImprimeConsumoMateriaPrimaOP.pas',
  AAlteraEstagioFracaoOP in 'AAlteraEstagioFracaoOP.pas' {FAlteraEstagioFracaoOP},
  ANovaOrdemProducaoGenerica in 'ANovaOrdemProducaoGenerica.pas' {FNovaOrdemProducaoGenerica},
  AAlteraEstagioCotacao in '..\mpontaloja\AAlteraEstagioCotacao.pas' {FAlteraEstagioCotacao},
  ANovaColetaFracaoOP in 'ANovaColetaFracaoOP.pas' {FNovaColetaFracaoOP},
  AProcessaProdutividade in 'AProcessaProdutividade.pas' {FProcessaProdutividade},
  AColetaFracaoOP in 'AColetaFracaoOP.pas' {FColetaFracaoOP},
  AAlteraEstagioChamado in '..\mpontaloja\AAlteraEstagioChamado.pas' {FAlteraEstagioChamado},
  ANovaColetaRomaneio in 'ANovaColetaRomaneio.pas' {FNovaColetaRomaneio},
  ARomaneioGenerico in 'ARomaneioGenerico.pas' {FRomaneioGenerico},
  AHistoricoECobranca in '..\mfinanceiro\AHistoricoECobranca.pas' {FHistoricoECobranca},
  ALocalizaProdutoContrato in '..\MChamado\ALocalizaProdutoContrato.pas' {FLocalizaProdutoContrato},
  AFaccionistas in 'AFaccionistas.pas' {FFaccionistas},
  ANovaFaccionista in 'ANovaFaccionista.pas' {FNovaFaccionista},
  AChamadosTecnicos in '..\MChamado\AChamadosTecnicos.pas' {FChamadoTecnico},
  ANovaFracaoFaccionista in 'ANovaFracaoFaccionista.pas' {FNovaFracaoFaccionista},
  AFracaoFaccionista in 'AFracaoFaccionista.pas' {FFracaoFaccionista},
  AHoraAgendaChamado in '..\MChamado\AHoraAgendaChamado.pas' {FHoraAgendaChamado},
  AAgendaChamados in '..\MChamado\AAgendaChamados.pas' {FAgendaChamados},
  ARetornoFracaoFaccionista in 'ARetornoFracaoFaccionista.pas' {FRetornoFracaoFaccionista},
  ADevolucaoFracaoFaccionista in 'ADevolucaoFracaoFaccionista.pas' {FDevolucaoFracaoFaccionista},
  ANovoTelemarketingFaccionista in 'ANovoTelemarketingFaccionista.pas' {FNovoTelemarketingFaccionista},
  ATelemarketingFaccionista in 'ATelemarketingFaccionista.pas' {FTelemarketingFaccionista},
  AEfetuarPesquisaSatisfacao in '..\MChamado\AEfetuarPesquisaSatisfacao.pas' {FEfetuarPesquisaSatisfacao},
  UnPesquisaSatisfacao in '..\MChamado\UnPesquisaSatisfacao.pas',
  APesarCartucho in 'APesarCartucho.pas' {FPesarCartucho},
  AMedico in '..\mpontaloja\AMedico.pas' {FMedico},
  UnToledo in 'UnToledo.pas',
  UnArgox in '..\magerais\UnArgox.pas',
  AMostraParPagarOO in '..\mfinanceiro\AMostraParPagarOO.pas' {FMostraParPagarOO},
  AContatosCliente in '..\mpontaloja\AContatosCliente.pas' {FContatosCliente},
  AProdutosReserva in '..\mpontaloja\AProdutosReserva.pas' {FProdutosReserva},
  AImpEtiquetaTermicaProduto in 'AImpEtiquetaTermicaProduto.pas' {FImpEtiquetaTermicaProduto},
  AChequesCP in '..\mfinanceiro\AChequesCP.pas' {FChequesCP},
  AConsultacheques in '..\mfinanceiro\AConsultacheques.pas' {FConsultaCheques},
  ANovaMaquina in 'ANovaMaquina.pas' {FNovaMaquina},
  ABaixaConsumoProduto in 'ABaixaConsumoProduto.pas' {FBaixaConsumoProduto},
  ANovoPedidoCompra in 'ANovoPedidoCompra.pas' {FNovoPedidoCompra},
  APedidoCompra in 'APedidoCompra.pas' {FPedidoCompra},
  UnPedidoCompra in 'UnPedidoCompra.pas',
  AAlteraEstagioPedidoCompra in 'AAlteraEstagioPedidoCompra.pas' {FAlteraEstagioPedidoCompra},
  APedidosPendentesFaturar in '..\mpontaloja\APedidosPendentesFaturar.pas' {FPedidosPendentesFaturar},
  UnSolicitacaoCompra in 'UnSolicitacaoCompra.pas',
  ANovaSolicitacaoCompra in 'ANovaSolicitacaoCompra.pas' {FNovaSolicitacaoCompras},
  ASolicitacaoCompras in 'ASolicitacaoCompras.pas' {FSolicitacaoCompra},
  UnProspect in '..\mcrm\UnProspect.pas',
  AAlteraEstagioOrcamento in 'AAlteraEstagioOrcamento.pas' {FAlteraEstagioOrcamentoCompra},
  ATamanhos in '..\mpontaloja\ATamanhos.pas' {FTamanhos},
  AContasAReceber in '..\mfinanceiro\AContasAReceber.pas' {FContasaReceber},
  ANovoContasaReceber in '..\mfinanceiro\ANovoContasaReceber.pas' {FNovoContasAReceber},
  agraficoscontasareceber in '..\mfinanceiro\agraficoscontasareceber.pas' {FGraficosCR},
  AManutencaoCR in '..\mfinanceiro\AManutencaoCR.pas' {FManutencaoCR},
  AMovComissoes in '..\mfinanceiro\AMovComissoes.pas' {FMovComissoes},
  AGraficosContasaPagar in '..\mfinanceiro\AGraficosContasaPagar.pas' {FGraficosCP},
  AConsolidarCR in '..\mfinanceiro\AConsolidarCR.pas' {FConsolidarCR},
  AContasAConsolidarCR in '..\mfinanceiro\AContasAConsolidarCR.pas' {FContasAConsolidarCR},
  AVisualizaLogReceber in '..\mfinanceiro\AVisualizaLogReceber.pas' {FVisualizaLogReceber},
  ACompradores in 'ACompradores.pas' {FCompradores},
  AProdutosOrcados in '..\MChamado\AProdutosOrcados.pas' {FProdutosOrcados},
  AComissaoClassificacaoVendedor in 'AComissaoClassificacaoVendedor.pas' {FComissaoClassificacaoVendedor},
  UnVersoes in '..\magerais\UnVersoes.pas',
  AConcorrentes in '..\mcrm\AConcorrentes.pas' {FConcorrentes},
  ANovoConcorrente in '..\mcrm\ANovoConcorrente.pas' {FNovoConcorrente},
  ASolicitacaoCompraProdutosPendentes in 'ASolicitacaoCompraProdutosPendentes.pas' {FSolicitacaoCompraProdutosPendentes},
  ANovaProposta in '..\mcrm\ANovaProposta.pas' {FNovaProposta},
  UnProposta in '..\mcrm\UnProposta.pas',
  ANovoProspect in '..\mcrm\ANovoProspect.pas' {FNovoProspect},
  AProspects in '..\mcrm\AProspects.pas' {FProspects},
  ANovaAgendaProspect in '..\mcrm\ANovaAgendaProspect.pas' {FNovaAgendaProspect},
  ANovoTelemarketingProspect in '..\mcrm\ANovoTelemarketingProspect.pas' {FNovoTelemarketingProspect},
  AProdutosProspect in '..\mcrm\AProdutosProspect.pas' {FProdutosProspect},
  AContatosProspect in '..\mcrm\AContatosProspect.pas' {FContatosProspect},
  AAlteraEstagioProposta in '..\mcrm\AAlteraEstagioProposta.pas' {FAlteraEstagioProposta},
  AMeioDivulgacao in '..\mcrm\AMeioDivulgacao.pas' {FMeioDivulgacao},
  AMotivoVenda in '..\mcrm\AMotivoVenda.pas' {FMotivoVenda},
  ACartuchos in 'ACartuchos.pas' {FCartuchos},
  APedidosCompraAberto in 'APedidosCompraAberto.pas' {FPedidosCompraAberto},
  UnAmostra in '..\mcrm\UnAmostra.pas',
  ABaixaContasAReceberOO in '..\mfinanceiro\ABaixaContasAReceberOO.pas' {FBaixaContasaReceberOO},
  AInicializaNovoInventario in 'AInicializaNovoInventario.pas' {FInicializaNovoInventario},
  AEmailCobrancaPedidoCompra in 'AEmailCobrancaPedidoCompra.pas' {FEmailCobrancaPedidoCompra},
  AChequesOO in '..\mfinanceiro\AChequesOO.pas' {FChequesOO},
  ABaixaContasaPagarOO in '..\mfinanceiro\ABaixaContasaPagarOO.pas' {FBaixaContasaPagarOO},
  ANovoEmailContasAReceber in '..\mfinanceiro\ANovoEmailContasAReceber.pas' {FNovoEmailContasAReceber},
  ASelecionarUsuarios in '..\mpontaloja\ASelecionarUsuarios.pas' {FSelecionarUsuarios},
  UnLembrete in '..\mpontaloja\UnLembrete.pas',
  ANovoLembrete in '..\mpontaloja\ANovoLembrete.pas' {FNovoLembrete},
  AVerificaLeituraLembrete in '..\MChamado\AVerificaLeituraLembrete.pas' {FVerificaLeituraLembrete},
  AContasAPagar in '..\mfinanceiro\AContasAPagar.pas' {FContasaPagar},
  undespesas in '..\mfinanceiro\undespesas.pas',
  ANovoContasaPagar in '..\mfinanceiro\ANovoContasaPagar.pas' {FNovoContasAPagar},
  adespesas in '..\mfinanceiro\adespesas.pas' {FDespesas},
  ACentroCusto in '..\mfinanceiro\ACentroCusto.pas' {FCentroCusto},
  ageradespesasfixas in '..\mfinanceiro\ageradespesasfixas.pas' {FGeraDespesasFixas},
  AManutencaoCP in '..\mfinanceiro\AManutencaoCP.pas' {FManutencaoCP},
  AGerarFracaoOPMaquinasCorte in '..\mpontaloja\AGerarFracaoOPMaquinasCorte.pas' {FGerarFracaoOPMaquinasCorte},
  UnCaixa in '..\mcaixa\UnCaixa.pas',
  ATipoChamado in '..\MChamado\ATipoChamado.pas' {FTipoChamado},
  ASetores in '..\mcrm\ASetores.pas' {FSetores},
  ANovoSetor in '..\mcrm\ANovoSetor.pas' {FNovoSetor},
  unPremer in 'unPremer.pas',
  AImportaProdutosSolidWorks in 'AImportaProdutosSolidWorks.pas' {FImportaProdutosSolidWork},
  AAcessorio in 'AAcessorio.pas' {FAcessorio},
  ATipoProposta in '..\mcrm\ATipoProposta.pas' {FTipoProposta},
  UnZebra in '..\magerais\UnZebra.pas',
  ACompensaCheque in '..\mfinanceiro\ACompensaCheque.pas' {FCompensaCheque},
  APropostasCliente in '..\mcrm\APropostasCliente.pas' {FPropostasCliente},
  ARelOrdemSerra in 'ARelOrdemSerra.pas' {FRelOrdemSerra},
  ABastidor in 'ABastidor.pas' {FBastidor},
  AMontaKitBastidor in 'AMontaKitBastidor.pas' {FMontaKitBastidor},
  ABaixaProdutosChamado in '..\MChamado\ABaixaProdutosChamado.pas' {FBaixaProdutosChamado},
  ALocalizaFracaoOP in 'ALocalizaFracaoOP.pas' {FLocalizaFracaoOP},
  ANovoPlanoCorte in 'ANovoPlanoCorte.pas' {FNovoPlanoCorte},
  APlanoCorte in 'APlanoCorte.pas' {FPlanoCorte},
  AConsultaChamadoParcial in '..\MChamado\AConsultaChamadoParcial.pas' {FConsultaChamadoParcial},
  ACreditoCliente in '..\mfinanceiro\ACreditoCliente.pas' {FCreditoCliente},
  AFichaTecnicaPendente in 'AFichaTecnicaPendente.pas' {FFichaTecnicaPendente},
  ADesenhosPendentes in 'ADesenhosPendentes.pas' {FDesenhosPendentes},
  ANovoOrcamentoCompra in 'ANovoOrcamentoCompra.pas' {FNovoOrcamentoCompra},
  UnOrcamentoCompra in 'UnOrcamentoCompra.pas',
  AOrcamentoCompras in 'AOrcamentoCompras.pas' {FOrcamentoCompras},
  AFaixaEtaria in '..\mpontaloja\AFaixaEtaria.pas' {FFaixaEtaria},
  AConsultaLogSeparacaoConsumo in 'AConsultaLogSeparacaoConsumo.pas' {FConsultaLogSeparacaoConsumo},
  unEMarketing in '..\mpontaloja\unEMarketing.pas',
  AMarcas in '..\mpontaloja\AMarcas.pas' {FMarca},
  APrecoPendente in 'APrecoPendente.pas' {FPrecoPendente},
  AAmostras in '..\mcrm\AAmostras.pas' {FAmostras},
  ANovaAmostra in '..\mcrm\ANovaAmostra.pas' {FNovaAmostra},
  ADesenvolvedor in '..\mcrm\ADesenvolvedor.pas' {FDesenvolvedor},
  AColecao in '..\mcrm\AColecao.pas' {FColecao},
  AAmostraConsumo in '..\mcrm\AAmostraConsumo.pas' {FAmostraConsumo},
  ARequisicaoMaquina in '..\mcrm\ARequisicaoMaquina.pas' {FRequisicaoMaquina},
  AExcluiProdutoDuplicado in 'AExcluiProdutoDuplicado.pas' {FExcluiProdutoDuplicado},
  APendenciasCompras in 'APendenciasCompras.pas' {FPendenciasCompras},
  AAgendamentos in '..\mpontaloja\AAgendamentos.pas' {FAgendamentos},
  AAlteraEstagioAgendamento in '..\mpontaloja\AAlteraEstagioAgendamento.pas' {FAlteraEstagioAgendamento},
  AMetasVendedor in '..\mpontaloja\AMetasVendedor.pas' {FMetasVendedor},
  ATerceiroFaccionista in 'ATerceiroFaccionista.pas' {FTerceiroFaccionista},
  UnRave in '..\magerais\UnRave.pas',
  dmRave in '..\magerais\dmRave.pas' {dtRave: TDSServerModule},
  AFiguraGRF in 'AFiguraGRF.pas' {FFiguraGRF},
  AComposicoes in 'AComposicoes.pas' {FComposicoes},
  ANovaComposicao in 'ANovaComposicao.pas' {FNovaComposicao},
  UnNFe in '..\mfaturamento\UnNFe.pas',
  ACondicaoPagamento in '..\mpontaloja\ACondicaoPagamento.pas' {FCondicaoPagamento},
  ANovaCondicaoPagamento in '..\mpontaloja\ANovaCondicaoPagamento.pas' {FNovaCondicaoPagamento},
  UnCondicaoPagamento in '..\mfinanceiro\UnCondicaoPagamento.pas',
  AProjetos in '..\mfinanceiro\AProjetos.pas' {FProjetos},
  AMotivoParada in 'AMotivoParada.pas' {FMotivoParada},
  AFichaAmostrasPendentes in 'AFichaAmostrasPendentes.pas' {FFichaAmostrasPendentes},
  ATipoMateriaPrima in '..\mcrm\ATipoMateriaPrima.pas' {FTipoMateriaPrima},
  AGeraFracaoOPProdutos in 'AGeraFracaoOPProdutos.pas' {FGeraFracaoOPProdutos},
  ABaixaOrdemCorte in 'ABaixaOrdemCorte.pas' {FBaixaOrdemCorte},
  AOrdemCortePendente in 'AOrdemCortePendente.pas' {FOrdemCortePendente},
  AImprimeEtiquetaPrateleira in 'AImprimeEtiquetaPrateleira.pas' {FImprimeEtiquetaPrateleira},
  AAmostrasPendentes in 'AAmostrasPendentes.pas' {FAmostrasPendentes},
  ACorpoEmailProposta in '..\mcrm\ACorpoEmailProposta.pas' {FCorpoEmailProposta},
  AMostraEstoqueChapas in 'AMostraEstoqueChapas.pas' {FMostraEstoqueChapas},
  ACadastraEstoqueChapa in 'ACadastraEstoqueChapa.pas' {FCadastraEstoqueChapa},
  UnDRave in '..\magerais\UnDRave.pas',
  UnProgramador1 in '..\magerais\UnProgramador1.pas',
  ANovoProcessoProducao in 'ANovoProcessoProducao.pas' {FNovoProcessoProducao},
  AProcessosProducao in 'AProcessosProducao.pas' {FProcessosProducao},
  AAplicacao in '..\mcrm\AAplicacao.pas' {FAplicacao},
  AAdicionaProdutosTerceirizacao in 'AAdicionaProdutosTerceirizacao.pas' {FAdicionaProdutosTerceirizacao},
  AMapaCompras in 'AMapaCompras.pas' {FMapaCompras},
  ANovoEstagio in 'ANovoEstagio.pas' {FNovoEstagio},
  ASelecionarFornecedorMapaCompras in 'ASelecionarFornecedorMapaCompras.pas' {FSelecionaFornecedorMapaCompras},
  AOPProdutosAReservar in 'AOPProdutosAReservar.pas' {FOPProdutosAReservar},
  AComandoFiscalFiltro in '..\mefiPDV\AComandoFiscalFiltro.pas' {FComandoFiscalFiltro},
  AMenuFiscalECF in '..\mefiPDV\AMenuFiscalECF.pas' {FMenuFiscalECF},
  UnSpedFiscal in '..\mfaturamento\UnSpedFiscal.pas',
  AMostraObservacaoPedido in '..\mpontaloja\AMostraObservacaoPedido.pas' {FMostraObservacaoPedido},
  AProdutosClientePeca in '..\mpontaloja\AProdutosClientePeca.pas' {FProdutosClientePeca},
  AConsultaProdutoNumeroSerie in '..\mpontaloja\AConsultaProdutoNumeroSerie.pas' {FConsultaProdutoNumeroSerie},
  AEnviaEmailCobrancaPedidoCompra in 'AEnviaEmailCobrancaPedidoCompra.pas' {FEnviaEmailCobrancaPedidoCompra},
  AConsultaPrecosProdutos in '..\mpontaloja\AConsultaPrecosProdutos.pas' {FConsultaPrecosProdutos},
  ATelefonesCliente in '..\mpontaloja\ATelefonesCliente.pas' {FTelefoneCliente},
  AMotivoAtrasoAmostra in '..\mcrm\AMotivoAtrasoAmostra.pas' {FMotivoAtrasoAmostra},
  AReciboLocacao in '..\mpontaloja\AReciboLocacao.pas' {FReciboLocacao};

{$R *.RES}


begin
  RPDefine.DataID := IntToStr(Application.Handle);
  Application.Initialize;
  Application.HelpFile := '';
  Application.CreateForm(TFPrincipal, FPrincipal);
  if ParamCount = 0 then  // verifica se a parametros da base de dados
    Varia.ParametroBase := 'SisCorp'
  else
    varia.ParametroBase := CopiaAteChar(ParamStr(1),'/');

  if FPrincipal.AbreBaseDados(ParamStr(1)) then  // caso naum abra a base de dados
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
  end
  else
    FValidaSerieSistema.free;
end.
