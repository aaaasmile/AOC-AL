codeunit 52000 "Adventure of Code Mgt."
{
    var
        FileManagement: Codeunit "File Management";
        FileFilterExtensionTxt: Label 'txt,csv', Locked = true;
        FileFilterTxt: Label 'Text Files(*.txt;*.csv)|*.txt;*.csv', Locked = true;
        ImportPuzzleLbl: Label 'Select puzzle input file';
        ImportTestPuzzleLbl: Label 'Select puzzle Input Test file';

    local procedure SelectAndImport(var RecRef: RecordRef; var PuzzleOutStream: OutStream; IsTest: Boolean)
    var
        TempBlob: Codeunit "Temp Blob";
        PuzzleInStream: InStream;
        FileName: Text;
    begin
        FileName := GetFileName(TempBlob, IsTest);
        if FileName <> '' then begin
            TempBlob.CreateInStream(PuzzleInStream);
            CopyStream(PuzzleOutStream, PuzzleInStream);
            RecRef.Modify();
        end;
    end;

    procedure SelectAndImportInput(var Puzzle: Record "AOC Puzzle Day")
    var
        RecRef: RecordRef;
        PuzzleOutStream: OutStream;
    begin
        RecRef.GetTable(Puzzle);
        Puzzle."Puzzle Input".CreateOutStream(PuzzleOutStream);
        SelectAndImport(RecRef, PuzzleOutStream, false);
    end;

    procedure SelectAndImportInputTest(var Puzzle: Record "AOC Puzzle Day")
    var
        RecRef: RecordRef;
        PuzzleOutStream: OutStream;
    begin
        RecRef.GetTable(Puzzle);
        Puzzle."Puzzle Input Test".CreateOutStream(PuzzleOutStream);
        SelectAndImport(RecRef, PuzzleOutStream, true);
    end;

    local procedure GetFileName(var TempBlob: Codeunit "Temp Blob"; IsTest: Boolean) FileName: Text
    begin
        if IsTest then
            FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTestPuzzleLbl, '', FileFilterTxt, FileFilterExtensionTxt)
        else
            FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportPuzzleLbl, '', FileFilterTxt, FileFilterExtensionTxt);
    end;

    procedure RunTest(Puzzle: Record "AOC Puzzle Day")
    var
        SourceInStream: InStream;
        Line: Text;
        AllLines: List of [Text];
        Result: Text;
    begin
        Puzzle."Puzzle Input Test".CreateInStream(SourceInStream);
        while not SourceInStream.EOS do begin
            SourceInStream.ReadText(Line);
            Line := Line.Trim();
            AllLines.Add(Line);
        end;
        OnRunTest(Puzzle.Year, Puzzle.Day, AllLines, Result);
        Message('Result is %1', Result);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnRunTest(Year: Integer; Day: Integer; AllLines: List of [Text]; var Result: Text)
    begin
    end;
}