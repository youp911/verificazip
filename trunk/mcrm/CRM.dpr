program CRM;


uses
  Forms,
  SysUtils,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  Constantes in '..\MConfiguracoesSistema\Constantes.pas',
  ASobre in '..\MaGerais\ASobre.pas' {FSobre},
  Abertura in '..\MaGerais\Abertura.pas' {FAbertura},
  AAlterarSenha in '..\MaGerais\AAlterarSenha.pas' {FAlteraSenha},
  AAlterarFilialUso in '..\MaGerais\AAlterarFilialUso.pas' {FAlterarFilialUso},
  UnRegistro in '..\MConfiguraModulos\UnRegistro.pas',
  AClientes in '..\MaGerais\AClientes.pas' {FClientes},
  ANovoCliente in '..\MaGerais\ANovoCliente.pas' {FNovoCliente},
  AProfissoes in '..\MaGerais\AProfissoes.pas' {FProfissoes},
  ASituacoesClientes in '..\MaGerais\ASituacoesClientes.pas' {FSituacoesClientes},
  AConsultaRuas in '..\MaGerais\AConsultaRuas.pas' {FConsultaRuas},
  ACadCidades in '..\MaGerais\ACadCidades.pas' {FCidades},
  ACadPaises in '..\MaGerais\ACadPaises.pas' {FCadPaises},
  ACadEstados in '..\MaGerais\ACadEstados.pas' {FCadEstados},
  AEventos in '..\MaGerais\AEventos.pas' {FEventos},
  ATransportadoras in '..\MaGerais\ATransportadoras.pas' {FTransportadoras},
  ANovaTransportadora in '..\MaGerais\ANovaTransportadora.pas' {FNovaTransportadora},
  UnCodigoBarra in '..\MConfiguracoesSistema\UnCodigoBarra.pas',
  UnMoedas in '..\MConfiguracoesSistema\UnMoedas.pas',
  CadFormularios in '..\MConfiguracoesSistema\CadFormularios.pas' {FCadFormularios},
  AConsultaPrecosProdutos in '..\mpontaloja\AConsultaPrecosProdutos.pas' {FConsultaPrecosProdutos},
  AProdutosKit in '..\MEstoque\AProdutosKit.pas' {FProdutosKit},
  UnCotacao in '..\mpontaloja\UnCotacao.pas',
  UnProdutos in '..\MEstoque\UnProdutos.pas',
  UnSumarizaEstoque in '..\MEstoque\UnSumarizaEstoque.pas',
  AProdutos in '..\MEstoque\AProdutos.pas' {Fprodutos},
  ANovaClassificacao in '..\MEstoque\ANovaClassificacao.pas' {FNovaClassificacao},
  AMontaKit in '..\MEstoque\AMontaKit.pas' {FMontaKit},
  ALocalizaClassificacao in '..\MEstoque\ALocalizaClassificacao.pas' {FLocalizaClassificacao},
  ANovoVendedor in '..\MaGerais\ANovoVendedor.pas' {FNovoVendedor},
  AVendedores in '..\MaGerais\AVendedores.pas' {FVendedores},
  ACondicoesPgtos in '..\MFinanceiro\ACondicoesPgtos.pas' {FCondicoesPagamentos},
  UnClassificacao in '..\MEstoque\UnClassificacao.pas',
  ACotacao in '..\mpontaloja\ACotacao.pas' {FCotacao},
  AConsultaCondicaoPgto in '..\MaGerais\AConsultaCondicaoPgto.pas' {FConsultaCondicaoPgto},
  AFormasPagamento in '..\MFinanceiro\AFormasPagamento.pas' {FFormasPagamento},
  AImpCotacao in '..\mpontaloja\AImpCotacao.pas' {FImpOrcamento},
  ALocalizaProdutos in '..\MFaturamento\ALocalizaProdutos.pas' {FlocalizaProduto},
  ANovoServico in '..\MEstoque\ANovoServico.pas' {FNovoServico},
  ALocalizaServico in '..\MFaturamento\ALocalizaServico.pas' {FlocalizaServico},
  UnServicos in '..\MEstoque\UnServicos.pas',
  AAdicionaProdFilial in '..\MEstoque\AAdicionaProdFilial.pas' {FAdicionaProdFilial},
  ATabelaPreco in '..\MEstoque\ATabelaPreco.pas' {FTabelaPreco},
  AFormacaoPreco in '..\MEstoque\AFormacaoPreco.pas' {FFormacaoPreco},
  AImprimeTabela in '..\MEstoque\AImprimeTabela.pas' {FImprimeTabela},
  AServicos in '..\MEstoque\AServicos.pas' {FServicos},
  AFormacaoPrecoServico in '..\MEstoque\AFormacaoPrecoServico.pas' {FFormacaoPrecoServico},
  AImpTabelaServico in '..\MEstoque\AImpTabelaServico.pas' {FImpTabelaServico},
  UnNotaFiscal in '..\MFaturamento\UnNotaFiscal.pas',
  UnComissoes in '..\MFinanceiro\UnComissoes.pas',
  UnContasAReceber in '..\MFinanceiro\UnContasAReceber.pas',
  UnImpressao in '..\MaGerais\UnImpressao.pas',
  UnClassesImprimir in '..\MaGerais\UnClassesImprimir.pas',
  ANovaNatureza in '..\MFaturamento\ANovaNatureza.pas' {FNovaNatureza},
  ANaturezas in '..\MFaturamento\ANaturezas.pas' {FNaturezas},
  AOperacoesEstoques in '..\MEstoque\AOperacoesEstoques.pas' {FOperacoesEstoques},
  APlanoConta in '..\MFinanceiro\APlanoConta.pas' {FPlanoConta},
  ANovoPlanoConta in '..\MFinanceiro\ANovoPlanoConta.pas' {FNovoPlanoConta},
  AObservacoesNota in '..\MFaturamento\AObservacoesNota.pas' {FObservacoesNota},
  AMostraCheque in '..\MaGerais\AMostraCheque.pas' {FMostraCheque},
  UnContasAPagar in '..\MFinanceiro\UnContasAPagar.pas',
  ABancos in '..\MFinanceiro\ABancos.pas' {FBancos},
  UnAtualizacao in '..\MaGerais\UnAtualizacao.pas',
  AContas in '..\MFinanceiro\AContas.pas' {FContas},
  UnPrincipal in '..\MaGerais\UnPrincipal.pas',
  ARegiaoVenda in '..\MaGerais\ARegiaoVenda.pas' {FRegiaoVenda},
  AMovNatureza in '..\MFaturamento\AMovNatureza.pas' {FMovNatureza},
  AItensNatureza in '..\MFaturamento\AItensNatureza.pas' {FItensNatureza},
  AUnidade in '..\MEstoque\AUnidade.pas' {FUnidades},
  ABackup in '..\MaGerais\ABackup.pas' {FBackup},
  AImprimeEtiquetaBarra in '..\MEstoque\AImprimeEtiquetaBarra.pas' {FImprimeEtiquetaBarra},
  UnComandosImpCheque in '..\MaGerais\UnComandosImpCheque.pas',
  AEtiquetaCliente in '..\MaGerais\AEtiquetaCliente.pas' {FEtiquetaClientes},
  AImpProduto in '..\mestoque\AImpProduto.pas' {FImpProduto},
  ATipoFundo in '..\mestoque\ATipoFundo.pas' {FTipoFundo},
  UnDados in '..\magerais\UnDados.pas',
  ATipoEmenda in '..\mestoque\ATipoEmenda.pas' {FTipoEmenda},
  AMaquinas in '..\mestoque\AMaquinas.pas' {FMaquinas},
  UnClientes in '..\magerais\UnClientes.pas',
  ACores in '..\mestoque\ACores.pas' {FCores},
  ANovaCotacao in '..\mpontaloja\ANovaCotacao.pas' {FNovaCotacao},
  AMostraParReceberOO in '..\mfinanceiro\AMostraParReceberOO.pas' {FMostraParReceberOO},
  UnVendedor in '..\magerais\UnVendedor.pas',
  ATipoCotacao in '..\mpontaloja\ATipoCotacao.pas' {FTipoCotacao},
  UnSistema in '..\magerais\UnSistema.pas',
  ARamoAtividade in '..\mpontaloja\ARamoAtividade.pas' {FRamoAtividade},
  UnImpressaoRelatorio in '..\magerais\UnImpressaoRelatorio.pas',
  ARelPedido in '..\mpontaloja\ARelPedido.pas' {FRelPedido},
  UnImpressaoBoleto in '..\magerais\UnImpressaoBoleto.pas',
  AEmbalagem in '..\mpontaloja\AEmbalagem.pas' {FEmbalagem},
  AImprimeEtiqueta in '..\mpontaloja\AImprimeEtiqueta.pas' {FImprimiEtiqueta},
  UnImpressaoEtiquetaCotacao in '..\mpontaloja\UnImpressaoEtiquetaCotacao.pas',
  AProdutoReferencia in '..\mpontaloja\AProdutoReferencia.pas' {FReferenciaProduto},
  UnDadosCR in '..\mfinanceiro\UnDadosCR.pas',
  UnDadosProduto in '..\mestoque\UnDadosProduto.pas',
  AGeraOP in '..\mpontaloja\AGeraOP.pas' {FGerarOP},
  ANovaOrdemProducaoCadarco in '..\mestoque\ANovaOrdemProducaoCadarco.pas' {FNovaOrdemProducaoCadarco},
  UnOrdemProducao in '..\mestoque\UnOrdemProducao.pas',
  AImpOrdemProducao in '..\mestoque\AImpOrdemProducao.pas' {FImpOrdemProducao},
  AProdutosDevolvidos in '..\mpontaloja\AProdutosDevolvidos.pas' {FProdutosDevolvidos},
  ANovaNotaFiscalNota in '..\mfaturamento\ANovaNotaFiscalNota.pas' {FNovaNotaFiscalNota},
  AMostraObservacaoCliente in '..\mpontaloja\AMostraObservacaoCliente.pas' {FMostraObservacaoCliente},
  ANovaNotaFiscaisFor in '..\mestoque\ANovaNotaFiscaisFor.pas' {FNovaNotaFiscaisFor},
  UnNotasFiscaisFor in '..\mestoque\UnNotasFiscaisFor.pas',
  ABaixaParcialCotacao in '..\mpontaloja\ABaixaParcialCotacao.pas' {FBaixaParcialCotacao},
  AConsultaBaixaParcial in '..\mpontaloja\AConsultaBaixaParcial.pas' {FConsultaBaixaParcial},
  AValidaSerieSistema in '..\..\modulos\AValidaSerieSistema.pas' {FValidaSerieSistema},
  AAlteraClassificacaoProduto in '..\mpontaloja\AAlteraClassificacaoProduto.pas' {FAlteraClassificacaoProduto},
  UnCrystal in '..\magerais\UnCrystal.pas',
  ANovoECF in '..\mpontaloja\ANovoECF.pas' {FNovoECF},
  UnECF in '..\mpontaloja\UnECF.pas',
  UnBematech in '..\mpontaloja\UnBematech.pas',
  AFormaPagamentoECF in '..\mpontaloja\AFormaPagamentoECF.pas' {FFormaPagamentoECF},
  ATipoEstagioProducao in '..\mestoque\ATipoEstagioProducao.pas' {FTipoEstagioProducao},
  AGeraEstagiosOP in '..\mpontaloja\AGeraEstagiosOP.pas' {FGeraEstagiosOP},
  AMostraPlanenamentoOP in '..\mpontaloja\AMostraPlanenamentoOP.pas' {FMostraPlanejamentoOP},
  UnPcp in '..\mestoque\UnPcp.pas',
  AAlteraEstagioCotacao in '..\mpontaloja\AAlteraEstagioCotacao.pas' {FAlteraEstagioCotacao},
  AOrdensProducaoCadarco in '..\mestoque\AOrdensProducaoCadarco.pas' {FOrdensProducaoCadarco},
  ATecnicos in '..\mpontaloja\ATecnicos.pas' {FTecnicos},
  ANovoTecnico in '..\mpontaloja\ANovoTecnico.pas' {FNovoTecnico},
  ATipoCorte in '..\mestoque\ATipoCorte.pas' {FTipoCorte},
  ANovaCobranca in '..\mfinanceiro\ANovaCobranca.pas' {FNovaCobranca},
  AHistoricoLigacao in '..\mfinanceiro\AHistoricoLigacao.pas' {FHistoricoLigacao},
  ACobrancas in '..\mfinanceiro\ACobrancas.pas' {FCobrancas},
  AMotivoInadimplencia in '..\mfinanceiro\AMotivoInadimplencia.pas' {FMotivoInadimplencia},
  ANovaConta in '..\mfinanceiro\ANovaConta.pas' {FNovaConta},
  ATipoContrato in '..\mpontaloja\ATipoContrato.pas' {FTipoContrato},
  ANovoContratoCliente in '..\mpontaloja\ANovoContratoCliente.pas' {FNovoContratoCliente},
  UnContrato in '..\mpontaloja\UnContrato.pas',
  AContratosCliente in '..\mpontaloja\AContratosCliente.pas' {FContratosCliente},
  APrincipioAtivo in '..\mpontaloja\APrincipioAtivo.pas' {FPrincipioAtivo},
  ANovaCampanhaVendas in '..\mpontaloja\ANovaCampanhaVendas.pas' {FNovaCampanhaVendas},
  ACampanhaVendas in '..\mpontaloja\ACampanhaVendas.pas' {FCampanhaVendas},
  ANovoTeleMarketing in '..\mpontaloja\ANovoTeleMarketing.pas' {FNovoTeleMarketing},
  UnTeleMarketing in '..\mpontaloja\UnTeleMarketing.pas',
  ABrindesCliente in '..\mpontaloja\ABrindesCliente.pas' {FBrindesCliente},
  AAlteraVendedorCotacao in '..\mpontaloja\AAlteraVendedorCotacao.pas' {FAlteraVendedorCotacao},
  ATeleMarketings in '..\mpontaloja\ATeleMarketings.pas' {FTeleMarketings},
  AProdutosCliente in '..\mpontaloja\AProdutosCliente.pas' {FProdutosCliente},
  ADonoProduto in '..\mpontaloja\ADonoProduto.pas' {FDonoProduto},
  ANovoAgendamento in '..\mpontaloja\ANovoAgendamento.pas' {FNovoAgedamento},
  ATipoAgendamento in '..\mpontaloja\ATipoAgendamento.pas' {FTipoAgendamento},
  UnDaruma in '..\mpontaloja\UnDaruma.pas',
  AAgendamentos in '..\mpontaloja\AAgendamentos.pas' {FAgendamentos},
  AAcondicionamento in '..\mpontaloja\AAcondicionamento.pas' {FAcondicionamento},
  AEstagioAgendamento in '..\mpontaloja\AEstagioAgendamento.pas' {FEstagioAgendamento},
  ANovoChamadoTecnico in '..\mChamado\ANovoChamadoTecnico.pas' {FNovoChamado},
  UnChamado in '..\mChamado\UnChamado.pas',
  AGeraFracaoOP in '..\mpontaloja\AGeraFracaoOP.pas' {FGeraFracaoOP},
  AChamadosTecnicos in '..\mChamado\AChamadosTecnicos.pas' {FChamadoTecnico},
  AParentesCliente in '..\mpontaloja\AParentesCliente.pas' {FParentesClientes},
  AAlteraEstagioChamado in '..\mpontaloja\AAlteraEstagioChamado.pas' {FAlteraEstagioChamado},
  AAlteraEstagioAgendamento in '..\mpontaloja\AAlteraEstagioAgendamento.pas' {FAlteraEstagioAgendamento},
  AOrdemProducaoGenerica in '..\mestoque\AOrdemProducaoGenerica.pas' {FOrdemProducaoGenerica},
  ANovaOrdemProducaoGenerica in '..\mestoque\ANovaOrdemProducaoGenerica.pas' {FNovaOrdemProducaoGenerica},
  AHistoricoECobranca in '..\mfinanceiro\AHistoricoECobranca.pas' {FHistoricoECobranca},
  ALocalizaProdutoContrato in '..\mChamado\ALocalizaProdutoContrato.pas' {FLocalizaProdutoContrato},
  AAgendaChamados in '..\mChamado\AAgendaChamados.pas' {FAgendaChamados},
  AHoraAgendaChamado in '..\mChamado\AHoraAgendaChamado.pas' {FHoraAgendaChamado},
  ATipoChamado in '..\mChamado\ATipoChamado.pas' {FTipoChamado},
  APerguntaPesquisaSatisfacao in '..\mChamado\APerguntaPesquisaSatisfacao.pas' {FPerguntaPesquisaSatisfacao},
  ANovaPerguntaPesquisaSatisfacao in '..\mChamado\ANovaPerguntaPesquisaSatisfacao.pas' {FNovaPerguntaPesquisaSatisfacao},
  AEfetuarPesquisaSatisfacao in '..\mChamado\AEfetuarPesquisaSatisfacao.pas' {FEfetuarPesquisaSatisfacao},
  UnPesquisaSatisfacao in '..\mChamado\UnPesquisaSatisfacao.pas',
  APesquisaSatisfacaoChamado in '..\mChamado\APesquisaSatisfacaoChamado.pas' {FPesquisaSatisfacaoChamado},
  ANovoProspect in 'ANovoProspect.pas' {FNovoProspect},
  AMeioDivulgacao in 'AMeioDivulgacao.pas' {FMeioDivulgacao},
  AProspects in 'AProspects.pas' {FProspects},
  AMotivoVenda in 'AMotivoVenda.pas' {FMotivoVenda},
  ANovaProposta in 'ANovaProposta.pas' {FNovaProposta},
  UnProspect in 'UnProspect.pas',
  UnProposta in 'UnProposta.pas',
  AMedico in '..\mpontaloja\AMedico.pas' {FMedico},
  AColecao in 'AColecao.pas' {FColecao},
  AEstagioProducao in '..\mestoque\AEstagioProducao.pas' {FEstagioProducao},
  ADesenvolvedor in 'ADesenvolvedor.pas' {FDesenvolvedor},
  ANovaAmostra in 'ANovaAmostra.pas' {FNovaAmostra},
  AAlteraEstagioProposta in 'AAlteraEstagioProposta.pas' {FAlteraEstagioProposta},
  AAmostras in 'AAmostras.pas' {FAmostras},
  UnAmostra in 'UnAmostra.pas',
  AConcorrentes in 'AConcorrentes.pas' {FConcorrentes},
  ANovoConcorrente in 'ANovoConcorrente.pas' {FNovoConcorrente},
  AContatosCliente in '..\mpontaloja\AContatosCliente.pas' {FContatosCliente},
  AAmostraConsumo in 'AAmostraConsumo.pas' {FAmostraConsumo},
  AProdutosReserva in '..\mpontaloja\AProdutosReserva.pas' {FProdutosReserva},
  ANovaAgendaProspect in 'ANovaAgendaProspect.pas' {FNovaAgendaProspect},
  UnArgox in '..\magerais\UnArgox.pas',
  AChequesCP in '..\mfinanceiro\AChequesCP.pas' {FChequesCP},
  AConsultacheques in '..\mfinanceiro\AConsultacheques.pas' {FConsultaCheques},
  AProdutosProspect in 'AProdutosProspect.pas' {FProdutosProspect},
  AConsultaAgendaProspect in 'AConsultaAgendaProspect.pas' {FConsultaAgendaProspect},
  AContatosProspect in 'AContatosProspect.pas' {FContatosProspect},
  ANovaMaquina in '..\mestoque\ANovaMaquina.pas' {FNovaMaquina},
  ANovoTelemarketingProspect in 'ANovoTelemarketingProspect.pas' {FNovoTelemarketingProspect},
  ANovaTarefaEMarketingProspect in 'ANovaTarefaEMarketingProspect.pas' {FNovaTarefaEMarketingProspect},
  ATarefaEMarketingProspect in 'ATarefaEMarketingProspect.pas' {FTarefaEMarketingProspect},
  unEMarketingProspect in 'unEMarketingProspect.pas',
  APedidosPendentesFaturar in '..\mpontaloja\APedidosPendentesFaturar.pas' {FPedidosPendentesFaturar},
  ATarefaTelemarketingProspect in 'ATarefaTelemarketingProspect.pas' {FTarefasTelemarketingProspect},
  ANovaTarefaTelemarketingProspect in 'ANovaTarefaTelemarketingProspect.pas' {FNovaTarefaTelemarketingProspect},
  AHistoricoTelemarketingProspect in 'AHistoricoTelemarketingProspect.pas' {FHistoricoTelemarketingProspect},
  ATamanhos in '..\mpontaloja\ATamanhos.pas' {FTamanhos},
  agraficoscontasareceber in '..\mfinanceiro\agraficoscontasareceber.pas' {FGraficosCR},
  AVisualizaLogReceber in '..\mfinanceiro\AVisualizaLogReceber.pas' {FVisualizaLogReceber},
  AContasAReceber in '..\mfinanceiro\AContasAReceber.pas' {FContasaReceber},
  AGraficosContasaPagar in '..\mfinanceiro\AGraficosContasaPagar.pas' {FGraficosCP},
  ANovoContasaReceber in '..\mfinanceiro\ANovoContasaReceber.pas' {FNovoContasAReceber},
  AImprimeCR in '..\mfinanceiro\AImprimeCR.pas' {FImprimeCR},
  AManutencaoCR in '..\mfinanceiro\AManutencaoCR.pas' {FManutencaoCR},
  AMovComissoes in '..\mfinanceiro\AMovComissoes.pas' {FMovComissoes},
  AContasAConsolidarCR in '..\mfinanceiro\AContasAConsolidarCR.pas' {FContasAConsolidarCR},
  AConsolidarCR in '..\mfinanceiro\AConsolidarCR.pas' {FConsolidarCR},
  ASetores in 'ASetores.pas' {FSetores},
  AComissaoClassificacaoVendedor in '..\mestoque\AComissaoClassificacaoVendedor.pas' {FComissaoClassificacaoVendedor},
  AProdutosOrcados in '..\MChamado\AProdutosOrcados.pas' {FProdutosOrcados},
  AManutencaoEmail in 'AManutencaoEmail.pas' {FManutencaoEmail},
  UnVersoes in '..\magerais\UnVersoes.pas',
  APedidosCompraAberto in '..\mestoque\APedidosCompraAberto.pas' {FPedidosCompraAberto},
  UnSolicitacaoCompra in '..\mestoque\UnSolicitacaoCompra.pas',
  UnPedidoCompra in '..\mestoque\UnPedidoCompra.pas',
  ANovoPedidoCompra in '..\mestoque\ANovoPedidoCompra.pas' {FNovoPedidoCompra},
  ACompradores in '..\mestoque\ACompradores.pas' {FCompradores},
  ABaixaContasAReceberOO in '..\mfinanceiro\ABaixaContasAReceberOO.pas' {FBaixaContasaReceberOO},
  unEMarketing in '..\mpontaloja\unEMarketing.pas',
  ANovoProdutoPro in '..\mestoque\ANovoProdutoPro.pas' {FNovoProdutoPro},
  ABaixaContasaPagarOO in '..\mfinanceiro\ABaixaContasaPagarOO.pas' {FBaixaContasaPagarOO},
  AChequesOO in '..\mfinanceiro\AChequesOO.pas' {FChequesOO},
  ANovoEmailContasAReceber in '..\mfinanceiro\ANovoEmailContasAReceber.pas' {FNovoEmailContasAReceber},
  AVerificaLeituraLembrete in '..\MChamado\AVerificaLeituraLembrete.pas' {FVerificaLeituraLembrete},
  UnLembrete in '..\mpontaloja\UnLembrete.pas',
  ANovoLembrete in '..\mpontaloja\ANovoLembrete.pas' {FNovoLembrete},
  ASelecionarUsuarios in '..\mpontaloja\ASelecionarUsuarios.pas' {FSelecionarUsuarios},
  APropostasCliente in 'APropostasCliente.pas' {FPropostasCliente},
  undespesas in '..\mfinanceiro\undespesas.pas',
  ACentroCusto in '..\mfinanceiro\ACentroCusto.pas' {FCentroCusto},
  AContasAPagar in '..\mfinanceiro\AContasAPagar.pas' {FContasaPagar},
  adespesas in '..\mfinanceiro\adespesas.pas' {FDespesas},
  ageradespesasfixas in '..\mfinanceiro\ageradespesasfixas.pas' {FGeraDespesasFixas},
  AImprimeCP in '..\mfinanceiro\AImprimeCP.pas' {FImprimeCP},
  AManutencaoCP in '..\mfinanceiro\AManutencaoCP.pas' {FManutencaoCP},
  ANovoContasaPagar in '..\mfinanceiro\ANovoContasaPagar.pas' {FNovoContasAPagar},
  UnCaixa in '..\mcaixa\UnCaixa.pas',
  AGerarFracaoOPMaquinasCorte in '..\mpontaloja\AGerarFracaoOPMaquinasCorte.pas' {FGerarFracaoOPMaquinasCorte},
  ABaixaConsumoProduto in '..\mestoque\ABaixaConsumoProduto.pas' {FBaixaConsumoProduto},
  AAlteraEstagioPedidoCompra in '..\mestoque\AAlteraEstagioPedidoCompra.pas' {FAlteraEstagioPedidoCompra},
  ANovoSetor in 'ANovoSetor.pas' {FNovoSetor},
  AMostraParPagarOO in '..\mfinanceiro\AMostraParPagarOO.pas' {FMostraParPagarOO},
  ASolicitacaoCompras in '..\mestoque\ASolicitacaoCompras.pas' {FSolicitacaoCompra},
  ANovaSolicitacaoCompra in '..\mestoque\ANovaSolicitacaoCompra.pas' {FNovaSolicitacaoCompras},
  AAlteraEstagioOrcamento in '..\mestoque\AAlteraEstagioOrcamento.pas' {FAlteraEstagioOrcamentoCompra},
  APedidoCompra in '..\mestoque\APedidoCompra.pas' {FPedidoCompra},
  ATipoProposta in 'ATipoProposta.pas' {FTipoProposta},
  UnZebra in '..\magerais\UnZebra.pas',
  ACompensaCheque in '..\mfinanceiro\ACompensaCheque.pas' {FCompensaCheque},
  ARelOrdemSerra in '..\mestoque\ARelOrdemSerra.pas' {FRelOrdemSerra},
  AMontaKitBastidor in '..\mestoque\AMontaKitBastidor.pas' {FMontaKitBastidor},
  ABaixaProdutosChamado in '..\MChamado\ABaixaProdutosChamado.pas' {FBaixaProdutosChamado},
  ACreditoCliente in '..\mfinanceiro\ACreditoCliente.pas' {FCreditoCliente},
  AConsultaChamadoParcial in '..\MChamado\AConsultaChamadoParcial.pas' {FConsultaChamadoParcial},
  AAlteraEstagioFracaoOP in '..\mestoque\AAlteraEstagioFracaoOP.pas' {FAlteraEstagioFracaoOP},
  ASolicitacaoCompraProdutosPendentes in '..\mestoque\ASolicitacaoCompraProdutosPendentes.pas' {FSolicitacaoCompraProdutosPendentes},
  AFormatoFrasco in 'AFormatoFrasco.pas' {FFormatoFrasco},
  AMaterialFrasco in 'AMaterialFrasco.pas' {FMaterialFrasco},
  AMaterialRotulo in 'AMaterialRotulo.pas' {FMaterialRotulo},
  ANovoOrcamentoCompra in '..\mestoque\ANovoOrcamentoCompra.pas' {FNovoOrcamentoCompra},
  AMaterialLiner in 'AMaterialLiner.pas' {FMaterialLiner},
  UnOrcamentoCompra in '..\mestoque\UnOrcamentoCompra.pas',
  AHorarioTrabalho in '..\mestoque\AHorarioTrabalho.pas' {FHorarioTrabalho},
  ACadastraEmailSuspect in 'ACadastraEmailSuspect.pas' {FCadastraEmailSuspect},
  AFaixaEtaria in '..\mpontaloja\AFaixaEtaria.pas' {FFaixaEtaria},
  ADigitacaoProspect in 'ADigitacaoProspect.pas' {FDigitacaoProspect},
  AMarcas in '..\mpontaloja\AMarcas.pas' {FMarca},
  ARequisicaoMaquina in 'ARequisicaoMaquina.pas' {FRequisicaoMaquina},
  AInformacoesVendedor in 'AInformacoesVendedor.pas' {FInformacoesVendedor},
  AMetasVendedor in '..\mpontaloja\AMetasVendedor.pas' {FMetasVendedor},
  AConsultaLogSeparacaoConsumo in '..\mestoque\AConsultaLogSeparacaoConsumo.pas' {FConsultaLogSeparacaoConsumo},
  dmRave in '..\magerais\dmRave.pas' {dtRave: TDSServerModule},
  UnRave in '..\magerais\UnRave.pas',
  UnNFe in '..\mfaturamento\UnNFe.pas',
  ANovaComposicao in '..\mestoque\ANovaComposicao.pas' {FNovaComposicao},
  AComposicoes in '..\mestoque\AComposicoes.pas' {FComposicoes},
  ANovaCondicaoPagamento in '..\mpontaloja\ANovaCondicaoPagamento.pas' {FNovaCondicaoPagamento},
  ACondicaoPagamento in '..\mpontaloja\ACondicaoPagamento.pas' {FCondicaoPagamento},
  UnCondicaoPagamento in '..\mfinanceiro\UnCondicaoPagamento.pas',
  AProjetos in '..\mfinanceiro\AProjetos.pas' {FProjetos},
  ADepartamentoAmostra in 'ADepartamentoAmostra.pas' {FDepartamentoAmostra},
  ATipoMateriaPrima in 'ATipoMateriaPrima.pas' {FTipoMateriaPrima};

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
