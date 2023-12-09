codeunit 52001 "AOC Day 9"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Adventure of Code Mgt.", 'OnRunTestPart1', '', false, false)]
    local procedure C_AdventureofCodeMgt_OnRunTestPart1(Year: Integer; Day: Integer; AllLines: List of [Text]; var Result: Text)
    var
        TempAOCNumberLine: Record "AOC Number Line" temporary;
        Line: Text;
        LineIx: Integer;
        Counter: Integer;
        LineNo: Integer;
    begin
        if (Year <> 2023) or (Day <> 9) then
            exit;
        LineIx := 0;
        foreach Line in AllLines do begin
            TempAOCNumberLine.InsertFromSepSpaceText(LineIx, Line);
            LineIx += 1;
        end;
        Counter := 0;
        for LineNo := 0 to LineIx - 1 do begin
            Counter += ExtrapolateLine(TempAOCNumberLine, LineNo);
        end;
        Result := Format('%1', Counter);

    end;

    local procedure ExtrapolateLine(var TempAOCNumberLine: Record "AOC Number Line" temporary; LineNo: Integer): Integer
    var
        TempNumDiff: Record "AOC Number Line" temporary;
        Addition: Integer;
    begin
        TempAOCNumberLine.DuplicateLineTo(TempNumDiff, LineNo);

        Addition := ExtrapolateDiffLine(TempNumDiff, 0);
        exit(Addition);
    end;

    local procedure ExtrapolateDiffLine(var TempNumDiff: Record "AOC Number Line" temporary; LineNo: Integer): Integer
    var
        TempNumDiffNext: Record "AOC Number Line" temporary;
        ValA: Integer;
        ValB: Integer;
        Ix: Integer;
        Diff: Integer;
        EntryNo: Integer;
        SumTot: Integer;
        Addition: Integer;
    begin
        Ix := 1;
        TempNumDiff.Reset();
        TempNumDiff.SetRange("Line No.", LineNo);
        TempNumDiff.FindSet();
        repeat
            if (Ix mod 2) = 0 then begin
                ValB := TempNumDiff.Value;
                Diff := ValB - ValA;
                TempNumDiffNext."Entry No." := EntryNo;
                TempNumDiffNext."Line No." := LineNo;
                TempNumDiffNext.Value := Diff;
                TempNumDiffNext.Insert();
                EntryNo += 1;
            end else
                ValA := TempNumDiff.Value;

            Ix += 1;
        until TempNumDiff.Next() = 0;

        TempNumDiffNext.Reset();
        TempNumDiffNext.SetRange("Line No.", LineNo);
        TempNumDiffNext.CalcSums(Value);
        SumTot := TempNumDiffNext.Value;
        if SumTot = 0 then
            exit(0);

        LineNo += 1;
        Addition := ExtrapolateDiffLine(TempNumDiff, LineNo);

        LineNo -= 1;
        TempNumDiffNext.Reset();
        TempNumDiffNext.SetRange("Line No.", LineNo);
        TempNumDiffNext.FindLast();
        exit(TempNumDiffNext.Value + Addition);
    end;
}