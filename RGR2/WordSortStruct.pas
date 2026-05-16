UNIT WordSortStruct;

INTERFACE

FUNCTION InsertInStruct(Word: STRING): INTEGER;
PROCEDURE DeleteStruct();
PROCEDURE PutStructToStorage(FInPtr, FOutPtr: POINTER);

IMPLEMENTATION

USES
  WordCompare;
TYPE 
  WordsBinaryTree = ^NodeType;
  
  NodeType = RECORD
               Key: STRING;
               Value: INTEGER;
               LLink, RLink: WordsBinaryTree
             END; 
  WordStatType = RECORD
                   Key: STRING;
                   Value: INTEGER
                 END;  
VAR
  Ptr: WordsBinaryTree; 
  ElementCount: INTEGER;

PROCEDURE DeleteStruct();
BEGIN
  Ptr := NIL;
  ElementCount := 0
END;

PROCEDURE Insert(VAR Ptr: WordsBinaryTree; Word: STRING);
VAR 
  Comparator: INTEGER;
BEGIN
  IF Ptr = NIL
  THEN
    BEGIN 
      NEW(Ptr);
      ElementCount := ElementCount + 1;
      Ptr^.Key := Word;
      Ptr^.Value := 1;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL
    END
  ELSE
    BEGIN
      Comparator := WordCmp(Word, Ptr^.Key);
      CASE Comparator OF
        Equals: Ptr^.Value := Ptr^.Value + 1;
        More: Insert(Ptr^.LLink, Word);
        Less: Insert(Ptr^.RLink, Word)
      END
    END
END;

FUNCTION InsertInStruct(Word: STRING): INTEGER;
BEGIN {InsertInStruct}
  Insert(Ptr, Word);
  InsertInStruct := ElementCount
END; {InsertInStruct}

PROCEDURE ReadStorageFile(VAR FIn: TEXT; VAR WordStat: WordStatType);
BEGIN
  READLN(FIn, WordStat.Key);
  READLN(FIn, WordStat.Value);
END;

PROCEDURE WriteInStorage(VAR FOut: TEXT; VAR WordStat: WordStatType);
BEGIN
  WRITELN(FOut, WordStat.Key);
  WRITELN(FOut, WordStat.Value);
END;

PROCEDURE MergeTree(VAR FIn, FOut: TEXT; VAR Ptr: WordsBinaryTree; VAR StorageWordStat: WordStatType);
VAR
  WordStat: WordStatType;
  Comparator: INTEGER;
  NextNode: BOOLEAN;
BEGIN {MergeTree}
  IF Ptr <> NIL
  THEN
    BEGIN 
      NextNode := FALSE;
      MergeTree(FIn, FOut, Ptr^.LLink, StorageWordStat);
      WHILE NOT NextNode
      DO
        BEGIN
          IF StorageWordStat.Key = '' THEN
            Comparator := More
          ELSE
            Comparator := WordCmp(StorageWordStat.Key, Ptr^.Key);
          CASE Comparator OF
            Equals:
              BEGIN
                StorageWordStat.Value := StorageWordStat.Value + Ptr^.Value;
                WriteInStorage(FOut, StorageWordStat);
                IF NOT EOF(FIn)
                THEN
                  ReadStorageFile(FIn, StorageWordStat) {вынести в отд. модуль}
                ELSE
                  StorageWordStat.Key := '';
                NextNode := TRUE
              END;
            More: 
              BEGIN
                WordStat.Key := Ptr^.Key;
                WordStat.Value := Ptr^.Value;
                WriteInStorage(FOut, WordStat); {Вынести в отд. файл}
                NextNode := TRUE
              END;
            Less: 
              BEGIN
                WriteInStorage(FOut, StorageWordStat);
                IF NOT EOF(FIn)
                THEN
                  ReadStorageFile(FIn, StorageWordStat) {вынести в отд. модуль}
                ELSE
                  StorageWordStat.Key := ''
              END
          END
          
        END;
      MergeTree(FIn, FOut, Ptr^.RLink, StorageWordStat);
    END
END; {MergeTree}

PROCEDURE WriteTree(VAR FOut: TEXT; Ptr: WordsBinaryTree);
VAR
  WordStat: WordStatType;
BEGIN
  IF Ptr <> NIL 
  THEN
    BEGIN
      WriteTree(FOut, Ptr^.LLink);
      WRITELN('запись в бинарное дерево'); {Отладочный оператор}
      WordStat.Key := Ptr^.Key;
      WordStat.Value := Ptr^.Value;
      WriteInStorage(FOut, WordStat);
      WriteTree(FOut, Ptr^.RLink)
    END
END;

PROCEDURE PutStructToStorage(FInPtr, FOutPtr: POINTER);
VAR
  StorageWordStat: WordStatType;
  FIn, FOut: ^TEXT;
BEGIN
  FIn := FInPtr;
  FOut := FOutPtr;
  
  REWRITE(FOut^);
  RESET(FIn^);
  IF EOF(FIn^)
  THEN
    WriteTree(FOut^, Ptr)
  ELSE
    BEGIN
      ReadStorageFile(FIn^, StorageWordStat); {вынести в отд. модуль}
      MergeTree(FIn^, FOut^, Ptr, StorageWordStat);
      IF StorageWordStat.Key <> ''
      THEN
        WriteInStorage(FOut^, StorageWordStat);
      WHILE NOT EOF(FIn^)
      DO
        BEGIN
          ReadStorageFile(FIn^, StorageWordStat);
          WriteInStorage(FOut^, StorageWordStat)
        END
    END
END;


BEGIN
  ElementCount := 0
END.
