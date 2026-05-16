UNIT StatRW;

INTERFACE

TYPE
  WordStatType = RECORD
                   Key: STRING;
                   Value: INTEGER
                 END;  

PROCEDURE ReadStorageFile(VAR FIn: TEXT; VAR WordStat: WordStatType);
PROCEDURE WriteInStorage(VAR FOut: TEXT; VAR WordStat: WordStatType);

IMPLEMENTATION

PROCEDURE ReadStorageFile(VAR FIn: TEXT; VAR WordStat: WordStatType);
BEGIN
  READLN(FIn, WordStat.Key);
  READLN(FIn, WordStat.Value)
END;

PROCEDURE WriteInStorage(VAR FOut: TEXT; VAR WordStat: WordStatType);
BEGIN
  WRITELN(FOut, WordStat.Key);
  WRITELN(FOut, WordStat.Value)
END;

BEGIN

END.
