PROGRAM BubbleSortMLA(INPUT, OUTPUT);
VAR
  Ch: CHAR;
  F1: TEXT;
BEGIN
  REWRITE(F1);
  WHILE NOT EOF
  DO
    BEGIN
      IF NOT EOLN
      THEN
        BEGIN
          READ(Ch);
          WRITE(F1, Ch)
        END
      ELSE
        READLN(INPUT)
    END;
    {Отладочный вывод F1}
    RESET(F1);
    WHILE NOT EOLN(F1)
    DO
      BEGIN
        READ(F1, Ch);
        WRITE(Ch)
      END
END.
