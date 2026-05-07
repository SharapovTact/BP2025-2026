UNIT PGraphic;

INTERFACE
CONST
  Size = 5;
  FillSymbol = '#';
  SpaceSymbol = ' ';
  RowLength = 10;
TYPE
  MatrixType = SET OF 1 .. Size * Size;
  RowMatrixType = SET OF 1 .. Size * Size * RowLength;
  SymbolRec = RECORD
           Ch: CHAR;
           Matrix: MatrixType
         END;
  FileOfAlphabet = FILE OF SymbolRec;
PROCEDURE ParseAlphabet(VAR FIn: TEXT; VAR Alphabet: FileOfAlphabet);
PROCEDURE PrintMessage(VAR FIn: TEXT; VAR FOut: TEXT; VAR Alphabet: FileOfAlphabet);

IMPLEMENTATION

PROCEDURE CharToInt(VAR CharSymb: CHAR; VAR DigitalSymb: INTEGER);
BEGIN {CharToInt}
  IF CharSymb = '0' THEN DigitalSymb := 0 ELSE
  IF CharSymb = '9' THEN DigitalSymb := 9 ELSE
  IF CharSymb = '8' THEN DigitalSymb := 8 ELSE
  IF CharSymb = '7' THEN DigitalSymb := 7 ELSE
  IF CharSymb = '6' THEN DigitalSymb := 6 ELSE
  IF CharSymb = '5' THEN DigitalSymb := 5 ELSE
  IF CharSymb = '4' THEN DigitalSymb := 4 ELSE
  IF CharSymb = '3' THEN DigitalSymb := 3 ELSE
  IF CharSymb = '2' THEN DigitalSymb := 2 ELSE
  IF CharSymb = '1' THEN DigitalSymb := 1
END; {CharToInt}
  
PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
VAR
  Symbol: CHAR;
BEGIN {ReadDigit}
  D := -1;
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Symbol);
      CharToInt(Symbol, D)
    END
END; {ReadDigit}

PROCEDURE ReadNumber(VAR F: TEXT; VAR Number: INTEGER);
VAR
  Digit: INTEGER;
BEGIN {ReadNumber}
  Number := -1;
  ReadDigit(F, Digit);
  WHILE (Digit <> -1) AND (Number <> -2)
  DO
    BEGIN
      IF (Number > ((MAXINT - Digit) DIV 10)) AND (Number > 10)
      THEN
        Number := -2
      ELSE
        BEGIN
          IF (Number = -1)
          THEN
            Number := Digit
          ELSE
            Number := Number * 10 + Digit
        END;
      ReadDigit(F, Digit)
    END
END; {ReadNumber}

PROCEDURE ParseAlphabet(VAR FIn: TEXT; VAR Alphabet: FileOfAlphabet);
VAR
  Symbol: SymbolRec;
  Num: INTEGER;
BEGIN {ParseAlphabet}
  REWRITE(Alphabet);
  RESET(FIn);
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      IF NOT EOLN(FIn)
      THEN
        READ(FIn, Symbol.Ch);
      WHILE NOT EOLN(FIn)
      DO
        BEGIN
          ReadNumber(FIn, Num);
          IF Num > 0
          THEN           
            Symbol.Matrix := Symbol.Matrix + [Num]
        END;
      WRITE(Alphabet, Symbol);
      Symbol.Ch := ' ';
      Symbol.Matrix := [];
      READLN(FIn)
    END
END; {ParseAlphabet}

FUNCTION GetSymbolMatrix(Ch: CHAR; VAR Alphabet: FileOfAlphabet): MatrixType;
VAR 
  Matrix: MatrixType;
  Symbol: SymbolRec;
  SymbolFound: BOOLEAN;
BEGIN {GetSymbolMatrix}
  RESET(Alphabet);
  Matrix := [];
  SymbolFound := FALSE;
  WHILE (NOT EOF(Alphabet)) AND (NOT SymbolFound)
  DO
    BEGIN
      READ(Alphabet, Symbol);
      IF (Symbol.Ch = Ch)
      THEN
        BEGIN
          SymbolFound := TRUE;
          Matrix := Symbol.Matrix
        END
    END;
  GetSymbolMatrix := Matrix
END; {GetSymbolMatrix}

PROCEDURE FillRowMatrix(VAR RowMatrix: RowMatrixType; I: INTEGER; Ch: CHAR; VAR Alphabet: FileOfAlphabet);
VAR
  J, K, Pos: INTEGER;
  Matrix: MatrixType;
BEGIN {FillRowMatrix}
  Matrix := GetSymbolMatrix(Ch, Alphabet);
  FOR J := 0 TO (Size - 1)
  DO
    FOR K := 1 TO Size
      DO
        BEGIN
          Pos := J * Size + K;
          IF Pos IN Matrix
          THEN
            RowMatrix := RowMatrix + [Pos + I * Size + J * Size * (RowLength - 1)]
        END
END; {FillRowMatrix}

PROCEDURE PrintRow(VAR FOut: TEXT; RowMatrix: RowMatrixType);
VAR
  I: INTEGER;
BEGIN {PrintRow}
  FOR I := 1 TO (Size * Size * RowLength)
  DO
    BEGIN
      IF I IN RowMatrix
      THEN
        WRITE(FOut, FillSymbol)
      ELSE
        WRITE(FOut, SpaceSymbol);
      IF (I MOD Size = 0) AND (I MOD (Size * RowLength) <> 0)
      THEN
        WRITE(FOut, SpaceSymbol);
      IF (I MOD (Size * RowLength)) = 0
      THEN
        WRITELN(FOut)
    END
END; {PrintRow}

PROCEDURE PrintMessage(VAR FIn: TEXT; VAR FOut: TEXT; VAR Alphabet: FileOfAlphabet);
VAR
  Ch: CHAR;
  RowMatrix: RowMatrixType;
  I: INTEGER;
BEGIN {PrintMessage}
  I := 0;
  RowMatrix := [];
  WHILE NOT EOLN(FIn)
  DO
    BEGIN
      READ(FIn, Ch);
      FillRowMatrix(RowMatrix, I, Ch, Alphabet);
      I := I + 1;
      IF (I = RowLength) OR (EOLN(FIn))
      THEN
        BEGIN
          I := 0;
          PrintRow(FOut, RowMatrix);
          RowMatrix := []
        END
    END
END; {PrintMessage}

END.

