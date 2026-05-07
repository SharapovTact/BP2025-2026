PROGRAM Repair(INPUT, OUTPUT);
VAR
  File1, File2: TEXT;
  Res: CHAR;

PROCEDURE Lexico(VAR F1, F2: TEXT; VAR Result: CHAR);
VAR
  Ch1, Ch2, VC, LC: CHAR;
BEGIN {Lexico}
  Result := '0';
  VC := '0';
  LC := '0';
  WHILE NOT EOLN(F1) AND NOT EOLN(F2) 
  DO
    BEGIN
      READ(F1, Ch1);
      READ(F2, Ch2);
      IF VC = '0'
      THEN
        IF (Ch1 < Ch2)
        THEN
          VC := '1';
        IF (Ch2 < Ch1)
        THEN
          VC := '2'
    END;
  IF (EOLN(F1) AND NOT EOLN(F2))
  THEN
    LC := '1'
  ELSE 
    IF (NOT EOLN(F1) AND EOLN(F2))
    THEN
      LC := '2';
  IF (LC = '0')
  THEN
    Result := VC
  ELSE
    Result := LC  
END; {Lexico}

PROCEDURE CopyFileLine(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN {CopyFile}
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  WRITELN(OutFile)
END; {CopyFile}

BEGIN
  REWRITE(File1);
  REWRITE(File2);
  CopyFileLine(INPUT, File1);
  READLN(INPUT);     
  CopyFileLine(INPUT, File2);
  
  RESET(File1);
  RESET(File2);
  Lexico(File1, File2, Res);
  IF (Res = '0')
  THEN
    WRITELN('Files are equal')
  ELSE 
    IF (Res = '1')
    THEN
      WRITELN('First file is smaller')
    ELSE
      WRITELN('Second file is smaller')  
END.
