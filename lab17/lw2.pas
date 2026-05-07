PROGRAM DigitLab(INPUT, OUTPUT);
VAR
  Number: INTEGER;

PROCEDURE CharToInt(VAR CharSymb: CHAR; VAR DigitalSymb: INTEGER);
BEGIN {CharToInt}
  IF CharSymb = '0' THEN DigitalSymb := 0 ELSE
  IF CharSymb = '9' THEN DigitalSymb := 9 ELSE
  IF CharSymb = '8' THEN DigitalSymb := 8 ELSE
  IF CharSymb = '7' THEN DigitalSymb := 7 ELSE
  IF CharSymb = '6' THEN DigitalSymb := 6 ELSE
  IF CharSymb = '5' THEN DigitalSymb := 5 ELSE
  IF CharSymb = '4' THEN DigitalSymb := 4 ELSE
  IF CharSymb = '3' THEN DigitalSymb := 3 ELSE
  IF CharSymb = '2' THEN DigitalSymb := 2 ELSE
  IF CharSymb = '1' THEN DigitalSymb := 1
END; {CharToInt}
  
PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
VAR
  Symbol: CHAR;
BEGIN {ReadDigit}
  D := -1;
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Symbol);
      CharToInt(Symbol, D)
    END
END; {ReadDigit}

PROCEDURE ReadNumber(VAR F: TEXT; VAR Number: INTEGER);
VAR
  Digit: INTEGER;
BEGIN {ReadNumber}
  Number := -1;
  ReadDigit(F, Digit);
  WHILE (Digit <> -1) AND (Number <> -2)
  DO
    BEGIN
      IF (Number > ((MAXINT - Digit) DIV 10)) AND (Number > 10)
      THEN
        Number := -2
      ELSE
        BEGIN
          IF (Number = -1)
          THEN
            Number := Digit
          ELSE
            Number := Number * 10 + Digit
        END;
      ReadDigit(F, Digit)
    END
END; {ReadNumber}

BEGIN
  ReadNumber(INPUT, Number);
  WRITELN(MAXINT);
  WRITELN(Number)
END.
