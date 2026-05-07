PROGRAM Decryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
  и печатает новые символы в OUTPUT}
CONST
  Len = 20;
  AlphabetSize = 26;
  CorrectValues = ['A' .. 'Z', ' '];
  DefaultSymbol = '?';
TYPE
  Str = ARRAY [1 .. Len] OF CHAR;
  Chiper = ARRAY [' ' .. 'Z'] OF CHAR;
VAR
  Msg: Str;
  Code: Chiper;
  I: 0 .. Len;
  SymbolIn: TEXT;

PROCEDURE Decode(VAR S: Str; StrLen: INTEGER); 
VAR
  Index: 1 .. Len;
  Ch: 'A' .. 'Z'; 
  Found: BOOLEAN;
BEGIN {Decode}       
  FOR Index := 1 TO StrLen
  DO
    BEGIN
      Found := FALSE;
      IF S[Index] = Code[' ']
      THEN
        BEGIN
          Found := TRUE;
          WRITE(' ')
        END  
      ELSE  
        FOR Ch := 'A' TO 'Z'
        DO
          IF S[Index] = Code[Ch]
          THEN
            BEGIN
              Found := TRUE;
              WRITE(Ch)
            END;
      IF Found = FALSE
      THEN
        WRITE(S[Index])
    END;            
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
      Code[Ch] := ChCode;
      READLN(FIn)
    END
END; {Initialize}

BEGIN {Decryption}  
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
      WRITELN;
      Decode(Msg, I)
    END
END.  {Decryption}
