PROGRAM BubbleSortMLA(INPUT, OUTPUT);
VAR
  Ch, Ch1, Ch2, EndLine: CHAR;
  F1, F2: TEXT;
BEGIN
  EndLine := 'F';
  REWRITE(F1);
  WHILE NOT EOF
  DO
    BEGIN
      IF NOT EOLN
      THEN
        BEGIN
          READ(Ch);
          WRITE(Ch)
        END
      ELSE
        BEGIN
          READLN(Ch);
          WRITE(Ch)
        END
    END
END.
