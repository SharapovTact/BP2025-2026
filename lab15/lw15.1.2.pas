PROGRAM Counter(INPUT, OUTPUT);
USES 
  Count3;
VAR
  V100, V10, V1, Ch, Ovr, Prev, PrevPrev: CHAR;
BEGIN
  WRITE('INPUT: ');
  IF NOT EOLN
  THEN
    READ(PrevPrev);
  IF NOT EOLN
  THEN
    READ(Prev);
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      IF (((Prev < PrevPrev) AND (Prev < Ch)) OR ((Prev > PrevPrev) AND (Prev > Ch)))
      THEN
        Bump;
      PrevPrev := Prev;
      Prev := Ch

    END;
  WRITELN;
  Value(V100, V10, V1, Ovr);
  WRITE('Reverses: ');
  IF (Ovr = 'T')
  THEN
    WRITELN('More than 999')
  ELSE
    WRITELN(V100, V10, V1)
END.
