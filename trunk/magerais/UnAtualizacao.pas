Unit UnAtualizacao;

interface
  Uses Classes, DbTables,SysUtils, APrincipal, Windows, Forms, UnVersoes,
       SQLExpr,IniFiles ;

Const
  CT_VersaoBanco = 1557;
  CT_VersaoInvalida = 'SISTEMA DESATUALIZADO!!! Este sistema já possui novas versões, essa versão pode não funcionar corretamente,  para o bom funcionamento do mesmo é necessário fazer a atualização...' ;

  CT_SenhaAtual = '9774';


Type
  TAtualiza = Class
    Private
      Aux : TSQLQuery;
      VprBaseDados : TSQLConnection;
      procedure AtualizaSenha( Senha : string );
      procedure AlteraVersoesSistemas(VpaNomCampo, VpaDesVersao : String);
      procedure VerificaVersaoSistema;
    public
      constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
      procedure AtualizaTabela(VpaNumAtualizacao : Integer);
      function AtualizaTabela1(VpaNumAtualizacao : Integer): String;
      function AtualizaTabela2(VpaNumAtualizacao : Integer): String;
      function AtualizaTabela3(VpaNumAtualizacao : Integer): String;
      function AtualizaTabela4(VpaNumAtualizacao : Integer): String;
      function AtualizaTabela5(VpaNumAtualizacao : Integer): String;
      procedure AtualizaBanco;
      procedure AtualizaNumeroVersaoSistema;
end;


implementation

Uses FunSql, ConstMsg, FunNumeros,Registry, Constantes, FunString, funvalida, FunArquivos;

{*************************** cria a classe ************************************}
constructor TAtualiza.criar( aowner : TComponent; VpaBaseDados : TSQLConnection );
begin
  inherited Create;
  VprBaseDados := VpaBasedados;
  Aux := TSQLQuery.Create(aowner);
  Aux.SQLConnection := VpaBaseDados;
end;

{*************** atualiza senha na base de dados ***************************** }
procedure TAtualiza.AtualizaSenha( Senha : string );
var
  ini : TRegIniFile;
  senhaInicial : string;
