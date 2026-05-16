UNIT WordCount;

INTERFACE
USES
  WordBinaryTree, StatStorage;

PROCEDURE InsertWord(Data: STRING; EndOfFile: BOOLEAN);

IMPLEMENTATION
CONST
  MaxElementCount = 3;
VAR
  WordCount: INTEGER;

PROCEDURE InsertWord(Data: STRING; EndOfFile: BOOLEAN);
BEGIN {InsertWord}
  WordCount := WordCount + 1;
  Insert(Ptr, Data);
  IF ElementCount = MaxElementCount
  THEN
    BEGIN
      SaveStat(Ptr, WordCount);
      WordCount := 0;
      DeleteTree()
    END;
  IF EndOfFile
  THEN
    SaveStat(Ptr, WordCount)
END; {InsertWord}

BEGIN
  WordCount := 0
END.
