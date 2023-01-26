unit ULogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TFrmBodyfit = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    TabControl: TTabControl;
    TabLogin: TTabItem;
    TabConta: TTabItem;
    RtgLogin: TRectangle;
    Rectangle1: TRectangle;
    Edit1: TEdit;
    Edit2: TEdit;
    RtgBtnLogin: TRectangle;
    BtnLogin: TSpeedButton;
    Label1: TLabel;
    RtgConta: TRectangle;
    Rectangle3: TRectangle;
    Edit3: TEdit;
    Edit4: TEdit;
    Rectangle4: TRectangle;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Edit5: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBodyfit: TFrmBodyfit;

implementation

{$R *.fmx}

end.
