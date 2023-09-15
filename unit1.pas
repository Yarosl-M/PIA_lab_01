unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  RTTIGrids, TAGraph, TASeries, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnGenerate: TButton;
    BtnExit: TButton;
    BtnClear: TButton;
    BtnFindC: TButton;
    LeCharterino: TChart;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelC: TLabel;
    Label5: TLabel;
    ArrTable: TStringGrid;
    LeCharterinoBarSeries1: TBarSeries;
    LeCharterinoBarSeries2: TBarSeries;
    procedure BtnClearClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure BtnFindCClick(Sender: TObject);
    procedure BtnGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  MainArr: array[0..29] of Integer;
  C: Integer;

const
  A : integer = 30;
  B : integer = 80;

implementation

{$R *.lfm}

{ TForm1 }

function CellRow(i: integer): integer;
begin
  cellRow := i div 5;
end;

function CellCol(i: integer): integer;
begin
  cellCol := i mod 5;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  year: word;
  myCaption: string;
  captions: array[0..4] of String = (
  'Bruh',
  'Ronald Topala did not die for this',
  'Really dingles my berries',
  'M. A. is really proud',
  'A true society moment'
  );
begin
  Randomize();
  year := currentyear();
  myCaption := 'Pascal in ' + inttostr(year) + '?' + ' ' + captions[Random(5)];
  caption := myCaption;
end;



procedure TForm1.BtnExitClick(Sender: TObject);
begin
  Close();
end;

procedure TForm1.BtnFindCClick(Sender: TObject);
var
  average, minDistance, thisMinDist: real;
  minDistIndex, i: integer;
begin
  average := Mean(MainArr);
  minDistance := abs(average - MainArr[0]);
  minDistIndex := 0;
  for i := 1 to 29 do
  begin
    thisMinDist := abs(average - MainArr[i]);
    if thisMinDist < minDistance then
    begin
      minDistance := thisMinDist;
      minDistIndex := i;
    end;
  end;
  C := MainArr[minDistIndex];
  LabelC.Caption := 'C = ' + inttostr(C);

  LeCharterinoBarSeries1.Clear;
  LeCharterinoBarSeries2.Clear;
  for i := 0 to 29 do
  begin
    if i = minDistIndex then
      LeCharterinoBarSeries1.Add(0)
    else
      LeCharterinoBarSeries1.Add(MainArr[i], IntToStr(MainArr[i]));
  end;
  for i := 0 to 29 do
  begin
    if i = minDistIndex then
    begin
      LeCharterinoBarSeries2.Add(MainArr[minDistIndex], IntToStr(MainArr[minDistIndex]));
      Break;
    end
    else
    LeCharterinoBarSeries2.Add(0);
  end;
end;

procedure TForm1.BtnClearClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to 29 do
  begin
    ArrTable.Cells[CellCol(i), CellRow(i)] := '';
  end;
  //BtnChart.Enabled := false;
  BtnFindC.Enabled := false;
  LabelC.Caption := 'C =';
end;

procedure TForm1.BtnGenerateClick(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to 29 do
  begin
    MainArr[i] := Random(B - A + 1) + A;
    ArrTable.Cells[CellCol(i), CellRow(i)] := inttostr(MainArr[i]);
  end;
  //BtnChart.Enabled := true;
  BtnFindC.Enabled := true;
end;

end.

