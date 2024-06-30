page 50124 "Diagnosis Description List"
{
    ApplicationArea = All;
    Caption = 'Diagnosis Description List';
    PageType = List;
    SourceTable = "Diagnosis Description";
    UsageCategory = Lists;

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
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    //FieldPropertyName = FieldPropertyValue;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    //FieldPropertyName = FieldPropertyValue;
                }
            }
        }
    }
}
