UNIT WordStat;

INTERFACE
USES
  WordParse, WordCount, StatStorage;
PROCEDURE PrintWordStat(VAR WordIn, StatOut: TEXT);

IMPLEMENTATION
  
PROCEDURE PrintWordStat(VAR WordIn, StatOut: TEXT);
VAR
  Word: STRING;
  Overflow: BOOLEAN;
BEGIN {PrintWordStat}
  RESET(WordIn);
  Overflow := FALSE;
  WHILE NOT EOF(WordIn) AND NOT Overflow
  DO
    BEGIN
      Word := ReadWord(WordIn);
      IF Word <> ''
      THEN
        InsertWord(LowerCase(Word), EOF(WordIn))
    END;
  REWRITE(StatOut);
  PrintStat(StatOut)
END; {PrintWordStat}

BEGIN

END.
