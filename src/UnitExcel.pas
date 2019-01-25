unit UnitExcel;


interface

uses  Windows, SysUtils, Classes, Db, dbgrids, math;

type
     // TDataSetToExcel
     TDataSetToExcel = class(TObject)
     protected
       procedure WriteToken(AToken : word; ALength : word);
       procedure WriteFont(const AFontName : string; AFontHeight,
			   AAttribute : word);
       procedure WriteFormat(const AFormatStr : string);
     private
       FRow : word;
       FDataFile : file;
       FFileName : string;
       FDataSet : TDataSet;
       FDbGrid : TDbGrid;
     public
       constructor Create(ADataSet : TDataSet;const AFileName : string);
       function WriteFile(option : integer) : boolean;
     end;

implementation

(*****************EXCEL RELATES ROUTINES**************)
const
      // XL Tokens
      XL_DIM       = $00;
      XL_BOF       = $09;
      XL_EOF       = $0A;
      XL_DOCUMENT  = $10;
      XL_FORMAT    = $1E;
      XL_COLWIDTH  = $24;
      XL_FONT      = $31;

      // XL Cell Types
      XL_INTEGER   = $02;
      XL_DOUBLE    = $03;
      XL_STRING    = $04;

      // XL Cell Formats
      XL_INTFORMAT = $81;
      XL_DBLFORMAT = $82;
      XL_XDTFORMAT = $83;
      XL_DTEFORMAT = $84;
      XL_TMEFORMAT = $85;
      XL_HEADBOLD  = $40;
      XL_HEADSHADE = $F8;

// ========================
// Create the class
// ========================

constructor TDataSetToExcel.Create(ADataSet : TDataSet; const AFileName : string);
begin
  FDataSet := ADataSet;
  FFileName := ChangeFileExt(AFilename,'.xls');
end;

// ====================================
// Write a Token Descripton Header
// ====================================

procedure TDataSetToExcel.WriteToken(AToken : word; ALength : word);
var aTOKBuffer : array [0..1] of word;
begin
  aTOKBuffer[0] := AToken;
  aTOKBuffer[1] := ALength;
  Blockwrite(FDataFile,aTOKBuffer,SizeOf(aTOKBuffer));
end;

// ====================================
// Write the font information
// ====================================

procedure TDataSetToExcel.WriteFont(const AFontName : string;
                                    AFontHeight,AAttribute : word);
var iLen : byte;
begin
  AFontHeight := AFontHeight * 20;
  WriteToken(XL_FONT,5 + length(AFontName));
  BlockWrite(FDataFile,AFontHeight,2);
  BlockWrite(FDataFile,AAttribute,2);
  iLen := length(AFontName);
  BlockWrite(FDataFile,iLen,1);
  BlockWrite(FDataFile,AFontName[1],iLen);
end;

// ====================================
// Write the format information
// ====================================

procedure TDataSetToExcel.WriteFormat(const AFormatStr : string);
var iLen : byte;
begin
  WriteToken(XL_FORMAT,1 + length(AFormatStr));
  iLen := length(AFormatStr);
  BlockWrite(FDataFile,iLen,1);
  BlockWrite(FDataFile,AFormatStr[1],iLen);
end;

// ====================================
// Write the XL file from data set
// ====================================

function TDataSetToExcel.WriteFile(OPTION : integer) : boolean;
var bRetvar : boolean;
    aDOCBuffer : array [0..1] of word;
    aDIMBuffer : array [0..3] of word;
    aAttributes : array [0..2] of byte;
    i,j,k : integer;
    iColNum,
    iDataLen : byte;
    sStrData : string;
    fDblData : double;
    wWidth : word;
