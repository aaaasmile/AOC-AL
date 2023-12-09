codeunit 52001 "AOC Day 9"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Adventure of Code Mgt.", 'OnRunTestPart1', '', false, false)]
    local procedure C_AdventureofCodeMgt_OnRunTestPart1(Year: Integer; Day: Integer; AllLines: List of [Text]; var Result: Text)
    var
        TempAOCNumberLine: Record "AOC Number Line" temporary;
        Line: Text;
        LineIx: Integer;
        Counter: Integer;
        i: Integer;
    begin
        if (Year <> 2023) or (Day <> 9) then
            exit;
        LineIx := 0;
        foreach Line in AllLines do begin
            TempAOCNumberLine.InsertFromSepSpaceText(LineIx, Line);
            LineIx += 1;
        end;
        Counter := 0;
        for i := 0 to LineIx - 1 do begin
            TempAOCNumberLine.Reset();
            TempAOCNumberLine.SetRange("Line No.", i);

            Counter += ExtrapolateLine(TempAOCNumberLine);
        end;
        Result := Format('%1', Counter);

    end;

    local procedure ExtrapolateLine(var TempAOCNumberLine: Record "AOC Number Line" temporary): Integer
    var
        TempNumDiff: Record "AOC Number Line" temporary;
        ValA: Integer;
        ValB: Integer;
        Ix: Integer;
        Diff: Integer;
        EntryNo: Integer;
        LineNo: Integer;
        SumTot: Integer;
        Addition: Integer;
    begin
        TempAOCNumberLine.FindSet();
        repeat
            if (Ix mod 2) = 0 then begin
                ValB := TempAOCNumberLine.Value;
                Diff := ValA - ValB;
                TempNumDiff."Entry No." := EntryNo;
                TempNumDiff."Line No." := LineNo;
                TempNumDiff.Value := Diff;
                TempNumDiff.Insert();
                EntryNo += 1;
            end else
                ValA := TempAOCNumberLine.Value;

            Ix += 1;
        until TempAOCNumberLine.Next() = 0;
        TempNumDiff.Reset();
        TempNumDiff.SetRange("Line No.", LineNo);
        TempNumDiff.CalcSums(Value);
        SumTot := TempNumDiff.Value;
        if SumTot = 0 then
            exit(0);

        LineNo += 1;
        Addition := ExtrapolateDiffLine(TempNumDiff, LineNo);
        exit(Addition);
    end;
}