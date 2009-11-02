Unit UnChamado;
{Verificado
-.edit;
}
Interface

Uses Classes, DBTables, UnDados, SysUtils,IdBaseComponent, IdMessage, IdComponent,
     IdTCPConnection, IdTCPClient,IdMessageClient, IdSMTP, UnDadosProduto, FunObjeto,
     unProdutos,IdAttachment, idText, SQLExpr, Tabela;

//classe localiza
Type TRBLocalizaChamado = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesChamado = class(TRBLocalizaChamado)
  private
    Aux,
    Chamado,
    Chamado2 : TSQLQuery;
    Cadastro : TSQL;
    Mensagem : TidMessage;
    SMTP : TIdSMTP;
    function RNumChamadoDisponivel(VpaCodfilial : Integer): Integer;
    function RSeqEstagioDisponivel(VpaCodFilial,VpaNumChamado : Integer):Integer;
    function RDesContrato(VpaCodFilial, VpaSeqContrato : Integer) : string;
    function RSeqEmailDisponivel(VpaCodFilial, VpaNumchamado : Integer): Integer;
    function RSeqChamadoParcialDiponivel(VpaCodFilial,VpaNumChamado : Integer):integer;
    procedure MontaCabecalhoEmailModelo1(VpaTexto : TStrings; VpaDChamado : TRBDChamado;VpaDFilial : TRBDFilial);
    procedure MontaEmailChamadoCelular(VpaTexto : TStrings;VpaDChamado : TRBDChamado;VpaDCliente : TRBDCliente);
    procedure MontaEmailChamadoModelo1(VpaTexto : TStrings;VpaDChamado : TRBDChamado;VpaDCliente : TRBDCliente;VpaDFilial : TRBDFilial);
    procedure MontaEmailChamadoTexto(VpaTexto : TStrings;VpaDChamado : TRBDChamado;VpaDCliente : TRBDCliente);
    procedure ApagaDChamadoProduto(VpaCodFilial, VpaNumChamado: Integer);
    procedure ApagaDChamadoServicoExecutado(VpaCodFilial, VpaNumChamado: Integer);
    procedure ApagaDChamadoServicoOrcado(VpaCodFilial, VpaNumChamado: Integer);
    procedure ApagaDChamadoProdutoOrcado(VpaCodFilial, VpaNumChamado: Integer);
    procedure CarDServicoExecutadoChamado(VpaDChamado: TRBDChamado; VpaDProdutoChamado: TRBDChamadoProduto);
    procedure CarDProdutoOrcadoChamado(VpaDChamado: TRBDChamado; VpaDProdutoChamado: TRBDChamadoProduto);
    procedure CarDServicoOrcadoChamado(VpaDChamado: TRBDChamado; VpaDProdutoChamado: TRBDChamadoProduto);
    procedure CarDProdutoChamado(VpaDChamado : TRBDChamado);
    procedure CarDProdutoExtraChamado(VpaDChamado : TRBDChamado);
    procedure CarDChamadoCotacao(VpaDChamado : TRBDChamado;VpaDCotacao : TRBDOrcamento);
    procedure CarDChamadoCotacaoProduto(VpaDChamado : TRBDChamado;VpaDCotacao : TRBDOrcamento);
    function GravaDProdutoChamado(VpaDChamado : TRBDChamado) : string;
    function GravaDChamadoServicoExecutado(VpaDChamado: TRBDChamado): String;
    function GravaDChamadoProdutoOrcado(VpaDChamado: TRBDChamado): String;
    function GravaDChamadoServicoOrcado(VpaDChamado: TRBDChamado): String;
    function GravaLogEstagio(VpaCodFilial, VpaNumChamado,VpaCodEstagio,VpaCodUsuario : Integer;VpaDesMotivo : String):String;
    function GravaDChamadoParcialProduto(VpaDChamado : TRBDChamado;VpaDParcial : TRBDChamadoParcial):string;
    function GravaDChamadoProdutoExtra(VpaDChamado : TRBDChamado):string;
    function BaixaEstoqueBaixaParcial(VpaDChamado : TRBDChamado;VpaDParcial : TRBDChamadoParcial) : string;
    function CadastraNumeroSerieProduto(VpaDChamado : TRBDChamado) : string;
  public
    constructor cria(VpaBaseDados : TSqlConnection);
    destructor destroy;override;
    function GravaDChamado(VpaDChamado : TRBDChamado) : String;
    function GravaDChamadoParcial(VpaDChamado : TRBDChamado;VpaDParcial : TRBDChamadoParcial):String;
    procedure CarDChamado(VpaCodFilial,VpaNumChamado : Integer;VpaDChamado : TRBDChamado);
    function AlteraEstagioChamado(VpaCodFilial,VpaNumChamando, VpaCodUsuario, VpaCodEstagio : Integer;VpaDesMotivo : String):String;
    function AlteraEstagioChamados(VpaCodFilial, VpaCodUsuario, VpaCodEstagio : Integer;VpaChamados, VpaDesMotivo : String):String;
    function AlteraAgendaTecnico(VpaCodFilial,VpaNumChamado, VpaCodTecnico : Integer;VpaDatPrevista : TDateTime):String;
    function AlteraTecnico(VpaCodFilial,VpaNumChamado,VpaCodTecnico : Integer) : string;
    procedure SetaPesquisaSatisfacaoRealizada(VpaCodFilial,VpaNumChamado : Integer);
    function ExcluiChamado(VpaCodFilial,VpaNumChamado : Integer):String;
    function EnviaEmailChamado(VpaDChamado : TRBDChamado;VpaDCliente : TRBDCliente;VpaEmail : string):String;
    function GravaDEmail(VpaDChamado: TRBDChamado;VpaDesEmail : String): String;
    function RNomeTecnico(VpaCodTecnico : Integer):String;
    function RNomeTipoContrato(VpaCodTipo : Integer):String;
    function GeraFichaImplantacaoChamado(VpaDCotacao : TRBDOrcamento):String;
    function REmailTecnico(VpaCodTecnico : Integer):String;
    procedure MarcaProdutosExtraFaturado(VpaCodFilial,VpaNumChamado : Integer);
end;



implementation

Uses FunSql, FunString, Constantes, FunData, UnSistema, UnClientes;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaChamado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaChamado.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesChamado
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesChamado.cria(VpaBaseDados : TSqlConnection);
begin
  inherited create;
  Cadastro := TSQL.create(nil);
  Cadastro.ASQLConnection := VpaBaseDados;
  Aux := TSQLQuery.create(nil);
  Aux.SQLConnection := VpaBaseDados;
  Chamado := TSQLQuery.create(nil);
  Chamado.SQLConnection := VpaBaseDados;
  Chamado2:= TSQLQuery.create(nil);
  Chamado2.SQLConnection := VpaBaseDados;
  Mensagem := TIdMessage.Create(nil);
  SMTP := TIdSMTP.Create(nil);
end;

{******************************************************************************}
destructor TRBFuncoesChamado.destroy;
begin
  Aux.free;
  Cadastro.free;
  Chamado.free;
  Chamado2.Free;
  Mensagem.free;
  SMTP.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesChamado.RNumChamadoDisponivel(VpaCodfilial : Integer): Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select max(NUMCHAMADO) ULTIMO from CHAMADOCORPO '+
                            ' Where CODFILIAL = ' +IntToStr(VpaCodfilial));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesChamado.RSeqEstagioDisponivel(VpaCodFilial,VpaNumChamado : Integer):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select Max(SEQESTAGIO) ULTIMO from ESTAGIOCHAMADO '+
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and NUMCHAMADO = '+ IntToStr(VpaNumChamado));
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesChamado.RDesContrato(VpaCodFilial, VpaSeqContrato : Integer) : string;
begin
  AdicionaSQLAbreTabela(Aux,'select TIP.NOMTIPOCONTRATO '+
                            ' from CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                            ' Where CON.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO '+
                            ' and CON.CODFILIAL = ' + IntToStr(VpaCodFilial)+
                            ' and CON.SEQCONTRATO = '+ IntToStr(VpaSeqContrato));
  Result := Aux.FieldByName('NOMTIPOCONTRATO').AsString;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.MontaCabecalhoEmailModelo1(VpaTexto : TStrings; VpaDChamado : TRBDChamado;VpaDFilial : TRBDFilial);
var
  Vpfbmppart : TIdAttachment;
