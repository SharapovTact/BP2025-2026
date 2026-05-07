PROGRAM CopyInp(INPUT, OUTPUT);
PROCEDURE RCopy(VAR InFile: TEXT);
VAR 
  Ch: CHAR;
BEGIN {Reverse}
  IF NOT EOLN(InFile)
  THEN
    BEGIN
      READ(InFile, Ch);
      WRITE(OUTPUT, Ch);
      RCopy(InFile)
    END
  ELSE
    WRITELN
END; {Reverse}

BEGIN
  RCopy(INPUT)
END.
