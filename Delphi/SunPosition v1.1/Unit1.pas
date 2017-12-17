unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Samples.Calendar,
  Vcl.StdCtrls, Vcl.ComCtrls, System.Dateutils, System.StrUtils, System.Types, System.Math,
  Vcl.ExtCtrls, Vcl.Buttons, System.IniFiles, Vcl.Menus, ShellApi;

type
	ResultRec = RECORD
		Altitude		: double;
		Azimuth			: double;
		lblResult	: TLabel;
	END;

	DateDetail = RECORD
		edDate	: TDateTimePicker;
		cbDltSav: TCheckBox;
	END;

  TForm1 = class(TForm)
    btnCalc: TButton;
    edLongitude: TEdit;
    rgFormat: TRadioGroup;
    rbDegMinSec: TRadioButton;
    rbDecDeg: TRadioButton;
    lblLongitude: TLabel;
    lblLatitude: TLabel;
    edLatitude: TEdit;
    lblLatNote: TLabel;
    lblLongNote: TLabel;
    edZone: TComboBox;
    lblTimeZone: TLabel;
    edPlace: TEdit;
    lblPlaceName: TLabel;
    edAbrev: TEdit;
    lblAbrev: TLabel;
    lblMsg: TLabel;
    btnExp: TButton;
    btnExit: TButton;
    MainMenu1: TMainMenu;
    Help1: TMenuItem;
    ShadowInstructionManual1: TMenuItem;
    About1: TMenuItem;
    procedure btnCalcClick(Sender: TObject);
    procedure NumKeyPress(Sender: TObject; var Key: Char);
    procedure PlaceAbrevChange(Sender: TObject);
    procedure PlaceAbrevKeyPress(Sender: TObject; var Key: Char);
    procedure NumberKeyPress(Sender: TObject; var Key: Char);
    procedure edLatitudeExit(Sender: TObject);
    procedure edEnter(Sender: TObject);
    procedure FormatChange(Sender: TObject);
    procedure edLongitudeExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure edZoneExit(Sender: TObject);
    procedure edDateChange(Sender: TObject);
    procedure edTimeChange(Sender: TObject);
    procedure edPlaceExit(Sender: TObject);
    procedure SunPosDblClick(Sender: TObject);
    procedure SunPosClick(Sender: TObject);
    procedure btnExpClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure ShadowInstructionManual1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  sinceErr : integer;
  Dates : array [1..4] of DateDetail;
  Times : array [1..4] of TDateTimePicker;
  Results : array [1..4, 1..4] of ResultRec;


implementation

{$R *.dfm}

uses Unit2, Unit3;

VAR
  Msgs : TStringList;
  strDS: String;
  strSunLow : String;
  strAl, strAz : string;

PROCEDURE ClearErr;
BEGIN
  if SinceErr = 0 then
    SinceErr := 1
  else
    Form1.lblMsg.Caption := '';
END;

FUNCTION degToRad(angleDeg : double) : double;
BEGIN
		result := Pi * angleDeg / 180.0;
END;


FUNCTION calcGeomMeanAnomalySun(t: double) : double;
BEGIN
	result := 357.52911 + t * (35999.05029 - 0.0001537 * t);
END;

FUNCTION calcMeanObliquityOfEcliptic(t : double): double;
VAR
  seconds : double;
BEGIN
		seconds := 21.448 - t*(46.8150 + t*(0.00059 - t*(0.001813)));
		result := 23.0 + (26.0 + (seconds/60.0))/60.0;
END;


FUNCTION calcObliquityCorrection(t:double) : double;
VAR
  e0, omega : double;
BEGIN
		e0 := calcMeanObliquityOfEcliptic(t);
		omega := 125.04 - 1934.136 * t;
		result := e0 + 0.00256 * cos(degToRad(omega));
END;

FUNCTION calcGeomMeanLongSun(t:double) : double;
VAR
  Lo  : double;
BEGIN
		Lo := 280.46646 + t * (36000.76983 + 0.0003032 * t);
		while(Lo > 360.0) do
			Lo := Lo - 360.0;
		while (Lo < 0.0) do
			Lo := Lo + 360.0;
		result := Lo;		// in degrees
END;

FUNCTION calcSunEqOfCenter(t : double) : double;
VAR
  m, mrad ,sinm,
  sin2m, sin3m  : real;
