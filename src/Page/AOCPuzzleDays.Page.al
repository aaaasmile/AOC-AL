page 52000 "AOC Days"
{
    ApplicationArea = All;
    Caption = 'Adventure of Code';
    PageType = List;
    SourceTable = "AOC Puzzle Day";
    UsageCategory = Tasks;
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field("Input Test"; g_HasInputTest)
                {
                    ApplicationArea = All;
                }
                field("Input"; g_HasInput)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportPuzzleTest)
            {
                ApplicationArea = All;
                Caption = 'Import Input Test';
                Image = Questionaire;

                trigger OnAction()
                var
                    ImportWaterReadings: Codeunit "Adventure of Code Mgt.";
                begin
                    ImportWaterReadings.SelectAndImportInputTest(Rec);
                end;
            }
            action(ImportPuzzle)
            {
                ApplicationArea = All;
                Caption = 'Import Input';
                Image = Questionaire;

                trigger OnAction()
                var
                    ImportWaterReadings: Codeunit "Adventure of Code Mgt.";
                begin
                    ImportWaterReadings.SelectAndImportInput(Rec);
                end;
            }
        }
        area(Promoted)
        {
            actionref(ImportPuzzle_Promoted; ImportPuzzleTest)
            {
            }
            actionref(ImportPuzzleTest_Promoted; ImportPuzzle)
            {
            }
        }
    }
    var
        g_HasInputTest: Boolean;
        g_HasInput: Boolean;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Puzzle Input", "Puzzle Input Test", "Puzzle Input Test 2");
        g_HasInput := Rec."Puzzle Input".HasValue();
        g_HasInputTest := Rec."Puzzle Input Test".HasValue();
    end;
}