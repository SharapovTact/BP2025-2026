UNIT BinaryTree;

INTERFACE
TYPE 
  Tree = ^NodeType;
  
PROCEDURE Insert(VAR Ptr: Tree; Data: CHAR);
PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Tree);


IMPLEMENTATION   

NodeType = RECORD
               Key: CHAR;
               LLink, RLink: Tree
             END;

PROCEDURE Insert(VAR Ptr: Tree; Data: CHAR);
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN 
      NEW(Ptr);
      Ptr^.Key := Data;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL
    END
  ELSE
    IF Ptr^.Key > Data
    THEN
      Insert(Ptr^.LLink, Data)
    ELSE
      Insert(Ptr^.RLink, Data)
END; {Insert}

PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Tree);
VAR
  Ch: CHAR;
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      Ch := Ptr^.Key;  
      PrintTree(FOut, Ptr^.LLink);
      WRITE(FOut, Ch);
      PrintTree(FOut, Ptr^.RLink)
    END
END; {PrintTree}

END.
