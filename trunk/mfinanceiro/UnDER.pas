Unit UnDER;

Interface

Uses Classes, DBTables, UnDadosCR, SysUtils,Graphics, vcf1;

Const
  LinInicial = 1;
  LinFinal = 20;
  ColFinal = 20;
  ColInicial = 1;
  ColDescricao = 2;
  ColOrcado = 3;
  ColRealizado = 4;
  ColDiferenca = 5;


//classe localiza
Type TRBLocalizaDER = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesDER = class(TRBLocalizaDER)
  private
    CorFonteTitulo,
    CorFundoTitulo,
    CorFonteNegativo,
    CorFonteTituloReceitas,
    CorFonteReceitas,
    CorFundoTituloReceitas,
    CorFundoReceitas,
    CorFundoDespesas,
    CorFonteDespesas,
    CorFonteTituloDespesas,
    CorFundoTituloDespesas: TColor;

    // fonte
    TamanhoFonte : integer;
    NomeFonte : string;
    AlturaLinha : Integer;

    TamanhoGrade : Integer;

    Aux,
    DER :TQuery;
    procedure InicializaGradeGeral(VpaGrade : TF1Book;VpaDDER : TRBDDERCorpo);
    procedure CarVendedoresGrade(VpaGrade :TF1Book;VpaDDEr : TRBDDERCorpo);
  public
    constructor cria;
    procedure CarMetasVendedores(VpaDDER : TRBDDERCorpo);
    procedure CarTitulosGrade(VpaGrade : TF1Book;VpaDFluxo : TRBDDERCorpo);
    procedure CarregaCores(VpaCorFonteTitulo, VpaCorFundoTitulo, VpaCorFonteNegativo, VpaCorFonteTituloReceitas, VpaCorFonteReceitas, VpaCorFundoTituloReceitas, VpaCorFundoReceitas, VpaCorFonteDespesas,VpaCorFundoDespesas, VpaCorFonteTituloDespesas, VpaCorFundoTituloDespesas: TColor; VpaNomFonte : string; VpaTamFonte,VpaAltLinha : Integer);
    procedure LimpaFluxo(VpaGrade : TF1Book);
    procedure InicializaDER(VpaGrade :TF1Book;VpaDFluxo : TRBDDERCorpo);
    procedure CarDER(VpaGrade :TF1Book;VpaDDER : TRBDDERCorpo);
end;



implementation

Uses FunSql, FunObjeto, FunData;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaDER
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaDER.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesDER
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesDER.cria;
begin
  inherited create;
  Aux := TQuery.Create(nil);
  Aux.DataBaseName := 'BaseDados';

  DER := TQuery.Create(nil);
  DER.DataBaseName := 'BaseDados';
end;

{******************************************************************************}
procedure TRBFuncoesDER.InicializaGradeGeral(VpaGrade : TF1Book;VpaDDER : TRBDDERCorpo);
begin
  if VpaDDER.IndMensal then
    VpaGrade.TextRC[LinInicial,ColDescricao] := 'DER : '+TextoMes(MontaData(1,VpaDDER.Mes,VpaDDER.Ano),false) + ' de '+IntToStr(VpaDDER.Ano)
  else
    VpaGrade.TextRC[LinInicial,ColDescricao] := 'DER : '+IntToStr(VpaDDER.Ano);
  FormataCelula(VpaGrade,ColDescricao,ColDescricao,LinInicial,LinInicial,TamanhoFonte+2,clwhite,clblue,true,
                false,NomeFonte);
  VpaGrade.TextRC[LinInicial+1,ColOrcado] := 'Orçado';
  VpaGrade.TextRC[LinInicial+1,ColRealizado] := 'Realizado';
  VpaGrade.TextRC[LinInicial+1,ColDiferenca] := 'Diferença';

  FormataCelula(VpaGrade,ColOrcado,ColDiferenca,LinInicial+1,LinInicial+1,TamanhoFonte,CorFundoTitulo,CorFonteTitulo,true,
                false,NomeFonte);
  FormataBordaCelula(VpaGrade,ColOrcado,ColDiferenca,LinInicial+1,LinInicial+1,clBlack,false);
  VpaGrade.SetRowHeight(LinInicial,LinInicial,AlturaLinha+100,false);
  VpaGrade.ColWidth[ColInicial] := 500;
  VpaGrade.ColWidth[ColDescricao] := 8000;
  VpaGrade.ColWidth[ColOrcado] := 3500;
  VpaGrade.ColWidth[ColRealizado] := 3500;
  VpaGrade.ColWidth[ColDiferenca] := 3500;
end;

