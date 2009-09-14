Unit UnEntradaMetros;

Interface

Uses Classes, DBTables, vcf1, SysUtils,Graphics,SQLExpr,db;

Const
  LinInicial = 1;
  LinFinal = 20;
  ColInicial = 1;
  ColTituloGrade = 2;
  LinTituloGrade = 4;
  ColAplicacao = 3;
  ColSaldoAnterior = 4;
  ColFinal = 20;


//classe localiza
Type TRBLocalizaEntradaMetros = class
  private
  public
    constructor cria;
    procedure PosEntradaMetros(VpaTabela : TDataSet;VpaDatInicio, VpaDatFim : TDateTime);
end;
//classe funcoes
Type TRBFuncoesEntradaMetros = class(TRBLocalizaEntradaMetros)
  private
    CorFonte,
    CorTitulo,
    CorFundoCaixa,
    CorFonteNegativo,
    CorFonteTituloGrade,
    CorFonteGrade,
    CorFundoTituloGrade,
    CorFundoGrade,
    CorFonteCP,
    CorFonteTituloCP,
    CorFundoTituloCP: TColor;
    // fonte
    TamanhoFonte : integer;
    NomeFonte : string;
    AlturaLinha : Integer;
    Tabela : TSQLQuery;
    procedure InicializaGradeGeral(VpaGrade : TF1Book);
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    procedure CarregaCores(VpaCorFonte, VpaCorFonteTituloGrade, VpaCorFonteGrade, VpaCorTitulo, VpaCorFundoTituloGrade, VpaCorFundoGrade: TColor; VpaNomFonte : string; VpaTamFonte,VpaAltLinha : Integer);
    procedure CarTituloGrade(VpaGrade : TF1Book;VpaDatInicio, VpaDatFim : TDateTime);
    procedure CarEntradaMetros(VpaGrade : TF1Book;VpaDatInicio, VpaDatFim : TDateTime);
end;



implementation

Uses FunSql, funObjeto;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaEntradaMetros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaEntradaMetros.cria;
begin
  inherited create;
end;

{******************************************************************************}
procedure TRBLocalizaEntradaMetros.PosEntradaMetros(VpaTabela : TDataSet;VpaDatInicio, VpaDatFim : TDateTime);
begin
  AdicionaSQLAbreTabela(VpaTabela,'SELECT MET.DATENTRADA, MET.CODCLASSIFICACAO, MET.QTDMETROAMOSTRA, MET.QTDMETROPEDIDO, MET.QTDMETROTOTAL, '+
                                  ' MET.VALAMOSTRA, MET.VALPEDIDO, MET.VALTOTAL, '+
                                  ' CLA.C_NOM_CLA '+
                                  ' FROM  ENTRADAMETRODIARIO MET, CADCLASSIFICACAO CLA '+
                                  ' WHERE MET.CODCLASSIFICACAO = CLA.C_COD_CLA '+
                                  ' AND CLA.C_TIP_CLA = ''P'''+
                                  ' ORDER BY CODCLASSIFICACAO');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesEntradaMetros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesEntradaMetros.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesEntradaMetros.destroy;
begin
  Tabela.free;
  inherited destroy;
end;

{******************************************************************************}
procedure TRBFuncoesEntradaMetros.InicializaGradeGeral(VpaGrade : TF1Book);
begin
  FormataCelula(VpaGrade,LinInicial,LinInicial,ColInicial,ColInicial,TamanhoFonte+2,clwhite,clblue,true,
                false,NomeFonte);

//  FormataCelula(VpaGrade,ColAplicacao,ColSaldoAnterior,LinInicial,LinInicial,TamanhoFonte,CorFundoCaixa,CorFonteCaixa,true,
//                false,NomeFonte);
  FormataBordaCelula(VpaGrade,ColTituloGrade,ColTituloGrade+6,LinTituloGrade,LinTituloGrade+1,clBlack,false);
  VpaGrade.SetRowHeight(LinInicial,LinInicial,AlturaLinha+100,false);
  VpaGrade.ColWidth[ColInicial] := 500;
  VpaGrade.ColWidth[ColTituloGrade] := 7500;
  VpaGrade.ColWidth[ColTituloGrade+1] := 3500;
  VpaGrade.ColWidth[ColTituloGrade+2] := 3500;
  VpaGrade.ColWidth[ColTituloGrade+3] := 3500;
  VpaGrade.ColWidth[ColTituloGrade+4] := 3500;
  VpaGrade.ColWidth[ColTituloGrade+5] := 3500;
  VpaGrade.ColWidth[ColTituloGrade+6] := 3500;
