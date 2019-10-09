unit areaRiemman_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Objetos;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Grafica1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  area,error, limInf, limSup, areaAnalitica: real;
  prec, noRectangulos: integer;
  sumaR: cl_sumaRiemman;
begin
  Grafica1.Canvas.FillRect(1,1,600,600);
  limInf:=strtofloat(Edit1.Text);
  limSup:=strtofloat(Edit2.Text);
  prec:=strtoint(ComboBox1.Text);
  noRectangulos:=strtoint(Edit4.Text);
  areaAnalitica:=strtofloat(Edit5.Text);
  sumaR := cl_sumaRiemman.create(300,300,limInf,limSup,areaAnalitica,noRectangulos,prec,Grafica1);
  area := sumaR.calcularArea;
  Label6.Caption:=Concat('Área: ',floattostr(area),' u2');
  error:=sumaR.calcularError;
  Label7.Caption:=Concat('Error: ',floattostr(error));
  sumaR.Destroy;
end;

end.

