codeunit 52000 "Adventure of Code Mgt."
{
    var
        FileManagement: Codeunit "File Management";
        FileFilterExtensionTxt: Label 'txt,csv', Locked = true;
        FileFilterTxt: Label 'Text Files(*.txt;*.csv)|*.txt;*.csv';
        ImportPuzzleLbl: Label 'Select puzzle input file';

    procedure SelectAndImportPuzzle(Puzzle: Record "AOC Puzzle Day")
    var
        TempBlob: Codeunit "Temp Blob";
        PuzzleInStream: InStream;
        PuzzleOutStream: OutStream;
        FileName: Text;
    begin
        Puzzle.CalcFields("Puzzle Imput");
        if not Puzzle."Puzzle Imput".HasValue then begin
            FileName := GetFileName(TempBlob);
            if FileName <> '' then begin
                TempBlob.CreateInStream(PuzzleInStream);
                Puzzle."Puzzle Imput".CreateOutStream(PuzzleOutStream);
                CopyStream(PuzzleOutStream, PuzzleInStream);
                Puzzle.Modify();
            end;
        end;
    end;

    procedure RemovePuzzleInputTest(Puzzle: Record "AOC Puzzle Day")
    begin
        Puzzle.CalcFields("Puzzle Imput");
        Clear(Puzzle."Puzzle Imput");
        Puzzle.Modify();
    end;

    procedure RemovePuzzleInputReal(Puzzle: Record "AOC Puzzle Day")
    begin
        Puzzle.CalcFields("Puzzle Imput");
        Clear(Puzzle."Puzzle Imput");
        Puzzle.Modify();
    end;

    local procedure GetFileName(var TempBlob: Codeunit "Temp Blob") FileName: Text
    begin
        FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportPuzzleLbl, '', FileFilterTxt, FileFilterExtensionTxt);
    end;
}