Begin
  VpaTexto.add('<html>');
  VpaTexto.add('<title> '+Sistema.RNomFilial(VpaDChamado.CodFilial)+' - Chamado : '+IntToStr(VpaDChamado.NumChamado));
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<table width=100%>');
  VpaTexto.add('  <tr>');
  VpaTexto.add('    <td width='+IntToStr(varia.CRMTamanhoLogo)+' bgcolor="#'+varia.CRMCorClaraEmail+'">');
  VpaTexto.add('    <a href="http://'+VpaDFilial.DesSite+ '">');
  VpaTexto.add('      <IMG src="cid:'+IntToStr(VpaDChamado.CodFilial)+'.jpg" width='+IntToStr(varia.CRMTamanhoLogo)+' height = '+IntToStr(Varia.CRMAlturaLogo)+' border = 0>');
  VpaTexto.add('    </a></td> <td bgcolor="#'+varia.CRMCorClaraEmail+'"> <font size = "2">');
  VpaTexto.add('    <b>'+VpaDFilial.NomFantasia+ '.</b>');
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesEndereco+'              Bairro : '+VpaDFilial.DesBairro);
  VpaTexto.add('    <br>');
  VpaTexto.add('    '+VpaDFilial.DesCidade +' / '+VpaDFilial.DesUF+ '                CEP : '+VpaDFilial.DesCep);
  VpaTexto.add('    <br>');
  VpaTexto.add('    Fone : '+VpaDFilial.DesFone +'         -             e-mail :'+VpaDFilial.DesEmailComercial);
  VpaTexto.add('    <br>');
  VpaTexto.add('    site : <a href="http://'+VpaDFilial.DesSite+'">'+VpaDFilial.DesSite);
  VpaTexto.add('    </td><td bgcolor="#'+varia.CRMCorClaraEmail+'">' );
  VpaTexto.add('    <center>');
  VpaTexto.add('    <b>Chamado');
  VpaTexto.add('    <br> '+formatFloat('###,###,##0',VpaDChamado.NumChamado)+'</b>');
  VpaTexto.add('    </center>');
  VpaTexto.add('    </td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('</left>');
  VpaTexto.add('    <br>');
//d5  Vpfbmppart := TIdAttachment.Create(Mensagem.MessageParts,varia.PathVersoes+'\'+inttoStr(VpaDChamado.CodFilial)+'.jpg');
  Vpfbmppart.ContentType := 'image/jpg';
  Vpfbmppart.ContentDisposition := 'inline';
  Vpfbmppart.ExtraHeaders.Values['content-id'] := inttoStr(VpaDChamado.CodFilial)+'.jpg';
  Vpfbmppart.DisplayName := inttoStr(VpaDChamado.CodFilial)+'.jpg';
end;

{******************************************************************************}
procedure TRBFuncoesChamado.MontaEmailChamadoCelular(VpaTexto : TStrings;VpaDChamado : TRBDChamado;VpaDCliente : TRBDCliente);
Var
  VpfLaco : Integer;
  VpfDProChamado : TRBDChamadoProduto;
  VpfDatGarantia : string;
begin
  VpaTexto.add('<html>');
  VpaTexto.add('<head><title>Chamado</title>');
  VpaTexto.add('</head>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  VpaTexto.add('<b>'+varia.NomeFilial+'</b></font><br />');
  VpaTexto.add('</b></left>');
  VpaTexto.add('<center>');
  VpaTexto.add('<b>Chamado '+IntToStr(VpaDChamado.NumChamado)+'</b><br />');
  VpaTexto.add('</b></font></center><br />');
  VpaTexto.add('');
  VpaTexto.add('<center>');
  VpaTexto.add('<table width="95%" border="1">');
  VpaTexto.add('<tr>');
  VpaTexto.add('        <td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Cliente</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+IntToStr(VpaDCliente.CodCliente)+'-'+UpperCase(VpaDCliente.NomCliente)+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Nome Fantasia</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+UpperCase(VpaDCliente.NomFantasia)+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Endere�o </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+UpperCase(VpaDCliente.DesEndereco+','+VpaDCliente.NumEndereco+'-'+VpaDCliente.DesComplementoEndereco)+ '</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Bairro</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+UPPERCASE(VpaDCliente.DesBairro)+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Cidade </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+UpperCase(VpaDCliente.DesCidade+' / '+VpaDCliente.DesUF) +'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Fone</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+VpaDCliente.DesFone1+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Contato </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+UpperCase(VpaDChamado.NomContato)+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Solicitante</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+UpperCase(VpaDChamado.NomSolicitante)+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;End Atendimento </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+UpperCase(VpaDChamado.DesEnderecoAtendimento)+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</center>');
  VpaTexto.add('');
  VpaTexto.add('<center>');
  VpaTexto.add('<table width="95%" border="0">');
  VpaTexto.add('<br>');
  VpaTexto.add('<tr>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Data Chamado</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+FormatDateTime('DD/MM/YYYY HH:MM',VpaDChamado.DatChamado)+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Usu�rio</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+UpperCase(Sistema.RNomUsuario(VpaDChamado.CodUsuario))+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td>&nbsp;</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td>&nbsp;</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;T�cnico</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+UpperCase(RNomeTecnico(VpaDChamado.CodTecnico))+' </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#E1E1FF"><font face="Verdana" size="1"><b>&nbsp;Previs�o Atendimento</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td bgcolor="#CCCCFF"><font face="Verdana" size="2"><li>&nbsp;'+FormatDateTime('DD/MM/YYYY HH:MM',VpaDChamado.DatPrevisao)+'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table>');
  for vpflaco := 0 to VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDProChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLaco]);
    if VpfDProChamado.DatGarantia > MontaData(1,1,1900) then
     VpfDatGarantia := FormatDateTime('DD/MM/YYYY',VpfDProChamado.DatGarantia)
    else
      VpfDatGarantia := '';
    VpaTexto.add('<table width="95%" border="0" valign="top">');
    VpaTexto.add('<tr><br>');
    VpaTexto.add('	<td bgcolor="#E1E1FF" <font face="Verdana" size="3"><b>Produto '+IntToStr(VpfLaco+1)+' de '+IntToStr(VpaDChamado.Produtos.Count)+' </td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('	<td bgcolor="#CCCCFF" <font face="Verdana" size="-1"><li>&nbsp;'+UpperCase(VpfDProChamado.CodProduto+'-'+ VpfDProChamado.NomProduto)+'</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('	<td bgcolor="#E1E1FF" <font face="Verdana" size="-1"><b>&nbsp;Contrato</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('        <td bgcolor="#CCCCFF" <font face="Verdana" size="-1"><li>&nbsp;'+UpperCase(VpfDProChamado.DesContrato)+'</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('	<td bgcolor="#E1E1FF" <font face="Verdana" size="-1"><b>&nbsp;Num S�rie</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('	<td bgcolor="#CCCCFF" <font face="Verdana" size="-1"><li>&nbsp;'+UpperCase(VpfDProChamado.NumSerie) +'</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('	<td bgcolor="#E1E1FF" <font face="Verdana" size="-1"><b>&nbsp;Garantia</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('        <td bgcolor="#CCCCFF" <font face="Verdana" size="-1"><li>&nbsp;'+VpfDatGarantia+' </td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('     <td bgcolor="#E1E1FF" <font face="Verdana" size="-1">&nbsp;Problema </td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('     <td bgcolor="#CCCCFF" <font face="Verdana" size="-1"><li>&nbsp;'+UpperCase(VpfDProChamado.DesProblema)+' </td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('</table>');
  end;
  VpaTexto.add('</body></html>');
end;

{******************************************************************************}
procedure TRBFuncoesChamado.MontaEmailChamadoModelo1(VpaTexto : TStrings;VpaDChamado : TRBDChamado;VpaDCliente : TRBDCliente;VpaDFilial : TRBDFilial);
var
  VpfLaco, VpfLacoDescricao : Integer;
  VpfDProdutoChamado : TRBDChamadoProduto;
  VpfDatGarantia : String;
  VpfDescricaoTecnica : TStringList;
begin
  VpfDescricaoTecnica := TStringList.create;
  MontaCabecalhoEmailModelo1(VpaTexto,VpaDChamado,VpaDFilial);
  VpaTexto.add('<table border = 0 cellpadding="0" cellspacing="0" width=100%  >');
  VpaTexto.add('  <tr>');
  VpaTexto.add('<td width="25%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Data Chamado</td><td width="30%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY - HH:MM:SS',VpaDChamado.DatChamado)+'</td>');
  VpaTexto.add('<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Tecnico</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+RNomeTecnico(VpaDChamado.CodTecnico) +'</td>');
  VpaTexto.add('  </tr><tr>');
  VpaTexto.add('<td width="25%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Previs�o Atendimento</td><td width="30%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+FormatDateTime('DD/MM/YYYY - HH:MM:SS',VpaDChamado.DatPrevisao)+'</td>');
  VpaTexto.add('<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Usu�rio</td><td width="35%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+Sistema.RNomUsuario(VpaDChamado.CodUsuario) +'</td>');
  VpaTexto.add('  </tr>');
  VpaTexto.add('</table>');
  VpaTexto.add('    <br>');

  VpaTexto.add('<table border = 0 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Cliente</td>');
  VpaTexto.add('	<td colspan="5" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="2">&nbsp;'+IntToStr(VpaDChamado.CodCliente)+ '-'+VpaDCliente.NomCliente +' </td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="0"><b>&nbsp;Endere&ccedil;o</td>');
  VpaTexto.add('	<td width="45%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1">&nbsp;'+VpaDCliente.DesEndereco+'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="0"><b>&nbsp;Bairro</td>');
  VpaTexto.add('	<td width="30%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1">&nbsp;'+VpaDCliente.DesBairro +'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="0"><b>&nbsp;Cidade</td>');
  VpaTexto.add('	<td width="45%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1">&nbsp;'+VpaDCliente.DesCidade+'/'+VpaDCliente.DesUF +'</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="0"><b>&nbsp;Fone</td>');
  VpaTexto.add('	<td width="30%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1">&nbsp;'+VpaDCliente.DesFone1 +'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="0"><b>&nbsp;Contato</td>');
  VpaTexto.add('	<td width="45%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1">&nbsp;'+VpaDChamado.NomContato +'</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="0"><b>&nbsp;Solicitante</td>');
  VpaTexto.add('	<td width="30%" bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1">&nbsp;<b>'+VpaDChamado.NomSolicitante+'</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="0"><b>&nbsp;Atend.</td>');
  VpaTexto.add('	<td colspan=5 bgcolor="#'+varia.CRMCorEscuraemail+'"><font face="Verdana" size="1">&nbsp;'+VpaDChamado.DesEnderecoAtendimento +'</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');



  VpaTexto.add('<table border=1 cellpadding="0" cellspacing="0" width="100%">');
  for VpfLaco := 0 to VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDProdutoChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLaco]);
    if VpfDProdutoChamado.DatGarantia > MontaData(1,1,1900) then
      VpfDatGarantia := FormatDateTime('DD/MM/YYYY',VpfDProdutoChamado.DatGarantia)
    else
      VpfDatGarantia := '';
    VpaTexto.add('<tr> ');
    VpaTexto.add('        <td width="40%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-2">&nbsp;Produto</td>');
    VpaTexto.add('        <td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-2">&nbsp;Contrato</td>');
    VpaTexto.add('	<td width="20%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-2">&nbsp;Numero S�rie </td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-2">&nbsp;Garantia</td>');
    VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'" align="center"><font face="Verdana" size="-2">&nbsp;Setor</td>');
    VpaTexto.add('</tr><tr>');
    VpaTexto.add('    <td width="40%" align="left"><font face="Verdana" size="-2">&nbsp;'+VpfDProdutoChamado.NomProduto+ '</td>');
    VpaTexto.add('    <td width="15%" align="left"><font face="Verdana" size="-2">&nbsp;'+VpfDProdutoChamado.DesContrato+'</td>');
    VpaTexto.add('    <td width="20%" align="right"><font face="Verdana" size="-2">&nbsp;'+VpfDProdutoChamado.NumSerie +'</td>');
    VpaTexto.add('    <td width="10%" align="right"><font face="Verdana" size="-2">&nbsp;'+VpfDatGarantia +'</td>');
    VpaTexto.add('    <td width="10%" align="right"><font face="Verdana" size="-2">&nbsp;'+VpfDProdutoChamado.DesSetor +'</td>');

    VpaTexto.add('    </tr><tr>');
    VpaTexto.add('    <td colspan=6 align="left" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="-2"><b>Problema</td>');
    VpaTexto.add('    </tr><tr>');
    VpaTexto.add('    <td colspan=6 align="left" ><font face="Verdana" size="-2">');
    VpfDescricaoTecnica.Text := VpfDProdutoChamado.DesProblema;
    for VpfLacoDescricao := 0 to VpfDescricaoTecnica.Count - 1 do
      VpaTexto.add(VpfDescricaoTecnica.Strings[VpfLacoDescricao]+'<br>');
    VpaTexto.add('    </td>');
    VpaTexto.add('    </tr>');
  end;
  VpaTexto.add('</table>');
  VpaTexto.add('Servi�os Prestados');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');
  VpaTexto.add('Observa��es');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');
  VpaTexto.add('<hr>');



  VpaTexto.add('<table border=0 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Chamado </td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FormatFloat(varia.MascaraValor,VpaDChamado.ValChamado)+'</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Pe�as</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">_____________</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Deslocamento </td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;'+FormatFloat(varia.MascaraValor,VpaDChamado.ValDeslocamento)+'</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Quantidade Horas Adicionais</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">_____________</td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td colspan=2 bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Valor Total</td>');
  VpaTexto.add('	<td width="25%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">______________</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');

  VpaTexto.add('<table border=0 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Atendimento</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;___/___/___</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Hora Cheqada</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;Hora Saida</td>');
  VpaTexto.add('	<td width="15%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorClaraemail+'"><font face="Verdana" size="1"><b>&nbsp;KM</td>');
  VpaTexto.add('	<td width="10%" bgcolor="#'+varia.CRMCorEscuraEmail+'"><font face="Verdana" size="2">&nbsp;</td>');
  VpaTexto.add('</tr>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<br>');
  VpaTexto.add('<table border=0 cellpadding="0" cellspacing="0" width="100%">');
  VpaTexto.add('<tr>');
  VpaTexto.add('	<td width="30%" ><b><hr></td>');
  VpaTexto.add('	<td width="10%" ></td>');
  VpaTexto.add('	<td width="60%" ><b><hr></td>');
  VpaTexto.add('</tr><tr>');
  VpaTexto.add('	<td width="30%" align="center" >Tecnico Atendimento</td>');
  VpaTexto.add('	<td width="10%" ></td>');
  VpaTexto.add('	<td width="60%" align="center" >'+VpaDCliente.NomCliente+'</td>');
  VpaTexto.add('</table><br>');
  VpaTexto.add('<right><font face="Verdana" size="0">A assinatura do cliente, certifica de que ele est� de acordo com os servi�os executados e com os d�bitos lan�ados neste relat�rio');
  VpaTexto.add('</right>');
  VpaTexto.add('<br>');

  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  VpaTexto.add('<address>Sistema de gest�o desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Efic�cia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
end;

{******************************************************************************}
procedure TRBFuncoesChamado.MontaEmailChamadoTexto(VpaTexto : TStrings;VpaDChamado : TRBDChamado;VpaDCliente : TRBDCliente);
Var
  VpfLaco : Integer;
  VpfDProChamado : TRBDChamadoProduto;
begin
  VpaTexto.add('Chamado '+IntToStr(VpaDChamado.NumChamado));
  VpaTexto.add('');
  VpaTexto.add('Cliente');
  VpaTexto.add(UpperCase(IntToStr(VpaDCliente.CodCliente)+'-'+VpaDCliente.NomCliente));
  VpaTexto.add('Nome Fantasia');
  VpaTexto.add(UpperCase(VpaDCliente.NomFantasia));
  VpaTexto.add('Endere�o');
  VpaTexto.add(UpperCase(VpaDCliente.DesEndereco+','+VpaDCliente.NumEndereco+'-'+VpaDCliente.DesComplementoEndereco));
  VpaTexto.add('Bairro');
  VpaTexto.add(UPPERCASE(VpaDCliente.DesBairro));
  VpaTexto.add('Cidade');
  VpaTexto.add(UpperCase(VpaDCliente.DesCidade+' / '+VpaDCliente.DesUF));
  VpaTexto.add('Fone');
  VpaTexto.add(VpaDCliente.DesFone1);
  VpaTexto.add('Contato');
  VpaTexto.add(UpperCase(VpaDChamado.NomContato));
  VpaTexto.add('Solicitante');
  VpaTexto.add(UpperCase(VpaDChamado.NomSolicitante));
  VpaTexto.add('End Atendimento');
  VpaTexto.add(UpperCase(VpaDChamado.DesEnderecoAtendimento));
  VpaTexto.add('Data Chamado');
  VpaTexto.add(FormatDateTime('DD/MM/YYYY HH:MM',VpaDChamado.DatChamado));
  VpaTexto.add('Usu�rio');
  VpaTexto.add(UpperCase(Sistema.RNomUsuario(VpaDChamado.CodUsuario)));
  VpaTexto.add('T�cnico');
  VpaTexto.add(UpperCase(RNomeTecnico(VpaDChamado.CodTecnico)));
  VpaTexto.add('Previs�o Atendimento');
  VpaTexto.add(FormatDateTime('DD/MM/YYYY HH:MM',VpaDChamado.DatPrevisao));
  for vpflaco := 0 to VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDProChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLaco]);
    VpaTexto.add('');
    VpaTexto.add('Produto '+IntToStr(VpfLaco+1)+' de '+IntToStr(VpaDChamado.Produtos.Count));
    VpaTexto.add(UpperCase(VpfDProChamado.CodProduto+'-'+ VpfDProChamado.NomProduto));
    VpaTexto.add('Contrato');
    VpaTexto.add(UpperCase(VpfDProChamado.DesContrato));
    VpaTexto.add('Num S�rie');
    VpaTexto.add(UpperCase(VpfDProChamado.NumSerie));
    VpaTexto.add('Garantia');
    VpaTexto.add(FormatDateTime('DD/MM/YYYY',VpfDProChamado.DatGarantia));
    VpaTexto.add('Problema');
    VpaTexto.add(UpperCase(VpfDProChamado.DesProblema));
    VpaTexto.add('');
  end;
end;


{******************************************************************************}
procedure TRBFuncoesChamado.CarDServicoExecutadoChamado(VpaDChamado: TRBDChamado; VpaDProdutoChamado: TRBDChamadoProduto);
var
  VpfChamadoServicoExecutado: TRBDChamadoServicoExecutado;
begin
  AdicionaSQLAbreTabela(Chamado2,'SELECT'+
                                 ' CSE.CODFILIAL, CSE.NUMCHAMADO, CSE.SEQITEM, CSE.SEQITEMEXECUTADO,'+
                                 ' CSE.CODEMPRESASERVICO,'+
                                 ' CSE.CODSERVICO, SER.C_NOM_SER,'+
                                 ' CSE.QTDSERVICO, CSE.VALSERVICO, CSE.VALTOTAL'+
                                 ' FROM CHAMADOSERVICOEXECUTADO CSE, CADSERVICO SER'+
                                 ' WHERE'+
                                 ' CSE.CODFILIAL = '+IntToStr(VpaDChamado.CodFilial)+
                                 ' AND CSE.NUMCHAMADO = '+IntToStr(VpaDChamado.NumChamado)+
                                 ' AND CSE.SEQITEM = '+IntToStr(VpaDProdutoChamado.SeqItem)+
                                 ' AND CSE.CODSERVICO = SER.I_COD_SER'+
                                 ' ORDER BY SEQITEMEXECUTADO');
  FreeTObjectsList(VpaDProdutoChamado.ServicosExecutados);
  while not Chamado2.Eof do
  begin
    VpfChamadoServicoExecutado:= VpaDProdutoChamado.AddServicoExecutado;

    VpfChamadoServicoExecutado.CodServico:= Chamado2.FieldByName('CODSERVICO').AsInteger;
    VpfChamadoServicoExecutado.CodEmpresaServico:= Chamado2.FieldByName('CODEMPRESASERVICO').AsInteger;
    VpfChamadoServicoExecutado.SeqItemExecutado:= Chamado2.FieldByName('SEQITEMEXECUTADO').AsInteger;
    VpfChamadoServicoExecutado.NomServico:= Chamado2.FieldByName('C_NOM_SER').AsString;
    VpfChamadoServicoExecutado.Quantidade:= Chamado2.FieldByName('QTDSERVICO').AsFloat;
    VpfChamadoServicoExecutado.ValUnitario:= Chamado2.FieldByName('VALSERVICO').AsFloat;
    VpfChamadoServicoExecutado.ValTotal:= Chamado2.FieldByName('VALTOTAL').AsFloat;

    Chamado2.Next;
  end;
  Chamado2.Close;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.CarDProdutoOrcadoChamado(VpaDChamado: TRBDChamado; VpaDProdutoChamado: TRBDChamadoProduto);
var
  VpfChamadoProdutoOrcado: TRBDChamadoProdutoOrcado;
begin
  AdicionaSQLAbreTabela(Chamado2,'SELECT CPO.CODFILIAL, CPO.NUMCHAMADO, CPO.SEQITEM,'+
                                 ' CPO.SEQITEMORCADO, CPO.SEQPRODUTO, CPO.QTDPRODUTO,'+
                                 ' CPO.VALUNITARIO, CPO.VALTOTAL, CPO.DESUM,'+
                                 ' CPO.INDAPROVADO, PRO.C_COD_PRO, PRO.C_NOM_PRO'+
                                 ' FROM CHAMADOPRODUTOORCADO CPO, CADPRODUTOS PRO'+
                                 ' WHERE CPO.SEQPRODUTO = PRO.I_SEQ_PRO'+
                                 ' AND CPO.CODFILIAL = '+IntToStr(VpaDChamado.CodFilial)+
                                 ' AND CPO.NUMCHAMADO = '+IntToStr(VpaDChamado.NumChamado)+
                                 ' AND CPO.SEQITEM = '+IntToStr(VpaDProdutoChamado.SeqItem));
  FreeTObjectsList(VpaDProdutoChamado.ProdutosOrcados);
  while not Chamado2.Eof do
  begin
    VpfChamadoProdutoOrcado:= VpaDProdutoChamado.AddProdutoOrcado;

    VpfChamadoProdutoOrcado.SeqItemOrcado:= Chamado2.FieldByName('SEQITEMORCADO').AsInteger;
    VpfChamadoProdutoOrcado.SeqProduto:= Chamado2.FieldByName('SEQPRODUTO').AsInteger;
    VpfChamadoProdutoOrcado.Quantidade:= Chamado2.FieldByName('QTDPRODUTO').AsFloat;
    VpfChamadoProdutoOrcado.ValUnitario:= Chamado2.FieldByName('VALUNITARIO').AsFloat;
    VpfChamadoProdutoOrcado.ValTotal:= Chamado2.FieldByName('VALTOTAL').AsFloat;
    VpfChamadoProdutoOrcado.DesUM:= Chamado2.FieldByName('DESUM').AsString;
    if Chamado2.FieldByName('INDAPROVADO').AsString = 'S' then
      VpfChamadoProdutoOrcado.IndAprovado:= True
    else
      VpfChamadoProdutoOrcado.IndAprovado:= False;
    VpfChamadoProdutoOrcado.CodProduto:= Chamado2.FieldByName('C_COD_PRO').AsString;
    VpfChamadoProdutoOrcado.NomProduto:= Chamado2.FieldByName('C_NOM_PRO').AsString;
    VpfChamadoProdutoOrcado.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpfChamadoProdutoOrcado.DesUM);

    Chamado2.Next;
  end;
  Chamado2.Close;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.CarDServicoOrcadoChamado(VpaDChamado: TRBDChamado; VpaDProdutoChamado: TRBDChamadoProduto);
var
  VpfChamadoServicoOrcado: TRBDChamadoServicoOrcado;
begin
  AdicionaSQLAbreTabela(Chamado2,'SELECT CSO.CODFILIAL, CSO.NUMCHAMADO, CSO.SEQITEM,'+
                                 ' CSO.SEQITEMORCADO, CSO.CODEMPRESASERVICO, CSO.CODSERVICO,'+
                                 ' CSO.QTDSERVICO, CSO.VALSERVICO, CSO.VALTOTAL, CSO.INDAPROVADO,'+
                                 ' SER.C_NOM_SER'+
                                 ' FROM CHAMADOSERVICOORCADO CSO, CADSERVICO SER'+
                                 ' WHERE'+
                                 ' CSO.CODSERVICO = SER.I_COD_SER'+
                                 ' AND CSO.CODFILIAL = '+IntToStr(VpaDChamado.CodFilial)+
                                 ' AND CSO.NUMCHAMADO = '+IntToStr(VpaDChamado.NumChamado)+
                                 ' AND CSO.SEQITEM = '+IntToStr(VpaDProdutoChamado.SeqItem));
  FreeTObjectsList(VpaDProdutoChamado.ServicosOrcados);
  while not Chamado2.Eof do
  begin
    VpfChamadoServicoOrcado:= VpaDProdutoChamado.AddServicoOrcado;

    VpfChamadoServicoOrcado.SeqItemOrcado:= Chamado2.FieldByName('SEQITEMORCADO').AsInteger;
    VpfChamadoServicoOrcado.CodEmpresaServico:= Chamado2.FieldByName('CODEMPRESASERVICO').AsInteger;
    VpfChamadoServicoOrcado.CodServico:= Chamado2.FieldByName('CODSERVICO').AsInteger;
    VpfChamadoServicoOrcado.QtdServico:= Chamado2.FieldByName('QTDSERVICO').AsFloat;
    VpfChamadoServicoOrcado.ValUnitario:= Chamado2.FieldByName('VALSERVICO').AsFloat;
    VpfChamadoServicoOrcado.ValTotal:= Chamado2.FieldByName('VALTOTAL').AsFloat;
    if Chamado2.FieldByName('INDAPROVADO').AsString = 'S' then
      VpfChamadoServicoOrcado.IndAprovado:= True
    else
      VpfChamadoServicoOrcado.IndAprovado:= False; 
    VpfChamadoServicoOrcado.NomServico:= Chamado2.FieldByName('C_NOM_SER').AsString;

    Chamado2.Next;
  end;
  Chamado2.Close;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.CarDProdutoChamado(VpaDChamado : TRBDChamado);
var
  VpfDProdutoChamado : TRBDChamadoProduto;
begin
  AdicionaSQLAbreTabela(Chamado,'SELECT CHP.SEQITEM, CHP.SEQPRODUTO, CHP.NUMCONTADOR, CHP.NUMSERIE, CHP.NUMSERIEINTERNO, '+
                                ' CHP.DESSETOR, CHP.SEQCONTRATO, CHP.SEQITEMCONTRATO, CHP.DESPROBLEMA, '+
                                ' CHP.DESSERVICOEXECUTADO, CHP.CODFILIALCONTRATO,CHP.DATGARANTIA, CHP.DESUM, '+
                                ' CHP.QTDPRODUTO, CHP.QTDBAIXADO, CHP.SEQITEMPRODUTOCLIENTE, ' +
                                ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL '+
                                ' FROM CHAMADOPRODUTO CHP, CADPRODUTOS PRO '+
                                ' Where CHP.CODFILIAL = ' +IntToStr(VpaDChamado.CodFilial)+
                                ' AND CHP.NUMCHAMADO = '+IntToStr(VpaDChamado.NumChamado)+
                                ' AND CHP.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                                ' order by SEQITEM ');
  While not Chamado.eof do
  begin
    VpfDProdutoChamado := VpaDChamado.AddProdutoChamado;
    with VpfDProdutoChamado do
    begin
      SeqItem := Chamado.FieldByName('SEQITEM').AsInteger;
      CodFilialChamado := Chamado.FieldByName('CODFILIALCONTRATO').AsInteger;
      SeqContrato := Chamado.FieldByName('SEQCONTRATO').AsInteger;
      SeqItemContrato := Chamado.FieldByName('SEQITEMCONTRATO').AsInteger;
      SeqItemProdutoCliente := Chamado.FieldByName('SEQITEMPRODUTOCLIENTE').AsInteger;
      SeqProduto := Chamado.FieldByName('SEQPRODUTO').AsInteger;
      CodProduto := Chamado.FieldByName('C_COD_PRO').AsString;
      NomProduto := Chamado.FieldByName('C_NOM_PRO').AsString;
      NumSerie := Chamado.FieldByName('NUMSERIE').AsString;
      NumSerieInterno := Chamado.FieldByName('NUMSERIEINTERNO').AsString;
      DesSetor := Chamado.FieldByName('DESSETOR').AsString;
      DesUM := Chamado.FieldByName('DESUM').AsString;
      DesUMOriginal := Chamado.FieldByName('UMORIGINAL').AsString;
      QtdProduto := Chamado.FieldByname('QTDPRODUTO').AsFloat;
      QtdBaixado := Chamado.FieldByname('QTDBAIXADO').AsFloat;
      DesProblema := Chamado.FieldByName('DESPROBLEMA').AsString;
      DesServicoExecutado := Chamado.FieldByName('DESSERVICOEXECUTADO').AsString;
      DatGarantia := Chamado.FieldByName('DATGARANTIA').AsDateTime;
      NumContador := Chamado.FieldByName('NUMCONTADOR').AsInteger;
      if SeqContrato <> 0 then
        DesContrato := RDesContrato(VpaDChamado.CodFilial,SeqContrato);
      UnidadeParentes.free;
      UnidadeParentes := FunProdutos.RUnidadesParentes(Chamado.FieldByName('UMORIGINAL').AsString);
    end;
    CarDServicoExecutadoChamado(VpaDChamado,VpfDProdutoChamado);
    CarDProdutoOrcadoChamado(VpaDChamado,VpfDProdutoChamado);
    CarDServicoOrcadoChamado(VpaDChamado,VpfDProdutoChamado);
    Chamado.next;
  end;
  Chamado.close;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.CarDProdutoExtraChamado(VpaDChamado : TRBDChamado);
var
  VpfDProdutoExtra : TRBDChamadoProdutoExtra;
begin
  AdicionaSQLAbreTabela(Chamado,'SELECT CHP.SEQITEM, CHP.SEQPRODUTO, CHP.DESUM, '+
                                ' CHP.QTDPRODUTO, CHP.INDFATURADO, ' +
                                ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL '+
                                ' FROM CHAMADOPRODUTOEXTRA CHP, CADPRODUTOS PRO '+
                                ' Where CHP.CODFILIAL = ' +IntToStr(VpaDChamado.CodFilial)+
                                ' AND CHP.NUMCHAMADO = '+IntToStr(VpaDChamado.NumChamado)+
                                ' AND CHP.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                                ' order by SEQITEM ');
  While not Chamado.eof do
  begin
    VpfDProdutoExtra := VpaDChamado.AddProdutoExtra;
    with VpfDProdutoExtra do
    begin
      SeqItem := Chamado.FieldByName('SEQITEM').AsInteger;
      SeqProduto := Chamado.FieldByName('SEQPRODUTO').AsInteger;
      CodProduto := Chamado.FieldByName('C_COD_PRO').AsString;
      NomProduto := Chamado.FieldByName('C_NOM_PRO').AsString;
      UM := Chamado.FieldByName('DESUM').AsString;
      UMOriginal := Chamado.FieldByName('UMORIGINAL').AsString;
      QtdBaixado := Chamado.FieldByname('QTDPRODUTO').AsFloat;
      IndFaturado := Chamado.FieldByName('INDFATURADO').AsString = 'S';
    end;
    Chamado.next;
  end;
  Chamado.close;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.CarDChamadoCotacao(VpaDChamado : TRBDChamado;VpaDCotacao : TRBDOrcamento);
begin
  VpaDChamado.CodFilial := VpaDCotacao.CodEmpFil;
  VpaDChamado.CodCliente := VpaDCotacao.CodCliente;
  VpaDChamado.CodTecnico := varia.CodTecnicoIndefinido;
  VpaDChamado.CodTipoChamado := Varia.TipoChamadoInstalacao;
  VpaDChamado.CodUsuario := varia.CodigoUsuario;
  VpaDChamado.CodEstagio := varia.EstagioChamadoAguardandoAgendamendo;
  VpaDChamado.NomSolicitante := VpaDCotacao.NomContato;
  VpaDChamado.NomContato := VpaDCotacao.NomContato;
  VpaDChamado.DatChamado := now;
  VpaDChamado.DatPrevisao := date;
  VpaDChamado.IndPesquisaSatisfacao := false;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.CarDChamadoCotacaoProduto(VpaDChamado : TRBDChamado;VpaDCotacao : TRBDOrcamento);
var
  VpfDProCotacao : TRBDOrcProduto;
  VpfDProChamado : TRBDChamadoProduto;
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDProCotacao := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    VpfDProChamado := VpaDChamado.AddProdutoChamado;
    VpfDProChamado.CodFilialChamado := VpaDChamado.CodFilial;
    VpfDProChamado.SeqItem := VpfLaco + 1;
    VpfDProChamado.SeqProduto := VpfDProCotacao.SeqProduto;
    VpfDProChamado.CodProduto := VpfDProCotacao.CodProduto;
    VpfDProChamado.NomProduto := VpfDProCotacao.NomProduto;
    VpfDProChamado.NumSerie := VpfDProCotacao.DesRefCliente;
  end;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.ApagaDChamadoProduto(VpaCodFilial, VpaNumChamado: Integer);
begin
  ExecutaComandoSql(Aux,'Delete FROM CHAMADOPRODUTO '+
                        ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' and NUMCHAMADO = ' +IntToStr(VpaNumChamado));
end;

{******************************************************************************}
procedure TRBFuncoesChamado.ApagaDChamadoServicoExecutado(VpaCodFilial, VpaNumChamado: Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM CHAMADOSERVICOEXECUTADO'+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND NUMCHAMADO = ' +IntToStr(VpaNumChamado));
end;

{******************************************************************************}
procedure TRBFuncoesChamado.ApagaDChamadoServicoOrcado(VpaCodFilial, VpaNumChamado: Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM CHAMADOSERVICOORCADO'+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND NUMCHAMADO = ' +IntToStr(VpaNumChamado));
end;

{******************************************************************************}
procedure TRBFuncoesChamado.ApagaDChamadoProdutoOrcado(VpaCodFilial, VpaNumChamado: Integer);
begin
  ExecutaComandoSql(Aux,'DELETE FROM CHAMADOPRODUTOORCADO'+
                        ' WHERE CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' AND NUMCHAMADO = ' +IntToStr(VpaNumChamado));
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaDProdutoChamado(VpaDChamado : TRBDChamado) : string;
var
  VpfDProdutoChamado : TRBDChamadoProduto;
  VpfLaco : Integer;
begin
  result := '';
  ApagaDChamadoServicoExecutado(VpaDChamado.CodFilial,VpaDChamado.NumChamado);
  ApagaDChamadoProdutoOrcado(VpaDChamado.CodFilial,VpaDChamado.NumChamado);
  ApagaDChamadoServicoOrcado(VpaDChamado.CodFilial,VpaDChamado.NumChamado);
  ApagaDChamadoProduto(VpaDChamado.CodFilial,VpaDChamado.NumChamado);

  AdicionaSQLAbreTabela(Cadastro,'Select * from CHAMADOPRODUTO');
  for VpfLaco := 0 to  VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDProdutoChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLaco]);
    VpfDProdutoChamado.SeqItem := VpfLaco + 1;
    Cadastro.Insert;
    Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDChamado.CodFilial;
    Cadastro.FieldByName('NUMCHAMADO').AsInteger := VpaDChamado.NumChamado;
    Cadastro.FieldByName('SEQITEM').AsInteger := VpfDProdutoChamado.seqItem;
    Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDProdutoChamado.SeqProduto;
    if VpfDProdutoChamado.NumContador <> 0 then
      Cadastro.FieldByName('NUMCONTADOR').AsInteger := VpfDProdutoChamado.NumContador
    else
      Cadastro.FieldByName('NUMCONTADOR').clear;
    Cadastro.FieldByName('NUMSERIE').AsString  := VpfDProdutoChamado.NumSerie;
    Cadastro.FieldByName('NUMSERIEINTERNO').AsString  := VpfDProdutoChamado.NumSerieInterno;
    Cadastro.FieldByName('DESSETOR').AsString  := VpfDProdutoChamado.DesSetor;
    Cadastro.FieldByName('DESPROBLEMA').AsString  := VpfDProdutoChamado.DesProblema;
    Cadastro.FieldByName('DESUM').AsString  := VpfDProdutoChamado.DesUM;
    Cadastro.FieldByName('QTDPRODUTO').AsFloat  := VpfDProdutoChamado.QtdProduto;
    Cadastro.FieldByName('QTDBAIXADO').AsFloat  := VpfDProdutoChamado.QtdBaixado;

    if VpfDProdutoChamado.DatGarantia > MontaData(1,1,1900) then
      Cadastro.FieldByName('DATGARANTIA').AsDateTime  := VpfDProdutoChamado.DatGarantia
    else
      Cadastro.FieldByName('DATGARANTIA').Clear;
    Cadastro.FieldByName('DESSERVICOEXECUTADO').AsString  := VpfDProdutoChamado.DesServicoExecutado;

    if VpfDProdutoChamado.SeqItemProdutoCliente <> 0 then
      Cadastro.FieldByName('SEQITEMPRODUTOCLIENTE').AsInteger := VpfDProdutoChamado.SeqItemProdutoCliente
    else
      Cadastro.FieldByName('SEQITEMPRODUTOCLIENTE').clear;
    if VpfDProdutoChamado.SeqContrato <> 0 then
    begin
      Cadastro.FieldByName('CODFILIALCONTRATO').AsInteger := VpfDProdutoChamado.CodFilialChamado;
      Cadastro.FieldByName('SEQCONTRATO').AsInteger := VpfDProdutoChamado.SeqContrato;
      Cadastro.FieldByName('SEQITEMCONTRATO').AsInteger := VpfDProdutoChamado.SeqIteMContrato;
    end
    else
    begin
      Cadastro.FieldByName('CODFILIALCONTRATO').Clear;
      Cadastro.FieldByName('SEQCONTRATO').Clear;
      Cadastro.FieldByName('SEQITEMCONTRATO').Clear;
    end;
    try
      Cadastro.post;
    except
      on e : exception do
      begin
        result := 'ERRO NA GRAVA��O DO CHAMADOPRODUTO!!!'#13+e.message;
        exit;
      end;
    end;
  end;
  Cadastro.close;
  if result = '' then
  begin
    Result:= GravaDChamadoServicoExecutado(VpaDChamado);
    if Result = '' then
    begin
      Result:= GravaDChamadoProdutoOrcado(VpaDChamado);
      if Result = '' then
      begin
        Result:= GravaDChamadoServicoOrcado(VpaDChamado);
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaLogEstagio(VpaCodFilial, VpaNumChamado,VpaCodEstagio,VpaCodUsuario : Integer;VpaDesMotivo : String):String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from ESTAGIOCHAMADO');
  Cadastro.insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaCodFilial;
  Cadastro.FieldByName('NUMCHAMADO').AsInteger := VpaNumChamado;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaCodUsuario;
  Cadastro.FieldByName('CODESTAGIO').AsInteger := VpaCodEstagio;
  if VpaDesMotivo <> '' then
    Cadastro.FieldByName('DESMOTIVO').AsString := VpaDesMotivo;
  Cadastro.FieldByName('DATESTAGIO').AsDateTime := now;
  Cadastro.FieldByName('SEQESTAGIO').AsInteger := RSeqEstagioDisponivel(VpaCodFilial,VpaNumChamado);
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVA��O DO LOG DO ESTAGIO DO CHAMADO!!!'#13+e.message;
  end;
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaDChamadoParcialProduto(VpaDChamado : TRBDChamado;VpaDParcial : TRBDChamadoParcial):string;
Var
  VpfSeqItem, VpfLaco : Integer;
  VpfDProdutoChamado : TRBDChamadoProduto;
  VpfDProdutoExtra : TRBDChamadoProdutoExtra;
begin
  result := '';
  VpfSeqItem := 1;
  AdicionaSQLAbreTabela(Cadastro,'Select * from CHAMADOPARCIALPRODUTO');

  for VpfLaco := 0 to VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDProdutoChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLaco]);
    if VpfDProdutoChamado.QtdABaixar > 0 then
    begin
      Cadastro.insert;
      Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDChamado.CodFilial;
      Cadastro.FieldByName('NUMCHAMADO').AsInteger := VpaDChamado.NumChamado;
      Cadastro.FieldByName('SEQPARCIAL').AsInteger := VpaDParcial.SeqParcial;
      Cadastro.FieldByName('SEQITEM').AsInteger := VpfSeqItem;
      Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDProdutoChamado.SeqProduto;
      Cadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDProdutoChamado.QtdABaixar;
      Cadastro.FieldByName('DESUM').AsString := VpfDProdutoChamado.DesUM;
      Cadastro.FieldByName('INDPRODUTOEXTRA').AsString := 'N';
      Cadastro.FieldByName('INDFATURADO').AsString := 'N';
      try
        Cadastro.post;
      except
        on e : exception do
        begin
          result := 'ERRO NA GRAVA��O DO CHAMADOPRODUTOPARCIAL!!!'#13+e.message;
          break;
        end;
      end;
      inc(VpfSeqItem);
      if VpaDParcial.IndRetorno then
        VpfDProdutoChamado.QtdBaixado := VpfDProdutoChamado.QtdBaixado - VpfDProdutoChamado.QtdABaixar
      else
        VpfDProdutoChamado.QtdBaixado := VpfDProdutoChamado.QtdBaixado + VpfDProdutoChamado.QtdABaixar;
    end;
  end;
  if result = '' then
  begin
    for VpfLaco := 0 to VpaDChamado.ProdutosExtras.Count - 1 do
    begin
      VpfDProdutoExtra := TRBDChamadoProdutoExtra(VpaDChamado.ProdutosExtras.Items[VpfLaco]);
      if (VpfDProdutoExtra.QtdProduto <> 0) and not(VpfDProdutoExtra.IndFaturado) then
      begin
        Cadastro.insert;
        Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDChamado.CodFilial;
        Cadastro.FieldByName('NUMCHAMADO').AsInteger := VpaDChamado.NumChamado;
        Cadastro.FieldByName('SEQPARCIAL').AsInteger := VpaDParcial.SeqParcial;
        Cadastro.FieldByName('SEQITEM').AsInteger := VpfSeqItem;
        Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDProdutoExtra.SeqProduto;
        Cadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDProdutoExtra.QtdProduto;
        Cadastro.FieldByName('DESUM').AsString := VpfDProdutoExtra.UM;
        Cadastro.FieldByName('INDPRODUTOEXTRA').AsString := 'S';
        Cadastro.FieldByName('INDFATURADO').AsString := 'N';
        try
          Cadastro.post;
        except
          on e : exception do
          begin
            result := 'ERRO NA GRAVA��O DO CHAMADOPRODUTOPARCIAL!!!'#13+e.message;
            break;
          end;
        end;
        inc(VpfSeqItem);
        if VpaDParcial.IndRetorno then
          VpfDProdutoExtra.QtdBaixado := VpfDProdutoExtra.QtdBaixado - VpfDProdutoExtra.QtdProduto
        else
          VpfDProdutoExtra.QtdBaixado := VpfDProdutoExtra.QtdBaixado + VpfDProdutoExtra.QtdProduto;
      end;
    end;
  end;
  if result = '' then
  begin
    result := GravaDProdutoChamado(VpaDChamado);
    if result = '' then
      result := GravaDChamadoProdutoExtra(VpaDChamado);
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaDChamadoProdutoExtra(VpaDChamado : TRBDChamado):string;
var
  VpfLaco : Integer;
  VpfDProdutoExtra : TRBDChamadoProdutoExtra;
begin
  result := '';
  ExecutaComandoSql(Aux,'Delete from CHAMADOPRODUTOEXTRA'+
                                   ' Where CODFILIAL = '+IntToStr(VpaDChamado.CodFilial)+
                                   ' and NUMCHAMADO = '+IntToStr(VpaDChamado.NumChamado));
  for vpflaco := 0 to VpaDChamado.ProdutosExtras.Count - 1 do
  begin
    VpfDProdutoExtra := TRBDChamadoProdutoExtra(VpaDChamado.ProdutosExtras.Items[VpfLaco]);
    if VpfDProdutoExtra.QtdBaixado > 0 then
    begin
      AdicionaSQLAbreTabela(Cadastro,'Select * from CHAMADOPRODUTOEXTRA'+
                                     ' Where CODFILIAL = '+IntToStr(VpaDChamado.CodFilial)+
                                     ' and NUMCHAMADO = '+IntToStr(VpaDChamado.NumChamado)+
                                     ' and SEQPRODUTO = '+IntToStr(VpfDProdutoExtra.SeqProduto));
      Cadastro.insert;
      Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDChamado.CodFilial;
      Cadastro.FieldByName('NUMCHAMADO').AsInteger := VpaDChamado.NumChamado;
      VpfDProdutoExtra.SeqItem := VpfLaco + 1;
      Cadastro.FieldByName('SEQITEM').AsInteger := VpfDProdutoExtra.SeqItem;
      Cadastro.FieldByName('SEQPRODUTO').AsInteger := VpfDProdutoExtra.SeqProduto;
      Cadastro.FieldByName('DESUM').AsString := VpfDProdutoExtra.UM;
      Cadastro.FieldByName('QTDPRODUTO').AsFloat := VpfDProdutoExtra.QtdBaixado;
      Cadastro.FieldByName('SEQITEM').AsInteger := VpfDProdutoExtra.SeqItem;
      if VpfDProdutoExtra.IndFaturado then
        Cadastro.FieldByName('INDFATURADO').AsString := 'S'
      else
        Cadastro.FieldByName('INDFATURADO').AsString := 'N';
      try
        Cadastro.post;
      except
        on e : exception do
        begin
          result := 'ERRO NA GRAVACAO DOS PRODUTOS EXTRAS DO CHAMADO!!!'#13+e.message;
          break;
        end;
      end;
    end;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesChamado.BaixaEstoqueBaixaParcial(VpaDChamado : TRBDChamado;VpaDParcial : TRBDChamadoParcial) : string;
var
  VpfLaco, VpfOperacaoBaixa, VpfSeqEstoqueBarra : Integer;
  VpfDProdutoChamado : TRBDChamadoProduto;
  VpfDProdutoExtra : TRBDChamadoProdutoExtra;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  if Varia.OperacaoSaidaProdutoBaixaChamado = 0 then
    result := 'OPERA��O ESTOQUE SAIDA BAIXA CHAMADO N�O PREENHCIDA!!!'#13'� necess�rio configurar a opera��o de estoque de saida de produtos para a baixa nas configura��es do produto.';
  if result = '' then
  begin
    for VpfLaco := 0 to VpaDChamado.Produtos.Count - 1 do
    begin
      VpfDProdutoChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLaco]);
      if VpfDProdutoChamado.QtdABaixar <> 0 then
      begin
        if VpaDParcial.IndRetorno then
          VpfOperacaoBaixa := Varia.OperacaoEntradaProdutoBaixaChamado
        else
          VpfOperacaoBaixa := Varia.OperacaoSaidaProdutoBaixaChamado;
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,0,VpaDChamado.CodFilial,VpfDProdutoChamado.SeqProduto);
        if not FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDChamado.CodFilial,VpfOperacaoBaixa,
                                    0,VpaDChamado.NumChamado,0,varia.MoedaBase,0,0,date,VpfDProdutoChamado.QtdABaixar,
                                    0,VpfDProdutoChamado.DesUM,'',false,VpfSeqEstoqueBarra,true,0)then
        begin
          result := 'ERRO NA BAIXA DE ESTOQUE DOS PRODUTOS DO CHAMADO!!!';
          break;
        end;
        VpfDProduto.free;
      end;
    end;
  end;
  if result = '' then
  begin
    for VpfLaco := 0 to VpaDChamado.ProdutosExtras.Count - 1 do
    begin
      VpfDProdutoExtra := TRBDChamadoProdutoExtra(VpaDChamado.ProdutosExtras.Items[VpfLaco]);
      if VpfDProdutoExtra.QtdProduto <> 0 then
      begin
        if VpaDParcial.IndRetorno then
          VpfOperacaoBaixa := Varia.OperacaoEntradaProdutoBaixaChamado
        else
          VpfOperacaoBaixa := Varia.OperacaoSaidaProdutoBaixaChamado;
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,0,VpaDChamado.CodFilial,VpfDProdutoExtra.SeqProduto);
        if not FunProdutos.BaixaProdutoEstoque(VpfDProduto,VpaDChamado.CodFilial,VpfOperacaoBaixa,
                                    0,VpaDChamado.NumChamado,0,varia.MoedaBase,0,0,date,VpfDProdutoExtra.QtdProduto,
                                    0,VpfDProdutoExtra.UM,'',false,VpfSeqEstoqueBarra,true,0)then
        begin
          result := 'ERRO NA BAIXA DE ESTOQUE DOS PRODUTOS EXTRAS!!!';
          break;
        end;
        VpfDProduto.free;
      end;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesChamado.CadastraNumeroSerieProduto(VpaDChamado : TRBDChamado) : string;
