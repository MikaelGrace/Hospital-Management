page 50115 "Diagnosis Document"
{
    Caption = 'Diagnosis Document';
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
                field(Charge; Rec."Total Charges")
                {
                    ApplicationArea = All;
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
        area(Navigation)
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
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify();
                    DiagnosisDescriptionDocument.Editable := true;
                    DiagnosisDescriptionDocument.Run();
                end;
            }

        }
        area(Processing)
        {
            action("Create Sales Order")
            {
                ApplicationArea = All;
                ToolTip = 'Create a sales order from the diagnosis document';
                trigger OnAction()
                var
                    CustNo: Code[20];
                    LineNo: Integer;
                begin
                    // Set Customer No. here. You can set it based on some field in your Diagnostics Document or statically
                    // Example customer number

                    // Initialize and insert Sales Header
                    SalesAndReceivableSetupRec.Get();
                    SalesHeaderRec.Init();
                    SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
                    SalesHeaderRec.Insert(true);
                    SalesHeaderRec.Validate("Sell-to Customer No.", Rec."Patient No.");
                    SalesHeaderRec.Modify();

                    // Loop through the Diagnostics Lines and create Sales Lines
                    DiagnosisDescriptionLineRec.SetRange("Document No.", Rec.Code);
                    if DiagnosisDescriptionLineRec.FindSet() then
                        repeat
                            LineNo += 10000;
                            SalesLineRec.Init();
                            SalesLineRec.Validate("Document Type", SalesHeaderRec."Document Type");
                            SalesLineRec.Validate("Document No.", SalesHeaderRec."No.");
                            SalesLineRec.Validate(Type, SalesLineRec.Type::"G/L Account"); // Adjust the type based on your need
                            SalesLineRec.Validate("No.", SalesAndReceivableSetupRec."Service Account");
                            SalesLineRec.Validate(Description, DiagnosisDescriptionLineRec.Description);
                            SalesLineRec.Validate(Quantity, 1); // Set the quantity based on your need
                            SalesLineRec.Validate("Unit Price", DiagnosisDescriptionLineRec.Charge);
                            SalesLineRec.Validate("Line No.", LineNo);
                            SalesLineRec.Insert(true);
                        until DiagnosisDescriptionLineRec.Next() = 0;

                    // Open the created Sales Order
                    Page.Run(Page::"Sales Order", SalesHeaderRec);
                end;
            }
        }
    }

    var
        IsEditable: Boolean;
        DiagnosisDescriptionDocument: Page "Diagnosis Document";
        SalesHeaderRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        DiagnosisDescriptionLineRec: Record "Diagnosis Description Line";
        SalesAndReceivableSetupRec: Record "Sales & Receivables Setup";

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Closed then
            CurrPage.Editable := false;
    end;
}
