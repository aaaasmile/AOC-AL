table 52000 "AOC Puzzle Day"
{
    Caption = 'Puzzle';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Year; Integer)
        {
            Caption = 'Year';
        }
        field(2; Day; Integer)
        {
            Caption = 'Day';
        }
        field(3; URL; Text[1024])
        {
            Caption = 'URL to puzzle text and file';
            ExtendedDatatype = URL;
        }
        field(5; "Puzzle Imput"; Blob)
        {
            Caption = 'Puzzle Imput';
        }
    }

    keys
    {
        key(PK; Year, Day)
        {
            Clustered = true;
        }
    }
}