begin
  result := '';
    
end;

{******************************************************************************}
function TRBFuncoesChamado.REmailTecnico(VpaCodTecnico : Integer):String;
begin
  AdicionaSqlAbreTabela(Aux,'Select * from TECNICO ' +
                            ' Where CODTECNICO = '+IntToStr(VpaCodTecnico));
  result := Aux.FieldByName('DESEMAIL').AsString;
  Aux.Close;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.MarcaProdutosExtraFaturado(VpaCodFilial,VpaNumChamado : Integer);
begin
  ExecutaComandoSql(Aux,'UPDATE CHAMADOPRODUTOEXTRA SET INDFATURADO = ''S'''+
                        ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' and NUMCHAMADO = '+IntToStr(VpaNumChamado));
  ExecutaComandoSql(Aux,'UPDATE CHAMADOPARCIALPRODUTO SET INDFATURADO = ''S'''+
                        ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                        ' and NUMCHAMADO = '+IntToStr(VpaNumChamado));
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaDChamado(VpaDChamado : TRBDChamado) : String;
begin
  AdicionaSqlAbreTabela(Cadastro,'Select * from  CHAMADOCORPO '+
                                   ' Where CODFILIAL = '+ IntToStr(VpaDChamado.Codfilial)+
                                   ' and NUMCHAMADO = '+IntToStr(VpaDChamado.NumChamado));
  if VpaDChamado.NumChamado = 0 then
    Cadastro.insert
  else
    Cadastro.edit;

  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDChamado.CodFilial;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaDChamado.CodUsuario;
  Cadastro.FieldByName('CODTECNICO').AsInteger := VpaDChamado.CodTecnico;
  Cadastro.FieldByName('DATCHAMADO').AsDateTime := VpaDChamado.DatChamado;
  Cadastro.FieldByName('DATPREVISAO').AsDateTime := VpaDChamado.DatPrevisao;
  if VpaDChamado.NumChamadoAnterior <>0 then
    Cadastro.FieldByName('NUMCHAMADOANTERIOR').AsInteger := VpaDChamado.NumChamadoAnterior
  else
    Cadastro.FieldByName('NUMCHAMADOANTERIOR').Clear;
  if VpaDChamado.CodEstagio <>0 then
    Cadastro.FieldByName('CODESTAGIO').AsInteger := VpaDChamado.CodEstagio
  else
    Cadastro.FieldByName('CODESTAGIO').Clear;
  if VpaDChamado.IndPesquisaSatisfacao then
    Cadastro.FieldByName('INDPESQUISASATISFACAO').AsString := 'S'
  else
    Cadastro.FieldByName('INDPESQUISASATISFACAO').AsString := 'N';

  Cadastro.FieldByName('CODCLIENTE').AsInteger := VpaDChamado.CodCliente;
  Cadastro.FieldByName('CODTIPOCHAMADO').AsInteger := VpaDChamado.CodTipoChamado;
  Cadastro.FieldByName('NOMSOLICITANTE').AsString := VpaDChamado.NomSolicitante;
  Cadastro.FieldByName('NOMCONTATO').AsString := VpaDChamado.NomContato;
  Cadastro.FieldByName('DESENDERECOATENDIMENTO').AsString := VpaDChamado.DesEnderecoAtendimento;
  Cadastro.FieldByName('VALCHAMADO').AsFloat := VpaDChamado.ValChamado;
  Cadastro.FieldByName('VALDESLOCAMENTO').AsFloat := VpaDChamado.ValDeslocamento;
  if VpaDChamado.NumChamado  = 0 then
    VpaDChamado.NumChamado := RNumChamadoDisponivel(VpaDChamado.CodFilial);
  Cadastro.FieldByName('NUMCHAMADO').AsInteger := VpaDChamado.NumChamado;

  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVA��O DO CHAMADO CORPO!!!'#13+ e.message;
  end;
  Cadastro.close;
  if result = '' then
  begin
    result := GravaDProdutoChamado(VpaDChamado);
    if result = '' then
    begin
      result := FunClientes.AtualizaNumeroSerieProdutoChamado(VpaDChamado);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaDChamadoParcial(VpaDChamado : TRBDChamado;VpaDParcial : TRBDChamadoParcial):String;
