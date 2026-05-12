PROGRAM CountWords(INPUT, OUTPUT);
USES
  WordStat;
VAR
  WordIn, StatOut: TEXT;
BEGIN {CountWords}
  ASSIGN(WordIn, 'Text.TXT');
  ASSIGN(StatOut, 'Output.TXT');
  PrintWordStat(WordIn, StatOut);
  CLOSE(WordIn);
  CLOSE(StatOut)
END. {CountWords}
