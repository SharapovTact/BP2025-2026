PROGRAM DigitLab(INPUT, OUTPUT);
VAR
  Digit, Sum: INTEGER;

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

BEGIN
  Sum := 0;
  WHILE (NOT EOLN) AND (Digit <> -1)                                                                                                                  
  DO
    BEGIN
      ReadDigit(INPUT, Digit);
      IF (Digit <> -1) AND (Sum < MAXINT - Digit)
      THEN
        Sum := Sum + Digit
    END;
  WRITELN(Sum)
END.
