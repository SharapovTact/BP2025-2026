PROGRAM Counter(INPUT, OUTPUT);
USES Count3;
VAR
  V100, V10, V1, Ch, Ovr: CHAR;
BEGIN
  Start;
  WHILE(NOT EOLN(INPUT))
  DO
    BEGIN
      READ(INPUT, Ch);
      Bump;
    END;
  Value(V100, V10, V1, Ovr);
  IF (Ovr = 'T')
  THEN
    WRITELN('Overflow');
  WRITELN(V100, V10, V1)
END.
