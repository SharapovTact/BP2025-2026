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
      WRITELN(W1, ' ', W2, ' ', W3, ' ', W4) {Отладочный оператор}
      {проверка окна на land}
      {проверка окна на sea}
    END
  {создание сообщения Sarah}
END.  {SarahRevere} 


