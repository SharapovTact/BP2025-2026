PROGRAM Sort(INPUT, OUTPUT);
VAR
  F: TEXT;
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

PROCEDURE RecursiveSort(VAR F1: TEXT);
VAR
  F2, F3: TEXT;
  Ch, OnlyOneCharacter: CHAR;
                                                            
PROCEDURE CheckOneCharacter(VAR CheckingFile: TEXT; VAR Flag: CHAR);
VAR
  CheckingCh: CHAR;
BEGIN {CheckOneCharacter}
  Flag := 'F';                         
  IF NOT EOLN(CheckingFile)
  THEN
    BEGIN
      READ(CheckingFile, CheckingCh);
      IF EOLN(CheckingFile)
      THEN
        Flag := 'T'
    END             
END; {CheckOneCharacter}

PROCEDURE Split(VAR InFile, Evens, Odds: TEXT);
VAR
  Next, WrCh: CHAR;
BEGIN {Split}
  Next := 'O';
  WHILE NOT EOF(InFile)
  DO
    BEGIN
      WHILE NOT EOLN(InFile)
      DO
        BEGIN
          READ(InFile, WrCh);
          IF (Next = 'O')
          THEN
            BEGIN
              WRITE(Odds, WrCh);
              Next := 'E'
            END
          ELSE
            BEGIN
              WRITE(Evens, WrCh);
              Next := 'O'
            END
        END;
      READLN(InFile);
      WRITELN(Odds);
      WRITELN(Evens)
    END
END; {Split}

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

PROCEDURE Merge(VAR Fm1, Fm2, Fm3: TEXT);                            
VAR
  Ch2, Ch3: CHAR;
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

BEGIN {RecursiveSort};
  RESET(F1);
  CheckOneCharacter(F1, OnlyOneCharacter); 
  RESET(F1);
  IF (NOT EOLN(F1)) AND (OnlyOneCharacter = 'F')
  THEN
    BEGIN
	  REWRITE(F2);
      REWRITE(F3);
      Split(F1, F2, F3);
      RecursiveSort(F2);
      RecursiveSort(F3);
      Merge(F1, F2, F3)
    END                            
END; {RecursiveSort}

BEGIN     
  REWRITE(F);
  CopyFile(INPUT, F);
  RecursiveSort(F);     
  RESET(F);
  CopyFile(F, OUTPUT)
END.
