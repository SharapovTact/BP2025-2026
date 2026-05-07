PROGRAM SelectSort(INPUT, OUTPUT); 
{Сортирует символы, предшествующие #, из INPUT в OUTPUT. 
 Программа выдаст ошибку, если в INPUT отсутствует #} 
VAR 
  Ch, Min: CHAR; 
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
  WRITELN;                          
  
  WRITE(OUTPUT, 'Min: ');
  RESET(F1);
  READ(F1, Ch);
  WHILE Ch <> '#'
  DO { Ch <> '#' и Ch - первый символ F1}
    BEGIN
      {Выбираем минимальный из F1 и копируем остаток F1 в F2}
      Min := Ch;
      READ(F1, Ch);
      WHILE Ch <> '#' {Search Min of F1}
      DO  
        BEGIN
          IF Ch < Min
          THEN  
            Min := Ch;
          READ(F1, Ch)
        END;
      WRITE(OUTPUT, Min);
    END;  
  WRITELN
END. {SelectSort}