{******************************************************************************}
procedure TRBFuncoesDER.CarVendedoresGrade(VpaGrade :TF1Book;VpaDDEr : TRBDDERCorpo);
var
  VpfLaco,VpfLinha : Integer;
  VpfDVendedor : TRBDDERVendedor;
begin
  VpfLinha := LinInicial +2;
  for VpfLaco := 0 to VpaDDEr.Vendedores.Count - 1 do
  begin
    VpfDVendedor := TRBDDERVendedor(VpaDDEr.Vendedores.Items[VpfLaco]);
    VpaGrade.TextRC[Vpflinha,ColDescricao] := VpfDVendedor.NomVendedor;
    VpaGrade.TextRC[Vpflinha,ColOrcado] := FormatFloat('#,###,###,##0.00', VpfDVendedor.ValMeta);

    inc(VpfLinha);
  end;
end;

{******************************************************************************}
procedure TRBFuncoesDER.CarMetasVendedores(VpaDDER : TRBDDERCorpo);
var
  VpfDVendedor : TRBDDERVendedor;
begin
  AdicionaSQLAbreTabela(DER,'SELECT VEN.I_COD_VEN, VEN.C_NOM_VEN , '+
                            '  MET.VALMETA '+
                            ' FROM CADVENDEDORES VEN, METAVENDEDOR MET '+
                            ' Where VEN.I_COD_VEN = MET.CODVENDEDOR '+
                            ' AND MET.ANOMETA = '+IntToStr(VpaDDER.Ano)+
                            ' and MET.MESMETA = '+IntToStr(VpaDDER.Mes));
  While not DER.eof do
  begin
    VpfDVendedor := VpaDDER.addVendedor;
    VpfDVendedor.CodVendedor := DER.FieldByName('I_COD_VEN').AsInteger;
    VpfDVendedor.NomVendedor := DER.FieldByName('C_NOM_VEN').AsString;
    VpfDVendedor.ValMeta := DER.FieldByName('VALMETA').AsFloat;
    DER.next;
  end;
  DER.close;
end;

{******************************************************************************}
procedure TRBFuncoesDER.CarTitulosGrade(VpaGrade : TF1Book;VpaDFluxo : TRBDDERCorpo);
begin

end;

{******************************************************************************}
procedure TRBFuncoesDER.CarregaCores(VpaCorFonteTitulo, VpaCorFundoTitulo, VpaCorFonteNegativo, VpaCorFonteTituloReceitas, VpaCorFonteReceitas, VpaCorFundoTituloReceitas, VpaCorFundoReceitas, VpaCorFonteDespesas,VpaCorFundoDespesas, VpaCorFonteTituloDespesas, VpaCorFundoTituloDespesas: TColor; VpaNomFonte : string; VpaTamFonte,VpaAltLinha : Integer);
begin
  CorFonteTitulo := VpaCorFonteTitulo;
  CorFundoTitulo := VpaCorFundoTitulo;
  CorFonteNegativo := VpaCorFonteNegativo;
  CorFonteTituloDespesas := VpaCorFonteTituloReceitas;
  CorFonteDespesas := VpaCorFonteReceitas;
  CorFundoTituloDespesas := VpaCorFundoTituloReceitas;
  CorFundoDespesas := VpaCorFundoDespesas;
  CorFonteDespesas := VpaCorFonteDespesas;
  CorFundoDespesas := VpaCorFundoDespesas;
  CorFonteTituloDespesas := VpaCorFonteTituloDespesas;
  CorFundoTituloDespesas := VpaCorFundoTituloDespesas;

  TamanhoFonte :=  VpaTamFonte;
  NomeFonte := VpaNomFonte;

  AlturaLinha := VpaAltLinha;
end;

{******************************************************************************}
procedure TRBFuncoesDER.LimpaFluxo(VpaGrade : TF1Book);
begin
  LimpaGrade(VpaGrade,ColInicial,ColFinal,LinInicial,LinFinal);
end;

{******************************************************************************}
procedure TRBFuncoesDER.InicializaDER(VpaGrade :TF1Book;VpaDFluxo : TRBDDERCorpo);
begin
  TamanhoGrade := 6;
  VpaGrade.MaxCol := TamanhoGrade;
  InicializaGradeGeral(VpaGrade,VpaDFluxo);
end;

{******************************************************************************}
procedure TRBFuncoesDER.CarDER(VpaGrade :TF1Book;VpaDDER : TRBDDERCorpo);
begin
  CarMetasVendedores(VpaDDER);
  CarVendedoresGrade(VpaGrade,VpaDDER);
end;

end.
