Unit UnFluxoCaixa;

Interface

Uses Classes, vcf1,Graphics, unDadosCR, SysUtils, CGrades, SqlExpr,Tabela;

Const
  LinInicial = 0;
  LinFinal = 20;
  LinPrimeiraContaCaixa = 1;
  ColInicial = 0;
  ColTituloLinha = 1;
  ColAplicacao = 2;
  ColSaldoAnterior = 3;
  ColSaldoAtual = 4;

//classe localiza
Type TRBLocalizaFluxoCaixa = class
  private
  public
    procedure LocalizaContas(VpaTabela : TSQl);
    procedure LocalizaSaldoAnteriorCR(VpaTabela : TSql;VpaDatInicio : TDateTime);
    procedure LocalizaChequeSaldoAnteriorCR(VpaTabela : TSQl;VpaDatInicio : TDateTime);
    procedure LocalizaContasAReceber(VpaTabela : TSQl;VpaDatInicio,VpaDatFim : TDateTime);
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesFluxoCaixa = class(TRBLocalizaFluxoCaixa)
  private
    Aux,
    Tabela : TSQL;
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
    procedure InicializaGradeGeral(VpaGrade : TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarContasFluxo(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarSaldoAnterior(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarChequesSaldoAnterior(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarContasaReceber(VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarMesContasaReceberGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo;VpaMes,VpaAno : Integer);
    procedure CarValorAplicacaoGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarContaCaixaGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure RContaCaixaDia(VpanumConta :string; VpaFluxoDia : TRBDFluxoCaixaDia;VpaDFluxoMes : TRBDFluxoCaixaMes; VpaDFluxo : TRBDFluxoCaixaCorpo);
    function RContaFluxoCaixa(VpaNumConta : string; VpaDFluxo : TRBDFluxoCaixaCorpo):TRBDFluxoCaixaConta;
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    procedure CarregaCores(VpaCorFonteCaixa, VpaCorFundoCaixa, VpaCorFonteNegativo, VpaCorFonteTituloCR, VpaCorFonteCR, VpaCorFundoTituloCR, VpaCorFundoCR, VpaCorFonteCP,VpaCorFundoCP, VpaCorFonteTituloCP, VpaCorFundoTituloCP: TColor; VpaNomFonte : string; VpaTamFonte,VpaAltLinha : Integer);
    procedure LimpaFluxo(VpaGrade : TF1Book);
    procedure InicializaFluxoDiario(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
    procedure CarFluxoCaixa(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
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
procedure TRBLocalizaFluxoCaixa.LocalizaContas(VpaTabela : TSQL);
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
procedure TRBLocalizaFluxoCaixa.LocalizaSaldoAnteriorCR(VpaTabela : TSQL;VpaDatInicio: TDateTime);
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
procedure TRBLocalizaFluxoCaixa.LocalizaChequeSaldoAnteriorCR(VpaTabela : TSQL;VpaDatInicio : TDateTime);
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
procedure TRBLocalizaFluxoCaixa.LocalizaContasAReceber(VpaTabela : TSQL;VpaDatInicio,VpaDatFim : TDateTime);
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
                                  ' AND MOV.C_FUN_PER =  ''N'''+
                                  ' AND CAD.C_IND_DEV = ''N''');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesFluxoCaixa
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesFluxoCaixa.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  Tabela := TSQL.Create(nil);
  Tabela.ASQlConnection := VpaBaseDados;
  Aux := TSQL.Create(nil);
  Aux.ASQlConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesFluxoCaixa.destroy;
begin
  Tabela.free;
  Aux.free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.InicializaGradeGeral(VpaGrade : TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
begin
  if VpaDFluxo.IndDiario then
    VpaGrade.Cells[ColInicial,LinInicial] := 'Fluxo Diário : '+IntToStr(VpaDFluxo.Mes)+'/'+IntToStr(VpaDFluxo.Ano)
  else
    VpaGrade.Cells[ColInicial,LinInicial] := 'Fluxo Mensal : '+ IntToStr(VpaDFluxo.Ano);
  VpaGrade.MesclarCelulas(ColInicial,ColInicial+1,LinInicial,LinInicial);
  VpaGrade.FormataCelula(ColInicial,ColInicial,LinInicial,LinInicial,TamanhoFonte+2,NomeFonte,clblue,true,false,clwhite,taCenter,vaCenter,
                bcSemBorda,clBlack);
  VpaGrade.cells[ColSaldoAnterior,LinInicial] := 'Saldo Anterior';
  VpaGrade.Cells[ColAplicacao,LinInicial] := 'Aplicação';
  VpaGrade.Cells[ColSaldoAtual,LinInicial] := 'Saldo Atual';

  VpaGrade.FormataCelula(ColAplicacao,ColSaldoAtual,LinInicial,LinInicial,TamanhoFonte,NomeFonte,CorFonteCaixa,true,false,CorFundoCaixa,
                         taLeftJustify,vacenter,bcComBorda,clBlack);
  VpaGrade.RowHeights[LinInicial] := AlturaLinha+5;
  VpaGrade.ColWidths[ColInicial] := 10;
  VpaGrade.ColWidths[ColTituloLinha] := 200;
  VpaGrade.ColWidths[ColAplicacao] := 100;
  VpaGrade.ColWidths[ColSaldoAnterior] := 100;
  VpaGrade.ColWidths[ColSaldoAtual] := 100;
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
procedure TRBFuncoesFluxoCaixa.CarMesContasaReceberGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo;VpaMes,VpaAno : Integer);
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
          VpaGrade.cells[ColAplicacao+1+VpfDDia.Dia,VpfDConta.LinContasReceberPrevisto] := FormatFloat('#,###,###,##0.00',VpfDDia.ValCRPrevisto);
          VpaGrade.cells[ColAplicacao+1+VpfDDia.Dia,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalReceita);
          VpaGrade.cells[ColAplicacao+1+VpfDDia.Dia,VpfDConta.LinReceitasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDDia.ValTotalReceitaAcumulada);
        end;
        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinContasReceberPrevisto] := FormatFloat('#,###,###,##0.00',VpfDMes.ValCRPrevisto);
        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDMes.ValTotalReceita);
        VpaGrade.cells[VpaDFluxo.QtdColunas,VpfDConta.LinReceitasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDMes.ValTotalReceitaAcumulada);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarValorAplicacaoGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
var
  VpfLaco : Integer;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  for VpfLaco := 0 to VpaDFluxo.ContasCaixa.Count -1 do
  begin
    VpfDConta := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]);
    if VpfDConta.ValAplicado <> 0 then
      VpaGrade.Cells[ColAplicacao,VpfDConta.LinReceitasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDConta.ValAplicado)
    else
      VpaGrade.cells[ColAplicacao,VpfDConta.LinReceitasAcumuladas] := FormatFloat('#,###,###,##0.00',0);

    if VpfDConta.ValSaldoAnterior <> 0 then
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnterior)
    else
      VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',0);

    if VpfDConta.ValSaldoAtual <> 0 then
      VpaGrade.cells[ColSaldoAtual,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAtual)
    else
      VpaGrade.cells[ColSaldoAtual,VpfDConta.LinReceitasAcumuladas-1] := FormatFloat('#,###,###,##0.00',0);

    VpaGrade.cells[ColSaldoAnterior,VpfDConta.LinReceitasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnterior+VpfDConta.ValAplicado);
    VpaGrade.cells[ColSaldoAtual,VpfDConta.LinReceitasAcumuladas] := FormatFloat('#,###,###,##0.00',VpfDConta.ValSaldoAnterior+VpfDConta.ValAplicado+VpfDConta.ValSaldoAtual);
  end;

  if VpaDFluxo.ValAplicacao <> 0 then
    VpaGrade.cells[ColAplicacao,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValAplicacao)
  else
    VpaGrade.cells[ColAplicacao,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',0);

  VpaGrade.cells[ColSaldoAnterior,VpaDFluxo.LinTotalAcumulado-1] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValSaldoAnterior);
  VpaGrade.cells[ColSaldoAnterior,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValAplicacao+VpaDFluxo.ValSaldoAnterior);
  VpaGrade.cells[ColSaldoAtual,VpaDFluxo.LinTotalAcumulado-1] := FormatFloat('#,###,###,##0.00',VpaDFluxo.valSaldoAtual);
  VpaGrade.cells[ColSaldoAtual,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValAplicacao+VpaDFluxo.ValSaldoAnterior+VpaDFluxo.valSaldoAtual);
  VpaGrade.cells[VpaDFluxo.QtdColunas,VpaDFluxo.LinTotalAcumulado] := FormatFloat('#,###,###,##0.00',VpaDFluxo.ValTotalAcumulado);
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarContaCaixaGrade(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
Var
  vpfLinha : Integer;
  VpfLaco : integer;
  VpfDConta : TRBDFluxoCaixaConta;
begin
  for VpfLaco := 0 to VpaDFluxo.ContasCaixa.Count -1 do
  begin
    VpaGrade.RowCount := VpaGrade.RowCount + 23;
    VpfDConta := TRBDFluxoCaixaConta(VpaDFluxo.ContasCaixa.Items[VpfLaco]);
    vpfLinha := LinPrimeiraContaCaixa +1 +(VpfLaco*23);
    VpaGrade.cells[ColInicial+1,vpfLinha] := VpfDConta.NumContaCaixa+ '-'+VpfDConta.NomContaCaixa;
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha+1;
    VpaGrade.FormataCelula(ColInicial,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clblue,taLeftJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.MesclarCelulas(ColInicial+1,ColInicial+5,vpfLinha,vpfLinha);

   VpaGrade.FormataCelula(ColInicial,VpaDFluxo.QtdColunas,VpfLinha - 1,VpfLinha - 1,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //formata a cor da primeira coluna em azul
    VpaGrade.FormataCelula(ColInicial,ColInicial,VpfLinha,VpfLinha+20,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clblue,taLeftJustify,vaCenter,bcSemBorda,clBlack);
    VpaGrade.ColWidths[colInicial] := 10;

    //Titulo Contas a receber;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+2,NomeFonte,CorFonteTituloCR, true,
                 false,CorFundoTituloCR,taLeftJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Contas a Receber';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha+2;

    //Contas a receber Previsto;
    inc(vpflinha);
    VpfDConta.LinContasReceberPrevisto := VpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false,  CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Contas a Receber Previsto';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCR,false,
                false,CorFundoCR,taRightJustify,vaCenter,bcComBorda,clBlack);

    //Contas a receber Duvidoso;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false, CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Contas a Receber Duvidoso';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false, CorFundoCR,taRightJustify,vaCenter,bcComBorda,clBlack);

    //Cobrança Prevista;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false,CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Cobrança Prevista';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false,CorFundoCR,taRightJustify,vaCenter,bcComBorda,clBlack);


    //Contas a Desconto Duplicatas;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR, false,
                false,CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.Cells[ColInicial+1,vpfLinha] := '(-) Desconto Duplicatas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false, CorFundoCR,taRightJustify,vaCenter,bcComBorda,clBlack);

    //Contas a Cheques a compensar;
    inc(vpflinha);
    VpfDConta.LinChequesaCompensarCR := VpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                 false,CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := '(+) Cheques a Compensar';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false,CorFundoCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    inc(Vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //Total Receitas;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCR,false,
                false, CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Total Receitas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    //Receitas Acumuladas;
    inc(vpflinha);
    VpfDConta.LinReceitasAcumuladas := VpfLinha;
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas-1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCR,false,
                false,CorFundoTituloCR,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Receitas Acumuladas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    //coloca a coluna do total em cinza
    VpaGrade.FormataCelula(VpaDFluxo.QtdColunas,VpaDFluxo.QtdColunas,VpfDConta.LinContasReceberPrevisto,VpfDConta.LinChequesaCompensarCR,TamanhoFonte,NomeFonte, CorFonteCaixa,false,
                false,CorFundoCaixa,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.FormataCelula(VpaDFluxo.QtdColunas,VpaDFluxo.QtdColunas,VpfDConta.LinReceitasAcumuladas-1,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCaixa,false,
                false,CorFundoCaixa,taRightJustify,vaCenter,bcComBorda,clBlack);

    inc(Vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //Titulo Contas a Pagar
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+2,NomeFonte,CorFonteTituloCP,true,
                false,CorFundoTituloCP, taLeftJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Contas a Pagar';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    //Contas a pagar;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCP,false,
                false,CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Contas a pagar';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false,CorFundoCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    //Contas a pagar;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false, CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Despesas Fixa';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false,CorFundoCP,taRightJustify,vaCenter,bcComBorda,clBlack);

    //Contas a pagar;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte ,CorFonteCP,false,
                false,CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Comissões';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false,CorFundoCP,taRightJustify,vaCenter,bcComBorda,clBlack);

    //Contas a pagar;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,ColInicial+1,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false, CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Cheques a compensar';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
    VpaGrade.FormataCelula(ColAplicacao,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, CorFonteCP,false,
                false,CorFundoCP,taRightJustify,vaCenter,bcComBorda,clBlack);

    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //Contas a pagar;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false,CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Total Despesas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    //Contas a pagar;
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,CorFonteCP,false,
                false,CorFundoTituloCP,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Despesas Acumuladas';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte+3,NomeFonte,clwhite,true,
                false,clWhite,taLeftJustify,vaCenter,bcComBorda,clBlack);
    //Totais
    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte,clwhite,false,
                false, clblue,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Total Conta ' + VpfDConta.NumContaCaixa+ ' :';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;

    inc(vpflinha);
    VpaGrade.FormataCelula(ColInicial,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, clwhite,false,
                false,clblue,taRightJustify,vaCenter,bcComBorda,clBlack);
    VpaGrade.cells[ColInicial+1,vpfLinha] := 'Total Acumulado Conta ' +VpfDConta.NumContaCaixa+ ' :';
    VpaGrade.RowHeights[vpfLinha] := AlturaLinha;
  end;

  inc(vpflinha);
  //Total dia
  inc(vpflinha);
  VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, clBlack,true,
              false,clGray,taRightJustify,vaCenter,bcComBorda,clBlack);
  VpaGrade.cells[ColInicial+1,vpfLinha] := 'Total : ';
  VpaGrade.RowHeights[vpfLinha] := AlturaLinha+2;

  //Total Acumulado
  inc(vpflinha);
  VpaDFluxo.LinTotalAcumulado := VpfLinha;
  VpaGrade.FormataCelula(ColInicial+1,VpaDFluxo.QtdColunas,VpfLinha,VpfLinha,TamanhoFonte,NomeFonte, clBlack,true,
              false,clGray,taRightJustify,vaCenter,bcComBorda,clBlack);
  VpaGrade.Cells[ColInicial+1,vpfLinha] := 'Total Acumulado : ';
  VpaGrade.RowHeights[vpfLinha] := AlturaLinha+2;
  VpaGrade.RowCount := vpfLinha+1;
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
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.InicializaFluxoDiario(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
var
  VpfLaco : Integer;
begin
  TamanhoGrade := 50;
  VpaGrade.ColCount := TamanhoGrade;
  InicializaGradeGeral(VpaGrade,VpaDFluxo);
  if VpaDFluxo.IndDiario then
    VpaDFluxo.QtdColunas := Dia(UltimoDiaMes(MontaData(1,VpaDFluxo.Mes,VpaDFluxo.Ano)))
  else
    VpaDFluxo.QtdColunas := 12;
  VpaGrade.ColCount := VpaDFluxo.QtdColunas + ColSaldoAtual+2;

  VpaGrade.ColWidths[ColInicial] := 10;
  for VpfLaco := 1 to VpaDFluxo.QtdColunas do
  begin
    VpaGrade.cells[ColSaldoAtual+VpfLaco,LinInicial] := IntToStr(VpfLaco);
    VpaGrade.FormataCelula(ColSaldoAtual+VpfLaco,ColSaldoAtual+VpfLaco,LinInicial,LinInicial,TamanhoFonte,NomeFonte,CorFonteCaixa,true,
                false,CorFundoCaixa,taRightJustify,vacenter,bcComBorda,clBlack);
  end;
  VpaGrade.cells[ColSaldoAtual+VpaDFluxo.QtdColunas+1,LinInicial] := 'Total';
  VpaGrade.FormataCelula(ColSaldoAtual+VpaDFluxo.QtdColunas+1,ColSaldoAtual+VpaDFluxo.QtdColunas+1,LinInicial,LinInicial,TamanhoFonte,NomeFonte,CorFonteCaixa,true,
                false,CorFundoCaixa,taRightJustify,vaCenter,bcComBorda,clBlack);
  VpaGrade.ColWidths[VpaDFluxo.QtdColunas+ColSaldoAtual+1] := 120;

  VpaDFluxo.QtdColunas := VpaDFluxo.QtdColunas+ColSaldoAtual+1;
end;

{******************************************************************************}
procedure TRBFuncoesFluxoCaixa.CarFluxoCaixa(VpaGrade :TRBStringGridColor;VpaDFluxo : TRBDFluxoCaixaCorpo);
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
