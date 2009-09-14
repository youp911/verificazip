unit AImpProduto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  QuickRpt, ExtCtrls, Geradores, Db, DBTables, Qrctrls, UnProdutos,
  qrBarcode;

type
  TFImpProduto = class(TForm)
    R001FichaTecnica: TQuickRepNovo;
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    Produto: TQuery;
    QRLabel1: TQRLabel;
    I001Imagem: TQRImage;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel4: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape1: TQRShape;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel7: TQRLabel;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel11: TQRLabel;
    QRDBText10: TQRDBText;
    QRLabel12: TQRLabel;
    LTipoFundo: TQRLabel;
    R002AmostrasSemVendas: TQuickRepNovo;
    AmostrasSemVendas: TQuery;
    PageHeaderBand2: TQRBand;
    DetailBand2: TQRBand;
    SummaryBand1: TQRBand;
    PageFooterBand2: TQRBand;
    QRLabel13: TQRLabel;
    QRShape2: TQRShape;
    L002Periodo: TQRLabel;
    QRDBText11: TQRDBText;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRDBText12: TQRDBText;
    QRSysData3: TQRSysData;
    QRShape3: TQRShape;
    QRSysData4: TQRSysData;
    QRSysData5: TQRSysData;
    R003FichaTecnicaKairos: TQuickRepNovo;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRLabel16: TQRLabel;
    I003Imagem: TQRImage;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRLabel19: TQRLabel;
    QRDBText16: TQRDBText;
    QRBand3: TQRBand;
    QRShape4: TQRShape;
    QRSysData6: TQRSysData;
    QRSysData7: TQRSysData;
    QRLabel29: TQRLabel;
    L003Embalagem: TQRLabel;
    QRLabel20: TQRLabel;
    L003Acondicionamento: TQRLabel;
    QRLabel22: TQRLabel;
    Q003Combinacoes: TQRSubDetail;
    Combinacoes: TQuery;
    QRDBText17: TQRDBText;
    L003Consumos: TQRLabel;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText22: TQRDBText;
    QRGroup1: TQRGroup;
    QRDBText23: TQRDBText;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    L003QtdMateriaPrima: TQRLabel;
    QRBand4: TQRBand;
    QRShape5: TQRShape;
    L003TituloRendimento: TQRLabel;
    L003Rendimento: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    Estagios: TQuery;
    QRDBText20: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRDBText26: TQRDBText;
    QRDBText27: TQRDBText;
    QRDBText28: TQRDBText;
    QRGroup2: TQRGroup;
    QRLabel21: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Q003CombinacoesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    FunProduto : TFuncoesProduto;
    procedure PosicionaProduto(VpaSeqProduto : String);
    procedure PosicionaCombinacoes(VpaSeqProduto : String);
    procedure PosicionaEstagiosProduto(VpaSeqProduto : String);
    procedure CarSelectAmostrasSemVendas(VpaDatInicial, VpaDatFinal : TDateTime);
  public
    { Public declarations }
    procedure ImprimeProduto(VpaSeqProduto : String);
    procedure ImprimeAmostrasSemVendas(VpaDatInicial, VpaDatFinal : TDateTime;VpaVisualizar : Boolean);
  end;

var
  FImpProduto: TFImpProduto;

implementation

