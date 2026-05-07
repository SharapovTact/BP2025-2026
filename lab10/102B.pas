PROGRAM AutoFormat(INPUT, OUTPUT);
VAR
  Ch, State, Busy: CHAR;
BEGIN
  READ(INPUT, Ch);
  State := '0';
  Busy := '0';
  WHILE Ch <> '.'
  DO
    BEGIN
      Busy := '0';
      //Обработка BEGIN
      IF (State = '0') AND ((Ch = 'B') OR (Ch = 'E') OR (Ch = 'G') OR (Ch = 'I') OR (Ch = 'N')) 
      THEN
        BEGIN
          WRITE(Ch);
          IF Ch = 'N'
          THEN
            BEGIN
              State := '1'
            END
        END
      ELSE
        //Обработки следующей строки
        //State: 1(Строка после BEGIN)
        //State: 2(Начало строки)
        //State: 3(Описывает название инструкции)
        //State: 4(Начало скобки)
        //State: 5(Формальное окончание строки)
        //State: 6(Окончание файла)
        BEGIN
          IF (State = '2') AND (Ch = ';') AND (Busy = '0')
          THEN
            BEGIN
              WRITE(Ch);
              Busy := '1'
            END
          ELSE
            BEGIN 
              //Обработка ';' после состояния '1'
              IF (State = '1') AND (Ch = ';') AND (Busy = '0')
              THEN
                BEGIN
                  Busy := '1';
                  WRITELN;
                  WRITE('  ', Ch);
                  State := '3'
                END;
              //Обработка новой строки, состояние '1'
              IF (State = '1') AND (Ch = 'E') AND (Busy = '0')
              THEN
                BEGIN
                  Busy := '1';
                  State := '6'
                END;
              IF (State = '1') AND (Ch <> ';') AND (Ch <> ' ') AND (Busy = '0')
              THEN
                BEGIN
                  WRITELN;
                  Busy := '1';
                  WRITE('  ', Ch);
                  State := '3'
                END;  
              //Обработка новой строки, состояние '2'
              IF (State = '2') AND (Ch <> ' ') AND (Busy = '0')
              THEN
                BEGIN
                  WRITELN;
                  Busy := '1';
                  WRITE('  ', Ch);
                  State := '3' 
                END;
              //Обработка имени инструкции
              IF (State = '3') AND (Ch <> '(') AND(Ch <> ' ') AND (Ch <> ';') AND (Busy = '0')
              THEN
                BEGIN
                  WRITE(Ch);
                  Busy := '1'
                END;
              //Обработка конца инструкции без скобок c ';'
              IF (State = '3') AND (Ch = ';') AND (Busy = '0')
              THEN  
                BEGIN
                  Busy := '1';
                  WRITE(Ch);
                  State := '2'
                END;
              //Обработка конца инструкции в конце программы
              IF (State = '3') AND (Ch = ' ') AND (Busy = '0')
              THEN
                BEGIN
                  Busy := '1';
                  State := '6'
                END;
              //Обработка начала скобки  
              IF (State = '3') AND (Ch = '(') AND (Busy = '0')
              THEN
                BEGIN
                  WRITE(Ch);
                  Busy := '1';
                  State := '4'
                END;
              //Обработка тела скобки
              IF (State = '4') AND (Ch <> ' ') AND (Ch <> ')') AND (Busy = '0')
              THEN 
                BEGIN
                  Busy := '1';
                  IF (Ch = ',')
                  THEN
                    WRITE(Ch, ' ')
                  ELSE
                    WRITE(Ch)
                END;
              //Обработка окончания скобки  
              IF (State = '4') AND (Ch = ')') AND (Busy = '0')
              THEN 
                BEGIN
                  Busy := '1';
                  State := '5';
                  WRITE(Ch)
                END; 
              //Обработка конца строки со скобками
              IF (State = '5') AND (Ch = ' ') AND (Busy = '0') 
              THEN
                BEGIN
                  Busy := '1';
                  State := '6'
                END;
              IF (State = '5') AND (Ch = ';') AND (Busy = '0')
              THEN
                BEGIN
                  Busy := '1';
                  WRITE(Ch);
                  State := '2'
                END;
              //Обработка конца программы  
              IF (State = '6') AND (Busy = '0')
              THEN
                BEGIN
                  Busy := '1';
                  State := '.';
                  WRITELN;
                  WRITE('END.')
                END
            END
        END;
      READ(INPUT, Ch)  
    END
END.
