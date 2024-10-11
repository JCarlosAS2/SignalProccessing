unit Unit_Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, Menus, Fourier, Cepstrum, TAGraph, TASeries, UTBaseFreqAnalisys;

type
  ARREGLO = ARRAY OF single;

  { TForm1 }

  TForm1 = class(TForm)
    Cepstrum1: TCepstrum;
    Chart1: TChart;
    Chart2: TChart;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBoxSignalData: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelBitMuestra: TLabel;
    LabelCanal: TLabel;
    LabelFrecMuestreo: TLabel;
    LabelName: TLabel;
    MainMenu1: TMainMenu;
    MenuItemCepstrum: TMenuItem;
    MenuItemLoad: TMenuItem;
    MenuItemProject: TMenuItem;
    MenuItemArchivo: TMenuItem;
    MenuItemClose: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemCepstrumClick(Sender: TObject);
    procedure MenuItemCloseClick(Sender: TObject);
    procedure MenuItemLoadClick(Sender: TObject);
  private
    { private declarations }
    procedure ShowCepstrum;
  public
    { public declarations }
  end; 

var
  Form1: TForm1;
  FLine1: TLineSeries;
  FLine2: TLineSeries;
  canalDE, canalIZ: array of single;
  Buff: array of byte;
  Filename: string;
  frecMuestreo: word;
  ok, bandera: boolean;
  nombreF:PAnsiChar;

implementation

{******************************************************************************}
function leerfichero():Boolean;  {esta funcion}
var
arch: file;
ptrBuff: ^byte;
CantidadByte, size, n: longword;

begin
if Form1.OpenDialog1.Execute then     { Display Open dialog box }
begin
  Filename:= Form1.OpenDialog1.Filename;
  AssignFile(arch, Filename);
  FileMode:= 0; //read-only mode
  Reset(arch,1); // record size to be used in data transfers of 1 bytes
  size:= FileSize(Filename);
  SetLength(Buff, size);
  if size<>0 then
  begin
    result:= true;
    ok:= true;
    for CantidadByte:= low(Buff) to high(Buff) do  Buff[CantidadByte]:= 0;
    ptrBuff:= @Buff[low(Buff)];
    //Form1IU.Label1.Caption :='No.Byte= '+ CurrToStrF( size,ffNumber,0 );
    CantidadByte:= size;
    BlockRead(arch, ptrBuff^, CantidadByte);
    CloseFile(arch);
  end else
        begin
          CloseFile(arch);
          result:= false;
          ok:= false;
        end;
end  else result:= false;
End;
{******************************************************************************}

{******************************************************************************}
function canal(A:array of byte):arreglo;  {esta funcion}
  var
  x, x1: longword;
  palabra: word;
  begin
  //Buff[22]= numero de canales.(estereo=2byte=1/canal,mono=1byte)
  //Buff[34]= bit por muestras(8bit/muestras=1byte,16bit/muetras=2byte)
  //SE INTRODUCE UN ERROR DE ESCALA,EL MAYOR VALOR DE 1BYTE=255 Y NO 256!!!!!!!
   if (A[34]= 16) and (A[22]= 1) then //16bit/muestras,mono
   {concateno los pares de byte consecutivos para formar word}
   {y convierto de word a entero}
    begin
          SetLength(result, (length(A)-44)div 2);
          SetLength(canalDE, (length(A)-44)div 2);
          x:= 22; //para que 2*22=44 sea el primer valor despues del header
          while x<=((length(A)div 2)-1) do //elimina 44 byte de header
            begin
             result[x-22]:= (A[2*x]+A[2*x+1]*$100)/32767;//16bitPCM(-32768=0=32767)
             if  (A[2*x]+A[2*x+1]*$100) > 32767 then
              begin
                palabra:= A[2*x]+A[2*x+1]*$100;
                result[x-22]:= smallint(palabra)/32768;
              end;
             canalDE[x-22]:= 0;//valores impares
             x:= x+1;
            end;
        end
   else if (A[34]=8) and (A[22]=2) then //8bit/muestras,estereo
   //separo canal derecho del izquierdo, no son senales idem,pero parecidas
        begin
          SetLength(result, (length(A)-44)div 2);
          SetLength(canalDE, (length(A)-44)div 2);
          x:= 22; //para que 2*22=44 sea el primer valor despues del header
          while x <= ((length(A)div 2)-1) do //elimina 44 byte de header
            begin
             result[x-22]:= 2*A[2*x]/255-1;//valores pares
             canalDE[x-22]:= 2*A[2*x+1]/255-1;//valores impares
             x:= x+1;
            end;
        end
   else if (A[34]= 8) and (A[22]= 1) then   //8bit/muestras,mono
                begin
                  SetLength(result, length(A)-44);
                  SetLength(canalDE, length(A)-44);
                  x:= 44;
                    while x<= high(A) do  //elimina 44 byte de header
                      begin
                        result[x-44]:= 2*A[x]/255-1;//convierte de byte a entero
                        canalDE[x-44]:= 0;
                        x:= x+1;
                      end;
                end
   else
        begin //16bit/muestra estereo
          SetLength(result, (length(A)-44)div 4); //4bytes para una muestra.
          SetLength(canalDE, (length(A)-44)div 4);
          x:= 11; //para que 11*4=44 sea el primer valor despues del header
          while x<=((length(A)div 4)-1) do //elimina 44 byte de header
            begin
             result[x-11]:= (A[4*x]+A[4*x+1]*$100)/32767; //16bitPCM(-32768=0=32767)
             if  (A[4*x]+A[4*x+1]*$100) > 32767 then
               begin
                palabra:= A[4*x]+A[4*x+1]*$100;
                result[x-11]:= smallint(palabra)/32768;
               end;
             canalDE[x-11]:= (A[4*x+2]+A[4*x+3]*$100)/32767; //16bitPCM(-32768=0=32767)
             if  (A[4*x+2]+A[4*x+3]*$100) > 32767 then
              begin
                palabra:= A[4*x+2]+A[4*x+3]*$100;
                canalDE[x-11]:= smallint(palabra)/32768;
              end;
             x:=x+1;
            end;
        end;
  End;
{******************************************************************************}

