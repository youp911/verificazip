unit UnComissoes;
{Verificado
-.edit;
}
interface

uses
    Db, DBTables, classes, sysUtils, UnSistema, UnDadosCR, SQLExpr, Tabela;

// funcoes
type
  TFuncoesComissao = class
    Cadastro,
    Comissao : TSQL;
    Tabela : TSQLQuery;
  private
    procedure PosicionaComissao(VpaTabela : TDataSet; VpaCodfilial, VpaLanComissao : Integer);
    procedure PosicionaComisaoCR(VpaTabela : TDataSet; VpaCodFilial,VpLanReceber,VpaNumParcela : Integer);
    function RPerParcelaSobreValoTotal(VpaValTotal, VpaValParcela : Double):Double;
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor Destroy; override;
    function RSeqComissaoDisponivel(VpaCodFilial : Integer) : Integer;
    function VerificaComissaoPaga(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer ) : Boolean;overload;
    function VerificaComissaoPaga(VpaCodFilial, VpaLanReceber : Integer ) : Boolean;overload;
    procedure ExcluiTodaComissaoDireto(VpaCodfilial, VpaLanReceber : Integer);
    function ExcluiUmaComissao(VpaCodFilial, VpaLanReceber,VpaNumParcela : Integer) : string;
    procedure AlteraVencimentos(VpaCodFilial,VpaLanReceber, VpaNumParcela : integer; VpaNovaData : TDateTime);
    function EfetuaBaixaPagamento(VpaCodfilial,VpaLanComissao : Integer;VpaDatPagamento : TDateTime):String;
    function EstornaBaixaPagamento(VpaCodfilial,VpaLanComissao : Integer):String;
    function EfetuaLiberacao(VpaCodfilial,VpaLanComissao : Integer;VpaDatLiberacao : TDateTime):String;
    function EstornaLiberacao(VpaCodfilial,VpaLanComissao : Integer):String;
    procedure AlteraVendedor( VpaCodVendedor, VpaCodFilial, VpaLanComissao: Integer);
    procedure AlterarPerComissao(VpaCodFilial, VpaNumLancamento, VpaNumLanReceber, VpaNroParcela : Integer;VpaNovoPercentual : Double);
    procedure GeraParcelasComissao(VpaDNovaCR : TRBDContasCR;VpaDComissao : TRBDComissao);
    function GravaDComissoes(VpaDComissao : TRBDComissao) : string;
    function LiberaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : String;
    function EstornaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : string;
  end;

implementation

uses constMsg, constantes, funSql, funData, FunObjeto;



{#############################################################################
                        TFuncoesComissoes
#############################################################################  }

{ ****************** Na criação da classe ******************************** }
constructor TFuncoesComissao.cria(VpaBaseDados : TSQLConnection);
begin
  inherited;
    Comissao := TSQL.Create(nil);
    Comissao.ASQLConnection := VpaBaseDados;
    Cadastro := TSQL.Create(nil);
    Cadastro.ASQLConnection := VpaBaseDados;
    Tabela := TSQLQuery.Create(nil);
    Tabela.SQLConnection := VpaBaseDados;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesComissao.Destroy;
begin
    FechaTabela(Comissao);
    FechaTabela(tabela);
    Comissao.free;
    Cadastro.free;
    Tabela.free;
  inherited;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 funcoes de carregamento da classe
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{******************************************************************************}
function TFuncoesComissao.RSeqComissaoDisponivel(VpaCodFilial : Integer) : Integer;
begin
  AdicionaSQLAbreTabela(Tabela,'Select max(I_LAN_CON) ULTIMO FROM MOVCOMISSOES '+
                               ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial));
  result := Tabela.FieldByname('ULTIMO').AsInteger + 1;
  Tabela.close;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Exclusao da comissao
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{ ********************* exclui comisssao ************************************}
procedure TFuncoesComissao.ExcluiTodaComissaoDireto(VpaCodfilial, VpaLanReceber : Integer);
begin
  Sistema.GravaLogExclusao('MOVCOMISSOES','Select * from MOVCOMISSOES '+
                           ' where I_EMP_FIL = '+ InttoStr(VpaCodFilial) +
                           ' and I_LAN_REC = ' + IntToStr(VpaLanReceber));
  ExecutaComandoSql(Comissao,' Delete from MovComissoes ' +
                             ' where i_emp_fil = '+ InttoStr(VpaCodFilial) +
                             ' and I_LAN_REC = ' + IntToStr(VpaLanReceber));
end;

