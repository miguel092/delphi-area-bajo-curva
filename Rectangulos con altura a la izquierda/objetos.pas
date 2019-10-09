unit Objetos;

{$mode objfpc}{$H+}

interface

uses
  Contnrs, ExtCtrls, Graphics, Math;

{************************************************************************
***************** DEFINICIÓN DE LA CLASE cl_puntoreal ******************}
type
cl_puntoreal = class
  private
    x: real;
    y: real;
    xo: integer;
    yo: integer;
    xt: integer;
    yt: integer;
    precision: integer;
  public
    procedure setx(n:real);
    procedure sety(n:real);
    procedure setxo(n:integer);
    procedure setyo(n:integer);
    procedure setxt(n:integer);
    procedure setyt(n:integer);
    procedure setprecision(n:integer);
    function getx: real;
    function gety: real;
    function getxo: integer;
    function getyo: integer;
    function getxt: integer;
    function getyt: integer;
    function getprecision: integer;
    procedure geotograf;
    constructor create(cx,cy: real; crx,cry,p:integer);
end;

{**********************************************************************
******************* DEFINICIÓN DE LA CLASE cl_linea ******************}
type
cl_linea = class
  private
    puntoInicio: cl_puntoreal;
    puntoFin: cl_puntoreal;

  public
    procedure setpuntoInicio(x, y: real);
    procedure setpuntoFin(x, y: real);
    function getpuntoInicio: cl_puntoreal;
    function getpuntoFin: cl_puntoreal;
    constructor create(xorig, yorig:integer; xInicio, yInicio, xFin, yFin:real; p: integer);
end;
{**********************************************************************
******************* DEFINICIÓN DE LA CLASE cl_rectangulo ******************}
type
  cl_rectangulo = class
    private
      lado1: cl_linea;
      lado2: cl_linea;
      lado3: cl_linea;
      lado4: cl_linea;

    public
      procedure setlado1(xInic, yInic, xFin, yFin:real);
      procedure setlado2(xInic, yInic, xFin, yFin:real);
      procedure setlado3(xInic, yInic, xFin, yFin:real);
      procedure setlado4(xInic, yInic, xFin, yFin:real);
      function getlado1: cl_linea;
      function getlado2: cl_linea;
      function getlado3: cl_linea;
      function getlado4: cl_linea;
      constructor create(xorig, yorig:integer; xInicio, yInicio, xFin, yFin:real; p:integer);
  end;

 {**********************************************************************
 ******************* DEFINICIÓN DE LA CLASE cl_plotreal ******************}
type
cl_plotreal = class
  private
    lineas: TObjectlist;
    superficie: TImage;

  public
//  procedure setlineas(n: integer);
  	procedure setsuperficie(ima: TImage);
  	function getlineas: TObjectlist;
  	function getsuperficie: TImage;
    procedure modelo(izq, der: real);
    procedure graficar;
    constructor create(n, xorig, yorig:integer; salida:TImage; p:integer);
  end;

{**************************************************************************
*************** DEFINICIÓN DE LA CLASE cl_plotrectangulo ******************}
type
LadosRectangulo = array[1..4,1..600] of real;
  cl_plotrectangulo = class
    private
      rectangulos: TObjectlist;
      superficie: TImage;
    public
      procedure setrectangulos(n:integer; LadosR:LadosRectangulo);
      procedure setsuperficie(ima: TImage);
      function getrectangulos: TObjectList;
      function getsuperficie: TImage;
      procedure graficar;
      constructor create(numRec, xorig, yorig:integer; xInicio, yInicio, xFin, yFin: real; salida: TImage;p:integer);
   end;

