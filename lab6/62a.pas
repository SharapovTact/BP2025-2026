PROGRAM Split(INPUT, OUTPUT);
VAR 
  Ch, Next: CHAR;
BEGIN
  Next := 'O';
  READ(INPUT, Ch);
  WHILE (Ch <> '#')
  DO
    BEGIN
      WRITE(OUTPUT, Next);{Отладочный оператор}
      IF Next = 'O'
      THEN
        Next := 'E';
      ELSE
        Next := 'O';
      READ(INPUT, Ch)
    END;
  WRITELN(OUTPUT)
  {Копируем Odds в OUT}
  {Копируем Evens в OUT}
END.