{ ********************* exclui uma única comisssao ************************************}
function TFuncoesComissao.ExcluiUmaComissao(VpaCodFilial, VpaLanReceber,VpaNumParcela : Integer) : string;
begin
  Result := '';
  // Exclui a comissão;
  if  VerificaComissaoPaga(VpaCodFilial, VpalanReceber, VpaNumParcela) then
  begin
    if not Confirmacao(CT_CanExcluiComissao) then
      result := 'COMISSAO PAGA!!!'#13'A comissão referente a esse título foi paga.';
  end;

  if result = '' then
  begin
    ExecutaComandoSql(comissao, ' Delete from MOVCOMISSOES '+
                                ' where I_EMP_FIL = '+ InttoStr(VpaCodFilial) +
                                ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                ' and I_NRO_PAR = ' + IntToStr(VpaNumParcela));
  end;
end;

{ *** verifica se a comissão foi paga *** }
function  TFuncoesComissao.VerificaComissaoPaga(VpaCodFilial, VpaLanReceber, VpaNumParcela : Integer ) : Boolean;
begin
  AdicionaSQLAbreTabela(Tabela, ' select I_EMP_FIL from MOVCOMISSOES ' +
                                ' where I_EMP_FIL = '+ InttoStr(VpaCodFilial) +
                                ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                ' and I_NRO_PAR = ' + IntToStr(VpaNumParcela) +
                                ' and not D_DAT_PAG is null ');
  Result := (not Tabela.EOF);
  FechaTabela(Tabela);
end;


{******************************************************************************}
function TFuncoesComissao.VerificaComissaoPaga(VpaCodFilial, VpaLanReceber : Integer ) : Boolean;
begin
  AdicionaSQLAbreTabela(Tabela, ' select I_EMP_FIL from MOVCOMISSOES ' +
                                ' where I_EMP_FIL = '+ InttoStr(VpaCodFilial) +
                                ' and I_LAN_REC = ' + IntToStr(VpaLanReceber) +
                                ' and not D_DAT_PAG is null ');
  Result := (not Tabela.EOF);
  FechaTabela(Tabela);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Altera o vencimento da comissao
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ***** Altera o venvimento da comissao ************************************* }
procedure TFuncoesComissao.AlteraVencimentos(VpaCodFilial,VpaLanReceber, VpaNumParcela : integer; VpaNovaData : TDateTime);
begin
  PosicionaComisaoCR(Comissao, VpaCodFilial,VpaLanReceber, VpaNumParcela);
  if not Comissao.eof then
  begin
    Comissao.edit;
    Comissao.FieldByName('D_DAT_VEN').Value := VpaNovaData;
    //atualiza a data de alteracao para poder exportar
    Comissao.FieldByName('D_ULT_ALT').AsDateTime := Date;
    Comissao.post;
  end;
  Comissao.close;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Manutencao de pagamentos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFuncoesComissao.PosicionaComissao(VpaTabela : TDataSet; VpaCodfilial, VpaLanComissao : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVCOMISSOES MOC ' +
                                  ' Where I_EMP_FIL = ' +IntToStr(VpaCodfilial)+
                                  ' and I_LAN_CON = ' +IntToStr(VpaLanComissao));
end;

{******************************************************************************}
procedure TFuncoesComissao.PosicionaComisaoCR(VpaTabela : TDataSet; VpaCodFilial,VpLanReceber,VpaNumParcela : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select * from MOVCOMISSOES MOC ' +
                                  ' Where I_EMP_FIL = ' +IntToStr(VpaCodfilial)+
                                  ' and I_LAN_REC = ' +IntToStr(VpLanReceber)+
                                  ' and I_NRO_PAR = ' +IntToStr(VpaNumParcela));
end;

{******************************************************************************}
function TFuncoesComissao.RPerParcelaSobreValoTotal(VpaValTotal, VpaValParcela : Double) : Double;
begin
  result := (VpaValParcela * 100)/VpaValTotal;
end;

{ ********** efetua baixas de pagamentos de parcelas ou de efetiva ********** }
function TFuncoesComissao.EfetuaBaixaPagamento(VpaCodfilial,VpaLanComissao : Integer;VpaDatPagamento : TDateTime):String;
begin
  result := '';
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.Edit;
  Comissao.FieldByName('D_DAT_PAG').AsDateTime := VpaDatPagamento;
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := Date;
  try
    Comissao.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DA BAIXA DA COMISSÃO!!!'#13+e.message;
  end;
  comissao.close;
end;

