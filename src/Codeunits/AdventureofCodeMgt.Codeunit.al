codeunit 52000 "Adventure of Code Mgt."
{
    var
        FileManagement: Codeunit "File Management";
        FileFilterExtensionTxt: Label 'md', Locked = true;
        FileFilterTxt: Label 'Text Files(*.txt;*.md)|*.txt;*.md', Locked = true;
        ImportPuzzleLbl: Label 'Select puzzle input file';
        ImportTestPuzzleLbl: Label 'Select puzzle Input Test file';

    local procedure SelectAndImport(var Puzzle: Record "AOC Puzzle Day"; var PuzzleOutStream: OutStream; IsTest: Boolean)
    var
        TempBlob: Codeunit "Temp Blob";
        PuzzleInStream: InStream;
        FileName: Text;
    begin
        FileName := GetFileName(TempBlob, IsTest);
        if FileName <> '' then begin
            TempBlob.CreateInStream(PuzzleInStream);
            CopyStream(PuzzleOutStream, PuzzleInStream);
            Puzzle.Modify();
        end;
    end;

    procedure SelectAndImportInput(var Puzzle: Record "AOC Puzzle Day")
    var
        PuzzleOutStream: OutStream;
    begin
        Puzzle."Puzzle Input".CreateOutStream(PuzzleOutStream);
        SelectAndImport(Puzzle, PuzzleOutStream, false);
    end;

    procedure SelectAndImportInputTest(var Puzzle: Record "AOC Puzzle Day")
    var
        PuzzleOutStream: OutStream;
    begin
        Puzzle."Puzzle Input Test".CreateOutStream(PuzzleOutStream);
        SelectAndImport(Puzzle, PuzzleOutStream, true);
    end;

    local procedure GetFileName(var TempBlob: Codeunit "Temp Blob"; IsTest: Boolean) FileName: Text
    begin
        if IsTest then
            FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTestPuzzleLbl, '', FileFilterTxt, FileFilterExtensionTxt)
        else
            FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportPuzzleLbl, '', FileFilterTxt, FileFilterExtensionTxt);
    end;

    procedure RunInput(Puzzle: Record "AOC Puzzle Day"; IsPart1: Boolean)
    var
        SourceInStream: InStream;
        Line: Text;
        AllLines: List of [Text];
        Result: Text;
    begin
        Puzzle.CalcFields("Puzzle Input");
        if not Puzzle."Puzzle Input".HasValue() then
            Error('No input imported');

        Puzzle."Puzzle Input".CreateInStream(SourceInStream);
        while not SourceInStream.EOS do begin
            SourceInStream.ReadText(Line);
            Line := Line.Trim();
            AllLines.Add(Line);
        end;
        if IsPart1 then
            OnRunTestPart1(Puzzle.Year, Puzzle.Day, AllLines, Result)
        else
            OnRunTestPart2(Puzzle.Year, Puzzle.Day, AllLines, Result);

        if GuiAllowed then
            Message('Result is %1', Result);
    end;

    procedure RunTest(Puzzle: Record "AOC Puzzle Day"; IsPart1: Boolean)
    var
        SourceInStream: InStream;
        Line: Text;
        AllLines: List of [Text];
        Result: Text;
    begin
        Puzzle.CalcFields("Puzzle Input Test");
        if Puzzle."Puzzle Input Test".HasValue() then
            Error('No test imported');
        Puzzle."Puzzle Input Test".CreateInStream(SourceInStream);
        while not SourceInStream.EOS do begin
            SourceInStream.ReadText(Line);
            Line := Line.Trim();
            AllLines.Add(Line);
        end;
        if IsPart1 then
            OnRunTestPart1(Puzzle.Year, Puzzle.Day, AllLines, Result)
        else
            OnRunTestPart2(Puzzle.Year, Puzzle.Day, AllLines, Result);
        Message('Result is %1', Result);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnRunTestPart1(Year: Integer; Day: Integer; AllLines: List of [Text]; var Result: Text)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnRunTestPart2(Year: Integer; Day: Integer; AllLines: List of [Text]; var Result: Text)
    begin
    end;
}