codeunit 52001 "AOC Day 9"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Adventure of Code Mgt.", 'OnRunTestPart1', '', false, false)]
    local procedure C_AdventureofCodeMgt_OnRunTestPart1(Year: Integer; Day: Integer; AllLines: List of [Text]; var Result: Text)
    var
        TempAOCNumberLine: Record "AOC Number Line" temporary;
        Line: Text;
        LineIx: Integer;
        Counter: Decimal;
        LineCounter: Integer;
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
            LineCounter := ExtrapolateLineZero(TempAOCNumberLine, LineNo);
            Counter += LineCounter;
        end;
        Result := Format(Counter);
    end;

    local procedure ExtrapolateLineZero(var TempAOCNumberLine: Record "AOC Number Line" temporary; LineNo: Integer): Integer
    var
        TempNumDiff: Record "AOC Number Line" temporary;
        Addition: Integer;
    begin
        TempAOCNumberLine.DuplicateLineTo(TempNumDiff, LineNo);

        Addition := ExtrapolateDiffLine(TempNumDiff, 0);
        TempNumDiff.Reset();
        TempNumDiff.SetRange("Line No.", 0);
        TempNumDiff.FindLast();
        exit(TempNumDiff.Value + Addition);
    end;

    local procedure ExtrapolateDiffLine(var TempNumDiff: Record "AOC Number Line" temporary; LineNo: Integer): Integer
    var
        TempNumDiffSupport: Record "AOC Number Line" temporary;
        ValA: Integer;
        ValB: Integer;
        Ix: Integer;
        Diff: Integer;
        EntryNo: Integer;
        SumTot: Integer;
        Addition: Integer;
        LineNoNext: Integer;
    begin
        LineNoNext := LineNo + 1;
        Ix := 0;
        TempNumDiff.Reset();
        TempNumDiff.SetRange("Line No.", LineNo);
        TempNumDiff.FindSet();
        repeat
            if Ix = 0 then
                ValA := TempNumDiff.Value
            else begin
                ValB := TempNumDiff.Value;
                Diff := ValB - ValA;
                TempNumDiffSupport."Entry No." := EntryNo;
                TempNumDiffSupport."Line No." := LineNoNext;
                TempNumDiffSupport.Value := Diff;
                TempNumDiffSupport.Insert();
                EntryNo += 1;
                ValA := ValB;
            end;
            Ix += 1;
        until TempNumDiff.Next() = 0;
        TempNumDiff.InsertLineFrom(TempNumDiffSupport, LineNoNext);

        TempNumDiffSupport.Reset();
        TempNumDiffSupport.SetRange("Line No.", LineNoNext);
        TempNumDiffSupport.CalcSums(Value);
        SumTot := TempNumDiffSupport.Value;
        if SumTot = 0 then
            exit(0);

        Addition := ExtrapolateDiffLine(TempNumDiff, LineNoNext);

        TempNumDiff.Reset();
        TempNumDiff.SetRange("Line No.", LineNoNext);
        TempNumDiff.FindLast();
        exit(TempNumDiff.Value + Addition);
    end;
}