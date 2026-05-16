UNIT WordCompare;

INTERFACE

CONST
  Less = -1;
  Equals = 0;
  More = 1;
  Alphabet = 'abcdefghijklmnopqrstuvwxyzàáâãäå¸æçèéêëìíîïðñòóôõö÷øùúûüýþÿ';

FUNCTION WordCmp(Word1: STRING; Word2: STRING): INTEGER; {-1:W1<W2, 0:W1=W2, 1:W1>W2}

IMPLEMENTATION

FUNCTION CharCompare(Ch1, Ch2: CHAR): INTEGER;
VAR
  Pos: INTEGER;
  Compared: BOOLEAN;
BEGIN {CharCompare}
  Compared := FALSE;
  CharCompare := Equals;
  Pos := 1;
  WHILE (Pos <> Length(Alphabet) + 1) AND (Compared = FALSE)
  DO
    BEGIN
      IF (Alphabet[Pos] = Ch1) AND (Alphabet[Pos] = Ch2)
      THEN
        Compared := TRUE
      ELSE
        IF Alphabet[Pos] = Ch1
        THEN
          BEGIN                                                        
            CharCompare := More;
            Compared := TRUE
          END  
        ELSE
          IF Alphabet[Pos] = Ch2
          THEN
            BEGIN
              CharCompare := Less;
              Compared := TRUE
            END;
      Pos := Pos + 1
    END
END; {CharCompare}

FUNCTION WordCmp(Word1: STRING; Word2: STRING): INTEGER;
VAR
  I, WComparator, CComparator: INTEGER;
  Len1, Len2: INTEGER;
BEGIN {WordCompare}
  WComparator := Equals;
  Len1 := Length(Word1);
  Len2 := Length(Word2);
  I := 1;       
  WHILE (I <> Len1 + 1) AND (WComparator = 0) AND (I <= Len1) AND (I <= Len2)
  DO
    BEGIN
      WComparator := CharCompare(Word1[I], Word2[I]);
      I := I + 1
    END;
  IF (WComparator = Equals) AND (Len1 > Len2)
  THEN
    WComparator := Less;
  IF (WComparator = Equals) AND (Len1 < Len2)
  THEN
    WComparator := More;  
  WordCmp := WComparator;
  IF Word1 = ''
  THEN
    WordCmp := 1;
  IF Word2 = ''
  THEN
    WordCmp := -1
END; {WordCompare}
END.
