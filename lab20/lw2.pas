PROGRAM Graphic(INPUT, OUTPUT);
USES
  PGraphic;
VAR
  Alphabet: FileOfAlphabet;
  SymbolIn: TEXT;
BEGIN
  
  ASSIGN(Alphabet, 'ALPHABET.DAT');
  ASSIGN(SymbolIn, 'FIN.TXT');
  ParseAlphabet(SymbolIn, Alphabet);
  PrintMessage(INPUT, OUTPUT, Alphabet)
END.
