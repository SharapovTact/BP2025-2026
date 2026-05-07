PROGRAM CountWords(INPUT, OUTPUT);
USES
  WordParse, WordCount;
VAR
  WordIn, StatOut: TEXT;
  Word: STRING;
  Overflow: BOOLEAN;
BEGIN {CountWords}
  ASSIGN(WordIn, 'Text.TXT');
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
            WRITELN(OUTPUT, '—труктура переполнена, слишком много слов');
            Overflow := TRUE
          END
    END;
  CLOSE(WordIn);
  ASSIGN(StatOut, 'Output.TXT');
  REWRITE(StatOut);
  PrintStat(StatOut);
  CLOSE(StatOut)
END. {CountWords}
