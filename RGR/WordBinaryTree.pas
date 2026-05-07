UNIT WordBinaryTree;

INTERFACE     
USES
  WordComp;
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

PROCEDURE Insert(VAR Ptr: WordsBinaryTree; Data: STRING); 
PROCEDURE PrintTree(VAR FOut: TEXT; VAR Ptr: WordsBinaryTree); 

IMPLEMENTATION 

PROCEDURE Insert(VAR Ptr: WordsBinaryTree; Data: STRING);
VAR 
  Comparator: INTEGER;
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN 
      NEW(Ptr);
      ElementCount := ElementCount + 1;
      Ptr^.Key := Data;
      Ptr^.Value := 1;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL
    END
  ELSE
    BEGIN
      Comparator := WordCompare(Data, Ptr^.Key);
      CASE Comparator OF
        Equals: Ptr^.Value := Ptr^.Value + 1;
        More: Insert(Ptr^.LLink, Data);
        Less: Insert(Ptr^.RLink, Data)
      END
    END
END; {Insert}

PROCEDURE PrintTree(VAR FOut: TEXT; VAR Ptr: WordsBinaryTree);
VAR
  Str: STRING;
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      Str := Ptr^.Key;  
      PrintTree(FOut, Ptr^.LLink);
      WRITE(FOut, Str);
      WRITELN(FOut, ' - ', Ptr^.Value);
      PrintTree(FOut, Ptr^.RLink)
    END
END; {PrintTree}

BEGIN
  ElementCount := 0
END.
