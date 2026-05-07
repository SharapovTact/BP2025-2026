UNIT WordCount;

INTERFACE
USES
  WordBinaryTree;

FUNCTION InsertWord(Data: STRING): BOOLEAN;
PROCEDURE PrintStat(VAR FOut: TEXT);

IMPLEMENTATION
CONST
  MaxElementCount = 100000;
VAR
  WordCount: INTEGER;

FUNCTION InsertWord(Data: STRING): BOOLEAN; {TRUE - вставилось/FALSE - не вставилось}
BEGIN {InsertWord}
  IF ElementCount < MaxElementCount
  THEN
    BEGIN
      WordCount := WordCount + 1;
      Insert(Ptr, Data);
      InsertWord := TRUE
    END
  ELSE
    InsertWord := FALSE
END; {InsertWord}

PROCEDURE PrintStat(VAR FOut: TEXT);
BEGIN {PrintStat}
  WRITELN(FOut, ' ол-во слов: ', WordCount);
  PrintTree(FOut, Ptr)
END; {PrintStat}

BEGIN
  WordCount := 0
END.