end;

{******************************************************************************}
procedure TRBFuncoesEntradaMetros.CarTituloGrade(VpaGrade : TF1Book;VpaDatInicio, VpaDatFim : TDateTime);
begin
  InicializaGradeGeral(VpaGrade);
  FormataCelula(VpaGrade,ColTituloGrade,ColTituloGrade+6,LinTituloGrade,LinTituloGrade+1,TamanhoFonte,CorFundoTituloGrade,CorFonteTituloGrade,true,
                false,NomeFonte);

  VpaGrade.TextRC[1,1] := 'Entrada Metros  '+FormatDateTime('DD/MM/YYYY',VpaDatInicio)+ ' - '+FormatDateTime('DD/MM/YYYY',VpaDatFim);
  VpaGrade.TextRC[LinTituloGrade,ColTituloGrade] := 'Familia';
  VpaGrade.TextRC[LinTituloGrade,ColTituloGrade+1] := 'Amostra';
  VpaGrade.TextRC[LinTituloGrade,ColTituloGrade+3] := 'Pedidos';
  VpaGrade.TextRC[LinTituloGrade,ColTituloGrade+5] := 'Total';
  VpaGrade.TextRC[LinTituloGrade+1,ColTituloGrade+1] := 'Metros';
  VpaGrade.TextRC[LinTituloGrade+1,ColTituloGrade+2] := 'Valor';
  VpaGrade.TextRC[LinTituloGrade+1,ColTituloGrade+3] := 'Metros';
  VpaGrade.TextRC[LinTituloGrade+1,ColTituloGrade+4] := 'Valor';
  VpaGrade.TextRC[LinTituloGrade+1,ColTituloGrade+5] := 'Metros';
  VpaGrade.TextRC[LinTituloGrade+1,ColTituloGrade+6] := 'Valor';
end;

{******************************************************************************}
procedure TRBFuncoesEntradaMetros.CarregaCores(VpaCorFonte, VpaCorFonteTituloGrade, VpaCorFonteGrade, VpaCorTitulo, VpaCorFundoTituloGrade, VpaCorFundoGrade: TColor; VpaNomFonte : string; VpaTamFonte,VpaAltLinha : Integer);
begin
  CorFonte := VpaCorFonte;
  CorTitulo := VpaCorTitulo;
  CorFonteTituloGrade := VpaCorFonteTituloGrade;
  CorFonteGrade := VpaCorFonteGrade;
  CorFundoTituloGrade := VpaCorFundoTituloGrade;
  CorFundoGrade := VpaCorFundoGrade;


  TamanhoFonte :=  VpaTamFonte;
  NomeFonte := VpaNomFonte;

  AlturaLinha := VpaAltLinha;
end;

{******************************************************************************}
procedure TRBFuncoesEntradaMetros.CarEntradaMetros(VpaGrade : TF1Book;VpaDatInicio, VpaDatFim : TDateTime);
var
  VpfMetroAmostra, VpfMetrosPedido, VpfMetrosItem, VpfMetrosTotal : Double;
  VpfValAmostra, VpfValPedido, VpfValItem, VpfValTotal : Double;
  VpfCodClassificacao, VpfNomClassificacao : String;
  VpfLinha : Integer;
