codeunit 52001 "AOC Day 9"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Adventure of Code Mgt.", 'OnRunTest', '', false, false)]
    local procedure C_AdventureofCodeMgt_OnRunTest(Year: Integer; Day: Integer; AllLines: List of [Text]; var Result: Text)
    var
        Line: Text;
    begin
        if (Year <> 2023) or (Day <> 9) then
            exit;
        foreach Line in AllLines do begin

        end;
    end;
}