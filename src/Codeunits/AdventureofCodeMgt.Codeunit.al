codeunit 52000 "Adventure of Code Mgt."
{
    var
        FileManagement: Codeunit "File Management";
        FileFilterExtensionTxt: Label 'txt,csv', Locked = true;
        FileFilterTxt: Label 'Text Files(*.txt;*.csv)|*.txt;*.csv', Locked = true;
        ImportPuzzleLbl: Label 'Select puzzle input file';

    procedure SelectAndImport(RecRef: RecordRef; PuzzleOutStream: OutStream)
    var
        TempBlob: Codeunit "Temp Blob";
        PuzzleInStream: InStream;
        FileName: Text;
    begin
        FileName := GetFileName(TempBlob);
        if FileName <> '' then begin
            TempBlob.CreateInStream(PuzzleInStream);
            CopyStream(PuzzleOutStream, PuzzleInStream);
            RecRef.Modify();
        end;
    end;

    procedure SelectAndImportInput(Puzzle: Record "AOC Puzzle Day")
    var
        RecRef: RecordRef;
        PuzzleOutStream: OutStream;
    begin
        RecRef.GetTable(Puzzle);
        Puzzle."Puzzle Input".CreateOutStream(PuzzleOutStream);
        SelectAndImport(RecRef, PuzzleOutStream);
    end;

    procedure SelectAndImportInputTest(Puzzle: Record "AOC Puzzle Day")
    var
        RecRef: RecordRef;
        PuzzleOutStream: OutStream;
    begin
        RecRef.GetTable(Puzzle);
        Puzzle."Puzzle Input Test".CreateOutStream(PuzzleOutStream);
        SelectAndImport(RecRef, PuzzleOutStream);
    end;

    local procedure GetFileName(var TempBlob: Codeunit "Temp Blob") FileName: Text
    begin
        FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportPuzzleLbl, '', FileFilterTxt, FileFilterExtensionTxt);
    end;
}