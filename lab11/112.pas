PROGRAM WithoutLast(INPUT, OUTPUT);
VAR
  Ch1: CHAR;
BEGIN
  IF NOT EOLN
  THEN
    BEGIN
      READ(Ch1);
      WHILE NOT EOLN
      DO
        BEGIN
          WRITE(Ch1);
          READ(Ch1)
        END
    END;
  WRITELN
END.
