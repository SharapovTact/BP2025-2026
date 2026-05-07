PROGRAM AutoFormat(INPUT, OUTPUT);
VAR
  Ch, State, Busy: CHAR;
BEGIN
  READ(INPUT, Ch);
  State := '1';
  Busy := '0';
  WHILE Ch <> '.'
  DO
    BEGIN
      { State - 0(Конец файла) }
      { State - 1(Начало файла) }
      { State - 2(Начало первой строки) }
      { State - 3(Начало инструкции) }
      { State - 4(Продолжение названия инструкции) }
      { State - 5(После инструкции ' ', проверка на ';' или END) }
      { State - 6(Начало скобки) }  
      Busy := '0';
      { BEGIN }
      IF ((State = '1') AND ((Ch = 'B') OR (Ch = 'E') OR (Ch = 'G') OR (Ch = 'I') OR (Ch = 'N')))
      THEN
        BEGIN
          WRITE(Ch);
          IF (Ch = 'N')
          THEN
            BEGIN
              State := '2';
              Busy := '1'
            END
        END;
      { Первая строка это ';' }
      IF ((State = '2') AND (Ch = ';') AND (Busy = '0'))
      THEN
        BEGIN
          WRITELN;
          Busy := '1';
          State := '3';
          WRITE('  ', Ch)
        END;
      { Первая строка это END. }
      IF ((State = '2') AND (Ch = 'E') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '0'
        END;
      { Завершение программы }
      IF ((State = '0') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '.';
          WRITELN;
          WRITE('END.')
        END;
      { END после законченой строки }
      IF ((State = '3') AND (Ch = 'E') AND (Busy = '0'))
      THEN
        BEGIN
          State := '0';
          Busy := '1'
        END;
      { Пустая инструкция }
      IF ((State = '3') AND (Ch = ';') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch)
        END;
      { Начало новой инструкции }
      IF (((State = '3') OR (State = '2')) AND (Ch <> ' ') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '4';
          WRITELN;
          WRITE('  ', Ch)
        END;
      { Тело инструкции }
      IF ((State = '4') AND (Ch <> ';') AND (Ch <> ' ') AND (Ch <> '(') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch)
        END;
      { ';' в упор к инструкции }
      IF ((State = '4') AND (Ch = ';') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '3';
          WRITE(Ch)
        END;
      { ' ' после тела инструкции }
      IF ((State = '4') AND (Ch = ' ') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '5'
        END;
      { '    (' после инструкции }
      IF ((State = '5') AND (Ch = '(') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '6';
          WRITE(Ch)
        END;
      { '    ;' после инструкции }
      IF ((State = '5') AND (Ch = ';') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '3';
          WRITE(Ch)
        END;
      { '   END.' после инструкции }
      IF ((State = '5') AND (Ch = 'E') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '0'
        END;
      { Начало скобки }
      IF ((State = '4') AND (Ch = '(') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '6';
          WRITE(Ch)
        END;
      { Тело скобки }
      IF ((State = '6') AND (Ch <> ',') AND (Ch <> ')') AND (Ch <> ' ') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch)
        END;
      { Запятая }
      IF ((State = '6') AND (Ch = ',') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch, ' ')
        END;
      { Закрывается скобка }
      IF ((State = '6') AND (Ch = ')') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch);
          State := '5'
        END;
      {Край условий}
      READ(INPUT, Ch);
      IF EOLN(INPUT)
      THEN
        Ch := '.'
    END
END.
