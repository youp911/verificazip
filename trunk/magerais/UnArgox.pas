unit UnArgox;
{Verificado
-.edit;
}

interface

Uses SysUtils,Dialogs, UnDadosProduto, Classes, windows;


  (*Funções da DLL de comunicação com a impressora de Codigo de Barras*)
   function  A_Set_Darkness ( darkness:integer):integer;stdcall;external 'WINPPLA.DLL';
   function  A_CreatePrn    ( selection:integer;FileName:PAnsiChar):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Print_Out    ( width,height,copies,amount:integer):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Prn_Text     ( x,y,ori,font,typee,hor_factor,ver_factor:integer;mode:PAnsichar;numeric:integer;data:Pansichar):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Prn_Barcode  ( x,y,ori:integer;typee:PAnsichar;narrow,width,height:integer;mode:PAnsichar;numeric:integer;data:PAnsiChar):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Prn_Text_TrueType ( x,y,FSize:integer;FType:AnsiChar;Fspin,FWeight,FItalic,FUnline,FStrikeOut:integer;id_name,data:AnsiChar;mem_mode:integer):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Get_Graphic  ( x,y,mem_mode:integer;format:PAnsiChar;filename:PAnsiChar):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Draw_Box     ( mode, x, y, width, height, top, side:integer):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Draw_Line    (mode, x, y, width, height:integer):integer;stdcall;external 'WINPPLA.DLL';
   Procedure A_ClosePrn     ();stdcall;external 'WINPPLA.DLL';
   procedure A_Feed_Label   ();stdcall;external 'WINPPLA.DLL';
   function  A_Set_Backfeed (back :integer):integer;stdcall;external 'WINPPLA.DLL';
