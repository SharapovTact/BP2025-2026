PROGRAM Encryption(INPUT, OUTPUT);
{Ia?aaiaeo neiaieu ec INPUT a eia niaeanii Chiper 
  e ia?aoaao iiaua neiaieu a OUTPUT}
CONST
  Len = 20;
  AlphabetSize = 26;
TYPE
  Str = ARRAY [1 .. Len] OF CHAR;
  Chiper = ARRAY ['!' .. '~'] OF CHAR;
  StrIndex = 0 .. Len;
VAR
  Msg: Str;
  Code: Chiper;
  I: StrIndex;
  SymbolIn: TEXT;
  CorrectValues: SET OF CHAR;

PROCEDURE Decode(VAR S: Str; StrLen: StrIndex); 
VAR
  Index: StrIndex;
BEGIN {Decode}       
  FOR Index := 1 TO StrLen
  DO
    IF (S[Index] IN CorrectValues)
    THEN
      WRITE(Code[S[Index]])
    ELSE   
      WRITE(S[Index]);
  WRITELN
END; {Decode}

PROCEDURE Initialize(VAR FIn: TEXT; VAR Code: Chiper);
VAR
  Ch, ChCode: CHAR;
BEGIN {Initialize}
  RESET(FIn);
  WHILE NOT EOF(FIn)
  DO
    BEGIN    
      IF NOT EOLN(FIn)
      THEN
        READ(FIn, Ch);
      IF NOT EOLN(FIn)
      THEN
        READ(FIn, ChCode);
      Code[ChCode] := Ch;
      CorrectValues := CorrectValues + [ChCode];
      READLN(FIn)
    END;
  CLOSE(FIn)
END; {Initialize}

BEGIN {Encryption}  
  ASSIGN(SymbolIn, 'FIN.TXT');
  Initialize(SymbolIn, Code);
  WHILE NOT EOF
  DO
    BEGIN
      I := 0;
      WHILE NOT EOLN AND (I < Len)
      DO
        BEGIN
          I := I + 1;
          READ(Msg[I])
        END;
      READLN;
      Decode(Msg, I)
    END
END.  {Encryption}
