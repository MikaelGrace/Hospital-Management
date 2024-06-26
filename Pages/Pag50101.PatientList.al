page 50122 "Patient List"
{
    ApplicationArea = All;
    Caption = 'Patient List';
    PageType = List;
    SourceTable = Patient;
    UsageCategory = Lists;
    CardPageId = 50118;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
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
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blood Group field.', Comment = '%';
                }
            }
        }
    }
}
