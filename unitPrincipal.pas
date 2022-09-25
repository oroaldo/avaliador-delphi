unit unitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMXTee.Engine, FMXTee.Series,
  FMXTee.Procs, FMXTee.Chart, FMX.Objects, FMX.Layouts;

type
  TfrmPrincipal = class(TForm)
    Button1: TButton;
    btnOtimo: TButton;
    btnRegular: TButton;
    btnRuim: TButton;
    imgOtimo: TImage;
    imgRegular: TImage;
    imgRuim: TImage;
    lblTitulo: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    quadroVotos: TPanel;
    timer: TTimer;
    Chart1: TChart;
    quadroGrafico: TPanel;
    Series1: THorizBarSeries;
    procedure Button1Click(Sender: TObject);
    procedure btnOtimoClick(Sender: TObject);
    function contador(voto: String): Integer;
    function verResultado(): Integer;
    function calcVotos(votos, total: Integer): Integer;
    procedure btnRegularClick(Sender: TObject);
    procedure btnRuimClick(Sender: TObject);
    procedure imgOtimoClick(Sender: TObject);
    procedure imgRegularClick(Sender: TObject);
    procedure imgRuimClick(Sender: TObject);
    procedure timerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses unitDM;

procedure TfrmPrincipal.btnOtimoClick(Sender: TObject);
begin
  contador('OTIMO');
  verResultado;
end;

procedure TfrmPrincipal.btnRegularClick(Sender: TObject);
begin
  contador('REGULAR');
  verResultado;
end;

procedure TfrmPrincipal.btnRuimClick(Sender: TObject);
begin
  contador('RUIM');
  verResultado;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  {dm.qry.Active:= false;
  dm.qry.SQL.Clear;
  dm.qry.SQL.Add('SELECT sum(escore) as total FROM sentiment');
  dm.qry.Active := true;
  ShowMessage(FloatToStr(dm.qry.FieldByName('total').Value) + ' votos');}
end;

function TfrmPrincipal.contador(voto: String): integer;
begin
  dm.qry.Active:= false;
  dm.qry.SQL.Clear;
  dm.qry.SQL.Add('update sentiment set escore = escore+1 where voice ="'+voto+'"');
  dm.qry.Prepare;
  dm.qry.ExecSQL;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  chart1.Series[0].Clear;
end;

procedure TfrmPrincipal.imgOtimoClick(Sender: TObject);
begin
  contador('OTIMO');
  verResultado;
end;

procedure TfrmPrincipal.imgRegularClick(Sender: TObject);
begin
  contador('REGULAR');
  verResultado;
end;

procedure TfrmPrincipal.imgRuimClick(Sender: TObject);
begin
  contador('RUIM');
  verResultado;
end;

procedure TfrmPrincipal.timerTimer(Sender: TObject);
begin
  //RETORNA AOS SMILES APÓS 5s
  if timer.Interval < 4000 then
    begin
      timer.Interval := timer.interval + 1000;
    end
  else
   begin
     timer.Enabled:= false;
     quadroVotos.Visible:= True;
     quadroGrafico.Visible:= False;
   end;
end;

function TfrmPrincipal.verResultado(): integer;
var otimo, bom, ruim, total: integer;
begin
  dm.qry.Active:= false;
  dm.qry.SQL.Clear;
  dm.qry.SQL.Add('select "votos", SUM(CASE WHEN voice = "RUIM" THEN escore END) ruim,SUM(CASE WHEN voice = "REGULAR" THEN escore END) bom, SUM(CASE WHEN voice = "OTIMO" THEN escore END) otimo, SUM(escore) as total from sentiment');
  dm.qry.Active := true;

  total := dm.qry.FieldByName('total').AsInteger;

  otimo := calcVotos(dm.qry.FieldByName('otimo').AsInteger, total);
  bom := calcVotos(dm.qry.FieldByName('bom').AsInteger, total);
  ruim := calcVotos(dm.qry.FieldByName('ruim').AsInteger, total);


  chart1.series[0].Clear;
  chart1.series[0].Add(otimo, 'ÓTIMO', TAlphaColorRec.Green);
  chart1.series[0].Add(bom, 'REGULAR', TAlphaColorRec.Yellow);
  chart1.series[0].Add(ruim, 'RUIM', TAlphaColorRec.Red);
  chart1.Series[0].SortByLabels(loAscending);

  quadroVotos.Visible:= False;
  quadroGrafico.Visible:= True;

  timer.Enabled:= true;
end;

function TfrmPrincipal.calcVotos(votos, total: integer): integer;
var porcentagem: integer;
begin
  Result:= Round((votos*100)/total);
end;

end.
