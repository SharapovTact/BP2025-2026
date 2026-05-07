PROGRAM Prime(INPUT, OUTPUT);
CONST
  MaxDigit = 100;
  MinDigit = 2;
VAR
  DigitColl, DelSet: SET OF MinDigit .. MaxDigit;
  SelectedSimple, Counter, Digit: INTEGER;
BEGIN
  DigitColl := [MinDigit .. MaxDigit];
  DelSet := [];
  SelectedSimple := MinDigit;
  Counter := MinDigit;
  WHILE (SelectedSimple < MaxDigit)
  DO
    BEGIN
      IF (Counter * SelectedSimple > MaxDigit)
      THEN
        BEGIN
          DigitColl := DigitColl - DelSet;
          SelectedSimple := SelectedSimple + 1;
          WHILE NOT(SelectedSimple IN DigitColl) AND (SelectedSimple < MaxDigit)
          DO
            BEGIN
              Counter := MinDigit;
              SelectedSimple := SelectedSimple + 1
            END
        END;
      DelSet := DelSet + [Counter * SelectedSimple];
      Counter := Counter + 1
    END;          
    
  Digit := MinDigit;
  WHILE Digit <= MaxDigit
  DO
    BEGIN
      IF (Digit IN DigitColl)
      THEN
        WRITE(Digit, ' '); 
      Digit := Digit + 1
    END;
  WRITELN
END.
