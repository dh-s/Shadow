PROCEDURE SaveInt (name : string;  value : integer; toini : boolean);		EXTERNAL;

FUNCTION GetSvdInt (name : string; default : integer) : integer;		EXTERNAL;

PROCEDURE InitSettings (iniName : string);		EXTERNAL;

PROCEDURE SaveAng (name : string;  value : real; toini : boolean);		EXTERNAL;

FUNCTION GetSvdAng (name : string; default : real) : real;		EXTERNAL;

PROCEDURE SaveRl (name : string;  value : real; toini : boolean);		EXTERNAL;

FUNCTION GetSvdRl (name : string; default : real) : real;		EXTERNAL;

PROCEDURE SaveBln (name : string;  value : boolean; toini : boolean);		EXTERNAL;

FUNCTION GetSvdBln (name : string; default : boolean) : boolean;		EXTERNAL;

PROCEDURE SaveStr (name : string;  value : string; toini : boolean);		EXTERNAL;

PROCEDURE GetSvdStr (name : string; default : string; result : OUT str80 );		EXTERNAL;
