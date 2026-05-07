UNIT Stack;

INTERFACE
CONST
  Depth = 20;
TYPE
  EltType = CHAR;
  Stack = RECORD
            Val: ARRAY [1 .. Depth] OF EltType;
            StackTop: 0 .. Depth
          END;
VAR
  S: Stack;
  Elt: EltType;
  
PROCEDURE NewStack(VAR S: Stack);
PROCEDURE Push(VAR S: Stack; E: EltType);
PROCEDURE Pop(VAR S:Stack);
FUNCTION Top(VAR S: Stack): EltType;
FUNCTION Empty(VAR S: Stack): BOOLEAN;
FUNCTION Full(VAR S: Stack): BOOLEAN;

IMPLEMENTATION

PROCEDURE NewStack(VAR S: Stack);
{S := <>}
BEGIN {NewStack}
  S.StackTop := 0
END; {NewStack}

PROCEDURE Push(VAR S: Stack; E: EltType);
{S := S & <E>}
BEGIN {Push}
  IF S.StackTop >= Depth
  THEN
    WRITELN('** OVERFLOW **')
  ELSE
    BEGIN
      S.StackTop := S.StackTop + 1;
      S.Val[S.StackTop] := E
    END
END; {Push}

PROCEDURE Pop(VAR S:Stack);
BEGIN {Pop}
  IF S.StackTop <= 0 
  THEN
    WRITELN('** UNDERFLOW **')
  ELSE
    S.StackTop := S.StackTop - 1
END; {Pop}

FUNCTION Top(VAR S: Stack): EltType;
BEGIN {Top}
  IF S.StackTop <= 0
  THEN
    BEGIN
      WRITELN('** READING EMPTY STACK **');
      Top := '0'
    END
  ELSE
    Top := S.Val[S.StackTop]
END; {Top}

FUNCTION Empty(VAR S: Stack): BOOLEAN;
BEGIN {Empty}
  Empty := S.StackTop <= 0
END; {Empty}

FUNCTION Full(VAR S: Stack): BOOLEAN;
BEGIN {Full}
  Full := S.StackTop >= Depth
END; {Full}


END.                                                                                
