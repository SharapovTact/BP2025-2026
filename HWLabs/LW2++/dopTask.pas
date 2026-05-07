PROGRAM CounterChar(INPUT, OUTPUT);
VAR
  Ch, Digit1, Digit2, Digit3, Flag, Digit2Is9to0, Digit3Is9to0: CHAR;
BEGIN
  Digit1 := '0';
  Digit2 := '0';
  Digit3 := '0';

  Digit2Is9to0 := 'F';
  Digit3Is9to0 := 'F';

  READ(Ch);
  Flag := 'T';
  WHILE Ch <> '#'
  DO
    BEGIN
      {Проверка на переполненность}
      IF Flag = 'T'
      THEN
        IF Digit1 = '9'
        THEN
	  IF Digit2 = '9'
	  THEN
	    IF Digit3 = '9'
	    THEN
              BEGIN
                WRITELN('Overflow');
                Flag := 'F'
              END;
      {Основное выполнение}
      IF Flag = 'T'
      THEN
        BEGIN
          IF Digit3 = '9'
          THEN
            BEGIN
	      Digit3Is9to0 := 'T';
	      Digit3 := '0';
              IF Digit2 = '9'
	      THEN
	        BEGIN
	          Digit2Is9to0 := 'T';
	          Digit2 := '0';
	          IF Digit1 = '8' THEN Digit1 := '9';
	          IF Digit1 = '7' THEN Digit1 := '8';
	          IF Digit1 = '6' THEN Digit1 := '7';
	          IF Digit1 = '5' THEN Digit1 := '6';
	          IF Digit1 = '4' THEN Digit1 := '5';
	          IF Digit1 = '3' THEN Digit1 := '4';
	          IF Digit1 = '2' THEN Digit1 := '3';
	          IF Digit1 = '1' THEN Digit1 := '2';
	          IF Digit1 = '0' THEN Digit1 := '1'
	        END;
	      IF Digit2 = '8' THEN Digit2 := '9';
	      IF Digit2 = '7' THEN Digit2 := '8';
	      IF Digit2 = '6' THEN Digit2 := '7';
	      IF Digit2 = '5' THEN Digit2 := '6';
	      IF Digit2 = '4' THEN Digit2 := '5';
	      IF Digit2 = '3' THEN Digit2 := '4';
	      IF Digit2 = '2' THEN Digit2 := '3';
	      IF Digit2 = '1' THEN Digit2 := '2';
	      IF Digit2Is9to0 = 'T'
	      THEN
	        Digit2Is9to0 := 'F'
	      ELSE
	        IF Digit2 = '0' THEN Digit2 := '1'
            END;
          IF Digit3 = '8' THEN Digit3 := '9';
          IF Digit3 = '7' THEN Digit3 := '8';
          IF Digit3 = '6' THEN Digit3 := '7';
          IF Digit3 = '5' THEN Digit3 := '6';
          IF Digit3 = '4' THEN Digit3 := '5';
          IF Digit3 = '3' THEN Digit3 := '4';
      	  IF Digit3 = '2' THEN Digit3 := '3';
      	  IF Digit3 = '1' THEN Digit3 := '2';
          IF Digit3Is9to0 = 'T'
          THEN
            Digit3Is9to0 := 'F'
          ELSE
            IF Digit3 = '0' THEN Digit3 := '1';

      END;
      READ(Ch)
    END;
  IF Flag = 'T'
  THEN
    WRITELN('Number of char is: ', Digit1, Digit2, Digit3)
END.
