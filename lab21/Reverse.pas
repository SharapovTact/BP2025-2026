PROGRAM Reverse(INPUT, OUTPUT);
USES
  Stack;
BEGIN {Reverse}
  NewStack(S);
  WHILE NOT EOLN AND NOT Full(S)
  DO
    BEGIN
      Read(Elt);
      Push(S, Elt);
    END;
  WHILE NOT Empty(S)
  DO
    BEGIN
      WRITE(Top(S));
      Pop(S)
    END;
  WRITELN
END.  {Reverse}