BEGIN
	 m := calcGeomMeanAnomalySun(t);

	 mrad := degToRad(m);
	 sinm := sin(mrad);
	 sin2m := sin(mrad+mrad);
   sin3m := sin(mrad+mrad+mrad);

	 result := sinm * (1.914602 - t * (0.004817 + 0.000014 * t))
                + sin2m * (0.019993 - 0.000101 * t) + sin3m * 0.000289;
END;

FUNCTION calcSunTrueLong(t : double) : double;
VAR
  Lo, c : double;
BEGIN
	Lo := calcGeomMeanLongSun(t);
	c := calcSunEqOfCenter(t);

	result := Lo + c;
END;

FUNCTION calcSunApparentLong(t : double) : double;
VAR
  o, omega : double;
BEGIN
	o := calcSunTrueLong(t);
  omega := 125.04 - 1934.136 * t;
	result := o - 0.00569 - 0.00478 * sin(degToRad(omega));
END;

FUNCTION calcSunDeclination(t : double) : double;
VAR
  e,
  lambda,
  sint  : double;
BEGIN
	e := calcObliquityCorrection(t);
	lambda := calcSunApparentLong(t);

	sint := sin(degToRad(e)) * sin(degToRad(lambda));
	result := radToDeg(arcsin(sint));
END;

function calcEccentricityEarthOrbit(t: double): double;
BEGIN
	result := 0.016708634 - t * (0.000042037 + 0.0000001267 * t);
END;


FUNCTION CalcEquationOfTime(t: double) : double;
VAR
  epsilon,sinm,
  cos2Lo,
  Lo,
  e,
  m,
  y,
  sin2Lo,
  sin4Lo,
  sin2m,
  Etime : double;

BEGIN
  epsilon := calcObliquityCorrection(t);
  Lo := calcGeomMeanLongSun(t);
  e := calcEccentricityEarthOrbit(t);
  m := calcGeomMeanAnomalySun(t);

  y := tan(degToRad(epsilon)/2.0);
  y := y * y;

  sin2Lo := sin(2.0 * degToRad(Lo));
  sinm := sin(degToRad(m));
  cos2Lo := cos(2.0 * degToRad(Lo));
  sin4Lo := sin(4.0 * degToRad(Lo));
  sin2m  := sin(2.0 * degToRad(m));

  Etime := y * sin2Lo - 2.0 * e * sinm + 4.0 * e * y * sinm * cos2Lo
      - 0.5 * y * y * sin4Lo - 1.25 * e * e * sin2m;

  Result :=  radToDeg(Etime)*4.0;	// in minutes of time
END;

FUNCTION RadianAngle (deg, min, sec : integer) : real;
VAR
  MyDeg : real;
BEGIN
  MyDeg := deg + min/60 + sec/3600;
  Result := MyDeg / 180 * Pi;
END;

PROCEDURE DegMinSecAngle (rad : real; var deg, min, sec : integer);
VAR
  r  : real;
BEGIN
  while rad > pi do rad := rad-Pi;
  r := rad * 180 / Pi;
  deg := trunc(r);
  r := (r-deg)*60;
  min := trunc(r);
  sec := round ((r-min)*60);
END;


FUNCTION CheckDegFormat (s : string) : boolean;
VAR
  i, m1, m2, p1, p2 : integer;
BEGIN
  result := true;
  m1 := pos ('-', s, 1);
  if m1 = 1 then begin
    m2 := pos ('-', s, 2);
    if m2 <> 0 then
      result := false;
  end
  else if m1 > 1 then
    result := false;

  p1 := pos ('.', s, 1);
  if s.Length = 0 then
    result := false
  else if p1 = 0 then
    result := true
  else if (p1 = 1) or (p1 = s.Length) then
    result := false
  else if Form1.rbDegMinSec.Checked then begin
    p2 := pos ('.', s, p1+1);
    if (p2 = p1+1) or (p2=s.Length) then result := false;
    if p2 <> 0 then begin
      p1 := pos ('.', s, p2+1);
      if p1 <> 0 then result := false;
    end;
  end
  else begin
    p2 := pos ('.', s, p1+1);
    if p2 <> 0 then
      result := false;
  end;
  for i := 1 to s.Length do
    if not (s[i] in ['0'..'9', '.', '-']) then result := false;
END;


FUNCTION Degrees (s : string) : double;
VAR
  neg : boolean;
  deg, min, sec : double;
  ndx : integer;
