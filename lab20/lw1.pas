PROGRAM Graphic(INPUT, OUTPUT);
CONST
  Size = 5;
  FillSymbol = '#';
  SpaceSymbol = ' ';
TYPE 
  MatrixType = SET OF 1 .. Size * Size;
VAR
  Matrix: MatrixType;
  Ch: CHAR;

FUNCTION ReadLetter(VAR FI: TEXT; VAR Ch: CHAR): BOOLEAN;
BEGIN
  IF EOLN(FI) OR EOF(FI)
  THEN
    ReadLetter := FALSE
  ELSE
    BEGIN
      READ(FI, Ch);
      ReadLetter := TRUE
    END
END;

PROCEDURE PrintMatrix(VAR FO: TEXT; Matrix: MatrixType);
VAR
  I, J: INTEGER;
BEGIN
  FOR I := 1 TO Size
  DO
    BEGIN
      FOR J := 1 TO Size
      DO
        BEGIN
          IF (((I * Size) - (Size - J)) IN Matrix)
          THEN
            WRITE(FillSymbol)
          ELSE
            WRITE(SpaceSymbol)
        END;
      WRITELN
    END
END;

FUNCTION GetMatrix(Ch: CHAR): MatrixType;
BEGIN
  IF (Ch >= 'A') AND (Ch <= 'C')
  THEN
    CASE Ch OF
      'A': GetMatrix := [3, 7, 9, 12, 14, 17, 19, 22, 24, 18];
      'B': GetMatrix := [2, 7, 12, 22, 17, 3, 4, 5, 10, 20, 25, 23, 24, 13, 14];
      'C': GetMatrix := [2, 3, 4, 5, 7, 12, 17, 22, 23, 24, 25]
    END
  ELSE
    GetMatrix := []
END;        

BEGIN
  WHILE ReadLetter(INPUT, Ch)
  DO
    BEGIN
      Matrix := GetMatrix(Ch);
      IF (Matrix <> [])
      THEN                       
        PrintMatrix(OUTPUT, Matrix)
      ELSE
        WRITELN('Символ не найден!')
    END;
  WRITELN
END.
