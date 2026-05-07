PROGRAM Split(INPUT, OUTPUT);
VAR 
  Ch, Next: CHAR;
  Odds: TEXT;
BEGIN
  Next := 'O';
  REWRITE(Odds);
  READ(INPUT, Ch);
  WHILE (Ch <> '#')
  DO
    BEGIN
      IF Next = 'O'
      THEN
        BEGIN
          WRITE(Odds, Ch);
          Next := 'E'
        END
      ELSE  
        Next := 'O';
      READ(INPUT, Ch)
    END;
  WRITELN(Odds, '#');
  WRITELN(Evens, '#');
  
  RESET(Odds);
  READ(Odds, Ch);
  WHILE (Ch <> '#')
  DO
    BEGIN
      WRITE(OUTPUT, Ch);
      READ(Odds, Ch)
    END
  {Копируем Evens в OUT}
END.
