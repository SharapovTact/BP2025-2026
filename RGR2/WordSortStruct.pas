UNIT WordSortStruct;

INTERFACE

FUNCTION InsertInStruct(Word: STRING): INTEGER;
PROCEDURE DeleteStruct();
PROCEDURE PutStructToStorage(FInPtr, FOutPtr: POINTER);

IMPLEMENTATION

USES
  WordCompare, StatRW;
TYPE 
  WordsBinaryTree = ^NodeType;
  
  NodeType = RECORD
               Key: STRING;
               Value: INTEGER;
               LLink, RLink: WordsBinaryTree
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
BEGIN {Insert}
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
END; {Insert}

FUNCTION InsertInStruct(Word: STRING): INTEGER;
BEGIN {InsertInStruct}
  Insert(Ptr, Word);
  InsertInStruct := ElementCount
END; {InsertInStruct}

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
                  ReadStorageFile(FIn, StorageWordStat)
                ELSE
                  StorageWordStat.Key := '';
                NextNode := TRUE
              END;
            More: 
              BEGIN
                WordStat.Key := Ptr^.Key;
                WordStat.Value := Ptr^.Value;
                WriteInStorage(FOut, WordStat);
                NextNode := TRUE
              END;
            Less: 
              BEGIN
                WriteInStorage(FOut, StorageWordStat);
                IF NOT EOF(FIn)
                THEN
                  ReadStorageFile(FIn, StorageWordStat)
                ELSE
                  StorageWordStat.Key := ''
              END
          END
          
        END;
      MergeTree(FIn, FOut, Ptr^.RLink, StorageWordStat)
    END
END; {MergeTree}

PROCEDURE WriteTree(VAR FOut: TEXT; Ptr: WordsBinaryTree);
VAR
  WordStat: WordStatType;
BEGIN {WriteTree}
  IF Ptr <> NIL 
  THEN
    BEGIN
      WriteTree(FOut, Ptr^.LLink);
      WordStat.Key := Ptr^.Key;
      WordStat.Value := Ptr^.Value;
      WriteInStorage(FOut, WordStat);
      WriteTree(FOut, Ptr^.RLink)
    END
END; {WriteTree}

PROCEDURE PutStructToStorage(FInPtr, FOutPtr: POINTER);
VAR {PutStructToStorage}
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
      ReadStorageFile(FIn^, StorageWordStat);
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
END; {PutStructToStorage}


BEGIN
  ElementCount := 0
END.
