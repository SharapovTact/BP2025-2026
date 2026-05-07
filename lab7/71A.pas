PROGRAM BubbleSort(INPUT, OUTPUT);
{Сортируем первую строку INPUT в OUTPUT}
VAR
  Sorted, Ch, Ch1, Ch2: CHAR;
  F1, F2: TEXT;
BEGIN {BubbleSort}
  REWRITE(F1);
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      WRITE(F1, Ch)
    END;

  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      Sorted := 'Y' {Отладочный оператор}
      { Копируем F1 в F2,проверяя отсортированность
       и переставляя первые соседние символы по порядку}
      { Копируем F2 в F1 }
    END;
    
  RESET(F1);
  WHILE NOT EOLN(F1){Отладочный оператор}
  DO
    BEGIN
      READ(F1, Ch);
      WRITE(Ch)
    END;
  WRITELN
END. {BubbleSort}

