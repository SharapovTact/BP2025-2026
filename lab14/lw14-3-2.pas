PROGRAM MergeTest(INPUT, OUTPUT);
VAR
  F1, F2: TEXT;
PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN {CopyFile}
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  WRITELN(OutFile)                                                             
END; {CopyFile}

PROCEDURE Merge(VAR Fm1, Fm2, Fm3: TEXT);
VAR
  Ch2, Ch3: CHAR;
  
PROCEDURE CopyMerge(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN {CopyMerge}
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END                                                           
END; {CopyMerge}

BEGIN {Merge}
  RESET(Fm2);
  RESET(Fm3);
  REWRITE(Fm1);
  IF NOT EOLN(Fm2)
  THEN
    READ(Fm2, Ch2);
  IF NOT EOLN(Fm3)
  THEN 
    READ(Fm3, Ch3);
  
  WHILE (NOT EOF(Fm2)) AND (NOT EOF(Fm3))
  DO
    BEGIN
	  IF Ch2 < Ch3
	  THEN
	    BEGIN
	      WRITE(Fm1, Ch2);
		  IF NOT EOLN(Fm2)
		  THEN
		    READ(Fm2, Ch2)
		  ELSE
		    READLN(Fm2)
		END
	  ELSE
	    BEGIN
		  WRITE(Fm1, Ch3);
		  IF NOT EOLN(Fm3)
		  THEN
		    READ(Fm3, Ch3)
		  ELSE
		    READLN(Fm3)
		END
	END;         
  IF NOT EOF(Fm2)
  THEN      
    BEGIN
      IF EOLN(Fm2)
      THEN
        WRITE(Fm1, Ch2)
      ELSE
        BEGIN
          WRITE(Fm1, Ch2);
          CopyMerge(Fm2, Fm1) 
        END
    END;
  IF NOT EOF(Fm3)
  THEN 
    BEGIN
      IF EOLN(Fm3)
      THEN
        WRITE(Fm1, Ch3)
      ELSE
        BEGIN
          WRITE(Fm1, Ch3);
          CopyMerge(Fm3, Fm1) 
        END
    END; 
  WRITELN(Fm1);
  RESET(Fm1)
END; {Merge}

BEGIN
  REWRITE(F1);
  REWRITE(F2);
  CopyFile(INPUT, F1);
  READLN;
  IF NOT EOLN
  THEN
    CopyFile(INPUT, F2);
  Merge(OUTPUT, F1, F2)
END.
