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
  Ch: CHAR;
  
{Процедура Encode}

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
  FOR Ch := 'A' TO 'Z' {ОТЛАДКА}
  DO                   {ОТЛАДКА}
    WRITE(Code[Ch]);   {ОТЛАДКА}
  WRITELN;             {ОТЛАДКА}
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
      FOR I := 1 TO Len {ОТЛАДКА}
      DO                {ОТЛАДКА}
        WRITE(Msg[I]);  {ОТЛАДКА} 
      WRITELN           {ОТЛАДКА}
    END
END.  {Encryption}
