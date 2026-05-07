PROGRAM AutoFormat(INPUT, OUTPUT);
VAR
  Ch, State, Busy, CommentEnter, W1, W2, W3: CHAR;
BEGIN
  IF NOT(EOLN(INPUT))
  THEN
    BEGIN
      READ(INPUT, Ch)
    END;
  State := '1';
  Busy := '0';
  CommentEnter := '0';
  W1 := '&';
  W2 := '&';
  W3 := '&';
  WHILE (State <> '.')
  DO
    BEGIN
      { CommentEnter - 0(Комментарий не был записан на строке) }
      { CommentEnter - 1(Комментарий уже был записан на строке) }
      { State - 0(Конец файла) }
      { State - 1(Начало файла) }
      { State - 2(Начало первой строки) }
      { State - 3(Начало инструкции) }
      { State - 4(Продолжение названия инструкции) }
      { State - 5(После инструкции ' ', проверка на ';' или END) }
      { State - 6(Начало скобки) }  
      { State - 7(Начало строки) }
      { State - 8(Проверка на '') }
      { State - 9(Начало оператора присваивания) }
      { State - A(Внутри комментария перед BEGIN) }
      { State - B(Внутри комментария после END.) }
      { State - C(Символы после начала E) }
      { State - D(Комментарии после .) }
      { State - E(Тело комментария после .) }
      { State - F(Тело комментария после BEGIN) }
      { State - G(Обработка END!) }
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
      { Комментарий первой строкой }
      IF ((State = '2') AND (Ch = '{') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(' ', Ch);
          State := 'F'
        END;
        
      { Тело комментария после BEGIN }
      IF ((State = 'F') AND (Ch <> '}') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch);
        END;
      { Конец комментария после BEGIN }
      IF ((State = 'F') AND (Ch = '}') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '3';
          WRITE(Ch);
          CommentEnter := '1'
        END;  
      { ; после комментария }
      IF ((CommentEnter = '1') AND (State = '3') AND (Ch = ';'))
      THEN
        BEGIN
          WRITELN;
          WRITE('  ');
          CommentEnter := '0'
        END;
      { Проверка на ''END }
      IF ((State = '9') AND (Ch = '''') AND (Busy = '0'))
      THEN
        BEGIN
          State := 'H';
          Busy := '1';
          WRITE(Ch)
        END;
      IF ((State = 'H') AND (Ch <> '''') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch)
        END;
      IF ((State = 'H') AND (Ch = '''') AND (Busy = '0'))
      THEN
        BEGIN
          State := '5';
          WRITE(Ch);
          Busy := '1'
        END;
      { Комментарий начинается единоразово}
      IF ((State = '3') AND (Ch = '{') AND (CommentEnter = '0') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := 'F';
          WRITE(' ', Ch);
        END;
      { Комментарий начинается после другого }
      IF ((State = '3') AND (Ch = '{') AND (CommentEnter = '1') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := 'F';
          WRITELN;
          WRITE('  ', Ch);
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
          State := 'G'
        END;
      { END после законченой строки }
      IF ((State = '3') AND (Ch = 'E') AND (Busy = '0'))
      THEN
        BEGIN
          State := 'G';
          Busy := '1'
        END;
      { Пустая инструкция }
      IF ((State = '3') AND (Ch = ';') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch)
        END;
      IF ((State = '4') AND (Ch = '{') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(' ', Ch);
          State := 'F'
        END;
      { Начало новой инструкции }
      IF (((State = '3') OR (State = '2')) AND (Ch <> ' ') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '4';
          CommentEnter := '0';
          WRITELN;
          WRITE('  ', Ch)
        END;
      { Тело инструкции }
      IF ((State = '4') AND (Ch <> ';') AND (Ch <> ' ') AND (Ch <> '(') AND (Ch <> ':') AND (Busy = '0'))
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
          State := 'G'
        END;
      { '  :' после инструкции }
      IF ((State = '5') AND (Ch = ':') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '9';
          WRITE(' ', Ch)
        END;
      IF ((State = '5') AND (Ch = '{') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := 'F';
          WRITE(' ', Ch);
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
      IF ((State = '6') AND (Ch <> ',') AND (Ch <> ')') AND (Ch <> ' ') AND (Ch <> '''') AND (Busy = '0'))
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
        
      {10.2+}
      { Начало строки }
      IF ((State = '6') AND (Ch = '''') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '7';
          WRITE(Ch)
        END;
      { Проверка на '' }
      IF ((State = '7') AND (Ch = '''') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '8';
          WRITE(Ch)
        END;
      IF ((State = '8') AND (Ch = '''') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch);
          State := '7'
        END;
      { Проверка на конец литерала }
      IF ((State = '8') AND (Ch <> '''') AND (Ch <> ')') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := '6';
          WRITE(Ch)
        END;
      IF ((State = '8') AND (Ch = ')') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch);
          State := '5'
        END;
      { Продолжение строки }
      IF ((State = '7') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch)
        END;
      { Начало присваивания }
      IF ((State = '4') AND (Ch = ':') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(' ', Ch);
          State := '9'
        END;
      { Найдено '=' }
      IF ((State = '9') AND (Ch = '=') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch, ' ')
        END;
      { Найдена вторая переменная }
      IF ((State = '9') AND (Ch <> '=') AND (Ch <> ' ') AND  (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch);
          State := '4'
        END;
      { Обработка комментариев ДО BEGIN }  
      IF ((State = '1') AND (Ch = '{') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := 'A';
          WRITE(Ch)
        END;
      { Запись комментария }
      IF ((State = 'A') AND (Ch <> '}') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch)
        END;
      { Завершение комментария }
      IF ((State = 'A') AND (Ch = '}') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITELN(Ch);
          State := '1'
        END;
      { Обработка комментария после END. }
      IF ((State = '0') AND (Ch = '{') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          State := 'B';
          WRITELN(Ch)
        END;
      { ИСПОЛЬЗОВАТЬ СОСТ C }
      
      { Обработка E }
      IF (State = 'G')
      THEN
        BEGIN
          IF NOT(EOLN(INPUT))
          THEN
            READ(INPUT, W1);
          IF NOT(EOLN(INPUT))
          THEN
            READ(INPUT, W2);
          IF NOT(EOLN(INPUT))
          THEN
            READ(INPUT, W3);
            
          IF ((W1 = 'N') AND (W2 = 'D') AND ((W3 = ':') OR (W3 = ' ') OR (W3 = '.')))
          THEN
            State := '0'
          ELSE
            BEGIN
              State := '4';
              WRITELN;
              WRITE('  ', Ch)
            END
        END;
        
      { Край условий }
      { Завершение программы }
      IF (State = '0')
      THEN
        BEGIN
          Busy := '1';
          WRITELN;
          WRITE('E');
          State := 'C' 
        END;    
      { Точка }
      IF ((State = 'C') AND (Ch = '.') AND (Busy = '0'))                        
      THEN
        BEGIN
          Busy := '1';
          WRITE('. ');
          State := 'D'
        END;
      IF ((State = 'C') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch)
        END;
      { Начало комментария после '.' }
      IF ((State = 'D') AND (Ch = '{') AND (Busy = '0'))
      THEN
        BEGIN 
          Busy := '1';
          WRITE(Ch);
          State := 'E'
        END;
      { Тело комментария после '.' }
      IF ((State = 'E') AND (Ch <> '}') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITE(Ch)
        END;
      { Конец комментария после '.' }
      IF ((State = 'E') AND (Ch = '}') AND (Busy = '0'))
      THEN
        BEGIN
          Busy := '1';
          WRITELN(Ch);
          State := 'D'
        END;
       
      IF (W1 <> '&')
      THEN
        BEGIN
          Ch := W1;
          W1 := '&'
        END
      ELSE
        IF (W2 <> '&')
        THEN
          BEGIN
            Ch := W2;
            W2 := '&'
          END
        ELSE
          IF (W3 <> '&')
          THEN
            BEGIN
              Ch := W3;
              W3 := '&'
            END
          ELSE
            READ(INPUT, Ch);
     // WRITE(State); // ОТЛАДКА
      IF (EOLN(INPUT) AND (W3 = '&'))
      THEN
        BEGIN
          WRITE(Ch);              
          State := '.'
        END
    END
END.
