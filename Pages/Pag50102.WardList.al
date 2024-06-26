page 50121 "Ward List"
{
    ApplicationArea = All;
    Caption = 'Ward List';
    PageType = List;
    SourceTable = Ward;
    UsageCategory = Lists;
    CardPageId = 50117;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Ward No."; Rec."Ward No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ward No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
            }
        }
    }
}
