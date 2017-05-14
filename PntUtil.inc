FUNCTION PntsEqual (p1, p2 : point) : boolean;			EXTERNAL;

PROCEDURE SortPnts (pnts : IN OUT pntarr;
										npnts : IN OUT integer;
										elimdupes : boolean);						EXTERNAL;

FUNCTION  PntInPly (pnt : point;
										ply : array of point; 
										npnt : integer) : integer;			EXTERNAL;

PROCEDURE SwapPnts (p1, p2 : IN OUT point);					EXTERNAL;

