Unit UnFluxoCaixa;

Interface

Uses Classes, DBTables,vcf1,Graphics, unDadosCR, SysUtils;

Const
  LinInicial = 1;
  LinFinal = 20;
  LinPrimeiraContaCaixa = 2;
  ColInicial = 1;
  ColTituloLinha = 2;
  ColAplicacao = 3;
  ColSaldoAnterior = 4;
  ColSaldoAtual = 5;
  ColFinal = 20;

//classe localiza
Type TRBLocalizaFluxoCaixa = class
  private
  public
    procedure LocalizaContas(VpaTabela : TQuery);
    procedure LocalizaSaldoAnteriorCR(VpaTabela : TQuery;VpaDatInicio : TDateTime);
    procedure LocalizaChequeSaldoAnteriorCR(VpaTabela : TQuery;VpaDatInicio : TDateTime);
    procedure LocalizaContasAReceber(VpaTabela : TQuery;VpaDatInicio,VpaDatFim : TDateTime);
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesFluxoCaixa = class(TRBLocalizaFluxoCaixa)
  private
    Aux,
    Tabela : TQuery;
    // cores
    CorFonteCaixa,
    CorFundoCaixa,
    CorFonteNegativo,
    CorFonteTituloCR,
    CorFonteCR,
    CorFundoTituloCR,
    CorFundoCR,
    CorFundoCP,
    CorFonteCP,
    CorFonteTituloCP,
    CorFundoTituloCP: TColor;
    // fonte
    TamanhoFonte : integer;
    NomeFonte : string;
    AlturaLinha : Integer;

    TamanhoGrade : Integer;
    procedure InicializaGradeGeral(VpaGrade : TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarContasFluxo(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarSaldoAnterior(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarChequesSaldoAnterior(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarContasaReceber(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarMesContasaReceberGrade(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo;VpaMes,VpaAno : Integer);
    procedure CarValorAplicacaoGrade(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarContaCaixaGrade(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure RContaCaixaDia(VpanumConta :string; VpaFluxoDia : TRBDFluxoCaixaDia;VpaDFluxoMes : TRBDFluxoCaixaMes; VpaDFluxo : TRBDFluxoCaixaCorpo);
    function RContaFluxoCaixa(VpaNumConta : string; VpaDFluxo : TRBDFluxoCaixaCorpo):TRBDFluxoCaixaConta;
  public
    constructor cria;
    destructor destroy;override;
    procedure CarTitulosDiarioGrade(VpaGrade : TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarregaCores(VpaCorFonteCaixa, VpaCorFundoCaixa, VpaCorFonteNegativo, VpaCorFonteTituloCR, VpaCorFonteCR, VpaCorFundoTituloCR, VpaCorFundoCR, VpaCorFonteCP,VpaCorFundoCP, VpaCorFonteTituloCP, VpaCorFundoTituloCP: TColor; VpaNomFonte : string; VpaTamFonte,VpaAltLinha : Integer);
    procedure LimpaFluxo(VpaGrade : TF1Book);
    procedure InicializaFluxoDiario(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarFluxoCaixa(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
end;



implementation

Uses FunSql, FunObjeto, funData;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaFluxoCaixa
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaFluxoCaixa.cria;
begin
  inherited create;
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaContas(VpaTabela : TQuery);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select CON.C_NRO_CON, C_NOM_CRR, CON.N_LIM_CRE, CON.N_SAL_ATU, '+
                                  '       CON.N_VAL_APL, '+
                                  '       BAN.C_NOM_BAN '+
                                  ' from CADCONTAS CON, CADBANCOS BAN '+
                                  ' Where CON.C_IND_ATI = ''T'''+
                                  ' and CON.I_COD_BAN = BAN.I_COD_BAN '+
                                  ' order by C_NRO_CON ');
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaSaldoAnteriorCR(VpaTabela : TQuery;VpaDatInicio: TDateTime);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select  MOV.C_NRO_CON, MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_PAR_FIL, MOV.I_COD_FRM, MOV.D_DAT_VEN, MOV.C_NRO_DUP, MOV.N_VLR_PAR, '+
                                  ' MOV.D_DAT_PRO, '+
                                  ' CAD.I_COD_CLI, CAD.I_NRO_NOT, CAD.D_DAT_EMI, '+
                                  ' CLI.C_NOM_CLI '+
                                  ' from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADCLIENTES CLI '+
                                 ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                                 ' AND MOV.I_LAN_REC = CAD.I_LAN_REC '+
                                 ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                 ' AND MOV.D_DAT_PAG IS NULL '+
                                 ' AND MOV.D_DAT_PRO < '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                                 ' AND MOV.C_FUN_PER =  ''N''');
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaChequeSaldoAnteriorCR(VpaTabela : TQuery;VpaDatInicio : TDateTime);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select CHE.SEQCHEQUE, CHE.CODBANCO, CHE.CODFORMAPAGAMENTO, CHE.NUMCHEQUE, '+
                                  ' CHE.CODUSUARIO, CHE.NUMCONTACAIXA, CHE.NOMEMITENTE, CHE.TIPCHEQUE, '+
                                  ' CHE.VALCHEQUE, CHE.DATCADASTRO, CHE.DATVENCIMENTO, CHE.DATCOMPENSACAO, '+
                                  ' CHE.DATDEVOLUCAO,'+
                                  ' CON.C_NOM_CRR, CON.C_TIP_CON,  '+
                                  ' FRM.C_NOM_FRM ' +
                                  ' from CHEQUE CHE, CADCONTAS CON, CADFORMASPAGAMENTO FRM'+
                                 ' WHERE CHE.DATVENCIMENTO < '+SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                                 ' AND CHE.DATCOMPENSACAO IS NULL'+
                                 ' AND CHE.CODFORMAPAGAMENTO = FRM.I_COD_FRM '+
                                 ' AND CHE.NUMCONTACAIXA = CON.C_NRO_CON ');
end;

{******************************************************************************}
procedure TRBLocalizaFluxoCaixa.LocalizaContasAReceber(VpaTabela : TQuery;VpaDatInicio,VpaDatFim : TDateTime);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select  MOV.C_NRO_CON, MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_PAR_FIL, MOV.I_COD_FRM, MOV.D_DAT_VEN, MOV.C_NRO_DUP, MOV.N_VLR_PAR, '+
                                  ' MOV.D_DAT_PRO, '+
                                  ' CAD.I_COD_CLI, CAD.I_NRO_NOT, CAD.D_DAT_EMI, '+
                                  ' CLI.C_NOM_CLI, CLI.C_FIN_CON '+
                                  ' from MOVCONTASARECEBER MOV, CADCONTASARECEBER CAD, CADCLIENTES CLI '+
                                  ' WHERE MOV.I_EMP_FIL = CAD.I_EMP_FIL '+
                                  ' AND MOV.I_LAN_REC = CAD.I_LAN_REC '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                   SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_PRO',VpaDatInicio,VpaDatFim,true)+
                                  ' AND MOV.D_DAT_PAG IS NULL '+
                                  ' AND MOV.C_FUN_PER =  ''N''');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesFluxoCaixa
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesFluxoCaixa.cria;
begin
  inherited create;
  Tabela := TQuery.Create(nil);
  Tabela.DatabaseName := 'BaseDados';
  Aux := TQuery.Create(nil);
  Aux.DataBaseName := 'BaseDados';
end;

{******************************************************************************}
destructor TRBFuncoesFluxoCaixa.destroy;
begin
  Tabela.free;
  Aux.free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.InicializaGradeGeral(VpaGrade : TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
begin
  if VpaDFluxo.IndDiario then
    VpaGrade.TextRC[LinInicial,ColInicial] := 'Fluxo Diário : '+IntToStr(VpaDFluxo.Mes)+'/'+IntToStr(VpaDFluxo.Ano)
  else
    VpaGrade.TextRC[LinInicial,ColInicial] := 'Fluxo Mensal : '+ IntToStr(VpaDFluxo.Ano);
  FormataCelula(VpaGrade,ColInicial,ColInicial,LinInicial,LinInicial,TamanhoFonte+2,clwhite,clblue,true,
                false,NomeFonte);
  VpaGrade.TextRC[LinInicial,ColSaldoAnterior] := 'Saldo Anterior';
  VpaGrade.TextRC[LinInicial,ColAplicacao] := 'Aplicação';
  VpaGrade.TextRC[LinInicial,ColSaldoAtual] := 'Saldo Atual';

  FormataCelula(VpaGrade,ColAplicacao,ColSaldoAtual,LinInicial,LinInicial,TamanhoFonte,CorFundoCaixa,CorFonteCaixa,true,
                false,NomeFonte);
  FormataBordaCelula(VpaGrade,ColAplicacao,ColSaldoAtual,LinInicial,LinInicial,clBlack,false);
  VpaGrade.SetRowHeight(LinInicial,LinInicial,AlturaLinha+100,false);
  VpaGrade.ColWidth[ColInicial] := 500;
  VpaGrade.ColWidth[ColTituloLinha] := 5000;
  VpaGrade.ColWidth[ColAplicacao] := 2500;
  VpaGrade.ColWidth[ColSaldoAnterior] := 3500;
  VpaGrade.ColWidth[ColSaldoAtual] := 3500;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarContasFluxo(VpaDFluxo : TRBDFluxoCaixaCorpo);
Var
  VpfDContaCaixa : TRBDFluxoCaixaConta;
begin
  FreeTObjectsList(VpaDFluxo.ContasCaixa);
  VpaDFluxo.ValAplicacao := 0;
  LocalizaContas(Tabela);
  while not tabela.eof do
  begin
    VpfDContaCaixa := VpaDFluxo.addContaCaixa;
    VpfDContaCaixa.NumContaCaixa := Tabela.FieldByName('C_NRO_CON').AsString;
    VpfDContaCaixa.NomContaCaixa := Tabela.FieldByName('C_NOM_BAN').AsString+'/'+Tabela.FieldByName('C_NOM_CRR').AsString;
    VpfDContaCaixa.ValSaldoAtual := Tabela.FieldByName('N_SAL_ATU').AsFloat;
    VpfDContaCaixa.ValAplicado := Tabela.FieldByName('N_VAL_APL').AsFloat;
    VpfDContaCaixa.ValLimiteCredito := Tabela.FieldByName('N_LIM_CRE').AsFloat;
    VpaDFluxo.ValAplicacao :=  VpaDFluxo.ValAplicacao + VpfDContaCaixa.ValAplicado;
    VpaDFluxo.ValSaldoAtual :=  VpaDFluxo.ValSaldoAtual + VpfDContaCaixa.ValSaldoAtual;
    Tabela.next;
  end;
  Tabela.close;
  VpfDContaCaixa := VpaDFluxo.addContaCaixa;
  VpfDContaCaixa.NumContaCaixa := '';
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarSaldoAnterior(VpaDFluxo : TRBDFluxoCaixaCorpo);
var
  VpfDParcelaCR : TRBDParcelaBaixaCR;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  VpaDFluxo.ValSaldoAnterior := 0;
  LocalizaSaldoAnteriorCR(Tabela,VpaDFluxo.DatInicio);
  While not Tabela.eof do
  begin
    VpfDConta := RContaFluxoCaixa(Tabela.FieldByName('C_NRO_CON').AsString,VpaDFluxo);
    VpfDParcelaCR := VpfDConta.addParcelaSaldoAnterior;

    VpfDParcelaCR.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfDParcelaCR.LanReceber := Tabela.FieldByName('I_LAN_REC').AsInteger;
    VpfDParcelaCR.NumParcelaParcial := Tabela.FieldByName('I_PAR_FIL').AsInteger;
    VpfDParcelaCR.CodCliente := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfDParcelaCR.CodFormaPagamento := Tabela.FieldByName('I_COD_FRM').AsInteger;
    VpfDParcelaCR.NumNotaFiscal := Tabela.FieldByName('I_NRO_NOT').AsInteger;
    VpfDParcelaCR.NumDiasAtraso := DiasPorPeriodo(Tabela.FieldByName('D_DAT_VEN').AsDateTime,Date);
    VpfDParcelaCR.NumContaCorrente := Tabela.FieldByName('C_NRO_CON').AsString;
    VpfDParcelaCR.NomCliente := Tabela.FieldByName('C_NOM_CLI').AsString;
    VpfDParcelaCR.NumDuplicata := Tabela.FieldByName('C_NRO_DUP').AsString;
    VpfDParcelaCR.DatVencimento := Tabela.FieldByName('D_DAT_VEN').AsDateTime;
    VpfDParcelaCR.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
    VpfDParcelaCR.ValParcela := Tabela.FieldByName('N_VLR_PAR').AsFloat;

    VpfDConta.ValSaldoAnterior := VpfDConta.ValSaldoAnterior + VpfDParcelaCR.ValParcela;
    VpaDFluxo.ValSaldoAnterior := VpaDFluxo.ValSaldoAnterior + VpfDParcelaCR.ValParcela;
    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarChequesSaldoAnterior(VpaDFluxo : TRBDFluxoCaixaCorpo);
var
  VpfDCheque : TRBDCheque;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  VpaDFluxo.ValSaldoAnterior := 0;
  LocalizaChequeSaldoAnteriorCR(Tabela,VpaDFluxo.DatInicio);
  While not Tabela.eof do
  begin
    VpfDConta := RContaFluxoCaixa(Tabela.FieldByName('NUMCONTACAIXA').AsString,VpaDFluxo);
    if Tabela.FieldByName('TIPCHEQUE').AsString = 'C' then
      VpfDCheque := VpfDConta.addChequeCR(Tabela.FieldByName('DATVENCIMENTO').AsDateTime)
    else
      VpfDCheque := VpfDConta.addChequeCP(Tabela.FieldByName('DATVENCIMENTO').AsDateTime);

    VpfDCheque.SeqCheque := Tabela.FieldByName('SEQCHEQUE').AsInteger;
    VpfDCheque.CodBanco := Tabela.FieldByName('CODBANCO').AsInteger;
    VpfDCheque.CodFormaPagamento := Tabela.FieldByName('CODFORMAPAGAMENTO').AsInteger;
    VpfDCheque.NumCheque := Tabela.FieldByName('NUMCHEQUE').AsInteger;
    VpfDCheque.CodUsuario := Tabela.FieldByName('CODUSUARIO').AsInteger;
    VpfDCheque.NumContaCaixa := Tabela.FieldByName('NUMCONTACAIXA').AsString;
    VpfDCheque.NomContaCaixa := Tabela.FieldByName('C_NOM_CRR').AsString;
    VpfDCheque.NomEmitente := Tabela.FieldByName('NOMEMITENTE').AsString;
    VpfDCheque.NomFormaPagamento := Tabela.FieldByName('C_NOM_FRM').AsString;
    VpfDCheque.TipCheque := Tabela.FieldByName('TIPCHEQUE').AsString;
    VpfDCheque.TipContaCaixa := Tabela.FieldByName('C_TIP_CON').AsString;
    VpfDCheque.ValCheque := Tabela.FieldByName('VALCHEQUE').AsFloat;
    VpfDCheque.DatCadastro := Tabela.FieldByName('DATCADASTRO').AsDateTime;
    VpfDCheque.DatVencimento := Tabela.FieldByName('DATVENCIMENTO').AsDateTime;
    VpfDCheque.DatCompensacao := Tabela.FieldByName('DATCOMPENSACAO').AsDateTime;
    VpfDCheque.DatDevolucao := Tabela.FieldByName('DATDEVOLUCAO').AsDateTime;

    Tabela.next;
  end;
  Tabela.close;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarContasaReceber(VpaDFluxo : TRBDFluxoCaixaCorpo);
Var
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDParcelaCR : TRBDParcelaBaixaCR;
begin
  LocalizaContasAReceber(Tabela,VpaDFluxo.DatInicio,VpaDFluxo.DatFim);
  while not Tabela.eof do
  begin
    VpfDConta := RContaFluxoCaixa(Tabela.FieldByName('C_NRO_CON').AsString,VpaDFluxo);
    VpfDParcelaCR := VpfDConta.addParcela(Tabela.FieldByName('D_DAT_PRO').AsDateTime);

    VpfDParcelaCR.CodFilial := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfDParcelaCR.LanReceber := Tabela.FieldByName('I_LAN_REC').AsInteger;
    VpfDParcelaCR.NumParcelaParcial := Tabela.FieldByName('I_PAR_FIL').AsInteger;
    VpfDParcelaCR.CodCliente := Tabela.FieldByName('I_EMP_FIL').AsInteger;
    VpfDParcelaCR.CodFormaPagamento := Tabela.FieldByName('I_COD_FRM').AsInteger;
    VpfDParcelaCR.NumNotaFiscal := Tabela.FieldByName('I_NRO_NOT').AsInteger;
    VpfDParcelaCR.NumDiasAtraso := DiasPorPeriodo(Tabela.FieldByName('D_DAT_VEN').AsDateTime,Date);
    VpfDParcelaCR.NumContaCorrente := Tabela.FieldByName('C_NRO_CON').AsString;
    VpfDParcelaCR.NomCliente := Tabela.FieldByName('C_NOM_CLI').AsString;
    VpfDParcelaCR.NumDuplicata := Tabela.FieldByName('C_NRO_DUP').AsString;
    VpfDParcelaCR.DatVencimento := Tabela.FieldByName('D_DAT_VEN').AsDateTime;
    VpfDParcelaCR.DatEmissao := Tabela.FieldByName('D_DAT_EMI').AsDateTime;
    VpfDParcelaCR.ValParcela := Tabela.FieldByName('N_VLR_PAR').AsFloat;

    Tabela.next;
  end;
  Tabela.close;
  VpaDFluxo.CalculaValoresTotais;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarMesContasaReceberGrade(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo;VpaMes,VpaAno : Integer);
var
  VpfLacoContas, VpfLacoMes, VpfLacoDia : Integer;
  VpfDConta : TRBDFluxoCaixaConta;
  VpfDMes : TRBDFluxoCaixaMes;
  VpfDDia : TRBDFluxoCaixaDia;
begin
  for VpfLacoContas := 0 to VpaDFluxo.ContasCaixa.Count -1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLacoContas]);
    for VpfLacoMes := 0 to VpfDConta.Meses.Count - 1 do
    begin
      if (TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]).Mes = VpaMes) and
         (TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]).Ano = VpaAno) then
      begin
        VpfDMes := TRBDFluxoCaixaMes(VpfDConta.Meses.Items[VpfLacoMes]);
        for VpfLacoDia := 0 to VpfDMes.Dias.Count - 1 do
        begin
          VpfDDia := TRBDFluxoCaixaDia(VpfDMes.Dias.Items[VpfLacoDia]);
          VpaGrade.TextRC[VpfDConta.LinContasReceberPrevisto,ColAplicacao+1+VpfDDia.Dia] := FormatFloat('#,###,###,##0.00',VpfDDia.ValCRPrevisto);
          VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas-1,ColAplicacao+1+VpfDDia.Dia] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalReceita);
          VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas,ColAplicacao+1+VpfDDia.Dia] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalReceitaAcumulada);
        end;
        VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas,VpaDFluxo.QtdColunas] := FormatFloat('#,###,###,##0.00',VpfDMes.ValTotalReceitaAcumulada);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarValorAplicacaoGrade(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
var
  VpfLaco : Integer;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  for VpfLaco := 0 to VpaDFluxo.ContasCaixa.Count -1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]);
    if VpfDConta.ValAplicado <> 0 then
      VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas,ColAplicacao] := FormatFloat('#,###,###,##0.00',VpfDConta.ValAplicado)
    else
      VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas,ColAplicacao] := FormatFloat('#,###,###,##0.00',0);

    if VpfDConta.ValSaldoAnterior <> 0 then
      VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas-1,ColSaldoAnterior] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnterior)
    else
      VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas-1,ColSaldoAnterior] := FormatFloat('#,###,###,##0.00',0);

    if VpfDConta.ValSaldoAtual <> 0 then
      VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas-1,ColSaldoAtual] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAtual)
    else
      VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas-1,ColSaldoAtual] := FormatFloat('#,###,###,##0.00',0);

    VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas,ColSaldoAnterior] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnterior+VpfDConta.ValAplicado);
    VpaGrade.TextRC[VpfDConta.LinReceitasAcumuladas,ColSaldoAtual] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnterior+VpfDConta.ValAplicado+VpfDConta.ValSaldoAtual);
  end;

  if VpaDFluxo.ValAplicacao <> 0 then
    VpaGrade.TextRC[VpaDFluxo.LinTotalAcumulado,ColAplicacao] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValAplicacao)
  else
    VpaGrade.TextRC[VpaDFluxo.LinTotalAcumulado,ColAplicacao] := FormatFloat('#,###,###,##0.00',0);

  VpaGrade.TextRC[VpaDFluxo.LinTotalAcumulado-1,ColSaldoAnterior] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValSaldoAnterior);
  VpaGrade.TextRC[VpaDFluxo.LinTotalAcumulado,ColSaldoAnterior] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValAplicacao+VpaDFluxo.ValSaldoAnterior);
  VpaGrade.TextRC[VpaDFluxo.LinTotalAcumulado-1,ColSaldoAtual] := FormatFloat('#,###,###,##0.00',VpaDFluxo.valSaldoAtual);
  VpaGrade.TextRC[VpaDFluxo.LinTotalAcumulado,ColSaldoAtual] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValAplicacao+VpaDFluxo.ValSaldoAnterior+VpaDFluxo.valSaldoAtual);
  VpaGrade.TextRC[VpaDFluxo.LinTotalAcumulado,VpaDFluxo.QtdColunas] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValTotalAcumulado);
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarContaCaixaGrade(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
Var
  vpfLinha : Integer;
  VpfLaco : integer;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  VpaGrade.ColWidth[ColInicial] := 500;
  VpaGrade.ColWidth[ColInicial+1] := 6000;
  for VpfLaco := 0 to VpaDFluxo.ContasCaixa.Count -1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]);
    vpfLinha := LinPrimeiraContaCaixa +1 +(VpfLaco*23);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := VpfDConta.NumContaCaixa+ '-'+VpfDConta.NomContaCaixa;
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha+100,false);
    FormataCelula(VpaGrade,ColInicial,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,clblue,clwhite,true,
                false,NomeFonte);
    FormataBordaCelula(VpaGrade,ColInicial,VpaDFluxo.QtdColunas,VpfLinha,vpfLinha,clBlue,false);

    //formata a cor da primeira coluna em azul
    FormataCelula(VpaGrade,ColInicial,ColInicial,VpfLinha,VpfLinha+20,TamanhoFonte+3,clblue,clwhite,true,
                false,NomeFonte);

    //Titulo Contas a receber;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+2,CorFundoTituloCR,CorFonteTituloCR,true,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Contas a Receber';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha+100,false);

    //Contas a receber Previsto;
    inc(vpflinha);
    VpfDConta.LinContasReceberPrevisto := VpfLinha;
    FormataCelula(VpaGrade,ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCR,CorFonteCR,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Contas a Receber Previsto';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
    FormataCelula(VpaGrade,ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoCR,CorFonteCR,false,
                false,NomeFonte);

    //Contas a receber Duvidoso;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCR,CorFonteCR,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Contas a Receber Duvidoso';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
    FormataCelula(VpaGrade,ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoCR,CorFonteCR,false,
                false,NomeFonte);

    //Cobrança Prevista;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCR,CorFonteCR,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Cobrança Prevista';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
    FormataCelula(VpaGrade,ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoCR,CorFonteCR,false,
                false,NomeFonte);


    //Contas a Desconto Duplicatas;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCR,CorFonteCR,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := '(-) Desconto Duplicatas';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
    FormataCelula(VpaGrade,ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoCR,CorFonteCR,false,
                false,NomeFonte);

    //Contas a Cheques a compensar;
    inc(vpflinha);
    VpfDConta.LinChequesaCompensarCR := VpfLinha;
    FormataCelula(VpaGrade,ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCR,CorFonteCR,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := '(+) Cheques a Compensar';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
    FormataCelula(VpaGrade,ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoCR,CorFonteCR,false,
                false,NomeFonte);
    inc(Vpflinha);
    //Total Receitas;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCR,CorFonteCR,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Total Receitas';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);

    //Receitas Acumuladas;
    inc(vpflinha);
    VpfDConta.LinReceitasAcumuladas := VpfLinha;
    FormataCelula(VpaGrade,ColInicial+1,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCR,CorFonteCR,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Receitas Acumuladas';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);

    //coloca a coluna do total em cinza
    FormataCelula(VpaGrade,VpaDFluxo.QtdColunas,VpaDFluxo.QtdColunas,VpfDConta.LinContasReceberPrevisto,VpfDConta.LinChequesaCompensarCR,TamanhoFonte,CorFundoCaixa,CorFonteCaixa,false,
                false,NomeFonte);
    FormataCelula(VpaGrade,VpaDFluxo.QtdColunas,VpaDFluxo.QtdColunas,VpfDConta.LinReceitasAcumuladas-1,VpfLinha,TamanhoFonte,CorFundoCaixa,CorFonteCaixa,false,
                false,NomeFonte);

    inc(Vpflinha);
    //Titulo Contas a Pagar
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+2,CorFundoTituloCP,CorFonteTituloCP,true,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Contas a Pagar';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha+100,false);
    //Contas a pagar;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCP,CorFonteTituloCP,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Contas a pagar';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
    FormataCelula(VpaGrade,ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,CorFundoCP,CorFonteCP,false,
                false,NomeFonte);
    //Contas a pagar;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCP,CorFonteTituloCP,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Despesas Fixa';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
    FormataCelula(VpaGrade,ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,CorFundoCP,CorFonteCP,false,
                false,NomeFonte);

    //Contas a pagar;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCP,CorFonteTituloCP,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Comissões';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
    FormataCelula(VpaGrade,ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,CorFundoCP,CorFonteCP,false,
                false,NomeFonte);

    //Contas a pagar;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCP,CorFonteTituloCP,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Cheques a compensar';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
    FormataCelula(VpaGrade,ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,CorFundoCP,CorFonteCP,false,
                false,NomeFonte);

    inc(vpflinha);
    //Contas a pagar;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCP,CorFonteTituloCP,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Total Despesas';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);

    //Contas a pagar;
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloCP,CorFonteTituloCP,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Despesas Acumuladas';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);

    inc(vpflinha);
    //Totais
    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,clblue,clwhite,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Total Conta ' + VpfDConta.NumContaCaixa+ ' :';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);

    inc(vpflinha);
    FormataCelula(VpaGrade,ColInicial,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,clblue,clwhite,false,
                false,NomeFonte);
    VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Total Acumulado Conta ' +VpfDConta.NumContaCaixa+ ' :';
    VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha,false);
  end;

  inc(vpflinha);
  //Total dia
  inc(vpflinha);
  FormataCelula(VpaGrade,ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,clGray,clBlack,true,
              false,NomeFonte);
  VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Total : ';
  VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha+100,false);

  //Total Acumulado
  inc(vpflinha);
  VpaDFluxo.LinTotalAcumulado := VpfLinha;
  FormataCelula(VpaGrade,ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,clGray,clBlack,true,
              false,NomeFonte);
  VpaGrade.TextRC[vpfLinha,ColInicial+1] := 'Total Acumulado : ';
  VpaGrade.SetRowHeight(vpfLinha,VpfLinha,AlturaLinha+100,false);
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.RContaCaixaDia(VpanumConta :string; VpaFluxoDia : TRBDFluxoCaixaDia;VpaDFluxoMes : TRBDFluxoCaixaMes; VpaDFluxo : TRBDFluxoCaixaCorpo);
begin
  
end;

{******************************************************************************}
function TRBFuncoesFluxoCaixa.RContaFluxoCaixa(VpaNumConta : string; VpaDFluxo : TRBDFluxoCaixaCorpo):TRBDFluxoCaixaConta;
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to  VpaDFluxo.ContasCaixa.Count - 1 do
  begin
    if  TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]).NumContaCaixa = VpaNumConta then
    begin
      Result := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]);
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarTitulosDiarioGrade(VpaGrade : TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
begin


end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarregaCores(VpaCorFonteCaixa, VpaCorFundoCaixa, VpaCorFonteNegativo, VpaCorFonteTituloCR, VpaCorFonteCR, VpaCorFundoTituloCR, VpaCorFundoCR, VpaCorFonteCP, VpaCorFundoCP,VpaCorFonteTituloCP, VpaCorFundoTituloCP: TColor; VpaNomFonte : string; VpaTamFonte,VpaAltLinha : Integer);
begin
  CorFonteCaixa := VpaCorFonteCaixa;
  CorFundoCaixa := VpaCorFundoCaixa;
  CorFonteNegativo := VpaCorFonteNegativo;
  CorFonteTituloCR := VpaCorFonteTituloCR;
  CorFonteCR := VpaCorFonteCR;
  CorFundoTituloCR := VpaCorFundoTituloCR;
  CorFundoCR := VpaCorFundoCR;
  CorFonteCP := VpaCorFonteCP;
  CorFundoCP := VpaCorFundoCP;
  CorFonteTituloCP := VpaCorFonteTituloCP;
  CorFundoTituloCP := VpaCorFundoTituloCP;

  TamanhoFonte :=  VpaTamFonte;
  NomeFonte := VpaNomFonte;

  AlturaLinha := VpaAltLinha;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.LimpaFluxo(VpaGrade : TF1Book);
begin
  LimpaGrade(VpaGrade,ColInicial,ColFinal,LinInicial,LinFinal);
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.InicializaFluxoDiario(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
var
  VpfLaco : Integer;
begin
  TamanhoGrade := 50;
  VpaGrade.MaxCol := TamanhoGrade;
  InicializaGradeGeral(VpaGrade,VpaDFluxo);
  if VpaDFluxo.IndDiario then
    VpaDFluxo.QtdColunas := Dia(UltimoDiaMes(MontaData(1,VpaDFluxo.Mes,VpaDFluxo.Ano)))
  else
    VpaDFluxo.QtdColunas := 12;

  for VpfLaco := 1 to VpaDFluxo.QtdColunas do
  begin
    VpaGrade.TextRC[LinInicial,ColSaldoAtual+VpfLaco] := IntToStr(VpfLaco);
    FormataCelula(VpaGrade,ColSaldoAtual+VpfLaco,ColSaldoAtual+VpfLaco,LinInicial,LinInicial,TamanhoFonte,CorFundoCaixa,CorFonteCaixa,true,
                false,NomeFonte);
    FormataBordaCelula(VpaGrade,ColSaldoAtual+VpfLaco,ColSaldoAtual+VpfLaco,LinInicial,LinInicial,clBlack,false);
    VpaGrade.SetAlignment(F1HAlignRight,false,F1VAlignBottom,0);
    VpaGrade.ColWidth[ColInicial] := 2500;
  end;
  VpaGrade.TextRC[LinInicial,ColSaldoAtual+VpaDFluxo.QtdColunas+1] := 'Total';
  FormataCelula(VpaGrade,ColSaldoAtual+VpaDFluxo.QtdColunas+1,ColSaldoAtual+VpaDFluxo.QtdColunas+1,LinInicial,LinInicial,TamanhoFonte,CorFundoCaixa,CorFonteCaixa,true,
                false,NomeFonte);
  VpaGrade.SetAlignment(F1HAlignRight,false,F1VAlignBottom,0);
  VpaGrade.ColWidth[ColInicial] := 2500;

  VpaDFluxo.QtdColunas := VpaDFluxo.QtdColunas+ColSaldoAtual+1;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarFluxoCaixa(VpaGrade :TF1Book;VpaDFluxo : TRBDFluxoCaixaCorpo);
begin
  CarContasFluxo(VpaDFluxo);
  CarContaCaixaGrade(VpaGrade,VpaDFluxo);
  CarSaldoAnterior(VpaDFluxo);
  CarChequesSaldoAnterior(VpaDFluxo);
  CarContasaReceber(VpaDFluxo);
  CarValorAplicacaoGrade(VpaGrade,VpaDFluxo);
  CarMesContasaReceberGrade(VpaGrade,VpaDFluxo,VpaDFluxo.Mes,VpaDFluxo.Ano);
end;

end.
