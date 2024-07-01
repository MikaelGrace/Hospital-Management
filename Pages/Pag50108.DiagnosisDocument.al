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
                    trigger OnValidate()
                    var
                        LineNo: Integer;
                        OpenedCount: Integer;
                        MaxLineNo: Integer;

                    begin
                        MaxLineNo := 0; //initialize maxLineNo

                        if Rec."Ward No." <> '' then begin
                            WardHeaderRec.SetRange("Ward No.", Rec."Ward No.");
                            if WardHeaderRec.FindFirst() then begin
                                WardLineRec.SetRange("Document No.", Rec."Ward No.");
                                WardLineRec.SetRange(Status, WardLineRec.Status::Open);
                                OpenedCount := WardLineRec.Count();

                                if OpenedCount < WardHeaderRec."No. Of Beds" then begin
                                    WardLineRec.SetRange("Document No.", Rec."Ward No.");
                                    WardLineRec.Reset();
                                    if WardLineRec.FindLast() then begin
                                        MaxLineNo := WardLineRec."Line No.";
                                    end;

                                    MaxLineNo += 10000; //increment by 10000 for new line

                                    WardLineRec.Init();
                                    WardLineRec."Document No." := WardHeaderRec."Ward No.";
                                    WardLineRec."Diagnosis No." := Rec.Code;
                                    WardLineRec."Line No." := MaxLineNo; //ensure line number is set correctly
                                    WardLineRec."Start Date" := Today;
                                    WardLineRec."Patient Name" := Rec."First Name" + ' ' + Rec."Last Name";
                                    WardLineRec."Patient No." := Rec."Patient No.";
                                    WardLineRec.Status := WardLineRec.Status::Open;
                                    WardLineRec.Description := WardHeaderRec.Description;
                                    WardLineRec."Unit Charge" := WardHeaderRec."Bed Charge";
                                    WardLineRec.Insert();
                                end
                                else
                                    Dialog.Error('This ward is fully occupied');
                            end;
                        end;
                    end;
                }
                field("Total Charges"; Rec."Total Charges")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(DiagnosisLines; "Diagnosis SubForm")
            {
                //ApplicationArea = All;
                SubPageLink = "Document No." = field(Code);
                UpdatePropagation = Both;
            }
            part(WardLine; "Ward Subform")
            {
                SubPageLink = "Document No." = field("Ward No."), "Patient No." = field("Patient No."), "Diagnosis No." = field(Code);
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
                    Rec.Status := Rec.Status::Open;
                    PatientRec.Get(Rec."Patient No.");
                    PatientRec.CalcFields("Balance (LCY)");
                    if Confirm('Do you want to close this diagnosis', false) then begin

                        if PatientRec."Balance (LCY)" = 0 then begin
                            Rec.Status := Rec.Status::Closed;
                            Rec.Modify();
                            DiagnosisDescriptionDocument.SetRecord(Rec);
                            CurrPage.Close();
                            DiagnosisDescriptionDocument.Editable := false;
                            DiagnosisDescriptionDocument.Run();
                        end
                        else
                            Message('Document cannot be closed because Patient %1 is yet to complete payment', Rec."Patient No.");
                    end;
                end;
            }
            action("Reopen Diagnosis")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Closed then
                        if Confirm('Do you want to reopen this diagnosis', false) then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                            DiagnosisDescriptionDocument.SetRecord(Rec);
                            DiagnosisDescriptionDocument.Editable := true;
                            DiagnosisDescriptionDocument.Run();
                        end;
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

                    WardLineRec.SetRange("Diagnosis No.", Rec.Code);
                    WardLineRec.SetRange("Patient No.", Rec."Patient No.");
                    WardLineRec.SetRange("Document No.", Rec."Ward No.");
                    if WardLineRec.FindSet() then begin
                        WardLineRec.Validate("End Date", Today);
                        WardLineRec.Validate(Status, WardLineRec.Status::Closed);
                        WardLineRec.Validate("Total Bed Charge", WardLineRec."Unit Charge" * WardLineRec."No. of Days");
                        // a logic was added to the end date field that would update the number of days. 
                        //No.of days =  start date - end date + 1
                        WardLineRec.Modify();
                    end;
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
                            if DiagnosisDescriptionLineRec.Type = DiagnosisDescriptionLineRec.Type::Test then
                                SalesLineRec.Validate(Type, SalesLineRec.Type::"G/L Account"); // Adjust the type based on your need
                            if DiagnosisDescriptionLineRec.Type = DiagnosisDescriptionLineRec.Type::Treatment then
                                SalesLineRec.Validate(Type, SalesLineRec.Type::"G/L Account");
                            if DiagnosisDescriptionLineRec.Type = DiagnosisDescriptionLineRec.Type::Drug then
                                SalesLineRec.Validate(Type, SalesLineRec.Type::Item); // adjust the type based on your need
                            SalesLineRec.Validate("No.", DiagnosisDescriptionLineRec."Account No.");
                            SalesLineRec.Validate(Description, DiagnosisDescriptionLineRec.Description);
                            SalesLineRec.Validate(Quantity, 1); // Set the quantity based on your need
                            SalesLineRec.Validate("Unit Price", DiagnosisDescriptionLineRec.Charge);
                            SalesLineRec.Validate("Line No.", LineNo);
                            SalesLineRec.Insert(true);
                        until DiagnosisDescriptionLineRec.Next() = 0;
                    //insert Ward Line details if available
                    begin
                        LineNo += 10000;
                        SalesLineRec.Init();
                        SalesLineRec.Validate("Document Type", SalesHeaderRec."Document Type");
                        SalesLineRec.Validate("Document No.", SalesHeaderRec."No.");
                        SalesLineRec.Validate(Type, SalesLineRec.Type::"G/L Account");
                        SalesLineRec.Validate("No.", SalesAndReceivableSetupRec."Service Account");
                        SalesLineRec.Validate(Description, WardLineRec.Description);
                        SalesLineRec.Validate(Quantity, WardLineRec."No. of Days");
                        SalesLineRec.Validate("Unit Price", WardLineRec."Unit Charge");
                        SalesLineRec.Validate("Line No.", LineNo);
                        SalesLineRec.Insert(true);
                    end;
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
        PatientRec: Record Patient;
        WardHeaderRec: Record "Ward Header";
        WardLineRec: Record "Ward Line";

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Closed then
            CurrPage.Editable := false;
    end;
}
