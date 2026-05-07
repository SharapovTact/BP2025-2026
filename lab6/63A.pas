PROGRAM SelectSort(INPUT, OUTPUT); 
{Сортирует символы, предшествующие #, из INPUT в OUTPUT. 
 Программа выдаст ошибку, если в INPUT отсутствует #} 
VAR 
  Ch: CHAR; 
  F1: TEXT; 
BEGIN {SelectSort}  
  REWRITE(F1);{Копировать INPUT в F1 и эхо в OUTPUT} 
  READ(INPUT, Ch); 
  WRITE(OUTPUT, 'SAVED DATA IN F1: '); 
  WHILE Ch <> '#'
  DO 
    BEGIN 
      WRITE(F1, Ch); 
      WRITE(OUTPUT, Ch); 
      READ(INPUT, Ch) 
    END;
  WRITE(F1, Ch);
  WRITELN                           
  {Сортировать F1 в OUTPUT, используя стратегию SelectSort} 
END. {SelectSort}
