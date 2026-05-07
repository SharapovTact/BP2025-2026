PROGRAM SarahRevere(INPUT, OUTPUT); 
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN; 
PROCEDURE InitSarahRevere(VAR Wp1, Wp2, Wp3, Wp4: CHAR; VAR LookingP, LandP, SeaP: BOOLEAN);
BEGIN
  Wp1 := ' ';
  Wp2 := ' ';
  Wp3 := ' ';
  Wp4 := ' ';
  LookingP := NOT EOLN;
  LandP := FALSE;
  SeaP := FALSE
END;

PROCEDURE WindowMove(VAR FIn: TEXT; VAR LookingP: BOOLEAN; VAR Wp1, Wp2, Wp3, Wp4: CHAR);
BEGIN
  Wp1 := Wp2;
  Wp2 := Wp3;
  Wp3 := Wp4;
  READ(FIn, W4);
  LookingP := NOT EOLN(Fin)
END;

BEGIN {SarahRevere}   
  InitSarahRevere(W1, W2, W3, W4, Looking, Land, Sea);
  WHILE Looking AND NOT (Land OR Sea)   
  DO
    BEGIN
      WindowMove(INPUT, Looking, W1, W2, W3, W4);
      Land := (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd');
      Sea := (W2 = 's') AND (W3 = 'e') AND (W4 = 'a')
    END;
  IF NOT(Land OR Sea)
  THEN
    WRITELN('Sarah didn''t say')
  ELSE
    BEGIN
      WRITE('The British are coming by ');
      IF Land
      THEN
        WRITELN('land');
      IF Sea
      THEN
        WRITELN('sea')
    END
END.  {SarahRevere} 


