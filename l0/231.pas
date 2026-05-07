PROGRAM Less(INPUT, OUTPUT);
VAR
  Ch: CHAR;
BEGIN
  READ(Ch);
  WRITE('Вывод без пробелов, до решётки: ');
  WHILE Ch <> '#'
  DO
    BEGIN
      IF Ch <> ' '
      THEN
        WRITE(Ch);
      READ(Ch)
    END;
  WRITELN
END.
