page 50101 "Ward Subform"
{
    Caption = 'Ward Subform';
    PageType = ListPart;
    SourceTable = "Ward Line";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Diagnosis No."; Rec."Diagnosis No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Diagnosis No. field.', Comment = '%';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Patient Name field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Unit Charge"; Rec."Unit Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Charge field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Days field.', Comment = '%';
                }
                field("Total Bed Charge"; Rec."Total Bed Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Bed Charge field.', Comment = '%';
                }
            }
        }
    }
}
