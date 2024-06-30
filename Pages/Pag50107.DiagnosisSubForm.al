page 50116 "Diagnosis SubForm"
{
    Caption = 'Diagnosis SubForm';
    PageType = ListPart;
    SourceTable = "Diagnosis Description Line";
    AutoSplitKey = true;
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Test No."; Rec."Test No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Charge; Rec.Charge)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