{******************************************************************************}
procedure VozClick();   {esta funcion}
var
x: longword;
salto, i: word;

begin
    if Form1.Chart1.SeriesCount > 0
     then
        for i:= Form1.Chart1.SeriesCount - 1 downto 0  do
         Begin
           try
             Form1.Chart1.DeleteSeries(Form1.Chart1.Series[i]);
           except Begin

                  end;
           end;
         end;

   Form1.Chart1.ClearSeries;
   FLine1 := TLineSeries.Create(nil);
   FLine1.SeriesColor := clRed;
   Form1.Chart1.AddSeries(FLine1);

   FLine2 := TLineSeries.Create(nil);
   FLine2.SeriesColor := clblue;
   Form1.Chart1.AddSeries(FLine2);
   //Form1.Chart2.AddSeries(FLine2);

With Form1.Chart1.Title.Text do
   begin
      Clear;
      Add('VOZ');
   end;
//Form1IU.Chart1.Repaint;
if leerfichero() then
  begin
     canalIZ:= canal(Buff);
    case  length(canalIZ) of
       1..500 : salto:= 1;
       501..10000 : salto:= 5;
       10001..100000 : salto:= 10;
       100001..1000000 : salto:= 50;
     else salto := 100;
    end;
      x:=0;
          while x<= high(canalIZ) do  {es el rojo}
              begin
                 FLine1.AddXY(x, canalIZ[x]);
                 x:= x+salto;
              end;
      x:=0;     {Buff es un open array, low(Buff)=0}
          while x<= high(canalDE) do  {es el azul}
              begin
                 FLine2.AddXY(x, canalDE[x]);
                 x:= x+salto;
              end;
         frecMuestreo:= Buff[24]+Buff[25]*256+Buff[26]*65536+Buff[27]*16777216;
    With Form1.Chart1.Title.Text do
       begin
          Clear;
	  Add('VOZ '+ ExtractFileName(FileName));
       end;
  end;
End;
{******************************************************************************}

{******************************************************************************}
procedure TForm1.ShowCepstrum;
var
   i, j: Integer;
   x: longword;
   y, z: Double;
   //salto: Word;
   Line: TLineSeries;
   Line1: TLineSeries;

begin
   Chart2.ClearSeries;
   Line:= TLineSeries.Create(Nil);
   Line.SeriesColor:= clRed;

   Line1:= TLineSeries.Create(Nil);
   Line1.SeriesColor:= clBlue;

  Cepstrum1.Clear;
  for i:= 1 to Cepstrum1.SpectrumSize do
   begin
      y:= canalIZ[i];
      Cepstrum1.RealSpec[i]:= y;
   end;
   Cepstrum1.Cepstrum;
   for j:= 1 to Cepstrum1.SpectrumSize do
      begin
         z:= Cepstrum1.RealSpec[j];
         Line.AddXY(j, z);
      end;


   Cepstrum1.Clear;
   for i:= 1 to Cepstrum1.SpectrumSize do
   begin
      y:= canalDE[i];
      Cepstrum1.RealSpec[i]:= y;
   end;
   Cepstrum1.Cepstrum;
   for j:= 1 to Cepstrum1.SpectrumSize do
      begin
         z:= Cepstrum1.RealSpec[j];
         Line1.AddXY(j, z);
      end;

   Chart2.AddSeries(Line);
   Chart2.AddSeries(Line1);
end;
{******************************************************************************}

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItemCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuItemCepstrumClick(Sender: TObject);
begin
  ShowCepstrum;
  GroupBox3.Enabled:= True;
  MenuItemCepstrum.Enabled:= False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Cepstrum1.Clear;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
       0:Cepstrum1.WeightingWindow := fwRectangle;
       1:Cepstrum1.WeightingWindow := fwTriangle;
       2:Cepstrum1.WeightingWindow := fwGauss;
       3:Cepstrum1.WeightingWindow := fwHamming;
       4:Cepstrum1.WeightingWindow := fwBlackman;
       5:Cepstrum1.WeightingWindow := fwCos2;
  end;
  ShowCepstrum;
end;

procedure TForm1.MenuItemLoadClick(Sender: TObject);
begin
  VozClick();
  nombreF:= PChar(Filename);
  Label1.Caption:= ExtractFileName(nombreF);
  Label2.Caption:= IntToStr(frecMuestreo);
  Label3.Caption:= IntToStr(Buff[22]);
  Label4.Caption:= IntToStr(Buff[34]);
  MenuItemCepstrum.Enabled:= True;
  Chart2.ClearSeries;

end;






end.

