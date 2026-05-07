PROGRAM BubbleSort(INPUT, OUTPUT);
VAR
  Sorted: CHAR;
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
PROCEDURE CopyAndSwap(VAR Buf1, Buf2: TEXT; VAR Sorted1: CHAR);
VAR
  Ch1, Ch2: CHAR;
BEGIN
  IF NOT EOLN(Buf1)
  THEN
    BEGIN
      READ(Buf1, Ch1);
      WHILE NOT EOLN(Buf1)
      DO 
        BEGIN
          READ(Buf1, Ch2);
          IF (Ch1 <= Ch2)
          THEN
            BEGIN
              WRITE(Buf2, Ch1);
              Ch1 := Ch2
            END
          ELSE
            BEGIN
              WRITE(Buf2, Ch2);
              Sorted1 := 'N'
            END
        END;
      WRITELN(Buf2, Ch1) 
    END
END;

BEGIN {BubbleSort}
  REWRITE(F1);
  CopyFile(INPUT, F1);
    
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      Sorted := 'Y';
      RESET(F1);
      REWRITE(F2);
      CopyAndSwap(F1, F2, Sorted);
      RESET(F2);
      REWRITE(F1);
      CopyFile(F2, F1)
    END;
    
  RESET(F1);
  CopyFile(F1, OUTPUT)
END. {BubbleSort}


