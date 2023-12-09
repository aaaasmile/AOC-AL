table 52001 "AOC Number Line"
{
    Caption = 'Number';
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(10; "Value"; Integer)
        {
            Caption = 'Value';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Line No.")
        {
        }
    }

    procedure InsertFromSepSpaceText(LineNo: Integer; LineText: Text)
    var
        NumbersYouHave: List of [Text];
        NumText: Text;
        EntryNo: Integer;
        Num: Integer;
    begin
        // expect something like : 0 4 9 15 22 30 39 49 60 72 85 99 114 130 147
        EntryNo := 0;
        NumbersYouHave := LineText.Trim().Split(' ');
        foreach NumText in NumbersYouHave do begin
            Evaluate(Num, NumText);
            Rec."Entry No." := EntryNo;
            Rec."Line No." := LineNo;
            Rec.Value := Num;
            Rec.Insert();
            EntryNo += 1;
        end;
    end;

    internal procedure DuplicateLineTo(var TempAOCNumberLine: Record "AOC Number Line" temporary; LineNo: Integer)
    begin
        Rec.Reset();
        Rec.SetRange("Line No.", LineNo);
        if Rec.FindSet() then
            repeat
                TempAOCNumberLine."Entry No." := Rec."Entry No.";
                TempAOCNumberLine."Line No." := 0;
                TempAOCNumberLine.Value := Rec.Value;
                TempAOCNumberLine.Insert();
            until Rec.Next() = 0;
    end;

    internal procedure InsertLineFrom(var TempNumSupport: Record "AOC Number Line" temporary; LineNoNext: Integer)
    begin
        TempNumSupport.Reset();
        TempNumSupport.SetRange("Line No.", LineNoNext);
        if TempNumSupport.FindSet() then
            repeat
                Rec."Entry No." := TempNumSupport."Entry No.";
                Rec."Line No." := LineNoNext;
                Rec.Value := TempNumSupport.Value;
                Rec.Insert();
            until TempNumSupport.Next() = 0;
    end;
}