{**************************************************************************
*************** DEFINICIÓN DE LA CLASE cl_sumaRiemman ******************}
type
  cl_sumaRiemman = class
    private
      limiteInferior: real;
      limiteSuperior: real;
      funcion: cl_plotreal;
      numeroRectangulos: integer;
      areaRiemman: real;
      areaIntegral: real;
      error: real;
      rectangulo: cl_plotrectangulo;

    public
      procedure setLimiteInferior(n: real);
      procedure setLimiteSuperior(n: real);
      procedure setFuncion(f: cl_plotreal);
      procedure setNumeroRectangulos(n: integer);
      procedure setAreaRiemman(n: real);
      procedure setAreaIntegral(n: real);
      procedure setError(n: real);
      procedure setRectangulo(r: cl_plotrectangulo);
      function getLimiteInferior: real;
      function getLimiteSuperior: real;
      function getFuncion: cl_plotreal;
      function getNumeroRectangulos: integer;
      function getAreaRiemman: real;
      function getAreaIntegral: real;
      function getError: real;
      function getRectangulo: cl_plotrectangulo;
      function calcularArea: real;
      function calcularError: real;
      constructor create(xorig, yorig:integer; limInf,limSup,areaAnalitica:real;noRectangulos, prec:integer; salida:TImage);
end;
implementation
{**********************************************************************
*************** MÉTODOS DE LA CLASE cl_puntoreal ******************}
procedure cl_puntoreal.setx(n:real);
begin
  x:=n;
end;

procedure cl_puntoreal.sety(n:real);
begin
  y:=n;
end;

procedure cl_puntoreal.setxo(n:integer);
begin
  xo:=n;
end;

procedure cl_puntoreal.setyo(n:integer);
begin
  yo:=n;
end;

procedure cl_puntoreal.setxt(n:integer);
begin
  xt:=n;
end;

procedure cl_puntoreal.setyt(n:integer);
begin
  yt:=n;
end;

procedure cl_puntoreal.setprecision(n:integer);
begin
  precision:=n;
end;


function cl_puntoreal.getx: real;
begin
  getx:=x;
end;

function cl_puntoreal.gety: real;
begin
  gety:=y;
end;

function cl_puntoreal.getxo: integer;
begin
  getxo:=xo;
end;

function cl_puntoreal.getyo: integer;
begin
  getyo:=yo;
end;

function cl_puntoreal.getxt: integer;
begin
  getxt:=xt;
end;

function cl_puntoreal.getyt: integer;
begin
  getyt:=yt;
end;

function cl_puntoreal.getprecision: integer;
begin
  getprecision:=precision;
end;

procedure cl_puntoreal.geotograf;
begin
  xt:=round(xo+(x*precision));
  yt:=round(yo-(y*precision));
end;

constructor cl_puntoreal.create(cx,cy: real; crx,cry,p:integer);
begin
  x:=cx;
  y:=cy;
  xo:=crx;
  yo:=cry;
  precision:=p;
end;

{**********************************************************************
******************* MÉTODOS DE LA CLASE cl_linea **********************}
procedure cl_linea.setpuntoInicio(x, y: real);
begin
     puntoInicio.setx(x);
     puntoInicio.sety(y);
     puntoInicio.geotograf;
end;

procedure cl_linea.setpuntoFin(x, y: real);
begin
     puntoFin.setx(x);
     puntoFin.sety(y);
     puntoFin.geotograf;
end;

function cl_linea.getpuntoInicio: cl_puntoreal;
begin
  getpuntoInicio:= puntoInicio;
end;

function cl_linea.getpuntoFin: cl_puntoreal;
begin
  getpuntoFin:= puntoFin;
end;

constructor cl_linea.create(xorig, yorig:integer; xInicio, yInicio, xFin, yFin:real; p: integer);
begin
   puntoInicio := cl_puntoreal.create(xInicio, yInicio, xorig, yorig, p);
   puntoFin := cl_puntoreal.create(xFin, yFin, xorig, yorig, p);
end;

{****************************************************************************
******************* MÉTODOS DE LA CLASE cl_rectangulo **********************}
 procedure cl_rectangulo.setlado1(xInic, yInic, xFin, yFin:real);
begin
  lado1.setpuntoInicio(xInic,yInic);
  lado1.setpuntoFin(xFin,yFin);
end;

procedure cl_rectangulo.setlado2(xInic, yInic, xFin, yFin:real);
begin
  lado2.setpuntoInicio(xInic,yInic);
  lado2.setpuntoFin(xFin,yFin);