begin
  AdicionaSQLAbreTabela(Cadastro,'Select * from CHAMADOPARCIALCORPO ');
  Cadastro.insert;
  Cadastro.FieldByName('CODFILIAL').AsInteger := VpaDChamado.CodFilial;
  Cadastro.FieldByName('NUMCHAMADO').AsInteger := VpaDChamado.NumChamado;
  Cadastro.FieldByName('CODTECNICO').AsInteger := VpaDParcial.CodTecnico;
  Cadastro.FieldByName('CODUSUARIO').AsInteger := VpaDParcial.CodUsuario;
  Cadastro.FieldByName('DATPARCIAL').AsDateTime := VpaDParcial.DatParcial;
  if VpaDParcial.IndRetorno then
    Cadastro.FieldByName('INDRETORNO').AsString := 'S'
  else
    Cadastro.FieldByName('INDRETORNO').AsString := 'N';
  Cadastro.FieldByName('INDFATURADO').AsString := 'N';
  VpaDParcial.SeqParcial := RSeqChamadoParcialDiponivel(VpaDChamado.CodFilial,VpaDChamado.NumChamado);
  Cadastro.FieldByName('SEQPARCIAL').AsInteger := VpaDParcial.SeqParcial;
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVA�AO DO CHAMADO PARCIAL!!!'#13+e.message;
  end;
  Cadastro.close;
  if result = '' then
  begin
    Result := GravaDChamadoParcialProduto(VpaDChamado,VpaDParcial);
    if result = '' then
    begin
      BaixaEstoqueBaixaParcial(VpaDChamado,VpaDParcial);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaDChamadoServicoExecutado(VpaDChamado: TRBDChamado): String;
