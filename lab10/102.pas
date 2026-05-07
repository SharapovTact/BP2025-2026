PROGRAM AutoFormat(INPUT, OUTPUT);
VAR
  Ch, State: CHAR;
BEGIN
  READ(INPUT, Ch);
  State := '0';
  WHILE Ch <> '.'
  DO
    BEGIN
      //Обработка BEGIN
      IF (State = '0') AND ((Ch = 'B') OR (Ch = 'E') OR (Ch = 'G') OR (Ch = 'I') OR (Ch = 'N')) 
      THEN
        BEGIN
          WRITE(Ch);
          IF Ch = 'N'
          THEN
            BEGIN
              State := '2'
            END
        END
      ELSE
        //Обработки следующей строки
        //State: 1(Строка после BEGIN)
        //State: 2(Строка сразу после BEGIN, два пробела)
        //State: 3(Строка только началась, нужно для обработки пустого оператора)
        //State: 4(Строка продолжается)
        //State: 5(Внутри скобки)
        BEGIN
          //Обработка строки после BEGIN
          {IF State = '1'
          THEN
            BEGIN
              WRITELN;
              State := '2'
            END; }
          //Обработка пустого оператора
          IF (Ch = ';') AND (State = '2')
          THEN
            BEGIN
              WRITELN;
              WRITE('  ', Ch);
              READ(INPUT, Ch);
              State := '3'
            END
          ELSE
            IF (State = '2')
            THEN
              State := '3';
          IF (Ch = ';') AND (State = '3')
          THEN
            BEGIN
              WHILE Ch = ';'
              DO
                BEGIN
                  WRITE(Ch);
                  READ(INPUT, Ch)
                END
            END
          ELSE
          //Обработка названия инструкции
            IF (State = '3') AND (Ch <> ' ')
            THEN
              BEGIN
                WRITELN;
                WRITE('  ', Ch);
                State := '4'
              END 
            ELSE 
              IF (State = '4') AND (Ch <> '(') AND (Ch <> ' ')
              THEN 
                WRITE(Ch)
              ELSE
              //Обработка скобки
                BEGIN
                  IF (State = '4') AND (Ch = '(')
                  THEN
                    BEGIN
                      State := '5';
                      WRITE(Ch)
                    END;
                  IF (State = '5') AND (Ch <> ' ') AND (Ch <> ',') AND (Ch <> '(') AND (Ch <> ')')
                  THEN
                    WRITE(Ch);
                  IF (State = '5') AND (Ch = ',')
                  THEN
                    WRITE(Ch, ' ');
                  IF (State = '5') AND (Ch = ')')
                  THEN
                    BEGIN
                      State := '3';
                      WRITE(Ch)
                    END
                END  
                  
        END;
      READ(INPUT, Ch);
    END
END.
