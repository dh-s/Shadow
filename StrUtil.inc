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



