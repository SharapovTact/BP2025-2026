UNIT WordStat;

INTERFACE
USES
  WordParse, WordCount;
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
        IF InsertWord(LowerCase(Word)) = FALSE
        THEN
          BEGIN
            WRITELN(StatOut, '—труктура переполнена, слишком много слов');
            Overflow := TRUE
          END
    END;
  REWRITE(StatOut);
  PrintStat(StatOut);
END; {PrintWordStat}

BEGIN

END.
