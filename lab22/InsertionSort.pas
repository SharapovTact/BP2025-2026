PROGRAM InsertionSort (INPUT, OUTPUT);
{Сортирует символы из INPUT}
CONST
  Max = 16;
  ListEnd = 0;
TYPE
  RecArray = ARRAY [1 .. Max] OF 
               RECORD
                 Key: CHAR;
                 Next: 0 .. Max;
               END;
  Range = 0 .. Max;
VAR
  Arr: RecArray;
  First, Index: Range;
  Prev, Curr: Range;
  Extra: CHAR;
  Found: BOOLEAN;
  
PROCEDURE WriteList;
VAR
  Index: Range;
BEGIN {WriteList}
  Index := First;
  WHILE Index <> ListEnd
  DO
    BEGIN
      WRITE(Arr[Index].Key, ' ');
      Index := Arr[Index].Next
    END;
  WRITELN
END; {WriteList}

PROCEDURE PutRecInList;
BEGIN {PutRecInList}
  Prev := 0;
  Curr := First;
  
  Found := FALSE;
  WHILE (Curr <> ListEnd) AND (NOT Found)
  DO
    BEGIN
      IF Arr[Index].Key > Arr[Curr].Key
      THEN
        BEGIN
          Prev := Curr;
          Curr := Arr[Curr].Next
        END
      ELSE
        Found := TRUE 
    END;

  Arr[Index].Next := Curr;
  IF Prev = 0
  THEN
    First := Index
  ELSE
    Arr[Prev].Next := Index
END; {PutRecInList}

BEGIN
  First := 0;
  Index := 0;
  WHILE NOT EOLN
  DO
    BEGIN
      Index := Index + 1;
      IF Index > Max
      THEN
        BEGIN
          READ(Extra);
          WRITELN('Нет места в списке для ''', Extra, '''')
        END
      ELSE
        BEGIN
          READ(Arr[Index].Key);
          PutRecInList
        END
    END;
  WriteList
END.