var
  VpfLacoExterno, VpfLacoInterno: Integer;
  VpfDChamadoServicoExecutado: TRBDChamadoServicoExecutado;
  VpfDProdutoChamado: TRBDChamadoProduto;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM CHAMADOSERVICOEXECUTADO');
  for VpfLacoExterno:= 0 to VpaDChamado.Produtos.Count-1 do
  begin
    VpfDProdutoChamado:= TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLacoExterno]);
    for VpfLacoInterno:= 0 to VpfDProdutoChamado.ServicosExecutados.Count-1 do
    begin
      VpfDChamadoServicoExecutado:= TRBDChamadoServicoExecutado(VpfDProdutoChamado.ServicosExecutados.Items[VpfLacoInterno]);

      Cadastro.Insert;

      Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDChamado.CodFilial;
      Cadastro.FieldByName('NUMCHAMADO').AsInteger:= VpaDChamado.NumChamado;

      Cadastro.FieldByName('SEQITEM').AsInteger:= VpfDProdutoChamado.SeqItem;
      VpfDChamadoServicoExecutado.SeqItemExecutado:= VpfLacoInterno+1;
      Cadastro.FieldByName('SEQITEMEXECUTADO').AsInteger:= VpfDChamadoServicoExecutado.SeqItemExecutado;

      Cadastro.FieldByName('CODSERVICO').AsInteger:= VpfDChamadoServicoExecutado.CodServico;
      Cadastro.FieldByName('CODEMPRESASERVICO').AsInteger:= VpfDChamadoServicoExecutado.CodEmpresaServico;
      Cadastro.FieldByName('QTDSERVICO').AsFloat:= VpfDChamadoServicoExecutado.Quantidade;
      Cadastro.FieldByName('VALSERVICO').AsFloat:= VpfDChamadoServicoExecutado.ValUnitario;
      Cadastro.FieldByName('VALTOTAL').AsFloat:= VpfDChamadoServicoExecutado.ValTotal;
      try
        Cadastro.Post;
      except
        on E:Exception do
        begin
          Result:= 'ERRO NA GRAVA��O DOS SERVI�OS EXECUTADOS!!!'#13+E.Message;
          Break;
        end;
      end;
    end;
    if Result <> '' then
      Break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaDChamadoProdutoOrcado(VpaDChamado: TRBDChamado): String;