end;

procedure cl_rectangulo.setlado3(xInic, yInic, xFin, yFin:real);
begin
  lado3.setpuntoInicio(xInic,yInic);
  lado3.setpuntoFin(xFin,yFin);
end;

procedure cl_rectangulo.setlado4(xInic, yInic, xFin, yFin:real);
begin
  lado4.setpuntoInicio(xInic,yInic);
  lado4.setpuntoFin(xFin,yFin);
end;

function cl_rectangulo.getlado1: cl_linea;
begin
  Result:=lado1;
end;

function cl_rectangulo.getlado2: cl_linea;
begin
  Result:=lado2;
end;

function cl_rectangulo.getlado3: cl_linea;
begin
  Result:=lado3;
end;

function cl_rectangulo.getlado4: cl_linea;
begin
  Result:=lado4;
end;

constructor cl_rectangulo.create(xorig, yorig:integer; xInicio, yInicio, xFin, yFin:real; p:integer);
begin
   lado1 := cl_linea.create(xorig,yorig,xInicio,yInicio,xFin,yInicio, p);
   lado2 := cl_linea.create(xorig, yorig, xFin, yInicio, xFin, yFin, p);
   lado3 := cl_linea.create(xorig, yorig, xFin, yFin, xInicio, yFin, p);
   lado4 := cl_linea.create(xorig, yorig, xInicio, yFin, xInicio, yInicio, p);
end;


{****************************************************************************
******************* MÉTODOS DE LA CLASE cl_plotreal **********************}
procedure cl_plotreal.setsuperficie(ima: TImage);
begin
     superficie:=ima;
end;

function cl_plotreal.getlineas: TObjectlist;
begin
     getlineas:=lineas;
end;

function cl_plotreal.getsuperficie: TImage;
begin
    getsuperficie:=superficie;
end;

procedure cl_plotreal.modelo(izq, der: real);
var
    i, c, p: integer;
    vx: real;

    function f(n: real):real;
    begin
        f:=power(n,1/3);
       // f:=1-power(n-1,3)-power(n-1,2);   //    0 - 1 = 0.91666
       //f:=power(n,2);                    // -1.5 - 1 = 1.4583
       //f:=cos(n);                        // -2.5 - 2.5 = 1.1969
       //f:=sin(n);                        // -pi - pi = 2
       //f:=ln(n);                         //  1   - e (2.71.82) = 1
    end;

begin
     c:=0;
     with lineas do
     begin
        p := (Items[0] as cl_linea).getpuntoInicio.getprecision;
     end;

     for i:=1 to round(1+(der-izq)*p) do
     begin
         vx:=izq+(i-1)/p;
         with lineas do
         begin
             (Items[c] as cl_linea).setpuntoInicio(vx,f(vx));
             (Items[c] as cl_linea).setpuntoFin((izq+(i)/p),f(izq+(i)/p));
         end;
         c:=c+1;
     end;
end;
procedure cl_plotreal.graficar;
var
    i, n, alto, ancho, xCero, yCero: integer;
    cx,cy,cx1,cy1: integer;
begin
    alto:=600;
    ancho:=600;
    with lineas do
    begin
         xCero:=(Items[1] as cl_linea).getpuntoInicio.getxo;
         yCero:=(Items[1] as cl_linea).getpuntoInicio.getyo;
    end;

    superficie.Canvas.Pen.Color:=clGreen;
	superficie.Canvas.Line(0, yCero, ancho, yCero);
    superficie.Canvas.Line(xCero, 0, xCero, alto);
	n:=lineas.count;
    superficie.Canvas.Pen.Color:=clBlack;
	for i:=1 to n do
    begin
        with lineas do
        begin
         cx := (Items[i-1] as cl_linea).getpuntoInicio.getxt;
         cy := (Items[i-1] as cl_linea).getpuntoInicio.getyt;
         cx1 := (Items[i-1] as cl_linea).getpuntoFin.getxt;
         cy1 := (Items[i-1] as cl_linea).getpuntoFin.getyt;
        end;
        superficie.Canvas.Line(cx,cy,cx1,cy1);
    end;
