UNIT Count3;

INTERFACE

PROCEDURE Start; {Обнуляет счётчик}
PROCEDURE Bump; {Увеличивает счётчик на единицу}
PROCEDURE Value(VAR V100, V10, V1, Ovr: CHAR); {Возвращает значение счётчика}

IMPLEMENTATION
VAR 
  Ones, Tens, Hundreds, Overflow: CHAR;
PROCEDURE Start;
{Обнуляет счётчик}
BEGIN{Start}
  Ones := '0';
  Tens := '0';
  Hundreds := '0';
  Overflow := 'F'
END;{Start}

PROCEDURE Bump;
{Увеличивает 3-цифровой счетчик определенный   Ones, Tens, Hundreds
     на единицу, если он находится в диапaзоне от 0 до 999 }
PROCEDURE NextDigit(VAR Digit: CHAR);
  BEGIN {NextDigit}
    IF Digit = '0' THEN Digit := '1' ELSE
    IF Digit = '1' THEN Digit := '2' ELSE
    IF Digit = '2' THEN Digit := '3' ELSE
    IF Digit = '3' THEN Digit := '4' ELSE
    IF Digit = '4' THEN Digit := '5' ELSE
    IF Digit = '5' THEN Digit := '6' ELSE
    IF Digit = '6' THEN Digit := '7' ELSE
    IF Digit = '7' THEN Digit := '8' ELSE
    IF Digit = '8' THEN Digit := '9' ELSE
    IF Digit = '9' THEN Digit := '0'
  END;{NextDigit}
BEGIN {Bump}
  NextDigit(Ones);
  IF  Ones = '0'
  THEN
    BEGIN
      NextDigit(Tens);
      IF Tens = '0'
      THEN
        BEGIN
          NextDigit(Hundreds);
          IF Hundreds = '0'
          THEN
            BEGIN
              Ones := '9';
              Tens := '9';
              Hundreds := '9';
              Overflow := 'T'
            END
        END
    END
END; {Bump}

PROCEDURE Value(VAR V100, V10, V1, Ovr: CHAR);
{Передаёт значения счётчика переменным V100, V10, V1}
BEGIN {Value}
  V100 := Hundreds;
  V10 := Tens;
  V1 := Ones;
  Ovr := Overflow
END; {Value}

BEGIN {Инициализация данных модуля}
  Start
END.


