PROGRAM DigitLab(INPUT, OUTPUT);
VAR
  SumNum, CountOfNum, MinNum, MaxNum: INTEGER;

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

PROCEDURE UpdateStat(VAR Number, CountOfNum, MinNum, MaxNum, SumNum: INTEGER);
BEGIN {UpdateStat}
  IF Number = -2
  THEN
    CountOfNum := -2;
  
  IF CountOfNum >= 0
  THEN
    IF CountOfNum = MAXINT
    THEN
      CountOfNum := -1
    ELSE
      CountOfNum := CountOfNum + 1;
  
  IF Number < MinNum
  THEN
    MinNum := Number;
  IF Number > MaxNum
  THEN
    MaxNum := Number;
    
  IF (SumNum <> -1)
  THEN
    IF (MAXINT - Number < SumNum)
    THEN
      SumNum := -1
    ELSE
      SumNum := Number + SumNum
END; {UpdateStat}

PROCEDURE StrStat(VAR F: TEXT; VAR CountOfNum, MinNum, MaxNum, SumNum: INTEGER);
VAR
  Number: INTEGER;
BEGIN {StrStat}
  WHILE NOT EOLN
  DO
    BEGIN
      ReadNumber(INPUT, Number);
      IF (Number >= 0)
      THEN
        UpdateStat(Number, CountOfNum, MinNum, MaxNum, SumNum)
    END
END; {StrStat}

PROCEDURE PrintStat(CountOfNum, MinNum, MaxNum, SumNum: INTEGER);
VAR
  Remain: INTEGER;
BEGIN {PrintStat}
  IF (CountOfNum <> 0)
  THEN
    BEGIN
      IF (CountOfNum = -2) THEN
        WRITELN('Overflow')
      ELSE IF (CountOfNum = -1) THEN
        WRITELN('CountOfNum is overflow')
      ELSE IF (SumNum = -1) THEN
        BEGIN
          WRITELN('Sum is overflow');
          WRITELN('Min: ', MinNum);
          WRITELN('Max: ', MaxNum)
        END   
      ELSE 
        BEGIN
          WRITELN('Count of Nums: ', CountOfNum);
          WRITELN('Min: ', MinNum);
          WRITELN('Max: ', MaxNum);
          WRITE('Average value: ', SumNum DIV CountOfNum);
          IF (SumNum MOD CountOfNum) <= (MAXINT DIV 100) 
          THEN
            Remain := (SumNum MOD CountOfNum) * 100 DIV CountOfNum
          ELSE
            WRITELN('Remain is overflow');
          IF Remain <> 0
          THEN
            WRITE('.', Remain);
          WRITELN
        END                                                                    
    END
  ELSE
    WRITELN('Numbers not found')
END; {PrintStat}

PROCEDURE Init(VAR CountOfNum, MinNum, MaxNum, SumNum: INTEGER);
BEGIN {Init}
  CountOfNum := 0;
  MinNum := MAXINT;
  MaxNum := 0;
  SumNum := 0
END; {Init}

BEGIN
  Init(CountOfNum, MinNum, MaxNum, SumNum);
  StrStat(INPUT, CountOfNum, MinNum, MaxNum, SumNum);
  PrintStat(CountOfNum, MinNum, MaxNum, SumNum)
END.
