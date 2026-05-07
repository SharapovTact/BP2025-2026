PROGRAM Encryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
  и печатает новые символы в OUTPUT}
CONST
  Len = 20;
  AlphabetSize = 26;
TYPE
  Str = ARRAY [1 .. Len] OF CHAR;
  Chiper = ARRAY ['A' .. 'Z'] OF CHAR;
VAR
  Msg: Str;
  Code: Chiper;
  I: INTEGER;
  SymbolIn: TEXT;

PROCEDURE Encode(VAR S: Str);
VAR
  Index: 1 .. Len;
BEGIN {Encode}
  FOR Index := 1 TO Len
  DO
    IF S[Index] IN ['A' .. 'Z']
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END; {Encode}


PROCEDURE Initialize(VAR FIn: TEXT; VAR Code: Chiper);
VAR
  I: CHAR;
BEGIN {Initialize}
  RESET(FIn);
  FOR I := 'A' TO 'Z'
  DO
    IF NOT EOLN(FIn)
    THEN
      READ(FIn, Code[I])
    ELSE
      Code[I] := '?' 
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
          READ(Msg[I]);
          WRITE(Msg[I])
        END;
      READLN;
      WRITELN;
      FOR I := I + 1 TO Len
      DO
        Msg[I] := ' '; 
      Encode(Msg)
    END
END.  {Encryption}