end;

constructor cl_plotreal.create(n, xorig, yorig:integer; salida: TImage; p:integer);
var
	i: integer;
begin
	superficie:=salida;
	lineas:=TObjectlist.Create();
	for i:=1 to n do
	begin
		lineas.Add(cl_linea.create(xorig,yorig,0,0,0,0,p));
	end;
end;

{**************************************************************
*************** MÉTODOS DE LA CLASE cl_plotrectangulo *********}
procedure cl_plotrectangulo.setrectangulos(n:integer; LadosR:LadosRectangulo);
var
   i:integer;
begin

   for i:=1 to n do
   begin
        with rectangulos do
        begin
             (Items[i-1] as cl_rectangulo).setlado1(LadosR[1,i],LadosR[2,i],LadosR[3,i],LadosR[4,i]);
             (Items[i-1] as cl_rectangulo).setlado2(LadosR[1,i],LadosR[2,i],LadosR[3,i],LadosR[4,i]);
             (Items[i-1] as cl_rectangulo).setlado3(LadosR[1,i],LadosR[2,i],LadosR[3,i],LadosR[4,i]);
             (Items[i-1] as cl_rectangulo).setlado4(LadosR[1,i],LadosR[2,i],LadosR[3,i],LadosR[4,i]);
        end;
   end;
end;

procedure cl_plotrectangulo.setsuperficie(ima: TImage);
begin
 superficie := ima;
end;

function cl_plotrectangulo.getrectangulos: TObjectlist;
begin
 getrectangulos := rectangulos;
end;

function cl_plotrectangulo.getsuperficie: TImage;
begin
 getsuperficie := superficie;
end;

procedure cl_plotrectangulo.graficar;
var
 alto, ancho, xCero, yCero, n: integer;
 x, y, x1, y1, i: integer;
begin
 alto := 300;
 ancho := 300;

 with rectangulos do
 begin
   xCero := (Items[0] as cl_rectangulo).getlado1.getpuntoInicio.getxo;
   yCero := (Items[0] as cl_rectangulo).getlado1.getpuntoInicio.getyo;
 end;
 superficie.Canvas.Pen.Color := clGreen;
 superficie.Canvas.Line(0, yCero, ancho, yCero);
 superficie.Canvas.Line(xCero, 0, xCero, alto);

 n:=rectangulos.Count;
 superficie.Canvas.Pen.Color := clskyblue;
 for i:= 1 to n do
 begin
     with rectangulos do
     begin
         x := (Items[i-1] as cl_rectangulo).getlado1.getpuntoInicio.getxt;
         y := (Items[i-1] as cl_rectangulo).getlado1.getpuntoInicio.getyt;
         x1 := (Items[i-1] as cl_rectangulo).getlado2.getpuntoFin.getxt;
         y1 := (Items[i-1] as cl_rectangulo).getlado2.getpuntoFin.getyt;
     end;
     superficie.Canvas.Rectangle(x, y, x1, y1);
 end;
end;

constructor cl_plotrectangulo.create(numRec, xorig, yorig:integer; xInicio, yInicio, xFin, yFin: real; salida: TImage; p:integer);
var
 i: integer;
begin
 superficie := salida;
 rectangulos:=TObjectlist.Create();
 for i:=1 to numRec do
 begin
   rectangulos.Add(cl_rectangulo.create(xorig, yorig, xInicio, yInicio, xFin, yFin, p));
 end;
end;

{**************************************************************
*************** MÉTODOS DE LA CLASE cl_sumaRiemman *********}
procedure cl_sumaRiemman.setLimiteInferior(n: real);
begin
   limiteInferior:=n;
end;

procedure cl_sumaRiemman.setLimiteSuperior(n: real);
begin
   limiteSuperior:=n;
end;

procedure cl_sumaRiemman.setFuncion(f: cl_plotreal);
begin
  funcion:=f;
end;

procedure cl_sumaRiemman.setNumeroRectangulos(n: integer);
begin
   numeroRectangulos:=n;
