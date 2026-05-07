PROGRAM SplitTest(INPUT, OUTPUT);
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

BEGIN
  REWRITE(F1);
  REWRITE(F2);
  Split(INPUT, F1, F2);
  RESET(F1);
  CopyFile(F1, OUTPUT);
  RESET(F2);
  CopyFile(F2, OUTPUT)
END.
