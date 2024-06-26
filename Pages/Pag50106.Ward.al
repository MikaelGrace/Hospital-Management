page 50117 Ward
{
    Caption = 'Ward';
    PageType = Card;
    SourceTable = Ward;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
