FUNCTION DisplayFileError (res : integer; desc : string) : boolean;			EXTERNAL;

PROCEDURE DisplayVerboseMsg (msgnum : integer; param : string);		EXTERNAL;

PROCEDURE InitLog (MacroName : string);		EXTERNAL;

PROCEDURE OpenLog;		EXTERNAL;

PROCEDURE LogStr (str : string); 	EXTERNAL;

PROCEDURE LogStrDis (str : string; dis : real); 	EXTERNAL;

PROCEDURE LogStrAng (str : string; ang : real); 	EXTERNAL;

PROCEDURE LogStrInt (str : string; i : integer); 	EXTERNAL;

PROCEDURE CloseLog; 	EXTERNAL;


