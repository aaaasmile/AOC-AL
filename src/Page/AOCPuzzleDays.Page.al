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
                field(Day; Rec.Day)
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
            action(ImportPuzle)
            {
                ApplicationArea = All;
                Caption = 'Import Puzzle';
                Image = Questionaire;
                ToolTip = 'Import Puzzle';

                trigger OnAction()
                var
                    ImportWaterReadings: Codeunit "Adventure of Code Mgt.";
                begin
                    ImportWaterReadings.SelectAndImportPuzzle(Rec);
                end;
            }
            // action(RemovePuzleInput)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Remove Puzzle Input';
            //     Image = Delete;
            //     ToolTip = 'Remove Puzzle Input';

            //     // trigger OnAction()
            //     // var
            //     //     ImportWaterReadings: Codeunit "Adventure of Code Mgt.";
            //     // begin
            //     //     ImportWaterReadings.RemovePuzzleInput(Rec);
            //     // end;
            // }
        }
        area(Promoted)
        {
            actionref(ImportPuzle_Promoted; ImportPuzle)
            {
            }
        }
    }
}