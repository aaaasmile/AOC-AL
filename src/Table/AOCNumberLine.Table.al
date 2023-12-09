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
        end;
    end;
}