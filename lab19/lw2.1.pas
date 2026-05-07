PROGRAM SortDate(INPUT, OUTPUT);
USES
  DateIO;
VAR
  MyDate, GetDate: Date;
  F: FileOfDate;

BEGIN
  MyDate.Mo := DEC;
  MyDate.Day := 31;
  
  ASSIGN(F, 'DATE.DAT');
  REWRITE(F);
  WRITE(F, MyDate);
  
  CopyOut(F)
END.
