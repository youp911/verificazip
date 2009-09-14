Unit UnAtualizacao;

interface
  Uses Classes, DbTables,SysUtils, APrincipal, Windows, Forms, UnVersoes,
       SQLExpr ;

Const
  CT_VersaoBanco = 1486;
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
  VpfRegistry : TRegistry;
begin
  VpfRegistry := TRegistry.Create;
  VpfRegistry.RootKey := HKEY_LOCAL_MACHINE;
  VpfRegistry.OpenKey(CT_DIRETORIOREGEDIT+'\Versoes',true);
  if UpperCase(CampoPermissaoModulo) = 'C_MOD_PON' then
    VpfRegistry.WriteString('PONTOLOJA',VersaoPontoLoja)
  else
    if UpperCase(CampoPermissaoModulo) = 'C_CON_SIS' then
      VpfRegistry.WriteString('CONFIGURACAOSISTEMA',VersaoConfiguracaoSistema)
    else
      if UpperCase(CampoPermissaoModulo) = 'C_MOD_FIN' then
        VpfRegistry.WriteString('FINANCEIRO',VersaoFinanceiro)
      else
        if UpperCase(CampoPermissaoModulo) = 'C_MOD_FAT' then
          VpfRegistry.WriteString('FATURAMENTO',VersaoFaturamento)
        else
          if UpperCase(CampoPermissaoModulo) = 'C_MOD_EST' then
            VpfRegistry.WriteString('ESTOQUE',VersaoEstoque)
          else
            if UpperCase(CampoPermissaoModulo) = 'C_MOD_CHA' then
              VpfRegistry.WriteString('CHAMADO',VersaoChamadoTecnico)
            else
              if UpperCase(CampoPermissaoModulo) = 'C_MOD_AGE' then
                VpfRegistry.WriteString('AGENDA',VersaoAgenda)
              else
                if UpperCase(CampoPermissaoModulo) = 'C_MOD_CRM' then
                  VpfRegistry.WriteString('CRM',VersaoCRM)
                else
                  if UpperCase(CampoPermissaoModulo) = 'C_MOD_CAI' then
                    VpfRegistry.WriteString('CAIXA',VersaoCaixa);


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
}
end.

