unit UnBematech;
{Verificado
-.edit;
}
interface

  // Funções de Inicialização
function Bematech_FI_AlteraSimboloMoeda( SimboloMoeda: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ProgramaAliquota( Aliquota: AnsiString; ICMS_ISS: Integer ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ProgramaHorarioVerao: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_NomeiaDepartamento( Indice: Integer; Departamento: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NomeiaTotalizadorNaoSujeitoIcms( Indice: Integer; Totalizador: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ProgramaArredondamento: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_ProgramaTruncamento: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_ProgramaTruncamento'; 

function Bematech_FI_LinhasEntreCupons( Linhas: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_EspacoEntreLinhas( Dots: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_ForcaImpactoAgulhas( ForcaImpacto: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

// Funções do Cupom Fiscal 
function Bematech_FI_AbreCupom( CGC_CPF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VendeItem( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; TipoQuantidade: AnsiString; Quantidade: AnsiString; CasasDecimais: Integer; ValorUnitario: AnsiString; TipoDesconto: AnsiString; Desconto: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VendeItemDepartamento( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; ValorUnitario: AnsiString; Quantidade: AnsiString; Acrescimo: AnsiString; Desconto: AnsiString; IndiceDepartamento: AnsiString; UnidadeMedida: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaItemAnterior: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_CancelaItemGenerico( NumeroItem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaCupom: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_FechaCupomResumido( FormaPagamento: AnsiString; Mensagem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_FechaCupom( FormaPagamento: AnsiString; AcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString; ValorPago: AnsiString; Mensagem: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ResetaImpressora: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_IniciaFechamentoCupom( AcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_EfetuaFormaPagamento( FormaPagamento: AnsiString; ValorFormaPagamento: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_EfetuaFormaPagamentoDescricaoForma( FormaPagamento: AnsiString; ValorFormaPagamento: AnsiString; DescricaoFormaPagto: AnsiString ): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_TerminaFechamentoCupom( Mensagem: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_EstornoFormasPagamento( FormaOrigem: AnsiString; FormaDestino: AnsiString; Valor: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_UsaUnidadeMedida( UnidadeMedida: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_AumentaDescricaoItem( Descricao: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

// Funções dos Relatórios Fiscais
function Bematech_FI_LeituraX: Integer; StdCall; External 'BEMAFI32.DLL' ; 

function Bematech_FI_ReducaoZ( Data: AnsiString; Hora: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_RelatorioGerencial( Texto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_RelatorioGerencialTEF( Texto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_FechaRelatorioGerencial: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_LeituraMemoriaFiscalData( DataInicial: AnsiString; DataFinal: AnsiString ):
Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_LeituraMemoriaFiscalReducao( ReducaoInicial: AnsiString; ReducaoFinal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_LeituraMemoriaFiscalSerialData( DataInicial: AnsiString; DataFinal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_LeituraMemoriaFiscalSerialReducao( ReducaoInicial: AnsiString; ReducaoFinal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

// Funções das Operações Não Fiscais 
function Bematech_FI_RecebimentoNaoFiscal( IndiceTotalizador: AnsiString; Valor: AnsiString; FormaPagamento: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_AbreComprovanteNaoFiscalVinculado( FormaPagamento: AnsiString; Valor: AnsiString; NumeroCupom: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_UsaComprovanteNaoFiscalVinculado( Texto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_UsaComprovanteNaoFiscalVinculadoTEF( Texto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL'

function Bematech_FI_FechaComprovanteNaoFiscalVinculado: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_Sangria( Valor: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_Suprimento( Valor: AnsiString; FormaPagamento: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

// Funções de Informações da Impressora 
function Bematech_FI_NumeroSerie( NumeroSerie: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_SubTotal( SubTotal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroCupom( NumeroCupom: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_LeituraXSerial: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_VersaoFirmware( VersaoFirmware: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CGC_IE( CGC: AnsiString; IE: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_GrandeTotal( GrandeTotal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_Cancelamentos( ValorCancelamentos: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_Descontos( ValorDescontos: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroOperacoesNaoFiscais( NumeroOperacoes: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroCuponsCancelados( NumeroCancelamentos: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroIntervencoes( NumeroIntervencoes: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroReducoes( NumeroReducoes: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroSubstituicoesProprietario( NumeroSubstituicoes: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_UltimoItemVendido( NumeroItem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ClicheProprietario( Cliche: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroCaixa( NumeroCaixa: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroLoja( NumeroLoja: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_SimboloMoeda( SimboloMoeda: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_MinutosLigada( Minutos: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_MinutosImprimindo( Minutos: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaModoOperacao( Modo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaEpromConectada( Flag: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_FlagsFiscais( Var Flag: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_ValorPagoUltimoCupom( ValorCupom: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_DataHoraImpressora( Data: AnsiString; Hora: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ContadoresTotalizadoresNaoFiscais( Contadores: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaTotalizadoresNaoFiscais( Totalizadores: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_DataHoraReducao( Data: AnsiString; Hora: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_DataMovimento( Data: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaTruncamento( Flag: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_Acrescimos( ValorAcrescimos: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ContadorBilhetePassagem( ContadorPassagem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaAliquotasIss( Flag: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaFormasPagamento( Formas: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaRecebimentoNaoFiscal( Recebimentos: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaDepartamentos( Departamentos: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaTipoImpressora( Var TipoImpressora: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_VerificaTotalizadoresParciais( Totalizadores: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_RetornoAliquotas( Aliquotas: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaEstadoImpressora( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_DadosUltimaReducao( DadosReducao: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_MonitoramentoPapel( Var Linhas: Integer): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_VerificaIndiceAliquotasIss( Flag: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ValorFormaPagamento( FormaPagamento: AnsiString; Valor: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ValorTotalizadorNaoFiscal( Totalizador: AnsiString; Valor: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

// Funções de Autenticação e Gaveta de Dinheiro 
function Bematech_FI_Autenticacao:Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_Autenticacao'; 

function Bematech_FI_ProgramaCaracterAutenticacao( Parametros: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_AcionaGaveta:Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_AcionaGaveta'; 

function Bematech_FI_VerificaEstadoGaveta( Var EstadoGaveta: Integer ): Integer; StdCall; External 'BEMAFI32.DLL';

// Funções para a Impressora Restaurante 
function Bematech_FIR_AbreCupomRestaurante( Mesa: AnsiString; CGC_CPF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_RegistraVenda( Mesa: AnsiString; Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; Quantidade: AnsiString; ValorUnitario: AnsiString; FlagAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_CancelaVenda( Mesa: AnsiString; Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; Quantidade: AnsiString; ValorUnitario: AnsiString; FlagAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_ConferenciaMesa( Mesa: AnsiString; FlagAcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_AbreConferenciaMesa( Mesa: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_FechaConferenciaMesa( FlagAcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_TransferenciaMesa( MesaOrigem: AnsiString; MesaDestino: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_ContaDividida( NumeroCupons: AnsiString; ValorPago: AnsiString; CGC_CPF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_FechaCupomContaDividida( NumeroCupons: AnsiString; FlagAcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString; FormasPagamento: AnsiString; ValorFormasPagamento: AnsiString; ValorPagoCliente: AnsiString; CGC_CPF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_TransferenciaItem( MesaOrigem: AnsiString; Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; Quantidade: AnsiString; ValorUnitario: AnsiString; FlagAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString; MesaDestino: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_RelatorioMesasAbertas( TipoRelatorio: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FIR_ImprimeCardapio: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FIR_RelatorioMesasAbertasSerial: Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_CardapioPelaSerial: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FIR_RegistroVendaSerial( Mesa: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_VerificaMemoriaLivre( Bytes: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_FechaCupomRestaurante( FormaPagamento: AnsiString; FlagAcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString; ValorFormaPagto: AnsiString; Mensagem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FIR_FechaCupomResumidoRestaurante( FormaPagamento: AnsiString; Mensagem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

// Função para a Impressora Bilhete de Passagem 
function Bematech_FI_AbreBilhetePassagem( ImprimeValorFinal: AnsiString; ImprimeEnfatizado: AnsiString; Embarque: AnsiString; Destino: AnsiString; Linha: AnsiString; Prefixo: AnsiString; Agente: AnsiString; Agencia: AnsiString; Data: AnsiString; Hora: AnsiString; Poltrona: AnsiString; Plataforma: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

// Funções de Impressão de Cheques 
function Bematech_FI_ProgramaMoedaSingular( MoedaSingular: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ProgramaMoedaPlural( MoedaPlural: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaImpressaoCheque: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_VerificaStatusCheque( Var StatusCheque: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_ImprimeCheque( Banco: AnsiString; Valor: AnsiString; Favorecido: AnsiString; Cidade: AnsiString; Data: AnsiString; Mensagem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_IncluiCidadeFavorecido( Cidade: AnsiString; Favorecido: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ImprimeCopiaCheque: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_ImprimeCopiaCheque'; 

// Outras Funções 
function Bematech_FI_AbrePortaSerial: Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_RetornoImpressora( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_FechaPortaSerial: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_FechaPortaSerial'; 

function Bematech_FI_MapaResumo:Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_MapaResumo'; 

function Bematech_FI_AberturaDoDia( ValorCompra: AnsiString; FormaPagamento: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_FechamentoDoDia: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_FechamentoDoDia'; 

function Bematech_FI_ImprimeConfiguracoesImpressora:Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_ImprimeConfiguracoesImpressora'; 

function Bematech_FI_ImprimeDepartamentos: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_ImprimeDepartamentos'; 

function Bematech_FI_RelatorioTipo60Analitico: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_RelatorioTipo60Analitico'; 

function Bematech_FI_RelatorioTipo60Mestre: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_RelatorioTipo60Mestre'; 

function Bematech_FI_VerificaImpressoraLigada: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_VerificaImpressoraLigada'; 

function Bematech_FI_ImpressaoCarne( Titulo, Percelas: AnsiString; Datas, Quantidade: integer; Texto, Cliente, RG_CPF, Cupom: AnsiString; Vias, Assina: integer ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_InfoBalanca( Porta: AnsiString; Modelo: integer; Peso, PrecoKilo, Total: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_DadosSintegra( DataInicio: AnsiString; DataFinal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_IniciaModoTEF: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_IniciaModoTEF'; 

function Bematech_FI_FinalizaModoTEF: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_FinalizaModoTEF'; 

function Bematech_FI_VersaoDll( Versao: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_RegistrosTipo60: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_RegistrosTipo60'; 

function Bematech_FI_LeArquivoRetorno( Retorno: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

// Funções da Impressora Fiscal MFD 
function Bematech_FI_AbreCupomMFD(CGC: AnsiString; Nome: AnsiString; Endereco : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaCupomMFD(CGC, Nome, Endereco: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ProgramaFormaPagamentoMFD(FormaPagto, OperacaoTef: AnsiString) : Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_EfetuaFormaPagamentoMFD(FormaPagamento, ValorFormaPagamento, Parcelas, DescricaoFormaPagto: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CupomAdicionalMFD(): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_AcrescimoDescontoItemMFD (Item, AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimoDesconto: AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NomeiaRelatorioGerencialMFD (Indice, Descricao : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_AutenticacaoMFD(Linhas, Texto : AnsiString) : Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_AbreComprovanteNaoFiscalVinculadoMFD(FormaPagamento, Valor, NumeroCupom, CGC, nome, Endereco : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ReimpressaoNaoFiscalVinculadoMFD() : Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_AbreRecebimentoNaoFiscalMFD(CGC, Nome, Endereco : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_EfetuaRecebimentoNaoFiscalMFD(IndiceTotalizador, ValorRecebimento : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_IniciaFechamentoRecebimentoNaoFiscalMFD(AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimo, ValorDesconto : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_FechaRecebimentoNaoFiscalMFD(Mensagem : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaRecebimentoNaoFiscalMFD(CGC, Nome, Endereco : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_AbreRelatorioGerencialMFD(Indice : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_UsaRelatorioGerencialMFD(Texto : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_UsaRelatorioGerencialMFDTEF(Texto : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_SegundaViaNaoFiscalVinculadoMFD(): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_EstornoNaoFiscalVinculadoMFD(CGC, Nome, Endereco : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroSerieMFD(NumeroSerie : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VersaoFirmwareMFD(VersaoFirmware : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CNPJMFD(CNPJ : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_InscricaoEstadualMFD(InscricaoEstadual : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_InscricaoMunicipalMFD(InscricaoMunicipal : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_TempoOperacionalMFD(TempoOperacional : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_MinutosEmitindoDocumentosFiscaisMFD(Minutos : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ContadoresTotalizadoresNaoFiscaisMFD(Contadores : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaTotalizadoresNaoFiscaisMFD(Totalizadores : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaFormasPagamentoMFD(FormasPagamento : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaRecebimentoNaoFiscalMFD(Recebimentos : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaRelatorioGerencialMFD(Relatorios : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ContadorComprovantesCreditoMFD(Comprovantes : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ContadorOperacoesNaoFiscaisCanceladasMFD(OperacoesCanceladas : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ContadorRelatoriosGerenciaisMFD (Relatorios : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ContadorCupomFiscalMFD(CuponsEmitidos : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ContadorFitaDetalheMFD(ContadorFita : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ComprovantesNaoFiscaisNaoEmitidosMFD(Comprovantes : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_NumeroSerieMemoriaMFD(NumeroSerieMFD : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_MarcaModeloTipoImpressoraMFD(Marca, Modelo, Tipo : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ReducoesRestantesMFD(Reducoes : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaTotalizadoresParciaisMFD(Totalizadores : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_DadosUltimaReducaoMFD(DadosReducao : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_LeituraMemoriaFiscalDataMFD(DataInicial, DataFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_LeituraMemoriaFiscalSerialDataMFD(DataInicial, DataFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_LeituraChequeMFD(CodigoCMC7 : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ImprimeChequeMFD(NumeroBanco, Valor, Favorecido, Cidade, Data, Mensagem, ImpressaoVerso, Linhas : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD(FlagRetorno : AnsiString): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_RetornoImpressoraMFD( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_AbreBilhetePassagemMFD(Embarque, Destino, Linha, Agencia, Data, Hora, Poltrona, Plataforma, TipoPassagem, RGCliente, NomeCliente, EnderecoCliente, UFDetino: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaAcrescimoDescontoItemMFD( cFlag, cItem: AnsiString ): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_SubTotalizaCupomMFD: integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_SubTotalizaRecebimentoMFD: integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_TotalLivreMFD( cMemoriaLivre: AnsiString ): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_TamanhoTotalMFD( cTamanhoMFD: AnsiString ): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_AcrescimoDescontoSubtotalRecebimentoMFD( cFlag, cTipo, cValor: AnsiString ): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_AcrescimoDescontoSubtotalMFD( cFlag, cTipo, cValor: AnsiString): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaAcrescimoDescontoSubtotalMFD( cFlag: AnsiString): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaAcrescimoDescontoSubtotalRecebimentoMFD( cFlag: AnsiString ): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_TotalizaCupomMFD: integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_TotalizaRecebimentoMFD: integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_PercentualLivreMFD( cMemoriaLivre: AnsiString ): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_DataHoraUltimoDocumentoMFD( cDataHora: AnsiString ): integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_MapaResumoMFD:Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_MapaResumoMFD'; 

function Bematech_FI_RelatorioTipo60AnaliticoMFD: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_RelatorioTipo60AnaliticoMFD'; 

function Bematech_FI_ValorFormaPagamentoMFD( FormaPagamento: AnsiString; Valor: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ValorTotalizadorNaoFiscalMFD( Totalizador: AnsiString; Valor: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaEstadoImpressoraMFD( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_IniciaFechamentoCupomMFD( AcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimo: AnsiString; ValorDesconto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_TerminaFechamentoCupomCodigoBarrasMFD( cMensagem: AnsiString; cTipoCodigo: AnsiString; cCodigo: AnsiString; iAltura: Integer; iLargura: Integer; iPosicaoCaracteres: Integer; iFonte: Integer; iMargem: Integer; iCorrecaoErros: Integer; iColunas: Integer ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaItemNaoFiscalMFD( NumeroItem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_AcrescimoItemNaoFiscalMFD( NumeroItem: AnsiString; AcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CancelaAcrescimoNaoFiscalMFD( NumeroItem: AnsiString; AcrescimoDesconto: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_ImprimeClicheMFD:Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_ImprimeClicheMFD'; 

function Bematech_FI_ImprimeInformacaoChequeMFD( Posicao: Integer; Linhas: Integer; Mensagem: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_RelatorioSintegraMFD( iRelatorios : Integer; 
                                           cArquivo    : AnsiString;
                                           cMes        : AnsiString;
                                           cAno        : AnsiString;
                                           cRazaoSocial: AnsiString;
                                           cEndereco   : AnsiString;
                                           cNumero     : AnsiString;
                                           cComplemento: AnsiString;
                                           cBairro     : AnsiString;
                                           cCidade     : AnsiString;
                                           cCEP        : AnsiString;
                                           cTelefone   : AnsiString;
                                           cFax        : AnsiString;
                                           cContato    : AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_GeraRelatorioSintegraMFD( iRelatorios : Integer; 
                                               cArquivoOrigem : AnsiString;
                                               cArquivoDestino: AnsiString;
                                               cMes           : AnsiString;
                                               cAno           : AnsiString;
                                               cRazaoSocial   : AnsiString;
                                               cEndereco      : AnsiString;
                                               cNumero        : AnsiString;
                                               cComplemento   : AnsiString;
                                               cBairro        : AnsiString;
                                               cCidade        : AnsiString;
                                               cCEP           : AnsiString;
                                               cTelefone      : AnsiString;
                                               cFax           : AnsiString;
                                               cContato       : AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_DownloadMF( Arquivo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_DownloadMFD( Arquivo: AnsiString; TipoDownload: AnsiString; ParametroInicial: AnsiString; ParametroFinal: AnsiString; UsuarioECF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_FormatoDadosMFD( ArquivoOrigem: AnsiString; ArquivoDestino: AnsiString; TipoFormato: AnsiString; TipoDownload: AnsiString; ParametroInicial: AnsiString; ParametroFinal: AnsiString; UsuarioECF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

// Funções disponíveis somente na impressora fiscal MP-2000 TH FI versão 01.01.01 ou 01.00.02 
function Bematech_FI_AtivaDesativaVendaUmaLinhaMFD( iFlag: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_AtivaDesativaAlinhamentoEsquerdaMFD( iFlag: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_AtivaDesativaCorteProximoMFD(): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_AtivaDesativaTratamentoONOFFLineMFD( iFlag: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_StatusEstendidoMFD( Var iStatus: Integer ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_VerificaFlagCorteMFD( Var iStatus: Integer ): Integer; StdCall; External 'BEMAFI32.DLL'; 

function Bematech_FI_TempoRestanteComprovanteMFD( cTempo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_UFProprietarioMFD( cUF: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_GrandeTotalUltimaReducaoMFD( cGT: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_DataMovimentoUltimaReducaoMFD( cData: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_SubTotalComprovanteNaoFiscalMFD( cSubTotal: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_InicioFimCOOsMFD( cCOOIni, cCOOFim: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_InicioFimGTsMFD( cGTIni, cGTFim: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

// Função para Configuração dos Códigos de Barras 
function Bematech_FI_ConfiguraCodigoBarrasMFD( Altura: Integer; Largura: Integer; PosicaoCaracteres: Integer; Fonte: Integer; Margem: Integer): Integer; StdCall; External 'BEMAFI32.DLL'; 

// Funções para Impressão dos Códigos de Barras 
function Bematech_FI_CodigoBarrasUPCAMFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasUPCEMFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasEAN13MFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasEAN8MFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasCODE39MFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasCODE93MFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasCODE128MFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasITFMFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasCODABARMFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasISBNMFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasMSIMFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasPLESSEYMFD( Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

function Bematech_FI_CodigoBarrasPDF417MFD( NivelCorrecaoErros: Integer; Altura: Integer; Largura: Integer; Colunas: Integer; Codigo: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

implementation

end.
