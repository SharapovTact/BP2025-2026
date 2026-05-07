PROGRAM RevInp(INPUT, OUTPUT);
PROCEDURE Reverse(VAR InFile: TEXT; Flag: CHAR);
VAR 
  Ch: CHAR;
BEGIN {Reverse}
  IF NOT EOLN(InFile)
  THEN
    BEGIN
      READ(InFile, Ch);
      Reverse(InFile, 'F');
      WRITE(OUTPUT, Ch);
      IF Flag = 'T'
      THEN
        WRITELN
    END
END; {Reverse}

BEGIN
  Reverse(INPUT, 'T')
END.
