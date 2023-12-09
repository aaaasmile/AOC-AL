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
            group(General)
            {
                field(PartNo; g_IsPartOne)
                {
                    Caption = 'Is Part one';
                }
            }
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
                    AdventureOfCodeMgt: Codeunit "Adventure of Code Mgt.";
                begin
                    AdventureOfCodeMgt.SelectAndImportInputTest(Rec);
                    UpdateCalcFields();
                    CurrPage.Update();
                end;
            }
            action(ImportPuzzle)
            {
                ApplicationArea = All;
                Caption = 'Import Input';
                Image = Questionaire;

                trigger OnAction()
                var
                    AdventureOfCodeMgt: Codeunit "Adventure of Code Mgt.";
                begin
                    AdventureOfCodeMgt.SelectAndImportInput(Rec);
                    UpdateCalcFields();
                    CurrPage.Update();
                end;
            }
            action(RunTest)
            {
                ApplicationArea = All;
                Caption = 'Run Test';
                Image = Action;

                trigger OnAction()
                var
                    AdventureOfCodeMgt: Codeunit "Adventure of Code Mgt.";
                begin
                    AdventureOfCodeMgt.RunTest(Rec, g_IsPartOne);
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
            actionref(RunTestPuzzle_Promoted; RunTest)
            {
            }
        }
    }
    var
        g_HasInputTest: Boolean;
        g_HasInput: Boolean;
        g_IsPartOne: Boolean;

    trigger OnAfterGetRecord()
    begin
        UpdateCalcFields();
    end;

    local procedure UpdateCalcFields()
    begin
        Rec.CalcFields("Puzzle Input", "Puzzle Input Test", "Puzzle Input Test 2");
        g_HasInput := Rec."Puzzle Input".HasValue();
        g_HasInputTest := Rec."Puzzle Input Test".HasValue();
    end;
}