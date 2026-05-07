PROGRAM Split(INPUT,OUTPUT);
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;

PROCEDURE CopyOut(VAR F1: TEXT);
VAR 
  Ch1: CHAR;
BEGIN
  WHILE NOT EOF(F1)
  DO
    BEGIN
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch1);
          WRITE(OUTPUT, Ch1)
        END;
      READLN(F1);
    END
END;

BEGIN
  REWRITE(Odds);
  REWRITE(Evens);
  Next := 'O';
  WHILE NOT EOF
  DO
    BEGIN
      WHILE NOT EOLN
      DO
        BEGIN
          READ(INPUT, Ch);
          IF (Next = 'O')
          THEN
            BEGIN
              WRITE(Odds, Ch);
              Next := 'E'
            END
          ELSE
            BEGIN
              WRITE(Evens, Ch);
              Next := 'O'
            END
        END;
      READLN;
      WRITELN(Odds);
      WRITELN(Evens)
    END;
  RESET(Odds);
  RESET(Evens);
  CopyOut(Odds);
  CopyOut(Evens);
  WRITELN
END.