begin
  bRetvar := true;
  FRow := 0;
  FillChar(aAttributes,SizeOf(aAttributes),0);
  AssignFile(FDataFile,FFileName);

  try
    Rewrite(FDataFile,1);
    // Beginning of File
    WriteToken(XL_BOF,4);
    aDOCBuffer[0] := 0;
    aDOCBuffer[1] := XL_DOCUMENT;
    Blockwrite(FDataFile,aDOCBuffer,SizeOf(aDOCBuffer));

    // Font Table
    WriteFont('Arial',10,0);
    WriteFont('Arial',10,1);
    WriteFont('Courier New',11,0);

    // Column widths
    for i := 0 to FDataSet.FieldCount - 1 do begin
      wWidth := (FDataSet.Fields[i].DisplayWidth + 1) * 256;
      if FDataSet.FieldDefs[i].DataType = ftDateTime then inc(wWidth,2000);
      if FDataSet.FieldDefs[i].DataType = ftDate then inc(wWidth,1050);
      if FDataSet.FieldDefs[i].DataType = ftTime then inc(wWidth,100);
      WriteToken(XL_COLWIDTH,4);
      iColNum := i;
      BlockWrite(FDataFile,iColNum,1);
      BlockWrite(FDataFile,iColNum,1);
      BlockWrite(FDataFile,wWidth,2);
    end;

    // Column Formats
    WriteFormat('General');
    WriteFormat('0');
    WriteFormat('###,###,##0.00');
    WriteFormat('dd-mmm-yyyy hh:mm:ss');
    WriteFormat('dd-mmm-yyyy');
    WriteFormat('hh:mm:ss');

    // Dimensions
    WriteToken(XL_DIM,8);
    aDIMBuffer[0] := 0;
    aDIMBuffer[1] := Min(FDataSet.RecordCount,$FFFF);
    aDIMBuffer[2] := 0;
    aDIMBuffer[3] := Min(FDataSet.FieldCount - 1,$FFFF);
    Blockwrite(FDataFile,aDIMBuffer,SizeOf(aDIMBuffer));

    // Column Headers
    for i := 0 to FDataSet.FieldCount - 1 do
    begin
      sStrData := FDataSet.Fields[i].DisplayName;
      iDataLen := length(sStrData);
      WriteToken(XL_STRING,iDataLen + 8);
      WriteToken(FRow,i);
      aAttributes[1] := XL_HEADBOLD;
      aAttributes[2] := XL_HEADSHADE;
      BlockWrite(FDataFile,aAttributes,SizeOf(aAttributes));
      BlockWrite(FDataFile,iDataLen,SizeOf(iDataLen));
      if iDataLen > 0 then BlockWrite(FDataFile,sStrData[1],iDataLen);
      aAttributes[2] := 0;
    end;

    // ALL Data Rows are exported
    Fdataset.First;
    while not FDataSet.Eof do
    begin
      inc(FRow);
      for i := 0 to FDataSet.FieldCount - 1 do
      begin
      case FDataSet.FieldDefs[i].DataType of
        ftBoolean,ftWideString,ftFixedChar,
        ftString    : begin
            sStrData :=TrimRight(FDataSet.Fields[i].AsString);
            iDataLen := length(sStrData);
            WriteToken(XL_STRING,iDataLen + 8);
            WriteToken(FRow,i);
            aAttributes[1] := 0;
            BlockWrite(FDataFile,aAttributes,SizeOf(aAttributes));
            BlockWrite(FDataFile,iDataLen,SizeOf(iDataLen));
            if iDataLen > 0 then
              BlockWrite(FDataFile,sStrData[1],iDataLen);
          end;

        ftAutoInc,ftSmallInt,ftInteger,ftWord,ftLargeInt  :
         begin
            fDblData := FDataSet.Fields[i].AsFloat;
            iDataLen := SizeOf(fDblData);
            WriteToken(XL_DOUBLE,15);
            WriteToken(FRow,i);
            aAttributes[1] := XL_INTFORMAT;
            BlockWrite(FDataFile,aAttributes,SizeOf(aAttributes));
            BlockWrite(FDataFile,fDblData,iDatalen);
          end;

        ftFloat,
        ftCurrency,
        ftBcd :
          begin
            fDblData := FDataSet.Fields[i].AsFloat;
            iDataLen := SizeOf(fDblData);
            WriteToken(XL_DOUBLE,15);
            WriteToken(FRow,i);
            aAttributes[1] := XL_DBLFORMAT;
            BlockWrite(FDataFile,aAttributes,SizeOf(aAttributes));
            BlockWrite(FDataFile,fDblData,iDatalen);
          end;
        ftDateTime :
          begin
            fDblData := FDataSet.Fields[i].AsFloat;
            iDataLen := SizeOf(fDblData);
            WriteToken(XL_DOUBLE,15);
            WriteToken(FRow,i);
            aAttributes[1] := XL_XDTFORMAT;
            BlockWrite(FDataFile,aAttributes,SizeOf(aAttributes));
            BlockWrite(FDataFile,fDblData,iDatalen);
          end;

        ftDate :
          begin
            fDblData := FDataSet.Fields[i].AsFloat;
            iDataLen := SizeOf(fDblData);
            WriteToken(XL_DOUBLE,15);
            WriteToken(FRow,i);
            aAttributes[1] := XL_DTEFORMAT;
            BlockWrite(FDataFile,aAttributes,SizeOf(aAttributes));
            BlockWrite(FDataFile,fDblData,iDatalen);
          end;

        ftTime :
         begin
            fDblData := FDataSet.Fields[i].AsFloat;
            iDataLen := SizeOf(fDblData);
            WriteToken(XL_DOUBLE,15);
            WriteToken(FRow,i);
            aAttributes[1] := XL_TMEFORMAT;
            BlockWrite(FDataFile,aAttributes,SizeOf(aAttributes));
            BlockWrite(FDataFile,fDblData,iDatalen);
          end;
      end;
      end;
      FDataSet.Next;
    end;
    //end;
    // End of File
    WriteToken(XL_EOF,0);
    CloseFile(FDataFile);
    fdataset.First
  except
    bRetvar := false;
  end;
  Result := bRetvar;
end;

end.


