unit AImprimeTabela;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, QuickRpt, Geradores, Qrctrls, Db, DBTables;

type
  TFImprimeTabela = class(TForm)
    QuickRepNovo1: TQuickRepNovo;
    Tabela: TQuery;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRDBText5: TQRDBText;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRShape5: TQRShape;
    QRLabel9: TQRLabel;
    QCodProduto: TQRDBText;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ConfiguraRel(Altura, FonteCorpo : Integer; ImprimirLinha :Boolean;
                           NomeFonte, titulo : string; campos : array of integer );
  public
    procedure AbreRelatorio(SQL : TStrings; classificacao : String; Altura, FonteCorpo : Integer; ImprimirLinha :Boolean; NomeFonte : string;
                            campos : array of integer; titulo : string);
  end;

var
  FImprimeTabela: TFImprimeTabela;

implementation

uses APrincipal, funsql, funobjeto, funstring;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeTabela.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeTabela.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;

procedure TFImprimeTabela.ConfiguraRel(Altura, FonteCorpo : Integer; ImprimirLinha :Boolean;
                                       NomeFonte, Titulo : string; campos : array of integer );

  procedure mudaHeight( comp : array of TWincontrol; Height : integer );
    var
     laco : integer;
  begin
     for laco := low(comp) to high(comp) do
       comp[laco].Height := height;
  end;

  procedure mudaFonte( comp : array of TWincontrol; Nomefonte : string; TamanhoFonte : integer );
  var
    laco : integer;
  begin
     for laco := low(comp) to high(comp) do
     begin
       if (comp[laco] is TQRLabel) then
       begin
         (comp[laco] as TQRLabel).Font.Name := Nomefonte;
         (comp[laco] as TQRLabel).Font.Size := TamanhoFonte;
        end;
       if (comp[laco] is TQRDBText) then
       begin
         (comp[laco] as TQRDBText).Font.Name := Nomefonte;
         (comp[laco] as TQRDBText).Font.Size := TamanhoFonte;
       end;
     end;
  end;

begin

  QRLabel1.Caption := titulo; // titulo do relátorio

  mudaHeight([DetailBand1,QRShape6,QRShape2,QRShape3,QRShape4,QRShape7], altura); //muda altura

  mudaFonte( [QRLabel2,QRLabel3,QRLabel4,QRLabel5,QRLabel9, QRDBText1,QRDBText2,QRDBText3,QRDBText4,QCodProduto],
             nomeFonte, FonteCorpo);  // muda fonte

  canvas.Font.Name := NomeFonte;  // fonte
  Canvas.Font.Size := FonteCorpo; // tamanho fonte

  QRDBText1.top := trunc((altura - Canvas.TextHeight('AA')) / 2);  // posicao do texto
  QRDBText2.top := trunc((altura - Canvas.TextHeight('AA')) / 2);  // posicao do texto
  QRDBText3.top := trunc((altura - Canvas.TextHeight('AA')) / 2);  // posicao do texto
  QRDBText4.top := trunc((altura - Canvas.TextHeight('AA')) / 2);  // posicao do texto
  QCodProduto.top := trunc((altura - Canvas.TextHeight('AA')) / 2);  // posicao do texto

  QRShape1.Top := altura - 5; // linha inferir do detail

  if not ImprimirLinha then // mostra ou nao as linhas
    AlterarEnabledDet([QRShape1,QRShape2,QRShape3,QRShape4,QRShape7,QRShape6], false);

  if campos[0] <> 1 then
  begin
    QRDBText1.Enabled := false;
    QRLabel2.Enabled := false;
  end;
  if campos[2] <> 1 then
  begin
    QRDBText2.Enabled := false;
    QRLabel3.Enabled := false;
    QRShape9.Enabled := false;
    QRShape3.Enabled := false;
  end;
  if campos[1] <> 1 then
  begin
    QRDBText3.Enabled := false;
    QRLabel4.Enabled := false;
    QRShape11.Enabled := false;
    QRShape6.Enabled := false;
  end;

  case campos[3] of
    1 : QRDBText4.DataField := 'venda';
    2 : QRDBText4.DataField := 'compra';
    3 : QRDBText4.DataField := 'custo';
  end;
end;


procedure TFImprimeTabela.AbreRelatorio(SQL : TStrings; classificacao : String; Altura, FonteCorpo : Integer; ImprimirLinha :Boolean; NomeFonte : string;
                                        campos : array of integer; titulo : string );
begin
  ConfiguraRel(Altura,FonteCorpo,ImprimirLinha,NomeFonte, titulo, campos);
  if DeletaEspaco(classificacao) = '' then
    QRLabel8.Caption := 'Todas'
  else
    QRLabel8.Caption := classificacao;
  FechaTabela(tabela);
  tabela.sql := SQL;
  AbreTabela(tabela);
  QuickRepNovo1.Preview;
  self.close;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
Initialization
 RegisterClasses([TFImprimeTabela]);
end.