{******************************************************************************}
function TFuncoesComissao.EstornaBaixaPagamento(VpaCodfilial,VpaLanComissao : Integer):String;
begin
  result := '';
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.Edit;
  Comissao.FieldByName('D_DAT_PAG').clear;
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := Date;
  try
    Comissao.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DA BAIXA DA COMISSÃO!!!'#13+e.message;
  end;
  comissao.close;
end;

{******************************************************************************}
function TFuncoesComissao.EfetuaLiberacao(VpaCodfilial,VpaLanComissao : Integer;VpaDatLiberacao : TDateTime):String;
begin
  result := '';
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.Edit;
  Comissao.FieldByName('D_DAT_VAL').AsDateTime := VpaDatLiberacao;
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := Date;
  try
    Comissao.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DA BAIXA DA COMISSÃO!!!'#13+e.message;
  end;
  comissao.close;
end;

{******************************************************************************}
function TFuncoesComissao.EstornaLiberacao(VpaCodfilial,VpaLanComissao : Integer):String;
begin
  result := '';
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.Edit;
  Comissao.FieldByName('D_DAT_VAL').clear;
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := Date;
  try
    Comissao.post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DA BAIXA DA COMISSÃO!!!'#13+e.message;
  end;
  comissao.close;
end;

{******************************************************************************}
procedure TFuncoesComissao.AlteraVendedor( VpaCodVendedor, VpaCodFilial, VpaLanComissao : Integer);
begin
  PosicionaComissao(Comissao,VpaCodfilial,VpaLanComissao);
  Comissao.edit;
  Comissao.FieldByName('I_COD_VEN').AsInteger := VpaCodVendedor;
  //atualiza a data de alteracao para poder exportar
  Comissao.FieldByName('D_ULT_ALT').AsDateTime := Date;
  Comissao.post;
  Comissao.close;
end;

{******************************************************************************}
procedure TFuncoesComissao.AlterarPerComissao(VpaCodFilial, VpaNumLancamento, VpaNumLanReceber, VpaNroParcela : Integer;VpaNovoPercentual : Double);
begin
  AdicionaSqlAbreTabela(Tabela,'Select (MOV.N_VLR_PAR * MOE.N_VLR_DIA) Valor '+
                               ' from MOVCONTASARECEBER MOV, CADMOEDAS MOE ' +
                               ' Where MOV.I_EMP_FIL = '+IntTostr(VpaCodFilial)+
                               ' and MOV.I_LAN_REC = ' + IntToStr(VpaNumLanReceber)+
                               ' and MOV.I_NRO_PAR = '+ IntToStr(VpaNroParcela)+
                               ' and MOE.I_COD_MOE = MOV.I_COD_MOE');
  AdicionaSQLAbreTabela(Comissao,'Select * from MOVCOMISSOES MOC' +
                               ' Where MOC.I_EMP_FIL = '+IntTostr(VpaCodFilial)+
                               ' and MOC.I_LAN_CON = ' + IntToStr(VpaNumLancamento));
  Comissao.Edit;
  Comissao.FieldByName('N_VLR_COM').AsFloat := ((Tabela.FieldByName('Valor').AsFloat * VpaNovoPercentual)/100);
  Comissao.FieldByName('N_PER_COM').AsFloat := VpaNovoPercentual;
  Comissao.FieldByName('N_VLR_INI').AsFloat := ((Tabela.FieldByName('Valor').AsFloat * VpaNovoPercentual)/100);
  Comissao.post;

  Comissao.close;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFuncoesComissao.GeraParcelasComissao(VpaDNovaCR : TRBDContasCR;VpaDComissao : TRBDComissao);
var
  VpfDParcela : TRBDMovContasCR;
  VpfDParcelaComissao : TRBDComissaoItem;
  VpfLaco : Integer;
begin
  FreeTObjectsList(VpaDComissao.Parcelas);
  for VpfLaco := 0 to VpaDNovaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[VpfLaco]);
    VpfDParcelaComissao := VpaDComissao.AddParcela;
    VpfDParcelaComissao.NumParcela := VpfDParcela.NumParcela;
    VpfDParcelaComissao.DatVencimento := VpfDParcela.DatVencimento;
    if VpaDComissao.ValTotalComissao < 0 then
    begin
      VpfDParcelaComissao.ValComissaoParcela := VpaDComissao.ValTotalComissao;
      VpfDParcelaComissao.DatLiberacao := date;
    end
    else
    begin
      VpfDParcelaComissao.ValComissaoParcela := (VpaDComissao.ValTotalComissao * RPerParcelaSobreValoTotal(VpaDNovaCR.ValTotal,VpfDParcela.Valor))/100;
      VpfDParcelaComissao.DatLiberacao := montadata(1,1,1900);
    end;
  end;
end;

