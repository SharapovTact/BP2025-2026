PROGRAM SelectSort(INPUT, OUTPUT); 
{Сортирует символы, предшествующие #, из INPUT в OUTPUT. 
 Программа выдаст ошибку, если в INPUT отсутствует #} 
VAR 
  Ch, Min: CHAR; 
  F1, F2: TEXT; 
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
  
  WRITE(OUTPUT, 'SORTED: ');
  RESET(F1);
  READ(F1, Ch);
  WHILE Ch <> '#'
  DO { Ch <> '#' и Ch - первый символ F1}
    BEGIN
      REWRITE(F2);
      {Выбираем минимальный из F1 и копируем остаток F1 в F2}
      Min := Ch;
      READ(F1, Ch);
      WHILE Ch <> '#' {Search Min of F1}   
      DO  
        BEGIN    
          IF (Ch < Min)
          THEN
            BEGIN
              WRITE(F2, Min);  
              Min := Ch;
              WRITE(F2, Min)
            END
          ELSE
            WRITE(F2, Ch);
          READ(F1, Ch);
        END;         
      WRITELN(F2, '#');
      WRITE(OUTPUT, Min);
                            
      RESET(F2);
      REWRITE(F1);
      READ(F2, Ch);
      WHILE Ch <> '#'
      DO
        BEGIN
          WRITE(F1, Ch);
          READ(F2, Ch)
        END;
      WRITELN(F1, '#');
      RESET(F1);
      READ(F1, Ch)
      
    END;  
  WRITELN(OUTPUT)
END. {SelectSort}
