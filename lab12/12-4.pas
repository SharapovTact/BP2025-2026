PROGRAM DeleteSpace(INPUT, OUTPUT);
VAR
  Ch, State: CHAR;
BEGIN
  State := 'S';
  
  WHILE NOT EOLN
  DO
    BEGIN    
      READ(Ch);
      IF (State = ' ') AND (Ch <> ' ')
      THEN
        BEGIN
          WRITE(' ', Ch);
          State := 'M'
        END
      ELSE
        IF (State = 'M') AND (Ch = ' ')
        THEN
          BEGIN
            State := ' '
          END
        ELSE
          IF (State = 'M') AND (Ch <> ' ')
          THEN
            WRITE(Ch);
      
      IF (State = 'S') AND (Ch <> ' ')
      THEN
        BEGIN
          WRITE(Ch);
          State := 'M'
        END
    END;
  WRITELN('#')
END.
