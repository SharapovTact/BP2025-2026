PROGRAM SortMonth(INPUT, OUTPUT);
USES
  DateIO;
VAR
  M1, M2: Month;
PROCEDURE DateSort(VAR M1, M2: Month; VAR FOut: TEXT);
BEGIN {DateSort}
  IF (M1 = NoMonth) OR (M2 = NoMonth)
  THEN
    WRITELN(FOut, 'Неверные данные!')
  ELSE
    BEGIN
      IF M1 = M2
      THEN
        WRITELN('Оба месяца ');
      WriteMonth(FOut, M1);
      IF M1 <> M2
      THEN
        BEGIN
          IF M1 < M2
          THEN
            WRITE(FOut, ' предшествует ')
          ELSE
            WRITE(FOut, ' следует за ');
          WriteMonth(FOut, M2)
        END;
        WRITELN(FOut)
    END
END; {DateSort}
  
BEGIN
  ReadMonth(INPUT, M1);
  ReadMonth(INPUT, M2);
  DateSort(M1, M2, OUTPUT)
END.
