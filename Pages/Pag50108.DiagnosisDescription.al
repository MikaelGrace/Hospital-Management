page 50115 "Diagnosis Description"
{
    Caption = 'Diagnosis Description';
    PageType = Document;
    SourceTable = "Diagnosis Description Header";
    Editable = true;
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(DiagnosisLines; "Diagnosis SubForm")
            {
                SubPageLink = "Document No." = field(Code);
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Close Diagnosis")
            {
                Caption = 'Close Diagnosis';
                Image = Action;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify();
                    DiagnosisDescriptionDocument.SetRecord(Rec);
                    CurrPage.Close();
                    DiagnosisDescriptionDocument.Editable := false;
                    DiagnosisDescriptionDocument.Run();

                end;
            }
            action("Reopen Diagnosis")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Modify();
                    DiagnosisDescriptionDocument.Editable := true;
                    DiagnosisDescriptionDocument.Run();
                end;
            }
        }
    }

    var
        IsEditable: Boolean;
        DiagnosisDescriptionDocument: Page "Diagnosis Description";

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Closed then
            CurrPage.Editable := false;
    end;
}
