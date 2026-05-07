PROGRAM Test(INPUT, OUTPUT);
USES
  Queue;
VAR
  Ch: CHAR;
BEGIN
  EmptyQ();
  AddQ('A');
  AddQ('B');
  HeadQ(Ch);
  DelQ();
  HeadQ(Ch);
  WRITELN('Hello', Ch)
END.