uses APrincipal,FunSql,Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImpProduto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunProduto := TFuncoesProduto.criar(Application,FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImpProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Produto.close;
  AmostrasSemVendas.close;
  Estagios.close;
  Combinacoes.close;
  FunProduto.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImpProduto.PosicionaProduto(VpaSeqProduto : String);
begin
  AdicionaSQLAbreTabela(Produto,'Select * from CADPRODUTOS '+
                                ' Where I_SEQ_PRO = ' + VpaSeqProduto+
                                ' and I_COD_EMP = ' + IntToStr(Varia.codigoEmpresa));
end;

{******************************************************************************}
procedure TFImpProduto.PosicionaCombinacoes(VpaSeqProduto : String);
begin
  AdicionaSQLAbreTabela(Combinacoes,'select KIT.I_COR_KIT ,KIT.I_SEQ_PRO, KIT.N_QTD_PRO, KIT.I_COD_COR, KIT.C_COD_UNI, KIT.I_SEQ_MOV, '+
                                    ' COR1.NOM_COR CORKIT , COR2.NOM_COR, '+
                                    ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_PRA_PRO '+
                                    ' from MOVKIT KIT, COR COR1, COR COR2, CADPRODUTOS PRO '+
                                    ' Where KIT.I_COR_KIT = COR1.COD_COR '+
                                    ' AND KIT.I_COD_COR = COR2.COD_COR ' +
                                    ' AND KIT.I_SEQ_PRO = PRO.I_SEQ_PRO'+
                                    ' AND KIT.I_PRO_KIT = ' + VpaSeqProduto+
                                    ' AND KIT.I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa)+
                                    ' order by KIT.I_COR_KIT, KIT.I_SEQ_MOV');
end;

{******************************************************************************}
procedure TFImpProduto.PosicionaEstagiosProduto(VpaSeqProduto : String);
begin
  AdicionaSQLAbreTabela(Estagios,'select ESP.SEQESTAGIO, ESP.NUMORDEM, ESP.CODESTAGIO, ESP.DESESTAGIO, ESP.QTDPRODUCAOHORA, '+
                                 ' ESP.CODESTAGIOANTERIOR, '+
                                 ' EST.NOMEST ' +
                                 ' from PRODUTOESTAGIO ESP , ESTAGIOPRODUCAO EST '+
                                 ' Where ESP.CODESTAGIO = EST.CODEST ' +
                                 ' and SEQPRODUTO = ' +VpaSeqProduto+
                                 ' ORDER BY ESP.NUMORDEM');

end;

{******************************************************************************}
procedure TFImpProduto.CarSelectAmostrasSemVendas(VpaDatInicial, VpaDatFinal : TDateTime);
begin
  AdicionaSQLAbreTabela(AmostrasSemVendas,'select * from CADPRODUTOS CAD '+
                                ' where exists (select * from ORDEMPRODUCAOCORPO PRO ' +
                                ' where CAD.I_SEQ_PRO = PRO.SEQPRO '+
                                ' and PRO.TIPPED = 0 '+
                                 SQLTextoDataEntreAAAAMMDD('DATEMI',VpaDatInicial,VpaDatFinal,true)+ '  ) '+
                                ' and not exists(select * from ORDEMPRODUCAOCORPO PR1 '+
                                '      where  CAD.I_SEQ_PRO = PR1.SEQPRO '+
                                '      and PR1.TIPPED = 1)');

end;

{******************************************************************************}
procedure TFImpProduto.ImprimeProduto(VpaSeqProduto : String);
begin
  PosicionaProduto(VpaSeqProduto);
  if (varia.CNPJFilial = CNPJ_Kairos) or (varia.CNPJFilial = CNPJ_AviamentosJaragua) then
  begin
    PosicionaCombinacoes(VpaSeqProduto);
    PosicionaEstagiosProduto(VpaSeqProduto);
    R003FichaTecnicaKairos.preview;
  end
  else
  begin
    R001FichaTecnica.Preview;
  end;
end;

{******************************************************************************}
procedure TFImpProduto.ImprimeAmostrasSemVendas(VpaDatInicial, VpaDatFinal : TDateTime;VpaVisualizar : Boolean);
begin
  CarSelectAmostrasSemVendas(VpaDatInicial,VpaDatFinal);
  L002Periodo.Caption := 'Período de : '+FormatDateTime('DD/MM/YYYY',VpaDatInicial)+' até : '+FormatDateTime('DD/MM/YYYY',VpaDatFinal);
  if VpaVisualizar then
    R002AmostrasSemVendas.Preview
  else
    R002AmostrasSemVendas.print;
end;

{******************************************************************************}
procedure TFImpProduto.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Produto.FieldByName('I_COD_FUN').AsInteger <> 0 then
    LTipoFundo.Caption := Produto.FieldByName('I_COD_FUN').AsString + ' - '+ FunProduto.RNomeFundo(Produto.FieldByName('I_COD_FUN').AsString)
  else
    LTipoFundo.Caption := '';
  try
    I001Imagem.Picture.LoadFromFile(Varia.DriveFoto+ Produto.FieldByName('C_PAT_FOT').AsString);
  except
  end;
end;

{******************************************************************************}
procedure TFImpProduto.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  VpfRendimento : TStringList;
begin
  L003Embalagem.caption := '';
  L003Acondicionamento.Caption := '';
  if Produto.FieldByName('I_COD_EMB').AsInteger <> 0 then
    L003Embalagem.Caption := Produto.FieldByName('I_COD_EMB').AsString + '-'+ FunProduto.RNomeEmbalagem(Produto.FieldByName('I_COD_EMB').AsInteger);
  if Produto.FieldByName('I_COD_ACO').AsInteger <> 0 then
    L003Acondicionamento.Caption := Produto.FieldByName('I_COD_ACO').AsString + '-'+ FunProduto.RNomAcondicionamento(Produto.FieldByName('I_COD_ACO').AsInteger);
  if Produto.FieldByName('C_PAT_FOT').AsString <> '' then
  begin
    try
      I003Imagem.Picture.LoadFromFile(Varia.DriveFoto+ Produto.FieldByName('C_PAT_FOT').AsString);
    except
    end;
  end;
  VpfRendimento := TStringList.Create;
  VpfRendimento.Text := Produto.FieldByName('C_REN_PRO').AsString;
  L003Rendimento.Height := VpfRendimento.Count * 17;
  QRBand2.Height := L003Rendimento.Top+L003Rendimento.Height+30;
  L003Consumos.Top := L003Rendimento.Top+L003Rendimento.Height+5;
  VpfRendimento.free;
  if L003Rendimento.Height = 0 then
    L003TituloRendimento.Caption := '';
end;

procedure TFImpProduto.Q003CombinacoesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  L003QtdMateriaPrima.Caption := FormatFloat('###,###,##0.00####',Combinacoes.FieldByName('N_QTD_PRO').AsFloat);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImpProduto]);
end.