BEGIN
  if not CheckDegFormat(s) then begin
    result := 0;
    exit;
  end;

  if Form1.rbDegMinSec.Checked then begin
    neg := (s[1] = '-');
    if neg then
      delete (s, 1, 1);
    ndx := pos ('.', s, 1);
    if ndx = 0 then
      result := s.toDouble
    else begin
      deg := (s.substring (0, ndx-1)).toDouble;
      min := 0;
      sec := 0;
      delete (s, 1, ndx);
      ndx := pos ('.', s, 1);
      if ndx = 0 then
        min := s.ToDouble
      else begin
        min := (s.substring (0, ndx-1)).toDouble;
        delete (s, 1, ndx);
        sec := s.ToDouble;
      end;
      result := deg + min/60 + sec/3600;
    end;
    if neg then
      result := -result;
  end
  else
    result := s.toDouble;
END;

FUNCTION getLatitude : double;
BEGIN
    result := Degrees(Form1.edLatitude.text);
END;

FUNCTION getLongitude : double;
BEGIN
    result := Degrees(Form1.edLongitude.text);
END;

FUNCTION getTimeAdj : double;
VAR
  s : string;
  Z : TStringDynArray;
BEGIN
  s := Form1.edZone.Text;
  if s.Length = 0 then begin
    result := 0;
    exit;
  end;
  Delete(s, 1, 3);
  Z := SplitString (s, ':');
  result := StrToInt(Z[0]);
  if result < 0 then
    result := result - StrToInt(Z[1])/60
  else
    result := result + StrToInt(Z[1])/60 ;
END;

PROCEDURE CalcSun (shaddate : tDateTime; shadtime: tDateTime; dltsv : boolean;
                   var altitude : double; var azimuth : double);
VAR
  latitude,
  longitude,
  jd,
  T,
  ZoneAdj,
  eqTime,
  solarTimeFix,
  trueSolarTime,
  hourangle,
  haRad,
  csz,
  zenith,
  solarDec,
  azDenom,
  azRad,
  exoatmElevation,
  te, refractionCorrection,
  solarZen   : double;
  Z : TStringDynArray;
BEGIN
   latitude := getLatitude;
   longitude := getLongitude;
   ZoneAdj := getTimeAdj;
   if dltsv then ZoneAdj := ZoneAdj + 1;

   jd := DateTimeToJulianDate (shaddate + shadtime);

   T := (jd - ZoneAdj/24 - 2451545.0)/36525.0;

   eqTime := calcEquationOfTime(T);
   solarDec := calcSunDeclination(T);

   solarTimeFix := eqTime + 4.0 * longitude
    - 60.0 * ZoneAdj;
   trueSolarTime := shadtime * 1440 + solarTimeFix;
   while trueSolarTime > 1440 do
    trueSolarTime := TrueSolarTime - 1440;
   hourAngle := trueSolarTime / 4.0 - 180.0;
	 if (hourAngle < -180) then
		 hourAngle := hourAngle + 360.0;

   haRad := degToRad(hourAngle);

   csz := sin(degToRad(latitude)) *
      sin(degToRad(solarDec)) +
      cos(degToRad(latitude)) *
      cos(degToRad(solarDec)) * cos(haRad);
    if (csz > 1.0) then
      csz := 1.0
    else if (csz < -1.0) then
      csz := -1.0;

   zenith := radToDeg(arccos(csz));

   azDenom := cos(degToRad(latitude)) * sin(degToRad(zenith));
	if (abs(azDenom) > 0.001) then
  begin
    azRad := ((sin(degToRad(latitude)) * cos(degToRad(zenith)) )
                - sin(degToRad(solarDec))) / azDenom;
    if (abs(azRad) > 1.0) then
    begin
      if (azRad < 0) then
        azRad := -1.0
      else
        azRad := 1.0;
    end;

    azimuth := 180.0 - radToDeg(arccos(azRad));

    if (hourAngle > 0.0) then
      azimuth := -azimuth;
  end
  else
  begin
    if (latitude > 0.0) then
      azimuth := 180.0
    else
      azimuth := 0.0;
  end;
  if (azimuth < 0.0) then
    azimuth := azimuth + 360.0;


  exoatmElevation := 90.0 - zenith;
	if (exoatmElevation > 85.0) then
		refractionCorrection := 0.0
	else begin
		te := tan (degToRad(exoatmElevation));
		if (exoatmElevation > 5.0) then
			refractionCorrection := 58.1 / te - 0.07 / (te*te*te)
				              + 0.000086 / (te*te*te*te*te)
		else if (exoatmElevation > -0.575) then
			refractionCorrection := 1735.0 + exoatmElevation *
							(-518.2 + exoatmElevation * (103.4 +
							exoatmElevation * (-12.79 +
							exoatmElevation * 0.711) ) )
		else
			refractionCorrection := -20.774 / te;

		refractionCorrection := refractionCorrection / 3600.0;
	end;

	solarZen := zenith - refractionCorrection;

  altitude := 90 - solarZen;