begin
  try

    // atualiza regedit
    Ini := TRegIniFile.Create('Software\Systec\Sistema');
    senhaInicial := Ini.ReadString('SENHAS','BANCODADOS', '');  // guarda senha do banco
    Ini.WriteString('SENHAS','BANCODADOS', Criptografa(senha));  // carrega senha do banco


   // atualiza base de dados
    LimpaSQLTabela(aux);
    AdicionaSQLTabela(Aux, 'grant connect, to DBA identified by ''' + senha + '''');
    Aux.ExecSQL;

    ini.free;
   except
    Ini.WriteString('SENHAS','BANCODADOS', senhaInicial);
    ini.free;
  end;
end;

{*********************** atualiza o banco de dados ****************************}
procedure TAtualiza.AtualizaBanco;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_Ult_Alt from Cfg_Geral ');
  if Aux.FieldByName('I_Ult_Alt').AsInteger < CT_VersaoBanco Then
    AtualizaTabela(Aux.FieldByName('I_Ult_Alt').AsInteger);
  Aux.Close;
  VerificaVersaoSistema

end;

{******************************************************************************}
procedure TAtualiza.AtualizaNumeroVersaoSistema;
var
  VpfRegistry : TIniFile;
begin
  VpfRegistry := TIniFile.Create(RetornaDiretorioCorrente+'\'+ varia.ParametroBase+ '.ini');
  if UpperCase(CampoPermissaoModulo) = 'C_MOD_PON' then
    VpfRegistry.WriteString('VERSAO','PONTOLOJA',VersaoPontoLoja)
  else
    if UpperCase(CampoPermissaoModulo) = 'C_CON_SIS' then
      VpfRegistry.WriteString('VERSAO','CONFIGURACAOSISTEMA',VersaoConfiguracaoSistema)
    else
      if UpperCase(CampoPermissaoModulo) = 'C_MOD_FIN' then
        VpfRegistry.WriteString('VERSAO','FINANCEIRO',VersaoFinanceiro)
      else
        if UpperCase(CampoPermissaoModulo) = 'C_MOD_FAT' then
          VpfRegistry.WriteString('VERSAO','FATURAMENTO',VersaoFaturamento)
        else
          if UpperCase(CampoPermissaoModulo) = 'C_MOD_EST' then
            VpfRegistry.WriteString('VERSAO','ESTOQUE',VersaoEstoque)
          else
            if UpperCase(CampoPermissaoModulo) = 'C_MOD_CHA' then
              VpfRegistry.WriteString('VERSAO','CHAMADO',VersaoChamadoTecnico)
            else
              if UpperCase(CampoPermissaoModulo) = 'C_MOD_AGE' then
                VpfRegistry.WriteString('VERSAO','AGENDA',VersaoAgenda)
              else
                if UpperCase(CampoPermissaoModulo) = 'C_MOD_CRM' then
                  VpfRegistry.WriteString('VERSAO','CRM',VersaoCRM)
                else
                  if UpperCase(CampoPermissaoModulo) = 'C_MOD_CAI' then
                    VpfRegistry.WriteString('VERSAO','CAIXA',VersaoCaixa);


  VpfRegistry.Free;
end;

{****************** verifica a versao do sistema ******************************}
procedure TAtualiza.VerificaVersaoSistema;
var
  VpfVersaoSistema : String;
begin
  AdicionaSQLAbreTabela(Aux,'Select '+SQlTextoIsNull(CampoPermissaoModulo,'0')+ CampoPermissaoModulo +
                            ' from cfg_geral ');
  if UpperCase(CampoPermissaoModulo) = 'C_MOD_EST' THEN
    VpfVersaoSistema := VersaoEstoque
  else
    if UpperCase(CampoPermissaoModulo) = 'C_MOD_FAT' THEN
      VpfVersaoSistema := VersaoFaturamento
    else
      if UpperCase(CampoPermissaoModulo) = 'C_MOD_PON' THEN
        VpfVersaoSistema := VersaoPontoLoja
      else
        if UpperCase(CampoPermissaoModulo) = 'C_MOD_CHA' THEN
          VpfVersaoSistema := VersaoChamadoTecnico
        else
          if UpperCase(CampoPermissaoModulo) = 'C_MOD_FIN' THEN
            VpfVersaoSistema := VersaoFinanceiro
          else
            if UpperCase(CampoPermissaoModulo) = 'C_CON_SIS' THEN
              VpfVersaoSistema := VersaoConfiguracaoSistema
            else
              if UpperCase(CampoPermissaoModulo) = 'C_MOD_AGE' THEN
                VpfVersaoSistema := VersaoAgenda
              else
                if UpperCase(CampoPermissaoModulo) = 'C_MOD_CRM' THEN
                  VpfVersaoSistema := VersaoCRM
                else
                  if UpperCase(CampoPermissaoModulo) = 'C_MOD_CAI' THEN
                    VpfVersaoSistema := VersaoCaixa;


  if trim(SubstituiStr(VpfVersaoSistema,'.',',')) <> trim(Aux.FieldByName(CampoPermissaoModulo).AsString) then
  begin
    if ArredondaDecimais(StrToFloat(SubstituiStr(VpfVersaoSistema,'.',',')),3) > ArredondaDecimais(StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',',')),3) then
      if StrToFloat(SubstituiStr(VpfVersaoSistema,'.',','))  > StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',',')) then
        AlteraVersoesSistemas(CampoPermissaoModulo,VpfVersaoSistema);
  end;
  if UpperCase(Application.Title) <> 'SISCORP' then
    AtualizaNumeroVersaoSistema;
  Aux.close;
end;

{********************* altera as versoes do sistema ***************************}
procedure TAtualiza.AlteraVersoesSistemas(VpaNomCampo, VpaDesVersao : String);
begin
  ExecutaComandoSql(Aux,'Update Cfg_Geral ' +
                        'set '+VpaNomCampo+ ' = '''+VpaDesVersao + '''');
end;

{**************************** atualiza a tabela *******************************}
procedure TAtualiza.AtualizaTabela(VpaNumAtualizacao : Integer);
var
  VpfSemErros : Boolean;
  VpfErro : String;
begin
  VpfSemErros := true;
//  FAbertura.painelTempo1.Execute('Atualizando o Banco de Dados. Aguarde...');
  repeat
    Try
      if VpaNumAtualizacao < 300 Then
      begin
        VpfErro := '300';
        ExecutaComandoSql(Aux,'ALTER TABLE CADVENDEDORES' +
                              ' add C_DES_EMA CHAR(50) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 300');
      end;
      if VpaNumAtualizacao < 301 Then
      begin
        VpfErro := '301';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS' +
                              ' ADD N_VLR_DES NUMERIC(12,3) NULL, '+
                              ' ADD N_PER_DES NUMERIC(12,3) NULL, '+
                              ' ADD N_PER_COM NUMERIC(5,2) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 301');
      end;
      if VpaNumAtualizacao < 302 Then
      begin
        VpfErro := '302';
        ExecutaComandoSql(Aux,'DROP INDEX MOVNOTASFISCAIS_PK');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS drop PRIMARY KEY');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNOTASFISCAIS '+
                              ' ADD PRIMARY KEY(I_EMP_FIL,I_SEQ_NOT,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'CREATE UNIQUE INDEX MOVNOTASFISCAIS_PK ON MOVNOTASFISCAIS(I_EMP_FIL,I_SEQ_NOT,I_SEQ_MOV)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 302');
      end;
      if VpaNumAtualizacao < 303 Then
      begin
        VpfErro := '303';
        ExecutaComandoSql(Aux,'create index CadNotaFiscais_CP1 on CADNOTAFISCAIS(C_Ser_Not,I_NRO_NOT)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 303');
      end;
      if VpaNumAtualizacao < 1429 Then
      begin
        VpfErro := '1429';
        ExecutaComandoSql(Aux,'alter table RETORNOITEM ADD NOMOCORRENCIA VARCHAR2(30) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1429');
      end;
      if VpaNumAtualizacao < 1430 Then
      begin
        VpfErro := '1430';
        ExecutaComandoSql(Aux,'alter table REMESSAITEM ADD NOMMOTIVO VARCHAR2(30) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1430');
      end;
      if VpaNumAtualizacao < 1431 Then
      begin
        VpfErro := '1431';
        ExecutaComandoSql(Aux,'DROP INDEX MOVCOMISSOES_CP4');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1431');
      end;
      if VpaNumAtualizacao < 1432 Then
      begin
        VpfErro := '1432';
        ExecutaComandoSql(Aux,'CREATE INDEX MOVCOMISSOES_CP3 ON MOVCOMISSOES(D_DAT_VAL,D_DAT_PAG)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1432');
      end;
      if VpaNumAtualizacao < 1433 Then
      begin
        VpfErro := '1433';
        TRY
          ExecutaComandoSql(Aux,'DROP INDEX MOVCOMISSOES_CP2');
        FINALLY
          ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1433');
        END;
      end;
      if VpaNumAtualizacao < 1434 Then
      begin
        VpfErro := '1434';
        ExecutaComandoSql(Aux,'CREATE INDEX MOVCOMISSOES_CP2 ON MOVCOMISSOES(D_DAT_VEN,D_DAT_PAG)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1434');
      end;
      if VpaNumAtualizacao < 1435 Then
      begin
        VpfErro := '1435';
        try
          ExecutaComandoSql(Aux,'DROP INDEX MOVCONTASRECEBERCP5');
        finally
          ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1435');
        end;
      end;
      if VpaNumAtualizacao < 1436 Then
      begin
        VpfErro := '1436';
        ExecutaComandoSql(Aux,'create index remessacorpo_cp1 on REMESSACORPO(DATBLOQUEIO,NUMCONTA,CODFILIAL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1436');
      end;
      if VpaNumAtualizacao < 1437 Then
      begin
        VpfErro := '1437';
        ExecutaComandoSql(Aux,'CREATE INDEX CADCODIGO_CP1 ON CADCODIGO(I_EMP_FIL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1437');
      end;
      if VpaNumAtualizacao < 1438 Then
      begin
        VpfErro := '1438';
        ExecutaComandoSql(Aux,'alter table CONTRATOCORPO ADD (CODPREPOSTO NUMBER(10,0) NULL,'+
                              ' PERCOMISSAO NUMBER(6,3) NULL, '+
                              ' PERCOMISSAOPREPOSTO NUMBER(6,3) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1438');
      end;
      if VpaNumAtualizacao < 1439 Then
      begin
        VpfErro := '1439';
        ExecutaComandoSql(Aux,'CREATE INDEX CONTRATOCORPO_FK4 on CONTRATOCORPO(CODPREPOSTO)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1439');
      end;
      if VpaNumAtualizacao < 1440 Then
      begin
        VpfErro := '1440';
        ExecutaComandoSql(Aux,'ALTER TABLE CONTRATOCORPO ADD DESEMAIL VARCHAR2(60) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1440');
      end;
      if VpaNumAtualizacao < 1441 Then
      begin
        VpfErro := '1441';
        ExecutaComandoSql(Aux,'CREATE TABLE FIGURAGRF( '+
                              ' CODFIGURAGRF NUMBER(10,0) NOT NULL, '+
                              ' NOMFIGURAGRF VARCHAR2(50) NULL,'+
                              ' DESFIGURAGRF VARCHAR2(2000)NULL,'+
                              ' PRIMARY KEY(CODFIGURAGRF))' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1441');
      end;
      if VpaNumAtualizacao < 1442 Then
      begin
        VpfErro := '1442';
        ExecutaComandoSql(Aux,'CREATE TABLE COMPOSICAO( '+
                              ' CODCOMPOSICAO NUMBER(10,0) NOT NULL, '+
                              ' NOMCOMPOSICAO VARCHAR2(50) NULL,'+
                              ' PRIMARY KEY(CODCOMPOSICAO))' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1442');
      end;
      if VpaNumAtualizacao < 1443 Then
      begin
        VpfErro := '1443';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_REF_CLI CHAR(1) NULL' );
        ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_REF_CLI = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1443');
      end;
      if VpaNumAtualizacao < 1444 Then
      begin
        VpfErro := '1444';
        ExecutaComandoSql(Aux,'ALTER TABLE CADUSUARIOS ADD C_CON_CAI  VARCHAR2(13) NULL' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1444');
      end;
      if VpaNumAtualizacao < 1445 Then
      begin
        VpfErro := '1445';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_CNF_ESC CHAR(1) NULL' );
        ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_CNF_ESC  = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1445');
      end;
      if VpaNumAtualizacao < 1446 Then
      begin
        VpfErro := '1446';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD (C_UFD_NFE CHAR(2) NULL,'+
                              ' C_AMH_NFE CHAR(1) NULL, '+   //AMBIENTE DE HOMOLOGACAO
                              ' C_MOM_NFE CHAR(1) NULL)');   // MOSTRAR MENSAGEM
        ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_AMH_NFE = ''T'','+
                              ' C_MOM_NFE = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1446');
      end;
      if VpaNumAtualizacao < 1447 Then
      begin
        VpfErro := '1447';
        ExecutaComandoSql(Aux,'alter table CADGRUPOS ADD (C_POL_PSP CHAR(1) NULL,'+
                              ' C_POL_PCP CHAR(1) NULL) ');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_POL_PSP = ''T'','+
                              ' C_POL_PCP = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1447');
      end;
      if VpaNumAtualizacao < 1448 Then
      begin
        VpfErro := '1448';
        ExecutaComandoSql(Aux,'alter table CADGRUPOS ADD C_POL_ECP CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_POL_ECP = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1448');
      end;
      if VpaNumAtualizacao < 1449 Then
      begin
        VpfErro := '1449';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD (C_DAN_NFE CHAR(1) NULL,'+
                              ' C_CER_NFE VARCHAR2(50))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1449');
      end;
      if VpaNumAtualizacao < 1450 Then
      begin
        VpfErro := '1450';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD C_IND_NFE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_IND_NFE = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1450');
      end;
      if VpaNumAtualizacao < 1451 Then
      begin
        VpfErro := '1451';
        ExecutaComandoSql(Aux,'alter table CADGRUPOS ADD C_FAT_CNO CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_FAT_CNO = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1451');
      end;
      if VpaNumAtualizacao < 1452 Then
      begin
        VpfErro := '1452';
        ExecutaComandoSql(Aux,'alter table movorcamentos add I_SEQ_ORD NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1452');
      end;
      if VpaNumAtualizacao < 1453 Then
      begin
        VpfErro := '1453';
        ExecutaComandoSql(Aux,'create table COMPOSICAOFIGURAGRF ('+
                              ' CODCOMPOSICAO NUMBER(10,0) NOT NULL,'+
                              ' CODFIGURAGRF NUMBER(10,0) NOT NULL,'+
                              ' PRIMARY KEY(CODCOMPOSICAO,CODFIGURAGRF))');
        ExecutaComandoSql(Aux,'CREATE INDEX COMPOSICAOFIGURAGRF_FK1 ON COMPOSICAOFIGURAGRF(CODCOMPOSICAO)');
        ExecutaComandoSql(Aux,'CREATE INDEX COMPOSICAOFIGURAGRF_FK2 ON COMPOSICAOFIGURAGRF(CODFIGURAGRF)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1453');
      end;
      if VpaNumAtualizacao < 1454 Then
      begin
        VpfErro := '1454';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ADD I_COD_COM NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1454');
      end;
      if VpaNumAtualizacao < 1455 Then
      begin
        VpfErro := '1455';
        ExecutaComandoSql(Aux,'alter table CFG_PRODUTO ADD C_ORP_ACE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE  CFG_PRODUTO SET C_ORP_ACE = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1455');
      end;
      if VpaNumAtualizacao < 1456 Then
      begin
        VpfErro := '1456';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ADD I_NUM_LOT NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1456');
      end;
      if VpaNumAtualizacao < 1457 Then
      begin
        VpfErro := '1457';
        ExecutaComandoSql(Aux,'alter table CFG_PRODUTO ADD I_REG_LOT NUMBER(5,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1457');
      end;
      if VpaNumAtualizacao < 1458 Then
      begin
        VpfErro := '1458';
        ExecutaComandoSql(Aux,'alter table CFG_PRODUTO ADD C_EST_SER CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_EST_SER = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1458');
      end;
      if VpaNumAtualizacao < 1459 Then
      begin
        VpfErro := '1459';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD I_COD_FIS NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1459');
      end;
      if VpaNumAtualizacao < 1460 Then
      begin
        VpfErro := '1460';
        ExecutaComandoSql(Aux,'alter table CADCLIENTES ADD I_COD_IBG NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1460');
      end;
      if VpaNumAtualizacao < 1461 Then
      begin
        VpfErro := '1461';
        ExecutaComandoSql(Aux,'alter table CADFILIAIS ADD C_COD_CNA VARCHAR2(15)NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1461');
      end;
      if VpaNumAtualizacao < 1462 Then
      begin
        VpfErro := '1462';
        ExecutaComandoSql(Aux,'alter table CADNOTAFISCAIS ADD( C_CHA_NFE VARCHAR2(50)NULL, '+
                              ' C_REC_NFE VARCHAR2(15) NULL, '+
                              ' C_PRO_NFE VARCHAR2(20) NULL,'+
                              ' C_STA_NFE VARCHAR2(3) NULL,'+
                              ' C_MOT_NFE VARCHAR2(40) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1462');
      end;
      if VpaNumAtualizacao < 1463 Then
      begin
        VpfErro := '1463';
        ExecutaComandoSql(Aux,'alter table CADPRODUTOS ADD C_IND_MON CHAR(1)NULL ');
        ExecutaComandoSql(Aux,'UPDATE CADPRODUTOS SET C_IND_MON = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1463');
      end;
      if VpaNumAtualizacao < 1464 Then
      begin
        VpfErro := '1464';
        ExecutaComandoSql(Aux,'alter table MOVESTOQUEPRODUTOS ADD(N_QTD_INI NUMBER(17,4)NULL, '+
                              ' N_QTD_FIN NUMBER(17,4) NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1464');
      end;
      if VpaNumAtualizacao < 1465 Then
      begin
        VpfErro := '1465';
        ExecutaComandoSql(Aux,'alter table CADGRUPOS ADD(C_COD_CLA VARCHAR2(15)NULL, '+
                              ' I_COD_FIL NUMBER(10) NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1465');
      end;
      if VpaNumAtualizacao < 1466 Then
      begin
        VpfErro := '1466';
        ExecutaComandoSql(Aux,'INSERT INTO CADSERIENOTAS(C_SER_NOT) VALUES(''900'')');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1466');
      end;
      if VpaNumAtualizacao < 1467 Then
      begin
        VpfErro := '1467';
        ExecutaComandoSql(Aux,'ALTER TABLE CAD_PAISES ADD(COD_IBGE NUMBER(4) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1467');
      end;
      if VpaNumAtualizacao < 1468 Then
      begin
        VpfErro := '1468';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD(I_COD_PAI NUMBER(4) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1468');
      end;
      if VpaNumAtualizacao < 1469 Then
      begin
        VpfErro := '1469';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_INS_MUN VARCHAR2(30) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1469');
      end;
      if VpaNumAtualizacao < 1470 Then
      begin
        VpfErro := '1470';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD I_ORI_PRO NUMBER(1,0) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADPRODUTOS SET I_ORI_PRO = 0 ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1470');
      end;
      if VpaNumAtualizacao < 1471 Then
      begin
        VpfErro := '1471';
        ExecutaComandoSql(Aux,'ALTER TABLE CADSERVICO ADD I_COD_FIS NUMBER(6,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1471');
      end;
      if VpaNumAtualizacao < 1472 Then
      begin
        VpfErro := '1472';
        ExecutaComandoSql(Aux,'CREATE INDEX MOVCONTASARECEBER_CP6 ON MOVCONTASARECEBER(C_NOS_NUM)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1472');
      end;
      if VpaNumAtualizacao < 1473 Then
      begin
        VpfErro := '1473';
        ExecutaComandoSql(Aux,'CREATE INDEX FRACAOOP_CP1 ON FRACAOOP(INDPLANOCORTE)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1473');
      end;
      if VpaNumAtualizacao < 1474 Then
      begin
        VpfErro := '1474';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD(I_TIP_BAR NUMBER(1,0),'+
                              ' N_PRE_EAN NUMBER(15,0)NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1474');
      end;
      if VpaNumAtualizacao < 1475 Then
      begin
        VpfErro := '1475';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD(I_ULT_EAN NUMBER(20,0)NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1475');
      end;
      if VpaNumAtualizacao < 1476 Then
      begin
        VpfErro := '1476';
        ExecutaComandoSql(Aux,'CREATE TABLE CONDICAOPAGAMENTOGRUPOUSUARIO('+
                              ' CODGRUPOUSUARIO NUMBER(10,0) NOT NULL, '+
                              ' CODCONDICAOPAGAMENTO NUMBER(10,0) NOT NULL, ' +
                              ' PRIMARY KEY(CODGRUPOUSUARIO,CODCONDICAOPAGAMENTO))');
        ExecutaComandoSql(Aux,'CREATE INDEX CONDICAOPGTOGRUPOUSUARIO_FK1 ON CONDICAOPAGAMENTOGRUPOUSUARIO(CODGRUPOUSUARIO)');
        ExecutaComandoSql(Aux,'CREATE INDEX CONDICAOPGTOGRUPOUSUARIO_FK2 ON CONDICAOPAGAMENTOGRUPOUSUARIO(CODCONDICAOPAGAMENTO)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1476');
      end;
      if VpaNumAtualizacao < 1477 Then
      begin
        VpfErro := '1477';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_GER_COP CHAR(1)NULL');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS set C_GER_COP = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1477');
      end;
      if VpaNumAtualizacao < 1478 Then
      begin
        VpfErro := '1478';
        ExecutaComandoSql(Aux,'ALTER TABLE ORCAMENTOCOMPRAFORNECEDORCORPO '+
                              ' ADD (DESEMAIL VARCHAR2(100) NULL, '+
                              ' NOMCONTATO VARCHAR2(50) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1478');
      end;
      if VpaNumAtualizacao < 1479 Then
      begin
        VpfErro := '1479';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_ORP_CMM CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_ORP_CMM = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1479');
      end;
      if VpaNumAtualizacao < 1480 Then
      begin
        VpfErro := '1480';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAIS ADD (C_PRC_NFE VARCHAR2(20) NULL, '+
                              ' C_MOC_NFE VARCHAR2(255) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1480');
      end;
      if VpaNumAtualizacao < 1481 Then
      begin
        VpfErro := '1481';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (C_SER_SER VARCHAR2(15) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1481');
      end;
      if VpaNumAtualizacao < 1482 Then
      begin
        VpfErro := '1482';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (C_NOT_CON CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update CADFILIAIS set C_NOT_CON = ''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1482');
      end;
      if VpaNumAtualizacao < 1483 Then
      begin
        VpfErro := '1483';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD (C_EST_CAC CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update CADGRUPOS set C_EST_CAC = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1483');
      end;
      if VpaNumAtualizacao < 1484 Then
      begin
        VpfErro := '1484';
        ExecutaComandoSql(Aux,'ALTER TABLE RETORNOITEM MODIFY NOMSACADO VARCHAR2(40)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1484');
      end;
      if VpaNumAtualizacao < 1485 Then
      begin
        VpfErro := '1485';
        ExecutaComandoSql(Aux,'ALTER TABLE CAD_PLANO_CONTA ADD N_VLR_PRE NUMBER(17,2) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1485');
      end;
      if VpaNumAtualizacao < 1486 Then
      begin
        VpfErro := '1486';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_MOD_EPE NUMBER(2) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1486');
      end;
      if VpaNumAtualizacao < 1487 Then
      begin
        VpfErro := '1487';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD C_EAN_ACE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_PRODUTO SET C_EAN_ACE = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1487');
      end;
      if VpaNumAtualizacao < 1488 Then
      begin
        VpfErro := '1488';
        ExecutaComandoSql(Aux,'ALTER TABLE EMBALAGEM ADD QTD_EMBALAGEM NUMBER(15,3)NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1488');
      end;
      if VpaNumAtualizacao < 1489 Then
      begin
        VpfErro := '1489';
        ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOPCONSUMO ADD QTDARESERVAR NUMBER(15,4)NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1489');
      end;
      if VpaNumAtualizacao < 1490 Then
      begin
        VpfErro := '1490';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVQDADEPRODUTO ADD N_QTD_ARE NUMBER(15,4)NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1490');
      end;
      if VpaNumAtualizacao < 1491 Then
      begin
        VpfErro := '1491';
        ExecutaComandoSql(Aux,'ALTER TABLE IMPRESSAOCONSUMOFRACAO ADD(QTDRESERVADA NUMBER(15,4)NULL, '+
                              ' QTDARESERVAR NUMBER(15,4) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1491');
      end;
      if VpaNumAtualizacao < 1492 Then
      begin
        VpfErro := '1492';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD C_EMA_NFE VARCHAR2(75) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1492');
      end;
      if VpaNumAtualizacao < 1493 Then
      begin
        VpfErro := '1493';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_NOT_IEC CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_NOT_IEC =''T''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1493');
      end;
      if VpaNumAtualizacao < 1494 Then
      begin
        VpfErro := '1494';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL ADD C_COM_ROM CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update CFG_FISCAL set C_COM_ROM =''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1494');
      end;
      if VpaNumAtualizacao < 1495 Then
      begin
        VpfErro := '1495';
        ExecutaComandoSql(Aux,'CREATE TABLE PRODUTORESERVADOEMEXCESSO ('+
                              ' SEQRESERVA NUMBER(10) NOT NULL, '+
                              ' DATRESERVA DATE, ' +
                              ' SEQPRODUTO NUMBER(10) NOT NULL, '+
                              ' QTDESTOQUEPRODUTO NUMBER(15,4) NULL, '+
                              ' QTDRESERVADO NUMBER(15,4) NULL, '+
                              ' QTDEXCESSO NUMBER(15,4) NULL, '+
                              ' CODFILIAL NUMBER(10) NULL, ' +
                              ' SEQORDEMPRODUCAO NUMBER(10) NULL, '+
                              ' CODUSUARIO NUMBER(10) NULL, '+
                              ' DESUM CHAR(2) NULL, '+
                              ' PRIMARY KEY(SEQRESERVA))');
        ExecutaComandoSql(Aux,'CREATE INDEX PRODUTORESERVADOEXCE_FK1 ON PRODUTORESERVADOEMEXCESSO(SEQPRODUTO)' );
        ExecutaComandoSql(Aux,'CREATE INDEX PRODUTORESERVADOEXCE_FK2 ON PRODUTORESERVADOEMEXCESSO(CODFILIAL,SEQORDEMPRODUCAO)' );
        ExecutaComandoSql(Aux,'CREATE INDEX PRODUTORESERVADOEXCE_FK3 ON PRODUTORESERVADOEMEXCESSO(CODUSUARIO)' );
        ExecutaComandoSql(Aux,'CREATE INDEX PRODUTORESERVADOEXCE_CP1 ON PRODUTORESERVADOEMEXCESSO(DATRESERVA)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1495');
      end;
      if VpaNumAtualizacao < 1496 Then
      begin
        VpfErro := '1496';
        ExecutaComandoSql(Aux,'CREATE TABLE RESERVAPRODUTO( '+
                              ' SEQRESERVA NUMBER(10) NOT NULL, '+
                              ' SEQPRODUTO NUMBER(10) NOT NULL, '+
                              ' TIPMOVIMENTO CHAR(1) NULL, '+
                              ' DATRESERVA DATE NULL, '+
                              ' QTDRESERVADA NUMBER(15,3) NULL, '+
                              ' CODUSUARIO NUMBER(10) NULL, '+
                              ' QTDINICIAL NUMBER(15,3) NULL,'+
                              ' QTDFINAL NUMBER(15,3) NULL, '+
                              ' CODFILIAL NUMBER(10) NULL, '+
                              ' SEQORDEMPRODUCAO NUMBER(10) NULL, '+
                              ' DESUM CHAR(2) NULL, '+
                              ' PRIMARY KEY(SEQRESERVA))');
        ExecutaComandoSql(Aux,'CREATE INDEX RESERVAPRODUTO_FK1 ON RESERVAPRODUTO(SEQPRODUTO)');
        ExecutaComandoSql(Aux,'CREATE INDEX RESERVAPRODUTO_FK2 ON RESERVAPRODUTO(CODFILIAL,SEQORDEMPRODUCAO)');
        ExecutaComandoSql(Aux,'CREATE INDEX RESERVAPRODUTO_FK3 ON RESERVAPRODUTO(CODUSUARIO)');
        ExecutaComandoSql(Aux,'CREATE INDEX RESERVAPRODUTO_CP1 ON RESERVAPRODUTO(DATRESERVA)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1496');
      end;
      if VpaNumAtualizacao < 1497 Then
      begin
        VpfErro := '1497';
        ExecutaComandoSql(Aux,'CREATE TABLE PROJETO( '+
                              ' CODPROJETO NUMBER(10) NOT NULL, '+
                              ' NOMPROJETO VARCHAR2(50) NULL, '+
                              ' PRIMARY KEY(CODPROJETO))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1497');
      end;
      if VpaNumAtualizacao < 1498 Then
      begin
        VpfErro := '1498';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD C_CON_PRO CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_CON_PRO = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1498');
      end;
      if VpaNumAtualizacao < 1499 Then
      begin
        VpfErro := '1499';
        ExecutaComandoSql(Aux,'CREATE TABLE CONTAAPAGARPROJETO( '+
                              ' CODFILIAL NUMBER(10) NOT NULL, '+
                              ' LANPAGAR NUMBER(10) NOT NULL, '+
                              ' CODPROJETO NUMBER(10) NOT NULL, '+
                              ' SEQDESPESA NUMBER(10) NOT NULL,' +
                              ' VALDESPESA NUMBER(15,3) NULL, '+
                              ' PERDESPESA NUMBER(15,3) NULL,'+
                              ' PRIMARY KEY(CODFILIAL,LANPAGAR,CODPROJETO,SEQDESPESA))');
        ExecutaComandoSql(Aux,'CREATE INDEX CONTAAPAGARPROJETO_FK1 ON CONTAAPAGARPROJETO(CODFILIAL,LANPAGAR)');
        ExecutaComandoSql(Aux,'CREATE INDEX CONTAAPAGARPROJETO_FK2 ON CONTAAPAGARPROJETO(CODPROJETO)');
        ExecutaComandoSql(Aux,'ALTER TABLE CONTAAPAGARPROJETO add CONSTRAINT CONTAAPAGARPRO_CP '+
                              ' FOREIGN KEY (CODFILIAL,LANPAGAR) '+
                              '  REFERENCES CADCONTASAPAGAR (I_EMP_FIL,I_LAN_APG) ');
        ExecutaComandoSql(Aux,'ALTER TABLE CONTAAPAGARPROJETO add CONSTRAINT CONTAAPAGAR_PROJETO '+
                              ' FOREIGN KEY (CODPROJETO) '+
                              '  REFERENCES PROJETO (CODPROJETO) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1499');
      end;
      if VpaNumAtualizacao < 1500 Then
      begin
        VpfErro := '1500';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_COT_PPP CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_COT_PPP = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1500');
      end;
      if VpaNumAtualizacao < 1501 Then
      begin
        VpfErro := '1501';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_COT_QME NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET I_COT_QME = 6');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1501');
      end;
      if VpaNumAtualizacao < 1502 Then
      begin
        VpfErro := '1502';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMPRODUCAOCORPO ADD CODPRJ NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1502');
      end;
      if VpaNumAtualizacao < 1503 Then
      begin
        VpfErro := '1503';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD N_CAP_LIQ NUMBER(10,2) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1503');
      end;
      if VpaNumAtualizacao < 1504 Then
      begin
        VpfErro := '1504';
        ExecutaComandoSql(Aux,'CREATE TABLE MOTIVOPARADA( '+
                              ' CODMOTIVOPARADA NUMBER(10) NOT NULL, '+
                              ' NOMMOTIVOPARADA VARCHAR2(50) NULL,'+
                              ' PRIMARY KEY(CODMOTIVOPARADA))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1504');
      end;
      if VpaNumAtualizacao < 1505 Then
      begin
        VpfErro := '1505';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD C_EST_RES CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_RES = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1505');
      end;
      if VpaNumAtualizacao < 1506 Then
      begin
        VpfErro := '1506';
        ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS ADD C_COT_ICS CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADEMPRESAS SET C_COT_ICS = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1506');
      end;
      if VpaNumAtualizacao < 1507 Then
      begin
        VpfErro := '1507';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLASSIFICACAO ADD C_IMP_ETI CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADCLASSIFICACAO SET C_IMP_ETI = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1507');
      end;
      if VpaNumAtualizacao < 1508 Then
      begin
        VpfErro := '1508';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO ADD I_COD_COR NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'UPDATE MOVTABELAPRECO SET I_COD_COR = 0');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO MODIFY I_COD_COR NUMBER(10) NOT NULL');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO drop PRIMARY KEY');
        ExecutaComandoSql(Aux,'ALTER TABLE MOVTABELAPRECO  '+
                              ' ADD PRIMARY KEY(I_COD_EMP,I_COD_TAB,I_SEQ_PRO,I_COD_CLI,I_COD_TAM,I_COD_COR)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1508');
      end;
      if VpaNumAtualizacao < 1509 Then
      begin
        VpfErro := '1509';
        ExecutaComandoSql(Aux,'create table DEPARTAMENTOAMOSTRA('+
                              ' CODDEPARTAMENTOAMOSTRA NUMBER(10,0) NOT NULL,'+
                              ' NOMDEPARTAMENTOAMOSTRA VARCHAR2(50)NULL,' +
                              ' PRIMARY KEY(CODDEPARTAMENTOAMOSTRA))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1509');
      end;
      if VpaNumAtualizacao < 1510 Then
      begin
        VpfErro := '1510';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA ADD CODDEPARTAMENTOAMOSTRA NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1510');
      end;
      if VpaNumAtualizacao < 1511 Then
      begin
        VpfErro := '1511';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(I_COD_DEA NUMBER(10,0) NULL , '+
                               ' I_DIA_AMO NUMBER(3) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1511');
      end;
      if VpaNumAtualizacao < 1512 Then
      begin
        VpfErro := '1512';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_NOF_ICO CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_NOF_ICO = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1512');
      end;
      if VpaNumAtualizacao < 1513 Then
      begin
        VpfErro := '1513';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASARECEBER ADD C_IND_DEV CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADCONTASARECEBER SET C_IND_DEV = ''N''');
        ExecutaComandoSql(Aux,'CREATE INDEX CADCONTASARECEBER_CP3 ON CADCONTASARECEBER(C_IND_DEV)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1513');
      end;
      if VpaNumAtualizacao < 1514 Then
      begin
        VpfErro := '1514';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_EST_REI NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1514');
      end;
      if VpaNumAtualizacao < 1515 Then
      begin
        VpfErro := '1515';
        ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOPCONSUMO ADD(INDEXCLUIR CHAR(1) NULL, '+
                              ' ALTMOLDE NUMBER(9,4) NULL, ' +
                              ' LARMOLDE NUMBER(9,4) NULL)');
        ExecutaComandoSql(Aux,'UPDATE FRACAOOPCONSUMO SET INDEXCLUIR = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1515');
      end;
      if VpaNumAtualizacao < 1516 Then
      begin
        VpfErro := '1516';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCLIENTES ADD C_IND_VIS CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADCLIENTES SET C_IND_VIS = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1516');
      end;
      if VpaNumAtualizacao < 1517 Then
      begin
        VpfErro := '1517';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACONSUMO ADD DESLEGENDA CHAR(4)NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1517');
      end;
      if VpaNumAtualizacao < 1518 Then
      begin
        VpfErro := '1518';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASAPAGAR add CONSTRAINT CADCONTASPAGAR_PLAC '+
                              ' FOREIGN KEY (I_COD_EMP, C_CLA_PLA) '+
                              '  REFERENCES CAD_PLANO_CONTA(I_COD_EMP,C_CLA_PLA) ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1518');
      end;
      if VpaNumAtualizacao < 1519 Then
      begin
        VpfErro := '1519';
        ExecutaComandoSql(Aux,'CREATE TABLE TIPOMATERIAPRIMA ('+
                              ' CODTIPOMATERIAPRIMA NUMBER(10) NULL, '+
                              ' NOMTIPOMATERIAPRIMA VARCHAR2(50) NULL, '+
                              ' PRIMARY KEY(CODTIPOMATERIAPRIMA))' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1519');
      end;
      if VpaNumAtualizacao < 1520 Then
      begin
        VpfErro := '1520';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRACONSUMO '+
                              ' ADD(CODTIPOMATERIAPRIMA NUMBER(10) NULL,'+
                              ' NUMSEQUENCIA NUMBER(10) NULL,' +
                              ' SEQENTRETELA NUMBER(10) NULL,' +
                              ' QTDENTRETELA NUMBER(10) NULL,' +
                              ' SEQTERMOCOLANTE NUMBER(10)NULL,' +
                              ' QTDTERMOCOLANTE NUMBER(10)NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1520');
      end;
      if VpaNumAtualizacao < 1521 Then
      begin
        VpfErro := '1521';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD( '+
                              ' C_PER_SPE CHAR(1) NULL, '+
                              ' I_ATI_SPE NUMBER(2) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1521');
      end;
      if VpaNumAtualizacao < 1522 Then
      begin
        VpfErro := '1522';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD( '+
                              ' I_CON_SPE NUMBER(10) NULL, '+
                              ' C_NCO_SPE VARCHAR2(50) NULL,'+
                              ' C_CPC_SPE VARCHAR2(14) NULL,' +
                              ' C_CRC_SPE VARCHAR2(15) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1522');
      end;
      if VpaNumAtualizacao < 1523 Then
      begin
        VpfErro := '1523';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD I_DES_PRO NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1523');
      end;
      if VpaNumAtualizacao < 1524 Then
      begin
        VpfErro := '1524';
        ExecutaComandoSql(Aux,'ALTER TABLE AMOSTRA ADD(CODEMPRESA NUMBER(10) NULL, '+
                              ' DESTIPOCLASSIFICACAO CHAR(1)NULL)');
        ExecutaComandoSql(Aux,'UPDATE AMOSTRA SET CODEMPRESA = 1, ' +
                              ' DESTIPOCLASSIFICACAO = ''P''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1524');
      end;
      if VpaNumAtualizacao < 1525 Then
      begin
        VpfErro := '1525';
        ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOP ADD INDPOSSUIEMESTOQUE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'Update FRACAOOP SET INDPOSSUIEMESTOQUE = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1525');
      end;
      if VpaNumAtualizacao < 1526 Then
      begin
        VpfErro := '1526';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_OBS_BOL VARCHAR2(600) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL SET C_OBS_BOL = ''****O DEPOSITO BANCARIO NAO QUITA ESTE BOLETO****''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1526');
      end;
      if VpaNumAtualizacao < 1527 Then
      begin
        VpfErro := '1527';
        ExecutaComandoSql(Aux,'ALTER TABLE CADEMPRESAS ADD C_IND_FCA CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADEMPRESAS SET C_IND_FCA = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1527');
      end;
      if VpaNumAtualizacao < 1528 Then
      begin
        VpfErro := '1528';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD I_ORC_LOC NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1528');
      end;
      if VpaNumAtualizacao < 1529 Then
      begin
        VpfErro := '1529';
        ExecutaComandoSql(Aux,'ALTER TABLE FACA ADD (ALTPROVA NUMBER(9,3)NULL, '+
                               ' LARPROVA NUMBER(9,3) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1529');
      end;
      if VpaNumAtualizacao < 1530 Then
      begin
        VpfErro := '1530';
        ExecutaComandoSql(Aux,'alter TABLE CFG_GERAL ADD C_AMO_CAC CHAR(1) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set C_AMO_CAC = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1530');
      end;
      if VpaNumAtualizacao < 1531 Then
      begin
        VpfErro := '1531';
        ExecutaComandoSql(Aux,'alter TABLE CFG_GERAL ADD C_DIR_FAM VARCHAR2(200) NULL ');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1531');
      end;
      if VpaNumAtualizacao < 1532 Then
      begin
        VpfErro := '1532';
        ExecutaComandoSql(Aux,'create table COEFICIENTECUSTO('+
                              ' CODCOEFICIENTE NUMBER(10) NOT NULL,' +
                              ' NOMCOEFICIENTE VARCHAR2(50) NOT NULL,' +
                              ' PERICMS NUMBER(9,3) NULL, ' +
                              ' PERPISCOFINS NUMBER(9,3) NULL,' +
                              ' PERCOMISSAO NUMBER(9,3) NULL,' +
                              ' PERFRETE NUMBER(9,3) NULL,' +
                              ' PERADMINISTRATIVO NUMBER(9,3) NULL,' +
                              ' PERPROPAGANDA NUMBER(9,3) NULL,' +
                              ' PERVENDAPRAZO NUMBER(9,3) NULL,' +
                              ' PERLUCRO NUMBER(9,3) NULL,' +
                              ' PRIMARY KEY(CODCOEFICIENTE))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1532');
      end;
      if VpaNumAtualizacao < 1533 Then
      begin
        VpfErro := '1533';
        ExecutaComandoSql(Aux,'ALTER TABLE CADTRANSPORTADORAS ADD(I_COD_PAI NUMBER(10) NULL, '+
                              ' I_COD_IBG NUMBER(10) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1533');
      end;
      if VpaNumAtualizacao < 1534 Then
      begin
        VpfErro := '1534';
        ExecutaComandoSql(Aux,'ALTER TABLE CADTRANSPORTADORAS ADD C_IND_PRO CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADTRANSPORTADORAS SET C_IND_PRO = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1534');
      end;
      if VpaNumAtualizacao < 1535 Then
      begin
        VpfErro := '1535';
        ExecutaComandoSql(Aux,'create table TIPODOCUMENTOFISCAL ('+
                              ' CODTIPODOCUMENTOFISCAL CHAR(2) NOT NULL, '+
                              ' NOMTIPODOCUMENTOFISCAL VARCHAR2(70) NULL, '+
                              ' PRIMARY KEY(CODTIPODOCUMENTOFISCAL))');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''01'',''NOTA FISCAL MODELO 1/1A'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''1B'',''NOTA FISCAL AVULSA'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''02'',''NOTA FISCAL DE VENDA AO CONSUMIDOR'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''2D'',''CUPOM FISCAL'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''04'',''NOTA FISCAL DE PRODUTOR'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''06'',''CONTA DE ENERGIA ELETRICA'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''07'',''NOTA FISCAL DE SERVICO DE TRANSPORTE'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''08'',''CONHECIMENTO DE TRANSPORTE RODOVIARIO DE CARGAS'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''8B'',''CONHECIMENTO DE TRANSPORTE AVULSO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''09'',''CONHECIMENTO DE TRANSPORTE AQUAVIARIO DE CARGAS'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''10'',''CONHECIMENTO DE AEREO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''11'',''CONHECIMENTO DE TRANSPORTE FERROVIARIO DE CARGAS'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''13'',''BILHETE DE PASSAGEM RODOVIARIO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''14'',''BILHETE DE PASSAGEM AQUAVIARIO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''15'',''BILHETE DE PASSAGEM E NOTA DE BAGAGEM'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''16'',''BILHETE DE PASSAGEM FERROVIARIO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''18'',''RESUMO DE MOVIMENTO DIARIO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''21'',''NOTA FISCAL DE SERVICO DE COMUNICACAO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''22'',''NOTA FISCAL DE SERVICO DE TELECOMUNICACAO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''26'',''CONHECIMENTO DE TRANSPORTE MULTIMODAL DE CARGAS'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''27'',''NOTA FISCAL DE TRANSPORTE FERROVIARIO DE CARGA'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''28'',''NOTA FISCAL/CONTA DE FORNECIMENTO DE GAS CANALIZADO'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''29'',''NOTA FISCAL/CONTA DE FORNECIMENTO DE AGUA CANALIZADA'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''55'',''NOTA FISCAL ELETRONICA (NF-E)'')');
        ExecutaComandoSql(Aux,'INSERT INTO TIPODOCUMENTOFISCAL VALUES(''57'',''CONHECIMENTO DE TRANSPORTE ELETRONICO (CT-E)'')');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1535');
      end;
      if VpaNumAtualizacao < 1536 Then
      begin
        VpfErro := '1536';
        ExecutaComandoSql(Aux,'ALTER TABLE FRACAOOP ADD DATCORTE DATE NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1536');
      end;
      if VpaNumAtualizacao < 1537 Then
      begin
        VpfErro := '1537';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD C_IND_SPE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CADFILIAIS SET C_IND_SPE = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1537');
      end;
      if VpaNumAtualizacao < 1538 Then
      begin
        VpfErro := '1538';
        ExecutaComandoSql(Aux,'ALTER TABLE CADFILIAIS ADD (N_PER_COF NUMBER(6,3) NULL,'+
                              ' N_PER_PIS NUMBER(6,3) NULL,'+
                              ' C_CST_IPI CHAR(2) NULL )');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1538');
      end;
      if VpaNumAtualizacao < 1539 Then
      begin
        VpfErro := '1539';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FISCAL DROP (N_PER_COF, N_PER_PIS)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1539');
      end;
      if VpaNumAtualizacao < 1540 Then
      begin
        VpfErro := '1540';
        ExecutaComandoSql(Aux,'ALTER TABLE MOVNATUREZA ADD(C_CAL_PIS CHAR(1) NULL,'+
                              ' C_CAL_COF CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update MOVNATUREZA SET C_CAL_PIS = ''N'','+
                              ' C_CAL_COF = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1540');
      end;
      if VpaNumAtualizacao < 1541 Then
      begin
        VpfErro := '1541';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR DROP (I_PRA_DIA, I_QTD_PAR)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1541');
      end;
      if VpaNumAtualizacao < 1542 Then
      begin
        VpfErro := '1542';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ADD I_COD_PAG NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1542');
      end;
      if VpaNumAtualizacao < 1543 Then
      begin
        VpfErro := '1543';
        ExecutaComandoSql(Aux,'ALTER TABLE CADCONTASAPAGAR ADD I_COD_PAG NUMBER(10,0) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1543');
      end;
      if VpaNumAtualizacao < 1544 Then
      begin
        VpfErro := '1544';
        ExecutaComandoSql(Aux,'ALTER TABLE CADNOTAFISCAISFOR ADD C_MOD_DOC CHAR(2) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1544');
      end;
      if VpaNumAtualizacao < 1545 Then
      begin
        VpfErro := '1545';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD C_SOW_IMC CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_SOW_IMC = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1545');
      end;
      if VpaNumAtualizacao < 1546 Then
      begin
        VpfErro := '1546';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD I_COE_PAD NUMBER(10) NULL');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1546');
      end;
      if VpaNumAtualizacao < 1547 Then
      begin
        VpfErro := '1547';
        ExecutaComandoSql(Aux,'CREATE TABLE REPRESENTADA ('+
                              ' CODREPRESENTADA NUMBER(10,0) NOT NULL, '+
                              ' NOMREPRESENTADA VARCHAR2(50) NULL, '+
                              ' NOMFANTASIA VARCHAR2(50) NULL,'+
                              ' DESENDERECO VARCHAR2(50) NULL,'+
                              ' DESBAIRRO VARCHAR2(30) NULL,'+
                              ' DESCEP VARCHAR2(9) NULL,'+
                              ' DESCOMPLEMENTO VARCHAR2(50) NULL,'+
                              ' NUMENDERECO NUMBER(10) NULL,'+
                              ' DESCIDADE VARCHAR2(40) NULL,'+
                              ' DESUF CHAR(2) NULL, '+
                              ' DESFONE VARCHAR2(20) NULL,'+
                              ' DESFAX VARCHAR2(20) NULL,'+
                              ' DESCNPJ VARCHAR2(18) NULL,'+
                              ' DESINSCRICAOESTADUAL VARCHAR2(20),'+
                              ' DESEMAIL VARCHAR2(100) NULL,'+
                              ' PRIMARY KEY(CODREPRESENTADA))');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1547');
      end;
      if VpaNumAtualizacao < 1548 Then
      begin
        VpfErro := '1548';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_FINANCEIRO ADD C_DEB_CRE CHAR(1) NULL');
        ExecutaComandoSql(Aux,'UPDATE CFG_FINANCEIRO SET C_DEB_CRE = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1548');
      end;
      if VpaNumAtualizacao < 1549 Then
      begin
        VpfErro := '1549';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(I_LAR_BAL NUMBER(10) NULL, '+
                              ' I_ALT_BAL NUMBER(10) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1549');
      end;
      if VpaNumAtualizacao < 1550 Then
      begin
        VpfErro := '1550';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMCORTEITEM ADD(LARENFESTO NUMBER(10) NULL, '+
                              ' ALTENFESTO NUMBER(10) NULL, '+
                              ' QTDENFESTO NUMBER(10,2) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1550');
      end;
      if VpaNumAtualizacao < 1551 Then
      begin
        VpfErro := '1551';
        ExecutaComandoSql(Aux,'ALTER TABLE ORDEMCORTEITEM ADD(POSFACA NUMBER(1) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1551');
      end;
      if VpaNumAtualizacao < 1552 Then
      begin
        VpfErro := '1552';
        ExecutaComandoSql(Aux,'ALTER TABLE CADPRODUTOS ADD(C_AGR_BAL CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update CADPRODUTOS set C_AGR_BAL = ''N''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1552');
      end;
      if VpaNumAtualizacao < 1553 Then
      begin
        VpfErro := '1553';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(I_LAR_PRE NUMBER(10) NULL, '+
                              ' I_ALT_PRE NUMBER(10) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1553');
      end;
      if VpaNumAtualizacao < 1554 Then
      begin
        VpfErro := '1554';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_PRODUTO ADD(C_IND_CAT CHAR(1) NULL)');
        ExecutaComandoSql(Aux,'Update CFG_PRODUTO set C_IND_CAT = ''F''');
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1554');
      end;
      if VpaNumAtualizacao < 1555 Then
      begin
        VpfErro := '1555';
        ExecutaComandoSql(Aux,'ALTER TABLE COMBINACAO ADD (SEQPRODUTOFIOTRAMA NUMBER(10) NULL,'+
                              ' SEQPRODUTOFIOAJUDA NUMBER(10) NULL,'+
                              ' CODCORFIOTRAMA NUMBER(10) NULL,'+
                              ' CODCORFIOAJUDA NUMBER(10) NULL)' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1555');
      end;
      if VpaNumAtualizacao < 1556 Then
      begin
        VpfErro := '1556';
        ExecutaComandoSql(Aux,'ALTER TABLE CFG_GERAL ADD(C_CHA_SEC CHAR(1)NULL)' );
        ExecutaComandoSql(Aux,'UPDATE CFG_GERAL SET C_CHA_SEC = ''F''' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1556');
      end;
      if VpaNumAtualizacao < 1557 Then
      begin
        VpfErro := '1557';
        ExecutaComandoSql(Aux,'ALTER TABLE CADGRUPOS ADD(C_EST_CPR CHAR(1)NULL)' );
        ExecutaComandoSql(Aux,'UPDATE CADGRUPOS SET C_EST_CPR = ''T''' );
        ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1557');
      end;
      VpfErro := AtualizaTabela1(VpaNumAtualizacao);
      if VpfErro = '' then
      begin
        VpfErro := AtualizaTabela2(VpaNumAtualizacao);
        if VpfErro = '' then
        begin
          VpfErro := AtualizaTabela3(VpaNumAtualizacao);
          if VpfErro = '' then
          begin
            VpfErro := AtualizaTabela4(VpaNumAtualizacao);
            if VpfErro = '' then
            begin
              VpfErro := AtualizaTabela5(VpaNumAtualizacao);
            end;
          end;
        end;
      end;
      VpfSemErros := true;
    except
      on E : Exception do
      begin
        Aux.sql.SaveToFile('comando.sql');
        Aux.Sql.text := E.message;
        Aux.Sql.SavetoFile('ErroInicio.txt');
        if Confirmacao(VpfErro + ' - Existe uma alteração para ser feita no banco de dados mas existem usuários'+
                    ' utilizando o sistema, ou algum outro sistema sendo utilizado no seu computador, é necessário'+
                    ' que todos os usuários saiam do sistema, para'+
                    ' poder continuar. Deseja continuar agora?') then
        Begin
          VpfSemErros := false;
          AdicionaSQLAbreTabela(Aux,'Select I_Ult_Alt from CFG_GERAL ');
          VpaNumAtualizacao := Aux.FieldByName('I_Ult_Alt').AsInteger;
        end
        else
          exit;
      end;
    end;
  until VpfSemErros;
//  FAbertura.painelTempo1.Fecha;
end;

{******************************************************************************}
function TAtualiza.AtualizaTabela1(VpaNumAtualizacao : Integer): String;
begin
  result := '';
  if VpaNumAtualizacao < 1429 Then
  begin
    result := '1429';
//    ExecutaComandoSql(Aux,'');
//    ExecutaComandoSql(Aux,'Update CFG_GERAL set I_Ult_Alt = 1429');
  end;
end;



function TAtualiza.AtualizaTabela2(VpaNumAtualizacao: Integer): String;
begin

end;

function TAtualiza.AtualizaTabela3(VpaNumAtualizacao: Integer): String;
begin

end;

function TAtualiza.AtualizaTabela4(VpaNumAtualizacao: Integer): String;
begin

end;

function TAtualiza.AtualizaTabela5(VpaNumAtualizacao: Integer): String;
begin

end;

{CFG_FISCAL
C_OPT_SIM

CadFormasPagamento
C_FLA_BCP
C_FLA_BCR

CFG_FISCAL
I_CLI_DEV

CFG_GERAL
C_COT_TPR

CFG_FINANCEIRO
C_CON_CAI

AMOSTRA
DESDEPARTAMENTO
INDCOPIA
}
end.

