unit ARelContasaPagar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  ComCtrls, Localizacao;

type
  TFRelContasaPagar = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    data1: TCalendario;
    data2: TCalendario;
    Filtro: TComboBoxColor;
    EditLocaliza4: TEditLocaliza;
    Label18: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Localiza: TConsultaPadrao;
    EditLocaliza3: TEditLocaliza;
    Label17: TLabel;
    SpeedButton3: TSpeedButton;
    Label19: TLabel;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    primeiro : boolean;
    procedure adicionaSQLAnalitico( TipoFiltro : Integer );
    procedure adicionaSQLSintetico( TipoFiltro : Integer );
    function TextoFilial( TipoFiltro : Integer ) : string;
    function TextoData : string;
    function TextoFornecedor : string;
    function TextoHistorico: string;
  public
    { Public declarations }
  end;

var
  FRelContasaPagar: TFRelContasaPagar;

implementation

uses APrincipal, fundata, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRelContasaPagar.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
data1.date :=  PrimeiroDiaMes(date);
data2.date :=  UltimoDiaMes(date);
primeiro := false;
Filtro.ItemIndex := 0;
{ContasaPagarAnalitico.ReportName := varia.PathRel + 'ContasaPagarAnalitico.rpt';
ContasaPagarSintetico.ReportName := varia.PathRel + 'ContasaPagarSintetico.rpt';}
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRelContasaPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;

function TFRelContasaPagar.TextoFilial( TipoFiltro : Integer ) : string;
begin
case TipoFiltro of
0 :  result := ' AND CADCONTASAPAGAR."I_EMP_FIL" = ' + IntToStr(varia.CodigoEmpFil);
1 :  result := ' AND CADCONTASAPAGAR."I_EMP_FIL" like ''' + IntToStr(varia.CodigoEmpresa) + '%''';
2 :  result := '';
end;
end;

function TFRelContasaPagar.TextoData : string;
begin
result := ' AND MOVCONTASAPAGAR."D_DAT_VEN" >= ''' + DataToStrFormato(AAAAMMDD,data1.DateTime,'/') + '''' +
          ' AND MOVCONTASAPAGAR."D_DAT_VEN" <= ''' + DataToStrFormato(AAAAMMDD,data2.DateTime,'/') + '''';
end;

function TFRelContasaPagar.TextoFornecedor : string;
begin
if EditLocaliza4.Text <> '' then
   result := 'AND CADCONTASAPAGAR."I_COD_CLI" = ' + EditLocaliza4.Text
else
   result := ' ';
end;

function TFRelContasaPagar.TextoHistorico : string;
begin
if EditLocaliza3.Text <> '' then
   result := 'AND CADCONTASAPAGAR."I_COD_HIS" = ' + EditLocaliza3.Text
else
   result := ' ';
end;

procedure TFRelContasaPagar.AdicionaSQLAnalitico( TipoFiltro : Integer );
begin
{if ContasaPagarAnalitico.SQL.Query.Count > 18 then
begin
  ContasaPagarAnalitico.SQL.Query.Delete(18);
  ContasaPagarAnalitico.SQL.Query.Delete(17);
  ContasaPagarAnalitico.SQL.Query.Delete(16);
  ContasaPagarAnalitico.SQL.Query.Delete(15);
end;
ContasaPagarAnalitico.SQL.Query.Insert(15, self.TextoFilial(tipoFiltro));
ContasaPagarAnalitico.SQL.Query.Insert(16, self.TextoData);
ContasaPagarAnalitico.SQL.Query.Insert(17, self.TextoFornecedor);
ContasaPagarAnalitico.SQL.Query.Insert(18, self.TextoHistorico);}
end;


procedure TFRelContasaPagar.AdicionaSQLSintetico( TipoFiltro : Integer );
begin
{if ContasaPagarSintetico.SQL.Query.Count > 14 then
begin
  ContasaPagarSintetico.SQL.Query.Delete(14);
  ContasaPagarSintetico.SQL.Query.Delete(13);
  ContasaPagarSintetico.SQL.Query.Delete(12);
  ContasaPagarSintetico.SQL.Query.Delete(11);
end;
ContasaPagarSintetico.SQL.Query.Insert(11, self.TextoFilial(tipoFiltro));
ContasaPagarSintetico.SQL.Query.Insert(12, self.TextoData);
ContasaPagarSintetico.SQL.Query.Insert(13, self.TextoFornecedor);
ContasaPagarSintetico.SQL.Query.Insert(14, self.TextoHistorico);}
end;


procedure TFRelContasaPagar.BitBtn1Click(Sender: TObject);
begin
{case filtro.ItemIndex of
0 : AdicionaSQLAnalitico(0);
1 : AdicionaSQLAnalitico(1);
2 : AdicionaSQLAnalitico(2);
end;
ContasaPagarAnalitico.ReportTitle := varia.NomeEmpresa + ' - ' + varia.NomeFilial + ' - Período de ' + DateToStr(data1.DateTime) + ' à ' + DateToStr(data2.DateTime);
ContasaPagarAnalitico.Execute;}
end;


procedure TFRelContasaPagar.BitBtn2Click(Sender: TObject);
begin
{case filtro.ItemIndex of
0 : AdicionaSQLSintetico(0);
1 : AdicionaSQLSintetico(1);
2 : AdicionaSQLSintetico(2);
end;
ContasaPagarSintetico.ReportTitle := varia.NomeEmpresa + ' - ' + varia.NomeFilial + ' - Período de ' + DateToStr(data1.DateTime) + ' à ' + DateToStr(data2.DateTime);
ContasaPagarSintetico.Execute;}
end;

Initialization
 RegisterClasses([TFRelContasaPagar]);
end.