{******************************************************************************}
function TFuncoesComissao.GravaDComissoes(VpaDComissao : TRBDComissao) : string;
Var
  VpfLaco : Integer;
  VpfDParcela : TRBDComissaoItem;
begin
  result := '';
  if VpaDComissao.SeqComissao <> 0 then
    ExcluiTodaComissaoDireto(VpaDComissao.CodFilial,VpaDComissao.LanReceber);
  AdicionaSQLAbreTabela(Cadastro,'Select * from MOVCOMISSOES '+
                                 ' Where I_EMP_FIL = 0 AND I_LAN_CON = 0');
  for VpfLaco := 0 to VpaDComissao.Parcelas.count - 1 do
  begin
    VpfDParcela := TRBDComissaoItem(VpaDComissao.Parcelas.Items[VpfLaco]);
    Cadastro.insert;
    Cadastro.FieldByname('I_EMP_FIL').AsInteger := VpaDComissao.CodFilial;
    Cadastro.FieldByname('I_LAN_REC').AsInteger := VpaDComissao.LanReceber;
    Cadastro.FieldByname('I_NRO_PAR').AsInteger := VpfDParcela.NumParcela;
    Cadastro.FieldByname('I_COD_VEN').AsInteger := VpaDComissao.CodVendedor;
    Cadastro.FieldByname('D_DAT_VEN').AsDateTime := VpfDParcela.DatVencimento;
    if VpfDParcela.DatPagamento > montadata(1,1,1900) then
      Cadastro.FieldByname('D_DAT_PAG').AsDateTime := VpfDParcela.DatPagamento;
    if VpfDParcela.DatLiberacao > montadata(1,1,1900) then
      Cadastro.FieldByname('D_DAT_VAL').AsDateTime := VpfDParcela.DatLiberacao;
    Cadastro.FieldByname('N_VLR_COM').AsFloat := VpfDParcela.ValComissaoParcela;
    Cadastro.FieldByname('N_VLR_INI').AsFloat := VpfDParcela.ValComissaoParcela;
    Cadastro.FieldByname('I_TIP_COM').AsInteger := VpaDComissao.TipComissao;
    if VpaDComissao.PerComissao <> 0 then
      Cadastro.FieldByname('N_PER_COM').AsFloat := VpaDComissao.PerComissao;
    Cadastro.FieldByname('L_OBS_COM').AsString := VpaDComissao.DesObservacao;
    Cadastro.FieldByname('D_DAT_EMI').AsDateTime := VpaDComissao.DatEmissao;
    Cadastro.FieldByname('D_ULT_ALT').AsDateTime := now;
    VpaDComissao.SeqComissao := RSeqComissaoDisponivel(VpaDComissao.CodFilial);
    Cadastro.FieldByname('I_LAN_CON').AsInteger := VpaDComissao.SeqComissao;
    try
      Cadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVAÇÃO DA COMISSÃO!!!'#13+e.message;
        break;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TFuncoesComissao.LiberaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : String;
begin
  result := '';
  PosicionaComisaoCR(Comissao,VpaCodfilial,VpaLanReceber,VpaNumParcela);
  while  not Comissao.eof do
  begin
    Comissao.Edit;
    Comissao.FieldByName('D_DAT_VAL').AsDateTime := date;
    Comissao.FieldByName('D_ULT_ALT').AsDateTime := Date;
    try
      Comissao.post;
    except
      on e : exception do result := 'ERRO NA GRAVAÇÃO DA BAIXA DA COMISSÃO!!!'#13+e.message;
    end;
    Comissao.next;
  end;
  comissao.close;
end;

{******************************************************************************}
function TFuncoesComissao.EstornaComissao(VpaCodFilial,VpaLanReceber,VpaNumParcela : Integer) : string;
begin
  result := '';
  PosicionaComisaoCR(Comissao,VpaCodfilial,VpaLanReceber,VpaNumParcela);
  if not Comissao.Eof then
  begin
    if not Comissao.FieldByname('D_DAT_PAG').IsNull then
      result := 'COMISSÃO PAGA!!!'#13'Não é possivel concluir a operação pois a comissão já foi paga para o vendedor';

    if result = '' then
    begin
      Comissao.Edit;
      Comissao.FieldByName('D_DAT_VAL').clear;
      Comissao.FieldByName('D_ULT_ALT').AsDateTime := Date;
      try
        Comissao.post;
      except
        on e : exception do result := 'ERRO NA GRAVAÇÃO DA BAIXA DA COMISSÃO!!!'#13+e.message;
      end;
    end;
  end;
  comissao.close;
end;

end.
