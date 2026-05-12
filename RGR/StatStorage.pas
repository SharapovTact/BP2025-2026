UNIT StatStorage;

INTERFACE
USES
  WordBinaryTree;
  
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
BEGIN {MergeStat}
  CopyFile(TempStat1, StatFile);
  CopyFile(TempStat2, StatFile)
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
