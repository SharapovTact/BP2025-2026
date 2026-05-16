UNIT WordStat;

INTERFACE
USES
  WordStorage, WordParse;
PROCEDURE PrintWordStat(VAR WordIn, StatOut: TEXT);

IMPLEMENTATION
  
PROCEDURE PrintWordStat(VAR WordIn, StatOut: TEXT);
VAR
  Word: STRING;
BEGIN {PrintWordStat}
  RESET(WordIn);
  WHILE NOT EOF(WordIn)
  DO
    BEGIN
      Word := ReadWord(WordIn);
      IF Word <> ''
      THEN
        Insert(LowerCase(Word))
    END;
  PrintStat(StatOut)
END; {PrintWordStat}

BEGIN

END.
