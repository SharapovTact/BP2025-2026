PROGRAM IsDigit(INPUT, OUTPUT);
VAR
  Ch: CHAR;
BEGIN
  READ(Ch);
  IF '0' <= Ch
  THEN
    IF Ch <= '9'
    THEN
      WRITELN(Ch, ' is digit')
    ELSE
      WRITELN(Ch, ' is not digit')
  ELSE
    WRITELN(Ch, 'is not digit')
END.