var
  VpfLacoExterno, VpfLacoInterno: Integer;
  VpfDChamadoProdutoOrcado: TRBDChamadoProdutoOrcado;
  VpfDProdutoChamado: TRBDChamadoProduto;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM CHAMADOPRODUTOORCADO');
  for VpfLacoExterno:= 0 to VpaDChamado.Produtos.Count-1 do
  begin
    VpfDProdutoChamado:= TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLacoExterno]);
    for VpfLacoInterno:= 0 to VpfDProdutoChamado.ProdutosOrcados.Count-1 do
    begin
      VpfDChamadoProdutoOrcado:= TRBDChamadoProdutoOrcado(VpfDProdutoChamado.ProdutosOrcados.Items[VpfLacoInterno]);

      Cadastro.Insert;

      Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDChamado.CodFilial;
      Cadastro.FieldByName('NUMCHAMADO').AsInteger:= VpaDChamado.NumChamado;
      Cadastro.FieldByName('SEQITEM').AsInteger:= VpfDProdutoChamado.SeqItem;
      VpfDChamadoProdutoOrcado.SeqItemOrcado:= VpfLacoInterno+1;
      Cadastro.FieldByName('SEQITEMORCADO').AsInteger:= VpfDChamadoProdutoOrcado.SeqItemOrcado;
      Cadastro.FieldByName('SEQPRODUTO').AsInteger:= VpfDChamadoProdutoOrcado.SeqProduto;
      Cadastro.FieldByName('QTDPRODUTO').AsFloat:= VpfDChamadoProdutoOrcado.Quantidade;
      Cadastro.FieldByName('VALUNITARIO').AsFloat:= VpfDChamadoProdutoOrcado.ValUnitario;
      Cadastro.FieldByName('VALTOTAL').AsFloat:= VpfDChamadoProdutoOrcado.ValTotal;
      Cadastro.FieldByName('DESUM').AsString:= VpfDChamadoProdutoOrcado.DesUM;
      if VpfDChamadoProdutoOrcado.IndAprovado then
        Cadastro.FieldByName('INDAPROVADO').AsString:= 'S'
      else
        Cadastro.FieldByName('INDAPROVADO').AsString:= 'N';

      try
        Cadastro.Post;
      except
        on E:Exception do
        begin
          Result:= 'ERRO NA GRAVA��O DOS PRODUTOS OR�ADOS!!!'#13+E.Message;
          Break;
        end;
      end;
    end;
    if Result <> '' then
      Break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaDChamadoServicoOrcado(VpaDChamado: TRBDChamado): String;
