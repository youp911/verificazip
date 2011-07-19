program faturamento;

uses
  Forms,
  SysUtils,
  RpDefine,
  FunString,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  Constantes in '..\MConfiguracoesSistema\Constantes.pas',
  ASobre in '..\MaGerais\ASobre.pas' {FSobre},
  Abertura in '..\MaGerais\Abertura.pas' {FAbertura},
  AAlterarSenha in '..\MaGerais\AAlterarSenha.pas' {FAlteraSenha},
  AAlterarFilialUso in '..\MaGerais\AAlterarFilialUso.pas' {FAlterarFilialUso},
  UnRegistro in '..\MConfiguraModulos\UnRegistro.pas',
  AUnidade in '..\MEstoque\AUnidade.pas' {FUnidades},
  AMontaKit in '..\MEstoque\AMontaKit.pas' {FMontaKit},
  ANovaClassificacao in '..\Mestoque\ANovaClassificacao.pas' {FNovaClassificacao},
  AOperacoesEstoques in '..\MEstoque\AOperacoesEstoques.pas' {FOperacoesEstoques},
  AProdutos in '..\MEstoque\AProdutos.pas' {Fprodutos},
  AProdutosKit in '..\MEstoque\AProdutosKit.pas' {FProdutosKit},
  AClientes in '..\MaGerais\AClientes.pas' {FClientes},
  ANovoCliente in '..\MaGerais\ANovoCliente.pas' {FNovoCliente},
  ASituacoesClientes in '..\MaGerais\ASituacoesClientes.pas' {FSituacoesClientes},
  AConsultaRuas in '..\MaGerais\AConsultaRuas.pas' {FConsultaRuas},
  ACadCidades in '..\MaGerais\ACadCidades.pas' {FCidades},
  ACadPaises in '..\MaGerais\ACadPaises.pas' {FCadPaises},
  ACadEstados in '..\MaGerais\ACadEstados.pas' {FCadEstados},
  AEventos in '..\MaGerais\AEventos.pas' {FEventos},
  ANaturezas in 'ANaturezas.pas' {FNaturezas},
  ANovaNatureza in 'ANovaNatureza.pas' {FNovaNatureza},
  UnProdutos in '..\MEstoque\UnProdutos.pas',
  UnCodigoBarra in '..\MConfiguracoesSistema\UnCodigoBarra.pas',
  AAdicionaProdFilial in '..\MEstoque\AAdicionaProdFilial.pas' {FAdicionaProdFilial},
  APlanoConta in '..\MFinanceiro\APlanoConta.pas' {FPlanoConta},
  ANovoPlanoConta in '..\MFinanceiro\ANovoPlanoConta.pas' {FNovoPlanoConta},
  ACadIcmsEstado in 'ACadIcmsEstado.pas' {FCadIcmsEstado},
  CadFormularios in '..\MConfiguracoesSistema\CadFormularios.pas' {FCadFormularios},
  AProfissoes in '..\MaGerais\AProfissoes.pas' {FProfissoes},
  UnSumarizaEstoque in '..\MEstoque\UnSumarizaEstoque.pas',
  AFormacaoPreco in '..\MEstoque\AFormacaoPreco.pas' {FFormacaoPreco},
  ATabelaPreco in '..\MEstoque\ATabelaPreco.pas' {FTabelaPreco},
  UnNotaFiscal in 'UnNotaFiscal.pas',
  ALocalizaProdutos in 'ALocalizaProdutos.pas' {FlocalizaProduto},
  ALocalizaClassificacao in '..\MEstoque\ALocalizaClassificacao.pas' {FLocalizaClassificacao},
  AManutencaoNotas in 'AManutencaoNotas.pas' {FManutencaoNotas},
  ADemosntrativoFaturamento in 'ADemosntrativoFaturamento.pas' {FDemonstrativoFaturamento},
  UnClassificacao in '..\MEstoque\UnClassificacao.pas',
  UnImpressao in '..\MaGerais\UnImpressao.pas',
  UnClassesImprimir in '..\MaGerais\UnClassesImprimir.pas',
  AConsultaCondicaoPgto in '..\MaGerais\AConsultaCondicaoPgto.pas' {FConsultaCondicaoPgto},
  AFormasPagamento in '..\MFinanceiro\AFormasPagamento.pas' {FFormasPagamento},
  ANovoServico in '..\MEstoque\ANovoServico.pas' {FNovoServico},
  UnComissoes in '..\MFinanceiro\UnComissoes.pas',
  UnContasAReceber in '..\MFinanceiro\UnContasAReceber.pas',
  UnServicos in '..\MEstoque\UnServicos.pas',
  UnMoedas in '..\MConfiguracoesSistema\UnMoedas.pas',
  AImprimeBoleto in '..\MFinanceiro\AImprimeBoleto.pas' {FImprimeBoleto},
  UnContasAPagar in '..\MFinanceiro\UnContasAPagar.pas',
  AMostraRecibo in '..\MaGerais\AMostraRecibo.pas' {FMostraRecibo},
  AMostraDuplicata in '..\MaGerais\AMostraDuplicata.pas' {FMostraDuplicata},
  AMostraBoleto in '..\MaGerais\AMostraBoleto.pas' {FMostraBoleto},
  AImprimeDuplicata in '..\MFinanceiro\AImprimeDuplicata.pas' {FImprimeDuplicata},
  AConsultaPrecosProdutos in '..\MPontaLoja\AConsultaPrecosProdutos.pas' {FConsultaPrecosProdutos},
  UnCotacao in '..\MPontaLoja\UnCotacao.pas',
  ANovaCotacao in '..\MPontaLoja\ANovaCotacao.pas' {FNovaCotacao},
  ANovoVendedor in '..\MaGerais\ANovoVendedor.pas' {FNovoVendedor},
  AVendedores in '..\MaGerais\AVendedores.pas' {FVendedores},
  ALocalizaServico in 'ALocalizaServico.pas' {FlocalizaServico},
  AMostraEnvelope in '..\MaGerais\AMostraEnvelope.pas' {FMostraEnvelope},
  ABancos in '..\MFinanceiro\ABancos.pas' {FBancos},
  UnAtualizacao in '..\MaGerais\UnAtualizacao.pas',
  AContas in '..\MFinanceiro\AContas.pas' {FContas},
  UnPrincipal in '..\MaGerais\UnPrincipal.pas',
  ARegiaoVenda in '..\MaGerais\ARegiaoVenda.pas' {FRegiaoVenda},
  AItensNatureza in 'AItensNatureza.pas' {FItensNatureza},
  AMovNatureza in 'AMovNatureza.pas' {FMovNatureza},
  UnComandosImpCheque in '..\MaGerais\UnComandosImpCheque.pas',
  UnEDI in 'UnEDI.pas',
  UnDados in '..\magerais\UnDados.pas',
  ATipoFundo in '..\mestoque\ATipoFundo.pas' {FTipoFundo},
  ATipoEmenda in '..\mestoque\ATipoEmenda.pas' {FTipoEmenda},
  AMaquinas in '..\mestoque\AMaquinas.pas' {FMaquinas},
  UnClientes in '..\magerais\UnClientes.pas',
  ACores in '..\mestoque\ACores.pas' {FCores},
  ACotacao in '..\mpontaloja\ACotacao.pas' {FCotacao},
  AMostraParReceberOO in '..\mfinanceiro\AMostraParReceberOO.pas' {FMostraParReceberOO},
  UnVendedor in '..\magerais\UnVendedor.pas',
  ATipoCotacao in '..\mpontaloja\ATipoCotacao.pas' {FTipoCotacao},
  UnSistema in '..\magerais\UnSistema.pas',
  UnImpressaoRelatorio in '..\magerais\UnImpressaoRelatorio.pas',
  ARelPedido in '..\mpontaloja\ARelPedido.pas' {FRelPedido},
  ARamoAtividade in '..\mpontaloja\ARamoAtividade.pas' {FRamoAtividade},
  UnImpressaoBoleto in '..\magerais\UnImpressaoBoleto.pas',
  AEmbalagem in '..\mpontaloja\AEmbalagem.pas' {FEmbalagem},
  AImprimeEtiqueta in '..\mpontaloja\AImprimeEtiqueta.pas' {FImprimiEtiqueta},
  UnImpressaoEtiquetaCotacao in '..\mpontaloja\UnImpressaoEtiquetaCotacao.pas',
  AProdutoReferencia in '..\mpontaloja\AProdutoReferencia.pas' {FReferenciaProduto},
  UnDadosCR in '..\mfinanceiro\UnDadosCR.pas',
  UnDadosProduto in '..\mestoque\UnDadosProduto.pas',
  AGeraOP in '..\mpontaloja\AGeraOP.pas' {FGerarOP},
  UnOrdemProducao in '..\mestoque\UnOrdemProducao.pas',
  ANovaOrdemProducaoCadarco in '..\mestoque\ANovaOrdemProducaoCadarco.pas' {FNovaOrdemProducaoCadarco},
  AProdutosDevolvidos in '..\mpontaloja\AProdutosDevolvidos.pas' {FProdutosDevolvidos},
  ANovaNotaFiscalNota in 'ANovaNotaFiscalNota.pas' {FNovaNotaFiscalNota},
  AMostraObservacaoCliente in '..\mpontaloja\AMostraObservacaoCliente.pas' {FMostraObservacaoCliente},
  ANovaNotaFiscaisFor in '..\mestoque\ANovaNotaFiscaisFor.pas' {FNovaNotaFiscaisFor},
  UnNotasFiscaisFor in '..\mestoque\UnNotasFiscaisFor.pas',
  ABaixaParcialCotacao in '..\mpontaloja\ABaixaParcialCotacao.pas' {FBaixaParcialCotacao},
  AConsultaBaixaParcial in '..\mpontaloja\AConsultaBaixaParcial.pas' {FConsultaBaixaParcial},
  AValidaSerieSistema in '..\..\modulos\AValidaSerieSistema.pas' {FValidaSerieSistema},
  AGeraArquivosFiscais in 'AGeraArquivosFiscais.pas' {FGeraArquivosFiscais},
  UnCrystal in '..\magerais\UnCrystal.pas',
  AImportaMunicipios in 'AImportaMunicipios.pas' {FImportaMunicipios},
  AMostraCriticaFiscal in 'AMostraCriticaFiscal.pas' {FMostraCriticaFiscal},
  AAliquotaFiscal in 'AAliquotaFiscal.pas' {FAliquotaFiscal},
  ANovoECF in '..\mpontaloja\ANovoECF.pas' {FNovoECF},
  UnECF in '..\mpontaloja\UnECF.pas',
  AFormaPagamentoECF in '..\mpontaloja\AFormaPagamentoECF.pas' {FFormaPagamentoECF},
  AEstagioProducao in '..\mestoque\AEstagioProducao.pas' {FEstagioProducao},
  ATipoEstagioProducao in '..\mestoque\ATipoEstagioProducao.pas' {FTipoEstagioProducao},
  AGeraEstagiosOP in '..\mpontaloja\AGeraEstagiosOP.pas' {FGeraEstagiosOP},
  UnExportacaoFiscal in 'UnExportacaoFiscal.pas',
  AVisualizaLogs in '..\magerais\AVisualizaLogs.pas' {FVisualizaLogs},
  AOrdensProducaoCadarco in '..\mestoque\AOrdensProducaoCadarco.pas' {FOrdensProducaoCadarco},
  ATecnicos in '..\mpontaloja\ATecnicos.pas' {FTecnicos},
  ANovoTecnico in '..\mpontaloja\ANovoTecnico.pas' {FNovoTecnico},
  ATipoCorte in '..\mestoque\ATipoCorte.pas' {FTipoCorte},
  ANovaCobranca in '..\mfinanceiro\ANovaCobranca.pas' {FNovaCobranca},
  ACobrancas in '..\mfinanceiro\ACobrancas.pas' {FCobrancas},
  AHistoricoLigacao in '..\mfinanceiro\AHistoricoLigacao.pas' {FHistoricoLigacao},
  AMotivoInadimplencia in '..\mfinanceiro\AMotivoInadimplencia.pas' {FMotivoInadimplencia},
  ANovaConta in '..\mfinanceiro\ANovaConta.pas' {FNovaConta},
  AContratosCliente in '..\mpontaloja\AContratosCliente.pas' {FContratosCliente},
  UnContrato in '..\mpontaloja\UnContrato.pas',
  ANovoContratoCliente in '..\mpontaloja\ANovoContratoCliente.pas' {FNovoContratoCliente},
  ATipoContrato in '..\mpontaloja\ATipoContrato.pas' {FTipoContrato},
  AAlteraVendedorCotacao in '..\mpontaloja\AAlteraVendedorCotacao.pas' {FAlteraVendedorCotacao},
  ABrindesCliente in '..\mpontaloja\ABrindesCliente.pas' {FBrindesCliente},
  ANovoTeleMarketing in '..\mpontaloja\ANovoTeleMarketing.pas' {FNovoTeleMarketing},
  UnTeleMarketing in '..\mpontaloja\UnTeleMarketing.pas',
  AProdutosCliente in '..\mpontaloja\AProdutosCliente.pas' {FProdutosCliente},
  ATeleMarketings in '..\mpontaloja\ATeleMarketings.pas' {FTeleMarketings},
  ATipoAgendamento in '..\mpontaloja\ATipoAgendamento.pas' {FTipoAgendamento},
  ANovoAgendamento in '..\mpontaloja\ANovoAgendamento.pas' {FNovoAgedamento},
  UnDaruma in '..\mpontaloja\UnDaruma.pas',
  ADonoProduto in '..\mpontaloja\ADonoProduto.pas' {FDonoProduto},
  AAcondicionamento in '..\mpontaloja\AAcondicionamento.pas' {FAcondicionamento},
  AGeraFracaoOP in '..\mpontaloja\AGeraFracaoOP.pas' {FGeraFracaoOP},
  AParentesCliente in '..\mpontaloja\AParentesCliente.pas' {FParentesClientes},
  UnChamado in '..\MChamado\UnChamado.pas',
  ANovoChamadoTecnico in '..\MChamado\ANovoChamadoTecnico.pas' {FNovoChamado},
  AOrdemProducaoGenerica in '..\mestoque\AOrdemProducaoGenerica.pas' {FOrdemProducaoGenerica},
  ANovaOrdemProducaoGenerica in '..\mestoque\ANovaOrdemProducaoGenerica.pas' {FNovaOrdemProducaoGenerica},
  AAlteraEstagioCotacao in '..\mpontaloja\AAlteraEstagioCotacao.pas' {FAlteraEstagioCotacao},
  AAlteraEstagioChamado in '..\mpontaloja\AAlteraEstagioChamado.pas' {FAlteraEstagioChamado},
  AHistoricoECobranca in '..\mfinanceiro\AHistoricoECobranca.pas' {FHistoricoECobranca},
  ALocalizaProdutoContrato in '..\MChamado\ALocalizaProdutoContrato.pas' {FLocalizaProdutoContrato},
  AChamadosTecnicos in '..\MChamado\AChamadosTecnicos.pas' {FChamadoTecnico},
  AVisualizaEstatisticaConsulta in 'AVisualizaEstatisticaConsulta.pas' {FVisualizaEstatisticaConsulta},
  AHoraAgendaChamado in '..\MChamado\AHoraAgendaChamado.pas' {FHoraAgendaChamado},
  AAgendaChamados in '..\MChamado\AAgendaChamados.pas' {FAgendaChamados},
  UnPesquisaSatisfacao in '..\MChamado\UnPesquisaSatisfacao.pas',
  AEfetuarPesquisaSatisfacao in '..\MChamado\AEfetuarPesquisaSatisfacao.pas' {FEfetuarPesquisaSatisfacao},
  AMedico in '..\mpontaloja\AMedico.pas' {FMedico},
  AContatosCliente in '..\mpontaloja\AContatosCliente.pas' {FContatosCliente},
  AProdutosReserva in '..\mpontaloja\AProdutosReserva.pas' {FProdutosReserva},
  UnArgox in '..\magerais\UnArgox.pas',
  AConsultacheques in '..\mfinanceiro\AConsultacheques.pas' {FConsultaCheques},
  AChequesCP in '..\mfinanceiro\AChequesCP.pas' {FChequesCP},
  ANovaMaquina in '..\mestoque\ANovaMaquina.pas' {FNovaMaquina},
  APedidosPendentesFaturar in '..\mpontaloja\APedidosPendentesFaturar.pas' {FPedidosPendentesFaturar},
  UnProspect in '..\mcrm\UnProspect.pas',
  ATamanhos in '..\mpontaloja\ATamanhos.pas' {FTamanhos},
  AContasAReceber in '..\mfinanceiro\AContasAReceber.pas' {FContasaReceber},
  ANovoContasaReceber in '..\mfinanceiro\ANovoContasaReceber.pas' {FNovoContasAReceber},
  agraficoscontasareceber in '..\mfinanceiro\agraficoscontasareceber.pas' {FGraficosCR},
  AGraficosContasaPagar in '..\mfinanceiro\AGraficosContasaPagar.pas' {FGraficosCP},
  AManutencaoCR in '..\mfinanceiro\AManutencaoCR.pas' {FManutencaoCR},
  AMovComissoes in '..\mfinanceiro\AMovComissoes.pas' {FMovComissoes},
  AContasAConsolidarCR in '..\mfinanceiro\AContasAConsolidarCR.pas' {FContasAConsolidarCR},
  AConsolidarCR in '..\mfinanceiro\AConsolidarCR.pas' {FConsolidarCR},
  AVisualizaLogReceber in '..\mfinanceiro\AVisualizaLogReceber.pas' {FVisualizaLogReceber},
  AComissaoClassificacaoVendedor in '..\mestoque\AComissaoClassificacaoVendedor.pas' {FComissaoClassificacaoVendedor},
  AProdutosOrcados in '..\MChamado\AProdutosOrcados.pas' {FProdutosOrcados},
  UnVersoes in '..\magerais\UnVersoes.pas',
  ANovoConcorrente in '..\mcrm\ANovoConcorrente.pas' {FNovoConcorrente},
  AConcorrentes in '..\mcrm\AConcorrentes.pas' {FConcorrentes},
  AContatosProspect in '..\mcrm\AContatosProspect.pas' {FContatosProspect},
  AMeioDivulgacao in '..\mcrm\AMeioDivulgacao.pas' {FMeioDivulgacao},
  AMotivoVenda in '..\mcrm\AMotivoVenda.pas' {FMotivoVenda},
  ANovaProposta in '..\mcrm\ANovaProposta.pas' {FNovaProposta},
  ANovoTelemarketingProspect in '..\mcrm\ANovoTelemarketingProspect.pas' {FNovoTelemarketingProspect},
  AProspects in '..\mcrm\AProspects.pas' {FProspects},
  UnProposta in '..\mcrm\UnProposta.pas',
  ANovoProspect in '..\mcrm\ANovoProspect.pas' {FNovoProspect},
  ANovaAgendaProspect in '..\mcrm\ANovaAgendaProspect.pas' {FNovaAgendaProspect},
  AProdutosProspect in '..\mcrm\AProdutosProspect.pas' {FProdutosProspect},
  AAlteraEstagioProposta in '..\mcrm\AAlteraEstagioProposta.pas' {FAlteraEstagioProposta},
  UnAmostra in '..\mcrm\UnAmostra.pas',
  ABaixaContasAReceberOO in '..\mfinanceiro\ABaixaContasAReceberOO.pas' {FBaixaContasaReceberOO},
  ANovoPedidoCompra in '..\mestoque\ANovoPedidoCompra.pas' {FNovoPedidoCompra},
  UnPedidoCompra in '..\mestoque\UnPedidoCompra.pas',
  UnSolicitacaoCompra in '..\mestoque\UnSolicitacaoCompra.pas',
  APedidosCompraAberto in '..\mestoque\APedidosCompraAberto.pas' {FPedidosCompraAberto},
  ACompradores in '..\mestoque\ACompradores.pas' {FCompradores},
  ABaixaContasaPagarOO in '..\mfinanceiro\ABaixaContasaPagarOO.pas' {FBaixaContasaPagarOO},
  AChequesOO in '..\mfinanceiro\AChequesOO.pas' {FChequesOO},
  UnLembrete in '..\mpontaloja\UnLembrete.pas',
  ANovoLembrete in '..\mpontaloja\ANovoLembrete.pas' {FNovoLembrete},
  ASelecionarUsuarios in '..\mpontaloja\ASelecionarUsuarios.pas' {FSelecionarUsuarios},
  AVerificaLeituraLembrete in '..\MChamado\AVerificaLeituraLembrete.pas' {FVerificaLeituraLembrete},
  ANovoEmailContasAReceber in '..\mfinanceiro\ANovoEmailContasAReceber.pas' {FNovoEmailContasAReceber},
  undespesas in '..\mfinanceiro\undespesas.pas',
  ACentroCusto in '..\mfinanceiro\ACentroCusto.pas' {FCentroCusto},
  AContasAPagar in '..\mfinanceiro\AContasAPagar.pas' {FContasaPagar},
  ageradespesasfixas in '..\mfinanceiro\ageradespesasfixas.pas' {FGeraDespesasFixas},
  AManutencaoCP in '..\mfinanceiro\AManutencaoCP.pas' {FManutencaoCP},
  ANovoContasaPagar in '..\mfinanceiro\ANovoContasaPagar.pas' {FNovoContasAPagar},
  adespesas in '..\mfinanceiro\adespesas.pas' {FDespesas},
  UnCaixa in '..\mcaixa\UnCaixa.pas',
  AGerarFracaoOPMaquinasCorte in '..\mpontaloja\AGerarFracaoOPMaquinasCorte.pas' {FGerarFracaoOPMaquinasCorte},
  ABaixaConsumoProduto in '..\mestoque\ABaixaConsumoProduto.pas' {FBaixaConsumoProduto},
  ATipoChamado in '..\MChamado\ATipoChamado.pas' {FTipoChamado},
  ASetores in '..\mcrm\ASetores.pas' {FSetores},
  AAlteraEstagioPedidoCompra in '..\mestoque\AAlteraEstagioPedidoCompra.pas' {FAlteraEstagioPedidoCompra},
  ANovoSetor in '..\mcrm\ANovoSetor.pas' {FNovoSetor},
  AMostraParPagarOO in '..\mfinanceiro\AMostraParPagarOO.pas' {FMostraParPagarOO},
  ASolicitacaoCompras in '..\mestoque\ASolicitacaoCompras.pas' {FSolicitacaoCompra},
  ANovaSolicitacaoCompra in '..\mestoque\ANovaSolicitacaoCompra.pas' {FNovaSolicitacaoCompras},
  AAlteraEstagioOrcamento in '..\mestoque\AAlteraEstagioOrcamento.pas' {FAlteraEstagioOrcamentoCompra},
  APedidoCompra in '..\mestoque\APedidoCompra.pas' {FPedidoCompra},
  ATipoProposta in '..\mcrm\ATipoProposta.pas' {FTipoProposta},
  UnZebra in '..\magerais\UnZebra.pas',
  APropostasCliente in '..\mcrm\APropostasCliente.pas' {FPropostasCliente},
  ARelOrdemSerra in '..\mestoque\ARelOrdemSerra.pas' {FRelOrdemSerra},
  ACompensaCheque in '..\mfinanceiro\ACompensaCheque.pas' {FCompensaCheque},
  AMontaKitBastidor in '..\mestoque\AMontaKitBastidor.pas' {FMontaKitBastidor},
  ABaixaProdutosChamado in '..\MChamado\ABaixaProdutosChamado.pas' {FBaixaProdutosChamado},
  AConsultaChamadoParcial in '..\MChamado\AConsultaChamadoParcial.pas' {FConsultaChamadoParcial},
  ACreditoCliente in '..\mfinanceiro\ACreditoCliente.pas' {FCreditoCliente},
  AAlteraEstagioFracaoOP in '..\mestoque\AAlteraEstagioFracaoOP.pas' {FAlteraEstagioFracaoOP},
  ASolicitacaoCompraProdutosPendentes in '..\mestoque\ASolicitacaoCompraProdutosPendentes.pas' {FSolicitacaoCompraProdutosPendentes},
  ANovoOrcamentoCompra in '..\mestoque\ANovoOrcamentoCompra.pas' {FNovoOrcamentoCompra},
  UnOrcamentoCompra in '..\mestoque\UnOrcamentoCompra.pas',
  AHorarioTrabalho in '..\mestoque\AHorarioTrabalho.pas' {FHorarioTrabalho},
  unEMarketing in '..\mpontaloja\unEMarketing.pas',
  AFaixaEtaria in '..\mpontaloja\AFaixaEtaria.pas' {FFaixaEtaria},
  AMarcas in '..\mpontaloja\AMarcas.pas' {FMarca},
  AAlteraEstagioAgendamento in '..\mpontaloja\AAlteraEstagioAgendamento.pas' {FAlteraEstagioAgendamento},
  AAgendamentos in '..\mpontaloja\AAgendamentos.pas' {FAgendamentos},
  AMetasVendedor in '..\mpontaloja\AMetasVendedor.pas' {FMetasVendedor},
  AConsultaLogSeparacaoConsumo in '..\mestoque\AConsultaLogSeparacaoConsumo.pas' {FConsultaLogSeparacaoConsumo},
  UnRave in '..\magerais\UnRave.pas',
  dmRave in '..\magerais\dmRave.pas' {dtRave: TDSServerModule},
  UnNFe in 'UnNFe.pas',
  ANovaComposicao in '..\mestoque\ANovaComposicao.pas' {FNovaComposicao},
  AComposicoes in '..\mestoque\AComposicoes.pas' {FComposicoes},
  AHigienizarCadastros in 'AHigienizarCadastros.pas' {FHigienizarCadastros},
  ANovaCondicaoPagamento in '..\mpontaloja\ANovaCondicaoPagamento.pas' {FNovaCondicaoPagamento},
  ACondicaoPagamento in '..\mpontaloja\ACondicaoPagamento.pas' {FCondicaoPagamento},
  UnCondicaoPagamento in '..\mfinanceiro\UnCondicaoPagamento.pas',
  AProjetos in '..\mfinanceiro\AProjetos.pas' {FProjetos},
  ASpedFiscal in 'ASpedFiscal.pas' {FSpedFiscal},
  UnSpedFiscal in 'UnSpedFiscal.pas',
  AGeraFracaoOPProdutos in '..\mestoque\AGeraFracaoOPProdutos.pas' {FGeraFracaoOPProdutos},
  ACorpoEmailProposta in '..\mcrm\ACorpoEmailProposta.pas' {FCorpoEmailProposta},
  AMostraEstoqueChapas in '..\mestoque\AMostraEstoqueChapas.pas' {FMostraEstoqueChapas},
  UnDRave in '..\magerais\UnDRave.pas',
  UnProgramador1 in '..\magerais\UnProgramador1.pas',
  AAcessorio in '..\mestoque\AAcessorio.pas' {FAcessorio},
  AAplicacao in '..\mcrm\AAplicacao.pas' {FAplicacao},
  AAdicionaProdutosTerceirizacao in '..\mestoque\AAdicionaProdutosTerceirizacao.pas' {FAdicionaProdutosTerceirizacao},
  ALocalizaFracaoOP in '..\mestoque\ALocalizaFracaoOP.pas' {FLocalizaFracaoOP},
  ANovoEstagio in '..\mestoque\ANovoEstagio.pas' {FNovoEstagio},
  ACorrigeNotasSpedFiscal in 'ACorrigeNotasSpedFiscal.pas' {FCorrigeNotasSpedFiscal},
  AOrcamentoCompras in '..\mestoque\AOrcamentoCompras.pas' {FOrcamentoCompras},
  ASelecionarFornecedorMapaCompras in '..\mestoque\ASelecionarFornecedorMapaCompras.pas' {FSelecionaFornecedorMapaCompras},
  AMapaCompras in '..\mestoque\AMapaCompras.pas' {FMapaCompras},
  AOPProdutosAReservar in '..\mestoque\AOPProdutosAReservar.pas' {FOPProdutosAReservar},
  AMenuFiscalECF in '..\mefiPDV\AMenuFiscalECF.pas' {FMenuFiscalECF},
  AComandoFiscalFiltro in '..\mefiPDV\AComandoFiscalFiltro.pas' {FComandoFiscalFiltro},
  AExportaNfeContabilidade in 'AExportaNfeContabilidade.pas' {FExportanfeContabilidade},
  ATipoMateriaPrima in '..\mcrm\ATipoMateriaPrima.pas' {FTipoMateriaPrima},
  AFacas in '..\mestoque\AFacas.pas' {FFacas},
  AMostraObservacaoPedido in '..\mpontaloja\AMostraObservacaoPedido.pas' {FMostraObservacaoPedido},
  AProdutosClientePeca in '..\mpontaloja\AProdutosClientePeca.pas' {FProdutosClientePeca},
  ATelefonesCliente in '..\mpontaloja\ATelefonesCliente.pas' {FTelefoneCliente},
  AReciboLocacao in '..\mpontaloja\AReciboLocacao.pas' {FReciboLocacao},
  AExportaRPS in 'AExportaRPS.pas' {FExportaRPS},
  UnExportaRPS in 'UnExportaRPS.pas',
  AConhecimentoTransporte in '..\mestoque\AConhecimentoTransporte.pas' {FConhecimentoTransporte},
  ANovoProdutoPro in '..\mestoque\ANovoProdutoPro.pas' {FNovoProdutoPro},
  AFaccionistas in '..\mestoque\AFaccionistas.pas' {FFaccionistas},
  AFracaoFaccionista in '..\mestoque\AFracaoFaccionista.pas' {FFracaoFaccionista},
  ANovaFaccionista in '..\mestoque\ANovaFaccionista.pas' {FNovaFaccionista},
  ANovaFracaoFaccionista in '..\mestoque\ANovaFracaoFaccionista.pas' {FNovaFracaoFaccionista},
  ARetornoFracaoFaccionista in '..\mestoque\ARetornoFracaoFaccionista.pas' {FRetornoFracaoFaccionista},
  ATerceiroFaccionista in '..\mestoque\ATerceiroFaccionista.pas' {FTerceiroFaccionista};

{$R *.RES}

begin
//  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
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
    if Sistema.ValidaSerieSistema then
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
  end;
end.


