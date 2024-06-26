page 50115 "Diagnosis Description"
{
    Caption = 'Diagnosis Description';
    PageType = Document;
    SourceTable = "Diagnosis Description Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blood Group field.', Comment = '%';
                }
                field(Genotype; Rec.Genotype)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Genotype field.', Comment = '%';
                }
                field("Doctor No."; Rec."Doctor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Doctor No. field.', Comment = '%';
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Doctor Name field.', Comment = '%';
                }
                field("Ward No."; Rec."Ward No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ward number field.', Comment = '%';
                }
            }
            part(DiagnosisLines; "Diagnosis SubForm")
            {
                SubPageLink = "Document No." = field(Code);
                UpdatePropagation = Both;
            }
        }
    }
}