var
  VpfLacoExterno, VpfLacoInterno: Integer;
  VpfDChamadoServicoOrcado: TRBDChamadoServicoOrcado;
  VpfDProdutoChamado: TRBDChamadoProduto;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM CHAMADOSERVICOORCADO');
  for VpfLacoExterno:= 0 to VpaDChamado.Produtos.Count-1 do
  begin
    VpfDProdutoChamado:= TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLacoExterno]);
    for VpfLacoInterno:= 0 to VpfDProdutoChamado.ServicosOrcados.Count-1 do
    begin
      VpfDChamadoServicoOrcado:= TRBDChamadoServicoOrcado(VpfDProdutoChamado.ServicosOrcados.Items[VpfLacoInterno]);

      Cadastro.Insert;
      Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDChamado.CodFilial;
      Cadastro.FieldByName('NUMCHAMADO').AsInteger:= VpaDChamado.NumChamado;
      Cadastro.FieldByName('SEQITEM').AsInteger:= VpfDProdutoChamado.SeqItem;
      VpfDChamadoServicoOrcado.SeqItemOrcado:= VpfLacoInterno+1;
      Cadastro.FieldByName('SEQITEMORCADO').AsInteger:= VpfDChamadoServicoOrcado.SeqItemOrcado;
      Cadastro.FieldByName('CODEMPRESASERVICO').AsInteger:= VpfDChamadoServicoOrcado.CodEmpresaServico;
      Cadastro.FieldByName('CODSERVICO').AsInteger:= VpfDChamadoServicoOrcado.CodServico;
      Cadastro.FieldByName('QTDSERVICO').AsFloat:= VpfDChamadoServicoOrcado.QtdServico;
      Cadastro.FieldByName('VALSERVICO').AsFloat:= VpfDChamadoServicoOrcado.ValUnitario;
      Cadastro.FieldByName('VALTOTAL').AsFloat:= VpfDChamadoServicoOrcado.ValTotal;
      if VpfDChamadoServicoOrcado.IndAprovado then
        Cadastro.FieldByName('INDAPROVADO').AsString:= 'S'
      else
        Cadastro.FieldByName('INDAPROVADO').AsString:= 'N';

      try
        Cadastro.Post;
      except
        on E:Exception do
        begin
          Result:= 'ERRO NA GRAVA��O DOS SERVI�OS OR�ADOS!!!'#13+E.Message;
          Break;
        end;
      end;
    end;
    if Result <> '' then
      Break;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.CarDChamado(VpaCodFilial,VpaNumChamado : Integer;VpaDChamado : TRBDChamado);
begin
  AdicionaSQLAbreTabela(Chamado,'Select CHA.NUMCHAMADOANTERIOR, CHA.CODCLIENTE, CHA.CODTIPOCHAMADO, '+
                                ' CHA.CODTECNICO, CHA.CODUSUARIO, CHA.CODESTAGIO, CHA.NOMSOLICITANTE, '+
                                ' CHA.NOMCONTATO, CHA.DESENDERECOATENDIMENTO, CHA.DATCHAMADO, '+
                                ' CHA.DATPREVISAO, CHA.VALCHAMADO, CHA.VALDESLOCAMENTO, CHA.INDPESQUISASATISFACAO, '+
                                ' TIP.NUMMODELOEMAIL '+
                                ' from CHAMADOCORPO CHA, TIPOCHAMADO TIP '+
                                ' Where CHA.CODFILIAL = '+IntToStr(VpaCodfilial)+
                                ' and CHA.NUMCHAMADO = '+ IntToStr(VpaNumChamado)+
                                ' AND CHA.CODTIPOCHAMADO = TIP.CODTIPOCHAMADO ');
  with VpaDChamado do
  begin
    Codfilial := VpaCodFilial;
    NumChamado := VpaNumChamado;
    NumChamadoAnterior := Chamado.FieldByName('NUMCHAMADOANTERIOR').AsInteger;
    CodCliente := Chamado.FieldByName('CODCLIENTE').AsInteger;
    CodTipoChamado := Chamado.FieldByName('CODTIPOCHAMADO').AsInteger;
    CodTecnico := Chamado.FieldByName('CODTECNICO').AsInteger;
    CodUsuario :=  Chamado.FieldByName('CODUSUARIO').AsInteger;
    CodEstagio :=  Chamado.FieldByName('CODESTAGIO').AsInteger;
    NomSolicitante := Chamado.FieldByName('NOMSOLICITANTE').AsString;
    NomContato := Chamado.FieldByName('NOMCONTATO').AsString;
    DesEnderecoAtendimento := Chamado.FieldByName('DESENDERECOATENDIMENTO').AsString;
    DatChamado := Chamado.FieldByName('DATCHAMADO').AsDateTime;
    DatPrevisao := Chamado.FieldByName('DATPREVISAO').AsDateTime;
    ValChamado := Chamado.FieldByName('VALCHAMADO').AsFloat;
    ValDeslocamento := Chamado.FieldByName('VALDESLOCAMENTO').AsFloat;
    IndPesquisaSatisfacao := (Chamado.FieldByName('INDPESQUISASATISFACAO').AsString = 'S');
    NumModeloEmail := Chamado.FieldByName('NUMMODELOEMAIL').AsInteger;
  end;
  Chamado.close;
  CarDProdutoChamado(VpaDChamado);
  CarDProdutoExtraChamado(VpaDChamado);
end;

