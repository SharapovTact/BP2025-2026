UNIT StatStorage;

INTERFACE
USES
  WordBinaryTree, WordComp;
  
PROCEDURE SaveStat(VAR Ptr: WordsBinaryTree; WordCount: INTEGER);
PROCEDURE PrintStat(VAR FOut: TEXT);

IMPLEMENTATION
TYPE 
  WordStatType = RECORD
               Key: STRING;
               Value: INTEGER
             END;
  WordsBinaryTreeFile = FILE OF WordStatType;
VAR
  WordNumber: INTEGER;
  StatFile: WordsBinaryTreeFile;
  
PROCEDURE CopyFile(VAR FIn: WordsBinaryTreeFile; VAR FOut: WordsBinaryTreeFile);
VAR
  WordStat: WordStatType;
BEGIN {CopyFile}
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      READ(FIn, WordStat);
      WRITE(FOut, WordStat)
    END
END; {CopyFile}

PROCEDURE CopyTree(VAR FOut: WordsBinaryTreeFile; VAR Ptr: WordsBinaryTree);
VAR
  WordStat: WordStatType;
BEGIN {CopyTree}
  IF Ptr <> NIL
  THEN
    BEGIN 
      CopyTree(FOut, Ptr^.LLink);
      WordStat.Key := Ptr^.Key;
      WordStat.Value := Ptr^.Value;
      WRITE(FOut, WordStat);
      CopyTree(FOut, Ptr^.RLink)
    END
END; {CopyTree}

PROCEDURE MergeStat(VAR TempStat1, TempStat2: WordsBinaryTreeFile);
VAR
  WordStat1, WordStat2: WordStatType;
  HasFirst, HasSecond: BOOLEAN;
  Comparator: INTEGER;
BEGIN {MergeStat}
  HasFirst := FALSE;
  HasSecond := FALSE;
  IF NOT EOF(TempStat1)
  THEN
    BEGIN
      HasFirst := TRUE;
      READ(TempStat1, WordStat1)
    END;                        
  IF NOT EOF(TempStat2)
  THEN
    BEGIN
      HasSecond := TRUE;
      READ(TempStat2, WordStat2)
    END;
  WHILE (NOT EOF(TempStat1)) AND (NOT EOF(TempStat2))
  DO
    BEGIN
      Comparator := WordCompare(WordStat1.Key, WordStat2.Key);
      CASE Comparator OF
        More:
          BEGIN
            WRITE(StatFile, WordStat1);
            READ(TempStat1, WordStat1)  
          END;
        Less:
          BEGIN
            WRITE(StatFile, WordStat2);
            READ(TempStat2, WordStat2)
          END;
        Equals:
          BEGIN
            WordStat1.Value := WordStat1.Value + WordStat2.Value;
            WRITE(StatFile, WordStat1);
            READ(TempStat1, WordStat1);
            READ(TempStat2, WordStat2) 
          END
      END
    END;
  IF HasFirst AND HasSecond
  THEN
    BEGIN
      Comparator := WordCompare(WordStat1.Key, WordStat2.Key);
      CASE Comparator OF
        More:
          BEGIN
            WRITE(StatFile, WordStat1);
            WRITE(StatFile, WordStat2)
          END;
        Less:
          BEGIN
            WRITE(StatFile, WordStat2);
            WRITE(StatFile, WordStat1)
          END;
        Equals:
          BEGIN
            WordStat1.Value := WordStat1.Value + WordStat2.Value;
            WRITE(StatFile, WordStat1)
          END
      END
    END
  ELSE
    IF HasFirst
    THEN
      WRITE(StatFile, WordStat1)
    ELSE
      WRITE(StatFile, WordStat2);
  CopyFile(TempStat1, StatFile);
  CopyFile(TempStat2, StatFile);
  REWRITE(TempStat1);
  REWRITE(TempStat2)
END; {MergeStat}

PROCEDURE SaveStat(VAR Ptr: WordsBinaryTree; WordCount: INTEGER);
VAR
  TempStat1, TempStat2: WordsBinaryTreeFile;
BEGIN {SaveStat}       
  ASSIGN(TempStat1, 'temp1.DAT');
  ASSIGN(TempStat2, 'temp2.DAT');    
  
  REWRITE(TempStat1);
  REWRITE(TempStat2);
  RESET(StatFile);
  
  CopyFile(StatFile, TempStat1);
  CopyTree(TempStat2, Ptr);
  
  RESET(TempStat1);
  RESET(TempStat2);
  REWRITE(StatFile);
  
  MergeStat(TempStat1, TempStat2);
  WordNumber := WordNumber + WordCount
END; {SaveStat} 

PROCEDURE PrintStat(VAR FOut: TEXT);
VAR
  WordStat: WordStatType;
BEGIN {PrintStat}
  WRITELN(FOut, 'Кол-во слов: ', WordNumber);
  RESET(StatFile);
  WHILE NOT EOF(StatFile)
  DO
    BEGIN
      READ(StatFile, WordStat);
      WRITELN(FOut, WordStat.Key, ' - ', WordStat.Value)
    END
END; {PrintStat}

BEGIN
  ASSIGN(StatFile, 'WordsStat.DAT');
  REWRITE(StatFile);    
  WordNumber := 0
END.                        