END;





procedure TForm1.edDateChange(Sender: TObject);
var
  ndx, i : integer;
begin
  ndx := strtoint ((TDateTimePicker(Sender)).Name[7]);
  Dates[ndx].cbDltSav.enabled := Dates[ndx].edDate.checked;
  for i := 1 to 4 do begin
    Results[ndx, i].Altitude := 0;
    Results[ndx, i].lblResult.Caption := '';
  end;
end;

procedure TForm1.edTimeChange(Sender: TObject);
var
  ndx, i : integer;
begin
  ndx := strtoint ((TDateTimePicker(Sender)).Name[7]);
  for i := 1 to 4 do begin
    Results[i, ndx].Altitude := 0;
    Results[i, ndx].lblResult.Caption := '';
  end;
end;

function DegtoStr (deg : double) : string; //var str : string);
var
  d, m, s : integer;
begin
  d := Trunc(deg);
  deg := Abs(deg - d) * 60;
  m := Trunc(deg);
  deg := (deg - m) * 60;
  s := Round(deg);
  result := inttostr(d) + '° ' + inttostr(m) + ''' ' + inttostr(s) + '"';
end;


PROCEDURE CheckTimeZone (s : string; hilite : boolean);
BEGIN
  if s = '' then begin
    Form1.lblMsg.Caption := Msgs[88]; //Time Zone must be selected';
    Form1.lblMsg.Font.Color := clRed;
    if hilite then
      Form1.edZone.Color := clRed;
    sinceErr := 0;
  end;
END;


procedure CheckLongitude (s : string; allowblank : boolean);
VAR
  l : double;
begin
  if s.Length = 0 then begin
    if allowblank then exit
    else begin
      Form1.lblMsg.Caption := Msgs[89]; //'Longitude must be entered';
      Form1.lblMsg.Font.Color := clRed;
      Form1.edLongitude.color := clRed;
      sinceErr := 0;
    end;
  end;
   if CheckDegFormat (s) then begin
    l := getLongitude;
    if (l > 180) or (l < -180) then begin
      Form1.lblMsg.Caption := Msgs[90]; //'Max longitude allowed is 180';
      Form1.lblMsg.Font.Color := clRed;
      Form1.edLongitude.color := clRed;
      sinceErr := 0;
    end
    else
      Form1.edLongitude.color := clWindow;
  end
  else begin
    Form1.lblMsg.Caption := Msgs[91]; //'Invalid format for longitude';
    Form1.lblMsg.Font.Color := clRed;
    Form1.edLongitude.color := clRed;
    sinceErr := 0;
  end;
end;


procedure CheckLatitude (s : string; allowblank : boolean);
VAR
  l : double;
begin
  if s.Length = 0 then begin
    if allowblank then exit
    else begin
      Form1.lblMsg.Caption := Msgs[92]; //'Latitude must be entered';
      Form1.lblMsg.Font.Color := clRed;
      Form1.edLatitude.color := clRed;
      sinceErr := 0;
    end;
  end;
  if CheckDegFormat (s) then begin
    l := getLatitude;
    if (l > 89) or (l < -89) then begin
      Form1.lblMsg.Caption := Msgs[93]; //'Max latitude allowed is 89';
      Form1.lblMsg.Font.Color := clRed;
      Form1.edLatitude.color := clRed;
      sinceErr := 0;
    end
    else
      Form1.edLatitude.color := clWindow;
  end
  else begin
    Form1.lblMsg.Caption := Msgs[94]; //'Invalid format for latitude';
    Form1.lblMsg.Font.Color := clRed;
    Form1.edLatitude.color := clRed;
    sinceErr := 0;
  end;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  form3.showmodal;
end;

procedure TForm1.btnCalcClick(Sender: TObject);
var
  i, j : integer;
begin
  lblMsg.Caption := '';
  CheckTimeZone (edZone.Text, true);
  CheckLongitude (edLongitude.text, false);
  CheckLatitude (edLatitude.text, false);
  if lblMsg.Caption <> '' then exit;
  for i := 1 to 4 do
    for j := 1 to 4 do begin
      if Dates[i].edDate.Checked then begin
        if Times[j].Checked then begin
          CalcSun (DateOf(Dates[i].edDate.Date),
                   TimeOf (Times[j].Time),
                   Dates[i].cbDltSav.Checked,
                   Results[i, j].Altitude,
                   Results[i, j].Azimuth);
          if Results[i, j].Altitude < 1 then begin
            Results[i, j].lblResult.Caption := strSunLow;
            Results[i, j].lblResult.Cursor := crDefault;
            Results[i, j].Altitude := 0;
          end
          else begin
            Results[i, j].lblResult.Caption :=
                strAl + DegtoStr(Results[i, j].Altitude) + SLineBreak +
                strAz + DegtoStr(Results[i, j].Azimuth);
            Results[i, j].lblResult.Cursor := crHandPoint;
          end;
        end;
      end;
    end;
end;

procedure TForm1.edZoneExit(Sender: TObject);
begin
  CheckTimeZone (Form1.edZone.Text, false);
end;


procedure TForm1.edLatitudeExit(Sender: TObject);
begin
  CheckLatitude (TEdit(Sender).Text, true);
end;


procedure TForm1.edLongitudeExit(Sender: TObject);
begin
  CheckLongitude (TEdit(Sender).Text, true);
end;

procedure TForm1.edPlaceExit(Sender: TObject);
VAR
  W : TStringDynArray;
  s, s1 : string;
  l : integer;
begin
  s := edPlace.Text;
  if (s.Length > 0) then begin
    W := SplitString (s, ' ');
    l := length(W);
    if l=0 then exit;
    if l = 1 then begin
      s := W[0];
      if s.Length > 11 then
        s := s.Substring(0, 11);
    end
    else begin
      s := W[l-1];
      s1 := W[l-2];
      if (s.StartsWith('(') and (s.Length < 6)) or (s.Length < 4) then begin
        if s1.length > 10-s.Length then
          s1 := s1.Substring(0, 10-s.Length);
        s := s1 + ' ' + s;
      end
      else begin
        if s.StartsWith('(') and not s1.startsWith('(') then s := s1;
        if s.Length > 11 then
          s := s.Substring(0, 11);
      end;
    end;
    edAbrev.Text := s;
  end;
end;

procedure TForm1.edEnter(Sender: TObject);
begin
  (TEdit(Sender)).Color := clWindow;
  ClearErr;
end;

procedure TForm1.NumberKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', '.', '-', char(vk_back), #$16, #$19, #$1A]) then
  begin
    Key := #0;
    Beep;
  end;
end;

procedure TForm1.PlaceAbrevChange(Sender: TObject);
begin
  if String(TEdit(Sender).Text).StartsWith(' ') then
    TEdit(Sender).Color := clRed
  else
    if TEdit(Sender).Text = '' then
      TEdit(Sender).Color := clRed
    else
      TEdit(Sender).Color := clWindow;
end;

procedure TForm1.PlaceAbrevKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['|', '\', '<', '>', '*', '?', '/', ':', '"'] then begin
    Key := #0;
    Beep;
  end;
end;

procedure TForm1.FormatChange(Sender: TObject);
begin
  ClearErr;
  CheckLatitude (TEdit(Form1.edLatitude).text, true);
  CheckLongitude (TEdit(Form1.edLongitude).text, true);
  ClearErr;
end;


procedure SaveSettings;
var
  s : string;
  Ini	: TIniFIle;
  i : integer;
begin
 	Ini := TIniFile.Create (ExtractFilePath(Application.ExeName) + 'shadow.ini');
	try
    for i := 1 to 4 do begin
      s := 'Date' + inttostr(i);
      Ini.WriteDate('Calculator', s, Dates[i].edDate.DateTime);
      s := s + 'Used';
      Ini.WriteBool('Calculator', s, Dates[i].edDate.Checked);
      s := 'Date' + inttostr(i) + 'DltSav';
      Ini.WriteBool('Calculator', s, Dates[i].cbDltSav.Checked);
      s := 'Time' + inttostr(i);
      Ini.WriteTime('Calculator', s, Times[i].DateTime);
    end;
    Ini.WriteString('Calculator', 'Latitude', Form1.edLatitude.Text);
    Ini.WriteString ('Calculator', 'Longitude', Form1.edLongitude.Text);
    Ini.WriteInteger ('Calculator', 'ZoneNdx', Form1.edZone.ItemIndex);
    Ini.WriteBool('Calculator', 'DecimalDegrees', Form1.rbDecDeg.Checked);
    Ini.WriteString ('Calculator', 'Place', Form1.edPlace.Text);
    Ini.WriteString ('Calculator', 'Place Abrev', Form1.edAbrev.Text);
	finally
		Ini.Free;
	end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j : integer;
	Ini	: TIniFIle;
  str : string;
begin
  strDS := 'Daylight Saving';
  strSunLow := 'sun too low';
  try
    Msgs := TStringList.Create;
    str := ExtractFilePath(Application.ExeName) + 'ShadLite.msg';
    Msgs.LoadFromFile(str);
    strDS := Msgs[84];
  //  Msgs.Free;
  except
    lblMsg.Caption := 'Error loading message file';
  end;

  sinceErr := 2;
  for i := 1 to 4 do begin
		Dates[i].edDate := TDateTimePicker.create(self);
		Dates[i].edDate.Parent := Form1;
		Dates[i].edDate.left := 29 + i*110;
		Dates[i].edDate.top := 190;
		Dates[i].edDate.TabOrder := 10 + 2*1;
		Dates[i].edDate.TabStop := true;
		Dates[i].edDate.height := 21;
		Dates[i].edDate.width := 94;
		Dates[i].edDate.kind := dtkDate;
		Dates[i].edDate.name := 'edDate' + inttostr(i);
		Dates[i].edDate.ShowCheckBox := true;
		Dates[i].edDate.Checked := (i=1);
		Dates[i].edDate.OnEnter := edEnter;
    Dates[i].edDate.OnChange := edDateChange;

    Dates[i].cbDltSav := TCheckbox.create(self);
    Dates[i].cbDltSav.Parent := Form1;
    Dates[i].cbDltSav.left := 33 + i*110;
    Dates[i].cbDltSav.top := Dates[i].edDate.top + 23;
    Dates[i].cbDltSav.TabOrder := 11 + 2*i;
    Dates[i].cbDltSav.TabStop := true;
    Dates[i].cbDltSav.height := 17;
    Dates[i].cbDltSav.width := 103;
    Dates[i].cbDltSav.Caption := strDS;
    Dates[i].cbDltSav.Enabled := Dates[i].edDate.Checked;
    Dates[i].cbDltSav.name := 'cbDltSav' + inttostr(i);
    Dates[i].cbDltSav.OnEnter := edEnter;

		Times[i] := TDateTimePicker.create(self);
		Times[i].Parent := Form1;
		Times[i].left := 25;
		Times[i].top := Dates[i].edDate.top + 9 + i*43;
		Times[i].height := 17;
		Times[i].width := 100;
		Times[i].TabOrder := 19+i;
		Times[i].TabStop := true;
		Times[i].ShowCheckBox := true;
		Times[i].Checked := (i=1);
		Times[i].Kind := dtkTime;
		Times[i].name := 'edTime' + inttostr(i);
		Times[i].OnEnter := edEnter;
    Times[i].OnChange := edTimeChange;
 	end;
  for i:= 1 to 4 do
    for j := 1 to 4 do begin
      Results[i, j].lblResult := TLabel.Create(self);
      Results[i, j].lblResult.Parent := Form1;
      Results[i, j].lblResult.Left := 33 + i*110;
      Results[i, j].lblResult.top := Times[j].top - 4;
      Results[i, j].lblResult.height := 30;
      Results[i, j].lblResult.width := 90;
      Results[i, j].lblResult.Name := 'lblResult' + inttostr(i) + inttostr(j);
      Results[i, j].lblResult.Caption := '';
      Results[i, j].Altitude := 0;
      Results[i, j].lblResult.OnDblClick := SunPosDblClick;
      Results[i, j].lblResult.OnClick := SunPosClick;
    end;

 	Ini := TIniFile.Create (ExtractFilePath(Application.ExeName) + 'shadow.ini');
	try
		Dates[1].edDate.DateTime := Ini.ReadDate ('Calculator', 'Date1', EncodeDate(2017,3,20));
		Dates[2].edDate.DateTime := Ini.ReadDate ('Calculator', 'Date2', EncodeDate(2017,6,21));
		Dates[3].edDate.DateTime := Ini.ReadDate ('Calculator', 'Date3', EncodeDate(2017,9,22));
		Dates[4].edDate.DateTime := Ini.ReadDate ('Calculator', 'Date4', EncodeDate(2017,12,21));
		Dates[1].edDate.Checked := Ini.ReadBool ('Calculator', 'Date1Used', true);
		Dates[2].edDate.Checked := Ini.ReadBool ('Calculator', 'Date2Used', false);
		Dates[3].edDate.Checked := Ini.ReadBool ('Calculator', 'Date3Used', false);
		Dates[4].edDate.Checked := Ini.ReadBool ('Calculator', 'Date4Used', false);
		Dates[1].cbDltSav.Checked := Ini.ReadBool ('Calculator', 'Date1DltSav', false);
		Dates[2].cbDltSav.Checked := Ini.ReadBool ('Calculator', 'Date2DltSav', false);
		Dates[3].cbDltSav.Checked := Ini.ReadBool ('Calculator', 'Date3DltSav', false);
		Dates[4].cbDltSav.Checked := Ini.ReadBool ('Calculator', 'Date4DltSav', false);
    Times[1].DateTime := Ini.ReadTime ('Calculator', 'Time1', EncodeTime(9,0,0,0));
    Times[2].DateTime := Ini.ReadTime ('Calculator', 'Time2', EncodeTime(12,0,0,0));
    Times[3].DateTime := Ini.ReadTime ('Calculator', 'Time3', EncodeTime(15,0,0,0));
    Times[4].DateTime := Ini.ReadTime ('Calculator', 'Time4', EncodeTime(18,0,0,0));
    edLatitude.Text := Ini.ReadString ('Calculator', 'Latitude', '-33.720748');
    edLongitude.Text := Ini.ReadString ('Calculator', 'Longitude', '149.848140');
    edZone.ItemIndex := Ini.ReadInteger ('Calculator', 'ZoneNdx', 6);
    rbDecDeg.Checked := Ini.ReadBool('Calculator', 'DecimalDegees', true);
    rbDegMinSec.Checked := not rbDecDeg.Checked;
    edPlace.Text := Ini.ReadString ('Calculator', 'Place', 'Lake Oberon NSW');
    edAbrev.Text := Ini.ReadString ('Calculator', 'Place Abrev', 'Oberon');
	finally
		Ini.Free;
	end;
  for i := 1 to 4 do
    Dates[i].cbDltSav.Enabled := Dates[i].edDate.Checked;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Msgs.Free;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  lblMsg.Caption := '';
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lblMsg.Caption := '';
end;

procedure TForm1.FormShow(Sender: TObject);
var
  str : string;
begin
  strDS := 'Daylight Saving';
  strSunLow := 'sun too low';
//  try
 //   Msgs := TStringList.Create;
 //   str := ExtractFilePath(Application.ExeName) + 'ShadLite.msg';
 //   Msgs.LoadFromFile(str);
    Form1.Caption := Msgs[68];
    lblLatitude.Caption := Msgs[69];
    lblLatNote.Caption := Msgs[70];
    lblLongitude.Caption := Msgs[71];
    lblLongNote.Caption := Msgs[72];
    rgFormat.Caption := Msgs[73];
    rbDegMinSec.Caption := Msgs[74];
    rbDecDeg.Caption := Msgs[75];
    lblTimeZone.Caption := Msgs[76];
    lblPlaceName.Caption := Msgs[77];
    lblAbrev.Caption := Msgs[78];
    btnCalc.Caption := Msgs[79];
    btnExit.Caption := Msgs[80];
    btnExp.Caption := Msgs[82];
    Help1.Caption := Msgs[81];
    ShadowInstructionManual1.Caption := Msgs[63];
    About1.Caption := Msgs[83];
    strDS := Msgs[84];
    strSunLow := Msgs[85];
    strAl := Msgs[86];
    strAz := Msgs[87];
 //   Msgs.Free;
//  except
 //   lblMsg.Caption := 'Error loading message file';
//  end;
end;


function SunPosMsg (DateNdx, TimeNdx : integer) : string;
var
  h, m, s, ms : word;
  str : string;
begin
  DateTimeToString (result, 'mmmd', Dates[DateNdx].edDate.Date);
  result := result + ' ';
  DecodeTime (Times[TimeNdx].Time, h, m, s, ms);
  if m = 0 then begin
    if h = 12 then
      result := result + 'noon'
    else if h > 12 then
      result := result + intToStr (h-12) + 'pm'
    else
      result := result + intToStr (h) + 'am';
  end
  else begin
    DateTimeToString (str, 'h.nna/p', Times[TimeNdx].Time);
    result := result + str;
  end;
  result := result + ' ' + Form1.edAbrev.text;
end;

function SunPosLongMsg (DateNdx, TimeNdx : integer) : string;
begin
  result := DateTimeToStr (Dates[DateNdx].edDate.Date + Times[TimeNdx].Time)
              + ' ' + Form1.edPlace.Text + ' (Al:'
              + DegtoStr (Results[DateNdx, TimeNdx].Altitude) + ', Az:'
              + DegtoStr (Results[DateNdx, TimeNdx].Azimuth) + ')';

end;

function SaveAllResults : boolean;
var
  i, j : integer;
  s : string;
  f : textfile;

  filename : string;
begin
  result := false;
  for i := 1 to 4 do
    if Dates[i].edDate.Checked then for j := 1 to 4 do begin
      if Times[j].Checked and (Results[i,j].Altitude > 0) then begin
        s := SunPosMsg (i, j);
        filename := ExtractFilePath(Application.ExeName) + 'shad\';
        if not DirectoryExists (filename) then
          if not CreateDir (filename) then begin
            Form1.lblMsg.Caption := Msgs[95]; //'Error creating Shad directory';
            Form1.lblMsg.Font.Color := clRed;
          end;
        filename := filename + s + '.sun';
        AssignFile (f, filename);
        rewrite (f);
        WriteLn (f, s);
        WriteLn (f, SunPosLongMsg (i, j));
        WriteLn (f, FloatToStr (degtorad(Results[i, j].azimuth)));
        WriteLn (f, FloatToStr (degtorad(Results[i, j].altitude)));
        CloseFile (f);
        result := true;
      end;
    end;
end;

procedure TForm1.btnExitClick(Sender: TObject);
begin
    SaveSettings;
  Application.Terminate;
end;

procedure TForm1.btnExpClick(Sender: TObject);
var
  Ini : TIniFile;
begin
  if length(Trim (edAbrev.Text)) = 0 then begin
    lblMsg.Caption := Msgs[96]; //'Must Enter Place Abbreviation';
    lblMsg.Font.Color := clRed;
  end
  else if SaveAllResults then begin
    SaveSettings;
    Ini := TIniFile.Create (ExtractFilePath(Application.ExeName) + 'shadow.ini');
    try
      Ini.WriteString('General', 'Filter', '*' + Form1.edAbrev.Text);
      lblMsg.Caption := Msgs[97]; //'Added to Saved Sun Positions && filter set';
      lblMsg.font.Color := clBlue;
    finally
      Ini.Free;
    end;
    SaveSettings;
    Application.Terminate;
  end
  else begin
    lblMsg.Caption := Msgs[98]; //'Nothing to Export';
    lblMsg.Font.Color := clRed;
  end;

end;

procedure SaveResultToIni (dateNdx, timeNdx : integer);
var
  Ini : TIniFile;
begin
 	Ini := TIniFile.Create (ExtractFilePath(Application.ExeName) + 'shadow.ini');
	try
    Ini.WriteFloat('General', 'Shad_Azimuth', degToRad(results[dateNdx, timeNdx].Azimuth));
    Ini.WriteFloat('General', 'ShadAltitude', degToRad(Results[dateNdx, timeNdx].Altitude));
    Ini.WriteString('General', 'ShadSunPosMg', SunPosMsg(DateNdx, TimeNdx));
	finally
		Ini.Free;
	end;
end;

procedure TForm1.SunPosDblClick(Sender: TObject);
var
  dateNdx,
  timeNdx : integer;
  s : string;
begin
  SaveSettings;
  s := (TLabel(Sender)).Name;
  dateNdx := strtoint(s[s.Length-1]);
  timeNdx := strtoint(s[s.Length]);
 	SaveResultToIni (dateNdx, timeNdx);
  Application.Terminate;
end;

procedure TForm1.ShadowInstructionManual1Click(Sender: TObject);
var
  helpfilename : PWideChar;
begin
  helpfilename := PWideChar(ExtractFilePath(Application.ExeName) + 'ShadowInstructions.pdf');
  ShellExecute(Handle, 'open', helpfilename,nil,nil,SW_SHOWNORMAL) ;
end;

procedure TForm1.SunPosClick(Sender: TObject);
var
  dateNdx,
  timeNdx : integer;
  s : string;
begin
  SaveSettings;
  s := (TLabel(Sender)).Name;
  dateNdx := strtoint(s[s.Length-1]);
  timeNdx := strtoint(s[s.Length]);
 	SaveResultToIni (dateNdx, timeNdx);
  lblMsg.Font.Color := clBlue;
  lblMsg.Caption := Msgs[99]; //'Altitude && Azimuth transferred to DataCAD';
end;

procedure TForm1.NumKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', char(vk_back)]) then begin
    Key := #0;
    Beep;
  end;
end;

end.
