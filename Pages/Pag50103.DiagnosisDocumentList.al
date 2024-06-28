page 50120 "Diagnosis Document List"
{
    ApplicationArea = All;
    Caption = 'Diagnosis Document List';
    PageType = List;
    SourceTable = "Diagnosis Description Header";
    UsageCategory = Lists;
    CardPageId = 50115;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
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
                field("Ward No."; Rec."Ward No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ward number field.', Comment = '%';
                }
            }
        }
    }
}
