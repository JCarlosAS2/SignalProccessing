unit UBasura1; 

{$mode DELPHI}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

 Abuelo=class(TObject)
   private
       public
       constructor Create();virtual;
   procedure p();Virtual;

 end;

 Padre= class(Abuelo)
   public
      constructor Create(); override;
      procedure kk;
      procedure p();override;
 end;

  Hijo=class(Padre)
      public
        constructor Create(); override;
     procedure p();override;
  end;

var
  Form1: TForm1; 

implementation

{ TForm1 }

constructor Hijo.Create();
Begin
  inherited Create;
  ShowMessage('Creando el Hijo');

end;

constructor Padre.Create();
Begin
  inherited Create;
  ShowMessage('Creando el Padre');

end;

procedure Padre.kk;
Begin
  p();
end;

constructor Abuelo.Create();
Begin
  inherited Create;
  ShowMessage('Creando el Abuelo');

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Abue: Abuelo;
begin
  Abue := Abuelo.Create();
  Abue.p();
  Abue.free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Hij: Hijo;
begin
  Hij := Hijo.Create();
  Hij.kk();

  Hij.free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Pad: Padre;
begin
  Pad := Padre.Create();
  Pad.kk();

  Pad.free;
end;

{$R *.lfm}
procedure Abuelo.p();
Begin
  ShowMessage('Soy el Abuelo');
end;

procedure Padre.p();
Begin
  ShowMessage('Soy el Padre');
end;

procedure Hijo.p();
Begin
  ShowMessage('Soy el Hijo');
end;


end.

