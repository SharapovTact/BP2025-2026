PROGRAM SortDate(INPUT, OUTPUT);
USES
  DateIO;
VAR
  Copying: BOOLEAN;
  D, VarDate: Date;
  TFile, DateFile: FileOfDate;
  FInput: TEXT;
CONST
  InputFile = 'FI.TXT';
  TempFile = 'TF.DAT';
  DatesFile = 'DF.DAT';

BEGIN
  ASSIGN(DateFile, DatesFile);
  ASSIGN(TFile, TempFile);
  ASSIGN(FInput, InputFile);
  
  REWRITE(DateFile);
  RESET(FInput);
  
  ReadDate(FInput, VarDate);
  READLN(FInput);
  WRITE(DateFile, VarDate);
  RESET(DateFile);
  
  WHILE NOT EOF(FInput)
  DO
    BEGIN
      RESET(DateFile);
      ReadDate(FInput, D);
      READLN(FInput);
      IF (D.Mo <> NoMonth)
      THEN
        BEGIN
          REWRITE(TFile);
          Copying := TRUE;
          WHILE NOT EOF(DateFile) AND Copying
          DO
            BEGIN
              READ(DateFile, VarDate);
              IF Less(VarDate, D)
              THEN
                WRITE(TFile, VarDate)
              ELSE
                BEGIN
                  Copying := FALSE;
                  WRITE(TFile, D);
                  WRITE(TFile, VarDate)
                END
            END;
          IF Copying
          THEN
            WRITE(TFile, D);
            
          WHILE NOT EOF(DateFile)
          DO
            BEGIN
              READ(DateFile, VarDate);
              WRITE(TFile, VarDate)
            END;
            
          RESET(TFile);
          REWRITE(DateFile);
          WHILE NOT EOF(TFile)
          DO
            BEGIN
              READ(TFile, VarDate);
              WRITE(DateFile, VarDate)
            END
        END
    END;
  RESET(DateFile);
  WRITELN;
  CopyOut(DateFile)
END.
