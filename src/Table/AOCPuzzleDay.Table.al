table 52000 "AOC Puzzle Day"
{
    Caption = 'Puzzle';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(10; Year; Integer)
        {
            Caption = 'Year';
        }
        field(15; Day; Integer)
        {
            Caption = 'Day';
        }
        field(20; "Puzzle Input"; Blob)
        {
            Caption = 'Puzzle Input';
        }
        field(25; "Puzzle Input Test"; Blob)
        {
            Caption = 'Puzzle Input Test';
        }
        field(30; "Puzzle Input Test 2"; Blob)
        {
            Caption = 'Puzzle Input Test 2';
        }

    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}