PROGRAM Split(INPUT,OUTPUT);
PROCEDURE CopyOut(VAR F1: TEXT);
VAR 
  Ch: CHAR;
BEGIN
  WHILE NOT EOF(F1)
  DO
    BEGIN
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch);
          WRITE(OUTPUT, Ch)
        END;
      READLN(F1);
      WRITELN
    END
END;

BEGIN
  CopyOut(INPUT);
  WRITELN
END.
