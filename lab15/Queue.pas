UNIT Queue;
INTERFACE
VAR
  Q: TEXT;
PROCEDURE EmptyQ;
PROCEDURE AddQ(Elt: CHAR);
PROCEDURE DelQ;
PROCEDURE HeadQ(VAR Elt: CHAR);

IMPLEMENTATION {–≈¿À»«¿÷»ﬂ}
PROCEDURE CopyOpen(VAR F1, F2: TEXT);
VAR
  Ch: CHAR;
BEGIN {CopyOpen}
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      WRITE(F2, Ch)
    END
END; {CopyOpen}

PROCEDURE EmptyQ;
BEGIN {EmptyQ}
  REWRITE(Q);
  WRITELN(Q);
  RESET(Q)
END; {EmptyQ}

PROCEDURE AddQ(Elt: CHAR);
VAR
  Temp: TEXT;
BEGIN {AddQ}
  REWRITE(Temp);
  CopyOpen(Q, Temp);
  WRITELN(Temp, Elt);
  RESET(Temp);
  REWRITE(Q);
  CopyOpen(Temp, Q);
  WRITELN(Q);
  RESET(Q)
END; {AddQ}

PROCEDURE DelQ;
  VAR
    Temp: TEXT;
    Ch: CHAR;
 BEGIN {DelQ}
  READ(Q, Ch);
  IF NOT EOF(Q)
  THEN
    BEGIN
      REWRITE(Temp);
      CopyOpen(Q, Temp);
      WRITELN(Temp);
      RESET(Temp);
      REWRITE(Q);
      CopyOpen(Temp, Q);
      WRITELN(Q)
    END;
  RESET(Q)
END; {DelQ}

PROCEDURE HeadQ(VAR Elt: CHAR);
BEGIN  {HeadQ}
  IF NOT EOLN(Q)
  THEN
    READ(Q,Elt)
  ELSE
    Elt := '#';
  RESET(Q)
END; {HeadQ}

END.