Type
  TRBFuncoesArgox = class
    private
      function ImprimeEtiquetaCartucho5X2e5SemLogo(VpaDPesoCartucho : TRBDPesoCartucho):Integer;
      function ImprimeEtiquetaCartucho5X2e5ComLogo(VpaDPesoCartucho : TRBDPesoCartucho):integer;
      function ImprimeEtiquetaCartucho2E5X3e5SemLogo(VpaDPesoCartucho : TRBDPesoCartucho):integer;
    public
      constructor cria(VpaPorta : String);
      destructor destroy;override;
      function ImprimeEtiqueta(VpaDPesoCartucho : TRBDPesoCartucho):integer;
      function ImprimeEtiquetaProduto8X15(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaProduto50X25(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaKairosTexto(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaProduto54X28(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaProduto35X89(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaProduto34X23(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaSeparacao(VpaBaixas : TList):integer;
      function ImprimeEtiquetaConsumoTecido(VpaBaixas : TList): Integer;
      function ImprimeNumerosModulo10(VpaLista : TStringList): string;
      procedure VoltarEtiqueta;
end;



implementation

Uses FunString, Constantes, UnOrdemProducao, unProdutos;


{******************************************************************************}
constructor TRBFuncoesArgox.cria(VpaPorta : String);
var
  VpfPorta : Integer;
  VpfLaco : INteger;
  Peso: array[0..35]of Ansichar;
begin
  inherited create;
  VpfPorta := 1;
  if uppercase(VpaPorta) = 'LPT1' then
    VpfPorta := 1
  else
    if uppercase(VpaPorta) = 'LPT2' then
      VpfPorta := 2
    else
      if uppercase(VpaPorta) = 'LPT3' then
        VpfPorta := 3
      else
        if uppercase(VpaPorta) = 'COM1' then
          VpfPorta := 4
        else
          if uppercase(VpaPorta) = 'COM2' then
            VpfPorta := 5
          else
            if uppercase(VpaPorta) = 'COM3' then
              VpfPorta := 6
            else
              VpfPorta := 10;

  CharToOem(PChar(VpaPorta), Peso);

  A_CreatePrn(VpfPorta,Peso);
//A_CreatePrn(VpfPorta,PAnsiChar(VpaPorta));
//  A_CreatePrn(VpfPorta,StrToPAnsiChar(Vpaporta));
end;

{******************************************************************************}
destructor TRBFuncoesArgox.destroy;
begin
  A_ClosePrn;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaCartucho5X2e5SemLogo(VpaDPesoCartucho : TRBDPesoCartucho):integer;
var
  VpfTexto : AnsiString;
  VpfSeqCartucho : Integer;
begin
  VpfSeqCartucho := VpaDPesoCartucho.SeqCartucho;
  A_Prn_Barcode(15,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  VpfTexto := VpaDPesoCartucho.CodProduto;
  A_Prn_Text(10,70,1,9,5,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(10,50,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(AdicionaCharDE(' ',VpaDPesoCartucho.NomCorCartucho,25)));
  VpfTexto := FormatFloat('#,##0gr',VpaDPesoCartucho.PesCartucho);
  A_Prn_Text(120,26,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  VpfTExto := FormatDateTime('DD/MM/YY',now);
  A_Prn_Text(180,47,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  A_Prn_Text(190,55,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));
  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(105,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(105,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(105,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));

  A_Prn_Barcode(213,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(210,70,1,9,5,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.CodProduto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(210,50,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(AdicionaCharDE(' ',VpaDPesoCartucho.NomCorCartucho,25)));
  A_Prn_Text(375,47,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(320,26,1,9,4,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0gr',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(385,55,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));
  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(300,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(300,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(300,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));

  result := A_Print_Out(1,1,1,1);
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaCartucho5X2e5ComLogo(VpaDPesoCartucho : TRBDPesoCartucho): Integer;
var
  VpfProduto : String;
  VpfSeqCartucho : Integer;
begin
  VpfSeqCartucho := VpaDPesoCartucho.SeqCartucho;
  if VpaDPesoCartucho.CodReduzidoCartucho <> '' then
    VpfProduto := VpaDPesoCartucho.CodProduto +'-'+VpaDPesoCartucho.CodReduzidoCartucho
  else
    VpfProduto := VpaDPesoCartucho.CodProduto +'-'+VpaDPesoCartucho.NomProduto;
  VpfProduto := copy(VpfProduto,1,24);
  A_Get_Graphic(15,65,1,PAnsiChar('B'),StrToPAnsiChar(varia.PathVersoes+'\'+intToStr(varia.CodigoEmpFil)+'a.bmp'));
  A_Prn_Text(80,75,1,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(Varia.FoneFilial));
  A_Prn_Barcode(15,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(15,50,1,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfProduto));
  A_Prn_Text(120,26,1,9,4,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0gr',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(180,47,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(190,55,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));
  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(105,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(105,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(105,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));

  A_Get_Graphic(210,65,1,PAnsiChar('B'),StrToPAnsiChar(varia.PathVersoes+'\'+intToStr(varia.CodigoEmpFil)+'a.bmp'));
  A_Prn_Text(275,75,1,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(varia.FoneFilial ));
  A_Prn_Barcode(210,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(210,50,1,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfProduto));
  A_Prn_Text(375,47,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(385,55,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));
  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(300,20,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(300,10,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(300,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));

  result := A_Print_Out(1,1,1,1);
end;


{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaCartucho2E5X3e5SemLogo(VpaDPesoCartucho : TRBDPesoCartucho):integer;
var
  VpfSeqCartucho : Integer;
begin
  VpfSeqCartucho := VpaDPesoCartucho.SeqCartucho;
  A_Prn_Barcode(5,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(5,70,1,9,5,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.CodProduto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(5,45,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.NomCorCartucho));
  if VpaDPesoCartucho.QtdMLCartucho <> 0 then
    A_Prn_Text(90,45,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0ml',VpaDPesoCartucho.QtdMLCartucho)));
  A_Prn_Text(93,26,1,9,4,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0g',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(97,15,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(100,5,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));

  A_Prn_Barcode(148,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(148,70,1,9,5,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.CodProduto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(148,50,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.NomCorCartucho));
  if VpaDPesoCartucho.QtdMLCartucho <> 0 then
    A_Prn_Text(230,50,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0ml',VpaDPesoCartucho.QtdMLCartucho)));
  A_Prn_Text(238,15,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(242,5,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));

  {  A_Prn_Barcode(210,1,1,'D',2,5,30,'N',1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpaDPesoCartucho.SeqCartucho),10)));
  A_Prn_Text(210,70,1,9,5,1,1,'N',0,StrToPAnsiChar(VpaDPesoCartucho.CodProduto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(210,50,1,9,3,1,1,'N',0,StrToPAnsiChar(AdicionaCharDE(' ',VpaDPesoCartucho.NomCorCartucho,25)));
  A_Prn_Text(375,47,4,9,1,1,1,'N',0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(320,26,1,9,4,1,1,'N',0,StrToPAnsiChar(FormatFloat('#,##0gr',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(385,55,4,9,1,1,1,'N',0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));}

  result := A_Print_Out(1,1,1,1);
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiqueta(VpaDPesoCartucho : TRBDPesoCartucho):integer;
begin
  if VpaDPesoCartucho.DesTipoCartucho = 'TI' then //cartucho de tinta
  begin                                           // se estiver em branco é para dar preferencia para o toner.
    case varia.ModeloEtiquetaCartuchoTinta of
      0 : Result := ImprimeEtiquetaCartucho2E5X3e5SemLogo(VpaDPesoCartucho);
    end;
  end
  else
  begin//cartucho de toner.
    case Varia.ModeloEtiquetaCartuchoToner of
      0 : result := ImprimeEtiquetaCartucho5X2e5ComLogo(VpaDPesoCartucho);
      1 : result := ImprimeEtiquetaCartucho5X2e5SemLogo(VpaDPesoCartucho);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto8X15(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX: Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiquetaPrincipal, VpfDEtiquetaCopia: TRBDEtiquetaProduto;
  VpfCodProduto,VpfSeqProduto,VpfNomProduto, VpfNumPedido : String;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiquetaPrincipal := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);

    if VpfLacoEtiquetas > 0 then
    begin
      inc(VpfColuna);
      VpfPosicaoX := VpfColuna * 59;
      A_Prn_Text(VpfPosicaoX+25,15,4,9,3,1,1,PAnsiChar('N'),0,PAnsiChar('OUTRO'));
      A_Prn_Text(VpfPosicaoX+45,15,4,9,3,1,1,PAnsiChar('N'),0,PAnsiChar('PRODUTO'));
    end;

    while (VpfDEtiquetaPrincipal.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiquetaPrincipal.QtdEtiquetas do
      begin
        VpfDEtiquetaCopia := TRBDEtiquetaProduto.cria;
        VpfDEtiquetaCopia.Produto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDEtiquetaCopia.Produto,VpfDEtiquetaPrincipal.Produto.CodEmpresa,VpfDEtiquetaPrincipal.Produto.CodEmpFil,VpfDEtiquetaPrincipal.Produto.SeqProduto);
        VpfDEtiquetaCopia.NumPedido := VpfDEtiquetaPrincipal.NumPedido;
        VpfDEtiquetaCopia.IndParaEstoque := VpfDEtiquetaPrincipal.IndParaEstoque;
        inc(VpfColuna);
        if VpfColuna > 6 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 59;
        VpfCodProduto := VpfDEtiquetaCopia.Produto.CodProduto;
        VpfNomProduto := Copy(VpfDEtiquetaCopia.Produto.NomProduto,1,19);
        VpfNumPedido := IntToStr(VpfDEtiquetaCopia.NumPedido);
        if VpfDEtiquetaCopia.IndParaEstoque then
        begin
          VpfSeqProduto := AdicionaCharE('0',InttoStr(VpfDEtiquetaCopia.Produto.SeqProduto),6);
          A_Prn_Text(VpfPosicaoX+10,1,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfCodProduto));
          A_Prn_Text(VpfPosicaoX+15,95,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
          A_Prn_Barcode(VpfPosicaoX+51,14,4,PAnsiChar('D'),3,6,30,PAnsiChar('N'),1,StrToPAnsiChar(VpfSeqProduto));
          A_Prn_Text(VpfPosicaoX+60,15,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfNomProduto));
        end
        else
        begin
          VpfSeqProduto := AdicionaCharE('0',InttoStr(VpfDEtiquetaCopia.Produto.SeqProduto),5);
          A_Prn_Barcode(VpfPosicaoX+50,4,4,PAnsiChar('D'),3,6,30,PAnsiChar('N'),1,StrToPAnsiChar(VpfSeqProduto));
          A_Prn_Text(VpfPosicaoX+15,95,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfNumPedido));
          A_Prn_Text(VpfPosicaoX+63,15,4,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfCodProduto));
        end;
      end;
      if VpfColuna >= 6 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiquetaPrincipal.QtdEtiquetas := VpfDEtiquetaPrincipal.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto50X25(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfNomProduto : String;
begin
{  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 1 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 195;
        if VpfDEtiqueta.Produto.CodReduzidoCartucho <> '' then
          VpfNomProduto := VpfDEtiqueta.Produto.CodReduzidoCartucho
        else
          VpfNomProduto := VpfDEtiqueta.Produto.CodProduto+'-'+VpfDEtiqueta.Produto.NomProduto;

        A_Get_Graphic(VpfPosicaoX +15,65,1,'B',StrToPAnsiChar(varia.PathVersoes+'\'+intToStr(varia.CodigoEmpFil)+'a.bmp'));
        A_Prn_Text(VpfPosicaoX + 80,75,1,9,2,1,1,'N',0,StrToPAnsiChar(varia.FoneFilial ));
        A_Prn_Barcode(VpfPosicaoX + 15,1,1,'D',2,5,30,'N',1,StrToPAnsiChar(AdicionaCharE('0',IntToStr(VpfDEtiqueta.Produto.SeqProduto),15)));
        A_Prn_Text(VpfPosicaoX + 15,50,1,9,2,1,1,'N',0,StrToPAnsiChar(copy(VpfNomProduto,1,29)));
        if Length(VpfNomProduto) > 29 then
          A_Prn_Text(VpfPosicaoX + 15,40,1,9,2,1,1,'N',0,StrToPAnsiChar(copy(VpfNomProduto,30,length(vpfNomProduto)-29)));
//        A_Prn_Text(VpfPosicaoX + 180,17,4,9,1,1,1,'N',0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
//        A_Prn_Text(VpfPosicaoX + 190,25,4,9,1,1,1,'N',0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));
      end;
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;}
end;


{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaKairosTexto(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 2 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 138;
        A_Prn_Text(VpfPosicaoX+13,47,1,9,1,2,1,PAnsiChar('N'),0,PAnsiChar('Pro : '));
        VpfTExto := VpfDEtiqueta.Produto.CodProduto;
        A_Prn_Text(VpfPosicaoX+50,47,1,9,1,2,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
        VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),1,26);
        A_Prn_Text(VpfPosicaoX+13,38,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        if Length(VpfDEtiqueta.Produto.NomProduto) > 26 then
        begin
          VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),27,25);
          A_Prn_Text(VpfPosicaoX+13,29,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        end;
        A_Prn_Text(VpfPosicaoX+13,13,1,9,1,2,1,PAnsiChar('N'),0,PAnsiChar('Cor : '));
        VpfTexto := IntToStr(VpfDEtiqueta.CodCor);
        A_Prn_Text(VpfPosicaoX+60,13,1,9,1,3,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        VpfTexto := Copy(RetiraAcentuacao(VpfDEtiqueta.NomCor),1,20);
        A_Prn_Text(VpfPosicaoX+13,3,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
        VpfTexto := FormatDateTime('DD/MM/YY',now);
        A_Prn_Text(VpfPosicaoX+133,3,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      end;
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto54X28(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfNomProduto : String;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 0 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 195;
        if VpfDEtiqueta.Produto.CodReduzidoCartucho <> '' then
          VpfNomProduto := VpfDEtiqueta.Produto.CodReduzidoCartucho
        else
          VpfNomProduto := VpfDEtiqueta.Produto.NomProduto;

{        A_Prn_Barcode(VpfPosicaoX + 15,1,1,'D',2,5,30,'N',1,StrToPAnsiChar(AdicionaCharE('0',IntToStr(VpfDEtiqueta.Produto.SeqProduto),15)));
        A_Prn_Text(VpfPosicaoX + 15,100,1,9,2,1,1,'N',0,StrToPAnsiChar(copy(VpfNomProduto,1,29)));
        if Length(VpfNomProduto) > 29 then
          A_Prn_Text(VpfPosicaoX + 15,90,1,9,2,1,1,'N',0,StrToPAnsiChar(copy(VpfNomProduto,30,length(vpfNomProduto)-29)));
        A_Prn_Text(VpfPosicaoX + 210,10,4,9,2,1,1,'N',0,StrToPAnsiChar(CopiaAteChar(varia.NomeFilial,' ')));
        A_Prn_Text(VpfPosicaoX + 15,45,1,9,2,2,2,'N',0,StrToPAnsiChar(VpfDEtiqueta.Produto.CodProduto));}
      end;
      if VpfColuna >= 1 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto34X23(VpaEtiquetas: TList): Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 2 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 138;
        VpfTExto := copy(VpfDEtiqueta.Produto.CodBarraFornecedor,1,12);
        A_Prn_Barcode(VpfPosicaoX+13,57,1,PAnsiChar('F'),2,10,25,PAnsiChar('N'),1,PAnsiChar(VpfTexto));
        A_Prn_Text(VpfPosicaoX+13,42,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Codigo Interno: '));
        VpfTExto := VpfDEtiqueta.Produto.CodProduto;
        A_Prn_Text(VpfPosicaoX+80,42,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
        VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),1,24);
        A_Prn_Text(VpfPosicaoX+13,32,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        if Length(VpfDEtiqueta.Produto.NomProduto) > 24 then
        begin
          VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),25,25);
          A_Prn_Text(VpfPosicaoX+13,22,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        end;
        A_Prn_Text(VpfPosicaoX+13,10,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Capac: '));
        VpfTexto := FormatFloat('#,###0 ml',VpfDEtiqueta.Produto.CapLiquida) ;
        A_Prn_Text(VpfPosicaoX+45,10,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        A_Prn_Text(VpfPosicaoX+80,10,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Alt: '));
        VpfTexto := FormatFloat('#,###0 cm',VpfDEtiqueta.Produto.AltProduto) ;;
        A_Prn_Text(VpfPosicaoX+95,10,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      end;
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto35X89(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      VpfColuna := 0;
      VpfPosicaoX := 10;
      VpfTExto := copy(VpfDEtiqueta.Produto.CodBarraFornecedor,1,12);
      A_Prn_Barcode(VpfPosicaoX+73,87,1,PAnsiChar('F'),4,10,25,PAnsiChar('N'),1,PAnsiChar(VpfTexto));
      A_Prn_Text(VpfPosicaoX+43,72,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Decricao : '));
      VpfTExto := copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),1,37);
      A_Prn_Text(VpfPosicaoX+99,72,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      if Length(VpfDEtiqueta.Produto.NomProduto) > 37 then
      begin
        VpfTExto := copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),38,20);
        A_Prn_Text(VpfPosicaoX+99,60,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      end;
      A_Prn_Text(VpfPosicaoX+15,47,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Codigo Interno : '));
      VpfTExto := RetiraAcentuacao(VpfDEtiqueta.Produto.CodProduto);
      A_Prn_Text(VpfPosicaoX+99,47,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      A_Prn_Text(VpfPosicaoX+25,37,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Cap. Liquida : '));
      VpfTExto := RetiraAcentuacao(FormatFloat('#,###,##0 ml',VpfDEtiqueta.Produto.CapLiquida));
      A_Prn_Text(VpfPosicaoX+99,37,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      A_Prn_Text(VpfPosicaoX+58,27,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Altura : '));
      VpfTExto := RetiraAcentuacao(FormatFloat('#,###,##0 cm',VpfDEtiqueta.Produto.AltProduto));
      A_Prn_Text(VpfPosicaoX+99,27,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      VpfTexto := FormatDateTime('DD/MM/YY',now);
      A_Prn_Text(VpfPosicaoX+350,3,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      result := A_Print_Out(1,1,1,1);
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - 1;
    end;
  end;
END;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaSeparacao(VpaBaixas : TList):integer;
var
  VpfPosicaoX : Integer;
  VpfLaco, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDProdutoBaixa : TRBDConsumoFracaoOP;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfTexto, VpfTexto2 : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLaco := 0 to VpaBaixas.Count - 1 do
  begin
    VpfDProdutoBaixa := TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if VpfDProdutoBaixa.QtdABaixar <> 0 then
    begin
      VpfDFracao := FunOrdemProducao.CarDFracaoOP(nil,VpfDProdutoBaixa.CodFilial,VpfDProdutoBaixa.SeqOrdem,VpfDProdutoBaixa.SeqFracao);
      inc(VpfColuna);
      VpfPosicaoX := VpfColuna * 140;
      VpfTexto := FloatToSTr(VpfDFracao.codBarras);
      A_Prn_Barcode(VpfPosicaoX+13,43,1,PAnsiChar('D'),2,5,15,PAnsiChar('N'),1,PAnsiChar(VpfTexto));
      VpfTexto := VpfDProdutoBaixa.CodProduto+'-'+ Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomProduto),1,21);
      A_Prn_Text(VpfPosicaoX+5,35,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      if Length(VpfDProdutoBaixa.NomProduto) > 21 then
      begin
        VpfTexto := Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomProduto),22,30);
        A_Prn_Text(VpfPosicaoX+5,25,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      end;
      VpfTexto :='Cor : '+IntToStr(VpfDProdutoBaixa.CodCor)+ Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomCor),1,15);
      A_Prn_Text(VpfPosicaoX+5,13,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      VpfTexto2 := 'Qtd Unitaria : '+FloatToStr(VpfDProdutoBaixa.QtdUnitario)+' '+VpfDProdutoBaixa.DesUMUnitario;
      A_Prn_Text(VpfPosicaoX+5,0,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto2));
      VpfTexto := 'Qtd Fra : '+ FloatToStr(VpfDFracao.QtdProduto);
      A_Prn_Text(VpfPosicaoX+127,0,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDFracao.free;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaConsumoTecido(VpaBaixas : TList): Integer;
var
  VpfPosicaoX : Integer;
  VpfLaco, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDProdutoBaixa : TRBDConsumoFracaoOP;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfTexto, VpfTexto2 : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLaco := 0 to VpaBaixas.Count - 1 do
  begin
    VpfDProdutoBaixa := TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if VpfDProdutoBaixa.QtdABaixar <> 0 then
    begin
      VpfDFracao := FunOrdemProducao.CarDFracaoOP(nil,VpfDProdutoBaixa.CodFilial,VpfDProdutoBaixa.SeqOrdem,VpfDProdutoBaixa.SeqFracao);
      inc(VpfColuna);
      VpfPosicaoX := VpfColuna * 140;
      VpfTexto := FloatToSTr(VpfDFracao.codBarras);
      VpfTexto := 'Fil : '+ IntToStr(VpfDFracao.CodFilial)+ '    OP : '+IntToStr(VpfDFracao.SeqOrdemProducao);
      A_Prn_Text(VpfPosicaoX+13,46,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      VpfTexto := VpfDProdutoBaixa.CodProduto+'-'+ Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomProduto),1,21);
      A_Prn_Text(VpfPosicaoX+5,35,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      if Length(VpfDProdutoBaixa.NomProduto) > 21 then
      begin
        VpfTexto := Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomProduto),22,30);
        A_Prn_Text(VpfPosicaoX+5,25,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      end;
      VpfTexto :='Cor : '+IntToStr(VpfDProdutoBaixa.CodCor)+ Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomCor),1,19);
      A_Prn_Text(VpfPosicaoX+5,13,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      VpfTexto2 := 'Qtd Total : '+FloatToStr(VpfDProdutoBaixa.QtdABaixar)+' '+VpfDProdutoBaixa.DesUM;
      A_Prn_Text(VpfPosicaoX+5,0,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto2));
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDFracao.free;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeNumerosModulo10(VpaLista : TStringList): string;
var
  VpfLaco, VpfIndice, VpfColuna : Integer;
  VpfNumero :  string;
begin
  VpfIndice := 0;
  for VpfLaco := 0 to VpaLista.Count - 1 do
  begin
    VpfNumero := VpaLista.Strings[VpfLaco];
    VpfColuna := 195 *(VpfLaco mod 2);
{    A_Get_Graphic(VpfColuna+15,65,1,'B',StrToPAnsiChar(varia.PathVersoes+'\'+intToStr(varia.CodigoEmpFil)+'a.bmp'));
    A_Prn_Text(VpfColuna+90,78,1,9,3,1,1,'N',0,StrToPAnsiChar('Suporte tecnico'));
    A_Prn_Text(VpfColuna+95,63,1,9,3,1,1,'N',0,StrToPAnsiChar('e suprimentos' ));
    A_Prn_Text(VpfColuna+79,42,1,9,4,1,1,'N',0,StrToPAnsiChar(DeletaChars(varia.FoneFilial,'*') ));
    A_Prn_Text(VpfColuna+70,31,1,9,2,1,1,'N',0,StrToPAnsiChar('sac@copylinebnu.com.br'));
    A_Prn_Text(VpfColuna+100,5,1,9,5,1,1,'N',0,StrToPAnsiChar('N.'));
    A_Prn_Text(VpfColuna+115,15,1,9,1,1,1,'N',0,StrToPAnsiChar('o'));
    A_Prn_Text(VpfColuna+130,5,1,9,5,1,1,'N',0,StrToPAnsiChar(AdicionaCharE('0',VpfNumero,5)));
    A_Prn_Text(VpfColuna+10,37,1,9,2,1,1,'N',0,StrToPAnsiChar('assistencia'));
    A_Prn_Text(VpfColuna+10,26,1,9,2,1,1,'N',0,StrToPAnsiChar('toner'));
    A_Prn_Text(VpfColuna+10,14,1,9,2,1,1,'N',0,StrToPAnsiChar('impressoras'));
    A_Prn_Text(VpfColuna+10,3,1,9,2,1,1,'N',0,StrToPAnsiChar('multifuncionais'));
    if (VpfLaco mod 2) = 1 then
      if A_Print_Out(1,1,1,1) <> 0 then
        result := 'ERRO AO IMPRIMIR!!!'#13'Não foi possível imprimir';}
  end;
  if VpaLista.Count > 0 then
  begin
    if (VpfLaco mod 2) = 0 then
      if A_Print_Out(1,1,1,1) <> 0 then
        result := 'ERRO AO IMPRIMIR!!!'#13'Não foi possível imprimir';
  end;
end;

{******************************************************************************}
procedure TRBFuncoesArgox.VoltarEtiqueta;
begin
  A_Set_Backfeed(350);
  A_Print_Out(1,1,1,1);
end;

end.
