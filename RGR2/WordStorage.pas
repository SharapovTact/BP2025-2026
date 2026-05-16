UNIT WordStorage;

INTERFACE
 
PROCEDURE Insert(Word: STRING);
PROCEDURE PrintStat(VAR FOut: TEXT);

IMPLEMENTATION

USES
  WordSortStruct, StatRW;
CONST
  MaxElementNumber = 3;
VAR
  WordCounter: INTEGER;
  StatFile1, StatFile2: TEXT;
  StorageFile, EmptyFile, Temp: ^TEXT;

PROCEDURE AddFreshDataInStorage();
BEGIN {AddFreshDataInStorage}
  PutStructToStorage(StorageFile, EmptyFile);
  DeleteStruct();
  Temp := StorageFile;
  StorageFile := EmptyFile;
  EmptyFile := Temp
END; {AddFreshDataInStorage}
  
PROCEDURE Insert(Word: STRING);
BEGIN {Insert}
  WordCounter := WordCounter + 1;
  IF InsertInStruct(Word) = MaxElementNumber
  THEN
    AddFreshDataInStorage()
END; {Insert}

PROCEDURE PrintStat(VAR FOut: TEXT);
VAR
  WordStat: WordStatType; 
BEGIN {PrintStat}
  AddFreshDataInStorage();   
  WRITELN(FOut, 'Кол-во слов: ', WordCounter);
  RESET(StorageFile^);
  WHILE NOT EOF(StorageFile^)
  DO
    BEGIN
      ReadStorageFile(StorageFile^, WordStat);
      WRITELN(FOut, WordStat.Key, ' - ', WordStat.Value)
    END;
  CLOSE(StorageFile^);
  
  REWRITE(EmptyFile^);
  CLOSE(EmptyFile^)
END; {PrintStat}

BEGIN
  ASSIGN(StatFile1, 'StatFile1.TXT');
  ASSIGN(StatFile2, 'StatFile2.TXT');
  REWRITE(StatFile1);
  CLOSE(StatFile1);
  WordCounter := 0;
  StorageFile := @StatFile1;
  EmptyFile := @StatFile2
END.
