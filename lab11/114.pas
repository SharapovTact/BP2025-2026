PROGRAM Reverse(INPUT, OUTPUT);
VAR
  Ch: CHAR;
  F1, F2: TEXT;
BEGIN
  REWRITE(F1);
  REWRITE(F2);
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(INPUT, Ch);
      WRITE(F1, Ch)
    END;
  RESET(F1);
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      WHILE NOT EOLN(F1) { Запись F1 в F2, без посл. симв. }
      DO
        BEGIN
          READ(F1, Ch);
          IF EOLN(F1)
          THEN
            WRITE(OUTPUT, Ch)
          ELSE 
            WRITE(F2, Ch)
        END; 
      RESET(F2);
      REWRITE(F1);
      WHILE NOT EOLN(F2) { Запись F2 в F1 }
      DO
        BEGIN
          READ(F2, Ch);
          WRITE(F1, Ch)
        END; 
      RESET(F1);
      REWRITE(F2)
    END;          
  WRITELN   
END.