end;

procedure cl_sumaRiemman.setAreaRiemman(n: real);
begin
     areaRiemman:=n;
end;

procedure cl_sumaRiemman.setAreaIntegral(n: real);
begin
  areaIntegral:=n;
end;

procedure cl_sumaRiemman.setError(n: real);
begin
     error:=n;
end;

procedure cl_sumaRiemman.setRectangulo(r: cl_plotrectangulo);
begin
    rectangulo:=r;
end;

function cl_sumaRiemman.getLimiteInferior: real;
begin
    Result:=limiteInferior;
end;

function cl_sumaRiemman.getLimiteSuperior: real;
begin
  Result:=limiteSuperior;
end;

function cl_sumaRiemman.getFuncion: cl_plotreal;
begin
  Result:=funcion;
end;

function cl_sumaRiemman.getNumeroRectangulos: integer;
begin
  Result:=numeroRectangulos;
end;

function cl_sumaRiemman.getAreaRiemman: real;
begin
  Result:=areaRiemman;
end;

function cl_sumaRiemman.getAreaIntegral: real;
begin
  Result:=areaIntegral;
end;

function cl_sumaRiemman.getError: real;
begin
  Result:=error;
end;

function cl_sumaRiemman.getRectangulo: cl_plotrectangulo;
begin
  Result:=rectangulo
end;

function cl_sumaRiemman.calcularArea: real;
var
  i,p,recFull, decimales: integer;
  base, fx, xInicio: real;
  recs, linea: TObjectlist;
  ladosRectangulo: array[1..4,1..600] of real;
begin
  recs := rectangulo.getrectangulos;

  with recs do
  begin
    p := (Items[0] as cl_rectangulo).getlado1.getpuntoInicio.getprecision;
  end;
  case p of
     1: decimales:=0;
     10: decimales:=-1;
     100: decimales:=-2;
     1000: decimales:=-3;
  end;
  base:=(limiteSuperior-limiteInferior)/numeroRectangulos;
  recFull:=1;
  linea:=funcion.getlineas;

  for i:=1 to round(1+(limiteSuperior-limiteInferior)*p) do
  begin
    with linea do
    begin
      xInicio:= (Items[i-1] as cl_linea).getpuntoInicio.getx;
    end;

    if roundto(xInicio,decimales) = roundto((limiteInferior+(base*recFull))-base,decimales) then
    begin
      with linea do
      begin
        fx := (Items[i-1] as cl_linea).getpuntoInicio.gety;
      end;

      ladosRectangulo[1,recFull]:= xInicio;
      ladosRectangulo[2,recFull]:= 0;
      ladosRectangulo[3,recFull]:= xInicio+base;
      ladosRectangulo[4,recFull]:= fx;
      areaRiemman:=abs(areaRiemman+(fx*base));
      recFull:=recFull+1;
    end;
  end;
  rectangulo.setrectangulos(numeroRectangulos, ladosRectangulo);
  rectangulo.graficar;
  funcion.graficar;
  result:=roundto(areaRiemman,-5);
end;

function cl_sumaRiemman.calcularError: real;
begin
  error:=abs(roundto(areaIntegral,-5)-roundto(areaRiemman,-5));
  result:=roundto(error,-5);
end;

constructor cl_sumaRiemman.create(xorig, yorig:integer; limInf,limSup,areaAnalitica:real;noRectangulos, prec:integer; salida:TImage);
var
   numeroObjetos: integer;
begin
  limiteInferior:=limInf;
  limiteSuperior:=limSup;
  numeroRectangulos:=noRectangulos;
  areaIntegral:=areaAnalitica;
  numeroObjetos:=round(((limiteSuperior-limiteInferior)*prec)+1);
  funcion := cl_plotreal.create(numeroObjetos,xorig,yorig,salida,prec);
  funcion.modelo(limiteInferior,limiteSuperior);
  rectangulo := cl_plotrectangulo.create(numeroRectangulos,xorig,yorig,0,0,0,0,salida,prec);
end;


end.


