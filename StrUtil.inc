FUNCTION BlankString (s : string): boolean;		EXTERNAL;

FUNCTION ValidFileName (s : string; strname : string) : integer; 		EXTERNAL;

FUNCTION StartsWith (target : string; prefix : string; casesensative : boolean) : boolean;	EXTERNAL;

FUNCTION EndsWith (target : string; suffix : string; casesensative : boolean) : boolean;	EXTERNAL;

PROCEDURE AppendDateTimeStamp (Str : IN OUT String; 
															 doDate : boolean; 
															 doTime : boolean;
															 TimeColons : boolean;
															 spacebetween : boolean);	EXTERNAL;
 
PROCEDURE RemoveChars (str : IN OUT string; CharsToRemove : string);	EXTERNAL;

PROCEDURE GetClrName (clr : IN integer; clrname : OUT string);	EXTERNAL;

PROCEDURE SafeStrIns (dest : IN OUT string; source : string; pos : integer);	EXTERNAL;

PROCEDURE SafeStrCat (str1 : IN OUT string; str2 : string);	EXTERNAL;
