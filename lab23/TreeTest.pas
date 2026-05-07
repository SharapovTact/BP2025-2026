PROGRAM TreeSort(INPUT, OUTPUT);
USES
  BinaryTree;
VAR
  Root1: Tree;
  Ch: CHAR;
BEGIN {TreeSort}
  Root1 := NIL;
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      Insert(Root1, Ch)
    END;
  PrintTree(OUTPUT, Root1)
END.  {TreeSort}

