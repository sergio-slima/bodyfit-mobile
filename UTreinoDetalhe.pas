unit UTreinoDetalhe;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TFrmTreinoDetalhe = class(TForm)
    LytToobar: TLayout;
    LblTitulo: TLabel;
    Image1: TImage;
    Label7: TLabel;
    LbxExercicios: TListBox;
    RtgBtnLogin: TRectangle;
    BtnIniciar: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTreinoDetalhe: TFrmTreinoDetalhe;

implementation

{$R *.fmx}

end.
