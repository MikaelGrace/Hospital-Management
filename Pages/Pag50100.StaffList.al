page 50123 "Staff List"
{
    ApplicationArea = All;
    Caption = 'Staff List';
    PageType = List;
    SourceTable = Staff;
    UsageCategory = Lists;
    CardPageId = 50119;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No. field.', Comment = '%';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
            }
        }
    }
}