begin
  PosEntradaMetros(Tabela,VpaDatInicio,VpaDatFim);
  VpfCodClassificacao := '';
  VpfLinha := 5;
  while not Tabela.eof do
  begin
    if VpfCodClassificacao <> Tabela.FieldByName('CODCLASSIFICACAO').AsString then
    begin
      if VpfCodClassificacao <> '' then
      begin
        inc(vpflinha);
        VpaGrade.TextRC[VpfLinha,ColTituloGrade] := VpfNomClassificacao;
        FormataCelula(VpaGrade,ColTituloGrade,ColTituloGrade,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloGrade,CorFonteTituloGrade,true,
                false,NomeFonte);
        VpaGrade.TextRC[VpfLinha,ColTituloGrade+1] := FormatFloat('#,###,###,##0.00',VpfMetroAmostra);
        VpaGrade.TextRC[VpfLinha,ColTituloGrade+2] := FormatFloat('#,###,###,##0.00',VpfValAmostra);
        VpaGrade.TextRC[VpfLinha,ColTituloGrade+3] := FormatFloat('#,###,###,##0.00',VpfMetrosPedido);
        VpaGrade.TextRC[VpfLinha,ColTituloGrade+4] := FormatFloat('#,###,###,##0.00',VpfValPedido);
        VpaGrade.TextRC[VpfLinha,ColTituloGrade+5] := FormatFloat('#,###,###,##0.00',VpfMetrosItem);
        VpaGrade.TextRC[VpfLinha,ColTituloGrade+6] := FormatFloat('#,###,###,##0.00',VpfValItem);
      end;
      VpfMetroAmostra :=0;
      VpfMetrosPedido :=0;
      VpfMetrosItem := 0;
      VpfValAmostra := 0;
      VpfValPedido :=0;
      VpfValItem := 0;
      VpfCodClassificacao := Tabela.FieldByName('CODCLASSIFICACAO').AsString;
      VpfNomClassificacao := Tabela.FieldByName('C_NOM_CLA').AsString;
    end;
    VpfMetroAmostra := VpfMetroAmostra + Tabela.FieldByName('QTDMETROAMOSTRA').AsFloat;
    VpfMetrosPedido := VpfMetrosPedido + Tabela.FieldByName('QTDMETROPEDIDO').AsFloat;
    VpfMetrosItem := VpfMetrosItem + Tabela.FieldByName('QTDMETROTOTAL').AsFloat;
    VpfValAmostra := VpfValAmostra + Tabela.FieldByName('VALAMOSTRA').AsFloat;
    VpfValPedido := VpfValPedido + Tabela.FieldByName('VALPEDIDO').AsFloat;
    VpfValItem := VpfValItem + Tabela.FieldByName('VALTOTAL').AsFloat;
    Tabela.next;
  end;
  if VpfCodClassificacao <> '' then
  begin
    inc(vpflinha);
    FormataCelula(VpaGrade,ColTituloGrade,ColTituloGrade,VpfLinha,VpfLinha,TamanhoFonte,CorFundoTituloGrade,CorFonteTituloGrade,true,
               false,NomeFonte);
    VpaGrade.TextRC[VpfLinha,ColTituloGrade] := VpfNomClassificacao;
    VpaGrade.TextRC[VpfLinha,ColTituloGrade+1] := FormatFloat('#,###,###,##0.00',VpfMetroAmostra);
    VpaGrade.TextRC[VpfLinha,ColTituloGrade+2] := FormatFloat('#,###,###,##0.00',VpfValAmostra);
    VpaGrade.TextRC[VpfLinha,ColTituloGrade+3] := FormatFloat('#,###,###,##0.00',VpfMetrosPedido);
    VpaGrade.TextRC[VpfLinha,ColTituloGrade+4] := FormatFloat('#,###,###,##0.00',VpfValPedido);
    VpaGrade.TextRC[VpfLinha,ColTituloGrade+5] := FormatFloat('#,###,###,##0.00',VpfMetrosItem);
    VpaGrade.TextRC[VpfLinha,ColTituloGrade+6] := FormatFloat('#,###,###,##0.00',VpfValItem);
  end;
  FormataBordaCelula(VpaGrade,ColTituloGrade,ColTituloGrade+6,LinTituloGrade+2,VpfLinha,clBlack,false);
  Tabela.close;
end;

end.