{******************************************************************************}
function TRBFuncoesChamado.AlteraEstagioChamado(VpaCodFilial,VpaNumChamando, VpaCodUsuario, VpaCodEstagio : Integer;VpaDesMotivo : String):String;
begin
  result := '';
  try
    ExecutaComandoSql(Aux,'UPDATE CHAMADOCORPO ' +
                          ' Set CODESTAGIO = ' + IntToStr(VpaCodEstagio)+
                          ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                          ' and NUMCHAMADO = ' + IntToStr(VpaNumChamando));
  except
    on e : exception do result := 'ERRO NA ALTERA��O DO ESTAGIO DO CHAMADO!!!'#13+e.message;
  end;
  if result = '' then
  begin
    result := GravaLogEstagio(VpaCodFilial,VpaNumChamando,VpaCodEstagio,VpaCodUsuario,VpaDesMotivo);
  end;
end;

{******************************************************************************}
function TRBFuncoesChamado.ExcluiChamado(VpaCodFilial,VpaNumChamado : Integer):String;
begin
  result := '';
  try
    sistema.GravaLogExclusao('CHAMADOCORPO','Select * from CHAMADOCORPO '+
                          ' Where CODFILIAL = ' + IntToStr(VpaCodFilial)+
                          ' and NUMCHAMADO = ' + IntToStr(VpaNumChamado));
    executaComandosQl(Aux,'Delete from CHAMADOCORPO '+
                          ' Where CODFILIAL = ' + IntToStr(VpaCodFilial)+
                          ' and NUMCHAMADO = ' + IntToStr(VpaNumChamado));
  except
    on e : exception do result := 'ERRO NA EXCLUS�O DO CHAMADOCORPO!!!!'#13+e.message;
  end;
end;

{******************************************************************************}
function TRBFuncoesChamado.EnviaEmailChamado(VpaDChamado : TRBDChamado;VpaDCliente : TRBDCliente;VpaEmail : string):String;
var
  VpfEmailTexto, VpfEmailHTML : TIdText;
  VpfDFilial : TRBDFilial;
begin
  result := '';
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,VpaDChamado.CodFilial);

{d5 colocado em comentario porque o novo indy ja gera em texto e html
 VpfEmailTexto := TIdText.Create(Mensagem.MessageParts);
  VpfEmailTexto.ContentType := 'text/plain';
  MontaEmailChamadoTexto(VpfEmailTexto.body,VpaDChamado,VpaDCliente);}

  VpfEmailHTML := TIdText.Create(Mensagem.MessageParts, Mensagem.Body);
  VpfEmailHTML.ContentType := 'text/html';
  case VpaDChamado.NumModeloEmail of
    0 : MontaEmailChamadoCelular(VpfEmailHTML.Body,VpaDChamado,VpaDCliente);
    1 : MontaEmailChamadoModelo1(VpfEmailHTML.Body,VpaDChamado,VpaDCliente,VpfDFilial);
  end;

  VpfEmailHTML.Body.Text := RetiraAcentuacaoHTML(VpfEmailHTML.Body.Text);
  Mensagem.From.Address := varia.UsuarioSMTP;
  Mensagem.From.Name := varia.NomeFilial;
  Mensagem.From.Text := varia.UsuarioSMTP;

  Mensagem.Recipients.EMailAddresses := VpaEmail;
  Mensagem.Subject := 'Chd '+IntToStr(VpaDChamado.NumChamado)+' - '+ VpaDCliente.NomCliente;
  Mensagem.Priority := TIdMessagePriority(0);
  Mensagem.ReceiptRecipient.Text  :=Mensagem.From.Text;
  Mensagem.ContentType := 'multipart/mixed';

  SMTP.UserName := varia.UsuarioSMTP;
  SMTP.Password := Varia.SenhaEmail;
  SMTP.Host := Varia.ServidorSMTP;
  SMTP.Port := 25;
  SMTP.AuthType := satDefault;

  if Mensagem.ReceiptRecipient.Address = '' then
    result := 'E-MAIL DO T�CNICO N�O PREENCHIDO!!!'#13'� necess�rio preencher o e-mail do t�cnico no cadastro dos tecnicos.';
  if SMTP.UserName = '' then
    result := 'USUARIO DO E-MAIL ORIGEM N�O CONFIGURADO!!!'#13'� necess�rio preencher nas configura��es o e-mail de origem.';
  if SMTP.Password = '' then
    result := 'SENHA SMTP DO E-MAIL ORIGEM N�O CONFIGURADO!!!'#13'� necess�rio preencher nas configura��es a senha do e-mail de origem';
  if SMTP.Host = '' then
    result := 'SERVIDOR DE SMTP N�O CONFIGURADO!!!'#13'� necess�rio configurar qual o servidor de SMTP...';
  if result = '' then
  begin
    SMTP.Connect;
    try
      SMTP.Send(Mensagem);
      GravaDEmail(VpaDChamado,Mensagem.Recipients.EMailAddresses);
    except
      on e : exception do
      begin
        result := 'ERRO AO ENVIAR O E-MAIL!!!'#13+e.message;
        SMTP.Disconnect;
      end;
    end;
    SMTP.Disconnect;
  end;
end;

{******************************************************************************}
function TRBFuncoesChamado.GravaDEmail(VpaDChamado: TRBDChamado;VpaDesEmail : String): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM CHAMADOEMAIL');
  Cadastro.Insert;

  Cadastro.FieldByName('CODFILIAL').AsInteger:= VpaDChamado.CodFilial;
  Cadastro.FieldByName('NUMCHAMADO').AsInteger:= VpaDChamado.NumChamado;
  Cadastro.FieldByName('SEQEMAIL').AsInteger:= RSeqEmailDisponivel(VpaDChamado.CodFilial,VpaDChamado.NumChamado);
  Cadastro.FieldByName('DATEMAIL').AsDateTime:= Now;
  Cadastro.FieldByName('DESEMAIL').AsString:= VpaDesEmail;
  Cadastro.FieldByName('CODUSUARIO').AsInteger:= Varia.CodigoUsuario;

  try
    Cadastro.post;
  except
    on E:Exception do
      Result:= 'ERRO NA GRAVA��O DO EMAIL DO CHAMADO!!!'#13+E.Message;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesChamado.RSeqEmailDisponivel(VpaCodFilial, VpaNumchamado : Integer): Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQEMAIL) PROXIMO FROM CHAMADOEMAIL'+
                           ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                           ' and NUMCHAMADO = ' +IntToStr(VpaNumchamado));
  Result:= Aux.FieldByName('PROXIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesChamado.RSeqChamadoParcialDiponivel(VpaCodFilial,VpaNumChamado : Integer):integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQPARCIAL) PROXIMO FROM CHAMADOPARCIALCORPO'+
                           ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                           ' and NUMCHAMADO = ' +IntToStr(VpaNumchamado));
  Result:= Aux.FieldByName('PROXIMO').AsInteger + 1;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesChamado.RNomeTecnico(VpaCodTecnico : Integer):String;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMTECNICO from TECNICO '+
                            ' Where CODTECNICO = '+IntToStr(VpaCodTecnico));
  Result := Aux.FieldByName('NOMTECNICO').AsString;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesChamado.RNomeTipoContrato(VpaCodTipo : Integer):String;
begin
  AdicionaSQLAbreTabela(Aux,'Select NOMTIPOCONTRATO from TIPOCONTRATO '+
                            ' Where CODTIPOCONTRATO = '+IntToStr(VpaCodTipo));
  result := Aux.FieldByName('NOMTIPOCONTRATO').AsString;
  Aux.close;
end;

{******************************************************************************}
function TRBFuncoesChamado.GeraFichaImplantacaoChamado(VpaDCotacao : TRBDOrcamento):String;
var
  VpfDChamado : TRBDChamado;
begin
  result := '';
  VpfDChamado := TRBDChamado.cria;
  CarDChamadoCotacao(VpfDChamado,VpaDCotacao);
  CarDChamadoCotacaoProduto(VpfDChamado,VpaDCotacao);
  result := GravaDChamado(VpfDChamado);
end;

{******************************************************************************}
function TRBFuncoesChamado.AlteraEstagioChamados(VpaCodFilial, VpaCodUsuario, VpaCodEstagio : Integer;VpaChamados,VpaDesMotivo : String):String;
var
  VpfChamado : Integer;
begin
  result := '';
  try
    ExecutaComandoSql(Aux,'UPDATE CHAMADOCORPO ' +
                          ' Set CODESTAGIO = ' + IntToStr(VpaCodEstagio)+
                          ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                          ' and NUMCHAMADO in (' + VpaChamados+')');
  except
    on e : exception do result := 'ERRO NA ALTERA��O DOS ESTAGIOS DO CHAMADO!!!'#13+e.message;
  end;
  While length(VpaChamados) > 0 do
  begin
    VpfChamado := strtoInt(CopiaAteChar(VpaChamados,','));
    VpaChamados := DeleteAteChar(VpaChamados,',');
    GravaLogEstagio(VpaCodFilial,VpfChamado,VpaCodEstagio,VpaCodUsuario,VpaDesMotivo);
  end;
end;

{******************************************************************************}
function TRBFuncoesChamado.AlteraAgendaTecnico(VpaCodFilial,VpaNumChamado, VpaCodTecnico : Integer;VpaDatPrevista : TDateTime):String;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CHAMADOCORPO '+
                                 ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                 ' and NUMCHAMADO = ' +IntToStr(VpaNumChamado));
  Cadastro.edit;
  Cadastro.FieldByName('CODTECNICO').AsInteger := VpaCodTecnico;
  Cadastro.FieldByName('DATPREVISAO').AsDateTime := VpaDatPrevista;
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVA��O DA AGENDA DO CHAMADO!!!'#13+e.message;
  end;
  Cadastro.close;
end;

{******************************************************************************}
function TRBFuncoesChamado.AlteraTecnico(VpaCodFilial,VpaNumChamado,VpaCodTecnico : Integer) : string;
begin
  result := '';
  AdicionaSQLAbreTabela(Cadastro,'Select * from CHAMADOCORPO '+
                                 ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                 ' and NUMCHAMADO = ' +IntToStr(VpaNumChamado));
  Cadastro.edit;
  Cadastro.FieldByName('CODTECNICO').AsInteger := VpaCodTecnico;
  try
    Cadastro.post;
  except
    on e : exception do result := 'ERRO NA GRAVA��O DA ALTERA��O DO TECNICO!!!'#13+e.message;
  end;
  Cadastro.close;
end;

{******************************************************************************}
procedure TRBFuncoesChamado.SetaPesquisaSatisfacaoRealizada(VpaCodFilial,VpaNumChamado : Integer);
begin
  ExecutaComandoSql(Aux,'Update CHAMADOCORPO ' +
                        'SET INDPESQUISASATISFACAO = ''S'''+
                        ' Where CODFILIAL = ' + IntToStr(VpaCodFilial)+
                        ' and NUMCHAMADO = ' + IntToStr(VpaNumChamado));
end;

end.

