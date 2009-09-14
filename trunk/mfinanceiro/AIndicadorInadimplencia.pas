unit AIndicadorInadimplencia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, LabelCorMove, ComCtrls,
  ImgList, Db, DBTables;

Type
  TRBDNo = class
    public
      TipInformacao,
      CodEmpresa,
      CodFilial : Integer;
//tipo informacao
//  0 - geral
//  1 - Inadiplencia geral
//  2 - inadimplencia 60 dias
//  3 - inadimplecia 60 - 180 dias 
end;
type
  TFIndicadorInadimplencia = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Arvore: TTreeView;
    ELista: TListView;
    Splitter1: TSplitter;
    ImageList1: TImageList;
    Tabela: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    VprNoPrincipal : TTreeNode;
    procedure CarNoInadimplencia;
    procedure carArvore;
  public
    { Public declarations }
  end;

var
  FIndicadorInadimplencia: TFIndicadorInadimplencia;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFIndicadorInadimplencia.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  carArvore;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFIndicadorInadimplencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFIndicadorInadimplencia.CarNoInadimplencia;
Var
  VpfNo,VpfNoAnterior : TTreenode;
  VpfDNo : TRBDNo;
begin
  VpfNo := Arvore.Items.AddChild(VprNoPrincipal,'Inadimplência');
  VpfDNo := TRBDNo.Create;
  VpfDNo.TipInformacao := 1;
  VpfNo.Data :=VpfDNo;
  VpfNoAnterior := VpfNo;

  VpfNo := Arvore.Items.AddChild(VpfNo,'Período');
  VpfDNo := TRBDNo.Create;
  VpfDNo.TipInformacao := 1;
  VpfNo.Data :=VpfDNo;
  VpfNoAnterior := VpfNo;

  VpfNo := Arvore.Items.AddChild(VpfNoAnterior,'60 dias');
  VpfDNo := TRBDNo.Create;
  VpfDNo.TipInformacao := 1;
  VpfNo.Data :=VpfDNo;


end;

{******************************************************************************}
procedure TFIndicadorInadimplencia.carArvore;
var
  VpfDNo : TRBDNo;
  VpfNo : TTreeNode;
begin
  Arvore.Items.Clear;
  VprNoPrincipal := Arvore.Items.Add(Arvore.Selected,'Indicadores');
  VpfDNo := TRBDNo.Create;
  VpfDNo.TipInformacao :=0;
  VprNoPrincipal.Data := VpfDNo;

  CarNoInadimplencia;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFIndicadorInadimplencia]);
end.
